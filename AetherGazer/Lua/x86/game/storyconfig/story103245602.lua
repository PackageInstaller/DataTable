return {
	Play324562001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324562001
		arg_1_1.duration_ = 6.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324562002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J21f"

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
				local var_4_5 = arg_1_1.bgs_.J21f

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
					if iter_4_0 ~= "J21f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2.03299999982119

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

			local var_4_19 = 0.733333333333333

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(1, 1, 1)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(1, 1, 1)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = manager.ui.mainCamera.transform
			local var_4_25 = 0.333333333333333

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = arg_1_1.var_.effecteqew
				local var_4_27
				local var_4_28 = var_4_24

				if not var_4_26 then
					var_4_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_out"), var_4_28)
					var_4_26.name = "eqew"
					arg_1_1.var_.effecteqew = var_4_26
				else
					var_4_26.transform:SetParent(var_4_28)
				end

				var_4_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_29 = 0

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_30 = 2

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_31 = 0.1
			local var_4_32 = 1

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				local var_4_33 = "play"
				local var_4_34 = "effect"

				arg_1_1:AudioAction(var_4_33, var_4_34, "se_story_148", "se_story_148_amb_wind", "")
			end

			local var_4_35 = 0
			local var_4_36 = 1

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				local var_4_37 = "play"
				local var_4_38 = "effect"

				arg_1_1:AudioAction(var_4_37, var_4_38, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_39 = 1
			local var_4_40 = 1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_41 = "play"
				local var_4_42 = "music"

				arg_1_1:AudioAction(var_4_41, var_4_42, "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_4_43 = ""
				local var_4_44 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

				if var_4_44 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_44 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_44

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_44
						arg_1_1.bgmTxt2_.text = var_4_44
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

			local var_4_45 = 0.1
			local var_4_46 = 1.93299999982119

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "effect"

				arg_1_1:AudioAction(var_4_47, var_4_48, "se_story_145", "se_story_145_fire01", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_49 = 1.9
			local var_4_50 = 1.35

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

				local var_4_52 = arg_1_1:GetWordFromCfg(324562001)
				local var_4_53 = arg_1_1:FormatText(var_4_52.content)

				arg_1_1.text_.text = var_4_53

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_54 = 54
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
	Play324562002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324562002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324562003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 0.975

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

				local var_11_2 = arg_8_1:GetWordFromCfg(324562002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 39
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
	Play324562003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324562003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324562004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.3
			local var_15_1 = 1

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				local var_15_2 = "play"
				local var_15_3 = "effect"

				arg_12_1:AudioAction(var_15_2, var_15_3, "se_story_150", "se_story_150_amb_cheer_loop", "")
			end

			local var_15_4 = 0
			local var_15_5 = 1.3

			if var_15_4 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_6 = arg_12_1:GetWordFromCfg(324562003)
				local var_15_7 = arg_12_1:FormatText(var_15_6.content)

				arg_12_1.text_.text = var_15_7

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_8 = 52
				local var_15_9 = utf8.len(var_15_7)
				local var_15_10 = var_15_8 <= 0 and var_15_5 or var_15_5 * (var_15_9 / var_15_8)

				if var_15_10 > 0 and var_15_5 < var_15_10 then
					arg_12_1.talkMaxDuration = var_15_10

					if var_15_10 + var_15_4 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_10 + var_15_4
					end
				end

				arg_12_1.text_.text = var_15_7
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_11 = math.max(var_15_5, arg_12_1.talkMaxDuration)

			if var_15_4 <= arg_12_1.time_ and arg_12_1.time_ < var_15_4 + var_15_11 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_4) / var_15_11

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_4 + var_15_11 and arg_12_1.time_ < var_15_4 + var_15_11 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324562004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324562004
		arg_16_1.duration_ = 3.17

		local var_16_0 = {
			zh = 2.2,
			ja = 3.166
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
				arg_16_0:Play324562005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 0.125

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_2 = arg_16_1:FormatText(StoryNameCfg[1504].name)

				arg_16_1.leftNameTxt_.text = var_19_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_3 = arg_16_1:GetWordFromCfg(324562004)
				local var_19_4 = arg_16_1:FormatText(var_19_3.content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562004", "story_v_out_324562.awb") ~= 0 then
					local var_19_8 = manager.audio:GetVoiceLength("story_v_out_324562", "324562004", "story_v_out_324562.awb") / 1000

					if var_19_8 + var_19_0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_0
					end

					if var_19_3.prefab_name ~= "" and arg_16_1.actors_[var_19_3.prefab_name] ~= nil then
						local var_19_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_3.prefab_name].transform, "story_v_out_324562", "324562004", "story_v_out_324562.awb")

						arg_16_1:RecordAudio("324562004", var_19_9)
						arg_16_1:RecordAudio("324562004", var_19_9)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_324562", "324562004", "story_v_out_324562.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_324562", "324562004", "story_v_out_324562.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_10 = math.max(var_19_1, arg_16_1.talkMaxDuration)

			if var_19_0 <= arg_16_1.time_ and arg_16_1.time_ < var_19_0 + var_19_10 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_0) / var_19_10

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_0 + var_19_10 and arg_16_1.time_ < var_19_0 + var_19_10 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play324562005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324562005
		arg_20_1.duration_ = 3.73

		local var_20_0 = {
			zh = 3.733,
			ja = 3.233
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
				arg_20_0:Play324562006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.325

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[1505].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(324562005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 13
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562005", "story_v_out_324562.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_324562", "324562005", "story_v_out_324562.awb") / 1000

					if var_23_8 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_0
					end

					if var_23_3.prefab_name ~= "" and arg_20_1.actors_[var_23_3.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_3.prefab_name].transform, "story_v_out_324562", "324562005", "story_v_out_324562.awb")

						arg_20_1:RecordAudio("324562005", var_23_9)
						arg_20_1:RecordAudio("324562005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324562", "324562005", "story_v_out_324562.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324562", "324562005", "story_v_out_324562.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_10 and arg_20_1.time_ < var_23_0 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324562006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324562006
		arg_24_1.duration_ = 3.13

		local var_24_0 = {
			zh = 3.066,
			ja = 3.133
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324562007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.25

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[1506].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(324562006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562006", "story_v_out_324562.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_324562", "324562006", "story_v_out_324562.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_324562", "324562006", "story_v_out_324562.awb")

						arg_24_1:RecordAudio("324562006", var_27_9)
						arg_24_1:RecordAudio("324562006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_324562", "324562006", "story_v_out_324562.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_324562", "324562006", "story_v_out_324562.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324562007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324562007
		arg_28_1.duration_ = 4.7

		local var_28_0 = {
			zh = 4.7,
			ja = 4.3
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
				arg_28_0:Play324562008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = manager.ui.mainCamera.transform
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.var_.shakeOldPos = var_31_0.localPosition
			end

			local var_31_2 = 0.6

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / 0.066
				local var_31_4, var_31_5 = math.modf(var_31_3)

				var_31_0.localPosition = Vector3.New(var_31_5 * 0.13, var_31_5 * 0.13, var_31_5 * 0.13) + arg_28_1.var_.shakeOldPos
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 then
				var_31_0.localPosition = arg_28_1.var_.shakeOldPos
			end

			local var_31_6 = manager.ui.mainCamera.transform
			local var_31_7 = 0.766666666666667

			if var_31_7 < arg_28_1.time_ and arg_28_1.time_ <= var_31_7 + arg_31_0 then
				arg_28_1.var_.shakeOldPos = var_31_6.localPosition
			end

			local var_31_8 = 0.6

			if var_31_7 <= arg_28_1.time_ and arg_28_1.time_ < var_31_7 + var_31_8 then
				local var_31_9 = (arg_28_1.time_ - var_31_7) / 0.066
				local var_31_10, var_31_11 = math.modf(var_31_9)

				var_31_6.localPosition = Vector3.New(var_31_11 * 0.13, var_31_11 * 0.13, var_31_11 * 0.13) + arg_28_1.var_.shakeOldPos
			end

			if arg_28_1.time_ >= var_31_7 + var_31_8 and arg_28_1.time_ < var_31_7 + var_31_8 + arg_31_0 then
				var_31_6.localPosition = arg_28_1.var_.shakeOldPos
			end

			local var_31_12 = 0

			if var_31_12 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			local var_31_13 = 1.5

			if arg_28_1.time_ >= var_31_12 + var_31_13 and arg_28_1.time_ < var_31_12 + var_31_13 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			local var_31_14 = 0.1
			local var_31_15 = 1

			if var_31_14 < arg_28_1.time_ and arg_28_1.time_ <= var_31_14 + arg_31_0 then
				local var_31_16 = "play"
				local var_31_17 = "effect"

				arg_28_1:AudioAction(var_31_16, var_31_17, "se_story_150", "se_story_150_amb_cheer_loop_down", "")
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_18 = 1
			local var_31_19 = 0.4

			if var_31_18 < arg_28_1.time_ and arg_28_1.time_ <= var_31_18 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_20 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_20:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_28_1.dialogCg_.alpha = arg_32_0
				end))
				var_31_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_21 = arg_28_1:GetWordFromCfg(324562007)
				local var_31_22 = arg_28_1:FormatText(var_31_21.content)

				arg_28_1.text_.text = var_31_22

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_23 = 16
				local var_31_24 = utf8.len(var_31_22)
				local var_31_25 = var_31_23 <= 0 and var_31_19 or var_31_19 * (var_31_24 / var_31_23)

				if var_31_25 > 0 and var_31_19 < var_31_25 then
					arg_28_1.talkMaxDuration = var_31_25
					var_31_18 = var_31_18 + 0.3

					if var_31_25 + var_31_18 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_25 + var_31_18
					end
				end

				arg_28_1.text_.text = var_31_22
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562007", "story_v_out_324562.awb") ~= 0 then
					local var_31_26 = manager.audio:GetVoiceLength("story_v_out_324562", "324562007", "story_v_out_324562.awb") / 1000

					if var_31_26 + var_31_18 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_26 + var_31_18
					end

					if var_31_21.prefab_name ~= "" and arg_28_1.actors_[var_31_21.prefab_name] ~= nil then
						local var_31_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_21.prefab_name].transform, "story_v_out_324562", "324562007", "story_v_out_324562.awb")

						arg_28_1:RecordAudio("324562007", var_31_27)
						arg_28_1:RecordAudio("324562007", var_31_27)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324562", "324562007", "story_v_out_324562.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324562", "324562007", "story_v_out_324562.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_28 = var_31_18 + 0.3
			local var_31_29 = math.max(var_31_19, arg_28_1.talkMaxDuration)

			if var_31_28 <= arg_28_1.time_ and arg_28_1.time_ < var_31_28 + var_31_29 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_28) / var_31_29

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_28 + var_31_29 and arg_28_1.time_ < var_31_28 + var_31_29 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324562008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 324562008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play324562009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0
			local var_37_1 = 1.75

			if var_37_0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_2 = arg_34_1:GetWordFromCfg(324562008)
				local var_37_3 = arg_34_1:FormatText(var_37_2.content)

				arg_34_1.text_.text = var_37_3

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_4 = 70
				local var_37_5 = utf8.len(var_37_3)
				local var_37_6 = var_37_4 <= 0 and var_37_1 or var_37_1 * (var_37_5 / var_37_4)

				if var_37_6 > 0 and var_37_1 < var_37_6 then
					arg_34_1.talkMaxDuration = var_37_6

					if var_37_6 + var_37_0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_6 + var_37_0
					end
				end

				arg_34_1.text_.text = var_37_3
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_7 = math.max(var_37_1, arg_34_1.talkMaxDuration)

			if var_37_0 <= arg_34_1.time_ and arg_34_1.time_ < var_37_0 + var_37_7 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_0) / var_37_7

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_0 + var_37_7 and arg_34_1.time_ < var_37_0 + var_37_7 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play324562009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 324562009
		arg_38_1.duration_ = 5.3

		local var_38_0 = {
			zh = 5.3,
			ja = 4.6
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play324562010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = "1170ui_story"

			if arg_38_1.actors_[var_41_0] == nil then
				local var_41_1 = Asset.Load("Char/" .. "1170ui_story")

				if not isNil(var_41_1) then
					local var_41_2 = Object.Instantiate(Asset.Load("Char/" .. "1170ui_story"), arg_38_1.stage_.transform)

					var_41_2.name = var_41_0
					var_41_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_38_1.actors_[var_41_0] = var_41_2

					local var_41_3 = var_41_2:GetComponentInChildren(typeof(CharacterEffect))

					var_41_3.enabled = true

					local var_41_4 = GameObjectTools.GetOrAddComponent(var_41_2, typeof(DynamicBoneHelper))

					if var_41_4 then
						var_41_4:EnableDynamicBone(false)
					end

					arg_38_1:ShowWeapon(var_41_3.transform, false)

					arg_38_1.var_[var_41_0 .. "Animator"] = var_41_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_38_1.var_[var_41_0 .. "Animator"].applyRootMotion = true
					arg_38_1.var_[var_41_0 .. "LipSync"] = var_41_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_41_5 = arg_38_1.actors_["1170ui_story"].transform
			local var_41_6 = 0

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.var_.moveOldPos1170ui_story = var_41_5.localPosition

				local var_41_7 = GameObjectTools.GetOrAddComponent(var_41_5.gameObject, typeof(DynamicBoneHelper))

				if var_41_7 then
					var_41_7:EnableDynamicBone(false)
				end
			end

			local var_41_8 = 0.001

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_8 then
				local var_41_9 = (arg_38_1.time_ - var_41_6) / var_41_8
				local var_41_10 = Vector3.New(0.03, -0.95, -6.08)

				var_41_5.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1170ui_story, var_41_10, var_41_9)

				local var_41_11 = manager.ui.mainCamera.transform.position - var_41_5.position

				var_41_5.forward = Vector3.New(var_41_11.x, var_41_11.y, var_41_11.z)

				local var_41_12 = var_41_5.localEulerAngles

				var_41_12.z = 0
				var_41_12.x = 0
				var_41_5.localEulerAngles = var_41_12
			end

			if arg_38_1.time_ >= var_41_6 + var_41_8 and arg_38_1.time_ < var_41_6 + var_41_8 + arg_41_0 then
				var_41_5.localPosition = Vector3.New(0.03, -0.95, -6.08)

				local var_41_13 = manager.ui.mainCamera.transform.position - var_41_5.position

				var_41_5.forward = Vector3.New(var_41_13.x, var_41_13.y, var_41_13.z)

				local var_41_14 = var_41_5.localEulerAngles

				var_41_14.z = 0
				var_41_14.x = 0
				var_41_5.localEulerAngles = var_41_14

				local var_41_15 = GameObjectTools.GetOrAddComponent(var_41_5.gameObject, typeof(DynamicBoneHelper))

				if var_41_15 then
					var_41_15:EnableDynamicBone(true)
				end
			end

			local var_41_16 = arg_38_1.actors_["1170ui_story"]
			local var_41_17 = 0

			if var_41_17 < arg_38_1.time_ and arg_38_1.time_ <= var_41_17 + arg_41_0 and not isNil(var_41_16) and arg_38_1.var_.characterEffect1170ui_story == nil then
				arg_38_1.var_.characterEffect1170ui_story = var_41_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_18 = 0.200000002980232

			if var_41_17 <= arg_38_1.time_ and arg_38_1.time_ < var_41_17 + var_41_18 and not isNil(var_41_16) then
				local var_41_19 = (arg_38_1.time_ - var_41_17) / var_41_18

				if arg_38_1.var_.characterEffect1170ui_story and not isNil(var_41_16) then
					arg_38_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_17 + var_41_18 and arg_38_1.time_ < var_41_17 + var_41_18 + arg_41_0 and not isNil(var_41_16) and arg_38_1.var_.characterEffect1170ui_story then
				arg_38_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_41_20 = 0

			if var_41_20 < arg_38_1.time_ and arg_38_1.time_ <= var_41_20 + arg_41_0 then
				arg_38_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_1")
			end

			local var_41_21 = 0

			if var_41_21 < arg_38_1.time_ and arg_38_1.time_ <= var_41_21 + arg_41_0 then
				arg_38_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_41_22 = 0
			local var_41_23 = 0.375

			if var_41_22 < arg_38_1.time_ and arg_38_1.time_ <= var_41_22 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_24 = arg_38_1:FormatText(StoryNameCfg[318].name)

				arg_38_1.leftNameTxt_.text = var_41_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_25 = arg_38_1:GetWordFromCfg(324562009)
				local var_41_26 = arg_38_1:FormatText(var_41_25.content)

				arg_38_1.text_.text = var_41_26

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_27 = 15
				local var_41_28 = utf8.len(var_41_26)
				local var_41_29 = var_41_27 <= 0 and var_41_23 or var_41_23 * (var_41_28 / var_41_27)

				if var_41_29 > 0 and var_41_23 < var_41_29 then
					arg_38_1.talkMaxDuration = var_41_29

					if var_41_29 + var_41_22 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_29 + var_41_22
					end
				end

				arg_38_1.text_.text = var_41_26
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562009", "story_v_out_324562.awb") ~= 0 then
					local var_41_30 = manager.audio:GetVoiceLength("story_v_out_324562", "324562009", "story_v_out_324562.awb") / 1000

					if var_41_30 + var_41_22 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_30 + var_41_22
					end

					if var_41_25.prefab_name ~= "" and arg_38_1.actors_[var_41_25.prefab_name] ~= nil then
						local var_41_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_25.prefab_name].transform, "story_v_out_324562", "324562009", "story_v_out_324562.awb")

						arg_38_1:RecordAudio("324562009", var_41_31)
						arg_38_1:RecordAudio("324562009", var_41_31)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_324562", "324562009", "story_v_out_324562.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_324562", "324562009", "story_v_out_324562.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_32 = math.max(var_41_23, arg_38_1.talkMaxDuration)

			if var_41_22 <= arg_38_1.time_ and arg_38_1.time_ < var_41_22 + var_41_32 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_22) / var_41_32

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_22 + var_41_32 and arg_38_1.time_ < var_41_22 + var_41_32 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play324562010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 324562010
		arg_42_1.duration_ = 3.5

		local var_42_0 = {
			zh = 2.4,
			ja = 3.5
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
				arg_42_0:Play324562011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = "6148ui_story"

			if arg_42_1.actors_[var_45_0] == nil then
				local var_45_1 = Asset.Load("Char/" .. "6148ui_story")

				if not isNil(var_45_1) then
					local var_45_2 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_42_1.stage_.transform)

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

			local var_45_5 = arg_42_1.actors_["6148ui_story"]
			local var_45_6 = 0

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect6148ui_story == nil then
				arg_42_1.var_.characterEffect6148ui_story = var_45_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_7 = 0.200000002980232

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_7 and not isNil(var_45_5) then
				local var_45_8 = (arg_42_1.time_ - var_45_6) / var_45_7

				if arg_42_1.var_.characterEffect6148ui_story and not isNil(var_45_5) then
					arg_42_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_6 + var_45_7 and arg_42_1.time_ < var_45_6 + var_45_7 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect6148ui_story then
				arg_42_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_45_9 = arg_42_1.actors_["1170ui_story"]
			local var_45_10 = 0

			if var_45_10 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 and not isNil(var_45_9) and arg_42_1.var_.characterEffect1170ui_story == nil then
				arg_42_1.var_.characterEffect1170ui_story = var_45_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_11 = 0.200000002980232

			if var_45_10 <= arg_42_1.time_ and arg_42_1.time_ < var_45_10 + var_45_11 and not isNil(var_45_9) then
				local var_45_12 = (arg_42_1.time_ - var_45_10) / var_45_11

				if arg_42_1.var_.characterEffect1170ui_story and not isNil(var_45_9) then
					local var_45_13 = Mathf.Lerp(0, 0.5, var_45_12)

					arg_42_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1170ui_story.fillRatio = var_45_13
				end
			end

			if arg_42_1.time_ >= var_45_10 + var_45_11 and arg_42_1.time_ < var_45_10 + var_45_11 + arg_45_0 and not isNil(var_45_9) and arg_42_1.var_.characterEffect1170ui_story then
				local var_45_14 = 0.5

				arg_42_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1170ui_story.fillRatio = var_45_14
			end

			local var_45_15 = 0
			local var_45_16 = 0.25

			if var_45_15 < arg_42_1.time_ and arg_42_1.time_ <= var_45_15 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_17 = arg_42_1:FormatText(StoryNameCfg[1488].name)

				arg_42_1.leftNameTxt_.text = var_45_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_18 = arg_42_1:GetWordFromCfg(324562010)
				local var_45_19 = arg_42_1:FormatText(var_45_18.content)

				arg_42_1.text_.text = var_45_19

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_20 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562010", "story_v_out_324562.awb") ~= 0 then
					local var_45_23 = manager.audio:GetVoiceLength("story_v_out_324562", "324562010", "story_v_out_324562.awb") / 1000

					if var_45_23 + var_45_15 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_23 + var_45_15
					end

					if var_45_18.prefab_name ~= "" and arg_42_1.actors_[var_45_18.prefab_name] ~= nil then
						local var_45_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_18.prefab_name].transform, "story_v_out_324562", "324562010", "story_v_out_324562.awb")

						arg_42_1:RecordAudio("324562010", var_45_24)
						arg_42_1:RecordAudio("324562010", var_45_24)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_324562", "324562010", "story_v_out_324562.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_324562", "324562010", "story_v_out_324562.awb")
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

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play324562011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 324562011
		arg_46_1.duration_ = 2.1

		local var_46_0 = {
			zh = 1.999999999999,
			ja = 2.1
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
				arg_46_0:Play324562012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1170ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1170ui_story == nil then
				arg_46_1.var_.characterEffect1170ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.200000002980232

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect1170ui_story and not isNil(var_49_0) then
					arg_46_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1170ui_story then
				arg_46_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_49_4 = arg_46_1.actors_["6148ui_story"]
			local var_49_5 = 0

			if var_49_5 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 and not isNil(var_49_4) and arg_46_1.var_.characterEffect6148ui_story == nil then
				arg_46_1.var_.characterEffect6148ui_story = var_49_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_6 = 0.200000002980232

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_6 and not isNil(var_49_4) then
				local var_49_7 = (arg_46_1.time_ - var_49_5) / var_49_6

				if arg_46_1.var_.characterEffect6148ui_story and not isNil(var_49_4) then
					local var_49_8 = Mathf.Lerp(0, 0.5, var_49_7)

					arg_46_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_46_1.var_.characterEffect6148ui_story.fillRatio = var_49_8
				end
			end

			if arg_46_1.time_ >= var_49_5 + var_49_6 and arg_46_1.time_ < var_49_5 + var_49_6 + arg_49_0 and not isNil(var_49_4) and arg_46_1.var_.characterEffect6148ui_story then
				local var_49_9 = 0.5

				arg_46_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_46_1.var_.characterEffect6148ui_story.fillRatio = var_49_9
			end

			local var_49_10 = 0

			if var_49_10 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 then
				arg_46_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action3_2")
			end

			local var_49_11 = 0

			if var_49_11 < arg_46_1.time_ and arg_46_1.time_ <= var_49_11 + arg_49_0 then
				arg_46_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_49_12 = 0
			local var_49_13 = 0.175

			if var_49_12 < arg_46_1.time_ and arg_46_1.time_ <= var_49_12 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_14 = arg_46_1:FormatText(StoryNameCfg[318].name)

				arg_46_1.leftNameTxt_.text = var_49_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_15 = arg_46_1:GetWordFromCfg(324562011)
				local var_49_16 = arg_46_1:FormatText(var_49_15.content)

				arg_46_1.text_.text = var_49_16

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_17 = 7
				local var_49_18 = utf8.len(var_49_16)
				local var_49_19 = var_49_17 <= 0 and var_49_13 or var_49_13 * (var_49_18 / var_49_17)

				if var_49_19 > 0 and var_49_13 < var_49_19 then
					arg_46_1.talkMaxDuration = var_49_19

					if var_49_19 + var_49_12 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_19 + var_49_12
					end
				end

				arg_46_1.text_.text = var_49_16
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562011", "story_v_out_324562.awb") ~= 0 then
					local var_49_20 = manager.audio:GetVoiceLength("story_v_out_324562", "324562011", "story_v_out_324562.awb") / 1000

					if var_49_20 + var_49_12 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_20 + var_49_12
					end

					if var_49_15.prefab_name ~= "" and arg_46_1.actors_[var_49_15.prefab_name] ~= nil then
						local var_49_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_15.prefab_name].transform, "story_v_out_324562", "324562011", "story_v_out_324562.awb")

						arg_46_1:RecordAudio("324562011", var_49_21)
						arg_46_1:RecordAudio("324562011", var_49_21)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_324562", "324562011", "story_v_out_324562.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_324562", "324562011", "story_v_out_324562.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_22 = math.max(var_49_13, arg_46_1.talkMaxDuration)

			if var_49_12 <= arg_46_1.time_ and arg_46_1.time_ < var_49_12 + var_49_22 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_12) / var_49_22

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_12 + var_49_22 and arg_46_1.time_ < var_49_12 + var_49_22 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play324562012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 324562012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play324562013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1170ui_story"].transform
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.var_.moveOldPos1170ui_story = var_53_0.localPosition

				local var_53_2 = GameObjectTools.GetOrAddComponent(var_53_0.gameObject, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(false)
				end
			end

			local var_53_3 = 0.001

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_3 then
				local var_53_4 = (arg_50_1.time_ - var_53_1) / var_53_3
				local var_53_5 = Vector3.New(0, 100, 0)

				var_53_0.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1170ui_story, var_53_5, var_53_4)

				local var_53_6 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_6.x, var_53_6.y, var_53_6.z)

				local var_53_7 = var_53_0.localEulerAngles

				var_53_7.z = 0
				var_53_7.x = 0
				var_53_0.localEulerAngles = var_53_7
			end

			if arg_50_1.time_ >= var_53_1 + var_53_3 and arg_50_1.time_ < var_53_1 + var_53_3 + arg_53_0 then
				var_53_0.localPosition = Vector3.New(0, 100, 0)

				local var_53_8 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_8.x, var_53_8.y, var_53_8.z)

				local var_53_9 = var_53_0.localEulerAngles

				var_53_9.z = 0
				var_53_9.x = 0
				var_53_0.localEulerAngles = var_53_9

				local var_53_10 = GameObjectTools.GetOrAddComponent(var_53_0.gameObject, typeof(DynamicBoneHelper))

				if var_53_10 then
					var_53_10:EnableDynamicBone(true)
				end
			end

			local var_53_11 = arg_50_1.actors_["1170ui_story"]
			local var_53_12 = 0

			if var_53_12 < arg_50_1.time_ and arg_50_1.time_ <= var_53_12 + arg_53_0 and not isNil(var_53_11) and arg_50_1.var_.characterEffect1170ui_story == nil then
				arg_50_1.var_.characterEffect1170ui_story = var_53_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_13 = 0.200000002980232

			if var_53_12 <= arg_50_1.time_ and arg_50_1.time_ < var_53_12 + var_53_13 and not isNil(var_53_11) then
				local var_53_14 = (arg_50_1.time_ - var_53_12) / var_53_13

				if arg_50_1.var_.characterEffect1170ui_story and not isNil(var_53_11) then
					local var_53_15 = Mathf.Lerp(0, 0.5, var_53_14)

					arg_50_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1170ui_story.fillRatio = var_53_15
				end
			end

			if arg_50_1.time_ >= var_53_12 + var_53_13 and arg_50_1.time_ < var_53_12 + var_53_13 + arg_53_0 and not isNil(var_53_11) and arg_50_1.var_.characterEffect1170ui_story then
				local var_53_16 = 0.5

				arg_50_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1170ui_story.fillRatio = var_53_16
			end

			local var_53_17 = 0
			local var_53_18 = 1.425

			if var_53_17 < arg_50_1.time_ and arg_50_1.time_ <= var_53_17 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_19 = arg_50_1:GetWordFromCfg(324562012)
				local var_53_20 = arg_50_1:FormatText(var_53_19.content)

				arg_50_1.text_.text = var_53_20

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_21 = 57
				local var_53_22 = utf8.len(var_53_20)
				local var_53_23 = var_53_21 <= 0 and var_53_18 or var_53_18 * (var_53_22 / var_53_21)

				if var_53_23 > 0 and var_53_18 < var_53_23 then
					arg_50_1.talkMaxDuration = var_53_23

					if var_53_23 + var_53_17 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_23 + var_53_17
					end
				end

				arg_50_1.text_.text = var_53_20
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_24 = math.max(var_53_18, arg_50_1.talkMaxDuration)

			if var_53_17 <= arg_50_1.time_ and arg_50_1.time_ < var_53_17 + var_53_24 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_17) / var_53_24

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_17 + var_53_24 and arg_50_1.time_ < var_53_17 + var_53_24 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play324562013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 324562013
		arg_54_1.duration_ = 2

		local var_54_0 = {
			zh = 2,
			ja = 1.833
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
				arg_54_0:Play324562014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1170ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1170ui_story == nil then
				arg_54_1.var_.characterEffect1170ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1170ui_story and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1170ui_story then
				arg_54_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_57_4 = 0
			local var_57_5 = 1

			if var_57_4 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				local var_57_6 = "play"
				local var_57_7 = "effect"

				arg_54_1:AudioAction(var_57_6, var_57_7, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_57_8 = 0
			local var_57_9 = 0.15

			if var_57_8 < arg_54_1.time_ and arg_54_1.time_ <= var_57_8 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_10 = arg_54_1:FormatText(StoryNameCfg[318].name)

				arg_54_1.leftNameTxt_.text = var_57_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1170")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_11 = arg_54_1:GetWordFromCfg(324562013)
				local var_57_12 = arg_54_1:FormatText(var_57_11.content)

				arg_54_1.text_.text = var_57_12

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_13 = 6
				local var_57_14 = utf8.len(var_57_12)
				local var_57_15 = var_57_13 <= 0 and var_57_9 or var_57_9 * (var_57_14 / var_57_13)

				if var_57_15 > 0 and var_57_9 < var_57_15 then
					arg_54_1.talkMaxDuration = var_57_15

					if var_57_15 + var_57_8 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_15 + var_57_8
					end
				end

				arg_54_1.text_.text = var_57_12
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562013", "story_v_out_324562.awb") ~= 0 then
					local var_57_16 = manager.audio:GetVoiceLength("story_v_out_324562", "324562013", "story_v_out_324562.awb") / 1000

					if var_57_16 + var_57_8 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_16 + var_57_8
					end

					if var_57_11.prefab_name ~= "" and arg_54_1.actors_[var_57_11.prefab_name] ~= nil then
						local var_57_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_11.prefab_name].transform, "story_v_out_324562", "324562013", "story_v_out_324562.awb")

						arg_54_1:RecordAudio("324562013", var_57_17)
						arg_54_1:RecordAudio("324562013", var_57_17)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_324562", "324562013", "story_v_out_324562.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_324562", "324562013", "story_v_out_324562.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_18 = math.max(var_57_9, arg_54_1.talkMaxDuration)

			if var_57_8 <= arg_54_1.time_ and arg_54_1.time_ < var_57_8 + var_57_18 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_8) / var_57_18

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_8 + var_57_18 and arg_54_1.time_ < var_57_8 + var_57_18 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play324562014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324562014
		arg_58_1.duration_ = 9

		local var_58_0 = {
			zh = 6.733,
			ja = 9
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play324562015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = "ST32"

			if arg_58_1.bgs_[var_61_0] == nil then
				local var_61_1 = Object.Instantiate(arg_58_1.paintGo_)

				var_61_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_61_0)
				var_61_1.name = var_61_0
				var_61_1.transform.parent = arg_58_1.stage_.transform
				var_61_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_58_1.bgs_[var_61_0] = var_61_1
			end

			local var_61_2 = 2

			if var_61_2 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 then
				local var_61_3 = manager.ui.mainCamera.transform.localPosition
				local var_61_4 = Vector3.New(0, 0, 10) + Vector3.New(var_61_3.x, var_61_3.y, 0)
				local var_61_5 = arg_58_1.bgs_.ST32

				var_61_5.transform.localPosition = var_61_4
				var_61_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_61_6 = var_61_5:GetComponent("SpriteRenderer")

				if var_61_6 and var_61_6.sprite then
					local var_61_7 = (var_61_5.transform.localPosition - var_61_3).z
					local var_61_8 = manager.ui.mainCameraCom_
					local var_61_9 = 2 * var_61_7 * Mathf.Tan(var_61_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_61_10 = var_61_9 * var_61_8.aspect
					local var_61_11 = var_61_6.sprite.bounds.size.x
					local var_61_12 = var_61_6.sprite.bounds.size.y
					local var_61_13 = var_61_10 / var_61_11
					local var_61_14 = var_61_9 / var_61_12
					local var_61_15 = var_61_14 < var_61_13 and var_61_13 or var_61_14

					var_61_5.transform.localScale = Vector3.New(var_61_15, var_61_15, 0)
				end

				for iter_61_0, iter_61_1 in pairs(arg_58_1.bgs_) do
					if iter_61_0 ~= "ST32" then
						iter_61_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_61_16 = 4

			if var_61_16 < arg_58_1.time_ and arg_58_1.time_ <= var_61_16 + arg_61_0 then
				arg_58_1.allBtn_.enabled = false
			end

			local var_61_17 = 0.3

			if arg_58_1.time_ >= var_61_16 + var_61_17 and arg_58_1.time_ < var_61_16 + var_61_17 + arg_61_0 then
				arg_58_1.allBtn_.enabled = true
			end

			local var_61_18 = 0

			if var_61_18 < arg_58_1.time_ and arg_58_1.time_ <= var_61_18 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_19 = 2

			if var_61_18 <= arg_58_1.time_ and arg_58_1.time_ < var_61_18 + var_61_19 then
				local var_61_20 = (arg_58_1.time_ - var_61_18) / var_61_19
				local var_61_21 = Color.New(0, 0, 0)

				var_61_21.a = Mathf.Lerp(0, 1, var_61_20)
				arg_58_1.mask_.color = var_61_21
			end

			if arg_58_1.time_ >= var_61_18 + var_61_19 and arg_58_1.time_ < var_61_18 + var_61_19 + arg_61_0 then
				local var_61_22 = Color.New(0, 0, 0)

				var_61_22.a = 1
				arg_58_1.mask_.color = var_61_22
			end

			local var_61_23 = 2

			if var_61_23 < arg_58_1.time_ and arg_58_1.time_ <= var_61_23 + arg_61_0 then
				arg_58_1.mask_.enabled = true
				arg_58_1.mask_.raycastTarget = true

				arg_58_1:SetGaussion(false)
			end

			local var_61_24 = 2

			if var_61_23 <= arg_58_1.time_ and arg_58_1.time_ < var_61_23 + var_61_24 then
				local var_61_25 = (arg_58_1.time_ - var_61_23) / var_61_24
				local var_61_26 = Color.New(0, 0, 0)

				var_61_26.a = Mathf.Lerp(1, 0, var_61_25)
				arg_58_1.mask_.color = var_61_26
			end

			if arg_58_1.time_ >= var_61_23 + var_61_24 and arg_58_1.time_ < var_61_23 + var_61_24 + arg_61_0 then
				local var_61_27 = Color.New(0, 0, 0)
				local var_61_28 = 0

				arg_58_1.mask_.enabled = false
				var_61_27.a = var_61_28
				arg_58_1.mask_.color = var_61_27
			end

			local var_61_29 = "10164ui_story"

			if arg_58_1.actors_[var_61_29] == nil then
				local var_61_30 = Asset.Load("Char/" .. "10164ui_story")

				if not isNil(var_61_30) then
					local var_61_31 = Object.Instantiate(Asset.Load("Char/" .. "10164ui_story"), arg_58_1.stage_.transform)

					var_61_31.name = var_61_29
					var_61_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_58_1.actors_[var_61_29] = var_61_31

					local var_61_32 = var_61_31:GetComponentInChildren(typeof(CharacterEffect))

					var_61_32.enabled = true

					local var_61_33 = GameObjectTools.GetOrAddComponent(var_61_31, typeof(DynamicBoneHelper))

					if var_61_33 then
						var_61_33:EnableDynamicBone(false)
					end

					arg_58_1:ShowWeapon(var_61_32.transform, false)

					arg_58_1.var_[var_61_29 .. "Animator"] = var_61_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_58_1.var_[var_61_29 .. "Animator"].applyRootMotion = true
					arg_58_1.var_[var_61_29 .. "LipSync"] = var_61_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_61_34 = arg_58_1.actors_["10164ui_story"].transform
			local var_61_35 = 3.8

			if var_61_35 < arg_58_1.time_ and arg_58_1.time_ <= var_61_35 + arg_61_0 then
				arg_58_1.var_.moveOldPos10164ui_story = var_61_34.localPosition

				local var_61_36 = GameObjectTools.GetOrAddComponent(var_61_34.gameObject, typeof(DynamicBoneHelper))

				if var_61_36 then
					var_61_36:EnableDynamicBone(false)
				end
			end

			local var_61_37 = 0.001

			if var_61_35 <= arg_58_1.time_ and arg_58_1.time_ < var_61_35 + var_61_37 then
				local var_61_38 = (arg_58_1.time_ - var_61_35) / var_61_37
				local var_61_39 = Vector3.New(0, -1.08, -5.83)

				var_61_34.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10164ui_story, var_61_39, var_61_38)

				local var_61_40 = manager.ui.mainCamera.transform.position - var_61_34.position

				var_61_34.forward = Vector3.New(var_61_40.x, var_61_40.y, var_61_40.z)

				local var_61_41 = var_61_34.localEulerAngles

				var_61_41.z = 0
				var_61_41.x = 0
				var_61_34.localEulerAngles = var_61_41
			end

			if arg_58_1.time_ >= var_61_35 + var_61_37 and arg_58_1.time_ < var_61_35 + var_61_37 + arg_61_0 then
				var_61_34.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_61_42 = manager.ui.mainCamera.transform.position - var_61_34.position

				var_61_34.forward = Vector3.New(var_61_42.x, var_61_42.y, var_61_42.z)

				local var_61_43 = var_61_34.localEulerAngles

				var_61_43.z = 0
				var_61_43.x = 0
				var_61_34.localEulerAngles = var_61_43

				local var_61_44 = GameObjectTools.GetOrAddComponent(var_61_34.gameObject, typeof(DynamicBoneHelper))

				if var_61_44 then
					var_61_44:EnableDynamicBone(true)
				end
			end

			local var_61_45 = arg_58_1.actors_["10164ui_story"]
			local var_61_46 = 3.8

			if var_61_46 < arg_58_1.time_ and arg_58_1.time_ <= var_61_46 + arg_61_0 and not isNil(var_61_45) and arg_58_1.var_.characterEffect10164ui_story == nil then
				arg_58_1.var_.characterEffect10164ui_story = var_61_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_47 = 0.200000002980232

			if var_61_46 <= arg_58_1.time_ and arg_58_1.time_ < var_61_46 + var_61_47 and not isNil(var_61_45) then
				local var_61_48 = (arg_58_1.time_ - var_61_46) / var_61_47

				if arg_58_1.var_.characterEffect10164ui_story and not isNil(var_61_45) then
					arg_58_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_46 + var_61_47 and arg_58_1.time_ < var_61_46 + var_61_47 + arg_61_0 and not isNil(var_61_45) and arg_58_1.var_.characterEffect10164ui_story then
				arg_58_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_61_49 = 3.8

			if var_61_49 < arg_58_1.time_ and arg_58_1.time_ <= var_61_49 + arg_61_0 then
				arg_58_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			local var_61_50 = 3.8

			if var_61_50 < arg_58_1.time_ and arg_58_1.time_ <= var_61_50 + arg_61_0 then
				arg_58_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_61_51 = 1.2
			local var_61_52 = 1

			if var_61_51 < arg_58_1.time_ and arg_58_1.time_ <= var_61_51 + arg_61_0 then
				local var_61_53 = "play"
				local var_61_54 = "effect"

				arg_58_1:AudioAction(var_61_53, var_61_54, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_61_55 = 0.1
			local var_61_56 = 1

			if var_61_55 < arg_58_1.time_ and arg_58_1.time_ <= var_61_55 + arg_61_0 then
				local var_61_57 = "stop"
				local var_61_58 = "effect"

				arg_58_1:AudioAction(var_61_57, var_61_58, "se_story_148", "se_story_148_amb_wind", "")
			end

			local var_61_59 = 0.1
			local var_61_60 = 1

			if var_61_59 < arg_58_1.time_ and arg_58_1.time_ <= var_61_59 + arg_61_0 then
				local var_61_61 = "stop"
				local var_61_62 = "effect"

				arg_58_1:AudioAction(var_61_61, var_61_62, "se_story_150", "se_story_150_amb_cheer_loop", "")
			end

			local var_61_63 = 0
			local var_61_64 = 1

			if var_61_63 < arg_58_1.time_ and arg_58_1.time_ <= var_61_63 + arg_61_0 then
				local var_61_65 = "play"
				local var_61_66 = "music"

				arg_58_1:AudioAction(var_61_65, var_61_66, "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_61_67 = ""
				local var_61_68 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if var_61_68 ~= "" then
					if arg_58_1.bgmTxt_.text ~= var_61_68 and arg_58_1.bgmTxt_.text ~= "" then
						if arg_58_1.bgmTxt2_.text ~= "" then
							arg_58_1.bgmTxt_.text = arg_58_1.bgmTxt2_.text
						end

						arg_58_1.bgmTxt2_.text = var_61_68

						arg_58_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_58_1.bgmTxt_.text = var_61_68
						arg_58_1.bgmTxt2_.text = var_61_68
					end

					if arg_58_1.bgmTimer then
						arg_58_1.bgmTimer:Stop()

						arg_58_1.bgmTimer = nil
					end

					if arg_58_1.settingData.show_music_name == 1 then
						arg_58_1.musicController:SetSelectedState("show")
						arg_58_1.musicAnimator_:Play("open", 0, 0)

						if arg_58_1.settingData.music_time ~= 0 then
							arg_58_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_58_1.settingData.music_time), function()
								if arg_58_1 == nil or isNil(arg_58_1.bgmTxt_) then
									return
								end

								arg_58_1.musicController:SetSelectedState("hide")
								arg_58_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_58_1.frameCnt_ <= 1 then
				arg_58_1.dialog_:SetActive(false)
			end

			local var_61_69 = 4
			local var_61_70 = 0.325

			if var_61_69 < arg_58_1.time_ and arg_58_1.time_ <= var_61_69 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0

				arg_58_1.dialog_:SetActive(true)

				arg_58_1.dialogCg_.alpha = 0

				local var_61_71 = LeanTween.value(arg_58_1.dialog_, 0, 1, 0.3)

				var_61_71:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_58_1.dialogCg_.alpha = arg_63_0
				end))
				var_61_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_58_1.dialog_)
					var_61_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_58_1.duration_ = arg_58_1.duration_ + 0.3

				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_72 = arg_58_1:FormatText(StoryNameCfg[1462].name)

				arg_58_1.leftNameTxt_.text = var_61_72

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_73 = arg_58_1:GetWordFromCfg(324562014)
				local var_61_74 = arg_58_1:FormatText(var_61_73.content)

				arg_58_1.text_.text = var_61_74

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_75 = 13
				local var_61_76 = utf8.len(var_61_74)
				local var_61_77 = var_61_75 <= 0 and var_61_70 or var_61_70 * (var_61_76 / var_61_75)

				if var_61_77 > 0 and var_61_70 < var_61_77 then
					arg_58_1.talkMaxDuration = var_61_77
					var_61_69 = var_61_69 + 0.3

					if var_61_77 + var_61_69 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_77 + var_61_69
					end
				end

				arg_58_1.text_.text = var_61_74
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562014", "story_v_out_324562.awb") ~= 0 then
					local var_61_78 = manager.audio:GetVoiceLength("story_v_out_324562", "324562014", "story_v_out_324562.awb") / 1000

					if var_61_78 + var_61_69 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_78 + var_61_69
					end

					if var_61_73.prefab_name ~= "" and arg_58_1.actors_[var_61_73.prefab_name] ~= nil then
						local var_61_79 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_73.prefab_name].transform, "story_v_out_324562", "324562014", "story_v_out_324562.awb")

						arg_58_1:RecordAudio("324562014", var_61_79)
						arg_58_1:RecordAudio("324562014", var_61_79)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_324562", "324562014", "story_v_out_324562.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_324562", "324562014", "story_v_out_324562.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_80 = var_61_69 + 0.3
			local var_61_81 = math.max(var_61_70, arg_58_1.talkMaxDuration)

			if var_61_80 <= arg_58_1.time_ and arg_58_1.time_ < var_61_80 + var_61_81 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_80) / var_61_81

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_80 + var_61_81 and arg_58_1.time_ < var_61_80 + var_61_81 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play324562015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 324562015
		arg_65_1.duration_ = 2.4

		local var_65_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play324562016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = "1071ui_story"

			if arg_65_1.actors_[var_68_0] == nil then
				local var_68_1 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_68_1) then
					local var_68_2 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_65_1.stage_.transform)

					var_68_2.name = var_68_0
					var_68_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_65_1.actors_[var_68_0] = var_68_2

					local var_68_3 = var_68_2:GetComponentInChildren(typeof(CharacterEffect))

					var_68_3.enabled = true

					local var_68_4 = GameObjectTools.GetOrAddComponent(var_68_2, typeof(DynamicBoneHelper))

					if var_68_4 then
						var_68_4:EnableDynamicBone(false)
					end

					arg_65_1:ShowWeapon(var_68_3.transform, false)

					arg_65_1.var_[var_68_0 .. "Animator"] = var_68_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_65_1.var_[var_68_0 .. "Animator"].applyRootMotion = true
					arg_65_1.var_[var_68_0 .. "LipSync"] = var_68_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_68_5 = arg_65_1.actors_["1071ui_story"].transform
			local var_68_6 = 0

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.var_.moveOldPos1071ui_story = var_68_5.localPosition
			end

			local var_68_7 = 0.001

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_7 then
				local var_68_8 = (arg_65_1.time_ - var_68_6) / var_68_7
				local var_68_9 = Vector3.New(0.7, -1.05, -6.2)

				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1071ui_story, var_68_9, var_68_8)

				local var_68_10 = manager.ui.mainCamera.transform.position - var_68_5.position

				var_68_5.forward = Vector3.New(var_68_10.x, var_68_10.y, var_68_10.z)

				local var_68_11 = var_68_5.localEulerAngles

				var_68_11.z = 0
				var_68_11.x = 0
				var_68_5.localEulerAngles = var_68_11
			end

			if arg_65_1.time_ >= var_68_6 + var_68_7 and arg_65_1.time_ < var_68_6 + var_68_7 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_68_12 = manager.ui.mainCamera.transform.position - var_68_5.position

				var_68_5.forward = Vector3.New(var_68_12.x, var_68_12.y, var_68_12.z)

				local var_68_13 = var_68_5.localEulerAngles

				var_68_13.z = 0
				var_68_13.x = 0
				var_68_5.localEulerAngles = var_68_13
			end

			local var_68_14 = arg_65_1.actors_["1071ui_story"]
			local var_68_15 = 0

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.characterEffect1071ui_story == nil then
				arg_65_1.var_.characterEffect1071ui_story = var_68_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_16 = 0.200000002980232

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_16 and not isNil(var_68_14) then
				local var_68_17 = (arg_65_1.time_ - var_68_15) / var_68_16

				if arg_65_1.var_.characterEffect1071ui_story and not isNil(var_68_14) then
					arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_15 + var_68_16 and arg_65_1.time_ < var_68_15 + var_68_16 + arg_68_0 and not isNil(var_68_14) and arg_65_1.var_.characterEffect1071ui_story then
				arg_65_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_68_18 = arg_65_1.actors_["10164ui_story"]
			local var_68_19 = 0

			if var_68_19 < arg_65_1.time_ and arg_65_1.time_ <= var_68_19 + arg_68_0 and not isNil(var_68_18) and arg_65_1.var_.characterEffect10164ui_story == nil then
				arg_65_1.var_.characterEffect10164ui_story = var_68_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_20 = 0.200000002980232

			if var_68_19 <= arg_65_1.time_ and arg_65_1.time_ < var_68_19 + var_68_20 and not isNil(var_68_18) then
				local var_68_21 = (arg_65_1.time_ - var_68_19) / var_68_20

				if arg_65_1.var_.characterEffect10164ui_story and not isNil(var_68_18) then
					local var_68_22 = Mathf.Lerp(0, 0.5, var_68_21)

					arg_65_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10164ui_story.fillRatio = var_68_22
				end
			end

			if arg_65_1.time_ >= var_68_19 + var_68_20 and arg_65_1.time_ < var_68_19 + var_68_20 + arg_68_0 and not isNil(var_68_18) and arg_65_1.var_.characterEffect10164ui_story then
				local var_68_23 = 0.5

				arg_65_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10164ui_story.fillRatio = var_68_23
			end

			local var_68_24 = 0

			if var_68_24 < arg_65_1.time_ and arg_65_1.time_ <= var_68_24 + arg_68_0 then
				arg_65_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action1_1")
			end

			local var_68_25 = 0

			if var_68_25 < arg_65_1.time_ and arg_65_1.time_ <= var_68_25 + arg_68_0 then
				arg_65_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_68_26 = arg_65_1.actors_["10164ui_story"].transform
			local var_68_27 = 0

			if var_68_27 < arg_65_1.time_ and arg_65_1.time_ <= var_68_27 + arg_68_0 then
				arg_65_1.var_.moveOldPos10164ui_story = var_68_26.localPosition

				local var_68_28 = GameObjectTools.GetOrAddComponent(var_68_26.gameObject, typeof(DynamicBoneHelper))

				if var_68_28 then
					var_68_28:EnableDynamicBone(false)
				end
			end

			local var_68_29 = 0.001

			if var_68_27 <= arg_65_1.time_ and arg_65_1.time_ < var_68_27 + var_68_29 then
				local var_68_30 = (arg_65_1.time_ - var_68_27) / var_68_29
				local var_68_31 = Vector3.New(-0.74, -1.08, -5.83)

				var_68_26.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10164ui_story, var_68_31, var_68_30)

				local var_68_32 = manager.ui.mainCamera.transform.position - var_68_26.position

				var_68_26.forward = Vector3.New(var_68_32.x, var_68_32.y, var_68_32.z)

				local var_68_33 = var_68_26.localEulerAngles

				var_68_33.z = 0
				var_68_33.x = 0
				var_68_26.localEulerAngles = var_68_33
			end

			if arg_65_1.time_ >= var_68_27 + var_68_29 and arg_65_1.time_ < var_68_27 + var_68_29 + arg_68_0 then
				var_68_26.localPosition = Vector3.New(-0.74, -1.08, -5.83)

				local var_68_34 = manager.ui.mainCamera.transform.position - var_68_26.position

				var_68_26.forward = Vector3.New(var_68_34.x, var_68_34.y, var_68_34.z)

				local var_68_35 = var_68_26.localEulerAngles

				var_68_35.z = 0
				var_68_35.x = 0
				var_68_26.localEulerAngles = var_68_35

				local var_68_36 = GameObjectTools.GetOrAddComponent(var_68_26.gameObject, typeof(DynamicBoneHelper))

				if var_68_36 then
					var_68_36:EnableDynamicBone(true)
				end
			end

			local var_68_37 = 0
			local var_68_38 = 0.2

			if var_68_37 < arg_65_1.time_ and arg_65_1.time_ <= var_68_37 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_39 = arg_65_1:FormatText(StoryNameCfg[384].name)

				arg_65_1.leftNameTxt_.text = var_68_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_40 = arg_65_1:GetWordFromCfg(324562015)
				local var_68_41 = arg_65_1:FormatText(var_68_40.content)

				arg_65_1.text_.text = var_68_41

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_42 = 8
				local var_68_43 = utf8.len(var_68_41)
				local var_68_44 = var_68_42 <= 0 and var_68_38 or var_68_38 * (var_68_43 / var_68_42)

				if var_68_44 > 0 and var_68_38 < var_68_44 then
					arg_65_1.talkMaxDuration = var_68_44

					if var_68_44 + var_68_37 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_44 + var_68_37
					end
				end

				arg_65_1.text_.text = var_68_41
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562015", "story_v_out_324562.awb") ~= 0 then
					local var_68_45 = manager.audio:GetVoiceLength("story_v_out_324562", "324562015", "story_v_out_324562.awb") / 1000

					if var_68_45 + var_68_37 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_45 + var_68_37
					end

					if var_68_40.prefab_name ~= "" and arg_65_1.actors_[var_68_40.prefab_name] ~= nil then
						local var_68_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_40.prefab_name].transform, "story_v_out_324562", "324562015", "story_v_out_324562.awb")

						arg_65_1:RecordAudio("324562015", var_68_46)
						arg_65_1:RecordAudio("324562015", var_68_46)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_324562", "324562015", "story_v_out_324562.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_324562", "324562015", "story_v_out_324562.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_47 = math.max(var_68_38, arg_65_1.talkMaxDuration)

			if var_68_37 <= arg_65_1.time_ and arg_65_1.time_ < var_68_37 + var_68_47 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_37) / var_68_47

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_37 + var_68_47 and arg_65_1.time_ < var_68_37 + var_68_47 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play324562016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 324562016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play324562017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1071ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1071ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(0, 100, 0)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1071ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(0, 100, 0)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["10164ui_story"].transform
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 then
				arg_69_1.var_.moveOldPos10164ui_story = var_72_9.localPosition

				local var_72_11 = GameObjectTools.GetOrAddComponent(var_72_9.gameObject, typeof(DynamicBoneHelper))

				if var_72_11 then
					var_72_11:EnableDynamicBone(false)
				end
			end

			local var_72_12 = 0.001

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_12 then
				local var_72_13 = (arg_69_1.time_ - var_72_10) / var_72_12
				local var_72_14 = Vector3.New(0, 100, 0)

				var_72_9.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10164ui_story, var_72_14, var_72_13)

				local var_72_15 = manager.ui.mainCamera.transform.position - var_72_9.position

				var_72_9.forward = Vector3.New(var_72_15.x, var_72_15.y, var_72_15.z)

				local var_72_16 = var_72_9.localEulerAngles

				var_72_16.z = 0
				var_72_16.x = 0
				var_72_9.localEulerAngles = var_72_16
			end

			if arg_69_1.time_ >= var_72_10 + var_72_12 and arg_69_1.time_ < var_72_10 + var_72_12 + arg_72_0 then
				var_72_9.localPosition = Vector3.New(0, 100, 0)

				local var_72_17 = manager.ui.mainCamera.transform.position - var_72_9.position

				var_72_9.forward = Vector3.New(var_72_17.x, var_72_17.y, var_72_17.z)

				local var_72_18 = var_72_9.localEulerAngles

				var_72_18.z = 0
				var_72_18.x = 0
				var_72_9.localEulerAngles = var_72_18

				local var_72_19 = GameObjectTools.GetOrAddComponent(var_72_9.gameObject, typeof(DynamicBoneHelper))

				if var_72_19 then
					var_72_19:EnableDynamicBone(true)
				end
			end

			local var_72_20 = arg_69_1.actors_["1071ui_story"]
			local var_72_21 = 0

			if var_72_21 < arg_69_1.time_ and arg_69_1.time_ <= var_72_21 + arg_72_0 and not isNil(var_72_20) and arg_69_1.var_.characterEffect1071ui_story == nil then
				arg_69_1.var_.characterEffect1071ui_story = var_72_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_22 = 0.200000002980232

			if var_72_21 <= arg_69_1.time_ and arg_69_1.time_ < var_72_21 + var_72_22 and not isNil(var_72_20) then
				local var_72_23 = (arg_69_1.time_ - var_72_21) / var_72_22

				if arg_69_1.var_.characterEffect1071ui_story and not isNil(var_72_20) then
					local var_72_24 = Mathf.Lerp(0, 0.5, var_72_23)

					arg_69_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1071ui_story.fillRatio = var_72_24
				end
			end

			if arg_69_1.time_ >= var_72_21 + var_72_22 and arg_69_1.time_ < var_72_21 + var_72_22 + arg_72_0 and not isNil(var_72_20) and arg_69_1.var_.characterEffect1071ui_story then
				local var_72_25 = 0.5

				arg_69_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1071ui_story.fillRatio = var_72_25
			end

			local var_72_26 = 0

			if var_72_26 < arg_69_1.time_ and arg_69_1.time_ <= var_72_26 + arg_72_0 then
				arg_69_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_72_27 = 0
			local var_72_28 = 0.85

			if var_72_27 < arg_69_1.time_ and arg_69_1.time_ <= var_72_27 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_29 = arg_69_1:GetWordFromCfg(324562016)
				local var_72_30 = arg_69_1:FormatText(var_72_29.content)

				arg_69_1.text_.text = var_72_30

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_31 = 34
				local var_72_32 = utf8.len(var_72_30)
				local var_72_33 = var_72_31 <= 0 and var_72_28 or var_72_28 * (var_72_32 / var_72_31)

				if var_72_33 > 0 and var_72_28 < var_72_33 then
					arg_69_1.talkMaxDuration = var_72_33

					if var_72_33 + var_72_27 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_33 + var_72_27
					end
				end

				arg_69_1.text_.text = var_72_30
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_34 = math.max(var_72_28, arg_69_1.talkMaxDuration)

			if var_72_27 <= arg_69_1.time_ and arg_69_1.time_ < var_72_27 + var_72_34 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_27) / var_72_34

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_27 + var_72_34 and arg_69_1.time_ < var_72_27 + var_72_34 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play324562017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 324562017
		arg_73_1.duration_ = 9.4

		local var_73_0 = {
			zh = 7.266,
			ja = 9.4
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play324562018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1071ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1071ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0.7, -1.05, -6.2)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1071ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0.7, -1.05, -6.2)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["1071ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1071ui_story == nil then
				arg_73_1.var_.characterEffect1071ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect1071ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1071ui_story then
				arg_73_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_76_13 = 0

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_76_14 = 0
			local var_76_15 = 0.75

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_16 = arg_73_1:FormatText(StoryNameCfg[384].name)

				arg_73_1.leftNameTxt_.text = var_76_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_17 = arg_73_1:GetWordFromCfg(324562017)
				local var_76_18 = arg_73_1:FormatText(var_76_17.content)

				arg_73_1.text_.text = var_76_18

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_19 = 30
				local var_76_20 = utf8.len(var_76_18)
				local var_76_21 = var_76_19 <= 0 and var_76_15 or var_76_15 * (var_76_20 / var_76_19)

				if var_76_21 > 0 and var_76_15 < var_76_21 then
					arg_73_1.talkMaxDuration = var_76_21

					if var_76_21 + var_76_14 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_21 + var_76_14
					end
				end

				arg_73_1.text_.text = var_76_18
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562017", "story_v_out_324562.awb") ~= 0 then
					local var_76_22 = manager.audio:GetVoiceLength("story_v_out_324562", "324562017", "story_v_out_324562.awb") / 1000

					if var_76_22 + var_76_14 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_22 + var_76_14
					end

					if var_76_17.prefab_name ~= "" and arg_73_1.actors_[var_76_17.prefab_name] ~= nil then
						local var_76_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_17.prefab_name].transform, "story_v_out_324562", "324562017", "story_v_out_324562.awb")

						arg_73_1:RecordAudio("324562017", var_76_23)
						arg_73_1:RecordAudio("324562017", var_76_23)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_324562", "324562017", "story_v_out_324562.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_324562", "324562017", "story_v_out_324562.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_24 = math.max(var_76_15, arg_73_1.talkMaxDuration)

			if var_76_14 <= arg_73_1.time_ and arg_73_1.time_ < var_76_14 + var_76_24 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_14) / var_76_24

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_14 + var_76_24 and arg_73_1.time_ < var_76_14 + var_76_24 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play324562018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 324562018
		arg_77_1.duration_ = 2.03

		local var_77_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play324562019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10164ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10164ui_story = var_80_0.localPosition

				local var_80_2 = GameObjectTools.GetOrAddComponent(var_80_0.gameObject, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(false)
				end
			end

			local var_80_3 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_3 then
				local var_80_4 = (arg_77_1.time_ - var_80_1) / var_80_3
				local var_80_5 = Vector3.New(-0.74, -1.08, -5.83)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10164ui_story, var_80_5, var_80_4)

				local var_80_6 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_6.x, var_80_6.y, var_80_6.z)

				local var_80_7 = var_80_0.localEulerAngles

				var_80_7.z = 0
				var_80_7.x = 0
				var_80_0.localEulerAngles = var_80_7
			end

			if arg_77_1.time_ >= var_80_1 + var_80_3 and arg_77_1.time_ < var_80_1 + var_80_3 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(-0.74, -1.08, -5.83)

				local var_80_8 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_8.x, var_80_8.y, var_80_8.z)

				local var_80_9 = var_80_0.localEulerAngles

				var_80_9.z = 0
				var_80_9.x = 0
				var_80_0.localEulerAngles = var_80_9

				local var_80_10 = GameObjectTools.GetOrAddComponent(var_80_0.gameObject, typeof(DynamicBoneHelper))

				if var_80_10 then
					var_80_10:EnableDynamicBone(true)
				end
			end

			local var_80_11 = arg_77_1.actors_["10164ui_story"]
			local var_80_12 = 0

			if var_80_12 < arg_77_1.time_ and arg_77_1.time_ <= var_80_12 + arg_80_0 and not isNil(var_80_11) and arg_77_1.var_.characterEffect10164ui_story == nil then
				arg_77_1.var_.characterEffect10164ui_story = var_80_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_13 = 0.200000002980232

			if var_80_12 <= arg_77_1.time_ and arg_77_1.time_ < var_80_12 + var_80_13 and not isNil(var_80_11) then
				local var_80_14 = (arg_77_1.time_ - var_80_12) / var_80_13

				if arg_77_1.var_.characterEffect10164ui_story and not isNil(var_80_11) then
					arg_77_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_12 + var_80_13 and arg_77_1.time_ < var_80_12 + var_80_13 + arg_80_0 and not isNil(var_80_11) and arg_77_1.var_.characterEffect10164ui_story then
				arg_77_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_80_15 = arg_77_1.actors_["1071ui_story"]
			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.characterEffect1071ui_story == nil then
				arg_77_1.var_.characterEffect1071ui_story = var_80_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_17 = 0.200000002980232

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 and not isNil(var_80_15) then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17

				if arg_77_1.var_.characterEffect1071ui_story and not isNil(var_80_15) then
					local var_80_19 = Mathf.Lerp(0, 0.5, var_80_18)

					arg_77_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1071ui_story.fillRatio = var_80_19
				end
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.characterEffect1071ui_story then
				local var_80_20 = 0.5

				arg_77_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1071ui_story.fillRatio = var_80_20
			end

			local var_80_21 = 0

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162actionlink/10162action41512")
			end

			local var_80_22 = 0

			if var_80_22 < arg_77_1.time_ and arg_77_1.time_ <= var_80_22 + arg_80_0 then
				arg_77_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_80_23 = 0
			local var_80_24 = 0.2

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_25 = arg_77_1:FormatText(StoryNameCfg[1462].name)

				arg_77_1.leftNameTxt_.text = var_80_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_26 = arg_77_1:GetWordFromCfg(324562018)
				local var_80_27 = arg_77_1:FormatText(var_80_26.content)

				arg_77_1.text_.text = var_80_27

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_28 = 8
				local var_80_29 = utf8.len(var_80_27)
				local var_80_30 = var_80_28 <= 0 and var_80_24 or var_80_24 * (var_80_29 / var_80_28)

				if var_80_30 > 0 and var_80_24 < var_80_30 then
					arg_77_1.talkMaxDuration = var_80_30

					if var_80_30 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_30 + var_80_23
					end
				end

				arg_77_1.text_.text = var_80_27
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562018", "story_v_out_324562.awb") ~= 0 then
					local var_80_31 = manager.audio:GetVoiceLength("story_v_out_324562", "324562018", "story_v_out_324562.awb") / 1000

					if var_80_31 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_31 + var_80_23
					end

					if var_80_26.prefab_name ~= "" and arg_77_1.actors_[var_80_26.prefab_name] ~= nil then
						local var_80_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_26.prefab_name].transform, "story_v_out_324562", "324562018", "story_v_out_324562.awb")

						arg_77_1:RecordAudio("324562018", var_80_32)
						arg_77_1:RecordAudio("324562018", var_80_32)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_324562", "324562018", "story_v_out_324562.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_324562", "324562018", "story_v_out_324562.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_33 = math.max(var_80_24, arg_77_1.talkMaxDuration)

			if var_80_23 <= arg_77_1.time_ and arg_77_1.time_ < var_80_23 + var_80_33 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_23) / var_80_33

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_23 + var_80_33 and arg_77_1.time_ < var_80_23 + var_80_33 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play324562019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 324562019
		arg_81_1.duration_ = 9.5

		local var_81_0 = {
			zh = 8,
			ja = 9.5
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play324562020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1071ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1071ui_story == nil then
				arg_81_1.var_.characterEffect1071ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1071ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1071ui_story then
				arg_81_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_84_4 = arg_81_1.actors_["10164ui_story"]
			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect10164ui_story == nil then
				arg_81_1.var_.characterEffect10164ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.200000002980232

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_6 and not isNil(var_84_4) then
				local var_84_7 = (arg_81_1.time_ - var_84_5) / var_84_6

				if arg_81_1.var_.characterEffect10164ui_story and not isNil(var_84_4) then
					local var_84_8 = Mathf.Lerp(0, 0.5, var_84_7)

					arg_81_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10164ui_story.fillRatio = var_84_8
				end
			end

			if arg_81_1.time_ >= var_84_5 + var_84_6 and arg_81_1.time_ < var_84_5 + var_84_6 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect10164ui_story then
				local var_84_9 = 0.5

				arg_81_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10164ui_story.fillRatio = var_84_9
			end

			local var_84_10 = 0
			local var_84_11 = 1.25

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_12 = arg_81_1:FormatText(StoryNameCfg[384].name)

				arg_81_1.leftNameTxt_.text = var_84_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_13 = arg_81_1:GetWordFromCfg(324562019)
				local var_84_14 = arg_81_1:FormatText(var_84_13.content)

				arg_81_1.text_.text = var_84_14

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_15 = 50
				local var_84_16 = utf8.len(var_84_14)
				local var_84_17 = var_84_15 <= 0 and var_84_11 or var_84_11 * (var_84_16 / var_84_15)

				if var_84_17 > 0 and var_84_11 < var_84_17 then
					arg_81_1.talkMaxDuration = var_84_17

					if var_84_17 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_17 + var_84_10
					end
				end

				arg_81_1.text_.text = var_84_14
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562019", "story_v_out_324562.awb") ~= 0 then
					local var_84_18 = manager.audio:GetVoiceLength("story_v_out_324562", "324562019", "story_v_out_324562.awb") / 1000

					if var_84_18 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_10
					end

					if var_84_13.prefab_name ~= "" and arg_81_1.actors_[var_84_13.prefab_name] ~= nil then
						local var_84_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_13.prefab_name].transform, "story_v_out_324562", "324562019", "story_v_out_324562.awb")

						arg_81_1:RecordAudio("324562019", var_84_19)
						arg_81_1:RecordAudio("324562019", var_84_19)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_324562", "324562019", "story_v_out_324562.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_324562", "324562019", "story_v_out_324562.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_20 = math.max(var_84_11, arg_81_1.talkMaxDuration)

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_20 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_10) / var_84_20

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_10 + var_84_20 and arg_81_1.time_ < var_84_10 + var_84_20 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play324562020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 324562020
		arg_85_1.duration_ = 4.77

		local var_85_0 = {
			zh = 3.833,
			ja = 4.766
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play324562021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_88_1 = 0
			local var_88_2 = 0.5

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_3 = arg_85_1:FormatText(StoryNameCfg[384].name)

				arg_85_1.leftNameTxt_.text = var_88_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_4 = arg_85_1:GetWordFromCfg(324562020)
				local var_88_5 = arg_85_1:FormatText(var_88_4.content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 20
				local var_88_7 = utf8.len(var_88_5)
				local var_88_8 = var_88_6 <= 0 and var_88_2 or var_88_2 * (var_88_7 / var_88_6)

				if var_88_8 > 0 and var_88_2 < var_88_8 then
					arg_85_1.talkMaxDuration = var_88_8

					if var_88_8 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562020", "story_v_out_324562.awb") ~= 0 then
					local var_88_9 = manager.audio:GetVoiceLength("story_v_out_324562", "324562020", "story_v_out_324562.awb") / 1000

					if var_88_9 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_1
					end

					if var_88_4.prefab_name ~= "" and arg_85_1.actors_[var_88_4.prefab_name] ~= nil then
						local var_88_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_4.prefab_name].transform, "story_v_out_324562", "324562020", "story_v_out_324562.awb")

						arg_85_1:RecordAudio("324562020", var_88_10)
						arg_85_1:RecordAudio("324562020", var_88_10)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_324562", "324562020", "story_v_out_324562.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_324562", "324562020", "story_v_out_324562.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_11 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_11 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_11

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_11 and arg_85_1.time_ < var_88_1 + var_88_11 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play324562021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 324562021
		arg_89_1.duration_ = 6.8

		local var_89_0 = {
			zh = 4.6,
			ja = 6.8
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play324562022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10164ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10164ui_story == nil then
				arg_89_1.var_.characterEffect10164ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect10164ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10164ui_story then
				arg_89_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_92_4 = arg_89_1.actors_["1071ui_story"]
			local var_92_5 = 0

			if var_92_5 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1071ui_story == nil then
				arg_89_1.var_.characterEffect1071ui_story = var_92_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_6 = 0.200000002980232

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_6 and not isNil(var_92_4) then
				local var_92_7 = (arg_89_1.time_ - var_92_5) / var_92_6

				if arg_89_1.var_.characterEffect1071ui_story and not isNil(var_92_4) then
					local var_92_8 = Mathf.Lerp(0, 0.5, var_92_7)

					arg_89_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1071ui_story.fillRatio = var_92_8
				end
			end

			if arg_89_1.time_ >= var_92_5 + var_92_6 and arg_89_1.time_ < var_92_5 + var_92_6 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect1071ui_story then
				local var_92_9 = 0.5

				arg_89_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1071ui_story.fillRatio = var_92_9
			end

			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 then
				arg_89_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162actionlink/10162action41216")
			end

			local var_92_11 = 0

			if var_92_11 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_92_12 = 0
			local var_92_13 = 0.6

			if var_92_12 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_14 = arg_89_1:FormatText(StoryNameCfg[1462].name)

				arg_89_1.leftNameTxt_.text = var_92_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_15 = arg_89_1:GetWordFromCfg(324562021)
				local var_92_16 = arg_89_1:FormatText(var_92_15.content)

				arg_89_1.text_.text = var_92_16

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_17 = 24
				local var_92_18 = utf8.len(var_92_16)
				local var_92_19 = var_92_17 <= 0 and var_92_13 or var_92_13 * (var_92_18 / var_92_17)

				if var_92_19 > 0 and var_92_13 < var_92_19 then
					arg_89_1.talkMaxDuration = var_92_19

					if var_92_19 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_19 + var_92_12
					end
				end

				arg_89_1.text_.text = var_92_16
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562021", "story_v_out_324562.awb") ~= 0 then
					local var_92_20 = manager.audio:GetVoiceLength("story_v_out_324562", "324562021", "story_v_out_324562.awb") / 1000

					if var_92_20 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_20 + var_92_12
					end

					if var_92_15.prefab_name ~= "" and arg_89_1.actors_[var_92_15.prefab_name] ~= nil then
						local var_92_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_15.prefab_name].transform, "story_v_out_324562", "324562021", "story_v_out_324562.awb")

						arg_89_1:RecordAudio("324562021", var_92_21)
						arg_89_1:RecordAudio("324562021", var_92_21)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_324562", "324562021", "story_v_out_324562.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_324562", "324562021", "story_v_out_324562.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_22 = math.max(var_92_13, arg_89_1.talkMaxDuration)

			if var_92_12 <= arg_89_1.time_ and arg_89_1.time_ < var_92_12 + var_92_22 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_12) / var_92_22

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_12 + var_92_22 and arg_89_1.time_ < var_92_12 + var_92_22 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play324562022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 324562022
		arg_93_1.duration_ = 4.07

		local var_93_0 = {
			zh = 2.6,
			ja = 4.066
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play324562023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1071ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1071ui_story == nil then
				arg_93_1.var_.characterEffect1071ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1071ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1071ui_story then
				arg_93_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_96_4 = arg_93_1.actors_["10164ui_story"]
			local var_96_5 = 0

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect10164ui_story == nil then
				arg_93_1.var_.characterEffect10164ui_story = var_96_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_6 = 0.200000002980232

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_6 and not isNil(var_96_4) then
				local var_96_7 = (arg_93_1.time_ - var_96_5) / var_96_6

				if arg_93_1.var_.characterEffect10164ui_story and not isNil(var_96_4) then
					local var_96_8 = Mathf.Lerp(0, 0.5, var_96_7)

					arg_93_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10164ui_story.fillRatio = var_96_8
				end
			end

			if arg_93_1.time_ >= var_96_5 + var_96_6 and arg_93_1.time_ < var_96_5 + var_96_6 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect10164ui_story then
				local var_96_9 = 0.5

				arg_93_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10164ui_story.fillRatio = var_96_9
			end

			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_1")
			end

			local var_96_11 = 0
			local var_96_12 = 0.35

			if var_96_11 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_13 = arg_93_1:FormatText(StoryNameCfg[384].name)

				arg_93_1.leftNameTxt_.text = var_96_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_14 = arg_93_1:GetWordFromCfg(324562022)
				local var_96_15 = arg_93_1:FormatText(var_96_14.content)

				arg_93_1.text_.text = var_96_15

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 14
				local var_96_17 = utf8.len(var_96_15)
				local var_96_18 = var_96_16 <= 0 and var_96_12 or var_96_12 * (var_96_17 / var_96_16)

				if var_96_18 > 0 and var_96_12 < var_96_18 then
					arg_93_1.talkMaxDuration = var_96_18

					if var_96_18 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_11
					end
				end

				arg_93_1.text_.text = var_96_15
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562022", "story_v_out_324562.awb") ~= 0 then
					local var_96_19 = manager.audio:GetVoiceLength("story_v_out_324562", "324562022", "story_v_out_324562.awb") / 1000

					if var_96_19 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_11
					end

					if var_96_14.prefab_name ~= "" and arg_93_1.actors_[var_96_14.prefab_name] ~= nil then
						local var_96_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_14.prefab_name].transform, "story_v_out_324562", "324562022", "story_v_out_324562.awb")

						arg_93_1:RecordAudio("324562022", var_96_20)
						arg_93_1:RecordAudio("324562022", var_96_20)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_324562", "324562022", "story_v_out_324562.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_324562", "324562022", "story_v_out_324562.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_21 = math.max(var_96_12, arg_93_1.talkMaxDuration)

			if var_96_11 <= arg_93_1.time_ and arg_93_1.time_ < var_96_11 + var_96_21 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_11) / var_96_21

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_11 + var_96_21 and arg_93_1.time_ < var_96_11 + var_96_21 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play324562023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 324562023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play324562024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1071ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1071ui_story == nil then
				arg_97_1.var_.characterEffect1071ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1071ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1071ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1071ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1071ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.825

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:GetWordFromCfg(324562023)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 33
				local var_100_11 = utf8.len(var_100_9)
				local var_100_12 = var_100_10 <= 0 and var_100_7 or var_100_7 * (var_100_11 / var_100_10)

				if var_100_12 > 0 and var_100_7 < var_100_12 then
					arg_97_1.talkMaxDuration = var_100_12

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_13 and arg_97_1.time_ < var_100_6 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play324562024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 324562024
		arg_101_1.duration_ = 10.43

		local var_101_0 = {
			zh = 10.366,
			ja = 10.433
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play324562025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1071ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1071ui_story == nil then
				arg_101_1.var_.characterEffect1071ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect1071ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect1071ui_story then
				arg_101_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_104_4 = 0

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action5_2")
			end

			local var_104_5 = 0
			local var_104_6 = 1.25

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_7 = arg_101_1:FormatText(StoryNameCfg[384].name)

				arg_101_1.leftNameTxt_.text = var_104_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(324562024)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_10 = 50
				local var_104_11 = utf8.len(var_104_9)
				local var_104_12 = var_104_10 <= 0 and var_104_6 or var_104_6 * (var_104_11 / var_104_10)

				if var_104_12 > 0 and var_104_6 < var_104_12 then
					arg_101_1.talkMaxDuration = var_104_12

					if var_104_12 + var_104_5 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_5
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562024", "story_v_out_324562.awb") ~= 0 then
					local var_104_13 = manager.audio:GetVoiceLength("story_v_out_324562", "324562024", "story_v_out_324562.awb") / 1000

					if var_104_13 + var_104_5 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_5
					end

					if var_104_8.prefab_name ~= "" and arg_101_1.actors_[var_104_8.prefab_name] ~= nil then
						local var_104_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_8.prefab_name].transform, "story_v_out_324562", "324562024", "story_v_out_324562.awb")

						arg_101_1:RecordAudio("324562024", var_104_14)
						arg_101_1:RecordAudio("324562024", var_104_14)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_324562", "324562024", "story_v_out_324562.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_324562", "324562024", "story_v_out_324562.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_15 = math.max(var_104_6, arg_101_1.talkMaxDuration)

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_15 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_5) / var_104_15

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_5 + var_104_15 and arg_101_1.time_ < var_104_5 + var_104_15 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play324562025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 324562025
		arg_105_1.duration_ = 4.6

		local var_105_0 = {
			zh = 3.4,
			ja = 4.6
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play324562026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10164ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10164ui_story == nil then
				arg_105_1.var_.characterEffect10164ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect10164ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10164ui_story then
				arg_105_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_108_4 = arg_105_1.actors_["1071ui_story"]
			local var_108_5 = 0

			if var_108_5 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect1071ui_story == nil then
				arg_105_1.var_.characterEffect1071ui_story = var_108_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.200000002980232

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_6 and not isNil(var_108_4) then
				local var_108_7 = (arg_105_1.time_ - var_108_5) / var_108_6

				if arg_105_1.var_.characterEffect1071ui_story and not isNil(var_108_4) then
					local var_108_8 = Mathf.Lerp(0, 0.5, var_108_7)

					arg_105_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1071ui_story.fillRatio = var_108_8
				end
			end

			if arg_105_1.time_ >= var_108_5 + var_108_6 and arg_105_1.time_ < var_108_5 + var_108_6 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect1071ui_story then
				local var_108_9 = 0.5

				arg_105_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1071ui_story.fillRatio = var_108_9
			end

			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_2")
			end

			local var_108_11 = 0

			if var_108_11 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				arg_105_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_108_12 = 0
			local var_108_13 = 0.375

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_14 = arg_105_1:FormatText(StoryNameCfg[1462].name)

				arg_105_1.leftNameTxt_.text = var_108_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_15 = arg_105_1:GetWordFromCfg(324562025)
				local var_108_16 = arg_105_1:FormatText(var_108_15.content)

				arg_105_1.text_.text = var_108_16

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_17 = 15
				local var_108_18 = utf8.len(var_108_16)
				local var_108_19 = var_108_17 <= 0 and var_108_13 or var_108_13 * (var_108_18 / var_108_17)

				if var_108_19 > 0 and var_108_13 < var_108_19 then
					arg_105_1.talkMaxDuration = var_108_19

					if var_108_19 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_19 + var_108_12
					end
				end

				arg_105_1.text_.text = var_108_16
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562025", "story_v_out_324562.awb") ~= 0 then
					local var_108_20 = manager.audio:GetVoiceLength("story_v_out_324562", "324562025", "story_v_out_324562.awb") / 1000

					if var_108_20 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_20 + var_108_12
					end

					if var_108_15.prefab_name ~= "" and arg_105_1.actors_[var_108_15.prefab_name] ~= nil then
						local var_108_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_15.prefab_name].transform, "story_v_out_324562", "324562025", "story_v_out_324562.awb")

						arg_105_1:RecordAudio("324562025", var_108_21)
						arg_105_1:RecordAudio("324562025", var_108_21)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_324562", "324562025", "story_v_out_324562.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_324562", "324562025", "story_v_out_324562.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_22 = math.max(var_108_13, arg_105_1.talkMaxDuration)

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_22 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_12) / var_108_22

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_12 + var_108_22 and arg_105_1.time_ < var_108_12 + var_108_22 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play324562026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 324562026
		arg_109_1.duration_ = 11.07

		local var_109_0 = {
			zh = 8.233,
			ja = 11.066
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play324562027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1071ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1071ui_story == nil then
				arg_109_1.var_.characterEffect1071ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1071ui_story and not isNil(var_112_0) then
					arg_109_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1071ui_story then
				arg_109_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_112_4 = arg_109_1.actors_["10164ui_story"]
			local var_112_5 = 0

			if var_112_5 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect10164ui_story == nil then
				arg_109_1.var_.characterEffect10164ui_story = var_112_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_6 = 0.200000002980232

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_6 and not isNil(var_112_4) then
				local var_112_7 = (arg_109_1.time_ - var_112_5) / var_112_6

				if arg_109_1.var_.characterEffect10164ui_story and not isNil(var_112_4) then
					local var_112_8 = Mathf.Lerp(0, 0.5, var_112_7)

					arg_109_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10164ui_story.fillRatio = var_112_8
				end
			end

			if arg_109_1.time_ >= var_112_5 + var_112_6 and arg_109_1.time_ < var_112_5 + var_112_6 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect10164ui_story then
				local var_112_9 = 0.5

				arg_109_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10164ui_story.fillRatio = var_112_9
			end

			local var_112_10 = 0
			local var_112_11 = 1.05

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_12 = arg_109_1:FormatText(StoryNameCfg[384].name)

				arg_109_1.leftNameTxt_.text = var_112_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_13 = arg_109_1:GetWordFromCfg(324562026)
				local var_112_14 = arg_109_1:FormatText(var_112_13.content)

				arg_109_1.text_.text = var_112_14

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_15 = 42
				local var_112_16 = utf8.len(var_112_14)
				local var_112_17 = var_112_15 <= 0 and var_112_11 or var_112_11 * (var_112_16 / var_112_15)

				if var_112_17 > 0 and var_112_11 < var_112_17 then
					arg_109_1.talkMaxDuration = var_112_17

					if var_112_17 + var_112_10 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_17 + var_112_10
					end
				end

				arg_109_1.text_.text = var_112_14
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562026", "story_v_out_324562.awb") ~= 0 then
					local var_112_18 = manager.audio:GetVoiceLength("story_v_out_324562", "324562026", "story_v_out_324562.awb") / 1000

					if var_112_18 + var_112_10 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_18 + var_112_10
					end

					if var_112_13.prefab_name ~= "" and arg_109_1.actors_[var_112_13.prefab_name] ~= nil then
						local var_112_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_13.prefab_name].transform, "story_v_out_324562", "324562026", "story_v_out_324562.awb")

						arg_109_1:RecordAudio("324562026", var_112_19)
						arg_109_1:RecordAudio("324562026", var_112_19)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_324562", "324562026", "story_v_out_324562.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_324562", "324562026", "story_v_out_324562.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_20 = math.max(var_112_11, arg_109_1.talkMaxDuration)

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_20 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_10) / var_112_20

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_10 + var_112_20 and arg_109_1.time_ < var_112_10 + var_112_20 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play324562027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 324562027
		arg_113_1.duration_ = 4.53

		local var_113_0 = {
			zh = 3.2,
			ja = 4.533
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play324562028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10164ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10164ui_story = var_116_0.localPosition

				local var_116_2 = GameObjectTools.GetOrAddComponent(var_116_0.gameObject, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(false)
				end
			end

			local var_116_3 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_3 then
				local var_116_4 = (arg_113_1.time_ - var_116_1) / var_116_3
				local var_116_5 = Vector3.New(0, 100, 0)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10164ui_story, var_116_5, var_116_4)

				local var_116_6 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_6.x, var_116_6.y, var_116_6.z)

				local var_116_7 = var_116_0.localEulerAngles

				var_116_7.z = 0
				var_116_7.x = 0
				var_116_0.localEulerAngles = var_116_7
			end

			if arg_113_1.time_ >= var_116_1 + var_116_3 and arg_113_1.time_ < var_116_1 + var_116_3 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, 100, 0)

				local var_116_8 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_8.x, var_116_8.y, var_116_8.z)

				local var_116_9 = var_116_0.localEulerAngles

				var_116_9.z = 0
				var_116_9.x = 0
				var_116_0.localEulerAngles = var_116_9

				local var_116_10 = GameObjectTools.GetOrAddComponent(var_116_0.gameObject, typeof(DynamicBoneHelper))

				if var_116_10 then
					var_116_10:EnableDynamicBone(true)
				end
			end

			local var_116_11 = arg_113_1.actors_["1170ui_story"].transform
			local var_116_12 = 0

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.var_.moveOldPos1170ui_story = var_116_11.localPosition

				local var_116_13 = GameObjectTools.GetOrAddComponent(var_116_11.gameObject, typeof(DynamicBoneHelper))

				if var_116_13 then
					var_116_13:EnableDynamicBone(false)
				end
			end

			local var_116_14 = 0.001

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_14 then
				local var_116_15 = (arg_113_1.time_ - var_116_12) / var_116_14
				local var_116_16 = Vector3.New(-0.68, -0.95, -6.08)

				var_116_11.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1170ui_story, var_116_16, var_116_15)

				local var_116_17 = manager.ui.mainCamera.transform.position - var_116_11.position

				var_116_11.forward = Vector3.New(var_116_17.x, var_116_17.y, var_116_17.z)

				local var_116_18 = var_116_11.localEulerAngles

				var_116_18.z = 0
				var_116_18.x = 0
				var_116_11.localEulerAngles = var_116_18
			end

			if arg_113_1.time_ >= var_116_12 + var_116_14 and arg_113_1.time_ < var_116_12 + var_116_14 + arg_116_0 then
				var_116_11.localPosition = Vector3.New(-0.68, -0.95, -6.08)

				local var_116_19 = manager.ui.mainCamera.transform.position - var_116_11.position

				var_116_11.forward = Vector3.New(var_116_19.x, var_116_19.y, var_116_19.z)

				local var_116_20 = var_116_11.localEulerAngles

				var_116_20.z = 0
				var_116_20.x = 0
				var_116_11.localEulerAngles = var_116_20

				local var_116_21 = GameObjectTools.GetOrAddComponent(var_116_11.gameObject, typeof(DynamicBoneHelper))

				if var_116_21 then
					var_116_21:EnableDynamicBone(true)
				end
			end

			local var_116_22 = arg_113_1.actors_["1170ui_story"]
			local var_116_23 = 0

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 and not isNil(var_116_22) and arg_113_1.var_.characterEffect1170ui_story == nil then
				arg_113_1.var_.characterEffect1170ui_story = var_116_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_24 = 0.200000002980232

			if var_116_23 <= arg_113_1.time_ and arg_113_1.time_ < var_116_23 + var_116_24 and not isNil(var_116_22) then
				local var_116_25 = (arg_113_1.time_ - var_116_23) / var_116_24

				if arg_113_1.var_.characterEffect1170ui_story and not isNil(var_116_22) then
					arg_113_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_23 + var_116_24 and arg_113_1.time_ < var_116_23 + var_116_24 + arg_116_0 and not isNil(var_116_22) and arg_113_1.var_.characterEffect1170ui_story then
				arg_113_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_116_26 = arg_113_1.actors_["1071ui_story"]
			local var_116_27 = 0

			if var_116_27 < arg_113_1.time_ and arg_113_1.time_ <= var_116_27 + arg_116_0 and not isNil(var_116_26) and arg_113_1.var_.characterEffect1071ui_story == nil then
				arg_113_1.var_.characterEffect1071ui_story = var_116_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_28 = 0.200000002980232

			if var_116_27 <= arg_113_1.time_ and arg_113_1.time_ < var_116_27 + var_116_28 and not isNil(var_116_26) then
				local var_116_29 = (arg_113_1.time_ - var_116_27) / var_116_28

				if arg_113_1.var_.characterEffect1071ui_story and not isNil(var_116_26) then
					local var_116_30 = Mathf.Lerp(0, 0.5, var_116_29)

					arg_113_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1071ui_story.fillRatio = var_116_30
				end
			end

			if arg_113_1.time_ >= var_116_27 + var_116_28 and arg_113_1.time_ < var_116_27 + var_116_28 + arg_116_0 and not isNil(var_116_26) and arg_113_1.var_.characterEffect1071ui_story then
				local var_116_31 = 0.5

				arg_113_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1071ui_story.fillRatio = var_116_31
			end

			local var_116_32 = 0

			if var_116_32 < arg_113_1.time_ and arg_113_1.time_ <= var_116_32 + arg_116_0 then
				arg_113_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action2_1")
			end

			local var_116_33 = 0

			if var_116_33 < arg_113_1.time_ and arg_113_1.time_ <= var_116_33 + arg_116_0 then
				arg_113_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_116_34 = 0
			local var_116_35 = 0.25

			if var_116_34 < arg_113_1.time_ and arg_113_1.time_ <= var_116_34 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_36 = arg_113_1:FormatText(StoryNameCfg[318].name)

				arg_113_1.leftNameTxt_.text = var_116_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_37 = arg_113_1:GetWordFromCfg(324562027)
				local var_116_38 = arg_113_1:FormatText(var_116_37.content)

				arg_113_1.text_.text = var_116_38

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_39 = 10
				local var_116_40 = utf8.len(var_116_38)
				local var_116_41 = var_116_39 <= 0 and var_116_35 or var_116_35 * (var_116_40 / var_116_39)

				if var_116_41 > 0 and var_116_35 < var_116_41 then
					arg_113_1.talkMaxDuration = var_116_41

					if var_116_41 + var_116_34 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_41 + var_116_34
					end
				end

				arg_113_1.text_.text = var_116_38
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562027", "story_v_out_324562.awb") ~= 0 then
					local var_116_42 = manager.audio:GetVoiceLength("story_v_out_324562", "324562027", "story_v_out_324562.awb") / 1000

					if var_116_42 + var_116_34 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_42 + var_116_34
					end

					if var_116_37.prefab_name ~= "" and arg_113_1.actors_[var_116_37.prefab_name] ~= nil then
						local var_116_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_37.prefab_name].transform, "story_v_out_324562", "324562027", "story_v_out_324562.awb")

						arg_113_1:RecordAudio("324562027", var_116_43)
						arg_113_1:RecordAudio("324562027", var_116_43)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_324562", "324562027", "story_v_out_324562.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_324562", "324562027", "story_v_out_324562.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_44 = math.max(var_116_35, arg_113_1.talkMaxDuration)

			if var_116_34 <= arg_113_1.time_ and arg_113_1.time_ < var_116_34 + var_116_44 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_34) / var_116_44

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_34 + var_116_44 and arg_113_1.time_ < var_116_34 + var_116_44 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play324562028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 324562028
		arg_117_1.duration_ = 5.5

		local var_117_0 = {
			zh = 3.533,
			ja = 5.5
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play324562029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1071ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1071ui_story == nil then
				arg_117_1.var_.characterEffect1071ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1071ui_story and not isNil(var_120_0) then
					arg_117_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1071ui_story then
				arg_117_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_120_4 = arg_117_1.actors_["1170ui_story"]
			local var_120_5 = 0

			if var_120_5 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1170ui_story == nil then
				arg_117_1.var_.characterEffect1170ui_story = var_120_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_6 = 0.200000002980232

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_6 and not isNil(var_120_4) then
				local var_120_7 = (arg_117_1.time_ - var_120_5) / var_120_6

				if arg_117_1.var_.characterEffect1170ui_story and not isNil(var_120_4) then
					local var_120_8 = Mathf.Lerp(0, 0.5, var_120_7)

					arg_117_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1170ui_story.fillRatio = var_120_8
				end
			end

			if arg_117_1.time_ >= var_120_5 + var_120_6 and arg_117_1.time_ < var_120_5 + var_120_6 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect1170ui_story then
				local var_120_9 = 0.5

				arg_117_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1170ui_story.fillRatio = var_120_9
			end

			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_1")
			end

			local var_120_11 = 0
			local var_120_12 = 0.5

			if var_120_11 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_13 = arg_117_1:FormatText(StoryNameCfg[384].name)

				arg_117_1.leftNameTxt_.text = var_120_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_14 = arg_117_1:GetWordFromCfg(324562028)
				local var_120_15 = arg_117_1:FormatText(var_120_14.content)

				arg_117_1.text_.text = var_120_15

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_16 = 20
				local var_120_17 = utf8.len(var_120_15)
				local var_120_18 = var_120_16 <= 0 and var_120_12 or var_120_12 * (var_120_17 / var_120_16)

				if var_120_18 > 0 and var_120_12 < var_120_18 then
					arg_117_1.talkMaxDuration = var_120_18

					if var_120_18 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_18 + var_120_11
					end
				end

				arg_117_1.text_.text = var_120_15
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562028", "story_v_out_324562.awb") ~= 0 then
					local var_120_19 = manager.audio:GetVoiceLength("story_v_out_324562", "324562028", "story_v_out_324562.awb") / 1000

					if var_120_19 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_19 + var_120_11
					end

					if var_120_14.prefab_name ~= "" and arg_117_1.actors_[var_120_14.prefab_name] ~= nil then
						local var_120_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_14.prefab_name].transform, "story_v_out_324562", "324562028", "story_v_out_324562.awb")

						arg_117_1:RecordAudio("324562028", var_120_20)
						arg_117_1:RecordAudio("324562028", var_120_20)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_324562", "324562028", "story_v_out_324562.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_324562", "324562028", "story_v_out_324562.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_21 = math.max(var_120_12, arg_117_1.talkMaxDuration)

			if var_120_11 <= arg_117_1.time_ and arg_117_1.time_ < var_120_11 + var_120_21 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_11) / var_120_21

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_11 + var_120_21 and arg_117_1.time_ < var_120_11 + var_120_21 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play324562029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 324562029
		arg_121_1.duration_ = 3.93

		local var_121_0 = {
			zh = 3.933,
			ja = 3.266
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play324562030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1170ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1170ui_story == nil then
				arg_121_1.var_.characterEffect1170ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1170ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1170ui_story then
				arg_121_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_124_4 = arg_121_1.actors_["1071ui_story"]
			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1071ui_story == nil then
				arg_121_1.var_.characterEffect1071ui_story = var_124_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_6 = 0.200000002980232

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_6 and not isNil(var_124_4) then
				local var_124_7 = (arg_121_1.time_ - var_124_5) / var_124_6

				if arg_121_1.var_.characterEffect1071ui_story and not isNil(var_124_4) then
					local var_124_8 = Mathf.Lerp(0, 0.5, var_124_7)

					arg_121_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1071ui_story.fillRatio = var_124_8
				end
			end

			if arg_121_1.time_ >= var_124_5 + var_124_6 and arg_121_1.time_ < var_124_5 + var_124_6 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect1071ui_story then
				local var_124_9 = 0.5

				arg_121_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1071ui_story.fillRatio = var_124_9
			end

			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action2_2")
			end

			local var_124_11 = 0

			if var_124_11 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 then
				arg_121_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_124_12 = 0
			local var_124_13 = 0.375

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_14 = arg_121_1:FormatText(StoryNameCfg[318].name)

				arg_121_1.leftNameTxt_.text = var_124_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_15 = arg_121_1:GetWordFromCfg(324562029)
				local var_124_16 = arg_121_1:FormatText(var_124_15.content)

				arg_121_1.text_.text = var_124_16

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_17 = 15
				local var_124_18 = utf8.len(var_124_16)
				local var_124_19 = var_124_17 <= 0 and var_124_13 or var_124_13 * (var_124_18 / var_124_17)

				if var_124_19 > 0 and var_124_13 < var_124_19 then
					arg_121_1.talkMaxDuration = var_124_19

					if var_124_19 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_19 + var_124_12
					end
				end

				arg_121_1.text_.text = var_124_16
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562029", "story_v_out_324562.awb") ~= 0 then
					local var_124_20 = manager.audio:GetVoiceLength("story_v_out_324562", "324562029", "story_v_out_324562.awb") / 1000

					if var_124_20 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_20 + var_124_12
					end

					if var_124_15.prefab_name ~= "" and arg_121_1.actors_[var_124_15.prefab_name] ~= nil then
						local var_124_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_15.prefab_name].transform, "story_v_out_324562", "324562029", "story_v_out_324562.awb")

						arg_121_1:RecordAudio("324562029", var_124_21)
						arg_121_1:RecordAudio("324562029", var_124_21)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_324562", "324562029", "story_v_out_324562.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_324562", "324562029", "story_v_out_324562.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_22 = math.max(var_124_13, arg_121_1.talkMaxDuration)

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_22 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_12) / var_124_22

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_12 + var_124_22 and arg_121_1.time_ < var_124_12 + var_124_22 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play324562030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 324562030
		arg_125_1.duration_ = 7.77

		local var_125_0 = {
			zh = 6.866,
			ja = 7.766
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play324562031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1071ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1071ui_story == nil then
				arg_125_1.var_.characterEffect1071ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect1071ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect1071ui_story then
				arg_125_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_128_4 = arg_125_1.actors_["1170ui_story"]
			local var_128_5 = 0

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1170ui_story == nil then
				arg_125_1.var_.characterEffect1170ui_story = var_128_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.200000002980232

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 and not isNil(var_128_4) then
				local var_128_7 = (arg_125_1.time_ - var_128_5) / var_128_6

				if arg_125_1.var_.characterEffect1170ui_story and not isNil(var_128_4) then
					local var_128_8 = Mathf.Lerp(0, 0.5, var_128_7)

					arg_125_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1170ui_story.fillRatio = var_128_8
				end
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1170ui_story then
				local var_128_9 = 0.5

				arg_125_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1170ui_story.fillRatio = var_128_9
			end

			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1:PlayTimeline("1071ui_story", "StoryTimeline/CharAction/story1071/story1071action/1071action2_2")
			end

			local var_128_11 = 0
			local var_128_12 = 0.75

			if var_128_11 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_13 = arg_125_1:FormatText(StoryNameCfg[384].name)

				arg_125_1.leftNameTxt_.text = var_128_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_14 = arg_125_1:GetWordFromCfg(324562030)
				local var_128_15 = arg_125_1:FormatText(var_128_14.content)

				arg_125_1.text_.text = var_128_15

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_16 = 30
				local var_128_17 = utf8.len(var_128_15)
				local var_128_18 = var_128_16 <= 0 and var_128_12 or var_128_12 * (var_128_17 / var_128_16)

				if var_128_18 > 0 and var_128_12 < var_128_18 then
					arg_125_1.talkMaxDuration = var_128_18

					if var_128_18 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_18 + var_128_11
					end
				end

				arg_125_1.text_.text = var_128_15
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562030", "story_v_out_324562.awb") ~= 0 then
					local var_128_19 = manager.audio:GetVoiceLength("story_v_out_324562", "324562030", "story_v_out_324562.awb") / 1000

					if var_128_19 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_19 + var_128_11
					end

					if var_128_14.prefab_name ~= "" and arg_125_1.actors_[var_128_14.prefab_name] ~= nil then
						local var_128_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_14.prefab_name].transform, "story_v_out_324562", "324562030", "story_v_out_324562.awb")

						arg_125_1:RecordAudio("324562030", var_128_20)
						arg_125_1:RecordAudio("324562030", var_128_20)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_324562", "324562030", "story_v_out_324562.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_324562", "324562030", "story_v_out_324562.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_21 = math.max(var_128_12, arg_125_1.talkMaxDuration)

			if var_128_11 <= arg_125_1.time_ and arg_125_1.time_ < var_128_11 + var_128_21 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_11) / var_128_21

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_11 + var_128_21 and arg_125_1.time_ < var_128_11 + var_128_21 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play324562031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 324562031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play324562032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1071ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1071ui_story == nil then
				arg_129_1.var_.characterEffect1071ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1071ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1071ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1071ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1071ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 0.975

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(324562031)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 39
				local var_132_11 = utf8.len(var_132_9)
				local var_132_12 = var_132_10 <= 0 and var_132_7 or var_132_7 * (var_132_11 / var_132_10)

				if var_132_12 > 0 and var_132_7 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_13 and arg_129_1.time_ < var_132_6 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play324562032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 324562032
		arg_133_1.duration_ = 9.8

		local var_133_0 = {
			zh = 9.5,
			ja = 9.8
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play324562033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1170ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1170ui_story == nil then
				arg_133_1.var_.characterEffect1170ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1170ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1170ui_story then
				arg_133_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_136_4 = 0

			if var_136_4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_1")
			end

			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_136_6 = 0
			local var_136_7 = 0.75

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_8 = arg_133_1:FormatText(StoryNameCfg[318].name)

				arg_133_1.leftNameTxt_.text = var_136_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_9 = arg_133_1:GetWordFromCfg(324562032)
				local var_136_10 = arg_133_1:FormatText(var_136_9.content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562032", "story_v_out_324562.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_324562", "324562032", "story_v_out_324562.awb") / 1000

					if var_136_14 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_6
					end

					if var_136_9.prefab_name ~= "" and arg_133_1.actors_[var_136_9.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_9.prefab_name].transform, "story_v_out_324562", "324562032", "story_v_out_324562.awb")

						arg_133_1:RecordAudio("324562032", var_136_15)
						arg_133_1:RecordAudio("324562032", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_324562", "324562032", "story_v_out_324562.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_324562", "324562032", "story_v_out_324562.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_16 and arg_133_1.time_ < var_136_6 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play324562033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 324562033
		arg_137_1.duration_ = 4.8

		local var_137_0 = {
			zh = 4.5,
			ja = 4.8
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play324562034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.55

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[318].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(324562033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 22
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562033", "story_v_out_324562.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_324562", "324562033", "story_v_out_324562.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_324562", "324562033", "story_v_out_324562.awb")

						arg_137_1:RecordAudio("324562033", var_140_9)
						arg_137_1:RecordAudio("324562033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_324562", "324562033", "story_v_out_324562.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_324562", "324562033", "story_v_out_324562.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_10 and arg_137_1.time_ < var_140_0 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play324562034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 324562034
		arg_141_1.duration_ = 8.23

		local var_141_0 = {
			zh = 4.633,
			ja = 8.233
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play324562035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10164ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos10164ui_story = var_144_0.localPosition

				local var_144_2 = GameObjectTools.GetOrAddComponent(var_144_0.gameObject, typeof(DynamicBoneHelper))

				if var_144_2 then
					var_144_2:EnableDynamicBone(false)
				end
			end

			local var_144_3 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_3 then
				local var_144_4 = (arg_141_1.time_ - var_144_1) / var_144_3
				local var_144_5 = Vector3.New(0.7, -1.08, -5.83)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10164ui_story, var_144_5, var_144_4)

				local var_144_6 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_6.x, var_144_6.y, var_144_6.z)

				local var_144_7 = var_144_0.localEulerAngles

				var_144_7.z = 0
				var_144_7.x = 0
				var_144_0.localEulerAngles = var_144_7
			end

			if arg_141_1.time_ >= var_144_1 + var_144_3 and arg_141_1.time_ < var_144_1 + var_144_3 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0.7, -1.08, -5.83)

				local var_144_8 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_8.x, var_144_8.y, var_144_8.z)

				local var_144_9 = var_144_0.localEulerAngles

				var_144_9.z = 0
				var_144_9.x = 0
				var_144_0.localEulerAngles = var_144_9

				local var_144_10 = GameObjectTools.GetOrAddComponent(var_144_0.gameObject, typeof(DynamicBoneHelper))

				if var_144_10 then
					var_144_10:EnableDynamicBone(true)
				end
			end

			local var_144_11 = arg_141_1.actors_["10164ui_story"]
			local var_144_12 = 0

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.characterEffect10164ui_story == nil then
				arg_141_1.var_.characterEffect10164ui_story = var_144_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_13 = 0.200000002980232

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_13 and not isNil(var_144_11) then
				local var_144_14 = (arg_141_1.time_ - var_144_12) / var_144_13

				if arg_141_1.var_.characterEffect10164ui_story and not isNil(var_144_11) then
					arg_141_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_12 + var_144_13 and arg_141_1.time_ < var_144_12 + var_144_13 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.characterEffect10164ui_story then
				arg_141_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_144_15 = arg_141_1.actors_["1170ui_story"]
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 and not isNil(var_144_15) and arg_141_1.var_.characterEffect1170ui_story == nil then
				arg_141_1.var_.characterEffect1170ui_story = var_144_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_17 = 0.200000002980232

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_17 and not isNil(var_144_15) then
				local var_144_18 = (arg_141_1.time_ - var_144_16) / var_144_17

				if arg_141_1.var_.characterEffect1170ui_story and not isNil(var_144_15) then
					local var_144_19 = Mathf.Lerp(0, 0.5, var_144_18)

					arg_141_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1170ui_story.fillRatio = var_144_19
				end
			end

			if arg_141_1.time_ >= var_144_16 + var_144_17 and arg_141_1.time_ < var_144_16 + var_144_17 + arg_144_0 and not isNil(var_144_15) and arg_141_1.var_.characterEffect1170ui_story then
				local var_144_20 = 0.5

				arg_141_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1170ui_story.fillRatio = var_144_20
			end

			local var_144_21 = 0

			if var_144_21 < arg_141_1.time_ and arg_141_1.time_ <= var_144_21 + arg_144_0 then
				arg_141_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_144_22 = 0

			if var_144_22 < arg_141_1.time_ and arg_141_1.time_ <= var_144_22 + arg_144_0 then
				arg_141_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_144_23 = arg_141_1.actors_["1071ui_story"].transform
			local var_144_24 = 0

			if var_144_24 < arg_141_1.time_ and arg_141_1.time_ <= var_144_24 + arg_144_0 then
				arg_141_1.var_.moveOldPos1071ui_story = var_144_23.localPosition
			end

			local var_144_25 = 0.001

			if var_144_24 <= arg_141_1.time_ and arg_141_1.time_ < var_144_24 + var_144_25 then
				local var_144_26 = (arg_141_1.time_ - var_144_24) / var_144_25
				local var_144_27 = Vector3.New(0, 100, 0)

				var_144_23.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1071ui_story, var_144_27, var_144_26)

				local var_144_28 = manager.ui.mainCamera.transform.position - var_144_23.position

				var_144_23.forward = Vector3.New(var_144_28.x, var_144_28.y, var_144_28.z)

				local var_144_29 = var_144_23.localEulerAngles

				var_144_29.z = 0
				var_144_29.x = 0
				var_144_23.localEulerAngles = var_144_29
			end

			if arg_141_1.time_ >= var_144_24 + var_144_25 and arg_141_1.time_ < var_144_24 + var_144_25 + arg_144_0 then
				var_144_23.localPosition = Vector3.New(0, 100, 0)

				local var_144_30 = manager.ui.mainCamera.transform.position - var_144_23.position

				var_144_23.forward = Vector3.New(var_144_30.x, var_144_30.y, var_144_30.z)

				local var_144_31 = var_144_23.localEulerAngles

				var_144_31.z = 0
				var_144_31.x = 0
				var_144_23.localEulerAngles = var_144_31
			end

			local var_144_32 = 0
			local var_144_33 = 0.65

			if var_144_32 < arg_141_1.time_ and arg_141_1.time_ <= var_144_32 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_34 = arg_141_1:FormatText(StoryNameCfg[1462].name)

				arg_141_1.leftNameTxt_.text = var_144_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_35 = arg_141_1:GetWordFromCfg(324562034)
				local var_144_36 = arg_141_1:FormatText(var_144_35.content)

				arg_141_1.text_.text = var_144_36

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_37 = 26
				local var_144_38 = utf8.len(var_144_36)
				local var_144_39 = var_144_37 <= 0 and var_144_33 or var_144_33 * (var_144_38 / var_144_37)

				if var_144_39 > 0 and var_144_33 < var_144_39 then
					arg_141_1.talkMaxDuration = var_144_39

					if var_144_39 + var_144_32 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_39 + var_144_32
					end
				end

				arg_141_1.text_.text = var_144_36
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562034", "story_v_out_324562.awb") ~= 0 then
					local var_144_40 = manager.audio:GetVoiceLength("story_v_out_324562", "324562034", "story_v_out_324562.awb") / 1000

					if var_144_40 + var_144_32 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_40 + var_144_32
					end

					if var_144_35.prefab_name ~= "" and arg_141_1.actors_[var_144_35.prefab_name] ~= nil then
						local var_144_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_35.prefab_name].transform, "story_v_out_324562", "324562034", "story_v_out_324562.awb")

						arg_141_1:RecordAudio("324562034", var_144_41)
						arg_141_1:RecordAudio("324562034", var_144_41)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_324562", "324562034", "story_v_out_324562.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_324562", "324562034", "story_v_out_324562.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_42 = math.max(var_144_33, arg_141_1.talkMaxDuration)

			if var_144_32 <= arg_141_1.time_ and arg_141_1.time_ < var_144_32 + var_144_42 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_32) / var_144_42

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_32 + var_144_42 and arg_141_1.time_ < var_144_32 + var_144_42 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10164ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1071ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play324562035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 324562035
		arg_145_1.duration_ = 9.43

		local var_145_0 = {
			zh = 9.433,
			ja = 8.933
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play324562036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1170ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1170ui_story == nil then
				arg_145_1.var_.characterEffect1170ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect1170ui_story and not isNil(var_148_0) then
					arg_145_1.var_.characterEffect1170ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1170ui_story then
				arg_145_1.var_.characterEffect1170ui_story.fillFlat = false
			end

			local var_148_4 = arg_145_1.actors_["10164ui_story"]
			local var_148_5 = 0

			if var_148_5 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10164ui_story == nil then
				arg_145_1.var_.characterEffect10164ui_story = var_148_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_6 = 0.200000002980232

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_6 and not isNil(var_148_4) then
				local var_148_7 = (arg_145_1.time_ - var_148_5) / var_148_6

				if arg_145_1.var_.characterEffect10164ui_story and not isNil(var_148_4) then
					local var_148_8 = Mathf.Lerp(0, 0.5, var_148_7)

					arg_145_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10164ui_story.fillRatio = var_148_8
				end
			end

			if arg_145_1.time_ >= var_148_5 + var_148_6 and arg_145_1.time_ < var_148_5 + var_148_6 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10164ui_story then
				local var_148_9 = 0.5

				arg_145_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10164ui_story.fillRatio = var_148_9
			end

			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/story1170/story1170action/1170action7_2")
			end

			local var_148_11 = 0

			if var_148_11 < arg_145_1.time_ and arg_145_1.time_ <= var_148_11 + arg_148_0 then
				arg_145_1:PlayTimeline("1170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_148_12 = 0
			local var_148_13 = 1.05

			if var_148_12 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_14 = arg_145_1:FormatText(StoryNameCfg[318].name)

				arg_145_1.leftNameTxt_.text = var_148_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_15 = arg_145_1:GetWordFromCfg(324562035)
				local var_148_16 = arg_145_1:FormatText(var_148_15.content)

				arg_145_1.text_.text = var_148_16

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_17 = 42
				local var_148_18 = utf8.len(var_148_16)
				local var_148_19 = var_148_17 <= 0 and var_148_13 or var_148_13 * (var_148_18 / var_148_17)

				if var_148_19 > 0 and var_148_13 < var_148_19 then
					arg_145_1.talkMaxDuration = var_148_19

					if var_148_19 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_19 + var_148_12
					end
				end

				arg_145_1.text_.text = var_148_16
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562035", "story_v_out_324562.awb") ~= 0 then
					local var_148_20 = manager.audio:GetVoiceLength("story_v_out_324562", "324562035", "story_v_out_324562.awb") / 1000

					if var_148_20 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_20 + var_148_12
					end

					if var_148_15.prefab_name ~= "" and arg_145_1.actors_[var_148_15.prefab_name] ~= nil then
						local var_148_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_15.prefab_name].transform, "story_v_out_324562", "324562035", "story_v_out_324562.awb")

						arg_145_1:RecordAudio("324562035", var_148_21)
						arg_145_1:RecordAudio("324562035", var_148_21)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_324562", "324562035", "story_v_out_324562.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_324562", "324562035", "story_v_out_324562.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_22 = math.max(var_148_13, arg_145_1.talkMaxDuration)

			if var_148_12 <= arg_145_1.time_ and arg_145_1.time_ < var_148_12 + var_148_22 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_12) / var_148_22

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_12 + var_148_22 and arg_145_1.time_ < var_148_12 + var_148_22 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play324562036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 324562036
		arg_149_1.duration_ = 3.3

		local var_149_0 = {
			zh = 2.966,
			ja = 3.3
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play324562037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10164ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10164ui_story == nil then
				arg_149_1.var_.characterEffect10164ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect10164ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10164ui_story then
				arg_149_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["1170ui_story"]
			local var_152_5 = 0

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1170ui_story == nil then
				arg_149_1.var_.characterEffect1170ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_6 = 0.200000002980232

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_6 and not isNil(var_152_4) then
				local var_152_7 = (arg_149_1.time_ - var_152_5) / var_152_6

				if arg_149_1.var_.characterEffect1170ui_story and not isNil(var_152_4) then
					local var_152_8 = Mathf.Lerp(0, 0.5, var_152_7)

					arg_149_1.var_.characterEffect1170ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1170ui_story.fillRatio = var_152_8
				end
			end

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect1170ui_story then
				local var_152_9 = 0.5

				arg_149_1.var_.characterEffect1170ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1170ui_story.fillRatio = var_152_9
			end

			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_1")
			end

			local var_152_11 = 0

			if var_152_11 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				arg_149_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_152_12 = 0
			local var_152_13 = 0.275

			if var_152_12 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_14 = arg_149_1:FormatText(StoryNameCfg[1462].name)

				arg_149_1.leftNameTxt_.text = var_152_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_15 = arg_149_1:GetWordFromCfg(324562036)
				local var_152_16 = arg_149_1:FormatText(var_152_15.content)

				arg_149_1.text_.text = var_152_16

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_17 = 11
				local var_152_18 = utf8.len(var_152_16)
				local var_152_19 = var_152_17 <= 0 and var_152_13 or var_152_13 * (var_152_18 / var_152_17)

				if var_152_19 > 0 and var_152_13 < var_152_19 then
					arg_149_1.talkMaxDuration = var_152_19

					if var_152_19 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_19 + var_152_12
					end
				end

				arg_149_1.text_.text = var_152_16
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562036", "story_v_out_324562.awb") ~= 0 then
					local var_152_20 = manager.audio:GetVoiceLength("story_v_out_324562", "324562036", "story_v_out_324562.awb") / 1000

					if var_152_20 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_20 + var_152_12
					end

					if var_152_15.prefab_name ~= "" and arg_149_1.actors_[var_152_15.prefab_name] ~= nil then
						local var_152_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_15.prefab_name].transform, "story_v_out_324562", "324562036", "story_v_out_324562.awb")

						arg_149_1:RecordAudio("324562036", var_152_21)
						arg_149_1:RecordAudio("324562036", var_152_21)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_324562", "324562036", "story_v_out_324562.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_324562", "324562036", "story_v_out_324562.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_22 = math.max(var_152_13, arg_149_1.talkMaxDuration)

			if var_152_12 <= arg_149_1.time_ and arg_149_1.time_ < var_152_12 + var_152_22 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_12) / var_152_22

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_12 + var_152_22 and arg_149_1.time_ < var_152_12 + var_152_22 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play324562037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 324562037
		arg_153_1.duration_ = 1.7

		local var_153_0 = {
			zh = 1.333,
			ja = 1.7
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play324562038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1071ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1071ui_story == nil then
				arg_153_1.var_.characterEffect1071ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1071ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1071ui_story then
				arg_153_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_156_4 = arg_153_1.actors_["10164ui_story"]
			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect10164ui_story == nil then
				arg_153_1.var_.characterEffect10164ui_story = var_156_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_6 = 0.200000002980232

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 and not isNil(var_156_4) then
				local var_156_7 = (arg_153_1.time_ - var_156_5) / var_156_6

				if arg_153_1.var_.characterEffect10164ui_story and not isNil(var_156_4) then
					local var_156_8 = Mathf.Lerp(0, 0.5, var_156_7)

					arg_153_1.var_.characterEffect10164ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10164ui_story.fillRatio = var_156_8
				end
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect10164ui_story then
				local var_156_9 = 0.5

				arg_153_1.var_.characterEffect10164ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10164ui_story.fillRatio = var_156_9
			end

			local var_156_10 = 0
			local var_156_11 = 0.15

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_12 = arg_153_1:FormatText(StoryNameCfg[384].name)

				arg_153_1.leftNameTxt_.text = var_156_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_13 = arg_153_1:GetWordFromCfg(324562037)
				local var_156_14 = arg_153_1:FormatText(var_156_13.content)

				arg_153_1.text_.text = var_156_14

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_15 = 6
				local var_156_16 = utf8.len(var_156_14)
				local var_156_17 = var_156_15 <= 0 and var_156_11 or var_156_11 * (var_156_16 / var_156_15)

				if var_156_17 > 0 and var_156_11 < var_156_17 then
					arg_153_1.talkMaxDuration = var_156_17

					if var_156_17 + var_156_10 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_17 + var_156_10
					end
				end

				arg_153_1.text_.text = var_156_14
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562037", "story_v_out_324562.awb") ~= 0 then
					local var_156_18 = manager.audio:GetVoiceLength("story_v_out_324562", "324562037", "story_v_out_324562.awb") / 1000

					if var_156_18 + var_156_10 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_18 + var_156_10
					end

					if var_156_13.prefab_name ~= "" and arg_153_1.actors_[var_156_13.prefab_name] ~= nil then
						local var_156_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_13.prefab_name].transform, "story_v_out_324562", "324562037", "story_v_out_324562.awb")

						arg_153_1:RecordAudio("324562037", var_156_19)
						arg_153_1:RecordAudio("324562037", var_156_19)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_324562", "324562037", "story_v_out_324562.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_324562", "324562037", "story_v_out_324562.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_20 = math.max(var_156_11, arg_153_1.talkMaxDuration)

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_20 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_10) / var_156_20

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_10 + var_156_20 and arg_153_1.time_ < var_156_10 + var_156_20 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play324562038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 324562038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play324562039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1071ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1071ui_story == nil then
				arg_157_1.var_.characterEffect1071ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect1071ui_story and not isNil(var_160_0) then
					local var_160_4 = Mathf.Lerp(0, 0.5, var_160_3)

					arg_157_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1071ui_story.fillRatio = var_160_4
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect1071ui_story then
				local var_160_5 = 0.5

				arg_157_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1071ui_story.fillRatio = var_160_5
			end

			local var_160_6 = 1.1
			local var_160_7 = 1

			if var_160_6 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				local var_160_8 = "play"
				local var_160_9 = "effect"

				arg_157_1:AudioAction(var_160_8, var_160_9, "se_story_side_1039", "se_story_1039_drawer", "")
			end

			local var_160_10 = 0
			local var_160_11 = 1.6

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_12 = arg_157_1:GetWordFromCfg(324562038)
				local var_160_13 = arg_157_1:FormatText(var_160_12.content)

				arg_157_1.text_.text = var_160_13

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_14 = 64
				local var_160_15 = utf8.len(var_160_13)
				local var_160_16 = var_160_14 <= 0 and var_160_11 or var_160_11 * (var_160_15 / var_160_14)

				if var_160_16 > 0 and var_160_11 < var_160_16 then
					arg_157_1.talkMaxDuration = var_160_16

					if var_160_16 + var_160_10 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_16 + var_160_10
					end
				end

				arg_157_1.text_.text = var_160_13
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_17 = math.max(var_160_11, arg_157_1.talkMaxDuration)

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_17 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_10) / var_160_17

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_10 + var_160_17 and arg_157_1.time_ < var_160_10 + var_160_17 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play324562039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 324562039
		arg_161_1.duration_ = 16.6

		local var_161_0 = {
			zh = 11.266,
			ja = 16.6
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play324562040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10164ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect10164ui_story == nil then
				arg_161_1.var_.characterEffect10164ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect10164ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect10164ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect10164ui_story then
				arg_161_1.var_.characterEffect10164ui_story.fillFlat = false
			end

			local var_164_4 = 0

			if var_164_4 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_2")
			end

			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1:PlayTimeline("10164ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_164_6 = 0
			local var_164_7 = 0.975

			if var_164_6 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_8 = arg_161_1:FormatText(StoryNameCfg[1462].name)

				arg_161_1.leftNameTxt_.text = var_164_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_9 = arg_161_1:GetWordFromCfg(324562039)
				local var_164_10 = arg_161_1:FormatText(var_164_9.content)

				arg_161_1.text_.text = var_164_10

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 39
				local var_164_12 = utf8.len(var_164_10)
				local var_164_13 = var_164_11 <= 0 and var_164_7 or var_164_7 * (var_164_12 / var_164_11)

				if var_164_13 > 0 and var_164_7 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_10
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562039", "story_v_out_324562.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_324562", "324562039", "story_v_out_324562.awb") / 1000

					if var_164_14 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_6
					end

					if var_164_9.prefab_name ~= "" and arg_161_1.actors_[var_164_9.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_9.prefab_name].transform, "story_v_out_324562", "324562039", "story_v_out_324562.awb")

						arg_161_1:RecordAudio("324562039", var_164_15)
						arg_161_1:RecordAudio("324562039", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_324562", "324562039", "story_v_out_324562.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_324562", "324562039", "story_v_out_324562.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_16 and arg_161_1.time_ < var_164_6 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play324562040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 324562040
		arg_165_1.duration_ = 7.47

		local var_165_0 = {
			zh = 7.466,
			ja = 7.133
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
			arg_165_1.auto_ = false
		end

		function arg_165_1.playNext_(arg_167_0)
			arg_165_1.onStoryFinished_()
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.525

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[1462].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(324562040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 21
				local var_168_6 = utf8.len(var_168_4)
				local var_168_7 = var_168_5 <= 0 and var_168_1 or var_168_1 * (var_168_6 / var_168_5)

				if var_168_7 > 0 and var_168_1 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_4
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324562", "324562040", "story_v_out_324562.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_324562", "324562040", "story_v_out_324562.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_324562", "324562040", "story_v_out_324562.awb")

						arg_165_1:RecordAudio("324562040", var_168_9)
						arg_165_1:RecordAudio("324562040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_324562", "324562040", "story_v_out_324562.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_324562", "324562040", "story_v_out_324562.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_10 and arg_165_1.time_ < var_168_0 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J21f",
		"TextureConfig/Background/ST32"
	},
	voices = {
		"story_v_out_324562.awb"
	}
}
