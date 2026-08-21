return {
	Play104111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104111001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play104111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if var_4_5 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_10 = 0
			local var_4_11 = 1

			if var_4_10 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				local var_4_12 = "play"
				local var_4_13 = "effect"

				arg_1_1:AudioAction(var_4_12, var_4_13, "se_story_4", "se_story_4_collapse", "")
			end

			local var_4_14 = 0

			if var_4_14 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_15 = 2

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				local var_4_16 = (arg_1_1.time_ - var_4_14) / var_4_15
				local var_4_17 = Color.New(0, 0, 0)

				var_4_17.a = Mathf.Lerp(1, 0, var_4_16)
				arg_1_1.mask_.color = var_4_17
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				local var_4_18 = Color.New(0, 0, 0)
				local var_4_19 = 0

				arg_1_1.mask_.enabled = false
				var_4_18.a = var_4_19
				arg_1_1.mask_.color = var_4_18
			end

			local var_4_20 = "S0404"

			if arg_1_1.bgs_[var_4_20] == nil then
				local var_4_21 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_20)
				var_4_21.name = var_4_20
				var_4_21.transform.parent = arg_1_1.stage_.transform
				var_4_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_20] = var_4_21
			end

			local var_4_22 = 0

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_23 = manager.ui.mainCamera.transform.localPosition
				local var_4_24 = Vector3.New(0, 0, 10) + Vector3.New(var_4_23.x, var_4_23.y, 0)
				local var_4_25 = arg_1_1.bgs_.S0404

				var_4_25.transform.localPosition = var_4_24
				var_4_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_26 = var_4_25:GetComponent("SpriteRenderer")

				if var_4_26 and var_4_26.sprite then
					local var_4_27 = (var_4_25.transform.localPosition - var_4_23).z
					local var_4_28 = manager.ui.mainCameraCom_
					local var_4_29 = 2 * var_4_27 * Mathf.Tan(var_4_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_30 = var_4_29 * var_4_28.aspect
					local var_4_31 = var_4_26.sprite.bounds.size.x
					local var_4_32 = var_4_26.sprite.bounds.size.y
					local var_4_33 = var_4_30 / var_4_31
					local var_4_34 = var_4_29 / var_4_32
					local var_4_35 = var_4_34 < var_4_33 and var_4_33 or var_4_34

					var_4_25.transform.localScale = Vector3.New(var_4_35, var_4_35, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0404" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_36 = manager.ui.mainCamera.transform
			local var_4_37 = 1.6

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.shakeOldPosMainCamera = var_4_36.localPosition
			end

			local var_4_38 = 1

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / 0.066
				local var_4_40, var_4_41 = math.modf(var_4_39)

				var_4_36.localPosition = Vector3.New(var_4_41 * 0.13, var_4_41 * 0.13, var_4_41 * 0.13) + arg_1_1.var_.shakeOldPosMainCamera
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				var_4_36.localPosition = arg_1_1.var_.shakeOldPosMainCamera
			end

			local var_4_42 = 2

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_43 = 0.6

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_44 = 2
			local var_4_45 = 0.15

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_46 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_46:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_47 = arg_1_1:GetWordFromCfg(104111001)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.text_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_49 = 6
				local var_4_50 = utf8.len(var_4_48)
				local var_4_51 = var_4_49 <= 0 and var_4_45 or var_4_45 * (var_4_50 / var_4_49)

				if var_4_51 > 0 and var_4_45 < var_4_51 then
					arg_1_1.talkMaxDuration = var_4_51
					var_4_44 = var_4_44 + 0.3

					if var_4_51 + var_4_44 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_51 + var_4_44
					end
				end

				arg_1_1.text_.text = var_4_48
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_52 = var_4_44 + 0.3
			local var_4_53 = math.max(var_4_45, arg_1_1.talkMaxDuration)

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
	Play104111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104111002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play104111003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.425

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

				local var_11_2 = arg_8_1:GetWordFromCfg(104111002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 57
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
	Play104111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104111003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play104111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0
			local var_15_1 = 0.4

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

				local var_15_2 = arg_12_1:GetWordFromCfg(104111003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 16
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
	Play104111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104111004
		arg_16_1.duration_ = 9.8

		local var_16_0 = {
			ja = 8.833,
			ko = 8.333,
			zh = 9.133,
			en = 9.8
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
				arg_16_0:Play104111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1037ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["1037ui_story"]
			local var_19_6 = 3.8

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1037ui_story == nil then
				arg_16_1.var_.characterEffect1037ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect1037ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1037ui_story then
				arg_16_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_19_9 = 0

			if var_19_9 < arg_16_1.time_ and arg_16_1.time_ <= var_19_9 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_10 = 2

			if var_19_9 <= arg_16_1.time_ and arg_16_1.time_ < var_19_9 + var_19_10 then
				local var_19_11 = (arg_16_1.time_ - var_19_9) / var_19_10
				local var_19_12 = Color.New(0, 0, 0)

				var_19_12.a = Mathf.Lerp(0, 1, var_19_11)
				arg_16_1.mask_.color = var_19_12
			end

			if arg_16_1.time_ >= var_19_9 + var_19_10 and arg_16_1.time_ < var_19_9 + var_19_10 + arg_19_0 then
				local var_19_13 = Color.New(0, 0, 0)

				var_19_13.a = 1
				arg_16_1.mask_.color = var_19_13
			end

			local var_19_14 = 2

			if var_19_14 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1.mask_.enabled = true
				arg_16_1.mask_.raycastTarget = true

				arg_16_1:SetGaussion(false)
			end

			local var_19_15 = 2

			if var_19_14 <= arg_16_1.time_ and arg_16_1.time_ < var_19_14 + var_19_15 then
				local var_19_16 = (arg_16_1.time_ - var_19_14) / var_19_15
				local var_19_17 = Color.New(0, 0, 0)

				var_19_17.a = Mathf.Lerp(1, 0, var_19_16)
				arg_16_1.mask_.color = var_19_17
			end

			if arg_16_1.time_ >= var_19_14 + var_19_15 and arg_16_1.time_ < var_19_14 + var_19_15 + arg_19_0 then
				local var_19_18 = Color.New(0, 0, 0)
				local var_19_19 = 0

				arg_16_1.mask_.enabled = false
				var_19_18.a = var_19_19
				arg_16_1.mask_.color = var_19_18
			end

			local var_19_20 = "A00"

			if arg_16_1.bgs_[var_19_20] == nil then
				local var_19_21 = Object.Instantiate(arg_16_1.paintGo_)

				var_19_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_19_20)
				var_19_21.name = var_19_20
				var_19_21.transform.parent = arg_16_1.stage_.transform
				var_19_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.bgs_[var_19_20] = var_19_21
			end

			local var_19_22 = 2

			if var_19_22 < arg_16_1.time_ and arg_16_1.time_ <= var_19_22 + arg_19_0 then
				local var_19_23 = manager.ui.mainCamera.transform.localPosition
				local var_19_24 = Vector3.New(0, 0, 10) + Vector3.New(var_19_23.x, var_19_23.y, 0)
				local var_19_25 = arg_16_1.bgs_.A00

				var_19_25.transform.localPosition = var_19_24
				var_19_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_19_26 = var_19_25:GetComponent("SpriteRenderer")

				if var_19_26 and var_19_26.sprite then
					local var_19_27 = (var_19_25.transform.localPosition - var_19_23).z
					local var_19_28 = manager.ui.mainCameraCom_
					local var_19_29 = 2 * var_19_27 * Mathf.Tan(var_19_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_19_30 = var_19_29 * var_19_28.aspect
					local var_19_31 = var_19_26.sprite.bounds.size.x
					local var_19_32 = var_19_26.sprite.bounds.size.y
					local var_19_33 = var_19_30 / var_19_31
					local var_19_34 = var_19_29 / var_19_32
					local var_19_35 = var_19_34 < var_19_33 and var_19_33 or var_19_34

					var_19_25.transform.localScale = Vector3.New(var_19_35, var_19_35, 0)
				end

				for iter_19_0, iter_19_1 in pairs(arg_16_1.bgs_) do
					if iter_19_0 ~= "A00" then
						iter_19_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_19_36 = 3.8

			if var_19_36 < arg_16_1.time_ and arg_16_1.time_ <= var_19_36 + arg_19_0 then
				arg_16_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_19_37 = arg_16_1.actors_["1037ui_story"].transform
			local var_19_38 = 3.8

			if var_19_38 < arg_16_1.time_ and arg_16_1.time_ <= var_19_38 + arg_19_0 then
				arg_16_1.var_.moveOldPos1037ui_story = var_19_37.localPosition
			end

			local var_19_39 = 0.001

			if var_19_38 <= arg_16_1.time_ and arg_16_1.time_ < var_19_38 + var_19_39 then
				local var_19_40 = (arg_16_1.time_ - var_19_38) / var_19_39
				local var_19_41 = Vector3.New(0, -1.09, -5.81)

				var_19_37.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1037ui_story, var_19_41, var_19_40)

				local var_19_42 = manager.ui.mainCamera.transform.position - var_19_37.position

				var_19_37.forward = Vector3.New(var_19_42.x, var_19_42.y, var_19_42.z)

				local var_19_43 = var_19_37.localEulerAngles

				var_19_43.z = 0
				var_19_43.x = 0
				var_19_37.localEulerAngles = var_19_43
			end

			if arg_16_1.time_ >= var_19_38 + var_19_39 and arg_16_1.time_ < var_19_38 + var_19_39 + arg_19_0 then
				var_19_37.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_19_44 = manager.ui.mainCamera.transform.position - var_19_37.position

				var_19_37.forward = Vector3.New(var_19_44.x, var_19_44.y, var_19_44.z)

				local var_19_45 = var_19_37.localEulerAngles

				var_19_45.z = 0
				var_19_45.x = 0
				var_19_37.localEulerAngles = var_19_45
			end

			local var_19_46 = 3.8

			if var_19_46 < arg_16_1.time_ and arg_16_1.time_ <= var_19_46 + arg_19_0 then
				arg_16_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_47 = 4
			local var_19_48 = 0.4

			if var_19_47 < arg_16_1.time_ and arg_16_1.time_ <= var_19_47 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_49 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_49:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_16_1.dialogCg_.alpha = arg_20_0
				end))
				var_19_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_50 = arg_16_1:FormatText(StoryNameCfg[15].name)

				arg_16_1.leftNameTxt_.text = var_19_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_51 = arg_16_1:GetWordFromCfg(104111004)
				local var_19_52 = arg_16_1:FormatText(var_19_51.content)

				arg_16_1.text_.text = var_19_52

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_53 = 16
				local var_19_54 = utf8.len(var_19_52)
				local var_19_55 = var_19_53 <= 0 and var_19_48 or var_19_48 * (var_19_54 / var_19_53)

				if var_19_55 > 0 and var_19_48 < var_19_55 then
					arg_16_1.talkMaxDuration = var_19_55
					var_19_47 = var_19_47 + 0.3

					if var_19_55 + var_19_47 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_55 + var_19_47
					end
				end

				arg_16_1.text_.text = var_19_52
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111004", "story_v_out_104111.awb") ~= 0 then
					local var_19_56 = manager.audio:GetVoiceLength("story_v_out_104111", "104111004", "story_v_out_104111.awb") / 1000

					if var_19_56 + var_19_47 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_56 + var_19_47
					end

					if var_19_51.prefab_name ~= "" and arg_16_1.actors_[var_19_51.prefab_name] ~= nil then
						local var_19_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_51.prefab_name].transform, "story_v_out_104111", "104111004", "story_v_out_104111.awb")

						arg_16_1:RecordAudio("104111004", var_19_57)
						arg_16_1:RecordAudio("104111004", var_19_57)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104111", "104111004", "story_v_out_104111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104111", "104111004", "story_v_out_104111.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_58 = var_19_47 + 0.3
			local var_19_59 = math.max(var_19_48, arg_16_1.talkMaxDuration)

			if var_19_58 <= arg_16_1.time_ and arg_16_1.time_ < var_19_58 + var_19_59 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_58) / var_19_59

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_58 + var_19_59 and arg_16_1.time_ < var_19_58 + var_19_59 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play104111005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 104111005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play104111006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1037ui_story"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1037ui_story == nil then
				arg_22_1.var_.characterEffect1037ui_story = var_25_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.1

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.characterEffect1037ui_story and not isNil(var_25_0) then
					local var_25_4 = Mathf.Lerp(0, 0.5, var_25_3)

					arg_22_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_22_1.var_.characterEffect1037ui_story.fillRatio = var_25_4
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1037ui_story then
				local var_25_5 = 0.5

				arg_22_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_22_1.var_.characterEffect1037ui_story.fillRatio = var_25_5
			end

			local var_25_6 = arg_22_1.actors_["1037ui_story"].transform
			local var_25_7 = 0

			if var_25_7 < arg_22_1.time_ and arg_22_1.time_ <= var_25_7 + arg_25_0 then
				arg_22_1.var_.moveOldPos1037ui_story = var_25_6.localPosition
			end

			local var_25_8 = 0.001

			if var_25_7 <= arg_22_1.time_ and arg_22_1.time_ < var_25_7 + var_25_8 then
				local var_25_9 = (arg_22_1.time_ - var_25_7) / var_25_8
				local var_25_10 = Vector3.New(0, 100, 0)

				var_25_6.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1037ui_story, var_25_10, var_25_9)

				local var_25_11 = manager.ui.mainCamera.transform.position - var_25_6.position

				var_25_6.forward = Vector3.New(var_25_11.x, var_25_11.y, var_25_11.z)

				local var_25_12 = var_25_6.localEulerAngles

				var_25_12.z = 0
				var_25_12.x = 0
				var_25_6.localEulerAngles = var_25_12
			end

			if arg_22_1.time_ >= var_25_7 + var_25_8 and arg_22_1.time_ < var_25_7 + var_25_8 + arg_25_0 then
				var_25_6.localPosition = Vector3.New(0, 100, 0)

				local var_25_13 = manager.ui.mainCamera.transform.position - var_25_6.position

				var_25_6.forward = Vector3.New(var_25_13.x, var_25_13.y, var_25_13.z)

				local var_25_14 = var_25_6.localEulerAngles

				var_25_14.z = 0
				var_25_14.x = 0
				var_25_6.localEulerAngles = var_25_14
			end

			local var_25_15 = 0
			local var_25_16 = 0.375

			if var_25_15 < arg_22_1.time_ and arg_22_1.time_ <= var_25_15 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_17 = arg_22_1:FormatText(StoryNameCfg[7].name)

				arg_22_1.leftNameTxt_.text = var_25_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_18 = arg_22_1:GetWordFromCfg(104111005)
				local var_25_19 = arg_22_1:FormatText(var_25_18.content)

				arg_22_1.text_.text = var_25_19

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_20 = 15
				local var_25_21 = utf8.len(var_25_19)
				local var_25_22 = var_25_20 <= 0 and var_25_16 or var_25_16 * (var_25_21 / var_25_20)

				if var_25_22 > 0 and var_25_16 < var_25_22 then
					arg_22_1.talkMaxDuration = var_25_22

					if var_25_22 + var_25_15 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_22 + var_25_15
					end
				end

				arg_22_1.text_.text = var_25_19
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_23 = math.max(var_25_16, arg_22_1.talkMaxDuration)

			if var_25_15 <= arg_22_1.time_ and arg_22_1.time_ < var_25_15 + var_25_23 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_15) / var_25_23

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_15 + var_25_23 and arg_22_1.time_ < var_25_15 + var_25_23 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play104111006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 104111006
		arg_26_1.duration_ = 5.77

		local var_26_0 = {
			ja = 5.766,
			ko = 4.366,
			zh = 4.2,
			en = 5
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play104111007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 0.525

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_2 = arg_26_1:FormatText(StoryNameCfg[10].name)

				arg_26_1.leftNameTxt_.text = var_29_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_3 = arg_26_1:GetWordFromCfg(104111006)
				local var_29_4 = arg_26_1:FormatText(var_29_3.content)

				arg_26_1.text_.text = var_29_4

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 21
				local var_29_6 = utf8.len(var_29_4)
				local var_29_7 = var_29_5 <= 0 and var_29_1 or var_29_1 * (var_29_6 / var_29_5)

				if var_29_7 > 0 and var_29_1 < var_29_7 then
					arg_26_1.talkMaxDuration = var_29_7

					if var_29_7 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_7 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_4
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111006", "story_v_out_104111.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_104111", "104111006", "story_v_out_104111.awb") / 1000

					if var_29_8 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_0
					end

					if var_29_3.prefab_name ~= "" and arg_26_1.actors_[var_29_3.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_3.prefab_name].transform, "story_v_out_104111", "104111006", "story_v_out_104111.awb")

						arg_26_1:RecordAudio("104111006", var_29_9)
						arg_26_1:RecordAudio("104111006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_104111", "104111006", "story_v_out_104111.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_104111", "104111006", "story_v_out_104111.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_10 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_10 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_10

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_10 and arg_26_1.time_ < var_29_0 + var_29_10 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play104111007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 104111007
		arg_30_1.duration_ = 5.03

		local var_30_0 = {
			ja = 3.3,
			ko = 5.033,
			zh = 4.5,
			en = 2.566
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play104111008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1037ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect1037ui_story == nil then
				arg_30_1.var_.characterEffect1037ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.1

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect1037ui_story and not isNil(var_33_0) then
					arg_30_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect1037ui_story then
				arg_30_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_33_4 = arg_30_1.actors_["1037ui_story"].transform
			local var_33_5 = 0

			if var_33_5 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 then
				arg_30_1.var_.moveOldPos1037ui_story = var_33_4.localPosition
			end

			local var_33_6 = 0.001

			if var_33_5 <= arg_30_1.time_ and arg_30_1.time_ < var_33_5 + var_33_6 then
				local var_33_7 = (arg_30_1.time_ - var_33_5) / var_33_6
				local var_33_8 = Vector3.New(0, -1.09, -5.81)

				var_33_4.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1037ui_story, var_33_8, var_33_7)

				local var_33_9 = manager.ui.mainCamera.transform.position - var_33_4.position

				var_33_4.forward = Vector3.New(var_33_9.x, var_33_9.y, var_33_9.z)

				local var_33_10 = var_33_4.localEulerAngles

				var_33_10.z = 0
				var_33_10.x = 0
				var_33_4.localEulerAngles = var_33_10
			end

			if arg_30_1.time_ >= var_33_5 + var_33_6 and arg_30_1.time_ < var_33_5 + var_33_6 + arg_33_0 then
				var_33_4.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_33_11 = manager.ui.mainCamera.transform.position - var_33_4.position

				var_33_4.forward = Vector3.New(var_33_11.x, var_33_11.y, var_33_11.z)

				local var_33_12 = var_33_4.localEulerAngles

				var_33_12.z = 0
				var_33_12.x = 0
				var_33_4.localEulerAngles = var_33_12
			end

			local var_33_13 = 0

			if var_33_13 < arg_30_1.time_ and arg_30_1.time_ <= var_33_13 + arg_33_0 then
				arg_30_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action7_1")
			end

			local var_33_14 = 0

			if var_33_14 < arg_30_1.time_ and arg_30_1.time_ <= var_33_14 + arg_33_0 then
				arg_30_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_33_15 = 0
			local var_33_16 = 0.425

			if var_33_15 < arg_30_1.time_ and arg_30_1.time_ <= var_33_15 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_17 = arg_30_1:FormatText(StoryNameCfg[15].name)

				arg_30_1.leftNameTxt_.text = var_33_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_18 = arg_30_1:GetWordFromCfg(104111007)
				local var_33_19 = arg_30_1:FormatText(var_33_18.content)

				arg_30_1.text_.text = var_33_19

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_20 = 16
				local var_33_21 = utf8.len(var_33_19)
				local var_33_22 = var_33_20 <= 0 and var_33_16 or var_33_16 * (var_33_21 / var_33_20)

				if var_33_22 > 0 and var_33_16 < var_33_22 then
					arg_30_1.talkMaxDuration = var_33_22

					if var_33_22 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_22 + var_33_15
					end
				end

				arg_30_1.text_.text = var_33_19
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111007", "story_v_out_104111.awb") ~= 0 then
					local var_33_23 = manager.audio:GetVoiceLength("story_v_out_104111", "104111007", "story_v_out_104111.awb") / 1000

					if var_33_23 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_23 + var_33_15
					end

					if var_33_18.prefab_name ~= "" and arg_30_1.actors_[var_33_18.prefab_name] ~= nil then
						local var_33_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_18.prefab_name].transform, "story_v_out_104111", "104111007", "story_v_out_104111.awb")

						arg_30_1:RecordAudio("104111007", var_33_24)
						arg_30_1:RecordAudio("104111007", var_33_24)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_104111", "104111007", "story_v_out_104111.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_104111", "104111007", "story_v_out_104111.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_25 = math.max(var_33_16, arg_30_1.talkMaxDuration)

			if var_33_15 <= arg_30_1.time_ and arg_30_1.time_ < var_33_15 + var_33_25 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_15) / var_33_25

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_15 + var_33_25 and arg_30_1.time_ < var_33_15 + var_33_25 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play104111008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 104111008
		arg_34_1.duration_ = 6.83

		local var_34_0 = {
			ja = 5.233,
			ko = 5.933,
			zh = 5.8,
			en = 6.833
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play104111009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1037ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1037ui_story == nil then
				arg_34_1.var_.characterEffect1037ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.1

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect1037ui_story and not isNil(var_37_0) then
					local var_37_4 = Mathf.Lerp(0, 0.5, var_37_3)

					arg_34_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1037ui_story.fillRatio = var_37_4
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1037ui_story then
				local var_37_5 = 0.5

				arg_34_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1037ui_story.fillRatio = var_37_5
			end

			local var_37_6 = arg_34_1.actors_["1037ui_story"].transform
			local var_37_7 = 0

			if var_37_7 < arg_34_1.time_ and arg_34_1.time_ <= var_37_7 + arg_37_0 then
				arg_34_1.var_.moveOldPos1037ui_story = var_37_6.localPosition
			end

			local var_37_8 = 0.001

			if var_37_7 <= arg_34_1.time_ and arg_34_1.time_ < var_37_7 + var_37_8 then
				local var_37_9 = (arg_34_1.time_ - var_37_7) / var_37_8
				local var_37_10 = Vector3.New(0, 100, 0)

				var_37_6.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1037ui_story, var_37_10, var_37_9)

				local var_37_11 = manager.ui.mainCamera.transform.position - var_37_6.position

				var_37_6.forward = Vector3.New(var_37_11.x, var_37_11.y, var_37_11.z)

				local var_37_12 = var_37_6.localEulerAngles

				var_37_12.z = 0
				var_37_12.x = 0
				var_37_6.localEulerAngles = var_37_12
			end

			if arg_34_1.time_ >= var_37_7 + var_37_8 and arg_34_1.time_ < var_37_7 + var_37_8 + arg_37_0 then
				var_37_6.localPosition = Vector3.New(0, 100, 0)

				local var_37_13 = manager.ui.mainCamera.transform.position - var_37_6.position

				var_37_6.forward = Vector3.New(var_37_13.x, var_37_13.y, var_37_13.z)

				local var_37_14 = var_37_6.localEulerAngles

				var_37_14.z = 0
				var_37_14.x = 0
				var_37_6.localEulerAngles = var_37_14
			end

			local var_37_15 = 0
			local var_37_16 = 0.775

			if var_37_15 < arg_34_1.time_ and arg_34_1.time_ <= var_37_15 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_17 = arg_34_1:FormatText(StoryNameCfg[55].name)

				arg_34_1.leftNameTxt_.text = var_37_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_18 = arg_34_1:GetWordFromCfg(104111008)
				local var_37_19 = arg_34_1:FormatText(var_37_18.content)

				arg_34_1.text_.text = var_37_19

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_20 = 31
				local var_37_21 = utf8.len(var_37_19)
				local var_37_22 = var_37_20 <= 0 and var_37_16 or var_37_16 * (var_37_21 / var_37_20)

				if var_37_22 > 0 and var_37_16 < var_37_22 then
					arg_34_1.talkMaxDuration = var_37_22

					if var_37_22 + var_37_15 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_22 + var_37_15
					end
				end

				arg_34_1.text_.text = var_37_19
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111008", "story_v_out_104111.awb") ~= 0 then
					local var_37_23 = manager.audio:GetVoiceLength("story_v_out_104111", "104111008", "story_v_out_104111.awb") / 1000

					if var_37_23 + var_37_15 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_23 + var_37_15
					end

					if var_37_18.prefab_name ~= "" and arg_34_1.actors_[var_37_18.prefab_name] ~= nil then
						local var_37_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_18.prefab_name].transform, "story_v_out_104111", "104111008", "story_v_out_104111.awb")

						arg_34_1:RecordAudio("104111008", var_37_24)
						arg_34_1:RecordAudio("104111008", var_37_24)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_104111", "104111008", "story_v_out_104111.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_104111", "104111008", "story_v_out_104111.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_25 = math.max(var_37_16, arg_34_1.talkMaxDuration)

			if var_37_15 <= arg_34_1.time_ and arg_34_1.time_ < var_37_15 + var_37_25 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_15) / var_37_25

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_15 + var_37_25 and arg_34_1.time_ < var_37_15 + var_37_25 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play104111009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 104111009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play104111010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0
			local var_41_1 = 0.15

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

				local var_41_3 = arg_38_1:GetWordFromCfg(104111009)
				local var_41_4 = arg_38_1:FormatText(var_41_3.content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 6
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
	Play104111010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 104111010
		arg_42_1.duration_ = 8.97

		local var_42_0 = {
			ja = 8.966,
			ko = 6.4,
			zh = 5.333,
			en = 6.333
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play104111011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = "1080ui_story"

			if arg_42_1.actors_[var_45_0] == nil then
				local var_45_1 = Asset.Load("Char/" .. "1080ui_story")

				if not isNil(var_45_1) then
					local var_45_2 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_42_1.stage_.transform)

					var_45_2.name = var_45_0
					var_45_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_42_1.actors_[var_45_0] = var_45_2

					local var_45_3 = var_45_2:GetComponentInChildren(typeof(CharacterEffect))

					var_45_3.enabled = true

					local var_45_4 = GameObjectTools.GetOrAddComponent(var_45_2, typeof(DynamicBoneHelper))

					if var_45_4 then
						var_45_4:EnableDynamicBone(false)
					end

					arg_42_1:ShowWeapon(var_45_3.transform, false)

					arg_42_1.var_[var_45_0 .. "Animator"] = var_45_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_42_1.var_[var_45_0 .. "Animator"].applyRootMotion = true
					arg_42_1.var_[var_45_0 .. "LipSync"] = var_45_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_45_5 = arg_42_1.actors_["1080ui_story"]
			local var_45_6 = 0

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect1080ui_story == nil then
				arg_42_1.var_.characterEffect1080ui_story = var_45_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_7 = 0.1

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_7 and not isNil(var_45_5) then
				local var_45_8 = (arg_42_1.time_ - var_45_6) / var_45_7

				if arg_42_1.var_.characterEffect1080ui_story and not isNil(var_45_5) then
					arg_42_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_6 + var_45_7 and arg_42_1.time_ < var_45_6 + var_45_7 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect1080ui_story then
				arg_42_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_45_9 = 0

			if var_45_9 < arg_42_1.time_ and arg_42_1.time_ <= var_45_9 + arg_45_0 then
				arg_42_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_45_10 = 0
			local var_45_11 = 0.75

			if var_45_10 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_12 = arg_42_1:FormatText(StoryNameCfg[55].name)

				arg_42_1.leftNameTxt_.text = var_45_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_13 = arg_42_1:GetWordFromCfg(104111010)
				local var_45_14 = arg_42_1:FormatText(var_45_13.content)

				arg_42_1.text_.text = var_45_14

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_15 = 30
				local var_45_16 = utf8.len(var_45_14)
				local var_45_17 = var_45_15 <= 0 and var_45_11 or var_45_11 * (var_45_16 / var_45_15)

				if var_45_17 > 0 and var_45_11 < var_45_17 then
					arg_42_1.talkMaxDuration = var_45_17

					if var_45_17 + var_45_10 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_17 + var_45_10
					end
				end

				arg_42_1.text_.text = var_45_14
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111010", "story_v_out_104111.awb") ~= 0 then
					local var_45_18 = manager.audio:GetVoiceLength("story_v_out_104111", "104111010", "story_v_out_104111.awb") / 1000

					if var_45_18 + var_45_10 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_18 + var_45_10
					end

					if var_45_13.prefab_name ~= "" and arg_42_1.actors_[var_45_13.prefab_name] ~= nil then
						local var_45_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_13.prefab_name].transform, "story_v_out_104111", "104111010", "story_v_out_104111.awb")

						arg_42_1:RecordAudio("104111010", var_45_19)
						arg_42_1:RecordAudio("104111010", var_45_19)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_104111", "104111010", "story_v_out_104111.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_104111", "104111010", "story_v_out_104111.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_20 = math.max(var_45_11, arg_42_1.talkMaxDuration)

			if var_45_10 <= arg_42_1.time_ and arg_42_1.time_ < var_45_10 + var_45_20 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_10) / var_45_20

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_10 + var_45_20 and arg_42_1.time_ < var_45_10 + var_45_20 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play104111011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 104111011
		arg_46_1.duration_ = 7.2

		local var_46_0 = {
			ja = 7.2,
			ko = 4.666,
			zh = 7.1,
			en = 6.5
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play104111012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = "1027ui_story"

			if arg_46_1.actors_[var_49_0] == nil then
				local var_49_1 = Asset.Load("Char/" .. "1027ui_story")

				if not isNil(var_49_1) then
					local var_49_2 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_46_1.stage_.transform)

					var_49_2.name = var_49_0
					var_49_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_46_1.actors_[var_49_0] = var_49_2

					local var_49_3 = var_49_2:GetComponentInChildren(typeof(CharacterEffect))

					var_49_3.enabled = true

					local var_49_4 = GameObjectTools.GetOrAddComponent(var_49_2, typeof(DynamicBoneHelper))

					if var_49_4 then
						var_49_4:EnableDynamicBone(false)
					end

					arg_46_1:ShowWeapon(var_49_3.transform, false)

					arg_46_1.var_[var_49_0 .. "Animator"] = var_49_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_46_1.var_[var_49_0 .. "Animator"].applyRootMotion = true
					arg_46_1.var_[var_49_0 .. "LipSync"] = var_49_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_49_5 = arg_46_1.actors_["1027ui_story"]
			local var_49_6 = 0

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 and not isNil(var_49_5) and arg_46_1.var_.characterEffect1027ui_story == nil then
				arg_46_1.var_.characterEffect1027ui_story = var_49_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_7 = 0.1

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_7 and not isNil(var_49_5) then
				local var_49_8 = (arg_46_1.time_ - var_49_6) / var_49_7

				if arg_46_1.var_.characterEffect1027ui_story and not isNil(var_49_5) then
					arg_46_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_6 + var_49_7 and arg_46_1.time_ < var_49_6 + var_49_7 + arg_49_0 and not isNil(var_49_5) and arg_46_1.var_.characterEffect1027ui_story then
				arg_46_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_49_9 = arg_46_1.actors_["1080ui_story"]
			local var_49_10 = 0

			if var_49_10 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 and not isNil(var_49_9) and arg_46_1.var_.characterEffect1080ui_story == nil then
				arg_46_1.var_.characterEffect1080ui_story = var_49_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_11 = 0.1

			if var_49_10 <= arg_46_1.time_ and arg_46_1.time_ < var_49_10 + var_49_11 and not isNil(var_49_9) then
				local var_49_12 = (arg_46_1.time_ - var_49_10) / var_49_11

				if arg_46_1.var_.characterEffect1080ui_story and not isNil(var_49_9) then
					local var_49_13 = Mathf.Lerp(0, 0.5, var_49_12)

					arg_46_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1080ui_story.fillRatio = var_49_13
				end
			end

			if arg_46_1.time_ >= var_49_10 + var_49_11 and arg_46_1.time_ < var_49_10 + var_49_11 + arg_49_0 and not isNil(var_49_9) and arg_46_1.var_.characterEffect1080ui_story then
				local var_49_14 = 0.5

				arg_46_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1080ui_story.fillRatio = var_49_14
			end

			local var_49_15 = 0

			if var_49_15 < arg_46_1.time_ and arg_46_1.time_ <= var_49_15 + arg_49_0 then
				arg_46_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_49_16 = 0
			local var_49_17 = 0.775

			if var_49_16 < arg_46_1.time_ and arg_46_1.time_ <= var_49_16 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_18 = arg_46_1:FormatText(StoryNameCfg[56].name)

				arg_46_1.leftNameTxt_.text = var_49_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1027")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_19 = arg_46_1:GetWordFromCfg(104111011)
				local var_49_20 = arg_46_1:FormatText(var_49_19.content)

				arg_46_1.text_.text = var_49_20

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_21 = 31
				local var_49_22 = utf8.len(var_49_20)
				local var_49_23 = var_49_21 <= 0 and var_49_17 or var_49_17 * (var_49_22 / var_49_21)

				if var_49_23 > 0 and var_49_17 < var_49_23 then
					arg_46_1.talkMaxDuration = var_49_23

					if var_49_23 + var_49_16 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_23 + var_49_16
					end
				end

				arg_46_1.text_.text = var_49_20
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111011", "story_v_out_104111.awb") ~= 0 then
					local var_49_24 = manager.audio:GetVoiceLength("story_v_out_104111", "104111011", "story_v_out_104111.awb") / 1000

					if var_49_24 + var_49_16 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_24 + var_49_16
					end

					if var_49_19.prefab_name ~= "" and arg_46_1.actors_[var_49_19.prefab_name] ~= nil then
						local var_49_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_19.prefab_name].transform, "story_v_out_104111", "104111011", "story_v_out_104111.awb")

						arg_46_1:RecordAudio("104111011", var_49_25)
						arg_46_1:RecordAudio("104111011", var_49_25)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_104111", "104111011", "story_v_out_104111.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_104111", "104111011", "story_v_out_104111.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_26 = math.max(var_49_17, arg_46_1.talkMaxDuration)

			if var_49_16 <= arg_46_1.time_ and arg_46_1.time_ < var_49_16 + var_49_26 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_16) / var_49_26

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_16 + var_49_26 and arg_46_1.time_ < var_49_16 + var_49_26 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play104111012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 104111012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play104111013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1027ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1027ui_story == nil then
				arg_50_1.var_.characterEffect1027ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.1

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect1027ui_story and not isNil(var_53_0) then
					local var_53_4 = Mathf.Lerp(0, 0.5, var_53_3)

					arg_50_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1027ui_story.fillRatio = var_53_4
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1027ui_story then
				local var_53_5 = 0.5

				arg_50_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1027ui_story.fillRatio = var_53_5
			end

			local var_53_6 = 0

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action7_1")
			end

			local var_53_7 = 0
			local var_53_8 = 1.075

			if var_53_7 < arg_50_1.time_ and arg_50_1.time_ <= var_53_7 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_9 = arg_50_1:FormatText(StoryNameCfg[7].name)

				arg_50_1.leftNameTxt_.text = var_53_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_10 = arg_50_1:GetWordFromCfg(104111012)
				local var_53_11 = arg_50_1:FormatText(var_53_10.content)

				arg_50_1.text_.text = var_53_11

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_12 = 43
				local var_53_13 = utf8.len(var_53_11)
				local var_53_14 = var_53_12 <= 0 and var_53_8 or var_53_8 * (var_53_13 / var_53_12)

				if var_53_14 > 0 and var_53_8 < var_53_14 then
					arg_50_1.talkMaxDuration = var_53_14

					if var_53_14 + var_53_7 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_7
					end
				end

				arg_50_1.text_.text = var_53_11
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_15 = math.max(var_53_8, arg_50_1.talkMaxDuration)

			if var_53_7 <= arg_50_1.time_ and arg_50_1.time_ < var_53_7 + var_53_15 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_7) / var_53_15

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_7 + var_53_15 and arg_50_1.time_ < var_53_7 + var_53_15 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play104111013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 104111013
		arg_54_1.duration_ = 2.17

		local var_54_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.166,
			en = 1.999999999999
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
				arg_54_0:Play104111014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1037ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1037ui_story == nil then
				arg_54_1.var_.characterEffect1037ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.1

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1037ui_story and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1037ui_story then
				arg_54_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_57_4 = arg_54_1.actors_["1037ui_story"].transform
			local var_57_5 = 0

			if var_57_5 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 then
				arg_54_1.var_.moveOldPos1037ui_story = var_57_4.localPosition
			end

			local var_57_6 = 0.001

			if var_57_5 <= arg_54_1.time_ and arg_54_1.time_ < var_57_5 + var_57_6 then
				local var_57_7 = (arg_54_1.time_ - var_57_5) / var_57_6
				local var_57_8 = Vector3.New(0, -1.09, -5.81)

				var_57_4.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1037ui_story, var_57_8, var_57_7)

				local var_57_9 = manager.ui.mainCamera.transform.position - var_57_4.position

				var_57_4.forward = Vector3.New(var_57_9.x, var_57_9.y, var_57_9.z)

				local var_57_10 = var_57_4.localEulerAngles

				var_57_10.z = 0
				var_57_10.x = 0
				var_57_4.localEulerAngles = var_57_10
			end

			if arg_54_1.time_ >= var_57_5 + var_57_6 and arg_54_1.time_ < var_57_5 + var_57_6 + arg_57_0 then
				var_57_4.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_57_11 = manager.ui.mainCamera.transform.position - var_57_4.position

				var_57_4.forward = Vector3.New(var_57_11.x, var_57_11.y, var_57_11.z)

				local var_57_12 = var_57_4.localEulerAngles

				var_57_12.z = 0
				var_57_12.x = 0
				var_57_4.localEulerAngles = var_57_12
			end

			local var_57_13 = 0

			if var_57_13 < arg_54_1.time_ and arg_54_1.time_ <= var_57_13 + arg_57_0 then
				arg_54_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_57_14 = 0
			local var_57_15 = 0.05

			if var_57_14 < arg_54_1.time_ and arg_54_1.time_ <= var_57_14 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_16 = arg_54_1:FormatText(StoryNameCfg[15].name)

				arg_54_1.leftNameTxt_.text = var_57_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_17 = arg_54_1:GetWordFromCfg(104111013)
				local var_57_18 = arg_54_1:FormatText(var_57_17.content)

				arg_54_1.text_.text = var_57_18

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_19 = 2
				local var_57_20 = utf8.len(var_57_18)
				local var_57_21 = var_57_19 <= 0 and var_57_15 or var_57_15 * (var_57_20 / var_57_19)

				if var_57_21 > 0 and var_57_15 < var_57_21 then
					arg_54_1.talkMaxDuration = var_57_21

					if var_57_21 + var_57_14 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_21 + var_57_14
					end
				end

				arg_54_1.text_.text = var_57_18
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111013", "story_v_out_104111.awb") ~= 0 then
					local var_57_22 = manager.audio:GetVoiceLength("story_v_out_104111", "104111013", "story_v_out_104111.awb") / 1000

					if var_57_22 + var_57_14 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_22 + var_57_14
					end

					if var_57_17.prefab_name ~= "" and arg_54_1.actors_[var_57_17.prefab_name] ~= nil then
						local var_57_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_17.prefab_name].transform, "story_v_out_104111", "104111013", "story_v_out_104111.awb")

						arg_54_1:RecordAudio("104111013", var_57_23)
						arg_54_1:RecordAudio("104111013", var_57_23)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_104111", "104111013", "story_v_out_104111.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_104111", "104111013", "story_v_out_104111.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_24 = math.max(var_57_15, arg_54_1.talkMaxDuration)

			if var_57_14 <= arg_54_1.time_ and arg_54_1.time_ < var_57_14 + var_57_24 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_14) / var_57_24

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_14 + var_57_24 and arg_54_1.time_ < var_57_14 + var_57_24 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play104111014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 104111014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play104111015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1037ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1037ui_story == nil then
				arg_58_1.var_.characterEffect1037ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.1

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1037ui_story and not isNil(var_61_0) then
					local var_61_4 = Mathf.Lerp(0, 0.5, var_61_3)

					arg_58_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1037ui_story.fillRatio = var_61_4
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1037ui_story then
				local var_61_5 = 0.5

				arg_58_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1037ui_story.fillRatio = var_61_5
			end

			local var_61_6 = 0
			local var_61_7 = 0.1

			if var_61_6 < arg_58_1.time_ and arg_58_1.time_ <= var_61_6 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_8 = arg_58_1:FormatText(StoryNameCfg[7].name)

				arg_58_1.leftNameTxt_.text = var_61_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_9 = arg_58_1:GetWordFromCfg(104111014)
				local var_61_10 = arg_58_1:FormatText(var_61_9.content)

				arg_58_1.text_.text = var_61_10

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_11 = 4
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
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_14 = math.max(var_61_7, arg_58_1.talkMaxDuration)

			if var_61_6 <= arg_58_1.time_ and arg_58_1.time_ < var_61_6 + var_61_14 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_6) / var_61_14

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_6 + var_61_14 and arg_58_1.time_ < var_61_6 + var_61_14 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play104111015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 104111015
		arg_62_1.duration_ = 4.73

		local var_62_0 = {
			ja = 4.2,
			ko = 4.733,
			zh = 3.7,
			en = 3.933
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play104111016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1037ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1037ui_story == nil then
				arg_62_1.var_.characterEffect1037ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.1

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1037ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1037ui_story then
				arg_62_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_65_4 = 0

			if var_65_4 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action472")
			end

			local var_65_5 = 0

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 then
				arg_62_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_65_6 = 0
			local var_65_7 = 0.45

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[15].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_9 = arg_62_1:GetWordFromCfg(104111015)
				local var_65_10 = arg_62_1:FormatText(var_65_9.content)

				arg_62_1.text_.text = var_65_10

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 18
				local var_65_12 = utf8.len(var_65_10)
				local var_65_13 = var_65_11 <= 0 and var_65_7 or var_65_7 * (var_65_12 / var_65_11)

				if var_65_13 > 0 and var_65_7 < var_65_13 then
					arg_62_1.talkMaxDuration = var_65_13

					if var_65_13 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_13 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_10
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104111", "104111015", "story_v_out_104111.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_out_104111", "104111015", "story_v_out_104111.awb") / 1000

					if var_65_14 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_6
					end

					if var_65_9.prefab_name ~= "" and arg_62_1.actors_[var_65_9.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_9.prefab_name].transform, "story_v_out_104111", "104111015", "story_v_out_104111.awb")

						arg_62_1:RecordAudio("104111015", var_65_15)
						arg_62_1:RecordAudio("104111015", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_104111", "104111015", "story_v_out_104111.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_104111", "104111015", "story_v_out_104111.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_16 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_16 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_16

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_16 and arg_62_1.time_ < var_65_6 + var_65_16 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play104111016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 104111016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
			arg_66_1.auto_ = false
		end

		function arg_66_1.playNext_(arg_68_0)
			arg_66_1.onStoryFinished_()
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1037ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1037ui_story == nil then
				arg_66_1.var_.characterEffect1037ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1037ui_story and not isNil(var_69_0) then
					local var_69_4 = Mathf.Lerp(0, 0.5, var_69_3)

					arg_66_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1037ui_story.fillRatio = var_69_4
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1037ui_story then
				local var_69_5 = 0.5

				arg_66_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1037ui_story.fillRatio = var_69_5
			end

			local var_69_6 = arg_66_1.actors_["1037ui_story"].transform
			local var_69_7 = 0

			if var_69_7 < arg_66_1.time_ and arg_66_1.time_ <= var_69_7 + arg_69_0 then
				arg_66_1.var_.moveOldPos1037ui_story = var_69_6.localPosition
			end

			local var_69_8 = 0.001

			if var_69_7 <= arg_66_1.time_ and arg_66_1.time_ < var_69_7 + var_69_8 then
				local var_69_9 = (arg_66_1.time_ - var_69_7) / var_69_8
				local var_69_10 = Vector3.New(0, 100, 0)

				var_69_6.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1037ui_story, var_69_10, var_69_9)

				local var_69_11 = manager.ui.mainCamera.transform.position - var_69_6.position

				var_69_6.forward = Vector3.New(var_69_11.x, var_69_11.y, var_69_11.z)

				local var_69_12 = var_69_6.localEulerAngles

				var_69_12.z = 0
				var_69_12.x = 0
				var_69_6.localEulerAngles = var_69_12
			end

			if arg_66_1.time_ >= var_69_7 + var_69_8 and arg_66_1.time_ < var_69_7 + var_69_8 + arg_69_0 then
				var_69_6.localPosition = Vector3.New(0, 100, 0)

				local var_69_13 = manager.ui.mainCamera.transform.position - var_69_6.position

				var_69_6.forward = Vector3.New(var_69_13.x, var_69_13.y, var_69_13.z)

				local var_69_14 = var_69_6.localEulerAngles

				var_69_14.z = 0
				var_69_14.x = 0
				var_69_6.localEulerAngles = var_69_14
			end

			local var_69_15 = 0
			local var_69_16 = 0.05

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_17 = arg_66_1:FormatText(StoryNameCfg[7].name)

				arg_66_1.leftNameTxt_.text = var_69_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_18 = arg_66_1:GetWordFromCfg(104111016)
				local var_69_19 = arg_66_1:FormatText(var_69_18.content)

				arg_66_1.text_.text = var_69_19

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_20 = 2
				local var_69_21 = utf8.len(var_69_19)
				local var_69_22 = var_69_20 <= 0 and var_69_16 or var_69_16 * (var_69_21 / var_69_20)

				if var_69_22 > 0 and var_69_16 < var_69_22 then
					arg_66_1.talkMaxDuration = var_69_22

					if var_69_22 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_22 + var_69_15
					end
				end

				arg_66_1.text_.text = var_69_19
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_23 = math.max(var_69_16, arg_66_1.talkMaxDuration)

			if var_69_15 <= arg_66_1.time_ and arg_66_1.time_ < var_69_15 + var_69_23 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_15) / var_69_23

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_15 + var_69_23 and arg_66_1.time_ < var_69_15 + var_69_23 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	assets = {
		"TextureConfig/Background/S0404",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_104111.awb"
	}
}
