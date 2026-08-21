return {
	Play106132001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106132001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play106132002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "C01b"

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
				local var_4_5 = arg_1_1.bgs_.C01b

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
					if iter_4_0 ~= "C01b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.C01b
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueC01b = var_4_18.color.a
					arg_1_1.var_.alphaMatValueC01b = var_4_18
				end

				arg_1_1.var_.alphaOldValueC01b = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueC01b, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueC01b then
					local var_4_22 = arg_1_1.var_.alphaMatValueC01b.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueC01b.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueC01b then
				local var_4_23 = arg_1_1.var_.alphaMatValueC01b
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = manager.ui.mainCamera.transform
			local var_4_26 = 1

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_25.localPosition
			end

			local var_4_27 = 0.6

			if var_4_26 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				local var_4_28 = (arg_1_1.time_ - var_4_26) / 0.066
				local var_4_29, var_4_30 = math.modf(var_4_28)

				var_4_25.localPosition = Vector3.New(var_4_30 * 0.13, var_4_30 * 0.13, var_4_30 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				var_4_25.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_31 = manager.ui.mainCamera.transform
			local var_4_32 = 2

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_31.localPosition
			end

			local var_4_33 = 0.6

			if var_4_32 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				local var_4_34 = (arg_1_1.time_ - var_4_32) / 0.099
				local var_4_35, var_4_36 = math.modf(var_4_34)

				var_4_31.localPosition = Vector3.New(var_4_36 * 0.13, var_4_36 * 0.13, var_4_36 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				var_4_31.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_37 = 0
			local var_4_38 = 1

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				local var_4_39 = "play"
				local var_4_40 = "music"

				arg_1_1:AudioAction(var_4_39, var_4_40, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_41 = ""
				local var_4_42 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_42 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_42 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_42

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_42
						arg_1_1.bgmTxt2_.text = var_4_42
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

			local var_4_43 = 0

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_44 = 2

			if arg_1_1.time_ >= var_4_43 + var_4_44 and arg_1_1.time_ < var_4_43 + var_4_44 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_45 = 0
			local var_4_46 = 2.10843759123236

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "effect"

				arg_1_1:AudioAction(var_4_47, var_4_48, "se_story_6", "se_story_6_giant_sword", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_49 = 2
			local var_4_50 = 0.65

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_51 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_51:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_52 = arg_1_1:GetWordFromCfg(106132001)
				local var_4_53 = arg_1_1:FormatText(var_4_52.content)

				arg_1_1.text_.text = var_4_53

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_54 = 26
				local var_4_55 = utf8.len(var_4_53)
				local var_4_56 = var_4_54 <= 0 and var_4_50 or var_4_50 * (var_4_55 / var_4_54)

				if var_4_56 > 0 and var_4_50 < var_4_56 then
					arg_1_1.talkMaxDuration = var_4_56
					var_4_49 = var_4_49 + 0.3

					if var_4_56 + var_4_49 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_56 + var_4_49
					end
				end

				arg_1_1.text_.text = var_4_53
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_57 = var_4_49 + 0.3
			local var_4_58 = math.max(var_4_50, arg_1_1.talkMaxDuration)

			if var_4_57 <= arg_1_1.time_ and arg_1_1.time_ < var_4_57 + var_4_58 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_57) / var_4_58

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_57 + var_4_58 and arg_1_1.time_ < var_4_57 + var_4_58 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play106132002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 106132002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play106132003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.275

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

				local var_11_2 = arg_8_1:GetWordFromCfg(106132002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 51
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
	Play106132003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 106132003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play106132004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 1

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

				local var_15_2 = arg_12_1:GetWordFromCfg(106132003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 40
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
	Play106132004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 106132004
		arg_16_1.duration_ = 3.7

		local var_16_0 = {
			ja = 2.866,
			ko = 3.4,
			zh = 3.7,
			en = 1.999999999999
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play106132005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "3004_tpose"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "3004_tpose")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["3004_tpose"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect3004_tpose == nil then
				arg_16_1.var_.characterEffect3004_tpose = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect3004_tpose and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect3004_tpose then
				arg_16_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_19_9 = arg_16_1.actors_["3004_tpose"].transform
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.var_.moveOldPos3004_tpose = var_19_9.localPosition

				local var_19_11 = GameObjectTools.GetOrAddComponent(var_19_9.gameObject, typeof(DynamicBoneHelper))

				if var_19_11 then
					var_19_11:EnableDynamicBone(false)
				end
			end

			local var_19_12 = 0.001

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_12 then
				local var_19_13 = (arg_16_1.time_ - var_19_10) / var_19_12
				local var_19_14 = Vector3.New(0, -2.22, -3.1)

				var_19_9.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3004_tpose, var_19_14, var_19_13)

				local var_19_15 = manager.ui.mainCamera.transform.position - var_19_9.position

				var_19_9.forward = Vector3.New(var_19_15.x, var_19_15.y, var_19_15.z)

				local var_19_16 = var_19_9.localEulerAngles

				var_19_16.z = 0
				var_19_16.x = 0
				var_19_9.localEulerAngles = var_19_16
			end

			if arg_16_1.time_ >= var_19_10 + var_19_12 and arg_16_1.time_ < var_19_10 + var_19_12 + arg_19_0 then
				var_19_9.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_19_17 = manager.ui.mainCamera.transform.position - var_19_9.position

				var_19_9.forward = Vector3.New(var_19_17.x, var_19_17.y, var_19_17.z)

				local var_19_18 = var_19_9.localEulerAngles

				var_19_18.z = 0
				var_19_18.x = 0
				var_19_9.localEulerAngles = var_19_18

				local var_19_19 = GameObjectTools.GetOrAddComponent(var_19_9.gameObject, typeof(DynamicBoneHelper))

				if var_19_19 then
					var_19_19:EnableDynamicBone(true)
				end
			end

			local var_19_20 = 0

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_19_21 = 0
			local var_19_22 = 0.125

			if var_19_21 < arg_16_1.time_ and arg_16_1.time_ <= var_19_21 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_23 = arg_16_1:FormatText(StoryNameCfg[82].name)

				arg_16_1.leftNameTxt_.text = var_19_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_24 = arg_16_1:GetWordFromCfg(106132004)
				local var_19_25 = arg_16_1:FormatText(var_19_24.content)

				arg_16_1.text_.text = var_19_25

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_26 = 5
				local var_19_27 = utf8.len(var_19_25)
				local var_19_28 = var_19_26 <= 0 and var_19_22 or var_19_22 * (var_19_27 / var_19_26)

				if var_19_28 > 0 and var_19_22 < var_19_28 then
					arg_16_1.talkMaxDuration = var_19_28

					if var_19_28 + var_19_21 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_28 + var_19_21
					end
				end

				arg_16_1.text_.text = var_19_25
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132004", "story_v_out_106132.awb") ~= 0 then
					local var_19_29 = manager.audio:GetVoiceLength("story_v_out_106132", "106132004", "story_v_out_106132.awb") / 1000

					if var_19_29 + var_19_21 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_29 + var_19_21
					end

					if var_19_24.prefab_name ~= "" and arg_16_1.actors_[var_19_24.prefab_name] ~= nil then
						local var_19_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_24.prefab_name].transform, "story_v_out_106132", "106132004", "story_v_out_106132.awb")

						arg_16_1:RecordAudio("106132004", var_19_30)
						arg_16_1:RecordAudio("106132004", var_19_30)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_106132", "106132004", "story_v_out_106132.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_106132", "106132004", "story_v_out_106132.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_31 = math.max(var_19_22, arg_16_1.talkMaxDuration)

			if var_19_21 <= arg_16_1.time_ and arg_16_1.time_ < var_19_21 + var_19_31 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_21) / var_19_31

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_21 + var_19_31 and arg_16_1.time_ < var_19_21 + var_19_31 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play106132005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 106132005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play106132006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["3004_tpose"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect3004_tpose == nil then
				arg_20_1.var_.characterEffect3004_tpose = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect3004_tpose and not isNil(var_23_0) then
					local var_23_4 = Mathf.Lerp(0, 0.5, var_23_3)

					arg_20_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_20_1.var_.characterEffect3004_tpose.fillRatio = var_23_4
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect3004_tpose then
				local var_23_5 = 0.5

				arg_20_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_20_1.var_.characterEffect3004_tpose.fillRatio = var_23_5
			end

			local var_23_6 = arg_20_1.actors_["3004_tpose"].transform
			local var_23_7 = 0

			if var_23_7 < arg_20_1.time_ and arg_20_1.time_ <= var_23_7 + arg_23_0 then
				arg_20_1.var_.moveOldPos3004_tpose = var_23_6.localPosition

				local var_23_8 = GameObjectTools.GetOrAddComponent(var_23_6.gameObject, typeof(DynamicBoneHelper))

				if var_23_8 then
					var_23_8:EnableDynamicBone(false)
				end
			end

			local var_23_9 = 0.001

			if var_23_7 <= arg_20_1.time_ and arg_20_1.time_ < var_23_7 + var_23_9 then
				local var_23_10 = (arg_20_1.time_ - var_23_7) / var_23_9
				local var_23_11 = Vector3.New(0, 100, 0)

				var_23_6.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos3004_tpose, var_23_11, var_23_10)

				local var_23_12 = manager.ui.mainCamera.transform.position - var_23_6.position

				var_23_6.forward = Vector3.New(var_23_12.x, var_23_12.y, var_23_12.z)

				local var_23_13 = var_23_6.localEulerAngles

				var_23_13.z = 0
				var_23_13.x = 0
				var_23_6.localEulerAngles = var_23_13
			end

			if arg_20_1.time_ >= var_23_7 + var_23_9 and arg_20_1.time_ < var_23_7 + var_23_9 + arg_23_0 then
				var_23_6.localPosition = Vector3.New(0, 100, 0)

				local var_23_14 = manager.ui.mainCamera.transform.position - var_23_6.position

				var_23_6.forward = Vector3.New(var_23_14.x, var_23_14.y, var_23_14.z)

				local var_23_15 = var_23_6.localEulerAngles

				var_23_15.z = 0
				var_23_15.x = 0
				var_23_6.localEulerAngles = var_23_15

				local var_23_16 = GameObjectTools.GetOrAddComponent(var_23_6.gameObject, typeof(DynamicBoneHelper))

				if var_23_16 then
					var_23_16:EnableDynamicBone(true)
				end
			end

			local var_23_17 = 0
			local var_23_18 = 1.025

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_19 = arg_20_1:GetWordFromCfg(106132005)
				local var_23_20 = arg_20_1:FormatText(var_23_19.content)

				arg_20_1.text_.text = var_23_20

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_21 = 41
				local var_23_22 = utf8.len(var_23_20)
				local var_23_23 = var_23_21 <= 0 and var_23_18 or var_23_18 * (var_23_22 / var_23_21)

				if var_23_23 > 0 and var_23_18 < var_23_23 then
					arg_20_1.talkMaxDuration = var_23_23

					if var_23_23 + var_23_17 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_17
					end
				end

				arg_20_1.text_.text = var_23_20
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_24 = math.max(var_23_18, arg_20_1.talkMaxDuration)

			if var_23_17 <= arg_20_1.time_ and arg_20_1.time_ < var_23_17 + var_23_24 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_17) / var_23_24

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_17 + var_23_24 and arg_20_1.time_ < var_23_17 + var_23_24 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play106132006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 106132006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play106132007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.4
			local var_27_1 = 1

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				local var_27_2 = "play"
				local var_27_3 = "effect"

				arg_24_1:AudioAction(var_27_2, var_27_3, "se_story_6", "se_story_6_tearing", "")
			end

			local var_27_4 = 0
			local var_27_5 = 0.7

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_6 = arg_24_1:GetWordFromCfg(106132006)
				local var_27_7 = arg_24_1:FormatText(var_27_6.content)

				arg_24_1.text_.text = var_27_7

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_8 = 28
				local var_27_9 = utf8.len(var_27_7)
				local var_27_10 = var_27_8 <= 0 and var_27_5 or var_27_5 * (var_27_9 / var_27_8)

				if var_27_10 > 0 and var_27_5 < var_27_10 then
					arg_24_1.talkMaxDuration = var_27_10

					if var_27_10 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_7
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_11 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_11 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_11

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_11 and arg_24_1.time_ < var_27_4 + var_27_11 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play106132007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 106132007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play106132008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_1 = 0.5

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_1 then
				local var_31_2 = (arg_28_1.time_ - var_31_0) / var_31_1
				local var_31_3 = Color.New(1, 1, 1)

				var_31_3.a = Mathf.Lerp(1, 0, var_31_2)
				arg_28_1.mask_.color = var_31_3
			end

			if arg_28_1.time_ >= var_31_0 + var_31_1 and arg_28_1.time_ < var_31_0 + var_31_1 + arg_31_0 then
				local var_31_4 = Color.New(1, 1, 1)
				local var_31_5 = 0

				arg_28_1.mask_.enabled = false
				var_31_4.a = var_31_5
				arg_28_1.mask_.color = var_31_4
			end

			local var_31_6 = 0
			local var_31_7 = 1

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				local var_31_8 = "play"
				local var_31_9 = "effect"

				arg_28_1:AudioAction(var_31_8, var_31_9, "se_story_6", "se_story_6_burning", "")
			end

			local var_31_10 = 0
			local var_31_11 = 1.15

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(106132007)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_14 = 46
				local var_31_15 = utf8.len(var_31_13)
				local var_31_16 = var_31_14 <= 0 and var_31_11 or var_31_11 * (var_31_15 / var_31_14)

				if var_31_16 > 0 and var_31_11 < var_31_16 then
					arg_28_1.talkMaxDuration = var_31_16

					if var_31_16 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_17 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_17 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_17

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_17 and arg_28_1.time_ < var_31_10 + var_31_17 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play106132008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 106132008
		arg_32_1.duration_ = 5.17

		local var_32_0 = {
			ja = 2.266,
			ko = 3.1,
			zh = 5.166,
			en = 3.533
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
				arg_32_0:Play106132009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["3004_tpose"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3004_tpose == nil then
				arg_32_1.var_.characterEffect3004_tpose = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect3004_tpose and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3004_tpose then
				arg_32_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["3004_tpose"].transform
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.var_.moveOldPos3004_tpose = var_35_4.localPosition

				local var_35_6 = GameObjectTools.GetOrAddComponent(var_35_4.gameObject, typeof(DynamicBoneHelper))

				if var_35_6 then
					var_35_6:EnableDynamicBone(false)
				end
			end

			local var_35_7 = 0.001

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_7 then
				local var_35_8 = (arg_32_1.time_ - var_35_5) / var_35_7
				local var_35_9 = Vector3.New(0, -2.22, -3.1)

				var_35_4.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos3004_tpose, var_35_9, var_35_8)

				local var_35_10 = manager.ui.mainCamera.transform.position - var_35_4.position

				var_35_4.forward = Vector3.New(var_35_10.x, var_35_10.y, var_35_10.z)

				local var_35_11 = var_35_4.localEulerAngles

				var_35_11.z = 0
				var_35_11.x = 0
				var_35_4.localEulerAngles = var_35_11
			end

			if arg_32_1.time_ >= var_35_5 + var_35_7 and arg_32_1.time_ < var_35_5 + var_35_7 + arg_35_0 then
				var_35_4.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_35_12 = manager.ui.mainCamera.transform.position - var_35_4.position

				var_35_4.forward = Vector3.New(var_35_12.x, var_35_12.y, var_35_12.z)

				local var_35_13 = var_35_4.localEulerAngles

				var_35_13.z = 0
				var_35_13.x = 0
				var_35_4.localEulerAngles = var_35_13

				local var_35_14 = GameObjectTools.GetOrAddComponent(var_35_4.gameObject, typeof(DynamicBoneHelper))

				if var_35_14 then
					var_35_14:EnableDynamicBone(true)
				end
			end

			local var_35_15 = 0

			if var_35_15 < arg_32_1.time_ and arg_32_1.time_ <= var_35_15 + arg_35_0 then
				arg_32_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_35_16 = 0
			local var_35_17 = 0.35

			if var_35_16 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_18 = arg_32_1:FormatText(StoryNameCfg[82].name)

				arg_32_1.leftNameTxt_.text = var_35_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_19 = arg_32_1:GetWordFromCfg(106132008)
				local var_35_20 = arg_32_1:FormatText(var_35_19.content)

				arg_32_1.text_.text = var_35_20

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_21 = 12
				local var_35_22 = utf8.len(var_35_20)
				local var_35_23 = var_35_21 <= 0 and var_35_17 or var_35_17 * (var_35_22 / var_35_21)

				if var_35_23 > 0 and var_35_17 < var_35_23 then
					arg_32_1.talkMaxDuration = var_35_23

					if var_35_23 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_23 + var_35_16
					end
				end

				arg_32_1.text_.text = var_35_20
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132008", "story_v_out_106132.awb") ~= 0 then
					local var_35_24 = manager.audio:GetVoiceLength("story_v_out_106132", "106132008", "story_v_out_106132.awb") / 1000

					if var_35_24 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_24 + var_35_16
					end

					if var_35_19.prefab_name ~= "" and arg_32_1.actors_[var_35_19.prefab_name] ~= nil then
						local var_35_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_19.prefab_name].transform, "story_v_out_106132", "106132008", "story_v_out_106132.awb")

						arg_32_1:RecordAudio("106132008", var_35_25)
						arg_32_1:RecordAudio("106132008", var_35_25)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_106132", "106132008", "story_v_out_106132.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_106132", "106132008", "story_v_out_106132.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_26 = math.max(var_35_17, arg_32_1.talkMaxDuration)

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_26 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_16) / var_35_26

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_16 + var_35_26 and arg_32_1.time_ < var_35_16 + var_35_26 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play106132009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 106132009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play106132010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["3004_tpose"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect3004_tpose == nil then
				arg_36_1.var_.characterEffect3004_tpose = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect3004_tpose and not isNil(var_39_0) then
					local var_39_4 = Mathf.Lerp(0, 0.5, var_39_3)

					arg_36_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_36_1.var_.characterEffect3004_tpose.fillRatio = var_39_4
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect3004_tpose then
				local var_39_5 = 0.5

				arg_36_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_36_1.var_.characterEffect3004_tpose.fillRatio = var_39_5
			end

			local var_39_6 = arg_36_1.actors_["3004_tpose"].transform
			local var_39_7 = 0

			if var_39_7 < arg_36_1.time_ and arg_36_1.time_ <= var_39_7 + arg_39_0 then
				arg_36_1.var_.moveOldPos3004_tpose = var_39_6.localPosition

				local var_39_8 = GameObjectTools.GetOrAddComponent(var_39_6.gameObject, typeof(DynamicBoneHelper))

				if var_39_8 then
					var_39_8:EnableDynamicBone(false)
				end
			end

			local var_39_9 = 0.001

			if var_39_7 <= arg_36_1.time_ and arg_36_1.time_ < var_39_7 + var_39_9 then
				local var_39_10 = (arg_36_1.time_ - var_39_7) / var_39_9
				local var_39_11 = Vector3.New(0, 100, 0)

				var_39_6.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos3004_tpose, var_39_11, var_39_10)

				local var_39_12 = manager.ui.mainCamera.transform.position - var_39_6.position

				var_39_6.forward = Vector3.New(var_39_12.x, var_39_12.y, var_39_12.z)

				local var_39_13 = var_39_6.localEulerAngles

				var_39_13.z = 0
				var_39_13.x = 0
				var_39_6.localEulerAngles = var_39_13
			end

			if arg_36_1.time_ >= var_39_7 + var_39_9 and arg_36_1.time_ < var_39_7 + var_39_9 + arg_39_0 then
				var_39_6.localPosition = Vector3.New(0, 100, 0)

				local var_39_14 = manager.ui.mainCamera.transform.position - var_39_6.position

				var_39_6.forward = Vector3.New(var_39_14.x, var_39_14.y, var_39_14.z)

				local var_39_15 = var_39_6.localEulerAngles

				var_39_15.z = 0
				var_39_15.x = 0
				var_39_6.localEulerAngles = var_39_15

				local var_39_16 = GameObjectTools.GetOrAddComponent(var_39_6.gameObject, typeof(DynamicBoneHelper))

				if var_39_16 then
					var_39_16:EnableDynamicBone(true)
				end
			end

			local var_39_17 = 0
			local var_39_18 = 0.775

			if var_39_17 < arg_36_1.time_ and arg_36_1.time_ <= var_39_17 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_19 = arg_36_1:GetWordFromCfg(106132009)
				local var_39_20 = arg_36_1:FormatText(var_39_19.content)

				arg_36_1.text_.text = var_39_20

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_21 = 31
				local var_39_22 = utf8.len(var_39_20)
				local var_39_23 = var_39_21 <= 0 and var_39_18 or var_39_18 * (var_39_22 / var_39_21)

				if var_39_23 > 0 and var_39_18 < var_39_23 then
					arg_36_1.talkMaxDuration = var_39_23

					if var_39_23 + var_39_17 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_17
					end
				end

				arg_36_1.text_.text = var_39_20
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_24 = math.max(var_39_18, arg_36_1.talkMaxDuration)

			if var_39_17 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_24 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_17) / var_39_24

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_17 + var_39_24 and arg_36_1.time_ < var_39_17 + var_39_24 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play106132010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 106132010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play106132011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = manager.ui.mainCamera.transform
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.var_.shakeOldPos = var_43_0.localPosition
			end

			local var_43_2 = 0.6

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / 0.099
				local var_43_4, var_43_5 = math.modf(var_43_3)

				var_43_0.localPosition = Vector3.New(var_43_5 * 0.13, var_43_5 * 0.13, var_43_5 * 0.13) + arg_40_1.var_.shakeOldPos
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 then
				var_43_0.localPosition = arg_40_1.var_.shakeOldPos
			end

			local var_43_6 = 0
			local var_43_7 = 1.3

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_8 = arg_40_1:GetWordFromCfg(106132010)
				local var_43_9 = arg_40_1:FormatText(var_43_8.content)

				arg_40_1.text_.text = var_43_9

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_10 = 52
				local var_43_11 = utf8.len(var_43_9)
				local var_43_12 = var_43_10 <= 0 and var_43_7 or var_43_7 * (var_43_11 / var_43_10)

				if var_43_12 > 0 and var_43_7 < var_43_12 then
					arg_40_1.talkMaxDuration = var_43_12

					if var_43_12 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_12 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_9
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_13 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_13 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_13

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_13 and arg_40_1.time_ < var_43_6 + var_43_13 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play106132011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 106132011
		arg_44_1.duration_ = 3.13

		local var_44_0 = {
			ja = 3.133,
			ko = 1.999999999999,
			zh = 2.333,
			en = 2.766
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
				arg_44_0:Play106132012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["3004_tpose"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect3004_tpose == nil then
				arg_44_1.var_.characterEffect3004_tpose = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect3004_tpose and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect3004_tpose then
				arg_44_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["3004_tpose"].transform
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.var_.moveOldPos3004_tpose = var_47_4.localPosition

				local var_47_6 = GameObjectTools.GetOrAddComponent(var_47_4.gameObject, typeof(DynamicBoneHelper))

				if var_47_6 then
					var_47_6:EnableDynamicBone(false)
				end
			end

			local var_47_7 = 0.001

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_7 then
				local var_47_8 = (arg_44_1.time_ - var_47_5) / var_47_7
				local var_47_9 = Vector3.New(0, -2.22, -3.1)

				var_47_4.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos3004_tpose, var_47_9, var_47_8)

				local var_47_10 = manager.ui.mainCamera.transform.position - var_47_4.position

				var_47_4.forward = Vector3.New(var_47_10.x, var_47_10.y, var_47_10.z)

				local var_47_11 = var_47_4.localEulerAngles

				var_47_11.z = 0
				var_47_11.x = 0
				var_47_4.localEulerAngles = var_47_11
			end

			if arg_44_1.time_ >= var_47_5 + var_47_7 and arg_44_1.time_ < var_47_5 + var_47_7 + arg_47_0 then
				var_47_4.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_47_12 = manager.ui.mainCamera.transform.position - var_47_4.position

				var_47_4.forward = Vector3.New(var_47_12.x, var_47_12.y, var_47_12.z)

				local var_47_13 = var_47_4.localEulerAngles

				var_47_13.z = 0
				var_47_13.x = 0
				var_47_4.localEulerAngles = var_47_13

				local var_47_14 = GameObjectTools.GetOrAddComponent(var_47_4.gameObject, typeof(DynamicBoneHelper))

				if var_47_14 then
					var_47_14:EnableDynamicBone(true)
				end
			end

			local var_47_15 = 0

			if var_47_15 < arg_44_1.time_ and arg_44_1.time_ <= var_47_15 + arg_47_0 then
				arg_44_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_47_16 = manager.ui.mainCamera.transform
			local var_47_17 = 0

			if var_47_17 < arg_44_1.time_ and arg_44_1.time_ <= var_47_17 + arg_47_0 then
				arg_44_1.var_.shakeOldPos = var_47_16.localPosition
			end

			local var_47_18 = 0.6

			if var_47_17 <= arg_44_1.time_ and arg_44_1.time_ < var_47_17 + var_47_18 then
				local var_47_19 = (arg_44_1.time_ - var_47_17) / 0.066
				local var_47_20, var_47_21 = math.modf(var_47_19)

				var_47_16.localPosition = Vector3.New(var_47_21 * 0.13, var_47_21 * 0.13, var_47_21 * 0.13) + arg_44_1.var_.shakeOldPos
			end

			if arg_44_1.time_ >= var_47_17 + var_47_18 and arg_44_1.time_ < var_47_17 + var_47_18 + arg_47_0 then
				var_47_16.localPosition = arg_44_1.var_.shakeOldPos
			end

			local var_47_22 = 0
			local var_47_23 = 0.125

			if var_47_22 < arg_44_1.time_ and arg_44_1.time_ <= var_47_22 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_24 = arg_44_1:FormatText(StoryNameCfg[82].name)

				arg_44_1.leftNameTxt_.text = var_47_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_25 = arg_44_1:GetWordFromCfg(106132011)
				local var_47_26 = arg_44_1:FormatText(var_47_25.content)

				arg_44_1.text_.text = var_47_26

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_27 = 5
				local var_47_28 = utf8.len(var_47_26)
				local var_47_29 = var_47_27 <= 0 and var_47_23 or var_47_23 * (var_47_28 / var_47_27)

				if var_47_29 > 0 and var_47_23 < var_47_29 then
					arg_44_1.talkMaxDuration = var_47_29

					if var_47_29 + var_47_22 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_29 + var_47_22
					end
				end

				arg_44_1.text_.text = var_47_26
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132011", "story_v_out_106132.awb") ~= 0 then
					local var_47_30 = manager.audio:GetVoiceLength("story_v_out_106132", "106132011", "story_v_out_106132.awb") / 1000

					if var_47_30 + var_47_22 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_30 + var_47_22
					end

					if var_47_25.prefab_name ~= "" and arg_44_1.actors_[var_47_25.prefab_name] ~= nil then
						local var_47_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_25.prefab_name].transform, "story_v_out_106132", "106132011", "story_v_out_106132.awb")

						arg_44_1:RecordAudio("106132011", var_47_31)
						arg_44_1:RecordAudio("106132011", var_47_31)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_106132", "106132011", "story_v_out_106132.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_106132", "106132011", "story_v_out_106132.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_32 = math.max(var_47_23, arg_44_1.talkMaxDuration)

			if var_47_22 <= arg_44_1.time_ and arg_44_1.time_ < var_47_22 + var_47_32 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_22) / var_47_32

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_22 + var_47_32 and arg_44_1.time_ < var_47_22 + var_47_32 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play106132012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 106132012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play106132013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["3004_tpose"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect3004_tpose == nil then
				arg_48_1.var_.characterEffect3004_tpose = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect3004_tpose and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_48_1.var_.characterEffect3004_tpose.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect3004_tpose then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_48_1.var_.characterEffect3004_tpose.fillRatio = var_51_5
			end

			local var_51_6 = arg_48_1.actors_["3004_tpose"].transform
			local var_51_7 = 0

			if var_51_7 < arg_48_1.time_ and arg_48_1.time_ <= var_51_7 + arg_51_0 then
				arg_48_1.var_.moveOldPos3004_tpose = var_51_6.localPosition

				local var_51_8 = GameObjectTools.GetOrAddComponent(var_51_6.gameObject, typeof(DynamicBoneHelper))

				if var_51_8 then
					var_51_8:EnableDynamicBone(false)
				end
			end

			local var_51_9 = 0.001

			if var_51_7 <= arg_48_1.time_ and arg_48_1.time_ < var_51_7 + var_51_9 then
				local var_51_10 = (arg_48_1.time_ - var_51_7) / var_51_9
				local var_51_11 = Vector3.New(0, 100, 0)

				var_51_6.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos3004_tpose, var_51_11, var_51_10)

				local var_51_12 = manager.ui.mainCamera.transform.position - var_51_6.position

				var_51_6.forward = Vector3.New(var_51_12.x, var_51_12.y, var_51_12.z)

				local var_51_13 = var_51_6.localEulerAngles

				var_51_13.z = 0
				var_51_13.x = 0
				var_51_6.localEulerAngles = var_51_13
			end

			if arg_48_1.time_ >= var_51_7 + var_51_9 and arg_48_1.time_ < var_51_7 + var_51_9 + arg_51_0 then
				var_51_6.localPosition = Vector3.New(0, 100, 0)

				local var_51_14 = manager.ui.mainCamera.transform.position - var_51_6.position

				var_51_6.forward = Vector3.New(var_51_14.x, var_51_14.y, var_51_14.z)

				local var_51_15 = var_51_6.localEulerAngles

				var_51_15.z = 0
				var_51_15.x = 0
				var_51_6.localEulerAngles = var_51_15

				local var_51_16 = GameObjectTools.GetOrAddComponent(var_51_6.gameObject, typeof(DynamicBoneHelper))

				if var_51_16 then
					var_51_16:EnableDynamicBone(true)
				end
			end

			local var_51_17 = 0
			local var_51_18 = 0.975

			if var_51_17 < arg_48_1.time_ and arg_48_1.time_ <= var_51_17 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_19 = arg_48_1:GetWordFromCfg(106132012)
				local var_51_20 = arg_48_1:FormatText(var_51_19.content)

				arg_48_1.text_.text = var_51_20

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_21 = 39
				local var_51_22 = utf8.len(var_51_20)
				local var_51_23 = var_51_21 <= 0 and var_51_18 or var_51_18 * (var_51_22 / var_51_21)

				if var_51_23 > 0 and var_51_18 < var_51_23 then
					arg_48_1.talkMaxDuration = var_51_23

					if var_51_23 + var_51_17 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_17
					end
				end

				arg_48_1.text_.text = var_51_20
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_24 = math.max(var_51_18, arg_48_1.talkMaxDuration)

			if var_51_17 <= arg_48_1.time_ and arg_48_1.time_ < var_51_17 + var_51_24 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_17) / var_51_24

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_17 + var_51_24 and arg_48_1.time_ < var_51_17 + var_51_24 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play106132013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 106132013
		arg_52_1.duration_ = 4.33

		local var_52_0 = {
			ja = 2.766,
			ko = 4.333,
			zh = 3.1,
			en = 3.266
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
				arg_52_0:Play106132014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["3004_tpose"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect3004_tpose == nil then
				arg_52_1.var_.characterEffect3004_tpose = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect3004_tpose and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect3004_tpose then
				arg_52_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["3004_tpose"].transform
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.var_.moveOldPos3004_tpose = var_55_4.localPosition

				local var_55_6 = GameObjectTools.GetOrAddComponent(var_55_4.gameObject, typeof(DynamicBoneHelper))

				if var_55_6 then
					var_55_6:EnableDynamicBone(false)
				end
			end

			local var_55_7 = 0.001

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_7 then
				local var_55_8 = (arg_52_1.time_ - var_55_5) / var_55_7
				local var_55_9 = Vector3.New(0, -2.22, -3.1)

				var_55_4.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos3004_tpose, var_55_9, var_55_8)

				local var_55_10 = manager.ui.mainCamera.transform.position - var_55_4.position

				var_55_4.forward = Vector3.New(var_55_10.x, var_55_10.y, var_55_10.z)

				local var_55_11 = var_55_4.localEulerAngles

				var_55_11.z = 0
				var_55_11.x = 0
				var_55_4.localEulerAngles = var_55_11
			end

			if arg_52_1.time_ >= var_55_5 + var_55_7 and arg_52_1.time_ < var_55_5 + var_55_7 + arg_55_0 then
				var_55_4.localPosition = Vector3.New(0, -2.22, -3.1)

				local var_55_12 = manager.ui.mainCamera.transform.position - var_55_4.position

				var_55_4.forward = Vector3.New(var_55_12.x, var_55_12.y, var_55_12.z)

				local var_55_13 = var_55_4.localEulerAngles

				var_55_13.z = 0
				var_55_13.x = 0
				var_55_4.localEulerAngles = var_55_13

				local var_55_14 = GameObjectTools.GetOrAddComponent(var_55_4.gameObject, typeof(DynamicBoneHelper))

				if var_55_14 then
					var_55_14:EnableDynamicBone(true)
				end
			end

			local var_55_15 = 0

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_55_16 = 0
			local var_55_17 = 0.225

			if var_55_16 < arg_52_1.time_ and arg_52_1.time_ <= var_55_16 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_18 = arg_52_1:FormatText(StoryNameCfg[82].name)

				arg_52_1.leftNameTxt_.text = var_55_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_19 = arg_52_1:GetWordFromCfg(106132013)
				local var_55_20 = arg_52_1:FormatText(var_55_19.content)

				arg_52_1.text_.text = var_55_20

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_21 = 9
				local var_55_22 = utf8.len(var_55_20)
				local var_55_23 = var_55_21 <= 0 and var_55_17 or var_55_17 * (var_55_22 / var_55_21)

				if var_55_23 > 0 and var_55_17 < var_55_23 then
					arg_52_1.talkMaxDuration = var_55_23

					if var_55_23 + var_55_16 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_16
					end
				end

				arg_52_1.text_.text = var_55_20
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132013", "story_v_out_106132.awb") ~= 0 then
					local var_55_24 = manager.audio:GetVoiceLength("story_v_out_106132", "106132013", "story_v_out_106132.awb") / 1000

					if var_55_24 + var_55_16 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_24 + var_55_16
					end

					if var_55_19.prefab_name ~= "" and arg_52_1.actors_[var_55_19.prefab_name] ~= nil then
						local var_55_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_19.prefab_name].transform, "story_v_out_106132", "106132013", "story_v_out_106132.awb")

						arg_52_1:RecordAudio("106132013", var_55_25)
						arg_52_1:RecordAudio("106132013", var_55_25)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_106132", "106132013", "story_v_out_106132.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_106132", "106132013", "story_v_out_106132.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_26 = math.max(var_55_17, arg_52_1.talkMaxDuration)

			if var_55_16 <= arg_52_1.time_ and arg_52_1.time_ < var_55_16 + var_55_26 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_16) / var_55_26

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_16 + var_55_26 and arg_52_1.time_ < var_55_16 + var_55_26 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play106132014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 106132014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play106132015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["3004_tpose"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect3004_tpose == nil then
				arg_56_1.var_.characterEffect3004_tpose = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect3004_tpose and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_56_1.var_.characterEffect3004_tpose.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect3004_tpose then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_56_1.var_.characterEffect3004_tpose.fillRatio = var_59_5
			end

			local var_59_6 = arg_56_1.actors_["3004_tpose"].transform
			local var_59_7 = 0

			if var_59_7 < arg_56_1.time_ and arg_56_1.time_ <= var_59_7 + arg_59_0 then
				arg_56_1.var_.moveOldPos3004_tpose = var_59_6.localPosition

				local var_59_8 = GameObjectTools.GetOrAddComponent(var_59_6.gameObject, typeof(DynamicBoneHelper))

				if var_59_8 then
					var_59_8:EnableDynamicBone(false)
				end
			end

			local var_59_9 = 0.001

			if var_59_7 <= arg_56_1.time_ and arg_56_1.time_ < var_59_7 + var_59_9 then
				local var_59_10 = (arg_56_1.time_ - var_59_7) / var_59_9
				local var_59_11 = Vector3.New(0, 100, 0)

				var_59_6.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos3004_tpose, var_59_11, var_59_10)

				local var_59_12 = manager.ui.mainCamera.transform.position - var_59_6.position

				var_59_6.forward = Vector3.New(var_59_12.x, var_59_12.y, var_59_12.z)

				local var_59_13 = var_59_6.localEulerAngles

				var_59_13.z = 0
				var_59_13.x = 0
				var_59_6.localEulerAngles = var_59_13
			end

			if arg_56_1.time_ >= var_59_7 + var_59_9 and arg_56_1.time_ < var_59_7 + var_59_9 + arg_59_0 then
				var_59_6.localPosition = Vector3.New(0, 100, 0)

				local var_59_14 = manager.ui.mainCamera.transform.position - var_59_6.position

				var_59_6.forward = Vector3.New(var_59_14.x, var_59_14.y, var_59_14.z)

				local var_59_15 = var_59_6.localEulerAngles

				var_59_15.z = 0
				var_59_15.x = 0
				var_59_6.localEulerAngles = var_59_15

				local var_59_16 = GameObjectTools.GetOrAddComponent(var_59_6.gameObject, typeof(DynamicBoneHelper))

				if var_59_16 then
					var_59_16:EnableDynamicBone(true)
				end
			end

			local var_59_17 = 0.366666666666667
			local var_59_18 = 0.367

			if var_59_17 < arg_56_1.time_ and arg_56_1.time_ <= var_59_17 + arg_59_0 then
				local var_59_19 = "play"
				local var_59_20 = "effect"

				arg_56_1:AudioAction(var_59_19, var_59_20, "se_story_6", "se_story_6_snake02", "")
			end

			local var_59_21 = 0
			local var_59_22 = 1.025

			if var_59_21 < arg_56_1.time_ and arg_56_1.time_ <= var_59_21 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_23 = arg_56_1:GetWordFromCfg(106132014)
				local var_59_24 = arg_56_1:FormatText(var_59_23.content)

				arg_56_1.text_.text = var_59_24

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_25 = 41
				local var_59_26 = utf8.len(var_59_24)
				local var_59_27 = var_59_25 <= 0 and var_59_22 or var_59_22 * (var_59_26 / var_59_25)

				if var_59_27 > 0 and var_59_22 < var_59_27 then
					arg_56_1.talkMaxDuration = var_59_27

					if var_59_27 + var_59_21 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_27 + var_59_21
					end
				end

				arg_56_1.text_.text = var_59_24
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_28 = math.max(var_59_22, arg_56_1.talkMaxDuration)

			if var_59_21 <= arg_56_1.time_ and arg_56_1.time_ < var_59_21 + var_59_28 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_21) / var_59_28

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_21 + var_59_28 and arg_56_1.time_ < var_59_21 + var_59_28 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play106132015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 106132015
		arg_60_1.duration_ = 9.97

		local var_60_0 = {
			ja = 3.4,
			ko = 6.9,
			zh = 9.966,
			en = 5.733
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
				arg_60_0:Play106132016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.675

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_2 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_2:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_3 = arg_60_1:FormatText(StoryNameCfg[82].name)

				arg_60_1.leftNameTxt_.text = var_63_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_4 = arg_60_1:GetWordFromCfg(106132015)
				local var_63_5 = arg_60_1:FormatText(var_63_4.content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_6 = 27
				local var_63_7 = utf8.len(var_63_5)
				local var_63_8 = var_63_6 <= 0 and var_63_1 or var_63_1 * (var_63_7 / var_63_6)

				if var_63_8 > 0 and var_63_1 < var_63_8 then
					arg_60_1.talkMaxDuration = var_63_8
					var_63_0 = var_63_0 + 0.3

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132015", "story_v_out_106132.awb") ~= 0 then
					local var_63_9 = manager.audio:GetVoiceLength("story_v_out_106132", "106132015", "story_v_out_106132.awb") / 1000

					if var_63_9 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_0
					end

					if var_63_4.prefab_name ~= "" and arg_60_1.actors_[var_63_4.prefab_name] ~= nil then
						local var_63_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_4.prefab_name].transform, "story_v_out_106132", "106132015", "story_v_out_106132.awb")

						arg_60_1:RecordAudio("106132015", var_63_10)
						arg_60_1:RecordAudio("106132015", var_63_10)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_106132", "106132015", "story_v_out_106132.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_106132", "106132015", "story_v_out_106132.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_11 = var_63_0 + 0.3
			local var_63_12 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_11 <= arg_60_1.time_ and arg_60_1.time_ < var_63_11 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_11) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_11 + var_63_12 and arg_60_1.time_ < var_63_11 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play106132016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 106132016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play106132017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["3004_tpose"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect3004_tpose == nil then
				arg_66_1.var_.characterEffect3004_tpose = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect3004_tpose and not isNil(var_69_0) then
					local var_69_4 = Mathf.Lerp(0, 0.5, var_69_3)

					arg_66_1.var_.characterEffect3004_tpose.fillFlat = true
					arg_66_1.var_.characterEffect3004_tpose.fillRatio = var_69_4
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect3004_tpose then
				local var_69_5 = 0.5

				arg_66_1.var_.characterEffect3004_tpose.fillFlat = true
				arg_66_1.var_.characterEffect3004_tpose.fillRatio = var_69_5
			end

			local var_69_6 = arg_66_1.actors_["3004_tpose"].transform
			local var_69_7 = 0

			if var_69_7 < arg_66_1.time_ and arg_66_1.time_ <= var_69_7 + arg_69_0 then
				arg_66_1.var_.moveOldPos3004_tpose = var_69_6.localPosition

				local var_69_8 = GameObjectTools.GetOrAddComponent(var_69_6.gameObject, typeof(DynamicBoneHelper))

				if var_69_8 then
					var_69_8:EnableDynamicBone(false)
				end
			end

			local var_69_9 = 0.001

			if var_69_7 <= arg_66_1.time_ and arg_66_1.time_ < var_69_7 + var_69_9 then
				local var_69_10 = (arg_66_1.time_ - var_69_7) / var_69_9
				local var_69_11 = Vector3.New(0, 100, 0)

				var_69_6.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos3004_tpose, var_69_11, var_69_10)

				local var_69_12 = manager.ui.mainCamera.transform.position - var_69_6.position

				var_69_6.forward = Vector3.New(var_69_12.x, var_69_12.y, var_69_12.z)

				local var_69_13 = var_69_6.localEulerAngles

				var_69_13.z = 0
				var_69_13.x = 0
				var_69_6.localEulerAngles = var_69_13
			end

			if arg_66_1.time_ >= var_69_7 + var_69_9 and arg_66_1.time_ < var_69_7 + var_69_9 + arg_69_0 then
				var_69_6.localPosition = Vector3.New(0, 100, 0)

				local var_69_14 = manager.ui.mainCamera.transform.position - var_69_6.position

				var_69_6.forward = Vector3.New(var_69_14.x, var_69_14.y, var_69_14.z)

				local var_69_15 = var_69_6.localEulerAngles

				var_69_15.z = 0
				var_69_15.x = 0
				var_69_6.localEulerAngles = var_69_15

				local var_69_16 = GameObjectTools.GetOrAddComponent(var_69_6.gameObject, typeof(DynamicBoneHelper))

				if var_69_16 then
					var_69_16:EnableDynamicBone(true)
				end
			end

			local var_69_17 = 0
			local var_69_18 = 1

			if var_69_17 < arg_66_1.time_ and arg_66_1.time_ <= var_69_17 + arg_69_0 then
				local var_69_19 = "play"
				local var_69_20 = "effect"

				arg_66_1:AudioAction(var_69_19, var_69_20, "se_story_6", "se_story_6_black_fog", "")
			end

			local var_69_21 = 0
			local var_69_22 = 1.1

			if var_69_21 < arg_66_1.time_ and arg_66_1.time_ <= var_69_21 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_23 = arg_66_1:GetWordFromCfg(106132016)
				local var_69_24 = arg_66_1:FormatText(var_69_23.content)

				arg_66_1.text_.text = var_69_24

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_25 = 44
				local var_69_26 = utf8.len(var_69_24)
				local var_69_27 = var_69_25 <= 0 and var_69_22 or var_69_22 * (var_69_26 / var_69_25)

				if var_69_27 > 0 and var_69_22 < var_69_27 then
					arg_66_1.talkMaxDuration = var_69_27

					if var_69_27 + var_69_21 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_27 + var_69_21
					end
				end

				arg_66_1.text_.text = var_69_24
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_28 = math.max(var_69_22, arg_66_1.talkMaxDuration)

			if var_69_21 <= arg_66_1.time_ and arg_66_1.time_ < var_69_21 + var_69_28 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_21) / var_69_28

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_21 + var_69_28 and arg_66_1.time_ < var_69_21 + var_69_28 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play106132017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 106132017
		arg_70_1.duration_ = 2

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play106132018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = "1099ui_story"

			if arg_70_1.actors_[var_73_0] == nil then
				local var_73_1 = Asset.Load("Char/" .. "1099ui_story")

				if not isNil(var_73_1) then
					local var_73_2 = Object.Instantiate(Asset.Load("Char/" .. "1099ui_story"), arg_70_1.stage_.transform)

					var_73_2.name = var_73_0
					var_73_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_70_1.actors_[var_73_0] = var_73_2

					local var_73_3 = var_73_2:GetComponentInChildren(typeof(CharacterEffect))

					var_73_3.enabled = true

					local var_73_4 = GameObjectTools.GetOrAddComponent(var_73_2, typeof(DynamicBoneHelper))

					if var_73_4 then
						var_73_4:EnableDynamicBone(false)
					end

					arg_70_1:ShowWeapon(var_73_3.transform, false)

					arg_70_1.var_[var_73_0 .. "Animator"] = var_73_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_70_1.var_[var_73_0 .. "Animator"].applyRootMotion = true
					arg_70_1.var_[var_73_0 .. "LipSync"] = var_73_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_73_5 = arg_70_1.actors_["1099ui_story"]
			local var_73_6 = 0

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect1099ui_story == nil then
				arg_70_1.var_.characterEffect1099ui_story = var_73_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_7 = 0.1

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_7 and not isNil(var_73_5) then
				local var_73_8 = (arg_70_1.time_ - var_73_6) / var_73_7

				if arg_70_1.var_.characterEffect1099ui_story and not isNil(var_73_5) then
					arg_70_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_6 + var_73_7 and arg_70_1.time_ < var_73_6 + var_73_7 + arg_73_0 and not isNil(var_73_5) and arg_70_1.var_.characterEffect1099ui_story then
				arg_70_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_73_9 = arg_70_1.actors_["1099ui_story"].transform
			local var_73_10 = 0

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1.var_.moveOldPos1099ui_story = var_73_9.localPosition
			end

			local var_73_11 = 0.001

			if var_73_10 <= arg_70_1.time_ and arg_70_1.time_ < var_73_10 + var_73_11 then
				local var_73_12 = (arg_70_1.time_ - var_73_10) / var_73_11
				local var_73_13 = Vector3.New(0, -1.08, -5.9)

				var_73_9.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1099ui_story, var_73_13, var_73_12)

				local var_73_14 = manager.ui.mainCamera.transform.position - var_73_9.position

				var_73_9.forward = Vector3.New(var_73_14.x, var_73_14.y, var_73_14.z)

				local var_73_15 = var_73_9.localEulerAngles

				var_73_15.z = 0
				var_73_15.x = 0
				var_73_9.localEulerAngles = var_73_15
			end

			if arg_70_1.time_ >= var_73_10 + var_73_11 and arg_70_1.time_ < var_73_10 + var_73_11 + arg_73_0 then
				var_73_9.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_73_16 = manager.ui.mainCamera.transform.position - var_73_9.position

				var_73_9.forward = Vector3.New(var_73_16.x, var_73_16.y, var_73_16.z)

				local var_73_17 = var_73_9.localEulerAngles

				var_73_17.z = 0
				var_73_17.x = 0
				var_73_9.localEulerAngles = var_73_17
			end

			local var_73_18 = 0

			if var_73_18 < arg_70_1.time_ and arg_70_1.time_ <= var_73_18 + arg_73_0 then
				arg_70_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			local var_73_19 = 0

			if var_73_19 < arg_70_1.time_ and arg_70_1.time_ <= var_73_19 + arg_73_0 then
				arg_70_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_73_20 = 0
			local var_73_21 = 0.125

			if var_73_20 < arg_70_1.time_ and arg_70_1.time_ <= var_73_20 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_22 = arg_70_1:FormatText(StoryNameCfg[84].name)

				arg_70_1.leftNameTxt_.text = var_73_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_23 = arg_70_1:GetWordFromCfg(106132017)
				local var_73_24 = arg_70_1:FormatText(var_73_23.content)

				arg_70_1.text_.text = var_73_24

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_25 = 5
				local var_73_26 = utf8.len(var_73_24)
				local var_73_27 = var_73_25 <= 0 and var_73_21 or var_73_21 * (var_73_26 / var_73_25)

				if var_73_27 > 0 and var_73_21 < var_73_27 then
					arg_70_1.talkMaxDuration = var_73_27

					if var_73_27 + var_73_20 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_27 + var_73_20
					end
				end

				arg_70_1.text_.text = var_73_24
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132017", "story_v_out_106132.awb") ~= 0 then
					local var_73_28 = manager.audio:GetVoiceLength("story_v_out_106132", "106132017", "story_v_out_106132.awb") / 1000

					if var_73_28 + var_73_20 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_28 + var_73_20
					end

					if var_73_23.prefab_name ~= "" and arg_70_1.actors_[var_73_23.prefab_name] ~= nil then
						local var_73_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_23.prefab_name].transform, "story_v_out_106132", "106132017", "story_v_out_106132.awb")

						arg_70_1:RecordAudio("106132017", var_73_29)
						arg_70_1:RecordAudio("106132017", var_73_29)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_106132", "106132017", "story_v_out_106132.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_106132", "106132017", "story_v_out_106132.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_30 = math.max(var_73_21, arg_70_1.talkMaxDuration)

			if var_73_20 <= arg_70_1.time_ and arg_70_1.time_ < var_73_20 + var_73_30 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_20) / var_73_30

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_20 + var_73_30 and arg_70_1.time_ < var_73_20 + var_73_30 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play106132018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 106132018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play106132019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1099ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1099ui_story == nil then
				arg_74_1.var_.characterEffect1099ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.1

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect1099ui_story and not isNil(var_77_0) then
					local var_77_4 = Mathf.Lerp(0, 0.5, var_77_3)

					arg_74_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1099ui_story.fillRatio = var_77_4
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1099ui_story then
				local var_77_5 = 0.5

				arg_74_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1099ui_story.fillRatio = var_77_5
			end

			local var_77_6 = arg_74_1.actors_["1099ui_story"].transform
			local var_77_7 = 0

			if var_77_7 < arg_74_1.time_ and arg_74_1.time_ <= var_77_7 + arg_77_0 then
				arg_74_1.var_.moveOldPos1099ui_story = var_77_6.localPosition
			end

			local var_77_8 = 0.001

			if var_77_7 <= arg_74_1.time_ and arg_74_1.time_ < var_77_7 + var_77_8 then
				local var_77_9 = (arg_74_1.time_ - var_77_7) / var_77_8
				local var_77_10 = Vector3.New(0, 100, 0)

				var_77_6.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1099ui_story, var_77_10, var_77_9)

				local var_77_11 = manager.ui.mainCamera.transform.position - var_77_6.position

				var_77_6.forward = Vector3.New(var_77_11.x, var_77_11.y, var_77_11.z)

				local var_77_12 = var_77_6.localEulerAngles

				var_77_12.z = 0
				var_77_12.x = 0
				var_77_6.localEulerAngles = var_77_12
			end

			if arg_74_1.time_ >= var_77_7 + var_77_8 and arg_74_1.time_ < var_77_7 + var_77_8 + arg_77_0 then
				var_77_6.localPosition = Vector3.New(0, 100, 0)

				local var_77_13 = manager.ui.mainCamera.transform.position - var_77_6.position

				var_77_6.forward = Vector3.New(var_77_13.x, var_77_13.y, var_77_13.z)

				local var_77_14 = var_77_6.localEulerAngles

				var_77_14.z = 0
				var_77_14.x = 0
				var_77_6.localEulerAngles = var_77_14
			end

			local var_77_15 = 0
			local var_77_16 = 0.525

			if var_77_15 < arg_74_1.time_ and arg_74_1.time_ <= var_77_15 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_17 = arg_74_1:GetWordFromCfg(106132018)
				local var_77_18 = arg_74_1:FormatText(var_77_17.content)

				arg_74_1.text_.text = var_77_18

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_19 = 21
				local var_77_20 = utf8.len(var_77_18)
				local var_77_21 = var_77_19 <= 0 and var_77_16 or var_77_16 * (var_77_20 / var_77_19)

				if var_77_21 > 0 and var_77_16 < var_77_21 then
					arg_74_1.talkMaxDuration = var_77_21

					if var_77_21 + var_77_15 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_21 + var_77_15
					end
				end

				arg_74_1.text_.text = var_77_18
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_22 = math.max(var_77_16, arg_74_1.talkMaxDuration)

			if var_77_15 <= arg_74_1.time_ and arg_74_1.time_ < var_77_15 + var_77_22 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_15) / var_77_22

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_15 + var_77_22 and arg_74_1.time_ < var_77_15 + var_77_22 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play106132019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 106132019
		arg_78_1.duration_ = 4

		local var_78_0 = {
			ja = 1.999999999999,
			ko = 2.233,
			zh = 2.8,
			en = 4
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
				arg_78_0:Play106132020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1099ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1099ui_story == nil then
				arg_78_1.var_.characterEffect1099ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.1

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1099ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1099ui_story then
				arg_78_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_81_4 = arg_78_1.actors_["1099ui_story"].transform
			local var_81_5 = 0

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.var_.moveOldPos1099ui_story = var_81_4.localPosition
			end

			local var_81_6 = 0.001

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_6 then
				local var_81_7 = (arg_78_1.time_ - var_81_5) / var_81_6
				local var_81_8 = Vector3.New(0, -1.08, -5.9)

				var_81_4.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1099ui_story, var_81_8, var_81_7)

				local var_81_9 = manager.ui.mainCamera.transform.position - var_81_4.position

				var_81_4.forward = Vector3.New(var_81_9.x, var_81_9.y, var_81_9.z)

				local var_81_10 = var_81_4.localEulerAngles

				var_81_10.z = 0
				var_81_10.x = 0
				var_81_4.localEulerAngles = var_81_10
			end

			if arg_78_1.time_ >= var_81_5 + var_81_6 and arg_78_1.time_ < var_81_5 + var_81_6 + arg_81_0 then
				var_81_4.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_81_11 = manager.ui.mainCamera.transform.position - var_81_4.position

				var_81_4.forward = Vector3.New(var_81_11.x, var_81_11.y, var_81_11.z)

				local var_81_12 = var_81_4.localEulerAngles

				var_81_12.z = 0
				var_81_12.x = 0
				var_81_4.localEulerAngles = var_81_12
			end

			local var_81_13 = 0

			if var_81_13 < arg_78_1.time_ and arg_78_1.time_ <= var_81_13 + arg_81_0 then
				arg_78_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action5_1")
			end

			local var_81_14 = 0

			if var_81_14 < arg_78_1.time_ and arg_78_1.time_ <= var_81_14 + arg_81_0 then
				arg_78_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_81_15 = 0
			local var_81_16 = 0.3

			if var_81_15 < arg_78_1.time_ and arg_78_1.time_ <= var_81_15 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_17 = arg_78_1:FormatText(StoryNameCfg[84].name)

				arg_78_1.leftNameTxt_.text = var_81_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_18 = arg_78_1:GetWordFromCfg(106132019)
				local var_81_19 = arg_78_1:FormatText(var_81_18.content)

				arg_78_1.text_.text = var_81_19

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_20 = 12
				local var_81_21 = utf8.len(var_81_19)
				local var_81_22 = var_81_20 <= 0 and var_81_16 or var_81_16 * (var_81_21 / var_81_20)

				if var_81_22 > 0 and var_81_16 < var_81_22 then
					arg_78_1.talkMaxDuration = var_81_22

					if var_81_22 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_22 + var_81_15
					end
				end

				arg_78_1.text_.text = var_81_19
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132019", "story_v_out_106132.awb") ~= 0 then
					local var_81_23 = manager.audio:GetVoiceLength("story_v_out_106132", "106132019", "story_v_out_106132.awb") / 1000

					if var_81_23 + var_81_15 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_23 + var_81_15
					end

					if var_81_18.prefab_name ~= "" and arg_78_1.actors_[var_81_18.prefab_name] ~= nil then
						local var_81_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_18.prefab_name].transform, "story_v_out_106132", "106132019", "story_v_out_106132.awb")

						arg_78_1:RecordAudio("106132019", var_81_24)
						arg_78_1:RecordAudio("106132019", var_81_24)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_106132", "106132019", "story_v_out_106132.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_106132", "106132019", "story_v_out_106132.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_25 = math.max(var_81_16, arg_78_1.talkMaxDuration)

			if var_81_15 <= arg_78_1.time_ and arg_78_1.time_ < var_81_15 + var_81_25 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_15) / var_81_25

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_15 + var_81_25 and arg_78_1.time_ < var_81_15 + var_81_25 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play106132020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 106132020
		arg_82_1.duration_ = 9.6

		local var_82_0 = {
			ja = 6.666,
			ko = 6.066,
			zh = 8.666,
			en = 9.6
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
				arg_82_0:Play106132021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = "1093ui_story"

			if arg_82_1.actors_[var_85_0] == nil then
				local var_85_1 = Asset.Load("Char/" .. "1093ui_story")

				if not isNil(var_85_1) then
					local var_85_2 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_82_1.stage_.transform)

					var_85_2.name = var_85_0
					var_85_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_82_1.actors_[var_85_0] = var_85_2

					local var_85_3 = var_85_2:GetComponentInChildren(typeof(CharacterEffect))

					var_85_3.enabled = true

					local var_85_4 = GameObjectTools.GetOrAddComponent(var_85_2, typeof(DynamicBoneHelper))

					if var_85_4 then
						var_85_4:EnableDynamicBone(false)
					end

					arg_82_1:ShowWeapon(var_85_3.transform, false)

					arg_82_1.var_[var_85_0 .. "Animator"] = var_85_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_82_1.var_[var_85_0 .. "Animator"].applyRootMotion = true
					arg_82_1.var_[var_85_0 .. "LipSync"] = var_85_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_85_5 = arg_82_1.actors_["1093ui_story"]
			local var_85_6 = 0

			if var_85_6 < arg_82_1.time_ and arg_82_1.time_ <= var_85_6 + arg_85_0 and not isNil(var_85_5) and arg_82_1.var_.characterEffect1093ui_story == nil then
				arg_82_1.var_.characterEffect1093ui_story = var_85_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_7 = 0.1

			if var_85_6 <= arg_82_1.time_ and arg_82_1.time_ < var_85_6 + var_85_7 and not isNil(var_85_5) then
				local var_85_8 = (arg_82_1.time_ - var_85_6) / var_85_7

				if arg_82_1.var_.characterEffect1093ui_story and not isNil(var_85_5) then
					arg_82_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_6 + var_85_7 and arg_82_1.time_ < var_85_6 + var_85_7 + arg_85_0 and not isNil(var_85_5) and arg_82_1.var_.characterEffect1093ui_story then
				arg_82_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_85_9 = arg_82_1.actors_["1099ui_story"]
			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect1099ui_story == nil then
				arg_82_1.var_.characterEffect1099ui_story = var_85_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_11 = 0.1

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_11 and not isNil(var_85_9) then
				local var_85_12 = (arg_82_1.time_ - var_85_10) / var_85_11

				if arg_82_1.var_.characterEffect1099ui_story and not isNil(var_85_9) then
					local var_85_13 = Mathf.Lerp(0, 0.5, var_85_12)

					arg_82_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1099ui_story.fillRatio = var_85_13
				end
			end

			if arg_82_1.time_ >= var_85_10 + var_85_11 and arg_82_1.time_ < var_85_10 + var_85_11 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect1099ui_story then
				local var_85_14 = 0.5

				arg_82_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1099ui_story.fillRatio = var_85_14
			end

			local var_85_15 = arg_82_1.actors_["1099ui_story"].transform
			local var_85_16 = 0

			if var_85_16 < arg_82_1.time_ and arg_82_1.time_ <= var_85_16 + arg_85_0 then
				arg_82_1.var_.moveOldPos1099ui_story = var_85_15.localPosition
			end

			local var_85_17 = 0.001

			if var_85_16 <= arg_82_1.time_ and arg_82_1.time_ < var_85_16 + var_85_17 then
				local var_85_18 = (arg_82_1.time_ - var_85_16) / var_85_17
				local var_85_19 = Vector3.New(0, -1.08, -5.9)

				var_85_15.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1099ui_story, var_85_19, var_85_18)

				local var_85_20 = manager.ui.mainCamera.transform.position - var_85_15.position

				var_85_15.forward = Vector3.New(var_85_20.x, var_85_20.y, var_85_20.z)

				local var_85_21 = var_85_15.localEulerAngles

				var_85_21.z = 0
				var_85_21.x = 0
				var_85_15.localEulerAngles = var_85_21
			end

			if arg_82_1.time_ >= var_85_16 + var_85_17 and arg_82_1.time_ < var_85_16 + var_85_17 + arg_85_0 then
				var_85_15.localPosition = Vector3.New(0, -1.08, -5.9)

				local var_85_22 = manager.ui.mainCamera.transform.position - var_85_15.position

				var_85_15.forward = Vector3.New(var_85_22.x, var_85_22.y, var_85_22.z)

				local var_85_23 = var_85_15.localEulerAngles

				var_85_23.z = 0
				var_85_23.x = 0
				var_85_15.localEulerAngles = var_85_23
			end

			local var_85_24 = arg_82_1.actors_["1099ui_story"].transform
			local var_85_25 = 0.033

			if var_85_25 < arg_82_1.time_ and arg_82_1.time_ <= var_85_25 + arg_85_0 then
				arg_82_1.var_.moveOldPos1099ui_story = var_85_24.localPosition
			end

			local var_85_26 = 0.5

			if var_85_25 <= arg_82_1.time_ and arg_82_1.time_ < var_85_25 + var_85_26 then
				local var_85_27 = (arg_82_1.time_ - var_85_25) / var_85_26
				local var_85_28 = Vector3.New(0.7, -1.08, -5.9)

				var_85_24.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1099ui_story, var_85_28, var_85_27)

				local var_85_29 = manager.ui.mainCamera.transform.position - var_85_24.position

				var_85_24.forward = Vector3.New(var_85_29.x, var_85_29.y, var_85_29.z)

				local var_85_30 = var_85_24.localEulerAngles

				var_85_30.z = 0
				var_85_30.x = 0
				var_85_24.localEulerAngles = var_85_30
			end

			if arg_82_1.time_ >= var_85_25 + var_85_26 and arg_82_1.time_ < var_85_25 + var_85_26 + arg_85_0 then
				var_85_24.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_85_31 = manager.ui.mainCamera.transform.position - var_85_24.position

				var_85_24.forward = Vector3.New(var_85_31.x, var_85_31.y, var_85_31.z)

				local var_85_32 = var_85_24.localEulerAngles

				var_85_32.z = 0
				var_85_32.x = 0
				var_85_24.localEulerAngles = var_85_32
			end

			local var_85_33 = arg_82_1.actors_["1093ui_story"].transform
			local var_85_34 = 0

			if var_85_34 < arg_82_1.time_ and arg_82_1.time_ <= var_85_34 + arg_85_0 then
				arg_82_1.var_.moveOldPos1093ui_story = var_85_33.localPosition

				local var_85_35 = "1093ui_story"

				arg_82_1:ShowWeapon(arg_82_1.var_[var_85_35 .. "Animator"].transform, true)
			end

			local var_85_36 = 0.001

			if var_85_34 <= arg_82_1.time_ and arg_82_1.time_ < var_85_34 + var_85_36 then
				local var_85_37 = (arg_82_1.time_ - var_85_34) / var_85_36
				local var_85_38 = Vector3.New(-0.7, -1.11, -5.88)

				var_85_33.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1093ui_story, var_85_38, var_85_37)

				local var_85_39 = manager.ui.mainCamera.transform.position - var_85_33.position

				var_85_33.forward = Vector3.New(var_85_39.x, var_85_39.y, var_85_39.z)

				local var_85_40 = var_85_33.localEulerAngles

				var_85_40.z = 0
				var_85_40.x = 0
				var_85_33.localEulerAngles = var_85_40
			end

			if arg_82_1.time_ >= var_85_34 + var_85_36 and arg_82_1.time_ < var_85_34 + var_85_36 + arg_85_0 then
				var_85_33.localPosition = Vector3.New(-0.7, -1.11, -5.88)

				local var_85_41 = manager.ui.mainCamera.transform.position - var_85_33.position

				var_85_33.forward = Vector3.New(var_85_41.x, var_85_41.y, var_85_41.z)

				local var_85_42 = var_85_33.localEulerAngles

				var_85_42.z = 0
				var_85_42.x = 0
				var_85_33.localEulerAngles = var_85_42
			end

			local var_85_43 = 0

			if var_85_43 < arg_82_1.time_ and arg_82_1.time_ <= var_85_43 + arg_85_0 then
				arg_82_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action10_2")
			end

			local var_85_44 = 0

			if var_85_44 < arg_82_1.time_ and arg_82_1.time_ <= var_85_44 + arg_85_0 then
				arg_82_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_85_45 = 0
			local var_85_46 = 0.8

			if var_85_45 < arg_82_1.time_ and arg_82_1.time_ <= var_85_45 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_47 = arg_82_1:FormatText(StoryNameCfg[73].name)

				arg_82_1.leftNameTxt_.text = var_85_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_48 = arg_82_1:GetWordFromCfg(106132020)
				local var_85_49 = arg_82_1:FormatText(var_85_48.content)

				arg_82_1.text_.text = var_85_49

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_50 = 32
				local var_85_51 = utf8.len(var_85_49)
				local var_85_52 = var_85_50 <= 0 and var_85_46 or var_85_46 * (var_85_51 / var_85_50)

				if var_85_52 > 0 and var_85_46 < var_85_52 then
					arg_82_1.talkMaxDuration = var_85_52

					if var_85_52 + var_85_45 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_52 + var_85_45
					end
				end

				arg_82_1.text_.text = var_85_49
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132020", "story_v_out_106132.awb") ~= 0 then
					local var_85_53 = manager.audio:GetVoiceLength("story_v_out_106132", "106132020", "story_v_out_106132.awb") / 1000

					if var_85_53 + var_85_45 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_53 + var_85_45
					end

					if var_85_48.prefab_name ~= "" and arg_82_1.actors_[var_85_48.prefab_name] ~= nil then
						local var_85_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_48.prefab_name].transform, "story_v_out_106132", "106132020", "story_v_out_106132.awb")

						arg_82_1:RecordAudio("106132020", var_85_54)
						arg_82_1:RecordAudio("106132020", var_85_54)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_106132", "106132020", "story_v_out_106132.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_106132", "106132020", "story_v_out_106132.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_55 = math.max(var_85_46, arg_82_1.talkMaxDuration)

			if var_85_45 <= arg_82_1.time_ and arg_82_1.time_ < var_85_45 + var_85_55 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_45) / var_85_55

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_45 + var_85_55 and arg_82_1.time_ < var_85_45 + var_85_55 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play106132021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 106132021
		arg_86_1.duration_ = 5.33

		local var_86_0 = {
			ja = 3.033,
			ko = 2.766,
			zh = 3,
			en = 5.333
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play106132022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1099ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1099ui_story == nil then
				arg_86_1.var_.characterEffect1099ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.1

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1099ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1099ui_story then
				arg_86_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_89_4 = arg_86_1.actors_["1093ui_story"]
			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect1093ui_story == nil then
				arg_86_1.var_.characterEffect1093ui_story = var_89_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.1

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 and not isNil(var_89_4) then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6

				if arg_86_1.var_.characterEffect1093ui_story and not isNil(var_89_4) then
					local var_89_8 = Mathf.Lerp(0, 0.5, var_89_7)

					arg_86_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1093ui_story.fillRatio = var_89_8
				end
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect1093ui_story then
				local var_89_9 = 0.5

				arg_86_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1093ui_story.fillRatio = var_89_9
			end

			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action456")
			end

			local var_89_11 = 0

			if var_89_11 < arg_86_1.time_ and arg_86_1.time_ <= var_89_11 + arg_89_0 then
				arg_86_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_89_12 = 0
			local var_89_13 = 0.4

			if var_89_12 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_14 = arg_86_1:FormatText(StoryNameCfg[84].name)

				arg_86_1.leftNameTxt_.text = var_89_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_15 = arg_86_1:GetWordFromCfg(106132021)
				local var_89_16 = arg_86_1:FormatText(var_89_15.content)

				arg_86_1.text_.text = var_89_16

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_17 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132021", "story_v_out_106132.awb") ~= 0 then
					local var_89_20 = manager.audio:GetVoiceLength("story_v_out_106132", "106132021", "story_v_out_106132.awb") / 1000

					if var_89_20 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_20 + var_89_12
					end

					if var_89_15.prefab_name ~= "" and arg_86_1.actors_[var_89_15.prefab_name] ~= nil then
						local var_89_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_15.prefab_name].transform, "story_v_out_106132", "106132021", "story_v_out_106132.awb")

						arg_86_1:RecordAudio("106132021", var_89_21)
						arg_86_1:RecordAudio("106132021", var_89_21)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_106132", "106132021", "story_v_out_106132.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_106132", "106132021", "story_v_out_106132.awb")
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
	Play106132022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 106132022
		arg_90_1.duration_ = 8.13

		local var_90_0 = {
			ja = 8.066,
			ko = 5.433,
			zh = 8.133,
			en = 6.666
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
				arg_90_0:Play106132023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1093ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1093ui_story == nil then
				arg_90_1.var_.characterEffect1093ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.1

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1093ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1093ui_story then
				arg_90_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_93_4 = arg_90_1.actors_["1099ui_story"]
			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect1099ui_story == nil then
				arg_90_1.var_.characterEffect1099ui_story = var_93_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_6 = 0.1

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_6 and not isNil(var_93_4) then
				local var_93_7 = (arg_90_1.time_ - var_93_5) / var_93_6

				if arg_90_1.var_.characterEffect1099ui_story and not isNil(var_93_4) then
					local var_93_8 = Mathf.Lerp(0, 0.5, var_93_7)

					arg_90_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1099ui_story.fillRatio = var_93_8
				end
			end

			if arg_90_1.time_ >= var_93_5 + var_93_6 and arg_90_1.time_ < var_93_5 + var_93_6 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect1099ui_story then
				local var_93_9 = 0.5

				arg_90_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1099ui_story.fillRatio = var_93_9
			end

			local var_93_10 = 0

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 then
				arg_90_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_93_11 = 0
			local var_93_12 = 0.55

			if var_93_11 < arg_90_1.time_ and arg_90_1.time_ <= var_93_11 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_13 = arg_90_1:FormatText(StoryNameCfg[73].name)

				arg_90_1.leftNameTxt_.text = var_93_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_14 = arg_90_1:GetWordFromCfg(106132022)
				local var_93_15 = arg_90_1:FormatText(var_93_14.content)

				arg_90_1.text_.text = var_93_15

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_16 = 22
				local var_93_17 = utf8.len(var_93_15)
				local var_93_18 = var_93_16 <= 0 and var_93_12 or var_93_12 * (var_93_17 / var_93_16)

				if var_93_18 > 0 and var_93_12 < var_93_18 then
					arg_90_1.talkMaxDuration = var_93_18

					if var_93_18 + var_93_11 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_18 + var_93_11
					end
				end

				arg_90_1.text_.text = var_93_15
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132022", "story_v_out_106132.awb") ~= 0 then
					local var_93_19 = manager.audio:GetVoiceLength("story_v_out_106132", "106132022", "story_v_out_106132.awb") / 1000

					if var_93_19 + var_93_11 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_19 + var_93_11
					end

					if var_93_14.prefab_name ~= "" and arg_90_1.actors_[var_93_14.prefab_name] ~= nil then
						local var_93_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_14.prefab_name].transform, "story_v_out_106132", "106132022", "story_v_out_106132.awb")

						arg_90_1:RecordAudio("106132022", var_93_20)
						arg_90_1:RecordAudio("106132022", var_93_20)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_106132", "106132022", "story_v_out_106132.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_106132", "106132022", "story_v_out_106132.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_21 = math.max(var_93_12, arg_90_1.talkMaxDuration)

			if var_93_11 <= arg_90_1.time_ and arg_90_1.time_ < var_93_11 + var_93_21 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_11) / var_93_21

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_11 + var_93_21 and arg_90_1.time_ < var_93_11 + var_93_21 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play106132023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 106132023
		arg_94_1.duration_ = 2

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play106132024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1099ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1099ui_story == nil then
				arg_94_1.var_.characterEffect1099ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.1

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1099ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1099ui_story then
				arg_94_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_97_4 = arg_94_1.actors_["1093ui_story"]
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect1093ui_story == nil then
				arg_94_1.var_.characterEffect1093ui_story = var_97_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.1

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 and not isNil(var_97_4) then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6

				if arg_94_1.var_.characterEffect1093ui_story and not isNil(var_97_4) then
					local var_97_8 = Mathf.Lerp(0, 0.5, var_97_7)

					arg_94_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1093ui_story.fillRatio = var_97_8
				end
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect1093ui_story then
				local var_97_9 = 0.5

				arg_94_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1093ui_story.fillRatio = var_97_9
			end

			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_2")
			end

			local var_97_11 = 0

			if var_97_11 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				arg_94_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_97_12 = 0
			local var_97_13 = 0.15

			if var_97_12 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_14 = arg_94_1:FormatText(StoryNameCfg[84].name)

				arg_94_1.leftNameTxt_.text = var_97_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_15 = arg_94_1:GetWordFromCfg(106132023)
				local var_97_16 = arg_94_1:FormatText(var_97_15.content)

				arg_94_1.text_.text = var_97_16

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_17 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132023", "story_v_out_106132.awb") ~= 0 then
					local var_97_20 = manager.audio:GetVoiceLength("story_v_out_106132", "106132023", "story_v_out_106132.awb") / 1000

					if var_97_20 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_20 + var_97_12
					end

					if var_97_15.prefab_name ~= "" and arg_94_1.actors_[var_97_15.prefab_name] ~= nil then
						local var_97_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_15.prefab_name].transform, "story_v_out_106132", "106132023", "story_v_out_106132.awb")

						arg_94_1:RecordAudio("106132023", var_97_21)
						arg_94_1:RecordAudio("106132023", var_97_21)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_106132", "106132023", "story_v_out_106132.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_106132", "106132023", "story_v_out_106132.awb")
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
	Play106132024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 106132024
		arg_98_1.duration_ = 9.83

		local var_98_0 = {
			ja = 9.833,
			ko = 6.6,
			zh = 8.733,
			en = 6.033
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
				arg_98_0:Play106132025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1093ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1093ui_story == nil then
				arg_98_1.var_.characterEffect1093ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.1

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1093ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1093ui_story then
				arg_98_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["1099ui_story"]
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1099ui_story == nil then
				arg_98_1.var_.characterEffect1099ui_story = var_101_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.1

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 and not isNil(var_101_4) then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6

				if arg_98_1.var_.characterEffect1099ui_story and not isNil(var_101_4) then
					local var_101_8 = Mathf.Lerp(0, 0.5, var_101_7)

					arg_98_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1099ui_story.fillRatio = var_101_8
				end
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1099ui_story then
				local var_101_9 = 0.5

				arg_98_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1099ui_story.fillRatio = var_101_9
			end

			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_101_11 = 0
			local var_101_12 = 0.8

			if var_101_11 < arg_98_1.time_ and arg_98_1.time_ <= var_101_11 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_13 = arg_98_1:FormatText(StoryNameCfg[73].name)

				arg_98_1.leftNameTxt_.text = var_101_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_14 = arg_98_1:GetWordFromCfg(106132024)
				local var_101_15 = arg_98_1:FormatText(var_101_14.content)

				arg_98_1.text_.text = var_101_15

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_16 = 33
				local var_101_17 = utf8.len(var_101_15)
				local var_101_18 = var_101_16 <= 0 and var_101_12 or var_101_12 * (var_101_17 / var_101_16)

				if var_101_18 > 0 and var_101_12 < var_101_18 then
					arg_98_1.talkMaxDuration = var_101_18

					if var_101_18 + var_101_11 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_18 + var_101_11
					end
				end

				arg_98_1.text_.text = var_101_15
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132024", "story_v_out_106132.awb") ~= 0 then
					local var_101_19 = manager.audio:GetVoiceLength("story_v_out_106132", "106132024", "story_v_out_106132.awb") / 1000

					if var_101_19 + var_101_11 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_19 + var_101_11
					end

					if var_101_14.prefab_name ~= "" and arg_98_1.actors_[var_101_14.prefab_name] ~= nil then
						local var_101_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_14.prefab_name].transform, "story_v_out_106132", "106132024", "story_v_out_106132.awb")

						arg_98_1:RecordAudio("106132024", var_101_20)
						arg_98_1:RecordAudio("106132024", var_101_20)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_106132", "106132024", "story_v_out_106132.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_106132", "106132024", "story_v_out_106132.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_21 = math.max(var_101_12, arg_98_1.talkMaxDuration)

			if var_101_11 <= arg_98_1.time_ and arg_98_1.time_ < var_101_11 + var_101_21 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_11) / var_101_21

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_11 + var_101_21 and arg_98_1.time_ < var_101_11 + var_101_21 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play106132025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 106132025
		arg_102_1.duration_ = 12.13

		local var_102_0 = {
			ja = 12.133,
			ko = 8.366,
			zh = 7.066,
			en = 7.7
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
				arg_102_0:Play106132026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_105_1 = 0
			local var_105_2 = 0.725

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_3 = arg_102_1:FormatText(StoryNameCfg[73].name)

				arg_102_1.leftNameTxt_.text = var_105_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_4 = arg_102_1:GetWordFromCfg(106132025)
				local var_105_5 = arg_102_1:FormatText(var_105_4.content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_6 = 29
				local var_105_7 = utf8.len(var_105_5)
				local var_105_8 = var_105_6 <= 0 and var_105_2 or var_105_2 * (var_105_7 / var_105_6)

				if var_105_8 > 0 and var_105_2 < var_105_8 then
					arg_102_1.talkMaxDuration = var_105_8

					if var_105_8 + var_105_1 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_1
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132025", "story_v_out_106132.awb") ~= 0 then
					local var_105_9 = manager.audio:GetVoiceLength("story_v_out_106132", "106132025", "story_v_out_106132.awb") / 1000

					if var_105_9 + var_105_1 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_1
					end

					if var_105_4.prefab_name ~= "" and arg_102_1.actors_[var_105_4.prefab_name] ~= nil then
						local var_105_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_4.prefab_name].transform, "story_v_out_106132", "106132025", "story_v_out_106132.awb")

						arg_102_1:RecordAudio("106132025", var_105_10)
						arg_102_1:RecordAudio("106132025", var_105_10)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_106132", "106132025", "story_v_out_106132.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_106132", "106132025", "story_v_out_106132.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_11 = math.max(var_105_2, arg_102_1.talkMaxDuration)

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_11 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_1) / var_105_11

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_1 + var_105_11 and arg_102_1.time_ < var_105_1 + var_105_11 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play106132026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 106132026
		arg_106_1.duration_ = 7.03

		local var_106_0 = {
			ja = 7.033,
			ko = 4.4,
			zh = 5.066,
			en = 4.8
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
				arg_106_0:Play106132027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1099ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1099ui_story == nil then
				arg_106_1.var_.characterEffect1099ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.1

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1099ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1099ui_story then
				arg_106_1.var_.characterEffect1099ui_story.fillFlat = false
			end

			local var_109_4 = arg_106_1.actors_["1093ui_story"]
			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect1093ui_story == nil then
				arg_106_1.var_.characterEffect1093ui_story = var_109_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_6 = 0.1

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_6 and not isNil(var_109_4) then
				local var_109_7 = (arg_106_1.time_ - var_109_5) / var_109_6

				if arg_106_1.var_.characterEffect1093ui_story and not isNil(var_109_4) then
					local var_109_8 = Mathf.Lerp(0, 0.5, var_109_7)

					arg_106_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1093ui_story.fillRatio = var_109_8
				end
			end

			if arg_106_1.time_ >= var_109_5 + var_109_6 and arg_106_1.time_ < var_109_5 + var_109_6 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect1093ui_story then
				local var_109_9 = 0.5

				arg_106_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1093ui_story.fillRatio = var_109_9
			end

			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/story1099/story1099actionlink/1099action465")
			end

			local var_109_11 = 0

			if var_109_11 < arg_106_1.time_ and arg_106_1.time_ <= var_109_11 + arg_109_0 then
				arg_106_1:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_109_12 = 0
			local var_109_13 = 0.575

			if var_109_12 < arg_106_1.time_ and arg_106_1.time_ <= var_109_12 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_14 = arg_106_1:FormatText(StoryNameCfg[84].name)

				arg_106_1.leftNameTxt_.text = var_109_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_15 = arg_106_1:GetWordFromCfg(106132026)
				local var_109_16 = arg_106_1:FormatText(var_109_15.content)

				arg_106_1.text_.text = var_109_16

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_17 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132026", "story_v_out_106132.awb") ~= 0 then
					local var_109_20 = manager.audio:GetVoiceLength("story_v_out_106132", "106132026", "story_v_out_106132.awb") / 1000

					if var_109_20 + var_109_12 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_20 + var_109_12
					end

					if var_109_15.prefab_name ~= "" and arg_106_1.actors_[var_109_15.prefab_name] ~= nil then
						local var_109_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_15.prefab_name].transform, "story_v_out_106132", "106132026", "story_v_out_106132.awb")

						arg_106_1:RecordAudio("106132026", var_109_21)
						arg_106_1:RecordAudio("106132026", var_109_21)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_106132", "106132026", "story_v_out_106132.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_106132", "106132026", "story_v_out_106132.awb")
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
	Play106132027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 106132027
		arg_110_1.duration_ = 7.77

		local var_110_0 = {
			ja = 7.766,
			ko = 4.533,
			zh = 5.7,
			en = 6.566
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
				arg_110_0:Play106132028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1093ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1093ui_story == nil then
				arg_110_1.var_.characterEffect1093ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.1

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1093ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1093ui_story then
				arg_110_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			local var_113_4 = arg_110_1.actors_["1099ui_story"]
			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect1099ui_story == nil then
				arg_110_1.var_.characterEffect1099ui_story = var_113_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_6 = 0.1

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 and not isNil(var_113_4) then
				local var_113_7 = (arg_110_1.time_ - var_113_5) / var_113_6

				if arg_110_1.var_.characterEffect1099ui_story and not isNil(var_113_4) then
					local var_113_8 = Mathf.Lerp(0, 0.5, var_113_7)

					arg_110_1.var_.characterEffect1099ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1099ui_story.fillRatio = var_113_8
				end
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect1099ui_story then
				local var_113_9 = 0.5

				arg_110_1.var_.characterEffect1099ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1099ui_story.fillRatio = var_113_9
			end

			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_113_11 = 0
			local var_113_12 = 0.475

			if var_113_11 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_13 = arg_110_1:FormatText(StoryNameCfg[73].name)

				arg_110_1.leftNameTxt_.text = var_113_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_14 = arg_110_1:GetWordFromCfg(106132027)
				local var_113_15 = arg_110_1:FormatText(var_113_14.content)

				arg_110_1.text_.text = var_113_15

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_16 = 17
				local var_113_17 = utf8.len(var_113_15)
				local var_113_18 = var_113_16 <= 0 and var_113_12 or var_113_12 * (var_113_17 / var_113_16)

				if var_113_18 > 0 and var_113_12 < var_113_18 then
					arg_110_1.talkMaxDuration = var_113_18

					if var_113_18 + var_113_11 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_18 + var_113_11
					end
				end

				arg_110_1.text_.text = var_113_15
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132027", "story_v_out_106132.awb") ~= 0 then
					local var_113_19 = manager.audio:GetVoiceLength("story_v_out_106132", "106132027", "story_v_out_106132.awb") / 1000

					if var_113_19 + var_113_11 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_19 + var_113_11
					end

					if var_113_14.prefab_name ~= "" and arg_110_1.actors_[var_113_14.prefab_name] ~= nil then
						local var_113_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_14.prefab_name].transform, "story_v_out_106132", "106132027", "story_v_out_106132.awb")

						arg_110_1:RecordAudio("106132027", var_113_20)
						arg_110_1:RecordAudio("106132027", var_113_20)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_106132", "106132027", "story_v_out_106132.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_106132", "106132027", "story_v_out_106132.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_21 = math.max(var_113_12, arg_110_1.talkMaxDuration)

			if var_113_11 <= arg_110_1.time_ and arg_110_1.time_ < var_113_11 + var_113_21 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_11) / var_113_21

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_11 + var_113_21 and arg_110_1.time_ < var_113_11 + var_113_21 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play106132028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 106132028
		arg_114_1.duration_ = 8

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play106132029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1093ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1093ui_story == nil then
				arg_114_1.var_.characterEffect1093ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.1

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1093ui_story and not isNil(var_117_0) then
					local var_117_4 = Mathf.Lerp(0, 0.5, var_117_3)

					arg_114_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1093ui_story.fillRatio = var_117_4
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1093ui_story then
				local var_117_5 = 0.5

				arg_114_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1093ui_story.fillRatio = var_117_5
			end

			local var_117_6 = arg_114_1.bgs_.C01b.transform
			local var_117_7 = 1.5

			if var_117_7 < arg_114_1.time_ and arg_114_1.time_ <= var_117_7 + arg_117_0 then
				arg_114_1.var_.moveOldPosC01b = var_117_6.localPosition
			end

			local var_117_8 = 0.001

			if var_117_7 <= arg_114_1.time_ and arg_114_1.time_ < var_117_7 + var_117_8 then
				local var_117_9 = (arg_114_1.time_ - var_117_7) / var_117_8
				local var_117_10 = Vector3.New(0, -100, 10)

				var_117_6.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPosC01b, var_117_10, var_117_9)
			end

			if arg_114_1.time_ >= var_117_7 + var_117_8 and arg_114_1.time_ < var_117_7 + var_117_8 + arg_117_0 then
				var_117_6.localPosition = Vector3.New(0, -100, 10)
			end

			local var_117_11 = "C07_1"

			if arg_114_1.bgs_[var_117_11] == nil then
				local var_117_12 = Object.Instantiate(arg_114_1.paintGo_)

				var_117_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_117_11)
				var_117_12.name = var_117_11
				var_117_12.transform.parent = arg_114_1.stage_.transform
				var_117_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.bgs_[var_117_11] = var_117_12
			end

			local var_117_13 = 1.5

			if var_117_13 < arg_114_1.time_ and arg_114_1.time_ <= var_117_13 + arg_117_0 then
				local var_117_14 = manager.ui.mainCamera.transform.localPosition
				local var_117_15 = Vector3.New(0, 0, 10) + Vector3.New(var_117_14.x, var_117_14.y, 0)
				local var_117_16 = arg_114_1.bgs_.C07_1

				var_117_16.transform.localPosition = var_117_15
				var_117_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_17 = var_117_16:GetComponent("SpriteRenderer")

				if var_117_17 and var_117_17.sprite then
					local var_117_18 = (var_117_16.transform.localPosition - var_117_14).z
					local var_117_19 = manager.ui.mainCameraCom_
					local var_117_20 = 2 * var_117_18 * Mathf.Tan(var_117_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_117_21 = var_117_20 * var_117_19.aspect
					local var_117_22 = var_117_17.sprite.bounds.size.x
					local var_117_23 = var_117_17.sprite.bounds.size.y
					local var_117_24 = var_117_21 / var_117_22
					local var_117_25 = var_117_20 / var_117_23
					local var_117_26 = var_117_25 < var_117_24 and var_117_24 or var_117_25

					var_117_16.transform.localScale = Vector3.New(var_117_26, var_117_26, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "C07_1" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_27 = arg_114_1.actors_["1099ui_story"].transform
			local var_117_28 = 0

			if var_117_28 < arg_114_1.time_ and arg_114_1.time_ <= var_117_28 + arg_117_0 then
				arg_114_1.var_.moveOldPos1099ui_story = var_117_27.localPosition
			end

			local var_117_29 = 0.001

			if var_117_28 <= arg_114_1.time_ and arg_114_1.time_ < var_117_28 + var_117_29 then
				local var_117_30 = (arg_114_1.time_ - var_117_28) / var_117_29
				local var_117_31 = Vector3.New(0, 100, 0)

				var_117_27.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1099ui_story, var_117_31, var_117_30)

				local var_117_32 = manager.ui.mainCamera.transform.position - var_117_27.position

				var_117_27.forward = Vector3.New(var_117_32.x, var_117_32.y, var_117_32.z)

				local var_117_33 = var_117_27.localEulerAngles

				var_117_33.z = 0
				var_117_33.x = 0
				var_117_27.localEulerAngles = var_117_33
			end

			if arg_114_1.time_ >= var_117_28 + var_117_29 and arg_114_1.time_ < var_117_28 + var_117_29 + arg_117_0 then
				var_117_27.localPosition = Vector3.New(0, 100, 0)

				local var_117_34 = manager.ui.mainCamera.transform.position - var_117_27.position

				var_117_27.forward = Vector3.New(var_117_34.x, var_117_34.y, var_117_34.z)

				local var_117_35 = var_117_27.localEulerAngles

				var_117_35.z = 0
				var_117_35.x = 0
				var_117_27.localEulerAngles = var_117_35
			end

			local var_117_36 = arg_114_1.actors_["1093ui_story"].transform
			local var_117_37 = 0

			if var_117_37 < arg_114_1.time_ and arg_114_1.time_ <= var_117_37 + arg_117_0 then
				arg_114_1.var_.moveOldPos1093ui_story = var_117_36.localPosition
			end

			local var_117_38 = 0.001

			if var_117_37 <= arg_114_1.time_ and arg_114_1.time_ < var_117_37 + var_117_38 then
				local var_117_39 = (arg_114_1.time_ - var_117_37) / var_117_38
				local var_117_40 = Vector3.New(0, 100, 0)

				var_117_36.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1093ui_story, var_117_40, var_117_39)

				local var_117_41 = manager.ui.mainCamera.transform.position - var_117_36.position

				var_117_36.forward = Vector3.New(var_117_41.x, var_117_41.y, var_117_41.z)

				local var_117_42 = var_117_36.localEulerAngles

				var_117_42.z = 0
				var_117_42.x = 0
				var_117_36.localEulerAngles = var_117_42
			end

			if arg_114_1.time_ >= var_117_37 + var_117_38 and arg_114_1.time_ < var_117_37 + var_117_38 + arg_117_0 then
				var_117_36.localPosition = Vector3.New(0, 100, 0)

				local var_117_43 = manager.ui.mainCamera.transform.position - var_117_36.position

				var_117_36.forward = Vector3.New(var_117_43.x, var_117_43.y, var_117_43.z)

				local var_117_44 = var_117_36.localEulerAngles

				var_117_44.z = 0
				var_117_44.x = 0
				var_117_36.localEulerAngles = var_117_44
			end

			local var_117_45 = arg_114_1.bgs_.C07_1
			local var_117_46 = 1.5

			if var_117_46 < arg_114_1.time_ and arg_114_1.time_ <= var_117_46 + arg_117_0 then
				local var_117_47 = var_117_45:GetComponent("SpriteRenderer")

				if var_117_47 then
					arg_114_1.var_.alphaOldValueC07_1 = var_117_47.color.a
					arg_114_1.var_.alphaMatValueC07_1 = var_117_47
				end

				arg_114_1.var_.alphaOldValueC07_1 = 0
			end

			local var_117_48 = 1.5

			if var_117_46 <= arg_114_1.time_ and arg_114_1.time_ < var_117_46 + var_117_48 then
				local var_117_49 = (arg_114_1.time_ - var_117_46) / var_117_48
				local var_117_50 = Mathf.Lerp(arg_114_1.var_.alphaOldValueC07_1, 1, var_117_49)

				if arg_114_1.var_.alphaMatValueC07_1 then
					local var_117_51 = arg_114_1.var_.alphaMatValueC07_1.color

					var_117_51.a = var_117_50
					arg_114_1.var_.alphaMatValueC07_1.color = var_117_51
				end
			end

			if arg_114_1.time_ >= var_117_46 + var_117_48 and arg_114_1.time_ < var_117_46 + var_117_48 + arg_117_0 and arg_114_1.var_.alphaMatValueC07_1 then
				local var_117_52 = arg_114_1.var_.alphaMatValueC07_1
				local var_117_53 = var_117_52.color

				var_117_53.a = 1
				var_117_52.color = var_117_53
			end

			local var_117_54 = arg_114_1.bgs_.C01b
			local var_117_55 = 0

			if var_117_55 < arg_114_1.time_ and arg_114_1.time_ <= var_117_55 + arg_117_0 then
				local var_117_56 = var_117_54:GetComponent("SpriteRenderer")

				if var_117_56 then
					arg_114_1.var_.alphaOldValueC01b = var_117_56.color.a
					arg_114_1.var_.alphaMatValueC01b = var_117_56
				end

				arg_114_1.var_.alphaOldValueC01b = 1
			end

			local var_117_57 = 1.5

			if var_117_55 <= arg_114_1.time_ and arg_114_1.time_ < var_117_55 + var_117_57 then
				local var_117_58 = (arg_114_1.time_ - var_117_55) / var_117_57
				local var_117_59 = Mathf.Lerp(arg_114_1.var_.alphaOldValueC01b, 0, var_117_58)

				if arg_114_1.var_.alphaMatValueC01b then
					local var_117_60 = arg_114_1.var_.alphaMatValueC01b.color

					var_117_60.a = var_117_59
					arg_114_1.var_.alphaMatValueC01b.color = var_117_60
				end
			end

			if arg_114_1.time_ >= var_117_55 + var_117_57 and arg_114_1.time_ < var_117_55 + var_117_57 + arg_117_0 and arg_114_1.var_.alphaMatValueC01b then
				local var_117_61 = arg_114_1.var_.alphaMatValueC01b
				local var_117_62 = var_117_61.color

				var_117_62.a = 0
				var_117_61.color = var_117_62
			end

			local var_117_63 = 0

			if var_117_63 < arg_114_1.time_ and arg_114_1.time_ <= var_117_63 + arg_117_0 then
				arg_114_1.allBtn_.enabled = false
			end

			local var_117_64 = 3

			if arg_114_1.time_ >= var_117_63 + var_117_64 and arg_114_1.time_ < var_117_63 + var_117_64 + arg_117_0 then
				arg_114_1.allBtn_.enabled = true
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_65 = 3
			local var_117_66 = 0.125

			if var_117_65 < arg_114_1.time_ and arg_114_1.time_ <= var_117_65 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_67 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_67:setOnUpdate(LuaHelper.FloatAction(function(arg_118_0)
					arg_114_1.dialogCg_.alpha = arg_118_0
				end))
				var_117_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_68 = arg_114_1:GetWordFromCfg(106132028)
				local var_117_69 = arg_114_1:FormatText(var_117_68.content)

				arg_114_1.text_.text = var_117_69

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_70 = 5
				local var_117_71 = utf8.len(var_117_69)
				local var_117_72 = var_117_70 <= 0 and var_117_66 or var_117_66 * (var_117_71 / var_117_70)

				if var_117_72 > 0 and var_117_66 < var_117_72 then
					arg_114_1.talkMaxDuration = var_117_72
					var_117_65 = var_117_65 + 0.3

					if var_117_72 + var_117_65 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_72 + var_117_65
					end
				end

				arg_114_1.text_.text = var_117_69
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_73 = var_117_65 + 0.3
			local var_117_74 = math.max(var_117_66, arg_114_1.talkMaxDuration)

			if var_117_73 <= arg_114_1.time_ and arg_114_1.time_ < var_117_73 + var_117_74 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_73) / var_117_74

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_73 + var_117_74 and arg_114_1.time_ < var_117_73 + var_117_74 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "C01b",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1099ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play106132029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 106132029
		arg_120_1.duration_ = 4.97

		local var_120_0 = {
			ja = 1.999999999999,
			ko = 2.366,
			zh = 3.9,
			en = 4.966
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
				arg_120_0:Play106132030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = "4014_tpose"

			if arg_120_1.actors_[var_123_0] == nil then
				local var_123_1 = Asset.Load("Char/" .. "4014_tpose")

				if not isNil(var_123_1) then
					local var_123_2 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_120_1.stage_.transform)

					var_123_2.name = var_123_0
					var_123_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_120_1.actors_[var_123_0] = var_123_2

					local var_123_3 = var_123_2:GetComponentInChildren(typeof(CharacterEffect))

					var_123_3.enabled = true

					local var_123_4 = GameObjectTools.GetOrAddComponent(var_123_2, typeof(DynamicBoneHelper))

					if var_123_4 then
						var_123_4:EnableDynamicBone(false)
					end

					arg_120_1:ShowWeapon(var_123_3.transform, false)

					arg_120_1.var_[var_123_0 .. "Animator"] = var_123_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_120_1.var_[var_123_0 .. "Animator"].applyRootMotion = true
					arg_120_1.var_[var_123_0 .. "LipSync"] = var_123_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_123_5 = arg_120_1.actors_["4014_tpose"]
			local var_123_6 = 0

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 and not isNil(var_123_5) and arg_120_1.var_.characterEffect4014_tpose == nil then
				arg_120_1.var_.characterEffect4014_tpose = var_123_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_7 = 0.1

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_7 and not isNil(var_123_5) then
				local var_123_8 = (arg_120_1.time_ - var_123_6) / var_123_7

				if arg_120_1.var_.characterEffect4014_tpose and not isNil(var_123_5) then
					arg_120_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_6 + var_123_7 and arg_120_1.time_ < var_123_6 + var_123_7 + arg_123_0 and not isNil(var_123_5) and arg_120_1.var_.characterEffect4014_tpose then
				arg_120_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_123_9 = arg_120_1.actors_["4014_tpose"].transform
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1.var_.moveOldPos4014_tpose = var_123_9.localPosition

				local var_123_11 = GameObjectTools.GetOrAddComponent(var_123_9.gameObject, typeof(DynamicBoneHelper))

				if var_123_11 then
					var_123_11:EnableDynamicBone(false)
				end
			end

			local var_123_12 = 0.001

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_12 then
				local var_123_13 = (arg_120_1.time_ - var_123_10) / var_123_12
				local var_123_14 = Vector3.New(0, -1.95, -4.2)

				var_123_9.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos4014_tpose, var_123_14, var_123_13)

				local var_123_15 = manager.ui.mainCamera.transform.position - var_123_9.position

				var_123_9.forward = Vector3.New(var_123_15.x, var_123_15.y, var_123_15.z)

				local var_123_16 = var_123_9.localEulerAngles

				var_123_16.z = 0
				var_123_16.x = 0
				var_123_9.localEulerAngles = var_123_16
			end

			if arg_120_1.time_ >= var_123_10 + var_123_12 and arg_120_1.time_ < var_123_10 + var_123_12 + arg_123_0 then
				var_123_9.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_123_17 = manager.ui.mainCamera.transform.position - var_123_9.position

				var_123_9.forward = Vector3.New(var_123_17.x, var_123_17.y, var_123_17.z)

				local var_123_18 = var_123_9.localEulerAngles

				var_123_18.z = 0
				var_123_18.x = 0
				var_123_9.localEulerAngles = var_123_18

				local var_123_19 = GameObjectTools.GetOrAddComponent(var_123_9.gameObject, typeof(DynamicBoneHelper))

				if var_123_19 then
					var_123_19:EnableDynamicBone(true)
				end
			end

			local var_123_20 = 0

			if var_123_20 < arg_120_1.time_ and arg_120_1.time_ <= var_123_20 + arg_123_0 then
				arg_120_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_123_21 = 0

			if var_123_21 < arg_120_1.time_ and arg_120_1.time_ <= var_123_21 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = true

				arg_120_1:SetGaussion(false)
			end

			local var_123_22 = 0.5

			if var_123_21 <= arg_120_1.time_ and arg_120_1.time_ < var_123_21 + var_123_22 then
				local var_123_23 = (arg_120_1.time_ - var_123_21) / var_123_22
				local var_123_24 = Color.New(1, 1, 1)

				var_123_24.a = Mathf.Lerp(1, 0, var_123_23)
				arg_120_1.mask_.color = var_123_24
			end

			if arg_120_1.time_ >= var_123_21 + var_123_22 and arg_120_1.time_ < var_123_21 + var_123_22 + arg_123_0 then
				local var_123_25 = Color.New(1, 1, 1)
				local var_123_26 = 0

				arg_120_1.mask_.enabled = false
				var_123_25.a = var_123_26
				arg_120_1.mask_.color = var_123_25
			end

			local var_123_27 = 0.5
			local var_123_28 = 0.225

			if var_123_27 < arg_120_1.time_ and arg_120_1.time_ <= var_123_27 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_29 = arg_120_1:FormatText(StoryNameCfg[87].name)

				arg_120_1.leftNameTxt_.text = var_123_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_30 = arg_120_1:GetWordFromCfg(106132029)
				local var_123_31 = arg_120_1:FormatText(var_123_30.content)

				arg_120_1.text_.text = var_123_31

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_32 = 9
				local var_123_33 = utf8.len(var_123_31)
				local var_123_34 = var_123_32 <= 0 and var_123_28 or var_123_28 * (var_123_33 / var_123_32)

				if var_123_34 > 0 and var_123_28 < var_123_34 then
					arg_120_1.talkMaxDuration = var_123_34

					if var_123_34 + var_123_27 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_34 + var_123_27
					end
				end

				arg_120_1.text_.text = var_123_31
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132029", "story_v_out_106132.awb") ~= 0 then
					local var_123_35 = manager.audio:GetVoiceLength("story_v_out_106132", "106132029", "story_v_out_106132.awb") / 1000

					if var_123_35 + var_123_27 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_35 + var_123_27
					end

					if var_123_30.prefab_name ~= "" and arg_120_1.actors_[var_123_30.prefab_name] ~= nil then
						local var_123_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_30.prefab_name].transform, "story_v_out_106132", "106132029", "story_v_out_106132.awb")

						arg_120_1:RecordAudio("106132029", var_123_36)
						arg_120_1:RecordAudio("106132029", var_123_36)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_106132", "106132029", "story_v_out_106132.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_106132", "106132029", "story_v_out_106132.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_37 = math.max(var_123_28, arg_120_1.talkMaxDuration)

			if var_123_27 <= arg_120_1.time_ and arg_120_1.time_ < var_123_27 + var_123_37 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_27) / var_123_37

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_27 + var_123_37 and arg_120_1.time_ < var_123_27 + var_123_37 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play106132030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 106132030
		arg_124_1.duration_ = 2.57

		local var_124_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.566,
			en = 1.999999999999
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
				arg_124_0:Play106132031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["4014_tpose"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect4014_tpose == nil then
				arg_124_1.var_.characterEffect4014_tpose = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.1

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect4014_tpose and not isNil(var_127_0) then
					local var_127_4 = Mathf.Lerp(0, 0.5, var_127_3)

					arg_124_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_124_1.var_.characterEffect4014_tpose.fillRatio = var_127_4
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect4014_tpose then
				local var_127_5 = 0.5

				arg_124_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_124_1.var_.characterEffect4014_tpose.fillRatio = var_127_5
			end

			local var_127_6 = "10004ui_story"

			if arg_124_1.actors_[var_127_6] == nil then
				local var_127_7 = Asset.Load("Char/" .. "10004ui_story")

				if not isNil(var_127_7) then
					local var_127_8 = Object.Instantiate(Asset.Load("Char/" .. "10004ui_story"), arg_124_1.stage_.transform)

					var_127_8.name = var_127_6
					var_127_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_124_1.actors_[var_127_6] = var_127_8

					local var_127_9 = var_127_8:GetComponentInChildren(typeof(CharacterEffect))

					var_127_9.enabled = true

					local var_127_10 = GameObjectTools.GetOrAddComponent(var_127_8, typeof(DynamicBoneHelper))

					if var_127_10 then
						var_127_10:EnableDynamicBone(false)
					end

					arg_124_1:ShowWeapon(var_127_9.transform, false)

					arg_124_1.var_[var_127_6 .. "Animator"] = var_127_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_124_1.var_[var_127_6 .. "Animator"].applyRootMotion = true
					arg_124_1.var_[var_127_6 .. "LipSync"] = var_127_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_127_11 = arg_124_1.actors_["10004ui_story"]
			local var_127_12 = 0

			if var_127_12 < arg_124_1.time_ and arg_124_1.time_ <= var_127_12 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect10004ui_story == nil then
				arg_124_1.var_.characterEffect10004ui_story = var_127_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_13 = 0.1

			if var_127_12 <= arg_124_1.time_ and arg_124_1.time_ < var_127_12 + var_127_13 and not isNil(var_127_11) then
				local var_127_14 = (arg_124_1.time_ - var_127_12) / var_127_13

				if arg_124_1.var_.characterEffect10004ui_story and not isNil(var_127_11) then
					arg_124_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_12 + var_127_13 and arg_124_1.time_ < var_127_12 + var_127_13 + arg_127_0 and not isNil(var_127_11) and arg_124_1.var_.characterEffect10004ui_story then
				arg_124_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_127_15 = arg_124_1.actors_["4014_tpose"].transform
			local var_127_16 = 0

			if var_127_16 < arg_124_1.time_ and arg_124_1.time_ <= var_127_16 + arg_127_0 then
				arg_124_1.var_.moveOldPos4014_tpose = var_127_15.localPosition

				local var_127_17 = GameObjectTools.GetOrAddComponent(var_127_15.gameObject, typeof(DynamicBoneHelper))

				if var_127_17 then
					var_127_17:EnableDynamicBone(false)
				end
			end

			local var_127_18 = 0.001

			if var_127_16 <= arg_124_1.time_ and arg_124_1.time_ < var_127_16 + var_127_18 then
				local var_127_19 = (arg_124_1.time_ - var_127_16) / var_127_18
				local var_127_20 = Vector3.New(0, 100, 0)

				var_127_15.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos4014_tpose, var_127_20, var_127_19)

				local var_127_21 = manager.ui.mainCamera.transform.position - var_127_15.position

				var_127_15.forward = Vector3.New(var_127_21.x, var_127_21.y, var_127_21.z)

				local var_127_22 = var_127_15.localEulerAngles

				var_127_22.z = 0
				var_127_22.x = 0
				var_127_15.localEulerAngles = var_127_22
			end

			if arg_124_1.time_ >= var_127_16 + var_127_18 and arg_124_1.time_ < var_127_16 + var_127_18 + arg_127_0 then
				var_127_15.localPosition = Vector3.New(0, 100, 0)

				local var_127_23 = manager.ui.mainCamera.transform.position - var_127_15.position

				var_127_15.forward = Vector3.New(var_127_23.x, var_127_23.y, var_127_23.z)

				local var_127_24 = var_127_15.localEulerAngles

				var_127_24.z = 0
				var_127_24.x = 0
				var_127_15.localEulerAngles = var_127_24

				local var_127_25 = GameObjectTools.GetOrAddComponent(var_127_15.gameObject, typeof(DynamicBoneHelper))

				if var_127_25 then
					var_127_25:EnableDynamicBone(true)
				end
			end

			local var_127_26 = arg_124_1.actors_["10004ui_story"].transform
			local var_127_27 = 0

			if var_127_27 < arg_124_1.time_ and arg_124_1.time_ <= var_127_27 + arg_127_0 then
				arg_124_1.var_.moveOldPos10004ui_story = var_127_26.localPosition
			end

			local var_127_28 = 0.001

			if var_127_27 <= arg_124_1.time_ and arg_124_1.time_ < var_127_27 + var_127_28 then
				local var_127_29 = (arg_124_1.time_ - var_127_27) / var_127_28
				local var_127_30 = Vector3.New(0, -1.1, -5.6)

				var_127_26.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos10004ui_story, var_127_30, var_127_29)

				local var_127_31 = manager.ui.mainCamera.transform.position - var_127_26.position

				var_127_26.forward = Vector3.New(var_127_31.x, var_127_31.y, var_127_31.z)

				local var_127_32 = var_127_26.localEulerAngles

				var_127_32.z = 0
				var_127_32.x = 0
				var_127_26.localEulerAngles = var_127_32
			end

			if arg_124_1.time_ >= var_127_27 + var_127_28 and arg_124_1.time_ < var_127_27 + var_127_28 + arg_127_0 then
				var_127_26.localPosition = Vector3.New(0, -1.1, -5.6)

				local var_127_33 = manager.ui.mainCamera.transform.position - var_127_26.position

				var_127_26.forward = Vector3.New(var_127_33.x, var_127_33.y, var_127_33.z)

				local var_127_34 = var_127_26.localEulerAngles

				var_127_34.z = 0
				var_127_34.x = 0
				var_127_26.localEulerAngles = var_127_34
			end

			local var_127_35 = 0

			if var_127_35 < arg_124_1.time_ and arg_124_1.time_ <= var_127_35 + arg_127_0 then
				arg_124_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action1_1")
			end

			local var_127_36 = 0

			if var_127_36 < arg_124_1.time_ and arg_124_1.time_ <= var_127_36 + arg_127_0 then
				arg_124_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_127_37 = 0
			local var_127_38 = 0.2

			if var_127_37 < arg_124_1.time_ and arg_124_1.time_ <= var_127_37 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_39 = arg_124_1:FormatText(StoryNameCfg[80].name)

				arg_124_1.leftNameTxt_.text = var_127_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_40 = arg_124_1:GetWordFromCfg(106132030)
				local var_127_41 = arg_124_1:FormatText(var_127_40.content)

				arg_124_1.text_.text = var_127_41

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_42 = 8
				local var_127_43 = utf8.len(var_127_41)
				local var_127_44 = var_127_42 <= 0 and var_127_38 or var_127_38 * (var_127_43 / var_127_42)

				if var_127_44 > 0 and var_127_38 < var_127_44 then
					arg_124_1.talkMaxDuration = var_127_44

					if var_127_44 + var_127_37 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_44 + var_127_37
					end
				end

				arg_124_1.text_.text = var_127_41
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132030", "story_v_out_106132.awb") ~= 0 then
					local var_127_45 = manager.audio:GetVoiceLength("story_v_out_106132", "106132030", "story_v_out_106132.awb") / 1000

					if var_127_45 + var_127_37 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_45 + var_127_37
					end

					if var_127_40.prefab_name ~= "" and arg_124_1.actors_[var_127_40.prefab_name] ~= nil then
						local var_127_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_40.prefab_name].transform, "story_v_out_106132", "106132030", "story_v_out_106132.awb")

						arg_124_1:RecordAudio("106132030", var_127_46)
						arg_124_1:RecordAudio("106132030", var_127_46)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_106132", "106132030", "story_v_out_106132.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_106132", "106132030", "story_v_out_106132.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_47 = math.max(var_127_38, arg_124_1.talkMaxDuration)

			if var_127_37 <= arg_124_1.time_ and arg_124_1.time_ < var_127_37 + var_127_47 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_37) / var_127_47

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_37 + var_127_47 and arg_124_1.time_ < var_127_37 + var_127_47 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play106132031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 106132031
		arg_128_1.duration_ = 3.73

		local var_128_0 = {
			ja = 3.333,
			ko = 2.8,
			zh = 3.733,
			en = 3.3
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
				arg_128_0:Play106132032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["4014_tpose"]
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect4014_tpose == nil then
				arg_128_1.var_.characterEffect4014_tpose = var_131_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.1

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 and not isNil(var_131_0) then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2

				if arg_128_1.var_.characterEffect4014_tpose and not isNil(var_131_0) then
					arg_128_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 and not isNil(var_131_0) and arg_128_1.var_.characterEffect4014_tpose then
				arg_128_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_131_4 = arg_128_1.actors_["10004ui_story"]
			local var_131_5 = 0

			if var_131_5 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect10004ui_story == nil then
				arg_128_1.var_.characterEffect10004ui_story = var_131_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_6 = 0.1

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_6 and not isNil(var_131_4) then
				local var_131_7 = (arg_128_1.time_ - var_131_5) / var_131_6

				if arg_128_1.var_.characterEffect10004ui_story and not isNil(var_131_4) then
					local var_131_8 = Mathf.Lerp(0, 0.5, var_131_7)

					arg_128_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_128_1.var_.characterEffect10004ui_story.fillRatio = var_131_8
				end
			end

			if arg_128_1.time_ >= var_131_5 + var_131_6 and arg_128_1.time_ < var_131_5 + var_131_6 + arg_131_0 and not isNil(var_131_4) and arg_128_1.var_.characterEffect10004ui_story then
				local var_131_9 = 0.5

				arg_128_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_128_1.var_.characterEffect10004ui_story.fillRatio = var_131_9
			end

			local var_131_10 = arg_128_1.actors_["4014_tpose"].transform
			local var_131_11 = 0

			if var_131_11 < arg_128_1.time_ and arg_128_1.time_ <= var_131_11 + arg_131_0 then
				arg_128_1.var_.moveOldPos4014_tpose = var_131_10.localPosition

				local var_131_12 = GameObjectTools.GetOrAddComponent(var_131_10.gameObject, typeof(DynamicBoneHelper))

				if var_131_12 then
					var_131_12:EnableDynamicBone(false)
				end
			end

			local var_131_13 = 0.001

			if var_131_11 <= arg_128_1.time_ and arg_128_1.time_ < var_131_11 + var_131_13 then
				local var_131_14 = (arg_128_1.time_ - var_131_11) / var_131_13
				local var_131_15 = Vector3.New(0, -1.95, -4.2)

				var_131_10.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos4014_tpose, var_131_15, var_131_14)

				local var_131_16 = manager.ui.mainCamera.transform.position - var_131_10.position

				var_131_10.forward = Vector3.New(var_131_16.x, var_131_16.y, var_131_16.z)

				local var_131_17 = var_131_10.localEulerAngles

				var_131_17.z = 0
				var_131_17.x = 0
				var_131_10.localEulerAngles = var_131_17
			end

			if arg_128_1.time_ >= var_131_11 + var_131_13 and arg_128_1.time_ < var_131_11 + var_131_13 + arg_131_0 then
				var_131_10.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_131_18 = manager.ui.mainCamera.transform.position - var_131_10.position

				var_131_10.forward = Vector3.New(var_131_18.x, var_131_18.y, var_131_18.z)

				local var_131_19 = var_131_10.localEulerAngles

				var_131_19.z = 0
				var_131_19.x = 0
				var_131_10.localEulerAngles = var_131_19

				local var_131_20 = GameObjectTools.GetOrAddComponent(var_131_10.gameObject, typeof(DynamicBoneHelper))

				if var_131_20 then
					var_131_20:EnableDynamicBone(true)
				end
			end

			local var_131_21 = arg_128_1.actors_["10004ui_story"].transform
			local var_131_22 = 0

			if var_131_22 < arg_128_1.time_ and arg_128_1.time_ <= var_131_22 + arg_131_0 then
				arg_128_1.var_.moveOldPos10004ui_story = var_131_21.localPosition
			end

			local var_131_23 = 0.001

			if var_131_22 <= arg_128_1.time_ and arg_128_1.time_ < var_131_22 + var_131_23 then
				local var_131_24 = (arg_128_1.time_ - var_131_22) / var_131_23
				local var_131_25 = Vector3.New(0, 100, 0)

				var_131_21.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10004ui_story, var_131_25, var_131_24)

				local var_131_26 = manager.ui.mainCamera.transform.position - var_131_21.position

				var_131_21.forward = Vector3.New(var_131_26.x, var_131_26.y, var_131_26.z)

				local var_131_27 = var_131_21.localEulerAngles

				var_131_27.z = 0
				var_131_27.x = 0
				var_131_21.localEulerAngles = var_131_27
			end

			if arg_128_1.time_ >= var_131_22 + var_131_23 and arg_128_1.time_ < var_131_22 + var_131_23 + arg_131_0 then
				var_131_21.localPosition = Vector3.New(0, 100, 0)

				local var_131_28 = manager.ui.mainCamera.transform.position - var_131_21.position

				var_131_21.forward = Vector3.New(var_131_28.x, var_131_28.y, var_131_28.z)

				local var_131_29 = var_131_21.localEulerAngles

				var_131_29.z = 0
				var_131_29.x = 0
				var_131_21.localEulerAngles = var_131_29
			end

			local var_131_30 = 0
			local var_131_31 = 0.3

			if var_131_30 < arg_128_1.time_ and arg_128_1.time_ <= var_131_30 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_32 = arg_128_1:FormatText(StoryNameCfg[87].name)

				arg_128_1.leftNameTxt_.text = var_131_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_33 = arg_128_1:GetWordFromCfg(106132031)
				local var_131_34 = arg_128_1:FormatText(var_131_33.content)

				arg_128_1.text_.text = var_131_34

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_35 = 12
				local var_131_36 = utf8.len(var_131_34)
				local var_131_37 = var_131_35 <= 0 and var_131_31 or var_131_31 * (var_131_36 / var_131_35)

				if var_131_37 > 0 and var_131_31 < var_131_37 then
					arg_128_1.talkMaxDuration = var_131_37

					if var_131_37 + var_131_30 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_37 + var_131_30
					end
				end

				arg_128_1.text_.text = var_131_34
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132031", "story_v_out_106132.awb") ~= 0 then
					local var_131_38 = manager.audio:GetVoiceLength("story_v_out_106132", "106132031", "story_v_out_106132.awb") / 1000

					if var_131_38 + var_131_30 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_38 + var_131_30
					end

					if var_131_33.prefab_name ~= "" and arg_128_1.actors_[var_131_33.prefab_name] ~= nil then
						local var_131_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_33.prefab_name].transform, "story_v_out_106132", "106132031", "story_v_out_106132.awb")

						arg_128_1:RecordAudio("106132031", var_131_39)
						arg_128_1:RecordAudio("106132031", var_131_39)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_106132", "106132031", "story_v_out_106132.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_106132", "106132031", "story_v_out_106132.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_40 = math.max(var_131_31, arg_128_1.talkMaxDuration)

			if var_131_30 <= arg_128_1.time_ and arg_128_1.time_ < var_131_30 + var_131_40 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_30) / var_131_40

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_30 + var_131_40 and arg_128_1.time_ < var_131_30 + var_131_40 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play106132032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 106132032
		arg_132_1.duration_ = 3.47

		local var_132_0 = {
			ja = 3.466,
			ko = 2.866,
			zh = 3.2,
			en = 2.033
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
				arg_132_0:Play106132033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["4014_tpose"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect4014_tpose == nil then
				arg_132_1.var_.characterEffect4014_tpose = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.1

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect4014_tpose and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_132_1.var_.characterEffect4014_tpose.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect4014_tpose then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_132_1.var_.characterEffect4014_tpose.fillRatio = var_135_5
			end

			local var_135_6 = arg_132_1.actors_["10004ui_story"]
			local var_135_7 = 0

			if var_135_7 < arg_132_1.time_ and arg_132_1.time_ <= var_135_7 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect10004ui_story == nil then
				arg_132_1.var_.characterEffect10004ui_story = var_135_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_8 = 0.1

			if var_135_7 <= arg_132_1.time_ and arg_132_1.time_ < var_135_7 + var_135_8 and not isNil(var_135_6) then
				local var_135_9 = (arg_132_1.time_ - var_135_7) / var_135_8

				if arg_132_1.var_.characterEffect10004ui_story and not isNil(var_135_6) then
					arg_132_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_7 + var_135_8 and arg_132_1.time_ < var_135_7 + var_135_8 + arg_135_0 and not isNil(var_135_6) and arg_132_1.var_.characterEffect10004ui_story then
				arg_132_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_135_10 = arg_132_1.actors_["4014_tpose"].transform
			local var_135_11 = 0

			if var_135_11 < arg_132_1.time_ and arg_132_1.time_ <= var_135_11 + arg_135_0 then
				arg_132_1.var_.moveOldPos4014_tpose = var_135_10.localPosition

				local var_135_12 = GameObjectTools.GetOrAddComponent(var_135_10.gameObject, typeof(DynamicBoneHelper))

				if var_135_12 then
					var_135_12:EnableDynamicBone(false)
				end
			end

			local var_135_13 = 0.001

			if var_135_11 <= arg_132_1.time_ and arg_132_1.time_ < var_135_11 + var_135_13 then
				local var_135_14 = (arg_132_1.time_ - var_135_11) / var_135_13
				local var_135_15 = Vector3.New(0, 100, 0)

				var_135_10.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos4014_tpose, var_135_15, var_135_14)

				local var_135_16 = manager.ui.mainCamera.transform.position - var_135_10.position

				var_135_10.forward = Vector3.New(var_135_16.x, var_135_16.y, var_135_16.z)

				local var_135_17 = var_135_10.localEulerAngles

				var_135_17.z = 0
				var_135_17.x = 0
				var_135_10.localEulerAngles = var_135_17
			end

			if arg_132_1.time_ >= var_135_11 + var_135_13 and arg_132_1.time_ < var_135_11 + var_135_13 + arg_135_0 then
				var_135_10.localPosition = Vector3.New(0, 100, 0)

				local var_135_18 = manager.ui.mainCamera.transform.position - var_135_10.position

				var_135_10.forward = Vector3.New(var_135_18.x, var_135_18.y, var_135_18.z)

				local var_135_19 = var_135_10.localEulerAngles

				var_135_19.z = 0
				var_135_19.x = 0
				var_135_10.localEulerAngles = var_135_19

				local var_135_20 = GameObjectTools.GetOrAddComponent(var_135_10.gameObject, typeof(DynamicBoneHelper))

				if var_135_20 then
					var_135_20:EnableDynamicBone(true)
				end
			end

			local var_135_21 = arg_132_1.actors_["10004ui_story"].transform
			local var_135_22 = 0

			if var_135_22 < arg_132_1.time_ and arg_132_1.time_ <= var_135_22 + arg_135_0 then
				arg_132_1.var_.moveOldPos10004ui_story = var_135_21.localPosition
			end

			local var_135_23 = 0.001

			if var_135_22 <= arg_132_1.time_ and arg_132_1.time_ < var_135_22 + var_135_23 then
				local var_135_24 = (arg_132_1.time_ - var_135_22) / var_135_23
				local var_135_25 = Vector3.New(0, -1.1, -5.6)

				var_135_21.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10004ui_story, var_135_25, var_135_24)

				local var_135_26 = manager.ui.mainCamera.transform.position - var_135_21.position

				var_135_21.forward = Vector3.New(var_135_26.x, var_135_26.y, var_135_26.z)

				local var_135_27 = var_135_21.localEulerAngles

				var_135_27.z = 0
				var_135_27.x = 0
				var_135_21.localEulerAngles = var_135_27
			end

			if arg_132_1.time_ >= var_135_22 + var_135_23 and arg_132_1.time_ < var_135_22 + var_135_23 + arg_135_0 then
				var_135_21.localPosition = Vector3.New(0, -1.1, -5.6)

				local var_135_28 = manager.ui.mainCamera.transform.position - var_135_21.position

				var_135_21.forward = Vector3.New(var_135_28.x, var_135_28.y, var_135_28.z)

				local var_135_29 = var_135_21.localEulerAngles

				var_135_29.z = 0
				var_135_29.x = 0
				var_135_21.localEulerAngles = var_135_29
			end

			local var_135_30 = 0

			if var_135_30 < arg_132_1.time_ and arg_132_1.time_ <= var_135_30 + arg_135_0 then
				arg_132_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action3_1")
			end

			local var_135_31 = 0

			if var_135_31 < arg_132_1.time_ and arg_132_1.time_ <= var_135_31 + arg_135_0 then
				arg_132_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_135_32 = 0
			local var_135_33 = 0.375

			if var_135_32 < arg_132_1.time_ and arg_132_1.time_ <= var_135_32 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_34 = arg_132_1:FormatText(StoryNameCfg[80].name)

				arg_132_1.leftNameTxt_.text = var_135_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_35 = arg_132_1:GetWordFromCfg(106132032)
				local var_135_36 = arg_132_1:FormatText(var_135_35.content)

				arg_132_1.text_.text = var_135_36

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_37 = 15
				local var_135_38 = utf8.len(var_135_36)
				local var_135_39 = var_135_37 <= 0 and var_135_33 or var_135_33 * (var_135_38 / var_135_37)

				if var_135_39 > 0 and var_135_33 < var_135_39 then
					arg_132_1.talkMaxDuration = var_135_39

					if var_135_39 + var_135_32 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_39 + var_135_32
					end
				end

				arg_132_1.text_.text = var_135_36
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132032", "story_v_out_106132.awb") ~= 0 then
					local var_135_40 = manager.audio:GetVoiceLength("story_v_out_106132", "106132032", "story_v_out_106132.awb") / 1000

					if var_135_40 + var_135_32 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_40 + var_135_32
					end

					if var_135_35.prefab_name ~= "" and arg_132_1.actors_[var_135_35.prefab_name] ~= nil then
						local var_135_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_35.prefab_name].transform, "story_v_out_106132", "106132032", "story_v_out_106132.awb")

						arg_132_1:RecordAudio("106132032", var_135_41)
						arg_132_1:RecordAudio("106132032", var_135_41)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_106132", "106132032", "story_v_out_106132.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_106132", "106132032", "story_v_out_106132.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_42 = math.max(var_135_33, arg_132_1.talkMaxDuration)

			if var_135_32 <= arg_132_1.time_ and arg_132_1.time_ < var_135_32 + var_135_42 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_32) / var_135_42

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_32 + var_135_42 and arg_132_1.time_ < var_135_32 + var_135_42 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play106132033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 106132033
		arg_136_1.duration_ = 5.47

		local var_136_0 = {
			ja = 5.466,
			ko = 4.1,
			zh = 4.2,
			en = 4.866
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
				arg_136_0:Play106132034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["4014_tpose"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect4014_tpose == nil then
				arg_136_1.var_.characterEffect4014_tpose = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.1

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect4014_tpose and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect4014_tpose then
				arg_136_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_139_4 = arg_136_1.actors_["10004ui_story"]
			local var_139_5 = 0

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect10004ui_story == nil then
				arg_136_1.var_.characterEffect10004ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.1

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 and not isNil(var_139_4) then
				local var_139_7 = (arg_136_1.time_ - var_139_5) / var_139_6

				if arg_136_1.var_.characterEffect10004ui_story and not isNil(var_139_4) then
					local var_139_8 = Mathf.Lerp(0, 0.5, var_139_7)

					arg_136_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_136_1.var_.characterEffect10004ui_story.fillRatio = var_139_8
				end
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect10004ui_story then
				local var_139_9 = 0.5

				arg_136_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_136_1.var_.characterEffect10004ui_story.fillRatio = var_139_9
			end

			local var_139_10 = arg_136_1.actors_["4014_tpose"].transform
			local var_139_11 = 0

			if var_139_11 < arg_136_1.time_ and arg_136_1.time_ <= var_139_11 + arg_139_0 then
				arg_136_1.var_.moveOldPos4014_tpose = var_139_10.localPosition

				local var_139_12 = GameObjectTools.GetOrAddComponent(var_139_10.gameObject, typeof(DynamicBoneHelper))

				if var_139_12 then
					var_139_12:EnableDynamicBone(false)
				end
			end

			local var_139_13 = 0.001

			if var_139_11 <= arg_136_1.time_ and arg_136_1.time_ < var_139_11 + var_139_13 then
				local var_139_14 = (arg_136_1.time_ - var_139_11) / var_139_13
				local var_139_15 = Vector3.New(0, -1.95, -4.2)

				var_139_10.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos4014_tpose, var_139_15, var_139_14)

				local var_139_16 = manager.ui.mainCamera.transform.position - var_139_10.position

				var_139_10.forward = Vector3.New(var_139_16.x, var_139_16.y, var_139_16.z)

				local var_139_17 = var_139_10.localEulerAngles

				var_139_17.z = 0
				var_139_17.x = 0
				var_139_10.localEulerAngles = var_139_17
			end

			if arg_136_1.time_ >= var_139_11 + var_139_13 and arg_136_1.time_ < var_139_11 + var_139_13 + arg_139_0 then
				var_139_10.localPosition = Vector3.New(0, -1.95, -4.2)

				local var_139_18 = manager.ui.mainCamera.transform.position - var_139_10.position

				var_139_10.forward = Vector3.New(var_139_18.x, var_139_18.y, var_139_18.z)

				local var_139_19 = var_139_10.localEulerAngles

				var_139_19.z = 0
				var_139_19.x = 0
				var_139_10.localEulerAngles = var_139_19

				local var_139_20 = GameObjectTools.GetOrAddComponent(var_139_10.gameObject, typeof(DynamicBoneHelper))

				if var_139_20 then
					var_139_20:EnableDynamicBone(true)
				end
			end

			local var_139_21 = arg_136_1.actors_["10004ui_story"].transform
			local var_139_22 = 0

			if var_139_22 < arg_136_1.time_ and arg_136_1.time_ <= var_139_22 + arg_139_0 then
				arg_136_1.var_.moveOldPos10004ui_story = var_139_21.localPosition
			end

			local var_139_23 = 0.001

			if var_139_22 <= arg_136_1.time_ and arg_136_1.time_ < var_139_22 + var_139_23 then
				local var_139_24 = (arg_136_1.time_ - var_139_22) / var_139_23
				local var_139_25 = Vector3.New(0, 100, 0)

				var_139_21.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos10004ui_story, var_139_25, var_139_24)

				local var_139_26 = manager.ui.mainCamera.transform.position - var_139_21.position

				var_139_21.forward = Vector3.New(var_139_26.x, var_139_26.y, var_139_26.z)

				local var_139_27 = var_139_21.localEulerAngles

				var_139_27.z = 0
				var_139_27.x = 0
				var_139_21.localEulerAngles = var_139_27
			end

			if arg_136_1.time_ >= var_139_22 + var_139_23 and arg_136_1.time_ < var_139_22 + var_139_23 + arg_139_0 then
				var_139_21.localPosition = Vector3.New(0, 100, 0)

				local var_139_28 = manager.ui.mainCamera.transform.position - var_139_21.position

				var_139_21.forward = Vector3.New(var_139_28.x, var_139_28.y, var_139_28.z)

				local var_139_29 = var_139_21.localEulerAngles

				var_139_29.z = 0
				var_139_29.x = 0
				var_139_21.localEulerAngles = var_139_29
			end

			local var_139_30 = 0
			local var_139_31 = 0.35

			if var_139_30 < arg_136_1.time_ and arg_136_1.time_ <= var_139_30 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_32 = arg_136_1:FormatText(StoryNameCfg[87].name)

				arg_136_1.leftNameTxt_.text = var_139_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_33 = arg_136_1:GetWordFromCfg(106132033)
				local var_139_34 = arg_136_1:FormatText(var_139_33.content)

				arg_136_1.text_.text = var_139_34

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_35 = 14
				local var_139_36 = utf8.len(var_139_34)
				local var_139_37 = var_139_35 <= 0 and var_139_31 or var_139_31 * (var_139_36 / var_139_35)

				if var_139_37 > 0 and var_139_31 < var_139_37 then
					arg_136_1.talkMaxDuration = var_139_37

					if var_139_37 + var_139_30 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_37 + var_139_30
					end
				end

				arg_136_1.text_.text = var_139_34
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132033", "story_v_out_106132.awb") ~= 0 then
					local var_139_38 = manager.audio:GetVoiceLength("story_v_out_106132", "106132033", "story_v_out_106132.awb") / 1000

					if var_139_38 + var_139_30 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_38 + var_139_30
					end

					if var_139_33.prefab_name ~= "" and arg_136_1.actors_[var_139_33.prefab_name] ~= nil then
						local var_139_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_33.prefab_name].transform, "story_v_out_106132", "106132033", "story_v_out_106132.awb")

						arg_136_1:RecordAudio("106132033", var_139_39)
						arg_136_1:RecordAudio("106132033", var_139_39)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_106132", "106132033", "story_v_out_106132.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_106132", "106132033", "story_v_out_106132.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_40 = math.max(var_139_31, arg_136_1.talkMaxDuration)

			if var_139_30 <= arg_136_1.time_ and arg_136_1.time_ < var_139_30 + var_139_40 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_30) / var_139_40

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_30 + var_139_40 and arg_136_1.time_ < var_139_30 + var_139_40 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play106132034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 106132034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play106132035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["4014_tpose"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect4014_tpose == nil then
				arg_140_1.var_.characterEffect4014_tpose = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.1

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect4014_tpose and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_140_1.var_.characterEffect4014_tpose.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect4014_tpose then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_140_1.var_.characterEffect4014_tpose.fillRatio = var_143_5
			end

			local var_143_6 = 0
			local var_143_7 = 0.75

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_8 = arg_140_1:GetWordFromCfg(106132034)
				local var_143_9 = arg_140_1:FormatText(var_143_8.content)

				arg_140_1.text_.text = var_143_9

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_10 = 30
				local var_143_11 = utf8.len(var_143_9)
				local var_143_12 = var_143_10 <= 0 and var_143_7 or var_143_7 * (var_143_11 / var_143_10)

				if var_143_12 > 0 and var_143_7 < var_143_12 then
					arg_140_1.talkMaxDuration = var_143_12

					if var_143_12 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_9
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_13 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_13 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_13

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_13 and arg_140_1.time_ < var_143_6 + var_143_13 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play106132035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 106132035
		arg_144_1.duration_ = 7.63

		local var_144_0 = {
			ja = 5.9,
			ko = 6.433,
			zh = 6.066,
			en = 7.633
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
			arg_144_1.auto_ = false
		end

		function arg_144_1.playNext_(arg_146_0)
			arg_144_1.onStoryFinished_()
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["4014_tpose"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect4014_tpose == nil then
				arg_144_1.var_.characterEffect4014_tpose = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.1

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect4014_tpose and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect4014_tpose then
				arg_144_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_147_4 = 0
			local var_147_5 = 0.525

			if var_147_4 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_6 = arg_144_1:FormatText(StoryNameCfg[87].name)

				arg_144_1.leftNameTxt_.text = var_147_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_7 = arg_144_1:GetWordFromCfg(106132035)
				local var_147_8 = arg_144_1:FormatText(var_147_7.content)

				arg_144_1.text_.text = var_147_8

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 21
				local var_147_10 = utf8.len(var_147_8)
				local var_147_11 = var_147_9 <= 0 and var_147_5 or var_147_5 * (var_147_10 / var_147_9)

				if var_147_11 > 0 and var_147_5 < var_147_11 then
					arg_144_1.talkMaxDuration = var_147_11

					if var_147_11 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_11 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_8
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106132", "106132035", "story_v_out_106132.awb") ~= 0 then
					local var_147_12 = manager.audio:GetVoiceLength("story_v_out_106132", "106132035", "story_v_out_106132.awb") / 1000

					if var_147_12 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_4
					end

					if var_147_7.prefab_name ~= "" and arg_144_1.actors_[var_147_7.prefab_name] ~= nil then
						local var_147_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_7.prefab_name].transform, "story_v_out_106132", "106132035", "story_v_out_106132.awb")

						arg_144_1:RecordAudio("106132035", var_147_13)
						arg_144_1:RecordAudio("106132035", var_147_13)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_106132", "106132035", "story_v_out_106132.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_106132", "106132035", "story_v_out_106132.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = math.max(var_147_5, arg_144_1.talkMaxDuration)

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_14 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_4) / var_147_14

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_4 + var_147_14 and arg_144_1.time_ < var_147_4 + var_147_14 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C01b",
		"TextureConfig/Background/C07_1"
	},
	voices = {
		"story_v_out_106132.awb"
	}
}
