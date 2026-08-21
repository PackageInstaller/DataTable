return {
	Play321021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321021001
		arg_1_1.duration_ = 6.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play321021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L06g"

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
				local var_4_5 = arg_1_1.bgs_.L06g

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
					if iter_4_0 ~= "L06g" then
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

			local var_4_24 = 0
			local var_4_25 = 0.2

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
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 1.9
			local var_4_37 = 0.225

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_39 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_39

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

				local var_4_40 = arg_1_1:GetWordFromCfg(321021001)
				local var_4_41 = arg_1_1:FormatText(var_4_40.content)

				arg_1_1.text_.text = var_4_41

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_42 = 9
				local var_4_43 = utf8.len(var_4_41)
				local var_4_44 = var_4_42 <= 0 and var_4_37 or var_4_37 * (var_4_43 / var_4_42)

				if var_4_44 > 0 and var_4_37 < var_4_44 then
					arg_1_1.talkMaxDuration = var_4_44
					var_4_36 = var_4_36 + 0.3

					if var_4_44 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_44 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_41
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_45 = var_4_36 + 0.3
			local var_4_46 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_45) / var_4_46

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play321021002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321021002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321021003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.125

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(321021002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 45
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play321021003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321021003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321021004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.35

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

				local var_16_2 = arg_13_1:GetWordFromCfg(321021003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 54
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
	Play321021004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321021004
		arg_17_1.duration_ = 2.6

		local var_17_0 = {
			zh = 1.999999999999,
			ja = 2.6
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321021005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "10104ui_story"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_17_1.stage_.transform)

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

			local var_20_5 = arg_17_1.actors_["10104ui_story"].transform
			local var_20_6 = 0

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.var_.moveOldPos10104ui_story = var_20_5.localPosition
			end

			local var_20_7 = 0.001

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_7 then
				local var_20_8 = (arg_17_1.time_ - var_20_6) / var_20_7
				local var_20_9 = Vector3.New(0.02, -1.12, -5.99)

				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10104ui_story, var_20_9, var_20_8)

				local var_20_10 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_10.x, var_20_10.y, var_20_10.z)

				local var_20_11 = var_20_5.localEulerAngles

				var_20_11.z = 0
				var_20_11.x = 0
				var_20_5.localEulerAngles = var_20_11
			end

			if arg_17_1.time_ >= var_20_6 + var_20_7 and arg_17_1.time_ < var_20_6 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_20_12 = manager.ui.mainCamera.transform.position - var_20_5.position

				var_20_5.forward = Vector3.New(var_20_12.x, var_20_12.y, var_20_12.z)

				local var_20_13 = var_20_5.localEulerAngles

				var_20_13.z = 0
				var_20_13.x = 0
				var_20_5.localEulerAngles = var_20_13
			end

			local var_20_14 = arg_17_1.actors_["10104ui_story"]
			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect10104ui_story == nil then
				arg_17_1.var_.characterEffect10104ui_story = var_20_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_16 = 0.200000002980232

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 and not isNil(var_20_14) then
				local var_20_17 = (arg_17_1.time_ - var_20_15) / var_20_16

				if arg_17_1.var_.characterEffect10104ui_story and not isNil(var_20_14) then
					arg_17_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 and not isNil(var_20_14) and arg_17_1.var_.characterEffect10104ui_story then
				arg_17_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_20_18 = 0

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_20_19 = 0

			if var_20_19 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_20_20 = 0
			local var_20_21 = 0.225

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_22 = arg_17_1:FormatText(StoryNameCfg[1030].name)

				arg_17_1.leftNameTxt_.text = var_20_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_23 = arg_17_1:GetWordFromCfg(321021004)
				local var_20_24 = arg_17_1:FormatText(var_20_23.content)

				arg_17_1.text_.text = var_20_24

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_25 = 9
				local var_20_26 = utf8.len(var_20_24)
				local var_20_27 = var_20_25 <= 0 and var_20_21 or var_20_21 * (var_20_26 / var_20_25)

				if var_20_27 > 0 and var_20_21 < var_20_27 then
					arg_17_1.talkMaxDuration = var_20_27

					if var_20_27 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_20
					end
				end

				arg_17_1.text_.text = var_20_24
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021004", "story_v_out_321021.awb") ~= 0 then
					local var_20_28 = manager.audio:GetVoiceLength("story_v_out_321021", "321021004", "story_v_out_321021.awb") / 1000

					if var_20_28 + var_20_20 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_20
					end

					if var_20_23.prefab_name ~= "" and arg_17_1.actors_[var_20_23.prefab_name] ~= nil then
						local var_20_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_23.prefab_name].transform, "story_v_out_321021", "321021004", "story_v_out_321021.awb")

						arg_17_1:RecordAudio("321021004", var_20_29)
						arg_17_1:RecordAudio("321021004", var_20_29)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321021", "321021004", "story_v_out_321021.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321021", "321021004", "story_v_out_321021.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_30 = math.max(var_20_21, arg_17_1.talkMaxDuration)

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_30 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_20) / var_20_30

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_20 + var_20_30 and arg_17_1.time_ < var_20_20 + var_20_30 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play321021005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321021005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play321021006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10104ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10104ui_story == nil then
				arg_21_1.var_.characterEffect10104ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect10104ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10104ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect10104ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10104ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.875

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_9 = arg_21_1:GetWordFromCfg(321021005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 35
				local var_24_12 = utf8.len(var_24_10)
				local var_24_13 = var_24_11 <= 0 and var_24_7 or var_24_7 * (var_24_12 / var_24_11)

				if var_24_13 > 0 and var_24_7 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play321021006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321021006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play321021007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 1.325

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(321021006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 53
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play321021007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321021007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play321021008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.1
			local var_32_1 = 1

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				local var_32_2 = "play"
				local var_32_3 = "effect"

				arg_29_1:AudioAction(var_32_2, var_32_3, "se_story_140", "se_story_140_safetybelt", "")
			end

			local var_32_4 = 0
			local var_32_5 = 0.55

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(321021007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_8 = 22
				local var_32_9 = utf8.len(var_32_7)
				local var_32_10 = var_32_8 <= 0 and var_32_5 or var_32_5 * (var_32_9 / var_32_8)

				if var_32_10 > 0 and var_32_5 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_11 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_11 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_11

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_11 and arg_29_1.time_ < var_32_4 + var_32_11 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play321021008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321021008
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play321021009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10104ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10104ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(0.02, -1.12, -5.99)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10104ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["10104ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10104ui_story == nil then
				arg_33_1.var_.characterEffect10104ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect10104ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10104ui_story then
				arg_33_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_36_15 = 0
			local var_36_16 = 0.15

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_17 = arg_33_1:FormatText(StoryNameCfg[1030].name)

				arg_33_1.leftNameTxt_.text = var_36_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_18 = arg_33_1:GetWordFromCfg(321021008)
				local var_36_19 = arg_33_1:FormatText(var_36_18.content)

				arg_33_1.text_.text = var_36_19

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_20 = 6
				local var_36_21 = utf8.len(var_36_19)
				local var_36_22 = var_36_20 <= 0 and var_36_16 or var_36_16 * (var_36_21 / var_36_20)

				if var_36_22 > 0 and var_36_16 < var_36_22 then
					arg_33_1.talkMaxDuration = var_36_22

					if var_36_22 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_22 + var_36_15
					end
				end

				arg_33_1.text_.text = var_36_19
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021008", "story_v_out_321021.awb") ~= 0 then
					local var_36_23 = manager.audio:GetVoiceLength("story_v_out_321021", "321021008", "story_v_out_321021.awb") / 1000

					if var_36_23 + var_36_15 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_23 + var_36_15
					end

					if var_36_18.prefab_name ~= "" and arg_33_1.actors_[var_36_18.prefab_name] ~= nil then
						local var_36_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_18.prefab_name].transform, "story_v_out_321021", "321021008", "story_v_out_321021.awb")

						arg_33_1:RecordAudio("321021008", var_36_24)
						arg_33_1:RecordAudio("321021008", var_36_24)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_321021", "321021008", "story_v_out_321021.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_321021", "321021008", "story_v_out_321021.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_25 = math.max(var_36_16, arg_33_1.talkMaxDuration)

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_25 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_15) / var_36_25

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_15 + var_36_25 and arg_33_1.time_ < var_36_15 + var_36_25 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play321021009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321021009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play321021010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10104ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10104ui_story == nil then
				arg_37_1.var_.characterEffect10104ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect10104ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10104ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10104ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10104ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 1

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[7].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_9 = arg_37_1:GetWordFromCfg(321021009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 40
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
	Play321021010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 321021010
		arg_41_1.duration_ = 5.43

		local var_41_0 = {
			zh = 2.9,
			ja = 5.433
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play321021011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10104ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10104ui_story == nil then
				arg_41_1.var_.characterEffect10104ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10104ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10104ui_story then
				arg_41_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_44_4 = 0
			local var_44_5 = 0.4

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_6 = arg_41_1:FormatText(StoryNameCfg[1030].name)

				arg_41_1.leftNameTxt_.text = var_44_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:GetWordFromCfg(321021010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 16
				local var_44_10 = utf8.len(var_44_8)
				local var_44_11 = var_44_9 <= 0 and var_44_5 or var_44_5 * (var_44_10 / var_44_9)

				if var_44_11 > 0 and var_44_5 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021010", "story_v_out_321021.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_321021", "321021010", "story_v_out_321021.awb") / 1000

					if var_44_12 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_4
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_321021", "321021010", "story_v_out_321021.awb")

						arg_41_1:RecordAudio("321021010", var_44_13)
						arg_41_1:RecordAudio("321021010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_321021", "321021010", "story_v_out_321021.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_321021", "321021010", "story_v_out_321021.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_14 and arg_41_1.time_ < var_44_4 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play321021011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 321021011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play321021012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10104ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10104ui_story == nil then
				arg_45_1.var_.characterEffect10104ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect10104ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10104ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10104ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10104ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 1.075

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_8 = arg_45_1:FormatText(StoryNameCfg[7].name)

				arg_45_1.leftNameTxt_.text = var_48_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_9 = arg_45_1:GetWordFromCfg(321021011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 43
				local var_48_12 = utf8.len(var_48_10)
				local var_48_13 = var_48_11 <= 0 and var_48_7 or var_48_7 * (var_48_12 / var_48_11)

				if var_48_13 > 0 and var_48_7 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play321021012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 321021012
		arg_49_1.duration_ = 2.6

		local var_49_0 = {
			zh = 2,
			ja = 2.6
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play321021013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10104ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10104ui_story == nil then
				arg_49_1.var_.characterEffect10104ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect10104ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10104ui_story then
				arg_49_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_52_4 = 0
			local var_52_5 = 0.2

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_6 = arg_49_1:FormatText(StoryNameCfg[1030].name)

				arg_49_1.leftNameTxt_.text = var_52_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_7 = arg_49_1:GetWordFromCfg(321021012)
				local var_52_8 = arg_49_1:FormatText(var_52_7.content)

				arg_49_1.text_.text = var_52_8

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 8
				local var_52_10 = utf8.len(var_52_8)
				local var_52_11 = var_52_9 <= 0 and var_52_5 or var_52_5 * (var_52_10 / var_52_9)

				if var_52_11 > 0 and var_52_5 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_8
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021012", "story_v_out_321021.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_321021", "321021012", "story_v_out_321021.awb") / 1000

					if var_52_12 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_4
					end

					if var_52_7.prefab_name ~= "" and arg_49_1.actors_[var_52_7.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_7.prefab_name].transform, "story_v_out_321021", "321021012", "story_v_out_321021.awb")

						arg_49_1:RecordAudio("321021012", var_52_13)
						arg_49_1:RecordAudio("321021012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_321021", "321021012", "story_v_out_321021.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_321021", "321021012", "story_v_out_321021.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_14 and arg_49_1.time_ < var_52_4 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play321021013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 321021013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play321021014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10104ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10104ui_story == nil then
				arg_53_1.var_.characterEffect10104ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect10104ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10104ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10104ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10104ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.125

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[7].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_9 = arg_53_1:GetWordFromCfg(321021013)
				local var_56_10 = arg_53_1:FormatText(var_56_9.content)

				arg_53_1.text_.text = var_56_10

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_11 = 5
				local var_56_12 = utf8.len(var_56_10)
				local var_56_13 = var_56_11 <= 0 and var_56_7 or var_56_7 * (var_56_12 / var_56_11)

				if var_56_13 > 0 and var_56_7 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_10
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_14 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_14 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_14

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_14 and arg_53_1.time_ < var_56_6 + var_56_14 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play321021014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 321021014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play321021015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10104ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10104ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, 100, 0)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10104ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, 100, 0)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = 0.5
			local var_60_10 = 1

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				local var_60_11 = "play"
				local var_60_12 = "effect"

				arg_57_1:AudioAction(var_60_11, var_60_12, "se_story_1310", "se_story_1310_cardoor02", "")
			end

			local var_60_13 = 0
			local var_60_14 = 1

			if var_60_13 < arg_57_1.time_ and arg_57_1.time_ <= var_60_13 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_15 = arg_57_1:GetWordFromCfg(321021014)
				local var_60_16 = arg_57_1:FormatText(var_60_15.content)

				arg_57_1.text_.text = var_60_16

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 40
				local var_60_18 = utf8.len(var_60_16)
				local var_60_19 = var_60_17 <= 0 and var_60_14 or var_60_14 * (var_60_18 / var_60_17)

				if var_60_19 > 0 and var_60_14 < var_60_19 then
					arg_57_1.talkMaxDuration = var_60_19

					if var_60_19 + var_60_13 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_13
					end
				end

				arg_57_1.text_.text = var_60_16
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_20 = math.max(var_60_14, arg_57_1.talkMaxDuration)

			if var_60_13 <= arg_57_1.time_ and arg_57_1.time_ < var_60_13 + var_60_20 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_13) / var_60_20

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_13 + var_60_20 and arg_57_1.time_ < var_60_13 + var_60_20 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play321021015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 321021015
		arg_61_1.duration_ = 2.93

		local var_61_0 = {
			zh = 2.53266666666667,
			ja = 2.93266666666667
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play321021016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10104ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10104ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(0.02, -1.12, -5.99)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10104ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["10104ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10104ui_story == nil then
				arg_61_1.var_.characterEffect10104ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect10104ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10104ui_story then
				arg_61_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_64_13 = 0

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			local var_64_14 = 0

			if var_64_14 < arg_61_1.time_ and arg_61_1.time_ <= var_64_14 + arg_64_0 then
				arg_61_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_64_15 = 0

			if var_64_15 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			local var_64_16 = 0.766666666666667

			if arg_61_1.time_ >= var_64_15 + var_64_16 and arg_61_1.time_ < var_64_15 + var_64_16 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_17 = 0.766666666666667
			local var_64_18 = 0.075

			if var_64_17 < arg_61_1.time_ and arg_61_1.time_ <= var_64_17 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_19 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_19:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_20 = arg_61_1:FormatText(StoryNameCfg[1030].name)

				arg_61_1.leftNameTxt_.text = var_64_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_21 = arg_61_1:GetWordFromCfg(321021015)
				local var_64_22 = arg_61_1:FormatText(var_64_21.content)

				arg_61_1.text_.text = var_64_22

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_23 = 3
				local var_64_24 = utf8.len(var_64_22)
				local var_64_25 = var_64_23 <= 0 and var_64_18 or var_64_18 * (var_64_24 / var_64_23)

				if var_64_25 > 0 and var_64_18 < var_64_25 then
					arg_61_1.talkMaxDuration = var_64_25
					var_64_17 = var_64_17 + 0.3

					if var_64_25 + var_64_17 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_25 + var_64_17
					end
				end

				arg_61_1.text_.text = var_64_22
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021015", "story_v_out_321021.awb") ~= 0 then
					local var_64_26 = manager.audio:GetVoiceLength("story_v_out_321021", "321021015", "story_v_out_321021.awb") / 1000

					if var_64_26 + var_64_17 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_26 + var_64_17
					end

					if var_64_21.prefab_name ~= "" and arg_61_1.actors_[var_64_21.prefab_name] ~= nil then
						local var_64_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_21.prefab_name].transform, "story_v_out_321021", "321021015", "story_v_out_321021.awb")

						arg_61_1:RecordAudio("321021015", var_64_27)
						arg_61_1:RecordAudio("321021015", var_64_27)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_321021", "321021015", "story_v_out_321021.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_321021", "321021015", "story_v_out_321021.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_28 = var_64_17 + 0.3
			local var_64_29 = math.max(var_64_18, arg_61_1.talkMaxDuration)

			if var_64_28 <= arg_61_1.time_ and arg_61_1.time_ < var_64_28 + var_64_29 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_28) / var_64_29

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_28 + var_64_29 and arg_61_1.time_ < var_64_28 + var_64_29 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play321021016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 321021016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play321021017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["10104ui_story"]
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect10104ui_story == nil then
				arg_67_1.var_.characterEffect10104ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 and not isNil(var_70_0) then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2

				if arg_67_1.var_.characterEffect10104ui_story and not isNil(var_70_0) then
					local var_70_4 = Mathf.Lerp(0, 0.5, var_70_3)

					arg_67_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_67_1.var_.characterEffect10104ui_story.fillRatio = var_70_4
				end
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect10104ui_story then
				local var_70_5 = 0.5

				arg_67_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_67_1.var_.characterEffect10104ui_story.fillRatio = var_70_5
			end

			local var_70_6 = 0
			local var_70_7 = 0.075

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_8 = arg_67_1:FormatText(StoryNameCfg[7].name)

				arg_67_1.leftNameTxt_.text = var_70_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_9 = arg_67_1:GetWordFromCfg(321021016)
				local var_70_10 = arg_67_1:FormatText(var_70_9.content)

				arg_67_1.text_.text = var_70_10

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 3
				local var_70_12 = utf8.len(var_70_10)
				local var_70_13 = var_70_11 <= 0 and var_70_7 or var_70_7 * (var_70_12 / var_70_11)

				if var_70_13 > 0 and var_70_7 < var_70_13 then
					arg_67_1.talkMaxDuration = var_70_13

					if var_70_13 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_13 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_10
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_14 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_14 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_14

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_14 and arg_67_1.time_ < var_70_6 + var_70_14 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play321021017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 321021017
		arg_71_1.duration_ = 4.97

		local var_71_0 = {
			zh = 2.533,
			ja = 4.966
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play321021018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10104ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10104ui_story == nil then
				arg_71_1.var_.characterEffect10104ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect10104ui_story and not isNil(var_74_0) then
					arg_71_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect10104ui_story then
				arg_71_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_74_4 = 0
			local var_74_5 = 0.35

			if var_74_4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_6 = arg_71_1:FormatText(StoryNameCfg[1030].name)

				arg_71_1.leftNameTxt_.text = var_74_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_7 = arg_71_1:GetWordFromCfg(321021017)
				local var_74_8 = arg_71_1:FormatText(var_74_7.content)

				arg_71_1.text_.text = var_74_8

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 14
				local var_74_10 = utf8.len(var_74_8)
				local var_74_11 = var_74_9 <= 0 and var_74_5 or var_74_5 * (var_74_10 / var_74_9)

				if var_74_11 > 0 and var_74_5 < var_74_11 then
					arg_71_1.talkMaxDuration = var_74_11

					if var_74_11 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_8
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021017", "story_v_out_321021.awb") ~= 0 then
					local var_74_12 = manager.audio:GetVoiceLength("story_v_out_321021", "321021017", "story_v_out_321021.awb") / 1000

					if var_74_12 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_4
					end

					if var_74_7.prefab_name ~= "" and arg_71_1.actors_[var_74_7.prefab_name] ~= nil then
						local var_74_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_7.prefab_name].transform, "story_v_out_321021", "321021017", "story_v_out_321021.awb")

						arg_71_1:RecordAudio("321021017", var_74_13)
						arg_71_1:RecordAudio("321021017", var_74_13)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_321021", "321021017", "story_v_out_321021.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_321021", "321021017", "story_v_out_321021.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_14 and arg_71_1.time_ < var_74_4 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play321021018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 321021018
		arg_75_1.duration_ = 6.6

		local var_75_0 = {
			zh = 4.033,
			ja = 6.6
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play321021019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.55

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[1030].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(321021018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 22
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021018", "story_v_out_321021.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_321021", "321021018", "story_v_out_321021.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_321021", "321021018", "story_v_out_321021.awb")

						arg_75_1:RecordAudio("321021018", var_78_9)
						arg_75_1:RecordAudio("321021018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_321021", "321021018", "story_v_out_321021.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_321021", "321021018", "story_v_out_321021.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_10 and arg_75_1.time_ < var_78_0 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play321021019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 321021019
		arg_79_1.duration_ = 1.33

		local var_79_0 = {
			zh = 1.3,
			ja = 1.333
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play321021020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10104ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10104ui_story == nil then
				arg_79_1.var_.characterEffect10104ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect10104ui_story and not isNil(var_82_0) then
					local var_82_4 = Mathf.Lerp(0, 0.5, var_82_3)

					arg_79_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10104ui_story.fillRatio = var_82_4
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect10104ui_story then
				local var_82_5 = 0.5

				arg_79_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10104ui_story.fillRatio = var_82_5
			end

			local var_82_6 = 0
			local var_82_7 = 0.125

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_8 = arg_79_1:FormatText(StoryNameCfg[1166].name)

				arg_79_1.leftNameTxt_.text = var_82_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_9 = arg_79_1:GetWordFromCfg(321021019)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 5
				local var_82_12 = utf8.len(var_82_10)
				local var_82_13 = var_82_11 <= 0 and var_82_7 or var_82_7 * (var_82_12 / var_82_11)

				if var_82_13 > 0 and var_82_7 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021019", "story_v_out_321021.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_321021", "321021019", "story_v_out_321021.awb") / 1000

					if var_82_14 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_6
					end

					if var_82_9.prefab_name ~= "" and arg_79_1.actors_[var_82_9.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_9.prefab_name].transform, "story_v_out_321021", "321021019", "story_v_out_321021.awb")

						arg_79_1:RecordAudio("321021019", var_82_15)
						arg_79_1:RecordAudio("321021019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_321021", "321021019", "story_v_out_321021.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_321021", "321021019", "story_v_out_321021.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_16 and arg_79_1.time_ < var_82_6 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play321021020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321021020
		arg_83_1.duration_ = 9.23

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play321021021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = "ST0506"

			if arg_83_1.bgs_[var_86_0] == nil then
				local var_86_1 = Object.Instantiate(arg_83_1.paintGo_)

				var_86_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_86_0)
				var_86_1.name = var_86_0
				var_86_1.transform.parent = arg_83_1.stage_.transform
				var_86_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.bgs_[var_86_0] = var_86_1
			end

			local var_86_2 = 2.299999999999

			if var_86_2 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				local var_86_3 = manager.ui.mainCamera.transform.localPosition
				local var_86_4 = Vector3.New(0, 0, 10) + Vector3.New(var_86_3.x, var_86_3.y, 0)
				local var_86_5 = arg_83_1.bgs_.ST0506

				var_86_5.transform.localPosition = var_86_4
				var_86_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_86_6 = var_86_5:GetComponent("SpriteRenderer")

				if var_86_6 and var_86_6.sprite then
					local var_86_7 = (var_86_5.transform.localPosition - var_86_3).z
					local var_86_8 = manager.ui.mainCameraCom_
					local var_86_9 = 2 * var_86_7 * Mathf.Tan(var_86_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_86_10 = var_86_9 * var_86_8.aspect
					local var_86_11 = var_86_6.sprite.bounds.size.x
					local var_86_12 = var_86_6.sprite.bounds.size.y
					local var_86_13 = var_86_10 / var_86_11
					local var_86_14 = var_86_9 / var_86_12
					local var_86_15 = var_86_14 < var_86_13 and var_86_13 or var_86_14

					var_86_5.transform.localScale = Vector3.New(var_86_15, var_86_15, 0)
				end

				for iter_86_0, iter_86_1 in pairs(arg_83_1.bgs_) do
					if iter_86_0 ~= "ST0506" then
						iter_86_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_86_16 = 2.299999999999

			if var_86_16 < arg_83_1.time_ and arg_83_1.time_ <= var_86_16 + arg_86_0 then
				arg_83_1.allBtn_.enabled = false
			end

			local var_86_17 = 0.3

			if arg_83_1.time_ >= var_86_16 + var_86_17 and arg_83_1.time_ < var_86_16 + var_86_17 + arg_86_0 then
				arg_83_1.allBtn_.enabled = true
			end

			local var_86_18 = 0

			if var_86_18 < arg_83_1.time_ and arg_83_1.time_ <= var_86_18 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_19 = 2.3

			if var_86_18 <= arg_83_1.time_ and arg_83_1.time_ < var_86_18 + var_86_19 then
				local var_86_20 = (arg_83_1.time_ - var_86_18) / var_86_19
				local var_86_21 = Color.New(0, 0, 0)

				var_86_21.a = Mathf.Lerp(0, 1, var_86_20)
				arg_83_1.mask_.color = var_86_21
			end

			if arg_83_1.time_ >= var_86_18 + var_86_19 and arg_83_1.time_ < var_86_18 + var_86_19 + arg_86_0 then
				local var_86_22 = Color.New(0, 0, 0)

				var_86_22.a = 1
				arg_83_1.mask_.color = var_86_22
			end

			local var_86_23 = 2.299999999999

			if var_86_23 < arg_83_1.time_ and arg_83_1.time_ <= var_86_23 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_24 = 2

			if var_86_23 <= arg_83_1.time_ and arg_83_1.time_ < var_86_23 + var_86_24 then
				local var_86_25 = (arg_83_1.time_ - var_86_23) / var_86_24
				local var_86_26 = Color.New(0, 0, 0)

				var_86_26.a = Mathf.Lerp(1, 0, var_86_25)
				arg_83_1.mask_.color = var_86_26
			end

			if arg_83_1.time_ >= var_86_23 + var_86_24 and arg_83_1.time_ < var_86_23 + var_86_24 + arg_86_0 then
				local var_86_27 = Color.New(0, 0, 0)
				local var_86_28 = 0

				arg_83_1.mask_.enabled = false
				var_86_27.a = var_86_28
				arg_83_1.mask_.color = var_86_27
			end

			local var_86_29 = arg_83_1.actors_["10104ui_story"].transform
			local var_86_30 = 2.26599999815126

			if var_86_30 < arg_83_1.time_ and arg_83_1.time_ <= var_86_30 + arg_86_0 then
				arg_83_1.var_.moveOldPos10104ui_story = var_86_29.localPosition
			end

			local var_86_31 = 0.001

			if var_86_30 <= arg_83_1.time_ and arg_83_1.time_ < var_86_30 + var_86_31 then
				local var_86_32 = (arg_83_1.time_ - var_86_30) / var_86_31
				local var_86_33 = Vector3.New(0, 100, 0)

				var_86_29.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10104ui_story, var_86_33, var_86_32)

				local var_86_34 = manager.ui.mainCamera.transform.position - var_86_29.position

				var_86_29.forward = Vector3.New(var_86_34.x, var_86_34.y, var_86_34.z)

				local var_86_35 = var_86_29.localEulerAngles

				var_86_35.z = 0
				var_86_35.x = 0
				var_86_29.localEulerAngles = var_86_35
			end

			if arg_83_1.time_ >= var_86_30 + var_86_31 and arg_83_1.time_ < var_86_30 + var_86_31 + arg_86_0 then
				var_86_29.localPosition = Vector3.New(0, 100, 0)

				local var_86_36 = manager.ui.mainCamera.transform.position - var_86_29.position

				var_86_29.forward = Vector3.New(var_86_36.x, var_86_36.y, var_86_36.z)

				local var_86_37 = var_86_29.localEulerAngles

				var_86_37.z = 0
				var_86_37.x = 0
				var_86_29.localEulerAngles = var_86_37
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_38 = 4.23333333333333
			local var_86_39 = 1.275

			if var_86_38 < arg_83_1.time_ and arg_83_1.time_ <= var_86_38 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_40 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_40:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_41 = arg_83_1:GetWordFromCfg(321021020)
				local var_86_42 = arg_83_1:FormatText(var_86_41.content)

				arg_83_1.text_.text = var_86_42

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_43 = 51
				local var_86_44 = utf8.len(var_86_42)
				local var_86_45 = var_86_43 <= 0 and var_86_39 or var_86_39 * (var_86_44 / var_86_43)

				if var_86_45 > 0 and var_86_39 < var_86_45 then
					arg_83_1.talkMaxDuration = var_86_45
					var_86_38 = var_86_38 + 0.3

					if var_86_45 + var_86_38 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_45 + var_86_38
					end
				end

				arg_83_1.text_.text = var_86_42
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_46 = var_86_38 + 0.3
			local var_86_47 = math.max(var_86_39, arg_83_1.talkMaxDuration)

			if var_86_46 <= arg_83_1.time_ and arg_83_1.time_ < var_86_46 + var_86_47 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_46) / var_86_47

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_46 + var_86_47 and arg_83_1.time_ < var_86_46 + var_86_47 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.26599999815126,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play321021021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 321021021
		arg_89_1.duration_ = 7.77

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play321021022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = "L13f"

			if arg_89_1.bgs_[var_92_0] == nil then
				local var_92_1 = Object.Instantiate(arg_89_1.paintGo_)

				var_92_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_92_0)
				var_92_1.name = var_92_0
				var_92_1.transform.parent = arg_89_1.stage_.transform
				var_92_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.bgs_[var_92_0] = var_92_1
			end

			local var_92_2 = 1.2

			if var_92_2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				local var_92_3 = manager.ui.mainCamera.transform.localPosition
				local var_92_4 = Vector3.New(0, 0, 10) + Vector3.New(var_92_3.x, var_92_3.y, 0)
				local var_92_5 = arg_89_1.bgs_.L13f

				var_92_5.transform.localPosition = var_92_4
				var_92_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_6 = var_92_5:GetComponent("SpriteRenderer")

				if var_92_6 and var_92_6.sprite then
					local var_92_7 = (var_92_5.transform.localPosition - var_92_3).z
					local var_92_8 = manager.ui.mainCameraCom_
					local var_92_9 = 2 * var_92_7 * Mathf.Tan(var_92_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_92_10 = var_92_9 * var_92_8.aspect
					local var_92_11 = var_92_6.sprite.bounds.size.x
					local var_92_12 = var_92_6.sprite.bounds.size.y
					local var_92_13 = var_92_10 / var_92_11
					local var_92_14 = var_92_9 / var_92_12
					local var_92_15 = var_92_14 < var_92_13 and var_92_13 or var_92_14

					var_92_5.transform.localScale = Vector3.New(var_92_15, var_92_15, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "L13f" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			local var_92_17 = 0.3

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			local var_92_18 = 0

			if var_92_18 < arg_89_1.time_ and arg_89_1.time_ <= var_92_18 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_19 = 1.2

			if var_92_18 <= arg_89_1.time_ and arg_89_1.time_ < var_92_18 + var_92_19 then
				local var_92_20 = (arg_89_1.time_ - var_92_18) / var_92_19
				local var_92_21 = Color.New(0, 0, 0)

				var_92_21.a = Mathf.Lerp(0, 1, var_92_20)
				arg_89_1.mask_.color = var_92_21
			end

			if arg_89_1.time_ >= var_92_18 + var_92_19 and arg_89_1.time_ < var_92_18 + var_92_19 + arg_92_0 then
				local var_92_22 = Color.New(0, 0, 0)

				var_92_22.a = 1
				arg_89_1.mask_.color = var_92_22
			end

			local var_92_23 = 1.2

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_24 = 1.56666666666667

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_24 then
				local var_92_25 = (arg_89_1.time_ - var_92_23) / var_92_24
				local var_92_26 = Color.New(0, 0, 0)

				var_92_26.a = Mathf.Lerp(1, 0, var_92_25)
				arg_89_1.mask_.color = var_92_26
			end

			if arg_89_1.time_ >= var_92_23 + var_92_24 and arg_89_1.time_ < var_92_23 + var_92_24 + arg_92_0 then
				local var_92_27 = Color.New(0, 0, 0)
				local var_92_28 = 0

				arg_89_1.mask_.enabled = false
				var_92_27.a = var_92_28
				arg_89_1.mask_.color = var_92_27
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_29 = 2.76666666666667
			local var_92_30 = 1.2

			if var_92_29 < arg_89_1.time_ and arg_89_1.time_ <= var_92_29 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_31 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_31:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_32 = arg_89_1:GetWordFromCfg(321021021)
				local var_92_33 = arg_89_1:FormatText(var_92_32.content)

				arg_89_1.text_.text = var_92_33

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_34 = 48
				local var_92_35 = utf8.len(var_92_33)
				local var_92_36 = var_92_34 <= 0 and var_92_30 or var_92_30 * (var_92_35 / var_92_34)

				if var_92_36 > 0 and var_92_30 < var_92_36 then
					arg_89_1.talkMaxDuration = var_92_36
					var_92_29 = var_92_29 + 0.3

					if var_92_36 + var_92_29 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_36 + var_92_29
					end
				end

				arg_89_1.text_.text = var_92_33
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_37 = var_92_29 + 0.3
			local var_92_38 = math.max(var_92_30, arg_89_1.talkMaxDuration)

			if var_92_37 <= arg_89_1.time_ and arg_89_1.time_ < var_92_37 + var_92_38 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_37) / var_92_38

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_37 + var_92_38 and arg_89_1.time_ < var_92_37 + var_92_38 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play321021022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321021022
		arg_95_1.duration_ = 4.07

		local var_95_0 = {
			zh = 3.4,
			ja = 4.066
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play321021023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["10104ui_story"].transform
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.var_.moveOldPos10104ui_story = var_98_0.localPosition
			end

			local var_98_2 = 0.001

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2
				local var_98_4 = Vector3.New(0.02, -1.12, -5.99)

				var_98_0.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10104ui_story, var_98_4, var_98_3)

				local var_98_5 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_5.x, var_98_5.y, var_98_5.z)

				local var_98_6 = var_98_0.localEulerAngles

				var_98_6.z = 0
				var_98_6.x = 0
				var_98_0.localEulerAngles = var_98_6
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 then
				var_98_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_98_7 = manager.ui.mainCamera.transform.position - var_98_0.position

				var_98_0.forward = Vector3.New(var_98_7.x, var_98_7.y, var_98_7.z)

				local var_98_8 = var_98_0.localEulerAngles

				var_98_8.z = 0
				var_98_8.x = 0
				var_98_0.localEulerAngles = var_98_8
			end

			local var_98_9 = arg_95_1.actors_["10104ui_story"]
			local var_98_10 = 0

			if var_98_10 < arg_95_1.time_ and arg_95_1.time_ <= var_98_10 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect10104ui_story == nil then
				arg_95_1.var_.characterEffect10104ui_story = var_98_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_11 = 0.200000002980232

			if var_98_10 <= arg_95_1.time_ and arg_95_1.time_ < var_98_10 + var_98_11 and not isNil(var_98_9) then
				local var_98_12 = (arg_95_1.time_ - var_98_10) / var_98_11

				if arg_95_1.var_.characterEffect10104ui_story and not isNil(var_98_9) then
					arg_95_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_10 + var_98_11 and arg_95_1.time_ < var_98_10 + var_98_11 + arg_98_0 and not isNil(var_98_9) and arg_95_1.var_.characterEffect10104ui_story then
				arg_95_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_98_13 = 0

			if var_98_13 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_98_14 = 0

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_98_15 = 0
			local var_98_16 = 0.45

			if var_98_15 < arg_95_1.time_ and arg_95_1.time_ <= var_98_15 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_17 = arg_95_1:FormatText(StoryNameCfg[1030].name)

				arg_95_1.leftNameTxt_.text = var_98_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_18 = arg_95_1:GetWordFromCfg(321021022)
				local var_98_19 = arg_95_1:FormatText(var_98_18.content)

				arg_95_1.text_.text = var_98_19

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_20 = 18
				local var_98_21 = utf8.len(var_98_19)
				local var_98_22 = var_98_20 <= 0 and var_98_16 or var_98_16 * (var_98_21 / var_98_20)

				if var_98_22 > 0 and var_98_16 < var_98_22 then
					arg_95_1.talkMaxDuration = var_98_22

					if var_98_22 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_22 + var_98_15
					end
				end

				arg_95_1.text_.text = var_98_19
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021022", "story_v_out_321021.awb") ~= 0 then
					local var_98_23 = manager.audio:GetVoiceLength("story_v_out_321021", "321021022", "story_v_out_321021.awb") / 1000

					if var_98_23 + var_98_15 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_23 + var_98_15
					end

					if var_98_18.prefab_name ~= "" and arg_95_1.actors_[var_98_18.prefab_name] ~= nil then
						local var_98_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_18.prefab_name].transform, "story_v_out_321021", "321021022", "story_v_out_321021.awb")

						arg_95_1:RecordAudio("321021022", var_98_24)
						arg_95_1:RecordAudio("321021022", var_98_24)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_321021", "321021022", "story_v_out_321021.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_321021", "321021022", "story_v_out_321021.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_25 = math.max(var_98_16, arg_95_1.talkMaxDuration)

			if var_98_15 <= arg_95_1.time_ and arg_95_1.time_ < var_98_15 + var_98_25 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_15) / var_98_25

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_15 + var_98_25 and arg_95_1.time_ < var_98_15 + var_98_25 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play321021023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321021023
		arg_99_1.duration_ = 2

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play321021024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["10104ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos10104ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, 100, 0)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10104ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, 100, 0)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = "1043ui_story"

			if arg_99_1.actors_[var_102_9] == nil then
				local var_102_10 = Asset.Load("Char/" .. "1043ui_story")

				if not isNil(var_102_10) then
					local var_102_11 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_99_1.stage_.transform)

					var_102_11.name = var_102_9
					var_102_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_99_1.actors_[var_102_9] = var_102_11

					local var_102_12 = var_102_11:GetComponentInChildren(typeof(CharacterEffect))

					var_102_12.enabled = true

					local var_102_13 = GameObjectTools.GetOrAddComponent(var_102_11, typeof(DynamicBoneHelper))

					if var_102_13 then
						var_102_13:EnableDynamicBone(false)
					end

					arg_99_1:ShowWeapon(var_102_12.transform, false)

					arg_99_1.var_[var_102_9 .. "Animator"] = var_102_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_99_1.var_[var_102_9 .. "Animator"].applyRootMotion = true
					arg_99_1.var_[var_102_9 .. "LipSync"] = var_102_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_102_14 = arg_99_1.actors_["1043ui_story"].transform
			local var_102_15 = 0

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 then
				arg_99_1.var_.moveOldPos1043ui_story = var_102_14.localPosition
			end

			local var_102_16 = 0.001

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_16 then
				local var_102_17 = (arg_99_1.time_ - var_102_15) / var_102_16
				local var_102_18 = Vector3.New(0.01, -1.01, -5.73)

				var_102_14.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1043ui_story, var_102_18, var_102_17)

				local var_102_19 = manager.ui.mainCamera.transform.position - var_102_14.position

				var_102_14.forward = Vector3.New(var_102_19.x, var_102_19.y, var_102_19.z)

				local var_102_20 = var_102_14.localEulerAngles

				var_102_20.z = 0
				var_102_20.x = 0
				var_102_14.localEulerAngles = var_102_20
			end

			if arg_99_1.time_ >= var_102_15 + var_102_16 and arg_99_1.time_ < var_102_15 + var_102_16 + arg_102_0 then
				var_102_14.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_102_21 = manager.ui.mainCamera.transform.position - var_102_14.position

				var_102_14.forward = Vector3.New(var_102_21.x, var_102_21.y, var_102_21.z)

				local var_102_22 = var_102_14.localEulerAngles

				var_102_22.z = 0
				var_102_22.x = 0
				var_102_14.localEulerAngles = var_102_22
			end

			local var_102_23 = arg_99_1.actors_["1043ui_story"]
			local var_102_24 = 0

			if var_102_24 < arg_99_1.time_ and arg_99_1.time_ <= var_102_24 + arg_102_0 and not isNil(var_102_23) and arg_99_1.var_.characterEffect1043ui_story == nil then
				arg_99_1.var_.characterEffect1043ui_story = var_102_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_25 = 0.200000002980232

			if var_102_24 <= arg_99_1.time_ and arg_99_1.time_ < var_102_24 + var_102_25 and not isNil(var_102_23) then
				local var_102_26 = (arg_99_1.time_ - var_102_24) / var_102_25

				if arg_99_1.var_.characterEffect1043ui_story and not isNil(var_102_23) then
					arg_99_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_24 + var_102_25 and arg_99_1.time_ < var_102_24 + var_102_25 + arg_102_0 and not isNil(var_102_23) and arg_99_1.var_.characterEffect1043ui_story then
				arg_99_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_102_27 = arg_99_1.actors_["10104ui_story"]
			local var_102_28 = 0

			if var_102_28 < arg_99_1.time_ and arg_99_1.time_ <= var_102_28 + arg_102_0 and not isNil(var_102_27) and arg_99_1.var_.characterEffect10104ui_story == nil then
				arg_99_1.var_.characterEffect10104ui_story = var_102_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_29 = 0.200000002980232

			if var_102_28 <= arg_99_1.time_ and arg_99_1.time_ < var_102_28 + var_102_29 and not isNil(var_102_27) then
				local var_102_30 = (arg_99_1.time_ - var_102_28) / var_102_29

				if arg_99_1.var_.characterEffect10104ui_story and not isNil(var_102_27) then
					local var_102_31 = Mathf.Lerp(0, 0.5, var_102_30)

					arg_99_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_99_1.var_.characterEffect10104ui_story.fillRatio = var_102_31
				end
			end

			if arg_99_1.time_ >= var_102_28 + var_102_29 and arg_99_1.time_ < var_102_28 + var_102_29 + arg_102_0 and not isNil(var_102_27) and arg_99_1.var_.characterEffect10104ui_story then
				local var_102_32 = 0.5

				arg_99_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_99_1.var_.characterEffect10104ui_story.fillRatio = var_102_32
			end

			local var_102_33 = 0

			if var_102_33 < arg_99_1.time_ and arg_99_1.time_ <= var_102_33 + arg_102_0 then
				arg_99_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_102_34 = 0

			if var_102_34 < arg_99_1.time_ and arg_99_1.time_ <= var_102_34 + arg_102_0 then
				arg_99_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_102_35 = 0
			local var_102_36 = 0.125

			if var_102_35 < arg_99_1.time_ and arg_99_1.time_ <= var_102_35 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_37 = arg_99_1:FormatText(StoryNameCfg[1156].name)

				arg_99_1.leftNameTxt_.text = var_102_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_38 = arg_99_1:GetWordFromCfg(321021023)
				local var_102_39 = arg_99_1:FormatText(var_102_38.content)

				arg_99_1.text_.text = var_102_39

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_40 = 5
				local var_102_41 = utf8.len(var_102_39)
				local var_102_42 = var_102_40 <= 0 and var_102_36 or var_102_36 * (var_102_41 / var_102_40)

				if var_102_42 > 0 and var_102_36 < var_102_42 then
					arg_99_1.talkMaxDuration = var_102_42

					if var_102_42 + var_102_35 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_42 + var_102_35
					end
				end

				arg_99_1.text_.text = var_102_39
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021023", "story_v_out_321021.awb") ~= 0 then
					local var_102_43 = manager.audio:GetVoiceLength("story_v_out_321021", "321021023", "story_v_out_321021.awb") / 1000

					if var_102_43 + var_102_35 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_43 + var_102_35
					end

					if var_102_38.prefab_name ~= "" and arg_99_1.actors_[var_102_38.prefab_name] ~= nil then
						local var_102_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_38.prefab_name].transform, "story_v_out_321021", "321021023", "story_v_out_321021.awb")

						arg_99_1:RecordAudio("321021023", var_102_44)
						arg_99_1:RecordAudio("321021023", var_102_44)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_321021", "321021023", "story_v_out_321021.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_321021", "321021023", "story_v_out_321021.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_45 = math.max(var_102_36, arg_99_1.talkMaxDuration)

			if var_102_35 <= arg_99_1.time_ and arg_99_1.time_ < var_102_35 + var_102_45 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_35) / var_102_45

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_35 + var_102_45 and arg_99_1.time_ < var_102_35 + var_102_45 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play321021024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321021024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play321021025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1043ui_story"]
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1043ui_story == nil then
				arg_103_1.var_.characterEffect1043ui_story = var_106_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 and not isNil(var_106_0) then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2

				if arg_103_1.var_.characterEffect1043ui_story and not isNil(var_106_0) then
					local var_106_4 = Mathf.Lerp(0, 0.5, var_106_3)

					arg_103_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1043ui_story.fillRatio = var_106_4
				end
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 and not isNil(var_106_0) and arg_103_1.var_.characterEffect1043ui_story then
				local var_106_5 = 0.5

				arg_103_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1043ui_story.fillRatio = var_106_5
			end

			local var_106_6 = 0
			local var_106_7 = 1.6

			if var_106_6 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_8 = arg_103_1:GetWordFromCfg(321021024)
				local var_106_9 = arg_103_1:FormatText(var_106_8.content)

				arg_103_1.text_.text = var_106_9

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 64
				local var_106_11 = utf8.len(var_106_9)
				local var_106_12 = var_106_10 <= 0 and var_106_7 or var_106_7 * (var_106_11 / var_106_10)

				if var_106_12 > 0 and var_106_7 < var_106_12 then
					arg_103_1.talkMaxDuration = var_106_12

					if var_106_12 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_12 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_9
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_13 and arg_103_1.time_ < var_106_6 + var_106_13 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play321021025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 321021025
		arg_107_1.duration_ = 8.97

		local var_107_0 = {
			zh = 6.7,
			ja = 8.966
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play321021026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10104ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10104ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(-0.88, -1.12, -5.99)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10104ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(-0.88, -1.12, -5.99)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = arg_107_1.actors_["1043ui_story"].transform
			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 then
				arg_107_1.var_.moveOldPos1043ui_story = var_110_9.localPosition
			end

			local var_110_11 = 0.001

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_11 then
				local var_110_12 = (arg_107_1.time_ - var_110_10) / var_110_11
				local var_110_13 = Vector3.New(0.81, -1.01, -5.73)

				var_110_9.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1043ui_story, var_110_13, var_110_12)

				local var_110_14 = manager.ui.mainCamera.transform.position - var_110_9.position

				var_110_9.forward = Vector3.New(var_110_14.x, var_110_14.y, var_110_14.z)

				local var_110_15 = var_110_9.localEulerAngles

				var_110_15.z = 0
				var_110_15.x = 0
				var_110_9.localEulerAngles = var_110_15
			end

			if arg_107_1.time_ >= var_110_10 + var_110_11 and arg_107_1.time_ < var_110_10 + var_110_11 + arg_110_0 then
				var_110_9.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_110_16 = manager.ui.mainCamera.transform.position - var_110_9.position

				var_110_9.forward = Vector3.New(var_110_16.x, var_110_16.y, var_110_16.z)

				local var_110_17 = var_110_9.localEulerAngles

				var_110_17.z = 0
				var_110_17.x = 0
				var_110_9.localEulerAngles = var_110_17
			end

			local var_110_18 = arg_107_1.actors_["10104ui_story"]
			local var_110_19 = 0

			if var_110_19 < arg_107_1.time_ and arg_107_1.time_ <= var_110_19 + arg_110_0 and not isNil(var_110_18) and arg_107_1.var_.characterEffect10104ui_story == nil then
				arg_107_1.var_.characterEffect10104ui_story = var_110_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_20 = 0.200000002980232

			if var_110_19 <= arg_107_1.time_ and arg_107_1.time_ < var_110_19 + var_110_20 and not isNil(var_110_18) then
				local var_110_21 = (arg_107_1.time_ - var_110_19) / var_110_20

				if arg_107_1.var_.characterEffect10104ui_story and not isNil(var_110_18) then
					arg_107_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_19 + var_110_20 and arg_107_1.time_ < var_110_19 + var_110_20 + arg_110_0 and not isNil(var_110_18) and arg_107_1.var_.characterEffect10104ui_story then
				arg_107_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_110_22 = 0

			if var_110_22 < arg_107_1.time_ and arg_107_1.time_ <= var_110_22 + arg_110_0 then
				arg_107_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			local var_110_23 = 0

			if var_110_23 < arg_107_1.time_ and arg_107_1.time_ <= var_110_23 + arg_110_0 then
				arg_107_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_110_24 = 0
			local var_110_25 = 0.825

			if var_110_24 < arg_107_1.time_ and arg_107_1.time_ <= var_110_24 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_26 = arg_107_1:FormatText(StoryNameCfg[1030].name)

				arg_107_1.leftNameTxt_.text = var_110_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_27 = arg_107_1:GetWordFromCfg(321021025)
				local var_110_28 = arg_107_1:FormatText(var_110_27.content)

				arg_107_1.text_.text = var_110_28

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_29 = 33
				local var_110_30 = utf8.len(var_110_28)
				local var_110_31 = var_110_29 <= 0 and var_110_25 or var_110_25 * (var_110_30 / var_110_29)

				if var_110_31 > 0 and var_110_25 < var_110_31 then
					arg_107_1.talkMaxDuration = var_110_31

					if var_110_31 + var_110_24 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_31 + var_110_24
					end
				end

				arg_107_1.text_.text = var_110_28
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021025", "story_v_out_321021.awb") ~= 0 then
					local var_110_32 = manager.audio:GetVoiceLength("story_v_out_321021", "321021025", "story_v_out_321021.awb") / 1000

					if var_110_32 + var_110_24 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_32 + var_110_24
					end

					if var_110_27.prefab_name ~= "" and arg_107_1.actors_[var_110_27.prefab_name] ~= nil then
						local var_110_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_27.prefab_name].transform, "story_v_out_321021", "321021025", "story_v_out_321021.awb")

						arg_107_1:RecordAudio("321021025", var_110_33)
						arg_107_1:RecordAudio("321021025", var_110_33)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_321021", "321021025", "story_v_out_321021.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_321021", "321021025", "story_v_out_321021.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_34 = math.max(var_110_25, arg_107_1.talkMaxDuration)

			if var_110_24 <= arg_107_1.time_ and arg_107_1.time_ < var_110_24 + var_110_34 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_24) / var_110_34

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_24 + var_110_34 and arg_107_1.time_ < var_110_24 + var_110_34 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play321021026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 321021026
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play321021027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10104ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10104ui_story == nil then
				arg_111_1.var_.characterEffect10104ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect10104ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10104ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10104ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10104ui_story.fillRatio = var_114_5
			end

			local var_114_6 = 0
			local var_114_7 = 0.3

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_8 = arg_111_1:FormatText(StoryNameCfg[7].name)

				arg_111_1.leftNameTxt_.text = var_114_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_9 = arg_111_1:GetWordFromCfg(321021026)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 12
				local var_114_12 = utf8.len(var_114_10)
				local var_114_13 = var_114_11 <= 0 and var_114_7 or var_114_7 * (var_114_12 / var_114_11)

				if var_114_13 > 0 and var_114_7 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_10
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_14 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_14 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_14

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_14 and arg_111_1.time_ < var_114_6 + var_114_14 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play321021027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 321021027
		arg_115_1.duration_ = 8.13

		local var_115_0 = {
			zh = 7.933,
			ja = 8.133
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play321021028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1043ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1043ui_story == nil then
				arg_115_1.var_.characterEffect1043ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1043ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1043ui_story then
				arg_115_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_118_4 = 0
			local var_118_5 = 0.95

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_6 = arg_115_1:FormatText(StoryNameCfg[1156].name)

				arg_115_1.leftNameTxt_.text = var_118_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_7 = arg_115_1:GetWordFromCfg(321021027)
				local var_118_8 = arg_115_1:FormatText(var_118_7.content)

				arg_115_1.text_.text = var_118_8

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 38
				local var_118_10 = utf8.len(var_118_8)
				local var_118_11 = var_118_9 <= 0 and var_118_5 or var_118_5 * (var_118_10 / var_118_9)

				if var_118_11 > 0 and var_118_5 < var_118_11 then
					arg_115_1.talkMaxDuration = var_118_11

					if var_118_11 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_8
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021027", "story_v_out_321021.awb") ~= 0 then
					local var_118_12 = manager.audio:GetVoiceLength("story_v_out_321021", "321021027", "story_v_out_321021.awb") / 1000

					if var_118_12 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_12 + var_118_4
					end

					if var_118_7.prefab_name ~= "" and arg_115_1.actors_[var_118_7.prefab_name] ~= nil then
						local var_118_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_7.prefab_name].transform, "story_v_out_321021", "321021027", "story_v_out_321021.awb")

						arg_115_1:RecordAudio("321021027", var_118_13)
						arg_115_1:RecordAudio("321021027", var_118_13)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_321021", "321021027", "story_v_out_321021.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_321021", "321021027", "story_v_out_321021.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_14 and arg_115_1.time_ < var_118_4 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play321021028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 321021028
		arg_119_1.duration_ = 2.03

		local var_119_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play321021029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action6_1")
			end

			local var_122_1 = 0
			local var_122_2 = 0.15

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_3 = arg_119_1:FormatText(StoryNameCfg[1156].name)

				arg_119_1.leftNameTxt_.text = var_122_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:GetWordFromCfg(321021028)
				local var_122_5 = arg_119_1:FormatText(var_122_4.content)

				arg_119_1.text_.text = var_122_5

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_6 = 6
				local var_122_7 = utf8.len(var_122_5)
				local var_122_8 = var_122_6 <= 0 and var_122_2 or var_122_2 * (var_122_7 / var_122_6)

				if var_122_8 > 0 and var_122_2 < var_122_8 then
					arg_119_1.talkMaxDuration = var_122_8

					if var_122_8 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_1
					end
				end

				arg_119_1.text_.text = var_122_5
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021028", "story_v_out_321021.awb") ~= 0 then
					local var_122_9 = manager.audio:GetVoiceLength("story_v_out_321021", "321021028", "story_v_out_321021.awb") / 1000

					if var_122_9 + var_122_1 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_1
					end

					if var_122_4.prefab_name ~= "" and arg_119_1.actors_[var_122_4.prefab_name] ~= nil then
						local var_122_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_4.prefab_name].transform, "story_v_out_321021", "321021028", "story_v_out_321021.awb")

						arg_119_1:RecordAudio("321021028", var_122_10)
						arg_119_1:RecordAudio("321021028", var_122_10)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_321021", "321021028", "story_v_out_321021.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_321021", "321021028", "story_v_out_321021.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_11 = math.max(var_122_2, arg_119_1.talkMaxDuration)

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_11 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_1) / var_122_11

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_1 + var_122_11 and arg_119_1.time_ < var_122_1 + var_122_11 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play321021029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321021029
		arg_123_1.duration_ = 6.93

		local var_123_0 = {
			zh = 5.1,
			ja = 6.933
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play321021030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["1043ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1043ui_story == nil then
				arg_123_1.var_.characterEffect1043ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect1043ui_story and not isNil(var_126_0) then
					local var_126_4 = Mathf.Lerp(0, 0.5, var_126_3)

					arg_123_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1043ui_story.fillRatio = var_126_4
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1043ui_story then
				local var_126_5 = 0.5

				arg_123_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1043ui_story.fillRatio = var_126_5
			end

			local var_126_6 = 0

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action6_2")
			end

			local var_126_7 = 0
			local var_126_8 = 0.65

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_9 = arg_123_1:FormatText(StoryNameCfg[1165].name)

				arg_123_1.leftNameTxt_.text = var_126_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_10 = arg_123_1:GetWordFromCfg(321021029)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_12 = 26
				local var_126_13 = utf8.len(var_126_11)
				local var_126_14 = var_126_12 <= 0 and var_126_8 or var_126_8 * (var_126_13 / var_126_12)

				if var_126_14 > 0 and var_126_8 < var_126_14 then
					arg_123_1.talkMaxDuration = var_126_14

					if var_126_14 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_7
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021029", "story_v_out_321021.awb") ~= 0 then
					local var_126_15 = manager.audio:GetVoiceLength("story_v_out_321021", "321021029", "story_v_out_321021.awb") / 1000

					if var_126_15 + var_126_7 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_15 + var_126_7
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_321021", "321021029", "story_v_out_321021.awb")

						arg_123_1:RecordAudio("321021029", var_126_16)
						arg_123_1:RecordAudio("321021029", var_126_16)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_321021", "321021029", "story_v_out_321021.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_321021", "321021029", "story_v_out_321021.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_17 = math.max(var_126_8, arg_123_1.talkMaxDuration)

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_17 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_7) / var_126_17

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_7 + var_126_17 and arg_123_1.time_ < var_126_7 + var_126_17 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play321021030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 321021030
		arg_127_1.duration_ = 1

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"

			SetActive(arg_127_1.choicesGo_, true)

			for iter_128_0, iter_128_1 in ipairs(arg_127_1.choices_) do
				local var_128_0 = iter_128_0 <= 2

				SetActive(iter_128_1.go, var_128_0)
			end

			arg_127_1.choices_[1].txt.text = arg_127_1:FormatText(StoryChoiceCfg[1249].name)
			arg_127_1.choices_[2].txt.text = arg_127_1:FormatText(StoryChoiceCfg[1250].name)
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play321021031(arg_127_1)
			end

			if arg_129_0 == 2 then
				arg_127_0:Play321021031(arg_127_1)
			end

			arg_127_1:RecordChoiceLog(321021030, 1249, 1250)
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			return
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play321021031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 321021031
		arg_131_1.duration_ = 2

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play321021032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10104ui_story"]
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect10104ui_story == nil then
				arg_131_1.var_.characterEffect10104ui_story = var_134_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_2 = 0.200000002980232

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 and not isNil(var_134_0) then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2

				if arg_131_1.var_.characterEffect10104ui_story and not isNil(var_134_0) then
					arg_131_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 and not isNil(var_134_0) and arg_131_1.var_.characterEffect10104ui_story then
				arg_131_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_134_4 = "10104ui_story"

			if arg_131_1.actors_[var_134_4] == nil then
				local var_134_5 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_134_5) then
					local var_134_6 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_131_1.stage_.transform)

					var_134_6.name = var_134_4
					var_134_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_131_1.actors_[var_134_4] = var_134_6

					local var_134_7 = var_134_6:GetComponentInChildren(typeof(CharacterEffect))

					var_134_7.enabled = true

					local var_134_8 = GameObjectTools.GetOrAddComponent(var_134_6, typeof(DynamicBoneHelper))

					if var_134_8 then
						var_134_8:EnableDynamicBone(false)
					end

					arg_131_1:ShowWeapon(var_134_7.transform, false)

					arg_131_1.var_[var_134_4 .. "Animator"] = var_134_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_131_1.var_[var_134_4 .. "Animator"].applyRootMotion = true
					arg_131_1.var_[var_134_4 .. "LipSync"] = var_134_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_134_9 = 0

			if var_134_9 < arg_131_1.time_ and arg_131_1.time_ <= var_134_9 + arg_134_0 then
				arg_131_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_2")
			end

			local var_134_10 = "10104ui_story"

			if arg_131_1.actors_[var_134_10] == nil then
				local var_134_11 = Asset.Load("Char/" .. "10104ui_story")

				if not isNil(var_134_11) then
					local var_134_12 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_131_1.stage_.transform)

					var_134_12.name = var_134_10
					var_134_12.transform.localPosition = Vector3.New(0, 100, 0)
					arg_131_1.actors_[var_134_10] = var_134_12

					local var_134_13 = var_134_12:GetComponentInChildren(typeof(CharacterEffect))

					var_134_13.enabled = true

					local var_134_14 = GameObjectTools.GetOrAddComponent(var_134_12, typeof(DynamicBoneHelper))

					if var_134_14 then
						var_134_14:EnableDynamicBone(false)
					end

					arg_131_1:ShowWeapon(var_134_13.transform, false)

					arg_131_1.var_[var_134_10 .. "Animator"] = var_134_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_131_1.var_[var_134_10 .. "Animator"].applyRootMotion = true
					arg_131_1.var_[var_134_10 .. "LipSync"] = var_134_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_134_15 = 0

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_134_16 = 0
			local var_134_17 = 0.125

			if var_134_16 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_18 = arg_131_1:FormatText(StoryNameCfg[1030].name)

				arg_131_1.leftNameTxt_.text = var_134_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_19 = arg_131_1:GetWordFromCfg(321021031)
				local var_134_20 = arg_131_1:FormatText(var_134_19.content)

				arg_131_1.text_.text = var_134_20

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_21 = 5
				local var_134_22 = utf8.len(var_134_20)
				local var_134_23 = var_134_21 <= 0 and var_134_17 or var_134_17 * (var_134_22 / var_134_21)

				if var_134_23 > 0 and var_134_17 < var_134_23 then
					arg_131_1.talkMaxDuration = var_134_23

					if var_134_23 + var_134_16 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_16
					end
				end

				arg_131_1.text_.text = var_134_20
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021031", "story_v_out_321021.awb") ~= 0 then
					local var_134_24 = manager.audio:GetVoiceLength("story_v_out_321021", "321021031", "story_v_out_321021.awb") / 1000

					if var_134_24 + var_134_16 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_24 + var_134_16
					end

					if var_134_19.prefab_name ~= "" and arg_131_1.actors_[var_134_19.prefab_name] ~= nil then
						local var_134_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_19.prefab_name].transform, "story_v_out_321021", "321021031", "story_v_out_321021.awb")

						arg_131_1:RecordAudio("321021031", var_134_25)
						arg_131_1:RecordAudio("321021031", var_134_25)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_321021", "321021031", "story_v_out_321021.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_321021", "321021031", "story_v_out_321021.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_26 = math.max(var_134_17, arg_131_1.talkMaxDuration)

			if var_134_16 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_26 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_16) / var_134_26

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_16 + var_134_26 and arg_131_1.time_ < var_134_16 + var_134_26 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play321021032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 321021032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play321021033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10104ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect10104ui_story == nil then
				arg_135_1.var_.characterEffect10104ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect10104ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10104ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect10104ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10104ui_story.fillRatio = var_138_5
			end

			local var_138_6 = 0.1
			local var_138_7 = 1

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				local var_138_8 = "play"
				local var_138_9 = "effect"

				arg_135_1:AudioAction(var_138_8, var_138_9, "se_story_side_1094", "se_story_1094_data", "")
			end

			local var_138_10 = 0
			local var_138_11 = 1.1

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_12 = arg_135_1:GetWordFromCfg(321021032)
				local var_138_13 = arg_135_1:FormatText(var_138_12.content)

				arg_135_1.text_.text = var_138_13

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_14 = 44
				local var_138_15 = utf8.len(var_138_13)
				local var_138_16 = var_138_14 <= 0 and var_138_11 or var_138_11 * (var_138_15 / var_138_14)

				if var_138_16 > 0 and var_138_11 < var_138_16 then
					arg_135_1.talkMaxDuration = var_138_16

					if var_138_16 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_10
					end
				end

				arg_135_1.text_.text = var_138_13
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_17 = math.max(var_138_11, arg_135_1.talkMaxDuration)

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_17 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_10) / var_138_17

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_10 + var_138_17 and arg_135_1.time_ < var_138_10 + var_138_17 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play321021033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 321021033
		arg_139_1.duration_ = 4.03

		local var_139_0 = {
			zh = 3.9,
			ja = 4.033
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play321021034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10104ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10104ui_story == nil then
				arg_139_1.var_.characterEffect10104ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect10104ui_story and not isNil(var_142_0) then
					arg_139_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10104ui_story then
				arg_139_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_142_4 = 0
			local var_142_5 = 0.65

			if var_142_4 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_6 = arg_139_1:FormatText(StoryNameCfg[1030].name)

				arg_139_1.leftNameTxt_.text = var_142_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_7 = arg_139_1:GetWordFromCfg(321021033)
				local var_142_8 = arg_139_1:FormatText(var_142_7.content)

				arg_139_1.text_.text = var_142_8

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 26
				local var_142_10 = utf8.len(var_142_8)
				local var_142_11 = var_142_9 <= 0 and var_142_5 or var_142_5 * (var_142_10 / var_142_9)

				if var_142_11 > 0 and var_142_5 < var_142_11 then
					arg_139_1.talkMaxDuration = var_142_11

					if var_142_11 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_8
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021033", "story_v_out_321021.awb") ~= 0 then
					local var_142_12 = manager.audio:GetVoiceLength("story_v_out_321021", "321021033", "story_v_out_321021.awb") / 1000

					if var_142_12 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_12 + var_142_4
					end

					if var_142_7.prefab_name ~= "" and arg_139_1.actors_[var_142_7.prefab_name] ~= nil then
						local var_142_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_7.prefab_name].transform, "story_v_out_321021", "321021033", "story_v_out_321021.awb")

						arg_139_1:RecordAudio("321021033", var_142_13)
						arg_139_1:RecordAudio("321021033", var_142_13)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_321021", "321021033", "story_v_out_321021.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_321021", "321021033", "story_v_out_321021.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_14 and arg_139_1.time_ < var_142_4 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play321021034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321021034
		arg_143_1.duration_ = 9

		local var_143_0 = {
			zh = 6.066,
			ja = 9
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play321021035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_146_1 = 0
			local var_146_2 = 0.875

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_3 = arg_143_1:FormatText(StoryNameCfg[1030].name)

				arg_143_1.leftNameTxt_.text = var_146_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(321021034)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_6 = 35
				local var_146_7 = utf8.len(var_146_5)
				local var_146_8 = var_146_6 <= 0 and var_146_2 or var_146_2 * (var_146_7 / var_146_6)

				if var_146_8 > 0 and var_146_2 < var_146_8 then
					arg_143_1.talkMaxDuration = var_146_8

					if var_146_8 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021034", "story_v_out_321021.awb") ~= 0 then
					local var_146_9 = manager.audio:GetVoiceLength("story_v_out_321021", "321021034", "story_v_out_321021.awb") / 1000

					if var_146_9 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_1
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_out_321021", "321021034", "story_v_out_321021.awb")

						arg_143_1:RecordAudio("321021034", var_146_10)
						arg_143_1:RecordAudio("321021034", var_146_10)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_321021", "321021034", "story_v_out_321021.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_321021", "321021034", "story_v_out_321021.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_11 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_11 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_11

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_11 and arg_143_1.time_ < var_146_1 + var_146_11 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play321021035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321021035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play321021036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10104ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10104ui_story == nil then
				arg_147_1.var_.characterEffect10104ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect10104ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10104ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect10104ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10104ui_story.fillRatio = var_150_5
			end

			local var_150_6 = arg_147_1.actors_["10104ui_story"].transform
			local var_150_7 = 0

			if var_150_7 < arg_147_1.time_ and arg_147_1.time_ <= var_150_7 + arg_150_0 then
				arg_147_1.var_.moveOldPos10104ui_story = var_150_6.localPosition
			end

			local var_150_8 = 0.001

			if var_150_7 <= arg_147_1.time_ and arg_147_1.time_ < var_150_7 + var_150_8 then
				local var_150_9 = (arg_147_1.time_ - var_150_7) / var_150_8
				local var_150_10 = Vector3.New(0, 100, 0)

				var_150_6.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10104ui_story, var_150_10, var_150_9)

				local var_150_11 = manager.ui.mainCamera.transform.position - var_150_6.position

				var_150_6.forward = Vector3.New(var_150_11.x, var_150_11.y, var_150_11.z)

				local var_150_12 = var_150_6.localEulerAngles

				var_150_12.z = 0
				var_150_12.x = 0
				var_150_6.localEulerAngles = var_150_12
			end

			if arg_147_1.time_ >= var_150_7 + var_150_8 and arg_147_1.time_ < var_150_7 + var_150_8 + arg_150_0 then
				var_150_6.localPosition = Vector3.New(0, 100, 0)

				local var_150_13 = manager.ui.mainCamera.transform.position - var_150_6.position

				var_150_6.forward = Vector3.New(var_150_13.x, var_150_13.y, var_150_13.z)

				local var_150_14 = var_150_6.localEulerAngles

				var_150_14.z = 0
				var_150_14.x = 0
				var_150_6.localEulerAngles = var_150_14
			end

			local var_150_15 = arg_147_1.actors_["1043ui_story"].transform
			local var_150_16 = 0

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.var_.moveOldPos1043ui_story = var_150_15.localPosition
			end

			local var_150_17 = 0.001

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 then
				local var_150_18 = (arg_147_1.time_ - var_150_16) / var_150_17
				local var_150_19 = Vector3.New(0, 100, 0)

				var_150_15.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1043ui_story, var_150_19, var_150_18)

				local var_150_20 = manager.ui.mainCamera.transform.position - var_150_15.position

				var_150_15.forward = Vector3.New(var_150_20.x, var_150_20.y, var_150_20.z)

				local var_150_21 = var_150_15.localEulerAngles

				var_150_21.z = 0
				var_150_21.x = 0
				var_150_15.localEulerAngles = var_150_21
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 then
				var_150_15.localPosition = Vector3.New(0, 100, 0)

				local var_150_22 = manager.ui.mainCamera.transform.position - var_150_15.position

				var_150_15.forward = Vector3.New(var_150_22.x, var_150_22.y, var_150_22.z)

				local var_150_23 = var_150_15.localEulerAngles

				var_150_23.z = 0
				var_150_23.x = 0
				var_150_15.localEulerAngles = var_150_23
			end

			local var_150_24 = 0
			local var_150_25 = 1.275

			if var_150_24 < arg_147_1.time_ and arg_147_1.time_ <= var_150_24 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_26 = arg_147_1:GetWordFromCfg(321021035)
				local var_150_27 = arg_147_1:FormatText(var_150_26.content)

				arg_147_1.text_.text = var_150_27

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_28 = 51
				local var_150_29 = utf8.len(var_150_27)
				local var_150_30 = var_150_28 <= 0 and var_150_25 or var_150_25 * (var_150_29 / var_150_28)

				if var_150_30 > 0 and var_150_25 < var_150_30 then
					arg_147_1.talkMaxDuration = var_150_30

					if var_150_30 + var_150_24 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_30 + var_150_24
					end
				end

				arg_147_1.text_.text = var_150_27
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_31 = math.max(var_150_25, arg_147_1.talkMaxDuration)

			if var_150_24 <= arg_147_1.time_ and arg_147_1.time_ < var_150_24 + var_150_31 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_24) / var_150_31

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_24 + var_150_31 and arg_147_1.time_ < var_150_24 + var_150_31 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play321021036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321021036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play321021037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 1.375

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_2 = arg_151_1:GetWordFromCfg(321021036)
				local var_154_3 = arg_151_1:FormatText(var_154_2.content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 55
				local var_154_5 = utf8.len(var_154_3)
				local var_154_6 = var_154_4 <= 0 and var_154_1 or var_154_1 * (var_154_5 / var_154_4)

				if var_154_6 > 0 and var_154_1 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_7 and arg_151_1.time_ < var_154_0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play321021037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 321021037
		arg_155_1.duration_ = 6.77

		local var_155_0 = {
			zh = 3.933,
			ja = 6.766
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play321021038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1043ui_story"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos1043ui_story = var_158_0.localPosition
			end

			local var_158_2 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2
				local var_158_4 = Vector3.New(0.01, -1.01, -5.73)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1043ui_story, var_158_4, var_158_3)

				local var_158_5 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_5.x, var_158_5.y, var_158_5.z)

				local var_158_6 = var_158_0.localEulerAngles

				var_158_6.z = 0
				var_158_6.x = 0
				var_158_0.localEulerAngles = var_158_6
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_158_7 = manager.ui.mainCamera.transform.position - var_158_0.position

				var_158_0.forward = Vector3.New(var_158_7.x, var_158_7.y, var_158_7.z)

				local var_158_8 = var_158_0.localEulerAngles

				var_158_8.z = 0
				var_158_8.x = 0
				var_158_0.localEulerAngles = var_158_8
			end

			local var_158_9 = arg_155_1.actors_["1043ui_story"]
			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect1043ui_story == nil then
				arg_155_1.var_.characterEffect1043ui_story = var_158_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_11 = 0.200000002980232

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_11 and not isNil(var_158_9) then
				local var_158_12 = (arg_155_1.time_ - var_158_10) / var_158_11

				if arg_155_1.var_.characterEffect1043ui_story and not isNil(var_158_9) then
					arg_155_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_10 + var_158_11 and arg_155_1.time_ < var_158_10 + var_158_11 + arg_158_0 and not isNil(var_158_9) and arg_155_1.var_.characterEffect1043ui_story then
				arg_155_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_158_13 = 0

			if var_158_13 < arg_155_1.time_ and arg_155_1.time_ <= var_158_13 + arg_158_0 then
				arg_155_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_158_14 = 0
			local var_158_15 = 0.2

			if var_158_14 < arg_155_1.time_ and arg_155_1.time_ <= var_158_14 + arg_158_0 then
				local var_158_16 = "play"
				local var_158_17 = "music"

				arg_155_1:AudioAction(var_158_16, var_158_17, "ui_battle", "ui_battle_stopbgm", "")

				local var_158_18 = ""
				local var_158_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_158_19 ~= "" then
					if arg_155_1.bgmTxt_.text ~= var_158_19 and arg_155_1.bgmTxt_.text ~= "" then
						if arg_155_1.bgmTxt2_.text ~= "" then
							arg_155_1.bgmTxt_.text = arg_155_1.bgmTxt2_.text
						end

						arg_155_1.bgmTxt2_.text = var_158_19

						arg_155_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_155_1.bgmTxt_.text = var_158_19
						arg_155_1.bgmTxt2_.text = var_158_19
					end

					if arg_155_1.bgmTimer then
						arg_155_1.bgmTimer:Stop()

						arg_155_1.bgmTimer = nil
					end

					if arg_155_1.settingData.show_music_name == 1 then
						arg_155_1.musicController:SetSelectedState("show")
						arg_155_1.musicAnimator_:Play("open", 0, 0)

						if arg_155_1.settingData.music_time ~= 0 then
							arg_155_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_155_1.settingData.music_time), function()
								if arg_155_1 == nil or isNil(arg_155_1.bgmTxt_) then
									return
								end

								arg_155_1.musicController:SetSelectedState("hide")
								arg_155_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_158_20 = 0

			if var_158_20 < arg_155_1.time_ and arg_155_1.time_ <= var_158_20 + arg_158_0 then
				arg_155_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_158_21 = 0
			local var_158_22 = 0.425

			if var_158_21 < arg_155_1.time_ and arg_155_1.time_ <= var_158_21 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_23 = arg_155_1:FormatText(StoryNameCfg[1156].name)

				arg_155_1.leftNameTxt_.text = var_158_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_24 = arg_155_1:GetWordFromCfg(321021037)
				local var_158_25 = arg_155_1:FormatText(var_158_24.content)

				arg_155_1.text_.text = var_158_25

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_26 = 17
				local var_158_27 = utf8.len(var_158_25)
				local var_158_28 = var_158_26 <= 0 and var_158_22 or var_158_22 * (var_158_27 / var_158_26)

				if var_158_28 > 0 and var_158_22 < var_158_28 then
					arg_155_1.talkMaxDuration = var_158_28

					if var_158_28 + var_158_21 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_28 + var_158_21
					end
				end

				arg_155_1.text_.text = var_158_25
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021037", "story_v_out_321021.awb") ~= 0 then
					local var_158_29 = manager.audio:GetVoiceLength("story_v_out_321021", "321021037", "story_v_out_321021.awb") / 1000

					if var_158_29 + var_158_21 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_29 + var_158_21
					end

					if var_158_24.prefab_name ~= "" and arg_155_1.actors_[var_158_24.prefab_name] ~= nil then
						local var_158_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_24.prefab_name].transform, "story_v_out_321021", "321021037", "story_v_out_321021.awb")

						arg_155_1:RecordAudio("321021037", var_158_30)
						arg_155_1:RecordAudio("321021037", var_158_30)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_321021", "321021037", "story_v_out_321021.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_321021", "321021037", "story_v_out_321021.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_31 = math.max(var_158_22, arg_155_1.talkMaxDuration)

			if var_158_21 <= arg_155_1.time_ and arg_155_1.time_ < var_158_21 + var_158_31 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_21) / var_158_31

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_21 + var_158_31 and arg_155_1.time_ < var_158_21 + var_158_31 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play321021038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 321021038
		arg_160_1.duration_ = 7.97

		local var_160_0 = {
			zh = 6.70033333518108,
			ja = 7.96733333518108
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
				arg_160_0:Play321021039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = "L08f"

			if arg_160_1.bgs_[var_163_0] == nil then
				local var_163_1 = Object.Instantiate(arg_160_1.paintGo_)

				var_163_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_163_0)
				var_163_1.name = var_163_0
				var_163_1.transform.parent = arg_160_1.stage_.transform
				var_163_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.bgs_[var_163_0] = var_163_1
			end

			local var_163_2 = 2

			if var_163_2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				local var_163_3 = manager.ui.mainCamera.transform.localPosition
				local var_163_4 = Vector3.New(0, 0, 10) + Vector3.New(var_163_3.x, var_163_3.y, 0)
				local var_163_5 = arg_160_1.bgs_.L08f

				var_163_5.transform.localPosition = var_163_4
				var_163_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_6 = var_163_5:GetComponent("SpriteRenderer")

				if var_163_6 and var_163_6.sprite then
					local var_163_7 = (var_163_5.transform.localPosition - var_163_3).z
					local var_163_8 = manager.ui.mainCameraCom_
					local var_163_9 = 2 * var_163_7 * Mathf.Tan(var_163_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_163_10 = var_163_9 * var_163_8.aspect
					local var_163_11 = var_163_6.sprite.bounds.size.x
					local var_163_12 = var_163_6.sprite.bounds.size.y
					local var_163_13 = var_163_10 / var_163_11
					local var_163_14 = var_163_9 / var_163_12
					local var_163_15 = var_163_14 < var_163_13 and var_163_13 or var_163_14

					var_163_5.transform.localScale = Vector3.New(var_163_15, var_163_15, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "L08f" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_16 = 0

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			local var_163_17 = 0.3

			if arg_160_1.time_ >= var_163_16 + var_163_17 and arg_160_1.time_ < var_163_16 + var_163_17 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_18 = 0

			if var_163_18 < arg_160_1.time_ and arg_160_1.time_ <= var_163_18 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_19 = 2

			if var_163_18 <= arg_160_1.time_ and arg_160_1.time_ < var_163_18 + var_163_19 then
				local var_163_20 = (arg_160_1.time_ - var_163_18) / var_163_19
				local var_163_21 = Color.New(0, 0, 0)

				var_163_21.a = Mathf.Lerp(0, 1, var_163_20)
				arg_160_1.mask_.color = var_163_21
			end

			if arg_160_1.time_ >= var_163_18 + var_163_19 and arg_160_1.time_ < var_163_18 + var_163_19 + arg_163_0 then
				local var_163_22 = Color.New(0, 0, 0)

				var_163_22.a = 1
				arg_160_1.mask_.color = var_163_22
			end

			local var_163_23 = 2

			if var_163_23 < arg_160_1.time_ and arg_160_1.time_ <= var_163_23 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_24 = 2

			if var_163_23 <= arg_160_1.time_ and arg_160_1.time_ < var_163_23 + var_163_24 then
				local var_163_25 = (arg_160_1.time_ - var_163_23) / var_163_24
				local var_163_26 = Color.New(0, 0, 0)

				var_163_26.a = Mathf.Lerp(1, 0, var_163_25)
				arg_160_1.mask_.color = var_163_26
			end

			if arg_160_1.time_ >= var_163_23 + var_163_24 and arg_160_1.time_ < var_163_23 + var_163_24 + arg_163_0 then
				local var_163_27 = Color.New(0, 0, 0)
				local var_163_28 = 0

				arg_160_1.mask_.enabled = false
				var_163_27.a = var_163_28
				arg_160_1.mask_.color = var_163_27
			end

			local var_163_29 = arg_160_1.actors_["1043ui_story"].transform
			local var_163_30 = 1.96599999815226

			if var_163_30 < arg_160_1.time_ and arg_160_1.time_ <= var_163_30 + arg_163_0 then
				arg_160_1.var_.moveOldPos1043ui_story = var_163_29.localPosition
			end

			local var_163_31 = 0.001

			if var_163_30 <= arg_160_1.time_ and arg_160_1.time_ < var_163_30 + var_163_31 then
				local var_163_32 = (arg_160_1.time_ - var_163_30) / var_163_31
				local var_163_33 = Vector3.New(0, 100, 0)

				var_163_29.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1043ui_story, var_163_33, var_163_32)

				local var_163_34 = manager.ui.mainCamera.transform.position - var_163_29.position

				var_163_29.forward = Vector3.New(var_163_34.x, var_163_34.y, var_163_34.z)

				local var_163_35 = var_163_29.localEulerAngles

				var_163_35.z = 0
				var_163_35.x = 0
				var_163_29.localEulerAngles = var_163_35
			end

			if arg_160_1.time_ >= var_163_30 + var_163_31 and arg_160_1.time_ < var_163_30 + var_163_31 + arg_163_0 then
				var_163_29.localPosition = Vector3.New(0, 100, 0)

				local var_163_36 = manager.ui.mainCamera.transform.position - var_163_29.position

				var_163_29.forward = Vector3.New(var_163_36.x, var_163_36.y, var_163_36.z)

				local var_163_37 = var_163_29.localEulerAngles

				var_163_37.z = 0
				var_163_37.x = 0
				var_163_29.localEulerAngles = var_163_37
			end

			local var_163_38 = arg_160_1.actors_["10104ui_story"].transform
			local var_163_39 = 3.83333333333333

			if var_163_39 < arg_160_1.time_ and arg_160_1.time_ <= var_163_39 + arg_163_0 then
				arg_160_1.var_.moveOldPos10104ui_story = var_163_38.localPosition
			end

			local var_163_40 = 0.001

			if var_163_39 <= arg_160_1.time_ and arg_160_1.time_ < var_163_39 + var_163_40 then
				local var_163_41 = (arg_160_1.time_ - var_163_39) / var_163_40
				local var_163_42 = Vector3.New(0.02, -1.12, -5.99)

				var_163_38.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10104ui_story, var_163_42, var_163_41)

				local var_163_43 = manager.ui.mainCamera.transform.position - var_163_38.position

				var_163_38.forward = Vector3.New(var_163_43.x, var_163_43.y, var_163_43.z)

				local var_163_44 = var_163_38.localEulerAngles

				var_163_44.z = 0
				var_163_44.x = 0
				var_163_38.localEulerAngles = var_163_44
			end

			if arg_160_1.time_ >= var_163_39 + var_163_40 and arg_160_1.time_ < var_163_39 + var_163_40 + arg_163_0 then
				var_163_38.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_163_45 = manager.ui.mainCamera.transform.position - var_163_38.position

				var_163_38.forward = Vector3.New(var_163_45.x, var_163_45.y, var_163_45.z)

				local var_163_46 = var_163_38.localEulerAngles

				var_163_46.z = 0
				var_163_46.x = 0
				var_163_38.localEulerAngles = var_163_46
			end

			local var_163_47 = arg_160_1.actors_["10104ui_story"]
			local var_163_48 = 3.83333333333333

			if var_163_48 < arg_160_1.time_ and arg_160_1.time_ <= var_163_48 + arg_163_0 and not isNil(var_163_47) and arg_160_1.var_.characterEffect10104ui_story == nil then
				arg_160_1.var_.characterEffect10104ui_story = var_163_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_49 = 0.200000002980232

			if var_163_48 <= arg_160_1.time_ and arg_160_1.time_ < var_163_48 + var_163_49 and not isNil(var_163_47) then
				local var_163_50 = (arg_160_1.time_ - var_163_48) / var_163_49

				if arg_160_1.var_.characterEffect10104ui_story and not isNil(var_163_47) then
					arg_160_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_48 + var_163_49 and arg_160_1.time_ < var_163_48 + var_163_49 + arg_163_0 and not isNil(var_163_47) and arg_160_1.var_.characterEffect10104ui_story then
				arg_160_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_163_51 = arg_160_1.actors_["1043ui_story"]
			local var_163_52 = 3.83333333333333

			if var_163_52 < arg_160_1.time_ and arg_160_1.time_ <= var_163_52 + arg_163_0 and not isNil(var_163_51) and arg_160_1.var_.characterEffect1043ui_story == nil then
				arg_160_1.var_.characterEffect1043ui_story = var_163_51:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_53 = 0.200000002980232

			if var_163_52 <= arg_160_1.time_ and arg_160_1.time_ < var_163_52 + var_163_53 and not isNil(var_163_51) then
				local var_163_54 = (arg_160_1.time_ - var_163_52) / var_163_53

				if arg_160_1.var_.characterEffect1043ui_story and not isNil(var_163_51) then
					local var_163_55 = Mathf.Lerp(0, 0.5, var_163_54)

					arg_160_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1043ui_story.fillRatio = var_163_55
				end
			end

			if arg_160_1.time_ >= var_163_52 + var_163_53 and arg_160_1.time_ < var_163_52 + var_163_53 + arg_163_0 and not isNil(var_163_51) and arg_160_1.var_.characterEffect1043ui_story then
				local var_163_56 = 0.5

				arg_160_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1043ui_story.fillRatio = var_163_56
			end

			local var_163_57 = 3.83333333333333

			if var_163_57 < arg_160_1.time_ and arg_160_1.time_ <= var_163_57 + arg_163_0 then
				arg_160_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			local var_163_58 = 3.83333333333333

			if var_163_58 < arg_160_1.time_ and arg_160_1.time_ <= var_163_58 + arg_163_0 then
				arg_160_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_163_59 = 0
			local var_163_60 = 0.2

			if var_163_59 < arg_160_1.time_ and arg_160_1.time_ <= var_163_59 + arg_163_0 then
				local var_163_61 = "play"
				local var_163_62 = "music"

				arg_160_1:AudioAction(var_163_61, var_163_62, "ui_battle", "ui_battle_stopbgm", "")

				local var_163_63 = ""
				local var_163_64 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_163_64 ~= "" then
					if arg_160_1.bgmTxt_.text ~= var_163_64 and arg_160_1.bgmTxt_.text ~= "" then
						if arg_160_1.bgmTxt2_.text ~= "" then
							arg_160_1.bgmTxt_.text = arg_160_1.bgmTxt2_.text
						end

						arg_160_1.bgmTxt2_.text = var_163_64

						arg_160_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_160_1.bgmTxt_.text = var_163_64
						arg_160_1.bgmTxt2_.text = var_163_64
					end

					if arg_160_1.bgmTimer then
						arg_160_1.bgmTimer:Stop()

						arg_160_1.bgmTimer = nil
					end

					if arg_160_1.settingData.show_music_name == 1 then
						arg_160_1.musicController:SetSelectedState("show")
						arg_160_1.musicAnimator_:Play("open", 0, 0)

						if arg_160_1.settingData.music_time ~= 0 then
							arg_160_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_160_1.settingData.music_time), function()
								if arg_160_1 == nil or isNil(arg_160_1.bgmTxt_) then
									return
								end

								arg_160_1.musicController:SetSelectedState("hide")
								arg_160_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_163_65 = 1.8
			local var_163_66 = 1

			if var_163_65 < arg_160_1.time_ and arg_160_1.time_ <= var_163_65 + arg_163_0 then
				local var_163_67 = "play"
				local var_163_68 = "music"

				arg_160_1:AudioAction(var_163_67, var_163_68, "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer.awb")

				local var_163_69 = ""
				local var_163_70 = manager.audio:GetAudioName("bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer")

				if var_163_70 ~= "" then
					if arg_160_1.bgmTxt_.text ~= var_163_70 and arg_160_1.bgmTxt_.text ~= "" then
						if arg_160_1.bgmTxt2_.text ~= "" then
							arg_160_1.bgmTxt_.text = arg_160_1.bgmTxt2_.text
						end

						arg_160_1.bgmTxt2_.text = var_163_70

						arg_160_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_160_1.bgmTxt_.text = var_163_70
						arg_160_1.bgmTxt2_.text = var_163_70
					end

					if arg_160_1.bgmTimer then
						arg_160_1.bgmTimer:Stop()

						arg_160_1.bgmTimer = nil
					end

					if arg_160_1.settingData.show_music_name == 1 then
						arg_160_1.musicController:SetSelectedState("show")
						arg_160_1.musicAnimator_:Play("open", 0, 0)

						if arg_160_1.settingData.music_time ~= 0 then
							arg_160_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_160_1.settingData.music_time), function()
								if arg_160_1 == nil or isNil(arg_160_1.bgmTxt_) then
									return
								end

								arg_160_1.musicController:SetSelectedState("hide")
								arg_160_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_163_71 = 1.56666666666667
			local var_163_72 = 1

			if var_163_71 < arg_160_1.time_ and arg_160_1.time_ <= var_163_71 + arg_163_0 then
				local var_163_73 = "play"
				local var_163_74 = "effect"

				arg_160_1:AudioAction(var_163_73, var_163_74, "se_story_140", "se_story_140_amb_drain", "")
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_75 = 3.86733333518108
			local var_163_76 = 0.375

			if var_163_75 < arg_160_1.time_ and arg_160_1.time_ <= var_163_75 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_77 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_77:setOnUpdate(LuaHelper.FloatAction(function(arg_166_0)
					arg_160_1.dialogCg_.alpha = arg_166_0
				end))
				var_163_77:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_77:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_78 = arg_160_1:FormatText(StoryNameCfg[1030].name)

				arg_160_1.leftNameTxt_.text = var_163_78

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_79 = arg_160_1:GetWordFromCfg(321021038)
				local var_163_80 = arg_160_1:FormatText(var_163_79.content)

				arg_160_1.text_.text = var_163_80

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_81 = 15
				local var_163_82 = utf8.len(var_163_80)
				local var_163_83 = var_163_81 <= 0 and var_163_76 or var_163_76 * (var_163_82 / var_163_81)

				if var_163_83 > 0 and var_163_76 < var_163_83 then
					arg_160_1.talkMaxDuration = var_163_83
					var_163_75 = var_163_75 + 0.3

					if var_163_83 + var_163_75 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_83 + var_163_75
					end
				end

				arg_160_1.text_.text = var_163_80
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021038", "story_v_out_321021.awb") ~= 0 then
					local var_163_84 = manager.audio:GetVoiceLength("story_v_out_321021", "321021038", "story_v_out_321021.awb") / 1000

					if var_163_84 + var_163_75 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_84 + var_163_75
					end

					if var_163_79.prefab_name ~= "" and arg_160_1.actors_[var_163_79.prefab_name] ~= nil then
						local var_163_85 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_79.prefab_name].transform, "story_v_out_321021", "321021038", "story_v_out_321021.awb")

						arg_160_1:RecordAudio("321021038", var_163_85)
						arg_160_1:RecordAudio("321021038", var_163_85)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_321021", "321021038", "story_v_out_321021.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_321021", "321021038", "story_v_out_321021.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_86 = var_163_75 + 0.3
			local var_163_87 = math.max(var_163_76, arg_160_1.talkMaxDuration)

			if var_163_86 <= arg_160_1.time_ and arg_160_1.time_ < var_163_86 + var_163_87 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_86) / var_163_87

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_86 + var_163_87 and arg_160_1.time_ < var_163_86 + var_163_87 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play321021039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 321021039
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play321021040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10104ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10104ui_story == nil then
				arg_168_1.var_.characterEffect10104ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect10104ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_168_1.var_.characterEffect10104ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10104ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_168_1.var_.characterEffect10104ui_story.fillRatio = var_171_5
			end

			local var_171_6 = 0
			local var_171_7 = 0.175

			if var_171_6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_8 = arg_168_1:FormatText(StoryNameCfg[7].name)

				arg_168_1.leftNameTxt_.text = var_171_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_9 = arg_168_1:GetWordFromCfg(321021039)
				local var_171_10 = arg_168_1:FormatText(var_171_9.content)

				arg_168_1.text_.text = var_171_10

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 7
				local var_171_12 = utf8.len(var_171_10)
				local var_171_13 = var_171_11 <= 0 and var_171_7 or var_171_7 * (var_171_12 / var_171_11)

				if var_171_13 > 0 and var_171_7 < var_171_13 then
					arg_168_1.talkMaxDuration = var_171_13

					if var_171_13 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_10
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_14 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_14 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_14

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_14 and arg_168_1.time_ < var_171_6 + var_171_14 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play321021040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 321021040
		arg_172_1.duration_ = 3.73

		local var_172_0 = {
			zh = 2.133,
			ja = 3.733
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play321021041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10104ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10104ui_story == nil then
				arg_172_1.var_.characterEffect10104ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect10104ui_story and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect10104ui_story then
				arg_172_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_175_4 = 0
			local var_175_5 = 0.275

			if var_175_4 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_6 = arg_172_1:FormatText(StoryNameCfg[1030].name)

				arg_172_1.leftNameTxt_.text = var_175_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_7 = arg_172_1:GetWordFromCfg(321021040)
				local var_175_8 = arg_172_1:FormatText(var_175_7.content)

				arg_172_1.text_.text = var_175_8

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_9 = 11
				local var_175_10 = utf8.len(var_175_8)
				local var_175_11 = var_175_9 <= 0 and var_175_5 or var_175_5 * (var_175_10 / var_175_9)

				if var_175_11 > 0 and var_175_5 < var_175_11 then
					arg_172_1.talkMaxDuration = var_175_11

					if var_175_11 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_11 + var_175_4
					end
				end

				arg_172_1.text_.text = var_175_8
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021040", "story_v_out_321021.awb") ~= 0 then
					local var_175_12 = manager.audio:GetVoiceLength("story_v_out_321021", "321021040", "story_v_out_321021.awb") / 1000

					if var_175_12 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_12 + var_175_4
					end

					if var_175_7.prefab_name ~= "" and arg_172_1.actors_[var_175_7.prefab_name] ~= nil then
						local var_175_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_7.prefab_name].transform, "story_v_out_321021", "321021040", "story_v_out_321021.awb")

						arg_172_1:RecordAudio("321021040", var_175_13)
						arg_172_1:RecordAudio("321021040", var_175_13)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_321021", "321021040", "story_v_out_321021.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_321021", "321021040", "story_v_out_321021.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_14 = math.max(var_175_5, arg_172_1.talkMaxDuration)

			if var_175_4 <= arg_172_1.time_ and arg_172_1.time_ < var_175_4 + var_175_14 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_4) / var_175_14

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_4 + var_175_14 and arg_172_1.time_ < var_175_4 + var_175_14 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play321021041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 321021041
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play321021042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10104ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10104ui_story == nil then
				arg_176_1.var_.characterEffect10104ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect10104ui_story and not isNil(var_179_0) then
					local var_179_4 = Mathf.Lerp(0, 0.5, var_179_3)

					arg_176_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_176_1.var_.characterEffect10104ui_story.fillRatio = var_179_4
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10104ui_story then
				local var_179_5 = 0.5

				arg_176_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_176_1.var_.characterEffect10104ui_story.fillRatio = var_179_5
			end

			local var_179_6 = 0
			local var_179_7 = 0.55

			if var_179_6 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_8 = arg_176_1:FormatText(StoryNameCfg[7].name)

				arg_176_1.leftNameTxt_.text = var_179_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_9 = arg_176_1:GetWordFromCfg(321021041)
				local var_179_10 = arg_176_1:FormatText(var_179_9.content)

				arg_176_1.text_.text = var_179_10

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_11 = 22
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
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_14 = math.max(var_179_7, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_14 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_6) / var_179_14

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_14 and arg_176_1.time_ < var_179_6 + var_179_14 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play321021042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 321021042
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play321021043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10104ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos10104ui_story = var_183_0.localPosition
			end

			local var_183_2 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2
				local var_183_4 = Vector3.New(0, 100, 0)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10104ui_story, var_183_4, var_183_3)

				local var_183_5 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_5.x, var_183_5.y, var_183_5.z)

				local var_183_6 = var_183_0.localEulerAngles

				var_183_6.z = 0
				var_183_6.x = 0
				var_183_0.localEulerAngles = var_183_6
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(0, 100, 0)

				local var_183_7 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_7.x, var_183_7.y, var_183_7.z)

				local var_183_8 = var_183_0.localEulerAngles

				var_183_8.z = 0
				var_183_8.x = 0
				var_183_0.localEulerAngles = var_183_8
			end

			local var_183_9 = 0
			local var_183_10 = 1.425

			if var_183_9 < arg_180_1.time_ and arg_180_1.time_ <= var_183_9 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_11 = arg_180_1:GetWordFromCfg(321021042)
				local var_183_12 = arg_180_1:FormatText(var_183_11.content)

				arg_180_1.text_.text = var_183_12

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_13 = 57
				local var_183_14 = utf8.len(var_183_12)
				local var_183_15 = var_183_13 <= 0 and var_183_10 or var_183_10 * (var_183_14 / var_183_13)

				if var_183_15 > 0 and var_183_10 < var_183_15 then
					arg_180_1.talkMaxDuration = var_183_15

					if var_183_15 + var_183_9 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_15 + var_183_9
					end
				end

				arg_180_1.text_.text = var_183_12
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_16 = math.max(var_183_10, arg_180_1.talkMaxDuration)

			if var_183_9 <= arg_180_1.time_ and arg_180_1.time_ < var_183_9 + var_183_16 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_9) / var_183_16

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_9 + var_183_16 and arg_180_1.time_ < var_183_9 + var_183_16 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321021043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 321021043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play321021044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0
			local var_187_1 = 0.25

			if var_187_0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_2 = arg_184_1:FormatText(StoryNameCfg[7].name)

				arg_184_1.leftNameTxt_.text = var_187_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:GetWordFromCfg(321021043)
				local var_187_4 = arg_184_1:FormatText(var_187_3.content)

				arg_184_1.text_.text = var_187_4

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 10
				local var_187_6 = utf8.len(var_187_4)
				local var_187_7 = var_187_5 <= 0 and var_187_1 or var_187_1 * (var_187_6 / var_187_5)

				if var_187_7 > 0 and var_187_1 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_0
					end
				end

				arg_184_1.text_.text = var_187_4
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_8 = math.max(var_187_1, arg_184_1.talkMaxDuration)

			if var_187_0 <= arg_184_1.time_ and arg_184_1.time_ < var_187_0 + var_187_8 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_0) / var_187_8

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_0 + var_187_8 and arg_184_1.time_ < var_187_0 + var_187_8 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play321021044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 321021044
		arg_188_1.duration_ = 12.87

		local var_188_0 = {
			zh = 8.133,
			ja = 12.866
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
				arg_188_0:Play321021045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10104ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos10104ui_story = var_191_0.localPosition
			end

			local var_191_2 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2
				local var_191_4 = Vector3.New(0.02, -1.12, -5.99)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10104ui_story, var_191_4, var_191_3)

				local var_191_5 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_5.x, var_191_5.y, var_191_5.z)

				local var_191_6 = var_191_0.localEulerAngles

				var_191_6.z = 0
				var_191_6.x = 0
				var_191_0.localEulerAngles = var_191_6
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_191_7 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_7.x, var_191_7.y, var_191_7.z)

				local var_191_8 = var_191_0.localEulerAngles

				var_191_8.z = 0
				var_191_8.x = 0
				var_191_0.localEulerAngles = var_191_8
			end

			local var_191_9 = arg_188_1.actors_["10104ui_story"]
			local var_191_10 = 0

			if var_191_10 < arg_188_1.time_ and arg_188_1.time_ <= var_191_10 + arg_191_0 and not isNil(var_191_9) and arg_188_1.var_.characterEffect10104ui_story == nil then
				arg_188_1.var_.characterEffect10104ui_story = var_191_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_11 = 0.200000002980232

			if var_191_10 <= arg_188_1.time_ and arg_188_1.time_ < var_191_10 + var_191_11 and not isNil(var_191_9) then
				local var_191_12 = (arg_188_1.time_ - var_191_10) / var_191_11

				if arg_188_1.var_.characterEffect10104ui_story and not isNil(var_191_9) then
					arg_188_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_10 + var_191_11 and arg_188_1.time_ < var_191_10 + var_191_11 + arg_191_0 and not isNil(var_191_9) and arg_188_1.var_.characterEffect10104ui_story then
				arg_188_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_191_13 = 0

			if var_191_13 < arg_188_1.time_ and arg_188_1.time_ <= var_191_13 + arg_191_0 then
				arg_188_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			local var_191_14 = 0

			if var_191_14 < arg_188_1.time_ and arg_188_1.time_ <= var_191_14 + arg_191_0 then
				arg_188_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_191_15 = 0
			local var_191_16 = 1.05

			if var_191_15 < arg_188_1.time_ and arg_188_1.time_ <= var_191_15 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_17 = arg_188_1:FormatText(StoryNameCfg[1030].name)

				arg_188_1.leftNameTxt_.text = var_191_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_18 = arg_188_1:GetWordFromCfg(321021044)
				local var_191_19 = arg_188_1:FormatText(var_191_18.content)

				arg_188_1.text_.text = var_191_19

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_20 = 42
				local var_191_21 = utf8.len(var_191_19)
				local var_191_22 = var_191_20 <= 0 and var_191_16 or var_191_16 * (var_191_21 / var_191_20)

				if var_191_22 > 0 and var_191_16 < var_191_22 then
					arg_188_1.talkMaxDuration = var_191_22

					if var_191_22 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_22 + var_191_15
					end
				end

				arg_188_1.text_.text = var_191_19
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021044", "story_v_out_321021.awb") ~= 0 then
					local var_191_23 = manager.audio:GetVoiceLength("story_v_out_321021", "321021044", "story_v_out_321021.awb") / 1000

					if var_191_23 + var_191_15 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_23 + var_191_15
					end

					if var_191_18.prefab_name ~= "" and arg_188_1.actors_[var_191_18.prefab_name] ~= nil then
						local var_191_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_18.prefab_name].transform, "story_v_out_321021", "321021044", "story_v_out_321021.awb")

						arg_188_1:RecordAudio("321021044", var_191_24)
						arg_188_1:RecordAudio("321021044", var_191_24)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_321021", "321021044", "story_v_out_321021.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_321021", "321021044", "story_v_out_321021.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_25 = math.max(var_191_16, arg_188_1.talkMaxDuration)

			if var_191_15 <= arg_188_1.time_ and arg_188_1.time_ < var_191_15 + var_191_25 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_15) / var_191_25

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_15 + var_191_25 and arg_188_1.time_ < var_191_15 + var_191_25 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play321021045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 321021045
		arg_192_1.duration_ = 12.5

		local var_192_0 = {
			zh = 8.9,
			ja = 12.5
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
				arg_192_0:Play321021046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 1.225

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[1030].name)

				arg_192_1.leftNameTxt_.text = var_195_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_3 = arg_192_1:GetWordFromCfg(321021045)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 49
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

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021045", "story_v_out_321021.awb") ~= 0 then
					local var_195_8 = manager.audio:GetVoiceLength("story_v_out_321021", "321021045", "story_v_out_321021.awb") / 1000

					if var_195_8 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_0
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_321021", "321021045", "story_v_out_321021.awb")

						arg_192_1:RecordAudio("321021045", var_195_9)
						arg_192_1:RecordAudio("321021045", var_195_9)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_321021", "321021045", "story_v_out_321021.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_321021", "321021045", "story_v_out_321021.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_10 and arg_192_1.time_ < var_195_0 + var_195_10 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play321021046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 321021046
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play321021047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10104ui_story"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect10104ui_story == nil then
				arg_196_1.var_.characterEffect10104ui_story = var_199_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.200000002980232

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.characterEffect10104ui_story and not isNil(var_199_0) then
					local var_199_4 = Mathf.Lerp(0, 0.5, var_199_3)

					arg_196_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_196_1.var_.characterEffect10104ui_story.fillRatio = var_199_4
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect10104ui_story then
				local var_199_5 = 0.5

				arg_196_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_196_1.var_.characterEffect10104ui_story.fillRatio = var_199_5
			end

			local var_199_6 = 0
			local var_199_7 = 0.925

			if var_199_6 < arg_196_1.time_ and arg_196_1.time_ <= var_199_6 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_8 = arg_196_1:FormatText(StoryNameCfg[7].name)

				arg_196_1.leftNameTxt_.text = var_199_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_9 = arg_196_1:GetWordFromCfg(321021046)
				local var_199_10 = arg_196_1:FormatText(var_199_9.content)

				arg_196_1.text_.text = var_199_10

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_11 = 37
				local var_199_12 = utf8.len(var_199_10)
				local var_199_13 = var_199_11 <= 0 and var_199_7 or var_199_7 * (var_199_12 / var_199_11)

				if var_199_13 > 0 and var_199_7 < var_199_13 then
					arg_196_1.talkMaxDuration = var_199_13

					if var_199_13 + var_199_6 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_13 + var_199_6
					end
				end

				arg_196_1.text_.text = var_199_10
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_14 = math.max(var_199_7, arg_196_1.talkMaxDuration)

			if var_199_6 <= arg_196_1.time_ and arg_196_1.time_ < var_199_6 + var_199_14 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_6) / var_199_14

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_6 + var_199_14 and arg_196_1.time_ < var_199_6 + var_199_14 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play321021047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 321021047
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play321021048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 0.475

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_2 = arg_200_1:FormatText(StoryNameCfg[7].name)

				arg_200_1.leftNameTxt_.text = var_203_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_3 = arg_200_1:GetWordFromCfg(321021047)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 19
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
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_8 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_8 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_8

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_8 and arg_200_1.time_ < var_203_0 + var_203_8 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play321021048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 321021048
		arg_204_1.duration_ = 3.83

		local var_204_0 = {
			zh = 2.333,
			ja = 3.833
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
				arg_204_0:Play321021049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["10104ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect10104ui_story == nil then
				arg_204_1.var_.characterEffect10104ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect10104ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect10104ui_story then
				arg_204_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_207_4 = 0

			if var_207_4 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104actionlink/10104action465")
			end

			local var_207_5 = 0

			if var_207_5 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 then
				arg_204_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_207_6 = 0
			local var_207_7 = 0.375

			if var_207_6 < arg_204_1.time_ and arg_204_1.time_ <= var_207_6 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_8 = arg_204_1:FormatText(StoryNameCfg[1030].name)

				arg_204_1.leftNameTxt_.text = var_207_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_9 = arg_204_1:GetWordFromCfg(321021048)
				local var_207_10 = arg_204_1:FormatText(var_207_9.content)

				arg_204_1.text_.text = var_207_10

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_11 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021048", "story_v_out_321021.awb") ~= 0 then
					local var_207_14 = manager.audio:GetVoiceLength("story_v_out_321021", "321021048", "story_v_out_321021.awb") / 1000

					if var_207_14 + var_207_6 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_14 + var_207_6
					end

					if var_207_9.prefab_name ~= "" and arg_204_1.actors_[var_207_9.prefab_name] ~= nil then
						local var_207_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_9.prefab_name].transform, "story_v_out_321021", "321021048", "story_v_out_321021.awb")

						arg_204_1:RecordAudio("321021048", var_207_15)
						arg_204_1:RecordAudio("321021048", var_207_15)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_321021", "321021048", "story_v_out_321021.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_321021", "321021048", "story_v_out_321021.awb")
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
	Play321021049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 321021049
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play321021050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["10104ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect10104ui_story == nil then
				arg_208_1.var_.characterEffect10104ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect10104ui_story and not isNil(var_211_0) then
					local var_211_4 = Mathf.Lerp(0, 0.5, var_211_3)

					arg_208_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10104ui_story.fillRatio = var_211_4
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect10104ui_story then
				local var_211_5 = 0.5

				arg_208_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10104ui_story.fillRatio = var_211_5
			end

			local var_211_6 = 0
			local var_211_7 = 0.5

			if var_211_6 < arg_208_1.time_ and arg_208_1.time_ <= var_211_6 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_8 = arg_208_1:FormatText(StoryNameCfg[7].name)

				arg_208_1.leftNameTxt_.text = var_211_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_9 = arg_208_1:GetWordFromCfg(321021049)
				local var_211_10 = arg_208_1:FormatText(var_211_9.content)

				arg_208_1.text_.text = var_211_10

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_11 = 20
				local var_211_12 = utf8.len(var_211_10)
				local var_211_13 = var_211_11 <= 0 and var_211_7 or var_211_7 * (var_211_12 / var_211_11)

				if var_211_13 > 0 and var_211_7 < var_211_13 then
					arg_208_1.talkMaxDuration = var_211_13

					if var_211_13 + var_211_6 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_13 + var_211_6
					end
				end

				arg_208_1.text_.text = var_211_10
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_14 = math.max(var_211_7, arg_208_1.talkMaxDuration)

			if var_211_6 <= arg_208_1.time_ and arg_208_1.time_ < var_211_6 + var_211_14 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_6) / var_211_14

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_6 + var_211_14 and arg_208_1.time_ < var_211_6 + var_211_14 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play321021050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 321021050
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play321021051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 0.575

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_2 = arg_212_1:FormatText(StoryNameCfg[7].name)

				arg_212_1.leftNameTxt_.text = var_215_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, true)
				arg_212_1.iconController_:SetSelectedState("hero")

				arg_212_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_212_1.callingController_:SetSelectedState("normal")

				arg_212_1.keyicon_.color = Color.New(1, 1, 1)
				arg_212_1.icon_.color = Color.New(1, 1, 1)

				local var_215_3 = arg_212_1:GetWordFromCfg(321021050)
				local var_215_4 = arg_212_1:FormatText(var_215_3.content)

				arg_212_1.text_.text = var_215_4

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 23
				local var_215_6 = utf8.len(var_215_4)
				local var_215_7 = var_215_5 <= 0 and var_215_1 or var_215_1 * (var_215_6 / var_215_5)

				if var_215_7 > 0 and var_215_1 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_4
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_8 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_8 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_8

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_8 and arg_212_1.time_ < var_215_0 + var_215_8 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play321021051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 321021051
		arg_216_1.duration_ = 13.3

		local var_216_0 = {
			zh = 9.033,
			ja = 13.3
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
				arg_216_0:Play321021052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["10104ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect10104ui_story == nil then
				arg_216_1.var_.characterEffect10104ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect10104ui_story and not isNil(var_219_0) then
					arg_216_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect10104ui_story then
				arg_216_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_219_4 = 0

			if var_219_4 < arg_216_1.time_ and arg_216_1.time_ <= var_219_4 + arg_219_0 then
				arg_216_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action5_2")
			end

			local var_219_5 = 0

			if var_219_5 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 then
				arg_216_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_219_6 = 0
			local var_219_7 = 1.225

			if var_219_6 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_8 = arg_216_1:FormatText(StoryNameCfg[1030].name)

				arg_216_1.leftNameTxt_.text = var_219_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_9 = arg_216_1:GetWordFromCfg(321021051)
				local var_219_10 = arg_216_1:FormatText(var_219_9.content)

				arg_216_1.text_.text = var_219_10

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_11 = 49
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

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021051", "story_v_out_321021.awb") ~= 0 then
					local var_219_14 = manager.audio:GetVoiceLength("story_v_out_321021", "321021051", "story_v_out_321021.awb") / 1000

					if var_219_14 + var_219_6 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_14 + var_219_6
					end

					if var_219_9.prefab_name ~= "" and arg_216_1.actors_[var_219_9.prefab_name] ~= nil then
						local var_219_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_9.prefab_name].transform, "story_v_out_321021", "321021051", "story_v_out_321021.awb")

						arg_216_1:RecordAudio("321021051", var_219_15)
						arg_216_1:RecordAudio("321021051", var_219_15)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_321021", "321021051", "story_v_out_321021.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_321021", "321021051", "story_v_out_321021.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_16 = math.max(var_219_7, arg_216_1.talkMaxDuration)

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_16 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_6) / var_219_16

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_6 + var_219_16 and arg_216_1.time_ < var_219_6 + var_219_16 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play321021052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 321021052
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play321021053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["10104ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect10104ui_story == nil then
				arg_220_1.var_.characterEffect10104ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect10104ui_story and not isNil(var_223_0) then
					local var_223_4 = Mathf.Lerp(0, 0.5, var_223_3)

					arg_220_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_220_1.var_.characterEffect10104ui_story.fillRatio = var_223_4
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect10104ui_story then
				local var_223_5 = 0.5

				arg_220_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_220_1.var_.characterEffect10104ui_story.fillRatio = var_223_5
			end

			local var_223_6 = 0
			local var_223_7 = 0.45

			if var_223_6 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_8 = arg_220_1:FormatText(StoryNameCfg[7].name)

				arg_220_1.leftNameTxt_.text = var_223_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_9 = arg_220_1:GetWordFromCfg(321021052)
				local var_223_10 = arg_220_1:FormatText(var_223_9.content)

				arg_220_1.text_.text = var_223_10

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_11 = 18
				local var_223_12 = utf8.len(var_223_10)
				local var_223_13 = var_223_11 <= 0 and var_223_7 or var_223_7 * (var_223_12 / var_223_11)

				if var_223_13 > 0 and var_223_7 < var_223_13 then
					arg_220_1.talkMaxDuration = var_223_13

					if var_223_13 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_13 + var_223_6
					end
				end

				arg_220_1.text_.text = var_223_10
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_14 = math.max(var_223_7, arg_220_1.talkMaxDuration)

			if var_223_6 <= arg_220_1.time_ and arg_220_1.time_ < var_223_6 + var_223_14 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_6) / var_223_14

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_6 + var_223_14 and arg_220_1.time_ < var_223_6 + var_223_14 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play321021053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 321021053
		arg_224_1.duration_ = 11.3

		local var_224_0 = {
			zh = 7.166,
			ja = 11.3
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
				arg_224_0:Play321021054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["10104ui_story"].transform
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.var_.moveOldPos10104ui_story = var_227_0.localPosition
			end

			local var_227_2 = 0.001

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2
				local var_227_4 = Vector3.New(0.02, -1.12, -5.99)

				var_227_0.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10104ui_story, var_227_4, var_227_3)

				local var_227_5 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_5.x, var_227_5.y, var_227_5.z)

				local var_227_6 = var_227_0.localEulerAngles

				var_227_6.z = 0
				var_227_6.x = 0
				var_227_0.localEulerAngles = var_227_6
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 then
				var_227_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_227_7 = manager.ui.mainCamera.transform.position - var_227_0.position

				var_227_0.forward = Vector3.New(var_227_7.x, var_227_7.y, var_227_7.z)

				local var_227_8 = var_227_0.localEulerAngles

				var_227_8.z = 0
				var_227_8.x = 0
				var_227_0.localEulerAngles = var_227_8
			end

			local var_227_9 = arg_224_1.actors_["10104ui_story"]
			local var_227_10 = 0

			if var_227_10 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 and not isNil(var_227_9) and arg_224_1.var_.characterEffect10104ui_story == nil then
				arg_224_1.var_.characterEffect10104ui_story = var_227_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_11 = 0.200000002980232

			if var_227_10 <= arg_224_1.time_ and arg_224_1.time_ < var_227_10 + var_227_11 and not isNil(var_227_9) then
				local var_227_12 = (arg_224_1.time_ - var_227_10) / var_227_11

				if arg_224_1.var_.characterEffect10104ui_story and not isNil(var_227_9) then
					arg_224_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_10 + var_227_11 and arg_224_1.time_ < var_227_10 + var_227_11 + arg_227_0 and not isNil(var_227_9) and arg_224_1.var_.characterEffect10104ui_story then
				arg_224_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_227_13 = 0

			if var_227_13 < arg_224_1.time_ and arg_224_1.time_ <= var_227_13 + arg_227_0 then
				arg_224_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_227_14 = 0
			local var_227_15 = 1

			if var_227_14 < arg_224_1.time_ and arg_224_1.time_ <= var_227_14 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_16 = arg_224_1:FormatText(StoryNameCfg[1030].name)

				arg_224_1.leftNameTxt_.text = var_227_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_17 = arg_224_1:GetWordFromCfg(321021053)
				local var_227_18 = arg_224_1:FormatText(var_227_17.content)

				arg_224_1.text_.text = var_227_18

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_19 = 40
				local var_227_20 = utf8.len(var_227_18)
				local var_227_21 = var_227_19 <= 0 and var_227_15 or var_227_15 * (var_227_20 / var_227_19)

				if var_227_21 > 0 and var_227_15 < var_227_21 then
					arg_224_1.talkMaxDuration = var_227_21

					if var_227_21 + var_227_14 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_21 + var_227_14
					end
				end

				arg_224_1.text_.text = var_227_18
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021053", "story_v_out_321021.awb") ~= 0 then
					local var_227_22 = manager.audio:GetVoiceLength("story_v_out_321021", "321021053", "story_v_out_321021.awb") / 1000

					if var_227_22 + var_227_14 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_22 + var_227_14
					end

					if var_227_17.prefab_name ~= "" and arg_224_1.actors_[var_227_17.prefab_name] ~= nil then
						local var_227_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_17.prefab_name].transform, "story_v_out_321021", "321021053", "story_v_out_321021.awb")

						arg_224_1:RecordAudio("321021053", var_227_23)
						arg_224_1:RecordAudio("321021053", var_227_23)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_321021", "321021053", "story_v_out_321021.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_321021", "321021053", "story_v_out_321021.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_24 = math.max(var_227_15, arg_224_1.talkMaxDuration)

			if var_227_14 <= arg_224_1.time_ and arg_224_1.time_ < var_227_14 + var_227_24 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_14) / var_227_24

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_14 + var_227_24 and arg_224_1.time_ < var_227_14 + var_227_24 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play321021054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 321021054
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play321021055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10104ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect10104ui_story == nil then
				arg_228_1.var_.characterEffect10104ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect10104ui_story and not isNil(var_231_0) then
					local var_231_4 = Mathf.Lerp(0, 0.5, var_231_3)

					arg_228_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_228_1.var_.characterEffect10104ui_story.fillRatio = var_231_4
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect10104ui_story then
				local var_231_5 = 0.5

				arg_228_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_228_1.var_.characterEffect10104ui_story.fillRatio = var_231_5
			end

			local var_231_6 = 0
			local var_231_7 = 0.325

			if var_231_6 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_8 = arg_228_1:FormatText(StoryNameCfg[7].name)

				arg_228_1.leftNameTxt_.text = var_231_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_9 = arg_228_1:GetWordFromCfg(321021054)
				local var_231_10 = arg_228_1:FormatText(var_231_9.content)

				arg_228_1.text_.text = var_231_10

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_11 = 13
				local var_231_12 = utf8.len(var_231_10)
				local var_231_13 = var_231_11 <= 0 and var_231_7 or var_231_7 * (var_231_12 / var_231_11)

				if var_231_13 > 0 and var_231_7 < var_231_13 then
					arg_228_1.talkMaxDuration = var_231_13

					if var_231_13 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_13 + var_231_6
					end
				end

				arg_228_1.text_.text = var_231_10
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_14 = math.max(var_231_7, arg_228_1.talkMaxDuration)

			if var_231_6 <= arg_228_1.time_ and arg_228_1.time_ < var_231_6 + var_231_14 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_6) / var_231_14

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_6 + var_231_14 and arg_228_1.time_ < var_231_6 + var_231_14 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play321021055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 321021055
		arg_232_1.duration_ = 1.27

		local var_232_0 = {
			zh = 0.999999999999,
			ja = 1.266
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
				arg_232_0:Play321021056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["10104ui_story"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect10104ui_story == nil then
				arg_232_1.var_.characterEffect10104ui_story = var_235_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.characterEffect10104ui_story and not isNil(var_235_0) then
					arg_232_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect10104ui_story then
				arg_232_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_235_4 = 0
			local var_235_5 = 0.1

			if var_235_4 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_6 = arg_232_1:FormatText(StoryNameCfg[1030].name)

				arg_232_1.leftNameTxt_.text = var_235_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_7 = arg_232_1:GetWordFromCfg(321021055)
				local var_235_8 = arg_232_1:FormatText(var_235_7.content)

				arg_232_1.text_.text = var_235_8

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_9 = 4
				local var_235_10 = utf8.len(var_235_8)
				local var_235_11 = var_235_9 <= 0 and var_235_5 or var_235_5 * (var_235_10 / var_235_9)

				if var_235_11 > 0 and var_235_5 < var_235_11 then
					arg_232_1.talkMaxDuration = var_235_11

					if var_235_11 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_11 + var_235_4
					end
				end

				arg_232_1.text_.text = var_235_8
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021055", "story_v_out_321021.awb") ~= 0 then
					local var_235_12 = manager.audio:GetVoiceLength("story_v_out_321021", "321021055", "story_v_out_321021.awb") / 1000

					if var_235_12 + var_235_4 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_12 + var_235_4
					end

					if var_235_7.prefab_name ~= "" and arg_232_1.actors_[var_235_7.prefab_name] ~= nil then
						local var_235_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_7.prefab_name].transform, "story_v_out_321021", "321021055", "story_v_out_321021.awb")

						arg_232_1:RecordAudio("321021055", var_235_13)
						arg_232_1:RecordAudio("321021055", var_235_13)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_321021", "321021055", "story_v_out_321021.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_321021", "321021055", "story_v_out_321021.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_14 = math.max(var_235_5, arg_232_1.talkMaxDuration)

			if var_235_4 <= arg_232_1.time_ and arg_232_1.time_ < var_235_4 + var_235_14 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_4) / var_235_14

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_4 + var_235_14 and arg_232_1.time_ < var_235_4 + var_235_14 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play321021056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 321021056
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play321021057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10104ui_story"].transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.var_.moveOldPos10104ui_story = var_239_0.localPosition
			end

			local var_239_2 = 0.001

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2
				local var_239_4 = Vector3.New(0, 100, 0)

				var_239_0.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10104ui_story, var_239_4, var_239_3)

				local var_239_5 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_5.x, var_239_5.y, var_239_5.z)

				local var_239_6 = var_239_0.localEulerAngles

				var_239_6.z = 0
				var_239_6.x = 0
				var_239_0.localEulerAngles = var_239_6
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 then
				var_239_0.localPosition = Vector3.New(0, 100, 0)

				local var_239_7 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_7.x, var_239_7.y, var_239_7.z)

				local var_239_8 = var_239_0.localEulerAngles

				var_239_8.z = 0
				var_239_8.x = 0
				var_239_0.localEulerAngles = var_239_8
			end

			local var_239_9 = arg_236_1.actors_["10104ui_story"]
			local var_239_10 = 0

			if var_239_10 < arg_236_1.time_ and arg_236_1.time_ <= var_239_10 + arg_239_0 and not isNil(var_239_9) and arg_236_1.var_.characterEffect10104ui_story == nil then
				arg_236_1.var_.characterEffect10104ui_story = var_239_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_11 = 0.200000002980232

			if var_239_10 <= arg_236_1.time_ and arg_236_1.time_ < var_239_10 + var_239_11 and not isNil(var_239_9) then
				local var_239_12 = (arg_236_1.time_ - var_239_10) / var_239_11

				if arg_236_1.var_.characterEffect10104ui_story and not isNil(var_239_9) then
					local var_239_13 = Mathf.Lerp(0, 0.5, var_239_12)

					arg_236_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_236_1.var_.characterEffect10104ui_story.fillRatio = var_239_13
				end
			end

			if arg_236_1.time_ >= var_239_10 + var_239_11 and arg_236_1.time_ < var_239_10 + var_239_11 + arg_239_0 and not isNil(var_239_9) and arg_236_1.var_.characterEffect10104ui_story then
				local var_239_14 = 0.5

				arg_236_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_236_1.var_.characterEffect10104ui_story.fillRatio = var_239_14
			end

			local var_239_15 = 0
			local var_239_16 = 1.25

			if var_239_15 < arg_236_1.time_ and arg_236_1.time_ <= var_239_15 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_17 = arg_236_1:GetWordFromCfg(321021056)
				local var_239_18 = arg_236_1:FormatText(var_239_17.content)

				arg_236_1.text_.text = var_239_18

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_19 = 50
				local var_239_20 = utf8.len(var_239_18)
				local var_239_21 = var_239_19 <= 0 and var_239_16 or var_239_16 * (var_239_20 / var_239_19)

				if var_239_21 > 0 and var_239_16 < var_239_21 then
					arg_236_1.talkMaxDuration = var_239_21

					if var_239_21 + var_239_15 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_21 + var_239_15
					end
				end

				arg_236_1.text_.text = var_239_18
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_22 = math.max(var_239_16, arg_236_1.talkMaxDuration)

			if var_239_15 <= arg_236_1.time_ and arg_236_1.time_ < var_239_15 + var_239_22 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_15) / var_239_22

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_15 + var_239_22 and arg_236_1.time_ < var_239_15 + var_239_22 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play321021057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 321021057
		arg_240_1.duration_ = 9.4

		local var_240_0 = {
			zh = 4.766,
			ja = 9.4
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
				arg_240_0:Play321021058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["10104ui_story"].transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPos10104ui_story = var_243_0.localPosition
			end

			local var_243_2 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2
				local var_243_4 = Vector3.New(0.02, -1.12, -5.99)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10104ui_story, var_243_4, var_243_3)

				local var_243_5 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_5.x, var_243_5.y, var_243_5.z)

				local var_243_6 = var_243_0.localEulerAngles

				var_243_6.z = 0
				var_243_6.x = 0
				var_243_0.localEulerAngles = var_243_6
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(0.02, -1.12, -5.99)

				local var_243_7 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_7.x, var_243_7.y, var_243_7.z)

				local var_243_8 = var_243_0.localEulerAngles

				var_243_8.z = 0
				var_243_8.x = 0
				var_243_0.localEulerAngles = var_243_8
			end

			local var_243_9 = arg_240_1.actors_["10104ui_story"]
			local var_243_10 = 0

			if var_243_10 < arg_240_1.time_ and arg_240_1.time_ <= var_243_10 + arg_243_0 and not isNil(var_243_9) and arg_240_1.var_.characterEffect10104ui_story == nil then
				arg_240_1.var_.characterEffect10104ui_story = var_243_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_11 = 0.200000002980232

			if var_243_10 <= arg_240_1.time_ and arg_240_1.time_ < var_243_10 + var_243_11 and not isNil(var_243_9) then
				local var_243_12 = (arg_240_1.time_ - var_243_10) / var_243_11

				if arg_240_1.var_.characterEffect10104ui_story and not isNil(var_243_9) then
					arg_240_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_10 + var_243_11 and arg_240_1.time_ < var_243_10 + var_243_11 + arg_243_0 and not isNil(var_243_9) and arg_240_1.var_.characterEffect10104ui_story then
				arg_240_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_243_13 = 0

			if var_243_13 < arg_240_1.time_ and arg_240_1.time_ <= var_243_13 + arg_243_0 then
				arg_240_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			local var_243_14 = 0

			if var_243_14 < arg_240_1.time_ and arg_240_1.time_ <= var_243_14 + arg_243_0 then
				arg_240_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_243_15 = 0
			local var_243_16 = 0.65

			if var_243_15 < arg_240_1.time_ and arg_240_1.time_ <= var_243_15 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_17 = arg_240_1:FormatText(StoryNameCfg[1030].name)

				arg_240_1.leftNameTxt_.text = var_243_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_18 = arg_240_1:GetWordFromCfg(321021057)
				local var_243_19 = arg_240_1:FormatText(var_243_18.content)

				arg_240_1.text_.text = var_243_19

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_20 = 26
				local var_243_21 = utf8.len(var_243_19)
				local var_243_22 = var_243_20 <= 0 and var_243_16 or var_243_16 * (var_243_21 / var_243_20)

				if var_243_22 > 0 and var_243_16 < var_243_22 then
					arg_240_1.talkMaxDuration = var_243_22

					if var_243_22 + var_243_15 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_22 + var_243_15
					end
				end

				arg_240_1.text_.text = var_243_19
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021057", "story_v_out_321021.awb") ~= 0 then
					local var_243_23 = manager.audio:GetVoiceLength("story_v_out_321021", "321021057", "story_v_out_321021.awb") / 1000

					if var_243_23 + var_243_15 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_23 + var_243_15
					end

					if var_243_18.prefab_name ~= "" and arg_240_1.actors_[var_243_18.prefab_name] ~= nil then
						local var_243_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_18.prefab_name].transform, "story_v_out_321021", "321021057", "story_v_out_321021.awb")

						arg_240_1:RecordAudio("321021057", var_243_24)
						arg_240_1:RecordAudio("321021057", var_243_24)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_321021", "321021057", "story_v_out_321021.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_321021", "321021057", "story_v_out_321021.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_25 = math.max(var_243_16, arg_240_1.talkMaxDuration)

			if var_243_15 <= arg_240_1.time_ and arg_240_1.time_ < var_243_15 + var_243_25 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_15) / var_243_25

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_15 + var_243_25 and arg_240_1.time_ < var_243_15 + var_243_25 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321021058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 321021058
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play321021059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["10104ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect10104ui_story == nil then
				arg_244_1.var_.characterEffect10104ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect10104ui_story and not isNil(var_247_0) then
					local var_247_4 = Mathf.Lerp(0, 0.5, var_247_3)

					arg_244_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_244_1.var_.characterEffect10104ui_story.fillRatio = var_247_4
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect10104ui_story then
				local var_247_5 = 0.5

				arg_244_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_244_1.var_.characterEffect10104ui_story.fillRatio = var_247_5
			end

			local var_247_6 = 0
			local var_247_7 = 0.225

			if var_247_6 < arg_244_1.time_ and arg_244_1.time_ <= var_247_6 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_8 = arg_244_1:FormatText(StoryNameCfg[7].name)

				arg_244_1.leftNameTxt_.text = var_247_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_9 = arg_244_1:GetWordFromCfg(321021058)
				local var_247_10 = arg_244_1:FormatText(var_247_9.content)

				arg_244_1.text_.text = var_247_10

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_11 = 9
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
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_14 = math.max(var_247_7, arg_244_1.talkMaxDuration)

			if var_247_6 <= arg_244_1.time_ and arg_244_1.time_ < var_247_6 + var_247_14 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_6) / var_247_14

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_6 + var_247_14 and arg_244_1.time_ < var_247_6 + var_247_14 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play321021059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 321021059
		arg_248_1.duration_ = 1.4

		local var_248_0 = {
			zh = 1.1,
			ja = 1.4
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play321021060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["10104ui_story"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect10104ui_story == nil then
				arg_248_1.var_.characterEffect10104ui_story = var_251_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.characterEffect10104ui_story and not isNil(var_251_0) then
					arg_248_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect10104ui_story then
				arg_248_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_251_4 = 0
			local var_251_5 = 0.1

			if var_251_4 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_6 = arg_248_1:FormatText(StoryNameCfg[1030].name)

				arg_248_1.leftNameTxt_.text = var_251_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_7 = arg_248_1:GetWordFromCfg(321021059)
				local var_251_8 = arg_248_1:FormatText(var_251_7.content)

				arg_248_1.text_.text = var_251_8

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_9 = 4
				local var_251_10 = utf8.len(var_251_8)
				local var_251_11 = var_251_9 <= 0 and var_251_5 or var_251_5 * (var_251_10 / var_251_9)

				if var_251_11 > 0 and var_251_5 < var_251_11 then
					arg_248_1.talkMaxDuration = var_251_11

					if var_251_11 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_11 + var_251_4
					end
				end

				arg_248_1.text_.text = var_251_8
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321021", "321021059", "story_v_out_321021.awb") ~= 0 then
					local var_251_12 = manager.audio:GetVoiceLength("story_v_out_321021", "321021059", "story_v_out_321021.awb") / 1000

					if var_251_12 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_12 + var_251_4
					end

					if var_251_7.prefab_name ~= "" and arg_248_1.actors_[var_251_7.prefab_name] ~= nil then
						local var_251_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_7.prefab_name].transform, "story_v_out_321021", "321021059", "story_v_out_321021.awb")

						arg_248_1:RecordAudio("321021059", var_251_13)
						arg_248_1:RecordAudio("321021059", var_251_13)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_321021", "321021059", "story_v_out_321021.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_321021", "321021059", "story_v_out_321021.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_14 = math.max(var_251_5, arg_248_1.talkMaxDuration)

			if var_251_4 <= arg_248_1.time_ and arg_248_1.time_ < var_251_4 + var_251_14 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_4) / var_251_14

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_4 + var_251_14 and arg_248_1.time_ < var_251_4 + var_251_14 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play321021060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 321021060
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
			arg_252_1.auto_ = false
		end

		function arg_252_1.playNext_(arg_254_0)
			arg_252_1.onStoryFinished_()
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10104ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect10104ui_story == nil then
				arg_252_1.var_.characterEffect10104ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect10104ui_story and not isNil(var_255_0) then
					local var_255_4 = Mathf.Lerp(0, 0.5, var_255_3)

					arg_252_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_252_1.var_.characterEffect10104ui_story.fillRatio = var_255_4
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect10104ui_story then
				local var_255_5 = 0.5

				arg_252_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_252_1.var_.characterEffect10104ui_story.fillRatio = var_255_5
			end

			local var_255_6 = 0
			local var_255_7 = 0.5

			if var_255_6 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_8 = arg_252_1:FormatText(StoryNameCfg[7].name)

				arg_252_1.leftNameTxt_.text = var_255_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_9 = arg_252_1:GetWordFromCfg(321021060)
				local var_255_10 = arg_252_1:FormatText(var_255_9.content)

				arg_252_1.text_.text = var_255_10

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_11 = 20
				local var_255_12 = utf8.len(var_255_10)
				local var_255_13 = var_255_11 <= 0 and var_255_7 or var_255_7 * (var_255_12 / var_255_11)

				if var_255_13 > 0 and var_255_7 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_10
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_14 and arg_252_1.time_ < var_255_6 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L06g",
		"TextureConfig/Background/ST0506",
		"TextureConfig/Background/L13f",
		"TextureConfig/Background/L08f"
	},
	voices = {
		"story_v_out_321021.awb"
	}
}
