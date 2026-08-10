return {
	Play910201001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 910201001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play910201002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST02"

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
				local var_4_5 = arg_1_1.bgs_.ST02

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
					if iter_4_0 ~= "ST02" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 0
			local var_4_23 = 0.6

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "stop"
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

			local var_4_28 = 1.5
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

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

			local var_4_34 = 0
			local var_4_35 = 1

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				local var_4_36 = "play"
				local var_4_37 = "effect"

				arg_1_1:AudioAction(var_4_36, var_4_37, "se_story_birthday", "se_story_birthday_shaokaodian", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 2
			local var_4_39 = 0.5

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_40 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_40:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_42 = arg_1_1:GetWordFromCfg(910201001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 20
				local var_4_45 = utf8.len(var_4_43)
				local var_4_46 = var_4_44 <= 0 and var_4_39 or var_4_39 * (var_4_45 / var_4_44)

				if var_4_46 > 0 and var_4_39 < var_4_46 then
					arg_1_1.talkMaxDuration = var_4_46
					var_4_38 = var_4_38 + 0.3

					if var_4_46 + var_4_38 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_46 + var_4_38
					end
				end

				arg_1_1.text_.text = var_4_43
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_47 = var_4_38 + 0.3
			local var_4_48 = math.max(var_4_39, arg_1_1.talkMaxDuration)

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
	Play910201002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 910201002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play910201003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.175

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[7].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:GetWordFromCfg(910201002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 7
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_8 and arg_9_1.time_ < var_12_0 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play910201003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 910201003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play910201004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.75

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(910201003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 30
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play910201004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 910201004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play910201005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1084ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_17_1.stage_.transform)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentInChildren(typeof(CharacterEffect))

					var_20_3.enabled = true

					local var_20_4 = GameObjectTools.GetOrAddComponent(var_20_2, typeof(DynamicBoneHelper))

					if var_20_4 then
						var_20_4:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_3.transform, false)

					arg_17_1.var_[var_20_0 .. "Animator"] = var_20_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_0 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_0 .. "LipSync"] = var_20_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_5 = arg_17_1.actors_["1084ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos1084ui_story = var_20_5.localPosition

				local var_20_7 = "1084ui_story"

				arg_17_1:ShowWeapon(arg_17_1.var_[var_20_7 .. "Animator"].transform, false)
			end

			local var_20_8 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_8 then
				local var_20_9 = (arg_17_1.time_ - var_20_6) / var_20_8
				local var_20_10 = Vector3.New(0, -0.97, -6)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1084ui_story, var_20_10, var_20_9)

				local var_20_11 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_11.x, var_20_11.y, var_20_11.z)

				local var_20_12 = var_20_5.localEulerAngles

				var_20_12.z = 0
				var_20_12.x = 0
				var_20_5.localEulerAngles = var_20_12
			end

			if arg_17_1.time_ >= var_20_6 + var_20_8 and arg_17_1.time_ < var_20_6 + var_20_8 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_20_13 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_13.x, var_20_13.y, var_20_13.z)

				local var_20_14 = var_20_5.localEulerAngles

				var_20_14.z = 0
				var_20_14.x = 0
				var_20_5.localEulerAngles = var_20_14
			end

			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_20_17 = arg_17_1.actors_["1084ui_story"]
			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 and not isNil(var_20_17) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = var_20_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_19 = 0.2

			if var_20_18 <= arg_17_1.time_ and arg_17_1.time_ < var_20_18 + var_20_19 and not isNil(var_20_17) then
				local var_20_20 = (arg_17_1.time_ - var_20_18) / var_20_19

				if arg_17_1.var_.characterEffect1084ui_story and not isNil(var_20_17) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_18 + var_20_19 and arg_17_1.time_ < var_20_18 + var_20_19 + arg_20_0 and not isNil(var_20_17) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_20_21 = 0
			local var_20_22 = 0.3

			if var_20_21 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_23 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_24 = arg_17_1:GetWordFromCfg(910201004)
				local var_20_25 = arg_17_1:FormatText(var_20_24.content)

				arg_17_1.text_.text = var_20_25

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_26 = 12
				local var_20_27 = utf8.len(var_20_25)
				local var_20_28 = var_20_26 <= 0 and var_20_22 or var_20_22 * (var_20_27 / var_20_26)

				if var_20_28 > 0 and var_20_22 < var_20_28 then
					arg_17_1.talkMaxDuration = var_20_28

					if var_20_28 + var_20_21 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_21
					end
				end

				arg_17_1.text_.text = var_20_25
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_29 = math.max(var_20_22, arg_17_1.talkMaxDuration)

			if var_20_21 <= arg_17_1.time_ and arg_17_1.time_ < var_20_21 + var_20_29 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_21) / var_20_29

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_21 + var_20_29 and arg_17_1.time_ < var_20_21 + var_20_29 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play910201005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 910201005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play910201006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action432")
			end

			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_24_2 = 0
			local var_24_3 = 0.525

			if var_24_2 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_4 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:GetWordFromCfg(910201005)
				local var_24_6 = arg_21_1:FormatText(var_24_5.content)

				arg_21_1.text_.text = var_24_6

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 21
				local var_24_8 = utf8.len(var_24_6)
				local var_24_9 = var_24_7 <= 0 and var_24_3 or var_24_3 * (var_24_8 / var_24_7)

				if var_24_9 > 0 and var_24_3 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_6
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play910201006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 910201006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play910201007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1084ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1084ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1084ui_story.fillRatio = var_28_5
			end

			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_2")
			end

			local var_28_7 = 0
			local var_28_8 = 0.55

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_9 = arg_25_1:FormatText(StoryNameCfg[331].name)

				arg_25_1.leftNameTxt_.text = var_28_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_10 = arg_25_1:GetWordFromCfg(910201006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 22
				local var_28_13 = utf8.len(var_28_11)
				local var_28_14 = var_28_12 <= 0 and var_28_8 or var_28_8 * (var_28_13 / var_28_12)

				if var_28_14 > 0 and var_28_8 < var_28_14 then
					arg_25_1.talkMaxDuration = var_28_14

					if var_28_14 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_15 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_15 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_15

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_15 and arg_25_1.time_ < var_28_7 + var_28_15 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play910201007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 910201007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play910201008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.2

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[7].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(910201007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 8
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_8 and arg_29_1.time_ < var_32_0 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play910201008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 910201008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play910201009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.625

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(910201008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 25
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_8 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_8 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_8

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_8 and arg_33_1.time_ < var_36_0 + var_36_8 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play910201009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 910201009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play910201010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1084ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1084ui_story == nil then
				arg_37_1.var_.characterEffect1084ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1084ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1084ui_story then
				arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_40_6 = 0
			local var_40_7 = 0.625

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[6].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_9 = arg_37_1:GetWordFromCfg(910201009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 25
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_7 or var_40_7 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_7 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play910201010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 910201010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play910201011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action486")
			end

			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_44_2 = 0
			local var_44_3 = 0.325

			if var_44_2 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_4 = arg_41_1:FormatText(StoryNameCfg[6].name)

				arg_41_1.leftNameTxt_.text = var_44_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_5 = arg_41_1:GetWordFromCfg(910201010)
				local var_44_6 = arg_41_1:FormatText(var_44_5.content)

				arg_41_1.text_.text = var_44_6

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 13
				local var_44_8 = utf8.len(var_44_6)
				local var_44_9 = var_44_7 <= 0 and var_44_3 or var_44_3 * (var_44_8 / var_44_7)

				if var_44_9 > 0 and var_44_3 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_6
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play910201011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 910201011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play910201012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1084ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1084ui_story == nil then
				arg_45_1.var_.characterEffect1084ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.2

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1084ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1084ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1084ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1084ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.9

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(910201011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 36
				local var_48_11 = utf8.len(var_48_9)
				local var_48_12 = var_48_10 <= 0 and var_48_7 or var_48_7 * (var_48_11 / var_48_10)

				if var_48_12 > 0 and var_48_7 < var_48_12 then
					arg_45_1.talkMaxDuration = var_48_12

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_13 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_13 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_13

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_13 and arg_45_1.time_ < var_48_6 + var_48_13 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play910201012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 910201012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play910201013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.35

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[331].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:GetWordFromCfg(910201012)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 14
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_8 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_8 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_8

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_8 and arg_49_1.time_ < var_52_0 + var_52_8 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play910201013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 910201013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play910201014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.65

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(910201013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 26
				local var_56_5 = utf8.len(var_56_3)
				local var_56_6 = var_56_4 <= 0 and var_56_1 or var_56_1 * (var_56_5 / var_56_4)

				if var_56_6 > 0 and var_56_1 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_7 and arg_53_1.time_ < var_56_0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play910201014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 910201014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play910201015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.9

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(910201014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 36
				local var_60_5 = utf8.len(var_60_3)
				local var_60_6 = var_60_4 <= 0 and var_60_1 or var_60_1 * (var_60_5 / var_60_4)

				if var_60_6 > 0 and var_60_1 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_7 and arg_57_1.time_ < var_60_0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play910201015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 910201015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play910201016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.225

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[36].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(910201015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 18
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_8 and arg_61_1.time_ < var_64_0 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play910201016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 910201016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play910201017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0
			local var_68_1 = 0.25

			if var_68_0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_2 = arg_65_1:FormatText(StoryNameCfg[36].name)

				arg_65_1.leftNameTxt_.text = var_68_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:GetWordFromCfg(910201016)
				local var_68_4 = arg_65_1:FormatText(var_68_3.content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 10
				local var_68_6 = utf8.len(var_68_4)
				local var_68_7 = var_68_5 <= 0 and var_68_1 or var_68_1 * (var_68_6 / var_68_5)

				if var_68_7 > 0 and var_68_1 < var_68_7 then
					arg_65_1.talkMaxDuration = var_68_7

					if var_68_7 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_7 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play910201017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 910201017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play910201018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1084ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1084ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1084ui_story then
				arg_69_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_72_4 = 0

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action463")
			end

			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_72_6 = 0
			local var_72_7 = 0.35

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[6].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_9 = arg_69_1:GetWordFromCfg(910201017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 14
				local var_72_12 = utf8.len(var_72_10)
				local var_72_13 = var_72_11 <= 0 and var_72_7 or var_72_7 * (var_72_12 / var_72_11)

				if var_72_13 > 0 and var_72_7 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_14 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_14 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_14

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_14 and arg_69_1.time_ < var_72_6 + var_72_14 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play910201018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 910201018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play910201019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1084ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1084ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1084ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1084ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1084ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.225

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[7].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(910201018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 9
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_7 or var_76_7 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_7 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_14 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_14 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_14

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_14 and arg_73_1.time_ < var_76_6 + var_76_14 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play910201019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 910201019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play910201020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.325

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[7].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(910201019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 14
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_8 and arg_77_1.time_ < var_80_0 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play910201020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 910201020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play910201021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1084ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1084ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1084ui_story then
				arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_84_4 = 0

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action436")
			end

			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_84_6 = 0
			local var_84_7 = 0.6

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[6].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_9 = arg_81_1:GetWordFromCfg(910201020)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 24
				local var_84_12 = utf8.len(var_84_10)
				local var_84_13 = var_84_11 <= 0 and var_84_7 or var_84_7 * (var_84_12 / var_84_11)

				if var_84_13 > 0 and var_84_7 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play910201021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 910201021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play910201022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action468")
			end

			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_88_2 = 0
			local var_88_3 = 0.625

			if var_88_2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_4 = arg_85_1:FormatText(StoryNameCfg[6].name)

				arg_85_1.leftNameTxt_.text = var_88_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_5 = arg_85_1:GetWordFromCfg(910201021)
				local var_88_6 = arg_85_1:FormatText(var_88_5.content)

				arg_85_1.text_.text = var_88_6

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 25
				local var_88_8 = utf8.len(var_88_6)
				local var_88_9 = var_88_7 <= 0 and var_88_3 or var_88_3 * (var_88_8 / var_88_7)

				if var_88_9 > 0 and var_88_3 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_2 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_2
					end
				end

				arg_85_1.text_.text = var_88_6
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_3, arg_85_1.talkMaxDuration)

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_2) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_2 + var_88_10 and arg_85_1.time_ < var_88_2 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play910201022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 910201022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play910201023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1084ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1084ui_story == nil then
				arg_89_1.var_.characterEffect1084ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1084ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1084ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1084ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1084ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 0.1

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_8 = arg_89_1:FormatText(StoryNameCfg[7].name)

				arg_89_1.leftNameTxt_.text = var_92_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_9 = arg_89_1:GetWordFromCfg(910201022)
				local var_92_10 = arg_89_1:FormatText(var_92_9.content)

				arg_89_1.text_.text = var_92_10

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 4
				local var_92_12 = utf8.len(var_92_10)
				local var_92_13 = var_92_11 <= 0 and var_92_7 or var_92_7 * (var_92_12 / var_92_11)

				if var_92_13 > 0 and var_92_7 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_10
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play910201023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 910201023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play910201024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1084ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1084ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1084ui_story then
				arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_96_4 = 0

			if var_96_4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action483")
			end

			local var_96_5 = 0

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_96_6 = 0
			local var_96_7 = 0.925

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_8 = arg_93_1:FormatText(StoryNameCfg[6].name)

				arg_93_1.leftNameTxt_.text = var_96_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_9 = arg_93_1:GetWordFromCfg(910201023)
				local var_96_10 = arg_93_1:FormatText(var_96_9.content)

				arg_93_1.text_.text = var_96_10

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_11 = 37
				local var_96_12 = utf8.len(var_96_10)
				local var_96_13 = var_96_11 <= 0 and var_96_7 or var_96_7 * (var_96_12 / var_96_11)

				if var_96_13 > 0 and var_96_7 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_6 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_6
					end
				end

				arg_93_1.text_.text = var_96_10
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_14 = math.max(var_96_7, arg_93_1.talkMaxDuration)

			if var_96_6 <= arg_93_1.time_ and arg_93_1.time_ < var_96_6 + var_96_14 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_6) / var_96_14

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_6 + var_96_14 and arg_93_1.time_ < var_96_6 + var_96_14 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play910201024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 910201024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play910201025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.525

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(910201024)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 21
				local var_100_5 = utf8.len(var_100_3)
				local var_100_6 = var_100_4 <= 0 and var_100_1 or var_100_1 * (var_100_5 / var_100_4)

				if var_100_6 > 0 and var_100_1 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_7 and arg_97_1.time_ < var_100_0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play910201025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 910201025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play910201026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1084ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1084ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_5
			end

			local var_104_6 = 0

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_104_7 = 0
			local var_104_8 = 0.925

			if var_104_7 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_9 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_10 = arg_101_1:GetWordFromCfg(910201025)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_12 = 37
				local var_104_13 = utf8.len(var_104_11)
				local var_104_14 = var_104_12 <= 0 and var_104_8 or var_104_8 * (var_104_13 / var_104_12)

				if var_104_14 > 0 and var_104_8 < var_104_14 then
					arg_101_1.talkMaxDuration = var_104_14

					if var_104_14 + var_104_7 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_7
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_15 = math.max(var_104_8, arg_101_1.talkMaxDuration)

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_15 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_7) / var_104_15

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_7 + var_104_15 and arg_101_1.time_ < var_104_7 + var_104_15 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play910201026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 910201026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play910201027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1084ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1084ui_story == nil then
				arg_105_1.var_.characterEffect1084ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1084ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1084ui_story then
				arg_105_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_108_4 = 0

			if var_108_4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_108_5 = 0

			if var_108_5 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_108_6 = 0
			local var_108_7 = 0.75

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[6].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_9 = arg_105_1:GetWordFromCfg(910201026)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 30
				local var_108_12 = utf8.len(var_108_10)
				local var_108_13 = var_108_11 <= 0 and var_108_7 or var_108_7 * (var_108_12 / var_108_11)

				if var_108_13 > 0 and var_108_7 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play910201027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 910201027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play910201028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_112_2 = 0
			local var_112_3 = 0.675

			if var_112_2 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_4 = arg_109_1:FormatText(StoryNameCfg[6].name)

				arg_109_1.leftNameTxt_.text = var_112_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:GetWordFromCfg(910201027)
				local var_112_6 = arg_109_1:FormatText(var_112_5.content)

				arg_109_1.text_.text = var_112_6

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 27
				local var_112_8 = utf8.len(var_112_6)
				local var_112_9 = var_112_7 <= 0 and var_112_3 or var_112_3 * (var_112_8 / var_112_7)

				if var_112_9 > 0 and var_112_3 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_6
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_10 and arg_109_1.time_ < var_112_2 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play910201028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 910201028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play910201029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_116_1 = 0
			local var_116_2 = 0.775

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_3 = arg_113_1:FormatText(StoryNameCfg[6].name)

				arg_113_1.leftNameTxt_.text = var_116_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_4 = arg_113_1:GetWordFromCfg(910201028)
				local var_116_5 = arg_113_1:FormatText(var_116_4.content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 31
				local var_116_7 = utf8.len(var_116_5)
				local var_116_8 = var_116_6 <= 0 and var_116_2 or var_116_2 * (var_116_7 / var_116_6)

				if var_116_8 > 0 and var_116_2 < var_116_8 then
					arg_113_1.talkMaxDuration = var_116_8

					if var_116_8 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_9 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_9 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_9

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_9 and arg_113_1.time_ < var_116_1 + var_116_9 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play910201029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 910201029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play910201030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action483")
			end

			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_120_2 = 0
			local var_120_3 = 0.725

			if var_120_2 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_4 = arg_117_1:FormatText(StoryNameCfg[6].name)

				arg_117_1.leftNameTxt_.text = var_120_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_5 = arg_117_1:GetWordFromCfg(910201029)
				local var_120_6 = arg_117_1:FormatText(var_120_5.content)

				arg_117_1.text_.text = var_120_6

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 29
				local var_120_8 = utf8.len(var_120_6)
				local var_120_9 = var_120_7 <= 0 and var_120_3 or var_120_3 * (var_120_8 / var_120_7)

				if var_120_9 > 0 and var_120_3 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9

					if var_120_9 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_6
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play910201030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 910201030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play910201031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_124_2 = 0
			local var_124_3 = 0.575

			if var_124_2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_4 = arg_121_1:FormatText(StoryNameCfg[6].name)

				arg_121_1.leftNameTxt_.text = var_124_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_5 = arg_121_1:GetWordFromCfg(910201030)
				local var_124_6 = arg_121_1:FormatText(var_124_5.content)

				arg_121_1.text_.text = var_124_6

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 23
				local var_124_8 = utf8.len(var_124_6)
				local var_124_9 = var_124_7 <= 0 and var_124_3 or var_124_3 * (var_124_8 / var_124_7)

				if var_124_9 > 0 and var_124_3 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_6
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_2) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_2 + var_124_10 and arg_121_1.time_ < var_124_2 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play910201031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 910201031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play910201032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1084ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1084ui_story == nil then
				arg_125_1.var_.characterEffect1084ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1084ui_story and not isNil(var_128_0) then
					local var_128_4 = Mathf.Lerp(0, 0.5, var_128_3)

					arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1084ui_story.fillRatio = var_128_4
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1084ui_story then
				local var_128_5 = 0.5

				arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1084ui_story.fillRatio = var_128_5
			end

			local var_128_6 = 0
			local var_128_7 = 0.575

			if var_128_6 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_8 = arg_125_1:FormatText(StoryNameCfg[7].name)

				arg_125_1.leftNameTxt_.text = var_128_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_9 = arg_125_1:GetWordFromCfg(910201031)
				local var_128_10 = arg_125_1:FormatText(var_128_9.content)

				arg_125_1.text_.text = var_128_10

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 23
				local var_128_12 = utf8.len(var_128_10)
				local var_128_13 = var_128_11 <= 0 and var_128_7 or var_128_7 * (var_128_12 / var_128_11)

				if var_128_13 > 0 and var_128_7 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_10
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_14 and arg_125_1.time_ < var_128_6 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play910201032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 910201032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play910201033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.825

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(910201032)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 33
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play910201033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 910201033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play910201034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1084ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1084ui_story == nil then
				arg_133_1.var_.characterEffect1084ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1084ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1084ui_story then
				arg_133_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_136_4 = 0

			if var_136_4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_136_6 = 0
			local var_136_7 = 0.15

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_8 = arg_133_1:FormatText(StoryNameCfg[6].name)

				arg_133_1.leftNameTxt_.text = var_136_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_9 = arg_133_1:GetWordFromCfg(910201033)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 6
				local var_136_12 = utf8.len(var_136_10)
				local var_136_13 = var_136_11 <= 0 and var_136_7 or var_136_7 * (var_136_12 / var_136_11)

				if var_136_13 > 0 and var_136_7 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_14 and arg_133_1.time_ < var_136_6 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play910201034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 910201034
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play910201035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1084ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1084ui_story == nil then
				arg_137_1.var_.characterEffect1084ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1084ui_story and not isNil(var_140_0) then
					local var_140_4 = Mathf.Lerp(0, 0.5, var_140_3)

					arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1084ui_story.fillRatio = var_140_4
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1084ui_story then
				local var_140_5 = 0.5

				arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1084ui_story.fillRatio = var_140_5
			end

			local var_140_6 = 0
			local var_140_7 = 1.025

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[7].name)

				arg_137_1.leftNameTxt_.text = var_140_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, true)
				arg_137_1.iconController_:SetSelectedState("hero")

				arg_137_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_137_1.callingController_:SetSelectedState("normal")

				arg_137_1.keyicon_.color = Color.New(1, 1, 1)
				arg_137_1.icon_.color = Color.New(1, 1, 1)

				local var_140_9 = arg_137_1:GetWordFromCfg(910201034)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 41
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_7 or var_140_7 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_7 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play910201035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 910201035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play910201036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1084ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1084ui_story == nil then
				arg_141_1.var_.characterEffect1084ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect1084ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1084ui_story then
				arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_144_4 = 0

			if var_144_4 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action435")
			end

			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_144_6 = 0
			local var_144_7 = 0.45

			if var_144_6 < arg_141_1.time_ and arg_141_1.time_ <= var_144_6 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_8 = arg_141_1:FormatText(StoryNameCfg[6].name)

				arg_141_1.leftNameTxt_.text = var_144_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_9 = arg_141_1:GetWordFromCfg(910201035)
				local var_144_10 = arg_141_1:FormatText(var_144_9.content)

				arg_141_1.text_.text = var_144_10

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_11 = 18
				local var_144_12 = utf8.len(var_144_10)
				local var_144_13 = var_144_11 <= 0 and var_144_7 or var_144_7 * (var_144_12 / var_144_11)

				if var_144_13 > 0 and var_144_7 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_6 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_6
					end
				end

				arg_141_1.text_.text = var_144_10
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_14 = math.max(var_144_7, arg_141_1.talkMaxDuration)

			if var_144_6 <= arg_141_1.time_ and arg_141_1.time_ < var_144_6 + var_144_14 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_6) / var_144_14

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_6 + var_144_14 and arg_141_1.time_ < var_144_6 + var_144_14 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play910201036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 910201036
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play910201037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1084ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1084ui_story == nil then
				arg_145_1.var_.characterEffect1084ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.2

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect1084ui_story and not isNil(var_148_0) then
					local var_148_4 = Mathf.Lerp(0, 0.5, var_148_3)

					arg_145_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1084ui_story.fillRatio = var_148_4
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1084ui_story then
				local var_148_5 = 0.5

				arg_145_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1084ui_story.fillRatio = var_148_5
			end

			local var_148_6 = 0
			local var_148_7 = 0.225

			if var_148_6 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_8 = arg_145_1:FormatText(StoryNameCfg[7].name)

				arg_145_1.leftNameTxt_.text = var_148_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_9 = arg_145_1:GetWordFromCfg(910201036)
				local var_148_10 = arg_145_1:FormatText(var_148_9.content)

				arg_145_1.text_.text = var_148_10

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_11 = 9
				local var_148_12 = utf8.len(var_148_10)
				local var_148_13 = var_148_11 <= 0 and var_148_7 or var_148_7 * (var_148_12 / var_148_11)

				if var_148_13 > 0 and var_148_7 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_10
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_14 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_14 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_14

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_14 and arg_145_1.time_ < var_148_6 + var_148_14 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play910201037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 910201037
		arg_149_1.duration_ = 9

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play910201038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = "STblack"

			if arg_149_1.bgs_[var_152_0] == nil then
				local var_152_1 = Object.Instantiate(arg_149_1.paintGo_)

				var_152_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_152_0)
				var_152_1.name = var_152_0
				var_152_1.transform.parent = arg_149_1.stage_.transform
				var_152_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.bgs_[var_152_0] = var_152_1
			end

			local var_152_2 = 2

			if var_152_2 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				local var_152_3 = manager.ui.mainCamera.transform.localPosition
				local var_152_4 = Vector3.New(0, 0, 10) + Vector3.New(var_152_3.x, var_152_3.y, 0)
				local var_152_5 = arg_149_1.bgs_.STblack

				var_152_5.transform.localPosition = var_152_4
				var_152_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_6 = var_152_5:GetComponent("SpriteRenderer")

				if var_152_6 and var_152_6.sprite then
					local var_152_7 = (var_152_5.transform.localPosition - var_152_3).z
					local var_152_8 = manager.ui.mainCameraCom_
					local var_152_9 = 2 * var_152_7 * Mathf.Tan(var_152_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_152_10 = var_152_9 * var_152_8.aspect
					local var_152_11 = var_152_6.sprite.bounds.size.x
					local var_152_12 = var_152_6.sprite.bounds.size.y
					local var_152_13 = var_152_10 / var_152_11
					local var_152_14 = var_152_9 / var_152_12
					local var_152_15 = var_152_14 < var_152_13 and var_152_13 or var_152_14

					var_152_5.transform.localScale = Vector3.New(var_152_15, var_152_15, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "STblack" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_17 = 2

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_17 then
				local var_152_18 = (arg_149_1.time_ - var_152_16) / var_152_17
				local var_152_19 = Color.New(0, 0, 0)

				var_152_19.a = Mathf.Lerp(0, 1, var_152_18)
				arg_149_1.mask_.color = var_152_19
			end

			if arg_149_1.time_ >= var_152_16 + var_152_17 and arg_149_1.time_ < var_152_16 + var_152_17 + arg_152_0 then
				local var_152_20 = Color.New(0, 0, 0)

				var_152_20.a = 1
				arg_149_1.mask_.color = var_152_20
			end

			local var_152_21 = 2

			if var_152_21 < arg_149_1.time_ and arg_149_1.time_ <= var_152_21 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_22 = 2

			if var_152_21 <= arg_149_1.time_ and arg_149_1.time_ < var_152_21 + var_152_22 then
				local var_152_23 = (arg_149_1.time_ - var_152_21) / var_152_22
				local var_152_24 = Color.New(0, 0, 0)

				var_152_24.a = Mathf.Lerp(1, 0, var_152_23)
				arg_149_1.mask_.color = var_152_24
			end

			if arg_149_1.time_ >= var_152_21 + var_152_22 and arg_149_1.time_ < var_152_21 + var_152_22 + arg_152_0 then
				local var_152_25 = Color.New(0, 0, 0)
				local var_152_26 = 0

				arg_149_1.mask_.enabled = false
				var_152_25.a = var_152_26
				arg_149_1.mask_.color = var_152_25
			end

			local var_152_27 = 0
			local var_152_28 = 1

			if var_152_27 < arg_149_1.time_ and arg_149_1.time_ <= var_152_27 + arg_152_0 then
				local var_152_29 = "stop"
				local var_152_30 = "effect"

				arg_149_1:AudioAction(var_152_29, var_152_30, "se_story_birthday", "se_story_birthday_shaokaodian", "")
			end

			local var_152_31 = arg_149_1.actors_["1084ui_story"].transform
			local var_152_32 = 1.966

			if var_152_32 < arg_149_1.time_ and arg_149_1.time_ <= var_152_32 + arg_152_0 then
				arg_149_1.var_.moveOldPos1084ui_story = var_152_31.localPosition
			end

			local var_152_33 = 0.001

			if var_152_32 <= arg_149_1.time_ and arg_149_1.time_ < var_152_32 + var_152_33 then
				local var_152_34 = (arg_149_1.time_ - var_152_32) / var_152_33
				local var_152_35 = Vector3.New(0, 100, 0)

				var_152_31.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1084ui_story, var_152_35, var_152_34)

				local var_152_36 = manager.ui.mainCamera.transform.position - var_152_31.position

				var_152_31.forward = Vector3.New(var_152_36.x, var_152_36.y, var_152_36.z)

				local var_152_37 = var_152_31.localEulerAngles

				var_152_37.z = 0
				var_152_37.x = 0
				var_152_31.localEulerAngles = var_152_37
			end

			if arg_149_1.time_ >= var_152_32 + var_152_33 and arg_149_1.time_ < var_152_32 + var_152_33 + arg_152_0 then
				var_152_31.localPosition = Vector3.New(0, 100, 0)

				local var_152_38 = manager.ui.mainCamera.transform.position - var_152_31.position

				var_152_31.forward = Vector3.New(var_152_38.x, var_152_38.y, var_152_38.z)

				local var_152_39 = var_152_31.localEulerAngles

				var_152_39.z = 0
				var_152_39.x = 0
				var_152_31.localEulerAngles = var_152_39
			end

			if arg_149_1.frameCnt_ <= 1 then
				arg_149_1.dialog_:SetActive(false)
			end

			local var_152_40 = 4
			local var_152_41 = 0.55

			if var_152_40 < arg_149_1.time_ and arg_149_1.time_ <= var_152_40 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				arg_149_1.dialog_:SetActive(true)

				arg_149_1.dialogCg_.alpha = 0

				local var_152_42 = LeanTween.value(arg_149_1.dialog_, 0, 1, 0.3)

				var_152_42:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_149_1.dialogCg_.alpha = arg_153_0
				end))
				var_152_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_149_1.dialog_)
					var_152_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_149_1.duration_ = arg_149_1.duration_ + 0.3

				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_43 = arg_149_1:FormatText(StoryNameCfg[36].name)

				arg_149_1.leftNameTxt_.text = var_152_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_44 = arg_149_1:GetWordFromCfg(910201037)
				local var_152_45 = arg_149_1:FormatText(var_152_44.content)

				arg_149_1.text_.text = var_152_45

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_46 = 22
				local var_152_47 = utf8.len(var_152_45)
				local var_152_48 = var_152_46 <= 0 and var_152_41 or var_152_41 * (var_152_47 / var_152_46)

				if var_152_48 > 0 and var_152_41 < var_152_48 then
					arg_149_1.talkMaxDuration = var_152_48
					var_152_40 = var_152_40 + 0.3

					if var_152_48 + var_152_40 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_48 + var_152_40
					end
				end

				arg_149_1.text_.text = var_152_45
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_49 = var_152_40 + 0.3
			local var_152_50 = math.max(var_152_41, arg_149_1.talkMaxDuration)

			if var_152_49 <= arg_149_1.time_ and arg_149_1.time_ < var_152_49 + var_152_50 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_49) / var_152_50

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_49 + var_152_50 and arg_149_1.time_ < var_152_49 + var_152_50 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play910201038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 910201038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play910201039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.475

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[36].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_3 = arg_155_1:GetWordFromCfg(910201038)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 19
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_8 and arg_155_1.time_ < var_158_0 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play910201039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 910201039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play910201040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.15

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[36].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(910201039)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 6
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_8 and arg_159_1.time_ < var_162_0 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play910201040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 910201040
		arg_163_1.duration_ = 9

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play910201041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = "A00"

			if arg_163_1.bgs_[var_166_0] == nil then
				local var_166_1 = Object.Instantiate(arg_163_1.paintGo_)

				var_166_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_166_0)
				var_166_1.name = var_166_0
				var_166_1.transform.parent = arg_163_1.stage_.transform
				var_166_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.bgs_[var_166_0] = var_166_1
			end

			local var_166_2 = 2

			if var_166_2 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				local var_166_3 = manager.ui.mainCamera.transform.localPosition
				local var_166_4 = Vector3.New(0, 0, 10) + Vector3.New(var_166_3.x, var_166_3.y, 0)
				local var_166_5 = arg_163_1.bgs_.A00

				var_166_5.transform.localPosition = var_166_4
				var_166_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_166_6 = var_166_5:GetComponent("SpriteRenderer")

				if var_166_6 and var_166_6.sprite then
					local var_166_7 = (var_166_5.transform.localPosition - var_166_3).z
					local var_166_8 = manager.ui.mainCameraCom_
					local var_166_9 = 2 * var_166_7 * Mathf.Tan(var_166_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_166_10 = var_166_9 * var_166_8.aspect
					local var_166_11 = var_166_6.sprite.bounds.size.x
					local var_166_12 = var_166_6.sprite.bounds.size.y
					local var_166_13 = var_166_10 / var_166_11
					local var_166_14 = var_166_9 / var_166_12
					local var_166_15 = var_166_14 < var_166_13 and var_166_13 or var_166_14

					var_166_5.transform.localScale = Vector3.New(var_166_15, var_166_15, 0)
				end

				for iter_166_0, iter_166_1 in pairs(arg_163_1.bgs_) do
					if iter_166_0 ~= "A00" then
						iter_166_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_17 = 2

			if var_166_16 <= arg_163_1.time_ and arg_163_1.time_ < var_166_16 + var_166_17 then
				local var_166_18 = (arg_163_1.time_ - var_166_16) / var_166_17
				local var_166_19 = Color.New(0, 0, 0)

				var_166_19.a = Mathf.Lerp(0, 1, var_166_18)
				arg_163_1.mask_.color = var_166_19
			end

			if arg_163_1.time_ >= var_166_16 + var_166_17 and arg_163_1.time_ < var_166_16 + var_166_17 + arg_166_0 then
				local var_166_20 = Color.New(0, 0, 0)

				var_166_20.a = 1
				arg_163_1.mask_.color = var_166_20
			end

			local var_166_21 = 2

			if var_166_21 < arg_163_1.time_ and arg_163_1.time_ <= var_166_21 + arg_166_0 then
				arg_163_1.mask_.enabled = true
				arg_163_1.mask_.raycastTarget = true

				arg_163_1:SetGaussion(false)
			end

			local var_166_22 = 2

			if var_166_21 <= arg_163_1.time_ and arg_163_1.time_ < var_166_21 + var_166_22 then
				local var_166_23 = (arg_163_1.time_ - var_166_21) / var_166_22
				local var_166_24 = Color.New(0, 0, 0)

				var_166_24.a = Mathf.Lerp(1, 0, var_166_23)
				arg_163_1.mask_.color = var_166_24
			end

			if arg_163_1.time_ >= var_166_21 + var_166_22 and arg_163_1.time_ < var_166_21 + var_166_22 + arg_166_0 then
				local var_166_25 = Color.New(0, 0, 0)
				local var_166_26 = 0

				arg_163_1.mask_.enabled = false
				var_166_25.a = var_166_26
				arg_163_1.mask_.color = var_166_25
			end

			local var_166_27 = "1019ui_story"

			if arg_163_1.actors_[var_166_27] == nil then
				local var_166_28 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_166_28) then
					local var_166_29 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_163_1.stage_.transform)

					var_166_29.name = var_166_27
					var_166_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_163_1.actors_[var_166_27] = var_166_29

					local var_166_30 = var_166_29:GetComponentInChildren(typeof(CharacterEffect))

					var_166_30.enabled = true

					local var_166_31 = GameObjectTools.GetOrAddComponent(var_166_29, typeof(DynamicBoneHelper))

					if var_166_31 then
						var_166_31:EnableDynamicBone(false)
					end

					arg_163_1:ShowWeapon(var_166_30.transform, false)

					arg_163_1.var_[var_166_27 .. "Animator"] = var_166_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_163_1.var_[var_166_27 .. "Animator"].applyRootMotion = true
					arg_163_1.var_[var_166_27 .. "LipSync"] = var_166_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_166_32 = arg_163_1.actors_["1019ui_story"].transform
			local var_166_33 = 3.8

			if var_166_33 < arg_163_1.time_ and arg_163_1.time_ <= var_166_33 + arg_166_0 then
				arg_163_1.var_.moveOldPos1019ui_story = var_166_32.localPosition
			end

			local var_166_34 = 0.001

			if var_166_33 <= arg_163_1.time_ and arg_163_1.time_ < var_166_33 + var_166_34 then
				local var_166_35 = (arg_163_1.time_ - var_166_33) / var_166_34
				local var_166_36 = Vector3.New(-0.2, -1.08, -5.9)

				var_166_32.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1019ui_story, var_166_36, var_166_35)

				local var_166_37 = manager.ui.mainCamera.transform.position - var_166_32.position

				var_166_32.forward = Vector3.New(var_166_37.x, var_166_37.y, var_166_37.z)

				local var_166_38 = var_166_32.localEulerAngles

				var_166_38.z = 0
				var_166_38.x = 0
				var_166_32.localEulerAngles = var_166_38
			end

			if arg_163_1.time_ >= var_166_33 + var_166_34 and arg_163_1.time_ < var_166_33 + var_166_34 + arg_166_0 then
				var_166_32.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_166_39 = manager.ui.mainCamera.transform.position - var_166_32.position

				var_166_32.forward = Vector3.New(var_166_39.x, var_166_39.y, var_166_39.z)

				local var_166_40 = var_166_32.localEulerAngles

				var_166_40.z = 0
				var_166_40.x = 0
				var_166_32.localEulerAngles = var_166_40
			end

			local var_166_41 = arg_163_1.actors_["1019ui_story"]
			local var_166_42 = 3.8

			if var_166_42 < arg_163_1.time_ and arg_163_1.time_ <= var_166_42 + arg_166_0 and not isNil(var_166_41) and arg_163_1.var_.characterEffect1019ui_story == nil then
				arg_163_1.var_.characterEffect1019ui_story = var_166_41:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_43 = 0.2

			if var_166_42 <= arg_163_1.time_ and arg_163_1.time_ < var_166_42 + var_166_43 and not isNil(var_166_41) then
				local var_166_44 = (arg_163_1.time_ - var_166_42) / var_166_43

				if arg_163_1.var_.characterEffect1019ui_story and not isNil(var_166_41) then
					arg_163_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_42 + var_166_43 and arg_163_1.time_ < var_166_42 + var_166_43 + arg_166_0 and not isNil(var_166_41) and arg_163_1.var_.characterEffect1019ui_story then
				arg_163_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_166_45 = 3.8

			if var_166_45 < arg_163_1.time_ and arg_163_1.time_ <= var_166_45 + arg_166_0 then
				arg_163_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_166_46 = 3.8

			if var_166_46 < arg_163_1.time_ and arg_163_1.time_ <= var_166_46 + arg_166_0 then
				arg_163_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_166_47 = 0
			local var_166_48 = 1

			if var_166_47 < arg_163_1.time_ and arg_163_1.time_ <= var_166_47 + arg_166_0 then
				local var_166_49 = "play"
				local var_166_50 = "music"

				arg_163_1:AudioAction(var_166_49, var_166_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_166_51 = ""
				local var_166_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_166_52 ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_52 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_52

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_52
						arg_163_1.bgmTxt2_.text = var_166_52
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_166_53 = 3.8
			local var_166_54 = 1

			if var_166_53 < arg_163_1.time_ and arg_163_1.time_ <= var_166_53 + arg_166_0 then
				local var_166_55 = "play"
				local var_166_56 = "music"

				arg_163_1:AudioAction(var_166_55, var_166_56, "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_166_57 = ""
				local var_166_58 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if var_166_58 ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_58 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_58

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_58
						arg_163_1.bgmTxt2_.text = var_166_58
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_166_59 = 4
			local var_166_60 = 0.9

			if var_166_59 < arg_163_1.time_ and arg_163_1.time_ <= var_166_59 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_61 = arg_163_1:FormatText(StoryNameCfg[13].name)

				arg_163_1.leftNameTxt_.text = var_166_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_62 = arg_163_1:GetWordFromCfg(910201040)
				local var_166_63 = arg_163_1:FormatText(var_166_62.content)

				arg_163_1.text_.text = var_166_63

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_64 = 36
				local var_166_65 = utf8.len(var_166_63)
				local var_166_66 = var_166_64 <= 0 and var_166_60 or var_166_60 * (var_166_65 / var_166_64)

				if var_166_66 > 0 and var_166_60 < var_166_66 then
					arg_163_1.talkMaxDuration = var_166_66

					if var_166_66 + var_166_59 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_66 + var_166_59
					end
				end

				arg_163_1.text_.text = var_166_63
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_67 = math.max(var_166_60, arg_163_1.talkMaxDuration)

			if var_166_59 <= arg_163_1.time_ and arg_163_1.time_ < var_166_59 + var_166_67 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_59) / var_166_67

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_59 + var_166_67 and arg_163_1.time_ < var_166_59 + var_166_67 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play910201041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 910201041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play910201042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_172_2 = 0
			local var_172_3 = 0.825

			if var_172_2 < arg_169_1.time_ and arg_169_1.time_ <= var_172_2 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_4 = arg_169_1:FormatText(StoryNameCfg[13].name)

				arg_169_1.leftNameTxt_.text = var_172_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_5 = arg_169_1:GetWordFromCfg(910201041)
				local var_172_6 = arg_169_1:FormatText(var_172_5.content)

				arg_169_1.text_.text = var_172_6

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_7 = 33
				local var_172_8 = utf8.len(var_172_6)
				local var_172_9 = var_172_7 <= 0 and var_172_3 or var_172_3 * (var_172_8 / var_172_7)

				if var_172_9 > 0 and var_172_3 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_2 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_2
					end
				end

				arg_169_1.text_.text = var_172_6
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_10 = math.max(var_172_3, arg_169_1.talkMaxDuration)

			if var_172_2 <= arg_169_1.time_ and arg_169_1.time_ < var_172_2 + var_172_10 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_2) / var_172_10

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_2 + var_172_10 and arg_169_1.time_ < var_172_2 + var_172_10 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play910201042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 910201042
		arg_173_1.duration_ = 0.2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"

			SetActive(arg_173_1.choicesGo_, true)

			for iter_174_0, iter_174_1 in ipairs(arg_173_1.choices_) do
				local var_174_0 = iter_174_0 <= 1

				SetActive(iter_174_1.go, var_174_0)
			end

			arg_173_1.choices_[1].txt.text = arg_173_1:FormatText(StoryChoiceCfg[247].name)
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play910201043(arg_173_1)
			end

			arg_173_1:RecordChoiceLog(910201042, 247)
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1019ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1019ui_story == nil then
				arg_173_1.var_.characterEffect1019ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1019ui_story and not isNil(var_176_0) then
					local var_176_4 = Mathf.Lerp(0, 0.5, var_176_3)

					arg_173_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1019ui_story.fillRatio = var_176_4
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1019ui_story then
				local var_176_5 = 0.5

				arg_173_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1019ui_story.fillRatio = var_176_5
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play910201043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 910201043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play910201044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1019ui_story"]
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1019ui_story == nil then
				arg_177_1.var_.characterEffect1019ui_story = var_180_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.2

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 and not isNil(var_180_0) then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2

				if arg_177_1.var_.characterEffect1019ui_story and not isNil(var_180_0) then
					arg_177_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 and not isNil(var_180_0) and arg_177_1.var_.characterEffect1019ui_story then
				arg_177_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_180_4 = 0

			if var_180_4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_180_5 = 0

			if var_180_5 < arg_177_1.time_ and arg_177_1.time_ <= var_180_5 + arg_180_0 then
				arg_177_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_180_6 = 0
			local var_180_7 = 0.575

			if var_180_6 < arg_177_1.time_ and arg_177_1.time_ <= var_180_6 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_8 = arg_177_1:FormatText(StoryNameCfg[13].name)

				arg_177_1.leftNameTxt_.text = var_180_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_9 = arg_177_1:GetWordFromCfg(910201043)
				local var_180_10 = arg_177_1:FormatText(var_180_9.content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_11 = 23
				local var_180_12 = utf8.len(var_180_10)
				local var_180_13 = var_180_11 <= 0 and var_180_7 or var_180_7 * (var_180_12 / var_180_11)

				if var_180_13 > 0 and var_180_7 < var_180_13 then
					arg_177_1.talkMaxDuration = var_180_13

					if var_180_13 + var_180_6 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_13 + var_180_6
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_14 = math.max(var_180_7, arg_177_1.talkMaxDuration)

			if var_180_6 <= arg_177_1.time_ and arg_177_1.time_ < var_180_6 + var_180_14 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_6) / var_180_14

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_6 + var_180_14 and arg_177_1.time_ < var_180_6 + var_180_14 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play910201044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 910201044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play910201045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1019ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1019ui_story == nil then
				arg_181_1.var_.characterEffect1019ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect1019ui_story and not isNil(var_184_0) then
					local var_184_4 = Mathf.Lerp(0, 0.5, var_184_3)

					arg_181_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1019ui_story.fillRatio = var_184_4
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect1019ui_story then
				local var_184_5 = 0.5

				arg_181_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1019ui_story.fillRatio = var_184_5
			end

			local var_184_6 = 0
			local var_184_7 = 0.15

			if var_184_6 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_8 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_9 = arg_181_1:GetWordFromCfg(910201044)
				local var_184_10 = arg_181_1:FormatText(var_184_9.content)

				arg_181_1.text_.text = var_184_10

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 6
				local var_184_12 = utf8.len(var_184_10)
				local var_184_13 = var_184_11 <= 0 and var_184_7 or var_184_7 * (var_184_12 / var_184_11)

				if var_184_13 > 0 and var_184_7 < var_184_13 then
					arg_181_1.talkMaxDuration = var_184_13

					if var_184_13 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_13 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_10
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play910201045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 910201045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"

			SetActive(arg_185_1.choicesGo_, true)

			for iter_186_0, iter_186_1 in ipairs(arg_185_1.choices_) do
				local var_186_0 = iter_186_0 <= 2

				SetActive(iter_186_1.go, var_186_0)
			end

			arg_185_1.choices_[1].txt.text = arg_185_1:FormatText(StoryChoiceCfg[248].name)
			arg_185_1.choices_[2].txt.text = arg_185_1:FormatText(StoryChoiceCfg[249].name)
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play910201046(arg_185_1)
			end

			if arg_187_0 == 2 then
				arg_185_0:Play910201046(arg_185_1)
			end

			arg_185_1:RecordChoiceLog(910201045, 248, 249)
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 4.96666666666667
			local var_188_1 = 0.0333333333333333

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[7].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_3 = arg_185_1:GetWordFromCfg(100012006)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 0
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play910201046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 910201046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play910201047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1019ui_story"]
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1019ui_story == nil then
				arg_189_1.var_.characterEffect1019ui_story = var_192_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.2

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 and not isNil(var_192_0) then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2

				if arg_189_1.var_.characterEffect1019ui_story and not isNil(var_192_0) then
					arg_189_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1019ui_story then
				arg_189_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_192_4 = "1019ui_story"

			if arg_189_1.actors_[var_192_4] == nil then
				local var_192_5 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_192_5) then
					local var_192_6 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_189_1.stage_.transform)

					var_192_6.name = var_192_4
					var_192_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_189_1.actors_[var_192_4] = var_192_6

					local var_192_7 = var_192_6:GetComponentInChildren(typeof(CharacterEffect))

					var_192_7.enabled = true

					local var_192_8 = GameObjectTools.GetOrAddComponent(var_192_6, typeof(DynamicBoneHelper))

					if var_192_8 then
						var_192_8:EnableDynamicBone(false)
					end

					arg_189_1:ShowWeapon(var_192_7.transform, false)

					arg_189_1.var_[var_192_4 .. "Animator"] = var_192_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_189_1.var_[var_192_4 .. "Animator"].applyRootMotion = true
					arg_189_1.var_[var_192_4 .. "LipSync"] = var_192_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_192_9 = 0

			if var_192_9 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 then
				arg_189_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action467")
			end

			local var_192_10 = 0
			local var_192_11 = 0.75

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_12 = arg_189_1:FormatText(StoryNameCfg[13].name)

				arg_189_1.leftNameTxt_.text = var_192_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_13 = arg_189_1:GetWordFromCfg(910201046)
				local var_192_14 = arg_189_1:FormatText(var_192_13.content)

				arg_189_1.text_.text = var_192_14

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_15 = 30
				local var_192_16 = utf8.len(var_192_14)
				local var_192_17 = var_192_15 <= 0 and var_192_11 or var_192_11 * (var_192_16 / var_192_15)

				if var_192_17 > 0 and var_192_11 < var_192_17 then
					arg_189_1.talkMaxDuration = var_192_17

					if var_192_17 + var_192_10 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_17 + var_192_10
					end
				end

				arg_189_1.text_.text = var_192_14
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_18 = math.max(var_192_11, arg_189_1.talkMaxDuration)

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_18 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_10) / var_192_18

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_10 + var_192_18 and arg_189_1.time_ < var_192_10 + var_192_18 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play910201047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 910201047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play910201048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action472")
			end

			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_196_2 = 0
			local var_196_3 = 0.775

			if var_196_2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_2 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_4 = arg_193_1:FormatText(StoryNameCfg[13].name)

				arg_193_1.leftNameTxt_.text = var_196_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_5 = arg_193_1:GetWordFromCfg(910201047)
				local var_196_6 = arg_193_1:FormatText(var_196_5.content)

				arg_193_1.text_.text = var_196_6

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_7 = 31
				local var_196_8 = utf8.len(var_196_6)
				local var_196_9 = var_196_7 <= 0 and var_196_3 or var_196_3 * (var_196_8 / var_196_7)

				if var_196_9 > 0 and var_196_3 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_2 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_2
					end
				end

				arg_193_1.text_.text = var_196_6
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_3, arg_193_1.talkMaxDuration)

			if var_196_2 <= arg_193_1.time_ and arg_193_1.time_ < var_196_2 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_2) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_2 + var_196_10 and arg_193_1.time_ < var_196_2 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play910201048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 910201048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play910201049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_200_2 = 0
			local var_200_3 = 0.4

			if var_200_2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_4 = arg_197_1:FormatText(StoryNameCfg[13].name)

				arg_197_1.leftNameTxt_.text = var_200_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_5 = arg_197_1:GetWordFromCfg(910201048)
				local var_200_6 = arg_197_1:FormatText(var_200_5.content)

				arg_197_1.text_.text = var_200_6

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_7 = 16
				local var_200_8 = utf8.len(var_200_6)
				local var_200_9 = var_200_7 <= 0 and var_200_3 or var_200_3 * (var_200_8 / var_200_7)

				if var_200_9 > 0 and var_200_3 < var_200_9 then
					arg_197_1.talkMaxDuration = var_200_9

					if var_200_9 + var_200_2 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_9 + var_200_2
					end
				end

				arg_197_1.text_.text = var_200_6
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_10 = math.max(var_200_3, arg_197_1.talkMaxDuration)

			if var_200_2 <= arg_197_1.time_ and arg_197_1.time_ < var_200_2 + var_200_10 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_2) / var_200_10

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_2 + var_200_10 and arg_197_1.time_ < var_200_2 + var_200_10 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play910201049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 910201049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play910201050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1019ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1019ui_story == nil then
				arg_201_1.var_.characterEffect1019ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.2

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1019ui_story and not isNil(var_204_0) then
					local var_204_4 = Mathf.Lerp(0, 0.5, var_204_3)

					arg_201_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1019ui_story.fillRatio = var_204_4
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1019ui_story then
				local var_204_5 = 0.5

				arg_201_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1019ui_story.fillRatio = var_204_5
			end

			local var_204_6 = 0
			local var_204_7 = 0.2

			if var_204_6 < arg_201_1.time_ and arg_201_1.time_ <= var_204_6 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_8 = arg_201_1:FormatText(StoryNameCfg[7].name)

				arg_201_1.leftNameTxt_.text = var_204_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_9 = arg_201_1:GetWordFromCfg(910201049)
				local var_204_10 = arg_201_1:FormatText(var_204_9.content)

				arg_201_1.text_.text = var_204_10

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_11 = 8
				local var_204_12 = utf8.len(var_204_10)
				local var_204_13 = var_204_11 <= 0 and var_204_7 or var_204_7 * (var_204_12 / var_204_11)

				if var_204_13 > 0 and var_204_7 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_6 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_6
					end
				end

				arg_201_1.text_.text = var_204_10
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_14 = math.max(var_204_7, arg_201_1.talkMaxDuration)

			if var_204_6 <= arg_201_1.time_ and arg_201_1.time_ < var_204_6 + var_204_14 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_6) / var_204_14

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_6 + var_204_14 and arg_201_1.time_ < var_204_6 + var_204_14 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play910201050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 910201050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play910201051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1019ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1019ui_story == nil then
				arg_205_1.var_.characterEffect1019ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.2

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect1019ui_story and not isNil(var_208_0) then
					arg_205_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1019ui_story then
				arg_205_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_208_4 = 0

			if var_208_4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_208_5 = 0

			if var_208_5 < arg_205_1.time_ and arg_205_1.time_ <= var_208_5 + arg_208_0 then
				arg_205_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_208_6 = 0
			local var_208_7 = 0.525

			if var_208_6 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_8 = arg_205_1:FormatText(StoryNameCfg[13].name)

				arg_205_1.leftNameTxt_.text = var_208_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_9 = arg_205_1:GetWordFromCfg(910201050)
				local var_208_10 = arg_205_1:FormatText(var_208_9.content)

				arg_205_1.text_.text = var_208_10

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_11 = 21
				local var_208_12 = utf8.len(var_208_10)
				local var_208_13 = var_208_11 <= 0 and var_208_7 or var_208_7 * (var_208_12 / var_208_11)

				if var_208_13 > 0 and var_208_7 < var_208_13 then
					arg_205_1.talkMaxDuration = var_208_13

					if var_208_13 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_6
					end
				end

				arg_205_1.text_.text = var_208_10
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_14 = math.max(var_208_7, arg_205_1.talkMaxDuration)

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_14 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_6) / var_208_14

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_6 + var_208_14 and arg_205_1.time_ < var_208_6 + var_208_14 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play910201051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 910201051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play910201052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1019ui_story"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1019ui_story == nil then
				arg_209_1.var_.characterEffect1019ui_story = var_212_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.characterEffect1019ui_story and not isNil(var_212_0) then
					local var_212_4 = Mathf.Lerp(0, 0.5, var_212_3)

					arg_209_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1019ui_story.fillRatio = var_212_4
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.characterEffect1019ui_story then
				local var_212_5 = 0.5

				arg_209_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1019ui_story.fillRatio = var_212_5
			end

			local var_212_6 = 0
			local var_212_7 = 0.3

			if var_212_6 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_8 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_9 = arg_209_1:GetWordFromCfg(910201051)
				local var_212_10 = arg_209_1:FormatText(var_212_9.content)

				arg_209_1.text_.text = var_212_10

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 12
				local var_212_12 = utf8.len(var_212_10)
				local var_212_13 = var_212_11 <= 0 and var_212_7 or var_212_7 * (var_212_12 / var_212_11)

				if var_212_13 > 0 and var_212_7 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_10
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play910201052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 910201052
		arg_213_1.duration_ = 9

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play910201053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = "B13"

			if arg_213_1.bgs_[var_216_0] == nil then
				local var_216_1 = Object.Instantiate(arg_213_1.paintGo_)

				var_216_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_216_0)
				var_216_1.name = var_216_0
				var_216_1.transform.parent = arg_213_1.stage_.transform
				var_216_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.bgs_[var_216_0] = var_216_1
			end

			local var_216_2 = 1.966

			if var_216_2 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				local var_216_3 = manager.ui.mainCamera.transform.localPosition
				local var_216_4 = Vector3.New(0, 0, 10) + Vector3.New(var_216_3.x, var_216_3.y, 0)
				local var_216_5 = arg_213_1.bgs_.B13

				var_216_5.transform.localPosition = var_216_4
				var_216_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_216_6 = var_216_5:GetComponent("SpriteRenderer")

				if var_216_6 and var_216_6.sprite then
					local var_216_7 = (var_216_5.transform.localPosition - var_216_3).z
					local var_216_8 = manager.ui.mainCameraCom_
					local var_216_9 = 2 * var_216_7 * Mathf.Tan(var_216_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_216_10 = var_216_9 * var_216_8.aspect
					local var_216_11 = var_216_6.sprite.bounds.size.x
					local var_216_12 = var_216_6.sprite.bounds.size.y
					local var_216_13 = var_216_10 / var_216_11
					local var_216_14 = var_216_9 / var_216_12
					local var_216_15 = var_216_14 < var_216_13 and var_216_13 or var_216_14

					var_216_5.transform.localScale = Vector3.New(var_216_15, var_216_15, 0)
				end

				for iter_216_0, iter_216_1 in pairs(arg_213_1.bgs_) do
					if iter_216_0 ~= "B13" then
						iter_216_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_216_16 = 0

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_17 = 2

			if var_216_16 <= arg_213_1.time_ and arg_213_1.time_ < var_216_16 + var_216_17 then
				local var_216_18 = (arg_213_1.time_ - var_216_16) / var_216_17
				local var_216_19 = Color.New(0, 0, 0)

				var_216_19.a = Mathf.Lerp(0, 1, var_216_18)
				arg_213_1.mask_.color = var_216_19
			end

			if arg_213_1.time_ >= var_216_16 + var_216_17 and arg_213_1.time_ < var_216_16 + var_216_17 + arg_216_0 then
				local var_216_20 = Color.New(0, 0, 0)

				var_216_20.a = 1
				arg_213_1.mask_.color = var_216_20
			end

			local var_216_21 = 2

			if var_216_21 < arg_213_1.time_ and arg_213_1.time_ <= var_216_21 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_22 = 2

			if var_216_21 <= arg_213_1.time_ and arg_213_1.time_ < var_216_21 + var_216_22 then
				local var_216_23 = (arg_213_1.time_ - var_216_21) / var_216_22
				local var_216_24 = Color.New(0, 0, 0)

				var_216_24.a = Mathf.Lerp(1, 0, var_216_23)
				arg_213_1.mask_.color = var_216_24
			end

			if arg_213_1.time_ >= var_216_21 + var_216_22 and arg_213_1.time_ < var_216_21 + var_216_22 + arg_216_0 then
				local var_216_25 = Color.New(0, 0, 0)
				local var_216_26 = 0

				arg_213_1.mask_.enabled = false
				var_216_25.a = var_216_26
				arg_213_1.mask_.color = var_216_25
			end

			local var_216_27 = arg_213_1.actors_["1019ui_story"].transform
			local var_216_28 = 1.966

			if var_216_28 < arg_213_1.time_ and arg_213_1.time_ <= var_216_28 + arg_216_0 then
				arg_213_1.var_.moveOldPos1019ui_story = var_216_27.localPosition
			end

			local var_216_29 = 0.001

			if var_216_28 <= arg_213_1.time_ and arg_213_1.time_ < var_216_28 + var_216_29 then
				local var_216_30 = (arg_213_1.time_ - var_216_28) / var_216_29
				local var_216_31 = Vector3.New(0, 100, 0)

				var_216_27.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1019ui_story, var_216_31, var_216_30)

				local var_216_32 = manager.ui.mainCamera.transform.position - var_216_27.position

				var_216_27.forward = Vector3.New(var_216_32.x, var_216_32.y, var_216_32.z)

				local var_216_33 = var_216_27.localEulerAngles

				var_216_33.z = 0
				var_216_33.x = 0
				var_216_27.localEulerAngles = var_216_33
			end

			if arg_213_1.time_ >= var_216_28 + var_216_29 and arg_213_1.time_ < var_216_28 + var_216_29 + arg_216_0 then
				var_216_27.localPosition = Vector3.New(0, 100, 0)

				local var_216_34 = manager.ui.mainCamera.transform.position - var_216_27.position

				var_216_27.forward = Vector3.New(var_216_34.x, var_216_34.y, var_216_34.z)

				local var_216_35 = var_216_27.localEulerAngles

				var_216_35.z = 0
				var_216_35.x = 0
				var_216_27.localEulerAngles = var_216_35
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_36 = 4
			local var_216_37 = 0.875

			if var_216_36 < arg_213_1.time_ and arg_213_1.time_ <= var_216_36 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_38 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_38:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_39 = arg_213_1:GetWordFromCfg(910201052)
				local var_216_40 = arg_213_1:FormatText(var_216_39.content)

				arg_213_1.text_.text = var_216_40

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_41 = 35
				local var_216_42 = utf8.len(var_216_40)
				local var_216_43 = var_216_41 <= 0 and var_216_37 or var_216_37 * (var_216_42 / var_216_41)

				if var_216_43 > 0 and var_216_37 < var_216_43 then
					arg_213_1.talkMaxDuration = var_216_43
					var_216_36 = var_216_36 + 0.3

					if var_216_43 + var_216_36 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_43 + var_216_36
					end
				end

				arg_213_1.text_.text = var_216_40
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_44 = var_216_36 + 0.3
			local var_216_45 = math.max(var_216_37, arg_213_1.talkMaxDuration)

			if var_216_44 <= arg_213_1.time_ and arg_213_1.time_ < var_216_44 + var_216_45 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_44) / var_216_45

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_44 + var_216_45 and arg_213_1.time_ < var_216_44 + var_216_45 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play910201053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 910201053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play910201054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = "1039ui_story"

			if arg_219_1.actors_[var_222_0] == nil then
				local var_222_1 = Asset.Load("Char/" .. "1039ui_story")

				if not isNil(var_222_1) then
					local var_222_2 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_219_1.stage_.transform)

					var_222_2.name = var_222_0
					var_222_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_219_1.actors_[var_222_0] = var_222_2

					local var_222_3 = var_222_2:GetComponentInChildren(typeof(CharacterEffect))

					var_222_3.enabled = true

					local var_222_4 = GameObjectTools.GetOrAddComponent(var_222_2, typeof(DynamicBoneHelper))

					if var_222_4 then
						var_222_4:EnableDynamicBone(false)
					end

					arg_219_1:ShowWeapon(var_222_3.transform, false)

					arg_219_1.var_[var_222_0 .. "Animator"] = var_222_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_219_1.var_[var_222_0 .. "Animator"].applyRootMotion = true
					arg_219_1.var_[var_222_0 .. "LipSync"] = var_222_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_222_5 = arg_219_1.actors_["1039ui_story"].transform
			local var_222_6 = 0

			if var_222_6 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.var_.moveOldPos1039ui_story = var_222_5.localPosition
			end

			local var_222_7 = 0.001

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_7 then
				local var_222_8 = (arg_219_1.time_ - var_222_6) / var_222_7
				local var_222_9 = Vector3.New(0, -1.01, -5.9)

				var_222_5.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1039ui_story, var_222_9, var_222_8)

				local var_222_10 = manager.ui.mainCamera.transform.position - var_222_5.position

				var_222_5.forward = Vector3.New(var_222_10.x, var_222_10.y, var_222_10.z)

				local var_222_11 = var_222_5.localEulerAngles

				var_222_11.z = 0
				var_222_11.x = 0
				var_222_5.localEulerAngles = var_222_11
			end

			if arg_219_1.time_ >= var_222_6 + var_222_7 and arg_219_1.time_ < var_222_6 + var_222_7 + arg_222_0 then
				var_222_5.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_222_12 = manager.ui.mainCamera.transform.position - var_222_5.position

				var_222_5.forward = Vector3.New(var_222_12.x, var_222_12.y, var_222_12.z)

				local var_222_13 = var_222_5.localEulerAngles

				var_222_13.z = 0
				var_222_13.x = 0
				var_222_5.localEulerAngles = var_222_13
			end

			local var_222_14 = 0

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 then
				arg_219_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			local var_222_15 = 0

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_222_16 = arg_219_1.actors_["1039ui_story"]
			local var_222_17 = 0

			if var_222_17 < arg_219_1.time_ and arg_219_1.time_ <= var_222_17 + arg_222_0 and not isNil(var_222_16) and arg_219_1.var_.characterEffect1039ui_story == nil then
				arg_219_1.var_.characterEffect1039ui_story = var_222_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_18 = 0.2

			if var_222_17 <= arg_219_1.time_ and arg_219_1.time_ < var_222_17 + var_222_18 and not isNil(var_222_16) then
				local var_222_19 = (arg_219_1.time_ - var_222_17) / var_222_18

				if arg_219_1.var_.characterEffect1039ui_story and not isNil(var_222_16) then
					arg_219_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_17 + var_222_18 and arg_219_1.time_ < var_222_17 + var_222_18 + arg_222_0 and not isNil(var_222_16) and arg_219_1.var_.characterEffect1039ui_story then
				arg_219_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_222_20 = 0
			local var_222_21 = 0.225

			if var_222_20 < arg_219_1.time_ and arg_219_1.time_ <= var_222_20 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_22 = arg_219_1:FormatText(StoryNameCfg[9].name)

				arg_219_1.leftNameTxt_.text = var_222_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_23 = arg_219_1:GetWordFromCfg(910201053)
				local var_222_24 = arg_219_1:FormatText(var_222_23.content)

				arg_219_1.text_.text = var_222_24

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_25 = 9
				local var_222_26 = utf8.len(var_222_24)
				local var_222_27 = var_222_25 <= 0 and var_222_21 or var_222_21 * (var_222_26 / var_222_25)

				if var_222_27 > 0 and var_222_21 < var_222_27 then
					arg_219_1.talkMaxDuration = var_222_27

					if var_222_27 + var_222_20 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_27 + var_222_20
					end
				end

				arg_219_1.text_.text = var_222_24
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_28 = math.max(var_222_21, arg_219_1.talkMaxDuration)

			if var_222_20 <= arg_219_1.time_ and arg_219_1.time_ < var_222_20 + var_222_28 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_20) / var_222_28

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_20 + var_222_28 and arg_219_1.time_ < var_222_20 + var_222_28 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play910201054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 910201054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play910201055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1039ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1039ui_story == nil then
				arg_223_1.var_.characterEffect1039ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.2

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect1039ui_story and not isNil(var_226_0) then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1039ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1039ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1039ui_story.fillRatio = var_226_5
			end

			local var_226_6 = 0
			local var_226_7 = 0.55

			if var_226_6 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_8 = arg_223_1:FormatText(StoryNameCfg[7].name)

				arg_223_1.leftNameTxt_.text = var_226_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_9 = arg_223_1:GetWordFromCfg(910201054)
				local var_226_10 = arg_223_1:FormatText(var_226_9.content)

				arg_223_1.text_.text = var_226_10

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 22
				local var_226_12 = utf8.len(var_226_10)
				local var_226_13 = var_226_11 <= 0 and var_226_7 or var_226_7 * (var_226_12 / var_226_11)

				if var_226_13 > 0 and var_226_7 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13

					if var_226_13 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_10
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_14 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_14

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_14 and arg_223_1.time_ < var_226_6 + var_226_14 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play910201055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 910201055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play910201056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1039ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1039ui_story == nil then
				arg_227_1.var_.characterEffect1039ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.2

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect1039ui_story and not isNil(var_230_0) then
					arg_227_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1039ui_story then
				arg_227_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_230_4 = 0

			if var_230_4 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action457")
			end

			local var_230_5 = 0

			if var_230_5 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_230_6 = 0
			local var_230_7 = 0.375

			if var_230_6 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_8 = arg_227_1:FormatText(StoryNameCfg[9].name)

				arg_227_1.leftNameTxt_.text = var_230_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_9 = arg_227_1:GetWordFromCfg(910201055)
				local var_230_10 = arg_227_1:FormatText(var_230_9.content)

				arg_227_1.text_.text = var_230_10

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 15
				local var_230_12 = utf8.len(var_230_10)
				local var_230_13 = var_230_11 <= 0 and var_230_7 or var_230_7 * (var_230_12 / var_230_11)

				if var_230_13 > 0 and var_230_7 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_10
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_14 = math.max(var_230_7, arg_227_1.talkMaxDuration)

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_14 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_6) / var_230_14

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_6 + var_230_14 and arg_227_1.time_ < var_230_6 + var_230_14 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play910201056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 910201056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play910201057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1039ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1039ui_story == nil then
				arg_231_1.var_.characterEffect1039ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.2

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect1039ui_story and not isNil(var_234_0) then
					local var_234_4 = Mathf.Lerp(0, 0.5, var_234_3)

					arg_231_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1039ui_story.fillRatio = var_234_4
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect1039ui_story then
				local var_234_5 = 0.5

				arg_231_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1039ui_story.fillRatio = var_234_5
			end

			local var_234_6 = 0
			local var_234_7 = 0.825

			if var_234_6 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_8 = arg_231_1:FormatText(StoryNameCfg[7].name)

				arg_231_1.leftNameTxt_.text = var_234_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_9 = arg_231_1:GetWordFromCfg(910201056)
				local var_234_10 = arg_231_1:FormatText(var_234_9.content)

				arg_231_1.text_.text = var_234_10

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_11 = 33
				local var_234_12 = utf8.len(var_234_10)
				local var_234_13 = var_234_11 <= 0 and var_234_7 or var_234_7 * (var_234_12 / var_234_11)

				if var_234_13 > 0 and var_234_7 < var_234_13 then
					arg_231_1.talkMaxDuration = var_234_13

					if var_234_13 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_6
					end
				end

				arg_231_1.text_.text = var_234_10
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_14 = math.max(var_234_7, arg_231_1.talkMaxDuration)

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_14 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_6) / var_234_14

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_6 + var_234_14 and arg_231_1.time_ < var_234_6 + var_234_14 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play910201057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 910201057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play910201058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1039ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1039ui_story == nil then
				arg_235_1.var_.characterEffect1039ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1039ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1039ui_story then
				arg_235_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_238_4 = 0

			if var_238_4 < arg_235_1.time_ and arg_235_1.time_ <= var_238_4 + arg_238_0 then
				arg_235_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action472")
			end

			local var_238_5 = 0

			if var_238_5 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 then
				arg_235_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_238_6 = 0
			local var_238_7 = 0.875

			if var_238_6 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_8 = arg_235_1:FormatText(StoryNameCfg[9].name)

				arg_235_1.leftNameTxt_.text = var_238_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_9 = arg_235_1:GetWordFromCfg(910201057)
				local var_238_10 = arg_235_1:FormatText(var_238_9.content)

				arg_235_1.text_.text = var_238_10

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 35
				local var_238_12 = utf8.len(var_238_10)
				local var_238_13 = var_238_11 <= 0 and var_238_7 or var_238_7 * (var_238_12 / var_238_11)

				if var_238_13 > 0 and var_238_7 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_10
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_14 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_14 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_14

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_14 and arg_235_1.time_ < var_238_6 + var_238_14 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play910201058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 910201058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play910201059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action425")
			end

			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_242_2 = 0
			local var_242_3 = 0.875

			if var_242_2 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_4 = arg_239_1:FormatText(StoryNameCfg[9].name)

				arg_239_1.leftNameTxt_.text = var_242_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_5 = arg_239_1:GetWordFromCfg(910201058)
				local var_242_6 = arg_239_1:FormatText(var_242_5.content)

				arg_239_1.text_.text = var_242_6

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_7 = 35
				local var_242_8 = utf8.len(var_242_6)
				local var_242_9 = var_242_7 <= 0 and var_242_3 or var_242_3 * (var_242_8 / var_242_7)

				if var_242_9 > 0 and var_242_3 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_6
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_10 and arg_239_1.time_ < var_242_2 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play910201059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 910201059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play910201060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action454")
			end

			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_246_2 = 0
			local var_246_3 = 0.775

			if var_246_2 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_4 = arg_243_1:FormatText(StoryNameCfg[9].name)

				arg_243_1.leftNameTxt_.text = var_246_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_5 = arg_243_1:GetWordFromCfg(910201059)
				local var_246_6 = arg_243_1:FormatText(var_246_5.content)

				arg_243_1.text_.text = var_246_6

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 31
				local var_246_8 = utf8.len(var_246_6)
				local var_246_9 = var_246_7 <= 0 and var_246_3 or var_246_3 * (var_246_8 / var_246_7)

				if var_246_9 > 0 and var_246_3 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_6
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_10 and arg_243_1.time_ < var_246_2 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play910201060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 910201060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play910201061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0

			if var_250_0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action442")
			end

			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_250_2 = 0
			local var_250_3 = 0.625

			if var_250_2 < arg_247_1.time_ and arg_247_1.time_ <= var_250_2 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_4 = arg_247_1:FormatText(StoryNameCfg[9].name)

				arg_247_1.leftNameTxt_.text = var_250_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_5 = arg_247_1:GetWordFromCfg(910201060)
				local var_250_6 = arg_247_1:FormatText(var_250_5.content)

				arg_247_1.text_.text = var_250_6

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_7 = 25
				local var_250_8 = utf8.len(var_250_6)
				local var_250_9 = var_250_7 <= 0 and var_250_3 or var_250_3 * (var_250_8 / var_250_7)

				if var_250_9 > 0 and var_250_3 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_2 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_2
					end
				end

				arg_247_1.text_.text = var_250_6
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_3, arg_247_1.talkMaxDuration)

			if var_250_2 <= arg_247_1.time_ and arg_247_1.time_ < var_250_2 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_2) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_2 + var_250_10 and arg_247_1.time_ < var_250_2 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play910201061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 910201061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play910201062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1039ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1039ui_story == nil then
				arg_251_1.var_.characterEffect1039ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.2

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect1039ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1039ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1039ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1039ui_story.fillRatio = var_254_5
			end

			local var_254_6 = 0
			local var_254_7 = 0.75

			if var_254_6 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_8 = arg_251_1:FormatText(StoryNameCfg[7].name)

				arg_251_1.leftNameTxt_.text = var_254_8

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

				local var_254_9 = arg_251_1:GetWordFromCfg(910201061)
				local var_254_10 = arg_251_1:FormatText(var_254_9.content)

				arg_251_1.text_.text = var_254_10

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 30
				local var_254_12 = utf8.len(var_254_10)
				local var_254_13 = var_254_11 <= 0 and var_254_7 or var_254_7 * (var_254_12 / var_254_11)

				if var_254_13 > 0 and var_254_7 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_10
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_14 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_14 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_14

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_14 and arg_251_1.time_ < var_254_6 + var_254_14 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play910201062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 910201062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play910201063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["1039ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1039ui_story == nil then
				arg_255_1.var_.characterEffect1039ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.2

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 and not isNil(var_258_0) then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect1039ui_story and not isNil(var_258_0) then
					arg_255_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and not isNil(var_258_0) and arg_255_1.var_.characterEffect1039ui_story then
				arg_255_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_258_4 = 0

			if var_258_4 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action425")
			end

			local var_258_5 = 0

			if var_258_5 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_258_6 = 0
			local var_258_7 = 0.125

			if var_258_6 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_8 = arg_255_1:FormatText(StoryNameCfg[9].name)

				arg_255_1.leftNameTxt_.text = var_258_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_9 = arg_255_1:GetWordFromCfg(910201062)
				local var_258_10 = arg_255_1:FormatText(var_258_9.content)

				arg_255_1.text_.text = var_258_10

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_11 = 5
				local var_258_12 = utf8.len(var_258_10)
				local var_258_13 = var_258_11 <= 0 and var_258_7 or var_258_7 * (var_258_12 / var_258_11)

				if var_258_13 > 0 and var_258_7 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13

					if var_258_13 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_6
					end
				end

				arg_255_1.text_.text = var_258_10
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_14 = math.max(var_258_7, arg_255_1.talkMaxDuration)

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_14 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_6) / var_258_14

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_6 + var_258_14 and arg_255_1.time_ < var_258_6 + var_258_14 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play910201063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 910201063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play910201064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1039ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1039ui_story == nil then
				arg_259_1.var_.characterEffect1039ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.2

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 and not isNil(var_262_0) then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect1039ui_story and not isNil(var_262_0) then
					local var_262_4 = Mathf.Lerp(0, 0.5, var_262_3)

					arg_259_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1039ui_story.fillRatio = var_262_4
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and not isNil(var_262_0) and arg_259_1.var_.characterEffect1039ui_story then
				local var_262_5 = 0.5

				arg_259_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1039ui_story.fillRatio = var_262_5
			end

			local var_262_6 = 0
			local var_262_7 = 0.45

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_8 = arg_259_1:FormatText(StoryNameCfg[7].name)

				arg_259_1.leftNameTxt_.text = var_262_8

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

				local var_262_9 = arg_259_1:GetWordFromCfg(910201063)
				local var_262_10 = arg_259_1:FormatText(var_262_9.content)

				arg_259_1.text_.text = var_262_10

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_11 = 18
				local var_262_12 = utf8.len(var_262_10)
				local var_262_13 = var_262_11 <= 0 and var_262_7 or var_262_7 * (var_262_12 / var_262_11)

				if var_262_13 > 0 and var_262_7 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13

					if var_262_13 + var_262_6 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_6
					end
				end

				arg_259_1.text_.text = var_262_10
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_14 = math.max(var_262_7, arg_259_1.talkMaxDuration)

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_14 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_6) / var_262_14

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_6 + var_262_14 and arg_259_1.time_ < var_262_6 + var_262_14 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play910201064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 910201064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play910201065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["1039ui_story"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1039ui_story == nil then
				arg_263_1.var_.characterEffect1039ui_story = var_266_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.2

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 and not isNil(var_266_0) then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.characterEffect1039ui_story and not isNil(var_266_0) then
					arg_263_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and not isNil(var_266_0) and arg_263_1.var_.characterEffect1039ui_story then
				arg_263_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_266_4 = 0

			if var_266_4 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action453")
			end

			local var_266_5 = 0

			if var_266_5 < arg_263_1.time_ and arg_263_1.time_ <= var_266_5 + arg_266_0 then
				arg_263_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_266_6 = 0
			local var_266_7 = 0.575

			if var_266_6 < arg_263_1.time_ and arg_263_1.time_ <= var_266_6 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_8 = arg_263_1:FormatText(StoryNameCfg[9].name)

				arg_263_1.leftNameTxt_.text = var_266_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_9 = arg_263_1:GetWordFromCfg(910201064)
				local var_266_10 = arg_263_1:FormatText(var_266_9.content)

				arg_263_1.text_.text = var_266_10

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_11 = 23
				local var_266_12 = utf8.len(var_266_10)
				local var_266_13 = var_266_11 <= 0 and var_266_7 or var_266_7 * (var_266_12 / var_266_11)

				if var_266_13 > 0 and var_266_7 < var_266_13 then
					arg_263_1.talkMaxDuration = var_266_13

					if var_266_13 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_13 + var_266_6
					end
				end

				arg_263_1.text_.text = var_266_10
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_7, arg_263_1.talkMaxDuration)

			if var_266_6 <= arg_263_1.time_ and arg_263_1.time_ < var_266_6 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_6) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_6 + var_266_14 and arg_263_1.time_ < var_266_6 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play910201065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 910201065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play910201066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action437")
			end

			local var_270_2 = 0
			local var_270_3 = 0.8

			if var_270_2 < arg_267_1.time_ and arg_267_1.time_ <= var_270_2 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_4 = arg_267_1:FormatText(StoryNameCfg[9].name)

				arg_267_1.leftNameTxt_.text = var_270_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_5 = arg_267_1:GetWordFromCfg(910201065)
				local var_270_6 = arg_267_1:FormatText(var_270_5.content)

				arg_267_1.text_.text = var_270_6

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_7 = 32
				local var_270_8 = utf8.len(var_270_6)
				local var_270_9 = var_270_7 <= 0 and var_270_3 or var_270_3 * (var_270_8 / var_270_7)

				if var_270_9 > 0 and var_270_3 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_2 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_2
					end
				end

				arg_267_1.text_.text = var_270_6
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_3, arg_267_1.talkMaxDuration)

			if var_270_2 <= arg_267_1.time_ and arg_267_1.time_ < var_270_2 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_2) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_2 + var_270_10 and arg_267_1.time_ < var_270_2 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play910201066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 910201066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play910201067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1039ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1039ui_story == nil then
				arg_271_1.var_.characterEffect1039ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.2

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect1039ui_story and not isNil(var_274_0) then
					local var_274_4 = Mathf.Lerp(0, 0.5, var_274_3)

					arg_271_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1039ui_story.fillRatio = var_274_4
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect1039ui_story then
				local var_274_5 = 0.5

				arg_271_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1039ui_story.fillRatio = var_274_5
			end

			local var_274_6 = 0
			local var_274_7 = 0.5

			if var_274_6 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_8 = arg_271_1:GetWordFromCfg(910201066)
				local var_274_9 = arg_271_1:FormatText(var_274_8.content)

				arg_271_1.text_.text = var_274_9

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 20
				local var_274_11 = utf8.len(var_274_9)
				local var_274_12 = var_274_10 <= 0 and var_274_7 or var_274_7 * (var_274_11 / var_274_10)

				if var_274_12 > 0 and var_274_7 < var_274_12 then
					arg_271_1.talkMaxDuration = var_274_12

					if var_274_12 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_12 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_9
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_13 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_13 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_13

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_13 and arg_271_1.time_ < var_274_6 + var_274_13 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play910201067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 910201067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play910201068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0

			if var_278_0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_0 + arg_278_0 then
				arg_275_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action474")
			end

			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 then
				arg_275_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_278_2 = arg_275_1.actors_["1039ui_story"]
			local var_278_3 = 0

			if var_278_3 < arg_275_1.time_ and arg_275_1.time_ <= var_278_3 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.characterEffect1039ui_story == nil then
				arg_275_1.var_.characterEffect1039ui_story = var_278_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_4 = 0.2

			if var_278_3 <= arg_275_1.time_ and arg_275_1.time_ < var_278_3 + var_278_4 and not isNil(var_278_2) then
				local var_278_5 = (arg_275_1.time_ - var_278_3) / var_278_4

				if arg_275_1.var_.characterEffect1039ui_story and not isNil(var_278_2) then
					arg_275_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_3 + var_278_4 and arg_275_1.time_ < var_278_3 + var_278_4 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.characterEffect1039ui_story then
				arg_275_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_278_6 = 0
			local var_278_7 = 0.875

			if var_278_6 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_8 = arg_275_1:FormatText(StoryNameCfg[9].name)

				arg_275_1.leftNameTxt_.text = var_278_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_9 = arg_275_1:GetWordFromCfg(910201067)
				local var_278_10 = arg_275_1:FormatText(var_278_9.content)

				arg_275_1.text_.text = var_278_10

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 35
				local var_278_12 = utf8.len(var_278_10)
				local var_278_13 = var_278_11 <= 0 and var_278_7 or var_278_7 * (var_278_12 / var_278_11)

				if var_278_13 > 0 and var_278_7 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_10
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_14 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_14 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_14

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_14 and arg_275_1.time_ < var_278_6 + var_278_14 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play910201068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 910201068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play910201069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1039ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1039ui_story == nil then
				arg_279_1.var_.characterEffect1039ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.2

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect1039ui_story and not isNil(var_282_0) then
					local var_282_4 = Mathf.Lerp(0, 0.5, var_282_3)

					arg_279_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1039ui_story.fillRatio = var_282_4
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect1039ui_story then
				local var_282_5 = 0.5

				arg_279_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1039ui_story.fillRatio = var_282_5
			end

			local var_282_6 = 0
			local var_282_7 = 0.225

			if var_282_6 < arg_279_1.time_ and arg_279_1.time_ <= var_282_6 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_8 = arg_279_1:FormatText(StoryNameCfg[7].name)

				arg_279_1.leftNameTxt_.text = var_282_8

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

				local var_282_9 = arg_279_1:GetWordFromCfg(910201068)
				local var_282_10 = arg_279_1:FormatText(var_282_9.content)

				arg_279_1.text_.text = var_282_10

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_11 = 9
				local var_282_12 = utf8.len(var_282_10)
				local var_282_13 = var_282_11 <= 0 and var_282_7 or var_282_7 * (var_282_12 / var_282_11)

				if var_282_13 > 0 and var_282_7 < var_282_13 then
					arg_279_1.talkMaxDuration = var_282_13

					if var_282_13 + var_282_6 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_13 + var_282_6
					end
				end

				arg_279_1.text_.text = var_282_10
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_14 = math.max(var_282_7, arg_279_1.talkMaxDuration)

			if var_282_6 <= arg_279_1.time_ and arg_279_1.time_ < var_282_6 + var_282_14 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_6) / var_282_14

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_6 + var_282_14 and arg_279_1.time_ < var_282_6 + var_282_14 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play910201069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 910201069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play910201070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["1039ui_story"]
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1039ui_story == nil then
				arg_283_1.var_.characterEffect1039ui_story = var_286_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.2

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 and not isNil(var_286_0) then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2

				if arg_283_1.var_.characterEffect1039ui_story and not isNil(var_286_0) then
					arg_283_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 and not isNil(var_286_0) and arg_283_1.var_.characterEffect1039ui_story then
				arg_283_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_286_4 = 0

			if var_286_4 < arg_283_1.time_ and arg_283_1.time_ <= var_286_4 + arg_286_0 then
				arg_283_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action442")
			end

			local var_286_5 = 0

			if var_286_5 < arg_283_1.time_ and arg_283_1.time_ <= var_286_5 + arg_286_0 then
				arg_283_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_286_6 = 0
			local var_286_7 = 0.425

			if var_286_6 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_8 = arg_283_1:FormatText(StoryNameCfg[9].name)

				arg_283_1.leftNameTxt_.text = var_286_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_9 = arg_283_1:GetWordFromCfg(910201069)
				local var_286_10 = arg_283_1:FormatText(var_286_9.content)

				arg_283_1.text_.text = var_286_10

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 17
				local var_286_12 = utf8.len(var_286_10)
				local var_286_13 = var_286_11 <= 0 and var_286_7 or var_286_7 * (var_286_12 / var_286_11)

				if var_286_13 > 0 and var_286_7 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_10
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_14 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_14 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_14

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_14 and arg_283_1.time_ < var_286_6 + var_286_14 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play910201070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 910201070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play910201071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action424")
			end

			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_290_2 = 0
			local var_290_3 = 0.8

			if var_290_2 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_4 = arg_287_1:FormatText(StoryNameCfg[9].name)

				arg_287_1.leftNameTxt_.text = var_290_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_5 = arg_287_1:GetWordFromCfg(910201070)
				local var_290_6 = arg_287_1:FormatText(var_290_5.content)

				arg_287_1.text_.text = var_290_6

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 32
				local var_290_8 = utf8.len(var_290_6)
				local var_290_9 = var_290_7 <= 0 and var_290_3 or var_290_3 * (var_290_8 / var_290_7)

				if var_290_9 > 0 and var_290_3 < var_290_9 then
					arg_287_1.talkMaxDuration = var_290_9

					if var_290_9 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_9 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_6
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_10 and arg_287_1.time_ < var_290_2 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play910201071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 910201071
		arg_291_1.duration_ = 9

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play910201072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = "ST12"

			if arg_291_1.bgs_[var_294_0] == nil then
				local var_294_1 = Object.Instantiate(arg_291_1.paintGo_)

				var_294_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_294_0)
				var_294_1.name = var_294_0
				var_294_1.transform.parent = arg_291_1.stage_.transform
				var_294_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_291_1.bgs_[var_294_0] = var_294_1
			end

			local var_294_2 = 2

			if var_294_2 < arg_291_1.time_ and arg_291_1.time_ <= var_294_2 + arg_294_0 then
				local var_294_3 = manager.ui.mainCamera.transform.localPosition
				local var_294_4 = Vector3.New(0, 0, 10) + Vector3.New(var_294_3.x, var_294_3.y, 0)
				local var_294_5 = arg_291_1.bgs_.ST12

				var_294_5.transform.localPosition = var_294_4
				var_294_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_294_6 = var_294_5:GetComponent("SpriteRenderer")

				if var_294_6 and var_294_6.sprite then
					local var_294_7 = (var_294_5.transform.localPosition - var_294_3).z
					local var_294_8 = manager.ui.mainCameraCom_
					local var_294_9 = 2 * var_294_7 * Mathf.Tan(var_294_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_294_10 = var_294_9 * var_294_8.aspect
					local var_294_11 = var_294_6.sprite.bounds.size.x
					local var_294_12 = var_294_6.sprite.bounds.size.y
					local var_294_13 = var_294_10 / var_294_11
					local var_294_14 = var_294_9 / var_294_12
					local var_294_15 = var_294_14 < var_294_13 and var_294_13 or var_294_14

					var_294_5.transform.localScale = Vector3.New(var_294_15, var_294_15, 0)
				end

				for iter_294_0, iter_294_1 in pairs(arg_291_1.bgs_) do
					if iter_294_0 ~= "ST12" then
						iter_294_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_294_16 = 0

			if var_294_16 < arg_291_1.time_ and arg_291_1.time_ <= var_294_16 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_17 = 2

			if var_294_16 <= arg_291_1.time_ and arg_291_1.time_ < var_294_16 + var_294_17 then
				local var_294_18 = (arg_291_1.time_ - var_294_16) / var_294_17
				local var_294_19 = Color.New(0, 0, 0)

				var_294_19.a = Mathf.Lerp(0, 1, var_294_18)
				arg_291_1.mask_.color = var_294_19
			end

			if arg_291_1.time_ >= var_294_16 + var_294_17 and arg_291_1.time_ < var_294_16 + var_294_17 + arg_294_0 then
				local var_294_20 = Color.New(0, 0, 0)

				var_294_20.a = 1
				arg_291_1.mask_.color = var_294_20
			end

			local var_294_21 = 2

			if var_294_21 < arg_291_1.time_ and arg_291_1.time_ <= var_294_21 + arg_294_0 then
				arg_291_1.mask_.enabled = true
				arg_291_1.mask_.raycastTarget = true

				arg_291_1:SetGaussion(false)
			end

			local var_294_22 = 2

			if var_294_21 <= arg_291_1.time_ and arg_291_1.time_ < var_294_21 + var_294_22 then
				local var_294_23 = (arg_291_1.time_ - var_294_21) / var_294_22
				local var_294_24 = Color.New(0, 0, 0)

				var_294_24.a = Mathf.Lerp(1, 0, var_294_23)
				arg_291_1.mask_.color = var_294_24
			end

			if arg_291_1.time_ >= var_294_21 + var_294_22 and arg_291_1.time_ < var_294_21 + var_294_22 + arg_294_0 then
				local var_294_25 = Color.New(0, 0, 0)
				local var_294_26 = 0

				arg_291_1.mask_.enabled = false
				var_294_25.a = var_294_26
				arg_291_1.mask_.color = var_294_25
			end

			local var_294_27 = arg_291_1.actors_["1039ui_story"].transform
			local var_294_28 = 1.966

			if var_294_28 < arg_291_1.time_ and arg_291_1.time_ <= var_294_28 + arg_294_0 then
				arg_291_1.var_.moveOldPos1039ui_story = var_294_27.localPosition
			end

			local var_294_29 = 0.001

			if var_294_28 <= arg_291_1.time_ and arg_291_1.time_ < var_294_28 + var_294_29 then
				local var_294_30 = (arg_291_1.time_ - var_294_28) / var_294_29
				local var_294_31 = Vector3.New(0, 100, 0)

				var_294_27.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1039ui_story, var_294_31, var_294_30)

				local var_294_32 = manager.ui.mainCamera.transform.position - var_294_27.position

				var_294_27.forward = Vector3.New(var_294_32.x, var_294_32.y, var_294_32.z)

				local var_294_33 = var_294_27.localEulerAngles

				var_294_33.z = 0
				var_294_33.x = 0
				var_294_27.localEulerAngles = var_294_33
			end

			if arg_291_1.time_ >= var_294_28 + var_294_29 and arg_291_1.time_ < var_294_28 + var_294_29 + arg_294_0 then
				var_294_27.localPosition = Vector3.New(0, 100, 0)

				local var_294_34 = manager.ui.mainCamera.transform.position - var_294_27.position

				var_294_27.forward = Vector3.New(var_294_34.x, var_294_34.y, var_294_34.z)

				local var_294_35 = var_294_27.localEulerAngles

				var_294_35.z = 0
				var_294_35.x = 0
				var_294_27.localEulerAngles = var_294_35
			end

			if arg_291_1.frameCnt_ <= 1 then
				arg_291_1.dialog_:SetActive(false)
			end

			local var_294_36 = 4
			local var_294_37 = 0.8

			if var_294_36 < arg_291_1.time_ and arg_291_1.time_ <= var_294_36 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0

				arg_291_1.dialog_:SetActive(true)

				arg_291_1.dialogCg_.alpha = 0

				local var_294_38 = LeanTween.value(arg_291_1.dialog_, 0, 1, 0.3)

				var_294_38:setOnUpdate(LuaHelper.FloatAction(function(arg_295_0)
					arg_291_1.dialogCg_.alpha = arg_295_0
				end))
				var_294_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_291_1.dialog_)
					var_294_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_291_1.duration_ = arg_291_1.duration_ + 0.3

				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_39 = arg_291_1:GetWordFromCfg(910201071)
				local var_294_40 = arg_291_1:FormatText(var_294_39.content)

				arg_291_1.text_.text = var_294_40

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_41 = 32
				local var_294_42 = utf8.len(var_294_40)
				local var_294_43 = var_294_41 <= 0 and var_294_37 or var_294_37 * (var_294_42 / var_294_41)

				if var_294_43 > 0 and var_294_37 < var_294_43 then
					arg_291_1.talkMaxDuration = var_294_43
					var_294_36 = var_294_36 + 0.3

					if var_294_43 + var_294_36 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_43 + var_294_36
					end
				end

				arg_291_1.text_.text = var_294_40
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_44 = var_294_36 + 0.3
			local var_294_45 = math.max(var_294_37, arg_291_1.talkMaxDuration)

			if var_294_44 <= arg_291_1.time_ and arg_291_1.time_ < var_294_44 + var_294_45 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_44) / var_294_45

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_44 + var_294_45 and arg_291_1.time_ < var_294_44 + var_294_45 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play910201072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 910201072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play910201073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 0.625

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[7].name)

				arg_297_1.leftNameTxt_.text = var_300_2

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

				local var_300_3 = arg_297_1:GetWordFromCfg(910201072)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 25
				local var_300_6 = utf8.len(var_300_4)
				local var_300_7 = var_300_5 <= 0 and var_300_1 or var_300_1 * (var_300_6 / var_300_5)

				if var_300_7 > 0 and var_300_1 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_8 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_8 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_8

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_8 and arg_297_1.time_ < var_300_0 + var_300_8 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play910201073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 910201073
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play910201074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.2

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[35].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1013")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_3 = arg_301_1:GetWordFromCfg(910201073)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 8
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
	Play910201074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 910201074
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play910201075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.4

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_2 = arg_305_1:GetWordFromCfg(910201074)
				local var_308_3 = arg_305_1:FormatText(var_308_2.content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 16
				local var_308_5 = utf8.len(var_308_3)
				local var_308_6 = var_308_4 <= 0 and var_308_1 or var_308_1 * (var_308_5 / var_308_4)

				if var_308_6 > 0 and var_308_1 < var_308_6 then
					arg_305_1.talkMaxDuration = var_308_6

					if var_308_6 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_6 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_7 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_7 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_7

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_7 and arg_305_1.time_ < var_308_0 + var_308_7 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play910201075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 910201075
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play910201076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.275

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[7].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(910201075)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 11
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_8 and arg_309_1.time_ < var_312_0 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play910201076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 910201076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play910201077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = "1013ui_story"

			if arg_313_1.actors_[var_316_0] == nil then
				local var_316_1 = Asset.Load("Char/" .. "1013ui_story")

				if not isNil(var_316_1) then
					local var_316_2 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_313_1.stage_.transform)

					var_316_2.name = var_316_0
					var_316_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_313_1.actors_[var_316_0] = var_316_2

					local var_316_3 = var_316_2:GetComponentInChildren(typeof(CharacterEffect))

					var_316_3.enabled = true

					local var_316_4 = GameObjectTools.GetOrAddComponent(var_316_2, typeof(DynamicBoneHelper))

					if var_316_4 then
						var_316_4:EnableDynamicBone(false)
					end

					arg_313_1:ShowWeapon(var_316_3.transform, false)

					arg_313_1.var_[var_316_0 .. "Animator"] = var_316_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_313_1.var_[var_316_0 .. "Animator"].applyRootMotion = true
					arg_313_1.var_[var_316_0 .. "LipSync"] = var_316_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_316_5 = arg_313_1.actors_["1013ui_story"].transform
			local var_316_6 = 0

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.var_.moveOldPos1013ui_story = var_316_5.localPosition
			end

			local var_316_7 = 0.001

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_7 then
				local var_316_8 = (arg_313_1.time_ - var_316_6) / var_316_7
				local var_316_9 = Vector3.New(0, -0.66, -6.15)

				var_316_5.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1013ui_story, var_316_9, var_316_8)

				local var_316_10 = manager.ui.mainCamera.transform.position - var_316_5.position

				var_316_5.forward = Vector3.New(var_316_10.x, var_316_10.y, var_316_10.z)

				local var_316_11 = var_316_5.localEulerAngles

				var_316_11.z = 0
				var_316_11.x = 0
				var_316_5.localEulerAngles = var_316_11
			end

			if arg_313_1.time_ >= var_316_6 + var_316_7 and arg_313_1.time_ < var_316_6 + var_316_7 + arg_316_0 then
				var_316_5.localPosition = Vector3.New(0, -0.66, -6.15)

				local var_316_12 = manager.ui.mainCamera.transform.position - var_316_5.position

				var_316_5.forward = Vector3.New(var_316_12.x, var_316_12.y, var_316_12.z)

				local var_316_13 = var_316_5.localEulerAngles

				var_316_13.z = 0
				var_316_13.x = 0
				var_316_5.localEulerAngles = var_316_13
			end

			local var_316_14 = 0

			if var_316_14 < arg_313_1.time_ and arg_313_1.time_ <= var_316_14 + arg_316_0 then
				arg_313_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action11_1")
			end

			local var_316_15 = 0

			if var_316_15 < arg_313_1.time_ and arg_313_1.time_ <= var_316_15 + arg_316_0 then
				arg_313_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_316_16 = arg_313_1.actors_["1013ui_story"]
			local var_316_17 = 0

			if var_316_17 < arg_313_1.time_ and arg_313_1.time_ <= var_316_17 + arg_316_0 and not isNil(var_316_16) and arg_313_1.var_.characterEffect1013ui_story == nil then
				arg_313_1.var_.characterEffect1013ui_story = var_316_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_18 = 0.2

			if var_316_17 <= arg_313_1.time_ and arg_313_1.time_ < var_316_17 + var_316_18 and not isNil(var_316_16) then
				local var_316_19 = (arg_313_1.time_ - var_316_17) / var_316_18

				if arg_313_1.var_.characterEffect1013ui_story and not isNil(var_316_16) then
					arg_313_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_17 + var_316_18 and arg_313_1.time_ < var_316_17 + var_316_18 + arg_316_0 and not isNil(var_316_16) and arg_313_1.var_.characterEffect1013ui_story then
				arg_313_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_316_20 = 0
			local var_316_21 = 0.3

			if var_316_20 < arg_313_1.time_ and arg_313_1.time_ <= var_316_20 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_22 = arg_313_1:FormatText(StoryNameCfg[35].name)

				arg_313_1.leftNameTxt_.text = var_316_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_23 = arg_313_1:GetWordFromCfg(910201076)
				local var_316_24 = arg_313_1:FormatText(var_316_23.content)

				arg_313_1.text_.text = var_316_24

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_25 = 12
				local var_316_26 = utf8.len(var_316_24)
				local var_316_27 = var_316_25 <= 0 and var_316_21 or var_316_21 * (var_316_26 / var_316_25)

				if var_316_27 > 0 and var_316_21 < var_316_27 then
					arg_313_1.talkMaxDuration = var_316_27

					if var_316_27 + var_316_20 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_27 + var_316_20
					end
				end

				arg_313_1.text_.text = var_316_24
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_28 = math.max(var_316_21, arg_313_1.talkMaxDuration)

			if var_316_20 <= arg_313_1.time_ and arg_313_1.time_ < var_316_20 + var_316_28 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_20) / var_316_28

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_20 + var_316_28 and arg_313_1.time_ < var_316_20 + var_316_28 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play910201077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 910201077
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play910201078(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1013ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1013ui_story == nil then
				arg_317_1.var_.characterEffect1013ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.2

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect1013ui_story and not isNil(var_320_0) then
					local var_320_4 = Mathf.Lerp(0, 0.5, var_320_3)

					arg_317_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_317_1.var_.characterEffect1013ui_story.fillRatio = var_320_4
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect1013ui_story then
				local var_320_5 = 0.5

				arg_317_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_317_1.var_.characterEffect1013ui_story.fillRatio = var_320_5
			end

			local var_320_6 = 0
			local var_320_7 = 0.1

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

				local var_320_9 = arg_317_1:GetWordFromCfg(910201077)
				local var_320_10 = arg_317_1:FormatText(var_320_9.content)

				arg_317_1.text_.text = var_320_10

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_11 = 4
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
	Play910201078 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 910201078
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play910201079(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1013ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1013ui_story == nil then
				arg_321_1.var_.characterEffect1013ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.2

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect1013ui_story and not isNil(var_324_0) then
					arg_321_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1013ui_story then
				arg_321_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_324_4 = 0

			if var_324_4 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action4112")
			end

			local var_324_5 = 0

			if var_324_5 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_324_6 = 0
			local var_324_7 = 0.85

			if var_324_6 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_8 = arg_321_1:FormatText(StoryNameCfg[35].name)

				arg_321_1.leftNameTxt_.text = var_324_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_9 = arg_321_1:GetWordFromCfg(910201078)
				local var_324_10 = arg_321_1:FormatText(var_324_9.content)

				arg_321_1.text_.text = var_324_10

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 34
				local var_324_12 = utf8.len(var_324_10)
				local var_324_13 = var_324_11 <= 0 and var_324_7 or var_324_7 * (var_324_12 / var_324_11)

				if var_324_13 > 0 and var_324_7 < var_324_13 then
					arg_321_1.talkMaxDuration = var_324_13

					if var_324_13 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_6
					end
				end

				arg_321_1.text_.text = var_324_10
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_14 = math.max(var_324_7, arg_321_1.talkMaxDuration)

			if var_324_6 <= arg_321_1.time_ and arg_321_1.time_ < var_324_6 + var_324_14 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_6) / var_324_14

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_6 + var_324_14 and arg_321_1.time_ < var_324_6 + var_324_14 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play910201079 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 910201079
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play910201080(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1013ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1013ui_story == nil then
				arg_325_1.var_.characterEffect1013ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.2

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect1013ui_story and not isNil(var_328_0) then
					local var_328_4 = Mathf.Lerp(0, 0.5, var_328_3)

					arg_325_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_325_1.var_.characterEffect1013ui_story.fillRatio = var_328_4
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect1013ui_story then
				local var_328_5 = 0.5

				arg_325_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_325_1.var_.characterEffect1013ui_story.fillRatio = var_328_5
			end

			local var_328_6 = 0
			local var_328_7 = 0.6

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

				local var_328_9 = arg_325_1:GetWordFromCfg(910201079)
				local var_328_10 = arg_325_1:FormatText(var_328_9.content)

				arg_325_1.text_.text = var_328_10

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_11 = 24
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
	Play910201080 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 910201080
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play910201081(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1013ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1013ui_story == nil then
				arg_329_1.var_.characterEffect1013ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.2

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect1013ui_story and not isNil(var_332_0) then
					arg_329_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1013ui_story then
				arg_329_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_332_4 = 0

			if var_332_4 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action425")
			end

			local var_332_5 = 0

			if var_332_5 < arg_329_1.time_ and arg_329_1.time_ <= var_332_5 + arg_332_0 then
				arg_329_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_332_6 = 0
			local var_332_7 = 0.6

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_8 = arg_329_1:FormatText(StoryNameCfg[35].name)

				arg_329_1.leftNameTxt_.text = var_332_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_9 = arg_329_1:GetWordFromCfg(910201080)
				local var_332_10 = arg_329_1:FormatText(var_332_9.content)

				arg_329_1.text_.text = var_332_10

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_11 = 24
				local var_332_12 = utf8.len(var_332_10)
				local var_332_13 = var_332_11 <= 0 and var_332_7 or var_332_7 * (var_332_12 / var_332_11)

				if var_332_13 > 0 and var_332_7 < var_332_13 then
					arg_329_1.talkMaxDuration = var_332_13

					if var_332_13 + var_332_6 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_13 + var_332_6
					end
				end

				arg_329_1.text_.text = var_332_10
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_14 = math.max(var_332_7, arg_329_1.talkMaxDuration)

			if var_332_6 <= arg_329_1.time_ and arg_329_1.time_ < var_332_6 + var_332_14 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_6) / var_332_14

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_6 + var_332_14 and arg_329_1.time_ < var_332_6 + var_332_14 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play910201081 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 910201081
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play910201082(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1013ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1013ui_story == nil then
				arg_333_1.var_.characterEffect1013ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.2

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect1013ui_story and not isNil(var_336_0) then
					local var_336_4 = Mathf.Lerp(0, 0.5, var_336_3)

					arg_333_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1013ui_story.fillRatio = var_336_4
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect1013ui_story then
				local var_336_5 = 0.5

				arg_333_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1013ui_story.fillRatio = var_336_5
			end

			local var_336_6 = 0
			local var_336_7 = 0.125

			if var_336_6 < arg_333_1.time_ and arg_333_1.time_ <= var_336_6 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_8 = arg_333_1:FormatText(StoryNameCfg[7].name)

				arg_333_1.leftNameTxt_.text = var_336_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_9 = arg_333_1:GetWordFromCfg(910201081)
				local var_336_10 = arg_333_1:FormatText(var_336_9.content)

				arg_333_1.text_.text = var_336_10

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_11 = 5
				local var_336_12 = utf8.len(var_336_10)
				local var_336_13 = var_336_11 <= 0 and var_336_7 or var_336_7 * (var_336_12 / var_336_11)

				if var_336_13 > 0 and var_336_7 < var_336_13 then
					arg_333_1.talkMaxDuration = var_336_13

					if var_336_13 + var_336_6 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_13 + var_336_6
					end
				end

				arg_333_1.text_.text = var_336_10
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_14 = math.max(var_336_7, arg_333_1.talkMaxDuration)

			if var_336_6 <= arg_333_1.time_ and arg_333_1.time_ < var_336_6 + var_336_14 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_6) / var_336_14

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_6 + var_336_14 and arg_333_1.time_ < var_336_6 + var_336_14 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play910201082 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 910201082
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play910201083(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 0.425

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_2 = arg_337_1:GetWordFromCfg(910201082)
				local var_340_3 = arg_337_1:FormatText(var_340_2.content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 17
				local var_340_5 = utf8.len(var_340_3)
				local var_340_6 = var_340_4 <= 0 and var_340_1 or var_340_1 * (var_340_5 / var_340_4)

				if var_340_6 > 0 and var_340_1 < var_340_6 then
					arg_337_1.talkMaxDuration = var_340_6

					if var_340_6 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_6 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_7 and arg_337_1.time_ < var_340_0 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play910201083 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 910201083
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play910201084(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0
			local var_344_1 = 0.475

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

				local var_344_3 = arg_341_1:GetWordFromCfg(910201083)
				local var_344_4 = arg_341_1:FormatText(var_344_3.content)

				arg_341_1.text_.text = var_344_4

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 19
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
	Play910201084 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 910201084
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play910201085(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["1013ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1013ui_story == nil then
				arg_345_1.var_.characterEffect1013ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.2

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect1013ui_story and not isNil(var_348_0) then
					arg_345_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect1013ui_story then
				arg_345_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_348_4 = 0

			if var_348_4 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action452")
			end

			local var_348_5 = 0

			if var_348_5 < arg_345_1.time_ and arg_345_1.time_ <= var_348_5 + arg_348_0 then
				arg_345_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_348_6 = 0
			local var_348_7 = 0.775

			if var_348_6 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_8 = arg_345_1:FormatText(StoryNameCfg[35].name)

				arg_345_1.leftNameTxt_.text = var_348_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_9 = arg_345_1:GetWordFromCfg(910201084)
				local var_348_10 = arg_345_1:FormatText(var_348_9.content)

				arg_345_1.text_.text = var_348_10

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 31
				local var_348_12 = utf8.len(var_348_10)
				local var_348_13 = var_348_11 <= 0 and var_348_7 or var_348_7 * (var_348_12 / var_348_11)

				if var_348_13 > 0 and var_348_7 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_10
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_14 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_14 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_14

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_14 and arg_345_1.time_ < var_348_6 + var_348_14 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play910201085 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 910201085
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play910201086(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1013ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1013ui_story == nil then
				arg_349_1.var_.characterEffect1013ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.2

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect1013ui_story and not isNil(var_352_0) then
					local var_352_4 = Mathf.Lerp(0, 0.5, var_352_3)

					arg_349_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_349_1.var_.characterEffect1013ui_story.fillRatio = var_352_4
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect1013ui_story then
				local var_352_5 = 0.5

				arg_349_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_349_1.var_.characterEffect1013ui_story.fillRatio = var_352_5
			end

			local var_352_6 = 0
			local var_352_7 = 0.225

			if var_352_6 < arg_349_1.time_ and arg_349_1.time_ <= var_352_6 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_8 = arg_349_1:FormatText(StoryNameCfg[7].name)

				arg_349_1.leftNameTxt_.text = var_352_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_9 = arg_349_1:GetWordFromCfg(910201085)
				local var_352_10 = arg_349_1:FormatText(var_352_9.content)

				arg_349_1.text_.text = var_352_10

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_11 = 9
				local var_352_12 = utf8.len(var_352_10)
				local var_352_13 = var_352_11 <= 0 and var_352_7 or var_352_7 * (var_352_12 / var_352_11)

				if var_352_13 > 0 and var_352_7 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_6 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_6
					end
				end

				arg_349_1.text_.text = var_352_10
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_14 = math.max(var_352_7, arg_349_1.talkMaxDuration)

			if var_352_6 <= arg_349_1.time_ and arg_349_1.time_ < var_352_6 + var_352_14 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_6) / var_352_14

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_6 + var_352_14 and arg_349_1.time_ < var_352_6 + var_352_14 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play910201086 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 910201086
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play910201087(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 0.075

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

				local var_356_2 = arg_353_1:GetWordFromCfg(910201086)
				local var_356_3 = arg_353_1:FormatText(var_356_2.content)

				arg_353_1.text_.text = var_356_3

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_4 = 3
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
	Play910201087 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 910201087
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play910201088(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1013ui_story"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1013ui_story == nil then
				arg_357_1.var_.characterEffect1013ui_story = var_360_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.2

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.characterEffect1013ui_story and not isNil(var_360_0) then
					arg_357_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.characterEffect1013ui_story then
				arg_357_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_360_4 = 0

			if var_360_4 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action425")
			end

			local var_360_5 = 0

			if var_360_5 < arg_357_1.time_ and arg_357_1.time_ <= var_360_5 + arg_360_0 then
				arg_357_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_360_6 = 0
			local var_360_7 = 0.35

			if var_360_6 < arg_357_1.time_ and arg_357_1.time_ <= var_360_6 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_8 = arg_357_1:FormatText(StoryNameCfg[35].name)

				arg_357_1.leftNameTxt_.text = var_360_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_9 = arg_357_1:GetWordFromCfg(910201087)
				local var_360_10 = arg_357_1:FormatText(var_360_9.content)

				arg_357_1.text_.text = var_360_10

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_11 = 14
				local var_360_12 = utf8.len(var_360_10)
				local var_360_13 = var_360_11 <= 0 and var_360_7 or var_360_7 * (var_360_12 / var_360_11)

				if var_360_13 > 0 and var_360_7 < var_360_13 then
					arg_357_1.talkMaxDuration = var_360_13

					if var_360_13 + var_360_6 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_13 + var_360_6
					end
				end

				arg_357_1.text_.text = var_360_10
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_14 = math.max(var_360_7, arg_357_1.talkMaxDuration)

			if var_360_6 <= arg_357_1.time_ and arg_357_1.time_ < var_360_6 + var_360_14 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_6) / var_360_14

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_6 + var_360_14 and arg_357_1.time_ < var_360_6 + var_360_14 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play910201088 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 910201088
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play910201089(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action454")
			end

			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_364_2 = 0
			local var_364_3 = 0.65

			if var_364_2 < arg_361_1.time_ and arg_361_1.time_ <= var_364_2 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_4 = arg_361_1:FormatText(StoryNameCfg[35].name)

				arg_361_1.leftNameTxt_.text = var_364_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_5 = arg_361_1:GetWordFromCfg(910201088)
				local var_364_6 = arg_361_1:FormatText(var_364_5.content)

				arg_361_1.text_.text = var_364_6

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_7 = 26
				local var_364_8 = utf8.len(var_364_6)
				local var_364_9 = var_364_7 <= 0 and var_364_3 or var_364_3 * (var_364_8 / var_364_7)

				if var_364_9 > 0 and var_364_3 < var_364_9 then
					arg_361_1.talkMaxDuration = var_364_9

					if var_364_9 + var_364_2 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_9 + var_364_2
					end
				end

				arg_361_1.text_.text = var_364_6
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_10 = math.max(var_364_3, arg_361_1.talkMaxDuration)

			if var_364_2 <= arg_361_1.time_ and arg_361_1.time_ < var_364_2 + var_364_10 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_2) / var_364_10

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_2 + var_364_10 and arg_361_1.time_ < var_364_2 + var_364_10 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play910201089 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 910201089
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play910201090(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1013ui_story"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1013ui_story == nil then
				arg_365_1.var_.characterEffect1013ui_story = var_368_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.2

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.characterEffect1013ui_story and not isNil(var_368_0) then
					local var_368_4 = Mathf.Lerp(0, 0.5, var_368_3)

					arg_365_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_365_1.var_.characterEffect1013ui_story.fillRatio = var_368_4
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect1013ui_story then
				local var_368_5 = 0.5

				arg_365_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_365_1.var_.characterEffect1013ui_story.fillRatio = var_368_5
			end

			local var_368_6 = 0
			local var_368_7 = 0.1

			if var_368_6 < arg_365_1.time_ and arg_365_1.time_ <= var_368_6 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_8 = arg_365_1:FormatText(StoryNameCfg[7].name)

				arg_365_1.leftNameTxt_.text = var_368_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_9 = arg_365_1:GetWordFromCfg(910201089)
				local var_368_10 = arg_365_1:FormatText(var_368_9.content)

				arg_365_1.text_.text = var_368_10

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_11 = 4
				local var_368_12 = utf8.len(var_368_10)
				local var_368_13 = var_368_11 <= 0 and var_368_7 or var_368_7 * (var_368_12 / var_368_11)

				if var_368_13 > 0 and var_368_7 < var_368_13 then
					arg_365_1.talkMaxDuration = var_368_13

					if var_368_13 + var_368_6 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_13 + var_368_6
					end
				end

				arg_365_1.text_.text = var_368_10
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_14 = math.max(var_368_7, arg_365_1.talkMaxDuration)

			if var_368_6 <= arg_365_1.time_ and arg_365_1.time_ < var_368_6 + var_368_14 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_6) / var_368_14

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_6 + var_368_14 and arg_365_1.time_ < var_368_6 + var_368_14 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play910201090 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 910201090
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play910201091(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1013ui_story"].transform
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.var_.moveOldPos1013ui_story = var_372_0.localPosition
			end

			local var_372_2 = 0.001

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2
				local var_372_4 = Vector3.New(0, 100, 0)

				var_372_0.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1013ui_story, var_372_4, var_372_3)

				local var_372_5 = manager.ui.mainCamera.transform.position - var_372_0.position

				var_372_0.forward = Vector3.New(var_372_5.x, var_372_5.y, var_372_5.z)

				local var_372_6 = var_372_0.localEulerAngles

				var_372_6.z = 0
				var_372_6.x = 0
				var_372_0.localEulerAngles = var_372_6
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 then
				var_372_0.localPosition = Vector3.New(0, 100, 0)

				local var_372_7 = manager.ui.mainCamera.transform.position - var_372_0.position

				var_372_0.forward = Vector3.New(var_372_7.x, var_372_7.y, var_372_7.z)

				local var_372_8 = var_372_0.localEulerAngles

				var_372_8.z = 0
				var_372_8.x = 0
				var_372_0.localEulerAngles = var_372_8
			end

			local var_372_9 = 0
			local var_372_10 = 0.825

			if var_372_9 < arg_369_1.time_ and arg_369_1.time_ <= var_372_9 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_11 = arg_369_1:GetWordFromCfg(910201090)
				local var_372_12 = arg_369_1:FormatText(var_372_11.content)

				arg_369_1.text_.text = var_372_12

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_13 = 33
				local var_372_14 = utf8.len(var_372_12)
				local var_372_15 = var_372_13 <= 0 and var_372_10 or var_372_10 * (var_372_14 / var_372_13)

				if var_372_15 > 0 and var_372_10 < var_372_15 then
					arg_369_1.talkMaxDuration = var_372_15

					if var_372_15 + var_372_9 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_15 + var_372_9
					end
				end

				arg_369_1.text_.text = var_372_12
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_16 = math.max(var_372_10, arg_369_1.talkMaxDuration)

			if var_372_9 <= arg_369_1.time_ and arg_369_1.time_ < var_372_9 + var_372_16 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_9) / var_372_16

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_9 + var_372_16 and arg_369_1.time_ < var_372_9 + var_372_16 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play910201091 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 910201091
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play910201092(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0
			local var_376_1 = 0.2

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_2 = arg_373_1:FormatText(StoryNameCfg[7].name)

				arg_373_1.leftNameTxt_.text = var_376_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_3 = arg_373_1:GetWordFromCfg(910201091)
				local var_376_4 = arg_373_1:FormatText(var_376_3.content)

				arg_373_1.text_.text = var_376_4

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_5 = 8
				local var_376_6 = utf8.len(var_376_4)
				local var_376_7 = var_376_5 <= 0 and var_376_1 or var_376_1 * (var_376_6 / var_376_5)

				if var_376_7 > 0 and var_376_1 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_0
					end
				end

				arg_373_1.text_.text = var_376_4
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_8 = math.max(var_376_1, arg_373_1.talkMaxDuration)

			if var_376_0 <= arg_373_1.time_ and arg_373_1.time_ < var_376_0 + var_376_8 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_0) / var_376_8

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_0 + var_376_8 and arg_373_1.time_ < var_376_0 + var_376_8 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play910201092 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 910201092
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play910201093(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0
			local var_380_1 = 0.475

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

				local var_380_3 = arg_377_1:GetWordFromCfg(910201092)
				local var_380_4 = arg_377_1:FormatText(var_380_3.content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_5 = 19
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
	Play910201093 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 910201093
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play910201094(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0
			local var_384_1 = 0.625

			if var_384_0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_2 = arg_381_1:GetWordFromCfg(910201093)
				local var_384_3 = arg_381_1:FormatText(var_384_2.content)

				arg_381_1.text_.text = var_384_3

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 25
				local var_384_5 = utf8.len(var_384_3)
				local var_384_6 = var_384_4 <= 0 and var_384_1 or var_384_1 * (var_384_5 / var_384_4)

				if var_384_6 > 0 and var_384_1 < var_384_6 then
					arg_381_1.talkMaxDuration = var_384_6

					if var_384_6 + var_384_0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_6 + var_384_0
					end
				end

				arg_381_1.text_.text = var_384_3
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_1, arg_381_1.talkMaxDuration)

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_0 + var_384_7 and arg_381_1.time_ < var_384_0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play910201094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 910201094
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play910201095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = "1080ui_story"

			if arg_385_1.actors_[var_388_0] == nil then
				local var_388_1 = Asset.Load("Char/" .. "1080ui_story")

				if not isNil(var_388_1) then
					local var_388_2 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_385_1.stage_.transform)

					var_388_2.name = var_388_0
					var_388_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_385_1.actors_[var_388_0] = var_388_2

					local var_388_3 = var_388_2:GetComponentInChildren(typeof(CharacterEffect))

					var_388_3.enabled = true

					local var_388_4 = GameObjectTools.GetOrAddComponent(var_388_2, typeof(DynamicBoneHelper))

					if var_388_4 then
						var_388_4:EnableDynamicBone(false)
					end

					arg_385_1:ShowWeapon(var_388_3.transform, false)

					arg_385_1.var_[var_388_0 .. "Animator"] = var_388_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_385_1.var_[var_388_0 .. "Animator"].applyRootMotion = true
					arg_385_1.var_[var_388_0 .. "LipSync"] = var_388_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_388_5 = arg_385_1.actors_["1080ui_story"].transform
			local var_388_6 = 0

			if var_388_6 < arg_385_1.time_ and arg_385_1.time_ <= var_388_6 + arg_388_0 then
				arg_385_1.var_.moveOldPos1080ui_story = var_388_5.localPosition
			end

			local var_388_7 = 0.001

			if var_388_6 <= arg_385_1.time_ and arg_385_1.time_ < var_388_6 + var_388_7 then
				local var_388_8 = (arg_385_1.time_ - var_388_6) / var_388_7
				local var_388_9 = Vector3.New(0, -1.01, -6.05)

				var_388_5.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1080ui_story, var_388_9, var_388_8)

				local var_388_10 = manager.ui.mainCamera.transform.position - var_388_5.position

				var_388_5.forward = Vector3.New(var_388_10.x, var_388_10.y, var_388_10.z)

				local var_388_11 = var_388_5.localEulerAngles

				var_388_11.z = 0
				var_388_11.x = 0
				var_388_5.localEulerAngles = var_388_11
			end

			if arg_385_1.time_ >= var_388_6 + var_388_7 and arg_385_1.time_ < var_388_6 + var_388_7 + arg_388_0 then
				var_388_5.localPosition = Vector3.New(0, -1.01, -6.05)

				local var_388_12 = manager.ui.mainCamera.transform.position - var_388_5.position

				var_388_5.forward = Vector3.New(var_388_12.x, var_388_12.y, var_388_12.z)

				local var_388_13 = var_388_5.localEulerAngles

				var_388_13.z = 0
				var_388_13.x = 0
				var_388_5.localEulerAngles = var_388_13
			end

			local var_388_14 = 0

			if var_388_14 < arg_385_1.time_ and arg_385_1.time_ <= var_388_14 + arg_388_0 then
				arg_385_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			local var_388_15 = 0

			if var_388_15 < arg_385_1.time_ and arg_385_1.time_ <= var_388_15 + arg_388_0 then
				arg_385_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_388_16 = arg_385_1.actors_["1080ui_story"]
			local var_388_17 = 0

			if var_388_17 < arg_385_1.time_ and arg_385_1.time_ <= var_388_17 + arg_388_0 and not isNil(var_388_16) and arg_385_1.var_.characterEffect1080ui_story == nil then
				arg_385_1.var_.characterEffect1080ui_story = var_388_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_18 = 0.2

			if var_388_17 <= arg_385_1.time_ and arg_385_1.time_ < var_388_17 + var_388_18 and not isNil(var_388_16) then
				local var_388_19 = (arg_385_1.time_ - var_388_17) / var_388_18

				if arg_385_1.var_.characterEffect1080ui_story and not isNil(var_388_16) then
					arg_385_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= var_388_17 + var_388_18 and arg_385_1.time_ < var_388_17 + var_388_18 + arg_388_0 and not isNil(var_388_16) and arg_385_1.var_.characterEffect1080ui_story then
				arg_385_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_388_20 = 0
			local var_388_21 = 0.125

			if var_388_20 < arg_385_1.time_ and arg_385_1.time_ <= var_388_20 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_22 = arg_385_1:FormatText(StoryNameCfg[55].name)

				arg_385_1.leftNameTxt_.text = var_388_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_23 = arg_385_1:GetWordFromCfg(910201094)
				local var_388_24 = arg_385_1:FormatText(var_388_23.content)

				arg_385_1.text_.text = var_388_24

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_25 = 5
				local var_388_26 = utf8.len(var_388_24)
				local var_388_27 = var_388_25 <= 0 and var_388_21 or var_388_21 * (var_388_26 / var_388_25)

				if var_388_27 > 0 and var_388_21 < var_388_27 then
					arg_385_1.talkMaxDuration = var_388_27

					if var_388_27 + var_388_20 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_27 + var_388_20
					end
				end

				arg_385_1.text_.text = var_388_24
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_28 = math.max(var_388_21, arg_385_1.talkMaxDuration)

			if var_388_20 <= arg_385_1.time_ and arg_385_1.time_ < var_388_20 + var_388_28 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_20) / var_388_28

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_20 + var_388_28 and arg_385_1.time_ < var_388_20 + var_388_28 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play910201095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 910201095
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play910201096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1080ui_story"]
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect1080ui_story == nil then
				arg_389_1.var_.characterEffect1080ui_story = var_392_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.2

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_2 and not isNil(var_392_0) then
				local var_392_3 = (arg_389_1.time_ - var_392_1) / var_392_2

				if arg_389_1.var_.characterEffect1080ui_story and not isNil(var_392_0) then
					local var_392_4 = Mathf.Lerp(0, 0.5, var_392_3)

					arg_389_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_389_1.var_.characterEffect1080ui_story.fillRatio = var_392_4
				end
			end

			if arg_389_1.time_ >= var_392_1 + var_392_2 and arg_389_1.time_ < var_392_1 + var_392_2 + arg_392_0 and not isNil(var_392_0) and arg_389_1.var_.characterEffect1080ui_story then
				local var_392_5 = 0.5

				arg_389_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_389_1.var_.characterEffect1080ui_story.fillRatio = var_392_5
			end

			local var_392_6 = 0
			local var_392_7 = 0.25

			if var_392_6 < arg_389_1.time_ and arg_389_1.time_ <= var_392_6 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_8 = arg_389_1:FormatText(StoryNameCfg[7].name)

				arg_389_1.leftNameTxt_.text = var_392_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_9 = arg_389_1:GetWordFromCfg(910201095)
				local var_392_10 = arg_389_1:FormatText(var_392_9.content)

				arg_389_1.text_.text = var_392_10

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_11 = 10
				local var_392_12 = utf8.len(var_392_10)
				local var_392_13 = var_392_11 <= 0 and var_392_7 or var_392_7 * (var_392_12 / var_392_11)

				if var_392_13 > 0 and var_392_7 < var_392_13 then
					arg_389_1.talkMaxDuration = var_392_13

					if var_392_13 + var_392_6 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_13 + var_392_6
					end
				end

				arg_389_1.text_.text = var_392_10
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_14 = math.max(var_392_7, arg_389_1.talkMaxDuration)

			if var_392_6 <= arg_389_1.time_ and arg_389_1.time_ < var_392_6 + var_392_14 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_6) / var_392_14

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_6 + var_392_14 and arg_389_1.time_ < var_392_6 + var_392_14 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play910201096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 910201096
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play910201097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1080ui_story"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1080ui_story == nil then
				arg_393_1.var_.characterEffect1080ui_story = var_396_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.2

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.characterEffect1080ui_story and not isNil(var_396_0) then
					arg_393_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect1080ui_story then
				arg_393_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_396_4 = 0

			if var_396_4 < arg_393_1.time_ and arg_393_1.time_ <= var_396_4 + arg_396_0 then
				arg_393_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action464")
			end

			local var_396_5 = 0

			if var_396_5 < arg_393_1.time_ and arg_393_1.time_ <= var_396_5 + arg_396_0 then
				arg_393_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_396_6 = 0
			local var_396_7 = 0.275

			if var_396_6 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_8 = arg_393_1:FormatText(StoryNameCfg[55].name)

				arg_393_1.leftNameTxt_.text = var_396_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_9 = arg_393_1:GetWordFromCfg(910201096)
				local var_396_10 = arg_393_1:FormatText(var_396_9.content)

				arg_393_1.text_.text = var_396_10

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_11 = 11
				local var_396_12 = utf8.len(var_396_10)
				local var_396_13 = var_396_11 <= 0 and var_396_7 or var_396_7 * (var_396_12 / var_396_11)

				if var_396_13 > 0 and var_396_7 < var_396_13 then
					arg_393_1.talkMaxDuration = var_396_13

					if var_396_13 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_13 + var_396_6
					end
				end

				arg_393_1.text_.text = var_396_10
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_14 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_14 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_14

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_14 and arg_393_1.time_ < var_396_6 + var_396_14 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play910201097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 910201097
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play910201098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1080ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1080ui_story == nil then
				arg_397_1.var_.characterEffect1080ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.2

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1080ui_story and not isNil(var_400_0) then
					local var_400_4 = Mathf.Lerp(0, 0.5, var_400_3)

					arg_397_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1080ui_story.fillRatio = var_400_4
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1080ui_story then
				local var_400_5 = 0.5

				arg_397_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1080ui_story.fillRatio = var_400_5
			end

			local var_400_6 = 0
			local var_400_7 = 0.3

			if var_400_6 < arg_397_1.time_ and arg_397_1.time_ <= var_400_6 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_8 = arg_397_1:FormatText(StoryNameCfg[7].name)

				arg_397_1.leftNameTxt_.text = var_400_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, true)
				arg_397_1.iconController_:SetSelectedState("hero")

				arg_397_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_397_1.callingController_:SetSelectedState("normal")

				arg_397_1.keyicon_.color = Color.New(1, 1, 1)
				arg_397_1.icon_.color = Color.New(1, 1, 1)

				local var_400_9 = arg_397_1:GetWordFromCfg(910201097)
				local var_400_10 = arg_397_1:FormatText(var_400_9.content)

				arg_397_1.text_.text = var_400_10

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_11 = 12
				local var_400_12 = utf8.len(var_400_10)
				local var_400_13 = var_400_11 <= 0 and var_400_7 or var_400_7 * (var_400_12 / var_400_11)

				if var_400_13 > 0 and var_400_7 < var_400_13 then
					arg_397_1.talkMaxDuration = var_400_13

					if var_400_13 + var_400_6 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_6
					end
				end

				arg_397_1.text_.text = var_400_10
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_14 = math.max(var_400_7, arg_397_1.talkMaxDuration)

			if var_400_6 <= arg_397_1.time_ and arg_397_1.time_ < var_400_6 + var_400_14 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_6) / var_400_14

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_6 + var_400_14 and arg_397_1.time_ < var_400_6 + var_400_14 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play910201098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 910201098
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play910201099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1080ui_story"]
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect1080ui_story == nil then
				arg_401_1.var_.characterEffect1080ui_story = var_404_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.2

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 and not isNil(var_404_0) then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2

				if arg_401_1.var_.characterEffect1080ui_story and not isNil(var_404_0) then
					arg_401_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 and not isNil(var_404_0) and arg_401_1.var_.characterEffect1080ui_story then
				arg_401_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_404_4 = 0

			if var_404_4 < arg_401_1.time_ and arg_401_1.time_ <= var_404_4 + arg_404_0 then
				arg_401_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action446")
			end

			local var_404_5 = 0

			if var_404_5 < arg_401_1.time_ and arg_401_1.time_ <= var_404_5 + arg_404_0 then
				arg_401_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_404_6 = 0
			local var_404_7 = 0.1

			if var_404_6 < arg_401_1.time_ and arg_401_1.time_ <= var_404_6 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_8 = arg_401_1:FormatText(StoryNameCfg[55].name)

				arg_401_1.leftNameTxt_.text = var_404_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_9 = arg_401_1:GetWordFromCfg(910201098)
				local var_404_10 = arg_401_1:FormatText(var_404_9.content)

				arg_401_1.text_.text = var_404_10

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_11 = 4
				local var_404_12 = utf8.len(var_404_10)
				local var_404_13 = var_404_11 <= 0 and var_404_7 or var_404_7 * (var_404_12 / var_404_11)

				if var_404_13 > 0 and var_404_7 < var_404_13 then
					arg_401_1.talkMaxDuration = var_404_13

					if var_404_13 + var_404_6 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_13 + var_404_6
					end
				end

				arg_401_1.text_.text = var_404_10
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_14 = math.max(var_404_7, arg_401_1.talkMaxDuration)

			if var_404_6 <= arg_401_1.time_ and arg_401_1.time_ < var_404_6 + var_404_14 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_6) / var_404_14

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_6 + var_404_14 and arg_401_1.time_ < var_404_6 + var_404_14 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play910201099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 910201099
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play910201100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1080ui_story"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1080ui_story == nil then
				arg_405_1.var_.characterEffect1080ui_story = var_408_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.2

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.characterEffect1080ui_story and not isNil(var_408_0) then
					local var_408_4 = Mathf.Lerp(0, 0.5, var_408_3)

					arg_405_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_405_1.var_.characterEffect1080ui_story.fillRatio = var_408_4
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1080ui_story then
				local var_408_5 = 0.5

				arg_405_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_405_1.var_.characterEffect1080ui_story.fillRatio = var_408_5
			end

			local var_408_6 = 0
			local var_408_7 = 0.45

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

				local var_408_9 = arg_405_1:GetWordFromCfg(910201099)
				local var_408_10 = arg_405_1:FormatText(var_408_9.content)

				arg_405_1.text_.text = var_408_10

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_11 = 18
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
	Play910201100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 910201100
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play910201101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["1080ui_story"]
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect1080ui_story == nil then
				arg_409_1.var_.characterEffect1080ui_story = var_412_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.2

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 and not isNil(var_412_0) then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2

				if arg_409_1.var_.characterEffect1080ui_story and not isNil(var_412_0) then
					arg_409_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect1080ui_story then
				arg_409_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_412_4 = 0

			if var_412_4 < arg_409_1.time_ and arg_409_1.time_ <= var_412_4 + arg_412_0 then
				arg_409_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action464")
			end

			local var_412_5 = 0

			if var_412_5 < arg_409_1.time_ and arg_409_1.time_ <= var_412_5 + arg_412_0 then
				arg_409_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_412_6 = 0
			local var_412_7 = 0.275

			if var_412_6 < arg_409_1.time_ and arg_409_1.time_ <= var_412_6 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_8 = arg_409_1:FormatText(StoryNameCfg[55].name)

				arg_409_1.leftNameTxt_.text = var_412_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_9 = arg_409_1:GetWordFromCfg(910201100)
				local var_412_10 = arg_409_1:FormatText(var_412_9.content)

				arg_409_1.text_.text = var_412_10

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_11 = 11
				local var_412_12 = utf8.len(var_412_10)
				local var_412_13 = var_412_11 <= 0 and var_412_7 or var_412_7 * (var_412_12 / var_412_11)

				if var_412_13 > 0 and var_412_7 < var_412_13 then
					arg_409_1.talkMaxDuration = var_412_13

					if var_412_13 + var_412_6 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_13 + var_412_6
					end
				end

				arg_409_1.text_.text = var_412_10
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_14 = math.max(var_412_7, arg_409_1.talkMaxDuration)

			if var_412_6 <= arg_409_1.time_ and arg_409_1.time_ < var_412_6 + var_412_14 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_6) / var_412_14

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_6 + var_412_14 and arg_409_1.time_ < var_412_6 + var_412_14 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play910201101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 910201101
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play910201102(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["1080ui_story"]
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1080ui_story == nil then
				arg_413_1.var_.characterEffect1080ui_story = var_416_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.2

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 and not isNil(var_416_0) then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2

				if arg_413_1.var_.characterEffect1080ui_story and not isNil(var_416_0) then
					local var_416_4 = Mathf.Lerp(0, 0.5, var_416_3)

					arg_413_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1080ui_story.fillRatio = var_416_4
				end
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 and not isNil(var_416_0) and arg_413_1.var_.characterEffect1080ui_story then
				local var_416_5 = 0.5

				arg_413_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1080ui_story.fillRatio = var_416_5
			end

			local var_416_6 = 0
			local var_416_7 = 0.075

			if var_416_6 < arg_413_1.time_ and arg_413_1.time_ <= var_416_6 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_8 = arg_413_1:FormatText(StoryNameCfg[7].name)

				arg_413_1.leftNameTxt_.text = var_416_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, true)
				arg_413_1.iconController_:SetSelectedState("hero")

				arg_413_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_413_1.callingController_:SetSelectedState("normal")

				arg_413_1.keyicon_.color = Color.New(1, 1, 1)
				arg_413_1.icon_.color = Color.New(1, 1, 1)

				local var_416_9 = arg_413_1:GetWordFromCfg(910201101)
				local var_416_10 = arg_413_1:FormatText(var_416_9.content)

				arg_413_1.text_.text = var_416_10

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_11 = 3
				local var_416_12 = utf8.len(var_416_10)
				local var_416_13 = var_416_11 <= 0 and var_416_7 or var_416_7 * (var_416_12 / var_416_11)

				if var_416_13 > 0 and var_416_7 < var_416_13 then
					arg_413_1.talkMaxDuration = var_416_13

					if var_416_13 + var_416_6 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_13 + var_416_6
					end
				end

				arg_413_1.text_.text = var_416_10
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_14 = math.max(var_416_7, arg_413_1.talkMaxDuration)

			if var_416_6 <= arg_413_1.time_ and arg_413_1.time_ < var_416_6 + var_416_14 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_6) / var_416_14

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_6 + var_416_14 and arg_413_1.time_ < var_416_6 + var_416_14 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play910201102 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 910201102
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play910201103(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			local var_420_0 = arg_417_1.actors_["1080ui_story"]
			local var_420_1 = 0

			if var_420_1 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1080ui_story == nil then
				arg_417_1.var_.characterEffect1080ui_story = var_420_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.2

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_2 and not isNil(var_420_0) then
				local var_420_3 = (arg_417_1.time_ - var_420_1) / var_420_2

				if arg_417_1.var_.characterEffect1080ui_story and not isNil(var_420_0) then
					arg_417_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= var_420_1 + var_420_2 and arg_417_1.time_ < var_420_1 + var_420_2 + arg_420_0 and not isNil(var_420_0) and arg_417_1.var_.characterEffect1080ui_story then
				arg_417_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_420_4 = 0

			if var_420_4 < arg_417_1.time_ and arg_417_1.time_ <= var_420_4 + arg_420_0 then
				arg_417_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_420_5 = 0
			local var_420_6 = 0.175

			if var_420_5 < arg_417_1.time_ and arg_417_1.time_ <= var_420_5 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				local var_420_7 = arg_417_1:FormatText(StoryNameCfg[55].name)

				arg_417_1.leftNameTxt_.text = var_420_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_8 = arg_417_1:GetWordFromCfg(910201102)
				local var_420_9 = arg_417_1:FormatText(var_420_8.content)

				arg_417_1.text_.text = var_420_9

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_10 = 7
				local var_420_11 = utf8.len(var_420_9)
				local var_420_12 = var_420_10 <= 0 and var_420_6 or var_420_6 * (var_420_11 / var_420_10)

				if var_420_12 > 0 and var_420_6 < var_420_12 then
					arg_417_1.talkMaxDuration = var_420_12

					if var_420_12 + var_420_5 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_12 + var_420_5
					end
				end

				arg_417_1.text_.text = var_420_9
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_13 = math.max(var_420_6, arg_417_1.talkMaxDuration)

			if var_420_5 <= arg_417_1.time_ and arg_417_1.time_ < var_420_5 + var_420_13 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_5) / var_420_13

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_5 + var_420_13 and arg_417_1.time_ < var_420_5 + var_420_13 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play910201103 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 910201103
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play910201104(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = arg_421_1.actors_["1080ui_story"]
			local var_424_1 = 0

			if var_424_1 < arg_421_1.time_ and arg_421_1.time_ <= var_424_1 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect1080ui_story == nil then
				arg_421_1.var_.characterEffect1080ui_story = var_424_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_2 = 0.2

			if var_424_1 <= arg_421_1.time_ and arg_421_1.time_ < var_424_1 + var_424_2 and not isNil(var_424_0) then
				local var_424_3 = (arg_421_1.time_ - var_424_1) / var_424_2

				if arg_421_1.var_.characterEffect1080ui_story and not isNil(var_424_0) then
					local var_424_4 = Mathf.Lerp(0, 0.5, var_424_3)

					arg_421_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_421_1.var_.characterEffect1080ui_story.fillRatio = var_424_4
				end
			end

			if arg_421_1.time_ >= var_424_1 + var_424_2 and arg_421_1.time_ < var_424_1 + var_424_2 + arg_424_0 and not isNil(var_424_0) and arg_421_1.var_.characterEffect1080ui_story then
				local var_424_5 = 0.5

				arg_421_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_421_1.var_.characterEffect1080ui_story.fillRatio = var_424_5
			end

			local var_424_6 = 0
			local var_424_7 = 0.375

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

				local var_424_9 = arg_421_1:GetWordFromCfg(910201103)
				local var_424_10 = arg_421_1:FormatText(var_424_9.content)

				arg_421_1.text_.text = var_424_10

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_11 = 15
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
	Play910201104 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 910201104
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play910201105(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = arg_425_1.actors_["1080ui_story"]
			local var_428_1 = 0

			if var_428_1 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1080ui_story == nil then
				arg_425_1.var_.characterEffect1080ui_story = var_428_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.2

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_2 and not isNil(var_428_0) then
				local var_428_3 = (arg_425_1.time_ - var_428_1) / var_428_2

				if arg_425_1.var_.characterEffect1080ui_story and not isNil(var_428_0) then
					arg_425_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= var_428_1 + var_428_2 and arg_425_1.time_ < var_428_1 + var_428_2 + arg_428_0 and not isNil(var_428_0) and arg_425_1.var_.characterEffect1080ui_story then
				arg_425_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_428_4 = 0

			if var_428_4 < arg_425_1.time_ and arg_425_1.time_ <= var_428_4 + arg_428_0 then
				arg_425_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action442")
			end

			local var_428_5 = 0

			if var_428_5 < arg_425_1.time_ and arg_425_1.time_ <= var_428_5 + arg_428_0 then
				arg_425_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_428_6 = 0
			local var_428_7 = 0.3

			if var_428_6 < arg_425_1.time_ and arg_425_1.time_ <= var_428_6 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				local var_428_8 = arg_425_1:FormatText(StoryNameCfg[55].name)

				arg_425_1.leftNameTxt_.text = var_428_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_9 = arg_425_1:GetWordFromCfg(910201104)
				local var_428_10 = arg_425_1:FormatText(var_428_9.content)

				arg_425_1.text_.text = var_428_10

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_11 = 12
				local var_428_12 = utf8.len(var_428_10)
				local var_428_13 = var_428_11 <= 0 and var_428_7 or var_428_7 * (var_428_12 / var_428_11)

				if var_428_13 > 0 and var_428_7 < var_428_13 then
					arg_425_1.talkMaxDuration = var_428_13

					if var_428_13 + var_428_6 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_13 + var_428_6
					end
				end

				arg_425_1.text_.text = var_428_10
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_14 = math.max(var_428_7, arg_425_1.talkMaxDuration)

			if var_428_6 <= arg_425_1.time_ and arg_425_1.time_ < var_428_6 + var_428_14 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_6) / var_428_14

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_6 + var_428_14 and arg_425_1.time_ < var_428_6 + var_428_14 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play910201105 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 910201105
		arg_429_1.duration_ = 5

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play910201106(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = arg_429_1.actors_["1080ui_story"]
			local var_432_1 = 0

			if var_432_1 < arg_429_1.time_ and arg_429_1.time_ <= var_432_1 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect1080ui_story == nil then
				arg_429_1.var_.characterEffect1080ui_story = var_432_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_2 = 0.2

			if var_432_1 <= arg_429_1.time_ and arg_429_1.time_ < var_432_1 + var_432_2 and not isNil(var_432_0) then
				local var_432_3 = (arg_429_1.time_ - var_432_1) / var_432_2

				if arg_429_1.var_.characterEffect1080ui_story and not isNil(var_432_0) then
					local var_432_4 = Mathf.Lerp(0, 0.5, var_432_3)

					arg_429_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1080ui_story.fillRatio = var_432_4
				end
			end

			if arg_429_1.time_ >= var_432_1 + var_432_2 and arg_429_1.time_ < var_432_1 + var_432_2 + arg_432_0 and not isNil(var_432_0) and arg_429_1.var_.characterEffect1080ui_story then
				local var_432_5 = 0.5

				arg_429_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1080ui_story.fillRatio = var_432_5
			end

			local var_432_6 = 0
			local var_432_7 = 0.675

			if var_432_6 < arg_429_1.time_ and arg_429_1.time_ <= var_432_6 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				local var_432_8 = arg_429_1:FormatText(StoryNameCfg[7].name)

				arg_429_1.leftNameTxt_.text = var_432_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, true)
				arg_429_1.iconController_:SetSelectedState("hero")

				arg_429_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_429_1.callingController_:SetSelectedState("normal")

				arg_429_1.keyicon_.color = Color.New(1, 1, 1)
				arg_429_1.icon_.color = Color.New(1, 1, 1)

				local var_432_9 = arg_429_1:GetWordFromCfg(910201105)
				local var_432_10 = arg_429_1:FormatText(var_432_9.content)

				arg_429_1.text_.text = var_432_10

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_11 = 27
				local var_432_12 = utf8.len(var_432_10)
				local var_432_13 = var_432_11 <= 0 and var_432_7 or var_432_7 * (var_432_12 / var_432_11)

				if var_432_13 > 0 and var_432_7 < var_432_13 then
					arg_429_1.talkMaxDuration = var_432_13

					if var_432_13 + var_432_6 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_13 + var_432_6
					end
				end

				arg_429_1.text_.text = var_432_10
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)
				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_14 = math.max(var_432_7, arg_429_1.talkMaxDuration)

			if var_432_6 <= arg_429_1.time_ and arg_429_1.time_ < var_432_6 + var_432_14 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_6) / var_432_14

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_6 + var_432_14 and arg_429_1.time_ < var_432_6 + var_432_14 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play910201106 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 910201106
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play910201107(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			local var_436_0 = arg_433_1.actors_["1080ui_story"]
			local var_436_1 = 0

			if var_436_1 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1080ui_story == nil then
				arg_433_1.var_.characterEffect1080ui_story = var_436_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.2

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_2 and not isNil(var_436_0) then
				local var_436_3 = (arg_433_1.time_ - var_436_1) / var_436_2

				if arg_433_1.var_.characterEffect1080ui_story and not isNil(var_436_0) then
					arg_433_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= var_436_1 + var_436_2 and arg_433_1.time_ < var_436_1 + var_436_2 + arg_436_0 and not isNil(var_436_0) and arg_433_1.var_.characterEffect1080ui_story then
				arg_433_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_436_4 = 0

			if var_436_4 < arg_433_1.time_ and arg_433_1.time_ <= var_436_4 + arg_436_0 then
				arg_433_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action424")
			end

			local var_436_5 = 0

			if var_436_5 < arg_433_1.time_ and arg_433_1.time_ <= var_436_5 + arg_436_0 then
				arg_433_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_436_6 = 0
			local var_436_7 = 0.125

			if var_436_6 < arg_433_1.time_ and arg_433_1.time_ <= var_436_6 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				local var_436_8 = arg_433_1:FormatText(StoryNameCfg[55].name)

				arg_433_1.leftNameTxt_.text = var_436_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_9 = arg_433_1:GetWordFromCfg(910201106)
				local var_436_10 = arg_433_1:FormatText(var_436_9.content)

				arg_433_1.text_.text = var_436_10

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_11 = 5
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
	Play910201107 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 910201107
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play910201108(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			local var_440_0 = arg_437_1.actors_["1080ui_story"]
			local var_440_1 = 0

			if var_440_1 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1080ui_story == nil then
				arg_437_1.var_.characterEffect1080ui_story = var_440_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.2

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_2 and not isNil(var_440_0) then
				local var_440_3 = (arg_437_1.time_ - var_440_1) / var_440_2

				if arg_437_1.var_.characterEffect1080ui_story and not isNil(var_440_0) then
					local var_440_4 = Mathf.Lerp(0, 0.5, var_440_3)

					arg_437_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1080ui_story.fillRatio = var_440_4
				end
			end

			if arg_437_1.time_ >= var_440_1 + var_440_2 and arg_437_1.time_ < var_440_1 + var_440_2 + arg_440_0 and not isNil(var_440_0) and arg_437_1.var_.characterEffect1080ui_story then
				local var_440_5 = 0.5

				arg_437_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1080ui_story.fillRatio = var_440_5
			end

			local var_440_6 = 0
			local var_440_7 = 0.425

			if var_440_6 < arg_437_1.time_ and arg_437_1.time_ <= var_440_6 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				local var_440_8 = arg_437_1:FormatText(StoryNameCfg[7].name)

				arg_437_1.leftNameTxt_.text = var_440_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_9 = arg_437_1:GetWordFromCfg(910201107)
				local var_440_10 = arg_437_1:FormatText(var_440_9.content)

				arg_437_1.text_.text = var_440_10

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_11 = 17
				local var_440_12 = utf8.len(var_440_10)
				local var_440_13 = var_440_11 <= 0 and var_440_7 or var_440_7 * (var_440_12 / var_440_11)

				if var_440_13 > 0 and var_440_7 < var_440_13 then
					arg_437_1.talkMaxDuration = var_440_13

					if var_440_13 + var_440_6 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_13 + var_440_6
					end
				end

				arg_437_1.text_.text = var_440_10
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_14 = math.max(var_440_7, arg_437_1.talkMaxDuration)

			if var_440_6 <= arg_437_1.time_ and arg_437_1.time_ < var_440_6 + var_440_14 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_6) / var_440_14

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_6 + var_440_14 and arg_437_1.time_ < var_440_6 + var_440_14 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play910201108 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 910201108
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play910201109(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = arg_441_1.actors_["1080ui_story"]
			local var_444_1 = 0

			if var_444_1 < arg_441_1.time_ and arg_441_1.time_ <= var_444_1 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1080ui_story == nil then
				arg_441_1.var_.characterEffect1080ui_story = var_444_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_2 = 0.2

			if var_444_1 <= arg_441_1.time_ and arg_441_1.time_ < var_444_1 + var_444_2 and not isNil(var_444_0) then
				local var_444_3 = (arg_441_1.time_ - var_444_1) / var_444_2

				if arg_441_1.var_.characterEffect1080ui_story and not isNil(var_444_0) then
					arg_441_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= var_444_1 + var_444_2 and arg_441_1.time_ < var_444_1 + var_444_2 + arg_444_0 and not isNil(var_444_0) and arg_441_1.var_.characterEffect1080ui_story then
				arg_441_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_444_4 = 0

			if var_444_4 < arg_441_1.time_ and arg_441_1.time_ <= var_444_4 + arg_444_0 then
				arg_441_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080actionlink/1080action446")
			end

			local var_444_5 = 0

			if var_444_5 < arg_441_1.time_ and arg_441_1.time_ <= var_444_5 + arg_444_0 then
				arg_441_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_444_6 = 0
			local var_444_7 = 0.4

			if var_444_6 < arg_441_1.time_ and arg_441_1.time_ <= var_444_6 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				local var_444_8 = arg_441_1:FormatText(StoryNameCfg[55].name)

				arg_441_1.leftNameTxt_.text = var_444_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_9 = arg_441_1:GetWordFromCfg(910201108)
				local var_444_10 = arg_441_1:FormatText(var_444_9.content)

				arg_441_1.text_.text = var_444_10

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_11 = 16
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
	Play910201109 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 910201109
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play910201110(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = arg_445_1.actors_["1080ui_story"]
			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 and not isNil(var_448_0) and arg_445_1.var_.characterEffect1080ui_story == nil then
				arg_445_1.var_.characterEffect1080ui_story = var_448_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_2 = 0.2

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_2 and not isNil(var_448_0) then
				local var_448_3 = (arg_445_1.time_ - var_448_1) / var_448_2

				if arg_445_1.var_.characterEffect1080ui_story and not isNil(var_448_0) then
					local var_448_4 = Mathf.Lerp(0, 0.5, var_448_3)

					arg_445_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1080ui_story.fillRatio = var_448_4
				end
			end

			if arg_445_1.time_ >= var_448_1 + var_448_2 and arg_445_1.time_ < var_448_1 + var_448_2 + arg_448_0 and not isNil(var_448_0) and arg_445_1.var_.characterEffect1080ui_story then
				local var_448_5 = 0.5

				arg_445_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1080ui_story.fillRatio = var_448_5
			end

			local var_448_6 = 0
			local var_448_7 = 0.8

			if var_448_6 < arg_445_1.time_ and arg_445_1.time_ <= var_448_6 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_8 = arg_445_1:GetWordFromCfg(910201109)
				local var_448_9 = arg_445_1:FormatText(var_448_8.content)

				arg_445_1.text_.text = var_448_9

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_10 = 32
				local var_448_11 = utf8.len(var_448_9)
				local var_448_12 = var_448_10 <= 0 and var_448_7 or var_448_7 * (var_448_11 / var_448_10)

				if var_448_12 > 0 and var_448_7 < var_448_12 then
					arg_445_1.talkMaxDuration = var_448_12

					if var_448_12 + var_448_6 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_12 + var_448_6
					end
				end

				arg_445_1.text_.text = var_448_9
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_13 = math.max(var_448_7, arg_445_1.talkMaxDuration)

			if var_448_6 <= arg_445_1.time_ and arg_445_1.time_ < var_448_6 + var_448_13 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_6) / var_448_13

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_6 + var_448_13 and arg_445_1.time_ < var_448_6 + var_448_13 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play910201110 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 910201110
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play910201111(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = arg_449_1.actors_["1080ui_story"].transform
			local var_452_1 = 0

			if var_452_1 < arg_449_1.time_ and arg_449_1.time_ <= var_452_1 + arg_452_0 then
				arg_449_1.var_.moveOldPos1080ui_story = var_452_0.localPosition
			end

			local var_452_2 = 0.001

			if var_452_1 <= arg_449_1.time_ and arg_449_1.time_ < var_452_1 + var_452_2 then
				local var_452_3 = (arg_449_1.time_ - var_452_1) / var_452_2
				local var_452_4 = Vector3.New(0, 100, 0)

				var_452_0.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1080ui_story, var_452_4, var_452_3)

				local var_452_5 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_5.x, var_452_5.y, var_452_5.z)

				local var_452_6 = var_452_0.localEulerAngles

				var_452_6.z = 0
				var_452_6.x = 0
				var_452_0.localEulerAngles = var_452_6
			end

			if arg_449_1.time_ >= var_452_1 + var_452_2 and arg_449_1.time_ < var_452_1 + var_452_2 + arg_452_0 then
				var_452_0.localPosition = Vector3.New(0, 100, 0)

				local var_452_7 = manager.ui.mainCamera.transform.position - var_452_0.position

				var_452_0.forward = Vector3.New(var_452_7.x, var_452_7.y, var_452_7.z)

				local var_452_8 = var_452_0.localEulerAngles

				var_452_8.z = 0
				var_452_8.x = 0
				var_452_0.localEulerAngles = var_452_8
			end

			local var_452_9 = 0
			local var_452_10 = 0.775

			if var_452_9 < arg_449_1.time_ and arg_449_1.time_ <= var_452_9 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_11 = arg_449_1:FormatText(StoryNameCfg[7].name)

				arg_449_1.leftNameTxt_.text = var_452_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_12 = arg_449_1:GetWordFromCfg(910201110)
				local var_452_13 = arg_449_1:FormatText(var_452_12.content)

				arg_449_1.text_.text = var_452_13

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_14 = 31
				local var_452_15 = utf8.len(var_452_13)
				local var_452_16 = var_452_14 <= 0 and var_452_10 or var_452_10 * (var_452_15 / var_452_14)

				if var_452_16 > 0 and var_452_10 < var_452_16 then
					arg_449_1.talkMaxDuration = var_452_16

					if var_452_16 + var_452_9 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_16 + var_452_9
					end
				end

				arg_449_1.text_.text = var_452_13
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_17 = math.max(var_452_10, arg_449_1.talkMaxDuration)

			if var_452_9 <= arg_449_1.time_ and arg_449_1.time_ < var_452_9 + var_452_17 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_9) / var_452_17

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_9 + var_452_17 and arg_449_1.time_ < var_452_9 + var_452_17 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play910201111 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 910201111
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play910201112(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0
			local var_456_1 = 0.275

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

				local var_456_2 = arg_453_1:GetWordFromCfg(910201111)
				local var_456_3 = arg_453_1:FormatText(var_456_2.content)

				arg_453_1.text_.text = var_456_3

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 11
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
	Play910201112 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 910201112
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play910201113(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0
			local var_460_1 = 0.5

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_2 = arg_457_1:GetWordFromCfg(910201112)
				local var_460_3 = arg_457_1:FormatText(var_460_2.content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 20
				local var_460_5 = utf8.len(var_460_3)
				local var_460_6 = var_460_4 <= 0 and var_460_1 or var_460_1 * (var_460_5 / var_460_4)

				if var_460_6 > 0 and var_460_1 < var_460_6 then
					arg_457_1.talkMaxDuration = var_460_6

					if var_460_6 + var_460_0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_6 + var_460_0
					end
				end

				arg_457_1.text_.text = var_460_3
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_1, arg_457_1.talkMaxDuration)

			if var_460_0 <= arg_457_1.time_ and arg_457_1.time_ < var_460_0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_0 + var_460_7 and arg_457_1.time_ < var_460_0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play910201113 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 910201113
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play910201114(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0
			local var_464_1 = 0.675

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_2 = arg_461_1:FormatText(StoryNameCfg[7].name)

				arg_461_1.leftNameTxt_.text = var_464_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:GetWordFromCfg(910201113)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 27
				local var_464_6 = utf8.len(var_464_4)
				local var_464_7 = var_464_5 <= 0 and var_464_1 or var_464_1 * (var_464_6 / var_464_5)

				if var_464_7 > 0 and var_464_1 < var_464_7 then
					arg_461_1.talkMaxDuration = var_464_7

					if var_464_7 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_4
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_8 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_8 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_8

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_8 and arg_461_1.time_ < var_464_0 + var_464_8 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play910201114 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 910201114
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play910201115(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = "1096ui_story"

			if arg_465_1.actors_[var_468_0] == nil then
				local var_468_1 = Asset.Load("Char/" .. "1096ui_story")

				if not isNil(var_468_1) then
					local var_468_2 = Object.Instantiate(Asset.Load("Char/" .. "1096ui_story"), arg_465_1.stage_.transform)

					var_468_2.name = var_468_0
					var_468_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_465_1.actors_[var_468_0] = var_468_2

					local var_468_3 = var_468_2:GetComponentInChildren(typeof(CharacterEffect))

					var_468_3.enabled = true

					local var_468_4 = GameObjectTools.GetOrAddComponent(var_468_2, typeof(DynamicBoneHelper))

					if var_468_4 then
						var_468_4:EnableDynamicBone(false)
					end

					arg_465_1:ShowWeapon(var_468_3.transform, false)

					arg_465_1.var_[var_468_0 .. "Animator"] = var_468_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_465_1.var_[var_468_0 .. "Animator"].applyRootMotion = true
					arg_465_1.var_[var_468_0 .. "LipSync"] = var_468_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_468_5 = arg_465_1.actors_["1096ui_story"].transform
			local var_468_6 = 0

			if var_468_6 < arg_465_1.time_ and arg_465_1.time_ <= var_468_6 + arg_468_0 then
				arg_465_1.var_.moveOldPos1096ui_story = var_468_5.localPosition
			end

			local var_468_7 = 0.001

			if var_468_6 <= arg_465_1.time_ and arg_465_1.time_ < var_468_6 + var_468_7 then
				local var_468_8 = (arg_465_1.time_ - var_468_6) / var_468_7
				local var_468_9 = Vector3.New(0, -1.13, -5.6)

				var_468_5.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1096ui_story, var_468_9, var_468_8)

				local var_468_10 = manager.ui.mainCamera.transform.position - var_468_5.position

				var_468_5.forward = Vector3.New(var_468_10.x, var_468_10.y, var_468_10.z)

				local var_468_11 = var_468_5.localEulerAngles

				var_468_11.z = 0
				var_468_11.x = 0
				var_468_5.localEulerAngles = var_468_11
			end

			if arg_465_1.time_ >= var_468_6 + var_468_7 and arg_465_1.time_ < var_468_6 + var_468_7 + arg_468_0 then
				var_468_5.localPosition = Vector3.New(0, -1.13, -5.6)

				local var_468_12 = manager.ui.mainCamera.transform.position - var_468_5.position

				var_468_5.forward = Vector3.New(var_468_12.x, var_468_12.y, var_468_12.z)

				local var_468_13 = var_468_5.localEulerAngles

				var_468_13.z = 0
				var_468_13.x = 0
				var_468_5.localEulerAngles = var_468_13
			end

			local var_468_14 = arg_465_1.actors_["1096ui_story"]
			local var_468_15 = 0

			if var_468_15 < arg_465_1.time_ and arg_465_1.time_ <= var_468_15 + arg_468_0 and not isNil(var_468_14) and arg_465_1.var_.characterEffect1096ui_story == nil then
				arg_465_1.var_.characterEffect1096ui_story = var_468_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_16 = 0.2

			if var_468_15 <= arg_465_1.time_ and arg_465_1.time_ < var_468_15 + var_468_16 and not isNil(var_468_14) then
				local var_468_17 = (arg_465_1.time_ - var_468_15) / var_468_16

				if arg_465_1.var_.characterEffect1096ui_story and not isNil(var_468_14) then
					arg_465_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= var_468_15 + var_468_16 and arg_465_1.time_ < var_468_15 + var_468_16 + arg_468_0 and not isNil(var_468_14) and arg_465_1.var_.characterEffect1096ui_story then
				arg_465_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_468_18 = 0

			if var_468_18 < arg_465_1.time_ and arg_465_1.time_ <= var_468_18 + arg_468_0 then
				arg_465_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action3_1")
			end

			local var_468_19 = 0

			if var_468_19 < arg_465_1.time_ and arg_465_1.time_ <= var_468_19 + arg_468_0 then
				arg_465_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_468_20 = 0
			local var_468_21 = 0.125

			if var_468_20 < arg_465_1.time_ and arg_465_1.time_ <= var_468_20 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_22 = arg_465_1:FormatText(StoryNameCfg[169].name)

				arg_465_1.leftNameTxt_.text = var_468_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_23 = arg_465_1:GetWordFromCfg(910201114)
				local var_468_24 = arg_465_1:FormatText(var_468_23.content)

				arg_465_1.text_.text = var_468_24

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_25 = 5
				local var_468_26 = utf8.len(var_468_24)
				local var_468_27 = var_468_25 <= 0 and var_468_21 or var_468_21 * (var_468_26 / var_468_25)

				if var_468_27 > 0 and var_468_21 < var_468_27 then
					arg_465_1.talkMaxDuration = var_468_27

					if var_468_27 + var_468_20 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_27 + var_468_20
					end
				end

				arg_465_1.text_.text = var_468_24
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_28 = math.max(var_468_21, arg_465_1.talkMaxDuration)

			if var_468_20 <= arg_465_1.time_ and arg_465_1.time_ < var_468_20 + var_468_28 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_20) / var_468_28

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_20 + var_468_28 and arg_465_1.time_ < var_468_20 + var_468_28 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play910201115 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 910201115
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play910201116(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = arg_469_1.actors_["1096ui_story"]
			local var_472_1 = 0

			if var_472_1 < arg_469_1.time_ and arg_469_1.time_ <= var_472_1 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect1096ui_story == nil then
				arg_469_1.var_.characterEffect1096ui_story = var_472_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.2

			if var_472_1 <= arg_469_1.time_ and arg_469_1.time_ < var_472_1 + var_472_2 and not isNil(var_472_0) then
				local var_472_3 = (arg_469_1.time_ - var_472_1) / var_472_2

				if arg_469_1.var_.characterEffect1096ui_story and not isNil(var_472_0) then
					local var_472_4 = Mathf.Lerp(0, 0.5, var_472_3)

					arg_469_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1096ui_story.fillRatio = var_472_4
				end
			end

			if arg_469_1.time_ >= var_472_1 + var_472_2 and arg_469_1.time_ < var_472_1 + var_472_2 + arg_472_0 and not isNil(var_472_0) and arg_469_1.var_.characterEffect1096ui_story then
				local var_472_5 = 0.5

				arg_469_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1096ui_story.fillRatio = var_472_5
			end

			local var_472_6 = 0
			local var_472_7 = 0.6

			if var_472_6 < arg_469_1.time_ and arg_469_1.time_ <= var_472_6 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				local var_472_8 = arg_469_1:FormatText(StoryNameCfg[7].name)

				arg_469_1.leftNameTxt_.text = var_472_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, true)
				arg_469_1.iconController_:SetSelectedState("hero")

				arg_469_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_469_1.callingController_:SetSelectedState("normal")

				arg_469_1.keyicon_.color = Color.New(1, 1, 1)
				arg_469_1.icon_.color = Color.New(1, 1, 1)

				local var_472_9 = arg_469_1:GetWordFromCfg(910201115)
				local var_472_10 = arg_469_1:FormatText(var_472_9.content)

				arg_469_1.text_.text = var_472_10

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_11 = 24
				local var_472_12 = utf8.len(var_472_10)
				local var_472_13 = var_472_11 <= 0 and var_472_7 or var_472_7 * (var_472_12 / var_472_11)

				if var_472_13 > 0 and var_472_7 < var_472_13 then
					arg_469_1.talkMaxDuration = var_472_13

					if var_472_13 + var_472_6 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_13 + var_472_6
					end
				end

				arg_469_1.text_.text = var_472_10
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_14 = math.max(var_472_7, arg_469_1.talkMaxDuration)

			if var_472_6 <= arg_469_1.time_ and arg_469_1.time_ < var_472_6 + var_472_14 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_6) / var_472_14

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_6 + var_472_14 and arg_469_1.time_ < var_472_6 + var_472_14 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play910201116 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 910201116
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play910201117(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = arg_473_1.actors_["1096ui_story"]
			local var_476_1 = 0

			if var_476_1 < arg_473_1.time_ and arg_473_1.time_ <= var_476_1 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect1096ui_story == nil then
				arg_473_1.var_.characterEffect1096ui_story = var_476_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.2

			if var_476_1 <= arg_473_1.time_ and arg_473_1.time_ < var_476_1 + var_476_2 and not isNil(var_476_0) then
				local var_476_3 = (arg_473_1.time_ - var_476_1) / var_476_2

				if arg_473_1.var_.characterEffect1096ui_story and not isNil(var_476_0) then
					arg_473_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= var_476_1 + var_476_2 and arg_473_1.time_ < var_476_1 + var_476_2 + arg_476_0 and not isNil(var_476_0) and arg_473_1.var_.characterEffect1096ui_story then
				arg_473_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_476_4 = 0

			if var_476_4 < arg_473_1.time_ and arg_473_1.time_ <= var_476_4 + arg_476_0 then
				arg_473_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action434")
			end

			local var_476_5 = 0

			if var_476_5 < arg_473_1.time_ and arg_473_1.time_ <= var_476_5 + arg_476_0 then
				arg_473_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_476_6 = 0
			local var_476_7 = 0.45

			if var_476_6 < arg_473_1.time_ and arg_473_1.time_ <= var_476_6 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				local var_476_8 = arg_473_1:FormatText(StoryNameCfg[169].name)

				arg_473_1.leftNameTxt_.text = var_476_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_9 = arg_473_1:GetWordFromCfg(910201116)
				local var_476_10 = arg_473_1:FormatText(var_476_9.content)

				arg_473_1.text_.text = var_476_10

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_11 = 18
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
	Play910201117 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 910201117
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play910201118(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = arg_477_1.actors_["1096ui_story"]
			local var_480_1 = 0

			if var_480_1 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect1096ui_story == nil then
				arg_477_1.var_.characterEffect1096ui_story = var_480_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.2

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_2 and not isNil(var_480_0) then
				local var_480_3 = (arg_477_1.time_ - var_480_1) / var_480_2

				if arg_477_1.var_.characterEffect1096ui_story and not isNil(var_480_0) then
					local var_480_4 = Mathf.Lerp(0, 0.5, var_480_3)

					arg_477_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1096ui_story.fillRatio = var_480_4
				end
			end

			if arg_477_1.time_ >= var_480_1 + var_480_2 and arg_477_1.time_ < var_480_1 + var_480_2 + arg_480_0 and not isNil(var_480_0) and arg_477_1.var_.characterEffect1096ui_story then
				local var_480_5 = 0.5

				arg_477_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1096ui_story.fillRatio = var_480_5
			end

			local var_480_6 = 0
			local var_480_7 = 0.425

			if var_480_6 < arg_477_1.time_ and arg_477_1.time_ <= var_480_6 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_8 = arg_477_1:FormatText(StoryNameCfg[7].name)

				arg_477_1.leftNameTxt_.text = var_480_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_9 = arg_477_1:GetWordFromCfg(910201117)
				local var_480_10 = arg_477_1:FormatText(var_480_9.content)

				arg_477_1.text_.text = var_480_10

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_11 = 17
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
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_14 = math.max(var_480_7, arg_477_1.talkMaxDuration)

			if var_480_6 <= arg_477_1.time_ and arg_477_1.time_ < var_480_6 + var_480_14 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_6) / var_480_14

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_6 + var_480_14 and arg_477_1.time_ < var_480_6 + var_480_14 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play910201118 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 910201118
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play910201119(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = arg_481_1.actors_["1096ui_story"]
			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect1096ui_story == nil then
				arg_481_1.var_.characterEffect1096ui_story = var_484_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.2

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_2 and not isNil(var_484_0) then
				local var_484_3 = (arg_481_1.time_ - var_484_1) / var_484_2

				if arg_481_1.var_.characterEffect1096ui_story and not isNil(var_484_0) then
					arg_481_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= var_484_1 + var_484_2 and arg_481_1.time_ < var_484_1 + var_484_2 + arg_484_0 and not isNil(var_484_0) and arg_481_1.var_.characterEffect1096ui_story then
				arg_481_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_484_4 = 0

			if var_484_4 < arg_481_1.time_ and arg_481_1.time_ <= var_484_4 + arg_484_0 then
				arg_481_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action445")
			end

			local var_484_5 = 0

			if var_484_5 < arg_481_1.time_ and arg_481_1.time_ <= var_484_5 + arg_484_0 then
				arg_481_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_484_6 = 0
			local var_484_7 = 0.8

			if var_484_6 < arg_481_1.time_ and arg_481_1.time_ <= var_484_6 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_8 = arg_481_1:FormatText(StoryNameCfg[169].name)

				arg_481_1.leftNameTxt_.text = var_484_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_9 = arg_481_1:GetWordFromCfg(910201118)
				local var_484_10 = arg_481_1:FormatText(var_484_9.content)

				arg_481_1.text_.text = var_484_10

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_11 = 32
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
	Play910201119 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 910201119
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play910201120(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 0

			if var_488_0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_0 + arg_488_0 then
				arg_485_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action453")
			end

			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_488_2 = 0
			local var_488_3 = 1.05

			if var_488_2 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				local var_488_4 = arg_485_1:FormatText(StoryNameCfg[169].name)

				arg_485_1.leftNameTxt_.text = var_488_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_5 = arg_485_1:GetWordFromCfg(910201119)
				local var_488_6 = arg_485_1:FormatText(var_488_5.content)

				arg_485_1.text_.text = var_488_6

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_7 = 42
				local var_488_8 = utf8.len(var_488_6)
				local var_488_9 = var_488_7 <= 0 and var_488_3 or var_488_3 * (var_488_8 / var_488_7)

				if var_488_9 > 0 and var_488_3 < var_488_9 then
					arg_485_1.talkMaxDuration = var_488_9

					if var_488_9 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_9 + var_488_2
					end
				end

				arg_485_1.text_.text = var_488_6
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_10 = math.max(var_488_3, arg_485_1.talkMaxDuration)

			if var_488_2 <= arg_485_1.time_ and arg_485_1.time_ < var_488_2 + var_488_10 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_2) / var_488_10

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_2 + var_488_10 and arg_485_1.time_ < var_488_2 + var_488_10 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play910201120 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 910201120
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play910201121(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = arg_489_1.actors_["1096ui_story"]
			local var_492_1 = 0

			if var_492_1 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect1096ui_story == nil then
				arg_489_1.var_.characterEffect1096ui_story = var_492_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_2 = 0.2

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_2 and not isNil(var_492_0) then
				local var_492_3 = (arg_489_1.time_ - var_492_1) / var_492_2

				if arg_489_1.var_.characterEffect1096ui_story and not isNil(var_492_0) then
					local var_492_4 = Mathf.Lerp(0, 0.5, var_492_3)

					arg_489_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_489_1.var_.characterEffect1096ui_story.fillRatio = var_492_4
				end
			end

			if arg_489_1.time_ >= var_492_1 + var_492_2 and arg_489_1.time_ < var_492_1 + var_492_2 + arg_492_0 and not isNil(var_492_0) and arg_489_1.var_.characterEffect1096ui_story then
				local var_492_5 = 0.5

				arg_489_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_489_1.var_.characterEffect1096ui_story.fillRatio = var_492_5
			end

			local var_492_6 = 0
			local var_492_7 = 0.425

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

				local var_492_9 = arg_489_1:GetWordFromCfg(910201120)
				local var_492_10 = arg_489_1:FormatText(var_492_9.content)

				arg_489_1.text_.text = var_492_10

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_11 = 17
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
	Play910201121 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 910201121
		arg_493_1.duration_ = 5

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play910201122(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			local var_496_0 = arg_493_1.actors_["1096ui_story"]
			local var_496_1 = 0

			if var_496_1 < arg_493_1.time_ and arg_493_1.time_ <= var_496_1 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect1096ui_story == nil then
				arg_493_1.var_.characterEffect1096ui_story = var_496_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.2

			if var_496_1 <= arg_493_1.time_ and arg_493_1.time_ < var_496_1 + var_496_2 and not isNil(var_496_0) then
				local var_496_3 = (arg_493_1.time_ - var_496_1) / var_496_2

				if arg_493_1.var_.characterEffect1096ui_story and not isNil(var_496_0) then
					arg_493_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= var_496_1 + var_496_2 and arg_493_1.time_ < var_496_1 + var_496_2 + arg_496_0 and not isNil(var_496_0) and arg_493_1.var_.characterEffect1096ui_story then
				arg_493_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_496_4 = 0

			if var_496_4 < arg_493_1.time_ and arg_493_1.time_ <= var_496_4 + arg_496_0 then
				arg_493_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action432")
			end

			local var_496_5 = 0

			if var_496_5 < arg_493_1.time_ and arg_493_1.time_ <= var_496_5 + arg_496_0 then
				arg_493_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_496_6 = 0
			local var_496_7 = 0.775

			if var_496_6 < arg_493_1.time_ and arg_493_1.time_ <= var_496_6 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				local var_496_8 = arg_493_1:FormatText(StoryNameCfg[169].name)

				arg_493_1.leftNameTxt_.text = var_496_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_9 = arg_493_1:GetWordFromCfg(910201121)
				local var_496_10 = arg_493_1:FormatText(var_496_9.content)

				arg_493_1.text_.text = var_496_10

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_11 = 31
				local var_496_12 = utf8.len(var_496_10)
				local var_496_13 = var_496_11 <= 0 and var_496_7 or var_496_7 * (var_496_12 / var_496_11)

				if var_496_13 > 0 and var_496_7 < var_496_13 then
					arg_493_1.talkMaxDuration = var_496_13

					if var_496_13 + var_496_6 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_13 + var_496_6
					end
				end

				arg_493_1.text_.text = var_496_10
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_14 = math.max(var_496_7, arg_493_1.talkMaxDuration)

			if var_496_6 <= arg_493_1.time_ and arg_493_1.time_ < var_496_6 + var_496_14 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_6) / var_496_14

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_6 + var_496_14 and arg_493_1.time_ < var_496_6 + var_496_14 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play910201122 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 910201122
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play910201123(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			local var_500_0 = 0

			if var_500_0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_0 + arg_500_0 then
				arg_497_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action423")
			end

			local var_500_1 = 0

			if var_500_1 < arg_497_1.time_ and arg_497_1.time_ <= var_500_1 + arg_500_0 then
				arg_497_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_500_2 = 0
			local var_500_3 = 0.575

			if var_500_2 < arg_497_1.time_ and arg_497_1.time_ <= var_500_2 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				local var_500_4 = arg_497_1:FormatText(StoryNameCfg[169].name)

				arg_497_1.leftNameTxt_.text = var_500_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_5 = arg_497_1:GetWordFromCfg(910201122)
				local var_500_6 = arg_497_1:FormatText(var_500_5.content)

				arg_497_1.text_.text = var_500_6

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_7 = 23
				local var_500_8 = utf8.len(var_500_6)
				local var_500_9 = var_500_7 <= 0 and var_500_3 or var_500_3 * (var_500_8 / var_500_7)

				if var_500_9 > 0 and var_500_3 < var_500_9 then
					arg_497_1.talkMaxDuration = var_500_9

					if var_500_9 + var_500_2 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_9 + var_500_2
					end
				end

				arg_497_1.text_.text = var_500_6
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_10 = math.max(var_500_3, arg_497_1.talkMaxDuration)

			if var_500_2 <= arg_497_1.time_ and arg_497_1.time_ < var_500_2 + var_500_10 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_2) / var_500_10

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_2 + var_500_10 and arg_497_1.time_ < var_500_2 + var_500_10 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play910201123 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 910201123
		arg_501_1.duration_ = 5

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play910201124(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = arg_501_1.actors_["1096ui_story"]
			local var_504_1 = 0

			if var_504_1 < arg_501_1.time_ and arg_501_1.time_ <= var_504_1 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.characterEffect1096ui_story == nil then
				arg_501_1.var_.characterEffect1096ui_story = var_504_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_2 = 0.2

			if var_504_1 <= arg_501_1.time_ and arg_501_1.time_ < var_504_1 + var_504_2 and not isNil(var_504_0) then
				local var_504_3 = (arg_501_1.time_ - var_504_1) / var_504_2

				if arg_501_1.var_.characterEffect1096ui_story and not isNil(var_504_0) then
					local var_504_4 = Mathf.Lerp(0, 0.5, var_504_3)

					arg_501_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_501_1.var_.characterEffect1096ui_story.fillRatio = var_504_4
				end
			end

			if arg_501_1.time_ >= var_504_1 + var_504_2 and arg_501_1.time_ < var_504_1 + var_504_2 + arg_504_0 and not isNil(var_504_0) and arg_501_1.var_.characterEffect1096ui_story then
				local var_504_5 = 0.5

				arg_501_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_501_1.var_.characterEffect1096ui_story.fillRatio = var_504_5
			end

			local var_504_6 = 0
			local var_504_7 = 0.575

			if var_504_6 < arg_501_1.time_ and arg_501_1.time_ <= var_504_6 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				local var_504_8 = arg_501_1:FormatText(StoryNameCfg[7].name)

				arg_501_1.leftNameTxt_.text = var_504_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, true)
				arg_501_1.iconController_:SetSelectedState("hero")

				arg_501_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_501_1.callingController_:SetSelectedState("normal")

				arg_501_1.keyicon_.color = Color.New(1, 1, 1)
				arg_501_1.icon_.color = Color.New(1, 1, 1)

				local var_504_9 = arg_501_1:GetWordFromCfg(910201123)
				local var_504_10 = arg_501_1:FormatText(var_504_9.content)

				arg_501_1.text_.text = var_504_10

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_11 = 23
				local var_504_12 = utf8.len(var_504_10)
				local var_504_13 = var_504_11 <= 0 and var_504_7 or var_504_7 * (var_504_12 / var_504_11)

				if var_504_13 > 0 and var_504_7 < var_504_13 then
					arg_501_1.talkMaxDuration = var_504_13

					if var_504_13 + var_504_6 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_13 + var_504_6
					end
				end

				arg_501_1.text_.text = var_504_10
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)
				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_14 = math.max(var_504_7, arg_501_1.talkMaxDuration)

			if var_504_6 <= arg_501_1.time_ and arg_501_1.time_ < var_504_6 + var_504_14 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_6) / var_504_14

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_6 + var_504_14 and arg_501_1.time_ < var_504_6 + var_504_14 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play910201124 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 910201124
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play910201125(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			local var_508_0 = arg_505_1.actors_["1096ui_story"]
			local var_508_1 = 0

			if var_508_1 < arg_505_1.time_ and arg_505_1.time_ <= var_508_1 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1096ui_story == nil then
				arg_505_1.var_.characterEffect1096ui_story = var_508_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_2 = 0.2

			if var_508_1 <= arg_505_1.time_ and arg_505_1.time_ < var_508_1 + var_508_2 and not isNil(var_508_0) then
				local var_508_3 = (arg_505_1.time_ - var_508_1) / var_508_2

				if arg_505_1.var_.characterEffect1096ui_story and not isNil(var_508_0) then
					arg_505_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= var_508_1 + var_508_2 and arg_505_1.time_ < var_508_1 + var_508_2 + arg_508_0 and not isNil(var_508_0) and arg_505_1.var_.characterEffect1096ui_story then
				arg_505_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_508_4 = 0

			if var_508_4 < arg_505_1.time_ and arg_505_1.time_ <= var_508_4 + arg_508_0 then
				arg_505_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action434")
			end

			local var_508_5 = 0

			if var_508_5 < arg_505_1.time_ and arg_505_1.time_ <= var_508_5 + arg_508_0 then
				arg_505_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_508_6 = 0
			local var_508_7 = 0.625

			if var_508_6 < arg_505_1.time_ and arg_505_1.time_ <= var_508_6 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				local var_508_8 = arg_505_1:FormatText(StoryNameCfg[169].name)

				arg_505_1.leftNameTxt_.text = var_508_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_9 = arg_505_1:GetWordFromCfg(910201124)
				local var_508_10 = arg_505_1:FormatText(var_508_9.content)

				arg_505_1.text_.text = var_508_10

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_11 = 25
				local var_508_12 = utf8.len(var_508_10)
				local var_508_13 = var_508_11 <= 0 and var_508_7 or var_508_7 * (var_508_12 / var_508_11)

				if var_508_13 > 0 and var_508_7 < var_508_13 then
					arg_505_1.talkMaxDuration = var_508_13

					if var_508_13 + var_508_6 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_13 + var_508_6
					end
				end

				arg_505_1.text_.text = var_508_10
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_14 = math.max(var_508_7, arg_505_1.talkMaxDuration)

			if var_508_6 <= arg_505_1.time_ and arg_505_1.time_ < var_508_6 + var_508_14 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_6) / var_508_14

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_6 + var_508_14 and arg_505_1.time_ < var_508_6 + var_508_14 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play910201125 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 910201125
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play910201126(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = arg_509_1.actors_["1096ui_story"]
			local var_512_1 = 0

			if var_512_1 < arg_509_1.time_ and arg_509_1.time_ <= var_512_1 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.characterEffect1096ui_story == nil then
				arg_509_1.var_.characterEffect1096ui_story = var_512_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_2 = 0.2

			if var_512_1 <= arg_509_1.time_ and arg_509_1.time_ < var_512_1 + var_512_2 and not isNil(var_512_0) then
				local var_512_3 = (arg_509_1.time_ - var_512_1) / var_512_2

				if arg_509_1.var_.characterEffect1096ui_story and not isNil(var_512_0) then
					local var_512_4 = Mathf.Lerp(0, 0.5, var_512_3)

					arg_509_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_509_1.var_.characterEffect1096ui_story.fillRatio = var_512_4
				end
			end

			if arg_509_1.time_ >= var_512_1 + var_512_2 and arg_509_1.time_ < var_512_1 + var_512_2 + arg_512_0 and not isNil(var_512_0) and arg_509_1.var_.characterEffect1096ui_story then
				local var_512_5 = 0.5

				arg_509_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_509_1.var_.characterEffect1096ui_story.fillRatio = var_512_5
			end

			local var_512_6 = 0
			local var_512_7 = 0.9

			if var_512_6 < arg_509_1.time_ and arg_509_1.time_ <= var_512_6 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_8 = arg_509_1:GetWordFromCfg(910201125)
				local var_512_9 = arg_509_1:FormatText(var_512_8.content)

				arg_509_1.text_.text = var_512_9

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_10 = 36
				local var_512_11 = utf8.len(var_512_9)
				local var_512_12 = var_512_10 <= 0 and var_512_7 or var_512_7 * (var_512_11 / var_512_10)

				if var_512_12 > 0 and var_512_7 < var_512_12 then
					arg_509_1.talkMaxDuration = var_512_12

					if var_512_12 + var_512_6 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_12 + var_512_6
					end
				end

				arg_509_1.text_.text = var_512_9
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_13 = math.max(var_512_7, arg_509_1.talkMaxDuration)

			if var_512_6 <= arg_509_1.time_ and arg_509_1.time_ < var_512_6 + var_512_13 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_6) / var_512_13

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_6 + var_512_13 and arg_509_1.time_ < var_512_6 + var_512_13 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play910201126 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 910201126
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play910201127(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0
			local var_516_1 = 0.75

			if var_516_0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				local var_516_2 = arg_513_1:FormatText(StoryNameCfg[7].name)

				arg_513_1.leftNameTxt_.text = var_516_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, true)
				arg_513_1.iconController_:SetSelectedState("hero")

				arg_513_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_513_1.callingController_:SetSelectedState("normal")

				arg_513_1.keyicon_.color = Color.New(1, 1, 1)
				arg_513_1.icon_.color = Color.New(1, 1, 1)

				local var_516_3 = arg_513_1:GetWordFromCfg(910201126)
				local var_516_4 = arg_513_1:FormatText(var_516_3.content)

				arg_513_1.text_.text = var_516_4

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_5 = 30
				local var_516_6 = utf8.len(var_516_4)
				local var_516_7 = var_516_5 <= 0 and var_516_1 or var_516_1 * (var_516_6 / var_516_5)

				if var_516_7 > 0 and var_516_1 < var_516_7 then
					arg_513_1.talkMaxDuration = var_516_7

					if var_516_7 + var_516_0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_7 + var_516_0
					end
				end

				arg_513_1.text_.text = var_516_4
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_8 = math.max(var_516_1, arg_513_1.talkMaxDuration)

			if var_516_0 <= arg_513_1.time_ and arg_513_1.time_ < var_516_0 + var_516_8 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_0) / var_516_8

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_0 + var_516_8 and arg_513_1.time_ < var_516_0 + var_516_8 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play910201127 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 910201127
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play910201128(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = arg_517_1.actors_["1096ui_story"]
			local var_520_1 = 0

			if var_520_1 < arg_517_1.time_ and arg_517_1.time_ <= var_520_1 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.characterEffect1096ui_story == nil then
				arg_517_1.var_.characterEffect1096ui_story = var_520_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_520_2 = 0.2

			if var_520_1 <= arg_517_1.time_ and arg_517_1.time_ < var_520_1 + var_520_2 and not isNil(var_520_0) then
				local var_520_3 = (arg_517_1.time_ - var_520_1) / var_520_2

				if arg_517_1.var_.characterEffect1096ui_story and not isNil(var_520_0) then
					arg_517_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_517_1.time_ >= var_520_1 + var_520_2 and arg_517_1.time_ < var_520_1 + var_520_2 + arg_520_0 and not isNil(var_520_0) and arg_517_1.var_.characterEffect1096ui_story then
				arg_517_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_520_4 = 0

			if var_520_4 < arg_517_1.time_ and arg_517_1.time_ <= var_520_4 + arg_520_0 then
				arg_517_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action443")
			end

			local var_520_5 = 0

			if var_520_5 < arg_517_1.time_ and arg_517_1.time_ <= var_520_5 + arg_520_0 then
				arg_517_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_520_6 = 0
			local var_520_7 = 0.225

			if var_520_6 < arg_517_1.time_ and arg_517_1.time_ <= var_520_6 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				local var_520_8 = arg_517_1:FormatText(StoryNameCfg[169].name)

				arg_517_1.leftNameTxt_.text = var_520_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_9 = arg_517_1:GetWordFromCfg(910201127)
				local var_520_10 = arg_517_1:FormatText(var_520_9.content)

				arg_517_1.text_.text = var_520_10

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_11 = 9
				local var_520_12 = utf8.len(var_520_10)
				local var_520_13 = var_520_11 <= 0 and var_520_7 or var_520_7 * (var_520_12 / var_520_11)

				if var_520_13 > 0 and var_520_7 < var_520_13 then
					arg_517_1.talkMaxDuration = var_520_13

					if var_520_13 + var_520_6 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_13 + var_520_6
					end
				end

				arg_517_1.text_.text = var_520_10
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_14 = math.max(var_520_7, arg_517_1.talkMaxDuration)

			if var_520_6 <= arg_517_1.time_ and arg_517_1.time_ < var_520_6 + var_520_14 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - var_520_6) / var_520_14

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= var_520_6 + var_520_14 and arg_517_1.time_ < var_520_6 + var_520_14 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play910201128 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 910201128
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play910201129(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = arg_521_1.actors_["1096ui_story"]
			local var_524_1 = 0

			if var_524_1 < arg_521_1.time_ and arg_521_1.time_ <= var_524_1 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect1096ui_story == nil then
				arg_521_1.var_.characterEffect1096ui_story = var_524_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_2 = 0.2

			if var_524_1 <= arg_521_1.time_ and arg_521_1.time_ < var_524_1 + var_524_2 and not isNil(var_524_0) then
				local var_524_3 = (arg_521_1.time_ - var_524_1) / var_524_2

				if arg_521_1.var_.characterEffect1096ui_story and not isNil(var_524_0) then
					local var_524_4 = Mathf.Lerp(0, 0.5, var_524_3)

					arg_521_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1096ui_story.fillRatio = var_524_4
				end
			end

			if arg_521_1.time_ >= var_524_1 + var_524_2 and arg_521_1.time_ < var_524_1 + var_524_2 + arg_524_0 and not isNil(var_524_0) and arg_521_1.var_.characterEffect1096ui_story then
				local var_524_5 = 0.5

				arg_521_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1096ui_story.fillRatio = var_524_5
			end

			local var_524_6 = 0
			local var_524_7 = 0.75

			if var_524_6 < arg_521_1.time_ and arg_521_1.time_ <= var_524_6 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				local var_524_8 = arg_521_1:FormatText(StoryNameCfg[7].name)

				arg_521_1.leftNameTxt_.text = var_524_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, true)
				arg_521_1.iconController_:SetSelectedState("hero")

				arg_521_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_521_1.callingController_:SetSelectedState("normal")

				arg_521_1.keyicon_.color = Color.New(1, 1, 1)
				arg_521_1.icon_.color = Color.New(1, 1, 1)

				local var_524_9 = arg_521_1:GetWordFromCfg(910201128)
				local var_524_10 = arg_521_1:FormatText(var_524_9.content)

				arg_521_1.text_.text = var_524_10

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_11 = 30
				local var_524_12 = utf8.len(var_524_10)
				local var_524_13 = var_524_11 <= 0 and var_524_7 or var_524_7 * (var_524_12 / var_524_11)

				if var_524_13 > 0 and var_524_7 < var_524_13 then
					arg_521_1.talkMaxDuration = var_524_13

					if var_524_13 + var_524_6 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_13 + var_524_6
					end
				end

				arg_521_1.text_.text = var_524_10
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_14 = math.max(var_524_7, arg_521_1.talkMaxDuration)

			if var_524_6 <= arg_521_1.time_ and arg_521_1.time_ < var_524_6 + var_524_14 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_6) / var_524_14

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_6 + var_524_14 and arg_521_1.time_ < var_524_6 + var_524_14 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play910201129 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 910201129
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play910201130(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = arg_525_1.actors_["1096ui_story"]
			local var_528_1 = 0

			if var_528_1 < arg_525_1.time_ and arg_525_1.time_ <= var_528_1 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect1096ui_story == nil then
				arg_525_1.var_.characterEffect1096ui_story = var_528_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_2 = 0.2

			if var_528_1 <= arg_525_1.time_ and arg_525_1.time_ < var_528_1 + var_528_2 and not isNil(var_528_0) then
				local var_528_3 = (arg_525_1.time_ - var_528_1) / var_528_2

				if arg_525_1.var_.characterEffect1096ui_story and not isNil(var_528_0) then
					arg_525_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= var_528_1 + var_528_2 and arg_525_1.time_ < var_528_1 + var_528_2 + arg_528_0 and not isNil(var_528_0) and arg_525_1.var_.characterEffect1096ui_story then
				arg_525_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_528_4 = 0

			if var_528_4 < arg_525_1.time_ and arg_525_1.time_ <= var_528_4 + arg_528_0 then
				arg_525_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action435")
			end

			local var_528_5 = 0

			if var_528_5 < arg_525_1.time_ and arg_525_1.time_ <= var_528_5 + arg_528_0 then
				arg_525_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_528_6 = 0
			local var_528_7 = 0.275

			if var_528_6 < arg_525_1.time_ and arg_525_1.time_ <= var_528_6 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				local var_528_8 = arg_525_1:FormatText(StoryNameCfg[169].name)

				arg_525_1.leftNameTxt_.text = var_528_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_9 = arg_525_1:GetWordFromCfg(910201129)
				local var_528_10 = arg_525_1:FormatText(var_528_9.content)

				arg_525_1.text_.text = var_528_10

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_11 = 11
				local var_528_12 = utf8.len(var_528_10)
				local var_528_13 = var_528_11 <= 0 and var_528_7 or var_528_7 * (var_528_12 / var_528_11)

				if var_528_13 > 0 and var_528_7 < var_528_13 then
					arg_525_1.talkMaxDuration = var_528_13

					if var_528_13 + var_528_6 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_13 + var_528_6
					end
				end

				arg_525_1.text_.text = var_528_10
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_14 = math.max(var_528_7, arg_525_1.talkMaxDuration)

			if var_528_6 <= arg_525_1.time_ and arg_525_1.time_ < var_528_6 + var_528_14 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_6) / var_528_14

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_6 + var_528_14 and arg_525_1.time_ < var_528_6 + var_528_14 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	Play910201130 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 910201130
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play910201131(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			local var_532_0 = arg_529_1.actors_["1096ui_story"]
			local var_532_1 = 0

			if var_532_1 < arg_529_1.time_ and arg_529_1.time_ <= var_532_1 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.characterEffect1096ui_story == nil then
				arg_529_1.var_.characterEffect1096ui_story = var_532_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_532_2 = 0.2

			if var_532_1 <= arg_529_1.time_ and arg_529_1.time_ < var_532_1 + var_532_2 and not isNil(var_532_0) then
				local var_532_3 = (arg_529_1.time_ - var_532_1) / var_532_2

				if arg_529_1.var_.characterEffect1096ui_story and not isNil(var_532_0) then
					local var_532_4 = Mathf.Lerp(0, 0.5, var_532_3)

					arg_529_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_529_1.var_.characterEffect1096ui_story.fillRatio = var_532_4
				end
			end

			if arg_529_1.time_ >= var_532_1 + var_532_2 and arg_529_1.time_ < var_532_1 + var_532_2 + arg_532_0 and not isNil(var_532_0) and arg_529_1.var_.characterEffect1096ui_story then
				local var_532_5 = 0.5

				arg_529_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_529_1.var_.characterEffect1096ui_story.fillRatio = var_532_5
			end

			local var_532_6 = 0
			local var_532_7 = 1.05

			if var_532_6 < arg_529_1.time_ and arg_529_1.time_ <= var_532_6 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, true)

				local var_532_8 = arg_529_1:FormatText(StoryNameCfg[7].name)

				arg_529_1.leftNameTxt_.text = var_532_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_529_1.leftNameTxt_.transform)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1.leftNameTxt_.text)
				SetActive(arg_529_1.iconTrs_.gameObject, true)
				arg_529_1.iconController_:SetSelectedState("hero")

				arg_529_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_529_1.callingController_:SetSelectedState("normal")

				arg_529_1.keyicon_.color = Color.New(1, 1, 1)
				arg_529_1.icon_.color = Color.New(1, 1, 1)

				local var_532_9 = arg_529_1:GetWordFromCfg(910201130)
				local var_532_10 = arg_529_1:FormatText(var_532_9.content)

				arg_529_1.text_.text = var_532_10

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_11 = 42
				local var_532_12 = utf8.len(var_532_10)
				local var_532_13 = var_532_11 <= 0 and var_532_7 or var_532_7 * (var_532_12 / var_532_11)

				if var_532_13 > 0 and var_532_7 < var_532_13 then
					arg_529_1.talkMaxDuration = var_532_13

					if var_532_13 + var_532_6 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_13 + var_532_6
					end
				end

				arg_529_1.text_.text = var_532_10
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_14 = math.max(var_532_7, arg_529_1.talkMaxDuration)

			if var_532_6 <= arg_529_1.time_ and arg_529_1.time_ < var_532_6 + var_532_14 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_6) / var_532_14

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_6 + var_532_14 and arg_529_1.time_ < var_532_6 + var_532_14 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {}

		arg_529_1:InitPlayNodeList()
	end,
	Play910201131 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 910201131
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play910201132(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = arg_533_1.actors_["1096ui_story"]
			local var_536_1 = 0

			if var_536_1 < arg_533_1.time_ and arg_533_1.time_ <= var_536_1 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.characterEffect1096ui_story == nil then
				arg_533_1.var_.characterEffect1096ui_story = var_536_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_536_2 = 0.2

			if var_536_1 <= arg_533_1.time_ and arg_533_1.time_ < var_536_1 + var_536_2 and not isNil(var_536_0) then
				local var_536_3 = (arg_533_1.time_ - var_536_1) / var_536_2

				if arg_533_1.var_.characterEffect1096ui_story and not isNil(var_536_0) then
					arg_533_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_533_1.time_ >= var_536_1 + var_536_2 and arg_533_1.time_ < var_536_1 + var_536_2 + arg_536_0 and not isNil(var_536_0) and arg_533_1.var_.characterEffect1096ui_story then
				arg_533_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_536_4 = 0

			if var_536_4 < arg_533_1.time_ and arg_533_1.time_ <= var_536_4 + arg_536_0 then
				arg_533_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action452")
			end

			local var_536_5 = 0

			if var_536_5 < arg_533_1.time_ and arg_533_1.time_ <= var_536_5 + arg_536_0 then
				arg_533_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_536_6 = 0
			local var_536_7 = 0.8

			if var_536_6 < arg_533_1.time_ and arg_533_1.time_ <= var_536_6 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, true)

				local var_536_8 = arg_533_1:FormatText(StoryNameCfg[169].name)

				arg_533_1.leftNameTxt_.text = var_536_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_533_1.leftNameTxt_.transform)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1.leftNameTxt_.text)
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_9 = arg_533_1:GetWordFromCfg(910201131)
				local var_536_10 = arg_533_1:FormatText(var_536_9.content)

				arg_533_1.text_.text = var_536_10

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_11 = 32
				local var_536_12 = utf8.len(var_536_10)
				local var_536_13 = var_536_11 <= 0 and var_536_7 or var_536_7 * (var_536_12 / var_536_11)

				if var_536_13 > 0 and var_536_7 < var_536_13 then
					arg_533_1.talkMaxDuration = var_536_13

					if var_536_13 + var_536_6 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_13 + var_536_6
					end
				end

				arg_533_1.text_.text = var_536_10
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_14 = math.max(var_536_7, arg_533_1.talkMaxDuration)

			if var_536_6 <= arg_533_1.time_ and arg_533_1.time_ < var_536_6 + var_536_14 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - var_536_6) / var_536_14

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= var_536_6 + var_536_14 and arg_533_1.time_ < var_536_6 + var_536_14 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play910201132 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 910201132
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play910201133(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0

			if var_540_0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_0 + arg_540_0 then
				arg_537_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action424")
			end

			local var_540_1 = 0

			if var_540_1 < arg_537_1.time_ and arg_537_1.time_ <= var_540_1 + arg_540_0 then
				arg_537_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_540_2 = 0
			local var_540_3 = 0.9

			if var_540_2 < arg_537_1.time_ and arg_537_1.time_ <= var_540_2 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				local var_540_4 = arg_537_1:FormatText(StoryNameCfg[169].name)

				arg_537_1.leftNameTxt_.text = var_540_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_5 = arg_537_1:GetWordFromCfg(910201132)
				local var_540_6 = arg_537_1:FormatText(var_540_5.content)

				arg_537_1.text_.text = var_540_6

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_7 = 36
				local var_540_8 = utf8.len(var_540_6)
				local var_540_9 = var_540_7 <= 0 and var_540_3 or var_540_3 * (var_540_8 / var_540_7)

				if var_540_9 > 0 and var_540_3 < var_540_9 then
					arg_537_1.talkMaxDuration = var_540_9

					if var_540_9 + var_540_2 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_9 + var_540_2
					end
				end

				arg_537_1.text_.text = var_540_6
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_10 = math.max(var_540_3, arg_537_1.talkMaxDuration)

			if var_540_2 <= arg_537_1.time_ and arg_537_1.time_ < var_540_2 + var_540_10 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_2) / var_540_10

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_2 + var_540_10 and arg_537_1.time_ < var_540_2 + var_540_10 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play910201133 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 910201133
		arg_541_1.duration_ = 5

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play910201134(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			local var_544_0 = arg_541_1.actors_["1096ui_story"]
			local var_544_1 = 0

			if var_544_1 < arg_541_1.time_ and arg_541_1.time_ <= var_544_1 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.characterEffect1096ui_story == nil then
				arg_541_1.var_.characterEffect1096ui_story = var_544_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_2 = 0.2

			if var_544_1 <= arg_541_1.time_ and arg_541_1.time_ < var_544_1 + var_544_2 and not isNil(var_544_0) then
				local var_544_3 = (arg_541_1.time_ - var_544_1) / var_544_2

				if arg_541_1.var_.characterEffect1096ui_story and not isNil(var_544_0) then
					local var_544_4 = Mathf.Lerp(0, 0.5, var_544_3)

					arg_541_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_541_1.var_.characterEffect1096ui_story.fillRatio = var_544_4
				end
			end

			if arg_541_1.time_ >= var_544_1 + var_544_2 and arg_541_1.time_ < var_544_1 + var_544_2 + arg_544_0 and not isNil(var_544_0) and arg_541_1.var_.characterEffect1096ui_story then
				local var_544_5 = 0.5

				arg_541_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_541_1.var_.characterEffect1096ui_story.fillRatio = var_544_5
			end

			local var_544_6 = 0
			local var_544_7 = 0.575

			if var_544_6 < arg_541_1.time_ and arg_541_1.time_ <= var_544_6 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				local var_544_8 = arg_541_1:FormatText(StoryNameCfg[7].name)

				arg_541_1.leftNameTxt_.text = var_544_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_541_1.callingController_:SetSelectedState("normal")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_9 = arg_541_1:GetWordFromCfg(910201133)
				local var_544_10 = arg_541_1:FormatText(var_544_9.content)

				arg_541_1.text_.text = var_544_10

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_11 = 23
				local var_544_12 = utf8.len(var_544_10)
				local var_544_13 = var_544_11 <= 0 and var_544_7 or var_544_7 * (var_544_12 / var_544_11)

				if var_544_13 > 0 and var_544_7 < var_544_13 then
					arg_541_1.talkMaxDuration = var_544_13

					if var_544_13 + var_544_6 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_13 + var_544_6
					end
				end

				arg_541_1.text_.text = var_544_10
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)
				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_14 = math.max(var_544_7, arg_541_1.talkMaxDuration)

			if var_544_6 <= arg_541_1.time_ and arg_541_1.time_ < var_544_6 + var_544_14 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_6) / var_544_14

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_6 + var_544_14 and arg_541_1.time_ < var_544_6 + var_544_14 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play910201134 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 910201134
		arg_545_1.duration_ = 5

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play910201135(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			local var_548_0 = 0
			local var_548_1 = 0.45

			if var_548_0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_0 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				local var_548_2 = arg_545_1:FormatText(StoryNameCfg[7].name)

				arg_545_1.leftNameTxt_.text = var_548_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, true)
				arg_545_1.iconController_:SetSelectedState("hero")

				arg_545_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_545_1.callingController_:SetSelectedState("normal")

				arg_545_1.keyicon_.color = Color.New(1, 1, 1)
				arg_545_1.icon_.color = Color.New(1, 1, 1)

				local var_548_3 = arg_545_1:GetWordFromCfg(910201134)
				local var_548_4 = arg_545_1:FormatText(var_548_3.content)

				arg_545_1.text_.text = var_548_4

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_5 = 18
				local var_548_6 = utf8.len(var_548_4)
				local var_548_7 = var_548_5 <= 0 and var_548_1 or var_548_1 * (var_548_6 / var_548_5)

				if var_548_7 > 0 and var_548_1 < var_548_7 then
					arg_545_1.talkMaxDuration = var_548_7

					if var_548_7 + var_548_0 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_7 + var_548_0
					end
				end

				arg_545_1.text_.text = var_548_4
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)
				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_8 = math.max(var_548_1, arg_545_1.talkMaxDuration)

			if var_548_0 <= arg_545_1.time_ and arg_545_1.time_ < var_548_0 + var_548_8 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_0) / var_548_8

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_0 + var_548_8 and arg_545_1.time_ < var_548_0 + var_548_8 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play910201135 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 910201135
		arg_549_1.duration_ = 5

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play910201136(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0

			if var_552_0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_0 + arg_552_0 then
				arg_549_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action445")
			end

			local var_552_1 = arg_549_1.actors_["1096ui_story"]
			local var_552_2 = 0

			if var_552_2 < arg_549_1.time_ and arg_549_1.time_ <= var_552_2 + arg_552_0 and not isNil(var_552_1) and arg_549_1.var_.characterEffect1096ui_story == nil then
				arg_549_1.var_.characterEffect1096ui_story = var_552_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_3 = 0.2

			if var_552_2 <= arg_549_1.time_ and arg_549_1.time_ < var_552_2 + var_552_3 and not isNil(var_552_1) then
				local var_552_4 = (arg_549_1.time_ - var_552_2) / var_552_3

				if arg_549_1.var_.characterEffect1096ui_story and not isNil(var_552_1) then
					arg_549_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_549_1.time_ >= var_552_2 + var_552_3 and arg_549_1.time_ < var_552_2 + var_552_3 + arg_552_0 and not isNil(var_552_1) and arg_549_1.var_.characterEffect1096ui_story then
				arg_549_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_552_5 = 0

			if var_552_5 < arg_549_1.time_ and arg_549_1.time_ <= var_552_5 + arg_552_0 then
				arg_549_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_552_6 = 0
			local var_552_7 = 0.4

			if var_552_6 < arg_549_1.time_ and arg_549_1.time_ <= var_552_6 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				local var_552_8 = arg_549_1:FormatText(StoryNameCfg[169].name)

				arg_549_1.leftNameTxt_.text = var_552_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_9 = arg_549_1:GetWordFromCfg(910201135)
				local var_552_10 = arg_549_1:FormatText(var_552_9.content)

				arg_549_1.text_.text = var_552_10

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_11 = 16
				local var_552_12 = utf8.len(var_552_10)
				local var_552_13 = var_552_11 <= 0 and var_552_7 or var_552_7 * (var_552_12 / var_552_11)

				if var_552_13 > 0 and var_552_7 < var_552_13 then
					arg_549_1.talkMaxDuration = var_552_13

					if var_552_13 + var_552_6 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_13 + var_552_6
					end
				end

				arg_549_1.text_.text = var_552_10
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)
				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_14 = math.max(var_552_7, arg_549_1.talkMaxDuration)

			if var_552_6 <= arg_549_1.time_ and arg_549_1.time_ < var_552_6 + var_552_14 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_6) / var_552_14

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_6 + var_552_14 and arg_549_1.time_ < var_552_6 + var_552_14 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play910201136 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 910201136
		arg_553_1.duration_ = 5

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play910201137(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			local var_556_0 = arg_553_1.actors_["1096ui_story"]
			local var_556_1 = 0

			if var_556_1 < arg_553_1.time_ and arg_553_1.time_ <= var_556_1 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1096ui_story == nil then
				arg_553_1.var_.characterEffect1096ui_story = var_556_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.2

			if var_556_1 <= arg_553_1.time_ and arg_553_1.time_ < var_556_1 + var_556_2 and not isNil(var_556_0) then
				local var_556_3 = (arg_553_1.time_ - var_556_1) / var_556_2

				if arg_553_1.var_.characterEffect1096ui_story and not isNil(var_556_0) then
					local var_556_4 = Mathf.Lerp(0, 0.5, var_556_3)

					arg_553_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1096ui_story.fillRatio = var_556_4
				end
			end

			if arg_553_1.time_ >= var_556_1 + var_556_2 and arg_553_1.time_ < var_556_1 + var_556_2 + arg_556_0 and not isNil(var_556_0) and arg_553_1.var_.characterEffect1096ui_story then
				local var_556_5 = 0.5

				arg_553_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1096ui_story.fillRatio = var_556_5
			end

			local var_556_6 = 0
			local var_556_7 = 0.55

			if var_556_6 < arg_553_1.time_ and arg_553_1.time_ <= var_556_6 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, false)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_8 = arg_553_1:GetWordFromCfg(910201136)
				local var_556_9 = arg_553_1:FormatText(var_556_8.content)

				arg_553_1.text_.text = var_556_9

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_10 = 22
				local var_556_11 = utf8.len(var_556_9)
				local var_556_12 = var_556_10 <= 0 and var_556_7 or var_556_7 * (var_556_11 / var_556_10)

				if var_556_12 > 0 and var_556_7 < var_556_12 then
					arg_553_1.talkMaxDuration = var_556_12

					if var_556_12 + var_556_6 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_12 + var_556_6
					end
				end

				arg_553_1.text_.text = var_556_9
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)
				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_13 = math.max(var_556_7, arg_553_1.talkMaxDuration)

			if var_556_6 <= arg_553_1.time_ and arg_553_1.time_ < var_556_6 + var_556_13 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_6) / var_556_13

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_6 + var_556_13 and arg_553_1.time_ < var_556_6 + var_556_13 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play910201137 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 910201137
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play910201138(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			local var_560_0 = arg_557_1.actors_["1096ui_story"]
			local var_560_1 = 0

			if var_560_1 < arg_557_1.time_ and arg_557_1.time_ <= var_560_1 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect1096ui_story == nil then
				arg_557_1.var_.characterEffect1096ui_story = var_560_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_560_2 = 0.2

			if var_560_1 <= arg_557_1.time_ and arg_557_1.time_ < var_560_1 + var_560_2 and not isNil(var_560_0) then
				local var_560_3 = (arg_557_1.time_ - var_560_1) / var_560_2

				if arg_557_1.var_.characterEffect1096ui_story and not isNil(var_560_0) then
					arg_557_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_557_1.time_ >= var_560_1 + var_560_2 and arg_557_1.time_ < var_560_1 + var_560_2 + arg_560_0 and not isNil(var_560_0) and arg_557_1.var_.characterEffect1096ui_story then
				arg_557_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_560_4 = 0

			if var_560_4 < arg_557_1.time_ and arg_557_1.time_ <= var_560_4 + arg_560_0 then
				arg_557_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_560_5 = 0
			local var_560_6 = 0.8

			if var_560_5 < arg_557_1.time_ and arg_557_1.time_ <= var_560_5 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				local var_560_7 = arg_557_1:FormatText(StoryNameCfg[169].name)

				arg_557_1.leftNameTxt_.text = var_560_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_8 = arg_557_1:GetWordFromCfg(910201137)
				local var_560_9 = arg_557_1:FormatText(var_560_8.content)

				arg_557_1.text_.text = var_560_9

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_10 = 32
				local var_560_11 = utf8.len(var_560_9)
				local var_560_12 = var_560_10 <= 0 and var_560_6 or var_560_6 * (var_560_11 / var_560_10)

				if var_560_12 > 0 and var_560_6 < var_560_12 then
					arg_557_1.talkMaxDuration = var_560_12

					if var_560_12 + var_560_5 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_12 + var_560_5
					end
				end

				arg_557_1.text_.text = var_560_9
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_13 = math.max(var_560_6, arg_557_1.talkMaxDuration)

			if var_560_5 <= arg_557_1.time_ and arg_557_1.time_ < var_560_5 + var_560_13 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_5) / var_560_13

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_5 + var_560_13 and arg_557_1.time_ < var_560_5 + var_560_13 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play910201138 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 910201138
		arg_561_1.duration_ = 5

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play910201139(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			local var_564_0 = arg_561_1.actors_["1096ui_story"]
			local var_564_1 = 0

			if var_564_1 < arg_561_1.time_ and arg_561_1.time_ <= var_564_1 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.characterEffect1096ui_story == nil then
				arg_561_1.var_.characterEffect1096ui_story = var_564_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_2 = 0.2

			if var_564_1 <= arg_561_1.time_ and arg_561_1.time_ < var_564_1 + var_564_2 and not isNil(var_564_0) then
				local var_564_3 = (arg_561_1.time_ - var_564_1) / var_564_2

				if arg_561_1.var_.characterEffect1096ui_story and not isNil(var_564_0) then
					local var_564_4 = Mathf.Lerp(0, 0.5, var_564_3)

					arg_561_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_561_1.var_.characterEffect1096ui_story.fillRatio = var_564_4
				end
			end

			if arg_561_1.time_ >= var_564_1 + var_564_2 and arg_561_1.time_ < var_564_1 + var_564_2 + arg_564_0 and not isNil(var_564_0) and arg_561_1.var_.characterEffect1096ui_story then
				local var_564_5 = 0.5

				arg_561_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_561_1.var_.characterEffect1096ui_story.fillRatio = var_564_5
			end

			local var_564_6 = 0
			local var_564_7 = 0.5

			if var_564_6 < arg_561_1.time_ and arg_561_1.time_ <= var_564_6 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				local var_564_8 = arg_561_1:FormatText(StoryNameCfg[7].name)

				arg_561_1.leftNameTxt_.text = var_564_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, true)
				arg_561_1.iconController_:SetSelectedState("hero")

				arg_561_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_561_1.callingController_:SetSelectedState("normal")

				arg_561_1.keyicon_.color = Color.New(1, 1, 1)
				arg_561_1.icon_.color = Color.New(1, 1, 1)

				local var_564_9 = arg_561_1:GetWordFromCfg(910201138)
				local var_564_10 = arg_561_1:FormatText(var_564_9.content)

				arg_561_1.text_.text = var_564_10

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_11 = 20
				local var_564_12 = utf8.len(var_564_10)
				local var_564_13 = var_564_11 <= 0 and var_564_7 or var_564_7 * (var_564_12 / var_564_11)

				if var_564_13 > 0 and var_564_7 < var_564_13 then
					arg_561_1.talkMaxDuration = var_564_13

					if var_564_13 + var_564_6 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_13 + var_564_6
					end
				end

				arg_561_1.text_.text = var_564_10
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)
				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_14 = math.max(var_564_7, arg_561_1.talkMaxDuration)

			if var_564_6 <= arg_561_1.time_ and arg_561_1.time_ < var_564_6 + var_564_14 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_6) / var_564_14

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_6 + var_564_14 and arg_561_1.time_ < var_564_6 + var_564_14 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {}

		arg_561_1:InitPlayNodeList()
	end,
	Play910201139 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 910201139
		arg_565_1.duration_ = 5

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play910201140(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			local var_568_0 = arg_565_1.actors_["1096ui_story"]
			local var_568_1 = 0

			if var_568_1 < arg_565_1.time_ and arg_565_1.time_ <= var_568_1 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect1096ui_story == nil then
				arg_565_1.var_.characterEffect1096ui_story = var_568_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_2 = 0.2

			if var_568_1 <= arg_565_1.time_ and arg_565_1.time_ < var_568_1 + var_568_2 and not isNil(var_568_0) then
				local var_568_3 = (arg_565_1.time_ - var_568_1) / var_568_2

				if arg_565_1.var_.characterEffect1096ui_story and not isNil(var_568_0) then
					arg_565_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_565_1.time_ >= var_568_1 + var_568_2 and arg_565_1.time_ < var_568_1 + var_568_2 + arg_568_0 and not isNil(var_568_0) and arg_565_1.var_.characterEffect1096ui_story then
				arg_565_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_568_4 = 0

			if var_568_4 < arg_565_1.time_ and arg_565_1.time_ <= var_568_4 + arg_568_0 then
				arg_565_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action453")
			end

			local var_568_5 = 0

			if var_568_5 < arg_565_1.time_ and arg_565_1.time_ <= var_568_5 + arg_568_0 then
				arg_565_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_568_6 = 0
			local var_568_7 = 1.075

			if var_568_6 < arg_565_1.time_ and arg_565_1.time_ <= var_568_6 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				local var_568_8 = arg_565_1:FormatText(StoryNameCfg[169].name)

				arg_565_1.leftNameTxt_.text = var_568_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_9 = arg_565_1:GetWordFromCfg(910201139)
				local var_568_10 = arg_565_1:FormatText(var_568_9.content)

				arg_565_1.text_.text = var_568_10

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_11 = 43
				local var_568_12 = utf8.len(var_568_10)
				local var_568_13 = var_568_11 <= 0 and var_568_7 or var_568_7 * (var_568_12 / var_568_11)

				if var_568_13 > 0 and var_568_7 < var_568_13 then
					arg_565_1.talkMaxDuration = var_568_13

					if var_568_13 + var_568_6 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_13 + var_568_6
					end
				end

				arg_565_1.text_.text = var_568_10
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)
				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_14 = math.max(var_568_7, arg_565_1.talkMaxDuration)

			if var_568_6 <= arg_565_1.time_ and arg_565_1.time_ < var_568_6 + var_568_14 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_6) / var_568_14

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_6 + var_568_14 and arg_565_1.time_ < var_568_6 + var_568_14 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {}

		arg_565_1:InitPlayNodeList()
	end,
	Play910201140 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 910201140
		arg_569_1.duration_ = 5

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play910201141(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			local var_572_0 = arg_569_1.actors_["1096ui_story"]
			local var_572_1 = 0

			if var_572_1 < arg_569_1.time_ and arg_569_1.time_ <= var_572_1 + arg_572_0 and not isNil(var_572_0) and arg_569_1.var_.characterEffect1096ui_story == nil then
				arg_569_1.var_.characterEffect1096ui_story = var_572_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_2 = 0.2

			if var_572_1 <= arg_569_1.time_ and arg_569_1.time_ < var_572_1 + var_572_2 and not isNil(var_572_0) then
				local var_572_3 = (arg_569_1.time_ - var_572_1) / var_572_2

				if arg_569_1.var_.characterEffect1096ui_story and not isNil(var_572_0) then
					local var_572_4 = Mathf.Lerp(0, 0.5, var_572_3)

					arg_569_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_569_1.var_.characterEffect1096ui_story.fillRatio = var_572_4
				end
			end

			if arg_569_1.time_ >= var_572_1 + var_572_2 and arg_569_1.time_ < var_572_1 + var_572_2 + arg_572_0 and not isNil(var_572_0) and arg_569_1.var_.characterEffect1096ui_story then
				local var_572_5 = 0.5

				arg_569_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_569_1.var_.characterEffect1096ui_story.fillRatio = var_572_5
			end

			local var_572_6 = 0
			local var_572_7 = 0.3

			if var_572_6 < arg_569_1.time_ and arg_569_1.time_ <= var_572_6 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				local var_572_8 = arg_569_1:FormatText(StoryNameCfg[7].name)

				arg_569_1.leftNameTxt_.text = var_572_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, true)
				arg_569_1.iconController_:SetSelectedState("hero")

				arg_569_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_569_1.callingController_:SetSelectedState("normal")

				arg_569_1.keyicon_.color = Color.New(1, 1, 1)
				arg_569_1.icon_.color = Color.New(1, 1, 1)

				local var_572_9 = arg_569_1:GetWordFromCfg(910201140)
				local var_572_10 = arg_569_1:FormatText(var_572_9.content)

				arg_569_1.text_.text = var_572_10

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_11 = 12
				local var_572_12 = utf8.len(var_572_10)
				local var_572_13 = var_572_11 <= 0 and var_572_7 or var_572_7 * (var_572_12 / var_572_11)

				if var_572_13 > 0 and var_572_7 < var_572_13 then
					arg_569_1.talkMaxDuration = var_572_13

					if var_572_13 + var_572_6 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_13 + var_572_6
					end
				end

				arg_569_1.text_.text = var_572_10
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)
				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_14 = math.max(var_572_7, arg_569_1.talkMaxDuration)

			if var_572_6 <= arg_569_1.time_ and arg_569_1.time_ < var_572_6 + var_572_14 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_6) / var_572_14

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_6 + var_572_14 and arg_569_1.time_ < var_572_6 + var_572_14 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play910201141 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 910201141
		arg_573_1.duration_ = 5

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play910201142(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = arg_573_1.actors_["1096ui_story"]
			local var_576_1 = 0

			if var_576_1 < arg_573_1.time_ and arg_573_1.time_ <= var_576_1 + arg_576_0 and not isNil(var_576_0) and arg_573_1.var_.characterEffect1096ui_story == nil then
				arg_573_1.var_.characterEffect1096ui_story = var_576_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_576_2 = 0.2

			if var_576_1 <= arg_573_1.time_ and arg_573_1.time_ < var_576_1 + var_576_2 and not isNil(var_576_0) then
				local var_576_3 = (arg_573_1.time_ - var_576_1) / var_576_2

				if arg_573_1.var_.characterEffect1096ui_story and not isNil(var_576_0) then
					arg_573_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_573_1.time_ >= var_576_1 + var_576_2 and arg_573_1.time_ < var_576_1 + var_576_2 + arg_576_0 and not isNil(var_576_0) and arg_573_1.var_.characterEffect1096ui_story then
				arg_573_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_576_4 = 0

			if var_576_4 < arg_573_1.time_ and arg_573_1.time_ <= var_576_4 + arg_576_0 then
				arg_573_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action435")
			end

			local var_576_5 = 0

			if var_576_5 < arg_573_1.time_ and arg_573_1.time_ <= var_576_5 + arg_576_0 then
				arg_573_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_576_6 = 0
			local var_576_7 = 0.175

			if var_576_6 < arg_573_1.time_ and arg_573_1.time_ <= var_576_6 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				local var_576_8 = arg_573_1:FormatText(StoryNameCfg[169].name)

				arg_573_1.leftNameTxt_.text = var_576_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_9 = arg_573_1:GetWordFromCfg(910201141)
				local var_576_10 = arg_573_1:FormatText(var_576_9.content)

				arg_573_1.text_.text = var_576_10

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_11 = 7
				local var_576_12 = utf8.len(var_576_10)
				local var_576_13 = var_576_11 <= 0 and var_576_7 or var_576_7 * (var_576_12 / var_576_11)

				if var_576_13 > 0 and var_576_7 < var_576_13 then
					arg_573_1.talkMaxDuration = var_576_13

					if var_576_13 + var_576_6 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_13 + var_576_6
					end
				end

				arg_573_1.text_.text = var_576_10
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)
				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_14 = math.max(var_576_7, arg_573_1.talkMaxDuration)

			if var_576_6 <= arg_573_1.time_ and arg_573_1.time_ < var_576_6 + var_576_14 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - var_576_6) / var_576_14

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= var_576_6 + var_576_14 and arg_573_1.time_ < var_576_6 + var_576_14 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play910201142 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 910201142
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play910201143(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			local var_580_0 = arg_577_1.actors_["1096ui_story"]
			local var_580_1 = 0

			if var_580_1 < arg_577_1.time_ and arg_577_1.time_ <= var_580_1 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.characterEffect1096ui_story == nil then
				arg_577_1.var_.characterEffect1096ui_story = var_580_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_580_2 = 0.2

			if var_580_1 <= arg_577_1.time_ and arg_577_1.time_ < var_580_1 + var_580_2 and not isNil(var_580_0) then
				local var_580_3 = (arg_577_1.time_ - var_580_1) / var_580_2

				if arg_577_1.var_.characterEffect1096ui_story and not isNil(var_580_0) then
					local var_580_4 = Mathf.Lerp(0, 0.5, var_580_3)

					arg_577_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_577_1.var_.characterEffect1096ui_story.fillRatio = var_580_4
				end
			end

			if arg_577_1.time_ >= var_580_1 + var_580_2 and arg_577_1.time_ < var_580_1 + var_580_2 + arg_580_0 and not isNil(var_580_0) and arg_577_1.var_.characterEffect1096ui_story then
				local var_580_5 = 0.5

				arg_577_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_577_1.var_.characterEffect1096ui_story.fillRatio = var_580_5
			end

			local var_580_6 = 0
			local var_580_7 = 0.075

			if var_580_6 < arg_577_1.time_ and arg_577_1.time_ <= var_580_6 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, true)

				local var_580_8 = arg_577_1:FormatText(StoryNameCfg[7].name)

				arg_577_1.leftNameTxt_.text = var_580_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_577_1.leftNameTxt_.transform)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1.leftNameTxt_.text)
				SetActive(arg_577_1.iconTrs_.gameObject, true)
				arg_577_1.iconController_:SetSelectedState("hero")

				arg_577_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_577_1.callingController_:SetSelectedState("normal")

				arg_577_1.keyicon_.color = Color.New(1, 1, 1)
				arg_577_1.icon_.color = Color.New(1, 1, 1)

				local var_580_9 = arg_577_1:GetWordFromCfg(910201142)
				local var_580_10 = arg_577_1:FormatText(var_580_9.content)

				arg_577_1.text_.text = var_580_10

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_11 = 3
				local var_580_12 = utf8.len(var_580_10)
				local var_580_13 = var_580_11 <= 0 and var_580_7 or var_580_7 * (var_580_12 / var_580_11)

				if var_580_13 > 0 and var_580_7 < var_580_13 then
					arg_577_1.talkMaxDuration = var_580_13

					if var_580_13 + var_580_6 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_13 + var_580_6
					end
				end

				arg_577_1.text_.text = var_580_10
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_14 = math.max(var_580_7, arg_577_1.talkMaxDuration)

			if var_580_6 <= arg_577_1.time_ and arg_577_1.time_ < var_580_6 + var_580_14 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_6) / var_580_14

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_6 + var_580_14 and arg_577_1.time_ < var_580_6 + var_580_14 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {}

		arg_577_1:InitPlayNodeList()
	end,
	Play910201143 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 910201143
		arg_581_1.duration_ = 5

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play910201144(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			local var_584_0 = arg_581_1.actors_["1096ui_story"]
			local var_584_1 = 0

			if var_584_1 < arg_581_1.time_ and arg_581_1.time_ <= var_584_1 + arg_584_0 and not isNil(var_584_0) and arg_581_1.var_.characterEffect1096ui_story == nil then
				arg_581_1.var_.characterEffect1096ui_story = var_584_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_2 = 0.2

			if var_584_1 <= arg_581_1.time_ and arg_581_1.time_ < var_584_1 + var_584_2 and not isNil(var_584_0) then
				local var_584_3 = (arg_581_1.time_ - var_584_1) / var_584_2

				if arg_581_1.var_.characterEffect1096ui_story and not isNil(var_584_0) then
					arg_581_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_581_1.time_ >= var_584_1 + var_584_2 and arg_581_1.time_ < var_584_1 + var_584_2 + arg_584_0 and not isNil(var_584_0) and arg_581_1.var_.characterEffect1096ui_story then
				arg_581_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_584_4 = 0

			if var_584_4 < arg_581_1.time_ and arg_581_1.time_ <= var_584_4 + arg_584_0 then
				arg_581_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_584_5 = 0
			local var_584_6 = 0.325

			if var_584_5 < arg_581_1.time_ and arg_581_1.time_ <= var_584_5 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				local var_584_7 = arg_581_1:FormatText(StoryNameCfg[169].name)

				arg_581_1.leftNameTxt_.text = var_584_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_8 = arg_581_1:GetWordFromCfg(910201143)
				local var_584_9 = arg_581_1:FormatText(var_584_8.content)

				arg_581_1.text_.text = var_584_9

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_10 = 13
				local var_584_11 = utf8.len(var_584_9)
				local var_584_12 = var_584_10 <= 0 and var_584_6 or var_584_6 * (var_584_11 / var_584_10)

				if var_584_12 > 0 and var_584_6 < var_584_12 then
					arg_581_1.talkMaxDuration = var_584_12

					if var_584_12 + var_584_5 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_12 + var_584_5
					end
				end

				arg_581_1.text_.text = var_584_9
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)
				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_13 = math.max(var_584_6, arg_581_1.talkMaxDuration)

			if var_584_5 <= arg_581_1.time_ and arg_581_1.time_ < var_584_5 + var_584_13 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_5) / var_584_13

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_5 + var_584_13 and arg_581_1.time_ < var_584_5 + var_584_13 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {}

		arg_581_1:InitPlayNodeList()
	end,
	Play910201144 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 910201144
		arg_585_1.duration_ = 5

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play910201145(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			local var_588_0 = 0

			if var_588_0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_0 + arg_588_0 then
				arg_585_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action453")
			end

			local var_588_1 = 0
			local var_588_2 = 1.25

			if var_588_1 < arg_585_1.time_ and arg_585_1.time_ <= var_588_1 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, false)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_3 = arg_585_1:GetWordFromCfg(910201144)
				local var_588_4 = arg_585_1:FormatText(var_588_3.content)

				arg_585_1.text_.text = var_588_4

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_5 = 50
				local var_588_6 = utf8.len(var_588_4)
				local var_588_7 = var_588_5 <= 0 and var_588_2 or var_588_2 * (var_588_6 / var_588_5)

				if var_588_7 > 0 and var_588_2 < var_588_7 then
					arg_585_1.talkMaxDuration = var_588_7

					if var_588_7 + var_588_1 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_7 + var_588_1
					end
				end

				arg_585_1.text_.text = var_588_4
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)
				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_8 = math.max(var_588_2, arg_585_1.talkMaxDuration)

			if var_588_1 <= arg_585_1.time_ and arg_585_1.time_ < var_588_1 + var_588_8 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_1) / var_588_8

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_1 + var_588_8 and arg_585_1.time_ < var_588_1 + var_588_8 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {}

		arg_585_1:InitPlayNodeList()
	end,
	Play910201145 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 910201145
		arg_589_1.duration_ = 6.53

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play910201146(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			local var_592_0 = arg_589_1.actors_["1096ui_story"].transform
			local var_592_1 = 1.966

			if var_592_1 < arg_589_1.time_ and arg_589_1.time_ <= var_592_1 + arg_592_0 then
				arg_589_1.var_.moveOldPos1096ui_story = var_592_0.localPosition
			end

			local var_592_2 = 0.001

			if var_592_1 <= arg_589_1.time_ and arg_589_1.time_ < var_592_1 + var_592_2 then
				local var_592_3 = (arg_589_1.time_ - var_592_1) / var_592_2
				local var_592_4 = Vector3.New(0, 100, 0)

				var_592_0.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos1096ui_story, var_592_4, var_592_3)

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

			local var_592_9 = 0

			if var_592_9 < arg_589_1.time_ and arg_589_1.time_ <= var_592_9 + arg_592_0 then
				arg_589_1.mask_.enabled = true
				arg_589_1.mask_.raycastTarget = true

				arg_589_1:SetGaussion(false)
			end

			local var_592_10 = 1.966

			if var_592_9 <= arg_589_1.time_ and arg_589_1.time_ < var_592_9 + var_592_10 then
				local var_592_11 = (arg_589_1.time_ - var_592_9) / var_592_10
				local var_592_12 = Color.New(0, 0, 0)

				var_592_12.a = Mathf.Lerp(0, 1, var_592_11)
				arg_589_1.mask_.color = var_592_12
			end

			if arg_589_1.time_ >= var_592_9 + var_592_10 and arg_589_1.time_ < var_592_9 + var_592_10 + arg_592_0 then
				local var_592_13 = Color.New(0, 0, 0)

				var_592_13.a = 1
				arg_589_1.mask_.color = var_592_13
			end

			local var_592_14 = 1.966

			if var_592_14 < arg_589_1.time_ and arg_589_1.time_ <= var_592_14 + arg_592_0 then
				arg_589_1.mask_.enabled = true
				arg_589_1.mask_.raycastTarget = true

				arg_589_1:SetGaussion(false)
			end

			local var_592_15 = 1.966

			if var_592_14 <= arg_589_1.time_ and arg_589_1.time_ < var_592_14 + var_592_15 then
				local var_592_16 = (arg_589_1.time_ - var_592_14) / var_592_15
				local var_592_17 = Color.New(0, 0, 0)

				var_592_17.a = Mathf.Lerp(1, 0, var_592_16)
				arg_589_1.mask_.color = var_592_17
			end

			if arg_589_1.time_ >= var_592_14 + var_592_15 and arg_589_1.time_ < var_592_14 + var_592_15 + arg_592_0 then
				local var_592_18 = Color.New(0, 0, 0)
				local var_592_19 = 0

				arg_589_1.mask_.enabled = false
				var_592_18.a = var_592_19
				arg_589_1.mask_.color = var_592_18
			end

			local var_592_20 = 1.966

			if var_592_20 < arg_589_1.time_ and arg_589_1.time_ <= var_592_20 + arg_592_0 then
				arg_589_1.fswbg_:SetActive(true)
				arg_589_1.dialog_:SetActive(false)

				arg_589_1.fswtw_.percent = 0

				local var_592_21 = arg_589_1:GetWordFromCfg(910201145)
				local var_592_22 = arg_589_1:FormatText(var_592_21.content)

				arg_589_1.fswt_.text = var_592_22

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.fswt_)

				arg_589_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_589_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_589_1.fswtw_:SetDirty()

				arg_589_1.typewritterCharCountI18N = 0

				SetActive(arg_589_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_589_1:ShowNextGo(false)
			end

			local var_592_23 = 1.98266666666667

			if var_592_23 < arg_589_1.time_ and arg_589_1.time_ <= var_592_23 + arg_592_0 then
				arg_589_1.var_.oldValueTypewriter = arg_589_1.fswtw_.percent

				SetActive(arg_589_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_589_1:ShowNextGo(false)
			end

			local var_592_24 = 14
			local var_592_25 = 0.933333333333333
			local var_592_26 = arg_589_1:GetWordFromCfg(910201145)
			local var_592_27 = arg_589_1:FormatText(var_592_26.content)
			local var_592_28, var_592_29 = arg_589_1:GetPercentByPara(var_592_27, 1)

			if var_592_23 < arg_589_1.time_ and arg_589_1.time_ <= var_592_23 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0

				local var_592_30 = var_592_24 <= 0 and var_592_25 or var_592_25 * ((var_592_29 - arg_589_1.typewritterCharCountI18N) / var_592_24)

				if var_592_30 > 0 and var_592_25 < var_592_30 then
					arg_589_1.talkMaxDuration = var_592_30

					if var_592_30 + var_592_23 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_30 + var_592_23
					end
				end
			end

			local var_592_31 = 0.933333333333333
			local var_592_32 = math.max(var_592_31, arg_589_1.talkMaxDuration)

			if var_592_23 <= arg_589_1.time_ and arg_589_1.time_ < var_592_23 + var_592_32 then
				local var_592_33 = (arg_589_1.time_ - var_592_23) / var_592_32

				arg_589_1.fswtw_.percent = Mathf.Lerp(arg_589_1.var_.oldValueTypewriter, var_592_28, var_592_33)
				arg_589_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_589_1.fswtw_:SetDirty()
			end

			if arg_589_1.time_ >= var_592_23 + var_592_32 and arg_589_1.time_ < var_592_23 + var_592_32 + arg_592_0 then
				arg_589_1.fswtw_.percent = var_592_28

				arg_589_1.fswtw_:SetDirty()
				arg_589_1:ShowNextGo(true)

				arg_589_1.typewritterCharCountI18N = var_592_29
			end

			local var_592_34 = 1.966

			if var_592_34 < arg_589_1.time_ and arg_589_1.time_ <= var_592_34 + arg_592_0 then
				local var_592_35 = arg_589_1.fswbg_.transform:Find("textbox/adapt/content") or arg_589_1.fswbg_.transform:Find("textbox/content")
				local var_592_36 = arg_589_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_592_37 = var_592_35:GetComponent("Text")
				local var_592_38 = var_592_35:GetComponent("RectTransform")

				var_592_37.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_592_38.offsetMin = Vector2.New(0, 0)
				var_592_38.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_589_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_589_1:InitPlayNodeList()
	end,
	Play910201146 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 910201146
		arg_593_1.duration_ = 1.33

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play910201147(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 0

			if var_596_0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_0 + arg_596_0 then
				arg_593_1.var_.oldValueTypewriter = arg_593_1.fswtw_.percent

				SetActive(arg_593_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_593_1:ShowNextGo(false)
			end

			local var_596_1 = 34
			local var_596_2 = 1.33333333333333
			local var_596_3 = arg_593_1:GetWordFromCfg(910201145)
			local var_596_4 = arg_593_1:FormatText(var_596_3.content)
			local var_596_5, var_596_6 = arg_593_1:GetPercentByPara(var_596_4, 2)

			if var_596_0 < arg_593_1.time_ and arg_593_1.time_ <= var_596_0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0

				local var_596_7 = var_596_1 <= 0 and var_596_2 or var_596_2 * ((var_596_6 - arg_593_1.typewritterCharCountI18N) / var_596_1)

				if var_596_7 > 0 and var_596_2 < var_596_7 then
					arg_593_1.talkMaxDuration = var_596_7

					if var_596_7 + var_596_0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_7 + var_596_0
					end
				end
			end

			local var_596_8 = 1.33333333333333
			local var_596_9 = math.max(var_596_8, arg_593_1.talkMaxDuration)

			if var_596_0 <= arg_593_1.time_ and arg_593_1.time_ < var_596_0 + var_596_9 then
				local var_596_10 = (arg_593_1.time_ - var_596_0) / var_596_9

				arg_593_1.fswtw_.percent = Mathf.Lerp(arg_593_1.var_.oldValueTypewriter, var_596_5, var_596_10)
				arg_593_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_593_1.fswtw_:SetDirty()
			end

			if arg_593_1.time_ >= var_596_0 + var_596_9 and arg_593_1.time_ < var_596_0 + var_596_9 + arg_596_0 then
				arg_593_1.fswtw_.percent = var_596_5

				arg_593_1.fswtw_:SetDirty()
				arg_593_1:ShowNextGo(true)

				arg_593_1.typewritterCharCountI18N = var_596_6
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play910201147 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 910201147
		arg_597_1.duration_ = 1

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play910201148(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 0

			if var_600_0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_0 + arg_600_0 then
				arg_597_1.var_.oldValueTypewriter = arg_597_1.fswtw_.percent

				SetActive(arg_597_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_597_1:ShowNextGo(false)
			end

			local var_600_1 = 5
			local var_600_2 = 0.333333333333333
			local var_600_3 = arg_597_1:GetWordFromCfg(910201145)
			local var_600_4 = arg_597_1:FormatText(var_600_3.content)
			local var_600_5, var_600_6 = arg_597_1:GetPercentByPara(var_600_4, 3)

			if var_600_0 < arg_597_1.time_ and arg_597_1.time_ <= var_600_0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0

				local var_600_7 = var_600_1 <= 0 and var_600_2 or var_600_2 * ((var_600_6 - arg_597_1.typewritterCharCountI18N) / var_600_1)

				if var_600_7 > 0 and var_600_2 < var_600_7 then
					arg_597_1.talkMaxDuration = var_600_7

					if var_600_7 + var_600_0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_7 + var_600_0
					end
				end
			end

			local var_600_8 = 0.333333333333333
			local var_600_9 = math.max(var_600_8, arg_597_1.talkMaxDuration)

			if var_600_0 <= arg_597_1.time_ and arg_597_1.time_ < var_600_0 + var_600_9 then
				local var_600_10 = (arg_597_1.time_ - var_600_0) / var_600_9

				arg_597_1.fswtw_.percent = Mathf.Lerp(arg_597_1.var_.oldValueTypewriter, var_600_5, var_600_10)
				arg_597_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_597_1.fswtw_:SetDirty()
			end

			if arg_597_1.time_ >= var_600_0 + var_600_9 and arg_597_1.time_ < var_600_0 + var_600_9 + arg_600_0 then
				arg_597_1.fswtw_.percent = var_600_5

				arg_597_1.fswtw_:SetDirty()
				arg_597_1:ShowNextGo(true)

				arg_597_1.typewritterCharCountI18N = var_600_6
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play910201148 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 910201148
		arg_601_1.duration_ = 9

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play910201149(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			local var_604_0 = 0

			if var_604_0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_0 + arg_604_0 then
				arg_601_1.mask_.enabled = true
				arg_601_1.mask_.raycastTarget = true

				arg_601_1:SetGaussion(false)
			end

			local var_604_1 = 2

			if var_604_0 <= arg_601_1.time_ and arg_601_1.time_ < var_604_0 + var_604_1 then
				local var_604_2 = (arg_601_1.time_ - var_604_0) / var_604_1
				local var_604_3 = Color.New(0, 0, 0)

				var_604_3.a = Mathf.Lerp(0, 1, var_604_2)
				arg_601_1.mask_.color = var_604_3
			end

			if arg_601_1.time_ >= var_604_0 + var_604_1 and arg_601_1.time_ < var_604_0 + var_604_1 + arg_604_0 then
				local var_604_4 = Color.New(0, 0, 0)

				var_604_4.a = 1
				arg_601_1.mask_.color = var_604_4
			end

			local var_604_5 = 2

			if var_604_5 < arg_601_1.time_ and arg_601_1.time_ <= var_604_5 + arg_604_0 then
				arg_601_1.mask_.enabled = true
				arg_601_1.mask_.raycastTarget = true

				arg_601_1:SetGaussion(false)
			end

			local var_604_6 = 2

			if var_604_5 <= arg_601_1.time_ and arg_601_1.time_ < var_604_5 + var_604_6 then
				local var_604_7 = (arg_601_1.time_ - var_604_5) / var_604_6
				local var_604_8 = Color.New(0, 0, 0)

				var_604_8.a = Mathf.Lerp(1, 0, var_604_7)
				arg_601_1.mask_.color = var_604_8
			end

			if arg_601_1.time_ >= var_604_5 + var_604_6 and arg_601_1.time_ < var_604_5 + var_604_6 + arg_604_0 then
				local var_604_9 = Color.New(0, 0, 0)
				local var_604_10 = 0

				arg_601_1.mask_.enabled = false
				var_604_9.a = var_604_10
				arg_601_1.mask_.color = var_604_9
			end

			local var_604_11 = 1.98333333333333

			if var_604_11 < arg_601_1.time_ and arg_601_1.time_ <= var_604_11 + arg_604_0 then
				arg_601_1.fswbg_:SetActive(false)
				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_601_1:ShowNextGo(false)
			end

			if arg_601_1.frameCnt_ <= 1 then
				arg_601_1.dialog_:SetActive(false)
			end

			local var_604_12 = 4
			local var_604_13 = 0.5

			if var_604_12 < arg_601_1.time_ and arg_601_1.time_ <= var_604_12 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0

				arg_601_1.dialog_:SetActive(true)

				arg_601_1.dialogCg_.alpha = 0

				local var_604_14 = LeanTween.value(arg_601_1.dialog_, 0, 1, 0.3)

				var_604_14:setOnUpdate(LuaHelper.FloatAction(function(arg_605_0)
					arg_601_1.dialogCg_.alpha = arg_605_0
				end))
				var_604_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_601_1.dialog_)
					var_604_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_601_1.duration_ = arg_601_1.duration_ + 0.3

				SetActive(arg_601_1.leftNameGo_, false)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_15 = arg_601_1:GetWordFromCfg(910201148)
				local var_604_16 = arg_601_1:FormatText(var_604_15.content)

				arg_601_1.text_.text = var_604_16

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_17 = 20
				local var_604_18 = utf8.len(var_604_16)
				local var_604_19 = var_604_17 <= 0 and var_604_13 or var_604_13 * (var_604_18 / var_604_17)

				if var_604_19 > 0 and var_604_13 < var_604_19 then
					arg_601_1.talkMaxDuration = var_604_19
					var_604_12 = var_604_12 + 0.3

					if var_604_19 + var_604_12 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_19 + var_604_12
					end
				end

				arg_601_1.text_.text = var_604_16
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_20 = var_604_12 + 0.3
			local var_604_21 = math.max(var_604_13, arg_601_1.talkMaxDuration)

			if var_604_20 <= arg_601_1.time_ and arg_601_1.time_ < var_604_20 + var_604_21 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_20) / var_604_21

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_20 + var_604_21 and arg_601_1.time_ < var_604_20 + var_604_21 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play910201149 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 910201149
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play910201150(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			local var_610_0 = arg_607_1.actors_["1096ui_story"]
			local var_610_1 = 0

			if var_610_1 < arg_607_1.time_ and arg_607_1.time_ <= var_610_1 + arg_610_0 and not isNil(var_610_0) and arg_607_1.var_.characterEffect1096ui_story == nil then
				arg_607_1.var_.characterEffect1096ui_story = var_610_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_610_2 = 0.2

			if var_610_1 <= arg_607_1.time_ and arg_607_1.time_ < var_610_1 + var_610_2 and not isNil(var_610_0) then
				local var_610_3 = (arg_607_1.time_ - var_610_1) / var_610_2

				if arg_607_1.var_.characterEffect1096ui_story and not isNil(var_610_0) then
					arg_607_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_607_1.time_ >= var_610_1 + var_610_2 and arg_607_1.time_ < var_610_1 + var_610_2 + arg_610_0 and not isNil(var_610_0) and arg_607_1.var_.characterEffect1096ui_story then
				arg_607_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_610_4 = 0

			if var_610_4 < arg_607_1.time_ and arg_607_1.time_ <= var_610_4 + arg_610_0 then
				arg_607_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action432")
			end

			local var_610_5 = 0

			if var_610_5 < arg_607_1.time_ and arg_607_1.time_ <= var_610_5 + arg_610_0 then
				arg_607_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_610_6 = arg_607_1.actors_["1096ui_story"].transform
			local var_610_7 = 0

			if var_610_7 < arg_607_1.time_ and arg_607_1.time_ <= var_610_7 + arg_610_0 then
				arg_607_1.var_.moveOldPos1096ui_story = var_610_6.localPosition
			end

			local var_610_8 = 0.001

			if var_610_7 <= arg_607_1.time_ and arg_607_1.time_ < var_610_7 + var_610_8 then
				local var_610_9 = (arg_607_1.time_ - var_610_7) / var_610_8
				local var_610_10 = Vector3.New(0, -1.13, -5.6)

				var_610_6.localPosition = Vector3.Lerp(arg_607_1.var_.moveOldPos1096ui_story, var_610_10, var_610_9)

				local var_610_11 = manager.ui.mainCamera.transform.position - var_610_6.position

				var_610_6.forward = Vector3.New(var_610_11.x, var_610_11.y, var_610_11.z)

				local var_610_12 = var_610_6.localEulerAngles

				var_610_12.z = 0
				var_610_12.x = 0
				var_610_6.localEulerAngles = var_610_12
			end

			if arg_607_1.time_ >= var_610_7 + var_610_8 and arg_607_1.time_ < var_610_7 + var_610_8 + arg_610_0 then
				var_610_6.localPosition = Vector3.New(0, -1.13, -5.6)

				local var_610_13 = manager.ui.mainCamera.transform.position - var_610_6.position

				var_610_6.forward = Vector3.New(var_610_13.x, var_610_13.y, var_610_13.z)

				local var_610_14 = var_610_6.localEulerAngles

				var_610_14.z = 0
				var_610_14.x = 0
				var_610_6.localEulerAngles = var_610_14
			end

			local var_610_15 = 0
			local var_610_16 = 0.25

			if var_610_15 < arg_607_1.time_ and arg_607_1.time_ <= var_610_15 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				local var_610_17 = arg_607_1:FormatText(StoryNameCfg[169].name)

				arg_607_1.leftNameTxt_.text = var_610_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, false)
				arg_607_1.callingController_:SetSelectedState("normal")

				local var_610_18 = arg_607_1:GetWordFromCfg(910201149)
				local var_610_19 = arg_607_1:FormatText(var_610_18.content)

				arg_607_1.text_.text = var_610_19

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_20 = 10
				local var_610_21 = utf8.len(var_610_19)
				local var_610_22 = var_610_20 <= 0 and var_610_16 or var_610_16 * (var_610_21 / var_610_20)

				if var_610_22 > 0 and var_610_16 < var_610_22 then
					arg_607_1.talkMaxDuration = var_610_22

					if var_610_22 + var_610_15 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_22 + var_610_15
					end
				end

				arg_607_1.text_.text = var_610_19
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_23 = math.max(var_610_16, arg_607_1.talkMaxDuration)

			if var_610_15 <= arg_607_1.time_ and arg_607_1.time_ < var_610_15 + var_610_23 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_15) / var_610_23

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_15 + var_610_23 and arg_607_1.time_ < var_610_15 + var_610_23 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_607_1:InitPlayNodeList()
	end,
	Play910201150 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 910201150
		arg_611_1.duration_ = 5

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play910201151(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			local var_614_0 = arg_611_1.actors_["1096ui_story"]
			local var_614_1 = 0

			if var_614_1 < arg_611_1.time_ and arg_611_1.time_ <= var_614_1 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1096ui_story == nil then
				arg_611_1.var_.characterEffect1096ui_story = var_614_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_614_2 = 0.2

			if var_614_1 <= arg_611_1.time_ and arg_611_1.time_ < var_614_1 + var_614_2 and not isNil(var_614_0) then
				local var_614_3 = (arg_611_1.time_ - var_614_1) / var_614_2

				if arg_611_1.var_.characterEffect1096ui_story and not isNil(var_614_0) then
					local var_614_4 = Mathf.Lerp(0, 0.5, var_614_3)

					arg_611_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_611_1.var_.characterEffect1096ui_story.fillRatio = var_614_4
				end
			end

			if arg_611_1.time_ >= var_614_1 + var_614_2 and arg_611_1.time_ < var_614_1 + var_614_2 + arg_614_0 and not isNil(var_614_0) and arg_611_1.var_.characterEffect1096ui_story then
				local var_614_5 = 0.5

				arg_611_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_611_1.var_.characterEffect1096ui_story.fillRatio = var_614_5
			end

			local var_614_6 = 0
			local var_614_7 = 0.75

			if var_614_6 < arg_611_1.time_ and arg_611_1.time_ <= var_614_6 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, true)

				local var_614_8 = arg_611_1:FormatText(StoryNameCfg[7].name)

				arg_611_1.leftNameTxt_.text = var_614_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_611_1.leftNameTxt_.transform)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1.leftNameTxt_.text)
				SetActive(arg_611_1.iconTrs_.gameObject, true)
				arg_611_1.iconController_:SetSelectedState("hero")

				arg_611_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_611_1.callingController_:SetSelectedState("normal")

				arg_611_1.keyicon_.color = Color.New(1, 1, 1)
				arg_611_1.icon_.color = Color.New(1, 1, 1)

				local var_614_9 = arg_611_1:GetWordFromCfg(910201150)
				local var_614_10 = arg_611_1:FormatText(var_614_9.content)

				arg_611_1.text_.text = var_614_10

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_11 = 30
				local var_614_12 = utf8.len(var_614_10)
				local var_614_13 = var_614_11 <= 0 and var_614_7 or var_614_7 * (var_614_12 / var_614_11)

				if var_614_13 > 0 and var_614_7 < var_614_13 then
					arg_611_1.talkMaxDuration = var_614_13

					if var_614_13 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_13 + var_614_6
					end
				end

				arg_611_1.text_.text = var_614_10
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_14 = math.max(var_614_7, arg_611_1.talkMaxDuration)

			if var_614_6 <= arg_611_1.time_ and arg_611_1.time_ < var_614_6 + var_614_14 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_6) / var_614_14

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_6 + var_614_14 and arg_611_1.time_ < var_614_6 + var_614_14 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {}

		arg_611_1:InitPlayNodeList()
	end,
	Play910201151 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 910201151
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play910201152(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0
			local var_618_1 = 0.725

			if var_618_0 < arg_615_1.time_ and arg_615_1.time_ <= var_618_0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				local var_618_2 = arg_615_1:FormatText(StoryNameCfg[7].name)

				arg_615_1.leftNameTxt_.text = var_618_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_3 = arg_615_1:GetWordFromCfg(910201151)
				local var_618_4 = arg_615_1:FormatText(var_618_3.content)

				arg_615_1.text_.text = var_618_4

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_5 = 29
				local var_618_6 = utf8.len(var_618_4)
				local var_618_7 = var_618_5 <= 0 and var_618_1 or var_618_1 * (var_618_6 / var_618_5)

				if var_618_7 > 0 and var_618_1 < var_618_7 then
					arg_615_1.talkMaxDuration = var_618_7

					if var_618_7 + var_618_0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_7 + var_618_0
					end
				end

				arg_615_1.text_.text = var_618_4
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_8 = math.max(var_618_1, arg_615_1.talkMaxDuration)

			if var_618_0 <= arg_615_1.time_ and arg_615_1.time_ < var_618_0 + var_618_8 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - var_618_0) / var_618_8

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= var_618_0 + var_618_8 and arg_615_1.time_ < var_618_0 + var_618_8 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play910201152 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 910201152
		arg_619_1.duration_ = 9

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play910201153(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = "ST05"

			if arg_619_1.bgs_[var_622_0] == nil then
				local var_622_1 = Object.Instantiate(arg_619_1.paintGo_)

				var_622_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_622_0)
				var_622_1.name = var_622_0
				var_622_1.transform.parent = arg_619_1.stage_.transform
				var_622_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_619_1.bgs_[var_622_0] = var_622_1
			end

			local var_622_2 = 2

			if var_622_2 < arg_619_1.time_ and arg_619_1.time_ <= var_622_2 + arg_622_0 then
				local var_622_3 = manager.ui.mainCamera.transform.localPosition
				local var_622_4 = Vector3.New(0, 0, 10) + Vector3.New(var_622_3.x, var_622_3.y, 0)
				local var_622_5 = arg_619_1.bgs_.ST05

				var_622_5.transform.localPosition = var_622_4
				var_622_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_622_6 = var_622_5:GetComponent("SpriteRenderer")

				if var_622_6 and var_622_6.sprite then
					local var_622_7 = (var_622_5.transform.localPosition - var_622_3).z
					local var_622_8 = manager.ui.mainCameraCom_
					local var_622_9 = 2 * var_622_7 * Mathf.Tan(var_622_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_622_10 = var_622_9 * var_622_8.aspect
					local var_622_11 = var_622_6.sprite.bounds.size.x
					local var_622_12 = var_622_6.sprite.bounds.size.y
					local var_622_13 = var_622_10 / var_622_11
					local var_622_14 = var_622_9 / var_622_12
					local var_622_15 = var_622_14 < var_622_13 and var_622_13 or var_622_14

					var_622_5.transform.localScale = Vector3.New(var_622_15, var_622_15, 0)
				end

				for iter_622_0, iter_622_1 in pairs(arg_619_1.bgs_) do
					if iter_622_0 ~= "ST05" then
						iter_622_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_622_16 = 0

			if var_622_16 < arg_619_1.time_ and arg_619_1.time_ <= var_622_16 + arg_622_0 then
				arg_619_1.mask_.enabled = true
				arg_619_1.mask_.raycastTarget = true

				arg_619_1:SetGaussion(false)
			end

			local var_622_17 = 2

			if var_622_16 <= arg_619_1.time_ and arg_619_1.time_ < var_622_16 + var_622_17 then
				local var_622_18 = (arg_619_1.time_ - var_622_16) / var_622_17
				local var_622_19 = Color.New(0, 0, 0)

				var_622_19.a = Mathf.Lerp(0, 1, var_622_18)
				arg_619_1.mask_.color = var_622_19
			end

			if arg_619_1.time_ >= var_622_16 + var_622_17 and arg_619_1.time_ < var_622_16 + var_622_17 + arg_622_0 then
				local var_622_20 = Color.New(0, 0, 0)

				var_622_20.a = 1
				arg_619_1.mask_.color = var_622_20
			end

			local var_622_21 = 2

			if var_622_21 < arg_619_1.time_ and arg_619_1.time_ <= var_622_21 + arg_622_0 then
				arg_619_1.mask_.enabled = true
				arg_619_1.mask_.raycastTarget = true

				arg_619_1:SetGaussion(false)
			end

			local var_622_22 = 2.166667

			if var_622_21 <= arg_619_1.time_ and arg_619_1.time_ < var_622_21 + var_622_22 then
				local var_622_23 = (arg_619_1.time_ - var_622_21) / var_622_22
				local var_622_24 = Color.New(0, 0, 0)

				var_622_24.a = Mathf.Lerp(1, 0, var_622_23)
				arg_619_1.mask_.color = var_622_24
			end

			if arg_619_1.time_ >= var_622_21 + var_622_22 and arg_619_1.time_ < var_622_21 + var_622_22 + arg_622_0 then
				local var_622_25 = Color.New(0, 0, 0)
				local var_622_26 = 0

				arg_619_1.mask_.enabled = false
				var_622_25.a = var_622_26
				arg_619_1.mask_.color = var_622_25
			end

			local var_622_27 = arg_619_1.actors_["1096ui_story"].transform
			local var_622_28 = 1.966

			if var_622_28 < arg_619_1.time_ and arg_619_1.time_ <= var_622_28 + arg_622_0 then
				arg_619_1.var_.moveOldPos1096ui_story = var_622_27.localPosition
			end

			local var_622_29 = 0.001

			if var_622_28 <= arg_619_1.time_ and arg_619_1.time_ < var_622_28 + var_622_29 then
				local var_622_30 = (arg_619_1.time_ - var_622_28) / var_622_29
				local var_622_31 = Vector3.New(0, 100, 0)

				var_622_27.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos1096ui_story, var_622_31, var_622_30)

				local var_622_32 = manager.ui.mainCamera.transform.position - var_622_27.position

				var_622_27.forward = Vector3.New(var_622_32.x, var_622_32.y, var_622_32.z)

				local var_622_33 = var_622_27.localEulerAngles

				var_622_33.z = 0
				var_622_33.x = 0
				var_622_27.localEulerAngles = var_622_33
			end

			if arg_619_1.time_ >= var_622_28 + var_622_29 and arg_619_1.time_ < var_622_28 + var_622_29 + arg_622_0 then
				var_622_27.localPosition = Vector3.New(0, 100, 0)

				local var_622_34 = manager.ui.mainCamera.transform.position - var_622_27.position

				var_622_27.forward = Vector3.New(var_622_34.x, var_622_34.y, var_622_34.z)

				local var_622_35 = var_622_27.localEulerAngles

				var_622_35.z = 0
				var_622_35.x = 0
				var_622_27.localEulerAngles = var_622_35
			end

			local var_622_36 = arg_619_1.bgs_.ST05
			local var_622_37 = 2

			if var_622_37 < arg_619_1.time_ and arg_619_1.time_ <= var_622_37 + arg_622_0 then
				local var_622_38 = var_622_36:GetComponent("SpriteRenderer")

				if var_622_38 then
					arg_619_1.var_.alphaOldValueST05 = var_622_38.color.a
					arg_619_1.var_.alphaMatValueST05 = var_622_38
				end
			end

			local var_622_39 = 2.43333333333333

			if var_622_37 <= arg_619_1.time_ and arg_619_1.time_ < var_622_37 + var_622_39 then
				local var_622_40 = (arg_619_1.time_ - var_622_37) / var_622_39
				local var_622_41 = Mathf.Lerp(arg_619_1.var_.alphaOldValueST05, 0.5, var_622_40)

				if arg_619_1.var_.alphaMatValueST05 then
					local var_622_42 = arg_619_1.var_.alphaMatValueST05.color

					var_622_42.a = var_622_41
					arg_619_1.var_.alphaMatValueST05.color = var_622_42
				end
			end

			if arg_619_1.time_ >= var_622_37 + var_622_39 and arg_619_1.time_ < var_622_37 + var_622_39 + arg_622_0 and arg_619_1.var_.alphaMatValueST05 then
				local var_622_43 = arg_619_1.var_.alphaMatValueST05
				local var_622_44 = var_622_43.color

				var_622_44.a = 0.5
				var_622_43.color = var_622_44
			end

			local var_622_45 = 0
			local var_622_46 = 1

			if var_622_45 < arg_619_1.time_ and arg_619_1.time_ <= var_622_45 + arg_622_0 then
				local var_622_47 = "play"
				local var_622_48 = "music"

				arg_619_1:AudioAction(var_622_47, var_622_48, "ui_battle", "ui_battle_stopbgm", "")

				local var_622_49 = ""
				local var_622_50 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_622_50 ~= "" then
					if arg_619_1.bgmTxt_.text ~= var_622_50 and arg_619_1.bgmTxt_.text ~= "" then
						if arg_619_1.bgmTxt2_.text ~= "" then
							arg_619_1.bgmTxt_.text = arg_619_1.bgmTxt2_.text
						end

						arg_619_1.bgmTxt2_.text = var_622_50

						arg_619_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_619_1.bgmTxt_.text = var_622_50
						arg_619_1.bgmTxt2_.text = var_622_50
					end

					if arg_619_1.bgmTimer then
						arg_619_1.bgmTimer:Stop()

						arg_619_1.bgmTimer = nil
					end

					if arg_619_1.settingData.show_music_name == 1 then
						arg_619_1.musicController:SetSelectedState("show")
						arg_619_1.musicAnimator_:Play("open", 0, 0)

						if arg_619_1.settingData.music_time ~= 0 then
							arg_619_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_619_1.settingData.music_time), function()
								if arg_619_1 == nil or isNil(arg_619_1.bgmTxt_) then
									return
								end

								arg_619_1.musicController:SetSelectedState("hide")
								arg_619_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_622_51 = 4
			local var_622_52 = 0.975

			if var_622_51 < arg_619_1.time_ and arg_619_1.time_ <= var_622_51 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, false)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_53 = arg_619_1:GetWordFromCfg(910201152)
				local var_622_54 = arg_619_1:FormatText(var_622_53.content)

				arg_619_1.text_.text = var_622_54

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_55 = 39
				local var_622_56 = utf8.len(var_622_54)
				local var_622_57 = var_622_55 <= 0 and var_622_52 or var_622_52 * (var_622_56 / var_622_55)

				if var_622_57 > 0 and var_622_52 < var_622_57 then
					arg_619_1.talkMaxDuration = var_622_57

					if var_622_57 + var_622_51 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_57 + var_622_51
					end
				end

				arg_619_1.text_.text = var_622_54
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_58 = math.max(var_622_52, arg_619_1.talkMaxDuration)

			if var_622_51 <= arg_619_1.time_ and arg_619_1.time_ < var_622_51 + var_622_58 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_51) / var_622_58

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_51 + var_622_58 and arg_619_1.time_ < var_622_51 + var_622_58 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_619_1:InitPlayNodeList()
	end,
	Play910201153 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 910201153
		arg_624_1.duration_ = 5

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play910201154(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0
			local var_627_1 = 0.3

			if var_627_0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				local var_627_2 = arg_624_1:FormatText(StoryNameCfg[7].name)

				arg_624_1.leftNameTxt_.text = var_627_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, true)
				arg_624_1.iconController_:SetSelectedState("hero")

				arg_624_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_624_1.callingController_:SetSelectedState("normal")

				arg_624_1.keyicon_.color = Color.New(1, 1, 1)
				arg_624_1.icon_.color = Color.New(1, 1, 1)

				local var_627_3 = arg_624_1:GetWordFromCfg(910201153)
				local var_627_4 = arg_624_1:FormatText(var_627_3.content)

				arg_624_1.text_.text = var_627_4

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_5 = 12
				local var_627_6 = utf8.len(var_627_4)
				local var_627_7 = var_627_5 <= 0 and var_627_1 or var_627_1 * (var_627_6 / var_627_5)

				if var_627_7 > 0 and var_627_1 < var_627_7 then
					arg_624_1.talkMaxDuration = var_627_7

					if var_627_7 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_7 + var_627_0
					end
				end

				arg_624_1.text_.text = var_627_4
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)
				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_8 = math.max(var_627_1, arg_624_1.talkMaxDuration)

			if var_627_0 <= arg_624_1.time_ and arg_624_1.time_ < var_627_0 + var_627_8 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_0) / var_627_8

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_0 + var_627_8 and arg_624_1.time_ < var_627_0 + var_627_8 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {}

		arg_624_1:InitPlayNodeList()
	end,
	Play910201154 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 910201154
		arg_628_1.duration_ = 5

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play910201155(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			local var_631_0 = arg_628_1.actors_["1096ui_story"].transform
			local var_631_1 = 0

			if var_631_1 < arg_628_1.time_ and arg_628_1.time_ <= var_631_1 + arg_631_0 then
				arg_628_1.var_.moveOldPos1096ui_story = var_631_0.localPosition
			end

			local var_631_2 = 0.001

			if var_631_1 <= arg_628_1.time_ and arg_628_1.time_ < var_631_1 + var_631_2 then
				local var_631_3 = (arg_628_1.time_ - var_631_1) / var_631_2
				local var_631_4 = Vector3.New(0, -1.13, -5.6)

				var_631_0.localPosition = Vector3.Lerp(arg_628_1.var_.moveOldPos1096ui_story, var_631_4, var_631_3)

				local var_631_5 = manager.ui.mainCamera.transform.position - var_631_0.position

				var_631_0.forward = Vector3.New(var_631_5.x, var_631_5.y, var_631_5.z)

				local var_631_6 = var_631_0.localEulerAngles

				var_631_6.z = 0
				var_631_6.x = 0
				var_631_0.localEulerAngles = var_631_6
			end

			if arg_628_1.time_ >= var_631_1 + var_631_2 and arg_628_1.time_ < var_631_1 + var_631_2 + arg_631_0 then
				var_631_0.localPosition = Vector3.New(0, -1.13, -5.6)

				local var_631_7 = manager.ui.mainCamera.transform.position - var_631_0.position

				var_631_0.forward = Vector3.New(var_631_7.x, var_631_7.y, var_631_7.z)

				local var_631_8 = var_631_0.localEulerAngles

				var_631_8.z = 0
				var_631_8.x = 0
				var_631_0.localEulerAngles = var_631_8
			end

			local var_631_9 = 0

			if var_631_9 < arg_628_1.time_ and arg_628_1.time_ <= var_631_9 + arg_631_0 then
				arg_628_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action5_1")
			end

			local var_631_10 = 0

			if var_631_10 < arg_628_1.time_ and arg_628_1.time_ <= var_631_10 + arg_631_0 then
				arg_628_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_631_11 = arg_628_1.actors_["1096ui_story"]
			local var_631_12 = 0

			if var_631_12 < arg_628_1.time_ and arg_628_1.time_ <= var_631_12 + arg_631_0 and not isNil(var_631_11) and arg_628_1.var_.characterEffect1096ui_story == nil then
				arg_628_1.var_.characterEffect1096ui_story = var_631_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_631_13 = 0.2

			if var_631_12 <= arg_628_1.time_ and arg_628_1.time_ < var_631_12 + var_631_13 and not isNil(var_631_11) then
				local var_631_14 = (arg_628_1.time_ - var_631_12) / var_631_13

				if arg_628_1.var_.characterEffect1096ui_story and not isNil(var_631_11) then
					arg_628_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_628_1.time_ >= var_631_12 + var_631_13 and arg_628_1.time_ < var_631_12 + var_631_13 + arg_631_0 and not isNil(var_631_11) and arg_628_1.var_.characterEffect1096ui_story then
				arg_628_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_631_15 = 0
			local var_631_16 = 0.5

			if var_631_15 < arg_628_1.time_ and arg_628_1.time_ <= var_631_15 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				local var_631_17 = arg_628_1:FormatText(StoryNameCfg[169].name)

				arg_628_1.leftNameTxt_.text = var_631_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, false)
				arg_628_1.callingController_:SetSelectedState("normal")

				local var_631_18 = arg_628_1:GetWordFromCfg(910201154)
				local var_631_19 = arg_628_1:FormatText(var_631_18.content)

				arg_628_1.text_.text = var_631_19

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_20 = 20
				local var_631_21 = utf8.len(var_631_19)
				local var_631_22 = var_631_20 <= 0 and var_631_16 or var_631_16 * (var_631_21 / var_631_20)

				if var_631_22 > 0 and var_631_16 < var_631_22 then
					arg_628_1.talkMaxDuration = var_631_22

					if var_631_22 + var_631_15 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_22 + var_631_15
					end
				end

				arg_628_1.text_.text = var_631_19
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)
				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_23 = math.max(var_631_16, arg_628_1.talkMaxDuration)

			if var_631_15 <= arg_628_1.time_ and arg_628_1.time_ < var_631_15 + var_631_23 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_15) / var_631_23

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_15 + var_631_23 and arg_628_1.time_ < var_631_15 + var_631_23 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_628_1:InitPlayNodeList()
	end,
	Play910201155 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 910201155
		arg_632_1.duration_ = 5

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play910201156(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			local var_635_0 = arg_632_1.actors_["1096ui_story"]
			local var_635_1 = 0

			if var_635_1 < arg_632_1.time_ and arg_632_1.time_ <= var_635_1 + arg_635_0 and not isNil(var_635_0) and arg_632_1.var_.characterEffect1096ui_story == nil then
				arg_632_1.var_.characterEffect1096ui_story = var_635_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_635_2 = 0.2

			if var_635_1 <= arg_632_1.time_ and arg_632_1.time_ < var_635_1 + var_635_2 and not isNil(var_635_0) then
				local var_635_3 = (arg_632_1.time_ - var_635_1) / var_635_2

				if arg_632_1.var_.characterEffect1096ui_story and not isNil(var_635_0) then
					local var_635_4 = Mathf.Lerp(0, 0.5, var_635_3)

					arg_632_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_632_1.var_.characterEffect1096ui_story.fillRatio = var_635_4
				end
			end

			if arg_632_1.time_ >= var_635_1 + var_635_2 and arg_632_1.time_ < var_635_1 + var_635_2 + arg_635_0 and not isNil(var_635_0) and arg_632_1.var_.characterEffect1096ui_story then
				local var_635_5 = 0.5

				arg_632_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_632_1.var_.characterEffect1096ui_story.fillRatio = var_635_5
			end

			local var_635_6 = 0
			local var_635_7 = 0.575

			if var_635_6 < arg_632_1.time_ and arg_632_1.time_ <= var_635_6 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				local var_635_8 = arg_632_1:FormatText(StoryNameCfg[7].name)

				arg_632_1.leftNameTxt_.text = var_635_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, true)
				arg_632_1.iconController_:SetSelectedState("hero")

				arg_632_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_632_1.callingController_:SetSelectedState("normal")

				arg_632_1.keyicon_.color = Color.New(1, 1, 1)
				arg_632_1.icon_.color = Color.New(1, 1, 1)

				local var_635_9 = arg_632_1:GetWordFromCfg(910201155)
				local var_635_10 = arg_632_1:FormatText(var_635_9.content)

				arg_632_1.text_.text = var_635_10

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_11 = 23
				local var_635_12 = utf8.len(var_635_10)
				local var_635_13 = var_635_11 <= 0 and var_635_7 or var_635_7 * (var_635_12 / var_635_11)

				if var_635_13 > 0 and var_635_7 < var_635_13 then
					arg_632_1.talkMaxDuration = var_635_13

					if var_635_13 + var_635_6 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_13 + var_635_6
					end
				end

				arg_632_1.text_.text = var_635_10
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)
				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_14 = math.max(var_635_7, arg_632_1.talkMaxDuration)

			if var_635_6 <= arg_632_1.time_ and arg_632_1.time_ < var_635_6 + var_635_14 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_6) / var_635_14

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_6 + var_635_14 and arg_632_1.time_ < var_635_6 + var_635_14 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play910201156 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 910201156
		arg_636_1.duration_ = 5

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play910201157(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = arg_636_1.actors_["1096ui_story"]
			local var_639_1 = 0

			if var_639_1 < arg_636_1.time_ and arg_636_1.time_ <= var_639_1 + arg_639_0 and not isNil(var_639_0) and arg_636_1.var_.characterEffect1096ui_story == nil then
				arg_636_1.var_.characterEffect1096ui_story = var_639_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_639_2 = 0.2

			if var_639_1 <= arg_636_1.time_ and arg_636_1.time_ < var_639_1 + var_639_2 and not isNil(var_639_0) then
				local var_639_3 = (arg_636_1.time_ - var_639_1) / var_639_2

				if arg_636_1.var_.characterEffect1096ui_story and not isNil(var_639_0) then
					arg_636_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_636_1.time_ >= var_639_1 + var_639_2 and arg_636_1.time_ < var_639_1 + var_639_2 + arg_639_0 and not isNil(var_639_0) and arg_636_1.var_.characterEffect1096ui_story then
				arg_636_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_639_4 = 0

			if var_639_4 < arg_636_1.time_ and arg_636_1.time_ <= var_639_4 + arg_639_0 then
				arg_636_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096actionlink/1096action452")
			end

			local var_639_5 = 0

			if var_639_5 < arg_636_1.time_ and arg_636_1.time_ <= var_639_5 + arg_639_0 then
				arg_636_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_639_6 = 0
			local var_639_7 = 0.35

			if var_639_6 < arg_636_1.time_ and arg_636_1.time_ <= var_639_6 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				local var_639_8 = arg_636_1:FormatText(StoryNameCfg[169].name)

				arg_636_1.leftNameTxt_.text = var_639_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_9 = arg_636_1:GetWordFromCfg(910201156)
				local var_639_10 = arg_636_1:FormatText(var_639_9.content)

				arg_636_1.text_.text = var_639_10

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_11 = 14
				local var_639_12 = utf8.len(var_639_10)
				local var_639_13 = var_639_11 <= 0 and var_639_7 or var_639_7 * (var_639_12 / var_639_11)

				if var_639_13 > 0 and var_639_7 < var_639_13 then
					arg_636_1.talkMaxDuration = var_639_13

					if var_639_13 + var_639_6 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_13 + var_639_6
					end
				end

				arg_636_1.text_.text = var_639_10
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)
				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_14 = math.max(var_639_7, arg_636_1.talkMaxDuration)

			if var_639_6 <= arg_636_1.time_ and arg_636_1.time_ < var_639_6 + var_639_14 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_6) / var_639_14

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_6 + var_639_14 and arg_636_1.time_ < var_639_6 + var_639_14 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play910201157 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 910201157
		arg_640_1.duration_ = 5

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play910201158(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			local var_643_0 = arg_640_1.actors_["1096ui_story"]
			local var_643_1 = 0

			if var_643_1 < arg_640_1.time_ and arg_640_1.time_ <= var_643_1 + arg_643_0 and not isNil(var_643_0) and arg_640_1.var_.characterEffect1096ui_story == nil then
				arg_640_1.var_.characterEffect1096ui_story = var_643_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_643_2 = 0.2

			if var_643_1 <= arg_640_1.time_ and arg_640_1.time_ < var_643_1 + var_643_2 and not isNil(var_643_0) then
				local var_643_3 = (arg_640_1.time_ - var_643_1) / var_643_2

				if arg_640_1.var_.characterEffect1096ui_story and not isNil(var_643_0) then
					local var_643_4 = Mathf.Lerp(0, 0.5, var_643_3)

					arg_640_1.var_.characterEffect1096ui_story.fillFlat = true
					arg_640_1.var_.characterEffect1096ui_story.fillRatio = var_643_4
				end
			end

			if arg_640_1.time_ >= var_643_1 + var_643_2 and arg_640_1.time_ < var_643_1 + var_643_2 + arg_643_0 and not isNil(var_643_0) and arg_640_1.var_.characterEffect1096ui_story then
				local var_643_5 = 0.5

				arg_640_1.var_.characterEffect1096ui_story.fillFlat = true
				arg_640_1.var_.characterEffect1096ui_story.fillRatio = var_643_5
			end

			local var_643_6 = 0
			local var_643_7 = 0.35

			if var_643_6 < arg_640_1.time_ and arg_640_1.time_ <= var_643_6 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, true)

				local var_643_8 = arg_640_1:FormatText(StoryNameCfg[7].name)

				arg_640_1.leftNameTxt_.text = var_643_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_640_1.leftNameTxt_.transform)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1.leftNameTxt_.text)
				SetActive(arg_640_1.iconTrs_.gameObject, true)
				arg_640_1.iconController_:SetSelectedState("hero")

				arg_640_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_640_1.callingController_:SetSelectedState("normal")

				arg_640_1.keyicon_.color = Color.New(1, 1, 1)
				arg_640_1.icon_.color = Color.New(1, 1, 1)

				local var_643_9 = arg_640_1:GetWordFromCfg(910201157)
				local var_643_10 = arg_640_1:FormatText(var_643_9.content)

				arg_640_1.text_.text = var_643_10

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_11 = 14
				local var_643_12 = utf8.len(var_643_10)
				local var_643_13 = var_643_11 <= 0 and var_643_7 or var_643_7 * (var_643_12 / var_643_11)

				if var_643_13 > 0 and var_643_7 < var_643_13 then
					arg_640_1.talkMaxDuration = var_643_13

					if var_643_13 + var_643_6 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_13 + var_643_6
					end
				end

				arg_640_1.text_.text = var_643_10
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)
				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_14 = math.max(var_643_7, arg_640_1.talkMaxDuration)

			if var_643_6 <= arg_640_1.time_ and arg_640_1.time_ < var_643_6 + var_643_14 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_6) / var_643_14

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_6 + var_643_14 and arg_640_1.time_ < var_643_6 + var_643_14 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {}

		arg_640_1:InitPlayNodeList()
	end,
	Play910201158 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 910201158
		arg_644_1.duration_ = 7

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play910201159(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			local var_647_0 = 0

			if var_647_0 < arg_644_1.time_ and arg_644_1.time_ <= var_647_0 + arg_647_0 then
				arg_644_1.mask_.enabled = true
				arg_644_1.mask_.raycastTarget = true

				arg_644_1:SetGaussion(false)
			end

			local var_647_1 = 2

			if var_647_0 <= arg_644_1.time_ and arg_644_1.time_ < var_647_0 + var_647_1 then
				local var_647_2 = (arg_644_1.time_ - var_647_0) / var_647_1
				local var_647_3 = Color.New(1, 1, 1)

				var_647_3.a = Mathf.Lerp(1, 0, var_647_2)
				arg_644_1.mask_.color = var_647_3
			end

			if arg_644_1.time_ >= var_647_0 + var_647_1 and arg_644_1.time_ < var_647_0 + var_647_1 + arg_647_0 then
				local var_647_4 = Color.New(1, 1, 1)
				local var_647_5 = 0

				arg_644_1.mask_.enabled = false
				var_647_4.a = var_647_5
				arg_644_1.mask_.color = var_647_4
			end

			local var_647_6 = arg_644_1.actors_["1096ui_story"].transform
			local var_647_7 = 0

			if var_647_7 < arg_644_1.time_ and arg_644_1.time_ <= var_647_7 + arg_647_0 then
				arg_644_1.var_.moveOldPos1096ui_story = var_647_6.localPosition
			end

			local var_647_8 = 0.001

			if var_647_7 <= arg_644_1.time_ and arg_644_1.time_ < var_647_7 + var_647_8 then
				local var_647_9 = (arg_644_1.time_ - var_647_7) / var_647_8
				local var_647_10 = Vector3.New(0, 100, 0)

				var_647_6.localPosition = Vector3.Lerp(arg_644_1.var_.moveOldPos1096ui_story, var_647_10, var_647_9)

				local var_647_11 = manager.ui.mainCamera.transform.position - var_647_6.position

				var_647_6.forward = Vector3.New(var_647_11.x, var_647_11.y, var_647_11.z)

				local var_647_12 = var_647_6.localEulerAngles

				var_647_12.z = 0
				var_647_12.x = 0
				var_647_6.localEulerAngles = var_647_12
			end

			if arg_644_1.time_ >= var_647_7 + var_647_8 and arg_644_1.time_ < var_647_7 + var_647_8 + arg_647_0 then
				var_647_6.localPosition = Vector3.New(0, 100, 0)

				local var_647_13 = manager.ui.mainCamera.transform.position - var_647_6.position

				var_647_6.forward = Vector3.New(var_647_13.x, var_647_13.y, var_647_13.z)

				local var_647_14 = var_647_6.localEulerAngles

				var_647_14.z = 0
				var_647_14.x = 0
				var_647_6.localEulerAngles = var_647_14
			end

			local var_647_15 = arg_644_1.bgs_.ST05
			local var_647_16 = 0

			if var_647_16 < arg_644_1.time_ and arg_644_1.time_ <= var_647_16 + arg_647_0 then
				local var_647_17 = var_647_15:GetComponent("SpriteRenderer")

				if var_647_17 then
					arg_644_1.var_.alphaOldValueST05 = var_647_17.color.a
					arg_644_1.var_.alphaMatValueST05 = var_647_17
				end

				arg_644_1.var_.alphaOldValueST05 = 0
			end

			local var_647_18 = 3.2

			if var_647_16 <= arg_644_1.time_ and arg_644_1.time_ < var_647_16 + var_647_18 then
				local var_647_19 = (arg_644_1.time_ - var_647_16) / var_647_18
				local var_647_20 = Mathf.Lerp(arg_644_1.var_.alphaOldValueST05, 1, var_647_19)

				if arg_644_1.var_.alphaMatValueST05 then
					local var_647_21 = arg_644_1.var_.alphaMatValueST05.color

					var_647_21.a = var_647_20
					arg_644_1.var_.alphaMatValueST05.color = var_647_21
				end
			end

			if arg_644_1.time_ >= var_647_16 + var_647_18 and arg_644_1.time_ < var_647_16 + var_647_18 + arg_647_0 and arg_644_1.var_.alphaMatValueST05 then
				local var_647_22 = arg_644_1.var_.alphaMatValueST05
				local var_647_23 = var_647_22.color

				var_647_23.a = 1
				var_647_22.color = var_647_23
			end

			local var_647_24 = 2
			local var_647_25 = 0.075

			if var_647_24 < arg_644_1.time_ and arg_644_1.time_ <= var_647_24 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, false)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_644_1.iconTrs_.gameObject, false)
				arg_644_1.callingController_:SetSelectedState("normal")

				local var_647_26 = arg_644_1:GetWordFromCfg(910201158)
				local var_647_27 = arg_644_1:FormatText(var_647_26.content)

				arg_644_1.text_.text = var_647_27

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_28 = 3
				local var_647_29 = utf8.len(var_647_27)
				local var_647_30 = var_647_28 <= 0 and var_647_25 or var_647_25 * (var_647_29 / var_647_28)

				if var_647_30 > 0 and var_647_25 < var_647_30 then
					arg_644_1.talkMaxDuration = var_647_30

					if var_647_30 + var_647_24 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_30 + var_647_24
					end
				end

				arg_644_1.text_.text = var_647_27
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)
				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_31 = math.max(var_647_25, arg_644_1.talkMaxDuration)

			if var_647_24 <= arg_644_1.time_ and arg_644_1.time_ < var_647_24 + var_647_31 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - var_647_24) / var_647_31

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= var_647_24 + var_647_31 and arg_644_1.time_ < var_647_24 + var_647_31 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_644_1:InitPlayNodeList()
	end,
	Play910201159 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 910201159
		arg_648_1.duration_ = 5

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play910201160(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			local var_651_0 = 0
			local var_651_1 = 0.35

			if var_651_0 < arg_648_1.time_ and arg_648_1.time_ <= var_651_0 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				local var_651_2 = arg_648_1:FormatText(StoryNameCfg[7].name)

				arg_648_1.leftNameTxt_.text = var_651_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, true)
				arg_648_1.iconController_:SetSelectedState("hero")

				arg_648_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_648_1.callingController_:SetSelectedState("normal")

				arg_648_1.keyicon_.color = Color.New(1, 1, 1)
				arg_648_1.icon_.color = Color.New(1, 1, 1)

				local var_651_3 = arg_648_1:GetWordFromCfg(910201159)
				local var_651_4 = arg_648_1:FormatText(var_651_3.content)

				arg_648_1.text_.text = var_651_4

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_5 = 14
				local var_651_6 = utf8.len(var_651_4)
				local var_651_7 = var_651_5 <= 0 and var_651_1 or var_651_1 * (var_651_6 / var_651_5)

				if var_651_7 > 0 and var_651_1 < var_651_7 then
					arg_648_1.talkMaxDuration = var_651_7

					if var_651_7 + var_651_0 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_7 + var_651_0
					end
				end

				arg_648_1.text_.text = var_651_4
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)
				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_8 = math.max(var_651_1, arg_648_1.talkMaxDuration)

			if var_651_0 <= arg_648_1.time_ and arg_648_1.time_ < var_651_0 + var_651_8 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - var_651_0) / var_651_8

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= var_651_0 + var_651_8 and arg_648_1.time_ < var_651_0 + var_651_8 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {}

		arg_648_1:InitPlayNodeList()
	end,
	Play910201160 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 910201160
		arg_652_1.duration_ = 5

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play910201161(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = 0

			if var_655_0 < arg_652_1.time_ and arg_652_1.time_ <= var_655_0 + arg_655_0 then
				arg_652_1.mask_.enabled = true
				arg_652_1.mask_.raycastTarget = true

				arg_652_1:SetGaussion(false)
			end

			local var_655_1 = 2

			if var_655_0 <= arg_652_1.time_ and arg_652_1.time_ < var_655_0 + var_655_1 then
				local var_655_2 = (arg_652_1.time_ - var_655_0) / var_655_1
				local var_655_3 = Color.New(1, 1, 1)

				var_655_3.a = Mathf.Lerp(1, 0, var_655_2)
				arg_652_1.mask_.color = var_655_3
			end

			if arg_652_1.time_ >= var_655_0 + var_655_1 and arg_652_1.time_ < var_655_0 + var_655_1 + arg_655_0 then
				local var_655_4 = Color.New(1, 1, 1)
				local var_655_5 = 0

				arg_652_1.mask_.enabled = false
				var_655_4.a = var_655_5
				arg_652_1.mask_.color = var_655_4
			end

			local var_655_6 = 0
			local var_655_7 = 1

			if var_655_6 < arg_652_1.time_ and arg_652_1.time_ <= var_655_6 + arg_655_0 then
				local var_655_8 = "play"
				local var_655_9 = "effect"

				arg_652_1:AudioAction(var_655_8, var_655_9, "se_story_birthday", "se_story_birthday_kaideng", "")
			end

			local var_655_10 = 0
			local var_655_11 = 0.075

			if var_655_10 < arg_652_1.time_ and arg_652_1.time_ <= var_655_10 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, false)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_12 = arg_652_1:GetWordFromCfg(910201160)
				local var_655_13 = arg_652_1:FormatText(var_655_12.content)

				arg_652_1.text_.text = var_655_13

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_14 = 3
				local var_655_15 = utf8.len(var_655_13)
				local var_655_16 = var_655_14 <= 0 and var_655_11 or var_655_11 * (var_655_15 / var_655_14)

				if var_655_16 > 0 and var_655_11 < var_655_16 then
					arg_652_1.talkMaxDuration = var_655_16

					if var_655_16 + var_655_10 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_16 + var_655_10
					end
				end

				arg_652_1.text_.text = var_655_13
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)
				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_17 = math.max(var_655_11, arg_652_1.talkMaxDuration)

			if var_655_10 <= arg_652_1.time_ and arg_652_1.time_ < var_655_10 + var_655_17 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_10) / var_655_17

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_10 + var_655_17 and arg_652_1.time_ < var_655_10 + var_655_17 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play910201161 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 910201161
		arg_656_1.duration_ = 5

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play910201162(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			local var_659_0 = 0
			local var_659_1 = 1

			if var_659_0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_0 + arg_659_0 then
				local var_659_2 = "play"
				local var_659_3 = "effect"

				arg_656_1:AudioAction(var_659_2, var_659_3, "se_story_birthday", "se_story_birthday_lapao", "")
			end

			local var_659_4 = 0
			local var_659_5 = 0.1

			if var_659_4 < arg_656_1.time_ and arg_656_1.time_ <= var_659_4 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, false)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_6 = arg_656_1:GetWordFromCfg(910201161)
				local var_659_7 = arg_656_1:FormatText(var_659_6.content)

				arg_656_1.text_.text = var_659_7

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_8 = 4
				local var_659_9 = utf8.len(var_659_7)
				local var_659_10 = var_659_8 <= 0 and var_659_5 or var_659_5 * (var_659_9 / var_659_8)

				if var_659_10 > 0 and var_659_5 < var_659_10 then
					arg_656_1.talkMaxDuration = var_659_10

					if var_659_10 + var_659_4 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_10 + var_659_4
					end
				end

				arg_656_1.text_.text = var_659_7
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)
				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_11 = math.max(var_659_5, arg_656_1.talkMaxDuration)

			if var_659_4 <= arg_656_1.time_ and arg_656_1.time_ < var_659_4 + var_659_11 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_4) / var_659_11

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_4 + var_659_11 and arg_656_1.time_ < var_659_4 + var_659_11 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {}

		arg_656_1:InitPlayNodeList()
	end,
	Play910201162 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 910201162
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play910201163(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = 0
			local var_663_1 = 0.2

			if var_663_0 < arg_660_1.time_ and arg_660_1.time_ <= var_663_0 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, true)

				local var_663_2 = arg_660_1:FormatText(StoryNameCfg[330].name)

				arg_660_1.leftNameTxt_.text = var_663_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_660_1.leftNameTxt_.transform)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1.leftNameTxt_.text)
				SetActive(arg_660_1.iconTrs_.gameObject, false)
				arg_660_1.callingController_:SetSelectedState("normal")

				local var_663_3 = arg_660_1:GetWordFromCfg(910201162)
				local var_663_4 = arg_660_1:FormatText(var_663_3.content)

				arg_660_1.text_.text = var_663_4

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_5 = 8
				local var_663_6 = utf8.len(var_663_4)
				local var_663_7 = var_663_5 <= 0 and var_663_1 or var_663_1 * (var_663_6 / var_663_5)

				if var_663_7 > 0 and var_663_1 < var_663_7 then
					arg_660_1.talkMaxDuration = var_663_7

					if var_663_7 + var_663_0 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_7 + var_663_0
					end
				end

				arg_660_1.text_.text = var_663_4
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_8 = math.max(var_663_1, arg_660_1.talkMaxDuration)

			if var_663_0 <= arg_660_1.time_ and arg_660_1.time_ < var_663_0 + var_663_8 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_0) / var_663_8

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_0 + var_663_8 and arg_660_1.time_ < var_663_0 + var_663_8 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play910201163 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 910201163
		arg_664_1.duration_ = 5

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play910201164(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = 0
			local var_667_1 = 1

			if var_667_0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_0 + arg_667_0 then
				local var_667_2 = "play"
				local var_667_3 = "music"

				arg_664_1:AudioAction(var_667_2, var_667_3, "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_667_4 = ""
				local var_667_5 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

				if var_667_5 ~= "" then
					if arg_664_1.bgmTxt_.text ~= var_667_5 and arg_664_1.bgmTxt_.text ~= "" then
						if arg_664_1.bgmTxt2_.text ~= "" then
							arg_664_1.bgmTxt_.text = arg_664_1.bgmTxt2_.text
						end

						arg_664_1.bgmTxt2_.text = var_667_5

						arg_664_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_664_1.bgmTxt_.text = var_667_5
						arg_664_1.bgmTxt2_.text = var_667_5
					end

					if arg_664_1.bgmTimer then
						arg_664_1.bgmTimer:Stop()

						arg_664_1.bgmTimer = nil
					end

					if arg_664_1.settingData.show_music_name == 1 then
						arg_664_1.musicController:SetSelectedState("show")
						arg_664_1.musicAnimator_:Play("open", 0, 0)

						if arg_664_1.settingData.music_time ~= 0 then
							arg_664_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_664_1.settingData.music_time), function()
								if arg_664_1 == nil or isNil(arg_664_1.bgmTxt_) then
									return
								end

								arg_664_1.musicController:SetSelectedState("hide")
								arg_664_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_667_6 = 0
			local var_667_7 = 0.2

			if var_667_6 < arg_664_1.time_ and arg_664_1.time_ <= var_667_6 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, true)

				local var_667_8 = arg_664_1:FormatText(StoryNameCfg[330].name)

				arg_664_1.leftNameTxt_.text = var_667_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_664_1.leftNameTxt_.transform)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1.leftNameTxt_.text)
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_9 = arg_664_1:GetWordFromCfg(910201163)
				local var_667_10 = arg_664_1:FormatText(var_667_9.content)

				arg_664_1.text_.text = var_667_10

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_11 = 8
				local var_667_12 = utf8.len(var_667_10)
				local var_667_13 = var_667_11 <= 0 and var_667_7 or var_667_7 * (var_667_12 / var_667_11)

				if var_667_13 > 0 and var_667_7 < var_667_13 then
					arg_664_1.talkMaxDuration = var_667_13

					if var_667_13 + var_667_6 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_13 + var_667_6
					end
				end

				arg_664_1.text_.text = var_667_10
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)
				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_14 = math.max(var_667_7, arg_664_1.talkMaxDuration)

			if var_667_6 <= arg_664_1.time_ and arg_664_1.time_ < var_667_6 + var_667_14 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - var_667_6) / var_667_14

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= var_667_6 + var_667_14 and arg_664_1.time_ < var_667_6 + var_667_14 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	Play910201164 = function(arg_669_0, arg_669_1)
		arg_669_1.time_ = 0
		arg_669_1.frameCnt_ = 0
		arg_669_1.state_ = "playing"
		arg_669_1.curTalkId_ = 910201164
		arg_669_1.duration_ = 5

		SetActive(arg_669_1.tipsGo_, false)

		function arg_669_1.onSingleLineFinish_()
			arg_669_1.onSingleLineUpdate_ = nil
			arg_669_1.onSingleLineFinish_ = nil
			arg_669_1.state_ = "waiting"
		end

		function arg_669_1.playNext_(arg_671_0)
			if arg_671_0 == 1 then
				arg_669_0:Play910201165(arg_669_1)
			end
		end

		function arg_669_1.onSingleLineUpdate_(arg_672_0)
			local var_672_0 = 0
			local var_672_1 = 0.975

			if var_672_0 < arg_669_1.time_ and arg_669_1.time_ <= var_672_0 + arg_672_0 then
				arg_669_1.talkMaxDuration = 0
				arg_669_1.dialogCg_.alpha = 1

				arg_669_1.dialog_:SetActive(true)
				SetActive(arg_669_1.leftNameGo_, false)

				arg_669_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_669_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_669_1:RecordName(arg_669_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_669_1.iconTrs_.gameObject, false)
				arg_669_1.callingController_:SetSelectedState("normal")

				local var_672_2 = arg_669_1:GetWordFromCfg(910201164)
				local var_672_3 = arg_669_1:FormatText(var_672_2.content)

				arg_669_1.text_.text = var_672_3

				LuaForUtil.ClearLinePrefixSymbol(arg_669_1.text_)

				local var_672_4 = 39
				local var_672_5 = utf8.len(var_672_3)
				local var_672_6 = var_672_4 <= 0 and var_672_1 or var_672_1 * (var_672_5 / var_672_4)

				if var_672_6 > 0 and var_672_1 < var_672_6 then
					arg_669_1.talkMaxDuration = var_672_6

					if var_672_6 + var_672_0 > arg_669_1.duration_ then
						arg_669_1.duration_ = var_672_6 + var_672_0
					end
				end

				arg_669_1.text_.text = var_672_3
				arg_669_1.typewritter.percent = 0

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(false)
				arg_669_1:RecordContent(arg_669_1.text_.text)
			end

			local var_672_7 = math.max(var_672_1, arg_669_1.talkMaxDuration)

			if var_672_0 <= arg_669_1.time_ and arg_669_1.time_ < var_672_0 + var_672_7 then
				arg_669_1.typewritter.percent = (arg_669_1.time_ - var_672_0) / var_672_7

				arg_669_1.typewritter:SetDirty()
			end

			if arg_669_1.time_ >= var_672_0 + var_672_7 and arg_669_1.time_ < var_672_0 + var_672_7 + arg_672_0 then
				arg_669_1.typewritter.percent = 1

				arg_669_1.typewritter:SetDirty()
				arg_669_1:ShowNextGo(true)
			end
		end

		arg_669_1.nodeConfigList_ = {}

		arg_669_1:InitPlayNodeList()
	end,
	Play910201165 = function(arg_673_0, arg_673_1)
		arg_673_1.time_ = 0
		arg_673_1.frameCnt_ = 0
		arg_673_1.state_ = "playing"
		arg_673_1.curTalkId_ = 910201165
		arg_673_1.duration_ = 5

		SetActive(arg_673_1.tipsGo_, false)

		function arg_673_1.onSingleLineFinish_()
			arg_673_1.onSingleLineUpdate_ = nil
			arg_673_1.onSingleLineFinish_ = nil
			arg_673_1.state_ = "waiting"
		end

		function arg_673_1.playNext_(arg_675_0)
			if arg_675_0 == 1 then
				arg_673_0:Play910201166(arg_673_1)
			end
		end

		function arg_673_1.onSingleLineUpdate_(arg_676_0)
			local var_676_0 = 0
			local var_676_1 = 0.3

			if var_676_0 < arg_673_1.time_ and arg_673_1.time_ <= var_676_0 + arg_676_0 then
				arg_673_1.talkMaxDuration = 0
				arg_673_1.dialogCg_.alpha = 1

				arg_673_1.dialog_:SetActive(true)
				SetActive(arg_673_1.leftNameGo_, true)

				local var_676_2 = arg_673_1:FormatText(StoryNameCfg[7].name)

				arg_673_1.leftNameTxt_.text = var_676_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_673_1.leftNameTxt_.transform)

				arg_673_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_673_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_673_1:RecordName(arg_673_1.leftNameTxt_.text)
				SetActive(arg_673_1.iconTrs_.gameObject, true)
				arg_673_1.iconController_:SetSelectedState("hero")

				arg_673_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_673_1.callingController_:SetSelectedState("normal")

				arg_673_1.keyicon_.color = Color.New(1, 1, 1)
				arg_673_1.icon_.color = Color.New(1, 1, 1)

				local var_676_3 = arg_673_1:GetWordFromCfg(910201165)
				local var_676_4 = arg_673_1:FormatText(var_676_3.content)

				arg_673_1.text_.text = var_676_4

				LuaForUtil.ClearLinePrefixSymbol(arg_673_1.text_)

				local var_676_5 = 12
				local var_676_6 = utf8.len(var_676_4)
				local var_676_7 = var_676_5 <= 0 and var_676_1 or var_676_1 * (var_676_6 / var_676_5)

				if var_676_7 > 0 and var_676_1 < var_676_7 then
					arg_673_1.talkMaxDuration = var_676_7

					if var_676_7 + var_676_0 > arg_673_1.duration_ then
						arg_673_1.duration_ = var_676_7 + var_676_0
					end
				end

				arg_673_1.text_.text = var_676_4
				arg_673_1.typewritter.percent = 0

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(false)
				arg_673_1:RecordContent(arg_673_1.text_.text)
			end

			local var_676_8 = math.max(var_676_1, arg_673_1.talkMaxDuration)

			if var_676_0 <= arg_673_1.time_ and arg_673_1.time_ < var_676_0 + var_676_8 then
				arg_673_1.typewritter.percent = (arg_673_1.time_ - var_676_0) / var_676_8

				arg_673_1.typewritter:SetDirty()
			end

			if arg_673_1.time_ >= var_676_0 + var_676_8 and arg_673_1.time_ < var_676_0 + var_676_8 + arg_676_0 then
				arg_673_1.typewritter.percent = 1

				arg_673_1.typewritter:SetDirty()
				arg_673_1:ShowNextGo(true)
			end
		end

		arg_673_1.nodeConfigList_ = {}

		arg_673_1:InitPlayNodeList()
	end,
	Play910201166 = function(arg_677_0, arg_677_1)
		arg_677_1.time_ = 0
		arg_677_1.frameCnt_ = 0
		arg_677_1.state_ = "playing"
		arg_677_1.curTalkId_ = 910201166
		arg_677_1.duration_ = 5

		SetActive(arg_677_1.tipsGo_, false)

		function arg_677_1.onSingleLineFinish_()
			arg_677_1.onSingleLineUpdate_ = nil
			arg_677_1.onSingleLineFinish_ = nil
			arg_677_1.state_ = "waiting"
		end

		function arg_677_1.playNext_(arg_679_0)
			if arg_679_0 == 1 then
				arg_677_0:Play910201167(arg_677_1)
			end
		end

		function arg_677_1.onSingleLineUpdate_(arg_680_0)
			local var_680_0 = "1036ui_story"

			if arg_677_1.actors_[var_680_0] == nil then
				local var_680_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_680_1) then
					local var_680_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_677_1.stage_.transform)

					var_680_2.name = var_680_0
					var_680_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_677_1.actors_[var_680_0] = var_680_2

					local var_680_3 = var_680_2:GetComponentInChildren(typeof(CharacterEffect))

					var_680_3.enabled = true

					local var_680_4 = GameObjectTools.GetOrAddComponent(var_680_2, typeof(DynamicBoneHelper))

					if var_680_4 then
						var_680_4:EnableDynamicBone(false)
					end

					arg_677_1:ShowWeapon(var_680_3.transform, false)

					arg_677_1.var_[var_680_0 .. "Animator"] = var_680_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_677_1.var_[var_680_0 .. "Animator"].applyRootMotion = true
					arg_677_1.var_[var_680_0 .. "LipSync"] = var_680_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_680_5 = arg_677_1.actors_["1036ui_story"].transform
			local var_680_6 = 0

			if var_680_6 < arg_677_1.time_ and arg_677_1.time_ <= var_680_6 + arg_680_0 then
				arg_677_1.var_.moveOldPos1036ui_story = var_680_5.localPosition
			end

			local var_680_7 = 0.001

			if var_680_6 <= arg_677_1.time_ and arg_677_1.time_ < var_680_6 + var_680_7 then
				local var_680_8 = (arg_677_1.time_ - var_680_6) / var_680_7
				local var_680_9 = Vector3.New(0, -1.09, -5.78)

				var_680_5.localPosition = Vector3.Lerp(arg_677_1.var_.moveOldPos1036ui_story, var_680_9, var_680_8)

				local var_680_10 = manager.ui.mainCamera.transform.position - var_680_5.position

				var_680_5.forward = Vector3.New(var_680_10.x, var_680_10.y, var_680_10.z)

				local var_680_11 = var_680_5.localEulerAngles

				var_680_11.z = 0
				var_680_11.x = 0
				var_680_5.localEulerAngles = var_680_11
			end

			if arg_677_1.time_ >= var_680_6 + var_680_7 and arg_677_1.time_ < var_680_6 + var_680_7 + arg_680_0 then
				var_680_5.localPosition = Vector3.New(0, -1.09, -5.78)

				local var_680_12 = manager.ui.mainCamera.transform.position - var_680_5.position

				var_680_5.forward = Vector3.New(var_680_12.x, var_680_12.y, var_680_12.z)

				local var_680_13 = var_680_5.localEulerAngles

				var_680_13.z = 0
				var_680_13.x = 0
				var_680_5.localEulerAngles = var_680_13
			end

			local var_680_14 = arg_677_1.actors_["1036ui_story"]
			local var_680_15 = 0

			if var_680_15 < arg_677_1.time_ and arg_677_1.time_ <= var_680_15 + arg_680_0 and not isNil(var_680_14) and arg_677_1.var_.characterEffect1036ui_story == nil then
				arg_677_1.var_.characterEffect1036ui_story = var_680_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_680_16 = 0.2

			if var_680_15 <= arg_677_1.time_ and arg_677_1.time_ < var_680_15 + var_680_16 and not isNil(var_680_14) then
				local var_680_17 = (arg_677_1.time_ - var_680_15) / var_680_16

				if arg_677_1.var_.characterEffect1036ui_story and not isNil(var_680_14) then
					arg_677_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_677_1.time_ >= var_680_15 + var_680_16 and arg_677_1.time_ < var_680_15 + var_680_16 + arg_680_0 and not isNil(var_680_14) and arg_677_1.var_.characterEffect1036ui_story then
				arg_677_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_680_18 = 0

			if var_680_18 < arg_677_1.time_ and arg_677_1.time_ <= var_680_18 + arg_680_0 then
				arg_677_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			local var_680_19 = 0

			if var_680_19 < arg_677_1.time_ and arg_677_1.time_ <= var_680_19 + arg_680_0 then
				arg_677_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_680_20 = 0
			local var_680_21 = 1

			if var_680_20 < arg_677_1.time_ and arg_677_1.time_ <= var_680_20 + arg_680_0 then
				arg_677_1.talkMaxDuration = 0
				arg_677_1.dialogCg_.alpha = 1

				arg_677_1.dialog_:SetActive(true)
				SetActive(arg_677_1.leftNameGo_, true)

				local var_680_22 = arg_677_1:FormatText(StoryNameCfg[5].name)

				arg_677_1.leftNameTxt_.text = var_680_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_677_1.leftNameTxt_.transform)

				arg_677_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_677_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_677_1:RecordName(arg_677_1.leftNameTxt_.text)
				SetActive(arg_677_1.iconTrs_.gameObject, false)
				arg_677_1.callingController_:SetSelectedState("normal")

				local var_680_23 = arg_677_1:GetWordFromCfg(910201166)
				local var_680_24 = arg_677_1:FormatText(var_680_23.content)

				arg_677_1.text_.text = var_680_24

				LuaForUtil.ClearLinePrefixSymbol(arg_677_1.text_)

				local var_680_25 = 40
				local var_680_26 = utf8.len(var_680_24)
				local var_680_27 = var_680_25 <= 0 and var_680_21 or var_680_21 * (var_680_26 / var_680_25)

				if var_680_27 > 0 and var_680_21 < var_680_27 then
					arg_677_1.talkMaxDuration = var_680_27

					if var_680_27 + var_680_20 > arg_677_1.duration_ then
						arg_677_1.duration_ = var_680_27 + var_680_20
					end
				end

				arg_677_1.text_.text = var_680_24
				arg_677_1.typewritter.percent = 0

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(false)
				arg_677_1:RecordContent(arg_677_1.text_.text)
			end

			local var_680_28 = math.max(var_680_21, arg_677_1.talkMaxDuration)

			if var_680_20 <= arg_677_1.time_ and arg_677_1.time_ < var_680_20 + var_680_28 then
				arg_677_1.typewritter.percent = (arg_677_1.time_ - var_680_20) / var_680_28

				arg_677_1.typewritter:SetDirty()
			end

			if arg_677_1.time_ >= var_680_20 + var_680_28 and arg_677_1.time_ < var_680_20 + var_680_28 + arg_680_0 then
				arg_677_1.typewritter.percent = 1

				arg_677_1.typewritter:SetDirty()
				arg_677_1:ShowNextGo(true)
			end
		end

		arg_677_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_677_1:InitPlayNodeList()
	end,
	Play910201167 = function(arg_681_0, arg_681_1)
		arg_681_1.time_ = 0
		arg_681_1.frameCnt_ = 0
		arg_681_1.state_ = "playing"
		arg_681_1.curTalkId_ = 910201167
		arg_681_1.duration_ = 5

		SetActive(arg_681_1.tipsGo_, false)

		function arg_681_1.onSingleLineFinish_()
			arg_681_1.onSingleLineUpdate_ = nil
			arg_681_1.onSingleLineFinish_ = nil
			arg_681_1.state_ = "waiting"
		end

		function arg_681_1.playNext_(arg_683_0)
			if arg_683_0 == 1 then
				arg_681_0:Play910201168(arg_681_1)
			end
		end

		function arg_681_1.onSingleLineUpdate_(arg_684_0)
			local var_684_0 = "1037ui_story"

			if arg_681_1.actors_[var_684_0] == nil then
				local var_684_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_684_1) then
					local var_684_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_681_1.stage_.transform)

					var_684_2.name = var_684_0
					var_684_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_681_1.actors_[var_684_0] = var_684_2

					local var_684_3 = var_684_2:GetComponentInChildren(typeof(CharacterEffect))

					var_684_3.enabled = true

					local var_684_4 = GameObjectTools.GetOrAddComponent(var_684_2, typeof(DynamicBoneHelper))

					if var_684_4 then
						var_684_4:EnableDynamicBone(false)
					end

					arg_681_1:ShowWeapon(var_684_3.transform, false)

					arg_681_1.var_[var_684_0 .. "Animator"] = var_684_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_681_1.var_[var_684_0 .. "Animator"].applyRootMotion = true
					arg_681_1.var_[var_684_0 .. "LipSync"] = var_684_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_684_5 = arg_681_1.actors_["1037ui_story"]
			local var_684_6 = 0

			if var_684_6 < arg_681_1.time_ and arg_681_1.time_ <= var_684_6 + arg_684_0 and not isNil(var_684_5) and arg_681_1.var_.characterEffect1037ui_story == nil then
				arg_681_1.var_.characterEffect1037ui_story = var_684_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_684_7 = 0.2

			if var_684_6 <= arg_681_1.time_ and arg_681_1.time_ < var_684_6 + var_684_7 and not isNil(var_684_5) then
				local var_684_8 = (arg_681_1.time_ - var_684_6) / var_684_7

				if arg_681_1.var_.characterEffect1037ui_story and not isNil(var_684_5) then
					arg_681_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_681_1.time_ >= var_684_6 + var_684_7 and arg_681_1.time_ < var_684_6 + var_684_7 + arg_684_0 and not isNil(var_684_5) and arg_681_1.var_.characterEffect1037ui_story then
				arg_681_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_684_9 = arg_681_1.actors_["1036ui_story"]
			local var_684_10 = 0

			if var_684_10 < arg_681_1.time_ and arg_681_1.time_ <= var_684_10 + arg_684_0 and not isNil(var_684_9) and arg_681_1.var_.characterEffect1036ui_story == nil then
				arg_681_1.var_.characterEffect1036ui_story = var_684_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_684_11 = 0.2

			if var_684_10 <= arg_681_1.time_ and arg_681_1.time_ < var_684_10 + var_684_11 and not isNil(var_684_9) then
				local var_684_12 = (arg_681_1.time_ - var_684_10) / var_684_11

				if arg_681_1.var_.characterEffect1036ui_story and not isNil(var_684_9) then
					local var_684_13 = Mathf.Lerp(0, 0.5, var_684_12)

					arg_681_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_681_1.var_.characterEffect1036ui_story.fillRatio = var_684_13
				end
			end

			if arg_681_1.time_ >= var_684_10 + var_684_11 and arg_681_1.time_ < var_684_10 + var_684_11 + arg_684_0 and not isNil(var_684_9) and arg_681_1.var_.characterEffect1036ui_story then
				local var_684_14 = 0.5

				arg_681_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_681_1.var_.characterEffect1036ui_story.fillRatio = var_684_14
			end

			local var_684_15 = 0

			if var_684_15 < arg_681_1.time_ and arg_681_1.time_ <= var_684_15 + arg_684_0 then
				arg_681_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			local var_684_16 = 0

			if var_684_16 < arg_681_1.time_ and arg_681_1.time_ <= var_684_16 + arg_684_0 then
				arg_681_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_684_17 = 0

			if var_684_17 < arg_681_1.time_ and arg_681_1.time_ <= var_684_17 + arg_684_0 then
				arg_681_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_2")
			end

			local var_684_18 = arg_681_1.actors_["1037ui_story"].transform
			local var_684_19 = 0

			if var_684_19 < arg_681_1.time_ and arg_681_1.time_ <= var_684_19 + arg_684_0 then
				arg_681_1.var_.moveOldPos1037ui_story = var_684_18.localPosition
			end

			local var_684_20 = 0.001

			if var_684_19 <= arg_681_1.time_ and arg_681_1.time_ < var_684_19 + var_684_20 then
				local var_684_21 = (arg_681_1.time_ - var_684_19) / var_684_20
				local var_684_22 = Vector3.New(0, -1.09, -5.81)

				var_684_18.localPosition = Vector3.Lerp(arg_681_1.var_.moveOldPos1037ui_story, var_684_22, var_684_21)

				local var_684_23 = manager.ui.mainCamera.transform.position - var_684_18.position

				var_684_18.forward = Vector3.New(var_684_23.x, var_684_23.y, var_684_23.z)

				local var_684_24 = var_684_18.localEulerAngles

				var_684_24.z = 0
				var_684_24.x = 0
				var_684_18.localEulerAngles = var_684_24
			end

			if arg_681_1.time_ >= var_684_19 + var_684_20 and arg_681_1.time_ < var_684_19 + var_684_20 + arg_684_0 then
				var_684_18.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_684_25 = manager.ui.mainCamera.transform.position - var_684_18.position

				var_684_18.forward = Vector3.New(var_684_25.x, var_684_25.y, var_684_25.z)

				local var_684_26 = var_684_18.localEulerAngles

				var_684_26.z = 0
				var_684_26.x = 0
				var_684_18.localEulerAngles = var_684_26
			end

			local var_684_27 = arg_681_1.actors_["1036ui_story"].transform
			local var_684_28 = 0

			if var_684_28 < arg_681_1.time_ and arg_681_1.time_ <= var_684_28 + arg_684_0 then
				arg_681_1.var_.moveOldPos1036ui_story = var_684_27.localPosition
			end

			local var_684_29 = 0.001

			if var_684_28 <= arg_681_1.time_ and arg_681_1.time_ < var_684_28 + var_684_29 then
				local var_684_30 = (arg_681_1.time_ - var_684_28) / var_684_29
				local var_684_31 = Vector3.New(-0.7, -1.09, -5.78)

				var_684_27.localPosition = Vector3.Lerp(arg_681_1.var_.moveOldPos1036ui_story, var_684_31, var_684_30)

				local var_684_32 = manager.ui.mainCamera.transform.position - var_684_27.position

				var_684_27.forward = Vector3.New(var_684_32.x, var_684_32.y, var_684_32.z)

				local var_684_33 = var_684_27.localEulerAngles

				var_684_33.z = 0
				var_684_33.x = 0
				var_684_27.localEulerAngles = var_684_33
			end

			if arg_681_1.time_ >= var_684_28 + var_684_29 and arg_681_1.time_ < var_684_28 + var_684_29 + arg_684_0 then
				var_684_27.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_684_34 = manager.ui.mainCamera.transform.position - var_684_27.position

				var_684_27.forward = Vector3.New(var_684_34.x, var_684_34.y, var_684_34.z)

				local var_684_35 = var_684_27.localEulerAngles

				var_684_35.z = 0
				var_684_35.x = 0
				var_684_27.localEulerAngles = var_684_35
			end

			local var_684_36 = 0
			local var_684_37 = 0.2

			if var_684_36 < arg_681_1.time_ and arg_681_1.time_ <= var_684_36 + arg_684_0 then
				arg_681_1.talkMaxDuration = 0
				arg_681_1.dialogCg_.alpha = 1

				arg_681_1.dialog_:SetActive(true)
				SetActive(arg_681_1.leftNameGo_, true)

				local var_684_38 = arg_681_1:FormatText(StoryNameCfg[15].name)

				arg_681_1.leftNameTxt_.text = var_684_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_681_1.leftNameTxt_.transform)

				arg_681_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_681_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_681_1:RecordName(arg_681_1.leftNameTxt_.text)
				SetActive(arg_681_1.iconTrs_.gameObject, false)
				arg_681_1.callingController_:SetSelectedState("normal")

				local var_684_39 = arg_681_1:GetWordFromCfg(910201167)
				local var_684_40 = arg_681_1:FormatText(var_684_39.content)

				arg_681_1.text_.text = var_684_40

				LuaForUtil.ClearLinePrefixSymbol(arg_681_1.text_)

				local var_684_41 = 8
				local var_684_42 = utf8.len(var_684_40)
				local var_684_43 = var_684_41 <= 0 and var_684_37 or var_684_37 * (var_684_42 / var_684_41)

				if var_684_43 > 0 and var_684_37 < var_684_43 then
					arg_681_1.talkMaxDuration = var_684_43

					if var_684_43 + var_684_36 > arg_681_1.duration_ then
						arg_681_1.duration_ = var_684_43 + var_684_36
					end
				end

				arg_681_1.text_.text = var_684_40
				arg_681_1.typewritter.percent = 0

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(false)
				arg_681_1:RecordContent(arg_681_1.text_.text)
			end

			local var_684_44 = math.max(var_684_37, arg_681_1.talkMaxDuration)

			if var_684_36 <= arg_681_1.time_ and arg_681_1.time_ < var_684_36 + var_684_44 then
				arg_681_1.typewritter.percent = (arg_681_1.time_ - var_684_36) / var_684_44

				arg_681_1.typewritter:SetDirty()
			end

			if arg_681_1.time_ >= var_684_36 + var_684_44 and arg_681_1.time_ < var_684_36 + var_684_44 + arg_684_0 then
				arg_681_1.typewritter.percent = 1

				arg_681_1.typewritter:SetDirty()
				arg_681_1:ShowNextGo(true)
			end
		end

		arg_681_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_681_1:InitPlayNodeList()
	end,
	Play910201168 = function(arg_685_0, arg_685_1)
		arg_685_1.time_ = 0
		arg_685_1.frameCnt_ = 0
		arg_685_1.state_ = "playing"
		arg_685_1.curTalkId_ = 910201168
		arg_685_1.duration_ = 5

		SetActive(arg_685_1.tipsGo_, false)

		function arg_685_1.onSingleLineFinish_()
			arg_685_1.onSingleLineUpdate_ = nil
			arg_685_1.onSingleLineFinish_ = nil
			arg_685_1.state_ = "waiting"
		end

		function arg_685_1.playNext_(arg_687_0)
			if arg_687_0 == 1 then
				arg_685_0:Play910201169(arg_685_1)
			end
		end

		function arg_685_1.onSingleLineUpdate_(arg_688_0)
			local var_688_0 = arg_685_1.actors_["1036ui_story"].transform
			local var_688_1 = 0

			if var_688_1 < arg_685_1.time_ and arg_685_1.time_ <= var_688_1 + arg_688_0 then
				arg_685_1.var_.moveOldPos1036ui_story = var_688_0.localPosition
			end

			local var_688_2 = 0.001

			if var_688_1 <= arg_685_1.time_ and arg_685_1.time_ < var_688_1 + var_688_2 then
				local var_688_3 = (arg_685_1.time_ - var_688_1) / var_688_2
				local var_688_4 = Vector3.New(0, 100, 0)

				var_688_0.localPosition = Vector3.Lerp(arg_685_1.var_.moveOldPos1036ui_story, var_688_4, var_688_3)

				local var_688_5 = manager.ui.mainCamera.transform.position - var_688_0.position

				var_688_0.forward = Vector3.New(var_688_5.x, var_688_5.y, var_688_5.z)

				local var_688_6 = var_688_0.localEulerAngles

				var_688_6.z = 0
				var_688_6.x = 0
				var_688_0.localEulerAngles = var_688_6
			end

			if arg_685_1.time_ >= var_688_1 + var_688_2 and arg_685_1.time_ < var_688_1 + var_688_2 + arg_688_0 then
				var_688_0.localPosition = Vector3.New(0, 100, 0)

				local var_688_7 = manager.ui.mainCamera.transform.position - var_688_0.position

				var_688_0.forward = Vector3.New(var_688_7.x, var_688_7.y, var_688_7.z)

				local var_688_8 = var_688_0.localEulerAngles

				var_688_8.z = 0
				var_688_8.x = 0
				var_688_0.localEulerAngles = var_688_8
			end

			local var_688_9 = arg_685_1.actors_["1037ui_story"].transform
			local var_688_10 = 0

			if var_688_10 < arg_685_1.time_ and arg_685_1.time_ <= var_688_10 + arg_688_0 then
				arg_685_1.var_.moveOldPos1037ui_story = var_688_9.localPosition
			end

			local var_688_11 = 0.001

			if var_688_10 <= arg_685_1.time_ and arg_685_1.time_ < var_688_10 + var_688_11 then
				local var_688_12 = (arg_685_1.time_ - var_688_10) / var_688_11
				local var_688_13 = Vector3.New(0, 100, 0)

				var_688_9.localPosition = Vector3.Lerp(arg_685_1.var_.moveOldPos1037ui_story, var_688_13, var_688_12)

				local var_688_14 = manager.ui.mainCamera.transform.position - var_688_9.position

				var_688_9.forward = Vector3.New(var_688_14.x, var_688_14.y, var_688_14.z)

				local var_688_15 = var_688_9.localEulerAngles

				var_688_15.z = 0
				var_688_15.x = 0
				var_688_9.localEulerAngles = var_688_15
			end

			if arg_685_1.time_ >= var_688_10 + var_688_11 and arg_685_1.time_ < var_688_10 + var_688_11 + arg_688_0 then
				var_688_9.localPosition = Vector3.New(0, 100, 0)

				local var_688_16 = manager.ui.mainCamera.transform.position - var_688_9.position

				var_688_9.forward = Vector3.New(var_688_16.x, var_688_16.y, var_688_16.z)

				local var_688_17 = var_688_9.localEulerAngles

				var_688_17.z = 0
				var_688_17.x = 0
				var_688_9.localEulerAngles = var_688_17
			end

			local var_688_18 = "1066ui_story"

			if arg_685_1.actors_[var_688_18] == nil then
				local var_688_19 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_688_19) then
					local var_688_20 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_685_1.stage_.transform)

					var_688_20.name = var_688_18
					var_688_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_685_1.actors_[var_688_18] = var_688_20

					local var_688_21 = var_688_20:GetComponentInChildren(typeof(CharacterEffect))

					var_688_21.enabled = true

					local var_688_22 = GameObjectTools.GetOrAddComponent(var_688_20, typeof(DynamicBoneHelper))

					if var_688_22 then
						var_688_22:EnableDynamicBone(false)
					end

					arg_685_1:ShowWeapon(var_688_21.transform, false)

					arg_685_1.var_[var_688_18 .. "Animator"] = var_688_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_685_1.var_[var_688_18 .. "Animator"].applyRootMotion = true
					arg_685_1.var_[var_688_18 .. "LipSync"] = var_688_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_688_23 = arg_685_1.actors_["1066ui_story"].transform
			local var_688_24 = 0

			if var_688_24 < arg_685_1.time_ and arg_685_1.time_ <= var_688_24 + arg_688_0 then
				arg_685_1.var_.moveOldPos1066ui_story = var_688_23.localPosition
			end

			local var_688_25 = 0.001

			if var_688_24 <= arg_685_1.time_ and arg_685_1.time_ < var_688_24 + var_688_25 then
				local var_688_26 = (arg_685_1.time_ - var_688_24) / var_688_25
				local var_688_27 = Vector3.New(0, -0.77, -6.1)

				var_688_23.localPosition = Vector3.Lerp(arg_685_1.var_.moveOldPos1066ui_story, var_688_27, var_688_26)

				local var_688_28 = manager.ui.mainCamera.transform.position - var_688_23.position

				var_688_23.forward = Vector3.New(var_688_28.x, var_688_28.y, var_688_28.z)

				local var_688_29 = var_688_23.localEulerAngles

				var_688_29.z = 0
				var_688_29.x = 0
				var_688_23.localEulerAngles = var_688_29
			end

			if arg_685_1.time_ >= var_688_24 + var_688_25 and arg_685_1.time_ < var_688_24 + var_688_25 + arg_688_0 then
				var_688_23.localPosition = Vector3.New(0, -0.77, -6.1)

				local var_688_30 = manager.ui.mainCamera.transform.position - var_688_23.position

				var_688_23.forward = Vector3.New(var_688_30.x, var_688_30.y, var_688_30.z)

				local var_688_31 = var_688_23.localEulerAngles

				var_688_31.z = 0
				var_688_31.x = 0
				var_688_23.localEulerAngles = var_688_31
			end

			local var_688_32 = 0

			if var_688_32 < arg_685_1.time_ and arg_685_1.time_ <= var_688_32 + arg_688_0 then
				arg_685_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			local var_688_33 = arg_685_1.actors_["1066ui_story"]
			local var_688_34 = 0

			if var_688_34 < arg_685_1.time_ and arg_685_1.time_ <= var_688_34 + arg_688_0 and not isNil(var_688_33) and arg_685_1.var_.characterEffect1066ui_story == nil then
				arg_685_1.var_.characterEffect1066ui_story = var_688_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_688_35 = 0.2

			if var_688_34 <= arg_685_1.time_ and arg_685_1.time_ < var_688_34 + var_688_35 and not isNil(var_688_33) then
				local var_688_36 = (arg_685_1.time_ - var_688_34) / var_688_35

				if arg_685_1.var_.characterEffect1066ui_story and not isNil(var_688_33) then
					arg_685_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_685_1.time_ >= var_688_34 + var_688_35 and arg_685_1.time_ < var_688_34 + var_688_35 + arg_688_0 and not isNil(var_688_33) and arg_685_1.var_.characterEffect1066ui_story then
				arg_685_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_688_37 = 0

			if var_688_37 < arg_685_1.time_ and arg_685_1.time_ <= var_688_37 + arg_688_0 then
				arg_685_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_688_38 = 0
			local var_688_39 = 1

			if var_688_38 < arg_685_1.time_ and arg_685_1.time_ <= var_688_38 + arg_688_0 then
				arg_685_1.talkMaxDuration = 0
				arg_685_1.dialogCg_.alpha = 1

				arg_685_1.dialog_:SetActive(true)
				SetActive(arg_685_1.leftNameGo_, true)

				local var_688_40 = arg_685_1:FormatText(StoryNameCfg[32].name)

				arg_685_1.leftNameTxt_.text = var_688_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_685_1.leftNameTxt_.transform)

				arg_685_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_685_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_685_1:RecordName(arg_685_1.leftNameTxt_.text)
				SetActive(arg_685_1.iconTrs_.gameObject, false)
				arg_685_1.callingController_:SetSelectedState("normal")

				local var_688_41 = arg_685_1:GetWordFromCfg(910201168)
				local var_688_42 = arg_685_1:FormatText(var_688_41.content)

				arg_685_1.text_.text = var_688_42

				LuaForUtil.ClearLinePrefixSymbol(arg_685_1.text_)

				local var_688_43 = 40
				local var_688_44 = utf8.len(var_688_42)
				local var_688_45 = var_688_43 <= 0 and var_688_39 or var_688_39 * (var_688_44 / var_688_43)

				if var_688_45 > 0 and var_688_39 < var_688_45 then
					arg_685_1.talkMaxDuration = var_688_45

					if var_688_45 + var_688_38 > arg_685_1.duration_ then
						arg_685_1.duration_ = var_688_45 + var_688_38
					end
				end

				arg_685_1.text_.text = var_688_42
				arg_685_1.typewritter.percent = 0

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(false)
				arg_685_1:RecordContent(arg_685_1.text_.text)
			end

			local var_688_46 = math.max(var_688_39, arg_685_1.talkMaxDuration)

			if var_688_38 <= arg_685_1.time_ and arg_685_1.time_ < var_688_38 + var_688_46 then
				arg_685_1.typewritter.percent = (arg_685_1.time_ - var_688_38) / var_688_46

				arg_685_1.typewritter:SetDirty()
			end

			if arg_685_1.time_ >= var_688_38 + var_688_46 and arg_685_1.time_ < var_688_38 + var_688_46 + arg_688_0 then
				arg_685_1.typewritter.percent = 1

				arg_685_1.typewritter:SetDirty()
				arg_685_1:ShowNextGo(true)
			end
		end

		arg_685_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_685_1:InitPlayNodeList()
	end,
	Play910201169 = function(arg_689_0, arg_689_1)
		arg_689_1.time_ = 0
		arg_689_1.frameCnt_ = 0
		arg_689_1.state_ = "playing"
		arg_689_1.curTalkId_ = 910201169
		arg_689_1.duration_ = 5

		SetActive(arg_689_1.tipsGo_, false)

		function arg_689_1.onSingleLineFinish_()
			arg_689_1.onSingleLineUpdate_ = nil
			arg_689_1.onSingleLineFinish_ = nil
			arg_689_1.state_ = "waiting"
		end

		function arg_689_1.playNext_(arg_691_0)
			if arg_691_0 == 1 then
				arg_689_0:Play910201170(arg_689_1)
			end
		end

		function arg_689_1.onSingleLineUpdate_(arg_692_0)
			local var_692_0 = 0

			if var_692_0 < arg_689_1.time_ and arg_689_1.time_ <= var_692_0 + arg_692_0 then
				arg_689_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action443")
			end

			local var_692_1 = 0

			if var_692_1 < arg_689_1.time_ and arg_689_1.time_ <= var_692_1 + arg_692_0 then
				arg_689_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_692_2 = 0
			local var_692_3 = 1.1

			if var_692_2 < arg_689_1.time_ and arg_689_1.time_ <= var_692_2 + arg_692_0 then
				arg_689_1.talkMaxDuration = 0
				arg_689_1.dialogCg_.alpha = 1

				arg_689_1.dialog_:SetActive(true)
				SetActive(arg_689_1.leftNameGo_, true)

				local var_692_4 = arg_689_1:FormatText(StoryNameCfg[32].name)

				arg_689_1.leftNameTxt_.text = var_692_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_689_1.leftNameTxt_.transform)

				arg_689_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_689_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_689_1:RecordName(arg_689_1.leftNameTxt_.text)
				SetActive(arg_689_1.iconTrs_.gameObject, false)
				arg_689_1.callingController_:SetSelectedState("normal")

				local var_692_5 = arg_689_1:GetWordFromCfg(910201169)
				local var_692_6 = arg_689_1:FormatText(var_692_5.content)

				arg_689_1.text_.text = var_692_6

				LuaForUtil.ClearLinePrefixSymbol(arg_689_1.text_)

				local var_692_7 = 44
				local var_692_8 = utf8.len(var_692_6)
				local var_692_9 = var_692_7 <= 0 and var_692_3 or var_692_3 * (var_692_8 / var_692_7)

				if var_692_9 > 0 and var_692_3 < var_692_9 then
					arg_689_1.talkMaxDuration = var_692_9

					if var_692_9 + var_692_2 > arg_689_1.duration_ then
						arg_689_1.duration_ = var_692_9 + var_692_2
					end
				end

				arg_689_1.text_.text = var_692_6
				arg_689_1.typewritter.percent = 0

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(false)
				arg_689_1:RecordContent(arg_689_1.text_.text)
			end

			local var_692_10 = math.max(var_692_3, arg_689_1.talkMaxDuration)

			if var_692_2 <= arg_689_1.time_ and arg_689_1.time_ < var_692_2 + var_692_10 then
				arg_689_1.typewritter.percent = (arg_689_1.time_ - var_692_2) / var_692_10

				arg_689_1.typewritter:SetDirty()
			end

			if arg_689_1.time_ >= var_692_2 + var_692_10 and arg_689_1.time_ < var_692_2 + var_692_10 + arg_692_0 then
				arg_689_1.typewritter.percent = 1

				arg_689_1.typewritter:SetDirty()
				arg_689_1:ShowNextGo(true)
			end
		end

		arg_689_1.nodeConfigList_ = {}

		arg_689_1:InitPlayNodeList()
	end,
	Play910201170 = function(arg_693_0, arg_693_1)
		arg_693_1.time_ = 0
		arg_693_1.frameCnt_ = 0
		arg_693_1.state_ = "playing"
		arg_693_1.curTalkId_ = 910201170
		arg_693_1.duration_ = 5

		SetActive(arg_693_1.tipsGo_, false)

		function arg_693_1.onSingleLineFinish_()
			arg_693_1.onSingleLineUpdate_ = nil
			arg_693_1.onSingleLineFinish_ = nil
			arg_693_1.state_ = "waiting"
		end

		function arg_693_1.playNext_(arg_695_0)
			if arg_695_0 == 1 then
				arg_693_0:Play910201171(arg_693_1)
			end
		end

		function arg_693_1.onSingleLineUpdate_(arg_696_0)
			local var_696_0 = arg_693_1.actors_["1066ui_story"].transform
			local var_696_1 = 0

			if var_696_1 < arg_693_1.time_ and arg_693_1.time_ <= var_696_1 + arg_696_0 then
				arg_693_1.var_.moveOldPos1066ui_story = var_696_0.localPosition
			end

			local var_696_2 = 0.001

			if var_696_1 <= arg_693_1.time_ and arg_693_1.time_ < var_696_1 + var_696_2 then
				local var_696_3 = (arg_693_1.time_ - var_696_1) / var_696_2
				local var_696_4 = Vector3.New(0, 100, 0)

				var_696_0.localPosition = Vector3.Lerp(arg_693_1.var_.moveOldPos1066ui_story, var_696_4, var_696_3)

				local var_696_5 = manager.ui.mainCamera.transform.position - var_696_0.position

				var_696_0.forward = Vector3.New(var_696_5.x, var_696_5.y, var_696_5.z)

				local var_696_6 = var_696_0.localEulerAngles

				var_696_6.z = 0
				var_696_6.x = 0
				var_696_0.localEulerAngles = var_696_6
			end

			if arg_693_1.time_ >= var_696_1 + var_696_2 and arg_693_1.time_ < var_696_1 + var_696_2 + arg_696_0 then
				var_696_0.localPosition = Vector3.New(0, 100, 0)

				local var_696_7 = manager.ui.mainCamera.transform.position - var_696_0.position

				var_696_0.forward = Vector3.New(var_696_7.x, var_696_7.y, var_696_7.z)

				local var_696_8 = var_696_0.localEulerAngles

				var_696_8.z = 0
				var_696_8.x = 0
				var_696_0.localEulerAngles = var_696_8
			end

			local var_696_9 = "1027ui_story"

			if arg_693_1.actors_[var_696_9] == nil then
				local var_696_10 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_696_10) then
					local var_696_11 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_693_1.stage_.transform)

					var_696_11.name = var_696_9
					var_696_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_693_1.actors_[var_696_9] = var_696_11

					local var_696_12 = var_696_11:GetComponentInChildren(typeof(CharacterEffect))

					var_696_12.enabled = true

					local var_696_13 = GameObjectTools.GetOrAddComponent(var_696_11, typeof(DynamicBoneHelper))

					if var_696_13 then
						var_696_13:EnableDynamicBone(false)
					end

					arg_693_1:ShowWeapon(var_696_12.transform, false)

					arg_693_1.var_[var_696_9 .. "Animator"] = var_696_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_693_1.var_[var_696_9 .. "Animator"].applyRootMotion = true
					arg_693_1.var_[var_696_9 .. "LipSync"] = var_696_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_696_14 = arg_693_1.actors_["1027ui_story"].transform
			local var_696_15 = 0

			if var_696_15 < arg_693_1.time_ and arg_693_1.time_ <= var_696_15 + arg_696_0 then
				arg_693_1.var_.moveOldPos1027ui_story = var_696_14.localPosition
			end

			local var_696_16 = 0.001

			if var_696_15 <= arg_693_1.time_ and arg_693_1.time_ < var_696_15 + var_696_16 then
				local var_696_17 = (arg_693_1.time_ - var_696_15) / var_696_16
				local var_696_18 = Vector3.New(0, -0.81, -5.8)

				var_696_14.localPosition = Vector3.Lerp(arg_693_1.var_.moveOldPos1027ui_story, var_696_18, var_696_17)

				local var_696_19 = manager.ui.mainCamera.transform.position - var_696_14.position

				var_696_14.forward = Vector3.New(var_696_19.x, var_696_19.y, var_696_19.z)

				local var_696_20 = var_696_14.localEulerAngles

				var_696_20.z = 0
				var_696_20.x = 0
				var_696_14.localEulerAngles = var_696_20
			end

			if arg_693_1.time_ >= var_696_15 + var_696_16 and arg_693_1.time_ < var_696_15 + var_696_16 + arg_696_0 then
				var_696_14.localPosition = Vector3.New(0, -0.81, -5.8)

				local var_696_21 = manager.ui.mainCamera.transform.position - var_696_14.position

				var_696_14.forward = Vector3.New(var_696_21.x, var_696_21.y, var_696_21.z)

				local var_696_22 = var_696_14.localEulerAngles

				var_696_22.z = 0
				var_696_22.x = 0
				var_696_14.localEulerAngles = var_696_22
			end

			local var_696_23 = 0

			if var_696_23 < arg_693_1.time_ and arg_693_1.time_ <= var_696_23 + arg_696_0 then
				arg_693_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action7_1")
			end

			local var_696_24 = 0

			if var_696_24 < arg_693_1.time_ and arg_693_1.time_ <= var_696_24 + arg_696_0 then
				arg_693_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva")
			end

			local var_696_25 = arg_693_1.actors_["1027ui_story"]
			local var_696_26 = 0

			if var_696_26 < arg_693_1.time_ and arg_693_1.time_ <= var_696_26 + arg_696_0 and not isNil(var_696_25) and arg_693_1.var_.characterEffect1027ui_story == nil then
				arg_693_1.var_.characterEffect1027ui_story = var_696_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_696_27 = 0.2

			if var_696_26 <= arg_693_1.time_ and arg_693_1.time_ < var_696_26 + var_696_27 and not isNil(var_696_25) then
				local var_696_28 = (arg_693_1.time_ - var_696_26) / var_696_27

				if arg_693_1.var_.characterEffect1027ui_story and not isNil(var_696_25) then
					arg_693_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_693_1.time_ >= var_696_26 + var_696_27 and arg_693_1.time_ < var_696_26 + var_696_27 + arg_696_0 and not isNil(var_696_25) and arg_693_1.var_.characterEffect1027ui_story then
				arg_693_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_696_29 = 0
			local var_696_30 = 0.3

			if var_696_29 < arg_693_1.time_ and arg_693_1.time_ <= var_696_29 + arg_696_0 then
				arg_693_1.talkMaxDuration = 0
				arg_693_1.dialogCg_.alpha = 1

				arg_693_1.dialog_:SetActive(true)
				SetActive(arg_693_1.leftNameGo_, true)

				local var_696_31 = arg_693_1:FormatText(StoryNameCfg[56].name)

				arg_693_1.leftNameTxt_.text = var_696_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_693_1.leftNameTxt_.transform)

				arg_693_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_693_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_693_1:RecordName(arg_693_1.leftNameTxt_.text)
				SetActive(arg_693_1.iconTrs_.gameObject, false)
				arg_693_1.callingController_:SetSelectedState("normal")

				local var_696_32 = arg_693_1:GetWordFromCfg(910201170)
				local var_696_33 = arg_693_1:FormatText(var_696_32.content)

				arg_693_1.text_.text = var_696_33

				LuaForUtil.ClearLinePrefixSymbol(arg_693_1.text_)

				local var_696_34 = 12
				local var_696_35 = utf8.len(var_696_33)
				local var_696_36 = var_696_34 <= 0 and var_696_30 or var_696_30 * (var_696_35 / var_696_34)

				if var_696_36 > 0 and var_696_30 < var_696_36 then
					arg_693_1.talkMaxDuration = var_696_36

					if var_696_36 + var_696_29 > arg_693_1.duration_ then
						arg_693_1.duration_ = var_696_36 + var_696_29
					end
				end

				arg_693_1.text_.text = var_696_33
				arg_693_1.typewritter.percent = 0

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(false)
				arg_693_1:RecordContent(arg_693_1.text_.text)
			end

			local var_696_37 = math.max(var_696_30, arg_693_1.talkMaxDuration)

			if var_696_29 <= arg_693_1.time_ and arg_693_1.time_ < var_696_29 + var_696_37 then
				arg_693_1.typewritter.percent = (arg_693_1.time_ - var_696_29) / var_696_37

				arg_693_1.typewritter:SetDirty()
			end

			if arg_693_1.time_ >= var_696_29 + var_696_37 and arg_693_1.time_ < var_696_29 + var_696_37 + arg_696_0 then
				arg_693_1.typewritter.percent = 1

				arg_693_1.typewritter:SetDirty()
				arg_693_1:ShowNextGo(true)
			end
		end

		arg_693_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_693_1:InitPlayNodeList()
	end,
	Play910201171 = function(arg_697_0, arg_697_1)
		arg_697_1.time_ = 0
		arg_697_1.frameCnt_ = 0
		arg_697_1.state_ = "playing"
		arg_697_1.curTalkId_ = 910201171
		arg_697_1.duration_ = 5

		SetActive(arg_697_1.tipsGo_, false)

		function arg_697_1.onSingleLineFinish_()
			arg_697_1.onSingleLineUpdate_ = nil
			arg_697_1.onSingleLineFinish_ = nil
			arg_697_1.state_ = "waiting"
		end

		function arg_697_1.playNext_(arg_699_0)
			if arg_699_0 == 1 then
				arg_697_0:Play910201172(arg_697_1)
			end
		end

		function arg_697_1.onSingleLineUpdate_(arg_700_0)
			local var_700_0 = 0

			if var_700_0 < arg_697_1.time_ and arg_697_1.time_ <= var_700_0 + arg_700_0 then
				arg_697_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action476")
			end

			local var_700_1 = 0

			if var_700_1 < arg_697_1.time_ and arg_697_1.time_ <= var_700_1 + arg_700_0 then
				arg_697_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_700_2 = 0
			local var_700_3 = 0.85

			if var_700_2 < arg_697_1.time_ and arg_697_1.time_ <= var_700_2 + arg_700_0 then
				arg_697_1.talkMaxDuration = 0
				arg_697_1.dialogCg_.alpha = 1

				arg_697_1.dialog_:SetActive(true)
				SetActive(arg_697_1.leftNameGo_, true)

				local var_700_4 = arg_697_1:FormatText(StoryNameCfg[56].name)

				arg_697_1.leftNameTxt_.text = var_700_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_697_1.leftNameTxt_.transform)

				arg_697_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_697_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_697_1:RecordName(arg_697_1.leftNameTxt_.text)
				SetActive(arg_697_1.iconTrs_.gameObject, false)
				arg_697_1.callingController_:SetSelectedState("normal")

				local var_700_5 = arg_697_1:GetWordFromCfg(910201171)
				local var_700_6 = arg_697_1:FormatText(var_700_5.content)

				arg_697_1.text_.text = var_700_6

				LuaForUtil.ClearLinePrefixSymbol(arg_697_1.text_)

				local var_700_7 = 34
				local var_700_8 = utf8.len(var_700_6)
				local var_700_9 = var_700_7 <= 0 and var_700_3 or var_700_3 * (var_700_8 / var_700_7)

				if var_700_9 > 0 and var_700_3 < var_700_9 then
					arg_697_1.talkMaxDuration = var_700_9

					if var_700_9 + var_700_2 > arg_697_1.duration_ then
						arg_697_1.duration_ = var_700_9 + var_700_2
					end
				end

				arg_697_1.text_.text = var_700_6
				arg_697_1.typewritter.percent = 0

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(false)
				arg_697_1:RecordContent(arg_697_1.text_.text)
			end

			local var_700_10 = math.max(var_700_3, arg_697_1.talkMaxDuration)

			if var_700_2 <= arg_697_1.time_ and arg_697_1.time_ < var_700_2 + var_700_10 then
				arg_697_1.typewritter.percent = (arg_697_1.time_ - var_700_2) / var_700_10

				arg_697_1.typewritter:SetDirty()
			end

			if arg_697_1.time_ >= var_700_2 + var_700_10 and arg_697_1.time_ < var_700_2 + var_700_10 + arg_700_0 then
				arg_697_1.typewritter.percent = 1

				arg_697_1.typewritter:SetDirty()
				arg_697_1:ShowNextGo(true)
			end
		end

		arg_697_1.nodeConfigList_ = {}

		arg_697_1:InitPlayNodeList()
	end,
	Play910201172 = function(arg_701_0, arg_701_1)
		arg_701_1.time_ = 0
		arg_701_1.frameCnt_ = 0
		arg_701_1.state_ = "playing"
		arg_701_1.curTalkId_ = 910201172
		arg_701_1.duration_ = 5

		SetActive(arg_701_1.tipsGo_, false)

		function arg_701_1.onSingleLineFinish_()
			arg_701_1.onSingleLineUpdate_ = nil
			arg_701_1.onSingleLineFinish_ = nil
			arg_701_1.state_ = "waiting"
		end

		function arg_701_1.playNext_(arg_703_0)
			if arg_703_0 == 1 then
				arg_701_0:Play910201173(arg_701_1)
			end
		end

		function arg_701_1.onSingleLineUpdate_(arg_704_0)
			local var_704_0 = 0

			if var_704_0 < arg_701_1.time_ and arg_701_1.time_ <= var_704_0 + arg_704_0 then
				arg_701_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027actionlink/1027action462")
			end

			local var_704_1 = 0

			if var_704_1 < arg_701_1.time_ and arg_701_1.time_ <= var_704_1 + arg_704_0 then
				arg_701_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_704_2 = 0
			local var_704_3 = 0.275

			if var_704_2 < arg_701_1.time_ and arg_701_1.time_ <= var_704_2 + arg_704_0 then
				arg_701_1.talkMaxDuration = 0
				arg_701_1.dialogCg_.alpha = 1

				arg_701_1.dialog_:SetActive(true)
				SetActive(arg_701_1.leftNameGo_, true)

				local var_704_4 = arg_701_1:FormatText(StoryNameCfg[56].name)

				arg_701_1.leftNameTxt_.text = var_704_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_701_1.leftNameTxt_.transform)

				arg_701_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_701_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_701_1:RecordName(arg_701_1.leftNameTxt_.text)
				SetActive(arg_701_1.iconTrs_.gameObject, false)
				arg_701_1.callingController_:SetSelectedState("normal")

				local var_704_5 = arg_701_1:GetWordFromCfg(910201172)
				local var_704_6 = arg_701_1:FormatText(var_704_5.content)

				arg_701_1.text_.text = var_704_6

				LuaForUtil.ClearLinePrefixSymbol(arg_701_1.text_)

				local var_704_7 = 11
				local var_704_8 = utf8.len(var_704_6)
				local var_704_9 = var_704_7 <= 0 and var_704_3 or var_704_3 * (var_704_8 / var_704_7)

				if var_704_9 > 0 and var_704_3 < var_704_9 then
					arg_701_1.talkMaxDuration = var_704_9

					if var_704_9 + var_704_2 > arg_701_1.duration_ then
						arg_701_1.duration_ = var_704_9 + var_704_2
					end
				end

				arg_701_1.text_.text = var_704_6
				arg_701_1.typewritter.percent = 0

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(false)
				arg_701_1:RecordContent(arg_701_1.text_.text)
			end

			local var_704_10 = math.max(var_704_3, arg_701_1.talkMaxDuration)

			if var_704_2 <= arg_701_1.time_ and arg_701_1.time_ < var_704_2 + var_704_10 then
				arg_701_1.typewritter.percent = (arg_701_1.time_ - var_704_2) / var_704_10

				arg_701_1.typewritter:SetDirty()
			end

			if arg_701_1.time_ >= var_704_2 + var_704_10 and arg_701_1.time_ < var_704_2 + var_704_10 + arg_704_0 then
				arg_701_1.typewritter.percent = 1

				arg_701_1.typewritter:SetDirty()
				arg_701_1:ShowNextGo(true)
			end
		end

		arg_701_1.nodeConfigList_ = {}

		arg_701_1:InitPlayNodeList()
	end,
	Play910201173 = function(arg_705_0, arg_705_1)
		arg_705_1.time_ = 0
		arg_705_1.frameCnt_ = 0
		arg_705_1.state_ = "playing"
		arg_705_1.curTalkId_ = 910201173
		arg_705_1.duration_ = 5

		SetActive(arg_705_1.tipsGo_, false)

		function arg_705_1.onSingleLineFinish_()
			arg_705_1.onSingleLineUpdate_ = nil
			arg_705_1.onSingleLineFinish_ = nil
			arg_705_1.state_ = "waiting"
		end

		function arg_705_1.playNext_(arg_707_0)
			if arg_707_0 == 1 then
				arg_705_0:Play910201174(arg_705_1)
			end
		end

		function arg_705_1.onSingleLineUpdate_(arg_708_0)
			local var_708_0 = arg_705_1.actors_["1027ui_story"].transform
			local var_708_1 = 0

			if var_708_1 < arg_705_1.time_ and arg_705_1.time_ <= var_708_1 + arg_708_0 then
				arg_705_1.var_.moveOldPos1027ui_story = var_708_0.localPosition
			end

			local var_708_2 = 0.001

			if var_708_1 <= arg_705_1.time_ and arg_705_1.time_ < var_708_1 + var_708_2 then
				local var_708_3 = (arg_705_1.time_ - var_708_1) / var_708_2
				local var_708_4 = Vector3.New(0, 100, 0)

				var_708_0.localPosition = Vector3.Lerp(arg_705_1.var_.moveOldPos1027ui_story, var_708_4, var_708_3)

				local var_708_5 = manager.ui.mainCamera.transform.position - var_708_0.position

				var_708_0.forward = Vector3.New(var_708_5.x, var_708_5.y, var_708_5.z)

				local var_708_6 = var_708_0.localEulerAngles

				var_708_6.z = 0
				var_708_6.x = 0
				var_708_0.localEulerAngles = var_708_6
			end

			if arg_705_1.time_ >= var_708_1 + var_708_2 and arg_705_1.time_ < var_708_1 + var_708_2 + arg_708_0 then
				var_708_0.localPosition = Vector3.New(0, 100, 0)

				local var_708_7 = manager.ui.mainCamera.transform.position - var_708_0.position

				var_708_0.forward = Vector3.New(var_708_7.x, var_708_7.y, var_708_7.z)

				local var_708_8 = var_708_0.localEulerAngles

				var_708_8.z = 0
				var_708_8.x = 0
				var_708_0.localEulerAngles = var_708_8
			end

			local var_708_9 = "1011ui_story"

			if arg_705_1.actors_[var_708_9] == nil then
				local var_708_10 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_708_10) then
					local var_708_11 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_705_1.stage_.transform)

					var_708_11.name = var_708_9
					var_708_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_705_1.actors_[var_708_9] = var_708_11

					local var_708_12 = var_708_11:GetComponentInChildren(typeof(CharacterEffect))

					var_708_12.enabled = true

					local var_708_13 = GameObjectTools.GetOrAddComponent(var_708_11, typeof(DynamicBoneHelper))

					if var_708_13 then
						var_708_13:EnableDynamicBone(false)
					end

					arg_705_1:ShowWeapon(var_708_12.transform, false)

					arg_705_1.var_[var_708_9 .. "Animator"] = var_708_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_705_1.var_[var_708_9 .. "Animator"].applyRootMotion = true
					arg_705_1.var_[var_708_9 .. "LipSync"] = var_708_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_708_14 = arg_705_1.actors_["1011ui_story"].transform
			local var_708_15 = 0

			if var_708_15 < arg_705_1.time_ and arg_705_1.time_ <= var_708_15 + arg_708_0 then
				arg_705_1.var_.moveOldPos1011ui_story = var_708_14.localPosition
			end

			local var_708_16 = 0.001

			if var_708_15 <= arg_705_1.time_ and arg_705_1.time_ < var_708_15 + var_708_16 then
				local var_708_17 = (arg_705_1.time_ - var_708_15) / var_708_16
				local var_708_18 = Vector3.New(0, -0.71, -6)

				var_708_14.localPosition = Vector3.Lerp(arg_705_1.var_.moveOldPos1011ui_story, var_708_18, var_708_17)

				local var_708_19 = manager.ui.mainCamera.transform.position - var_708_14.position

				var_708_14.forward = Vector3.New(var_708_19.x, var_708_19.y, var_708_19.z)

				local var_708_20 = var_708_14.localEulerAngles

				var_708_20.z = 0
				var_708_20.x = 0
				var_708_14.localEulerAngles = var_708_20
			end

			if arg_705_1.time_ >= var_708_15 + var_708_16 and arg_705_1.time_ < var_708_15 + var_708_16 + arg_708_0 then
				var_708_14.localPosition = Vector3.New(0, -0.71, -6)

				local var_708_21 = manager.ui.mainCamera.transform.position - var_708_14.position

				var_708_14.forward = Vector3.New(var_708_21.x, var_708_21.y, var_708_21.z)

				local var_708_22 = var_708_14.localEulerAngles

				var_708_22.z = 0
				var_708_22.x = 0
				var_708_14.localEulerAngles = var_708_22
			end

			local var_708_23 = 0

			if var_708_23 < arg_705_1.time_ and arg_705_1.time_ <= var_708_23 + arg_708_0 then
				arg_705_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			local var_708_24 = 0

			if var_708_24 < arg_705_1.time_ and arg_705_1.time_ <= var_708_24 + arg_708_0 then
				arg_705_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_708_25 = arg_705_1.actors_["1011ui_story"]
			local var_708_26 = 0

			if var_708_26 < arg_705_1.time_ and arg_705_1.time_ <= var_708_26 + arg_708_0 and not isNil(var_708_25) and arg_705_1.var_.characterEffect1011ui_story == nil then
				arg_705_1.var_.characterEffect1011ui_story = var_708_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_708_27 = 0.2

			if var_708_26 <= arg_705_1.time_ and arg_705_1.time_ < var_708_26 + var_708_27 and not isNil(var_708_25) then
				local var_708_28 = (arg_705_1.time_ - var_708_26) / var_708_27

				if arg_705_1.var_.characterEffect1011ui_story and not isNil(var_708_25) then
					arg_705_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_705_1.time_ >= var_708_26 + var_708_27 and arg_705_1.time_ < var_708_26 + var_708_27 + arg_708_0 and not isNil(var_708_25) and arg_705_1.var_.characterEffect1011ui_story then
				arg_705_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_708_29 = 0
			local var_708_30 = 0.25

			if var_708_29 < arg_705_1.time_ and arg_705_1.time_ <= var_708_29 + arg_708_0 then
				arg_705_1.talkMaxDuration = 0
				arg_705_1.dialogCg_.alpha = 1

				arg_705_1.dialog_:SetActive(true)
				SetActive(arg_705_1.leftNameGo_, true)

				local var_708_31 = arg_705_1:FormatText(StoryNameCfg[37].name)

				arg_705_1.leftNameTxt_.text = var_708_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_705_1.leftNameTxt_.transform)

				arg_705_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_705_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_705_1:RecordName(arg_705_1.leftNameTxt_.text)
				SetActive(arg_705_1.iconTrs_.gameObject, false)
				arg_705_1.callingController_:SetSelectedState("normal")

				local var_708_32 = arg_705_1:GetWordFromCfg(910201173)
				local var_708_33 = arg_705_1:FormatText(var_708_32.content)

				arg_705_1.text_.text = var_708_33

				LuaForUtil.ClearLinePrefixSymbol(arg_705_1.text_)

				local var_708_34 = 10
				local var_708_35 = utf8.len(var_708_33)
				local var_708_36 = var_708_34 <= 0 and var_708_30 or var_708_30 * (var_708_35 / var_708_34)

				if var_708_36 > 0 and var_708_30 < var_708_36 then
					arg_705_1.talkMaxDuration = var_708_36

					if var_708_36 + var_708_29 > arg_705_1.duration_ then
						arg_705_1.duration_ = var_708_36 + var_708_29
					end
				end

				arg_705_1.text_.text = var_708_33
				arg_705_1.typewritter.percent = 0

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(false)
				arg_705_1:RecordContent(arg_705_1.text_.text)
			end

			local var_708_37 = math.max(var_708_30, arg_705_1.talkMaxDuration)

			if var_708_29 <= arg_705_1.time_ and arg_705_1.time_ < var_708_29 + var_708_37 then
				arg_705_1.typewritter.percent = (arg_705_1.time_ - var_708_29) / var_708_37

				arg_705_1.typewritter:SetDirty()
			end

			if arg_705_1.time_ >= var_708_29 + var_708_37 and arg_705_1.time_ < var_708_29 + var_708_37 + arg_708_0 then
				arg_705_1.typewritter.percent = 1

				arg_705_1.typewritter:SetDirty()
				arg_705_1:ShowNextGo(true)
			end
		end

		arg_705_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_705_1:InitPlayNodeList()
	end,
	Play910201174 = function(arg_709_0, arg_709_1)
		arg_709_1.time_ = 0
		arg_709_1.frameCnt_ = 0
		arg_709_1.state_ = "playing"
		arg_709_1.curTalkId_ = 910201174
		arg_709_1.duration_ = 5

		SetActive(arg_709_1.tipsGo_, false)

		function arg_709_1.onSingleLineFinish_()
			arg_709_1.onSingleLineUpdate_ = nil
			arg_709_1.onSingleLineFinish_ = nil
			arg_709_1.state_ = "waiting"
		end

		function arg_709_1.playNext_(arg_711_0)
			if arg_711_0 == 1 then
				arg_709_0:Play910201175(arg_709_1)
			end
		end

		function arg_709_1.onSingleLineUpdate_(arg_712_0)
			local var_712_0 = arg_709_1.actors_["1011ui_story"].transform
			local var_712_1 = 0

			if var_712_1 < arg_709_1.time_ and arg_709_1.time_ <= var_712_1 + arg_712_0 then
				arg_709_1.var_.moveOldPos1011ui_story = var_712_0.localPosition
			end

			local var_712_2 = 0.001

			if var_712_1 <= arg_709_1.time_ and arg_709_1.time_ < var_712_1 + var_712_2 then
				local var_712_3 = (arg_709_1.time_ - var_712_1) / var_712_2
				local var_712_4 = Vector3.New(0, 100, 0)

				var_712_0.localPosition = Vector3.Lerp(arg_709_1.var_.moveOldPos1011ui_story, var_712_4, var_712_3)

				local var_712_5 = manager.ui.mainCamera.transform.position - var_712_0.position

				var_712_0.forward = Vector3.New(var_712_5.x, var_712_5.y, var_712_5.z)

				local var_712_6 = var_712_0.localEulerAngles

				var_712_6.z = 0
				var_712_6.x = 0
				var_712_0.localEulerAngles = var_712_6
			end

			if arg_709_1.time_ >= var_712_1 + var_712_2 and arg_709_1.time_ < var_712_1 + var_712_2 + arg_712_0 then
				var_712_0.localPosition = Vector3.New(0, 100, 0)

				local var_712_7 = manager.ui.mainCamera.transform.position - var_712_0.position

				var_712_0.forward = Vector3.New(var_712_7.x, var_712_7.y, var_712_7.z)

				local var_712_8 = var_712_0.localEulerAngles

				var_712_8.z = 0
				var_712_8.x = 0
				var_712_0.localEulerAngles = var_712_8
			end

			local var_712_9 = 0
			local var_712_10 = 0.675

			if var_712_9 < arg_709_1.time_ and arg_709_1.time_ <= var_712_9 + arg_712_0 then
				arg_709_1.talkMaxDuration = 0
				arg_709_1.dialogCg_.alpha = 1

				arg_709_1.dialog_:SetActive(true)
				SetActive(arg_709_1.leftNameGo_, false)

				arg_709_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_709_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_709_1:RecordName(arg_709_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_709_1.iconTrs_.gameObject, false)
				arg_709_1.callingController_:SetSelectedState("normal")

				local var_712_11 = arg_709_1:GetWordFromCfg(910201174)
				local var_712_12 = arg_709_1:FormatText(var_712_11.content)

				arg_709_1.text_.text = var_712_12

				LuaForUtil.ClearLinePrefixSymbol(arg_709_1.text_)

				local var_712_13 = 27
				local var_712_14 = utf8.len(var_712_12)
				local var_712_15 = var_712_13 <= 0 and var_712_10 or var_712_10 * (var_712_14 / var_712_13)

				if var_712_15 > 0 and var_712_10 < var_712_15 then
					arg_709_1.talkMaxDuration = var_712_15

					if var_712_15 + var_712_9 > arg_709_1.duration_ then
						arg_709_1.duration_ = var_712_15 + var_712_9
					end
				end

				arg_709_1.text_.text = var_712_12
				arg_709_1.typewritter.percent = 0

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(false)
				arg_709_1:RecordContent(arg_709_1.text_.text)
			end

			local var_712_16 = math.max(var_712_10, arg_709_1.talkMaxDuration)

			if var_712_9 <= arg_709_1.time_ and arg_709_1.time_ < var_712_9 + var_712_16 then
				arg_709_1.typewritter.percent = (arg_709_1.time_ - var_712_9) / var_712_16

				arg_709_1.typewritter:SetDirty()
			end

			if arg_709_1.time_ >= var_712_9 + var_712_16 and arg_709_1.time_ < var_712_9 + var_712_16 + arg_712_0 then
				arg_709_1.typewritter.percent = 1

				arg_709_1.typewritter:SetDirty()
				arg_709_1:ShowNextGo(true)
			end
		end

		arg_709_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_709_1:InitPlayNodeList()
	end,
	Play910201175 = function(arg_713_0, arg_713_1)
		arg_713_1.time_ = 0
		arg_713_1.frameCnt_ = 0
		arg_713_1.state_ = "playing"
		arg_713_1.curTalkId_ = 910201175
		arg_713_1.duration_ = 5

		SetActive(arg_713_1.tipsGo_, false)

		function arg_713_1.onSingleLineFinish_()
			arg_713_1.onSingleLineUpdate_ = nil
			arg_713_1.onSingleLineFinish_ = nil
			arg_713_1.state_ = "waiting"
		end

		function arg_713_1.playNext_(arg_715_0)
			if arg_715_0 == 1 then
				arg_713_0:Play910201176(arg_713_1)
			end
		end

		function arg_713_1.onSingleLineUpdate_(arg_716_0)
			local var_716_0 = arg_713_1.actors_["1084ui_story"].transform
			local var_716_1 = 0

			if var_716_1 < arg_713_1.time_ and arg_713_1.time_ <= var_716_1 + arg_716_0 then
				arg_713_1.var_.moveOldPos1084ui_story = var_716_0.localPosition
			end

			local var_716_2 = 0.001

			if var_716_1 <= arg_713_1.time_ and arg_713_1.time_ < var_716_1 + var_716_2 then
				local var_716_3 = (arg_713_1.time_ - var_716_1) / var_716_2
				local var_716_4 = Vector3.New(0, -0.97, -6)

				var_716_0.localPosition = Vector3.Lerp(arg_713_1.var_.moveOldPos1084ui_story, var_716_4, var_716_3)

				local var_716_5 = manager.ui.mainCamera.transform.position - var_716_0.position

				var_716_0.forward = Vector3.New(var_716_5.x, var_716_5.y, var_716_5.z)

				local var_716_6 = var_716_0.localEulerAngles

				var_716_6.z = 0
				var_716_6.x = 0
				var_716_0.localEulerAngles = var_716_6
			end

			if arg_713_1.time_ >= var_716_1 + var_716_2 and arg_713_1.time_ < var_716_1 + var_716_2 + arg_716_0 then
				var_716_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_716_7 = manager.ui.mainCamera.transform.position - var_716_0.position

				var_716_0.forward = Vector3.New(var_716_7.x, var_716_7.y, var_716_7.z)

				local var_716_8 = var_716_0.localEulerAngles

				var_716_8.z = 0
				var_716_8.x = 0
				var_716_0.localEulerAngles = var_716_8
			end

			local var_716_9 = arg_713_1.actors_["1084ui_story"]
			local var_716_10 = 0

			if var_716_10 < arg_713_1.time_ and arg_713_1.time_ <= var_716_10 + arg_716_0 and not isNil(var_716_9) and arg_713_1.var_.characterEffect1084ui_story == nil then
				arg_713_1.var_.characterEffect1084ui_story = var_716_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_716_11 = 0.2

			if var_716_10 <= arg_713_1.time_ and arg_713_1.time_ < var_716_10 + var_716_11 and not isNil(var_716_9) then
				local var_716_12 = (arg_713_1.time_ - var_716_10) / var_716_11

				if arg_713_1.var_.characterEffect1084ui_story and not isNil(var_716_9) then
					arg_713_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_713_1.time_ >= var_716_10 + var_716_11 and arg_713_1.time_ < var_716_10 + var_716_11 + arg_716_0 and not isNil(var_716_9) and arg_713_1.var_.characterEffect1084ui_story then
				arg_713_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_716_13 = 0

			if var_716_13 < arg_713_1.time_ and arg_713_1.time_ <= var_716_13 + arg_716_0 then
				arg_713_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_716_14 = 0

			if var_716_14 < arg_713_1.time_ and arg_713_1.time_ <= var_716_14 + arg_716_0 then
				arg_713_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_716_15 = 0
			local var_716_16 = 0.35

			if var_716_15 < arg_713_1.time_ and arg_713_1.time_ <= var_716_15 + arg_716_0 then
				arg_713_1.talkMaxDuration = 0
				arg_713_1.dialogCg_.alpha = 1

				arg_713_1.dialog_:SetActive(true)
				SetActive(arg_713_1.leftNameGo_, true)

				local var_716_17 = arg_713_1:FormatText(StoryNameCfg[6].name)

				arg_713_1.leftNameTxt_.text = var_716_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_713_1.leftNameTxt_.transform)

				arg_713_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_713_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_713_1:RecordName(arg_713_1.leftNameTxt_.text)
				SetActive(arg_713_1.iconTrs_.gameObject, false)
				arg_713_1.callingController_:SetSelectedState("normal")

				local var_716_18 = arg_713_1:GetWordFromCfg(910201175)
				local var_716_19 = arg_713_1:FormatText(var_716_18.content)

				arg_713_1.text_.text = var_716_19

				LuaForUtil.ClearLinePrefixSymbol(arg_713_1.text_)

				local var_716_20 = 14
				local var_716_21 = utf8.len(var_716_19)
				local var_716_22 = var_716_20 <= 0 and var_716_16 or var_716_16 * (var_716_21 / var_716_20)

				if var_716_22 > 0 and var_716_16 < var_716_22 then
					arg_713_1.talkMaxDuration = var_716_22

					if var_716_22 + var_716_15 > arg_713_1.duration_ then
						arg_713_1.duration_ = var_716_22 + var_716_15
					end
				end

				arg_713_1.text_.text = var_716_19
				arg_713_1.typewritter.percent = 0

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(false)
				arg_713_1:RecordContent(arg_713_1.text_.text)
			end

			local var_716_23 = math.max(var_716_16, arg_713_1.talkMaxDuration)

			if var_716_15 <= arg_713_1.time_ and arg_713_1.time_ < var_716_15 + var_716_23 then
				arg_713_1.typewritter.percent = (arg_713_1.time_ - var_716_15) / var_716_23

				arg_713_1.typewritter:SetDirty()
			end

			if arg_713_1.time_ >= var_716_15 + var_716_23 and arg_713_1.time_ < var_716_15 + var_716_23 + arg_716_0 then
				arg_713_1.typewritter.percent = 1

				arg_713_1.typewritter:SetDirty()
				arg_713_1:ShowNextGo(true)
			end
		end

		arg_713_1.nodeConfigList_ = {
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

		arg_713_1:InitPlayNodeList()
	end,
	Play910201176 = function(arg_717_0, arg_717_1)
		arg_717_1.time_ = 0
		arg_717_1.frameCnt_ = 0
		arg_717_1.state_ = "playing"
		arg_717_1.curTalkId_ = 910201176
		arg_717_1.duration_ = 5

		SetActive(arg_717_1.tipsGo_, false)

		function arg_717_1.onSingleLineFinish_()
			arg_717_1.onSingleLineUpdate_ = nil
			arg_717_1.onSingleLineFinish_ = nil
			arg_717_1.state_ = "waiting"
		end

		function arg_717_1.playNext_(arg_719_0)
			if arg_719_0 == 1 then
				arg_717_0:Play910201177(arg_717_1)
			end
		end

		function arg_717_1.onSingleLineUpdate_(arg_720_0)
			local var_720_0 = arg_717_1.actors_["1084ui_story"]
			local var_720_1 = 0

			if var_720_1 < arg_717_1.time_ and arg_717_1.time_ <= var_720_1 + arg_720_0 and not isNil(var_720_0) and arg_717_1.var_.characterEffect1084ui_story == nil then
				arg_717_1.var_.characterEffect1084ui_story = var_720_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_720_2 = 0.2

			if var_720_1 <= arg_717_1.time_ and arg_717_1.time_ < var_720_1 + var_720_2 and not isNil(var_720_0) then
				local var_720_3 = (arg_717_1.time_ - var_720_1) / var_720_2

				if arg_717_1.var_.characterEffect1084ui_story and not isNil(var_720_0) then
					local var_720_4 = Mathf.Lerp(0, 0.5, var_720_3)

					arg_717_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_717_1.var_.characterEffect1084ui_story.fillRatio = var_720_4
				end
			end

			if arg_717_1.time_ >= var_720_1 + var_720_2 and arg_717_1.time_ < var_720_1 + var_720_2 + arg_720_0 and not isNil(var_720_0) and arg_717_1.var_.characterEffect1084ui_story then
				local var_720_5 = 0.5

				arg_717_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_717_1.var_.characterEffect1084ui_story.fillRatio = var_720_5
			end

			local var_720_6 = 0
			local var_720_7 = 0.4

			if var_720_6 < arg_717_1.time_ and arg_717_1.time_ <= var_720_6 + arg_720_0 then
				arg_717_1.talkMaxDuration = 0
				arg_717_1.dialogCg_.alpha = 1

				arg_717_1.dialog_:SetActive(true)
				SetActive(arg_717_1.leftNameGo_, true)

				local var_720_8 = arg_717_1:FormatText(StoryNameCfg[7].name)

				arg_717_1.leftNameTxt_.text = var_720_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_717_1.leftNameTxt_.transform)

				arg_717_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_717_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_717_1:RecordName(arg_717_1.leftNameTxt_.text)
				SetActive(arg_717_1.iconTrs_.gameObject, true)
				arg_717_1.iconController_:SetSelectedState("hero")

				arg_717_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_717_1.callingController_:SetSelectedState("normal")

				arg_717_1.keyicon_.color = Color.New(1, 1, 1)
				arg_717_1.icon_.color = Color.New(1, 1, 1)

				local var_720_9 = arg_717_1:GetWordFromCfg(910201176)
				local var_720_10 = arg_717_1:FormatText(var_720_9.content)

				arg_717_1.text_.text = var_720_10

				LuaForUtil.ClearLinePrefixSymbol(arg_717_1.text_)

				local var_720_11 = 16
				local var_720_12 = utf8.len(var_720_10)
				local var_720_13 = var_720_11 <= 0 and var_720_7 or var_720_7 * (var_720_12 / var_720_11)

				if var_720_13 > 0 and var_720_7 < var_720_13 then
					arg_717_1.talkMaxDuration = var_720_13

					if var_720_13 + var_720_6 > arg_717_1.duration_ then
						arg_717_1.duration_ = var_720_13 + var_720_6
					end
				end

				arg_717_1.text_.text = var_720_10
				arg_717_1.typewritter.percent = 0

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(false)
				arg_717_1:RecordContent(arg_717_1.text_.text)
			end

			local var_720_14 = math.max(var_720_7, arg_717_1.talkMaxDuration)

			if var_720_6 <= arg_717_1.time_ and arg_717_1.time_ < var_720_6 + var_720_14 then
				arg_717_1.typewritter.percent = (arg_717_1.time_ - var_720_6) / var_720_14

				arg_717_1.typewritter:SetDirty()
			end

			if arg_717_1.time_ >= var_720_6 + var_720_14 and arg_717_1.time_ < var_720_6 + var_720_14 + arg_720_0 then
				arg_717_1.typewritter.percent = 1

				arg_717_1.typewritter:SetDirty()
				arg_717_1:ShowNextGo(true)
			end
		end

		arg_717_1.nodeConfigList_ = {}

		arg_717_1:InitPlayNodeList()
	end,
	Play910201177 = function(arg_721_0, arg_721_1)
		arg_721_1.time_ = 0
		arg_721_1.frameCnt_ = 0
		arg_721_1.state_ = "playing"
		arg_721_1.curTalkId_ = 910201177
		arg_721_1.duration_ = 5

		SetActive(arg_721_1.tipsGo_, false)

		function arg_721_1.onSingleLineFinish_()
			arg_721_1.onSingleLineUpdate_ = nil
			arg_721_1.onSingleLineFinish_ = nil
			arg_721_1.state_ = "waiting"
		end

		function arg_721_1.playNext_(arg_723_0)
			if arg_723_0 == 1 then
				arg_721_0:Play910201178(arg_721_1)
			end
		end

		function arg_721_1.onSingleLineUpdate_(arg_724_0)
			local var_724_0 = arg_721_1.actors_["1084ui_story"]
			local var_724_1 = 0

			if var_724_1 < arg_721_1.time_ and arg_721_1.time_ <= var_724_1 + arg_724_0 and not isNil(var_724_0) and arg_721_1.var_.characterEffect1084ui_story == nil then
				arg_721_1.var_.characterEffect1084ui_story = var_724_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_724_2 = 0.2

			if var_724_1 <= arg_721_1.time_ and arg_721_1.time_ < var_724_1 + var_724_2 and not isNil(var_724_0) then
				local var_724_3 = (arg_721_1.time_ - var_724_1) / var_724_2

				if arg_721_1.var_.characterEffect1084ui_story and not isNil(var_724_0) then
					arg_721_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_721_1.time_ >= var_724_1 + var_724_2 and arg_721_1.time_ < var_724_1 + var_724_2 + arg_724_0 and not isNil(var_724_0) and arg_721_1.var_.characterEffect1084ui_story then
				arg_721_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_724_4 = 0

			if var_724_4 < arg_721_1.time_ and arg_721_1.time_ <= var_724_4 + arg_724_0 then
				arg_721_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action432")
			end

			local var_724_5 = 0

			if var_724_5 < arg_721_1.time_ and arg_721_1.time_ <= var_724_5 + arg_724_0 then
				arg_721_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_724_6 = 0
			local var_724_7 = 0.475

			if var_724_6 < arg_721_1.time_ and arg_721_1.time_ <= var_724_6 + arg_724_0 then
				arg_721_1.talkMaxDuration = 0
				arg_721_1.dialogCg_.alpha = 1

				arg_721_1.dialog_:SetActive(true)
				SetActive(arg_721_1.leftNameGo_, true)

				local var_724_8 = arg_721_1:FormatText(StoryNameCfg[6].name)

				arg_721_1.leftNameTxt_.text = var_724_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_721_1.leftNameTxt_.transform)

				arg_721_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_721_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_721_1:RecordName(arg_721_1.leftNameTxt_.text)
				SetActive(arg_721_1.iconTrs_.gameObject, false)
				arg_721_1.callingController_:SetSelectedState("normal")

				local var_724_9 = arg_721_1:GetWordFromCfg(910201177)
				local var_724_10 = arg_721_1:FormatText(var_724_9.content)

				arg_721_1.text_.text = var_724_10

				LuaForUtil.ClearLinePrefixSymbol(arg_721_1.text_)

				local var_724_11 = 19
				local var_724_12 = utf8.len(var_724_10)
				local var_724_13 = var_724_11 <= 0 and var_724_7 or var_724_7 * (var_724_12 / var_724_11)

				if var_724_13 > 0 and var_724_7 < var_724_13 then
					arg_721_1.talkMaxDuration = var_724_13

					if var_724_13 + var_724_6 > arg_721_1.duration_ then
						arg_721_1.duration_ = var_724_13 + var_724_6
					end
				end

				arg_721_1.text_.text = var_724_10
				arg_721_1.typewritter.percent = 0

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(false)
				arg_721_1:RecordContent(arg_721_1.text_.text)
			end

			local var_724_14 = math.max(var_724_7, arg_721_1.talkMaxDuration)

			if var_724_6 <= arg_721_1.time_ and arg_721_1.time_ < var_724_6 + var_724_14 then
				arg_721_1.typewritter.percent = (arg_721_1.time_ - var_724_6) / var_724_14

				arg_721_1.typewritter:SetDirty()
			end

			if arg_721_1.time_ >= var_724_6 + var_724_14 and arg_721_1.time_ < var_724_6 + var_724_14 + arg_724_0 then
				arg_721_1.typewritter.percent = 1

				arg_721_1.typewritter:SetDirty()
				arg_721_1:ShowNextGo(true)
			end
		end

		arg_721_1.nodeConfigList_ = {}

		arg_721_1:InitPlayNodeList()
	end,
	Play910201178 = function(arg_725_0, arg_725_1)
		arg_725_1.time_ = 0
		arg_725_1.frameCnt_ = 0
		arg_725_1.state_ = "playing"
		arg_725_1.curTalkId_ = 910201178
		arg_725_1.duration_ = 5

		SetActive(arg_725_1.tipsGo_, false)

		function arg_725_1.onSingleLineFinish_()
			arg_725_1.onSingleLineUpdate_ = nil
			arg_725_1.onSingleLineFinish_ = nil
			arg_725_1.state_ = "waiting"
		end

		function arg_725_1.playNext_(arg_727_0)
			if arg_727_0 == 1 then
				arg_725_0:Play910201179(arg_725_1)
			end
		end

		function arg_725_1.onSingleLineUpdate_(arg_728_0)
			local var_728_0 = arg_725_1.actors_["1084ui_story"]
			local var_728_1 = 0

			if var_728_1 < arg_725_1.time_ and arg_725_1.time_ <= var_728_1 + arg_728_0 and not isNil(var_728_0) and arg_725_1.var_.characterEffect1084ui_story == nil then
				arg_725_1.var_.characterEffect1084ui_story = var_728_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_728_2 = 0.2

			if var_728_1 <= arg_725_1.time_ and arg_725_1.time_ < var_728_1 + var_728_2 and not isNil(var_728_0) then
				local var_728_3 = (arg_725_1.time_ - var_728_1) / var_728_2

				if arg_725_1.var_.characterEffect1084ui_story and not isNil(var_728_0) then
					local var_728_4 = Mathf.Lerp(0, 0.5, var_728_3)

					arg_725_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_725_1.var_.characterEffect1084ui_story.fillRatio = var_728_4
				end
			end

			if arg_725_1.time_ >= var_728_1 + var_728_2 and arg_725_1.time_ < var_728_1 + var_728_2 + arg_728_0 and not isNil(var_728_0) and arg_725_1.var_.characterEffect1084ui_story then
				local var_728_5 = 0.5

				arg_725_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_725_1.var_.characterEffect1084ui_story.fillRatio = var_728_5
			end

			local var_728_6 = 0
			local var_728_7 = 0.175

			if var_728_6 < arg_725_1.time_ and arg_725_1.time_ <= var_728_6 + arg_728_0 then
				arg_725_1.talkMaxDuration = 0
				arg_725_1.dialogCg_.alpha = 1

				arg_725_1.dialog_:SetActive(true)
				SetActive(arg_725_1.leftNameGo_, true)

				local var_728_8 = arg_725_1:FormatText(StoryNameCfg[7].name)

				arg_725_1.leftNameTxt_.text = var_728_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_725_1.leftNameTxt_.transform)

				arg_725_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_725_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_725_1:RecordName(arg_725_1.leftNameTxt_.text)
				SetActive(arg_725_1.iconTrs_.gameObject, true)
				arg_725_1.iconController_:SetSelectedState("hero")

				arg_725_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_725_1.callingController_:SetSelectedState("normal")

				arg_725_1.keyicon_.color = Color.New(1, 1, 1)
				arg_725_1.icon_.color = Color.New(1, 1, 1)

				local var_728_9 = arg_725_1:GetWordFromCfg(910201178)
				local var_728_10 = arg_725_1:FormatText(var_728_9.content)

				arg_725_1.text_.text = var_728_10

				LuaForUtil.ClearLinePrefixSymbol(arg_725_1.text_)

				local var_728_11 = 7
				local var_728_12 = utf8.len(var_728_10)
				local var_728_13 = var_728_11 <= 0 and var_728_7 or var_728_7 * (var_728_12 / var_728_11)

				if var_728_13 > 0 and var_728_7 < var_728_13 then
					arg_725_1.talkMaxDuration = var_728_13

					if var_728_13 + var_728_6 > arg_725_1.duration_ then
						arg_725_1.duration_ = var_728_13 + var_728_6
					end
				end

				arg_725_1.text_.text = var_728_10
				arg_725_1.typewritter.percent = 0

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(false)
				arg_725_1:RecordContent(arg_725_1.text_.text)
			end

			local var_728_14 = math.max(var_728_7, arg_725_1.talkMaxDuration)

			if var_728_6 <= arg_725_1.time_ and arg_725_1.time_ < var_728_6 + var_728_14 then
				arg_725_1.typewritter.percent = (arg_725_1.time_ - var_728_6) / var_728_14

				arg_725_1.typewritter:SetDirty()
			end

			if arg_725_1.time_ >= var_728_6 + var_728_14 and arg_725_1.time_ < var_728_6 + var_728_14 + arg_728_0 then
				arg_725_1.typewritter.percent = 1

				arg_725_1.typewritter:SetDirty()
				arg_725_1:ShowNextGo(true)
			end
		end

		arg_725_1.nodeConfigList_ = {}

		arg_725_1:InitPlayNodeList()
	end,
	Play910201179 = function(arg_729_0, arg_729_1)
		arg_729_1.time_ = 0
		arg_729_1.frameCnt_ = 0
		arg_729_1.state_ = "playing"
		arg_729_1.curTalkId_ = 910201179
		arg_729_1.duration_ = 5

		SetActive(arg_729_1.tipsGo_, false)

		function arg_729_1.onSingleLineFinish_()
			arg_729_1.onSingleLineUpdate_ = nil
			arg_729_1.onSingleLineFinish_ = nil
			arg_729_1.state_ = "waiting"
		end

		function arg_729_1.playNext_(arg_731_0)
			if arg_731_0 == 1 then
				arg_729_0:Play910201180(arg_729_1)
			end
		end

		function arg_729_1.onSingleLineUpdate_(arg_732_0)
			local var_732_0 = arg_729_1.actors_["1084ui_story"]
			local var_732_1 = 0

			if var_732_1 < arg_729_1.time_ and arg_729_1.time_ <= var_732_1 + arg_732_0 and not isNil(var_732_0) and arg_729_1.var_.characterEffect1084ui_story == nil then
				arg_729_1.var_.characterEffect1084ui_story = var_732_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_732_2 = 0.2

			if var_732_1 <= arg_729_1.time_ and arg_729_1.time_ < var_732_1 + var_732_2 and not isNil(var_732_0) then
				local var_732_3 = (arg_729_1.time_ - var_732_1) / var_732_2

				if arg_729_1.var_.characterEffect1084ui_story and not isNil(var_732_0) then
					arg_729_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_729_1.time_ >= var_732_1 + var_732_2 and arg_729_1.time_ < var_732_1 + var_732_2 + arg_732_0 and not isNil(var_732_0) and arg_729_1.var_.characterEffect1084ui_story then
				arg_729_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_732_4 = 0

			if var_732_4 < arg_729_1.time_ and arg_729_1.time_ <= var_732_4 + arg_732_0 then
				arg_729_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action428")
			end

			local var_732_5 = 0

			if var_732_5 < arg_729_1.time_ and arg_729_1.time_ <= var_732_5 + arg_732_0 then
				arg_729_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_732_6 = 0
			local var_732_7 = 0.475

			if var_732_6 < arg_729_1.time_ and arg_729_1.time_ <= var_732_6 + arg_732_0 then
				arg_729_1.talkMaxDuration = 0
				arg_729_1.dialogCg_.alpha = 1

				arg_729_1.dialog_:SetActive(true)
				SetActive(arg_729_1.leftNameGo_, true)

				local var_732_8 = arg_729_1:FormatText(StoryNameCfg[6].name)

				arg_729_1.leftNameTxt_.text = var_732_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_729_1.leftNameTxt_.transform)

				arg_729_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_729_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_729_1:RecordName(arg_729_1.leftNameTxt_.text)
				SetActive(arg_729_1.iconTrs_.gameObject, false)
				arg_729_1.callingController_:SetSelectedState("normal")

				local var_732_9 = arg_729_1:GetWordFromCfg(910201179)
				local var_732_10 = arg_729_1:FormatText(var_732_9.content)

				arg_729_1.text_.text = var_732_10

				LuaForUtil.ClearLinePrefixSymbol(arg_729_1.text_)

				local var_732_11 = 19
				local var_732_12 = utf8.len(var_732_10)
				local var_732_13 = var_732_11 <= 0 and var_732_7 or var_732_7 * (var_732_12 / var_732_11)

				if var_732_13 > 0 and var_732_7 < var_732_13 then
					arg_729_1.talkMaxDuration = var_732_13

					if var_732_13 + var_732_6 > arg_729_1.duration_ then
						arg_729_1.duration_ = var_732_13 + var_732_6
					end
				end

				arg_729_1.text_.text = var_732_10
				arg_729_1.typewritter.percent = 0

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(false)
				arg_729_1:RecordContent(arg_729_1.text_.text)
			end

			local var_732_14 = math.max(var_732_7, arg_729_1.talkMaxDuration)

			if var_732_6 <= arg_729_1.time_ and arg_729_1.time_ < var_732_6 + var_732_14 then
				arg_729_1.typewritter.percent = (arg_729_1.time_ - var_732_6) / var_732_14

				arg_729_1.typewritter:SetDirty()
			end

			if arg_729_1.time_ >= var_732_6 + var_732_14 and arg_729_1.time_ < var_732_6 + var_732_14 + arg_732_0 then
				arg_729_1.typewritter.percent = 1

				arg_729_1.typewritter:SetDirty()
				arg_729_1:ShowNextGo(true)
			end
		end

		arg_729_1.nodeConfigList_ = {}

		arg_729_1:InitPlayNodeList()
	end,
	Play910201180 = function(arg_733_0, arg_733_1)
		arg_733_1.time_ = 0
		arg_733_1.frameCnt_ = 0
		arg_733_1.state_ = "playing"
		arg_733_1.curTalkId_ = 910201180
		arg_733_1.duration_ = 5

		SetActive(arg_733_1.tipsGo_, false)

		function arg_733_1.onSingleLineFinish_()
			arg_733_1.onSingleLineUpdate_ = nil
			arg_733_1.onSingleLineFinish_ = nil
			arg_733_1.state_ = "waiting"
		end

		function arg_733_1.playNext_(arg_735_0)
			if arg_735_0 == 1 then
				arg_733_0:Play910201181(arg_733_1)
			end
		end

		function arg_733_1.onSingleLineUpdate_(arg_736_0)
			local var_736_0 = arg_733_1.actors_["1084ui_story"]
			local var_736_1 = 0

			if var_736_1 < arg_733_1.time_ and arg_733_1.time_ <= var_736_1 + arg_736_0 and not isNil(var_736_0) and arg_733_1.var_.characterEffect1084ui_story == nil then
				arg_733_1.var_.characterEffect1084ui_story = var_736_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_736_2 = 0.2

			if var_736_1 <= arg_733_1.time_ and arg_733_1.time_ < var_736_1 + var_736_2 and not isNil(var_736_0) then
				local var_736_3 = (arg_733_1.time_ - var_736_1) / var_736_2

				if arg_733_1.var_.characterEffect1084ui_story and not isNil(var_736_0) then
					local var_736_4 = Mathf.Lerp(0, 0.5, var_736_3)

					arg_733_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_733_1.var_.characterEffect1084ui_story.fillRatio = var_736_4
				end
			end

			if arg_733_1.time_ >= var_736_1 + var_736_2 and arg_733_1.time_ < var_736_1 + var_736_2 + arg_736_0 and not isNil(var_736_0) and arg_733_1.var_.characterEffect1084ui_story then
				local var_736_5 = 0.5

				arg_733_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_733_1.var_.characterEffect1084ui_story.fillRatio = var_736_5
			end

			local var_736_6 = 0
			local var_736_7 = 0.3

			if var_736_6 < arg_733_1.time_ and arg_733_1.time_ <= var_736_6 + arg_736_0 then
				arg_733_1.talkMaxDuration = 0
				arg_733_1.dialogCg_.alpha = 1

				arg_733_1.dialog_:SetActive(true)
				SetActive(arg_733_1.leftNameGo_, true)

				local var_736_8 = arg_733_1:FormatText(StoryNameCfg[7].name)

				arg_733_1.leftNameTxt_.text = var_736_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_733_1.leftNameTxt_.transform)

				arg_733_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_733_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_733_1:RecordName(arg_733_1.leftNameTxt_.text)
				SetActive(arg_733_1.iconTrs_.gameObject, true)
				arg_733_1.iconController_:SetSelectedState("hero")

				arg_733_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_733_1.callingController_:SetSelectedState("normal")

				arg_733_1.keyicon_.color = Color.New(1, 1, 1)
				arg_733_1.icon_.color = Color.New(1, 1, 1)

				local var_736_9 = arg_733_1:GetWordFromCfg(910201180)
				local var_736_10 = arg_733_1:FormatText(var_736_9.content)

				arg_733_1.text_.text = var_736_10

				LuaForUtil.ClearLinePrefixSymbol(arg_733_1.text_)

				local var_736_11 = 12
				local var_736_12 = utf8.len(var_736_10)
				local var_736_13 = var_736_11 <= 0 and var_736_7 or var_736_7 * (var_736_12 / var_736_11)

				if var_736_13 > 0 and var_736_7 < var_736_13 then
					arg_733_1.talkMaxDuration = var_736_13

					if var_736_13 + var_736_6 > arg_733_1.duration_ then
						arg_733_1.duration_ = var_736_13 + var_736_6
					end
				end

				arg_733_1.text_.text = var_736_10
				arg_733_1.typewritter.percent = 0

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(false)
				arg_733_1:RecordContent(arg_733_1.text_.text)
			end

			local var_736_14 = math.max(var_736_7, arg_733_1.talkMaxDuration)

			if var_736_6 <= arg_733_1.time_ and arg_733_1.time_ < var_736_6 + var_736_14 then
				arg_733_1.typewritter.percent = (arg_733_1.time_ - var_736_6) / var_736_14

				arg_733_1.typewritter:SetDirty()
			end

			if arg_733_1.time_ >= var_736_6 + var_736_14 and arg_733_1.time_ < var_736_6 + var_736_14 + arg_736_0 then
				arg_733_1.typewritter.percent = 1

				arg_733_1.typewritter:SetDirty()
				arg_733_1:ShowNextGo(true)
			end
		end

		arg_733_1.nodeConfigList_ = {}

		arg_733_1:InitPlayNodeList()
	end,
	Play910201181 = function(arg_737_0, arg_737_1)
		arg_737_1.time_ = 0
		arg_737_1.frameCnt_ = 0
		arg_737_1.state_ = "playing"
		arg_737_1.curTalkId_ = 910201181
		arg_737_1.duration_ = 5

		SetActive(arg_737_1.tipsGo_, false)

		function arg_737_1.onSingleLineFinish_()
			arg_737_1.onSingleLineUpdate_ = nil
			arg_737_1.onSingleLineFinish_ = nil
			arg_737_1.state_ = "waiting"
		end

		function arg_737_1.playNext_(arg_739_0)
			if arg_739_0 == 1 then
				arg_737_0:Play910201182(arg_737_1)
			end
		end

		function arg_737_1.onSingleLineUpdate_(arg_740_0)
			local var_740_0 = arg_737_1.actors_["1084ui_story"]
			local var_740_1 = 0

			if var_740_1 < arg_737_1.time_ and arg_737_1.time_ <= var_740_1 + arg_740_0 and not isNil(var_740_0) and arg_737_1.var_.characterEffect1084ui_story == nil then
				arg_737_1.var_.characterEffect1084ui_story = var_740_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_740_2 = 0.2

			if var_740_1 <= arg_737_1.time_ and arg_737_1.time_ < var_740_1 + var_740_2 and not isNil(var_740_0) then
				local var_740_3 = (arg_737_1.time_ - var_740_1) / var_740_2

				if arg_737_1.var_.characterEffect1084ui_story and not isNil(var_740_0) then
					arg_737_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_737_1.time_ >= var_740_1 + var_740_2 and arg_737_1.time_ < var_740_1 + var_740_2 + arg_740_0 and not isNil(var_740_0) and arg_737_1.var_.characterEffect1084ui_story then
				arg_737_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_740_4 = 0

			if var_740_4 < arg_737_1.time_ and arg_737_1.time_ <= var_740_4 + arg_740_0 then
				arg_737_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action486")
			end

			local var_740_5 = 0

			if var_740_5 < arg_737_1.time_ and arg_737_1.time_ <= var_740_5 + arg_740_0 then
				arg_737_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_740_6 = 0
			local var_740_7 = 0.825

			if var_740_6 < arg_737_1.time_ and arg_737_1.time_ <= var_740_6 + arg_740_0 then
				arg_737_1.talkMaxDuration = 0
				arg_737_1.dialogCg_.alpha = 1

				arg_737_1.dialog_:SetActive(true)
				SetActive(arg_737_1.leftNameGo_, true)

				local var_740_8 = arg_737_1:FormatText(StoryNameCfg[6].name)

				arg_737_1.leftNameTxt_.text = var_740_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_737_1.leftNameTxt_.transform)

				arg_737_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_737_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_737_1:RecordName(arg_737_1.leftNameTxt_.text)
				SetActive(arg_737_1.iconTrs_.gameObject, false)
				arg_737_1.callingController_:SetSelectedState("normal")

				local var_740_9 = arg_737_1:GetWordFromCfg(910201181)
				local var_740_10 = arg_737_1:FormatText(var_740_9.content)

				arg_737_1.text_.text = var_740_10

				LuaForUtil.ClearLinePrefixSymbol(arg_737_1.text_)

				local var_740_11 = 33
				local var_740_12 = utf8.len(var_740_10)
				local var_740_13 = var_740_11 <= 0 and var_740_7 or var_740_7 * (var_740_12 / var_740_11)

				if var_740_13 > 0 and var_740_7 < var_740_13 then
					arg_737_1.talkMaxDuration = var_740_13

					if var_740_13 + var_740_6 > arg_737_1.duration_ then
						arg_737_1.duration_ = var_740_13 + var_740_6
					end
				end

				arg_737_1.text_.text = var_740_10
				arg_737_1.typewritter.percent = 0

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(false)
				arg_737_1:RecordContent(arg_737_1.text_.text)
			end

			local var_740_14 = math.max(var_740_7, arg_737_1.talkMaxDuration)

			if var_740_6 <= arg_737_1.time_ and arg_737_1.time_ < var_740_6 + var_740_14 then
				arg_737_1.typewritter.percent = (arg_737_1.time_ - var_740_6) / var_740_14

				arg_737_1.typewritter:SetDirty()
			end

			if arg_737_1.time_ >= var_740_6 + var_740_14 and arg_737_1.time_ < var_740_6 + var_740_14 + arg_740_0 then
				arg_737_1.typewritter.percent = 1

				arg_737_1.typewritter:SetDirty()
				arg_737_1:ShowNextGo(true)
			end
		end

		arg_737_1.nodeConfigList_ = {}

		arg_737_1:InitPlayNodeList()
	end,
	Play910201182 = function(arg_741_0, arg_741_1)
		arg_741_1.time_ = 0
		arg_741_1.frameCnt_ = 0
		arg_741_1.state_ = "playing"
		arg_741_1.curTalkId_ = 910201182
		arg_741_1.duration_ = 5

		SetActive(arg_741_1.tipsGo_, false)

		function arg_741_1.onSingleLineFinish_()
			arg_741_1.onSingleLineUpdate_ = nil
			arg_741_1.onSingleLineFinish_ = nil
			arg_741_1.state_ = "waiting"
		end

		function arg_741_1.playNext_(arg_743_0)
			if arg_743_0 == 1 then
				arg_741_0:Play910201183(arg_741_1)
			end
		end

		function arg_741_1.onSingleLineUpdate_(arg_744_0)
			local var_744_0 = 0

			if var_744_0 < arg_741_1.time_ and arg_741_1.time_ <= var_744_0 + arg_744_0 then
				arg_741_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action467")
			end

			local var_744_1 = 0

			if var_744_1 < arg_741_1.time_ and arg_741_1.time_ <= var_744_1 + arg_744_0 then
				arg_741_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_744_2 = 0
			local var_744_3 = 0.775

			if var_744_2 < arg_741_1.time_ and arg_741_1.time_ <= var_744_2 + arg_744_0 then
				arg_741_1.talkMaxDuration = 0
				arg_741_1.dialogCg_.alpha = 1

				arg_741_1.dialog_:SetActive(true)
				SetActive(arg_741_1.leftNameGo_, true)

				local var_744_4 = arg_741_1:FormatText(StoryNameCfg[6].name)

				arg_741_1.leftNameTxt_.text = var_744_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_741_1.leftNameTxt_.transform)

				arg_741_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_741_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_741_1:RecordName(arg_741_1.leftNameTxt_.text)
				SetActive(arg_741_1.iconTrs_.gameObject, false)
				arg_741_1.callingController_:SetSelectedState("normal")

				local var_744_5 = arg_741_1:GetWordFromCfg(910201182)
				local var_744_6 = arg_741_1:FormatText(var_744_5.content)

				arg_741_1.text_.text = var_744_6

				LuaForUtil.ClearLinePrefixSymbol(arg_741_1.text_)

				local var_744_7 = 31
				local var_744_8 = utf8.len(var_744_6)
				local var_744_9 = var_744_7 <= 0 and var_744_3 or var_744_3 * (var_744_8 / var_744_7)

				if var_744_9 > 0 and var_744_3 < var_744_9 then
					arg_741_1.talkMaxDuration = var_744_9

					if var_744_9 + var_744_2 > arg_741_1.duration_ then
						arg_741_1.duration_ = var_744_9 + var_744_2
					end
				end

				arg_741_1.text_.text = var_744_6
				arg_741_1.typewritter.percent = 0

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(false)
				arg_741_1:RecordContent(arg_741_1.text_.text)
			end

			local var_744_10 = math.max(var_744_3, arg_741_1.talkMaxDuration)

			if var_744_2 <= arg_741_1.time_ and arg_741_1.time_ < var_744_2 + var_744_10 then
				arg_741_1.typewritter.percent = (arg_741_1.time_ - var_744_2) / var_744_10

				arg_741_1.typewritter:SetDirty()
			end

			if arg_741_1.time_ >= var_744_2 + var_744_10 and arg_741_1.time_ < var_744_2 + var_744_10 + arg_744_0 then
				arg_741_1.typewritter.percent = 1

				arg_741_1.typewritter:SetDirty()
				arg_741_1:ShowNextGo(true)
			end
		end

		arg_741_1.nodeConfigList_ = {}

		arg_741_1:InitPlayNodeList()
	end,
	Play910201183 = function(arg_745_0, arg_745_1)
		arg_745_1.time_ = 0
		arg_745_1.frameCnt_ = 0
		arg_745_1.state_ = "playing"
		arg_745_1.curTalkId_ = 910201183
		arg_745_1.duration_ = 5

		SetActive(arg_745_1.tipsGo_, false)

		function arg_745_1.onSingleLineFinish_()
			arg_745_1.onSingleLineUpdate_ = nil
			arg_745_1.onSingleLineFinish_ = nil
			arg_745_1.state_ = "waiting"
		end

		function arg_745_1.playNext_(arg_747_0)
			if arg_747_0 == 1 then
				arg_745_0:Play910201184(arg_745_1)
			end
		end

		function arg_745_1.onSingleLineUpdate_(arg_748_0)
			local var_748_0 = 0

			if var_748_0 < arg_745_1.time_ and arg_745_1.time_ <= var_748_0 + arg_748_0 then
				arg_745_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_748_1 = 0
			local var_748_2 = 0.825

			if var_748_1 < arg_745_1.time_ and arg_745_1.time_ <= var_748_1 + arg_748_0 then
				arg_745_1.talkMaxDuration = 0
				arg_745_1.dialogCg_.alpha = 1

				arg_745_1.dialog_:SetActive(true)
				SetActive(arg_745_1.leftNameGo_, true)

				local var_748_3 = arg_745_1:FormatText(StoryNameCfg[6].name)

				arg_745_1.leftNameTxt_.text = var_748_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_745_1.leftNameTxt_.transform)

				arg_745_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_745_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_745_1:RecordName(arg_745_1.leftNameTxt_.text)
				SetActive(arg_745_1.iconTrs_.gameObject, false)
				arg_745_1.callingController_:SetSelectedState("normal")

				local var_748_4 = arg_745_1:GetWordFromCfg(910201183)
				local var_748_5 = arg_745_1:FormatText(var_748_4.content)

				arg_745_1.text_.text = var_748_5

				LuaForUtil.ClearLinePrefixSymbol(arg_745_1.text_)

				local var_748_6 = 33
				local var_748_7 = utf8.len(var_748_5)
				local var_748_8 = var_748_6 <= 0 and var_748_2 or var_748_2 * (var_748_7 / var_748_6)

				if var_748_8 > 0 and var_748_2 < var_748_8 then
					arg_745_1.talkMaxDuration = var_748_8

					if var_748_8 + var_748_1 > arg_745_1.duration_ then
						arg_745_1.duration_ = var_748_8 + var_748_1
					end
				end

				arg_745_1.text_.text = var_748_5
				arg_745_1.typewritter.percent = 0

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(false)
				arg_745_1:RecordContent(arg_745_1.text_.text)
			end

			local var_748_9 = math.max(var_748_2, arg_745_1.talkMaxDuration)

			if var_748_1 <= arg_745_1.time_ and arg_745_1.time_ < var_748_1 + var_748_9 then
				arg_745_1.typewritter.percent = (arg_745_1.time_ - var_748_1) / var_748_9

				arg_745_1.typewritter:SetDirty()
			end

			if arg_745_1.time_ >= var_748_1 + var_748_9 and arg_745_1.time_ < var_748_1 + var_748_9 + arg_748_0 then
				arg_745_1.typewritter.percent = 1

				arg_745_1.typewritter:SetDirty()
				arg_745_1:ShowNextGo(true)
			end
		end

		arg_745_1.nodeConfigList_ = {}

		arg_745_1:InitPlayNodeList()
	end,
	Play910201184 = function(arg_749_0, arg_749_1)
		arg_749_1.time_ = 0
		arg_749_1.frameCnt_ = 0
		arg_749_1.state_ = "playing"
		arg_749_1.curTalkId_ = 910201184
		arg_749_1.duration_ = 5

		SetActive(arg_749_1.tipsGo_, false)

		function arg_749_1.onSingleLineFinish_()
			arg_749_1.onSingleLineUpdate_ = nil
			arg_749_1.onSingleLineFinish_ = nil
			arg_749_1.state_ = "waiting"
		end

		function arg_749_1.playNext_(arg_751_0)
			if arg_751_0 == 1 then
				arg_749_0:Play910201185(arg_749_1)
			end
		end

		function arg_749_1.onSingleLineUpdate_(arg_752_0)
			local var_752_0 = 0

			if var_752_0 < arg_749_1.time_ and arg_749_1.time_ <= var_752_0 + arg_752_0 then
				arg_749_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action473")
			end

			local var_752_1 = 0

			if var_752_1 < arg_749_1.time_ and arg_749_1.time_ <= var_752_1 + arg_752_0 then
				arg_749_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_752_2 = 0
			local var_752_3 = 1.05

			if var_752_2 < arg_749_1.time_ and arg_749_1.time_ <= var_752_2 + arg_752_0 then
				arg_749_1.talkMaxDuration = 0
				arg_749_1.dialogCg_.alpha = 1

				arg_749_1.dialog_:SetActive(true)
				SetActive(arg_749_1.leftNameGo_, true)

				local var_752_4 = arg_749_1:FormatText(StoryNameCfg[6].name)

				arg_749_1.leftNameTxt_.text = var_752_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_749_1.leftNameTxt_.transform)

				arg_749_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_749_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_749_1:RecordName(arg_749_1.leftNameTxt_.text)
				SetActive(arg_749_1.iconTrs_.gameObject, false)
				arg_749_1.callingController_:SetSelectedState("normal")

				local var_752_5 = arg_749_1:GetWordFromCfg(910201184)
				local var_752_6 = arg_749_1:FormatText(var_752_5.content)

				arg_749_1.text_.text = var_752_6

				LuaForUtil.ClearLinePrefixSymbol(arg_749_1.text_)

				local var_752_7 = 42
				local var_752_8 = utf8.len(var_752_6)
				local var_752_9 = var_752_7 <= 0 and var_752_3 or var_752_3 * (var_752_8 / var_752_7)

				if var_752_9 > 0 and var_752_3 < var_752_9 then
					arg_749_1.talkMaxDuration = var_752_9

					if var_752_9 + var_752_2 > arg_749_1.duration_ then
						arg_749_1.duration_ = var_752_9 + var_752_2
					end
				end

				arg_749_1.text_.text = var_752_6
				arg_749_1.typewritter.percent = 0

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(false)
				arg_749_1:RecordContent(arg_749_1.text_.text)
			end

			local var_752_10 = math.max(var_752_3, arg_749_1.talkMaxDuration)

			if var_752_2 <= arg_749_1.time_ and arg_749_1.time_ < var_752_2 + var_752_10 then
				arg_749_1.typewritter.percent = (arg_749_1.time_ - var_752_2) / var_752_10

				arg_749_1.typewritter:SetDirty()
			end

			if arg_749_1.time_ >= var_752_2 + var_752_10 and arg_749_1.time_ < var_752_2 + var_752_10 + arg_752_0 then
				arg_749_1.typewritter.percent = 1

				arg_749_1.typewritter:SetDirty()
				arg_749_1:ShowNextGo(true)
			end
		end

		arg_749_1.nodeConfigList_ = {}

		arg_749_1:InitPlayNodeList()
	end,
	Play910201185 = function(arg_753_0, arg_753_1)
		arg_753_1.time_ = 0
		arg_753_1.frameCnt_ = 0
		arg_753_1.state_ = "playing"
		arg_753_1.curTalkId_ = 910201185
		arg_753_1.duration_ = 5

		SetActive(arg_753_1.tipsGo_, false)

		function arg_753_1.onSingleLineFinish_()
			arg_753_1.onSingleLineUpdate_ = nil
			arg_753_1.onSingleLineFinish_ = nil
			arg_753_1.state_ = "waiting"
		end

		function arg_753_1.playNext_(arg_755_0)
			if arg_755_0 == 1 then
				arg_753_0:Play910201186(arg_753_1)
			end
		end

		function arg_753_1.onSingleLineUpdate_(arg_756_0)
			local var_756_0 = arg_753_1.actors_["1084ui_story"]
			local var_756_1 = 0

			if var_756_1 < arg_753_1.time_ and arg_753_1.time_ <= var_756_1 + arg_756_0 and not isNil(var_756_0) and arg_753_1.var_.characterEffect1084ui_story == nil then
				arg_753_1.var_.characterEffect1084ui_story = var_756_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_756_2 = 0.2

			if var_756_1 <= arg_753_1.time_ and arg_753_1.time_ < var_756_1 + var_756_2 and not isNil(var_756_0) then
				local var_756_3 = (arg_753_1.time_ - var_756_1) / var_756_2

				if arg_753_1.var_.characterEffect1084ui_story and not isNil(var_756_0) then
					local var_756_4 = Mathf.Lerp(0, 0.5, var_756_3)

					arg_753_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_753_1.var_.characterEffect1084ui_story.fillRatio = var_756_4
				end
			end

			if arg_753_1.time_ >= var_756_1 + var_756_2 and arg_753_1.time_ < var_756_1 + var_756_2 + arg_756_0 and not isNil(var_756_0) and arg_753_1.var_.characterEffect1084ui_story then
				local var_756_5 = 0.5

				arg_753_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_753_1.var_.characterEffect1084ui_story.fillRatio = var_756_5
			end

			local var_756_6 = 0
			local var_756_7 = 0.425

			if var_756_6 < arg_753_1.time_ and arg_753_1.time_ <= var_756_6 + arg_756_0 then
				arg_753_1.talkMaxDuration = 0
				arg_753_1.dialogCg_.alpha = 1

				arg_753_1.dialog_:SetActive(true)
				SetActive(arg_753_1.leftNameGo_, true)

				local var_756_8 = arg_753_1:FormatText(StoryNameCfg[7].name)

				arg_753_1.leftNameTxt_.text = var_756_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_753_1.leftNameTxt_.transform)

				arg_753_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_753_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_753_1:RecordName(arg_753_1.leftNameTxt_.text)
				SetActive(arg_753_1.iconTrs_.gameObject, true)
				arg_753_1.iconController_:SetSelectedState("hero")

				arg_753_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_753_1.callingController_:SetSelectedState("normal")

				arg_753_1.keyicon_.color = Color.New(1, 1, 1)
				arg_753_1.icon_.color = Color.New(1, 1, 1)

				local var_756_9 = arg_753_1:GetWordFromCfg(910201185)
				local var_756_10 = arg_753_1:FormatText(var_756_9.content)

				arg_753_1.text_.text = var_756_10

				LuaForUtil.ClearLinePrefixSymbol(arg_753_1.text_)

				local var_756_11 = 17
				local var_756_12 = utf8.len(var_756_10)
				local var_756_13 = var_756_11 <= 0 and var_756_7 or var_756_7 * (var_756_12 / var_756_11)

				if var_756_13 > 0 and var_756_7 < var_756_13 then
					arg_753_1.talkMaxDuration = var_756_13

					if var_756_13 + var_756_6 > arg_753_1.duration_ then
						arg_753_1.duration_ = var_756_13 + var_756_6
					end
				end

				arg_753_1.text_.text = var_756_10
				arg_753_1.typewritter.percent = 0

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(false)
				arg_753_1:RecordContent(arg_753_1.text_.text)
			end

			local var_756_14 = math.max(var_756_7, arg_753_1.talkMaxDuration)

			if var_756_6 <= arg_753_1.time_ and arg_753_1.time_ < var_756_6 + var_756_14 then
				arg_753_1.typewritter.percent = (arg_753_1.time_ - var_756_6) / var_756_14

				arg_753_1.typewritter:SetDirty()
			end

			if arg_753_1.time_ >= var_756_6 + var_756_14 and arg_753_1.time_ < var_756_6 + var_756_14 + arg_756_0 then
				arg_753_1.typewritter.percent = 1

				arg_753_1.typewritter:SetDirty()
				arg_753_1:ShowNextGo(true)
			end
		end

		arg_753_1.nodeConfigList_ = {}

		arg_753_1:InitPlayNodeList()
	end,
	Play910201186 = function(arg_757_0, arg_757_1)
		arg_757_1.time_ = 0
		arg_757_1.frameCnt_ = 0
		arg_757_1.state_ = "playing"
		arg_757_1.curTalkId_ = 910201186
		arg_757_1.duration_ = 5

		SetActive(arg_757_1.tipsGo_, false)

		function arg_757_1.onSingleLineFinish_()
			arg_757_1.onSingleLineUpdate_ = nil
			arg_757_1.onSingleLineFinish_ = nil
			arg_757_1.state_ = "waiting"
		end

		function arg_757_1.playNext_(arg_759_0)
			if arg_759_0 == 1 then
				arg_757_0:Play910201187(arg_757_1)
			end
		end

		function arg_757_1.onSingleLineUpdate_(arg_760_0)
			local var_760_0 = arg_757_1.actors_["1013ui_story"].transform
			local var_760_1 = 0

			if var_760_1 < arg_757_1.time_ and arg_757_1.time_ <= var_760_1 + arg_760_0 then
				arg_757_1.var_.moveOldPos1013ui_story = var_760_0.localPosition
			end

			local var_760_2 = 0.001

			if var_760_1 <= arg_757_1.time_ and arg_757_1.time_ < var_760_1 + var_760_2 then
				local var_760_3 = (arg_757_1.time_ - var_760_1) / var_760_2
				local var_760_4 = Vector3.New(0, -0.66, -6.15)

				var_760_0.localPosition = Vector3.Lerp(arg_757_1.var_.moveOldPos1013ui_story, var_760_4, var_760_3)

				local var_760_5 = manager.ui.mainCamera.transform.position - var_760_0.position

				var_760_0.forward = Vector3.New(var_760_5.x, var_760_5.y, var_760_5.z)

				local var_760_6 = var_760_0.localEulerAngles

				var_760_6.z = 0
				var_760_6.x = 0
				var_760_0.localEulerAngles = var_760_6
			end

			if arg_757_1.time_ >= var_760_1 + var_760_2 and arg_757_1.time_ < var_760_1 + var_760_2 + arg_760_0 then
				var_760_0.localPosition = Vector3.New(0, -0.66, -6.15)

				local var_760_7 = manager.ui.mainCamera.transform.position - var_760_0.position

				var_760_0.forward = Vector3.New(var_760_7.x, var_760_7.y, var_760_7.z)

				local var_760_8 = var_760_0.localEulerAngles

				var_760_8.z = 0
				var_760_8.x = 0
				var_760_0.localEulerAngles = var_760_8
			end

			local var_760_9 = 0

			if var_760_9 < arg_757_1.time_ and arg_757_1.time_ <= var_760_9 + arg_760_0 then
				arg_757_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013action/1013action10_1")
			end

			local var_760_10 = arg_757_1.actors_["1084ui_story"].transform
			local var_760_11 = 0

			if var_760_11 < arg_757_1.time_ and arg_757_1.time_ <= var_760_11 + arg_760_0 then
				arg_757_1.var_.moveOldPos1084ui_story = var_760_10.localPosition
			end

			local var_760_12 = 0.001

			if var_760_11 <= arg_757_1.time_ and arg_757_1.time_ < var_760_11 + var_760_12 then
				local var_760_13 = (arg_757_1.time_ - var_760_11) / var_760_12
				local var_760_14 = Vector3.New(0, 100, 0)

				var_760_10.localPosition = Vector3.Lerp(arg_757_1.var_.moveOldPos1084ui_story, var_760_14, var_760_13)

				local var_760_15 = manager.ui.mainCamera.transform.position - var_760_10.position

				var_760_10.forward = Vector3.New(var_760_15.x, var_760_15.y, var_760_15.z)

				local var_760_16 = var_760_10.localEulerAngles

				var_760_16.z = 0
				var_760_16.x = 0
				var_760_10.localEulerAngles = var_760_16
			end

			if arg_757_1.time_ >= var_760_11 + var_760_12 and arg_757_1.time_ < var_760_11 + var_760_12 + arg_760_0 then
				var_760_10.localPosition = Vector3.New(0, 100, 0)

				local var_760_17 = manager.ui.mainCamera.transform.position - var_760_10.position

				var_760_10.forward = Vector3.New(var_760_17.x, var_760_17.y, var_760_17.z)

				local var_760_18 = var_760_10.localEulerAngles

				var_760_18.z = 0
				var_760_18.x = 0
				var_760_10.localEulerAngles = var_760_18
			end

			local var_760_19 = arg_757_1.actors_["1013ui_story"]
			local var_760_20 = 0

			if var_760_20 < arg_757_1.time_ and arg_757_1.time_ <= var_760_20 + arg_760_0 and not isNil(var_760_19) and arg_757_1.var_.characterEffect1013ui_story == nil then
				arg_757_1.var_.characterEffect1013ui_story = var_760_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_760_21 = 0.2

			if var_760_20 <= arg_757_1.time_ and arg_757_1.time_ < var_760_20 + var_760_21 and not isNil(var_760_19) then
				local var_760_22 = (arg_757_1.time_ - var_760_20) / var_760_21

				if arg_757_1.var_.characterEffect1013ui_story and not isNil(var_760_19) then
					arg_757_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_757_1.time_ >= var_760_20 + var_760_21 and arg_757_1.time_ < var_760_20 + var_760_21 + arg_760_0 and not isNil(var_760_19) and arg_757_1.var_.characterEffect1013ui_story then
				arg_757_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_760_23 = 0

			if var_760_23 < arg_757_1.time_ and arg_757_1.time_ <= var_760_23 + arg_760_0 then
				arg_757_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_760_24 = 0
			local var_760_25 = 0.575

			if var_760_24 < arg_757_1.time_ and arg_757_1.time_ <= var_760_24 + arg_760_0 then
				arg_757_1.talkMaxDuration = 0
				arg_757_1.dialogCg_.alpha = 1

				arg_757_1.dialog_:SetActive(true)
				SetActive(arg_757_1.leftNameGo_, true)

				local var_760_26 = arg_757_1:FormatText(StoryNameCfg[35].name)

				arg_757_1.leftNameTxt_.text = var_760_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_757_1.leftNameTxt_.transform)

				arg_757_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_757_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_757_1:RecordName(arg_757_1.leftNameTxt_.text)
				SetActive(arg_757_1.iconTrs_.gameObject, false)
				arg_757_1.callingController_:SetSelectedState("normal")

				local var_760_27 = arg_757_1:GetWordFromCfg(910201186)
				local var_760_28 = arg_757_1:FormatText(var_760_27.content)

				arg_757_1.text_.text = var_760_28

				LuaForUtil.ClearLinePrefixSymbol(arg_757_1.text_)

				local var_760_29 = 23
				local var_760_30 = utf8.len(var_760_28)
				local var_760_31 = var_760_29 <= 0 and var_760_25 or var_760_25 * (var_760_30 / var_760_29)

				if var_760_31 > 0 and var_760_25 < var_760_31 then
					arg_757_1.talkMaxDuration = var_760_31

					if var_760_31 + var_760_24 > arg_757_1.duration_ then
						arg_757_1.duration_ = var_760_31 + var_760_24
					end
				end

				arg_757_1.text_.text = var_760_28
				arg_757_1.typewritter.percent = 0

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(false)
				arg_757_1:RecordContent(arg_757_1.text_.text)
			end

			local var_760_32 = math.max(var_760_25, arg_757_1.talkMaxDuration)

			if var_760_24 <= arg_757_1.time_ and arg_757_1.time_ < var_760_24 + var_760_32 then
				arg_757_1.typewritter.percent = (arg_757_1.time_ - var_760_24) / var_760_32

				arg_757_1.typewritter:SetDirty()
			end

			if arg_757_1.time_ >= var_760_24 + var_760_32 and arg_757_1.time_ < var_760_24 + var_760_32 + arg_760_0 then
				arg_757_1.typewritter.percent = 1

				arg_757_1.typewritter:SetDirty()
				arg_757_1:ShowNextGo(true)
			end
		end

		arg_757_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
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

		arg_757_1:InitPlayNodeList()
	end,
	Play910201187 = function(arg_761_0, arg_761_1)
		arg_761_1.time_ = 0
		arg_761_1.frameCnt_ = 0
		arg_761_1.state_ = "playing"
		arg_761_1.curTalkId_ = 910201187
		arg_761_1.duration_ = 5

		SetActive(arg_761_1.tipsGo_, false)

		function arg_761_1.onSingleLineFinish_()
			arg_761_1.onSingleLineUpdate_ = nil
			arg_761_1.onSingleLineFinish_ = nil
			arg_761_1.state_ = "waiting"
		end

		function arg_761_1.playNext_(arg_763_0)
			if arg_763_0 == 1 then
				arg_761_0:Play910201188(arg_761_1)
			end
		end

		function arg_761_1.onSingleLineUpdate_(arg_764_0)
			local var_764_0 = 0

			if var_764_0 < arg_761_1.time_ and arg_761_1.time_ <= var_764_0 + arg_764_0 then
				arg_761_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/story1013/story1013actionlink/1013action4102")
			end

			local var_764_1 = 0

			if var_764_1 < arg_761_1.time_ and arg_761_1.time_ <= var_764_1 + arg_764_0 then
				arg_761_1:PlayTimeline("1013ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_764_2 = 0
			local var_764_3 = 0.475

			if var_764_2 < arg_761_1.time_ and arg_761_1.time_ <= var_764_2 + arg_764_0 then
				arg_761_1.talkMaxDuration = 0
				arg_761_1.dialogCg_.alpha = 1

				arg_761_1.dialog_:SetActive(true)
				SetActive(arg_761_1.leftNameGo_, true)

				local var_764_4 = arg_761_1:FormatText(StoryNameCfg[35].name)

				arg_761_1.leftNameTxt_.text = var_764_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_761_1.leftNameTxt_.transform)

				arg_761_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_761_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_761_1:RecordName(arg_761_1.leftNameTxt_.text)
				SetActive(arg_761_1.iconTrs_.gameObject, false)
				arg_761_1.callingController_:SetSelectedState("normal")

				local var_764_5 = arg_761_1:GetWordFromCfg(910201187)
				local var_764_6 = arg_761_1:FormatText(var_764_5.content)

				arg_761_1.text_.text = var_764_6

				LuaForUtil.ClearLinePrefixSymbol(arg_761_1.text_)

				local var_764_7 = 19
				local var_764_8 = utf8.len(var_764_6)
				local var_764_9 = var_764_7 <= 0 and var_764_3 or var_764_3 * (var_764_8 / var_764_7)

				if var_764_9 > 0 and var_764_3 < var_764_9 then
					arg_761_1.talkMaxDuration = var_764_9

					if var_764_9 + var_764_2 > arg_761_1.duration_ then
						arg_761_1.duration_ = var_764_9 + var_764_2
					end
				end

				arg_761_1.text_.text = var_764_6
				arg_761_1.typewritter.percent = 0

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(false)
				arg_761_1:RecordContent(arg_761_1.text_.text)
			end

			local var_764_10 = math.max(var_764_3, arg_761_1.talkMaxDuration)

			if var_764_2 <= arg_761_1.time_ and arg_761_1.time_ < var_764_2 + var_764_10 then
				arg_761_1.typewritter.percent = (arg_761_1.time_ - var_764_2) / var_764_10

				arg_761_1.typewritter:SetDirty()
			end

			if arg_761_1.time_ >= var_764_2 + var_764_10 and arg_761_1.time_ < var_764_2 + var_764_10 + arg_764_0 then
				arg_761_1.typewritter.percent = 1

				arg_761_1.typewritter:SetDirty()
				arg_761_1:ShowNextGo(true)
			end
		end

		arg_761_1.nodeConfigList_ = {}

		arg_761_1:InitPlayNodeList()
	end,
	Play910201188 = function(arg_765_0, arg_765_1)
		arg_765_1.time_ = 0
		arg_765_1.frameCnt_ = 0
		arg_765_1.state_ = "playing"
		arg_765_1.curTalkId_ = 910201188
		arg_765_1.duration_ = 5

		SetActive(arg_765_1.tipsGo_, false)

		function arg_765_1.onSingleLineFinish_()
			arg_765_1.onSingleLineUpdate_ = nil
			arg_765_1.onSingleLineFinish_ = nil
			arg_765_1.state_ = "waiting"
		end

		function arg_765_1.playNext_(arg_767_0)
			if arg_767_0 == 1 then
				arg_765_0:Play910201189(arg_765_1)
			end
		end

		function arg_765_1.onSingleLineUpdate_(arg_768_0)
			local var_768_0 = arg_765_1.actors_["1013ui_story"].transform
			local var_768_1 = 0

			if var_768_1 < arg_765_1.time_ and arg_765_1.time_ <= var_768_1 + arg_768_0 then
				arg_765_1.var_.moveOldPos1013ui_story = var_768_0.localPosition
			end

			local var_768_2 = 0.001

			if var_768_1 <= arg_765_1.time_ and arg_765_1.time_ < var_768_1 + var_768_2 then
				local var_768_3 = (arg_765_1.time_ - var_768_1) / var_768_2
				local var_768_4 = Vector3.New(0, 100, 0)

				var_768_0.localPosition = Vector3.Lerp(arg_765_1.var_.moveOldPos1013ui_story, var_768_4, var_768_3)

				local var_768_5 = manager.ui.mainCamera.transform.position - var_768_0.position

				var_768_0.forward = Vector3.New(var_768_5.x, var_768_5.y, var_768_5.z)

				local var_768_6 = var_768_0.localEulerAngles

				var_768_6.z = 0
				var_768_6.x = 0
				var_768_0.localEulerAngles = var_768_6
			end

			if arg_765_1.time_ >= var_768_1 + var_768_2 and arg_765_1.time_ < var_768_1 + var_768_2 + arg_768_0 then
				var_768_0.localPosition = Vector3.New(0, 100, 0)

				local var_768_7 = manager.ui.mainCamera.transform.position - var_768_0.position

				var_768_0.forward = Vector3.New(var_768_7.x, var_768_7.y, var_768_7.z)

				local var_768_8 = var_768_0.localEulerAngles

				var_768_8.z = 0
				var_768_8.x = 0
				var_768_0.localEulerAngles = var_768_8
			end

			local var_768_9 = 0
			local var_768_10 = 0.225

			if var_768_9 < arg_765_1.time_ and arg_765_1.time_ <= var_768_9 + arg_768_0 then
				arg_765_1.talkMaxDuration = 0
				arg_765_1.dialogCg_.alpha = 1

				arg_765_1.dialog_:SetActive(true)
				SetActive(arg_765_1.leftNameGo_, true)

				local var_768_11 = arg_765_1:FormatText(StoryNameCfg[7].name)

				arg_765_1.leftNameTxt_.text = var_768_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_765_1.leftNameTxt_.transform)

				arg_765_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_765_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_765_1:RecordName(arg_765_1.leftNameTxt_.text)
				SetActive(arg_765_1.iconTrs_.gameObject, true)
				arg_765_1.iconController_:SetSelectedState("hero")

				arg_765_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_765_1.callingController_:SetSelectedState("normal")

				arg_765_1.keyicon_.color = Color.New(1, 1, 1)
				arg_765_1.icon_.color = Color.New(1, 1, 1)

				local var_768_12 = arg_765_1:GetWordFromCfg(910201188)
				local var_768_13 = arg_765_1:FormatText(var_768_12.content)

				arg_765_1.text_.text = var_768_13

				LuaForUtil.ClearLinePrefixSymbol(arg_765_1.text_)

				local var_768_14 = 9
				local var_768_15 = utf8.len(var_768_13)
				local var_768_16 = var_768_14 <= 0 and var_768_10 or var_768_10 * (var_768_15 / var_768_14)

				if var_768_16 > 0 and var_768_10 < var_768_16 then
					arg_765_1.talkMaxDuration = var_768_16

					if var_768_16 + var_768_9 > arg_765_1.duration_ then
						arg_765_1.duration_ = var_768_16 + var_768_9
					end
				end

				arg_765_1.text_.text = var_768_13
				arg_765_1.typewritter.percent = 0

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(false)
				arg_765_1:RecordContent(arg_765_1.text_.text)
			end

			local var_768_17 = math.max(var_768_10, arg_765_1.talkMaxDuration)

			if var_768_9 <= arg_765_1.time_ and arg_765_1.time_ < var_768_9 + var_768_17 then
				arg_765_1.typewritter.percent = (arg_765_1.time_ - var_768_9) / var_768_17

				arg_765_1.typewritter:SetDirty()
			end

			if arg_765_1.time_ >= var_768_9 + var_768_17 and arg_765_1.time_ < var_768_9 + var_768_17 + arg_768_0 then
				arg_765_1.typewritter.percent = 1

				arg_765_1.typewritter:SetDirty()
				arg_765_1:ShowNextGo(true)
			end
		end

		arg_765_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1013ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_765_1:InitPlayNodeList()
	end,
	Play910201189 = function(arg_769_0, arg_769_1)
		arg_769_1.time_ = 0
		arg_769_1.frameCnt_ = 0
		arg_769_1.state_ = "playing"
		arg_769_1.curTalkId_ = 910201189
		arg_769_1.duration_ = 5

		SetActive(arg_769_1.tipsGo_, false)

		function arg_769_1.onSingleLineFinish_()
			arg_769_1.onSingleLineUpdate_ = nil
			arg_769_1.onSingleLineFinish_ = nil
			arg_769_1.state_ = "waiting"
		end

		function arg_769_1.playNext_(arg_771_0)
			if arg_771_0 == 1 then
				arg_769_0:Play910201190(arg_769_1)
			end
		end

		function arg_769_1.onSingleLineUpdate_(arg_772_0)
			local var_772_0 = arg_769_1.actors_["1080ui_story"].transform
			local var_772_1 = 0

			if var_772_1 < arg_769_1.time_ and arg_769_1.time_ <= var_772_1 + arg_772_0 then
				arg_769_1.var_.moveOldPos1080ui_story = var_772_0.localPosition
			end

			local var_772_2 = 0.001

			if var_772_1 <= arg_769_1.time_ and arg_769_1.time_ < var_772_1 + var_772_2 then
				local var_772_3 = (arg_769_1.time_ - var_772_1) / var_772_2
				local var_772_4 = Vector3.New(0, -1.01, -6.05)

				var_772_0.localPosition = Vector3.Lerp(arg_769_1.var_.moveOldPos1080ui_story, var_772_4, var_772_3)

				local var_772_5 = manager.ui.mainCamera.transform.position - var_772_0.position

				var_772_0.forward = Vector3.New(var_772_5.x, var_772_5.y, var_772_5.z)

				local var_772_6 = var_772_0.localEulerAngles

				var_772_6.z = 0
				var_772_6.x = 0
				var_772_0.localEulerAngles = var_772_6
			end

			if arg_769_1.time_ >= var_772_1 + var_772_2 and arg_769_1.time_ < var_772_1 + var_772_2 + arg_772_0 then
				var_772_0.localPosition = Vector3.New(0, -1.01, -6.05)

				local var_772_7 = manager.ui.mainCamera.transform.position - var_772_0.position

				var_772_0.forward = Vector3.New(var_772_7.x, var_772_7.y, var_772_7.z)

				local var_772_8 = var_772_0.localEulerAngles

				var_772_8.z = 0
				var_772_8.x = 0
				var_772_0.localEulerAngles = var_772_8
			end

			local var_772_9 = arg_769_1.actors_["1080ui_story"]
			local var_772_10 = 0

			if var_772_10 < arg_769_1.time_ and arg_769_1.time_ <= var_772_10 + arg_772_0 and not isNil(var_772_9) and arg_769_1.var_.characterEffect1080ui_story == nil then
				arg_769_1.var_.characterEffect1080ui_story = var_772_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_772_11 = 0.2

			if var_772_10 <= arg_769_1.time_ and arg_769_1.time_ < var_772_10 + var_772_11 and not isNil(var_772_9) then
				local var_772_12 = (arg_769_1.time_ - var_772_10) / var_772_11

				if arg_769_1.var_.characterEffect1080ui_story and not isNil(var_772_9) then
					arg_769_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_769_1.time_ >= var_772_10 + var_772_11 and arg_769_1.time_ < var_772_10 + var_772_11 + arg_772_0 and not isNil(var_772_9) and arg_769_1.var_.characterEffect1080ui_story then
				arg_769_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_772_13 = 0

			if var_772_13 < arg_769_1.time_ and arg_769_1.time_ <= var_772_13 + arg_772_0 then
				arg_769_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action3_1")
			end

			local var_772_14 = 0

			if var_772_14 < arg_769_1.time_ and arg_769_1.time_ <= var_772_14 + arg_772_0 then
				arg_769_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_772_15 = 0
			local var_772_16 = 0.25

			if var_772_15 < arg_769_1.time_ and arg_769_1.time_ <= var_772_15 + arg_772_0 then
				arg_769_1.talkMaxDuration = 0
				arg_769_1.dialogCg_.alpha = 1

				arg_769_1.dialog_:SetActive(true)
				SetActive(arg_769_1.leftNameGo_, true)

				local var_772_17 = arg_769_1:FormatText(StoryNameCfg[55].name)

				arg_769_1.leftNameTxt_.text = var_772_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_769_1.leftNameTxt_.transform)

				arg_769_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_769_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_769_1:RecordName(arg_769_1.leftNameTxt_.text)
				SetActive(arg_769_1.iconTrs_.gameObject, false)
				arg_769_1.callingController_:SetSelectedState("normal")

				local var_772_18 = arg_769_1:GetWordFromCfg(910201189)
				local var_772_19 = arg_769_1:FormatText(var_772_18.content)

				arg_769_1.text_.text = var_772_19

				LuaForUtil.ClearLinePrefixSymbol(arg_769_1.text_)

				local var_772_20 = 10
				local var_772_21 = utf8.len(var_772_19)
				local var_772_22 = var_772_20 <= 0 and var_772_16 or var_772_16 * (var_772_21 / var_772_20)

				if var_772_22 > 0 and var_772_16 < var_772_22 then
					arg_769_1.talkMaxDuration = var_772_22

					if var_772_22 + var_772_15 > arg_769_1.duration_ then
						arg_769_1.duration_ = var_772_22 + var_772_15
					end
				end

				arg_769_1.text_.text = var_772_19
				arg_769_1.typewritter.percent = 0

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(false)
				arg_769_1:RecordContent(arg_769_1.text_.text)
			end

			local var_772_23 = math.max(var_772_16, arg_769_1.talkMaxDuration)

			if var_772_15 <= arg_769_1.time_ and arg_769_1.time_ < var_772_15 + var_772_23 then
				arg_769_1.typewritter.percent = (arg_769_1.time_ - var_772_15) / var_772_23

				arg_769_1.typewritter:SetDirty()
			end

			if arg_769_1.time_ >= var_772_15 + var_772_23 and arg_769_1.time_ < var_772_15 + var_772_23 + arg_772_0 then
				arg_769_1.typewritter.percent = 1

				arg_769_1.typewritter:SetDirty()
				arg_769_1:ShowNextGo(true)
			end
		end

		arg_769_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_769_1:InitPlayNodeList()
	end,
	Play910201190 = function(arg_773_0, arg_773_1)
		arg_773_1.time_ = 0
		arg_773_1.frameCnt_ = 0
		arg_773_1.state_ = "playing"
		arg_773_1.curTalkId_ = 910201190
		arg_773_1.duration_ = 5

		SetActive(arg_773_1.tipsGo_, false)

		function arg_773_1.onSingleLineFinish_()
			arg_773_1.onSingleLineUpdate_ = nil
			arg_773_1.onSingleLineFinish_ = nil
			arg_773_1.state_ = "waiting"
		end

		function arg_773_1.playNext_(arg_775_0)
			if arg_775_0 == 1 then
				arg_773_0:Play910201191(arg_773_1)
			end
		end

		function arg_773_1.onSingleLineUpdate_(arg_776_0)
			local var_776_0 = arg_773_1.actors_["1080ui_story"]
			local var_776_1 = 0

			if var_776_1 < arg_773_1.time_ and arg_773_1.time_ <= var_776_1 + arg_776_0 and not isNil(var_776_0) and arg_773_1.var_.characterEffect1080ui_story == nil then
				arg_773_1.var_.characterEffect1080ui_story = var_776_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_776_2 = 0.2

			if var_776_1 <= arg_773_1.time_ and arg_773_1.time_ < var_776_1 + var_776_2 and not isNil(var_776_0) then
				local var_776_3 = (arg_773_1.time_ - var_776_1) / var_776_2

				if arg_773_1.var_.characterEffect1080ui_story and not isNil(var_776_0) then
					local var_776_4 = Mathf.Lerp(0, 0.5, var_776_3)

					arg_773_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_773_1.var_.characterEffect1080ui_story.fillRatio = var_776_4
				end
			end

			if arg_773_1.time_ >= var_776_1 + var_776_2 and arg_773_1.time_ < var_776_1 + var_776_2 + arg_776_0 and not isNil(var_776_0) and arg_773_1.var_.characterEffect1080ui_story then
				local var_776_5 = 0.5

				arg_773_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_773_1.var_.characterEffect1080ui_story.fillRatio = var_776_5
			end

			local var_776_6 = 0
			local var_776_7 = 0.275

			if var_776_6 < arg_773_1.time_ and arg_773_1.time_ <= var_776_6 + arg_776_0 then
				arg_773_1.talkMaxDuration = 0
				arg_773_1.dialogCg_.alpha = 1

				arg_773_1.dialog_:SetActive(true)
				SetActive(arg_773_1.leftNameGo_, false)

				arg_773_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_773_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_773_1:RecordName(arg_773_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_773_1.iconTrs_.gameObject, false)
				arg_773_1.callingController_:SetSelectedState("normal")

				local var_776_8 = arg_773_1:GetWordFromCfg(910201190)
				local var_776_9 = arg_773_1:FormatText(var_776_8.content)

				arg_773_1.text_.text = var_776_9

				LuaForUtil.ClearLinePrefixSymbol(arg_773_1.text_)

				local var_776_10 = 11
				local var_776_11 = utf8.len(var_776_9)
				local var_776_12 = var_776_10 <= 0 and var_776_7 or var_776_7 * (var_776_11 / var_776_10)

				if var_776_12 > 0 and var_776_7 < var_776_12 then
					arg_773_1.talkMaxDuration = var_776_12

					if var_776_12 + var_776_6 > arg_773_1.duration_ then
						arg_773_1.duration_ = var_776_12 + var_776_6
					end
				end

				arg_773_1.text_.text = var_776_9
				arg_773_1.typewritter.percent = 0

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(false)
				arg_773_1:RecordContent(arg_773_1.text_.text)
			end

			local var_776_13 = math.max(var_776_7, arg_773_1.talkMaxDuration)

			if var_776_6 <= arg_773_1.time_ and arg_773_1.time_ < var_776_6 + var_776_13 then
				arg_773_1.typewritter.percent = (arg_773_1.time_ - var_776_6) / var_776_13

				arg_773_1.typewritter:SetDirty()
			end

			if arg_773_1.time_ >= var_776_6 + var_776_13 and arg_773_1.time_ < var_776_6 + var_776_13 + arg_776_0 then
				arg_773_1.typewritter.percent = 1

				arg_773_1.typewritter:SetDirty()
				arg_773_1:ShowNextGo(true)
			end
		end

		arg_773_1.nodeConfigList_ = {}

		arg_773_1:InitPlayNodeList()
	end,
	Play910201191 = function(arg_777_0, arg_777_1)
		arg_777_1.time_ = 0
		arg_777_1.frameCnt_ = 0
		arg_777_1.state_ = "playing"
		arg_777_1.curTalkId_ = 910201191
		arg_777_1.duration_ = 5

		SetActive(arg_777_1.tipsGo_, false)

		function arg_777_1.onSingleLineFinish_()
			arg_777_1.onSingleLineUpdate_ = nil
			arg_777_1.onSingleLineFinish_ = nil
			arg_777_1.state_ = "waiting"
		end

		function arg_777_1.playNext_(arg_779_0)
			if arg_779_0 == 1 then
				arg_777_0:Play910201192(arg_777_1)
			end
		end

		function arg_777_1.onSingleLineUpdate_(arg_780_0)
			local var_780_0 = 0
			local var_780_1 = 0.225

			if var_780_0 < arg_777_1.time_ and arg_777_1.time_ <= var_780_0 + arg_780_0 then
				arg_777_1.talkMaxDuration = 0
				arg_777_1.dialogCg_.alpha = 1

				arg_777_1.dialog_:SetActive(true)
				SetActive(arg_777_1.leftNameGo_, true)

				local var_780_2 = arg_777_1:FormatText(StoryNameCfg[7].name)

				arg_777_1.leftNameTxt_.text = var_780_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_777_1.leftNameTxt_.transform)

				arg_777_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_777_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_777_1:RecordName(arg_777_1.leftNameTxt_.text)
				SetActive(arg_777_1.iconTrs_.gameObject, true)
				arg_777_1.iconController_:SetSelectedState("hero")

				arg_777_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_777_1.callingController_:SetSelectedState("normal")

				arg_777_1.keyicon_.color = Color.New(1, 1, 1)
				arg_777_1.icon_.color = Color.New(1, 1, 1)

				local var_780_3 = arg_777_1:GetWordFromCfg(910201191)
				local var_780_4 = arg_777_1:FormatText(var_780_3.content)

				arg_777_1.text_.text = var_780_4

				LuaForUtil.ClearLinePrefixSymbol(arg_777_1.text_)

				local var_780_5 = 9
				local var_780_6 = utf8.len(var_780_4)
				local var_780_7 = var_780_5 <= 0 and var_780_1 or var_780_1 * (var_780_6 / var_780_5)

				if var_780_7 > 0 and var_780_1 < var_780_7 then
					arg_777_1.talkMaxDuration = var_780_7

					if var_780_7 + var_780_0 > arg_777_1.duration_ then
						arg_777_1.duration_ = var_780_7 + var_780_0
					end
				end

				arg_777_1.text_.text = var_780_4
				arg_777_1.typewritter.percent = 0

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(false)
				arg_777_1:RecordContent(arg_777_1.text_.text)
			end

			local var_780_8 = math.max(var_780_1, arg_777_1.talkMaxDuration)

			if var_780_0 <= arg_777_1.time_ and arg_777_1.time_ < var_780_0 + var_780_8 then
				arg_777_1.typewritter.percent = (arg_777_1.time_ - var_780_0) / var_780_8

				arg_777_1.typewritter:SetDirty()
			end

			if arg_777_1.time_ >= var_780_0 + var_780_8 and arg_777_1.time_ < var_780_0 + var_780_8 + arg_780_0 then
				arg_777_1.typewritter.percent = 1

				arg_777_1.typewritter:SetDirty()
				arg_777_1:ShowNextGo(true)
			end
		end

		arg_777_1.nodeConfigList_ = {}

		arg_777_1:InitPlayNodeList()
	end,
	Play910201192 = function(arg_781_0, arg_781_1)
		arg_781_1.time_ = 0
		arg_781_1.frameCnt_ = 0
		arg_781_1.state_ = "playing"
		arg_781_1.curTalkId_ = 910201192
		arg_781_1.duration_ = 5

		SetActive(arg_781_1.tipsGo_, false)

		function arg_781_1.onSingleLineFinish_()
			arg_781_1.onSingleLineUpdate_ = nil
			arg_781_1.onSingleLineFinish_ = nil
			arg_781_1.state_ = "waiting"
		end

		function arg_781_1.playNext_(arg_783_0)
			if arg_783_0 == 1 then
				arg_781_0:Play910201193(arg_781_1)
			end
		end

		function arg_781_1.onSingleLineUpdate_(arg_784_0)
			local var_784_0 = arg_781_1.actors_["1080ui_story"].transform
			local var_784_1 = 0

			if var_784_1 < arg_781_1.time_ and arg_781_1.time_ <= var_784_1 + arg_784_0 then
				arg_781_1.var_.moveOldPos1080ui_story = var_784_0.localPosition
			end

			local var_784_2 = 0.001

			if var_784_1 <= arg_781_1.time_ and arg_781_1.time_ < var_784_1 + var_784_2 then
				local var_784_3 = (arg_781_1.time_ - var_784_1) / var_784_2
				local var_784_4 = Vector3.New(0, 100, 0)

				var_784_0.localPosition = Vector3.Lerp(arg_781_1.var_.moveOldPos1080ui_story, var_784_4, var_784_3)

				local var_784_5 = manager.ui.mainCamera.transform.position - var_784_0.position

				var_784_0.forward = Vector3.New(var_784_5.x, var_784_5.y, var_784_5.z)

				local var_784_6 = var_784_0.localEulerAngles

				var_784_6.z = 0
				var_784_6.x = 0
				var_784_0.localEulerAngles = var_784_6
			end

			if arg_781_1.time_ >= var_784_1 + var_784_2 and arg_781_1.time_ < var_784_1 + var_784_2 + arg_784_0 then
				var_784_0.localPosition = Vector3.New(0, 100, 0)

				local var_784_7 = manager.ui.mainCamera.transform.position - var_784_0.position

				var_784_0.forward = Vector3.New(var_784_7.x, var_784_7.y, var_784_7.z)

				local var_784_8 = var_784_0.localEulerAngles

				var_784_8.z = 0
				var_784_8.x = 0
				var_784_0.localEulerAngles = var_784_8
			end

			local var_784_9 = 0
			local var_784_10 = 0.25

			if var_784_9 < arg_781_1.time_ and arg_781_1.time_ <= var_784_9 + arg_784_0 then
				arg_781_1.talkMaxDuration = 0
				arg_781_1.dialogCg_.alpha = 1

				arg_781_1.dialog_:SetActive(true)
				SetActive(arg_781_1.leftNameGo_, true)

				local var_784_11 = arg_781_1:FormatText(StoryNameCfg[7].name)

				arg_781_1.leftNameTxt_.text = var_784_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_781_1.leftNameTxt_.transform)

				arg_781_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_781_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_781_1:RecordName(arg_781_1.leftNameTxt_.text)
				SetActive(arg_781_1.iconTrs_.gameObject, true)
				arg_781_1.iconController_:SetSelectedState("hero")

				arg_781_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_781_1.callingController_:SetSelectedState("normal")

				arg_781_1.keyicon_.color = Color.New(1, 1, 1)
				arg_781_1.icon_.color = Color.New(1, 1, 1)

				local var_784_12 = arg_781_1:GetWordFromCfg(910201192)
				local var_784_13 = arg_781_1:FormatText(var_784_12.content)

				arg_781_1.text_.text = var_784_13

				LuaForUtil.ClearLinePrefixSymbol(arg_781_1.text_)

				local var_784_14 = 10
				local var_784_15 = utf8.len(var_784_13)
				local var_784_16 = var_784_14 <= 0 and var_784_10 or var_784_10 * (var_784_15 / var_784_14)

				if var_784_16 > 0 and var_784_10 < var_784_16 then
					arg_781_1.talkMaxDuration = var_784_16

					if var_784_16 + var_784_9 > arg_781_1.duration_ then
						arg_781_1.duration_ = var_784_16 + var_784_9
					end
				end

				arg_781_1.text_.text = var_784_13
				arg_781_1.typewritter.percent = 0

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(false)
				arg_781_1:RecordContent(arg_781_1.text_.text)
			end

			local var_784_17 = math.max(var_784_10, arg_781_1.talkMaxDuration)

			if var_784_9 <= arg_781_1.time_ and arg_781_1.time_ < var_784_9 + var_784_17 then
				arg_781_1.typewritter.percent = (arg_781_1.time_ - var_784_9) / var_784_17

				arg_781_1.typewritter:SetDirty()
			end

			if arg_781_1.time_ >= var_784_9 + var_784_17 and arg_781_1.time_ < var_784_9 + var_784_17 + arg_784_0 then
				arg_781_1.typewritter.percent = 1

				arg_781_1.typewritter:SetDirty()
				arg_781_1:ShowNextGo(true)
			end
		end

		arg_781_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_781_1:InitPlayNodeList()
	end,
	Play910201193 = function(arg_785_0, arg_785_1)
		arg_785_1.time_ = 0
		arg_785_1.frameCnt_ = 0
		arg_785_1.state_ = "playing"
		arg_785_1.curTalkId_ = 910201193
		arg_785_1.duration_ = 5

		SetActive(arg_785_1.tipsGo_, false)

		function arg_785_1.onSingleLineFinish_()
			arg_785_1.onSingleLineUpdate_ = nil
			arg_785_1.onSingleLineFinish_ = nil
			arg_785_1.state_ = "waiting"
		end

		function arg_785_1.playNext_(arg_787_0)
			if arg_787_0 == 1 then
				arg_785_0:Play910201194(arg_785_1)
			end
		end

		function arg_785_1.onSingleLineUpdate_(arg_788_0)
			local var_788_0 = "1059ui_story"

			if arg_785_1.actors_[var_788_0] == nil then
				local var_788_1 = Asset.Load("Char/" .. "1059ui_story")

				if not isNil(var_788_1) then
					local var_788_2 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_785_1.stage_.transform)

					var_788_2.name = var_788_0
					var_788_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_785_1.actors_[var_788_0] = var_788_2

					local var_788_3 = var_788_2:GetComponentInChildren(typeof(CharacterEffect))

					var_788_3.enabled = true

					local var_788_4 = GameObjectTools.GetOrAddComponent(var_788_2, typeof(DynamicBoneHelper))

					if var_788_4 then
						var_788_4:EnableDynamicBone(false)
					end

					arg_785_1:ShowWeapon(var_788_3.transform, false)

					arg_785_1.var_[var_788_0 .. "Animator"] = var_788_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_785_1.var_[var_788_0 .. "Animator"].applyRootMotion = true
					arg_785_1.var_[var_788_0 .. "LipSync"] = var_788_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_788_5 = arg_785_1.actors_["1059ui_story"].transform
			local var_788_6 = 0

			if var_788_6 < arg_785_1.time_ and arg_785_1.time_ <= var_788_6 + arg_788_0 then
				arg_785_1.var_.moveOldPos1059ui_story = var_788_5.localPosition
			end

			local var_788_7 = 0.001

			if var_788_6 <= arg_785_1.time_ and arg_785_1.time_ < var_788_6 + var_788_7 then
				local var_788_8 = (arg_785_1.time_ - var_788_6) / var_788_7
				local var_788_9 = Vector3.New(0, -1.05, -6)

				var_788_5.localPosition = Vector3.Lerp(arg_785_1.var_.moveOldPos1059ui_story, var_788_9, var_788_8)

				local var_788_10 = manager.ui.mainCamera.transform.position - var_788_5.position

				var_788_5.forward = Vector3.New(var_788_10.x, var_788_10.y, var_788_10.z)

				local var_788_11 = var_788_5.localEulerAngles

				var_788_11.z = 0
				var_788_11.x = 0
				var_788_5.localEulerAngles = var_788_11
			end

			if arg_785_1.time_ >= var_788_6 + var_788_7 and arg_785_1.time_ < var_788_6 + var_788_7 + arg_788_0 then
				var_788_5.localPosition = Vector3.New(0, -1.05, -6)

				local var_788_12 = manager.ui.mainCamera.transform.position - var_788_5.position

				var_788_5.forward = Vector3.New(var_788_12.x, var_788_12.y, var_788_12.z)

				local var_788_13 = var_788_5.localEulerAngles

				var_788_13.z = 0
				var_788_13.x = 0
				var_788_5.localEulerAngles = var_788_13
			end

			local var_788_14 = arg_785_1.actors_["1059ui_story"]
			local var_788_15 = 0

			if var_788_15 < arg_785_1.time_ and arg_785_1.time_ <= var_788_15 + arg_788_0 and not isNil(var_788_14) and arg_785_1.var_.characterEffect1059ui_story == nil then
				arg_785_1.var_.characterEffect1059ui_story = var_788_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_788_16 = 0.2

			if var_788_15 <= arg_785_1.time_ and arg_785_1.time_ < var_788_15 + var_788_16 and not isNil(var_788_14) then
				local var_788_17 = (arg_785_1.time_ - var_788_15) / var_788_16

				if arg_785_1.var_.characterEffect1059ui_story and not isNil(var_788_14) then
					arg_785_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_785_1.time_ >= var_788_15 + var_788_16 and arg_785_1.time_ < var_788_15 + var_788_16 + arg_788_0 and not isNil(var_788_14) and arg_785_1.var_.characterEffect1059ui_story then
				arg_785_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_788_18 = 0

			if var_788_18 < arg_785_1.time_ and arg_785_1.time_ <= var_788_18 + arg_788_0 then
				arg_785_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action2_1")
			end

			local var_788_19 = 0

			if var_788_19 < arg_785_1.time_ and arg_785_1.time_ <= var_788_19 + arg_788_0 then
				arg_785_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_788_20 = 0
			local var_788_21 = 0.5

			if var_788_20 < arg_785_1.time_ and arg_785_1.time_ <= var_788_20 + arg_788_0 then
				arg_785_1.talkMaxDuration = 0
				arg_785_1.dialogCg_.alpha = 1

				arg_785_1.dialog_:SetActive(true)
				SetActive(arg_785_1.leftNameGo_, true)

				local var_788_22 = arg_785_1:FormatText(StoryNameCfg[28].name)

				arg_785_1.leftNameTxt_.text = var_788_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_785_1.leftNameTxt_.transform)

				arg_785_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_785_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_785_1:RecordName(arg_785_1.leftNameTxt_.text)
				SetActive(arg_785_1.iconTrs_.gameObject, false)
				arg_785_1.callingController_:SetSelectedState("normal")

				local var_788_23 = arg_785_1:GetWordFromCfg(910201193)
				local var_788_24 = arg_785_1:FormatText(var_788_23.content)

				arg_785_1.text_.text = var_788_24

				LuaForUtil.ClearLinePrefixSymbol(arg_785_1.text_)

				local var_788_25 = 20
				local var_788_26 = utf8.len(var_788_24)
				local var_788_27 = var_788_25 <= 0 and var_788_21 or var_788_21 * (var_788_26 / var_788_25)

				if var_788_27 > 0 and var_788_21 < var_788_27 then
					arg_785_1.talkMaxDuration = var_788_27

					if var_788_27 + var_788_20 > arg_785_1.duration_ then
						arg_785_1.duration_ = var_788_27 + var_788_20
					end
				end

				arg_785_1.text_.text = var_788_24
				arg_785_1.typewritter.percent = 0

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(false)
				arg_785_1:RecordContent(arg_785_1.text_.text)
			end

			local var_788_28 = math.max(var_788_21, arg_785_1.talkMaxDuration)

			if var_788_20 <= arg_785_1.time_ and arg_785_1.time_ < var_788_20 + var_788_28 then
				arg_785_1.typewritter.percent = (arg_785_1.time_ - var_788_20) / var_788_28

				arg_785_1.typewritter:SetDirty()
			end

			if arg_785_1.time_ >= var_788_20 + var_788_28 and arg_785_1.time_ < var_788_20 + var_788_28 + arg_788_0 then
				arg_785_1.typewritter.percent = 1

				arg_785_1.typewritter:SetDirty()
				arg_785_1:ShowNextGo(true)
			end
		end

		arg_785_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_785_1:InitPlayNodeList()
	end,
	Play910201194 = function(arg_789_0, arg_789_1)
		arg_789_1.time_ = 0
		arg_789_1.frameCnt_ = 0
		arg_789_1.state_ = "playing"
		arg_789_1.curTalkId_ = 910201194
		arg_789_1.duration_ = 5

		SetActive(arg_789_1.tipsGo_, false)

		function arg_789_1.onSingleLineFinish_()
			arg_789_1.onSingleLineUpdate_ = nil
			arg_789_1.onSingleLineFinish_ = nil
			arg_789_1.state_ = "waiting"
		end

		function arg_789_1.playNext_(arg_791_0)
			if arg_791_0 == 1 then
				arg_789_0:Play910201195(arg_789_1)
			end
		end

		function arg_789_1.onSingleLineUpdate_(arg_792_0)
			local var_792_0 = 0

			if var_792_0 < arg_789_1.time_ and arg_789_1.time_ <= var_792_0 + arg_792_0 then
				arg_789_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action425")
			end

			local var_792_1 = 0

			if var_792_1 < arg_789_1.time_ and arg_789_1.time_ <= var_792_1 + arg_792_0 then
				arg_789_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_792_2 = 0
			local var_792_3 = 1.05

			if var_792_2 < arg_789_1.time_ and arg_789_1.time_ <= var_792_2 + arg_792_0 then
				arg_789_1.talkMaxDuration = 0
				arg_789_1.dialogCg_.alpha = 1

				arg_789_1.dialog_:SetActive(true)
				SetActive(arg_789_1.leftNameGo_, true)

				local var_792_4 = arg_789_1:FormatText(StoryNameCfg[28].name)

				arg_789_1.leftNameTxt_.text = var_792_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_789_1.leftNameTxt_.transform)

				arg_789_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_789_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_789_1:RecordName(arg_789_1.leftNameTxt_.text)
				SetActive(arg_789_1.iconTrs_.gameObject, false)
				arg_789_1.callingController_:SetSelectedState("normal")

				local var_792_5 = arg_789_1:GetWordFromCfg(910201194)
				local var_792_6 = arg_789_1:FormatText(var_792_5.content)

				arg_789_1.text_.text = var_792_6

				LuaForUtil.ClearLinePrefixSymbol(arg_789_1.text_)

				local var_792_7 = 42
				local var_792_8 = utf8.len(var_792_6)
				local var_792_9 = var_792_7 <= 0 and var_792_3 or var_792_3 * (var_792_8 / var_792_7)

				if var_792_9 > 0 and var_792_3 < var_792_9 then
					arg_789_1.talkMaxDuration = var_792_9

					if var_792_9 + var_792_2 > arg_789_1.duration_ then
						arg_789_1.duration_ = var_792_9 + var_792_2
					end
				end

				arg_789_1.text_.text = var_792_6
				arg_789_1.typewritter.percent = 0

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(false)
				arg_789_1:RecordContent(arg_789_1.text_.text)
			end

			local var_792_10 = math.max(var_792_3, arg_789_1.talkMaxDuration)

			if var_792_2 <= arg_789_1.time_ and arg_789_1.time_ < var_792_2 + var_792_10 then
				arg_789_1.typewritter.percent = (arg_789_1.time_ - var_792_2) / var_792_10

				arg_789_1.typewritter:SetDirty()
			end

			if arg_789_1.time_ >= var_792_2 + var_792_10 and arg_789_1.time_ < var_792_2 + var_792_10 + arg_792_0 then
				arg_789_1.typewritter.percent = 1

				arg_789_1.typewritter:SetDirty()
				arg_789_1:ShowNextGo(true)
			end
		end

		arg_789_1.nodeConfigList_ = {}

		arg_789_1:InitPlayNodeList()
	end,
	Play910201195 = function(arg_793_0, arg_793_1)
		arg_793_1.time_ = 0
		arg_793_1.frameCnt_ = 0
		arg_793_1.state_ = "playing"
		arg_793_1.curTalkId_ = 910201195
		arg_793_1.duration_ = 5

		SetActive(arg_793_1.tipsGo_, false)

		function arg_793_1.onSingleLineFinish_()
			arg_793_1.onSingleLineUpdate_ = nil
			arg_793_1.onSingleLineFinish_ = nil
			arg_793_1.state_ = "waiting"
		end

		function arg_793_1.playNext_(arg_795_0)
			if arg_795_0 == 1 then
				arg_793_0:Play910201196(arg_793_1)
			end
		end

		function arg_793_1.onSingleLineUpdate_(arg_796_0)
			local var_796_0 = arg_793_1.actors_["1059ui_story"]
			local var_796_1 = 0

			if var_796_1 < arg_793_1.time_ and arg_793_1.time_ <= var_796_1 + arg_796_0 and not isNil(var_796_0) and arg_793_1.var_.characterEffect1059ui_story == nil then
				arg_793_1.var_.characterEffect1059ui_story = var_796_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_796_2 = 0.2

			if var_796_1 <= arg_793_1.time_ and arg_793_1.time_ < var_796_1 + var_796_2 and not isNil(var_796_0) then
				local var_796_3 = (arg_793_1.time_ - var_796_1) / var_796_2

				if arg_793_1.var_.characterEffect1059ui_story and not isNil(var_796_0) then
					local var_796_4 = Mathf.Lerp(0, 0.5, var_796_3)

					arg_793_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_793_1.var_.characterEffect1059ui_story.fillRatio = var_796_4
				end
			end

			if arg_793_1.time_ >= var_796_1 + var_796_2 and arg_793_1.time_ < var_796_1 + var_796_2 + arg_796_0 and not isNil(var_796_0) and arg_793_1.var_.characterEffect1059ui_story then
				local var_796_5 = 0.5

				arg_793_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_793_1.var_.characterEffect1059ui_story.fillRatio = var_796_5
			end

			local var_796_6 = 0
			local var_796_7 = 0.725

			if var_796_6 < arg_793_1.time_ and arg_793_1.time_ <= var_796_6 + arg_796_0 then
				arg_793_1.talkMaxDuration = 0
				arg_793_1.dialogCg_.alpha = 1

				arg_793_1.dialog_:SetActive(true)
				SetActive(arg_793_1.leftNameGo_, true)

				local var_796_8 = arg_793_1:FormatText(StoryNameCfg[7].name)

				arg_793_1.leftNameTxt_.text = var_796_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_793_1.leftNameTxt_.transform)

				arg_793_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_793_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_793_1:RecordName(arg_793_1.leftNameTxt_.text)
				SetActive(arg_793_1.iconTrs_.gameObject, true)
				arg_793_1.iconController_:SetSelectedState("hero")

				arg_793_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_793_1.callingController_:SetSelectedState("normal")

				arg_793_1.keyicon_.color = Color.New(1, 1, 1)
				arg_793_1.icon_.color = Color.New(1, 1, 1)

				local var_796_9 = arg_793_1:GetWordFromCfg(910201195)
				local var_796_10 = arg_793_1:FormatText(var_796_9.content)

				arg_793_1.text_.text = var_796_10

				LuaForUtil.ClearLinePrefixSymbol(arg_793_1.text_)

				local var_796_11 = 29
				local var_796_12 = utf8.len(var_796_10)
				local var_796_13 = var_796_11 <= 0 and var_796_7 or var_796_7 * (var_796_12 / var_796_11)

				if var_796_13 > 0 and var_796_7 < var_796_13 then
					arg_793_1.talkMaxDuration = var_796_13

					if var_796_13 + var_796_6 > arg_793_1.duration_ then
						arg_793_1.duration_ = var_796_13 + var_796_6
					end
				end

				arg_793_1.text_.text = var_796_10
				arg_793_1.typewritter.percent = 0

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(false)
				arg_793_1:RecordContent(arg_793_1.text_.text)
			end

			local var_796_14 = math.max(var_796_7, arg_793_1.talkMaxDuration)

			if var_796_6 <= arg_793_1.time_ and arg_793_1.time_ < var_796_6 + var_796_14 then
				arg_793_1.typewritter.percent = (arg_793_1.time_ - var_796_6) / var_796_14

				arg_793_1.typewritter:SetDirty()
			end

			if arg_793_1.time_ >= var_796_6 + var_796_14 and arg_793_1.time_ < var_796_6 + var_796_14 + arg_796_0 then
				arg_793_1.typewritter.percent = 1

				arg_793_1.typewritter:SetDirty()
				arg_793_1:ShowNextGo(true)
			end
		end

		arg_793_1.nodeConfigList_ = {}

		arg_793_1:InitPlayNodeList()
	end,
	Play910201196 = function(arg_797_0, arg_797_1)
		arg_797_1.time_ = 0
		arg_797_1.frameCnt_ = 0
		arg_797_1.state_ = "playing"
		arg_797_1.curTalkId_ = 910201196
		arg_797_1.duration_ = 5

		SetActive(arg_797_1.tipsGo_, false)

		function arg_797_1.onSingleLineFinish_()
			arg_797_1.onSingleLineUpdate_ = nil
			arg_797_1.onSingleLineFinish_ = nil
			arg_797_1.state_ = "waiting"
		end

		function arg_797_1.playNext_(arg_799_0)
			if arg_799_0 == 1 then
				arg_797_0:Play910201197(arg_797_1)
			end
		end

		function arg_797_1.onSingleLineUpdate_(arg_800_0)
			local var_800_0 = arg_797_1.actors_["1059ui_story"]
			local var_800_1 = 0

			if var_800_1 < arg_797_1.time_ and arg_797_1.time_ <= var_800_1 + arg_800_0 and not isNil(var_800_0) and arg_797_1.var_.characterEffect1059ui_story == nil then
				arg_797_1.var_.characterEffect1059ui_story = var_800_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_800_2 = 0.2

			if var_800_1 <= arg_797_1.time_ and arg_797_1.time_ < var_800_1 + var_800_2 and not isNil(var_800_0) then
				local var_800_3 = (arg_797_1.time_ - var_800_1) / var_800_2

				if arg_797_1.var_.characterEffect1059ui_story and not isNil(var_800_0) then
					arg_797_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_797_1.time_ >= var_800_1 + var_800_2 and arg_797_1.time_ < var_800_1 + var_800_2 + arg_800_0 and not isNil(var_800_0) and arg_797_1.var_.characterEffect1059ui_story then
				arg_797_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_800_4 = 0

			if var_800_4 < arg_797_1.time_ and arg_797_1.time_ <= var_800_4 + arg_800_0 then
				arg_797_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action452")
			end

			local var_800_5 = 0

			if var_800_5 < arg_797_1.time_ and arg_797_1.time_ <= var_800_5 + arg_800_0 then
				arg_797_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_800_6 = 0
			local var_800_7 = 0.7

			if var_800_6 < arg_797_1.time_ and arg_797_1.time_ <= var_800_6 + arg_800_0 then
				arg_797_1.talkMaxDuration = 0
				arg_797_1.dialogCg_.alpha = 1

				arg_797_1.dialog_:SetActive(true)
				SetActive(arg_797_1.leftNameGo_, true)

				local var_800_8 = arg_797_1:FormatText(StoryNameCfg[28].name)

				arg_797_1.leftNameTxt_.text = var_800_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_797_1.leftNameTxt_.transform)

				arg_797_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_797_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_797_1:RecordName(arg_797_1.leftNameTxt_.text)
				SetActive(arg_797_1.iconTrs_.gameObject, false)
				arg_797_1.callingController_:SetSelectedState("normal")

				local var_800_9 = arg_797_1:GetWordFromCfg(910201196)
				local var_800_10 = arg_797_1:FormatText(var_800_9.content)

				arg_797_1.text_.text = var_800_10

				LuaForUtil.ClearLinePrefixSymbol(arg_797_1.text_)

				local var_800_11 = 28
				local var_800_12 = utf8.len(var_800_10)
				local var_800_13 = var_800_11 <= 0 and var_800_7 or var_800_7 * (var_800_12 / var_800_11)

				if var_800_13 > 0 and var_800_7 < var_800_13 then
					arg_797_1.talkMaxDuration = var_800_13

					if var_800_13 + var_800_6 > arg_797_1.duration_ then
						arg_797_1.duration_ = var_800_13 + var_800_6
					end
				end

				arg_797_1.text_.text = var_800_10
				arg_797_1.typewritter.percent = 0

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(false)
				arg_797_1:RecordContent(arg_797_1.text_.text)
			end

			local var_800_14 = math.max(var_800_7, arg_797_1.talkMaxDuration)

			if var_800_6 <= arg_797_1.time_ and arg_797_1.time_ < var_800_6 + var_800_14 then
				arg_797_1.typewritter.percent = (arg_797_1.time_ - var_800_6) / var_800_14

				arg_797_1.typewritter:SetDirty()
			end

			if arg_797_1.time_ >= var_800_6 + var_800_14 and arg_797_1.time_ < var_800_6 + var_800_14 + arg_800_0 then
				arg_797_1.typewritter.percent = 1

				arg_797_1.typewritter:SetDirty()
				arg_797_1:ShowNextGo(true)
			end
		end

		arg_797_1.nodeConfigList_ = {}

		arg_797_1:InitPlayNodeList()
	end,
	Play910201197 = function(arg_801_0, arg_801_1)
		arg_801_1.time_ = 0
		arg_801_1.frameCnt_ = 0
		arg_801_1.state_ = "playing"
		arg_801_1.curTalkId_ = 910201197
		arg_801_1.duration_ = 5

		SetActive(arg_801_1.tipsGo_, false)

		function arg_801_1.onSingleLineFinish_()
			arg_801_1.onSingleLineUpdate_ = nil
			arg_801_1.onSingleLineFinish_ = nil
			arg_801_1.state_ = "waiting"
		end

		function arg_801_1.playNext_(arg_803_0)
			if arg_803_0 == 1 then
				arg_801_0:Play910201198(arg_801_1)
			end
		end

		function arg_801_1.onSingleLineUpdate_(arg_804_0)
			local var_804_0 = arg_801_1.actors_["1059ui_story"]
			local var_804_1 = 0

			if var_804_1 < arg_801_1.time_ and arg_801_1.time_ <= var_804_1 + arg_804_0 and not isNil(var_804_0) and arg_801_1.var_.characterEffect1059ui_story == nil then
				arg_801_1.var_.characterEffect1059ui_story = var_804_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_804_2 = 0.2

			if var_804_1 <= arg_801_1.time_ and arg_801_1.time_ < var_804_1 + var_804_2 and not isNil(var_804_0) then
				local var_804_3 = (arg_801_1.time_ - var_804_1) / var_804_2

				if arg_801_1.var_.characterEffect1059ui_story and not isNil(var_804_0) then
					local var_804_4 = Mathf.Lerp(0, 0.5, var_804_3)

					arg_801_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_801_1.var_.characterEffect1059ui_story.fillRatio = var_804_4
				end
			end

			if arg_801_1.time_ >= var_804_1 + var_804_2 and arg_801_1.time_ < var_804_1 + var_804_2 + arg_804_0 and not isNil(var_804_0) and arg_801_1.var_.characterEffect1059ui_story then
				local var_804_5 = 0.5

				arg_801_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_801_1.var_.characterEffect1059ui_story.fillRatio = var_804_5
			end

			local var_804_6 = 0
			local var_804_7 = 0.125

			if var_804_6 < arg_801_1.time_ and arg_801_1.time_ <= var_804_6 + arg_804_0 then
				arg_801_1.talkMaxDuration = 0
				arg_801_1.dialogCg_.alpha = 1

				arg_801_1.dialog_:SetActive(true)
				SetActive(arg_801_1.leftNameGo_, true)

				local var_804_8 = arg_801_1:FormatText(StoryNameCfg[7].name)

				arg_801_1.leftNameTxt_.text = var_804_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_801_1.leftNameTxt_.transform)

				arg_801_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_801_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_801_1:RecordName(arg_801_1.leftNameTxt_.text)
				SetActive(arg_801_1.iconTrs_.gameObject, true)
				arg_801_1.iconController_:SetSelectedState("hero")

				arg_801_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_801_1.callingController_:SetSelectedState("normal")

				arg_801_1.keyicon_.color = Color.New(1, 1, 1)
				arg_801_1.icon_.color = Color.New(1, 1, 1)

				local var_804_9 = arg_801_1:GetWordFromCfg(910201197)
				local var_804_10 = arg_801_1:FormatText(var_804_9.content)

				arg_801_1.text_.text = var_804_10

				LuaForUtil.ClearLinePrefixSymbol(arg_801_1.text_)

				local var_804_11 = 5
				local var_804_12 = utf8.len(var_804_10)
				local var_804_13 = var_804_11 <= 0 and var_804_7 or var_804_7 * (var_804_12 / var_804_11)

				if var_804_13 > 0 and var_804_7 < var_804_13 then
					arg_801_1.talkMaxDuration = var_804_13

					if var_804_13 + var_804_6 > arg_801_1.duration_ then
						arg_801_1.duration_ = var_804_13 + var_804_6
					end
				end

				arg_801_1.text_.text = var_804_10
				arg_801_1.typewritter.percent = 0

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(false)
				arg_801_1:RecordContent(arg_801_1.text_.text)
			end

			local var_804_14 = math.max(var_804_7, arg_801_1.talkMaxDuration)

			if var_804_6 <= arg_801_1.time_ and arg_801_1.time_ < var_804_6 + var_804_14 then
				arg_801_1.typewritter.percent = (arg_801_1.time_ - var_804_6) / var_804_14

				arg_801_1.typewritter:SetDirty()
			end

			if arg_801_1.time_ >= var_804_6 + var_804_14 and arg_801_1.time_ < var_804_6 + var_804_14 + arg_804_0 then
				arg_801_1.typewritter.percent = 1

				arg_801_1.typewritter:SetDirty()
				arg_801_1:ShowNextGo(true)
			end
		end

		arg_801_1.nodeConfigList_ = {}

		arg_801_1:InitPlayNodeList()
	end,
	Play910201198 = function(arg_805_0, arg_805_1)
		arg_805_1.time_ = 0
		arg_805_1.frameCnt_ = 0
		arg_805_1.state_ = "playing"
		arg_805_1.curTalkId_ = 910201198
		arg_805_1.duration_ = 5

		SetActive(arg_805_1.tipsGo_, false)

		function arg_805_1.onSingleLineFinish_()
			arg_805_1.onSingleLineUpdate_ = nil
			arg_805_1.onSingleLineFinish_ = nil
			arg_805_1.state_ = "waiting"
		end

		function arg_805_1.playNext_(arg_807_0)
			if arg_807_0 == 1 then
				arg_805_0:Play910201199(arg_805_1)
			end
		end

		function arg_805_1.onSingleLineUpdate_(arg_808_0)
			local var_808_0 = arg_805_1.actors_["1059ui_story"].transform
			local var_808_1 = 0

			if var_808_1 < arg_805_1.time_ and arg_805_1.time_ <= var_808_1 + arg_808_0 then
				arg_805_1.var_.moveOldPos1059ui_story = var_808_0.localPosition
			end

			local var_808_2 = 0.001

			if var_808_1 <= arg_805_1.time_ and arg_805_1.time_ < var_808_1 + var_808_2 then
				local var_808_3 = (arg_805_1.time_ - var_808_1) / var_808_2
				local var_808_4 = Vector3.New(0, 100, 0)

				var_808_0.localPosition = Vector3.Lerp(arg_805_1.var_.moveOldPos1059ui_story, var_808_4, var_808_3)

				local var_808_5 = manager.ui.mainCamera.transform.position - var_808_0.position

				var_808_0.forward = Vector3.New(var_808_5.x, var_808_5.y, var_808_5.z)

				local var_808_6 = var_808_0.localEulerAngles

				var_808_6.z = 0
				var_808_6.x = 0
				var_808_0.localEulerAngles = var_808_6
			end

			if arg_805_1.time_ >= var_808_1 + var_808_2 and arg_805_1.time_ < var_808_1 + var_808_2 + arg_808_0 then
				var_808_0.localPosition = Vector3.New(0, 100, 0)

				local var_808_7 = manager.ui.mainCamera.transform.position - var_808_0.position

				var_808_0.forward = Vector3.New(var_808_7.x, var_808_7.y, var_808_7.z)

				local var_808_8 = var_808_0.localEulerAngles

				var_808_8.z = 0
				var_808_8.x = 0
				var_808_0.localEulerAngles = var_808_8
			end

			local var_808_9 = "1032ui_story"

			if arg_805_1.actors_[var_808_9] == nil then
				local var_808_10 = Asset.Load("Char/" .. "1032ui_story")

				if not isNil(var_808_10) then
					local var_808_11 = Object.Instantiate(Asset.Load("Char/" .. "1032ui_story"), arg_805_1.stage_.transform)

					var_808_11.name = var_808_9
					var_808_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_805_1.actors_[var_808_9] = var_808_11

					local var_808_12 = var_808_11:GetComponentInChildren(typeof(CharacterEffect))

					var_808_12.enabled = true

					local var_808_13 = GameObjectTools.GetOrAddComponent(var_808_11, typeof(DynamicBoneHelper))

					if var_808_13 then
						var_808_13:EnableDynamicBone(false)
					end

					arg_805_1:ShowWeapon(var_808_12.transform, false)

					arg_805_1.var_[var_808_9 .. "Animator"] = var_808_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_805_1.var_[var_808_9 .. "Animator"].applyRootMotion = true
					arg_805_1.var_[var_808_9 .. "LipSync"] = var_808_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_808_14 = 0

			if var_808_14 < arg_805_1.time_ and arg_805_1.time_ <= var_808_14 + arg_808_0 then
				arg_805_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action8_1")
			end

			local var_808_15 = arg_805_1.actors_["1032ui_story"].transform
			local var_808_16 = 0

			if var_808_16 < arg_805_1.time_ and arg_805_1.time_ <= var_808_16 + arg_808_0 then
				arg_805_1.var_.moveOldPos1032ui_story = var_808_15.localPosition
			end

			local var_808_17 = 0.001

			if var_808_16 <= arg_805_1.time_ and arg_805_1.time_ < var_808_16 + var_808_17 then
				local var_808_18 = (arg_805_1.time_ - var_808_16) / var_808_17
				local var_808_19 = Vector3.New(0, -1.05, -6.2)

				var_808_15.localPosition = Vector3.Lerp(arg_805_1.var_.moveOldPos1032ui_story, var_808_19, var_808_18)

				local var_808_20 = manager.ui.mainCamera.transform.position - var_808_15.position

				var_808_15.forward = Vector3.New(var_808_20.x, var_808_20.y, var_808_20.z)

				local var_808_21 = var_808_15.localEulerAngles

				var_808_21.z = 0
				var_808_21.x = 0
				var_808_15.localEulerAngles = var_808_21
			end

			if arg_805_1.time_ >= var_808_16 + var_808_17 and arg_805_1.time_ < var_808_16 + var_808_17 + arg_808_0 then
				var_808_15.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_808_22 = manager.ui.mainCamera.transform.position - var_808_15.position

				var_808_15.forward = Vector3.New(var_808_22.x, var_808_22.y, var_808_22.z)

				local var_808_23 = var_808_15.localEulerAngles

				var_808_23.z = 0
				var_808_23.x = 0
				var_808_15.localEulerAngles = var_808_23
			end

			local var_808_24 = 0

			if var_808_24 < arg_805_1.time_ and arg_805_1.time_ <= var_808_24 + arg_808_0 then
				arg_805_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_808_25 = arg_805_1.actors_["1032ui_story"]
			local var_808_26 = 0

			if var_808_26 < arg_805_1.time_ and arg_805_1.time_ <= var_808_26 + arg_808_0 and not isNil(var_808_25) and arg_805_1.var_.characterEffect1032ui_story == nil then
				arg_805_1.var_.characterEffect1032ui_story = var_808_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_808_27 = 0.2

			if var_808_26 <= arg_805_1.time_ and arg_805_1.time_ < var_808_26 + var_808_27 and not isNil(var_808_25) then
				local var_808_28 = (arg_805_1.time_ - var_808_26) / var_808_27

				if arg_805_1.var_.characterEffect1032ui_story and not isNil(var_808_25) then
					arg_805_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_805_1.time_ >= var_808_26 + var_808_27 and arg_805_1.time_ < var_808_26 + var_808_27 + arg_808_0 and not isNil(var_808_25) and arg_805_1.var_.characterEffect1032ui_story then
				arg_805_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			local var_808_29 = 0
			local var_808_30 = 0.925

			if var_808_29 < arg_805_1.time_ and arg_805_1.time_ <= var_808_29 + arg_808_0 then
				arg_805_1.talkMaxDuration = 0
				arg_805_1.dialogCg_.alpha = 1

				arg_805_1.dialog_:SetActive(true)
				SetActive(arg_805_1.leftNameGo_, true)

				local var_808_31 = arg_805_1:FormatText(StoryNameCfg[61].name)

				arg_805_1.leftNameTxt_.text = var_808_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_805_1.leftNameTxt_.transform)

				arg_805_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_805_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_805_1:RecordName(arg_805_1.leftNameTxt_.text)
				SetActive(arg_805_1.iconTrs_.gameObject, false)
				arg_805_1.callingController_:SetSelectedState("normal")

				local var_808_32 = arg_805_1:GetWordFromCfg(910201198)
				local var_808_33 = arg_805_1:FormatText(var_808_32.content)

				arg_805_1.text_.text = var_808_33

				LuaForUtil.ClearLinePrefixSymbol(arg_805_1.text_)

				local var_808_34 = 37
				local var_808_35 = utf8.len(var_808_33)
				local var_808_36 = var_808_34 <= 0 and var_808_30 or var_808_30 * (var_808_35 / var_808_34)

				if var_808_36 > 0 and var_808_30 < var_808_36 then
					arg_805_1.talkMaxDuration = var_808_36

					if var_808_36 + var_808_29 > arg_805_1.duration_ then
						arg_805_1.duration_ = var_808_36 + var_808_29
					end
				end

				arg_805_1.text_.text = var_808_33
				arg_805_1.typewritter.percent = 0

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(false)
				arg_805_1:RecordContent(arg_805_1.text_.text)
			end

			local var_808_37 = math.max(var_808_30, arg_805_1.talkMaxDuration)

			if var_808_29 <= arg_805_1.time_ and arg_805_1.time_ < var_808_29 + var_808_37 then
				arg_805_1.typewritter.percent = (arg_805_1.time_ - var_808_29) / var_808_37

				arg_805_1.typewritter:SetDirty()
			end

			if arg_805_1.time_ >= var_808_29 + var_808_37 and arg_805_1.time_ < var_808_29 + var_808_37 + arg_808_0 then
				arg_805_1.typewritter.percent = 1

				arg_805_1.typewritter:SetDirty()
				arg_805_1:ShowNextGo(true)
			end
		end

		arg_805_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_805_1:InitPlayNodeList()
	end,
	Play910201199 = function(arg_809_0, arg_809_1)
		arg_809_1.time_ = 0
		arg_809_1.frameCnt_ = 0
		arg_809_1.state_ = "playing"
		arg_809_1.curTalkId_ = 910201199
		arg_809_1.duration_ = 5

		SetActive(arg_809_1.tipsGo_, false)

		function arg_809_1.onSingleLineFinish_()
			arg_809_1.onSingleLineUpdate_ = nil
			arg_809_1.onSingleLineFinish_ = nil
			arg_809_1.state_ = "waiting"
		end

		function arg_809_1.playNext_(arg_811_0)
			if arg_811_0 == 1 then
				arg_809_0:Play910201200(arg_809_1)
			end
		end

		function arg_809_1.onSingleLineUpdate_(arg_812_0)
			local var_812_0 = 0

			if var_812_0 < arg_809_1.time_ and arg_809_1.time_ <= var_812_0 + arg_812_0 then
				arg_809_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032actionlink/1032action486")
			end

			local var_812_1 = 0

			if var_812_1 < arg_809_1.time_ and arg_809_1.time_ <= var_812_1 + arg_812_0 then
				arg_809_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_812_2 = 0
			local var_812_3 = 0.775

			if var_812_2 < arg_809_1.time_ and arg_809_1.time_ <= var_812_2 + arg_812_0 then
				arg_809_1.talkMaxDuration = 0
				arg_809_1.dialogCg_.alpha = 1

				arg_809_1.dialog_:SetActive(true)
				SetActive(arg_809_1.leftNameGo_, true)

				local var_812_4 = arg_809_1:FormatText(StoryNameCfg[61].name)

				arg_809_1.leftNameTxt_.text = var_812_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_809_1.leftNameTxt_.transform)

				arg_809_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_809_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_809_1:RecordName(arg_809_1.leftNameTxt_.text)
				SetActive(arg_809_1.iconTrs_.gameObject, false)
				arg_809_1.callingController_:SetSelectedState("normal")

				local var_812_5 = arg_809_1:GetWordFromCfg(910201199)
				local var_812_6 = arg_809_1:FormatText(var_812_5.content)

				arg_809_1.text_.text = var_812_6

				LuaForUtil.ClearLinePrefixSymbol(arg_809_1.text_)

				local var_812_7 = 31
				local var_812_8 = utf8.len(var_812_6)
				local var_812_9 = var_812_7 <= 0 and var_812_3 or var_812_3 * (var_812_8 / var_812_7)

				if var_812_9 > 0 and var_812_3 < var_812_9 then
					arg_809_1.talkMaxDuration = var_812_9

					if var_812_9 + var_812_2 > arg_809_1.duration_ then
						arg_809_1.duration_ = var_812_9 + var_812_2
					end
				end

				arg_809_1.text_.text = var_812_6
				arg_809_1.typewritter.percent = 0

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(false)
				arg_809_1:RecordContent(arg_809_1.text_.text)
			end

			local var_812_10 = math.max(var_812_3, arg_809_1.talkMaxDuration)

			if var_812_2 <= arg_809_1.time_ and arg_809_1.time_ < var_812_2 + var_812_10 then
				arg_809_1.typewritter.percent = (arg_809_1.time_ - var_812_2) / var_812_10

				arg_809_1.typewritter:SetDirty()
			end

			if arg_809_1.time_ >= var_812_2 + var_812_10 and arg_809_1.time_ < var_812_2 + var_812_10 + arg_812_0 then
				arg_809_1.typewritter.percent = 1

				arg_809_1.typewritter:SetDirty()
				arg_809_1:ShowNextGo(true)
			end
		end

		arg_809_1.nodeConfigList_ = {}

		arg_809_1:InitPlayNodeList()
	end,
	Play910201200 = function(arg_813_0, arg_813_1)
		arg_813_1.time_ = 0
		arg_813_1.frameCnt_ = 0
		arg_813_1.state_ = "playing"
		arg_813_1.curTalkId_ = 910201200
		arg_813_1.duration_ = 5

		SetActive(arg_813_1.tipsGo_, false)

		function arg_813_1.onSingleLineFinish_()
			arg_813_1.onSingleLineUpdate_ = nil
			arg_813_1.onSingleLineFinish_ = nil
			arg_813_1.state_ = "waiting"
		end

		function arg_813_1.playNext_(arg_815_0)
			if arg_815_0 == 1 then
				arg_813_0:Play910201201(arg_813_1)
			end
		end

		function arg_813_1.onSingleLineUpdate_(arg_816_0)
			local var_816_0 = arg_813_1.actors_["1032ui_story"].transform
			local var_816_1 = 0

			if var_816_1 < arg_813_1.time_ and arg_813_1.time_ <= var_816_1 + arg_816_0 then
				arg_813_1.var_.moveOldPos1032ui_story = var_816_0.localPosition
			end

			local var_816_2 = 0.001

			if var_816_1 <= arg_813_1.time_ and arg_813_1.time_ < var_816_1 + var_816_2 then
				local var_816_3 = (arg_813_1.time_ - var_816_1) / var_816_2
				local var_816_4 = Vector3.New(0, 100, 0)

				var_816_0.localPosition = Vector3.Lerp(arg_813_1.var_.moveOldPos1032ui_story, var_816_4, var_816_3)

				local var_816_5 = manager.ui.mainCamera.transform.position - var_816_0.position

				var_816_0.forward = Vector3.New(var_816_5.x, var_816_5.y, var_816_5.z)

				local var_816_6 = var_816_0.localEulerAngles

				var_816_6.z = 0
				var_816_6.x = 0
				var_816_0.localEulerAngles = var_816_6
			end

			if arg_813_1.time_ >= var_816_1 + var_816_2 and arg_813_1.time_ < var_816_1 + var_816_2 + arg_816_0 then
				var_816_0.localPosition = Vector3.New(0, 100, 0)

				local var_816_7 = manager.ui.mainCamera.transform.position - var_816_0.position

				var_816_0.forward = Vector3.New(var_816_7.x, var_816_7.y, var_816_7.z)

				local var_816_8 = var_816_0.localEulerAngles

				var_816_8.z = 0
				var_816_8.x = 0
				var_816_0.localEulerAngles = var_816_8
			end

			local var_816_9 = 0
			local var_816_10 = 0.375

			if var_816_9 < arg_813_1.time_ and arg_813_1.time_ <= var_816_9 + arg_816_0 then
				arg_813_1.talkMaxDuration = 0
				arg_813_1.dialogCg_.alpha = 1

				arg_813_1.dialog_:SetActive(true)
				SetActive(arg_813_1.leftNameGo_, true)

				local var_816_11 = arg_813_1:FormatText(StoryNameCfg[7].name)

				arg_813_1.leftNameTxt_.text = var_816_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_813_1.leftNameTxt_.transform)

				arg_813_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_813_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_813_1:RecordName(arg_813_1.leftNameTxt_.text)
				SetActive(arg_813_1.iconTrs_.gameObject, true)
				arg_813_1.iconController_:SetSelectedState("hero")

				arg_813_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_813_1.callingController_:SetSelectedState("normal")

				arg_813_1.keyicon_.color = Color.New(1, 1, 1)
				arg_813_1.icon_.color = Color.New(1, 1, 1)

				local var_816_12 = arg_813_1:GetWordFromCfg(910201200)
				local var_816_13 = arg_813_1:FormatText(var_816_12.content)

				arg_813_1.text_.text = var_816_13

				LuaForUtil.ClearLinePrefixSymbol(arg_813_1.text_)

				local var_816_14 = 15
				local var_816_15 = utf8.len(var_816_13)
				local var_816_16 = var_816_14 <= 0 and var_816_10 or var_816_10 * (var_816_15 / var_816_14)

				if var_816_16 > 0 and var_816_10 < var_816_16 then
					arg_813_1.talkMaxDuration = var_816_16

					if var_816_16 + var_816_9 > arg_813_1.duration_ then
						arg_813_1.duration_ = var_816_16 + var_816_9
					end
				end

				arg_813_1.text_.text = var_816_13
				arg_813_1.typewritter.percent = 0

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(false)
				arg_813_1:RecordContent(arg_813_1.text_.text)
			end

			local var_816_17 = math.max(var_816_10, arg_813_1.talkMaxDuration)

			if var_816_9 <= arg_813_1.time_ and arg_813_1.time_ < var_816_9 + var_816_17 then
				arg_813_1.typewritter.percent = (arg_813_1.time_ - var_816_9) / var_816_17

				arg_813_1.typewritter:SetDirty()
			end

			if arg_813_1.time_ >= var_816_9 + var_816_17 and arg_813_1.time_ < var_816_9 + var_816_17 + arg_816_0 then
				arg_813_1.typewritter.percent = 1

				arg_813_1.typewritter:SetDirty()
				arg_813_1:ShowNextGo(true)
			end
		end

		arg_813_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_813_1:InitPlayNodeList()
	end,
	Play910201201 = function(arg_817_0, arg_817_1)
		arg_817_1.time_ = 0
		arg_817_1.frameCnt_ = 0
		arg_817_1.state_ = "playing"
		arg_817_1.curTalkId_ = 910201201
		arg_817_1.duration_ = 5

		SetActive(arg_817_1.tipsGo_, false)

		function arg_817_1.onSingleLineFinish_()
			arg_817_1.onSingleLineUpdate_ = nil
			arg_817_1.onSingleLineFinish_ = nil
			arg_817_1.state_ = "waiting"
		end

		function arg_817_1.playNext_(arg_819_0)
			if arg_819_0 == 1 then
				arg_817_0:Play910201202(arg_817_1)
			end
		end

		function arg_817_1.onSingleLineUpdate_(arg_820_0)
			local var_820_0 = arg_817_1.actors_["1096ui_story"].transform
			local var_820_1 = 0

			if var_820_1 < arg_817_1.time_ and arg_817_1.time_ <= var_820_1 + arg_820_0 then
				arg_817_1.var_.moveOldPos1096ui_story = var_820_0.localPosition
			end

			local var_820_2 = 0.001

			if var_820_1 <= arg_817_1.time_ and arg_817_1.time_ < var_820_1 + var_820_2 then
				local var_820_3 = (arg_817_1.time_ - var_820_1) / var_820_2
				local var_820_4 = Vector3.New(0, -1.13, -5.6)

				var_820_0.localPosition = Vector3.Lerp(arg_817_1.var_.moveOldPos1096ui_story, var_820_4, var_820_3)

				local var_820_5 = manager.ui.mainCamera.transform.position - var_820_0.position

				var_820_0.forward = Vector3.New(var_820_5.x, var_820_5.y, var_820_5.z)

				local var_820_6 = var_820_0.localEulerAngles

				var_820_6.z = 0
				var_820_6.x = 0
				var_820_0.localEulerAngles = var_820_6
			end

			if arg_817_1.time_ >= var_820_1 + var_820_2 and arg_817_1.time_ < var_820_1 + var_820_2 + arg_820_0 then
				var_820_0.localPosition = Vector3.New(0, -1.13, -5.6)

				local var_820_7 = manager.ui.mainCamera.transform.position - var_820_0.position

				var_820_0.forward = Vector3.New(var_820_7.x, var_820_7.y, var_820_7.z)

				local var_820_8 = var_820_0.localEulerAngles

				var_820_8.z = 0
				var_820_8.x = 0
				var_820_0.localEulerAngles = var_820_8
			end

			local var_820_9 = arg_817_1.actors_["1096ui_story"]
			local var_820_10 = 0

			if var_820_10 < arg_817_1.time_ and arg_817_1.time_ <= var_820_10 + arg_820_0 and not isNil(var_820_9) and arg_817_1.var_.characterEffect1096ui_story == nil then
				arg_817_1.var_.characterEffect1096ui_story = var_820_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_820_11 = 0.2

			if var_820_10 <= arg_817_1.time_ and arg_817_1.time_ < var_820_10 + var_820_11 and not isNil(var_820_9) then
				local var_820_12 = (arg_817_1.time_ - var_820_10) / var_820_11

				if arg_817_1.var_.characterEffect1096ui_story and not isNil(var_820_9) then
					arg_817_1.var_.characterEffect1096ui_story.fillFlat = false
				end
			end

			if arg_817_1.time_ >= var_820_10 + var_820_11 and arg_817_1.time_ < var_820_10 + var_820_11 + arg_820_0 and not isNil(var_820_9) and arg_817_1.var_.characterEffect1096ui_story then
				arg_817_1.var_.characterEffect1096ui_story.fillFlat = false
			end

			local var_820_13 = 0

			if var_820_13 < arg_817_1.time_ and arg_817_1.time_ <= var_820_13 + arg_820_0 then
				arg_817_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/story1096/story1096action/1096action3_1")
			end

			local var_820_14 = 0

			if var_820_14 < arg_817_1.time_ and arg_817_1.time_ <= var_820_14 + arg_820_0 then
				arg_817_1:PlayTimeline("1096ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_820_15 = 0
			local var_820_16 = 0.15

			if var_820_15 < arg_817_1.time_ and arg_817_1.time_ <= var_820_15 + arg_820_0 then
				arg_817_1.talkMaxDuration = 0
				arg_817_1.dialogCg_.alpha = 1

				arg_817_1.dialog_:SetActive(true)
				SetActive(arg_817_1.leftNameGo_, true)

				local var_820_17 = arg_817_1:FormatText(StoryNameCfg[169].name)

				arg_817_1.leftNameTxt_.text = var_820_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_817_1.leftNameTxt_.transform)

				arg_817_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_817_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_817_1:RecordName(arg_817_1.leftNameTxt_.text)
				SetActive(arg_817_1.iconTrs_.gameObject, false)
				arg_817_1.callingController_:SetSelectedState("normal")

				local var_820_18 = arg_817_1:GetWordFromCfg(910201201)
				local var_820_19 = arg_817_1:FormatText(var_820_18.content)

				arg_817_1.text_.text = var_820_19

				LuaForUtil.ClearLinePrefixSymbol(arg_817_1.text_)

				local var_820_20 = 6
				local var_820_21 = utf8.len(var_820_19)
				local var_820_22 = var_820_20 <= 0 and var_820_16 or var_820_16 * (var_820_21 / var_820_20)

				if var_820_22 > 0 and var_820_16 < var_820_22 then
					arg_817_1.talkMaxDuration = var_820_22

					if var_820_22 + var_820_15 > arg_817_1.duration_ then
						arg_817_1.duration_ = var_820_22 + var_820_15
					end
				end

				arg_817_1.text_.text = var_820_19
				arg_817_1.typewritter.percent = 0

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(false)
				arg_817_1:RecordContent(arg_817_1.text_.text)
			end

			local var_820_23 = math.max(var_820_16, arg_817_1.talkMaxDuration)

			if var_820_15 <= arg_817_1.time_ and arg_817_1.time_ < var_820_15 + var_820_23 then
				arg_817_1.typewritter.percent = (arg_817_1.time_ - var_820_15) / var_820_23

				arg_817_1.typewritter:SetDirty()
			end

			if arg_817_1.time_ >= var_820_15 + var_820_23 and arg_817_1.time_ < var_820_15 + var_820_23 + arg_820_0 then
				arg_817_1.typewritter.percent = 1

				arg_817_1.typewritter:SetDirty()
				arg_817_1:ShowNextGo(true)
			end
		end

		arg_817_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_817_1:InitPlayNodeList()
	end,
	Play910201202 = function(arg_821_0, arg_821_1)
		arg_821_1.time_ = 0
		arg_821_1.frameCnt_ = 0
		arg_821_1.state_ = "playing"
		arg_821_1.curTalkId_ = 910201202
		arg_821_1.duration_ = 9

		SetActive(arg_821_1.tipsGo_, false)

		function arg_821_1.onSingleLineFinish_()
			arg_821_1.onSingleLineUpdate_ = nil
			arg_821_1.onSingleLineFinish_ = nil
			arg_821_1.state_ = "waiting"
		end

		function arg_821_1.playNext_(arg_823_0)
			if arg_823_0 == 1 then
				arg_821_0:Play910201203(arg_821_1)
			end
		end

		function arg_821_1.onSingleLineUpdate_(arg_824_0)
			local var_824_0 = "HB0101"

			if arg_821_1.bgs_[var_824_0] == nil then
				local var_824_1 = Object.Instantiate(arg_821_1.paintGo_)

				var_824_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_824_0)
				var_824_1.name = var_824_0
				var_824_1.transform.parent = arg_821_1.stage_.transform
				var_824_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_821_1.bgs_[var_824_0] = var_824_1
			end

			local var_824_2 = 2

			if var_824_2 < arg_821_1.time_ and arg_821_1.time_ <= var_824_2 + arg_824_0 then
				local var_824_3 = manager.ui.mainCamera.transform.localPosition
				local var_824_4 = Vector3.New(0, 0, 10) + Vector3.New(var_824_3.x, var_824_3.y, 0)
				local var_824_5 = arg_821_1.bgs_.HB0101

				var_824_5.transform.localPosition = var_824_4
				var_824_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_824_6 = var_824_5:GetComponent("SpriteRenderer")

				if var_824_6 and var_824_6.sprite then
					local var_824_7 = (var_824_5.transform.localPosition - var_824_3).z
					local var_824_8 = manager.ui.mainCameraCom_
					local var_824_9 = 2 * var_824_7 * Mathf.Tan(var_824_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_824_10 = var_824_9 * var_824_8.aspect
					local var_824_11 = var_824_6.sprite.bounds.size.x
					local var_824_12 = var_824_6.sprite.bounds.size.y
					local var_824_13 = var_824_10 / var_824_11
					local var_824_14 = var_824_9 / var_824_12
					local var_824_15 = var_824_14 < var_824_13 and var_824_13 or var_824_14

					var_824_5.transform.localScale = Vector3.New(var_824_15, var_824_15, 0)
				end

				for iter_824_0, iter_824_1 in pairs(arg_821_1.bgs_) do
					if iter_824_0 ~= "HB0101" then
						iter_824_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_824_16 = arg_821_1.actors_["1096ui_story"].transform
			local var_824_17 = 1.966

			if var_824_17 < arg_821_1.time_ and arg_821_1.time_ <= var_824_17 + arg_824_0 then
				arg_821_1.var_.moveOldPos1096ui_story = var_824_16.localPosition
			end

			local var_824_18 = 0.001

			if var_824_17 <= arg_821_1.time_ and arg_821_1.time_ < var_824_17 + var_824_18 then
				local var_824_19 = (arg_821_1.time_ - var_824_17) / var_824_18
				local var_824_20 = Vector3.New(0, 100, 0)

				var_824_16.localPosition = Vector3.Lerp(arg_821_1.var_.moveOldPos1096ui_story, var_824_20, var_824_19)

				local var_824_21 = manager.ui.mainCamera.transform.position - var_824_16.position

				var_824_16.forward = Vector3.New(var_824_21.x, var_824_21.y, var_824_21.z)

				local var_824_22 = var_824_16.localEulerAngles

				var_824_22.z = 0
				var_824_22.x = 0
				var_824_16.localEulerAngles = var_824_22
			end

			if arg_821_1.time_ >= var_824_17 + var_824_18 and arg_821_1.time_ < var_824_17 + var_824_18 + arg_824_0 then
				var_824_16.localPosition = Vector3.New(0, 100, 0)

				local var_824_23 = manager.ui.mainCamera.transform.position - var_824_16.position

				var_824_16.forward = Vector3.New(var_824_23.x, var_824_23.y, var_824_23.z)

				local var_824_24 = var_824_16.localEulerAngles

				var_824_24.z = 0
				var_824_24.x = 0
				var_824_16.localEulerAngles = var_824_24
			end

			local var_824_25 = 0

			if var_824_25 < arg_821_1.time_ and arg_821_1.time_ <= var_824_25 + arg_824_0 then
				arg_821_1.mask_.enabled = true
				arg_821_1.mask_.raycastTarget = true

				arg_821_1:SetGaussion(false)
			end

			local var_824_26 = 2

			if var_824_25 <= arg_821_1.time_ and arg_821_1.time_ < var_824_25 + var_824_26 then
				local var_824_27 = (arg_821_1.time_ - var_824_25) / var_824_26
				local var_824_28 = Color.New(0, 0, 0)

				var_824_28.a = Mathf.Lerp(0, 1, var_824_27)
				arg_821_1.mask_.color = var_824_28
			end

			if arg_821_1.time_ >= var_824_25 + var_824_26 and arg_821_1.time_ < var_824_25 + var_824_26 + arg_824_0 then
				local var_824_29 = Color.New(0, 0, 0)

				var_824_29.a = 1
				arg_821_1.mask_.color = var_824_29
			end

			local var_824_30 = 2

			if var_824_30 < arg_821_1.time_ and arg_821_1.time_ <= var_824_30 + arg_824_0 then
				arg_821_1.mask_.enabled = true
				arg_821_1.mask_.raycastTarget = true

				arg_821_1:SetGaussion(false)
			end

			local var_824_31 = 2

			if var_824_30 <= arg_821_1.time_ and arg_821_1.time_ < var_824_30 + var_824_31 then
				local var_824_32 = (arg_821_1.time_ - var_824_30) / var_824_31
				local var_824_33 = Color.New(0, 0, 0)

				var_824_33.a = Mathf.Lerp(1, 0, var_824_32)
				arg_821_1.mask_.color = var_824_33
			end

			if arg_821_1.time_ >= var_824_30 + var_824_31 and arg_821_1.time_ < var_824_30 + var_824_31 + arg_824_0 then
				local var_824_34 = Color.New(0, 0, 0)
				local var_824_35 = 0

				arg_821_1.mask_.enabled = false
				var_824_34.a = var_824_35
				arg_821_1.mask_.color = var_824_34
			end

			if arg_821_1.frameCnt_ <= 1 then
				arg_821_1.dialog_:SetActive(false)
			end

			local var_824_36 = 4
			local var_824_37 = 0.375

			if var_824_36 < arg_821_1.time_ and arg_821_1.time_ <= var_824_36 + arg_824_0 then
				arg_821_1.talkMaxDuration = 0

				arg_821_1.dialog_:SetActive(true)

				arg_821_1.dialogCg_.alpha = 0

				local var_824_38 = LeanTween.value(arg_821_1.dialog_, 0, 1, 0.3)

				var_824_38:setOnUpdate(LuaHelper.FloatAction(function(arg_825_0)
					arg_821_1.dialogCg_.alpha = arg_825_0
				end))
				var_824_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_821_1.dialog_)
					var_824_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_821_1.duration_ = arg_821_1.duration_ + 0.3

				SetActive(arg_821_1.leftNameGo_, true)

				local var_824_39 = arg_821_1:FormatText(StoryNameCfg[8].name)

				arg_821_1.leftNameTxt_.text = var_824_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_821_1.leftNameTxt_.transform)

				arg_821_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_821_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_821_1:RecordName(arg_821_1.leftNameTxt_.text)
				SetActive(arg_821_1.iconTrs_.gameObject, false)
				arg_821_1.callingController_:SetSelectedState("normal")

				local var_824_40 = arg_821_1:GetWordFromCfg(910201202)
				local var_824_41 = arg_821_1:FormatText(var_824_40.content)

				arg_821_1.text_.text = var_824_41

				LuaForUtil.ClearLinePrefixSymbol(arg_821_1.text_)

				local var_824_42 = 15
				local var_824_43 = utf8.len(var_824_41)
				local var_824_44 = var_824_42 <= 0 and var_824_37 or var_824_37 * (var_824_43 / var_824_42)

				if var_824_44 > 0 and var_824_37 < var_824_44 then
					arg_821_1.talkMaxDuration = var_824_44
					var_824_36 = var_824_36 + 0.3

					if var_824_44 + var_824_36 > arg_821_1.duration_ then
						arg_821_1.duration_ = var_824_44 + var_824_36
					end
				end

				arg_821_1.text_.text = var_824_41
				arg_821_1.typewritter.percent = 0

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(false)
				arg_821_1:RecordContent(arg_821_1.text_.text)
			end

			local var_824_45 = var_824_36 + 0.3
			local var_824_46 = math.max(var_824_37, arg_821_1.talkMaxDuration)

			if var_824_45 <= arg_821_1.time_ and arg_821_1.time_ < var_824_45 + var_824_46 then
				arg_821_1.typewritter.percent = (arg_821_1.time_ - var_824_45) / var_824_46

				arg_821_1.typewritter:SetDirty()
			end

			if arg_821_1.time_ >= var_824_45 + var_824_46 and arg_821_1.time_ < var_824_45 + var_824_46 + arg_824_0 then
				arg_821_1.typewritter.percent = 1

				arg_821_1.typewritter:SetDirty()
				arg_821_1:ShowNextGo(true)
			end
		end

		arg_821_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1096ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_821_1:InitPlayNodeList()
	end,
	Play910201203 = function(arg_827_0, arg_827_1)
		arg_827_1.time_ = 0
		arg_827_1.frameCnt_ = 0
		arg_827_1.state_ = "playing"
		arg_827_1.curTalkId_ = 910201203
		arg_827_1.duration_ = 5

		SetActive(arg_827_1.tipsGo_, false)

		function arg_827_1.onSingleLineFinish_()
			arg_827_1.onSingleLineUpdate_ = nil
			arg_827_1.onSingleLineFinish_ = nil
			arg_827_1.state_ = "waiting"
		end

		function arg_827_1.playNext_(arg_829_0)
			if arg_829_0 == 1 then
				arg_827_0:Play910201204(arg_827_1)
			end
		end

		function arg_827_1.onSingleLineUpdate_(arg_830_0)
			local var_830_0 = 0
			local var_830_1 = 0.8

			if var_830_0 < arg_827_1.time_ and arg_827_1.time_ <= var_830_0 + arg_830_0 then
				arg_827_1.talkMaxDuration = 0
				arg_827_1.dialogCg_.alpha = 1

				arg_827_1.dialog_:SetActive(true)
				SetActive(arg_827_1.leftNameGo_, true)

				local var_830_2 = arg_827_1:FormatText(StoryNameCfg[8].name)

				arg_827_1.leftNameTxt_.text = var_830_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_827_1.leftNameTxt_.transform)

				arg_827_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_827_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_827_1:RecordName(arg_827_1.leftNameTxt_.text)
				SetActive(arg_827_1.iconTrs_.gameObject, false)
				arg_827_1.callingController_:SetSelectedState("normal")

				local var_830_3 = arg_827_1:GetWordFromCfg(910201203)
				local var_830_4 = arg_827_1:FormatText(var_830_3.content)

				arg_827_1.text_.text = var_830_4

				LuaForUtil.ClearLinePrefixSymbol(arg_827_1.text_)

				local var_830_5 = 32
				local var_830_6 = utf8.len(var_830_4)
				local var_830_7 = var_830_5 <= 0 and var_830_1 or var_830_1 * (var_830_6 / var_830_5)

				if var_830_7 > 0 and var_830_1 < var_830_7 then
					arg_827_1.talkMaxDuration = var_830_7

					if var_830_7 + var_830_0 > arg_827_1.duration_ then
						arg_827_1.duration_ = var_830_7 + var_830_0
					end
				end

				arg_827_1.text_.text = var_830_4
				arg_827_1.typewritter.percent = 0

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(false)
				arg_827_1:RecordContent(arg_827_1.text_.text)
			end

			local var_830_8 = math.max(var_830_1, arg_827_1.talkMaxDuration)

			if var_830_0 <= arg_827_1.time_ and arg_827_1.time_ < var_830_0 + var_830_8 then
				arg_827_1.typewritter.percent = (arg_827_1.time_ - var_830_0) / var_830_8

				arg_827_1.typewritter:SetDirty()
			end

			if arg_827_1.time_ >= var_830_0 + var_830_8 and arg_827_1.time_ < var_830_0 + var_830_8 + arg_830_0 then
				arg_827_1.typewritter.percent = 1

				arg_827_1.typewritter:SetDirty()
				arg_827_1:ShowNextGo(true)
			end
		end

		arg_827_1.nodeConfigList_ = {}

		arg_827_1:InitPlayNodeList()
	end,
	Play910201204 = function(arg_831_0, arg_831_1)
		arg_831_1.time_ = 0
		arg_831_1.frameCnt_ = 0
		arg_831_1.state_ = "playing"
		arg_831_1.curTalkId_ = 910201204
		arg_831_1.duration_ = 5

		SetActive(arg_831_1.tipsGo_, false)

		function arg_831_1.onSingleLineFinish_()
			arg_831_1.onSingleLineUpdate_ = nil
			arg_831_1.onSingleLineFinish_ = nil
			arg_831_1.state_ = "waiting"
		end

		function arg_831_1.playNext_(arg_833_0)
			if arg_833_0 == 1 then
				arg_831_0:Play910201205(arg_831_1)
			end
		end

		function arg_831_1.onSingleLineUpdate_(arg_834_0)
			local var_834_0 = 0
			local var_834_1 = 0.55

			if var_834_0 < arg_831_1.time_ and arg_831_1.time_ <= var_834_0 + arg_834_0 then
				arg_831_1.talkMaxDuration = 0
				arg_831_1.dialogCg_.alpha = 1

				arg_831_1.dialog_:SetActive(true)
				SetActive(arg_831_1.leftNameGo_, true)

				local var_834_2 = arg_831_1:FormatText(StoryNameCfg[8].name)

				arg_831_1.leftNameTxt_.text = var_834_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_831_1.leftNameTxt_.transform)

				arg_831_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_831_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_831_1:RecordName(arg_831_1.leftNameTxt_.text)
				SetActive(arg_831_1.iconTrs_.gameObject, false)
				arg_831_1.callingController_:SetSelectedState("normal")

				local var_834_3 = arg_831_1:GetWordFromCfg(910201204)
				local var_834_4 = arg_831_1:FormatText(var_834_3.content)

				arg_831_1.text_.text = var_834_4

				LuaForUtil.ClearLinePrefixSymbol(arg_831_1.text_)

				local var_834_5 = 22
				local var_834_6 = utf8.len(var_834_4)
				local var_834_7 = var_834_5 <= 0 and var_834_1 or var_834_1 * (var_834_6 / var_834_5)

				if var_834_7 > 0 and var_834_1 < var_834_7 then
					arg_831_1.talkMaxDuration = var_834_7

					if var_834_7 + var_834_0 > arg_831_1.duration_ then
						arg_831_1.duration_ = var_834_7 + var_834_0
					end
				end

				arg_831_1.text_.text = var_834_4
				arg_831_1.typewritter.percent = 0

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(false)
				arg_831_1:RecordContent(arg_831_1.text_.text)
			end

			local var_834_8 = math.max(var_834_1, arg_831_1.talkMaxDuration)

			if var_834_0 <= arg_831_1.time_ and arg_831_1.time_ < var_834_0 + var_834_8 then
				arg_831_1.typewritter.percent = (arg_831_1.time_ - var_834_0) / var_834_8

				arg_831_1.typewritter:SetDirty()
			end

			if arg_831_1.time_ >= var_834_0 + var_834_8 and arg_831_1.time_ < var_834_0 + var_834_8 + arg_834_0 then
				arg_831_1.typewritter.percent = 1

				arg_831_1.typewritter:SetDirty()
				arg_831_1:ShowNextGo(true)
			end
		end

		arg_831_1.nodeConfigList_ = {}

		arg_831_1:InitPlayNodeList()
	end,
	Play910201205 = function(arg_835_0, arg_835_1)
		arg_835_1.time_ = 0
		arg_835_1.frameCnt_ = 0
		arg_835_1.state_ = "playing"
		arg_835_1.curTalkId_ = 910201205
		arg_835_1.duration_ = 5

		SetActive(arg_835_1.tipsGo_, false)

		function arg_835_1.onSingleLineFinish_()
			arg_835_1.onSingleLineUpdate_ = nil
			arg_835_1.onSingleLineFinish_ = nil
			arg_835_1.state_ = "waiting"
		end

		function arg_835_1.playNext_(arg_837_0)
			if arg_837_0 == 1 then
				arg_835_0:Play910201206(arg_835_1)
			end
		end

		function arg_835_1.onSingleLineUpdate_(arg_838_0)
			local var_838_0 = 0
			local var_838_1 = 1.075

			if var_838_0 < arg_835_1.time_ and arg_835_1.time_ <= var_838_0 + arg_838_0 then
				arg_835_1.talkMaxDuration = 0
				arg_835_1.dialogCg_.alpha = 1

				arg_835_1.dialog_:SetActive(true)
				SetActive(arg_835_1.leftNameGo_, true)

				local var_838_2 = arg_835_1:FormatText(StoryNameCfg[8].name)

				arg_835_1.leftNameTxt_.text = var_838_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_835_1.leftNameTxt_.transform)

				arg_835_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_835_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_835_1:RecordName(arg_835_1.leftNameTxt_.text)
				SetActive(arg_835_1.iconTrs_.gameObject, false)
				arg_835_1.callingController_:SetSelectedState("normal")

				local var_838_3 = arg_835_1:GetWordFromCfg(910201205)
				local var_838_4 = arg_835_1:FormatText(var_838_3.content)

				arg_835_1.text_.text = var_838_4

				LuaForUtil.ClearLinePrefixSymbol(arg_835_1.text_)

				local var_838_5 = 43
				local var_838_6 = utf8.len(var_838_4)
				local var_838_7 = var_838_5 <= 0 and var_838_1 or var_838_1 * (var_838_6 / var_838_5)

				if var_838_7 > 0 and var_838_1 < var_838_7 then
					arg_835_1.talkMaxDuration = var_838_7

					if var_838_7 + var_838_0 > arg_835_1.duration_ then
						arg_835_1.duration_ = var_838_7 + var_838_0
					end
				end

				arg_835_1.text_.text = var_838_4
				arg_835_1.typewritter.percent = 0

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(false)
				arg_835_1:RecordContent(arg_835_1.text_.text)
			end

			local var_838_8 = math.max(var_838_1, arg_835_1.talkMaxDuration)

			if var_838_0 <= arg_835_1.time_ and arg_835_1.time_ < var_838_0 + var_838_8 then
				arg_835_1.typewritter.percent = (arg_835_1.time_ - var_838_0) / var_838_8

				arg_835_1.typewritter:SetDirty()
			end

			if arg_835_1.time_ >= var_838_0 + var_838_8 and arg_835_1.time_ < var_838_0 + var_838_8 + arg_838_0 then
				arg_835_1.typewritter.percent = 1

				arg_835_1.typewritter:SetDirty()
				arg_835_1:ShowNextGo(true)
			end
		end

		arg_835_1.nodeConfigList_ = {}

		arg_835_1:InitPlayNodeList()
	end,
	Play910201206 = function(arg_839_0, arg_839_1)
		arg_839_1.time_ = 0
		arg_839_1.frameCnt_ = 0
		arg_839_1.state_ = "playing"
		arg_839_1.curTalkId_ = 910201206
		arg_839_1.duration_ = 5

		SetActive(arg_839_1.tipsGo_, false)

		function arg_839_1.onSingleLineFinish_()
			arg_839_1.onSingleLineUpdate_ = nil
			arg_839_1.onSingleLineFinish_ = nil
			arg_839_1.state_ = "waiting"
		end

		function arg_839_1.playNext_(arg_841_0)
			if arg_841_0 == 1 then
				arg_839_0:Play910201207(arg_839_1)
			end
		end

		function arg_839_1.onSingleLineUpdate_(arg_842_0)
			local var_842_0 = 0
			local var_842_1 = 0.8

			if var_842_0 < arg_839_1.time_ and arg_839_1.time_ <= var_842_0 + arg_842_0 then
				arg_839_1.talkMaxDuration = 0
				arg_839_1.dialogCg_.alpha = 1

				arg_839_1.dialog_:SetActive(true)
				SetActive(arg_839_1.leftNameGo_, true)

				local var_842_2 = arg_839_1:FormatText(StoryNameCfg[8].name)

				arg_839_1.leftNameTxt_.text = var_842_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_839_1.leftNameTxt_.transform)

				arg_839_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_839_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_839_1:RecordName(arg_839_1.leftNameTxt_.text)
				SetActive(arg_839_1.iconTrs_.gameObject, false)
				arg_839_1.callingController_:SetSelectedState("normal")

				local var_842_3 = arg_839_1:GetWordFromCfg(910201206)
				local var_842_4 = arg_839_1:FormatText(var_842_3.content)

				arg_839_1.text_.text = var_842_4

				LuaForUtil.ClearLinePrefixSymbol(arg_839_1.text_)

				local var_842_5 = 32
				local var_842_6 = utf8.len(var_842_4)
				local var_842_7 = var_842_5 <= 0 and var_842_1 or var_842_1 * (var_842_6 / var_842_5)

				if var_842_7 > 0 and var_842_1 < var_842_7 then
					arg_839_1.talkMaxDuration = var_842_7

					if var_842_7 + var_842_0 > arg_839_1.duration_ then
						arg_839_1.duration_ = var_842_7 + var_842_0
					end
				end

				arg_839_1.text_.text = var_842_4
				arg_839_1.typewritter.percent = 0

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(false)
				arg_839_1:RecordContent(arg_839_1.text_.text)
			end

			local var_842_8 = math.max(var_842_1, arg_839_1.talkMaxDuration)

			if var_842_0 <= arg_839_1.time_ and arg_839_1.time_ < var_842_0 + var_842_8 then
				arg_839_1.typewritter.percent = (arg_839_1.time_ - var_842_0) / var_842_8

				arg_839_1.typewritter:SetDirty()
			end

			if arg_839_1.time_ >= var_842_0 + var_842_8 and arg_839_1.time_ < var_842_0 + var_842_8 + arg_842_0 then
				arg_839_1.typewritter.percent = 1

				arg_839_1.typewritter:SetDirty()
				arg_839_1:ShowNextGo(true)
			end
		end

		arg_839_1.nodeConfigList_ = {}

		arg_839_1:InitPlayNodeList()
	end,
	Play910201207 = function(arg_843_0, arg_843_1)
		arg_843_1.time_ = 0
		arg_843_1.frameCnt_ = 0
		arg_843_1.state_ = "playing"
		arg_843_1.curTalkId_ = 910201207
		arg_843_1.duration_ = 5

		SetActive(arg_843_1.tipsGo_, false)

		function arg_843_1.onSingleLineFinish_()
			arg_843_1.onSingleLineUpdate_ = nil
			arg_843_1.onSingleLineFinish_ = nil
			arg_843_1.state_ = "waiting"
		end

		function arg_843_1.playNext_(arg_845_0)
			if arg_845_0 == 1 then
				arg_843_0:Play910201208(arg_843_1)
			end
		end

		function arg_843_1.onSingleLineUpdate_(arg_846_0)
			local var_846_0 = 0
			local var_846_1 = 0.975

			if var_846_0 < arg_843_1.time_ and arg_843_1.time_ <= var_846_0 + arg_846_0 then
				arg_843_1.talkMaxDuration = 0
				arg_843_1.dialogCg_.alpha = 1

				arg_843_1.dialog_:SetActive(true)
				SetActive(arg_843_1.leftNameGo_, true)

				local var_846_2 = arg_843_1:FormatText(StoryNameCfg[8].name)

				arg_843_1.leftNameTxt_.text = var_846_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_843_1.leftNameTxt_.transform)

				arg_843_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_843_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_843_1:RecordName(arg_843_1.leftNameTxt_.text)
				SetActive(arg_843_1.iconTrs_.gameObject, false)
				arg_843_1.callingController_:SetSelectedState("normal")

				local var_846_3 = arg_843_1:GetWordFromCfg(910201207)
				local var_846_4 = arg_843_1:FormatText(var_846_3.content)

				arg_843_1.text_.text = var_846_4

				LuaForUtil.ClearLinePrefixSymbol(arg_843_1.text_)

				local var_846_5 = 39
				local var_846_6 = utf8.len(var_846_4)
				local var_846_7 = var_846_5 <= 0 and var_846_1 or var_846_1 * (var_846_6 / var_846_5)

				if var_846_7 > 0 and var_846_1 < var_846_7 then
					arg_843_1.talkMaxDuration = var_846_7

					if var_846_7 + var_846_0 > arg_843_1.duration_ then
						arg_843_1.duration_ = var_846_7 + var_846_0
					end
				end

				arg_843_1.text_.text = var_846_4
				arg_843_1.typewritter.percent = 0

				arg_843_1.typewritter:SetDirty()
				arg_843_1:ShowNextGo(false)
				arg_843_1:RecordContent(arg_843_1.text_.text)
			end

			local var_846_8 = math.max(var_846_1, arg_843_1.talkMaxDuration)

			if var_846_0 <= arg_843_1.time_ and arg_843_1.time_ < var_846_0 + var_846_8 then
				arg_843_1.typewritter.percent = (arg_843_1.time_ - var_846_0) / var_846_8

				arg_843_1.typewritter:SetDirty()
			end

			if arg_843_1.time_ >= var_846_0 + var_846_8 and arg_843_1.time_ < var_846_0 + var_846_8 + arg_846_0 then
				arg_843_1.typewritter.percent = 1

				arg_843_1.typewritter:SetDirty()
				arg_843_1:ShowNextGo(true)
			end
		end

		arg_843_1.nodeConfigList_ = {}

		arg_843_1:InitPlayNodeList()
	end,
	Play910201208 = function(arg_847_0, arg_847_1)
		arg_847_1.time_ = 0
		arg_847_1.frameCnt_ = 0
		arg_847_1.state_ = "playing"
		arg_847_1.curTalkId_ = 910201208
		arg_847_1.duration_ = 5

		SetActive(arg_847_1.tipsGo_, false)

		function arg_847_1.onSingleLineFinish_()
			arg_847_1.onSingleLineUpdate_ = nil
			arg_847_1.onSingleLineFinish_ = nil
			arg_847_1.state_ = "waiting"
		end

		function arg_847_1.playNext_(arg_849_0)
			if arg_849_0 == 1 then
				arg_847_0:Play910201209(arg_847_1)
			end
		end

		function arg_847_1.onSingleLineUpdate_(arg_850_0)
			local var_850_0 = 0
			local var_850_1 = 0.2

			if var_850_0 < arg_847_1.time_ and arg_847_1.time_ <= var_850_0 + arg_850_0 then
				arg_847_1.talkMaxDuration = 0
				arg_847_1.dialogCg_.alpha = 1

				arg_847_1.dialog_:SetActive(true)
				SetActive(arg_847_1.leftNameGo_, true)

				local var_850_2 = arg_847_1:FormatText(StoryNameCfg[13].name)

				arg_847_1.leftNameTxt_.text = var_850_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_847_1.leftNameTxt_.transform)

				arg_847_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_847_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_847_1:RecordName(arg_847_1.leftNameTxt_.text)
				SetActive(arg_847_1.iconTrs_.gameObject, false)
				arg_847_1.callingController_:SetSelectedState("normal")

				local var_850_3 = arg_847_1:GetWordFromCfg(910201208)
				local var_850_4 = arg_847_1:FormatText(var_850_3.content)

				arg_847_1.text_.text = var_850_4

				LuaForUtil.ClearLinePrefixSymbol(arg_847_1.text_)

				local var_850_5 = 8
				local var_850_6 = utf8.len(var_850_4)
				local var_850_7 = var_850_5 <= 0 and var_850_1 or var_850_1 * (var_850_6 / var_850_5)

				if var_850_7 > 0 and var_850_1 < var_850_7 then
					arg_847_1.talkMaxDuration = var_850_7

					if var_850_7 + var_850_0 > arg_847_1.duration_ then
						arg_847_1.duration_ = var_850_7 + var_850_0
					end
				end

				arg_847_1.text_.text = var_850_4
				arg_847_1.typewritter.percent = 0

				arg_847_1.typewritter:SetDirty()
				arg_847_1:ShowNextGo(false)
				arg_847_1:RecordContent(arg_847_1.text_.text)
			end

			local var_850_8 = math.max(var_850_1, arg_847_1.talkMaxDuration)

			if var_850_0 <= arg_847_1.time_ and arg_847_1.time_ < var_850_0 + var_850_8 then
				arg_847_1.typewritter.percent = (arg_847_1.time_ - var_850_0) / var_850_8

				arg_847_1.typewritter:SetDirty()
			end

			if arg_847_1.time_ >= var_850_0 + var_850_8 and arg_847_1.time_ < var_850_0 + var_850_8 + arg_850_0 then
				arg_847_1.typewritter.percent = 1

				arg_847_1.typewritter:SetDirty()
				arg_847_1:ShowNextGo(true)
			end
		end

		arg_847_1.nodeConfigList_ = {}

		arg_847_1:InitPlayNodeList()
	end,
	Play910201209 = function(arg_851_0, arg_851_1)
		arg_851_1.time_ = 0
		arg_851_1.frameCnt_ = 0
		arg_851_1.state_ = "playing"
		arg_851_1.curTalkId_ = 910201209
		arg_851_1.duration_ = 5

		SetActive(arg_851_1.tipsGo_, false)

		function arg_851_1.onSingleLineFinish_()
			arg_851_1.onSingleLineUpdate_ = nil
			arg_851_1.onSingleLineFinish_ = nil
			arg_851_1.state_ = "waiting"
		end

		function arg_851_1.playNext_(arg_853_0)
			if arg_853_0 == 1 then
				arg_851_0:Play910201210(arg_851_1)
			end
		end

		function arg_851_1.onSingleLineUpdate_(arg_854_0)
			local var_854_0 = 0
			local var_854_1 = 0.175

			if var_854_0 < arg_851_1.time_ and arg_851_1.time_ <= var_854_0 + arg_854_0 then
				arg_851_1.talkMaxDuration = 0
				arg_851_1.dialogCg_.alpha = 1

				arg_851_1.dialog_:SetActive(true)
				SetActive(arg_851_1.leftNameGo_, true)

				local var_854_2 = arg_851_1:FormatText(StoryNameCfg[8].name)

				arg_851_1.leftNameTxt_.text = var_854_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_851_1.leftNameTxt_.transform)

				arg_851_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_851_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_851_1:RecordName(arg_851_1.leftNameTxt_.text)
				SetActive(arg_851_1.iconTrs_.gameObject, false)
				arg_851_1.callingController_:SetSelectedState("normal")

				local var_854_3 = arg_851_1:GetWordFromCfg(910201209)
				local var_854_4 = arg_851_1:FormatText(var_854_3.content)

				arg_851_1.text_.text = var_854_4

				LuaForUtil.ClearLinePrefixSymbol(arg_851_1.text_)

				local var_854_5 = 7
				local var_854_6 = utf8.len(var_854_4)
				local var_854_7 = var_854_5 <= 0 and var_854_1 or var_854_1 * (var_854_6 / var_854_5)

				if var_854_7 > 0 and var_854_1 < var_854_7 then
					arg_851_1.talkMaxDuration = var_854_7

					if var_854_7 + var_854_0 > arg_851_1.duration_ then
						arg_851_1.duration_ = var_854_7 + var_854_0
					end
				end

				arg_851_1.text_.text = var_854_4
				arg_851_1.typewritter.percent = 0

				arg_851_1.typewritter:SetDirty()
				arg_851_1:ShowNextGo(false)
				arg_851_1:RecordContent(arg_851_1.text_.text)
			end

			local var_854_8 = math.max(var_854_1, arg_851_1.talkMaxDuration)

			if var_854_0 <= arg_851_1.time_ and arg_851_1.time_ < var_854_0 + var_854_8 then
				arg_851_1.typewritter.percent = (arg_851_1.time_ - var_854_0) / var_854_8

				arg_851_1.typewritter:SetDirty()
			end

			if arg_851_1.time_ >= var_854_0 + var_854_8 and arg_851_1.time_ < var_854_0 + var_854_8 + arg_854_0 then
				arg_851_1.typewritter.percent = 1

				arg_851_1.typewritter:SetDirty()
				arg_851_1:ShowNextGo(true)
			end
		end

		arg_851_1.nodeConfigList_ = {}

		arg_851_1:InitPlayNodeList()
	end,
	Play910201210 = function(arg_855_0, arg_855_1)
		arg_855_1.time_ = 0
		arg_855_1.frameCnt_ = 0
		arg_855_1.state_ = "playing"
		arg_855_1.curTalkId_ = 910201210
		arg_855_1.duration_ = 5

		SetActive(arg_855_1.tipsGo_, false)

		function arg_855_1.onSingleLineFinish_()
			arg_855_1.onSingleLineUpdate_ = nil
			arg_855_1.onSingleLineFinish_ = nil
			arg_855_1.state_ = "waiting"
		end

		function arg_855_1.playNext_(arg_857_0)
			if arg_857_0 == 1 then
				arg_855_0:Play910201211(arg_855_1)
			end
		end

		function arg_855_1.onSingleLineUpdate_(arg_858_0)
			local var_858_0 = 0
			local var_858_1 = 0.7

			if var_858_0 < arg_855_1.time_ and arg_855_1.time_ <= var_858_0 + arg_858_0 then
				arg_855_1.talkMaxDuration = 0
				arg_855_1.dialogCg_.alpha = 1

				arg_855_1.dialog_:SetActive(true)
				SetActive(arg_855_1.leftNameGo_, true)

				local var_858_2 = arg_855_1:FormatText(StoryNameCfg[13].name)

				arg_855_1.leftNameTxt_.text = var_858_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_855_1.leftNameTxt_.transform)

				arg_855_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_855_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_855_1:RecordName(arg_855_1.leftNameTxt_.text)
				SetActive(arg_855_1.iconTrs_.gameObject, false)
				arg_855_1.callingController_:SetSelectedState("normal")

				local var_858_3 = arg_855_1:GetWordFromCfg(910201210)
				local var_858_4 = arg_855_1:FormatText(var_858_3.content)

				arg_855_1.text_.text = var_858_4

				LuaForUtil.ClearLinePrefixSymbol(arg_855_1.text_)

				local var_858_5 = 28
				local var_858_6 = utf8.len(var_858_4)
				local var_858_7 = var_858_5 <= 0 and var_858_1 or var_858_1 * (var_858_6 / var_858_5)

				if var_858_7 > 0 and var_858_1 < var_858_7 then
					arg_855_1.talkMaxDuration = var_858_7

					if var_858_7 + var_858_0 > arg_855_1.duration_ then
						arg_855_1.duration_ = var_858_7 + var_858_0
					end
				end

				arg_855_1.text_.text = var_858_4
				arg_855_1.typewritter.percent = 0

				arg_855_1.typewritter:SetDirty()
				arg_855_1:ShowNextGo(false)
				arg_855_1:RecordContent(arg_855_1.text_.text)
			end

			local var_858_8 = math.max(var_858_1, arg_855_1.talkMaxDuration)

			if var_858_0 <= arg_855_1.time_ and arg_855_1.time_ < var_858_0 + var_858_8 then
				arg_855_1.typewritter.percent = (arg_855_1.time_ - var_858_0) / var_858_8

				arg_855_1.typewritter:SetDirty()
			end

			if arg_855_1.time_ >= var_858_0 + var_858_8 and arg_855_1.time_ < var_858_0 + var_858_8 + arg_858_0 then
				arg_855_1.typewritter.percent = 1

				arg_855_1.typewritter:SetDirty()
				arg_855_1:ShowNextGo(true)
			end
		end

		arg_855_1.nodeConfigList_ = {}

		arg_855_1:InitPlayNodeList()
	end,
	Play910201211 = function(arg_859_0, arg_859_1)
		arg_859_1.time_ = 0
		arg_859_1.frameCnt_ = 0
		arg_859_1.state_ = "playing"
		arg_859_1.curTalkId_ = 910201211
		arg_859_1.duration_ = 5

		SetActive(arg_859_1.tipsGo_, false)

		function arg_859_1.onSingleLineFinish_()
			arg_859_1.onSingleLineUpdate_ = nil
			arg_859_1.onSingleLineFinish_ = nil
			arg_859_1.state_ = "waiting"
		end

		function arg_859_1.playNext_(arg_861_0)
			if arg_861_0 == 1 then
				arg_859_0:Play910201212(arg_859_1)
			end
		end

		function arg_859_1.onSingleLineUpdate_(arg_862_0)
			local var_862_0 = 0
			local var_862_1 = 0.5

			if var_862_0 < arg_859_1.time_ and arg_859_1.time_ <= var_862_0 + arg_862_0 then
				arg_859_1.talkMaxDuration = 0
				arg_859_1.dialogCg_.alpha = 1

				arg_859_1.dialog_:SetActive(true)
				SetActive(arg_859_1.leftNameGo_, true)

				local var_862_2 = arg_859_1:FormatText(StoryNameCfg[8].name)

				arg_859_1.leftNameTxt_.text = var_862_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_859_1.leftNameTxt_.transform)

				arg_859_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_859_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_859_1:RecordName(arg_859_1.leftNameTxt_.text)
				SetActive(arg_859_1.iconTrs_.gameObject, false)
				arg_859_1.callingController_:SetSelectedState("normal")

				local var_862_3 = arg_859_1:GetWordFromCfg(910201211)
				local var_862_4 = arg_859_1:FormatText(var_862_3.content)

				arg_859_1.text_.text = var_862_4

				LuaForUtil.ClearLinePrefixSymbol(arg_859_1.text_)

				local var_862_5 = 21
				local var_862_6 = utf8.len(var_862_4)
				local var_862_7 = var_862_5 <= 0 and var_862_1 or var_862_1 * (var_862_6 / var_862_5)

				if var_862_7 > 0 and var_862_1 < var_862_7 then
					arg_859_1.talkMaxDuration = var_862_7

					if var_862_7 + var_862_0 > arg_859_1.duration_ then
						arg_859_1.duration_ = var_862_7 + var_862_0
					end
				end

				arg_859_1.text_.text = var_862_4
				arg_859_1.typewritter.percent = 0

				arg_859_1.typewritter:SetDirty()
				arg_859_1:ShowNextGo(false)
				arg_859_1:RecordContent(arg_859_1.text_.text)
			end

			local var_862_8 = math.max(var_862_1, arg_859_1.talkMaxDuration)

			if var_862_0 <= arg_859_1.time_ and arg_859_1.time_ < var_862_0 + var_862_8 then
				arg_859_1.typewritter.percent = (arg_859_1.time_ - var_862_0) / var_862_8

				arg_859_1.typewritter:SetDirty()
			end

			if arg_859_1.time_ >= var_862_0 + var_862_8 and arg_859_1.time_ < var_862_0 + var_862_8 + arg_862_0 then
				arg_859_1.typewritter.percent = 1

				arg_859_1.typewritter:SetDirty()
				arg_859_1:ShowNextGo(true)
			end
		end

		arg_859_1.nodeConfigList_ = {}

		arg_859_1:InitPlayNodeList()
	end,
	Play910201212 = function(arg_863_0, arg_863_1)
		arg_863_1.time_ = 0
		arg_863_1.frameCnt_ = 0
		arg_863_1.state_ = "playing"
		arg_863_1.curTalkId_ = 910201212
		arg_863_1.duration_ = 9

		SetActive(arg_863_1.tipsGo_, false)

		function arg_863_1.onSingleLineFinish_()
			arg_863_1.onSingleLineUpdate_ = nil
			arg_863_1.onSingleLineFinish_ = nil
			arg_863_1.state_ = "waiting"
		end

		function arg_863_1.playNext_(arg_865_0)
			if arg_865_0 == 1 then
				arg_863_0:Play910201213(arg_863_1)
			end
		end

		function arg_863_1.onSingleLineUpdate_(arg_866_0)
			local var_866_0 = arg_863_1.actors_["1039ui_story"].transform
			local var_866_1 = 3.8

			if var_866_1 < arg_863_1.time_ and arg_863_1.time_ <= var_866_1 + arg_866_0 then
				arg_863_1.var_.moveOldPos1039ui_story = var_866_0.localPosition
			end

			local var_866_2 = 0.001

			if var_866_1 <= arg_863_1.time_ and arg_863_1.time_ < var_866_1 + var_866_2 then
				local var_866_3 = (arg_863_1.time_ - var_866_1) / var_866_2
				local var_866_4 = Vector3.New(0, -1.01, -5.9)

				var_866_0.localPosition = Vector3.Lerp(arg_863_1.var_.moveOldPos1039ui_story, var_866_4, var_866_3)

				local var_866_5 = manager.ui.mainCamera.transform.position - var_866_0.position

				var_866_0.forward = Vector3.New(var_866_5.x, var_866_5.y, var_866_5.z)

				local var_866_6 = var_866_0.localEulerAngles

				var_866_6.z = 0
				var_866_6.x = 0
				var_866_0.localEulerAngles = var_866_6
			end

			if arg_863_1.time_ >= var_866_1 + var_866_2 and arg_863_1.time_ < var_866_1 + var_866_2 + arg_866_0 then
				var_866_0.localPosition = Vector3.New(0, -1.01, -5.9)

				local var_866_7 = manager.ui.mainCamera.transform.position - var_866_0.position

				var_866_0.forward = Vector3.New(var_866_7.x, var_866_7.y, var_866_7.z)

				local var_866_8 = var_866_0.localEulerAngles

				var_866_8.z = 0
				var_866_8.x = 0
				var_866_0.localEulerAngles = var_866_8
			end

			local var_866_9 = 3.8

			if var_866_9 < arg_863_1.time_ and arg_863_1.time_ <= var_866_9 + arg_866_0 then
				arg_863_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action2_1")
			end

			local var_866_10 = 3.8

			if var_866_10 < arg_863_1.time_ and arg_863_1.time_ <= var_866_10 + arg_866_0 then
				arg_863_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_866_11 = arg_863_1.actors_["1039ui_story"]
			local var_866_12 = 3.8

			if var_866_12 < arg_863_1.time_ and arg_863_1.time_ <= var_866_12 + arg_866_0 and not isNil(var_866_11) and arg_863_1.var_.characterEffect1039ui_story == nil then
				arg_863_1.var_.characterEffect1039ui_story = var_866_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_866_13 = 0.2

			if var_866_12 <= arg_863_1.time_ and arg_863_1.time_ < var_866_12 + var_866_13 and not isNil(var_866_11) then
				local var_866_14 = (arg_863_1.time_ - var_866_12) / var_866_13

				if arg_863_1.var_.characterEffect1039ui_story and not isNil(var_866_11) then
					arg_863_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_863_1.time_ >= var_866_12 + var_866_13 and arg_863_1.time_ < var_866_12 + var_866_13 + arg_866_0 and not isNil(var_866_11) and arg_863_1.var_.characterEffect1039ui_story then
				arg_863_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_866_15 = 0

			if var_866_15 < arg_863_1.time_ and arg_863_1.time_ <= var_866_15 + arg_866_0 then
				arg_863_1.mask_.enabled = true
				arg_863_1.mask_.raycastTarget = true

				arg_863_1:SetGaussion(false)
			end

			local var_866_16 = 2

			if var_866_15 <= arg_863_1.time_ and arg_863_1.time_ < var_866_15 + var_866_16 then
				local var_866_17 = (arg_863_1.time_ - var_866_15) / var_866_16
				local var_866_18 = Color.New(0, 0, 0)

				var_866_18.a = Mathf.Lerp(0, 1, var_866_17)
				arg_863_1.mask_.color = var_866_18
			end

			if arg_863_1.time_ >= var_866_15 + var_866_16 and arg_863_1.time_ < var_866_15 + var_866_16 + arg_866_0 then
				local var_866_19 = Color.New(0, 0, 0)

				var_866_19.a = 1
				arg_863_1.mask_.color = var_866_19
			end

			local var_866_20 = 2

			if var_866_20 < arg_863_1.time_ and arg_863_1.time_ <= var_866_20 + arg_866_0 then
				arg_863_1.mask_.enabled = true
				arg_863_1.mask_.raycastTarget = true

				arg_863_1:SetGaussion(false)
			end

			local var_866_21 = 2

			if var_866_20 <= arg_863_1.time_ and arg_863_1.time_ < var_866_20 + var_866_21 then
				local var_866_22 = (arg_863_1.time_ - var_866_20) / var_866_21
				local var_866_23 = Color.New(0, 0, 0)

				var_866_23.a = Mathf.Lerp(1, 0, var_866_22)
				arg_863_1.mask_.color = var_866_23
			end

			if arg_863_1.time_ >= var_866_20 + var_866_21 and arg_863_1.time_ < var_866_20 + var_866_21 + arg_866_0 then
				local var_866_24 = Color.New(0, 0, 0)
				local var_866_25 = 0

				arg_863_1.mask_.enabled = false
				var_866_24.a = var_866_25
				arg_863_1.mask_.color = var_866_24
			end

			local var_866_26 = 2

			if var_866_26 < arg_863_1.time_ and arg_863_1.time_ <= var_866_26 + arg_866_0 then
				local var_866_27 = manager.ui.mainCamera.transform.localPosition
				local var_866_28 = Vector3.New(0, 0, 10) + Vector3.New(var_866_27.x, var_866_27.y, 0)
				local var_866_29 = arg_863_1.bgs_.ST05

				var_866_29.transform.localPosition = var_866_28
				var_866_29.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_866_30 = var_866_29:GetComponent("SpriteRenderer")

				if var_866_30 and var_866_30.sprite then
					local var_866_31 = (var_866_29.transform.localPosition - var_866_27).z
					local var_866_32 = manager.ui.mainCameraCom_
					local var_866_33 = 2 * var_866_31 * Mathf.Tan(var_866_32.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_866_34 = var_866_33 * var_866_32.aspect
					local var_866_35 = var_866_30.sprite.bounds.size.x
					local var_866_36 = var_866_30.sprite.bounds.size.y
					local var_866_37 = var_866_34 / var_866_35
					local var_866_38 = var_866_33 / var_866_36
					local var_866_39 = var_866_38 < var_866_37 and var_866_37 or var_866_38

					var_866_29.transform.localScale = Vector3.New(var_866_39, var_866_39, 0)
				end

				for iter_866_0, iter_866_1 in pairs(arg_863_1.bgs_) do
					if iter_866_0 ~= "ST05" then
						iter_866_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_866_40 = 4
			local var_866_41 = 0.975

			if var_866_40 < arg_863_1.time_ and arg_863_1.time_ <= var_866_40 + arg_866_0 then
				arg_863_1.talkMaxDuration = 0
				arg_863_1.dialogCg_.alpha = 1

				arg_863_1.dialog_:SetActive(true)
				SetActive(arg_863_1.leftNameGo_, true)

				local var_866_42 = arg_863_1:FormatText(StoryNameCfg[9].name)

				arg_863_1.leftNameTxt_.text = var_866_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_863_1.leftNameTxt_.transform)

				arg_863_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_863_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_863_1:RecordName(arg_863_1.leftNameTxt_.text)
				SetActive(arg_863_1.iconTrs_.gameObject, false)
				arg_863_1.callingController_:SetSelectedState("normal")

				local var_866_43 = arg_863_1:GetWordFromCfg(910201212)
				local var_866_44 = arg_863_1:FormatText(var_866_43.content)

				arg_863_1.text_.text = var_866_44

				LuaForUtil.ClearLinePrefixSymbol(arg_863_1.text_)

				local var_866_45 = 39
				local var_866_46 = utf8.len(var_866_44)
				local var_866_47 = var_866_45 <= 0 and var_866_41 or var_866_41 * (var_866_46 / var_866_45)

				if var_866_47 > 0 and var_866_41 < var_866_47 then
					arg_863_1.talkMaxDuration = var_866_47

					if var_866_47 + var_866_40 > arg_863_1.duration_ then
						arg_863_1.duration_ = var_866_47 + var_866_40
					end
				end

				arg_863_1.text_.text = var_866_44
				arg_863_1.typewritter.percent = 0

				arg_863_1.typewritter:SetDirty()
				arg_863_1:ShowNextGo(false)
				arg_863_1:RecordContent(arg_863_1.text_.text)
			end

			local var_866_48 = math.max(var_866_41, arg_863_1.talkMaxDuration)

			if var_866_40 <= arg_863_1.time_ and arg_863_1.time_ < var_866_40 + var_866_48 then
				arg_863_1.typewritter.percent = (arg_863_1.time_ - var_866_40) / var_866_48

				arg_863_1.typewritter:SetDirty()
			end

			if arg_863_1.time_ >= var_866_40 + var_866_48 and arg_863_1.time_ < var_866_40 + var_866_48 + arg_866_0 then
				arg_863_1.typewritter.percent = 1

				arg_863_1.typewritter:SetDirty()
				arg_863_1:ShowNextGo(true)
			end
		end

		arg_863_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_863_1:InitPlayNodeList()
	end,
	Play910201213 = function(arg_867_0, arg_867_1)
		arg_867_1.time_ = 0
		arg_867_1.frameCnt_ = 0
		arg_867_1.state_ = "playing"
		arg_867_1.curTalkId_ = 910201213
		arg_867_1.duration_ = 5

		SetActive(arg_867_1.tipsGo_, false)

		function arg_867_1.onSingleLineFinish_()
			arg_867_1.onSingleLineUpdate_ = nil
			arg_867_1.onSingleLineFinish_ = nil
			arg_867_1.state_ = "waiting"
		end

		function arg_867_1.playNext_(arg_869_0)
			if arg_869_0 == 1 then
				arg_867_0:Play910201214(arg_867_1)
			end
		end

		function arg_867_1.onSingleLineUpdate_(arg_870_0)
			local var_870_0 = 0

			if var_870_0 < arg_867_1.time_ and arg_867_1.time_ <= var_870_0 + arg_870_0 then
				arg_867_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action425")
			end

			local var_870_1 = 0

			if var_870_1 < arg_867_1.time_ and arg_867_1.time_ <= var_870_1 + arg_870_0 then
				arg_867_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_870_2 = 0
			local var_870_3 = 0.575

			if var_870_2 < arg_867_1.time_ and arg_867_1.time_ <= var_870_2 + arg_870_0 then
				arg_867_1.talkMaxDuration = 0
				arg_867_1.dialogCg_.alpha = 1

				arg_867_1.dialog_:SetActive(true)
				SetActive(arg_867_1.leftNameGo_, true)

				local var_870_4 = arg_867_1:FormatText(StoryNameCfg[9].name)

				arg_867_1.leftNameTxt_.text = var_870_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_867_1.leftNameTxt_.transform)

				arg_867_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_867_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_867_1:RecordName(arg_867_1.leftNameTxt_.text)
				SetActive(arg_867_1.iconTrs_.gameObject, false)
				arg_867_1.callingController_:SetSelectedState("normal")

				local var_870_5 = arg_867_1:GetWordFromCfg(910201213)
				local var_870_6 = arg_867_1:FormatText(var_870_5.content)

				arg_867_1.text_.text = var_870_6

				LuaForUtil.ClearLinePrefixSymbol(arg_867_1.text_)

				local var_870_7 = 23
				local var_870_8 = utf8.len(var_870_6)
				local var_870_9 = var_870_7 <= 0 and var_870_3 or var_870_3 * (var_870_8 / var_870_7)

				if var_870_9 > 0 and var_870_3 < var_870_9 then
					arg_867_1.talkMaxDuration = var_870_9

					if var_870_9 + var_870_2 > arg_867_1.duration_ then
						arg_867_1.duration_ = var_870_9 + var_870_2
					end
				end

				arg_867_1.text_.text = var_870_6
				arg_867_1.typewritter.percent = 0

				arg_867_1.typewritter:SetDirty()
				arg_867_1:ShowNextGo(false)
				arg_867_1:RecordContent(arg_867_1.text_.text)
			end

			local var_870_10 = math.max(var_870_3, arg_867_1.talkMaxDuration)

			if var_870_2 <= arg_867_1.time_ and arg_867_1.time_ < var_870_2 + var_870_10 then
				arg_867_1.typewritter.percent = (arg_867_1.time_ - var_870_2) / var_870_10

				arg_867_1.typewritter:SetDirty()
			end

			if arg_867_1.time_ >= var_870_2 + var_870_10 and arg_867_1.time_ < var_870_2 + var_870_10 + arg_870_0 then
				arg_867_1.typewritter.percent = 1

				arg_867_1.typewritter:SetDirty()
				arg_867_1:ShowNextGo(true)
			end
		end

		arg_867_1.nodeConfigList_ = {}

		arg_867_1:InitPlayNodeList()
	end,
	Play910201214 = function(arg_871_0, arg_871_1)
		arg_871_1.time_ = 0
		arg_871_1.frameCnt_ = 0
		arg_871_1.state_ = "playing"
		arg_871_1.curTalkId_ = 910201214
		arg_871_1.duration_ = 5

		SetActive(arg_871_1.tipsGo_, false)

		function arg_871_1.onSingleLineFinish_()
			arg_871_1.onSingleLineUpdate_ = nil
			arg_871_1.onSingleLineFinish_ = nil
			arg_871_1.state_ = "waiting"
		end

		function arg_871_1.playNext_(arg_873_0)
			if arg_873_0 == 1 then
				arg_871_0:Play910201215(arg_871_1)
			end
		end

		function arg_871_1.onSingleLineUpdate_(arg_874_0)
			local var_874_0 = arg_871_1.actors_["1039ui_story"]
			local var_874_1 = 0

			if var_874_1 < arg_871_1.time_ and arg_871_1.time_ <= var_874_1 + arg_874_0 and not isNil(var_874_0) and arg_871_1.var_.characterEffect1039ui_story == nil then
				arg_871_1.var_.characterEffect1039ui_story = var_874_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_874_2 = 0.2

			if var_874_1 <= arg_871_1.time_ and arg_871_1.time_ < var_874_1 + var_874_2 and not isNil(var_874_0) then
				local var_874_3 = (arg_871_1.time_ - var_874_1) / var_874_2

				if arg_871_1.var_.characterEffect1039ui_story and not isNil(var_874_0) then
					local var_874_4 = Mathf.Lerp(0, 0.5, var_874_3)

					arg_871_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_871_1.var_.characterEffect1039ui_story.fillRatio = var_874_4
				end
			end

			if arg_871_1.time_ >= var_874_1 + var_874_2 and arg_871_1.time_ < var_874_1 + var_874_2 + arg_874_0 and not isNil(var_874_0) and arg_871_1.var_.characterEffect1039ui_story then
				local var_874_5 = 0.5

				arg_871_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_871_1.var_.characterEffect1039ui_story.fillRatio = var_874_5
			end

			local var_874_6 = 0
			local var_874_7 = 0.35

			if var_874_6 < arg_871_1.time_ and arg_871_1.time_ <= var_874_6 + arg_874_0 then
				arg_871_1.talkMaxDuration = 0
				arg_871_1.dialogCg_.alpha = 1

				arg_871_1.dialog_:SetActive(true)
				SetActive(arg_871_1.leftNameGo_, true)

				local var_874_8 = arg_871_1:FormatText(StoryNameCfg[7].name)

				arg_871_1.leftNameTxt_.text = var_874_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_871_1.leftNameTxt_.transform)

				arg_871_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_871_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_871_1:RecordName(arg_871_1.leftNameTxt_.text)
				SetActive(arg_871_1.iconTrs_.gameObject, true)
				arg_871_1.iconController_:SetSelectedState("hero")

				arg_871_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_871_1.callingController_:SetSelectedState("normal")

				arg_871_1.keyicon_.color = Color.New(1, 1, 1)
				arg_871_1.icon_.color = Color.New(1, 1, 1)

				local var_874_9 = arg_871_1:GetWordFromCfg(910201214)
				local var_874_10 = arg_871_1:FormatText(var_874_9.content)

				arg_871_1.text_.text = var_874_10

				LuaForUtil.ClearLinePrefixSymbol(arg_871_1.text_)

				local var_874_11 = 14
				local var_874_12 = utf8.len(var_874_10)
				local var_874_13 = var_874_11 <= 0 and var_874_7 or var_874_7 * (var_874_12 / var_874_11)

				if var_874_13 > 0 and var_874_7 < var_874_13 then
					arg_871_1.talkMaxDuration = var_874_13

					if var_874_13 + var_874_6 > arg_871_1.duration_ then
						arg_871_1.duration_ = var_874_13 + var_874_6
					end
				end

				arg_871_1.text_.text = var_874_10
				arg_871_1.typewritter.percent = 0

				arg_871_1.typewritter:SetDirty()
				arg_871_1:ShowNextGo(false)
				arg_871_1:RecordContent(arg_871_1.text_.text)
			end

			local var_874_14 = math.max(var_874_7, arg_871_1.talkMaxDuration)

			if var_874_6 <= arg_871_1.time_ and arg_871_1.time_ < var_874_6 + var_874_14 then
				arg_871_1.typewritter.percent = (arg_871_1.time_ - var_874_6) / var_874_14

				arg_871_1.typewritter:SetDirty()
			end

			if arg_871_1.time_ >= var_874_6 + var_874_14 and arg_871_1.time_ < var_874_6 + var_874_14 + arg_874_0 then
				arg_871_1.typewritter.percent = 1

				arg_871_1.typewritter:SetDirty()
				arg_871_1:ShowNextGo(true)
			end
		end

		arg_871_1.nodeConfigList_ = {}

		arg_871_1:InitPlayNodeList()
	end,
	Play910201215 = function(arg_875_0, arg_875_1)
		arg_875_1.time_ = 0
		arg_875_1.frameCnt_ = 0
		arg_875_1.state_ = "playing"
		arg_875_1.curTalkId_ = 910201215
		arg_875_1.duration_ = 5

		SetActive(arg_875_1.tipsGo_, false)

		function arg_875_1.onSingleLineFinish_()
			arg_875_1.onSingleLineUpdate_ = nil
			arg_875_1.onSingleLineFinish_ = nil
			arg_875_1.state_ = "waiting"
		end

		function arg_875_1.playNext_(arg_877_0)
			if arg_877_0 == 1 then
				arg_875_0:Play910201216(arg_875_1)
			end
		end

		function arg_875_1.onSingleLineUpdate_(arg_878_0)
			local var_878_0 = arg_875_1.actors_["1039ui_story"]
			local var_878_1 = 0

			if var_878_1 < arg_875_1.time_ and arg_875_1.time_ <= var_878_1 + arg_878_0 and not isNil(var_878_0) and arg_875_1.var_.characterEffect1039ui_story == nil then
				arg_875_1.var_.characterEffect1039ui_story = var_878_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_878_2 = 0.2

			if var_878_1 <= arg_875_1.time_ and arg_875_1.time_ < var_878_1 + var_878_2 and not isNil(var_878_0) then
				local var_878_3 = (arg_875_1.time_ - var_878_1) / var_878_2

				if arg_875_1.var_.characterEffect1039ui_story and not isNil(var_878_0) then
					arg_875_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_875_1.time_ >= var_878_1 + var_878_2 and arg_875_1.time_ < var_878_1 + var_878_2 + arg_878_0 and not isNil(var_878_0) and arg_875_1.var_.characterEffect1039ui_story then
				arg_875_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			local var_878_4 = 0

			if var_878_4 < arg_875_1.time_ and arg_875_1.time_ <= var_878_4 + arg_878_0 then
				arg_875_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039actionlink/1039action454")
			end

			local var_878_5 = 0

			if var_878_5 < arg_875_1.time_ and arg_875_1.time_ <= var_878_5 + arg_878_0 then
				arg_875_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_878_6 = 0
			local var_878_7 = 0.25

			if var_878_6 < arg_875_1.time_ and arg_875_1.time_ <= var_878_6 + arg_878_0 then
				arg_875_1.talkMaxDuration = 0
				arg_875_1.dialogCg_.alpha = 1

				arg_875_1.dialog_:SetActive(true)
				SetActive(arg_875_1.leftNameGo_, true)

				local var_878_8 = arg_875_1:FormatText(StoryNameCfg[9].name)

				arg_875_1.leftNameTxt_.text = var_878_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_875_1.leftNameTxt_.transform)

				arg_875_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_875_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_875_1:RecordName(arg_875_1.leftNameTxt_.text)
				SetActive(arg_875_1.iconTrs_.gameObject, false)
				arg_875_1.callingController_:SetSelectedState("normal")

				local var_878_9 = arg_875_1:GetWordFromCfg(910201215)
				local var_878_10 = arg_875_1:FormatText(var_878_9.content)

				arg_875_1.text_.text = var_878_10

				LuaForUtil.ClearLinePrefixSymbol(arg_875_1.text_)

				local var_878_11 = 10
				local var_878_12 = utf8.len(var_878_10)
				local var_878_13 = var_878_11 <= 0 and var_878_7 or var_878_7 * (var_878_12 / var_878_11)

				if var_878_13 > 0 and var_878_7 < var_878_13 then
					arg_875_1.talkMaxDuration = var_878_13

					if var_878_13 + var_878_6 > arg_875_1.duration_ then
						arg_875_1.duration_ = var_878_13 + var_878_6
					end
				end

				arg_875_1.text_.text = var_878_10
				arg_875_1.typewritter.percent = 0

				arg_875_1.typewritter:SetDirty()
				arg_875_1:ShowNextGo(false)
				arg_875_1:RecordContent(arg_875_1.text_.text)
			end

			local var_878_14 = math.max(var_878_7, arg_875_1.talkMaxDuration)

			if var_878_6 <= arg_875_1.time_ and arg_875_1.time_ < var_878_6 + var_878_14 then
				arg_875_1.typewritter.percent = (arg_875_1.time_ - var_878_6) / var_878_14

				arg_875_1.typewritter:SetDirty()
			end

			if arg_875_1.time_ >= var_878_6 + var_878_14 and arg_875_1.time_ < var_878_6 + var_878_14 + arg_878_0 then
				arg_875_1.typewritter.percent = 1

				arg_875_1.typewritter:SetDirty()
				arg_875_1:ShowNextGo(true)
			end
		end

		arg_875_1.nodeConfigList_ = {}

		arg_875_1:InitPlayNodeList()
	end,
	Play910201216 = function(arg_879_0, arg_879_1)
		arg_879_1.time_ = 0
		arg_879_1.frameCnt_ = 0
		arg_879_1.state_ = "playing"
		arg_879_1.curTalkId_ = 910201216
		arg_879_1.duration_ = 5

		SetActive(arg_879_1.tipsGo_, false)

		function arg_879_1.onSingleLineFinish_()
			arg_879_1.onSingleLineUpdate_ = nil
			arg_879_1.onSingleLineFinish_ = nil
			arg_879_1.state_ = "waiting"
		end

		function arg_879_1.playNext_(arg_881_0)
			if arg_881_0 == 1 then
				arg_879_0:Play910201217(arg_879_1)
			end
		end

		function arg_879_1.onSingleLineUpdate_(arg_882_0)
			local var_882_0 = arg_879_1.actors_["1084ui_story"].transform
			local var_882_1 = 0

			if var_882_1 < arg_879_1.time_ and arg_879_1.time_ <= var_882_1 + arg_882_0 then
				arg_879_1.var_.moveOldPos1084ui_story = var_882_0.localPosition
			end

			local var_882_2 = 0.001

			if var_882_1 <= arg_879_1.time_ and arg_879_1.time_ < var_882_1 + var_882_2 then
				local var_882_3 = (arg_879_1.time_ - var_882_1) / var_882_2
				local var_882_4 = Vector3.New(0, -0.97, -6)

				var_882_0.localPosition = Vector3.Lerp(arg_879_1.var_.moveOldPos1084ui_story, var_882_4, var_882_3)

				local var_882_5 = manager.ui.mainCamera.transform.position - var_882_0.position

				var_882_0.forward = Vector3.New(var_882_5.x, var_882_5.y, var_882_5.z)

				local var_882_6 = var_882_0.localEulerAngles

				var_882_6.z = 0
				var_882_6.x = 0
				var_882_0.localEulerAngles = var_882_6
			end

			if arg_879_1.time_ >= var_882_1 + var_882_2 and arg_879_1.time_ < var_882_1 + var_882_2 + arg_882_0 then
				var_882_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_882_7 = manager.ui.mainCamera.transform.position - var_882_0.position

				var_882_0.forward = Vector3.New(var_882_7.x, var_882_7.y, var_882_7.z)

				local var_882_8 = var_882_0.localEulerAngles

				var_882_8.z = 0
				var_882_8.x = 0
				var_882_0.localEulerAngles = var_882_8
			end

			local var_882_9 = arg_879_1.actors_["1039ui_story"].transform
			local var_882_10 = 0

			if var_882_10 < arg_879_1.time_ and arg_879_1.time_ <= var_882_10 + arg_882_0 then
				arg_879_1.var_.moveOldPos1039ui_story = var_882_9.localPosition
			end

			local var_882_11 = 0.001

			if var_882_10 <= arg_879_1.time_ and arg_879_1.time_ < var_882_10 + var_882_11 then
				local var_882_12 = (arg_879_1.time_ - var_882_10) / var_882_11
				local var_882_13 = Vector3.New(0, 100, 0)

				var_882_9.localPosition = Vector3.Lerp(arg_879_1.var_.moveOldPos1039ui_story, var_882_13, var_882_12)

				local var_882_14 = manager.ui.mainCamera.transform.position - var_882_9.position

				var_882_9.forward = Vector3.New(var_882_14.x, var_882_14.y, var_882_14.z)

				local var_882_15 = var_882_9.localEulerAngles

				var_882_15.z = 0
				var_882_15.x = 0
				var_882_9.localEulerAngles = var_882_15
			end

			if arg_879_1.time_ >= var_882_10 + var_882_11 and arg_879_1.time_ < var_882_10 + var_882_11 + arg_882_0 then
				var_882_9.localPosition = Vector3.New(0, 100, 0)

				local var_882_16 = manager.ui.mainCamera.transform.position - var_882_9.position

				var_882_9.forward = Vector3.New(var_882_16.x, var_882_16.y, var_882_16.z)

				local var_882_17 = var_882_9.localEulerAngles

				var_882_17.z = 0
				var_882_17.x = 0
				var_882_9.localEulerAngles = var_882_17
			end

			local var_882_18 = 0

			if var_882_18 < arg_879_1.time_ and arg_879_1.time_ <= var_882_18 + arg_882_0 then
				arg_879_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_882_19 = arg_879_1.actors_["1084ui_story"]
			local var_882_20 = 0

			if var_882_20 < arg_879_1.time_ and arg_879_1.time_ <= var_882_20 + arg_882_0 and not isNil(var_882_19) and arg_879_1.var_.characterEffect1084ui_story == nil then
				arg_879_1.var_.characterEffect1084ui_story = var_882_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_882_21 = 0.2

			if var_882_20 <= arg_879_1.time_ and arg_879_1.time_ < var_882_20 + var_882_21 and not isNil(var_882_19) then
				local var_882_22 = (arg_879_1.time_ - var_882_20) / var_882_21

				if arg_879_1.var_.characterEffect1084ui_story and not isNil(var_882_19) then
					arg_879_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_879_1.time_ >= var_882_20 + var_882_21 and arg_879_1.time_ < var_882_20 + var_882_21 + arg_882_0 and not isNil(var_882_19) and arg_879_1.var_.characterEffect1084ui_story then
				arg_879_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_882_23 = 0

			if var_882_23 < arg_879_1.time_ and arg_879_1.time_ <= var_882_23 + arg_882_0 then
				arg_879_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_882_24 = 0
			local var_882_25 = 0.8

			if var_882_24 < arg_879_1.time_ and arg_879_1.time_ <= var_882_24 + arg_882_0 then
				arg_879_1.talkMaxDuration = 0
				arg_879_1.dialogCg_.alpha = 1

				arg_879_1.dialog_:SetActive(true)
				SetActive(arg_879_1.leftNameGo_, true)

				local var_882_26 = arg_879_1:FormatText(StoryNameCfg[6].name)

				arg_879_1.leftNameTxt_.text = var_882_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_879_1.leftNameTxt_.transform)

				arg_879_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_879_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_879_1:RecordName(arg_879_1.leftNameTxt_.text)
				SetActive(arg_879_1.iconTrs_.gameObject, false)
				arg_879_1.callingController_:SetSelectedState("normal")

				local var_882_27 = arg_879_1:GetWordFromCfg(910201216)
				local var_882_28 = arg_879_1:FormatText(var_882_27.content)

				arg_879_1.text_.text = var_882_28

				LuaForUtil.ClearLinePrefixSymbol(arg_879_1.text_)

				local var_882_29 = 32
				local var_882_30 = utf8.len(var_882_28)
				local var_882_31 = var_882_29 <= 0 and var_882_25 or var_882_25 * (var_882_30 / var_882_29)

				if var_882_31 > 0 and var_882_25 < var_882_31 then
					arg_879_1.talkMaxDuration = var_882_31

					if var_882_31 + var_882_24 > arg_879_1.duration_ then
						arg_879_1.duration_ = var_882_31 + var_882_24
					end
				end

				arg_879_1.text_.text = var_882_28
				arg_879_1.typewritter.percent = 0

				arg_879_1.typewritter:SetDirty()
				arg_879_1:ShowNextGo(false)
				arg_879_1:RecordContent(arg_879_1.text_.text)
			end

			local var_882_32 = math.max(var_882_25, arg_879_1.talkMaxDuration)

			if var_882_24 <= arg_879_1.time_ and arg_879_1.time_ < var_882_24 + var_882_32 then
				arg_879_1.typewritter.percent = (arg_879_1.time_ - var_882_24) / var_882_32

				arg_879_1.typewritter:SetDirty()
			end

			if arg_879_1.time_ >= var_882_24 + var_882_32 and arg_879_1.time_ < var_882_24 + var_882_32 + arg_882_0 then
				arg_879_1.typewritter.percent = 1

				arg_879_1.typewritter:SetDirty()
				arg_879_1:ShowNextGo(true)
			end
		end

		arg_879_1.nodeConfigList_ = {
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
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_879_1:InitPlayNodeList()
	end,
	Play910201217 = function(arg_883_0, arg_883_1)
		arg_883_1.time_ = 0
		arg_883_1.frameCnt_ = 0
		arg_883_1.state_ = "playing"
		arg_883_1.curTalkId_ = 910201217
		arg_883_1.duration_ = 0.2

		SetActive(arg_883_1.tipsGo_, false)

		function arg_883_1.onSingleLineFinish_()
			arg_883_1.onSingleLineUpdate_ = nil
			arg_883_1.onSingleLineFinish_ = nil
			arg_883_1.state_ = "waiting"

			SetActive(arg_883_1.choicesGo_, true)

			for iter_884_0, iter_884_1 in ipairs(arg_883_1.choices_) do
				local var_884_0 = iter_884_0 <= 2

				SetActive(iter_884_1.go, var_884_0)
			end

			arg_883_1.choices_[1].txt.text = arg_883_1:FormatText(StoryChoiceCfg[250].name)
			arg_883_1.choices_[2].txt.text = arg_883_1:FormatText(StoryChoiceCfg[251].name)
		end

		function arg_883_1.playNext_(arg_885_0)
			if arg_885_0 == 1 then
				arg_883_0:Play910201218(arg_883_1)
			end

			if arg_885_0 == 2 then
				arg_883_0:Play910201218(arg_883_1)
			end

			arg_883_1:RecordChoiceLog(910201217, 250, 251)
		end

		function arg_883_1.onSingleLineUpdate_(arg_886_0)
			local var_886_0 = arg_883_1.actors_["1084ui_story"]
			local var_886_1 = 0

			if var_886_1 < arg_883_1.time_ and arg_883_1.time_ <= var_886_1 + arg_886_0 and not isNil(var_886_0) and arg_883_1.var_.characterEffect1084ui_story == nil then
				arg_883_1.var_.characterEffect1084ui_story = var_886_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_886_2 = 0.2

			if var_886_1 <= arg_883_1.time_ and arg_883_1.time_ < var_886_1 + var_886_2 and not isNil(var_886_0) then
				local var_886_3 = (arg_883_1.time_ - var_886_1) / var_886_2

				if arg_883_1.var_.characterEffect1084ui_story and not isNil(var_886_0) then
					local var_886_4 = Mathf.Lerp(0, 0.5, var_886_3)

					arg_883_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_883_1.var_.characterEffect1084ui_story.fillRatio = var_886_4
				end
			end

			if arg_883_1.time_ >= var_886_1 + var_886_2 and arg_883_1.time_ < var_886_1 + var_886_2 + arg_886_0 and not isNil(var_886_0) and arg_883_1.var_.characterEffect1084ui_story then
				local var_886_5 = 0.5

				arg_883_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_883_1.var_.characterEffect1084ui_story.fillRatio = var_886_5
			end
		end

		arg_883_1.nodeConfigList_ = {}

		arg_883_1:InitPlayNodeList()
	end,
	Play910201218 = function(arg_887_0, arg_887_1)
		arg_887_1.time_ = 0
		arg_887_1.frameCnt_ = 0
		arg_887_1.state_ = "playing"
		arg_887_1.curTalkId_ = 910201218
		arg_887_1.duration_ = 5

		SetActive(arg_887_1.tipsGo_, false)

		function arg_887_1.onSingleLineFinish_()
			arg_887_1.onSingleLineUpdate_ = nil
			arg_887_1.onSingleLineFinish_ = nil
			arg_887_1.state_ = "waiting"
		end

		function arg_887_1.playNext_(arg_889_0)
			if arg_889_0 == 1 then
				arg_887_0:Play910201219(arg_887_1)
			end
		end

		function arg_887_1.onSingleLineUpdate_(arg_890_0)
			local var_890_0 = "1084ui_story"

			if arg_887_1.actors_[var_890_0] == nil then
				local var_890_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_890_1) then
					local var_890_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_887_1.stage_.transform)

					var_890_2.name = var_890_0
					var_890_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_887_1.actors_[var_890_0] = var_890_2

					local var_890_3 = var_890_2:GetComponentInChildren(typeof(CharacterEffect))

					var_890_3.enabled = true

					local var_890_4 = GameObjectTools.GetOrAddComponent(var_890_2, typeof(DynamicBoneHelper))

					if var_890_4 then
						var_890_4:EnableDynamicBone(false)
					end

					arg_887_1:ShowWeapon(var_890_3.transform, false)

					arg_887_1.var_[var_890_0 .. "Animator"] = var_890_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_887_1.var_[var_890_0 .. "Animator"].applyRootMotion = true
					arg_887_1.var_[var_890_0 .. "LipSync"] = var_890_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_890_5 = 0

			if var_890_5 < arg_887_1.time_ and arg_887_1.time_ <= var_890_5 + arg_890_0 then
				arg_887_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_890_6 = 0
			local var_890_7 = 0.95

			if var_890_6 < arg_887_1.time_ and arg_887_1.time_ <= var_890_6 + arg_890_0 then
				arg_887_1.talkMaxDuration = 0
				arg_887_1.dialogCg_.alpha = 1

				arg_887_1.dialog_:SetActive(true)
				SetActive(arg_887_1.leftNameGo_, true)

				local var_890_8 = arg_887_1:FormatText(StoryNameCfg[7].name)

				arg_887_1.leftNameTxt_.text = var_890_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_887_1.leftNameTxt_.transform)

				arg_887_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_887_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_887_1:RecordName(arg_887_1.leftNameTxt_.text)
				SetActive(arg_887_1.iconTrs_.gameObject, true)
				arg_887_1.iconController_:SetSelectedState("hero")

				arg_887_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_887_1.callingController_:SetSelectedState("normal")

				arg_887_1.keyicon_.color = Color.New(1, 1, 1)
				arg_887_1.icon_.color = Color.New(1, 1, 1)

				local var_890_9 = arg_887_1:GetWordFromCfg(910201218)
				local var_890_10 = arg_887_1:FormatText(var_890_9.content)

				arg_887_1.text_.text = var_890_10

				LuaForUtil.ClearLinePrefixSymbol(arg_887_1.text_)

				local var_890_11 = 38
				local var_890_12 = utf8.len(var_890_10)
				local var_890_13 = var_890_11 <= 0 and var_890_7 or var_890_7 * (var_890_12 / var_890_11)

				if var_890_13 > 0 and var_890_7 < var_890_13 then
					arg_887_1.talkMaxDuration = var_890_13

					if var_890_13 + var_890_6 > arg_887_1.duration_ then
						arg_887_1.duration_ = var_890_13 + var_890_6
					end
				end

				arg_887_1.text_.text = var_890_10
				arg_887_1.typewritter.percent = 0

				arg_887_1.typewritter:SetDirty()
				arg_887_1:ShowNextGo(false)
				arg_887_1:RecordContent(arg_887_1.text_.text)
			end

			local var_890_14 = math.max(var_890_7, arg_887_1.talkMaxDuration)

			if var_890_6 <= arg_887_1.time_ and arg_887_1.time_ < var_890_6 + var_890_14 then
				arg_887_1.typewritter.percent = (arg_887_1.time_ - var_890_6) / var_890_14

				arg_887_1.typewritter:SetDirty()
			end

			if arg_887_1.time_ >= var_890_6 + var_890_14 and arg_887_1.time_ < var_890_6 + var_890_14 + arg_890_0 then
				arg_887_1.typewritter.percent = 1

				arg_887_1.typewritter:SetDirty()
				arg_887_1:ShowNextGo(true)
			end
		end

		arg_887_1.nodeConfigList_ = {}

		arg_887_1:InitPlayNodeList()
	end,
	Play910201219 = function(arg_891_0, arg_891_1)
		arg_891_1.time_ = 0
		arg_891_1.frameCnt_ = 0
		arg_891_1.state_ = "playing"
		arg_891_1.curTalkId_ = 910201219
		arg_891_1.duration_ = 5

		SetActive(arg_891_1.tipsGo_, false)

		function arg_891_1.onSingleLineFinish_()
			arg_891_1.onSingleLineUpdate_ = nil
			arg_891_1.onSingleLineFinish_ = nil
			arg_891_1.state_ = "waiting"
		end

		function arg_891_1.playNext_(arg_893_0)
			if arg_893_0 == 1 then
				arg_891_0:Play910201220(arg_891_1)
			end
		end

		function arg_891_1.onSingleLineUpdate_(arg_894_0)
			local var_894_0 = 0
			local var_894_1 = 0.875

			if var_894_0 < arg_891_1.time_ and arg_891_1.time_ <= var_894_0 + arg_894_0 then
				arg_891_1.talkMaxDuration = 0
				arg_891_1.dialogCg_.alpha = 1

				arg_891_1.dialog_:SetActive(true)
				SetActive(arg_891_1.leftNameGo_, true)

				local var_894_2 = arg_891_1:FormatText(StoryNameCfg[7].name)

				arg_891_1.leftNameTxt_.text = var_894_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_891_1.leftNameTxt_.transform)

				arg_891_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_891_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_891_1:RecordName(arg_891_1.leftNameTxt_.text)
				SetActive(arg_891_1.iconTrs_.gameObject, true)
				arg_891_1.iconController_:SetSelectedState("hero")

				arg_891_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_891_1.callingController_:SetSelectedState("normal")

				arg_891_1.keyicon_.color = Color.New(1, 1, 1)
				arg_891_1.icon_.color = Color.New(1, 1, 1)

				local var_894_3 = arg_891_1:GetWordFromCfg(910201219)
				local var_894_4 = arg_891_1:FormatText(var_894_3.content)

				arg_891_1.text_.text = var_894_4

				LuaForUtil.ClearLinePrefixSymbol(arg_891_1.text_)

				local var_894_5 = 35
				local var_894_6 = utf8.len(var_894_4)
				local var_894_7 = var_894_5 <= 0 and var_894_1 or var_894_1 * (var_894_6 / var_894_5)

				if var_894_7 > 0 and var_894_1 < var_894_7 then
					arg_891_1.talkMaxDuration = var_894_7

					if var_894_7 + var_894_0 > arg_891_1.duration_ then
						arg_891_1.duration_ = var_894_7 + var_894_0
					end
				end

				arg_891_1.text_.text = var_894_4
				arg_891_1.typewritter.percent = 0

				arg_891_1.typewritter:SetDirty()
				arg_891_1:ShowNextGo(false)
				arg_891_1:RecordContent(arg_891_1.text_.text)
			end

			local var_894_8 = math.max(var_894_1, arg_891_1.talkMaxDuration)

			if var_894_0 <= arg_891_1.time_ and arg_891_1.time_ < var_894_0 + var_894_8 then
				arg_891_1.typewritter.percent = (arg_891_1.time_ - var_894_0) / var_894_8

				arg_891_1.typewritter:SetDirty()
			end

			if arg_891_1.time_ >= var_894_0 + var_894_8 and arg_891_1.time_ < var_894_0 + var_894_8 + arg_894_0 then
				arg_891_1.typewritter.percent = 1

				arg_891_1.typewritter:SetDirty()
				arg_891_1:ShowNextGo(true)
			end
		end

		arg_891_1.nodeConfigList_ = {}

		arg_891_1:InitPlayNodeList()
	end,
	Play910201220 = function(arg_895_0, arg_895_1)
		arg_895_1.time_ = 0
		arg_895_1.frameCnt_ = 0
		arg_895_1.state_ = "playing"
		arg_895_1.curTalkId_ = 910201220
		arg_895_1.duration_ = 5

		SetActive(arg_895_1.tipsGo_, false)

		function arg_895_1.onSingleLineFinish_()
			arg_895_1.onSingleLineUpdate_ = nil
			arg_895_1.onSingleLineFinish_ = nil
			arg_895_1.state_ = "waiting"
		end

		function arg_895_1.playNext_(arg_897_0)
			if arg_897_0 == 1 then
				arg_895_0:Play910201221(arg_895_1)
			end
		end

		function arg_895_1.onSingleLineUpdate_(arg_898_0)
			local var_898_0 = 0
			local var_898_1 = 0.8

			if var_898_0 < arg_895_1.time_ and arg_895_1.time_ <= var_898_0 + arg_898_0 then
				arg_895_1.talkMaxDuration = 0
				arg_895_1.dialogCg_.alpha = 1

				arg_895_1.dialog_:SetActive(true)
				SetActive(arg_895_1.leftNameGo_, true)

				local var_898_2 = arg_895_1:FormatText(StoryNameCfg[7].name)

				arg_895_1.leftNameTxt_.text = var_898_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_895_1.leftNameTxt_.transform)

				arg_895_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_895_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_895_1:RecordName(arg_895_1.leftNameTxt_.text)
				SetActive(arg_895_1.iconTrs_.gameObject, true)
				arg_895_1.iconController_:SetSelectedState("hero")

				arg_895_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_895_1.callingController_:SetSelectedState("normal")

				arg_895_1.keyicon_.color = Color.New(1, 1, 1)
				arg_895_1.icon_.color = Color.New(1, 1, 1)

				local var_898_3 = arg_895_1:GetWordFromCfg(910201220)
				local var_898_4 = arg_895_1:FormatText(var_898_3.content)

				arg_895_1.text_.text = var_898_4

				LuaForUtil.ClearLinePrefixSymbol(arg_895_1.text_)

				local var_898_5 = 32
				local var_898_6 = utf8.len(var_898_4)
				local var_898_7 = var_898_5 <= 0 and var_898_1 or var_898_1 * (var_898_6 / var_898_5)

				if var_898_7 > 0 and var_898_1 < var_898_7 then
					arg_895_1.talkMaxDuration = var_898_7

					if var_898_7 + var_898_0 > arg_895_1.duration_ then
						arg_895_1.duration_ = var_898_7 + var_898_0
					end
				end

				arg_895_1.text_.text = var_898_4
				arg_895_1.typewritter.percent = 0

				arg_895_1.typewritter:SetDirty()
				arg_895_1:ShowNextGo(false)
				arg_895_1:RecordContent(arg_895_1.text_.text)
			end

			local var_898_8 = math.max(var_898_1, arg_895_1.talkMaxDuration)

			if var_898_0 <= arg_895_1.time_ and arg_895_1.time_ < var_898_0 + var_898_8 then
				arg_895_1.typewritter.percent = (arg_895_1.time_ - var_898_0) / var_898_8

				arg_895_1.typewritter:SetDirty()
			end

			if arg_895_1.time_ >= var_898_0 + var_898_8 and arg_895_1.time_ < var_898_0 + var_898_8 + arg_898_0 then
				arg_895_1.typewritter.percent = 1

				arg_895_1.typewritter:SetDirty()
				arg_895_1:ShowNextGo(true)
			end
		end

		arg_895_1.nodeConfigList_ = {}

		arg_895_1:InitPlayNodeList()
	end,
	Play910201221 = function(arg_899_0, arg_899_1)
		arg_899_1.time_ = 0
		arg_899_1.frameCnt_ = 0
		arg_899_1.state_ = "playing"
		arg_899_1.curTalkId_ = 910201221
		arg_899_1.duration_ = 5

		SetActive(arg_899_1.tipsGo_, false)

		function arg_899_1.onSingleLineFinish_()
			arg_899_1.onSingleLineUpdate_ = nil
			arg_899_1.onSingleLineFinish_ = nil
			arg_899_1.state_ = "waiting"
		end

		function arg_899_1.playNext_(arg_901_0)
			if arg_901_0 == 1 then
				arg_899_0:Play910201222(arg_899_1)
			end
		end

		function arg_899_1.onSingleLineUpdate_(arg_902_0)
			local var_902_0 = 0
			local var_902_1 = 0.425

			if var_902_0 < arg_899_1.time_ and arg_899_1.time_ <= var_902_0 + arg_902_0 then
				arg_899_1.talkMaxDuration = 0
				arg_899_1.dialogCg_.alpha = 1

				arg_899_1.dialog_:SetActive(true)
				SetActive(arg_899_1.leftNameGo_, true)

				local var_902_2 = arg_899_1:FormatText(StoryNameCfg[7].name)

				arg_899_1.leftNameTxt_.text = var_902_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_899_1.leftNameTxt_.transform)

				arg_899_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_899_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_899_1:RecordName(arg_899_1.leftNameTxt_.text)
				SetActive(arg_899_1.iconTrs_.gameObject, true)
				arg_899_1.iconController_:SetSelectedState("hero")

				arg_899_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_899_1.callingController_:SetSelectedState("normal")

				arg_899_1.keyicon_.color = Color.New(1, 1, 1)
				arg_899_1.icon_.color = Color.New(1, 1, 1)

				local var_902_3 = arg_899_1:GetWordFromCfg(910201221)
				local var_902_4 = arg_899_1:FormatText(var_902_3.content)

				arg_899_1.text_.text = var_902_4

				LuaForUtil.ClearLinePrefixSymbol(arg_899_1.text_)

				local var_902_5 = 17
				local var_902_6 = utf8.len(var_902_4)
				local var_902_7 = var_902_5 <= 0 and var_902_1 or var_902_1 * (var_902_6 / var_902_5)

				if var_902_7 > 0 and var_902_1 < var_902_7 then
					arg_899_1.talkMaxDuration = var_902_7

					if var_902_7 + var_902_0 > arg_899_1.duration_ then
						arg_899_1.duration_ = var_902_7 + var_902_0
					end
				end

				arg_899_1.text_.text = var_902_4
				arg_899_1.typewritter.percent = 0

				arg_899_1.typewritter:SetDirty()
				arg_899_1:ShowNextGo(false)
				arg_899_1:RecordContent(arg_899_1.text_.text)
			end

			local var_902_8 = math.max(var_902_1, arg_899_1.talkMaxDuration)

			if var_902_0 <= arg_899_1.time_ and arg_899_1.time_ < var_902_0 + var_902_8 then
				arg_899_1.typewritter.percent = (arg_899_1.time_ - var_902_0) / var_902_8

				arg_899_1.typewritter:SetDirty()
			end

			if arg_899_1.time_ >= var_902_0 + var_902_8 and arg_899_1.time_ < var_902_0 + var_902_8 + arg_902_0 then
				arg_899_1.typewritter.percent = 1

				arg_899_1.typewritter:SetDirty()
				arg_899_1:ShowNextGo(true)
			end
		end

		arg_899_1.nodeConfigList_ = {}

		arg_899_1:InitPlayNodeList()
	end,
	Play910201222 = function(arg_903_0, arg_903_1)
		arg_903_1.time_ = 0
		arg_903_1.frameCnt_ = 0
		arg_903_1.state_ = "playing"
		arg_903_1.curTalkId_ = 910201222
		arg_903_1.duration_ = 5

		SetActive(arg_903_1.tipsGo_, false)

		function arg_903_1.onSingleLineFinish_()
			arg_903_1.onSingleLineUpdate_ = nil
			arg_903_1.onSingleLineFinish_ = nil
			arg_903_1.state_ = "waiting"
		end

		function arg_903_1.playNext_(arg_905_0)
			if arg_905_0 == 1 then
				arg_903_0:Play910201223(arg_903_1)
			end
		end

		function arg_903_1.onSingleLineUpdate_(arg_906_0)
			local var_906_0 = arg_903_1.actors_["1084ui_story"]
			local var_906_1 = 0

			if var_906_1 < arg_903_1.time_ and arg_903_1.time_ <= var_906_1 + arg_906_0 and not isNil(var_906_0) and arg_903_1.var_.characterEffect1084ui_story == nil then
				arg_903_1.var_.characterEffect1084ui_story = var_906_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_906_2 = 0.2

			if var_906_1 <= arg_903_1.time_ and arg_903_1.time_ < var_906_1 + var_906_2 and not isNil(var_906_0) then
				local var_906_3 = (arg_903_1.time_ - var_906_1) / var_906_2

				if arg_903_1.var_.characterEffect1084ui_story and not isNil(var_906_0) then
					arg_903_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_903_1.time_ >= var_906_1 + var_906_2 and arg_903_1.time_ < var_906_1 + var_906_2 + arg_906_0 and not isNil(var_906_0) and arg_903_1.var_.characterEffect1084ui_story then
				arg_903_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_906_4 = 0

			if var_906_4 < arg_903_1.time_ and arg_903_1.time_ <= var_906_4 + arg_906_0 then
				arg_903_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_1")
			end

			local var_906_5 = 0

			if var_906_5 < arg_903_1.time_ and arg_903_1.time_ <= var_906_5 + arg_906_0 then
				arg_903_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_906_6 = 0
			local var_906_7 = 0.375

			if var_906_6 < arg_903_1.time_ and arg_903_1.time_ <= var_906_6 + arg_906_0 then
				arg_903_1.talkMaxDuration = 0
				arg_903_1.dialogCg_.alpha = 1

				arg_903_1.dialog_:SetActive(true)
				SetActive(arg_903_1.leftNameGo_, true)

				local var_906_8 = arg_903_1:FormatText(StoryNameCfg[6].name)

				arg_903_1.leftNameTxt_.text = var_906_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_903_1.leftNameTxt_.transform)

				arg_903_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_903_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_903_1:RecordName(arg_903_1.leftNameTxt_.text)
				SetActive(arg_903_1.iconTrs_.gameObject, false)
				arg_903_1.callingController_:SetSelectedState("normal")

				local var_906_9 = arg_903_1:GetWordFromCfg(910201222)
				local var_906_10 = arg_903_1:FormatText(var_906_9.content)

				arg_903_1.text_.text = var_906_10

				LuaForUtil.ClearLinePrefixSymbol(arg_903_1.text_)

				local var_906_11 = 15
				local var_906_12 = utf8.len(var_906_10)
				local var_906_13 = var_906_11 <= 0 and var_906_7 or var_906_7 * (var_906_12 / var_906_11)

				if var_906_13 > 0 and var_906_7 < var_906_13 then
					arg_903_1.talkMaxDuration = var_906_13

					if var_906_13 + var_906_6 > arg_903_1.duration_ then
						arg_903_1.duration_ = var_906_13 + var_906_6
					end
				end

				arg_903_1.text_.text = var_906_10
				arg_903_1.typewritter.percent = 0

				arg_903_1.typewritter:SetDirty()
				arg_903_1:ShowNextGo(false)
				arg_903_1:RecordContent(arg_903_1.text_.text)
			end

			local var_906_14 = math.max(var_906_7, arg_903_1.talkMaxDuration)

			if var_906_6 <= arg_903_1.time_ and arg_903_1.time_ < var_906_6 + var_906_14 then
				arg_903_1.typewritter.percent = (arg_903_1.time_ - var_906_6) / var_906_14

				arg_903_1.typewritter:SetDirty()
			end

			if arg_903_1.time_ >= var_906_6 + var_906_14 and arg_903_1.time_ < var_906_6 + var_906_14 + arg_906_0 then
				arg_903_1.typewritter.percent = 1

				arg_903_1.typewritter:SetDirty()
				arg_903_1:ShowNextGo(true)
			end
		end

		arg_903_1.nodeConfigList_ = {}

		arg_903_1:InitPlayNodeList()
	end,
	Play910201223 = function(arg_907_0, arg_907_1)
		arg_907_1.time_ = 0
		arg_907_1.frameCnt_ = 0
		arg_907_1.state_ = "playing"
		arg_907_1.curTalkId_ = 910201223
		arg_907_1.duration_ = 5

		SetActive(arg_907_1.tipsGo_, false)

		function arg_907_1.onSingleLineFinish_()
			arg_907_1.onSingleLineUpdate_ = nil
			arg_907_1.onSingleLineFinish_ = nil
			arg_907_1.state_ = "waiting"
		end

		function arg_907_1.playNext_(arg_909_0)
			if arg_909_0 == 1 then
				arg_907_0:Play910201224(arg_907_1)
			end
		end

		function arg_907_1.onSingleLineUpdate_(arg_910_0)
			local var_910_0 = 0

			if var_910_0 < arg_907_1.time_ and arg_907_1.time_ <= var_910_0 + arg_910_0 then
				arg_907_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action2_2")
			end

			local var_910_1 = arg_907_1.actors_["1084ui_story"].transform
			local var_910_2 = 0

			if var_910_2 < arg_907_1.time_ and arg_907_1.time_ <= var_910_2 + arg_910_0 then
				arg_907_1.var_.moveOldPos1084ui_story = var_910_1.localPosition
			end

			local var_910_3 = 0.001

			if var_910_2 <= arg_907_1.time_ and arg_907_1.time_ < var_910_2 + var_910_3 then
				local var_910_4 = (arg_907_1.time_ - var_910_2) / var_910_3
				local var_910_5 = Vector3.New(0, 100, 0)

				var_910_1.localPosition = Vector3.Lerp(arg_907_1.var_.moveOldPos1084ui_story, var_910_5, var_910_4)

				local var_910_6 = manager.ui.mainCamera.transform.position - var_910_1.position

				var_910_1.forward = Vector3.New(var_910_6.x, var_910_6.y, var_910_6.z)

				local var_910_7 = var_910_1.localEulerAngles

				var_910_7.z = 0
				var_910_7.x = 0
				var_910_1.localEulerAngles = var_910_7
			end

			if arg_907_1.time_ >= var_910_2 + var_910_3 and arg_907_1.time_ < var_910_2 + var_910_3 + arg_910_0 then
				var_910_1.localPosition = Vector3.New(0, 100, 0)

				local var_910_8 = manager.ui.mainCamera.transform.position - var_910_1.position

				var_910_1.forward = Vector3.New(var_910_8.x, var_910_8.y, var_910_8.z)

				local var_910_9 = var_910_1.localEulerAngles

				var_910_9.z = 0
				var_910_9.x = 0
				var_910_1.localEulerAngles = var_910_9
			end

			local var_910_10 = 0
			local var_910_11 = 0.25

			if var_910_10 < arg_907_1.time_ and arg_907_1.time_ <= var_910_10 + arg_910_0 then
				arg_907_1.talkMaxDuration = 0
				arg_907_1.dialogCg_.alpha = 1

				arg_907_1.dialog_:SetActive(true)
				SetActive(arg_907_1.leftNameGo_, true)

				local var_910_12 = arg_907_1:FormatText(StoryNameCfg[10].name)

				arg_907_1.leftNameTxt_.text = var_910_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_907_1.leftNameTxt_.transform)

				arg_907_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_907_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_907_1:RecordName(arg_907_1.leftNameTxt_.text)
				SetActive(arg_907_1.iconTrs_.gameObject, true)
				arg_907_1.iconController_:SetSelectedState("hero")

				arg_907_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_907_1.callingController_:SetSelectedState("normal")

				arg_907_1.keyicon_.color = Color.New(1, 1, 1)
				arg_907_1.icon_.color = Color.New(1, 1, 1)

				local var_910_13 = arg_907_1:GetWordFromCfg(910201223)
				local var_910_14 = arg_907_1:FormatText(var_910_13.content)

				arg_907_1.text_.text = var_910_14

				LuaForUtil.ClearLinePrefixSymbol(arg_907_1.text_)

				local var_910_15 = 10
				local var_910_16 = utf8.len(var_910_14)
				local var_910_17 = var_910_15 <= 0 and var_910_11 or var_910_11 * (var_910_16 / var_910_15)

				if var_910_17 > 0 and var_910_11 < var_910_17 then
					arg_907_1.talkMaxDuration = var_910_17

					if var_910_17 + var_910_10 > arg_907_1.duration_ then
						arg_907_1.duration_ = var_910_17 + var_910_10
					end
				end

				arg_907_1.text_.text = var_910_14
				arg_907_1.typewritter.percent = 0

				arg_907_1.typewritter:SetDirty()
				arg_907_1:ShowNextGo(false)
				arg_907_1:RecordContent(arg_907_1.text_.text)
			end

			local var_910_18 = math.max(var_910_11, arg_907_1.talkMaxDuration)

			if var_910_10 <= arg_907_1.time_ and arg_907_1.time_ < var_910_10 + var_910_18 then
				arg_907_1.typewritter.percent = (arg_907_1.time_ - var_910_10) / var_910_18

				arg_907_1.typewritter:SetDirty()
			end

			if arg_907_1.time_ >= var_910_10 + var_910_18 and arg_907_1.time_ < var_910_10 + var_910_18 + arg_910_0 then
				arg_907_1.typewritter.percent = 1

				arg_907_1.typewritter:SetDirty()
				arg_907_1:ShowNextGo(true)
			end
		end

		arg_907_1.nodeConfigList_ = {
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

		arg_907_1:InitPlayNodeList()
	end,
	Play910201224 = function(arg_911_0, arg_911_1)
		arg_911_1.time_ = 0
		arg_911_1.frameCnt_ = 0
		arg_911_1.state_ = "playing"
		arg_911_1.curTalkId_ = 910201224
		arg_911_1.duration_ = 5

		SetActive(arg_911_1.tipsGo_, false)

		function arg_911_1.onSingleLineFinish_()
			arg_911_1.onSingleLineUpdate_ = nil
			arg_911_1.onSingleLineFinish_ = nil
			arg_911_1.state_ = "waiting"
		end

		function arg_911_1.playNext_(arg_913_0)
			if arg_913_0 == 1 then
				arg_911_0:Play910201225(arg_911_1)
			end
		end

		function arg_911_1.onSingleLineUpdate_(arg_914_0)
			local var_914_0 = arg_911_1.actors_["1059ui_story"].transform
			local var_914_1 = 0

			if var_914_1 < arg_911_1.time_ and arg_911_1.time_ <= var_914_1 + arg_914_0 then
				arg_911_1.var_.moveOldPos1059ui_story = var_914_0.localPosition
			end

			local var_914_2 = 0.001

			if var_914_1 <= arg_911_1.time_ and arg_911_1.time_ < var_914_1 + var_914_2 then
				local var_914_3 = (arg_911_1.time_ - var_914_1) / var_914_2
				local var_914_4 = Vector3.New(0, -1.05, -6)

				var_914_0.localPosition = Vector3.Lerp(arg_911_1.var_.moveOldPos1059ui_story, var_914_4, var_914_3)

				local var_914_5 = manager.ui.mainCamera.transform.position - var_914_0.position

				var_914_0.forward = Vector3.New(var_914_5.x, var_914_5.y, var_914_5.z)

				local var_914_6 = var_914_0.localEulerAngles

				var_914_6.z = 0
				var_914_6.x = 0
				var_914_0.localEulerAngles = var_914_6
			end

			if arg_911_1.time_ >= var_914_1 + var_914_2 and arg_911_1.time_ < var_914_1 + var_914_2 + arg_914_0 then
				var_914_0.localPosition = Vector3.New(0, -1.05, -6)

				local var_914_7 = manager.ui.mainCamera.transform.position - var_914_0.position

				var_914_0.forward = Vector3.New(var_914_7.x, var_914_7.y, var_914_7.z)

				local var_914_8 = var_914_0.localEulerAngles

				var_914_8.z = 0
				var_914_8.x = 0
				var_914_0.localEulerAngles = var_914_8
			end

			local var_914_9 = 0

			if var_914_9 < arg_911_1.time_ and arg_911_1.time_ <= var_914_9 + arg_914_0 then
				arg_911_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action5_1")
			end

			local var_914_10 = arg_911_1.actors_["1059ui_story"]
			local var_914_11 = 0

			if var_914_11 < arg_911_1.time_ and arg_911_1.time_ <= var_914_11 + arg_914_0 and not isNil(var_914_10) and arg_911_1.var_.characterEffect1059ui_story == nil then
				arg_911_1.var_.characterEffect1059ui_story = var_914_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_914_12 = 0.2

			if var_914_11 <= arg_911_1.time_ and arg_911_1.time_ < var_914_11 + var_914_12 and not isNil(var_914_10) then
				local var_914_13 = (arg_911_1.time_ - var_914_11) / var_914_12

				if arg_911_1.var_.characterEffect1059ui_story and not isNil(var_914_10) then
					arg_911_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_911_1.time_ >= var_914_11 + var_914_12 and arg_911_1.time_ < var_914_11 + var_914_12 + arg_914_0 and not isNil(var_914_10) and arg_911_1.var_.characterEffect1059ui_story then
				arg_911_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_914_14 = 0
			local var_914_15 = 0.325

			if var_914_14 < arg_911_1.time_ and arg_911_1.time_ <= var_914_14 + arg_914_0 then
				arg_911_1.talkMaxDuration = 0
				arg_911_1.dialogCg_.alpha = 1

				arg_911_1.dialog_:SetActive(true)
				SetActive(arg_911_1.leftNameGo_, true)

				local var_914_16 = arg_911_1:FormatText(StoryNameCfg[28].name)

				arg_911_1.leftNameTxt_.text = var_914_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_911_1.leftNameTxt_.transform)

				arg_911_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_911_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_911_1:RecordName(arg_911_1.leftNameTxt_.text)
				SetActive(arg_911_1.iconTrs_.gameObject, false)
				arg_911_1.callingController_:SetSelectedState("normal")

				local var_914_17 = arg_911_1:GetWordFromCfg(910201224)
				local var_914_18 = arg_911_1:FormatText(var_914_17.content)

				arg_911_1.text_.text = var_914_18

				LuaForUtil.ClearLinePrefixSymbol(arg_911_1.text_)

				local var_914_19 = 13
				local var_914_20 = utf8.len(var_914_18)
				local var_914_21 = var_914_19 <= 0 and var_914_15 or var_914_15 * (var_914_20 / var_914_19)

				if var_914_21 > 0 and var_914_15 < var_914_21 then
					arg_911_1.talkMaxDuration = var_914_21

					if var_914_21 + var_914_14 > arg_911_1.duration_ then
						arg_911_1.duration_ = var_914_21 + var_914_14
					end
				end

				arg_911_1.text_.text = var_914_18
				arg_911_1.typewritter.percent = 0

				arg_911_1.typewritter:SetDirty()
				arg_911_1:ShowNextGo(false)
				arg_911_1:RecordContent(arg_911_1.text_.text)
			end

			local var_914_22 = math.max(var_914_15, arg_911_1.talkMaxDuration)

			if var_914_14 <= arg_911_1.time_ and arg_911_1.time_ < var_914_14 + var_914_22 then
				arg_911_1.typewritter.percent = (arg_911_1.time_ - var_914_14) / var_914_22

				arg_911_1.typewritter:SetDirty()
			end

			if arg_911_1.time_ >= var_914_14 + var_914_22 and arg_911_1.time_ < var_914_14 + var_914_22 + arg_914_0 then
				arg_911_1.typewritter.percent = 1

				arg_911_1.typewritter:SetDirty()
				arg_911_1:ShowNextGo(true)
			end
		end

		arg_911_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_911_1:InitPlayNodeList()
	end,
	Play910201225 = function(arg_915_0, arg_915_1)
		arg_915_1.time_ = 0
		arg_915_1.frameCnt_ = 0
		arg_915_1.state_ = "playing"
		arg_915_1.curTalkId_ = 910201225
		arg_915_1.duration_ = 5

		SetActive(arg_915_1.tipsGo_, false)

		function arg_915_1.onSingleLineFinish_()
			arg_915_1.onSingleLineUpdate_ = nil
			arg_915_1.onSingleLineFinish_ = nil
			arg_915_1.state_ = "waiting"
		end

		function arg_915_1.playNext_(arg_917_0)
			if arg_917_0 == 1 then
				arg_915_0:Play910201226(arg_915_1)
			end
		end

		function arg_915_1.onSingleLineUpdate_(arg_918_0)
			local var_918_0 = arg_915_1.actors_["1084ui_story"].transform
			local var_918_1 = 0

			if var_918_1 < arg_915_1.time_ and arg_915_1.time_ <= var_918_1 + arg_918_0 then
				arg_915_1.var_.moveOldPos1084ui_story = var_918_0.localPosition
			end

			local var_918_2 = 0.001

			if var_918_1 <= arg_915_1.time_ and arg_915_1.time_ < var_918_1 + var_918_2 then
				local var_918_3 = (arg_915_1.time_ - var_918_1) / var_918_2
				local var_918_4 = Vector3.New(0, -0.97, -6)

				var_918_0.localPosition = Vector3.Lerp(arg_915_1.var_.moveOldPos1084ui_story, var_918_4, var_918_3)

				local var_918_5 = manager.ui.mainCamera.transform.position - var_918_0.position

				var_918_0.forward = Vector3.New(var_918_5.x, var_918_5.y, var_918_5.z)

				local var_918_6 = var_918_0.localEulerAngles

				var_918_6.z = 0
				var_918_6.x = 0
				var_918_0.localEulerAngles = var_918_6
			end

			if arg_915_1.time_ >= var_918_1 + var_918_2 and arg_915_1.time_ < var_918_1 + var_918_2 + arg_918_0 then
				var_918_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_918_7 = manager.ui.mainCamera.transform.position - var_918_0.position

				var_918_0.forward = Vector3.New(var_918_7.x, var_918_7.y, var_918_7.z)

				local var_918_8 = var_918_0.localEulerAngles

				var_918_8.z = 0
				var_918_8.x = 0
				var_918_0.localEulerAngles = var_918_8
			end

			local var_918_9 = arg_915_1.actors_["1059ui_story"].transform
			local var_918_10 = 0

			if var_918_10 < arg_915_1.time_ and arg_915_1.time_ <= var_918_10 + arg_918_0 then
				arg_915_1.var_.moveOldPos1059ui_story = var_918_9.localPosition
			end

			local var_918_11 = 0.001

			if var_918_10 <= arg_915_1.time_ and arg_915_1.time_ < var_918_10 + var_918_11 then
				local var_918_12 = (arg_915_1.time_ - var_918_10) / var_918_11
				local var_918_13 = Vector3.New(0, 100, 0)

				var_918_9.localPosition = Vector3.Lerp(arg_915_1.var_.moveOldPos1059ui_story, var_918_13, var_918_12)

				local var_918_14 = manager.ui.mainCamera.transform.position - var_918_9.position

				var_918_9.forward = Vector3.New(var_918_14.x, var_918_14.y, var_918_14.z)

				local var_918_15 = var_918_9.localEulerAngles

				var_918_15.z = 0
				var_918_15.x = 0
				var_918_9.localEulerAngles = var_918_15
			end

			if arg_915_1.time_ >= var_918_10 + var_918_11 and arg_915_1.time_ < var_918_10 + var_918_11 + arg_918_0 then
				var_918_9.localPosition = Vector3.New(0, 100, 0)

				local var_918_16 = manager.ui.mainCamera.transform.position - var_918_9.position

				var_918_9.forward = Vector3.New(var_918_16.x, var_918_16.y, var_918_16.z)

				local var_918_17 = var_918_9.localEulerAngles

				var_918_17.z = 0
				var_918_17.x = 0
				var_918_9.localEulerAngles = var_918_17
			end

			local var_918_18 = 0

			if var_918_18 < arg_915_1.time_ and arg_915_1.time_ <= var_918_18 + arg_918_0 then
				arg_915_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_918_19 = arg_915_1.actors_["1084ui_story"]
			local var_918_20 = 0

			if var_918_20 < arg_915_1.time_ and arg_915_1.time_ <= var_918_20 + arg_918_0 and not isNil(var_918_19) and arg_915_1.var_.characterEffect1084ui_story == nil then
				arg_915_1.var_.characterEffect1084ui_story = var_918_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_918_21 = 0.2

			if var_918_20 <= arg_915_1.time_ and arg_915_1.time_ < var_918_20 + var_918_21 and not isNil(var_918_19) then
				local var_918_22 = (arg_915_1.time_ - var_918_20) / var_918_21

				if arg_915_1.var_.characterEffect1084ui_story and not isNil(var_918_19) then
					arg_915_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_915_1.time_ >= var_918_20 + var_918_21 and arg_915_1.time_ < var_918_20 + var_918_21 + arg_918_0 and not isNil(var_918_19) and arg_915_1.var_.characterEffect1084ui_story then
				arg_915_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_918_23 = 0

			if var_918_23 < arg_915_1.time_ and arg_915_1.time_ <= var_918_23 + arg_918_0 then
				arg_915_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_918_24 = 0
			local var_918_25 = 0.725

			if var_918_24 < arg_915_1.time_ and arg_915_1.time_ <= var_918_24 + arg_918_0 then
				arg_915_1.talkMaxDuration = 0
				arg_915_1.dialogCg_.alpha = 1

				arg_915_1.dialog_:SetActive(true)
				SetActive(arg_915_1.leftNameGo_, true)

				local var_918_26 = arg_915_1:FormatText(StoryNameCfg[6].name)

				arg_915_1.leftNameTxt_.text = var_918_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_915_1.leftNameTxt_.transform)

				arg_915_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_915_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_915_1:RecordName(arg_915_1.leftNameTxt_.text)
				SetActive(arg_915_1.iconTrs_.gameObject, false)
				arg_915_1.callingController_:SetSelectedState("normal")

				local var_918_27 = arg_915_1:GetWordFromCfg(910201225)
				local var_918_28 = arg_915_1:FormatText(var_918_27.content)

				arg_915_1.text_.text = var_918_28

				LuaForUtil.ClearLinePrefixSymbol(arg_915_1.text_)

				local var_918_29 = 29
				local var_918_30 = utf8.len(var_918_28)
				local var_918_31 = var_918_29 <= 0 and var_918_25 or var_918_25 * (var_918_30 / var_918_29)

				if var_918_31 > 0 and var_918_25 < var_918_31 then
					arg_915_1.talkMaxDuration = var_918_31

					if var_918_31 + var_918_24 > arg_915_1.duration_ then
						arg_915_1.duration_ = var_918_31 + var_918_24
					end
				end

				arg_915_1.text_.text = var_918_28
				arg_915_1.typewritter.percent = 0

				arg_915_1.typewritter:SetDirty()
				arg_915_1:ShowNextGo(false)
				arg_915_1:RecordContent(arg_915_1.text_.text)
			end

			local var_918_32 = math.max(var_918_25, arg_915_1.talkMaxDuration)

			if var_918_24 <= arg_915_1.time_ and arg_915_1.time_ < var_918_24 + var_918_32 then
				arg_915_1.typewritter.percent = (arg_915_1.time_ - var_918_24) / var_918_32

				arg_915_1.typewritter:SetDirty()
			end

			if arg_915_1.time_ >= var_918_24 + var_918_32 and arg_915_1.time_ < var_918_24 + var_918_32 + arg_918_0 then
				arg_915_1.typewritter.percent = 1

				arg_915_1.typewritter:SetDirty()
				arg_915_1:ShowNextGo(true)
			end
		end

		arg_915_1.nodeConfigList_ = {
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_915_1:InitPlayNodeList()
	end,
	Play910201226 = function(arg_919_0, arg_919_1)
		arg_919_1.time_ = 0
		arg_919_1.frameCnt_ = 0
		arg_919_1.state_ = "playing"
		arg_919_1.curTalkId_ = 910201226
		arg_919_1.duration_ = 5

		SetActive(arg_919_1.tipsGo_, false)

		function arg_919_1.onSingleLineFinish_()
			arg_919_1.onSingleLineUpdate_ = nil
			arg_919_1.onSingleLineFinish_ = nil
			arg_919_1.state_ = "waiting"
		end

		function arg_919_1.playNext_(arg_921_0)
			if arg_921_0 == 1 then
				arg_919_0:Play910201227(arg_919_1)
			end
		end

		function arg_919_1.onSingleLineUpdate_(arg_922_0)
			local var_922_0 = arg_919_1.actors_["1084ui_story"].transform
			local var_922_1 = 0

			if var_922_1 < arg_919_1.time_ and arg_919_1.time_ <= var_922_1 + arg_922_0 then
				arg_919_1.var_.moveOldPos1084ui_story = var_922_0.localPosition
			end

			local var_922_2 = 0.001

			if var_922_1 <= arg_919_1.time_ and arg_919_1.time_ < var_922_1 + var_922_2 then
				local var_922_3 = (arg_919_1.time_ - var_922_1) / var_922_2
				local var_922_4 = Vector3.New(0, 100, 0)

				var_922_0.localPosition = Vector3.Lerp(arg_919_1.var_.moveOldPos1084ui_story, var_922_4, var_922_3)

				local var_922_5 = manager.ui.mainCamera.transform.position - var_922_0.position

				var_922_0.forward = Vector3.New(var_922_5.x, var_922_5.y, var_922_5.z)

				local var_922_6 = var_922_0.localEulerAngles

				var_922_6.z = 0
				var_922_6.x = 0
				var_922_0.localEulerAngles = var_922_6
			end

			if arg_919_1.time_ >= var_922_1 + var_922_2 and arg_919_1.time_ < var_922_1 + var_922_2 + arg_922_0 then
				var_922_0.localPosition = Vector3.New(0, 100, 0)

				local var_922_7 = manager.ui.mainCamera.transform.position - var_922_0.position

				var_922_0.forward = Vector3.New(var_922_7.x, var_922_7.y, var_922_7.z)

				local var_922_8 = var_922_0.localEulerAngles

				var_922_8.z = 0
				var_922_8.x = 0
				var_922_0.localEulerAngles = var_922_8
			end

			local var_922_9 = 0
			local var_922_10 = 0.35

			if var_922_9 < arg_919_1.time_ and arg_919_1.time_ <= var_922_9 + arg_922_0 then
				arg_919_1.talkMaxDuration = 0
				arg_919_1.dialogCg_.alpha = 1

				arg_919_1.dialog_:SetActive(true)
				SetActive(arg_919_1.leftNameGo_, true)

				local var_922_11 = arg_919_1:FormatText(StoryNameCfg[330].name)

				arg_919_1.leftNameTxt_.text = var_922_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_919_1.leftNameTxt_.transform)

				arg_919_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_919_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_919_1:RecordName(arg_919_1.leftNameTxt_.text)
				SetActive(arg_919_1.iconTrs_.gameObject, false)
				arg_919_1.callingController_:SetSelectedState("normal")

				local var_922_12 = arg_919_1:GetWordFromCfg(910201226)
				local var_922_13 = arg_919_1:FormatText(var_922_12.content)

				arg_919_1.text_.text = var_922_13

				LuaForUtil.ClearLinePrefixSymbol(arg_919_1.text_)

				local var_922_14 = 14
				local var_922_15 = utf8.len(var_922_13)
				local var_922_16 = var_922_14 <= 0 and var_922_10 or var_922_10 * (var_922_15 / var_922_14)

				if var_922_16 > 0 and var_922_10 < var_922_16 then
					arg_919_1.talkMaxDuration = var_922_16

					if var_922_16 + var_922_9 > arg_919_1.duration_ then
						arg_919_1.duration_ = var_922_16 + var_922_9
					end
				end

				arg_919_1.text_.text = var_922_13
				arg_919_1.typewritter.percent = 0

				arg_919_1.typewritter:SetDirty()
				arg_919_1:ShowNextGo(false)
				arg_919_1:RecordContent(arg_919_1.text_.text)
			end

			local var_922_17 = math.max(var_922_10, arg_919_1.talkMaxDuration)

			if var_922_9 <= arg_919_1.time_ and arg_919_1.time_ < var_922_9 + var_922_17 then
				arg_919_1.typewritter.percent = (arg_919_1.time_ - var_922_9) / var_922_17

				arg_919_1.typewritter:SetDirty()
			end

			if arg_919_1.time_ >= var_922_9 + var_922_17 and arg_919_1.time_ < var_922_9 + var_922_17 + arg_922_0 then
				arg_919_1.typewritter.percent = 1

				arg_919_1.typewritter:SetDirty()
				arg_919_1:ShowNextGo(true)
			end
		end

		arg_919_1.nodeConfigList_ = {
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

		arg_919_1:InitPlayNodeList()
	end,
	Play910201227 = function(arg_923_0, arg_923_1)
		arg_923_1.time_ = 0
		arg_923_1.frameCnt_ = 0
		arg_923_1.state_ = "playing"
		arg_923_1.curTalkId_ = 910201227
		arg_923_1.duration_ = 5

		SetActive(arg_923_1.tipsGo_, false)

		function arg_923_1.onSingleLineFinish_()
			arg_923_1.onSingleLineUpdate_ = nil
			arg_923_1.onSingleLineFinish_ = nil
			arg_923_1.state_ = "waiting"
			arg_923_1.auto_ = false
		end

		function arg_923_1.playNext_(arg_925_0)
			arg_923_1.onStoryFinished_()
		end

		function arg_923_1.onSingleLineUpdate_(arg_926_0)
			local var_926_0 = 0
			local var_926_1 = 0.25

			if var_926_0 < arg_923_1.time_ and arg_923_1.time_ <= var_926_0 + arg_926_0 then
				arg_923_1.talkMaxDuration = 0
				arg_923_1.dialogCg_.alpha = 1

				arg_923_1.dialog_:SetActive(true)
				SetActive(arg_923_1.leftNameGo_, false)

				arg_923_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_923_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_923_1:RecordName(arg_923_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_923_1.iconTrs_.gameObject, false)
				arg_923_1.callingController_:SetSelectedState("normal")

				local var_926_2 = arg_923_1:GetWordFromCfg(910201227)
				local var_926_3 = arg_923_1:FormatText(var_926_2.content)

				arg_923_1.text_.text = var_926_3

				LuaForUtil.ClearLinePrefixSymbol(arg_923_1.text_)

				local var_926_4 = 10
				local var_926_5 = utf8.len(var_926_3)
				local var_926_6 = var_926_4 <= 0 and var_926_1 or var_926_1 * (var_926_5 / var_926_4)

				if var_926_6 > 0 and var_926_1 < var_926_6 then
					arg_923_1.talkMaxDuration = var_926_6

					if var_926_6 + var_926_0 > arg_923_1.duration_ then
						arg_923_1.duration_ = var_926_6 + var_926_0
					end
				end

				arg_923_1.text_.text = var_926_3
				arg_923_1.typewritter.percent = 0

				arg_923_1.typewritter:SetDirty()
				arg_923_1:ShowNextGo(false)
				arg_923_1:RecordContent(arg_923_1.text_.text)
			end

			local var_926_7 = math.max(var_926_1, arg_923_1.talkMaxDuration)

			if var_926_0 <= arg_923_1.time_ and arg_923_1.time_ < var_926_0 + var_926_7 then
				arg_923_1.typewritter.percent = (arg_923_1.time_ - var_926_0) / var_926_7

				arg_923_1.typewritter:SetDirty()
			end

			if arg_923_1.time_ >= var_926_0 + var_926_7 and arg_923_1.time_ < var_926_0 + var_926_7 + arg_926_0 then
				arg_923_1.typewritter.percent = 1

				arg_923_1.typewritter:SetDirty()
				arg_923_1:ShowNextGo(true)
			end
		end

		arg_923_1.nodeConfigList_ = {}

		arg_923_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/A00",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/ST05",
		"TextureConfig/Background/HB0101"
	},
	voices = {}
}
