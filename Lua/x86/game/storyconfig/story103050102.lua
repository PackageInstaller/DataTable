return {
	Play305012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 305012001
		arg_1_1.duration_ = 6.67

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play305012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "S0408"

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
				local var_4_5 = arg_1_1.bgs_.S0408

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
					if iter_4_0 ~= "S0408" then
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

			local var_4_19 = 1.83333333333333

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0.990566, 0.990566, 0.990566)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0.990566, 0.990566, 0.990566)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0.2
			local var_4_25 = 1

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "effect"

				arg_1_1:AudioAction(var_4_26, var_4_27, "se_story_140", "se_story_140_amb_drone03", "")
			end

			local var_4_28 = 1
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

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

				arg_1_1:AudioAction(var_4_36, var_4_37, "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_38 = 1.674999999999
			local var_4_39 = 0.325

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

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_41 = arg_1_1:FormatText(StoryNameCfg[7].name)

				arg_1_1.leftNameTxt_.text = var_4_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_42 = arg_1_1:GetWordFromCfg(305012001)
				local var_4_43 = arg_1_1:FormatText(var_4_42.content)

				arg_1_1.text_.text = var_4_43

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_44 = 13
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
	Play305012002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 305012002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play305012003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story_144", "se_story_144_gun05", "")
			end

			local var_11_4 = 0
			local var_11_5 = 1.375

			if var_11_4 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_6 = arg_8_1:GetWordFromCfg(305012002)
				local var_11_7 = arg_8_1:FormatText(var_11_6.content)

				arg_8_1.text_.text = var_11_7

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_8 = 55
				local var_11_9 = utf8.len(var_11_7)
				local var_11_10 = var_11_8 <= 0 and var_11_5 or var_11_5 * (var_11_9 / var_11_8)

				if var_11_10 > 0 and var_11_5 < var_11_10 then
					arg_8_1.talkMaxDuration = var_11_10

					if var_11_10 + var_11_4 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_10 + var_11_4
					end
				end

				arg_8_1.text_.text = var_11_7
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_11 = math.max(var_11_5, arg_8_1.talkMaxDuration)

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_11 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_4) / var_11_11

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_4 + var_11_11 and arg_8_1.time_ < var_11_4 + var_11_11 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play305012003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 305012003
		arg_12_1.duration_ = 4.36

		local var_12_0 = {
			zh = 4.358,
			ja = 4.291
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play305012004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "S0408a"

			if arg_12_1.bgs_[var_15_0] == nil then
				local var_15_1 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_0)
				var_15_1.name = var_15_0
				var_15_1.transform.parent = arg_12_1.stage_.transform
				var_15_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_0] = var_15_1
			end

			local var_15_2 = 0

			if var_15_2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				local var_15_3 = manager.ui.mainCamera.transform.localPosition
				local var_15_4 = Vector3.New(0, 0, 10) + Vector3.New(var_15_3.x, var_15_3.y, 0)
				local var_15_5 = arg_12_1.bgs_.S0408a

				var_15_5.transform.localPosition = var_15_4
				var_15_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_6 = var_15_5:GetComponent("SpriteRenderer")

				if var_15_6 and var_15_6.sprite then
					local var_15_7 = (var_15_5.transform.localPosition - var_15_3).z
					local var_15_8 = manager.ui.mainCameraCom_
					local var_15_9 = 2 * var_15_7 * Mathf.Tan(var_15_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_15_10 = var_15_9 * var_15_8.aspect
					local var_15_11 = var_15_6.sprite.bounds.size.x
					local var_15_12 = var_15_6.sprite.bounds.size.y
					local var_15_13 = var_15_10 / var_15_11
					local var_15_14 = var_15_9 / var_15_12
					local var_15_15 = var_15_14 < var_15_13 and var_15_13 or var_15_14

					var_15_5.transform.localScale = Vector3.New(var_15_15, var_15_15, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "S0408a" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_17 = 0.3

			if arg_12_1.time_ >= var_15_16 + var_15_17 and arg_12_1.time_ < var_15_16 + var_15_17 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_19 = 1

			if var_15_18 <= arg_12_1.time_ and arg_12_1.time_ < var_15_18 + var_15_19 then
				local var_15_20 = (arg_12_1.time_ - var_15_18) / var_15_19
				local var_15_21 = Color.New(0, 0, 0)

				var_15_21.a = Mathf.Lerp(1, 0, var_15_20)
				arg_12_1.mask_.color = var_15_21
			end

			if arg_12_1.time_ >= var_15_18 + var_15_19 and arg_12_1.time_ < var_15_18 + var_15_19 + arg_15_0 then
				local var_15_22 = Color.New(0, 0, 0)
				local var_15_23 = 0

				arg_12_1.mask_.enabled = false
				var_15_22.a = var_15_23
				arg_12_1.mask_.color = var_15_22
			end

			local var_15_24 = arg_12_1.actors_["2069ui_story"]
			local var_15_25 = 0

			if var_15_25 < arg_12_1.time_ and arg_12_1.time_ <= var_15_25 + arg_15_0 and not isNil(var_15_24) and arg_12_1.var_.characterEffect2069ui_story == nil then
				arg_12_1.var_.characterEffect2069ui_story = var_15_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_26 = 0.200000002980232

			if var_15_25 <= arg_12_1.time_ and arg_12_1.time_ < var_15_25 + var_15_26 and not isNil(var_15_24) then
				local var_15_27 = (arg_12_1.time_ - var_15_25) / var_15_26

				if arg_12_1.var_.characterEffect2069ui_story and not isNil(var_15_24) then
					arg_12_1.var_.characterEffect2069ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_25 + var_15_26 and arg_12_1.time_ < var_15_25 + var_15_26 + arg_15_0 and not isNil(var_15_24) and arg_12_1.var_.characterEffect2069ui_story then
				arg_12_1.var_.characterEffect2069ui_story.fillFlat = false
			end

			local var_15_28 = manager.ui.mainCamera.transform
			local var_15_29 = 0

			if var_15_29 < arg_12_1.time_ and arg_12_1.time_ <= var_15_29 + arg_15_0 then
				local var_15_30 = arg_12_1.var_.effectQWE
				local var_15_31
				local var_15_32 = var_15_28

				if not var_15_30 then
					var_15_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_15_32)
					var_15_30.name = "QWE"
					arg_12_1.var_.effectQWE = var_15_30
				else
					var_15_30.transform:SetParent(var_15_32)
				end

				var_15_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_30.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_15_33 = 1.7777777777777777
				local var_15_34 = Screen.width / Screen.height
				local var_15_35 = var_15_34 / var_15_33
				local var_15_36 = Mathf.Max(var_15_33 / var_15_34, 1)

				var_15_30.transform.localScale = Vector3.New(var_15_30.transform.localScale.x * var_15_35, var_15_30.transform.localScale.y * var_15_36, var_15_30.transform.localScale.z)
			end

			local var_15_37 = manager.ui.mainCamera.transform
			local var_15_38 = 1.75

			if var_15_38 < arg_12_1.time_ and arg_12_1.time_ <= var_15_38 + arg_15_0 then
				local var_15_39 = arg_12_1.var_.effectQWE

				if var_15_39 then
					Object.Destroy(var_15_39)

					arg_12_1.var_.effectQWE = nil
				end
			end

			local var_15_40 = manager.ui.mainCamera.transform
			local var_15_41 = 0.633333333333333

			if var_15_41 < arg_12_1.time_ and arg_12_1.time_ <= var_15_41 + arg_15_0 then
				local var_15_42 = arg_12_1.var_.effectQWE1
				local var_15_43
				local var_15_44 = var_15_40

				if not var_15_42 then
					var_15_42 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_15_44)
					var_15_42.name = "QWE1"
					arg_12_1.var_.effectQWE1 = var_15_42
				else
					var_15_42.transform:SetParent(var_15_44)
				end

				var_15_42.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_42.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_15_45 = 1.7777777777777777
				local var_15_46 = Screen.width / Screen.height
				local var_15_47 = var_15_46 / var_15_45
				local var_15_48 = Mathf.Max(var_15_45 / var_15_46, 1)

				var_15_42.transform.localScale = Vector3.New(var_15_42.transform.localScale.x * var_15_47, var_15_42.transform.localScale.y * var_15_48, var_15_42.transform.localScale.z)
			end

			local var_15_49 = manager.ui.mainCamera.transform
			local var_15_50 = 2.38333333333333

			if var_15_50 < arg_12_1.time_ and arg_12_1.time_ <= var_15_50 + arg_15_0 then
				local var_15_51 = arg_12_1.var_.effectQWE1

				if var_15_51 then
					Object.Destroy(var_15_51)

					arg_12_1.var_.effectQWE1 = nil
				end
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_52 = 0.825
			local var_15_53 = 0.175

			if var_15_52 < arg_12_1.time_ and arg_12_1.time_ <= var_15_52 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_54 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_54:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_55 = arg_12_1:FormatText(StoryNameCfg[60].name)

				arg_12_1.leftNameTxt_.text = var_15_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_56 = arg_12_1:GetWordFromCfg(305012003)
				local var_15_57 = arg_12_1:FormatText(var_15_56.content)

				arg_12_1.text_.text = var_15_57

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_58 = 7
				local var_15_59 = utf8.len(var_15_57)
				local var_15_60 = var_15_58 <= 0 and var_15_53 or var_15_53 * (var_15_59 / var_15_58)

				if var_15_60 > 0 and var_15_53 < var_15_60 then
					arg_12_1.talkMaxDuration = var_15_60
					var_15_52 = var_15_52 + 0.3

					if var_15_60 + var_15_52 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_60 + var_15_52
					end
				end

				arg_12_1.text_.text = var_15_57
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012003", "story_v_out_305012.awb") ~= 0 then
					local var_15_61 = manager.audio:GetVoiceLength("story_v_out_305012", "305012003", "story_v_out_305012.awb") / 1000

					if var_15_61 + var_15_52 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_61 + var_15_52
					end

					if var_15_56.prefab_name ~= "" and arg_12_1.actors_[var_15_56.prefab_name] ~= nil then
						local var_15_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_56.prefab_name].transform, "story_v_out_305012", "305012003", "story_v_out_305012.awb")

						arg_12_1:RecordAudio("305012003", var_15_62)
						arg_12_1:RecordAudio("305012003", var_15_62)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_305012", "305012003", "story_v_out_305012.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_305012", "305012003", "story_v_out_305012.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_63 = var_15_52 + 0.3
			local var_15_64 = math.max(var_15_53, arg_12_1.talkMaxDuration)

			if var_15_63 <= arg_12_1.time_ and arg_12_1.time_ < var_15_63 + var_15_64 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_63) / var_15_64

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_63 + var_15_64 and arg_12_1.time_ < var_15_63 + var_15_64 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play305012004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 305012004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play305012005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["2069ui_story"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect2069ui_story == nil then
				arg_18_1.var_.characterEffect2069ui_story = var_21_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_2 = 0.200000002980232

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.characterEffect2069ui_story and not isNil(var_21_0) then
					local var_21_4 = Mathf.Lerp(0, 0.5, var_21_3)

					arg_18_1.var_.characterEffect2069ui_story.fillFlat = true
					arg_18_1.var_.characterEffect2069ui_story.fillRatio = var_21_4
				end
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect2069ui_story then
				local var_21_5 = 0.5

				arg_18_1.var_.characterEffect2069ui_story.fillFlat = true
				arg_18_1.var_.characterEffect2069ui_story.fillRatio = var_21_5
			end

			local var_21_6 = 0
			local var_21_7 = 1.4

			if var_21_6 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_8 = arg_18_1:GetWordFromCfg(305012004)
				local var_21_9 = arg_18_1:FormatText(var_21_8.content)

				arg_18_1.text_.text = var_21_9

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_10 = 56
				local var_21_11 = utf8.len(var_21_9)
				local var_21_12 = var_21_10 <= 0 and var_21_7 or var_21_7 * (var_21_11 / var_21_10)

				if var_21_12 > 0 and var_21_7 < var_21_12 then
					arg_18_1.talkMaxDuration = var_21_12

					if var_21_12 + var_21_6 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_12 + var_21_6
					end
				end

				arg_18_1.text_.text = var_21_9
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_13 = math.max(var_21_7, arg_18_1.talkMaxDuration)

			if var_21_6 <= arg_18_1.time_ and arg_18_1.time_ < var_21_6 + var_21_13 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_6) / var_21_13

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_6 + var_21_13 and arg_18_1.time_ < var_21_6 + var_21_13 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play305012005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 305012005
		arg_22_1.duration_ = 7.24

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play305012006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = "B13a"

			if arg_22_1.bgs_[var_25_0] == nil then
				local var_25_1 = Object.Instantiate(arg_22_1.paintGo_)

				var_25_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_25_0)
				var_25_1.name = var_25_0
				var_25_1.transform.parent = arg_22_1.stage_.transform
				var_25_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_[var_25_0] = var_25_1
			end

			local var_25_2 = 1

			if var_25_2 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				local var_25_3 = manager.ui.mainCamera.transform.localPosition
				local var_25_4 = Vector3.New(0, 0, 10) + Vector3.New(var_25_3.x, var_25_3.y, 0)
				local var_25_5 = arg_22_1.bgs_.B13a

				var_25_5.transform.localPosition = var_25_4
				var_25_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_6 = var_25_5:GetComponent("SpriteRenderer")

				if var_25_6 and var_25_6.sprite then
					local var_25_7 = (var_25_5.transform.localPosition - var_25_3).z
					local var_25_8 = manager.ui.mainCameraCom_
					local var_25_9 = 2 * var_25_7 * Mathf.Tan(var_25_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_25_10 = var_25_9 * var_25_8.aspect
					local var_25_11 = var_25_6.sprite.bounds.size.x
					local var_25_12 = var_25_6.sprite.bounds.size.y
					local var_25_13 = var_25_10 / var_25_11
					local var_25_14 = var_25_9 / var_25_12
					local var_25_15 = var_25_14 < var_25_13 and var_25_13 or var_25_14

					var_25_5.transform.localScale = Vector3.New(var_25_15, var_25_15, 0)
				end

				for iter_25_0, iter_25_1 in pairs(arg_22_1.bgs_) do
					if iter_25_0 ~= "B13a" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_16 = 0

			if var_25_16 < arg_22_1.time_ and arg_22_1.time_ <= var_25_16 + arg_25_0 then
				arg_22_1.allBtn_.enabled = false
			end

			local var_25_17 = 0.3

			if arg_22_1.time_ >= var_25_16 + var_25_17 and arg_22_1.time_ < var_25_16 + var_25_17 + arg_25_0 then
				arg_22_1.allBtn_.enabled = true
			end

			local var_25_18 = 0

			if var_25_18 < arg_22_1.time_ and arg_22_1.time_ <= var_25_18 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_19 = 1

			if var_25_18 <= arg_22_1.time_ and arg_22_1.time_ < var_25_18 + var_25_19 then
				local var_25_20 = (arg_22_1.time_ - var_25_18) / var_25_19
				local var_25_21 = Color.New(0, 0, 0)

				var_25_21.a = Mathf.Lerp(0, 1, var_25_20)
				arg_22_1.mask_.color = var_25_21
			end

			if arg_22_1.time_ >= var_25_18 + var_25_19 and arg_22_1.time_ < var_25_18 + var_25_19 + arg_25_0 then
				local var_25_22 = Color.New(0, 0, 0)

				var_25_22.a = 1
				arg_22_1.mask_.color = var_25_22
			end

			local var_25_23 = 1

			if var_25_23 < arg_22_1.time_ and arg_22_1.time_ <= var_25_23 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_24 = 1.46666666666667

			if var_25_23 <= arg_22_1.time_ and arg_22_1.time_ < var_25_23 + var_25_24 then
				local var_25_25 = (arg_22_1.time_ - var_25_23) / var_25_24
				local var_25_26 = Color.New(0, 0, 0)

				var_25_26.a = Mathf.Lerp(1, 0, var_25_25)
				arg_22_1.mask_.color = var_25_26
			end

			if arg_22_1.time_ >= var_25_23 + var_25_24 and arg_22_1.time_ < var_25_23 + var_25_24 + arg_25_0 then
				local var_25_27 = Color.New(0, 0, 0)
				local var_25_28 = 0

				arg_22_1.mask_.enabled = false
				var_25_27.a = var_25_28
				arg_22_1.mask_.color = var_25_27
			end

			local var_25_29 = 1.2
			local var_25_30 = 1

			if var_25_29 < arg_22_1.time_ and arg_22_1.time_ <= var_25_29 + arg_25_0 then
				local var_25_31 = "play"
				local var_25_32 = "effect"

				arg_22_1:AudioAction(var_25_31, var_25_32, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_25_33 = 0.2
			local var_25_34 = 1

			if var_25_33 < arg_22_1.time_ and arg_22_1.time_ <= var_25_33 + arg_25_0 then
				local var_25_35 = "stop"
				local var_25_36 = "effect"

				arg_22_1:AudioAction(var_25_35, var_25_36, "se_story_140", "se_story_140_amb_drone03", "")
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_37 = 2.24166666666667
			local var_25_38 = 0.225

			if var_25_37 < arg_22_1.time_ and arg_22_1.time_ <= var_25_37 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_39 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_39:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_22_1.dialogCg_.alpha = arg_26_0
				end))
				var_25_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_40 = arg_22_1:FormatText(StoryNameCfg[7].name)

				arg_22_1.leftNameTxt_.text = var_25_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_41 = arg_22_1:GetWordFromCfg(305012005)
				local var_25_42 = arg_22_1:FormatText(var_25_41.content)

				arg_22_1.text_.text = var_25_42

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_43 = 9
				local var_25_44 = utf8.len(var_25_42)
				local var_25_45 = var_25_43 <= 0 and var_25_38 or var_25_38 * (var_25_44 / var_25_43)

				if var_25_45 > 0 and var_25_38 < var_25_45 then
					arg_22_1.talkMaxDuration = var_25_45
					var_25_37 = var_25_37 + 0.3

					if var_25_45 + var_25_37 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_45 + var_25_37
					end
				end

				arg_22_1.text_.text = var_25_42
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_46 = var_25_37 + 0.3
			local var_25_47 = math.max(var_25_38, arg_22_1.talkMaxDuration)

			if var_25_46 <= arg_22_1.time_ and arg_22_1.time_ < var_25_46 + var_25_47 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_46) / var_25_47

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_46 + var_25_47 and arg_22_1.time_ < var_25_46 + var_25_47 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play305012006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 305012006
		arg_28_1.duration_ = 8.9

		local var_28_0 = {
			zh = 3.2,
			ja = 8.9
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play305012007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1033ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "1033ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = arg_28_1.actors_["1033ui_story"].transform
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.var_.moveOldPos1033ui_story = var_31_5.localPosition
			end

			local var_31_7 = 0.001

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7
				local var_31_9 = Vector3.New(0, -1.01, -6.13)

				var_31_5.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1033ui_story, var_31_9, var_31_8)

				local var_31_10 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_10.x, var_31_10.y, var_31_10.z)

				local var_31_11 = var_31_5.localEulerAngles

				var_31_11.z = 0
				var_31_11.x = 0
				var_31_5.localEulerAngles = var_31_11
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 then
				var_31_5.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_31_12 = manager.ui.mainCamera.transform.position - var_31_5.position

				var_31_5.forward = Vector3.New(var_31_12.x, var_31_12.y, var_31_12.z)

				local var_31_13 = var_31_5.localEulerAngles

				var_31_13.z = 0
				var_31_13.x = 0
				var_31_5.localEulerAngles = var_31_13
			end

			local var_31_14 = arg_28_1.actors_["1033ui_story"]
			local var_31_15 = 0

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 and not isNil(var_31_14) and arg_28_1.var_.characterEffect1033ui_story == nil then
				arg_28_1.var_.characterEffect1033ui_story = var_31_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_16 = 0.200000002980232

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_16 and not isNil(var_31_14) then
				local var_31_17 = (arg_28_1.time_ - var_31_15) / var_31_16

				if arg_28_1.var_.characterEffect1033ui_story and not isNil(var_31_14) then
					arg_28_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_15 + var_31_16 and arg_28_1.time_ < var_31_15 + var_31_16 + arg_31_0 and not isNil(var_31_14) and arg_28_1.var_.characterEffect1033ui_story then
				arg_28_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_31_18 = 0

			if var_31_18 < arg_28_1.time_ and arg_28_1.time_ <= var_31_18 + arg_31_0 then
				arg_28_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			local var_31_19 = 0

			if var_31_19 < arg_28_1.time_ and arg_28_1.time_ <= var_31_19 + arg_31_0 then
				arg_28_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_31_20 = 0
			local var_31_21 = 0.375

			if var_31_20 < arg_28_1.time_ and arg_28_1.time_ <= var_31_20 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_22 = arg_28_1:FormatText(StoryNameCfg[236].name)

				arg_28_1.leftNameTxt_.text = var_31_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_23 = arg_28_1:GetWordFromCfg(305012006)
				local var_31_24 = arg_28_1:FormatText(var_31_23.content)

				arg_28_1.text_.text = var_31_24

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_25 = 15
				local var_31_26 = utf8.len(var_31_24)
				local var_31_27 = var_31_25 <= 0 and var_31_21 or var_31_21 * (var_31_26 / var_31_25)

				if var_31_27 > 0 and var_31_21 < var_31_27 then
					arg_28_1.talkMaxDuration = var_31_27

					if var_31_27 + var_31_20 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_27 + var_31_20
					end
				end

				arg_28_1.text_.text = var_31_24
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012006", "story_v_out_305012.awb") ~= 0 then
					local var_31_28 = manager.audio:GetVoiceLength("story_v_out_305012", "305012006", "story_v_out_305012.awb") / 1000

					if var_31_28 + var_31_20 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_28 + var_31_20
					end

					if var_31_23.prefab_name ~= "" and arg_28_1.actors_[var_31_23.prefab_name] ~= nil then
						local var_31_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_23.prefab_name].transform, "story_v_out_305012", "305012006", "story_v_out_305012.awb")

						arg_28_1:RecordAudio("305012006", var_31_29)
						arg_28_1:RecordAudio("305012006", var_31_29)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_305012", "305012006", "story_v_out_305012.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_305012", "305012006", "story_v_out_305012.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_30 = math.max(var_31_21, arg_28_1.talkMaxDuration)

			if var_31_20 <= arg_28_1.time_ and arg_28_1.time_ < var_31_20 + var_31_30 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_20) / var_31_30

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_20 + var_31_30 and arg_28_1.time_ < var_31_20 + var_31_30 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play305012007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 305012007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play305012008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1033ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1033ui_story == nil then
				arg_32_1.var_.characterEffect1033ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1033ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1033ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1033ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1033ui_story.fillRatio = var_35_5
			end

			local var_35_6 = 0
			local var_35_7 = 0.4

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_8 = arg_32_1:FormatText(StoryNameCfg[7].name)

				arg_32_1.leftNameTxt_.text = var_35_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_9 = arg_32_1:GetWordFromCfg(305012007)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 16
				local var_35_12 = utf8.len(var_35_10)
				local var_35_13 = var_35_11 <= 0 and var_35_7 or var_35_7 * (var_35_12 / var_35_11)

				if var_35_13 > 0 and var_35_7 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_14 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_14 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_14

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_14 and arg_32_1.time_ < var_35_6 + var_35_14 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play305012008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 305012008
		arg_36_1.duration_ = 10.73

		local var_36_0 = {
			zh = 4.066,
			ja = 10.733
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
				arg_36_0:Play305012009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1033ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1033ui_story == nil then
				arg_36_1.var_.characterEffect1033ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1033ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1033ui_story then
				arg_36_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_39_4 = 0

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action438")
			end

			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_6 = 0
			local var_39_7 = 0.575

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[236].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_9 = arg_36_1:GetWordFromCfg(305012008)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012008", "story_v_out_305012.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_out_305012", "305012008", "story_v_out_305012.awb") / 1000

					if var_39_14 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_6
					end

					if var_39_9.prefab_name ~= "" and arg_36_1.actors_[var_39_9.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_9.prefab_name].transform, "story_v_out_305012", "305012008", "story_v_out_305012.awb")

						arg_36_1:RecordAudio("305012008", var_39_15)
						arg_36_1:RecordAudio("305012008", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_305012", "305012008", "story_v_out_305012.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_305012", "305012008", "story_v_out_305012.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_16 and arg_36_1.time_ < var_39_6 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play305012009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 305012009
		arg_40_1.duration_ = 4.73

		local var_40_0 = {
			zh = 4.733,
			ja = 1.999999999999
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
				arg_40_0:Play305012010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = "1066ui_story"

			if arg_40_1.actors_[var_43_0] == nil then
				local var_43_1 = Asset.Load("Char/" .. "1066ui_story")

				if not isNil(var_43_1) then
					local var_43_2 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_40_1.stage_.transform)

					var_43_2.name = var_43_0
					var_43_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_40_1.actors_[var_43_0] = var_43_2

					local var_43_3 = var_43_2:GetComponentInChildren(typeof(CharacterEffect))

					var_43_3.enabled = true

					local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_2, typeof(DynamicBoneHelper))

					if var_43_4 then
						var_43_4:EnableDynamicBone(false)
					end

					arg_40_1:ShowWeapon(var_43_3.transform, false)

					arg_40_1.var_[var_43_0 .. "Animator"] = var_43_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_40_1.var_[var_43_0 .. "Animator"].applyRootMotion = true
					arg_40_1.var_[var_43_0 .. "LipSync"] = var_43_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_43_5 = arg_40_1.actors_["1066ui_story"].transform
			local var_43_6 = 0

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.var_.moveOldPos1066ui_story = var_43_5.localPosition
			end

			local var_43_7 = 0.001

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_7 then
				local var_43_8 = (arg_40_1.time_ - var_43_6) / var_43_7
				local var_43_9 = Vector3.New(-0.7, -0.77, -6.1)

				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1066ui_story, var_43_9, var_43_8)

				local var_43_10 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_10.x, var_43_10.y, var_43_10.z)

				local var_43_11 = var_43_5.localEulerAngles

				var_43_11.z = 0
				var_43_11.x = 0
				var_43_5.localEulerAngles = var_43_11
			end

			if arg_40_1.time_ >= var_43_6 + var_43_7 and arg_40_1.time_ < var_43_6 + var_43_7 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(-0.7, -0.77, -6.1)

				local var_43_12 = manager.ui.mainCamera.transform.position - var_43_5.position

				var_43_5.forward = Vector3.New(var_43_12.x, var_43_12.y, var_43_12.z)

				local var_43_13 = var_43_5.localEulerAngles

				var_43_13.z = 0
				var_43_13.x = 0
				var_43_5.localEulerAngles = var_43_13
			end

			local var_43_14 = arg_40_1.actors_["1033ui_story"].transform
			local var_43_15 = 0

			if var_43_15 < arg_40_1.time_ and arg_40_1.time_ <= var_43_15 + arg_43_0 then
				arg_40_1.var_.moveOldPos1033ui_story = var_43_14.localPosition
			end

			local var_43_16 = 0.001

			if var_43_15 <= arg_40_1.time_ and arg_40_1.time_ < var_43_15 + var_43_16 then
				local var_43_17 = (arg_40_1.time_ - var_43_15) / var_43_16
				local var_43_18 = Vector3.New(0.7, -1.01, -6.13)

				var_43_14.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1033ui_story, var_43_18, var_43_17)

				local var_43_19 = manager.ui.mainCamera.transform.position - var_43_14.position

				var_43_14.forward = Vector3.New(var_43_19.x, var_43_19.y, var_43_19.z)

				local var_43_20 = var_43_14.localEulerAngles

				var_43_20.z = 0
				var_43_20.x = 0
				var_43_14.localEulerAngles = var_43_20
			end

			if arg_40_1.time_ >= var_43_15 + var_43_16 and arg_40_1.time_ < var_43_15 + var_43_16 + arg_43_0 then
				var_43_14.localPosition = Vector3.New(0.7, -1.01, -6.13)

				local var_43_21 = manager.ui.mainCamera.transform.position - var_43_14.position

				var_43_14.forward = Vector3.New(var_43_21.x, var_43_21.y, var_43_21.z)

				local var_43_22 = var_43_14.localEulerAngles

				var_43_22.z = 0
				var_43_22.x = 0
				var_43_14.localEulerAngles = var_43_22
			end

			local var_43_23 = arg_40_1.actors_["1066ui_story"]
			local var_43_24 = 0

			if var_43_24 < arg_40_1.time_ and arg_40_1.time_ <= var_43_24 + arg_43_0 and not isNil(var_43_23) and arg_40_1.var_.characterEffect1066ui_story == nil then
				arg_40_1.var_.characterEffect1066ui_story = var_43_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_25 = 0.200000002980232

			if var_43_24 <= arg_40_1.time_ and arg_40_1.time_ < var_43_24 + var_43_25 and not isNil(var_43_23) then
				local var_43_26 = (arg_40_1.time_ - var_43_24) / var_43_25

				if arg_40_1.var_.characterEffect1066ui_story and not isNil(var_43_23) then
					arg_40_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_24 + var_43_25 and arg_40_1.time_ < var_43_24 + var_43_25 + arg_43_0 and not isNil(var_43_23) and arg_40_1.var_.characterEffect1066ui_story then
				arg_40_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_43_27 = arg_40_1.actors_["1033ui_story"]
			local var_43_28 = 0

			if var_43_28 < arg_40_1.time_ and arg_40_1.time_ <= var_43_28 + arg_43_0 and not isNil(var_43_27) and arg_40_1.var_.characterEffect1033ui_story == nil then
				arg_40_1.var_.characterEffect1033ui_story = var_43_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_29 = 0.200000002980232

			if var_43_28 <= arg_40_1.time_ and arg_40_1.time_ < var_43_28 + var_43_29 and not isNil(var_43_27) then
				local var_43_30 = (arg_40_1.time_ - var_43_28) / var_43_29

				if arg_40_1.var_.characterEffect1033ui_story and not isNil(var_43_27) then
					local var_43_31 = Mathf.Lerp(0, 0.5, var_43_30)

					arg_40_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1033ui_story.fillRatio = var_43_31
				end
			end

			if arg_40_1.time_ >= var_43_28 + var_43_29 and arg_40_1.time_ < var_43_28 + var_43_29 + arg_43_0 and not isNil(var_43_27) and arg_40_1.var_.characterEffect1033ui_story then
				local var_43_32 = 0.5

				arg_40_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1033ui_story.fillRatio = var_43_32
			end

			local var_43_33 = 0

			if var_43_33 < arg_40_1.time_ and arg_40_1.time_ <= var_43_33 + arg_43_0 then
				arg_40_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action6_1")
			end

			local var_43_34 = 0

			if var_43_34 < arg_40_1.time_ and arg_40_1.time_ <= var_43_34 + arg_43_0 then
				arg_40_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_35 = 0
			local var_43_36 = 0.6

			if var_43_35 < arg_40_1.time_ and arg_40_1.time_ <= var_43_35 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_37 = arg_40_1:FormatText(StoryNameCfg[32].name)

				arg_40_1.leftNameTxt_.text = var_43_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_38 = arg_40_1:GetWordFromCfg(305012009)
				local var_43_39 = arg_40_1:FormatText(var_43_38.content)

				arg_40_1.text_.text = var_43_39

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_40 = 24
				local var_43_41 = utf8.len(var_43_39)
				local var_43_42 = var_43_40 <= 0 and var_43_36 or var_43_36 * (var_43_41 / var_43_40)

				if var_43_42 > 0 and var_43_36 < var_43_42 then
					arg_40_1.talkMaxDuration = var_43_42

					if var_43_42 + var_43_35 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_42 + var_43_35
					end
				end

				arg_40_1.text_.text = var_43_39
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012009", "story_v_out_305012.awb") ~= 0 then
					local var_43_43 = manager.audio:GetVoiceLength("story_v_out_305012", "305012009", "story_v_out_305012.awb") / 1000

					if var_43_43 + var_43_35 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_43 + var_43_35
					end

					if var_43_38.prefab_name ~= "" and arg_40_1.actors_[var_43_38.prefab_name] ~= nil then
						local var_43_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_38.prefab_name].transform, "story_v_out_305012", "305012009", "story_v_out_305012.awb")

						arg_40_1:RecordAudio("305012009", var_43_44)
						arg_40_1:RecordAudio("305012009", var_43_44)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_305012", "305012009", "story_v_out_305012.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_305012", "305012009", "story_v_out_305012.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_45 = math.max(var_43_36, arg_40_1.talkMaxDuration)

			if var_43_35 <= arg_40_1.time_ and arg_40_1.time_ < var_43_35 + var_43_45 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_35) / var_43_45

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_35 + var_43_45 and arg_40_1.time_ < var_43_35 + var_43_45 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play305012010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 305012010
		arg_44_1.duration_ = 11.9

		local var_44_0 = {
			zh = 5.3,
			ja = 11.9
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
				arg_44_0:Play305012011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1033ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1033ui_story == nil then
				arg_44_1.var_.characterEffect1033ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1033ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1033ui_story then
				arg_44_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["1066ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1066ui_story == nil then
				arg_44_1.var_.characterEffect1066ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.200000002980232

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect1066ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1066ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1066ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1066ui_story.fillRatio = var_47_9
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action482")
			end

			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_47_12 = 0
			local var_47_13 = 0.75

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_14 = arg_44_1:FormatText(StoryNameCfg[236].name)

				arg_44_1.leftNameTxt_.text = var_47_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:GetWordFromCfg(305012010)
				local var_47_16 = arg_44_1:FormatText(var_47_15.content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 30
				local var_47_18 = utf8.len(var_47_16)
				local var_47_19 = var_47_17 <= 0 and var_47_13 or var_47_13 * (var_47_18 / var_47_17)

				if var_47_19 > 0 and var_47_13 < var_47_19 then
					arg_44_1.talkMaxDuration = var_47_19

					if var_47_19 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_16
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012010", "story_v_out_305012.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_305012", "305012010", "story_v_out_305012.awb") / 1000

					if var_47_20 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_12
					end

					if var_47_15.prefab_name ~= "" and arg_44_1.actors_[var_47_15.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_15.prefab_name].transform, "story_v_out_305012", "305012010", "story_v_out_305012.awb")

						arg_44_1:RecordAudio("305012010", var_47_21)
						arg_44_1:RecordAudio("305012010", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_305012", "305012010", "story_v_out_305012.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_305012", "305012010", "story_v_out_305012.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_22 and arg_44_1.time_ < var_47_12 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play305012011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 305012011
		arg_48_1.duration_ = 5.8

		local var_48_0 = {
			zh = 5.8,
			ja = 1.999999999999
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
				arg_48_0:Play305012012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1066ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1066ui_story == nil then
				arg_48_1.var_.characterEffect1066ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1066ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1066ui_story then
				arg_48_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1033ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1033ui_story == nil then
				arg_48_1.var_.characterEffect1033ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.200000002980232

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1033ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1033ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1033ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1033ui_story.fillRatio = var_51_9
			end

			local var_51_10 = 0

			if var_51_10 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action6_2")
			end

			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_12 = 0
			local var_51_13 = 0.7

			if var_51_12 < arg_48_1.time_ and arg_48_1.time_ <= var_51_12 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_14 = arg_48_1:FormatText(StoryNameCfg[32].name)

				arg_48_1.leftNameTxt_.text = var_51_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_15 = arg_48_1:GetWordFromCfg(305012011)
				local var_51_16 = arg_48_1:FormatText(var_51_15.content)

				arg_48_1.text_.text = var_51_16

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_17 = 28
				local var_51_18 = utf8.len(var_51_16)
				local var_51_19 = var_51_17 <= 0 and var_51_13 or var_51_13 * (var_51_18 / var_51_17)

				if var_51_19 > 0 and var_51_13 < var_51_19 then
					arg_48_1.talkMaxDuration = var_51_19

					if var_51_19 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_19 + var_51_12
					end
				end

				arg_48_1.text_.text = var_51_16
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012011", "story_v_out_305012.awb") ~= 0 then
					local var_51_20 = manager.audio:GetVoiceLength("story_v_out_305012", "305012011", "story_v_out_305012.awb") / 1000

					if var_51_20 + var_51_12 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_20 + var_51_12
					end

					if var_51_15.prefab_name ~= "" and arg_48_1.actors_[var_51_15.prefab_name] ~= nil then
						local var_51_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_15.prefab_name].transform, "story_v_out_305012", "305012011", "story_v_out_305012.awb")

						arg_48_1:RecordAudio("305012011", var_51_21)
						arg_48_1:RecordAudio("305012011", var_51_21)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_305012", "305012011", "story_v_out_305012.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_305012", "305012011", "story_v_out_305012.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_22 = math.max(var_51_13, arg_48_1.talkMaxDuration)

			if var_51_12 <= arg_48_1.time_ and arg_48_1.time_ < var_51_12 + var_51_22 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_12) / var_51_22

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_12 + var_51_22 and arg_48_1.time_ < var_51_12 + var_51_22 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play305012012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 305012012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play305012013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1066ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1066ui_story == nil then
				arg_52_1.var_.characterEffect1066ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1066ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1066ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1066ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1066ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 0.9

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[7].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_9 = arg_52_1:GetWordFromCfg(305012012)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 36
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
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_14 and arg_52_1.time_ < var_55_6 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play305012013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 305012013
		arg_56_1.duration_ = 2.9

		local var_56_0 = {
			zh = 2.3,
			ja = 2.9
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
				arg_56_0:Play305012014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1066ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1066ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, 100, 0)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1066ui_story, var_59_4, var_59_3)

				local var_59_5 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_5.x, var_59_5.y, var_59_5.z)

				local var_59_6 = var_59_0.localEulerAngles

				var_59_6.z = 0
				var_59_6.x = 0
				var_59_0.localEulerAngles = var_59_6
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 then
				var_59_0.localPosition = Vector3.New(0, 100, 0)

				local var_59_7 = manager.ui.mainCamera.transform.position - var_59_0.position

				var_59_0.forward = Vector3.New(var_59_7.x, var_59_7.y, var_59_7.z)

				local var_59_8 = var_59_0.localEulerAngles

				var_59_8.z = 0
				var_59_8.x = 0
				var_59_0.localEulerAngles = var_59_8
			end

			local var_59_9 = arg_56_1.actors_["1033ui_story"].transform
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.var_.moveOldPos1033ui_story = var_59_9.localPosition
			end

			local var_59_11 = 0.001

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11
				local var_59_13 = Vector3.New(0, 100, 0)

				var_59_9.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1033ui_story, var_59_13, var_59_12)

				local var_59_14 = manager.ui.mainCamera.transform.position - var_59_9.position

				var_59_9.forward = Vector3.New(var_59_14.x, var_59_14.y, var_59_14.z)

				local var_59_15 = var_59_9.localEulerAngles

				var_59_15.z = 0
				var_59_15.x = 0
				var_59_9.localEulerAngles = var_59_15
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 then
				var_59_9.localPosition = Vector3.New(0, 100, 0)

				local var_59_16 = manager.ui.mainCamera.transform.position - var_59_9.position

				var_59_9.forward = Vector3.New(var_59_16.x, var_59_16.y, var_59_16.z)

				local var_59_17 = var_59_9.localEulerAngles

				var_59_17.z = 0
				var_59_17.x = 0
				var_59_9.localEulerAngles = var_59_17
			end

			local var_59_18 = "10045ui_story"

			if arg_56_1.actors_[var_59_18] == nil then
				local var_59_19 = Asset.Load("Char/" .. "10045ui_story")

				if not isNil(var_59_19) then
					local var_59_20 = Object.Instantiate(Asset.Load("Char/" .. "10045ui_story"), arg_56_1.stage_.transform)

					var_59_20.name = var_59_18
					var_59_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_56_1.actors_[var_59_18] = var_59_20

					local var_59_21 = var_59_20:GetComponentInChildren(typeof(CharacterEffect))

					var_59_21.enabled = true

					local var_59_22 = GameObjectTools.GetOrAddComponent(var_59_20, typeof(DynamicBoneHelper))

					if var_59_22 then
						var_59_22:EnableDynamicBone(false)
					end

					arg_56_1:ShowWeapon(var_59_21.transform, false)

					arg_56_1.var_[var_59_18 .. "Animator"] = var_59_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_56_1.var_[var_59_18 .. "Animator"].applyRootMotion = true
					arg_56_1.var_[var_59_18 .. "LipSync"] = var_59_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_59_23 = arg_56_1.actors_["10045ui_story"]
			local var_59_24 = 0

			if var_59_24 < arg_56_1.time_ and arg_56_1.time_ <= var_59_24 + arg_59_0 and not isNil(var_59_23) and arg_56_1.var_.characterEffect10045ui_story == nil then
				arg_56_1.var_.characterEffect10045ui_story = var_59_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_25 = 0.200000002980232

			if var_59_24 <= arg_56_1.time_ and arg_56_1.time_ < var_59_24 + var_59_25 and not isNil(var_59_23) then
				local var_59_26 = (arg_56_1.time_ - var_59_24) / var_59_25

				if arg_56_1.var_.characterEffect10045ui_story and not isNil(var_59_23) then
					arg_56_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_24 + var_59_25 and arg_56_1.time_ < var_59_24 + var_59_25 + arg_59_0 and not isNil(var_59_23) and arg_56_1.var_.characterEffect10045ui_story then
				arg_56_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_59_27 = 0
			local var_59_28 = 0.25

			if var_59_27 < arg_56_1.time_ and arg_56_1.time_ <= var_59_27 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_29 = arg_56_1:FormatText(StoryNameCfg[36].name)

				arg_56_1.leftNameTxt_.text = var_59_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_30 = arg_56_1:GetWordFromCfg(305012013)
				local var_59_31 = arg_56_1:FormatText(var_59_30.content)

				arg_56_1.text_.text = var_59_31

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_32 = 10
				local var_59_33 = utf8.len(var_59_31)
				local var_59_34 = var_59_32 <= 0 and var_59_28 or var_59_28 * (var_59_33 / var_59_32)

				if var_59_34 > 0 and var_59_28 < var_59_34 then
					arg_56_1.talkMaxDuration = var_59_34

					if var_59_34 + var_59_27 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_34 + var_59_27
					end
				end

				arg_56_1.text_.text = var_59_31
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012013", "story_v_out_305012.awb") ~= 0 then
					local var_59_35 = manager.audio:GetVoiceLength("story_v_out_305012", "305012013", "story_v_out_305012.awb") / 1000

					if var_59_35 + var_59_27 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_35 + var_59_27
					end

					if var_59_30.prefab_name ~= "" and arg_56_1.actors_[var_59_30.prefab_name] ~= nil then
						local var_59_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_30.prefab_name].transform, "story_v_out_305012", "305012013", "story_v_out_305012.awb")

						arg_56_1:RecordAudio("305012013", var_59_36)
						arg_56_1:RecordAudio("305012013", var_59_36)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_305012", "305012013", "story_v_out_305012.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_305012", "305012013", "story_v_out_305012.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_37 = math.max(var_59_28, arg_56_1.talkMaxDuration)

			if var_59_27 <= arg_56_1.time_ and arg_56_1.time_ < var_59_27 + var_59_37 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_27) / var_59_37

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_27 + var_59_37 and arg_56_1.time_ < var_59_27 + var_59_37 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play305012014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 305012014
		arg_60_1.duration_ = 6.73

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play305012015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "S0405"

			if arg_60_1.bgs_[var_63_0] == nil then
				local var_63_1 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_63_0)
				var_63_1.name = var_63_0
				var_63_1.transform.parent = arg_60_1.stage_.transform
				var_63_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_[var_63_0] = var_63_1
			end

			local var_63_2 = 0.34623639928177

			if var_63_2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				local var_63_3 = manager.ui.mainCamera.transform.localPosition
				local var_63_4 = Vector3.New(0, 0, 10) + Vector3.New(var_63_3.x, var_63_3.y, 0)
				local var_63_5 = arg_60_1.bgs_.S0405

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
					if iter_63_0 ~= "S0405" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_16 = 0.34623639928177

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

			local var_63_19 = 0.34623639928177

			if var_63_18 <= arg_60_1.time_ and arg_60_1.time_ < var_63_18 + var_63_19 then
				local var_63_20 = (arg_60_1.time_ - var_63_18) / var_63_19
				local var_63_21 = Color.New(1, 1, 1)

				var_63_21.a = Mathf.Lerp(0, 1, var_63_20)
				arg_60_1.mask_.color = var_63_21
			end

			if arg_60_1.time_ >= var_63_18 + var_63_19 and arg_60_1.time_ < var_63_18 + var_63_19 + arg_63_0 then
				local var_63_22 = Color.New(1, 1, 1)

				var_63_22.a = 1
				arg_60_1.mask_.color = var_63_22
			end

			local var_63_23 = 0.34623639928177

			if var_63_23 < arg_60_1.time_ and arg_60_1.time_ <= var_63_23 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_24 = 1.58709693405156

			if var_63_23 <= arg_60_1.time_ and arg_60_1.time_ < var_63_23 + var_63_24 then
				local var_63_25 = (arg_60_1.time_ - var_63_23) / var_63_24
				local var_63_26 = Color.New(1, 1, 1)

				var_63_26.a = Mathf.Lerp(1, 0, var_63_25)
				arg_60_1.mask_.color = var_63_26
			end

			if arg_60_1.time_ >= var_63_23 + var_63_24 and arg_60_1.time_ < var_63_23 + var_63_24 + arg_63_0 then
				local var_63_27 = Color.New(1, 1, 1)
				local var_63_28 = 0

				arg_60_1.mask_.enabled = false
				var_63_27.a = var_63_28
				arg_60_1.mask_.color = var_63_27
			end

			local var_63_29 = arg_60_1.actors_["10045ui_story"]
			local var_63_30 = 0.34623639928177

			if var_63_30 < arg_60_1.time_ and arg_60_1.time_ <= var_63_30 + arg_63_0 and not isNil(var_63_29) and arg_60_1.var_.characterEffect10045ui_story == nil then
				arg_60_1.var_.characterEffect10045ui_story = var_63_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_31 = 0.200000002980232

			if var_63_30 <= arg_60_1.time_ and arg_60_1.time_ < var_63_30 + var_63_31 and not isNil(var_63_29) then
				local var_63_32 = (arg_60_1.time_ - var_63_30) / var_63_31

				if arg_60_1.var_.characterEffect10045ui_story and not isNil(var_63_29) then
					local var_63_33 = Mathf.Lerp(0, 0.5, var_63_32)

					arg_60_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10045ui_story.fillRatio = var_63_33
				end
			end

			if arg_60_1.time_ >= var_63_30 + var_63_31 and arg_60_1.time_ < var_63_30 + var_63_31 + arg_63_0 and not isNil(var_63_29) and arg_60_1.var_.characterEffect10045ui_story then
				local var_63_34 = 0.5

				arg_60_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10045ui_story.fillRatio = var_63_34
			end

			local var_63_35 = 0.2
			local var_63_36 = 1

			if var_63_35 < arg_60_1.time_ and arg_60_1.time_ <= var_63_35 + arg_63_0 then
				local var_63_37 = "play"
				local var_63_38 = "effect"

				arg_60_1:AudioAction(var_63_37, var_63_38, "se_story_148", "se_story_148_sword08", "")
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_39 = 1.73333333333333
			local var_63_40 = 1.125

			if var_63_39 < arg_60_1.time_ and arg_60_1.time_ <= var_63_39 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_41 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_41:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_42 = arg_60_1:GetWordFromCfg(305012014)
				local var_63_43 = arg_60_1:FormatText(var_63_42.content)

				arg_60_1.text_.text = var_63_43

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_44 = 43
				local var_63_45 = utf8.len(var_63_43)
				local var_63_46 = var_63_44 <= 0 and var_63_40 or var_63_40 * (var_63_45 / var_63_44)

				if var_63_46 > 0 and var_63_40 < var_63_46 then
					arg_60_1.talkMaxDuration = var_63_46
					var_63_39 = var_63_39 + 0.3

					if var_63_46 + var_63_39 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_46 + var_63_39
					end
				end

				arg_60_1.text_.text = var_63_43
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_47 = var_63_39 + 0.3
			local var_63_48 = math.max(var_63_40, arg_60_1.talkMaxDuration)

			if var_63_47 <= arg_60_1.time_ and arg_60_1.time_ < var_63_47 + var_63_48 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_47) / var_63_48

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_47 + var_63_48 and arg_60_1.time_ < var_63_47 + var_63_48 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.1,
				amplitudeGain = 0.3,
				startTime = 0.733333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play305012015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 305012015
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play305012016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0
			local var_69_1 = 1.2

			if var_69_0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_2 = arg_66_1:GetWordFromCfg(305012015)
				local var_69_3 = arg_66_1:FormatText(var_69_2.content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 48
				local var_69_5 = utf8.len(var_69_3)
				local var_69_6 = var_69_4 <= 0 and var_69_1 or var_69_1 * (var_69_5 / var_69_4)

				if var_69_6 > 0 and var_69_1 < var_69_6 then
					arg_66_1.talkMaxDuration = var_69_6

					if var_69_6 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_7 and arg_66_1.time_ < var_69_0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play305012016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 305012016
		arg_70_1.duration_ = 6.93

		local var_70_0 = {
			zh = 5.2,
			ja = 6.933
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
				arg_70_0:Play305012017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10045ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10045ui_story == nil then
				arg_70_1.var_.characterEffect10045ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect10045ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10045ui_story then
				arg_70_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_73_4 = 0
			local var_73_5 = 0.6

			if var_73_4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_6 = arg_70_1:FormatText(StoryNameCfg[36].name)

				arg_70_1.leftNameTxt_.text = var_73_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_7 = arg_70_1:GetWordFromCfg(305012016)
				local var_73_8 = arg_70_1:FormatText(var_73_7.content)

				arg_70_1.text_.text = var_73_8

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_9 = 24
				local var_73_10 = utf8.len(var_73_8)
				local var_73_11 = var_73_9 <= 0 and var_73_5 or var_73_5 * (var_73_10 / var_73_9)

				if var_73_11 > 0 and var_73_5 < var_73_11 then
					arg_70_1.talkMaxDuration = var_73_11

					if var_73_11 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_4
					end
				end

				arg_70_1.text_.text = var_73_8
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012016", "story_v_out_305012.awb") ~= 0 then
					local var_73_12 = manager.audio:GetVoiceLength("story_v_out_305012", "305012016", "story_v_out_305012.awb") / 1000

					if var_73_12 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_12 + var_73_4
					end

					if var_73_7.prefab_name ~= "" and arg_70_1.actors_[var_73_7.prefab_name] ~= nil then
						local var_73_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_7.prefab_name].transform, "story_v_out_305012", "305012016", "story_v_out_305012.awb")

						arg_70_1:RecordAudio("305012016", var_73_13)
						arg_70_1:RecordAudio("305012016", var_73_13)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_305012", "305012016", "story_v_out_305012.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_305012", "305012016", "story_v_out_305012.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_5, arg_70_1.talkMaxDuration)

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_4) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_4 + var_73_14 and arg_70_1.time_ < var_73_4 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play305012017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 305012017
		arg_74_1.duration_ = 6.1

		local var_74_0 = {
			zh = 6.1,
			ja = 5.166
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
				arg_74_0:Play305012018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 0.775

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_2 = arg_74_1:FormatText(StoryNameCfg[36].name)

				arg_74_1.leftNameTxt_.text = var_77_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_3 = arg_74_1:GetWordFromCfg(305012017)
				local var_77_4 = arg_74_1:FormatText(var_77_3.content)

				arg_74_1.text_.text = var_77_4

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012017", "story_v_out_305012.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_305012", "305012017", "story_v_out_305012.awb") / 1000

					if var_77_8 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_0
					end

					if var_77_3.prefab_name ~= "" and arg_74_1.actors_[var_77_3.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_3.prefab_name].transform, "story_v_out_305012", "305012017", "story_v_out_305012.awb")

						arg_74_1:RecordAudio("305012017", var_77_9)
						arg_74_1:RecordAudio("305012017", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_305012", "305012017", "story_v_out_305012.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_305012", "305012017", "story_v_out_305012.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_10 and arg_74_1.time_ < var_77_0 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play305012018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 305012018
		arg_78_1.duration_ = 8.63

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play305012019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 2

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				local var_81_1 = manager.ui.mainCamera.transform.localPosition
				local var_81_2 = Vector3.New(0, 0, 10) + Vector3.New(var_81_1.x, var_81_1.y, 0)
				local var_81_3 = arg_78_1.bgs_.B13a

				var_81_3.transform.localPosition = var_81_2
				var_81_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_4 = var_81_3:GetComponent("SpriteRenderer")

				if var_81_4 and var_81_4.sprite then
					local var_81_5 = (var_81_3.transform.localPosition - var_81_1).z
					local var_81_6 = manager.ui.mainCameraCom_
					local var_81_7 = 2 * var_81_5 * Mathf.Tan(var_81_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_81_8 = var_81_7 * var_81_6.aspect
					local var_81_9 = var_81_4.sprite.bounds.size.x
					local var_81_10 = var_81_4.sprite.bounds.size.y
					local var_81_11 = var_81_8 / var_81_9
					local var_81_12 = var_81_7 / var_81_10
					local var_81_13 = var_81_12 < var_81_11 and var_81_11 or var_81_12

					var_81_3.transform.localScale = Vector3.New(var_81_13, var_81_13, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "B13a" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_14 = 0

			if var_81_14 < arg_78_1.time_ and arg_78_1.time_ <= var_81_14 + arg_81_0 then
				arg_78_1.allBtn_.enabled = false
			end

			local var_81_15 = 0.3

			if arg_78_1.time_ >= var_81_14 + var_81_15 and arg_78_1.time_ < var_81_14 + var_81_15 + arg_81_0 then
				arg_78_1.allBtn_.enabled = true
			end

			local var_81_16 = 0

			if var_81_16 < arg_78_1.time_ and arg_78_1.time_ <= var_81_16 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_17 = 2

			if var_81_16 <= arg_78_1.time_ and arg_78_1.time_ < var_81_16 + var_81_17 then
				local var_81_18 = (arg_78_1.time_ - var_81_16) / var_81_17
				local var_81_19 = Color.New(0, 0, 0)

				var_81_19.a = Mathf.Lerp(0, 1, var_81_18)
				arg_78_1.mask_.color = var_81_19
			end

			if arg_78_1.time_ >= var_81_16 + var_81_17 and arg_78_1.time_ < var_81_16 + var_81_17 + arg_81_0 then
				local var_81_20 = Color.New(0, 0, 0)

				var_81_20.a = 1
				arg_78_1.mask_.color = var_81_20
			end

			local var_81_21 = 2

			if var_81_21 < arg_78_1.time_ and arg_78_1.time_ <= var_81_21 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_22 = 2

			if var_81_21 <= arg_78_1.time_ and arg_78_1.time_ < var_81_21 + var_81_22 then
				local var_81_23 = (arg_78_1.time_ - var_81_21) / var_81_22
				local var_81_24 = Color.New(0, 0, 0)

				var_81_24.a = Mathf.Lerp(1, 0, var_81_23)
				arg_78_1.mask_.color = var_81_24
			end

			if arg_78_1.time_ >= var_81_21 + var_81_22 and arg_78_1.time_ < var_81_21 + var_81_22 + arg_81_0 then
				local var_81_25 = Color.New(0, 0, 0)
				local var_81_26 = 0

				arg_78_1.mask_.enabled = false
				var_81_25.a = var_81_26
				arg_78_1.mask_.color = var_81_25
			end

			local var_81_27 = arg_78_1.actors_["10045ui_story"]
			local var_81_28 = 0

			if var_81_28 < arg_78_1.time_ and arg_78_1.time_ <= var_81_28 + arg_81_0 and not isNil(var_81_27) and arg_78_1.var_.characterEffect10045ui_story == nil then
				arg_78_1.var_.characterEffect10045ui_story = var_81_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_29 = 0.200000002980232

			if var_81_28 <= arg_78_1.time_ and arg_78_1.time_ < var_81_28 + var_81_29 and not isNil(var_81_27) then
				local var_81_30 = (arg_78_1.time_ - var_81_28) / var_81_29

				if arg_78_1.var_.characterEffect10045ui_story and not isNil(var_81_27) then
					local var_81_31 = Mathf.Lerp(0, 0.5, var_81_30)

					arg_78_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10045ui_story.fillRatio = var_81_31
				end
			end

			if arg_78_1.time_ >= var_81_28 + var_81_29 and arg_78_1.time_ < var_81_28 + var_81_29 + arg_81_0 and not isNil(var_81_27) and arg_78_1.var_.characterEffect10045ui_story then
				local var_81_32 = 0.5

				arg_78_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10045ui_story.fillRatio = var_81_32
			end

			if arg_78_1.frameCnt_ <= 1 then
				arg_78_1.dialog_:SetActive(false)
			end

			local var_81_33 = 3.63333333333333
			local var_81_34 = 0.125

			if var_81_33 < arg_78_1.time_ and arg_78_1.time_ <= var_81_33 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_35 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_35:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_36 = arg_78_1:FormatText(StoryNameCfg[7].name)

				arg_78_1.leftNameTxt_.text = var_81_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_37 = arg_78_1:GetWordFromCfg(305012018)
				local var_81_38 = arg_78_1:FormatText(var_81_37.content)

				arg_78_1.text_.text = var_81_38

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_39 = 5
				local var_81_40 = utf8.len(var_81_38)
				local var_81_41 = var_81_39 <= 0 and var_81_34 or var_81_34 * (var_81_40 / var_81_39)

				if var_81_41 > 0 and var_81_34 < var_81_41 then
					arg_78_1.talkMaxDuration = var_81_41
					var_81_33 = var_81_33 + 0.3

					if var_81_41 + var_81_33 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_41 + var_81_33
					end
				end

				arg_78_1.text_.text = var_81_38
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_42 = var_81_33 + 0.3
			local var_81_43 = math.max(var_81_34, arg_78_1.talkMaxDuration)

			if var_81_42 <= arg_78_1.time_ and arg_78_1.time_ < var_81_42 + var_81_43 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_42) / var_81_43

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_42 + var_81_43 and arg_78_1.time_ < var_81_42 + var_81_43 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play305012019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 305012019
		arg_84_1.duration_ = 5.13

		local var_84_0 = {
			zh = 5.133,
			ja = 1.999999999999
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
				arg_84_0:Play305012020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = "1037ui_story"

			if arg_84_1.actors_[var_87_0] == nil then
				local var_87_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_87_1) then
					local var_87_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_84_1.stage_.transform)

					var_87_2.name = var_87_0
					var_87_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_84_1.actors_[var_87_0] = var_87_2

					local var_87_3 = var_87_2:GetComponentInChildren(typeof(CharacterEffect))

					var_87_3.enabled = true

					local var_87_4 = GameObjectTools.GetOrAddComponent(var_87_2, typeof(DynamicBoneHelper))

					if var_87_4 then
						var_87_4:EnableDynamicBone(false)
					end

					arg_84_1:ShowWeapon(var_87_3.transform, false)

					arg_84_1.var_[var_87_0 .. "Animator"] = var_87_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_84_1.var_[var_87_0 .. "Animator"].applyRootMotion = true
					arg_84_1.var_[var_87_0 .. "LipSync"] = var_87_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_87_5 = arg_84_1.actors_["1037ui_story"].transform
			local var_87_6 = 0

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.var_.moveOldPos1037ui_story = var_87_5.localPosition
			end

			local var_87_7 = 0.001

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_7 then
				local var_87_8 = (arg_84_1.time_ - var_87_6) / var_87_7
				local var_87_9 = Vector3.New(0, -1.09, -5.81)

				var_87_5.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1037ui_story, var_87_9, var_87_8)

				local var_87_10 = manager.ui.mainCamera.transform.position - var_87_5.position

				var_87_5.forward = Vector3.New(var_87_10.x, var_87_10.y, var_87_10.z)

				local var_87_11 = var_87_5.localEulerAngles

				var_87_11.z = 0
				var_87_11.x = 0
				var_87_5.localEulerAngles = var_87_11
			end

			if arg_84_1.time_ >= var_87_6 + var_87_7 and arg_84_1.time_ < var_87_6 + var_87_7 + arg_87_0 then
				var_87_5.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_87_12 = manager.ui.mainCamera.transform.position - var_87_5.position

				var_87_5.forward = Vector3.New(var_87_12.x, var_87_12.y, var_87_12.z)

				local var_87_13 = var_87_5.localEulerAngles

				var_87_13.z = 0
				var_87_13.x = 0
				var_87_5.localEulerAngles = var_87_13
			end

			local var_87_14 = arg_84_1.actors_["1037ui_story"]
			local var_87_15 = 0

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 and not isNil(var_87_14) and arg_84_1.var_.characterEffect1037ui_story == nil then
				arg_84_1.var_.characterEffect1037ui_story = var_87_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_16 = 0.200000002980232

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_16 and not isNil(var_87_14) then
				local var_87_17 = (arg_84_1.time_ - var_87_15) / var_87_16

				if arg_84_1.var_.characterEffect1037ui_story and not isNil(var_87_14) then
					arg_84_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_15 + var_87_16 and arg_84_1.time_ < var_87_15 + var_87_16 + arg_87_0 and not isNil(var_87_14) and arg_84_1.var_.characterEffect1037ui_story then
				arg_84_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_87_18 = 0

			if var_87_18 < arg_84_1.time_ and arg_84_1.time_ <= var_87_18 + arg_87_0 then
				arg_84_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_87_19 = 0

			if var_87_19 < arg_84_1.time_ and arg_84_1.time_ <= var_87_19 + arg_87_0 then
				arg_84_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_87_20 = 0
			local var_87_21 = 0.525

			if var_87_20 < arg_84_1.time_ and arg_84_1.time_ <= var_87_20 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_22 = arg_84_1:FormatText(StoryNameCfg[15].name)

				arg_84_1.leftNameTxt_.text = var_87_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_23 = arg_84_1:GetWordFromCfg(305012019)
				local var_87_24 = arg_84_1:FormatText(var_87_23.content)

				arg_84_1.text_.text = var_87_24

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_25 = 21
				local var_87_26 = utf8.len(var_87_24)
				local var_87_27 = var_87_25 <= 0 and var_87_21 or var_87_21 * (var_87_26 / var_87_25)

				if var_87_27 > 0 and var_87_21 < var_87_27 then
					arg_84_1.talkMaxDuration = var_87_27

					if var_87_27 + var_87_20 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_27 + var_87_20
					end
				end

				arg_84_1.text_.text = var_87_24
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012019", "story_v_out_305012.awb") ~= 0 then
					local var_87_28 = manager.audio:GetVoiceLength("story_v_out_305012", "305012019", "story_v_out_305012.awb") / 1000

					if var_87_28 + var_87_20 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_28 + var_87_20
					end

					if var_87_23.prefab_name ~= "" and arg_84_1.actors_[var_87_23.prefab_name] ~= nil then
						local var_87_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_23.prefab_name].transform, "story_v_out_305012", "305012019", "story_v_out_305012.awb")

						arg_84_1:RecordAudio("305012019", var_87_29)
						arg_84_1:RecordAudio("305012019", var_87_29)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_305012", "305012019", "story_v_out_305012.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_305012", "305012019", "story_v_out_305012.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_30 = math.max(var_87_21, arg_84_1.talkMaxDuration)

			if var_87_20 <= arg_84_1.time_ and arg_84_1.time_ < var_87_20 + var_87_30 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_20) / var_87_30

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_20 + var_87_30 and arg_84_1.time_ < var_87_20 + var_87_30 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play305012020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 305012020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play305012021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1037ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1037ui_story == nil then
				arg_88_1.var_.characterEffect1037ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.200000002980232

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1037ui_story and not isNil(var_91_0) then
					local var_91_4 = Mathf.Lerp(0, 0.5, var_91_3)

					arg_88_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1037ui_story.fillRatio = var_91_4
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1037ui_story then
				local var_91_5 = 0.5

				arg_88_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1037ui_story.fillRatio = var_91_5
			end

			local var_91_6 = 0
			local var_91_7 = 0.55

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[7].name)

				arg_88_1.leftNameTxt_.text = var_91_8

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

				local var_91_9 = arg_88_1:GetWordFromCfg(305012020)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 22
				local var_91_12 = utf8.len(var_91_10)
				local var_91_13 = var_91_11 <= 0 and var_91_7 or var_91_7 * (var_91_12 / var_91_11)

				if var_91_13 > 0 and var_91_7 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_14 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_14 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_14

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_14 and arg_88_1.time_ < var_91_6 + var_91_14 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play305012021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 305012021
		arg_92_1.duration_ = 8.5

		local var_92_0 = {
			zh = 8.5,
			ja = 1.999999999999
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
				arg_92_0:Play305012022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1037ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1037ui_story == nil then
				arg_92_1.var_.characterEffect1037ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1037ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1037ui_story then
				arg_92_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_95_4 = 0

			if var_95_4 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_95_6 = 0
			local var_95_7 = 1.05

			if var_95_6 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_8 = arg_92_1:FormatText(StoryNameCfg[15].name)

				arg_92_1.leftNameTxt_.text = var_95_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_9 = arg_92_1:GetWordFromCfg(305012021)
				local var_95_10 = arg_92_1:FormatText(var_95_9.content)

				arg_92_1.text_.text = var_95_10

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_11 = 42
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

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012021", "story_v_out_305012.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_305012", "305012021", "story_v_out_305012.awb") / 1000

					if var_95_14 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_6
					end

					if var_95_9.prefab_name ~= "" and arg_92_1.actors_[var_95_9.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_9.prefab_name].transform, "story_v_out_305012", "305012021", "story_v_out_305012.awb")

						arg_92_1:RecordAudio("305012021", var_95_15)
						arg_92_1:RecordAudio("305012021", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_305012", "305012021", "story_v_out_305012.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_305012", "305012021", "story_v_out_305012.awb")
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
	Play305012022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 305012022
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play305012023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1037ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1037ui_story == nil then
				arg_96_1.var_.characterEffect1037ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1037ui_story and not isNil(var_99_0) then
					local var_99_4 = Mathf.Lerp(0, 0.5, var_99_3)

					arg_96_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1037ui_story.fillRatio = var_99_4
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1037ui_story then
				local var_99_5 = 0.5

				arg_96_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1037ui_story.fillRatio = var_99_5
			end

			local var_99_6 = 0
			local var_99_7 = 0.825

			if var_99_6 < arg_96_1.time_ and arg_96_1.time_ <= var_99_6 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_8 = arg_96_1:FormatText(StoryNameCfg[7].name)

				arg_96_1.leftNameTxt_.text = var_99_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_9 = arg_96_1:GetWordFromCfg(305012022)
				local var_99_10 = arg_96_1:FormatText(var_99_9.content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_11 = 33
				local var_99_12 = utf8.len(var_99_10)
				local var_99_13 = var_99_11 <= 0 and var_99_7 or var_99_7 * (var_99_12 / var_99_11)

				if var_99_13 > 0 and var_99_7 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_6 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_6
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_14 = math.max(var_99_7, arg_96_1.talkMaxDuration)

			if var_99_6 <= arg_96_1.time_ and arg_96_1.time_ < var_99_6 + var_99_14 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_6) / var_99_14

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_6 + var_99_14 and arg_96_1.time_ < var_99_6 + var_99_14 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play305012023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 305012023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play305012024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.4

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_2

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

				local var_103_3 = arg_100_1:GetWordFromCfg(305012023)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 16
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_8 and arg_100_1.time_ < var_103_0 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play305012024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 305012024
		arg_104_1.duration_ = 5

		local var_104_0 = {
			zh = 3.766,
			ja = 5
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play305012025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = "1032ui_story"

			if arg_104_1.actors_[var_107_0] == nil then
				local var_107_1 = Asset.Load("Char/" .. "1032ui_story")

				if not isNil(var_107_1) then
					local var_107_2 = Object.Instantiate(Asset.Load("Char/" .. "1032ui_story"), arg_104_1.stage_.transform)

					var_107_2.name = var_107_0
					var_107_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_104_1.actors_[var_107_0] = var_107_2

					local var_107_3 = var_107_2:GetComponentInChildren(typeof(CharacterEffect))

					var_107_3.enabled = true

					local var_107_4 = GameObjectTools.GetOrAddComponent(var_107_2, typeof(DynamicBoneHelper))

					if var_107_4 then
						var_107_4:EnableDynamicBone(false)
					end

					arg_104_1:ShowWeapon(var_107_3.transform, false)

					arg_104_1.var_[var_107_0 .. "Animator"] = var_107_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_104_1.var_[var_107_0 .. "Animator"].applyRootMotion = true
					arg_104_1.var_[var_107_0 .. "LipSync"] = var_107_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_107_5 = arg_104_1.actors_["1032ui_story"].transform
			local var_107_6 = 0

			if var_107_6 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.var_.moveOldPos1032ui_story = var_107_5.localPosition
			end

			local var_107_7 = 0.001

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_7 then
				local var_107_8 = (arg_104_1.time_ - var_107_6) / var_107_7
				local var_107_9 = Vector3.New(0, -1.05, -6.2)

				var_107_5.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1032ui_story, var_107_9, var_107_8)

				local var_107_10 = manager.ui.mainCamera.transform.position - var_107_5.position

				var_107_5.forward = Vector3.New(var_107_10.x, var_107_10.y, var_107_10.z)

				local var_107_11 = var_107_5.localEulerAngles

				var_107_11.z = 0
				var_107_11.x = 0
				var_107_5.localEulerAngles = var_107_11
			end

			if arg_104_1.time_ >= var_107_6 + var_107_7 and arg_104_1.time_ < var_107_6 + var_107_7 + arg_107_0 then
				var_107_5.localPosition = Vector3.New(0, -1.05, -6.2)

				local var_107_12 = manager.ui.mainCamera.transform.position - var_107_5.position

				var_107_5.forward = Vector3.New(var_107_12.x, var_107_12.y, var_107_12.z)

				local var_107_13 = var_107_5.localEulerAngles

				var_107_13.z = 0
				var_107_13.x = 0
				var_107_5.localEulerAngles = var_107_13
			end

			local var_107_14 = arg_104_1.actors_["1037ui_story"].transform
			local var_107_15 = 0

			if var_107_15 < arg_104_1.time_ and arg_104_1.time_ <= var_107_15 + arg_107_0 then
				arg_104_1.var_.moveOldPos1037ui_story = var_107_14.localPosition
			end

			local var_107_16 = 0.001

			if var_107_15 <= arg_104_1.time_ and arg_104_1.time_ < var_107_15 + var_107_16 then
				local var_107_17 = (arg_104_1.time_ - var_107_15) / var_107_16
				local var_107_18 = Vector3.New(0, 100, 0)

				var_107_14.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1037ui_story, var_107_18, var_107_17)

				local var_107_19 = manager.ui.mainCamera.transform.position - var_107_14.position

				var_107_14.forward = Vector3.New(var_107_19.x, var_107_19.y, var_107_19.z)

				local var_107_20 = var_107_14.localEulerAngles

				var_107_20.z = 0
				var_107_20.x = 0
				var_107_14.localEulerAngles = var_107_20
			end

			if arg_104_1.time_ >= var_107_15 + var_107_16 and arg_104_1.time_ < var_107_15 + var_107_16 + arg_107_0 then
				var_107_14.localPosition = Vector3.New(0, 100, 0)

				local var_107_21 = manager.ui.mainCamera.transform.position - var_107_14.position

				var_107_14.forward = Vector3.New(var_107_21.x, var_107_21.y, var_107_21.z)

				local var_107_22 = var_107_14.localEulerAngles

				var_107_22.z = 0
				var_107_22.x = 0
				var_107_14.localEulerAngles = var_107_22
			end

			local var_107_23 = arg_104_1.actors_["1032ui_story"]
			local var_107_24 = 0

			if var_107_24 < arg_104_1.time_ and arg_104_1.time_ <= var_107_24 + arg_107_0 and not isNil(var_107_23) and arg_104_1.var_.characterEffect1032ui_story == nil then
				arg_104_1.var_.characterEffect1032ui_story = var_107_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_25 = 0.200000002980232

			if var_107_24 <= arg_104_1.time_ and arg_104_1.time_ < var_107_24 + var_107_25 and not isNil(var_107_23) then
				local var_107_26 = (arg_104_1.time_ - var_107_24) / var_107_25

				if arg_104_1.var_.characterEffect1032ui_story and not isNil(var_107_23) then
					arg_104_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_24 + var_107_25 and arg_104_1.time_ < var_107_24 + var_107_25 + arg_107_0 and not isNil(var_107_23) and arg_104_1.var_.characterEffect1032ui_story then
				arg_104_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			local var_107_27 = 0

			if var_107_27 < arg_104_1.time_ and arg_104_1.time_ <= var_107_27 + arg_107_0 then
				arg_104_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action4_1")
			end

			local var_107_28 = 0

			if var_107_28 < arg_104_1.time_ and arg_104_1.time_ <= var_107_28 + arg_107_0 then
				arg_104_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_107_29 = 0
			local var_107_30 = 0.325

			if var_107_29 < arg_104_1.time_ and arg_104_1.time_ <= var_107_29 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_31 = arg_104_1:FormatText(StoryNameCfg[61].name)

				arg_104_1.leftNameTxt_.text = var_107_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_32 = arg_104_1:GetWordFromCfg(305012024)
				local var_107_33 = arg_104_1:FormatText(var_107_32.content)

				arg_104_1.text_.text = var_107_33

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_34 = 13
				local var_107_35 = utf8.len(var_107_33)
				local var_107_36 = var_107_34 <= 0 and var_107_30 or var_107_30 * (var_107_35 / var_107_34)

				if var_107_36 > 0 and var_107_30 < var_107_36 then
					arg_104_1.talkMaxDuration = var_107_36

					if var_107_36 + var_107_29 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_36 + var_107_29
					end
				end

				arg_104_1.text_.text = var_107_33
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012024", "story_v_out_305012.awb") ~= 0 then
					local var_107_37 = manager.audio:GetVoiceLength("story_v_out_305012", "305012024", "story_v_out_305012.awb") / 1000

					if var_107_37 + var_107_29 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_37 + var_107_29
					end

					if var_107_32.prefab_name ~= "" and arg_104_1.actors_[var_107_32.prefab_name] ~= nil then
						local var_107_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_32.prefab_name].transform, "story_v_out_305012", "305012024", "story_v_out_305012.awb")

						arg_104_1:RecordAudio("305012024", var_107_38)
						arg_104_1:RecordAudio("305012024", var_107_38)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_305012", "305012024", "story_v_out_305012.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_305012", "305012024", "story_v_out_305012.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_39 = math.max(var_107_30, arg_104_1.talkMaxDuration)

			if var_107_29 <= arg_104_1.time_ and arg_104_1.time_ < var_107_29 + var_107_39 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_29) / var_107_39

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_29 + var_107_39 and arg_104_1.time_ < var_107_29 + var_107_39 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
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

		arg_104_1:InitPlayNodeList()
	end,
	Play305012025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 305012025
		arg_108_1.duration_ = 9.27

		local var_108_0 = {
			zh = 6.066,
			ja = 9.266
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
				arg_108_0:Play305012026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.75

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[61].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:GetWordFromCfg(305012025)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012025", "story_v_out_305012.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_305012", "305012025", "story_v_out_305012.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_305012", "305012025", "story_v_out_305012.awb")

						arg_108_1:RecordAudio("305012025", var_111_9)
						arg_108_1:RecordAudio("305012025", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_305012", "305012025", "story_v_out_305012.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_305012", "305012025", "story_v_out_305012.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_10 and arg_108_1.time_ < var_111_0 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play305012026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 305012026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play305012027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1032ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1032ui_story == nil then
				arg_112_1.var_.characterEffect1032ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1032ui_story and not isNil(var_115_0) then
					local var_115_4 = Mathf.Lerp(0, 0.5, var_115_3)

					arg_112_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1032ui_story.fillRatio = var_115_4
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1032ui_story then
				local var_115_5 = 0.5

				arg_112_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1032ui_story.fillRatio = var_115_5
			end

			local var_115_6 = 0
			local var_115_7 = 0.225

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_8 = arg_112_1:FormatText(StoryNameCfg[7].name)

				arg_112_1.leftNameTxt_.text = var_115_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_9 = arg_112_1:GetWordFromCfg(305012026)
				local var_115_10 = arg_112_1:FormatText(var_115_9.content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_11 = 9
				local var_115_12 = utf8.len(var_115_10)
				local var_115_13 = var_115_11 <= 0 and var_115_7 or var_115_7 * (var_115_12 / var_115_11)

				if var_115_13 > 0 and var_115_7 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_10
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_14 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_14 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_14

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_14 and arg_112_1.time_ < var_115_6 + var_115_14 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play305012027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 305012027
		arg_116_1.duration_ = 5.37

		local var_116_0 = {
			zh = 4.1,
			ja = 5.366
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
				arg_116_0:Play305012028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1032ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1032ui_story == nil then
				arg_116_1.var_.characterEffect1032ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect1032ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect1032ui_story then
				arg_116_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			local var_119_4 = 0

			if var_119_4 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032actionlink/1032action446")
			end

			local var_119_5 = 0
			local var_119_6 = 0.375

			if var_119_5 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_7 = arg_116_1:FormatText(StoryNameCfg[61].name)

				arg_116_1.leftNameTxt_.text = var_119_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_8 = arg_116_1:GetWordFromCfg(305012027)
				local var_119_9 = arg_116_1:FormatText(var_119_8.content)

				arg_116_1.text_.text = var_119_9

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_10 = 15
				local var_119_11 = utf8.len(var_119_9)
				local var_119_12 = var_119_10 <= 0 and var_119_6 or var_119_6 * (var_119_11 / var_119_10)

				if var_119_12 > 0 and var_119_6 < var_119_12 then
					arg_116_1.talkMaxDuration = var_119_12

					if var_119_12 + var_119_5 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_12 + var_119_5
					end
				end

				arg_116_1.text_.text = var_119_9
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012027", "story_v_out_305012.awb") ~= 0 then
					local var_119_13 = manager.audio:GetVoiceLength("story_v_out_305012", "305012027", "story_v_out_305012.awb") / 1000

					if var_119_13 + var_119_5 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_5
					end

					if var_119_8.prefab_name ~= "" and arg_116_1.actors_[var_119_8.prefab_name] ~= nil then
						local var_119_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_8.prefab_name].transform, "story_v_out_305012", "305012027", "story_v_out_305012.awb")

						arg_116_1:RecordAudio("305012027", var_119_14)
						arg_116_1:RecordAudio("305012027", var_119_14)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_305012", "305012027", "story_v_out_305012.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_305012", "305012027", "story_v_out_305012.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_15 = math.max(var_119_6, arg_116_1.talkMaxDuration)

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_15 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_5) / var_119_15

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_5 + var_119_15 and arg_116_1.time_ < var_119_5 + var_119_15 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play305012028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 305012028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play305012029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1032ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1032ui_story == nil then
				arg_120_1.var_.characterEffect1032ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1032ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1032ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1032ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1032ui_story.fillRatio = var_123_5
			end

			local var_123_6 = 0
			local var_123_7 = 0.25

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

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_9 = arg_120_1:GetWordFromCfg(305012028)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 10
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
	Play305012029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 305012029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play305012030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1032ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1032ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(0, 100, 0)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1032ui_story, var_127_4, var_127_3)

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

			local var_127_9 = 0
			local var_127_10 = 0.8

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_11 = arg_124_1:GetWordFromCfg(305012029)
				local var_127_12 = arg_124_1:FormatText(var_127_11.content)

				arg_124_1.text_.text = var_127_12

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_13 = 32
				local var_127_14 = utf8.len(var_127_12)
				local var_127_15 = var_127_13 <= 0 and var_127_10 or var_127_10 * (var_127_14 / var_127_13)

				if var_127_15 > 0 and var_127_10 < var_127_15 then
					arg_124_1.talkMaxDuration = var_127_15

					if var_127_15 + var_127_9 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_15 + var_127_9
					end
				end

				arg_124_1.text_.text = var_127_12
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_10, arg_124_1.talkMaxDuration)

			if var_127_9 <= arg_124_1.time_ and arg_124_1.time_ < var_127_9 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_9) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_9 + var_127_16 and arg_124_1.time_ < var_127_9 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
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
	Play305012030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 305012030
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play305012031(arg_128_1)
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

				local var_131_2 = arg_128_1:FormatText(StoryNameCfg[7].name)

				arg_128_1.leftNameTxt_.text = var_131_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_3 = arg_128_1:GetWordFromCfg(305012030)
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
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_8 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_8 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_8

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_8 and arg_128_1.time_ < var_131_0 + var_131_8 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play305012031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 305012031
		arg_132_1.duration_ = 9.2

		local var_132_0 = {
			zh = 4.866,
			ja = 9.2
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
				arg_132_0:Play305012032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1033ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos1033ui_story = var_135_0.localPosition
			end

			local var_135_2 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(0, -1.01, -6.13)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1033ui_story, var_135_4, var_135_3)

				local var_135_5 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_5.x, var_135_5.y, var_135_5.z)

				local var_135_6 = var_135_0.localEulerAngles

				var_135_6.z = 0
				var_135_6.x = 0
				var_135_0.localEulerAngles = var_135_6
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0, -1.01, -6.13)

				local var_135_7 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_7.x, var_135_7.y, var_135_7.z)

				local var_135_8 = var_135_0.localEulerAngles

				var_135_8.z = 0
				var_135_8.x = 0
				var_135_0.localEulerAngles = var_135_8
			end

			local var_135_9 = arg_132_1.actors_["1032ui_story"].transform
			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 then
				arg_132_1.var_.moveOldPos1032ui_story = var_135_9.localPosition
			end

			local var_135_11 = 0.001

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_11 then
				local var_135_12 = (arg_132_1.time_ - var_135_10) / var_135_11
				local var_135_13 = Vector3.New(0, 100, 0)

				var_135_9.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1032ui_story, var_135_13, var_135_12)

				local var_135_14 = manager.ui.mainCamera.transform.position - var_135_9.position

				var_135_9.forward = Vector3.New(var_135_14.x, var_135_14.y, var_135_14.z)

				local var_135_15 = var_135_9.localEulerAngles

				var_135_15.z = 0
				var_135_15.x = 0
				var_135_9.localEulerAngles = var_135_15
			end

			if arg_132_1.time_ >= var_135_10 + var_135_11 and arg_132_1.time_ < var_135_10 + var_135_11 + arg_135_0 then
				var_135_9.localPosition = Vector3.New(0, 100, 0)

				local var_135_16 = manager.ui.mainCamera.transform.position - var_135_9.position

				var_135_9.forward = Vector3.New(var_135_16.x, var_135_16.y, var_135_16.z)

				local var_135_17 = var_135_9.localEulerAngles

				var_135_17.z = 0
				var_135_17.x = 0
				var_135_9.localEulerAngles = var_135_17
			end

			local var_135_18 = arg_132_1.actors_["1033ui_story"]
			local var_135_19 = 0

			if var_135_19 < arg_132_1.time_ and arg_132_1.time_ <= var_135_19 + arg_135_0 and not isNil(var_135_18) and arg_132_1.var_.characterEffect1033ui_story == nil then
				arg_132_1.var_.characterEffect1033ui_story = var_135_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_20 = 0.200000002980232

			if var_135_19 <= arg_132_1.time_ and arg_132_1.time_ < var_135_19 + var_135_20 and not isNil(var_135_18) then
				local var_135_21 = (arg_132_1.time_ - var_135_19) / var_135_20

				if arg_132_1.var_.characterEffect1033ui_story and not isNil(var_135_18) then
					arg_132_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_19 + var_135_20 and arg_132_1.time_ < var_135_19 + var_135_20 + arg_135_0 and not isNil(var_135_18) and arg_132_1.var_.characterEffect1033ui_story then
				arg_132_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_135_22 = 0

			if var_135_22 < arg_132_1.time_ and arg_132_1.time_ <= var_135_22 + arg_135_0 then
				arg_132_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			local var_135_23 = 0

			if var_135_23 < arg_132_1.time_ and arg_132_1.time_ <= var_135_23 + arg_135_0 then
				arg_132_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_135_24 = 0
			local var_135_25 = 0.625

			if var_135_24 < arg_132_1.time_ and arg_132_1.time_ <= var_135_24 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_26 = arg_132_1:FormatText(StoryNameCfg[236].name)

				arg_132_1.leftNameTxt_.text = var_135_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_27 = arg_132_1:GetWordFromCfg(305012031)
				local var_135_28 = arg_132_1:FormatText(var_135_27.content)

				arg_132_1.text_.text = var_135_28

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_29 = 25
				local var_135_30 = utf8.len(var_135_28)
				local var_135_31 = var_135_29 <= 0 and var_135_25 or var_135_25 * (var_135_30 / var_135_29)

				if var_135_31 > 0 and var_135_25 < var_135_31 then
					arg_132_1.talkMaxDuration = var_135_31

					if var_135_31 + var_135_24 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_31 + var_135_24
					end
				end

				arg_132_1.text_.text = var_135_28
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012031", "story_v_out_305012.awb") ~= 0 then
					local var_135_32 = manager.audio:GetVoiceLength("story_v_out_305012", "305012031", "story_v_out_305012.awb") / 1000

					if var_135_32 + var_135_24 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_32 + var_135_24
					end

					if var_135_27.prefab_name ~= "" and arg_132_1.actors_[var_135_27.prefab_name] ~= nil then
						local var_135_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_27.prefab_name].transform, "story_v_out_305012", "305012031", "story_v_out_305012.awb")

						arg_132_1:RecordAudio("305012031", var_135_33)
						arg_132_1:RecordAudio("305012031", var_135_33)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_305012", "305012031", "story_v_out_305012.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_305012", "305012031", "story_v_out_305012.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_34 = math.max(var_135_25, arg_132_1.talkMaxDuration)

			if var_135_24 <= arg_132_1.time_ and arg_132_1.time_ < var_135_24 + var_135_34 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_24) / var_135_34

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_24 + var_135_34 and arg_132_1.time_ < var_135_24 + var_135_34 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1032ui_story",
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
	Play305012032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 305012032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play305012033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1033ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1033ui_story == nil then
				arg_136_1.var_.characterEffect1033ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1033ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1033ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1033ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1033ui_story.fillRatio = var_139_5
			end

			local var_139_6 = 0
			local var_139_7 = 0.2

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_8 = arg_136_1:FormatText(StoryNameCfg[7].name)

				arg_136_1.leftNameTxt_.text = var_139_8

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

				local var_139_9 = arg_136_1:GetWordFromCfg(305012032)
				local var_139_10 = arg_136_1:FormatText(var_139_9.content)

				arg_136_1.text_.text = var_139_10

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 8
				local var_139_12 = utf8.len(var_139_10)
				local var_139_13 = var_139_11 <= 0 and var_139_7 or var_139_7 * (var_139_12 / var_139_11)

				if var_139_13 > 0 and var_139_7 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_10
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_14 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_14 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_14

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_14 and arg_136_1.time_ < var_139_6 + var_139_14 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play305012033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 305012033
		arg_140_1.duration_ = 6.4

		local var_140_0 = {
			zh = 6.4,
			ja = 1.333
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
				arg_140_0:Play305012034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1037ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1037ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(0, -1.09, -5.81)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1037ui_story, var_143_4, var_143_3)

				local var_143_5 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_5.x, var_143_5.y, var_143_5.z)

				local var_143_6 = var_143_0.localEulerAngles

				var_143_6.z = 0
				var_143_6.x = 0
				var_143_0.localEulerAngles = var_143_6
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_143_7 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_7.x, var_143_7.y, var_143_7.z)

				local var_143_8 = var_143_0.localEulerAngles

				var_143_8.z = 0
				var_143_8.x = 0
				var_143_0.localEulerAngles = var_143_8
			end

			local var_143_9 = arg_140_1.actors_["1033ui_story"].transform
			local var_143_10 = 0

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 then
				arg_140_1.var_.moveOldPos1033ui_story = var_143_9.localPosition
			end

			local var_143_11 = 0.001

			if var_143_10 <= arg_140_1.time_ and arg_140_1.time_ < var_143_10 + var_143_11 then
				local var_143_12 = (arg_140_1.time_ - var_143_10) / var_143_11
				local var_143_13 = Vector3.New(0, 100, 0)

				var_143_9.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1033ui_story, var_143_13, var_143_12)

				local var_143_14 = manager.ui.mainCamera.transform.position - var_143_9.position

				var_143_9.forward = Vector3.New(var_143_14.x, var_143_14.y, var_143_14.z)

				local var_143_15 = var_143_9.localEulerAngles

				var_143_15.z = 0
				var_143_15.x = 0
				var_143_9.localEulerAngles = var_143_15
			end

			if arg_140_1.time_ >= var_143_10 + var_143_11 and arg_140_1.time_ < var_143_10 + var_143_11 + arg_143_0 then
				var_143_9.localPosition = Vector3.New(0, 100, 0)

				local var_143_16 = manager.ui.mainCamera.transform.position - var_143_9.position

				var_143_9.forward = Vector3.New(var_143_16.x, var_143_16.y, var_143_16.z)

				local var_143_17 = var_143_9.localEulerAngles

				var_143_17.z = 0
				var_143_17.x = 0
				var_143_9.localEulerAngles = var_143_17
			end

			local var_143_18 = arg_140_1.actors_["1037ui_story"]
			local var_143_19 = 0

			if var_143_19 < arg_140_1.time_ and arg_140_1.time_ <= var_143_19 + arg_143_0 and not isNil(var_143_18) and arg_140_1.var_.characterEffect1037ui_story == nil then
				arg_140_1.var_.characterEffect1037ui_story = var_143_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_20 = 0.200000002980232

			if var_143_19 <= arg_140_1.time_ and arg_140_1.time_ < var_143_19 + var_143_20 and not isNil(var_143_18) then
				local var_143_21 = (arg_140_1.time_ - var_143_19) / var_143_20

				if arg_140_1.var_.characterEffect1037ui_story and not isNil(var_143_18) then
					arg_140_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_19 + var_143_20 and arg_140_1.time_ < var_143_19 + var_143_20 + arg_143_0 and not isNil(var_143_18) and arg_140_1.var_.characterEffect1037ui_story then
				arg_140_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_143_22 = 0

			if var_143_22 < arg_140_1.time_ and arg_140_1.time_ <= var_143_22 + arg_143_0 then
				arg_140_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_143_23 = 0

			if var_143_23 < arg_140_1.time_ and arg_140_1.time_ <= var_143_23 + arg_143_0 then
				arg_140_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_143_24 = 0
			local var_143_25 = 0.775

			if var_143_24 < arg_140_1.time_ and arg_140_1.time_ <= var_143_24 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_26 = arg_140_1:FormatText(StoryNameCfg[15].name)

				arg_140_1.leftNameTxt_.text = var_143_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_27 = arg_140_1:GetWordFromCfg(305012033)
				local var_143_28 = arg_140_1:FormatText(var_143_27.content)

				arg_140_1.text_.text = var_143_28

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_29 = 30
				local var_143_30 = utf8.len(var_143_28)
				local var_143_31 = var_143_29 <= 0 and var_143_25 or var_143_25 * (var_143_30 / var_143_29)

				if var_143_31 > 0 and var_143_25 < var_143_31 then
					arg_140_1.talkMaxDuration = var_143_31

					if var_143_31 + var_143_24 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_31 + var_143_24
					end
				end

				arg_140_1.text_.text = var_143_28
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012033", "story_v_out_305012.awb") ~= 0 then
					local var_143_32 = manager.audio:GetVoiceLength("story_v_out_305012", "305012033", "story_v_out_305012.awb") / 1000

					if var_143_32 + var_143_24 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_32 + var_143_24
					end

					if var_143_27.prefab_name ~= "" and arg_140_1.actors_[var_143_27.prefab_name] ~= nil then
						local var_143_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_27.prefab_name].transform, "story_v_out_305012", "305012033", "story_v_out_305012.awb")

						arg_140_1:RecordAudio("305012033", var_143_33)
						arg_140_1:RecordAudio("305012033", var_143_33)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_305012", "305012033", "story_v_out_305012.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_305012", "305012033", "story_v_out_305012.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_34 = math.max(var_143_25, arg_140_1.talkMaxDuration)

			if var_143_24 <= arg_140_1.time_ and arg_140_1.time_ < var_143_24 + var_143_34 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_24) / var_143_34

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_24 + var_143_34 and arg_140_1.time_ < var_143_24 + var_143_34 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
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
	Play305012034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 305012034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play305012035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1037ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1037ui_story == nil then
				arg_144_1.var_.characterEffect1037ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1037ui_story and not isNil(var_147_0) then
					local var_147_4 = Mathf.Lerp(0, 0.5, var_147_3)

					arg_144_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1037ui_story.fillRatio = var_147_4
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1037ui_story then
				local var_147_5 = 0.5

				arg_144_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1037ui_story.fillRatio = var_147_5
			end

			local var_147_6 = 0
			local var_147_7 = 0.475

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_8 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_8

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

				local var_147_9 = arg_144_1:GetWordFromCfg(305012034)
				local var_147_10 = arg_144_1:FormatText(var_147_9.content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 19
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
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = math.max(var_147_7, arg_144_1.talkMaxDuration)

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_14 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_14

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_14 and arg_144_1.time_ < var_147_6 + var_147_14 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play305012035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 305012035
		arg_148_1.duration_ = 5.8

		local var_148_0 = {
			zh = 5.8,
			ja = 1.999999999999
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
				arg_148_0:Play305012036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1037ui_story"]
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1037ui_story == nil then
				arg_148_1.var_.characterEffect1037ui_story = var_151_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 and not isNil(var_151_0) then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2

				if arg_148_1.var_.characterEffect1037ui_story and not isNil(var_151_0) then
					arg_148_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 and not isNil(var_151_0) and arg_148_1.var_.characterEffect1037ui_story then
				arg_148_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_151_4 = 0

			if var_151_4 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			local var_151_5 = 0

			if var_151_5 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_151_6 = 0
			local var_151_7 = 0.675

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_8 = arg_148_1:FormatText(StoryNameCfg[15].name)

				arg_148_1.leftNameTxt_.text = var_151_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_9 = arg_148_1:GetWordFromCfg(305012035)
				local var_151_10 = arg_148_1:FormatText(var_151_9.content)

				arg_148_1.text_.text = var_151_10

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_11 = 26
				local var_151_12 = utf8.len(var_151_10)
				local var_151_13 = var_151_11 <= 0 and var_151_7 or var_151_7 * (var_151_12 / var_151_11)

				if var_151_13 > 0 and var_151_7 < var_151_13 then
					arg_148_1.talkMaxDuration = var_151_13

					if var_151_13 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_13 + var_151_6
					end
				end

				arg_148_1.text_.text = var_151_10
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012035", "story_v_out_305012.awb") ~= 0 then
					local var_151_14 = manager.audio:GetVoiceLength("story_v_out_305012", "305012035", "story_v_out_305012.awb") / 1000

					if var_151_14 + var_151_6 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_14 + var_151_6
					end

					if var_151_9.prefab_name ~= "" and arg_148_1.actors_[var_151_9.prefab_name] ~= nil then
						local var_151_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_9.prefab_name].transform, "story_v_out_305012", "305012035", "story_v_out_305012.awb")

						arg_148_1:RecordAudio("305012035", var_151_15)
						arg_148_1:RecordAudio("305012035", var_151_15)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_305012", "305012035", "story_v_out_305012.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_305012", "305012035", "story_v_out_305012.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_7, arg_148_1.talkMaxDuration)

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_6) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_6 + var_151_16 and arg_148_1.time_ < var_151_6 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play305012036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 305012036
		arg_152_1.duration_ = 5.2

		local var_152_0 = {
			zh = 5.2,
			ja = 1.999999999999
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
				arg_152_0:Play305012037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action445")
			end

			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_155_2 = 0
			local var_155_3 = 0.7

			if var_155_2 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_4 = arg_152_1:FormatText(StoryNameCfg[15].name)

				arg_152_1.leftNameTxt_.text = var_155_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_5 = arg_152_1:GetWordFromCfg(305012036)
				local var_155_6 = arg_152_1:FormatText(var_155_5.content)

				arg_152_1.text_.text = var_155_6

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_7 = 28
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

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012036", "story_v_out_305012.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_305012", "305012036", "story_v_out_305012.awb") / 1000

					if var_155_10 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_2
					end

					if var_155_5.prefab_name ~= "" and arg_152_1.actors_[var_155_5.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_5.prefab_name].transform, "story_v_out_305012", "305012036", "story_v_out_305012.awb")

						arg_152_1:RecordAudio("305012036", var_155_11)
						arg_152_1:RecordAudio("305012036", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_305012", "305012036", "story_v_out_305012.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_305012", "305012036", "story_v_out_305012.awb")
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
	Play305012037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 305012037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
			arg_156_1.auto_ = false
		end

		function arg_156_1.playNext_(arg_158_0)
			arg_156_1.onStoryFinished_()
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1037ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1037ui_story == nil then
				arg_156_1.var_.characterEffect1037ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect1037ui_story and not isNil(var_159_0) then
					local var_159_4 = Mathf.Lerp(0, 0.5, var_159_3)

					arg_156_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1037ui_story.fillRatio = var_159_4
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect1037ui_story then
				local var_159_5 = 0.5

				arg_156_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1037ui_story.fillRatio = var_159_5
			end

			local var_159_6 = 0
			local var_159_7 = 0.125

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

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_9 = arg_156_1:GetWordFromCfg(305012037)
				local var_159_10 = arg_156_1:FormatText(var_159_9.content)

				arg_156_1.text_.text = var_159_10

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 5
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
	assets = {
		"TextureConfig/Background/S0408",
		"TextureConfig/Background/S0408a",
		"TextureConfig/Background/B13a",
		"TextureConfig/Background/S0405"
	},
	voices = {
		"story_v_out_305012.awb"
	}
}
