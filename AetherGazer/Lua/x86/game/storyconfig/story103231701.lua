return {
	Play323171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323171001
		arg_1_1.duration_ = 11.68

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play323171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J24g"

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
				local var_4_5 = arg_1_1.bgs_.J24g

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
					if iter_4_0 ~= "J24g" then
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
			local var_4_25 = 3
			local var_4_26 = "J24g"

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_26)

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				local var_4_27 = arg_1_1:GetWordFromCfg(102)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_timeText_.text = var_4_28
				arg_1_1.text_timeText_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				local var_4_29 = arg_1_1:GetWordFromCfg(501122)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_siteText_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_31 = 3

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_32 = 1.5

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_31) / var_4_32
				local var_4_34 = Color.New(0, 0, 0)

				var_4_34.a = Mathf.Lerp(0, 1, var_4_33)
				arg_1_1.mask_.color = var_4_34
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				local var_4_35 = Color.New(0, 0, 0)

				var_4_35.a = 1
				arg_1_1.mask_.color = var_4_35
			end

			local var_4_36 = 4.5

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_37 = 1.9

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				local var_4_38 = (arg_1_1.time_ - var_4_36) / var_4_37
				local var_4_39 = Color.New(0, 0, 0)

				var_4_39.a = Mathf.Lerp(1, 0, var_4_38)
				arg_1_1.mask_.color = var_4_39
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				local var_4_40 = Color.New(0, 0, 0)
				local var_4_41 = 0

				arg_1_1.mask_.enabled = false
				var_4_40.a = var_4_41
				arg_1_1.mask_.color = var_4_40
			end

			local var_4_42 = 0

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_43 = 8.23333333333333

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_44 = manager.ui.mainCamera.transform
			local var_4_45 = 4.5

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_46 = arg_1_1.var_.effectvvv
				local var_4_47
				local var_4_48 = var_4_44

				if not var_4_46 then
					var_4_46 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snowfast_keep"), var_4_48)
					var_4_46.name = "vvv"
					arg_1_1.var_.effectvvv = var_4_46
				else
					var_4_46.transform:SetParent(var_4_48)
				end

				var_4_46.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_46.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_49 = 1.7777777777777777
				local var_4_50 = Screen.width / Screen.height
				local var_4_51 = var_4_50 / var_4_49
				local var_4_52 = Mathf.Max(var_4_49 / var_4_50, 1)

				var_4_46.transform.localScale = Vector3.New(var_4_46.transform.localScale.x * var_4_51, var_4_46.transform.localScale.y * var_4_52, var_4_46.transform.localScale.z)
			end

			local var_4_53 = 0
			local var_4_54 = 0.3

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_57 = ""
				local var_4_58 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_58 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_58 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_58

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_58
						arg_1_1.bgmTxt2_.text = var_4_58
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

			local var_4_59 = 4.5
			local var_4_60 = 1

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				local var_4_61 = "play"
				local var_4_62 = "music"

				arg_1_1:AudioAction(var_4_61, var_4_62, "bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun.awb")

				local var_4_63 = ""
				local var_4_64 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain_kunlun", "bgm_activity_4_8_story_mountain_kunlun")

				if var_4_64 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_64 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_64

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_64
						arg_1_1.bgmTxt2_.text = var_4_64
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

			local var_4_65 = 4.23333333333333
			local var_4_66 = 1

			if var_4_65 < arg_1_1.time_ and arg_1_1.time_ <= var_4_65 + arg_4_0 then
				local var_4_67 = "play"
				local var_4_68 = "effect"

				arg_1_1:AudioAction(var_4_67, var_4_68, "se_story_148", "se_story_148_amb_wind", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_69 = 6.68333333333333
			local var_4_70 = 1.55

			if var_4_69 < arg_1_1.time_ and arg_1_1.time_ <= var_4_69 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_71 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_71:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_72 = arg_1_1:GetWordFromCfg(323171001)
				local var_4_73 = arg_1_1:FormatText(var_4_72.content)

				arg_1_1.text_.text = var_4_73

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_74 = 62
				local var_4_75 = utf8.len(var_4_73)
				local var_4_76 = var_4_74 <= 0 and var_4_70 or var_4_70 * (var_4_75 / var_4_74)

				if var_4_76 > 0 and var_4_70 < var_4_76 then
					arg_1_1.talkMaxDuration = var_4_76
					var_4_69 = var_4_69 + 0.3

					if var_4_76 + var_4_69 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_76 + var_4_69
					end
				end

				arg_1_1.text_.text = var_4_73
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_77 = var_4_69 + 0.3
			local var_4_78 = math.max(var_4_70, arg_1_1.talkMaxDuration)

			if var_4_77 <= arg_1_1.time_ and arg_1_1.time_ < var_4_77 + var_4_78 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_77) / var_4_78

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_77 + var_4_78 and arg_1_1.time_ < var_4_77 + var_4_78 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323171002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 323171002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play323171003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0.1
			local var_13_1 = 1

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				local var_13_2 = "play"
				local var_13_3 = "effect"

				arg_10_1:AudioAction(var_13_2, var_13_3, "se_story_148", "se_story_148_whoosh02", "")
			end

			local var_13_4 = 0
			local var_13_5 = 0.975

			if var_13_4 < arg_10_1.time_ and arg_10_1.time_ <= var_13_4 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_6 = arg_10_1:GetWordFromCfg(323171002)
				local var_13_7 = arg_10_1:FormatText(var_13_6.content)

				arg_10_1.text_.text = var_13_7

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_8 = 39
				local var_13_9 = utf8.len(var_13_7)
				local var_13_10 = var_13_8 <= 0 and var_13_5 or var_13_5 * (var_13_9 / var_13_8)

				if var_13_10 > 0 and var_13_5 < var_13_10 then
					arg_10_1.talkMaxDuration = var_13_10

					if var_13_10 + var_13_4 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_10 + var_13_4
					end
				end

				arg_10_1.text_.text = var_13_7
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_11 = math.max(var_13_5, arg_10_1.talkMaxDuration)

			if var_13_4 <= arg_10_1.time_ and arg_10_1.time_ < var_13_4 + var_13_11 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_4) / var_13_11

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_4 + var_13_11 and arg_10_1.time_ < var_13_4 + var_13_11 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play323171003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 323171003
		arg_14_1.duration_ = 6.87

		local var_14_0 = {
			zh = 3.833,
			ja = 6.866
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play323171004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = "1053ui_story"

			if arg_14_1.actors_[var_17_0] == nil then
				local var_17_1 = Asset.Load("Char/" .. "1053ui_story")

				if not isNil(var_17_1) then
					local var_17_2 = Object.Instantiate(Asset.Load("Char/" .. "1053ui_story"), arg_14_1.stage_.transform)

					var_17_2.name = var_17_0
					var_17_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_14_1.actors_[var_17_0] = var_17_2

					local var_17_3 = var_17_2:GetComponentInChildren(typeof(CharacterEffect))

					var_17_3.enabled = true

					local var_17_4 = GameObjectTools.GetOrAddComponent(var_17_2, typeof(DynamicBoneHelper))

					if var_17_4 then
						var_17_4:EnableDynamicBone(false)
					end

					arg_14_1:ShowWeapon(var_17_3.transform, false)

					arg_14_1.var_[var_17_0 .. "Animator"] = var_17_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_14_1.var_[var_17_0 .. "Animator"].applyRootMotion = true
					arg_14_1.var_[var_17_0 .. "LipSync"] = var_17_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_17_5 = arg_14_1.actors_["1053ui_story"].transform
			local var_17_6 = 0

			if var_17_6 < arg_14_1.time_ and arg_14_1.time_ <= var_17_6 + arg_17_0 then
				arg_14_1.var_.moveOldPos1053ui_story = var_17_5.localPosition

				local var_17_7 = GameObjectTools.GetOrAddComponent(var_17_5.gameObject, typeof(DynamicBoneHelper))

				if var_17_7 then
					var_17_7:EnableDynamicBone(false)
				end
			end

			local var_17_8 = 0.001

			if var_17_6 <= arg_14_1.time_ and arg_14_1.time_ < var_17_6 + var_17_8 then
				local var_17_9 = (arg_14_1.time_ - var_17_6) / var_17_8
				local var_17_10 = Vector3.New(0, -1.08, -6)

				var_17_5.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1053ui_story, var_17_10, var_17_9)

				local var_17_11 = manager.ui.mainCamera.transform.position - var_17_5.position

				var_17_5.forward = Vector3.New(var_17_11.x, var_17_11.y, var_17_11.z)

				local var_17_12 = var_17_5.localEulerAngles

				var_17_12.z = 0
				var_17_12.x = 0
				var_17_5.localEulerAngles = var_17_12
			end

			if arg_14_1.time_ >= var_17_6 + var_17_8 and arg_14_1.time_ < var_17_6 + var_17_8 + arg_17_0 then
				var_17_5.localPosition = Vector3.New(0, -1.08, -6)

				local var_17_13 = manager.ui.mainCamera.transform.position - var_17_5.position

				var_17_5.forward = Vector3.New(var_17_13.x, var_17_13.y, var_17_13.z)

				local var_17_14 = var_17_5.localEulerAngles

				var_17_14.z = 0
				var_17_14.x = 0
				var_17_5.localEulerAngles = var_17_14

				local var_17_15 = GameObjectTools.GetOrAddComponent(var_17_5.gameObject, typeof(DynamicBoneHelper))

				if var_17_15 then
					var_17_15:EnableDynamicBone(true)
				end
			end

			local var_17_16 = arg_14_1.actors_["1053ui_story"]
			local var_17_17 = 0

			if var_17_17 < arg_14_1.time_ and arg_14_1.time_ <= var_17_17 + arg_17_0 and not isNil(var_17_16) and arg_14_1.var_.characterEffect1053ui_story == nil then
				arg_14_1.var_.characterEffect1053ui_story = var_17_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_18 = 0.200000002980232

			if var_17_17 <= arg_14_1.time_ and arg_14_1.time_ < var_17_17 + var_17_18 and not isNil(var_17_16) then
				local var_17_19 = (arg_14_1.time_ - var_17_17) / var_17_18

				if arg_14_1.var_.characterEffect1053ui_story and not isNil(var_17_16) then
					arg_14_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_14_1.time_ >= var_17_17 + var_17_18 and arg_14_1.time_ < var_17_17 + var_17_18 + arg_17_0 and not isNil(var_17_16) and arg_14_1.var_.characterEffect1053ui_story then
				arg_14_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_17_20 = 0

			if var_17_20 < arg_14_1.time_ and arg_14_1.time_ <= var_17_20 + arg_17_0 then
				arg_14_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action3_1")
			end

			local var_17_21 = 0

			if var_17_21 < arg_14_1.time_ and arg_14_1.time_ <= var_17_21 + arg_17_0 then
				arg_14_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_17_22 = 0
			local var_17_23 = 0.4

			if var_17_22 < arg_14_1.time_ and arg_14_1.time_ <= var_17_22 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_24 = arg_14_1:FormatText(StoryNameCfg[472].name)

				arg_14_1.leftNameTxt_.text = var_17_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_25 = arg_14_1:GetWordFromCfg(323171003)
				local var_17_26 = arg_14_1:FormatText(var_17_25.content)

				arg_14_1.text_.text = var_17_26

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_27 = 16
				local var_17_28 = utf8.len(var_17_26)
				local var_17_29 = var_17_27 <= 0 and var_17_23 or var_17_23 * (var_17_28 / var_17_27)

				if var_17_29 > 0 and var_17_23 < var_17_29 then
					arg_14_1.talkMaxDuration = var_17_29

					if var_17_29 + var_17_22 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_29 + var_17_22
					end
				end

				arg_14_1.text_.text = var_17_26
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171003", "story_v_out_323171.awb") ~= 0 then
					local var_17_30 = manager.audio:GetVoiceLength("story_v_out_323171", "323171003", "story_v_out_323171.awb") / 1000

					if var_17_30 + var_17_22 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_30 + var_17_22
					end

					if var_17_25.prefab_name ~= "" and arg_14_1.actors_[var_17_25.prefab_name] ~= nil then
						local var_17_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_25.prefab_name].transform, "story_v_out_323171", "323171003", "story_v_out_323171.awb")

						arg_14_1:RecordAudio("323171003", var_17_31)
						arg_14_1:RecordAudio("323171003", var_17_31)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_323171", "323171003", "story_v_out_323171.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_323171", "323171003", "story_v_out_323171.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_32 = math.max(var_17_23, arg_14_1.talkMaxDuration)

			if var_17_22 <= arg_14_1.time_ and arg_14_1.time_ < var_17_22 + var_17_32 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_22) / var_17_32

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_22 + var_17_32 and arg_14_1.time_ < var_17_22 + var_17_32 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play323171004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 323171004
		arg_18_1.duration_ = 6.5

		local var_18_0 = {
			zh = 4.4,
			ja = 6.5
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
				arg_18_0:Play323171005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 0.375

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[472].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_3 = arg_18_1:GetWordFromCfg(323171004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 15
				local var_21_6 = utf8.len(var_21_4)
				local var_21_7 = var_21_5 <= 0 and var_21_1 or var_21_1 * (var_21_6 / var_21_5)

				if var_21_7 > 0 and var_21_1 < var_21_7 then
					arg_18_1.talkMaxDuration = var_21_7

					if var_21_7 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_7 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_4
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171004", "story_v_out_323171.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_323171", "323171004", "story_v_out_323171.awb") / 1000

					if var_21_8 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_0
					end

					if var_21_3.prefab_name ~= "" and arg_18_1.actors_[var_21_3.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_3.prefab_name].transform, "story_v_out_323171", "323171004", "story_v_out_323171.awb")

						arg_18_1:RecordAudio("323171004", var_21_9)
						arg_18_1:RecordAudio("323171004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_323171", "323171004", "story_v_out_323171.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_323171", "323171004", "story_v_out_323171.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_10 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_10 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_10

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_10 and arg_18_1.time_ < var_21_0 + var_21_10 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play323171005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 323171005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play323171006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1053ui_story"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1053ui_story == nil then
				arg_22_1.var_.characterEffect1053ui_story = var_25_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.200000002980232

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.characterEffect1053ui_story and not isNil(var_25_0) then
					local var_25_4 = Mathf.Lerp(0, 0.5, var_25_3)

					arg_22_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_22_1.var_.characterEffect1053ui_story.fillRatio = var_25_4
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1053ui_story then
				local var_25_5 = 0.5

				arg_22_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_22_1.var_.characterEffect1053ui_story.fillRatio = var_25_5
			end

			local var_25_6 = 0.1
			local var_25_7 = 1

			if var_25_6 < arg_22_1.time_ and arg_22_1.time_ <= var_25_6 + arg_25_0 then
				local var_25_8 = "play"
				local var_25_9 = "effect"

				arg_22_1:AudioAction(var_25_8, var_25_9, "se_story_148", "se_story_148_whoosh03", "")
			end

			local var_25_10 = arg_22_1.actors_["1053ui_story"].transform
			local var_25_11 = 0

			if var_25_11 < arg_22_1.time_ and arg_22_1.time_ <= var_25_11 + arg_25_0 then
				arg_22_1.var_.moveOldPos1053ui_story = var_25_10.localPosition

				local var_25_12 = GameObjectTools.GetOrAddComponent(var_25_10.gameObject, typeof(DynamicBoneHelper))

				if var_25_12 then
					var_25_12:EnableDynamicBone(false)
				end
			end

			local var_25_13 = 0.001

			if var_25_11 <= arg_22_1.time_ and arg_22_1.time_ < var_25_11 + var_25_13 then
				local var_25_14 = (arg_22_1.time_ - var_25_11) / var_25_13
				local var_25_15 = Vector3.New(0, 100, 0)

				var_25_10.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1053ui_story, var_25_15, var_25_14)

				local var_25_16 = manager.ui.mainCamera.transform.position - var_25_10.position

				var_25_10.forward = Vector3.New(var_25_16.x, var_25_16.y, var_25_16.z)

				local var_25_17 = var_25_10.localEulerAngles

				var_25_17.z = 0
				var_25_17.x = 0
				var_25_10.localEulerAngles = var_25_17
			end

			if arg_22_1.time_ >= var_25_11 + var_25_13 and arg_22_1.time_ < var_25_11 + var_25_13 + arg_25_0 then
				var_25_10.localPosition = Vector3.New(0, 100, 0)

				local var_25_18 = manager.ui.mainCamera.transform.position - var_25_10.position

				var_25_10.forward = Vector3.New(var_25_18.x, var_25_18.y, var_25_18.z)

				local var_25_19 = var_25_10.localEulerAngles

				var_25_19.z = 0
				var_25_19.x = 0
				var_25_10.localEulerAngles = var_25_19

				local var_25_20 = GameObjectTools.GetOrAddComponent(var_25_10.gameObject, typeof(DynamicBoneHelper))

				if var_25_20 then
					var_25_20:EnableDynamicBone(true)
				end
			end

			local var_25_21 = 0
			local var_25_22 = 1.175

			if var_25_21 < arg_22_1.time_ and arg_22_1.time_ <= var_25_21 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_23 = arg_22_1:GetWordFromCfg(323171005)
				local var_25_24 = arg_22_1:FormatText(var_25_23.content)

				arg_22_1.text_.text = var_25_24

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_25 = 47
				local var_25_26 = utf8.len(var_25_24)
				local var_25_27 = var_25_25 <= 0 and var_25_22 or var_25_22 * (var_25_26 / var_25_25)

				if var_25_27 > 0 and var_25_22 < var_25_27 then
					arg_22_1.talkMaxDuration = var_25_27

					if var_25_27 + var_25_21 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_27 + var_25_21
					end
				end

				arg_22_1.text_.text = var_25_24
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_28 = math.max(var_25_22, arg_22_1.talkMaxDuration)

			if var_25_21 <= arg_22_1.time_ and arg_22_1.time_ < var_25_21 + var_25_28 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_21) / var_25_28

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_21 + var_25_28 and arg_22_1.time_ < var_25_21 + var_25_28 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play323171006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 323171006
		arg_26_1.duration_ = 2

		local var_26_0 = {
			zh = 2,
			ja = 1.266
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
				arg_26_0:Play323171007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 0.125

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_2 = arg_26_1:FormatText(StoryNameCfg[472].name)

				arg_26_1.leftNameTxt_.text = var_29_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1053")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_3 = arg_26_1:GetWordFromCfg(323171006)
				local var_29_4 = arg_26_1:FormatText(var_29_3.content)

				arg_26_1.text_.text = var_29_4

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_5 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171006", "story_v_out_323171.awb") ~= 0 then
					local var_29_8 = manager.audio:GetVoiceLength("story_v_out_323171", "323171006", "story_v_out_323171.awb") / 1000

					if var_29_8 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_0
					end

					if var_29_3.prefab_name ~= "" and arg_26_1.actors_[var_29_3.prefab_name] ~= nil then
						local var_29_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_3.prefab_name].transform, "story_v_out_323171", "323171006", "story_v_out_323171.awb")

						arg_26_1:RecordAudio("323171006", var_29_9)
						arg_26_1:RecordAudio("323171006", var_29_9)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_323171", "323171006", "story_v_out_323171.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_323171", "323171006", "story_v_out_323171.awb")
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
	Play323171007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 323171007
		arg_30_1.duration_ = 7.77

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play323171008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1053ui_story"].transform
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.var_.moveOldPos1053ui_story = var_33_0.localPosition

				local var_33_2 = GameObjectTools.GetOrAddComponent(var_33_0.gameObject, typeof(DynamicBoneHelper))

				if var_33_2 then
					var_33_2:EnableDynamicBone(false)
				end
			end

			local var_33_3 = 0.001

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_3 then
				local var_33_4 = (arg_30_1.time_ - var_33_1) / var_33_3
				local var_33_5 = Vector3.New(0, 100, 0)

				var_33_0.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1053ui_story, var_33_5, var_33_4)

				local var_33_6 = manager.ui.mainCamera.transform.position - var_33_0.position

				var_33_0.forward = Vector3.New(var_33_6.x, var_33_6.y, var_33_6.z)

				local var_33_7 = var_33_0.localEulerAngles

				var_33_7.z = 0
				var_33_7.x = 0
				var_33_0.localEulerAngles = var_33_7
			end

			if arg_30_1.time_ >= var_33_1 + var_33_3 and arg_30_1.time_ < var_33_1 + var_33_3 + arg_33_0 then
				var_33_0.localPosition = Vector3.New(0, 100, 0)

				local var_33_8 = manager.ui.mainCamera.transform.position - var_33_0.position

				var_33_0.forward = Vector3.New(var_33_8.x, var_33_8.y, var_33_8.z)

				local var_33_9 = var_33_0.localEulerAngles

				var_33_9.z = 0
				var_33_9.x = 0
				var_33_0.localEulerAngles = var_33_9

				local var_33_10 = GameObjectTools.GetOrAddComponent(var_33_0.gameObject, typeof(DynamicBoneHelper))

				if var_33_10 then
					var_33_10:EnableDynamicBone(true)
				end
			end

			local var_33_11 = arg_30_1.actors_["1053ui_story"]
			local var_33_12 = 0

			if var_33_12 < arg_30_1.time_ and arg_30_1.time_ <= var_33_12 + arg_33_0 and not isNil(var_33_11) and arg_30_1.var_.characterEffect1053ui_story == nil then
				arg_30_1.var_.characterEffect1053ui_story = var_33_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_13 = 0.200000002980232

			if var_33_12 <= arg_30_1.time_ and arg_30_1.time_ < var_33_12 + var_33_13 and not isNil(var_33_11) then
				local var_33_14 = (arg_30_1.time_ - var_33_12) / var_33_13

				if arg_30_1.var_.characterEffect1053ui_story and not isNil(var_33_11) then
					local var_33_15 = Mathf.Lerp(0, 0.5, var_33_14)

					arg_30_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1053ui_story.fillRatio = var_33_15
				end
			end

			if arg_30_1.time_ >= var_33_12 + var_33_13 and arg_30_1.time_ < var_33_12 + var_33_13 + arg_33_0 and not isNil(var_33_11) and arg_30_1.var_.characterEffect1053ui_story then
				local var_33_16 = 0.5

				arg_30_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1053ui_story.fillRatio = var_33_16
			end

			local var_33_17 = manager.ui.mainCamera.transform
			local var_33_18 = 0

			if var_33_18 < arg_30_1.time_ and arg_30_1.time_ <= var_33_18 + arg_33_0 then
				local var_33_19 = arg_30_1.var_.effectvvv1
				local var_33_20
				local var_33_21 = var_33_17

				if not var_33_19 then
					var_33_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snowfast_out"), var_33_21)
					var_33_19.name = "vvv1"
					arg_30_1.var_.effectvvv1 = var_33_19
				else
					var_33_19.transform:SetParent(var_33_21)
				end

				var_33_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_33_19.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_33_22 = 1.7777777777777777
				local var_33_23 = Screen.width / Screen.height
				local var_33_24 = var_33_23 / var_33_22
				local var_33_25 = Mathf.Max(var_33_22 / var_33_23, 1)

				var_33_19.transform.localScale = Vector3.New(var_33_19.transform.localScale.x * var_33_24, var_33_19.transform.localScale.y * var_33_25, var_33_19.transform.localScale.z)
			end

			local var_33_26 = manager.ui.mainCamera.transform
			local var_33_27 = 0

			if var_33_27 < arg_30_1.time_ and arg_30_1.time_ <= var_33_27 + arg_33_0 then
				local var_33_28 = arg_30_1.var_.effectvvv

				if var_33_28 then
					Object.Destroy(var_33_28)

					arg_30_1.var_.effectvvv = nil
				end
			end

			local var_33_29 = manager.ui.mainCamera.transform
			local var_33_30 = 0.566666666666667

			if var_33_30 < arg_30_1.time_ and arg_30_1.time_ <= var_33_30 + arg_33_0 then
				local var_33_31 = arg_30_1.var_.effect444
				local var_33_32
				local var_33_33 = var_33_29

				if not var_33_31 then
					var_33_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_33_33)
					var_33_31.name = "444"
					arg_30_1.var_.effect444 = var_33_31
				else
					var_33_31.transform:SetParent(var_33_33)
				end

				var_33_31.transform.localPosition = Vector3.New(0, 0, 0)
				var_33_31.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_33_34 = 1.7777777777777777
				local var_33_35 = Screen.width / Screen.height
				local var_33_36 = var_33_35 / var_33_34
				local var_33_37 = Mathf.Max(var_33_34 / var_33_35, 1)
				local var_33_38 = Mathf.Max(var_33_36, var_33_37)

				var_33_31.transform.localScale = Vector3.New(var_33_31.transform.localScale.x * var_33_38, var_33_31.transform.localScale.y * var_33_38, var_33_31.transform.localScale.z * var_33_38)
			end

			local var_33_39 = manager.ui.mainCamera.transform
			local var_33_40 = 1.2

			if var_33_40 < arg_30_1.time_ and arg_30_1.time_ <= var_33_40 + arg_33_0 then
				local var_33_41 = arg_30_1.var_.effect4441
				local var_33_42
				local var_33_43 = var_33_39

				if not var_33_41 then
					var_33_41 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_33_43)
					var_33_41.name = "4441"
					arg_30_1.var_.effect4441 = var_33_41
				else
					var_33_41.transform:SetParent(var_33_43)
				end

				var_33_41.transform.localPosition = Vector3.New(0, 0.13, -1.73)
				var_33_41.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_33_44 = 1.7777777777777777
				local var_33_45 = Screen.width / Screen.height
				local var_33_46 = var_33_45 / var_33_44
				local var_33_47 = Mathf.Max(var_33_44 / var_33_45, 1)
				local var_33_48 = Mathf.Max(var_33_46, var_33_47)

				var_33_41.transform.localScale = Vector3.New(var_33_41.transform.localScale.x * var_33_48, var_33_41.transform.localScale.y * var_33_48, var_33_41.transform.localScale.z * var_33_48)
			end

			local var_33_49 = 0

			if var_33_49 < arg_30_1.time_ and arg_30_1.time_ <= var_33_49 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			local var_33_50 = 2.96666666666667

			if arg_30_1.time_ >= var_33_49 + var_33_50 and arg_30_1.time_ < var_33_49 + var_33_50 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			local var_33_51 = 0.566666666666667
			local var_33_52 = 1

			if var_33_51 < arg_30_1.time_ and arg_30_1.time_ <= var_33_51 + arg_33_0 then
				local var_33_53 = "play"
				local var_33_54 = "effect"

				arg_30_1:AudioAction(var_33_53, var_33_54, "se_story_148", "se_story_148_energy", "")
			end

			local var_33_55 = manager.ui.mainCamera.transform
			local var_33_56 = 0

			if var_33_56 < arg_30_1.time_ and arg_30_1.time_ <= var_33_56 + arg_33_0 then
				local var_33_57 = arg_30_1.var_.effectvvv

				if var_33_57 then
					Object.Destroy(var_33_57)

					arg_30_1.var_.effectvvv = nil
				end
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_58 = 2.76666666666667
			local var_33_59 = 1.425

			if var_33_58 < arg_30_1.time_ and arg_30_1.time_ <= var_33_58 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_60 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_60:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_30_1.dialogCg_.alpha = arg_34_0
				end))
				var_33_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_61 = arg_30_1:GetWordFromCfg(323171007)
				local var_33_62 = arg_30_1:FormatText(var_33_61.content)

				arg_30_1.text_.text = var_33_62

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_63 = 57
				local var_33_64 = utf8.len(var_33_62)
				local var_33_65 = var_33_63 <= 0 and var_33_59 or var_33_59 * (var_33_64 / var_33_63)

				if var_33_65 > 0 and var_33_59 < var_33_65 then
					arg_30_1.talkMaxDuration = var_33_65
					var_33_58 = var_33_58 + 0.3

					if var_33_65 + var_33_58 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_65 + var_33_58
					end
				end

				arg_30_1.text_.text = var_33_62
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_66 = var_33_58 + 0.3
			local var_33_67 = math.max(var_33_59, arg_30_1.talkMaxDuration)

			if var_33_66 <= arg_30_1.time_ and arg_30_1.time_ < var_33_66 + var_33_67 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_66) / var_33_67

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_66 + var_33_67 and arg_30_1.time_ < var_33_66 + var_33_67 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323171008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 323171008
		arg_36_1.duration_ = 6.3

		local var_36_0 = {
			zh = 4.99966666666667,
			ja = 6.29966666666667
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
				arg_36_0:Play323171009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "ST2005"

			if arg_36_1.bgs_[var_39_0] == nil then
				local var_39_1 = Object.Instantiate(arg_36_1.paintGo_)

				var_39_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_39_0)
				var_39_1.name = var_39_0
				var_39_1.transform.parent = arg_36_1.stage_.transform
				var_39_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.bgs_[var_39_0] = var_39_1
			end

			local var_39_2 = 1.53333333333333

			if var_39_2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				local var_39_3 = manager.ui.mainCamera.transform.localPosition
				local var_39_4 = Vector3.New(0, 0, 10) + Vector3.New(var_39_3.x, var_39_3.y, 0)
				local var_39_5 = arg_36_1.bgs_.ST2005

				var_39_5.transform.localPosition = var_39_4
				var_39_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_39_6 = var_39_5:GetComponent("SpriteRenderer")

				if var_39_6 and var_39_6.sprite then
					local var_39_7 = (var_39_5.transform.localPosition - var_39_3).z
					local var_39_8 = manager.ui.mainCameraCom_
					local var_39_9 = 2 * var_39_7 * Mathf.Tan(var_39_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_39_10 = var_39_9 * var_39_8.aspect
					local var_39_11 = var_39_6.sprite.bounds.size.x
					local var_39_12 = var_39_6.sprite.bounds.size.y
					local var_39_13 = var_39_10 / var_39_11
					local var_39_14 = var_39_9 / var_39_12
					local var_39_15 = var_39_14 < var_39_13 and var_39_13 or var_39_14

					var_39_5.transform.localScale = Vector3.New(var_39_15, var_39_15, 0)
				end

				for iter_39_0, iter_39_1 in pairs(arg_36_1.bgs_) do
					if iter_39_0 ~= "ST2005" then
						iter_39_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_39_16 = 0

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			local var_39_17 = 0.3

			if arg_36_1.time_ >= var_39_16 + var_39_17 and arg_36_1.time_ < var_39_16 + var_39_17 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			local var_39_18 = 0

			if var_39_18 < arg_36_1.time_ and arg_36_1.time_ <= var_39_18 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_19 = 1.53333333333333

			if var_39_18 <= arg_36_1.time_ and arg_36_1.time_ < var_39_18 + var_39_19 then
				local var_39_20 = (arg_36_1.time_ - var_39_18) / var_39_19
				local var_39_21 = Color.New(0, 0, 0)

				var_39_21.a = Mathf.Lerp(0, 1, var_39_20)
				arg_36_1.mask_.color = var_39_21
			end

			if arg_36_1.time_ >= var_39_18 + var_39_19 and arg_36_1.time_ < var_39_18 + var_39_19 + arg_39_0 then
				local var_39_22 = Color.New(0, 0, 0)

				var_39_22.a = 1
				arg_36_1.mask_.color = var_39_22
			end

			local var_39_23 = 1.53333333333333

			if var_39_23 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_24 = 2

			if var_39_23 <= arg_36_1.time_ and arg_36_1.time_ < var_39_23 + var_39_24 then
				local var_39_25 = (arg_36_1.time_ - var_39_23) / var_39_24
				local var_39_26 = Color.New(0, 0, 0)

				var_39_26.a = Mathf.Lerp(1, 0, var_39_25)
				arg_36_1.mask_.color = var_39_26
			end

			if arg_36_1.time_ >= var_39_23 + var_39_24 and arg_36_1.time_ < var_39_23 + var_39_24 + arg_39_0 then
				local var_39_27 = Color.New(0, 0, 0)
				local var_39_28 = 0

				arg_36_1.mask_.enabled = false
				var_39_27.a = var_39_28
				arg_36_1.mask_.color = var_39_27
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_29 = 3.16666666666667
			local var_39_30 = 0.125

			if var_39_29 < arg_36_1.time_ and arg_36_1.time_ <= var_39_29 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_31 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_31:setOnUpdate(LuaHelper.FloatAction(function(arg_40_0)
					arg_36_1.dialogCg_.alpha = arg_40_0
				end))
				var_39_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_32 = arg_36_1:FormatText(StoryNameCfg[1454].name)

				arg_36_1.leftNameTxt_.text = var_39_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_33 = arg_36_1:GetWordFromCfg(323171008)
				local var_39_34 = arg_36_1:FormatText(var_39_33.content)

				arg_36_1.text_.text = var_39_34

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_35 = 5
				local var_39_36 = utf8.len(var_39_34)
				local var_39_37 = var_39_35 <= 0 and var_39_30 or var_39_30 * (var_39_36 / var_39_35)

				if var_39_37 > 0 and var_39_30 < var_39_37 then
					arg_36_1.talkMaxDuration = var_39_37
					var_39_29 = var_39_29 + 0.3

					if var_39_37 + var_39_29 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_37 + var_39_29
					end
				end

				arg_36_1.text_.text = var_39_34
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171008", "story_v_out_323171.awb") ~= 0 then
					local var_39_38 = manager.audio:GetVoiceLength("story_v_out_323171", "323171008", "story_v_out_323171.awb") / 1000

					if var_39_38 + var_39_29 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_38 + var_39_29
					end

					if var_39_33.prefab_name ~= "" and arg_36_1.actors_[var_39_33.prefab_name] ~= nil then
						local var_39_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_33.prefab_name].transform, "story_v_out_323171", "323171008", "story_v_out_323171.awb")

						arg_36_1:RecordAudio("323171008", var_39_39)
						arg_36_1:RecordAudio("323171008", var_39_39)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_323171", "323171008", "story_v_out_323171.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_323171", "323171008", "story_v_out_323171.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_40 = var_39_29 + 0.3
			local var_39_41 = math.max(var_39_30, arg_36_1.talkMaxDuration)

			if var_39_40 <= arg_36_1.time_ and arg_36_1.time_ < var_39_40 + var_39_41 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_40) / var_39_41

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_40 + var_39_41 and arg_36_1.time_ < var_39_40 + var_39_41 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play323171009 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 323171009
		arg_42_1.duration_ = 2.53

		local var_42_0 = {
			zh = 1.999999999999,
			ja = 2.533
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
				arg_42_0:Play323171010(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1053ui_story"].transform
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.var_.moveOldPos1053ui_story = var_45_0.localPosition

				local var_45_2 = GameObjectTools.GetOrAddComponent(var_45_0.gameObject, typeof(DynamicBoneHelper))

				if var_45_2 then
					var_45_2:EnableDynamicBone(false)
				end
			end

			local var_45_3 = 0.001

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_3 then
				local var_45_4 = (arg_42_1.time_ - var_45_1) / var_45_3
				local var_45_5 = Vector3.New(0, 100, 0)

				var_45_0.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1053ui_story, var_45_5, var_45_4)

				local var_45_6 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_6.x, var_45_6.y, var_45_6.z)

				local var_45_7 = var_45_0.localEulerAngles

				var_45_7.z = 0
				var_45_7.x = 0
				var_45_0.localEulerAngles = var_45_7
			end

			if arg_42_1.time_ >= var_45_1 + var_45_3 and arg_42_1.time_ < var_45_1 + var_45_3 + arg_45_0 then
				var_45_0.localPosition = Vector3.New(0, 100, 0)

				local var_45_8 = manager.ui.mainCamera.transform.position - var_45_0.position

				var_45_0.forward = Vector3.New(var_45_8.x, var_45_8.y, var_45_8.z)

				local var_45_9 = var_45_0.localEulerAngles

				var_45_9.z = 0
				var_45_9.x = 0
				var_45_0.localEulerAngles = var_45_9

				local var_45_10 = GameObjectTools.GetOrAddComponent(var_45_0.gameObject, typeof(DynamicBoneHelper))

				if var_45_10 then
					var_45_10:EnableDynamicBone(true)
				end
			end

			local var_45_11 = arg_42_1.actors_["1053ui_story"]
			local var_45_12 = 0

			if var_45_12 < arg_42_1.time_ and arg_42_1.time_ <= var_45_12 + arg_45_0 and not isNil(var_45_11) and arg_42_1.var_.characterEffect1053ui_story == nil then
				arg_42_1.var_.characterEffect1053ui_story = var_45_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_13 = 0.200000002980232

			if var_45_12 <= arg_42_1.time_ and arg_42_1.time_ < var_45_12 + var_45_13 and not isNil(var_45_11) then
				local var_45_14 = (arg_42_1.time_ - var_45_12) / var_45_13

				if arg_42_1.var_.characterEffect1053ui_story and not isNil(var_45_11) then
					arg_42_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_12 + var_45_13 and arg_42_1.time_ < var_45_12 + var_45_13 + arg_45_0 and not isNil(var_45_11) and arg_42_1.var_.characterEffect1053ui_story then
				arg_42_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_45_15 = 0

			if var_45_15 < arg_42_1.time_ and arg_42_1.time_ <= var_45_15 + arg_45_0 then
				arg_42_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_45_16 = 0

			if var_45_16 < arg_42_1.time_ and arg_42_1.time_ <= var_45_16 + arg_45_0 then
				arg_42_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_45_17 = 0
			local var_45_18 = 0.125

			if var_45_17 < arg_42_1.time_ and arg_42_1.time_ <= var_45_17 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_19 = arg_42_1:FormatText(StoryNameCfg[472].name)

				arg_42_1.leftNameTxt_.text = var_45_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1053")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_20 = arg_42_1:GetWordFromCfg(323171009)
				local var_45_21 = arg_42_1:FormatText(var_45_20.content)

				arg_42_1.text_.text = var_45_21

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_22 = 5
				local var_45_23 = utf8.len(var_45_21)
				local var_45_24 = var_45_22 <= 0 and var_45_18 or var_45_18 * (var_45_23 / var_45_22)

				if var_45_24 > 0 and var_45_18 < var_45_24 then
					arg_42_1.talkMaxDuration = var_45_24

					if var_45_24 + var_45_17 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_24 + var_45_17
					end
				end

				arg_42_1.text_.text = var_45_21
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171009", "story_v_out_323171.awb") ~= 0 then
					local var_45_25 = manager.audio:GetVoiceLength("story_v_out_323171", "323171009", "story_v_out_323171.awb") / 1000

					if var_45_25 + var_45_17 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_25 + var_45_17
					end

					if var_45_20.prefab_name ~= "" and arg_42_1.actors_[var_45_20.prefab_name] ~= nil then
						local var_45_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_20.prefab_name].transform, "story_v_out_323171", "323171009", "story_v_out_323171.awb")

						arg_42_1:RecordAudio("323171009", var_45_26)
						arg_42_1:RecordAudio("323171009", var_45_26)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_323171", "323171009", "story_v_out_323171.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_323171", "323171009", "story_v_out_323171.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_27 = math.max(var_45_18, arg_42_1.talkMaxDuration)

			if var_45_17 <= arg_42_1.time_ and arg_42_1.time_ < var_45_17 + var_45_27 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_17) / var_45_27

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_17 + var_45_27 and arg_42_1.time_ < var_45_17 + var_45_27 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323171010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 323171010
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play323171011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1053ui_story"].transform
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.var_.moveOldPos1053ui_story = var_49_0.localPosition

				local var_49_2 = GameObjectTools.GetOrAddComponent(var_49_0.gameObject, typeof(DynamicBoneHelper))

				if var_49_2 then
					var_49_2:EnableDynamicBone(false)
				end
			end

			local var_49_3 = 0.001

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_3 then
				local var_49_4 = (arg_46_1.time_ - var_49_1) / var_49_3
				local var_49_5 = Vector3.New(0, 100, 0)

				var_49_0.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1053ui_story, var_49_5, var_49_4)

				local var_49_6 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_6.x, var_49_6.y, var_49_6.z)

				local var_49_7 = var_49_0.localEulerAngles

				var_49_7.z = 0
				var_49_7.x = 0
				var_49_0.localEulerAngles = var_49_7
			end

			if arg_46_1.time_ >= var_49_1 + var_49_3 and arg_46_1.time_ < var_49_1 + var_49_3 + arg_49_0 then
				var_49_0.localPosition = Vector3.New(0, 100, 0)

				local var_49_8 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_8.x, var_49_8.y, var_49_8.z)

				local var_49_9 = var_49_0.localEulerAngles

				var_49_9.z = 0
				var_49_9.x = 0
				var_49_0.localEulerAngles = var_49_9

				local var_49_10 = GameObjectTools.GetOrAddComponent(var_49_0.gameObject, typeof(DynamicBoneHelper))

				if var_49_10 then
					var_49_10:EnableDynamicBone(true)
				end
			end

			local var_49_11 = arg_46_1.actors_["1053ui_story"]
			local var_49_12 = 0

			if var_49_12 < arg_46_1.time_ and arg_46_1.time_ <= var_49_12 + arg_49_0 and not isNil(var_49_11) and arg_46_1.var_.characterEffect1053ui_story == nil then
				arg_46_1.var_.characterEffect1053ui_story = var_49_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_13 = 0.200000002980232

			if var_49_12 <= arg_46_1.time_ and arg_46_1.time_ < var_49_12 + var_49_13 and not isNil(var_49_11) then
				local var_49_14 = (arg_46_1.time_ - var_49_12) / var_49_13

				if arg_46_1.var_.characterEffect1053ui_story and not isNil(var_49_11) then
					local var_49_15 = Mathf.Lerp(0, 0.5, var_49_14)

					arg_46_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1053ui_story.fillRatio = var_49_15
				end
			end

			if arg_46_1.time_ >= var_49_12 + var_49_13 and arg_46_1.time_ < var_49_12 + var_49_13 + arg_49_0 and not isNil(var_49_11) and arg_46_1.var_.characterEffect1053ui_story then
				local var_49_16 = 0.5

				arg_46_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1053ui_story.fillRatio = var_49_16
			end

			local var_49_17 = 0
			local var_49_18 = 1

			if var_49_17 < arg_46_1.time_ and arg_46_1.time_ <= var_49_17 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_19 = arg_46_1:GetWordFromCfg(323171010)
				local var_49_20 = arg_46_1:FormatText(var_49_19.content)

				arg_46_1.text_.text = var_49_20

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_21 = 40
				local var_49_22 = utf8.len(var_49_20)
				local var_49_23 = var_49_21 <= 0 and var_49_18 or var_49_18 * (var_49_22 / var_49_21)

				if var_49_23 > 0 and var_49_18 < var_49_23 then
					arg_46_1.talkMaxDuration = var_49_23

					if var_49_23 + var_49_17 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_23 + var_49_17
					end
				end

				arg_46_1.text_.text = var_49_20
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_24 = math.max(var_49_18, arg_46_1.talkMaxDuration)

			if var_49_17 <= arg_46_1.time_ and arg_46_1.time_ < var_49_17 + var_49_24 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_17) / var_49_24

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_17 + var_49_24 and arg_46_1.time_ < var_49_17 + var_49_24 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play323171011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 323171011
		arg_50_1.duration_ = 4.5

		local var_50_0 = {
			zh = 2.666,
			ja = 4.5
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play323171012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0
			local var_53_1 = 0.275

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_2 = arg_50_1:FormatText(StoryNameCfg[1454].name)

				arg_50_1.leftNameTxt_.text = var_53_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_3 = arg_50_1:GetWordFromCfg(323171011)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 11
				local var_53_6 = utf8.len(var_53_4)
				local var_53_7 = var_53_5 <= 0 and var_53_1 or var_53_1 * (var_53_6 / var_53_5)

				if var_53_7 > 0 and var_53_1 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171011", "story_v_out_323171.awb") ~= 0 then
					local var_53_8 = manager.audio:GetVoiceLength("story_v_out_323171", "323171011", "story_v_out_323171.awb") / 1000

					if var_53_8 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_8 + var_53_0
					end

					if var_53_3.prefab_name ~= "" and arg_50_1.actors_[var_53_3.prefab_name] ~= nil then
						local var_53_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_3.prefab_name].transform, "story_v_out_323171", "323171011", "story_v_out_323171.awb")

						arg_50_1:RecordAudio("323171011", var_53_9)
						arg_50_1:RecordAudio("323171011", var_53_9)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_323171", "323171011", "story_v_out_323171.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_323171", "323171011", "story_v_out_323171.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_10 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_10 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_10

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_10 and arg_50_1.time_ < var_53_0 + var_53_10 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play323171012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 323171012
		arg_54_1.duration_ = 9.93

		local var_54_0 = {
			zh = 7.866,
			ja = 9.933
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
				arg_54_0:Play323171013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1053ui_story"].transform
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.var_.moveOldPos1053ui_story = var_57_0.localPosition

				local var_57_2 = GameObjectTools.GetOrAddComponent(var_57_0.gameObject, typeof(DynamicBoneHelper))

				if var_57_2 then
					var_57_2:EnableDynamicBone(false)
				end
			end

			local var_57_3 = 0.001

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_3 then
				local var_57_4 = (arg_54_1.time_ - var_57_1) / var_57_3
				local var_57_5 = Vector3.New(0, -1.08, -6)

				var_57_0.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1053ui_story, var_57_5, var_57_4)

				local var_57_6 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_6.x, var_57_6.y, var_57_6.z)

				local var_57_7 = var_57_0.localEulerAngles

				var_57_7.z = 0
				var_57_7.x = 0
				var_57_0.localEulerAngles = var_57_7
			end

			if arg_54_1.time_ >= var_57_1 + var_57_3 and arg_54_1.time_ < var_57_1 + var_57_3 + arg_57_0 then
				var_57_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_57_8 = manager.ui.mainCamera.transform.position - var_57_0.position

				var_57_0.forward = Vector3.New(var_57_8.x, var_57_8.y, var_57_8.z)

				local var_57_9 = var_57_0.localEulerAngles

				var_57_9.z = 0
				var_57_9.x = 0
				var_57_0.localEulerAngles = var_57_9

				local var_57_10 = GameObjectTools.GetOrAddComponent(var_57_0.gameObject, typeof(DynamicBoneHelper))

				if var_57_10 then
					var_57_10:EnableDynamicBone(true)
				end
			end

			local var_57_11 = arg_54_1.actors_["1053ui_story"]
			local var_57_12 = 0

			if var_57_12 < arg_54_1.time_ and arg_54_1.time_ <= var_57_12 + arg_57_0 and not isNil(var_57_11) and arg_54_1.var_.characterEffect1053ui_story == nil then
				arg_54_1.var_.characterEffect1053ui_story = var_57_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_13 = 0.200000002980232

			if var_57_12 <= arg_54_1.time_ and arg_54_1.time_ < var_57_12 + var_57_13 and not isNil(var_57_11) then
				local var_57_14 = (arg_54_1.time_ - var_57_12) / var_57_13

				if arg_54_1.var_.characterEffect1053ui_story and not isNil(var_57_11) then
					arg_54_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_12 + var_57_13 and arg_54_1.time_ < var_57_12 + var_57_13 + arg_57_0 and not isNil(var_57_11) and arg_54_1.var_.characterEffect1053ui_story then
				arg_54_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_57_15 = 0

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 then
				arg_54_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_57_16 = 0

			if var_57_16 < arg_54_1.time_ and arg_54_1.time_ <= var_57_16 + arg_57_0 then
				arg_54_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_57_17 = 0
			local var_57_18 = 1.025

			if var_57_17 < arg_54_1.time_ and arg_54_1.time_ <= var_57_17 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_19 = arg_54_1:FormatText(StoryNameCfg[472].name)

				arg_54_1.leftNameTxt_.text = var_57_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_20 = arg_54_1:GetWordFromCfg(323171012)
				local var_57_21 = arg_54_1:FormatText(var_57_20.content)

				arg_54_1.text_.text = var_57_21

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_22 = 41
				local var_57_23 = utf8.len(var_57_21)
				local var_57_24 = var_57_22 <= 0 and var_57_18 or var_57_18 * (var_57_23 / var_57_22)

				if var_57_24 > 0 and var_57_18 < var_57_24 then
					arg_54_1.talkMaxDuration = var_57_24

					if var_57_24 + var_57_17 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_24 + var_57_17
					end
				end

				arg_54_1.text_.text = var_57_21
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171012", "story_v_out_323171.awb") ~= 0 then
					local var_57_25 = manager.audio:GetVoiceLength("story_v_out_323171", "323171012", "story_v_out_323171.awb") / 1000

					if var_57_25 + var_57_17 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_25 + var_57_17
					end

					if var_57_20.prefab_name ~= "" and arg_54_1.actors_[var_57_20.prefab_name] ~= nil then
						local var_57_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_20.prefab_name].transform, "story_v_out_323171", "323171012", "story_v_out_323171.awb")

						arg_54_1:RecordAudio("323171012", var_57_26)
						arg_54_1:RecordAudio("323171012", var_57_26)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_323171", "323171012", "story_v_out_323171.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_323171", "323171012", "story_v_out_323171.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_27 = math.max(var_57_18, arg_54_1.talkMaxDuration)

			if var_57_17 <= arg_54_1.time_ and arg_54_1.time_ < var_57_17 + var_57_27 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_17) / var_57_27

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_17 + var_57_27 and arg_54_1.time_ < var_57_17 + var_57_27 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play323171013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 323171013
		arg_58_1.duration_ = 5.4

		local var_58_0 = {
			zh = 3.966,
			ja = 5.4
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
				arg_58_0:Play323171014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 0.45

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_2 = arg_58_1:FormatText(StoryNameCfg[472].name)

				arg_58_1.leftNameTxt_.text = var_61_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_3 = arg_58_1:GetWordFromCfg(323171013)
				local var_61_4 = arg_58_1:FormatText(var_61_3.content)

				arg_58_1.text_.text = var_61_4

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_5 = 18
				local var_61_6 = utf8.len(var_61_4)
				local var_61_7 = var_61_5 <= 0 and var_61_1 or var_61_1 * (var_61_6 / var_61_5)

				if var_61_7 > 0 and var_61_1 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_4
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171013", "story_v_out_323171.awb") ~= 0 then
					local var_61_8 = manager.audio:GetVoiceLength("story_v_out_323171", "323171013", "story_v_out_323171.awb") / 1000

					if var_61_8 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_8 + var_61_0
					end

					if var_61_3.prefab_name ~= "" and arg_58_1.actors_[var_61_3.prefab_name] ~= nil then
						local var_61_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_3.prefab_name].transform, "story_v_out_323171", "323171013", "story_v_out_323171.awb")

						arg_58_1:RecordAudio("323171013", var_61_9)
						arg_58_1:RecordAudio("323171013", var_61_9)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_323171", "323171013", "story_v_out_323171.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_323171", "323171013", "story_v_out_323171.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_10 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_10 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_10

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_10 and arg_58_1.time_ < var_61_0 + var_61_10 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play323171014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 323171014
		arg_62_1.duration_ = 7

		local var_62_0 = {
			zh = 5,
			ja = 7
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
				arg_62_0:Play323171015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1053ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1053ui_story == nil then
				arg_62_1.var_.characterEffect1053ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1053ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1053ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1053ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1053ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 0.45

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_8 = arg_62_1:FormatText(StoryNameCfg[1454].name)

				arg_62_1.leftNameTxt_.text = var_65_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_9 = arg_62_1:GetWordFromCfg(323171014)
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171014", "story_v_out_323171.awb") ~= 0 then
					local var_65_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171014", "story_v_out_323171.awb") / 1000

					if var_65_14 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_14 + var_65_6
					end

					if var_65_9.prefab_name ~= "" and arg_62_1.actors_[var_65_9.prefab_name] ~= nil then
						local var_65_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_9.prefab_name].transform, "story_v_out_323171", "323171014", "story_v_out_323171.awb")

						arg_62_1:RecordAudio("323171014", var_65_15)
						arg_62_1:RecordAudio("323171014", var_65_15)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_323171", "323171014", "story_v_out_323171.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_323171", "323171014", "story_v_out_323171.awb")
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
	Play323171015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 323171015
		arg_66_1.duration_ = 9.13

		local var_66_0 = {
			zh = 6,
			ja = 9.133
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play323171016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1053ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1053ui_story == nil then
				arg_66_1.var_.characterEffect1053ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1053ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1053ui_story then
				arg_66_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_69_4 = 0

			if var_69_4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action7_1")
			end

			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_69_6 = 0

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.allBtn_.enabled = false
			end

			local var_69_7 = 1.5

			if arg_66_1.time_ >= var_69_6 + var_69_7 and arg_66_1.time_ < var_69_6 + var_69_7 + arg_69_0 then
				arg_66_1.allBtn_.enabled = true
			end

			local var_69_8 = 0
			local var_69_9 = 0.725

			if var_69_8 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_10 = arg_66_1:FormatText(StoryNameCfg[472].name)

				arg_66_1.leftNameTxt_.text = var_69_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_11 = arg_66_1:GetWordFromCfg(323171015)
				local var_69_12 = arg_66_1:FormatText(var_69_11.content)

				arg_66_1.text_.text = var_69_12

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_13 = 29
				local var_69_14 = utf8.len(var_69_12)
				local var_69_15 = var_69_13 <= 0 and var_69_9 or var_69_9 * (var_69_14 / var_69_13)

				if var_69_15 > 0 and var_69_9 < var_69_15 then
					arg_66_1.talkMaxDuration = var_69_15

					if var_69_15 + var_69_8 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_15 + var_69_8
					end
				end

				arg_66_1.text_.text = var_69_12
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171015", "story_v_out_323171.awb") ~= 0 then
					local var_69_16 = manager.audio:GetVoiceLength("story_v_out_323171", "323171015", "story_v_out_323171.awb") / 1000

					if var_69_16 + var_69_8 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_16 + var_69_8
					end

					if var_69_11.prefab_name ~= "" and arg_66_1.actors_[var_69_11.prefab_name] ~= nil then
						local var_69_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_11.prefab_name].transform, "story_v_out_323171", "323171015", "story_v_out_323171.awb")

						arg_66_1:RecordAudio("323171015", var_69_17)
						arg_66_1:RecordAudio("323171015", var_69_17)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_323171", "323171015", "story_v_out_323171.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_323171", "323171015", "story_v_out_323171.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_18 = math.max(var_69_9, arg_66_1.talkMaxDuration)

			if var_69_8 <= arg_66_1.time_ and arg_66_1.time_ < var_69_8 + var_69_18 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_8) / var_69_18

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_8 + var_69_18 and arg_66_1.time_ < var_69_8 + var_69_18 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play323171016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 323171016
		arg_70_1.duration_ = 10.6

		local var_70_0 = {
			zh = 9.433,
			ja = 10.6
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
				arg_70_0:Play323171017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0
			local var_73_1 = 1

			if var_73_0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_2 = arg_70_1:FormatText(StoryNameCfg[472].name)

				arg_70_1.leftNameTxt_.text = var_73_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:GetWordFromCfg(323171016)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 40
				local var_73_6 = utf8.len(var_73_4)
				local var_73_7 = var_73_5 <= 0 and var_73_1 or var_73_1 * (var_73_6 / var_73_5)

				if var_73_7 > 0 and var_73_1 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_0
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171016", "story_v_out_323171.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_323171", "323171016", "story_v_out_323171.awb") / 1000

					if var_73_8 + var_73_0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_0
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_323171", "323171016", "story_v_out_323171.awb")

						arg_70_1:RecordAudio("323171016", var_73_9)
						arg_70_1:RecordAudio("323171016", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_323171", "323171016", "story_v_out_323171.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_323171", "323171016", "story_v_out_323171.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_1, arg_70_1.talkMaxDuration)

			if var_73_0 <= arg_70_1.time_ and arg_70_1.time_ < var_73_0 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_0) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_0 + var_73_10 and arg_70_1.time_ < var_73_0 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play323171017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 323171017
		arg_74_1.duration_ = 5.57

		local var_74_0 = {
			zh = 2.033,
			ja = 5.566
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
				arg_74_0:Play323171018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1053ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1053ui_story == nil then
				arg_74_1.var_.characterEffect1053ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect1053ui_story and not isNil(var_77_0) then
					local var_77_4 = Mathf.Lerp(0, 0.5, var_77_3)

					arg_74_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1053ui_story.fillRatio = var_77_4
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1053ui_story then
				local var_77_5 = 0.5

				arg_74_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1053ui_story.fillRatio = var_77_5
			end

			local var_77_6 = 0
			local var_77_7 = 0.2

			if var_77_6 < arg_74_1.time_ and arg_74_1.time_ <= var_77_6 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_8 = arg_74_1:FormatText(StoryNameCfg[1454].name)

				arg_74_1.leftNameTxt_.text = var_77_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_9 = arg_74_1:GetWordFromCfg(323171017)
				local var_77_10 = arg_74_1:FormatText(var_77_9.content)

				arg_74_1.text_.text = var_77_10

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_11 = 8
				local var_77_12 = utf8.len(var_77_10)
				local var_77_13 = var_77_11 <= 0 and var_77_7 or var_77_7 * (var_77_12 / var_77_11)

				if var_77_13 > 0 and var_77_7 < var_77_13 then
					arg_74_1.talkMaxDuration = var_77_13

					if var_77_13 + var_77_6 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_13 + var_77_6
					end
				end

				arg_74_1.text_.text = var_77_10
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171017", "story_v_out_323171.awb") ~= 0 then
					local var_77_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171017", "story_v_out_323171.awb") / 1000

					if var_77_14 + var_77_6 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_14 + var_77_6
					end

					if var_77_9.prefab_name ~= "" and arg_74_1.actors_[var_77_9.prefab_name] ~= nil then
						local var_77_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_9.prefab_name].transform, "story_v_out_323171", "323171017", "story_v_out_323171.awb")

						arg_74_1:RecordAudio("323171017", var_77_15)
						arg_74_1:RecordAudio("323171017", var_77_15)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_323171", "323171017", "story_v_out_323171.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_323171", "323171017", "story_v_out_323171.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_16 = math.max(var_77_7, arg_74_1.talkMaxDuration)

			if var_77_6 <= arg_74_1.time_ and arg_74_1.time_ < var_77_6 + var_77_16 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_6) / var_77_16

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_6 + var_77_16 and arg_74_1.time_ < var_77_6 + var_77_16 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play323171018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 323171018
		arg_78_1.duration_ = 5.63

		local var_78_0 = {
			zh = 3.566,
			ja = 5.633
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
				arg_78_0:Play323171019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1053ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1053ui_story == nil then
				arg_78_1.var_.characterEffect1053ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect1053ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect1053ui_story then
				arg_78_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_81_4 = 0
			local var_81_5 = 0.35

			if var_81_4 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_6 = arg_78_1:FormatText(StoryNameCfg[472].name)

				arg_78_1.leftNameTxt_.text = var_81_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_7 = arg_78_1:GetWordFromCfg(323171018)
				local var_81_8 = arg_78_1:FormatText(var_81_7.content)

				arg_78_1.text_.text = var_81_8

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 14
				local var_81_10 = utf8.len(var_81_8)
				local var_81_11 = var_81_9 <= 0 and var_81_5 or var_81_5 * (var_81_10 / var_81_9)

				if var_81_11 > 0 and var_81_5 < var_81_11 then
					arg_78_1.talkMaxDuration = var_81_11

					if var_81_11 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_11 + var_81_4
					end
				end

				arg_78_1.text_.text = var_81_8
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171018", "story_v_out_323171.awb") ~= 0 then
					local var_81_12 = manager.audio:GetVoiceLength("story_v_out_323171", "323171018", "story_v_out_323171.awb") / 1000

					if var_81_12 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_12 + var_81_4
					end

					if var_81_7.prefab_name ~= "" and arg_78_1.actors_[var_81_7.prefab_name] ~= nil then
						local var_81_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_7.prefab_name].transform, "story_v_out_323171", "323171018", "story_v_out_323171.awb")

						arg_78_1:RecordAudio("323171018", var_81_13)
						arg_78_1:RecordAudio("323171018", var_81_13)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_323171", "323171018", "story_v_out_323171.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_323171", "323171018", "story_v_out_323171.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_14 = math.max(var_81_5, arg_78_1.talkMaxDuration)

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_14 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_4) / var_81_14

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_4 + var_81_14 and arg_78_1.time_ < var_81_4 + var_81_14 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play323171019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 323171019
		arg_82_1.duration_ = 11.03

		local var_82_0 = {
			zh = 7.3,
			ja = 11.033
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
				arg_82_0:Play323171020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action7_2")
			end

			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_85_2 = 0
			local var_85_3 = 0.725

			if var_85_2 < arg_82_1.time_ and arg_82_1.time_ <= var_85_2 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_4 = arg_82_1:FormatText(StoryNameCfg[472].name)

				arg_82_1.leftNameTxt_.text = var_85_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_5 = arg_82_1:GetWordFromCfg(323171019)
				local var_85_6 = arg_82_1:FormatText(var_85_5.content)

				arg_82_1.text_.text = var_85_6

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_7 = 29
				local var_85_8 = utf8.len(var_85_6)
				local var_85_9 = var_85_7 <= 0 and var_85_3 or var_85_3 * (var_85_8 / var_85_7)

				if var_85_9 > 0 and var_85_3 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9

					if var_85_9 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_2
					end
				end

				arg_82_1.text_.text = var_85_6
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171019", "story_v_out_323171.awb") ~= 0 then
					local var_85_10 = manager.audio:GetVoiceLength("story_v_out_323171", "323171019", "story_v_out_323171.awb") / 1000

					if var_85_10 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_2
					end

					if var_85_5.prefab_name ~= "" and arg_82_1.actors_[var_85_5.prefab_name] ~= nil then
						local var_85_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_5.prefab_name].transform, "story_v_out_323171", "323171019", "story_v_out_323171.awb")

						arg_82_1:RecordAudio("323171019", var_85_11)
						arg_82_1:RecordAudio("323171019", var_85_11)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_323171", "323171019", "story_v_out_323171.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_323171", "323171019", "story_v_out_323171.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_12 = math.max(var_85_3, arg_82_1.talkMaxDuration)

			if var_85_2 <= arg_82_1.time_ and arg_82_1.time_ < var_85_2 + var_85_12 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_2) / var_85_12

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_2 + var_85_12 and arg_82_1.time_ < var_85_2 + var_85_12 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play323171020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 323171020
		arg_86_1.duration_ = 5.03

		local var_86_0 = {
			zh = 1.966,
			ja = 5.033
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
				arg_86_0:Play323171021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1053ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1053ui_story == nil then
				arg_86_1.var_.characterEffect1053ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1053ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1053ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1053ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1053ui_story.fillRatio = var_89_5
			end

			local var_89_6 = 0
			local var_89_7 = 0.175

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_8 = arg_86_1:FormatText(StoryNameCfg[1454].name)

				arg_86_1.leftNameTxt_.text = var_89_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_9 = arg_86_1:GetWordFromCfg(323171020)
				local var_89_10 = arg_86_1:FormatText(var_89_9.content)

				arg_86_1.text_.text = var_89_10

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171020", "story_v_out_323171.awb") ~= 0 then
					local var_89_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171020", "story_v_out_323171.awb") / 1000

					if var_89_14 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_14 + var_89_6
					end

					if var_89_9.prefab_name ~= "" and arg_86_1.actors_[var_89_9.prefab_name] ~= nil then
						local var_89_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_9.prefab_name].transform, "story_v_out_323171", "323171020", "story_v_out_323171.awb")

						arg_86_1:RecordAudio("323171020", var_89_15)
						arg_86_1:RecordAudio("323171020", var_89_15)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_323171", "323171020", "story_v_out_323171.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_323171", "323171020", "story_v_out_323171.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_16 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_16 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_16

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_16 and arg_86_1.time_ < var_89_6 + var_89_16 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play323171021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 323171021
		arg_90_1.duration_ = 3.6

		local var_90_0 = {
			zh = 3.6,
			ja = 3.466
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
				arg_90_0:Play323171022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1053ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1053ui_story == nil then
				arg_90_1.var_.characterEffect1053ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1053ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1053ui_story then
				arg_90_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_93_4 = 0
			local var_93_5 = 0.3

			if var_93_4 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_6 = arg_90_1:FormatText(StoryNameCfg[472].name)

				arg_90_1.leftNameTxt_.text = var_93_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_7 = arg_90_1:GetWordFromCfg(323171021)
				local var_93_8 = arg_90_1:FormatText(var_93_7.content)

				arg_90_1.text_.text = var_93_8

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 12
				local var_93_10 = utf8.len(var_93_8)
				local var_93_11 = var_93_9 <= 0 and var_93_5 or var_93_5 * (var_93_10 / var_93_9)

				if var_93_11 > 0 and var_93_5 < var_93_11 then
					arg_90_1.talkMaxDuration = var_93_11

					if var_93_11 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_11 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_8
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171021", "story_v_out_323171.awb") ~= 0 then
					local var_93_12 = manager.audio:GetVoiceLength("story_v_out_323171", "323171021", "story_v_out_323171.awb") / 1000

					if var_93_12 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_12 + var_93_4
					end

					if var_93_7.prefab_name ~= "" and arg_90_1.actors_[var_93_7.prefab_name] ~= nil then
						local var_93_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_7.prefab_name].transform, "story_v_out_323171", "323171021", "story_v_out_323171.awb")

						arg_90_1:RecordAudio("323171021", var_93_13)
						arg_90_1:RecordAudio("323171021", var_93_13)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_323171", "323171021", "story_v_out_323171.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_323171", "323171021", "story_v_out_323171.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_14 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_14 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_14

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_14 and arg_90_1.time_ < var_93_4 + var_93_14 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play323171022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 323171022
		arg_94_1.duration_ = 14.57

		local var_94_0 = {
			zh = 12.7,
			ja = 14.566
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play323171023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0
			local var_97_1 = 1.35

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_2 = arg_94_1:FormatText(StoryNameCfg[472].name)

				arg_94_1.leftNameTxt_.text = var_97_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_3 = arg_94_1:GetWordFromCfg(323171022)
				local var_97_4 = arg_94_1:FormatText(var_97_3.content)

				arg_94_1.text_.text = var_97_4

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_5 = 54
				local var_97_6 = utf8.len(var_97_4)
				local var_97_7 = var_97_5 <= 0 and var_97_1 or var_97_1 * (var_97_6 / var_97_5)

				if var_97_7 > 0 and var_97_1 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_0
					end
				end

				arg_94_1.text_.text = var_97_4
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171022", "story_v_out_323171.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_323171", "323171022", "story_v_out_323171.awb") / 1000

					if var_97_8 + var_97_0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_0
					end

					if var_97_3.prefab_name ~= "" and arg_94_1.actors_[var_97_3.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_3.prefab_name].transform, "story_v_out_323171", "323171022", "story_v_out_323171.awb")

						arg_94_1:RecordAudio("323171022", var_97_9)
						arg_94_1:RecordAudio("323171022", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_323171", "323171022", "story_v_out_323171.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_323171", "323171022", "story_v_out_323171.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_1, arg_94_1.talkMaxDuration)

			if var_97_0 <= arg_94_1.time_ and arg_94_1.time_ < var_97_0 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_0) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_0 + var_97_10 and arg_94_1.time_ < var_97_0 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play323171023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 323171023
		arg_98_1.duration_ = 5.83

		local var_98_0 = {
			zh = 2.766,
			ja = 5.833
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
				arg_98_0:Play323171024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1053ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1053ui_story == nil then
				arg_98_1.var_.characterEffect1053ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1053ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1053ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1053ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1053ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.325

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_8 = arg_98_1:FormatText(StoryNameCfg[1454].name)

				arg_98_1.leftNameTxt_.text = var_101_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_9 = arg_98_1:GetWordFromCfg(323171023)
				local var_101_10 = arg_98_1:FormatText(var_101_9.content)

				arg_98_1.text_.text = var_101_10

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_11 = 13
				local var_101_12 = utf8.len(var_101_10)
				local var_101_13 = var_101_11 <= 0 and var_101_7 or var_101_7 * (var_101_12 / var_101_11)

				if var_101_13 > 0 and var_101_7 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_10
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171023", "story_v_out_323171.awb") ~= 0 then
					local var_101_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171023", "story_v_out_323171.awb") / 1000

					if var_101_14 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_14 + var_101_6
					end

					if var_101_9.prefab_name ~= "" and arg_98_1.actors_[var_101_9.prefab_name] ~= nil then
						local var_101_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_9.prefab_name].transform, "story_v_out_323171", "323171023", "story_v_out_323171.awb")

						arg_98_1:RecordAudio("323171023", var_101_15)
						arg_98_1:RecordAudio("323171023", var_101_15)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_323171", "323171023", "story_v_out_323171.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_323171", "323171023", "story_v_out_323171.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_16 and arg_98_1.time_ < var_101_6 + var_101_16 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play323171024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 323171024
		arg_102_1.duration_ = 3.1

		local var_102_0 = {
			zh = 1.999999999999,
			ja = 3.1
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
				arg_102_0:Play323171025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1053ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1053ui_story == nil then
				arg_102_1.var_.characterEffect1053ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1053ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1053ui_story then
				arg_102_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_105_4 = 0

			if var_105_4 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action6_1")
			end

			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_105_6 = 0
			local var_105_7 = 0.175

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_8 = arg_102_1:FormatText(StoryNameCfg[472].name)

				arg_102_1.leftNameTxt_.text = var_105_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_9 = arg_102_1:GetWordFromCfg(323171024)
				local var_105_10 = arg_102_1:FormatText(var_105_9.content)

				arg_102_1.text_.text = var_105_10

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171024", "story_v_out_323171.awb") ~= 0 then
					local var_105_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171024", "story_v_out_323171.awb") / 1000

					if var_105_14 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_14 + var_105_6
					end

					if var_105_9.prefab_name ~= "" and arg_102_1.actors_[var_105_9.prefab_name] ~= nil then
						local var_105_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_9.prefab_name].transform, "story_v_out_323171", "323171024", "story_v_out_323171.awb")

						arg_102_1:RecordAudio("323171024", var_105_15)
						arg_102_1:RecordAudio("323171024", var_105_15)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_323171", "323171024", "story_v_out_323171.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_323171", "323171024", "story_v_out_323171.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_16 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_16 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_16

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_16 and arg_102_1.time_ < var_105_6 + var_105_16 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play323171025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 323171025
		arg_106_1.duration_ = 13.57

		local var_106_0 = {
			zh = 6.9,
			ja = 13.566
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
				arg_106_0:Play323171026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1053ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1053ui_story == nil then
				arg_106_1.var_.characterEffect1053ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1053ui_story and not isNil(var_109_0) then
					local var_109_4 = Mathf.Lerp(0, 0.5, var_109_3)

					arg_106_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1053ui_story.fillRatio = var_109_4
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1053ui_story then
				local var_109_5 = 0.5

				arg_106_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1053ui_story.fillRatio = var_109_5
			end

			local var_109_6 = 0
			local var_109_7 = 0.65

			if var_109_6 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_8 = arg_106_1:FormatText(StoryNameCfg[1454].name)

				arg_106_1.leftNameTxt_.text = var_109_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_9 = arg_106_1:GetWordFromCfg(323171025)
				local var_109_10 = arg_106_1:FormatText(var_109_9.content)

				arg_106_1.text_.text = var_109_10

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 26
				local var_109_12 = utf8.len(var_109_10)
				local var_109_13 = var_109_11 <= 0 and var_109_7 or var_109_7 * (var_109_12 / var_109_11)

				if var_109_13 > 0 and var_109_7 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_10
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171025", "story_v_out_323171.awb") ~= 0 then
					local var_109_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171025", "story_v_out_323171.awb") / 1000

					if var_109_14 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_14 + var_109_6
					end

					if var_109_9.prefab_name ~= "" and arg_106_1.actors_[var_109_9.prefab_name] ~= nil then
						local var_109_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_9.prefab_name].transform, "story_v_out_323171", "323171025", "story_v_out_323171.awb")

						arg_106_1:RecordAudio("323171025", var_109_15)
						arg_106_1:RecordAudio("323171025", var_109_15)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_323171", "323171025", "story_v_out_323171.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_323171", "323171025", "story_v_out_323171.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_16 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_16 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_16

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_16 and arg_106_1.time_ < var_109_6 + var_109_16 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play323171026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 323171026
		arg_110_1.duration_ = 3.5

		local var_110_0 = {
			zh = 2.2,
			ja = 3.5
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
				arg_110_0:Play323171027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["1053ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1053ui_story == nil then
				arg_110_1.var_.characterEffect1053ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect1053ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect1053ui_story then
				arg_110_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_113_4 = 0
			local var_113_5 = 0.25

			if var_113_4 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_6 = arg_110_1:FormatText(StoryNameCfg[472].name)

				arg_110_1.leftNameTxt_.text = var_113_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_7 = arg_110_1:GetWordFromCfg(323171026)
				local var_113_8 = arg_110_1:FormatText(var_113_7.content)

				arg_110_1.text_.text = var_113_8

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 10
				local var_113_10 = utf8.len(var_113_8)
				local var_113_11 = var_113_9 <= 0 and var_113_5 or var_113_5 * (var_113_10 / var_113_9)

				if var_113_11 > 0 and var_113_5 < var_113_11 then
					arg_110_1.talkMaxDuration = var_113_11

					if var_113_11 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_11 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_8
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171026", "story_v_out_323171.awb") ~= 0 then
					local var_113_12 = manager.audio:GetVoiceLength("story_v_out_323171", "323171026", "story_v_out_323171.awb") / 1000

					if var_113_12 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_12 + var_113_4
					end

					if var_113_7.prefab_name ~= "" and arg_110_1.actors_[var_113_7.prefab_name] ~= nil then
						local var_113_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_7.prefab_name].transform, "story_v_out_323171", "323171026", "story_v_out_323171.awb")

						arg_110_1:RecordAudio("323171026", var_113_13)
						arg_110_1:RecordAudio("323171026", var_113_13)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_323171", "323171026", "story_v_out_323171.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_323171", "323171026", "story_v_out_323171.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_14 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_14 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_14

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_14 and arg_110_1.time_ < var_113_4 + var_113_14 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play323171027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 323171027
		arg_114_1.duration_ = 9.5

		local var_114_0 = {
			zh = 4.133,
			ja = 9.5
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
				arg_114_0:Play323171028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1053ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1053ui_story == nil then
				arg_114_1.var_.characterEffect1053ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1053ui_story and not isNil(var_117_0) then
					local var_117_4 = Mathf.Lerp(0, 0.5, var_117_3)

					arg_114_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1053ui_story.fillRatio = var_117_4
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1053ui_story then
				local var_117_5 = 0.5

				arg_114_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1053ui_story.fillRatio = var_117_5
			end

			local var_117_6 = 0
			local var_117_7 = 0.475

			if var_117_6 < arg_114_1.time_ and arg_114_1.time_ <= var_117_6 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_8 = arg_114_1:FormatText(StoryNameCfg[1454].name)

				arg_114_1.leftNameTxt_.text = var_117_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_9 = arg_114_1:GetWordFromCfg(323171027)
				local var_117_10 = arg_114_1:FormatText(var_117_9.content)

				arg_114_1.text_.text = var_117_10

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_11 = 18
				local var_117_12 = utf8.len(var_117_10)
				local var_117_13 = var_117_11 <= 0 and var_117_7 or var_117_7 * (var_117_12 / var_117_11)

				if var_117_13 > 0 and var_117_7 < var_117_13 then
					arg_114_1.talkMaxDuration = var_117_13

					if var_117_13 + var_117_6 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_13 + var_117_6
					end
				end

				arg_114_1.text_.text = var_117_10
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171027", "story_v_out_323171.awb") ~= 0 then
					local var_117_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171027", "story_v_out_323171.awb") / 1000

					if var_117_14 + var_117_6 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_14 + var_117_6
					end

					if var_117_9.prefab_name ~= "" and arg_114_1.actors_[var_117_9.prefab_name] ~= nil then
						local var_117_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_9.prefab_name].transform, "story_v_out_323171", "323171027", "story_v_out_323171.awb")

						arg_114_1:RecordAudio("323171027", var_117_15)
						arg_114_1:RecordAudio("323171027", var_117_15)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_323171", "323171027", "story_v_out_323171.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_323171", "323171027", "story_v_out_323171.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_16 = math.max(var_117_7, arg_114_1.talkMaxDuration)

			if var_117_6 <= arg_114_1.time_ and arg_114_1.time_ < var_117_6 + var_117_16 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_6) / var_117_16

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_6 + var_117_16 and arg_114_1.time_ < var_117_6 + var_117_16 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play323171028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 323171028
		arg_118_1.duration_ = 17.47

		local var_118_0 = {
			zh = 9.933,
			ja = 17.466
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
				arg_118_0:Play323171029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0
			local var_121_1 = 1

			if var_121_0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_2 = arg_118_1:FormatText(StoryNameCfg[1454].name)

				arg_118_1.leftNameTxt_.text = var_121_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:GetWordFromCfg(323171028)
				local var_121_4 = arg_118_1:FormatText(var_121_3.content)

				arg_118_1.text_.text = var_121_4

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 40
				local var_121_6 = utf8.len(var_121_4)
				local var_121_7 = var_121_5 <= 0 and var_121_1 or var_121_1 * (var_121_6 / var_121_5)

				if var_121_7 > 0 and var_121_1 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_0
					end
				end

				arg_118_1.text_.text = var_121_4
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171028", "story_v_out_323171.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_323171", "323171028", "story_v_out_323171.awb") / 1000

					if var_121_8 + var_121_0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_0
					end

					if var_121_3.prefab_name ~= "" and arg_118_1.actors_[var_121_3.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_3.prefab_name].transform, "story_v_out_323171", "323171028", "story_v_out_323171.awb")

						arg_118_1:RecordAudio("323171028", var_121_9)
						arg_118_1:RecordAudio("323171028", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_323171", "323171028", "story_v_out_323171.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_323171", "323171028", "story_v_out_323171.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_1, arg_118_1.talkMaxDuration)

			if var_121_0 <= arg_118_1.time_ and arg_118_1.time_ < var_121_0 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_0) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_0 + var_121_10 and arg_118_1.time_ < var_121_0 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play323171029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 323171029
		arg_122_1.duration_ = 11.83

		local var_122_0 = {
			zh = 6.8,
			ja = 11.833
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
				arg_122_0:Play323171030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1053ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1053ui_story == nil then
				arg_122_1.var_.characterEffect1053ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1053ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1053ui_story then
				arg_122_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_125_4 = 0

			if var_125_4 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053actionlink/1053action465")
			end

			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 then
				arg_122_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_125_6 = 0
			local var_125_7 = 0.7

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_8 = arg_122_1:FormatText(StoryNameCfg[472].name)

				arg_122_1.leftNameTxt_.text = var_125_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_9 = arg_122_1:GetWordFromCfg(323171029)
				local var_125_10 = arg_122_1:FormatText(var_125_9.content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 28
				local var_125_12 = utf8.len(var_125_10)
				local var_125_13 = var_125_11 <= 0 and var_125_7 or var_125_7 * (var_125_12 / var_125_11)

				if var_125_13 > 0 and var_125_7 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171029", "story_v_out_323171.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171029", "story_v_out_323171.awb") / 1000

					if var_125_14 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_6
					end

					if var_125_9.prefab_name ~= "" and arg_122_1.actors_[var_125_9.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_9.prefab_name].transform, "story_v_out_323171", "323171029", "story_v_out_323171.awb")

						arg_122_1:RecordAudio("323171029", var_125_15)
						arg_122_1:RecordAudio("323171029", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_323171", "323171029", "story_v_out_323171.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_323171", "323171029", "story_v_out_323171.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_16 and arg_122_1.time_ < var_125_6 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play323171030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 323171030
		arg_126_1.duration_ = 6.3

		local var_126_0 = {
			zh = 3.266,
			ja = 6.3
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
				arg_126_0:Play323171031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1053ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1053ui_story == nil then
				arg_126_1.var_.characterEffect1053ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.200000002980232

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1053ui_story and not isNil(var_129_0) then
					local var_129_4 = Mathf.Lerp(0, 0.5, var_129_3)

					arg_126_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1053ui_story.fillRatio = var_129_4
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1053ui_story then
				local var_129_5 = 0.5

				arg_126_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1053ui_story.fillRatio = var_129_5
			end

			local var_129_6 = 0
			local var_129_7 = 0.225

			if var_129_6 < arg_126_1.time_ and arg_126_1.time_ <= var_129_6 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_8 = arg_126_1:FormatText(StoryNameCfg[1454].name)

				arg_126_1.leftNameTxt_.text = var_129_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_9 = arg_126_1:GetWordFromCfg(323171030)
				local var_129_10 = arg_126_1:FormatText(var_129_9.content)

				arg_126_1.text_.text = var_129_10

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_11 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171030", "story_v_out_323171.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171030", "story_v_out_323171.awb") / 1000

					if var_129_14 + var_129_6 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_6
					end

					if var_129_9.prefab_name ~= "" and arg_126_1.actors_[var_129_9.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_9.prefab_name].transform, "story_v_out_323171", "323171030", "story_v_out_323171.awb")

						arg_126_1:RecordAudio("323171030", var_129_15)
						arg_126_1:RecordAudio("323171030", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_323171", "323171030", "story_v_out_323171.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_323171", "323171030", "story_v_out_323171.awb")
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
	Play323171031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 323171031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play323171032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1053ui_story"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos1053ui_story = var_133_0.localPosition

				local var_133_2 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_2 then
					var_133_2:EnableDynamicBone(false)
				end
			end

			local var_133_3 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_3 then
				local var_133_4 = (arg_130_1.time_ - var_133_1) / var_133_3
				local var_133_5 = Vector3.New(0, 100, 0)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1053ui_story, var_133_5, var_133_4)

				local var_133_6 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_6.x, var_133_6.y, var_133_6.z)

				local var_133_7 = var_133_0.localEulerAngles

				var_133_7.z = 0
				var_133_7.x = 0
				var_133_0.localEulerAngles = var_133_7
			end

			if arg_130_1.time_ >= var_133_1 + var_133_3 and arg_130_1.time_ < var_133_1 + var_133_3 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, 100, 0)

				local var_133_8 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_8.x, var_133_8.y, var_133_8.z)

				local var_133_9 = var_133_0.localEulerAngles

				var_133_9.z = 0
				var_133_9.x = 0
				var_133_0.localEulerAngles = var_133_9

				local var_133_10 = GameObjectTools.GetOrAddComponent(var_133_0.gameObject, typeof(DynamicBoneHelper))

				if var_133_10 then
					var_133_10:EnableDynamicBone(true)
				end
			end

			local var_133_11 = 0.5
			local var_133_12 = 1

			if var_133_11 < arg_130_1.time_ and arg_130_1.time_ <= var_133_11 + arg_133_0 then
				local var_133_13 = "play"
				local var_133_14 = "effect"

				arg_130_1:AudioAction(var_133_13, var_133_14, "se_story_148", "se_story_148_chess01", "")
			end

			local var_133_15 = 0
			local var_133_16 = 1.375

			if var_133_15 < arg_130_1.time_ and arg_130_1.time_ <= var_133_15 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_17 = arg_130_1:GetWordFromCfg(323171031)
				local var_133_18 = arg_130_1:FormatText(var_133_17.content)

				arg_130_1.text_.text = var_133_18

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_19 = 55
				local var_133_20 = utf8.len(var_133_18)
				local var_133_21 = var_133_19 <= 0 and var_133_16 or var_133_16 * (var_133_20 / var_133_19)

				if var_133_21 > 0 and var_133_16 < var_133_21 then
					arg_130_1.talkMaxDuration = var_133_21

					if var_133_21 + var_133_15 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_21 + var_133_15
					end
				end

				arg_130_1.text_.text = var_133_18
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_22 = math.max(var_133_16, arg_130_1.talkMaxDuration)

			if var_133_15 <= arg_130_1.time_ and arg_130_1.time_ < var_133_15 + var_133_22 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_15) / var_133_22

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_15 + var_133_22 and arg_130_1.time_ < var_133_15 + var_133_22 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play323171032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 323171032
		arg_134_1.duration_ = 8.23

		local var_134_0 = {
			zh = 5.233,
			ja = 8.233
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
				arg_134_0:Play323171033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1053ui_story"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos1053ui_story = var_137_0.localPosition

				local var_137_2 = GameObjectTools.GetOrAddComponent(var_137_0.gameObject, typeof(DynamicBoneHelper))

				if var_137_2 then
					var_137_2:EnableDynamicBone(false)
				end
			end

			local var_137_3 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_3 then
				local var_137_4 = (arg_134_1.time_ - var_137_1) / var_137_3
				local var_137_5 = Vector3.New(0, -1.08, -6)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1053ui_story, var_137_5, var_137_4)

				local var_137_6 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_6.x, var_137_6.y, var_137_6.z)

				local var_137_7 = var_137_0.localEulerAngles

				var_137_7.z = 0
				var_137_7.x = 0
				var_137_0.localEulerAngles = var_137_7
			end

			if arg_134_1.time_ >= var_137_1 + var_137_3 and arg_134_1.time_ < var_137_1 + var_137_3 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_137_8 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_8.x, var_137_8.y, var_137_8.z)

				local var_137_9 = var_137_0.localEulerAngles

				var_137_9.z = 0
				var_137_9.x = 0
				var_137_0.localEulerAngles = var_137_9

				local var_137_10 = GameObjectTools.GetOrAddComponent(var_137_0.gameObject, typeof(DynamicBoneHelper))

				if var_137_10 then
					var_137_10:EnableDynamicBone(true)
				end
			end

			local var_137_11 = arg_134_1.actors_["1053ui_story"]
			local var_137_12 = 0

			if var_137_12 < arg_134_1.time_ and arg_134_1.time_ <= var_137_12 + arg_137_0 and not isNil(var_137_11) and arg_134_1.var_.characterEffect1053ui_story == nil then
				arg_134_1.var_.characterEffect1053ui_story = var_137_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_13 = 0.200000002980232

			if var_137_12 <= arg_134_1.time_ and arg_134_1.time_ < var_137_12 + var_137_13 and not isNil(var_137_11) then
				local var_137_14 = (arg_134_1.time_ - var_137_12) / var_137_13

				if arg_134_1.var_.characterEffect1053ui_story and not isNil(var_137_11) then
					arg_134_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_12 + var_137_13 and arg_134_1.time_ < var_137_12 + var_137_13 + arg_137_0 and not isNil(var_137_11) and arg_134_1.var_.characterEffect1053ui_story then
				arg_134_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_137_15 = 0

			if var_137_15 < arg_134_1.time_ and arg_134_1.time_ <= var_137_15 + arg_137_0 then
				arg_134_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action5_2")
			end

			local var_137_16 = 0

			if var_137_16 < arg_134_1.time_ and arg_134_1.time_ <= var_137_16 + arg_137_0 then
				arg_134_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_137_17 = 0

			if var_137_17 < arg_134_1.time_ and arg_134_1.time_ <= var_137_17 + arg_137_0 then
				arg_134_1.allBtn_.enabled = false
			end

			local var_137_18 = 1.66666666666667

			if arg_134_1.time_ >= var_137_17 + var_137_18 and arg_134_1.time_ < var_137_17 + var_137_18 + arg_137_0 then
				arg_134_1.allBtn_.enabled = true
			end

			local var_137_19 = 0
			local var_137_20 = 0.425

			if var_137_19 < arg_134_1.time_ and arg_134_1.time_ <= var_137_19 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_21 = arg_134_1:FormatText(StoryNameCfg[472].name)

				arg_134_1.leftNameTxt_.text = var_137_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_22 = arg_134_1:GetWordFromCfg(323171032)
				local var_137_23 = arg_134_1:FormatText(var_137_22.content)

				arg_134_1.text_.text = var_137_23

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_24 = 17
				local var_137_25 = utf8.len(var_137_23)
				local var_137_26 = var_137_24 <= 0 and var_137_20 or var_137_20 * (var_137_25 / var_137_24)

				if var_137_26 > 0 and var_137_20 < var_137_26 then
					arg_134_1.talkMaxDuration = var_137_26

					if var_137_26 + var_137_19 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_26 + var_137_19
					end
				end

				arg_134_1.text_.text = var_137_23
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171032", "story_v_out_323171.awb") ~= 0 then
					local var_137_27 = manager.audio:GetVoiceLength("story_v_out_323171", "323171032", "story_v_out_323171.awb") / 1000

					if var_137_27 + var_137_19 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_27 + var_137_19
					end

					if var_137_22.prefab_name ~= "" and arg_134_1.actors_[var_137_22.prefab_name] ~= nil then
						local var_137_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_22.prefab_name].transform, "story_v_out_323171", "323171032", "story_v_out_323171.awb")

						arg_134_1:RecordAudio("323171032", var_137_28)
						arg_134_1:RecordAudio("323171032", var_137_28)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_323171", "323171032", "story_v_out_323171.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_323171", "323171032", "story_v_out_323171.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_29 = math.max(var_137_20, arg_134_1.talkMaxDuration)

			if var_137_19 <= arg_134_1.time_ and arg_134_1.time_ < var_137_19 + var_137_29 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_19) / var_137_29

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_19 + var_137_29 and arg_134_1.time_ < var_137_19 + var_137_29 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play323171033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 323171033
		arg_138_1.duration_ = 1.5

		local var_138_0 = {
			zh = 1.2,
			ja = 1.5
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
				arg_138_0:Play323171034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["1053ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1053ui_story == nil then
				arg_138_1.var_.characterEffect1053ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1053ui_story and not isNil(var_141_0) then
					local var_141_4 = Mathf.Lerp(0, 0.5, var_141_3)

					arg_138_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1053ui_story.fillRatio = var_141_4
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1053ui_story then
				local var_141_5 = 0.5

				arg_138_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1053ui_story.fillRatio = var_141_5
			end

			local var_141_6 = 0
			local var_141_7 = 0.05

			if var_141_6 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_8 = arg_138_1:FormatText(StoryNameCfg[1454].name)

				arg_138_1.leftNameTxt_.text = var_141_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_9 = arg_138_1:GetWordFromCfg(323171033)
				local var_141_10 = arg_138_1:FormatText(var_141_9.content)

				arg_138_1.text_.text = var_141_10

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171033", "story_v_out_323171.awb") ~= 0 then
					local var_141_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171033", "story_v_out_323171.awb") / 1000

					if var_141_14 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_14 + var_141_6
					end

					if var_141_9.prefab_name ~= "" and arg_138_1.actors_[var_141_9.prefab_name] ~= nil then
						local var_141_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_9.prefab_name].transform, "story_v_out_323171", "323171033", "story_v_out_323171.awb")

						arg_138_1:RecordAudio("323171033", var_141_15)
						arg_138_1:RecordAudio("323171033", var_141_15)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_323171", "323171033", "story_v_out_323171.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_323171", "323171033", "story_v_out_323171.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_16 = math.max(var_141_7, arg_138_1.talkMaxDuration)

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_16 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_6) / var_141_16

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_6 + var_141_16 and arg_138_1.time_ < var_141_6 + var_141_16 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play323171034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 323171034
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play323171035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.45

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

				local var_145_2 = arg_142_1:GetWordFromCfg(323171034)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 18
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
	Play323171035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 323171035
		arg_146_1.duration_ = 5.07

		local var_146_0 = {
			zh = 3.366,
			ja = 5.066
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
				arg_146_0:Play323171036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1053ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1053ui_story == nil then
				arg_146_1.var_.characterEffect1053ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1053ui_story and not isNil(var_149_0) then
					arg_146_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1053ui_story then
				arg_146_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_149_4 = 0

			if var_149_4 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_149_5 = 0

			if var_149_5 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 then
				arg_146_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_149_6 = 0
			local var_149_7 = 0.3

			if var_149_6 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_8 = arg_146_1:FormatText(StoryNameCfg[472].name)

				arg_146_1.leftNameTxt_.text = var_149_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_9 = arg_146_1:GetWordFromCfg(323171035)
				local var_149_10 = arg_146_1:FormatText(var_149_9.content)

				arg_146_1.text_.text = var_149_10

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_11 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171035", "story_v_out_323171.awb") ~= 0 then
					local var_149_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171035", "story_v_out_323171.awb") / 1000

					if var_149_14 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_14 + var_149_6
					end

					if var_149_9.prefab_name ~= "" and arg_146_1.actors_[var_149_9.prefab_name] ~= nil then
						local var_149_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_9.prefab_name].transform, "story_v_out_323171", "323171035", "story_v_out_323171.awb")

						arg_146_1:RecordAudio("323171035", var_149_15)
						arg_146_1:RecordAudio("323171035", var_149_15)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_323171", "323171035", "story_v_out_323171.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_323171", "323171035", "story_v_out_323171.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_16 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_16 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_16

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_16 and arg_146_1.time_ < var_149_6 + var_149_16 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play323171036 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 323171036
		arg_150_1.duration_ = 2.13

		local var_150_0 = {
			zh = 1.3,
			ja = 2.133
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
				arg_150_0:Play323171037(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1053ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1053ui_story == nil then
				arg_150_1.var_.characterEffect1053ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect1053ui_story and not isNil(var_153_0) then
					local var_153_4 = Mathf.Lerp(0, 0.5, var_153_3)

					arg_150_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1053ui_story.fillRatio = var_153_4
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1053ui_story then
				local var_153_5 = 0.5

				arg_150_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1053ui_story.fillRatio = var_153_5
			end

			local var_153_6 = 0
			local var_153_7 = 0.075

			if var_153_6 < arg_150_1.time_ and arg_150_1.time_ <= var_153_6 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_8 = arg_150_1:FormatText(StoryNameCfg[1454].name)

				arg_150_1.leftNameTxt_.text = var_153_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_9 = arg_150_1:GetWordFromCfg(323171036)
				local var_153_10 = arg_150_1:FormatText(var_153_9.content)

				arg_150_1.text_.text = var_153_10

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_11 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171036", "story_v_out_323171.awb") ~= 0 then
					local var_153_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171036", "story_v_out_323171.awb") / 1000

					if var_153_14 + var_153_6 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_14 + var_153_6
					end

					if var_153_9.prefab_name ~= "" and arg_150_1.actors_[var_153_9.prefab_name] ~= nil then
						local var_153_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_9.prefab_name].transform, "story_v_out_323171", "323171036", "story_v_out_323171.awb")

						arg_150_1:RecordAudio("323171036", var_153_15)
						arg_150_1:RecordAudio("323171036", var_153_15)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_323171", "323171036", "story_v_out_323171.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_323171", "323171036", "story_v_out_323171.awb")
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
	Play323171037 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 323171037
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play323171038(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1053ui_story"].transform
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.var_.moveOldPos1053ui_story = var_157_0.localPosition

				local var_157_2 = GameObjectTools.GetOrAddComponent(var_157_0.gameObject, typeof(DynamicBoneHelper))

				if var_157_2 then
					var_157_2:EnableDynamicBone(false)
				end
			end

			local var_157_3 = 0.001

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_3 then
				local var_157_4 = (arg_154_1.time_ - var_157_1) / var_157_3
				local var_157_5 = Vector3.New(0, 100, 0)

				var_157_0.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1053ui_story, var_157_5, var_157_4)

				local var_157_6 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_6.x, var_157_6.y, var_157_6.z)

				local var_157_7 = var_157_0.localEulerAngles

				var_157_7.z = 0
				var_157_7.x = 0
				var_157_0.localEulerAngles = var_157_7
			end

			if arg_154_1.time_ >= var_157_1 + var_157_3 and arg_154_1.time_ < var_157_1 + var_157_3 + arg_157_0 then
				var_157_0.localPosition = Vector3.New(0, 100, 0)

				local var_157_8 = manager.ui.mainCamera.transform.position - var_157_0.position

				var_157_0.forward = Vector3.New(var_157_8.x, var_157_8.y, var_157_8.z)

				local var_157_9 = var_157_0.localEulerAngles

				var_157_9.z = 0
				var_157_9.x = 0
				var_157_0.localEulerAngles = var_157_9

				local var_157_10 = GameObjectTools.GetOrAddComponent(var_157_0.gameObject, typeof(DynamicBoneHelper))

				if var_157_10 then
					var_157_10:EnableDynamicBone(true)
				end
			end

			local var_157_11 = 0.266666666666667
			local var_157_12 = 1

			if var_157_11 < arg_154_1.time_ and arg_154_1.time_ <= var_157_11 + arg_157_0 then
				local var_157_13 = "play"
				local var_157_14 = "effect"

				arg_154_1:AudioAction(var_157_13, var_157_14, "se_story_148", "se_story_148_chess02", "")
			end

			local var_157_15 = 0
			local var_157_16 = 0.875

			if var_157_15 < arg_154_1.time_ and arg_154_1.time_ <= var_157_15 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_17 = arg_154_1:GetWordFromCfg(323171037)
				local var_157_18 = arg_154_1:FormatText(var_157_17.content)

				arg_154_1.text_.text = var_157_18

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_19 = 35
				local var_157_20 = utf8.len(var_157_18)
				local var_157_21 = var_157_19 <= 0 and var_157_16 or var_157_16 * (var_157_20 / var_157_19)

				if var_157_21 > 0 and var_157_16 < var_157_21 then
					arg_154_1.talkMaxDuration = var_157_21

					if var_157_21 + var_157_15 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_21 + var_157_15
					end
				end

				arg_154_1.text_.text = var_157_18
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_22 = math.max(var_157_16, arg_154_1.talkMaxDuration)

			if var_157_15 <= arg_154_1.time_ and arg_154_1.time_ < var_157_15 + var_157_22 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_15) / var_157_22

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_15 + var_157_22 and arg_154_1.time_ < var_157_15 + var_157_22 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play323171038 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 323171038
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play323171039(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0
			local var_161_1 = 1.05

			if var_161_0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_2 = arg_158_1:GetWordFromCfg(323171038)
				local var_161_3 = arg_158_1:FormatText(var_161_2.content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 42
				local var_161_5 = utf8.len(var_161_3)
				local var_161_6 = var_161_4 <= 0 and var_161_1 or var_161_1 * (var_161_5 / var_161_4)

				if var_161_6 > 0 and var_161_1 < var_161_6 then
					arg_158_1.talkMaxDuration = var_161_6

					if var_161_6 + var_161_0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_6 + var_161_0
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_1, arg_158_1.talkMaxDuration)

			if var_161_0 <= arg_158_1.time_ and arg_158_1.time_ < var_161_0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_0 + var_161_7 and arg_158_1.time_ < var_161_0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play323171039 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 323171039
		arg_162_1.duration_ = 3.9

		local var_162_0 = {
			zh = 2.366,
			ja = 3.9
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
				arg_162_0:Play323171040(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = arg_162_1.actors_["1053ui_story"]
			local var_165_1 = 0

			if var_165_1 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1053ui_story == nil then
				arg_162_1.var_.characterEffect1053ui_story = var_165_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_2 = 0.200000002980232

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_2 and not isNil(var_165_0) then
				local var_165_3 = (arg_162_1.time_ - var_165_1) / var_165_2

				if arg_162_1.var_.characterEffect1053ui_story and not isNil(var_165_0) then
					arg_162_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= var_165_1 + var_165_2 and arg_162_1.time_ < var_165_1 + var_165_2 + arg_165_0 and not isNil(var_165_0) and arg_162_1.var_.characterEffect1053ui_story then
				arg_162_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_165_4 = 0

			if var_165_4 < arg_162_1.time_ and arg_162_1.time_ <= var_165_4 + arg_165_0 then
				arg_162_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_165_5 = 0

			if var_165_5 < arg_162_1.time_ and arg_162_1.time_ <= var_165_5 + arg_165_0 then
				arg_162_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_165_6 = arg_162_1.actors_["1053ui_story"].transform
			local var_165_7 = 0

			if var_165_7 < arg_162_1.time_ and arg_162_1.time_ <= var_165_7 + arg_165_0 then
				arg_162_1.var_.moveOldPos1053ui_story = var_165_6.localPosition

				local var_165_8 = GameObjectTools.GetOrAddComponent(var_165_6.gameObject, typeof(DynamicBoneHelper))

				if var_165_8 then
					var_165_8:EnableDynamicBone(false)
				end
			end

			local var_165_9 = 0.001

			if var_165_7 <= arg_162_1.time_ and arg_162_1.time_ < var_165_7 + var_165_9 then
				local var_165_10 = (arg_162_1.time_ - var_165_7) / var_165_9
				local var_165_11 = Vector3.New(0, -1.08, -6)

				var_165_6.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos1053ui_story, var_165_11, var_165_10)

				local var_165_12 = manager.ui.mainCamera.transform.position - var_165_6.position

				var_165_6.forward = Vector3.New(var_165_12.x, var_165_12.y, var_165_12.z)

				local var_165_13 = var_165_6.localEulerAngles

				var_165_13.z = 0
				var_165_13.x = 0
				var_165_6.localEulerAngles = var_165_13
			end

			if arg_162_1.time_ >= var_165_7 + var_165_9 and arg_162_1.time_ < var_165_7 + var_165_9 + arg_165_0 then
				var_165_6.localPosition = Vector3.New(0, -1.08, -6)

				local var_165_14 = manager.ui.mainCamera.transform.position - var_165_6.position

				var_165_6.forward = Vector3.New(var_165_14.x, var_165_14.y, var_165_14.z)

				local var_165_15 = var_165_6.localEulerAngles

				var_165_15.z = 0
				var_165_15.x = 0
				var_165_6.localEulerAngles = var_165_15

				local var_165_16 = GameObjectTools.GetOrAddComponent(var_165_6.gameObject, typeof(DynamicBoneHelper))

				if var_165_16 then
					var_165_16:EnableDynamicBone(true)
				end
			end

			local var_165_17 = 0
			local var_165_18 = 0.275

			if var_165_17 < arg_162_1.time_ and arg_162_1.time_ <= var_165_17 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				local var_165_19 = arg_162_1:FormatText(StoryNameCfg[472].name)

				arg_162_1.leftNameTxt_.text = var_165_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_20 = arg_162_1:GetWordFromCfg(323171039)
				local var_165_21 = arg_162_1:FormatText(var_165_20.content)

				arg_162_1.text_.text = var_165_21

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_22 = 11
				local var_165_23 = utf8.len(var_165_21)
				local var_165_24 = var_165_22 <= 0 and var_165_18 or var_165_18 * (var_165_23 / var_165_22)

				if var_165_24 > 0 and var_165_18 < var_165_24 then
					arg_162_1.talkMaxDuration = var_165_24

					if var_165_24 + var_165_17 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_24 + var_165_17
					end
				end

				arg_162_1.text_.text = var_165_21
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171039", "story_v_out_323171.awb") ~= 0 then
					local var_165_25 = manager.audio:GetVoiceLength("story_v_out_323171", "323171039", "story_v_out_323171.awb") / 1000

					if var_165_25 + var_165_17 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_25 + var_165_17
					end

					if var_165_20.prefab_name ~= "" and arg_162_1.actors_[var_165_20.prefab_name] ~= nil then
						local var_165_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_20.prefab_name].transform, "story_v_out_323171", "323171039", "story_v_out_323171.awb")

						arg_162_1:RecordAudio("323171039", var_165_26)
						arg_162_1:RecordAudio("323171039", var_165_26)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_323171", "323171039", "story_v_out_323171.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_323171", "323171039", "story_v_out_323171.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_27 = math.max(var_165_18, arg_162_1.talkMaxDuration)

			if var_165_17 <= arg_162_1.time_ and arg_162_1.time_ < var_165_17 + var_165_27 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_17) / var_165_27

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_17 + var_165_27 and arg_162_1.time_ < var_165_17 + var_165_27 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323171040 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 323171040
		arg_166_1.duration_ = 4.23

		local var_166_0 = {
			zh = 2.466,
			ja = 4.233
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
				arg_166_0:Play323171041(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = arg_166_1.actors_["1053ui_story"]
			local var_169_1 = 0

			if var_169_1 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1053ui_story == nil then
				arg_166_1.var_.characterEffect1053ui_story = var_169_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_2 and not isNil(var_169_0) then
				local var_169_3 = (arg_166_1.time_ - var_169_1) / var_169_2

				if arg_166_1.var_.characterEffect1053ui_story and not isNil(var_169_0) then
					local var_169_4 = Mathf.Lerp(0, 0.5, var_169_3)

					arg_166_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1053ui_story.fillRatio = var_169_4
				end
			end

			if arg_166_1.time_ >= var_169_1 + var_169_2 and arg_166_1.time_ < var_169_1 + var_169_2 + arg_169_0 and not isNil(var_169_0) and arg_166_1.var_.characterEffect1053ui_story then
				local var_169_5 = 0.5

				arg_166_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1053ui_story.fillRatio = var_169_5
			end

			local var_169_6 = 0
			local var_169_7 = 0.275

			if var_169_6 < arg_166_1.time_ and arg_166_1.time_ <= var_169_6 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				local var_169_8 = arg_166_1:FormatText(StoryNameCfg[1454].name)

				arg_166_1.leftNameTxt_.text = var_169_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_9 = arg_166_1:GetWordFromCfg(323171040)
				local var_169_10 = arg_166_1:FormatText(var_169_9.content)

				arg_166_1.text_.text = var_169_10

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_11 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171040", "story_v_out_323171.awb") ~= 0 then
					local var_169_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171040", "story_v_out_323171.awb") / 1000

					if var_169_14 + var_169_6 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_14 + var_169_6
					end

					if var_169_9.prefab_name ~= "" and arg_166_1.actors_[var_169_9.prefab_name] ~= nil then
						local var_169_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_9.prefab_name].transform, "story_v_out_323171", "323171040", "story_v_out_323171.awb")

						arg_166_1:RecordAudio("323171040", var_169_15)
						arg_166_1:RecordAudio("323171040", var_169_15)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_323171", "323171040", "story_v_out_323171.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_323171", "323171040", "story_v_out_323171.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_16 = math.max(var_169_7, arg_166_1.talkMaxDuration)

			if var_169_6 <= arg_166_1.time_ and arg_166_1.time_ < var_169_6 + var_169_16 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_6) / var_169_16

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_6 + var_169_16 and arg_166_1.time_ < var_169_6 + var_169_16 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play323171041 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 323171041
		arg_170_1.duration_ = 5.8

		local var_170_0 = {
			zh = 4,
			ja = 5.8
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play323171042(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["1053ui_story"]
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect1053ui_story == nil then
				arg_170_1.var_.characterEffect1053ui_story = var_173_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.200000002980232

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_2 and not isNil(var_173_0) then
				local var_173_3 = (arg_170_1.time_ - var_173_1) / var_173_2

				if arg_170_1.var_.characterEffect1053ui_story and not isNil(var_173_0) then
					arg_170_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= var_173_1 + var_173_2 and arg_170_1.time_ < var_173_1 + var_173_2 + arg_173_0 and not isNil(var_173_0) and arg_170_1.var_.characterEffect1053ui_story then
				arg_170_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_173_4 = 0
			local var_173_5 = 0.45

			if var_173_4 < arg_170_1.time_ and arg_170_1.time_ <= var_173_4 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				local var_173_6 = arg_170_1:FormatText(StoryNameCfg[472].name)

				arg_170_1.leftNameTxt_.text = var_173_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_7 = arg_170_1:GetWordFromCfg(323171041)
				local var_173_8 = arg_170_1:FormatText(var_173_7.content)

				arg_170_1.text_.text = var_173_8

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_9 = 18
				local var_173_10 = utf8.len(var_173_8)
				local var_173_11 = var_173_9 <= 0 and var_173_5 or var_173_5 * (var_173_10 / var_173_9)

				if var_173_11 > 0 and var_173_5 < var_173_11 then
					arg_170_1.talkMaxDuration = var_173_11

					if var_173_11 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_11 + var_173_4
					end
				end

				arg_170_1.text_.text = var_173_8
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171041", "story_v_out_323171.awb") ~= 0 then
					local var_173_12 = manager.audio:GetVoiceLength("story_v_out_323171", "323171041", "story_v_out_323171.awb") / 1000

					if var_173_12 + var_173_4 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_12 + var_173_4
					end

					if var_173_7.prefab_name ~= "" and arg_170_1.actors_[var_173_7.prefab_name] ~= nil then
						local var_173_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_7.prefab_name].transform, "story_v_out_323171", "323171041", "story_v_out_323171.awb")

						arg_170_1:RecordAudio("323171041", var_173_13)
						arg_170_1:RecordAudio("323171041", var_173_13)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_323171", "323171041", "story_v_out_323171.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_323171", "323171041", "story_v_out_323171.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_14 = math.max(var_173_5, arg_170_1.talkMaxDuration)

			if var_173_4 <= arg_170_1.time_ and arg_170_1.time_ < var_173_4 + var_173_14 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_4) / var_173_14

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_4 + var_173_14 and arg_170_1.time_ < var_173_4 + var_173_14 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play323171042 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 323171042
		arg_174_1.duration_ = 20.17

		local var_174_0 = {
			zh = 14.366,
			ja = 20.166
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play323171043(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1053ui_story"]
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1053ui_story == nil then
				arg_174_1.var_.characterEffect1053ui_story = var_177_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 and not isNil(var_177_0) then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2

				if arg_174_1.var_.characterEffect1053ui_story and not isNil(var_177_0) then
					local var_177_4 = Mathf.Lerp(0, 0.5, var_177_3)

					arg_174_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1053ui_story.fillRatio = var_177_4
				end
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 and not isNil(var_177_0) and arg_174_1.var_.characterEffect1053ui_story then
				local var_177_5 = 0.5

				arg_174_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1053ui_story.fillRatio = var_177_5
			end

			local var_177_6 = 0
			local var_177_7 = 1.275

			if var_177_6 < arg_174_1.time_ and arg_174_1.time_ <= var_177_6 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_8 = arg_174_1:FormatText(StoryNameCfg[1454].name)

				arg_174_1.leftNameTxt_.text = var_177_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_9 = arg_174_1:GetWordFromCfg(323171042)
				local var_177_10 = arg_174_1:FormatText(var_177_9.content)

				arg_174_1.text_.text = var_177_10

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_11 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171042", "story_v_out_323171.awb") ~= 0 then
					local var_177_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171042", "story_v_out_323171.awb") / 1000

					if var_177_14 + var_177_6 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_14 + var_177_6
					end

					if var_177_9.prefab_name ~= "" and arg_174_1.actors_[var_177_9.prefab_name] ~= nil then
						local var_177_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_9.prefab_name].transform, "story_v_out_323171", "323171042", "story_v_out_323171.awb")

						arg_174_1:RecordAudio("323171042", var_177_15)
						arg_174_1:RecordAudio("323171042", var_177_15)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_323171", "323171042", "story_v_out_323171.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_323171", "323171042", "story_v_out_323171.awb")
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
	Play323171043 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 323171043
		arg_178_1.duration_ = 9.87

		local var_178_0 = {
			zh = 3.833,
			ja = 9.866
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
				arg_178_0:Play323171044(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0
			local var_181_1 = 0.4

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_2 = arg_178_1:FormatText(StoryNameCfg[1454].name)

				arg_178_1.leftNameTxt_.text = var_181_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_3 = arg_178_1:GetWordFromCfg(323171043)
				local var_181_4 = arg_178_1:FormatText(var_181_3.content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_5 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171043", "story_v_out_323171.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_out_323171", "323171043", "story_v_out_323171.awb") / 1000

					if var_181_8 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_0
					end

					if var_181_3.prefab_name ~= "" and arg_178_1.actors_[var_181_3.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_3.prefab_name].transform, "story_v_out_323171", "323171043", "story_v_out_323171.awb")

						arg_178_1:RecordAudio("323171043", var_181_9)
						arg_178_1:RecordAudio("323171043", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_323171", "323171043", "story_v_out_323171.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_323171", "323171043", "story_v_out_323171.awb")
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
	Play323171044 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 323171044
		arg_182_1.duration_ = 9.97

		local var_182_0 = {
			zh = 5.566,
			ja = 9.966
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
				arg_182_0:Play323171045(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1053ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1053ui_story == nil then
				arg_182_1.var_.characterEffect1053ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1053ui_story and not isNil(var_185_0) then
					arg_182_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1053ui_story then
				arg_182_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_185_4 = 0

			if var_185_4 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action2_1")
			end

			local var_185_5 = 0

			if var_185_5 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 then
				arg_182_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_185_6 = 0
			local var_185_7 = 0.55

			if var_185_6 < arg_182_1.time_ and arg_182_1.time_ <= var_185_6 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_8 = arg_182_1:FormatText(StoryNameCfg[472].name)

				arg_182_1.leftNameTxt_.text = var_185_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_9 = arg_182_1:GetWordFromCfg(323171044)
				local var_185_10 = arg_182_1:FormatText(var_185_9.content)

				arg_182_1.text_.text = var_185_10

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_11 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171044", "story_v_out_323171.awb") ~= 0 then
					local var_185_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171044", "story_v_out_323171.awb") / 1000

					if var_185_14 + var_185_6 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_14 + var_185_6
					end

					if var_185_9.prefab_name ~= "" and arg_182_1.actors_[var_185_9.prefab_name] ~= nil then
						local var_185_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_9.prefab_name].transform, "story_v_out_323171", "323171044", "story_v_out_323171.awb")

						arg_182_1:RecordAudio("323171044", var_185_15)
						arg_182_1:RecordAudio("323171044", var_185_15)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_323171", "323171044", "story_v_out_323171.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_323171", "323171044", "story_v_out_323171.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_16 = math.max(var_185_7, arg_182_1.talkMaxDuration)

			if var_185_6 <= arg_182_1.time_ and arg_182_1.time_ < var_185_6 + var_185_16 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_6) / var_185_16

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_6 + var_185_16 and arg_182_1.time_ < var_185_6 + var_185_16 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play323171045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 323171045
		arg_186_1.duration_ = 19.47

		local var_186_0 = {
			zh = 11,
			ja = 19.466
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
				arg_186_0:Play323171046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1053ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1053ui_story == nil then
				arg_186_1.var_.characterEffect1053ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect1053ui_story and not isNil(var_189_0) then
					local var_189_4 = Mathf.Lerp(0, 0.5, var_189_3)

					arg_186_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1053ui_story.fillRatio = var_189_4
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1053ui_story then
				local var_189_5 = 0.5

				arg_186_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1053ui_story.fillRatio = var_189_5
			end

			local var_189_6 = 0
			local var_189_7 = 0.975

			if var_189_6 < arg_186_1.time_ and arg_186_1.time_ <= var_189_6 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_8 = arg_186_1:FormatText(StoryNameCfg[1454].name)

				arg_186_1.leftNameTxt_.text = var_189_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_9 = arg_186_1:GetWordFromCfg(323171045)
				local var_189_10 = arg_186_1:FormatText(var_189_9.content)

				arg_186_1.text_.text = var_189_10

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_11 = 39
				local var_189_12 = utf8.len(var_189_10)
				local var_189_13 = var_189_11 <= 0 and var_189_7 or var_189_7 * (var_189_12 / var_189_11)

				if var_189_13 > 0 and var_189_7 < var_189_13 then
					arg_186_1.talkMaxDuration = var_189_13

					if var_189_13 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_13 + var_189_6
					end
				end

				arg_186_1.text_.text = var_189_10
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171045", "story_v_out_323171.awb") ~= 0 then
					local var_189_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171045", "story_v_out_323171.awb") / 1000

					if var_189_14 + var_189_6 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_14 + var_189_6
					end

					if var_189_9.prefab_name ~= "" and arg_186_1.actors_[var_189_9.prefab_name] ~= nil then
						local var_189_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_9.prefab_name].transform, "story_v_out_323171", "323171045", "story_v_out_323171.awb")

						arg_186_1:RecordAudio("323171045", var_189_15)
						arg_186_1:RecordAudio("323171045", var_189_15)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_323171", "323171045", "story_v_out_323171.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_323171", "323171045", "story_v_out_323171.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_16 = math.max(var_189_7, arg_186_1.talkMaxDuration)

			if var_189_6 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_16 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_6) / var_189_16

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_6 + var_189_16 and arg_186_1.time_ < var_189_6 + var_189_16 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play323171046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 323171046
		arg_190_1.duration_ = 13

		local var_190_0 = {
			zh = 9.733,
			ja = 13
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play323171047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1053ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1053ui_story == nil then
				arg_190_1.var_.characterEffect1053ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1053ui_story and not isNil(var_193_0) then
					arg_190_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1053ui_story then
				arg_190_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_193_4 = 0
			local var_193_5 = 0.975

			if var_193_4 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_6 = arg_190_1:FormatText(StoryNameCfg[472].name)

				arg_190_1.leftNameTxt_.text = var_193_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_7 = arg_190_1:GetWordFromCfg(323171046)
				local var_193_8 = arg_190_1:FormatText(var_193_7.content)

				arg_190_1.text_.text = var_193_8

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 39
				local var_193_10 = utf8.len(var_193_8)
				local var_193_11 = var_193_9 <= 0 and var_193_5 or var_193_5 * (var_193_10 / var_193_9)

				if var_193_11 > 0 and var_193_5 < var_193_11 then
					arg_190_1.talkMaxDuration = var_193_11

					if var_193_11 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_11 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_8
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171046", "story_v_out_323171.awb") ~= 0 then
					local var_193_12 = manager.audio:GetVoiceLength("story_v_out_323171", "323171046", "story_v_out_323171.awb") / 1000

					if var_193_12 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_12 + var_193_4
					end

					if var_193_7.prefab_name ~= "" and arg_190_1.actors_[var_193_7.prefab_name] ~= nil then
						local var_193_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_7.prefab_name].transform, "story_v_out_323171", "323171046", "story_v_out_323171.awb")

						arg_190_1:RecordAudio("323171046", var_193_13)
						arg_190_1:RecordAudio("323171046", var_193_13)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_323171", "323171046", "story_v_out_323171.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_323171", "323171046", "story_v_out_323171.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_14 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_14 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_14

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_14 and arg_190_1.time_ < var_193_4 + var_193_14 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play323171047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 323171047
		arg_194_1.duration_ = 9.3

		local var_194_0 = {
			zh = 6.866,
			ja = 9.3
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play323171048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1053ui_story"]
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1053ui_story == nil then
				arg_194_1.var_.characterEffect1053ui_story = var_197_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.200000002980232

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 and not isNil(var_197_0) then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2

				if arg_194_1.var_.characterEffect1053ui_story and not isNil(var_197_0) then
					local var_197_4 = Mathf.Lerp(0, 0.5, var_197_3)

					arg_194_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_194_1.var_.characterEffect1053ui_story.fillRatio = var_197_4
				end
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 and not isNil(var_197_0) and arg_194_1.var_.characterEffect1053ui_story then
				local var_197_5 = 0.5

				arg_194_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_194_1.var_.characterEffect1053ui_story.fillRatio = var_197_5
			end

			local var_197_6 = 0
			local var_197_7 = 0.675

			if var_197_6 < arg_194_1.time_ and arg_194_1.time_ <= var_197_6 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_8 = arg_194_1:FormatText(StoryNameCfg[1454].name)

				arg_194_1.leftNameTxt_.text = var_197_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_9 = arg_194_1:GetWordFromCfg(323171047)
				local var_197_10 = arg_194_1:FormatText(var_197_9.content)

				arg_194_1.text_.text = var_197_10

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_11 = 27
				local var_197_12 = utf8.len(var_197_10)
				local var_197_13 = var_197_11 <= 0 and var_197_7 or var_197_7 * (var_197_12 / var_197_11)

				if var_197_13 > 0 and var_197_7 < var_197_13 then
					arg_194_1.talkMaxDuration = var_197_13

					if var_197_13 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_13 + var_197_6
					end
				end

				arg_194_1.text_.text = var_197_10
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171047", "story_v_out_323171.awb") ~= 0 then
					local var_197_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171047", "story_v_out_323171.awb") / 1000

					if var_197_14 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_14 + var_197_6
					end

					if var_197_9.prefab_name ~= "" and arg_194_1.actors_[var_197_9.prefab_name] ~= nil then
						local var_197_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_9.prefab_name].transform, "story_v_out_323171", "323171047", "story_v_out_323171.awb")

						arg_194_1:RecordAudio("323171047", var_197_15)
						arg_194_1:RecordAudio("323171047", var_197_15)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_323171", "323171047", "story_v_out_323171.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_323171", "323171047", "story_v_out_323171.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_16 = math.max(var_197_7, arg_194_1.talkMaxDuration)

			if var_197_6 <= arg_194_1.time_ and arg_194_1.time_ < var_197_6 + var_197_16 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_6) / var_197_16

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_6 + var_197_16 and arg_194_1.time_ < var_197_6 + var_197_16 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play323171048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 323171048
		arg_198_1.duration_ = 4.4

		local var_198_0 = {
			zh = 2.466,
			ja = 4.4
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
				arg_198_0:Play323171049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["1053ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1053ui_story == nil then
				arg_198_1.var_.characterEffect1053ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect1053ui_story and not isNil(var_201_0) then
					arg_198_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect1053ui_story then
				arg_198_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_201_4 = 0
			local var_201_5 = 0.3

			if var_201_4 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_6 = arg_198_1:FormatText(StoryNameCfg[472].name)

				arg_198_1.leftNameTxt_.text = var_201_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_7 = arg_198_1:GetWordFromCfg(323171048)
				local var_201_8 = arg_198_1:FormatText(var_201_7.content)

				arg_198_1.text_.text = var_201_8

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 12
				local var_201_10 = utf8.len(var_201_8)
				local var_201_11 = var_201_9 <= 0 and var_201_5 or var_201_5 * (var_201_10 / var_201_9)

				if var_201_11 > 0 and var_201_5 < var_201_11 then
					arg_198_1.talkMaxDuration = var_201_11

					if var_201_11 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_11 + var_201_4
					end
				end

				arg_198_1.text_.text = var_201_8
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171048", "story_v_out_323171.awb") ~= 0 then
					local var_201_12 = manager.audio:GetVoiceLength("story_v_out_323171", "323171048", "story_v_out_323171.awb") / 1000

					if var_201_12 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_12 + var_201_4
					end

					if var_201_7.prefab_name ~= "" and arg_198_1.actors_[var_201_7.prefab_name] ~= nil then
						local var_201_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_7.prefab_name].transform, "story_v_out_323171", "323171048", "story_v_out_323171.awb")

						arg_198_1:RecordAudio("323171048", var_201_13)
						arg_198_1:RecordAudio("323171048", var_201_13)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_323171", "323171048", "story_v_out_323171.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_323171", "323171048", "story_v_out_323171.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_14 = math.max(var_201_5, arg_198_1.talkMaxDuration)

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_14 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_4) / var_201_14

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_4 + var_201_14 and arg_198_1.time_ < var_201_4 + var_201_14 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play323171049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 323171049
		arg_202_1.duration_ = 9.43

		local var_202_0 = {
			zh = 4.4,
			ja = 9.433
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play323171050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = arg_202_1.actors_["1053ui_story"]
			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1053ui_story == nil then
				arg_202_1.var_.characterEffect1053ui_story = var_205_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_2 and not isNil(var_205_0) then
				local var_205_3 = (arg_202_1.time_ - var_205_1) / var_205_2

				if arg_202_1.var_.characterEffect1053ui_story and not isNil(var_205_0) then
					local var_205_4 = Mathf.Lerp(0, 0.5, var_205_3)

					arg_202_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1053ui_story.fillRatio = var_205_4
				end
			end

			if arg_202_1.time_ >= var_205_1 + var_205_2 and arg_202_1.time_ < var_205_1 + var_205_2 + arg_205_0 and not isNil(var_205_0) and arg_202_1.var_.characterEffect1053ui_story then
				local var_205_5 = 0.5

				arg_202_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1053ui_story.fillRatio = var_205_5
			end

			local var_205_6 = 0
			local var_205_7 = 0.5

			if var_205_6 < arg_202_1.time_ and arg_202_1.time_ <= var_205_6 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_8 = arg_202_1:FormatText(StoryNameCfg[1454].name)

				arg_202_1.leftNameTxt_.text = var_205_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_9 = arg_202_1:GetWordFromCfg(323171049)
				local var_205_10 = arg_202_1:FormatText(var_205_9.content)

				arg_202_1.text_.text = var_205_10

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_11 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171049", "story_v_out_323171.awb") ~= 0 then
					local var_205_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171049", "story_v_out_323171.awb") / 1000

					if var_205_14 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_14 + var_205_6
					end

					if var_205_9.prefab_name ~= "" and arg_202_1.actors_[var_205_9.prefab_name] ~= nil then
						local var_205_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_9.prefab_name].transform, "story_v_out_323171", "323171049", "story_v_out_323171.awb")

						arg_202_1:RecordAudio("323171049", var_205_15)
						arg_202_1:RecordAudio("323171049", var_205_15)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_323171", "323171049", "story_v_out_323171.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_323171", "323171049", "story_v_out_323171.awb")
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
	Play323171050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 323171050
		arg_206_1.duration_ = 4.2

		local var_206_0 = {
			zh = 2.833,
			ja = 4.2
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play323171051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["1053ui_story"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect1053ui_story == nil then
				arg_206_1.var_.characterEffect1053ui_story = var_209_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.200000002980232

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.characterEffect1053ui_story and not isNil(var_209_0) then
					arg_206_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect1053ui_story then
				arg_206_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_209_4 = 0

			if var_209_4 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action2_2")
			end

			local var_209_5 = 0

			if var_209_5 < arg_206_1.time_ and arg_206_1.time_ <= var_209_5 + arg_209_0 then
				arg_206_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_209_6 = 0
			local var_209_7 = 0.325

			if var_209_6 < arg_206_1.time_ and arg_206_1.time_ <= var_209_6 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_8 = arg_206_1:FormatText(StoryNameCfg[472].name)

				arg_206_1.leftNameTxt_.text = var_209_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_9 = arg_206_1:GetWordFromCfg(323171050)
				local var_209_10 = arg_206_1:FormatText(var_209_9.content)

				arg_206_1.text_.text = var_209_10

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_11 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171050", "story_v_out_323171.awb") ~= 0 then
					local var_209_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171050", "story_v_out_323171.awb") / 1000

					if var_209_14 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_14 + var_209_6
					end

					if var_209_9.prefab_name ~= "" and arg_206_1.actors_[var_209_9.prefab_name] ~= nil then
						local var_209_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_9.prefab_name].transform, "story_v_out_323171", "323171050", "story_v_out_323171.awb")

						arg_206_1:RecordAudio("323171050", var_209_15)
						arg_206_1:RecordAudio("323171050", var_209_15)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_323171", "323171050", "story_v_out_323171.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_323171", "323171050", "story_v_out_323171.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_16 = math.max(var_209_7, arg_206_1.talkMaxDuration)

			if var_209_6 <= arg_206_1.time_ and arg_206_1.time_ < var_209_6 + var_209_16 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_6) / var_209_16

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_6 + var_209_16 and arg_206_1.time_ < var_209_6 + var_209_16 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play323171051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 323171051
		arg_210_1.duration_ = 5.53

		local var_210_0 = {
			zh = 4.3,
			ja = 5.533
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
				arg_210_0:Play323171052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = arg_210_1.actors_["1053ui_story"]
			local var_213_1 = 0

			if var_213_1 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1053ui_story == nil then
				arg_210_1.var_.characterEffect1053ui_story = var_213_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_2 and not isNil(var_213_0) then
				local var_213_3 = (arg_210_1.time_ - var_213_1) / var_213_2

				if arg_210_1.var_.characterEffect1053ui_story and not isNil(var_213_0) then
					local var_213_4 = Mathf.Lerp(0, 0.5, var_213_3)

					arg_210_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1053ui_story.fillRatio = var_213_4
				end
			end

			if arg_210_1.time_ >= var_213_1 + var_213_2 and arg_210_1.time_ < var_213_1 + var_213_2 + arg_213_0 and not isNil(var_213_0) and arg_210_1.var_.characterEffect1053ui_story then
				local var_213_5 = 0.5

				arg_210_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1053ui_story.fillRatio = var_213_5
			end

			local var_213_6 = 0
			local var_213_7 = 0.35

			if var_213_6 < arg_210_1.time_ and arg_210_1.time_ <= var_213_6 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_8 = arg_210_1:FormatText(StoryNameCfg[1454].name)

				arg_210_1.leftNameTxt_.text = var_213_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_9 = arg_210_1:GetWordFromCfg(323171051)
				local var_213_10 = arg_210_1:FormatText(var_213_9.content)

				arg_210_1.text_.text = var_213_10

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_11 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171051", "story_v_out_323171.awb") ~= 0 then
					local var_213_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171051", "story_v_out_323171.awb") / 1000

					if var_213_14 + var_213_6 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_14 + var_213_6
					end

					if var_213_9.prefab_name ~= "" and arg_210_1.actors_[var_213_9.prefab_name] ~= nil then
						local var_213_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_9.prefab_name].transform, "story_v_out_323171", "323171051", "story_v_out_323171.awb")

						arg_210_1:RecordAudio("323171051", var_213_15)
						arg_210_1:RecordAudio("323171051", var_213_15)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_323171", "323171051", "story_v_out_323171.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_323171", "323171051", "story_v_out_323171.awb")
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
	Play323171052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 323171052
		arg_214_1.duration_ = 5.67

		local var_214_0 = {
			zh = 3.6,
			ja = 5.666
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
				arg_214_0:Play323171053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = arg_214_1.actors_["1053ui_story"]
			local var_217_1 = 0

			if var_217_1 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1053ui_story == nil then
				arg_214_1.var_.characterEffect1053ui_story = var_217_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_2 = 0.200000002980232

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_2 and not isNil(var_217_0) then
				local var_217_3 = (arg_214_1.time_ - var_217_1) / var_217_2

				if arg_214_1.var_.characterEffect1053ui_story and not isNil(var_217_0) then
					arg_214_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= var_217_1 + var_217_2 and arg_214_1.time_ < var_217_1 + var_217_2 + arg_217_0 and not isNil(var_217_0) and arg_214_1.var_.characterEffect1053ui_story then
				arg_214_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_217_4 = 0
			local var_217_5 = 0.375

			if var_217_4 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_6 = arg_214_1:FormatText(StoryNameCfg[472].name)

				arg_214_1.leftNameTxt_.text = var_217_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_7 = arg_214_1:GetWordFromCfg(323171052)
				local var_217_8 = arg_214_1:FormatText(var_217_7.content)

				arg_214_1.text_.text = var_217_8

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_9 = 15
				local var_217_10 = utf8.len(var_217_8)
				local var_217_11 = var_217_9 <= 0 and var_217_5 or var_217_5 * (var_217_10 / var_217_9)

				if var_217_11 > 0 and var_217_5 < var_217_11 then
					arg_214_1.talkMaxDuration = var_217_11

					if var_217_11 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_11 + var_217_4
					end
				end

				arg_214_1.text_.text = var_217_8
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171052", "story_v_out_323171.awb") ~= 0 then
					local var_217_12 = manager.audio:GetVoiceLength("story_v_out_323171", "323171052", "story_v_out_323171.awb") / 1000

					if var_217_12 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_12 + var_217_4
					end

					if var_217_7.prefab_name ~= "" and arg_214_1.actors_[var_217_7.prefab_name] ~= nil then
						local var_217_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_7.prefab_name].transform, "story_v_out_323171", "323171052", "story_v_out_323171.awb")

						arg_214_1:RecordAudio("323171052", var_217_13)
						arg_214_1:RecordAudio("323171052", var_217_13)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_323171", "323171052", "story_v_out_323171.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_323171", "323171052", "story_v_out_323171.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_14 = math.max(var_217_5, arg_214_1.talkMaxDuration)

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_4) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_4 + var_217_14 and arg_214_1.time_ < var_217_4 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play323171053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 323171053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play323171054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = arg_218_1.actors_["1053ui_story"].transform
			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1.var_.moveOldPos1053ui_story = var_221_0.localPosition

				local var_221_2 = GameObjectTools.GetOrAddComponent(var_221_0.gameObject, typeof(DynamicBoneHelper))

				if var_221_2 then
					var_221_2:EnableDynamicBone(false)
				end
			end

			local var_221_3 = 0.001

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_3 then
				local var_221_4 = (arg_218_1.time_ - var_221_1) / var_221_3
				local var_221_5 = Vector3.New(0, 100, 0)

				var_221_0.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1053ui_story, var_221_5, var_221_4)

				local var_221_6 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_6.x, var_221_6.y, var_221_6.z)

				local var_221_7 = var_221_0.localEulerAngles

				var_221_7.z = 0
				var_221_7.x = 0
				var_221_0.localEulerAngles = var_221_7
			end

			if arg_218_1.time_ >= var_221_1 + var_221_3 and arg_218_1.time_ < var_221_1 + var_221_3 + arg_221_0 then
				var_221_0.localPosition = Vector3.New(0, 100, 0)

				local var_221_8 = manager.ui.mainCamera.transform.position - var_221_0.position

				var_221_0.forward = Vector3.New(var_221_8.x, var_221_8.y, var_221_8.z)

				local var_221_9 = var_221_0.localEulerAngles

				var_221_9.z = 0
				var_221_9.x = 0
				var_221_0.localEulerAngles = var_221_9

				local var_221_10 = GameObjectTools.GetOrAddComponent(var_221_0.gameObject, typeof(DynamicBoneHelper))

				if var_221_10 then
					var_221_10:EnableDynamicBone(true)
				end
			end

			local var_221_11 = arg_218_1.actors_["1053ui_story"]
			local var_221_12 = 0

			if var_221_12 < arg_218_1.time_ and arg_218_1.time_ <= var_221_12 + arg_221_0 and not isNil(var_221_11) and arg_218_1.var_.characterEffect1053ui_story == nil then
				arg_218_1.var_.characterEffect1053ui_story = var_221_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_13 = 0.200000002980232

			if var_221_12 <= arg_218_1.time_ and arg_218_1.time_ < var_221_12 + var_221_13 and not isNil(var_221_11) then
				local var_221_14 = (arg_218_1.time_ - var_221_12) / var_221_13

				if arg_218_1.var_.characterEffect1053ui_story and not isNil(var_221_11) then
					local var_221_15 = Mathf.Lerp(0, 0.5, var_221_14)

					arg_218_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1053ui_story.fillRatio = var_221_15
				end
			end

			if arg_218_1.time_ >= var_221_12 + var_221_13 and arg_218_1.time_ < var_221_12 + var_221_13 + arg_221_0 and not isNil(var_221_11) and arg_218_1.var_.characterEffect1053ui_story then
				local var_221_16 = 0.5

				arg_218_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1053ui_story.fillRatio = var_221_16
			end

			local var_221_17 = 0.166666666666667
			local var_221_18 = 1

			if var_221_17 < arg_218_1.time_ and arg_218_1.time_ <= var_221_17 + arg_221_0 then
				local var_221_19 = "play"
				local var_221_20 = "effect"

				arg_218_1:AudioAction(var_221_19, var_221_20, "se_story_148", "se_story_148_chess03", "")
			end

			local var_221_21 = 0
			local var_221_22 = 0.65

			if var_221_21 < arg_218_1.time_ and arg_218_1.time_ <= var_221_21 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_23 = arg_218_1:GetWordFromCfg(323171053)
				local var_221_24 = arg_218_1:FormatText(var_221_23.content)

				arg_218_1.text_.text = var_221_24

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_25 = 26
				local var_221_26 = utf8.len(var_221_24)
				local var_221_27 = var_221_25 <= 0 and var_221_22 or var_221_22 * (var_221_26 / var_221_25)

				if var_221_27 > 0 and var_221_22 < var_221_27 then
					arg_218_1.talkMaxDuration = var_221_27

					if var_221_27 + var_221_21 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_27 + var_221_21
					end
				end

				arg_218_1.text_.text = var_221_24
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_28 = math.max(var_221_22, arg_218_1.talkMaxDuration)

			if var_221_21 <= arg_218_1.time_ and arg_218_1.time_ < var_221_21 + var_221_28 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_21) / var_221_28

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_21 + var_221_28 and arg_218_1.time_ < var_221_21 + var_221_28 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play323171054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 323171054
		arg_222_1.duration_ = 5.33

		local var_222_0 = {
			zh = 4.4,
			ja = 5.333
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
				arg_222_0:Play323171055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0
			local var_225_1 = 0.375

			if var_225_0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_2 = arg_222_1:FormatText(StoryNameCfg[1454].name)

				arg_222_1.leftNameTxt_.text = var_225_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_3 = arg_222_1:GetWordFromCfg(323171054)
				local var_225_4 = arg_222_1:FormatText(var_225_3.content)

				arg_222_1.text_.text = var_225_4

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 15
				local var_225_6 = utf8.len(var_225_4)
				local var_225_7 = var_225_5 <= 0 and var_225_1 or var_225_1 * (var_225_6 / var_225_5)

				if var_225_7 > 0 and var_225_1 < var_225_7 then
					arg_222_1.talkMaxDuration = var_225_7

					if var_225_7 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_7 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_4
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171054", "story_v_out_323171.awb") ~= 0 then
					local var_225_8 = manager.audio:GetVoiceLength("story_v_out_323171", "323171054", "story_v_out_323171.awb") / 1000

					if var_225_8 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_8 + var_225_0
					end

					if var_225_3.prefab_name ~= "" and arg_222_1.actors_[var_225_3.prefab_name] ~= nil then
						local var_225_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_3.prefab_name].transform, "story_v_out_323171", "323171054", "story_v_out_323171.awb")

						arg_222_1:RecordAudio("323171054", var_225_9)
						arg_222_1:RecordAudio("323171054", var_225_9)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_323171", "323171054", "story_v_out_323171.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_323171", "323171054", "story_v_out_323171.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_10 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_10 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_10

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_10 and arg_222_1.time_ < var_225_0 + var_225_10 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play323171055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 323171055
		arg_226_1.duration_ = 3.9

		local var_226_0 = {
			zh = 2.066,
			ja = 3.9
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play323171056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = arg_226_1.actors_["1053ui_story"].transform
			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.var_.moveOldPos1053ui_story = var_229_0.localPosition

				local var_229_2 = GameObjectTools.GetOrAddComponent(var_229_0.gameObject, typeof(DynamicBoneHelper))

				if var_229_2 then
					var_229_2:EnableDynamicBone(false)
				end
			end

			local var_229_3 = 0.001

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_3 then
				local var_229_4 = (arg_226_1.time_ - var_229_1) / var_229_3
				local var_229_5 = Vector3.New(0, -1.08, -6)

				var_229_0.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1053ui_story, var_229_5, var_229_4)

				local var_229_6 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_6.x, var_229_6.y, var_229_6.z)

				local var_229_7 = var_229_0.localEulerAngles

				var_229_7.z = 0
				var_229_7.x = 0
				var_229_0.localEulerAngles = var_229_7
			end

			if arg_226_1.time_ >= var_229_1 + var_229_3 and arg_226_1.time_ < var_229_1 + var_229_3 + arg_229_0 then
				var_229_0.localPosition = Vector3.New(0, -1.08, -6)

				local var_229_8 = manager.ui.mainCamera.transform.position - var_229_0.position

				var_229_0.forward = Vector3.New(var_229_8.x, var_229_8.y, var_229_8.z)

				local var_229_9 = var_229_0.localEulerAngles

				var_229_9.z = 0
				var_229_9.x = 0
				var_229_0.localEulerAngles = var_229_9

				local var_229_10 = GameObjectTools.GetOrAddComponent(var_229_0.gameObject, typeof(DynamicBoneHelper))

				if var_229_10 then
					var_229_10:EnableDynamicBone(true)
				end
			end

			local var_229_11 = arg_226_1.actors_["1053ui_story"]
			local var_229_12 = 0

			if var_229_12 < arg_226_1.time_ and arg_226_1.time_ <= var_229_12 + arg_229_0 and not isNil(var_229_11) and arg_226_1.var_.characterEffect1053ui_story == nil then
				arg_226_1.var_.characterEffect1053ui_story = var_229_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_13 = 0.200000002980232

			if var_229_12 <= arg_226_1.time_ and arg_226_1.time_ < var_229_12 + var_229_13 and not isNil(var_229_11) then
				local var_229_14 = (arg_226_1.time_ - var_229_12) / var_229_13

				if arg_226_1.var_.characterEffect1053ui_story and not isNil(var_229_11) then
					arg_226_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_12 + var_229_13 and arg_226_1.time_ < var_229_12 + var_229_13 + arg_229_0 and not isNil(var_229_11) and arg_226_1.var_.characterEffect1053ui_story then
				arg_226_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_229_15 = 0

			if var_229_15 < arg_226_1.time_ and arg_226_1.time_ <= var_229_15 + arg_229_0 then
				arg_226_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/story1053/story1053action/1053action1_1")
			end

			local var_229_16 = 0

			if var_229_16 < arg_226_1.time_ and arg_226_1.time_ <= var_229_16 + arg_229_0 then
				arg_226_1:PlayTimeline("1053ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_229_17 = 0
			local var_229_18 = 0.225

			if var_229_17 < arg_226_1.time_ and arg_226_1.time_ <= var_229_17 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_19 = arg_226_1:FormatText(StoryNameCfg[472].name)

				arg_226_1.leftNameTxt_.text = var_229_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_20 = arg_226_1:GetWordFromCfg(323171055)
				local var_229_21 = arg_226_1:FormatText(var_229_20.content)

				arg_226_1.text_.text = var_229_21

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_22 = 9
				local var_229_23 = utf8.len(var_229_21)
				local var_229_24 = var_229_22 <= 0 and var_229_18 or var_229_18 * (var_229_23 / var_229_22)

				if var_229_24 > 0 and var_229_18 < var_229_24 then
					arg_226_1.talkMaxDuration = var_229_24

					if var_229_24 + var_229_17 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_24 + var_229_17
					end
				end

				arg_226_1.text_.text = var_229_21
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171055", "story_v_out_323171.awb") ~= 0 then
					local var_229_25 = manager.audio:GetVoiceLength("story_v_out_323171", "323171055", "story_v_out_323171.awb") / 1000

					if var_229_25 + var_229_17 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_25 + var_229_17
					end

					if var_229_20.prefab_name ~= "" and arg_226_1.actors_[var_229_20.prefab_name] ~= nil then
						local var_229_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_20.prefab_name].transform, "story_v_out_323171", "323171055", "story_v_out_323171.awb")

						arg_226_1:RecordAudio("323171055", var_229_26)
						arg_226_1:RecordAudio("323171055", var_229_26)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_323171", "323171055", "story_v_out_323171.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_323171", "323171055", "story_v_out_323171.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_27 = math.max(var_229_18, arg_226_1.talkMaxDuration)

			if var_229_17 <= arg_226_1.time_ and arg_226_1.time_ < var_229_17 + var_229_27 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_17) / var_229_27

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_17 + var_229_27 and arg_226_1.time_ < var_229_17 + var_229_27 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1053ui_story",
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
	Play323171056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 323171056
		arg_230_1.duration_ = 10.17

		local var_230_0 = {
			zh = 6.4,
			ja = 10.166
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
				arg_230_0:Play323171057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["1053ui_story"]
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1053ui_story == nil then
				arg_230_1.var_.characterEffect1053ui_story = var_233_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 and not isNil(var_233_0) then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2

				if arg_230_1.var_.characterEffect1053ui_story and not isNil(var_233_0) then
					local var_233_4 = Mathf.Lerp(0, 0.5, var_233_3)

					arg_230_1.var_.characterEffect1053ui_story.fillFlat = true
					arg_230_1.var_.characterEffect1053ui_story.fillRatio = var_233_4
				end
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 and not isNil(var_233_0) and arg_230_1.var_.characterEffect1053ui_story then
				local var_233_5 = 0.5

				arg_230_1.var_.characterEffect1053ui_story.fillFlat = true
				arg_230_1.var_.characterEffect1053ui_story.fillRatio = var_233_5
			end

			local var_233_6 = 0
			local var_233_7 = 0.4

			if var_233_6 < arg_230_1.time_ and arg_230_1.time_ <= var_233_6 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				local var_233_8 = arg_230_1:FormatText(StoryNameCfg[1454].name)

				arg_230_1.leftNameTxt_.text = var_233_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10169")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_9 = arg_230_1:GetWordFromCfg(323171056)
				local var_233_10 = arg_230_1:FormatText(var_233_9.content)

				arg_230_1.text_.text = var_233_10

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_11 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171056", "story_v_out_323171.awb") ~= 0 then
					local var_233_14 = manager.audio:GetVoiceLength("story_v_out_323171", "323171056", "story_v_out_323171.awb") / 1000

					if var_233_14 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_14 + var_233_6
					end

					if var_233_9.prefab_name ~= "" and arg_230_1.actors_[var_233_9.prefab_name] ~= nil then
						local var_233_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_9.prefab_name].transform, "story_v_out_323171", "323171056", "story_v_out_323171.awb")

						arg_230_1:RecordAudio("323171056", var_233_15)
						arg_230_1:RecordAudio("323171056", var_233_15)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_323171", "323171056", "story_v_out_323171.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_323171", "323171056", "story_v_out_323171.awb")
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
	Play323171057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 323171057
		arg_234_1.duration_ = 12.23

		local var_234_0 = {
			zh = 8.366,
			ja = 12.233
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
				arg_234_0:Play323171058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = arg_234_1.actors_["1053ui_story"]
			local var_237_1 = 0

			if var_237_1 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1053ui_story == nil then
				arg_234_1.var_.characterEffect1053ui_story = var_237_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_2 and not isNil(var_237_0) then
				local var_237_3 = (arg_234_1.time_ - var_237_1) / var_237_2

				if arg_234_1.var_.characterEffect1053ui_story and not isNil(var_237_0) then
					arg_234_1.var_.characterEffect1053ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= var_237_1 + var_237_2 and arg_234_1.time_ < var_237_1 + var_237_2 + arg_237_0 and not isNil(var_237_0) and arg_234_1.var_.characterEffect1053ui_story then
				arg_234_1.var_.characterEffect1053ui_story.fillFlat = false
			end

			local var_237_4 = 0
			local var_237_5 = 0.85

			if var_237_4 < arg_234_1.time_ and arg_234_1.time_ <= var_237_4 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_6 = arg_234_1:FormatText(StoryNameCfg[472].name)

				arg_234_1.leftNameTxt_.text = var_237_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_7 = arg_234_1:GetWordFromCfg(323171057)
				local var_237_8 = arg_234_1:FormatText(var_237_7.content)

				arg_234_1.text_.text = var_237_8

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_9 = 34
				local var_237_10 = utf8.len(var_237_8)
				local var_237_11 = var_237_9 <= 0 and var_237_5 or var_237_5 * (var_237_10 / var_237_9)

				if var_237_11 > 0 and var_237_5 < var_237_11 then
					arg_234_1.talkMaxDuration = var_237_11

					if var_237_11 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_11 + var_237_4
					end
				end

				arg_234_1.text_.text = var_237_8
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171057", "story_v_out_323171.awb") ~= 0 then
					local var_237_12 = manager.audio:GetVoiceLength("story_v_out_323171", "323171057", "story_v_out_323171.awb") / 1000

					if var_237_12 + var_237_4 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_12 + var_237_4
					end

					if var_237_7.prefab_name ~= "" and arg_234_1.actors_[var_237_7.prefab_name] ~= nil then
						local var_237_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_7.prefab_name].transform, "story_v_out_323171", "323171057", "story_v_out_323171.awb")

						arg_234_1:RecordAudio("323171057", var_237_13)
						arg_234_1:RecordAudio("323171057", var_237_13)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_323171", "323171057", "story_v_out_323171.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_323171", "323171057", "story_v_out_323171.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_14 = math.max(var_237_5, arg_234_1.talkMaxDuration)

			if var_237_4 <= arg_234_1.time_ and arg_234_1.time_ < var_237_4 + var_237_14 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_4) / var_237_14

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_4 + var_237_14 and arg_234_1.time_ < var_237_4 + var_237_14 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play323171058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 323171058
		arg_238_1.duration_ = 5.53

		local var_238_0 = {
			zh = 2.933,
			ja = 5.533
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
			arg_238_1.auto_ = false
		end

		function arg_238_1.playNext_(arg_240_0)
			arg_238_1.onStoryFinished_()
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = 0
			local var_241_1 = 0.375

			if var_241_0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_0 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_2 = arg_238_1:FormatText(StoryNameCfg[472].name)

				arg_238_1.leftNameTxt_.text = var_241_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_3 = arg_238_1:GetWordFromCfg(323171058)
				local var_241_4 = arg_238_1:FormatText(var_241_3.content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_323171", "323171058", "story_v_out_323171.awb") ~= 0 then
					local var_241_8 = manager.audio:GetVoiceLength("story_v_out_323171", "323171058", "story_v_out_323171.awb") / 1000

					if var_241_8 + var_241_0 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_8 + var_241_0
					end

					if var_241_3.prefab_name ~= "" and arg_238_1.actors_[var_241_3.prefab_name] ~= nil then
						local var_241_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_3.prefab_name].transform, "story_v_out_323171", "323171058", "story_v_out_323171.awb")

						arg_238_1:RecordAudio("323171058", var_241_9)
						arg_238_1:RecordAudio("323171058", var_241_9)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_323171", "323171058", "story_v_out_323171.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_323171", "323171058", "story_v_out_323171.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_1, arg_238_1.talkMaxDuration)

			if var_241_0 <= arg_238_1.time_ and arg_238_1.time_ < var_241_0 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_0) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_0 + var_241_10 and arg_238_1.time_ < var_241_0 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J24g",
		"TextureConfig/Background/ST2005"
	},
	voices = {
		"story_v_out_323171.awb"
	}
}
