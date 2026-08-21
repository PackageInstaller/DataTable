return {
	Play113172001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113172001
		arg_1_1.duration_ = 12.77

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play113172002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "OM0104"

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
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.OM0104

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
					if iter_4_0 ~= "OM0104" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.OM0104.transform
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0104 = var_4_16.localPosition
			end

			local var_4_18 = 0.001

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				local var_4_19 = (arg_1_1.time_ - var_4_17) / var_4_18
				local var_4_20 = Vector3.New(-5, -1, 0.69)

				var_4_16.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0104, var_4_20, var_4_19)
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				var_4_16.localPosition = Vector3.New(-5, -1, 0.69)
			end

			local var_4_21 = arg_1_1.bgs_.OM0104.transform
			local var_4_22 = 0.0166666666666667

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0104 = var_4_21.localPosition
			end

			local var_4_23 = 3.98333333333333

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				local var_4_24 = (arg_1_1.time_ - var_4_22) / var_4_23
				local var_4_25 = Vector3.New(-5, -1.5, 0.69)

				var_4_21.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0104, var_4_25, var_4_24)
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				var_4_21.localPosition = Vector3.New(-5, -1.5, 0.69)
			end

			local var_4_26 = arg_1_1.bgs_.OM0104.transform
			local var_4_27 = 4

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0104 = var_4_26.localPosition
			end

			local var_4_28 = 0.001

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 then
				local var_4_29 = (arg_1_1.time_ - var_4_27) / var_4_28
				local var_4_30 = Vector3.New(4.5, 1.1, 1)

				var_4_26.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0104, var_4_30, var_4_29)
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 then
				var_4_26.localPosition = Vector3.New(4.5, 1.1, 1)
			end

			local var_4_31 = arg_1_1.bgs_.OM0104.transform
			local var_4_32 = 4.01666666666667

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0104 = var_4_31.localPosition
			end

			local var_4_33 = 3.98333333333333

			if var_4_32 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				local var_4_34 = (arg_1_1.time_ - var_4_32) / var_4_33
				local var_4_35 = Vector3.New(4.5, 0.8, 1)

				var_4_31.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0104, var_4_35, var_4_34)
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				var_4_31.localPosition = Vector3.New(4.5, 0.8, 1)
			end

			local var_4_36 = arg_1_1.bgs_.OM0104.transform
			local var_4_37 = 8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0104 = var_4_36.localPosition
			end

			local var_4_38 = 0.001

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38
				local var_4_40 = Vector3.New(0, 1, 9.5)

				var_4_36.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0104, var_4_40, var_4_39)
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				var_4_36.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_4_41 = arg_1_1.bgs_.OM0104.transform
			local var_4_42 = 8.01666666666667

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0104 = var_4_41.localPosition
			end

			local var_4_43 = 2.5

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				local var_4_44 = (arg_1_1.time_ - var_4_42) / var_4_43
				local var_4_45 = Vector3.New(0, 1, 10)

				var_4_41.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0104, var_4_45, var_4_44)
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				var_4_41.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_46 = 0

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_47 = 2

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				local var_4_48 = (arg_1_1.time_ - var_4_46) / var_4_47
				local var_4_49 = Color.New(0, 0, 0)

				var_4_49.a = Mathf.Lerp(1, 0, var_4_48)
				arg_1_1.mask_.color = var_4_49
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				local var_4_50 = Color.New(0, 0, 0)
				local var_4_51 = 0

				arg_1_1.mask_.enabled = false
				var_4_50.a = var_4_51
				arg_1_1.mask_.color = var_4_50
			end

			local var_4_52 = 2

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_53 = 2

			if var_4_52 <= arg_1_1.time_ and arg_1_1.time_ < var_4_52 + var_4_53 then
				local var_4_54 = (arg_1_1.time_ - var_4_52) / var_4_53
				local var_4_55 = Color.New(0, 0, 0)

				var_4_55.a = Mathf.Lerp(0, 1, var_4_54)
				arg_1_1.mask_.color = var_4_55
			end

			if arg_1_1.time_ >= var_4_52 + var_4_53 and arg_1_1.time_ < var_4_52 + var_4_53 + arg_4_0 then
				local var_4_56 = Color.New(0, 0, 0)

				var_4_56.a = 1
				arg_1_1.mask_.color = var_4_56
			end

			local var_4_57 = 4

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_58 = 2

			if var_4_57 <= arg_1_1.time_ and arg_1_1.time_ < var_4_57 + var_4_58 then
				local var_4_59 = (arg_1_1.time_ - var_4_57) / var_4_58
				local var_4_60 = Color.New(0, 0, 0)

				var_4_60.a = Mathf.Lerp(1, 0, var_4_59)
				arg_1_1.mask_.color = var_4_60
			end

			if arg_1_1.time_ >= var_4_57 + var_4_58 and arg_1_1.time_ < var_4_57 + var_4_58 + arg_4_0 then
				local var_4_61 = Color.New(0, 0, 0)
				local var_4_62 = 0

				arg_1_1.mask_.enabled = false
				var_4_61.a = var_4_62
				arg_1_1.mask_.color = var_4_61
			end

			local var_4_63 = 6

			if var_4_63 < arg_1_1.time_ and arg_1_1.time_ <= var_4_63 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_64 = 2

			if var_4_63 <= arg_1_1.time_ and arg_1_1.time_ < var_4_63 + var_4_64 then
				local var_4_65 = (arg_1_1.time_ - var_4_63) / var_4_64
				local var_4_66 = Color.New(0, 0, 0)

				var_4_66.a = Mathf.Lerp(0, 1, var_4_65)
				arg_1_1.mask_.color = var_4_66
			end

			if arg_1_1.time_ >= var_4_63 + var_4_64 and arg_1_1.time_ < var_4_63 + var_4_64 + arg_4_0 then
				local var_4_67 = Color.New(0, 0, 0)

				var_4_67.a = 1
				arg_1_1.mask_.color = var_4_67
			end

			local var_4_68 = 8

			if var_4_68 < arg_1_1.time_ and arg_1_1.time_ <= var_4_68 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_69 = 1.5

			if var_4_68 <= arg_1_1.time_ and arg_1_1.time_ < var_4_68 + var_4_69 then
				local var_4_70 = (arg_1_1.time_ - var_4_68) / var_4_69
				local var_4_71 = Color.New(0, 0, 0)

				var_4_71.a = Mathf.Lerp(1, 0, var_4_70)
				arg_1_1.mask_.color = var_4_71
			end

			if arg_1_1.time_ >= var_4_68 + var_4_69 and arg_1_1.time_ < var_4_68 + var_4_69 + arg_4_0 then
				local var_4_72 = Color.New(0, 0, 0)
				local var_4_73 = 0

				arg_1_1.mask_.enabled = false
				var_4_72.a = var_4_73
				arg_1_1.mask_.color = var_4_72
			end

			local var_4_74 = 10

			if var_4_74 < arg_1_1.time_ and arg_1_1.time_ <= var_4_74 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_75 = 0.6

			if arg_1_1.time_ >= var_4_74 + var_4_75 and arg_1_1.time_ < var_4_74 + var_4_75 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_76 = manager.ui.mainCamera.transform
			local var_4_77 = 10

			if var_4_77 < arg_1_1.time_ and arg_1_1.time_ <= var_4_77 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_76.localPosition
			end

			local var_4_78 = 0.6

			if var_4_77 <= arg_1_1.time_ and arg_1_1.time_ < var_4_77 + var_4_78 then
				local var_4_79 = (arg_1_1.time_ - var_4_77) / 0.066
				local var_4_80, var_4_81 = math.modf(var_4_79)

				var_4_76.localPosition = Vector3.New(var_4_81 * 0.13, var_4_81 * 0.13, var_4_81 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_77 + var_4_78 and arg_1_1.time_ < var_4_77 + var_4_78 + arg_4_0 then
				var_4_76.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_82 = 0
			local var_4_83 = 1

			if var_4_82 < arg_1_1.time_ and arg_1_1.time_ <= var_4_82 + arg_4_0 then
				local var_4_84 = "play"
				local var_4_85 = "effect"

				arg_1_1:AudioAction(var_4_84, var_4_85, "se_story_10", "se_story_10_smash", "")
			end

			local var_4_86 = 0
			local var_4_87 = 1

			if var_4_86 < arg_1_1.time_ and arg_1_1.time_ <= var_4_86 + arg_4_0 then
				local var_4_88 = "play"
				local var_4_89 = "music"

				arg_1_1:AudioAction(var_4_88, var_4_89, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_90 = ""
				local var_4_91 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_91 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_91 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_91

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_91
						arg_1_1.bgmTxt2_.text = var_4_91
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

			local var_4_92 = 10
			local var_4_93 = 0.6

			if var_4_92 < arg_1_1.time_ and arg_1_1.time_ <= var_4_92 + arg_4_0 then
				local var_4_94 = "play"
				local var_4_95 = "music"

				arg_1_1:AudioAction(var_4_94, var_4_95, "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")

				local var_4_96 = ""
				local var_4_97 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if var_4_97 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_97 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_97

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_97
						arg_1_1.bgmTxt2_.text = var_4_97
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

			local var_4_98 = 10
			local var_4_99 = 1

			if var_4_98 < arg_1_1.time_ and arg_1_1.time_ <= var_4_98 + arg_4_0 then
				local var_4_100 = "play"
				local var_4_101 = "effect"

				arg_1_1:AudioAction(var_4_100, var_4_101, "se_story", "se_story_robot_e", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_102 = 10
			local var_4_103 = 0.125

			if var_4_102 < arg_1_1.time_ and arg_1_1.time_ <= var_4_102 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_104 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_104:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_104:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_104:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_105 = arg_1_1:FormatText(StoryNameCfg[68].name)

				arg_1_1.leftNameTxt_.text = var_4_105

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2037")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_106 = arg_1_1:GetWordFromCfg(113172001)
				local var_4_107 = arg_1_1:FormatText(var_4_106.content)

				arg_1_1.text_.text = var_4_107

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_108 = 5
				local var_4_109 = utf8.len(var_4_107)
				local var_4_110 = var_4_108 <= 0 and var_4_103 or var_4_103 * (var_4_109 / var_4_108)

				if var_4_110 > 0 and var_4_103 < var_4_110 then
					arg_1_1.talkMaxDuration = var_4_110
					var_4_102 = var_4_102 + 0.3

					if var_4_110 + var_4_102 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_110 + var_4_102
					end
				end

				arg_1_1.text_.text = var_4_107
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172001", "story_v_out_113172.awb") ~= 0 then
					local var_4_111 = manager.audio:GetVoiceLength("story_v_out_113172", "113172001", "story_v_out_113172.awb") / 1000

					if var_4_111 + var_4_102 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_111 + var_4_102
					end

					if var_4_106.prefab_name ~= "" and arg_1_1.actors_[var_4_106.prefab_name] ~= nil then
						local var_4_112 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_106.prefab_name].transform, "story_v_out_113172", "113172001", "story_v_out_113172.awb")

						arg_1_1:RecordAudio("113172001", var_4_112)
						arg_1_1:RecordAudio("113172001", var_4_112)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113172", "113172001", "story_v_out_113172.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113172", "113172001", "story_v_out_113172.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_113 = var_4_102 + 0.3
			local var_4_114 = math.max(var_4_103, arg_1_1.talkMaxDuration)

			if var_4_113 <= arg_1_1.time_ and arg_1_1.time_ < var_4_113 + var_4_114 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_113) / var_4_114

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_113 + var_4_114 and arg_1_1.time_ < var_4_113 + var_4_114 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.98333333333333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.98333333333333,
				className = "StoryMoveNode",
				startTime = 4.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 8.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play113172002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113172002
		arg_9_1.duration_ = 1.93

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play113172003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_2 = "play"
				local var_12_3 = "effect"

				arg_9_1:AudioAction(var_12_2, var_12_3, "se_story_10", "se_story_10_smash02", "")
			end

			local var_12_4 = 0
			local var_12_5 = 1

			if var_12_4 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				local var_12_6 = "play"
				local var_12_7 = "effect"

				arg_9_1:AudioAction(var_12_6, var_12_7, "se_story_15", "se_story_15_roar3", "")
			end

			local var_12_8 = 0
			local var_12_9 = 0.1

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_10 = arg_9_1:FormatText(StoryNameCfg[68].name)

				arg_9_1.leftNameTxt_.text = var_12_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2038")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_11 = arg_9_1:GetWordFromCfg(113172002)
				local var_12_12 = arg_9_1:FormatText(var_12_11.content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 4
				local var_12_14 = utf8.len(var_12_12)
				local var_12_15 = var_12_13 <= 0 and var_12_9 or var_12_9 * (var_12_14 / var_12_13)

				if var_12_15 > 0 and var_12_9 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_12
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172002", "story_v_out_113172.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_113172", "113172002", "story_v_out_113172.awb") / 1000

					if var_12_16 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_8
					end

					if var_12_11.prefab_name ~= "" and arg_9_1.actors_[var_12_11.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_11.prefab_name].transform, "story_v_out_113172", "113172002", "story_v_out_113172.awb")

						arg_9_1:RecordAudio("113172002", var_12_17)
						arg_9_1:RecordAudio("113172002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113172", "113172002", "story_v_out_113172.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113172", "113172002", "story_v_out_113172.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_18 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_18 and arg_9_1.time_ < var_12_8 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play113172003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113172003
		arg_13_1.duration_ = 5.53

		local var_13_0 = {
			ja = 2.966,
			ko = 3.3,
			zh = 5.533,
			en = 3.7
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play113172004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.475

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[208].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_3 = arg_13_1:GetWordFromCfg(113172003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 19
				local var_16_6 = utf8.len(var_16_4)
				local var_16_7 = var_16_5 <= 0 and var_16_1 or var_16_1 * (var_16_6 / var_16_5)

				if var_16_7 > 0 and var_16_1 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172003", "story_v_out_113172.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_113172", "113172003", "story_v_out_113172.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_113172", "113172003", "story_v_out_113172.awb")

						arg_13_1:RecordAudio("113172003", var_16_9)
						arg_13_1:RecordAudio("113172003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_113172", "113172003", "story_v_out_113172.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_113172", "113172003", "story_v_out_113172.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_10 and arg_13_1.time_ < var_16_0 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play113172004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113172004
		arg_17_1.duration_ = 15.97

		local var_17_0 = {
			ja = 9.833,
			ko = 8.066,
			zh = 10.5,
			en = 15.966
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
				arg_17_0:Play113172005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.85

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[225].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(113172004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 34
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172004", "story_v_out_113172.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_113172", "113172004", "story_v_out_113172.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_113172", "113172004", "story_v_out_113172.awb")

						arg_17_1:RecordAudio("113172004", var_20_9)
						arg_17_1:RecordAudio("113172004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113172", "113172004", "story_v_out_113172.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113172", "113172004", "story_v_out_113172.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play113172005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113172005
		arg_21_1.duration_ = 9.4

		local var_21_0 = {
			ja = 7.966,
			ko = 9.4,
			zh = 8.633,
			en = 7.7
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play113172006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.725

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_2 = arg_21_1:FormatText(StoryNameCfg[225].name)

				arg_21_1.leftNameTxt_.text = var_24_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:GetWordFromCfg(113172005)
				local var_24_4 = arg_21_1:FormatText(var_24_3.content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 29
				local var_24_6 = utf8.len(var_24_4)
				local var_24_7 = var_24_5 <= 0 and var_24_1 or var_24_1 * (var_24_6 / var_24_5)

				if var_24_7 > 0 and var_24_1 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172005", "story_v_out_113172.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_113172", "113172005", "story_v_out_113172.awb") / 1000

					if var_24_8 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_0
					end

					if var_24_3.prefab_name ~= "" and arg_21_1.actors_[var_24_3.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_3.prefab_name].transform, "story_v_out_113172", "113172005", "story_v_out_113172.awb")

						arg_21_1:RecordAudio("113172005", var_24_9)
						arg_21_1:RecordAudio("113172005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_113172", "113172005", "story_v_out_113172.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_113172", "113172005", "story_v_out_113172.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_10 and arg_21_1.time_ < var_24_0 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play113172006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 113172006
		arg_25_1.duration_ = 2.5

		local var_25_0 = {
			ja = 2.3,
			ko = 1.9,
			zh = 2.1,
			en = 2.5
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play113172007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = manager.ui.mainCamera.transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.shakeOldPos = var_28_0.localPosition
			end

			local var_28_2 = 0.6

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / 0.066
				local var_28_4, var_28_5 = math.modf(var_28_3)

				var_28_0.localPosition = Vector3.New(var_28_5 * 0.13, var_28_5 * 0.13, var_28_5 * 0.13) + arg_25_1.var_.shakeOldPos
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = arg_25_1.var_.shakeOldPos
			end

			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			local var_28_7 = 0.6

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			local var_28_8 = 0
			local var_28_9 = 0.25

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_10 = arg_25_1:FormatText(StoryNameCfg[208].name)

				arg_25_1.leftNameTxt_.text = var_28_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_11 = arg_25_1:GetWordFromCfg(113172006)
				local var_28_12 = arg_25_1:FormatText(var_28_11.content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 10
				local var_28_14 = utf8.len(var_28_12)
				local var_28_15 = var_28_13 <= 0 and var_28_9 or var_28_9 * (var_28_14 / var_28_13)

				if var_28_15 > 0 and var_28_9 < var_28_15 then
					arg_25_1.talkMaxDuration = var_28_15

					if var_28_15 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_15 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_12
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172006", "story_v_out_113172.awb") ~= 0 then
					local var_28_16 = manager.audio:GetVoiceLength("story_v_out_113172", "113172006", "story_v_out_113172.awb") / 1000

					if var_28_16 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_16 + var_28_8
					end

					if var_28_11.prefab_name ~= "" and arg_25_1.actors_[var_28_11.prefab_name] ~= nil then
						local var_28_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_11.prefab_name].transform, "story_v_out_113172", "113172006", "story_v_out_113172.awb")

						arg_25_1:RecordAudio("113172006", var_28_17)
						arg_25_1:RecordAudio("113172006", var_28_17)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_113172", "113172006", "story_v_out_113172.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_113172", "113172006", "story_v_out_113172.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_18 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_18 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_18

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_18 and arg_25_1.time_ < var_28_8 + var_28_18 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play113172007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 113172007
		arg_29_1.duration_ = 7.4

		local var_29_0 = {
			ja = 7.4,
			ko = 5.466,
			zh = 7,
			en = 5.966
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play113172008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 1

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				local var_32_2 = "play"
				local var_32_3 = "effect"

				arg_29_1:AudioAction(var_32_2, var_32_3, "se_story_10", "se_story_10_smash03", "")
			end

			local var_32_4 = 0
			local var_32_5 = 0.65

			if var_32_4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_6 = arg_29_1:FormatText(StoryNameCfg[225].name)

				arg_29_1.leftNameTxt_.text = var_32_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_7 = arg_29_1:GetWordFromCfg(113172007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 26
				local var_32_10 = utf8.len(var_32_8)
				local var_32_11 = var_32_9 <= 0 and var_32_5 or var_32_5 * (var_32_10 / var_32_9)

				if var_32_11 > 0 and var_32_5 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172007", "story_v_out_113172.awb") ~= 0 then
					local var_32_12 = manager.audio:GetVoiceLength("story_v_out_113172", "113172007", "story_v_out_113172.awb") / 1000

					if var_32_12 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_4
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_113172", "113172007", "story_v_out_113172.awb")

						arg_29_1:RecordAudio("113172007", var_32_13)
						arg_29_1:RecordAudio("113172007", var_32_13)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_113172", "113172007", "story_v_out_113172.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_113172", "113172007", "story_v_out_113172.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_14 and arg_29_1.time_ < var_32_4 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play113172008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 113172008
		arg_33_1.duration_ = 4.3

		local var_33_0 = {
			ja = 3.9,
			ko = 3.533,
			zh = 3.533,
			en = 4.3
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play113172009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.225

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[225].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(113172008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172008", "story_v_out_113172.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_113172", "113172008", "story_v_out_113172.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_113172", "113172008", "story_v_out_113172.awb")

						arg_33_1:RecordAudio("113172008", var_36_9)
						arg_33_1:RecordAudio("113172008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_113172", "113172008", "story_v_out_113172.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_113172", "113172008", "story_v_out_113172.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play113172009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 113172009
		arg_37_1.duration_ = 9.23

		local var_37_0 = {
			ja = 6.033,
			ko = 5.633,
			zh = 9.233,
			en = 4.8
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play113172010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.6

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[208].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(113172009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 24
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172009", "story_v_out_113172.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_113172", "113172009", "story_v_out_113172.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_113172", "113172009", "story_v_out_113172.awb")

						arg_37_1:RecordAudio("113172009", var_40_9)
						arg_37_1:RecordAudio("113172009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_113172", "113172009", "story_v_out_113172.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_113172", "113172009", "story_v_out_113172.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play113172010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 113172010
		arg_41_1.duration_ = 10.97

		local var_41_0 = {
			ja = 10.966,
			ko = 5.366,
			zh = 7.9,
			en = 6.5
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
				arg_41_0:Play113172011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.45

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[225].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005_B")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:GetWordFromCfg(113172010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 18
				local var_44_6 = utf8.len(var_44_4)
				local var_44_7 = var_44_5 <= 0 and var_44_1 or var_44_1 * (var_44_6 / var_44_5)

				if var_44_7 > 0 and var_44_1 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172010", "story_v_out_113172.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_113172", "113172010", "story_v_out_113172.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_113172", "113172010", "story_v_out_113172.awb")

						arg_41_1:RecordAudio("113172010", var_44_9)
						arg_41_1:RecordAudio("113172010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_113172", "113172010", "story_v_out_113172.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_113172", "113172010", "story_v_out_113172.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_10 and arg_41_1.time_ < var_44_0 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play113172011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 113172011
		arg_45_1.duration_ = 2.27

		local var_45_0 = {
			ja = 1,
			ko = 1.233,
			zh = 2.266,
			en = 1.033
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play113172012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.05

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[208].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(113172011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 2
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172011", "story_v_out_113172.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_113172", "113172011", "story_v_out_113172.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_113172", "113172011", "story_v_out_113172.awb")

						arg_45_1:RecordAudio("113172011", var_48_9)
						arg_45_1:RecordAudio("113172011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_113172", "113172011", "story_v_out_113172.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_113172", "113172011", "story_v_out_113172.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play113172012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 113172012
		arg_49_1.duration_ = 15.4

		local var_49_0 = {
			ja = 15.4,
			ko = 9.866,
			zh = 11.133,
			en = 10.766
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
				arg_49_0:Play113172013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "F03b"

			if arg_49_1.bgs_[var_52_0] == nil then
				local var_52_1 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_52_0)
				var_52_1.name = var_52_0
				var_52_1.transform.parent = arg_49_1.stage_.transform
				var_52_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_[var_52_0] = var_52_1
			end

			local var_52_2 = 2

			if var_52_2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				local var_52_3 = manager.ui.mainCamera.transform.localPosition
				local var_52_4 = Vector3.New(0, 0, 10) + Vector3.New(var_52_3.x, var_52_3.y, 0)
				local var_52_5 = arg_49_1.bgs_.F03b

				var_52_5.transform.localPosition = var_52_4
				var_52_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_6 = var_52_5:GetComponent("SpriteRenderer")

				if var_52_6 and var_52_6.sprite then
					local var_52_7 = (var_52_5.transform.localPosition - var_52_3).z
					local var_52_8 = manager.ui.mainCameraCom_
					local var_52_9 = 2 * var_52_7 * Mathf.Tan(var_52_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_52_10 = var_52_9 * var_52_8.aspect
					local var_52_11 = var_52_6.sprite.bounds.size.x
					local var_52_12 = var_52_6.sprite.bounds.size.y
					local var_52_13 = var_52_10 / var_52_11
					local var_52_14 = var_52_9 / var_52_12
					local var_52_15 = var_52_14 < var_52_13 and var_52_13 or var_52_14

					var_52_5.transform.localScale = Vector3.New(var_52_15, var_52_15, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "F03b" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_16 = 0

			if var_52_16 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_17 = 2

			if var_52_16 <= arg_49_1.time_ and arg_49_1.time_ < var_52_16 + var_52_17 then
				local var_52_18 = (arg_49_1.time_ - var_52_16) / var_52_17
				local var_52_19 = Color.New(0, 0, 0)

				var_52_19.a = Mathf.Lerp(0, 1, var_52_18)
				arg_49_1.mask_.color = var_52_19
			end

			if arg_49_1.time_ >= var_52_16 + var_52_17 and arg_49_1.time_ < var_52_16 + var_52_17 + arg_52_0 then
				local var_52_20 = Color.New(0, 0, 0)

				var_52_20.a = 1
				arg_49_1.mask_.color = var_52_20
			end

			local var_52_21 = 2

			if var_52_21 < arg_49_1.time_ and arg_49_1.time_ <= var_52_21 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_22 = 2

			if var_52_21 <= arg_49_1.time_ and arg_49_1.time_ < var_52_21 + var_52_22 then
				local var_52_23 = (arg_49_1.time_ - var_52_21) / var_52_22
				local var_52_24 = Color.New(0, 0, 0)

				var_52_24.a = Mathf.Lerp(1, 0, var_52_23)
				arg_49_1.mask_.color = var_52_24
			end

			if arg_49_1.time_ >= var_52_21 + var_52_22 and arg_49_1.time_ < var_52_21 + var_52_22 + arg_52_0 then
				local var_52_25 = Color.New(0, 0, 0)
				local var_52_26 = 0

				arg_49_1.mask_.enabled = false
				var_52_25.a = var_52_26
				arg_49_1.mask_.color = var_52_25
			end

			local var_52_27 = "10006ui_story"

			if arg_49_1.actors_[var_52_27] == nil then
				local var_52_28 = Asset.Load("Char/" .. "10006ui_story")

				if not isNil(var_52_28) then
					local var_52_29 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_49_1.stage_.transform)

					var_52_29.name = var_52_27
					var_52_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_49_1.actors_[var_52_27] = var_52_29

					local var_52_30 = var_52_29:GetComponentInChildren(typeof(CharacterEffect))

					var_52_30.enabled = true

					local var_52_31 = GameObjectTools.GetOrAddComponent(var_52_29, typeof(DynamicBoneHelper))

					if var_52_31 then
						var_52_31:EnableDynamicBone(false)
					end

					arg_49_1:ShowWeapon(var_52_30.transform, false)

					arg_49_1.var_[var_52_27 .. "Animator"] = var_52_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_49_1.var_[var_52_27 .. "Animator"].applyRootMotion = true
					arg_49_1.var_[var_52_27 .. "LipSync"] = var_52_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_52_32 = arg_49_1.actors_["10006ui_story"].transform
			local var_52_33 = 4

			if var_52_33 < arg_49_1.time_ and arg_49_1.time_ <= var_52_33 + arg_52_0 then
				arg_49_1.var_.moveOldPos10006ui_story = var_52_32.localPosition
			end

			local var_52_34 = 0.001

			if var_52_33 <= arg_49_1.time_ and arg_49_1.time_ < var_52_33 + var_52_34 then
				local var_52_35 = (arg_49_1.time_ - var_52_33) / var_52_34
				local var_52_36 = Vector3.New(-0.7, -0.98, -5.65)

				var_52_32.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10006ui_story, var_52_36, var_52_35)

				local var_52_37 = manager.ui.mainCamera.transform.position - var_52_32.position

				var_52_32.forward = Vector3.New(var_52_37.x, var_52_37.y, var_52_37.z)

				local var_52_38 = var_52_32.localEulerAngles

				var_52_38.z = 0
				var_52_38.x = 0
				var_52_32.localEulerAngles = var_52_38
			end

			if arg_49_1.time_ >= var_52_33 + var_52_34 and arg_49_1.time_ < var_52_33 + var_52_34 + arg_52_0 then
				var_52_32.localPosition = Vector3.New(-0.7, -0.98, -5.65)

				local var_52_39 = manager.ui.mainCamera.transform.position - var_52_32.position

				var_52_32.forward = Vector3.New(var_52_39.x, var_52_39.y, var_52_39.z)

				local var_52_40 = var_52_32.localEulerAngles

				var_52_40.z = 0
				var_52_40.x = 0
				var_52_32.localEulerAngles = var_52_40
			end

			local var_52_41 = 4

			if var_52_41 < arg_49_1.time_ and arg_49_1.time_ <= var_52_41 + arg_52_0 then
				arg_49_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action3_1")
			end

			local var_52_42 = 4

			if var_52_42 < arg_49_1.time_ and arg_49_1.time_ <= var_52_42 + arg_52_0 then
				arg_49_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_52_43 = arg_49_1.actors_["10006ui_story"]
			local var_52_44 = 4

			if var_52_44 < arg_49_1.time_ and arg_49_1.time_ <= var_52_44 + arg_52_0 and not isNil(var_52_43) and arg_49_1.var_.characterEffect10006ui_story == nil then
				arg_49_1.var_.characterEffect10006ui_story = var_52_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_45 = 0.2

			if var_52_44 <= arg_49_1.time_ and arg_49_1.time_ < var_52_44 + var_52_45 and not isNil(var_52_43) then
				local var_52_46 = (arg_49_1.time_ - var_52_44) / var_52_45

				if arg_49_1.var_.characterEffect10006ui_story and not isNil(var_52_43) then
					arg_49_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_44 + var_52_45 and arg_49_1.time_ < var_52_44 + var_52_45 + arg_52_0 and not isNil(var_52_43) and arg_49_1.var_.characterEffect10006ui_story then
				arg_49_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_47 = 4
			local var_52_48 = 0.7

			if var_52_47 < arg_49_1.time_ and arg_49_1.time_ <= var_52_47 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_49 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_49:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_50 = arg_49_1:FormatText(StoryNameCfg[225].name)

				arg_49_1.leftNameTxt_.text = var_52_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_51 = arg_49_1:GetWordFromCfg(113172012)
				local var_52_52 = arg_49_1:FormatText(var_52_51.content)

				arg_49_1.text_.text = var_52_52

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_53 = 28
				local var_52_54 = utf8.len(var_52_52)
				local var_52_55 = var_52_53 <= 0 and var_52_48 or var_52_48 * (var_52_54 / var_52_53)

				if var_52_55 > 0 and var_52_48 < var_52_55 then
					arg_49_1.talkMaxDuration = var_52_55
					var_52_47 = var_52_47 + 0.3

					if var_52_55 + var_52_47 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_55 + var_52_47
					end
				end

				arg_49_1.text_.text = var_52_52
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172012", "story_v_out_113172.awb") ~= 0 then
					local var_52_56 = manager.audio:GetVoiceLength("story_v_out_113172", "113172012", "story_v_out_113172.awb") / 1000

					if var_52_56 + var_52_47 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_56 + var_52_47
					end

					if var_52_51.prefab_name ~= "" and arg_49_1.actors_[var_52_51.prefab_name] ~= nil then
						local var_52_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_51.prefab_name].transform, "story_v_out_113172", "113172012", "story_v_out_113172.awb")

						arg_49_1:RecordAudio("113172012", var_52_57)
						arg_49_1:RecordAudio("113172012", var_52_57)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_113172", "113172012", "story_v_out_113172.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_113172", "113172012", "story_v_out_113172.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_58 = var_52_47 + 0.3
			local var_52_59 = math.max(var_52_48, arg_49_1.talkMaxDuration)

			if var_52_58 <= arg_49_1.time_ and arg_49_1.time_ < var_52_58 + var_52_59 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_58) / var_52_59

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_58 + var_52_59 and arg_49_1.time_ < var_52_58 + var_52_59 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play113172013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 113172013
		arg_55_1.duration_ = 4.67

		local var_55_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 4.666,
			en = 2.2
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play113172014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = "1041ui_story"

			if arg_55_1.actors_[var_58_0] == nil then
				local var_58_1 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_58_1) then
					local var_58_2 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_55_1.stage_.transform)

					var_58_2.name = var_58_0
					var_58_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_55_1.actors_[var_58_0] = var_58_2

					local var_58_3 = var_58_2:GetComponentInChildren(typeof(CharacterEffect))

					var_58_3.enabled = true

					local var_58_4 = GameObjectTools.GetOrAddComponent(var_58_2, typeof(DynamicBoneHelper))

					if var_58_4 then
						var_58_4:EnableDynamicBone(false)
					end

					arg_55_1:ShowWeapon(var_58_3.transform, false)

					arg_55_1.var_[var_58_0 .. "Animator"] = var_58_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_55_1.var_[var_58_0 .. "Animator"].applyRootMotion = true
					arg_55_1.var_[var_58_0 .. "LipSync"] = var_58_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_58_5 = arg_55_1.actors_["1041ui_story"].transform
			local var_58_6 = 0

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.var_.moveOldPos1041ui_story = var_58_5.localPosition
			end

			local var_58_7 = 0.001

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_7 then
				local var_58_8 = (arg_55_1.time_ - var_58_6) / var_58_7
				local var_58_9 = Vector3.New(0.7, -1.11, -5.9)

				var_58_5.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1041ui_story, var_58_9, var_58_8)

				local var_58_10 = manager.ui.mainCamera.transform.position - var_58_5.position

				var_58_5.forward = Vector3.New(var_58_10.x, var_58_10.y, var_58_10.z)

				local var_58_11 = var_58_5.localEulerAngles

				var_58_11.z = 0
				var_58_11.x = 0
				var_58_5.localEulerAngles = var_58_11
			end

			if arg_55_1.time_ >= var_58_6 + var_58_7 and arg_55_1.time_ < var_58_6 + var_58_7 + arg_58_0 then
				var_58_5.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_58_12 = manager.ui.mainCamera.transform.position - var_58_5.position

				var_58_5.forward = Vector3.New(var_58_12.x, var_58_12.y, var_58_12.z)

				local var_58_13 = var_58_5.localEulerAngles

				var_58_13.z = 0
				var_58_13.x = 0
				var_58_5.localEulerAngles = var_58_13
			end

			local var_58_14 = 0

			if var_58_14 < arg_55_1.time_ and arg_55_1.time_ <= var_58_14 + arg_58_0 then
				arg_55_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action9_2")
			end

			local var_58_15 = 0

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 then
				arg_55_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_58_16 = arg_55_1.actors_["1041ui_story"]
			local var_58_17 = 0

			if var_58_17 < arg_55_1.time_ and arg_55_1.time_ <= var_58_17 + arg_58_0 and not isNil(var_58_16) and arg_55_1.var_.characterEffect1041ui_story == nil then
				arg_55_1.var_.characterEffect1041ui_story = var_58_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_18 = 0.2

			if var_58_17 <= arg_55_1.time_ and arg_55_1.time_ < var_58_17 + var_58_18 and not isNil(var_58_16) then
				local var_58_19 = (arg_55_1.time_ - var_58_17) / var_58_18

				if arg_55_1.var_.characterEffect1041ui_story and not isNil(var_58_16) then
					arg_55_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_17 + var_58_18 and arg_55_1.time_ < var_58_17 + var_58_18 + arg_58_0 and not isNil(var_58_16) and arg_55_1.var_.characterEffect1041ui_story then
				arg_55_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_58_20 = arg_55_1.actors_["10006ui_story"]
			local var_58_21 = 0

			if var_58_21 < arg_55_1.time_ and arg_55_1.time_ <= var_58_21 + arg_58_0 and not isNil(var_58_20) and arg_55_1.var_.characterEffect10006ui_story == nil then
				arg_55_1.var_.characterEffect10006ui_story = var_58_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_22 = 0.2

			if var_58_21 <= arg_55_1.time_ and arg_55_1.time_ < var_58_21 + var_58_22 and not isNil(var_58_20) then
				local var_58_23 = (arg_55_1.time_ - var_58_21) / var_58_22

				if arg_55_1.var_.characterEffect10006ui_story and not isNil(var_58_20) then
					local var_58_24 = Mathf.Lerp(0, 0.5, var_58_23)

					arg_55_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10006ui_story.fillRatio = var_58_24
				end
			end

			if arg_55_1.time_ >= var_58_21 + var_58_22 and arg_55_1.time_ < var_58_21 + var_58_22 + arg_58_0 and not isNil(var_58_20) and arg_55_1.var_.characterEffect10006ui_story then
				local var_58_25 = 0.5

				arg_55_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10006ui_story.fillRatio = var_58_25
			end

			local var_58_26 = 0
			local var_58_27 = 0.05

			if var_58_26 < arg_55_1.time_ and arg_55_1.time_ <= var_58_26 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_28 = arg_55_1:FormatText(StoryNameCfg[208].name)

				arg_55_1.leftNameTxt_.text = var_58_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_29 = arg_55_1:GetWordFromCfg(113172013)
				local var_58_30 = arg_55_1:FormatText(var_58_29.content)

				arg_55_1.text_.text = var_58_30

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_31 = 2
				local var_58_32 = utf8.len(var_58_30)
				local var_58_33 = var_58_31 <= 0 and var_58_27 or var_58_27 * (var_58_32 / var_58_31)

				if var_58_33 > 0 and var_58_27 < var_58_33 then
					arg_55_1.talkMaxDuration = var_58_33

					if var_58_33 + var_58_26 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_33 + var_58_26
					end
				end

				arg_55_1.text_.text = var_58_30
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172013", "story_v_out_113172.awb") ~= 0 then
					local var_58_34 = manager.audio:GetVoiceLength("story_v_out_113172", "113172013", "story_v_out_113172.awb") / 1000

					if var_58_34 + var_58_26 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_34 + var_58_26
					end

					if var_58_29.prefab_name ~= "" and arg_55_1.actors_[var_58_29.prefab_name] ~= nil then
						local var_58_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_29.prefab_name].transform, "story_v_out_113172", "113172013", "story_v_out_113172.awb")

						arg_55_1:RecordAudio("113172013", var_58_35)
						arg_55_1:RecordAudio("113172013", var_58_35)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_113172", "113172013", "story_v_out_113172.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_113172", "113172013", "story_v_out_113172.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_36 = math.max(var_58_27, arg_55_1.talkMaxDuration)

			if var_58_26 <= arg_55_1.time_ and arg_55_1.time_ < var_58_26 + var_58_36 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_26) / var_58_36

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_26 + var_58_36 and arg_55_1.time_ < var_58_26 + var_58_36 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play113172014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 113172014
		arg_59_1.duration_ = 4.83

		local var_59_0 = {
			ja = 3.233,
			ko = 2.366,
			zh = 4.833,
			en = 3.266
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play113172015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_62_1 = 0
			local var_62_2 = 0.2

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_3 = arg_59_1:FormatText(StoryNameCfg[208].name)

				arg_59_1.leftNameTxt_.text = var_62_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:GetWordFromCfg(113172014)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_6 = 8
				local var_62_7 = utf8.len(var_62_5)
				local var_62_8 = var_62_6 <= 0 and var_62_2 or var_62_2 * (var_62_7 / var_62_6)

				if var_62_8 > 0 and var_62_2 < var_62_8 then
					arg_59_1.talkMaxDuration = var_62_8

					if var_62_8 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172014", "story_v_out_113172.awb") ~= 0 then
					local var_62_9 = manager.audio:GetVoiceLength("story_v_out_113172", "113172014", "story_v_out_113172.awb") / 1000

					if var_62_9 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_1
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_113172", "113172014", "story_v_out_113172.awb")

						arg_59_1:RecordAudio("113172014", var_62_10)
						arg_59_1:RecordAudio("113172014", var_62_10)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_113172", "113172014", "story_v_out_113172.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_113172", "113172014", "story_v_out_113172.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_11 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_11 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_11

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_11 and arg_59_1.time_ < var_62_1 + var_62_11 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play113172015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 113172015
		arg_63_1.duration_ = 2

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play113172016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_66_1 = arg_63_1.actors_["10006ui_story"]
			local var_66_2 = 0

			if var_66_2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect10006ui_story == nil then
				arg_63_1.var_.characterEffect10006ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_3 = 0.2

			if var_66_2 <= arg_63_1.time_ and arg_63_1.time_ < var_66_2 + var_66_3 and not isNil(var_66_1) then
				local var_66_4 = (arg_63_1.time_ - var_66_2) / var_66_3

				if arg_63_1.var_.characterEffect10006ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_2 + var_66_3 and arg_63_1.time_ < var_66_2 + var_66_3 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect10006ui_story then
				arg_63_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_66_5 = arg_63_1.actors_["1041ui_story"]
			local var_66_6 = 0

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect1041ui_story == nil then
				arg_63_1.var_.characterEffect1041ui_story = var_66_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_7 = 0.2

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_7 and not isNil(var_66_5) then
				local var_66_8 = (arg_63_1.time_ - var_66_6) / var_66_7

				if arg_63_1.var_.characterEffect1041ui_story and not isNil(var_66_5) then
					local var_66_9 = Mathf.Lerp(0, 0.5, var_66_8)

					arg_63_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1041ui_story.fillRatio = var_66_9
				end
			end

			if arg_63_1.time_ >= var_66_6 + var_66_7 and arg_63_1.time_ < var_66_6 + var_66_7 + arg_66_0 and not isNil(var_66_5) and arg_63_1.var_.characterEffect1041ui_story then
				local var_66_10 = 0.5

				arg_63_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1041ui_story.fillRatio = var_66_10
			end

			local var_66_11 = 0
			local var_66_12 = 0.1

			if var_66_11 < arg_63_1.time_ and arg_63_1.time_ <= var_66_11 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_13 = arg_63_1:FormatText(StoryNameCfg[225].name)

				arg_63_1.leftNameTxt_.text = var_66_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_14 = arg_63_1:GetWordFromCfg(113172015)
				local var_66_15 = arg_63_1:FormatText(var_66_14.content)

				arg_63_1.text_.text = var_66_15

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_16 = 4
				local var_66_17 = utf8.len(var_66_15)
				local var_66_18 = var_66_16 <= 0 and var_66_12 or var_66_12 * (var_66_17 / var_66_16)

				if var_66_18 > 0 and var_66_12 < var_66_18 then
					arg_63_1.talkMaxDuration = var_66_18

					if var_66_18 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_18 + var_66_11
					end
				end

				arg_63_1.text_.text = var_66_15
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172015", "story_v_out_113172.awb") ~= 0 then
					local var_66_19 = manager.audio:GetVoiceLength("story_v_out_113172", "113172015", "story_v_out_113172.awb") / 1000

					if var_66_19 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_19 + var_66_11
					end

					if var_66_14.prefab_name ~= "" and arg_63_1.actors_[var_66_14.prefab_name] ~= nil then
						local var_66_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_14.prefab_name].transform, "story_v_out_113172", "113172015", "story_v_out_113172.awb")

						arg_63_1:RecordAudio("113172015", var_66_20)
						arg_63_1:RecordAudio("113172015", var_66_20)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_113172", "113172015", "story_v_out_113172.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_113172", "113172015", "story_v_out_113172.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_21 = math.max(var_66_12, arg_63_1.talkMaxDuration)

			if var_66_11 <= arg_63_1.time_ and arg_63_1.time_ < var_66_11 + var_66_21 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_11) / var_66_21

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_11 + var_66_21 and arg_63_1.time_ < var_66_11 + var_66_21 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play113172016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 113172016
		arg_67_1.duration_ = 10

		local var_67_0 = {
			ja = 10,
			ko = 4.1,
			zh = 6.566,
			en = 9.2
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play113172017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = "10006ui_tpose"

			if arg_67_1.actors_[var_70_0] == nil then
				local var_70_1 = Asset.Load("Char/" .. "10006ui_tpose")

				if not isNil(var_70_1) then
					local var_70_2 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_tpose"), arg_67_1.stage_.transform)

					var_70_2.name = var_70_0
					var_70_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_67_1.actors_[var_70_0] = var_70_2

					local var_70_3 = var_70_2:GetComponentInChildren(typeof(CharacterEffect))

					var_70_3.enabled = true

					local var_70_4 = GameObjectTools.GetOrAddComponent(var_70_2, typeof(DynamicBoneHelper))

					if var_70_4 then
						var_70_4:EnableDynamicBone(false)
					end

					arg_67_1:ShowWeapon(var_70_3.transform, false)

					arg_67_1.var_[var_70_0 .. "Animator"] = var_70_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_67_1.var_[var_70_0 .. "Animator"].applyRootMotion = true
					arg_67_1.var_[var_70_0 .. "LipSync"] = var_70_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_70_5 = arg_67_1.actors_["10006ui_tpose"]
			local var_70_6 = 0

			if var_70_6 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect10006ui_tpose == nil then
				arg_67_1.var_.characterEffect10006ui_tpose = var_70_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_7 = 0.2

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_7 and not isNil(var_70_5) then
				local var_70_8 = (arg_67_1.time_ - var_70_6) / var_70_7

				if arg_67_1.var_.characterEffect10006ui_tpose and not isNil(var_70_5) then
					local var_70_9 = Mathf.Lerp(0, 0.5, var_70_8)

					arg_67_1.var_.characterEffect10006ui_tpose.fillFlat = true
					arg_67_1.var_.characterEffect10006ui_tpose.fillRatio = var_70_9
				end
			end

			if arg_67_1.time_ >= var_70_6 + var_70_7 and arg_67_1.time_ < var_70_6 + var_70_7 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect10006ui_tpose then
				local var_70_10 = 0.5

				arg_67_1.var_.characterEffect10006ui_tpose.fillFlat = true
				arg_67_1.var_.characterEffect10006ui_tpose.fillRatio = var_70_10
			end

			local var_70_11 = arg_67_1.actors_["1041ui_story"]
			local var_70_12 = 0

			if var_70_12 < arg_67_1.time_ and arg_67_1.time_ <= var_70_12 + arg_70_0 and not isNil(var_70_11) and arg_67_1.var_.characterEffect1041ui_story == nil then
				arg_67_1.var_.characterEffect1041ui_story = var_70_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_13 = 0.2

			if var_70_12 <= arg_67_1.time_ and arg_67_1.time_ < var_70_12 + var_70_13 and not isNil(var_70_11) then
				local var_70_14 = (arg_67_1.time_ - var_70_12) / var_70_13

				if arg_67_1.var_.characterEffect1041ui_story and not isNil(var_70_11) then
					arg_67_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_12 + var_70_13 and arg_67_1.time_ < var_70_12 + var_70_13 + arg_70_0 and not isNil(var_70_11) and arg_67_1.var_.characterEffect1041ui_story then
				arg_67_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_70_15 = 0

			if var_70_15 < arg_67_1.time_ and arg_67_1.time_ <= var_70_15 + arg_70_0 then
				arg_67_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_70_16 = 0
			local var_70_17 = 0.4

			if var_70_16 < arg_67_1.time_ and arg_67_1.time_ <= var_70_16 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_18 = arg_67_1:FormatText(StoryNameCfg[208].name)

				arg_67_1.leftNameTxt_.text = var_70_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_19 = arg_67_1:GetWordFromCfg(113172016)
				local var_70_20 = arg_67_1:FormatText(var_70_19.content)

				arg_67_1.text_.text = var_70_20

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_21 = 16
				local var_70_22 = utf8.len(var_70_20)
				local var_70_23 = var_70_21 <= 0 and var_70_17 or var_70_17 * (var_70_22 / var_70_21)

				if var_70_23 > 0 and var_70_17 < var_70_23 then
					arg_67_1.talkMaxDuration = var_70_23

					if var_70_23 + var_70_16 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_23 + var_70_16
					end
				end

				arg_67_1.text_.text = var_70_20
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172016", "story_v_out_113172.awb") ~= 0 then
					local var_70_24 = manager.audio:GetVoiceLength("story_v_out_113172", "113172016", "story_v_out_113172.awb") / 1000

					if var_70_24 + var_70_16 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_24 + var_70_16
					end

					if var_70_19.prefab_name ~= "" and arg_67_1.actors_[var_70_19.prefab_name] ~= nil then
						local var_70_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_19.prefab_name].transform, "story_v_out_113172", "113172016", "story_v_out_113172.awb")

						arg_67_1:RecordAudio("113172016", var_70_25)
						arg_67_1:RecordAudio("113172016", var_70_25)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_113172", "113172016", "story_v_out_113172.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_113172", "113172016", "story_v_out_113172.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_26 = math.max(var_70_17, arg_67_1.talkMaxDuration)

			if var_70_16 <= arg_67_1.time_ and arg_67_1.time_ < var_70_16 + var_70_26 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_16) / var_70_26

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_16 + var_70_26 and arg_67_1.time_ < var_70_16 + var_70_26 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play113172017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 113172017
		arg_71_1.duration_ = 9.7

		local var_71_0 = {
			ja = 9.7,
			ko = 3.133,
			zh = 2.933,
			en = 3.9
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
				arg_71_0:Play113172018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1041ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1041ui_story == nil then
				arg_71_1.var_.characterEffect1041ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect1041ui_story and not isNil(var_74_0) then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1041ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1041ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1041ui_story.fillRatio = var_74_5
			end

			local var_74_6 = arg_71_1.actors_["10006ui_story"]
			local var_74_7 = 0

			if var_74_7 < arg_71_1.time_ and arg_71_1.time_ <= var_74_7 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect10006ui_story == nil then
				arg_71_1.var_.characterEffect10006ui_story = var_74_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_8 = 0.2

			if var_74_7 <= arg_71_1.time_ and arg_71_1.time_ < var_74_7 + var_74_8 and not isNil(var_74_6) then
				local var_74_9 = (arg_71_1.time_ - var_74_7) / var_74_8

				if arg_71_1.var_.characterEffect10006ui_story and not isNil(var_74_6) then
					arg_71_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_7 + var_74_8 and arg_71_1.time_ < var_74_7 + var_74_8 + arg_74_0 and not isNil(var_74_6) and arg_71_1.var_.characterEffect10006ui_story then
				arg_71_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006actionlink/10006action434")
			end

			local var_74_11 = 0

			if var_74_11 < arg_71_1.time_ and arg_71_1.time_ <= var_74_11 + arg_74_0 then
				arg_71_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_74_12 = 0
			local var_74_13 = 0.35

			if var_74_12 < arg_71_1.time_ and arg_71_1.time_ <= var_74_12 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_14 = arg_71_1:FormatText(StoryNameCfg[225].name)

				arg_71_1.leftNameTxt_.text = var_74_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_15 = arg_71_1:GetWordFromCfg(113172017)
				local var_74_16 = arg_71_1:FormatText(var_74_15.content)

				arg_71_1.text_.text = var_74_16

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_17 = 14
				local var_74_18 = utf8.len(var_74_16)
				local var_74_19 = var_74_17 <= 0 and var_74_13 or var_74_13 * (var_74_18 / var_74_17)

				if var_74_19 > 0 and var_74_13 < var_74_19 then
					arg_71_1.talkMaxDuration = var_74_19

					if var_74_19 + var_74_12 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_19 + var_74_12
					end
				end

				arg_71_1.text_.text = var_74_16
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172017", "story_v_out_113172.awb") ~= 0 then
					local var_74_20 = manager.audio:GetVoiceLength("story_v_out_113172", "113172017", "story_v_out_113172.awb") / 1000

					if var_74_20 + var_74_12 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_20 + var_74_12
					end

					if var_74_15.prefab_name ~= "" and arg_71_1.actors_[var_74_15.prefab_name] ~= nil then
						local var_74_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_15.prefab_name].transform, "story_v_out_113172", "113172017", "story_v_out_113172.awb")

						arg_71_1:RecordAudio("113172017", var_74_21)
						arg_71_1:RecordAudio("113172017", var_74_21)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_113172", "113172017", "story_v_out_113172.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_113172", "113172017", "story_v_out_113172.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_22 = math.max(var_74_13, arg_71_1.talkMaxDuration)

			if var_74_12 <= arg_71_1.time_ and arg_71_1.time_ < var_74_12 + var_74_22 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_12) / var_74_22

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_12 + var_74_22 and arg_71_1.time_ < var_74_12 + var_74_22 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play113172018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 113172018
		arg_75_1.duration_ = 5.1

		local var_75_0 = {
			ja = 1.999999999999,
			ko = 2.3,
			zh = 5.1,
			en = 1.999999999999
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
				arg_75_0:Play113172019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["10006ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect10006ui_story == nil then
				arg_75_1.var_.characterEffect10006ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.2

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect10006ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect10006ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10006ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect10006ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect10006ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10006ui_story.fillRatio = var_78_5
			end

			local var_78_6 = arg_75_1.actors_["1041ui_story"]
			local var_78_7 = 0

			if var_78_7 < arg_75_1.time_ and arg_75_1.time_ <= var_78_7 + arg_78_0 and not isNil(var_78_6) and arg_75_1.var_.characterEffect1041ui_story == nil then
				arg_75_1.var_.characterEffect1041ui_story = var_78_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_8 = 0.2

			if var_78_7 <= arg_75_1.time_ and arg_75_1.time_ < var_78_7 + var_78_8 and not isNil(var_78_6) then
				local var_78_9 = (arg_75_1.time_ - var_78_7) / var_78_8

				if arg_75_1.var_.characterEffect1041ui_story and not isNil(var_78_6) then
					arg_75_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= var_78_7 + var_78_8 and arg_75_1.time_ < var_78_7 + var_78_8 + arg_78_0 and not isNil(var_78_6) and arg_75_1.var_.characterEffect1041ui_story then
				arg_75_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_78_10 = 0

			if var_78_10 < arg_75_1.time_ and arg_75_1.time_ <= var_78_10 + arg_78_0 then
				arg_75_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_78_11 = 0
			local var_78_12 = 0.05

			if var_78_11 < arg_75_1.time_ and arg_75_1.time_ <= var_78_11 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_13 = arg_75_1:FormatText(StoryNameCfg[208].name)

				arg_75_1.leftNameTxt_.text = var_78_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_14 = arg_75_1:GetWordFromCfg(113172018)
				local var_78_15 = arg_75_1:FormatText(var_78_14.content)

				arg_75_1.text_.text = var_78_15

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_16 = 2
				local var_78_17 = utf8.len(var_78_15)
				local var_78_18 = var_78_16 <= 0 and var_78_12 or var_78_12 * (var_78_17 / var_78_16)

				if var_78_18 > 0 and var_78_12 < var_78_18 then
					arg_75_1.talkMaxDuration = var_78_18

					if var_78_18 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_18 + var_78_11
					end
				end

				arg_75_1.text_.text = var_78_15
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172018", "story_v_out_113172.awb") ~= 0 then
					local var_78_19 = manager.audio:GetVoiceLength("story_v_out_113172", "113172018", "story_v_out_113172.awb") / 1000

					if var_78_19 + var_78_11 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_19 + var_78_11
					end

					if var_78_14.prefab_name ~= "" and arg_75_1.actors_[var_78_14.prefab_name] ~= nil then
						local var_78_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_14.prefab_name].transform, "story_v_out_113172", "113172018", "story_v_out_113172.awb")

						arg_75_1:RecordAudio("113172018", var_78_20)
						arg_75_1:RecordAudio("113172018", var_78_20)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_113172", "113172018", "story_v_out_113172.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_113172", "113172018", "story_v_out_113172.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_21 = math.max(var_78_12, arg_75_1.talkMaxDuration)

			if var_78_11 <= arg_75_1.time_ and arg_75_1.time_ < var_78_11 + var_78_21 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_11) / var_78_21

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_11 + var_78_21 and arg_75_1.time_ < var_78_11 + var_78_21 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play113172019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 113172019
		arg_79_1.duration_ = 4.23

		local var_79_0 = {
			ja = 4.233,
			ko = 3.1,
			zh = 2.8,
			en = 3.633
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
				arg_79_0:Play113172020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1041ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1041ui_story == nil then
				arg_79_1.var_.characterEffect1041ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.2

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1041ui_story and not isNil(var_82_0) then
					local var_82_4 = Mathf.Lerp(0, 0.5, var_82_3)

					arg_79_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1041ui_story.fillRatio = var_82_4
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1041ui_story then
				local var_82_5 = 0.5

				arg_79_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1041ui_story.fillRatio = var_82_5
			end

			local var_82_6 = arg_79_1.actors_["10006ui_story"]
			local var_82_7 = 0

			if var_82_7 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect10006ui_story == nil then
				arg_79_1.var_.characterEffect10006ui_story = var_82_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_8 = 0.2

			if var_82_7 <= arg_79_1.time_ and arg_79_1.time_ < var_82_7 + var_82_8 and not isNil(var_82_6) then
				local var_82_9 = (arg_79_1.time_ - var_82_7) / var_82_8

				if arg_79_1.var_.characterEffect10006ui_story and not isNil(var_82_6) then
					arg_79_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_7 + var_82_8 and arg_79_1.time_ < var_82_7 + var_82_8 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect10006ui_story then
				arg_79_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_82_10 = 0

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 then
				arg_79_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006actionlink/10006action446")
			end

			local var_82_11 = 0

			if var_82_11 < arg_79_1.time_ and arg_79_1.time_ <= var_82_11 + arg_82_0 then
				arg_79_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_82_12 = 0
			local var_82_13 = 0.3

			if var_82_12 < arg_79_1.time_ and arg_79_1.time_ <= var_82_12 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_14 = arg_79_1:FormatText(StoryNameCfg[225].name)

				arg_79_1.leftNameTxt_.text = var_82_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_15 = arg_79_1:GetWordFromCfg(113172019)
				local var_82_16 = arg_79_1:FormatText(var_82_15.content)

				arg_79_1.text_.text = var_82_16

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_17 = 12
				local var_82_18 = utf8.len(var_82_16)
				local var_82_19 = var_82_17 <= 0 and var_82_13 or var_82_13 * (var_82_18 / var_82_17)

				if var_82_19 > 0 and var_82_13 < var_82_19 then
					arg_79_1.talkMaxDuration = var_82_19

					if var_82_19 + var_82_12 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_19 + var_82_12
					end
				end

				arg_79_1.text_.text = var_82_16
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172019", "story_v_out_113172.awb") ~= 0 then
					local var_82_20 = manager.audio:GetVoiceLength("story_v_out_113172", "113172019", "story_v_out_113172.awb") / 1000

					if var_82_20 + var_82_12 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_20 + var_82_12
					end

					if var_82_15.prefab_name ~= "" and arg_79_1.actors_[var_82_15.prefab_name] ~= nil then
						local var_82_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_15.prefab_name].transform, "story_v_out_113172", "113172019", "story_v_out_113172.awb")

						arg_79_1:RecordAudio("113172019", var_82_21)
						arg_79_1:RecordAudio("113172019", var_82_21)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_113172", "113172019", "story_v_out_113172.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_113172", "113172019", "story_v_out_113172.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_22 = math.max(var_82_13, arg_79_1.talkMaxDuration)

			if var_82_12 <= arg_79_1.time_ and arg_79_1.time_ < var_82_12 + var_82_22 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_12) / var_82_22

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_12 + var_82_22 and arg_79_1.time_ < var_82_12 + var_82_22 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play113172020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 113172020
		arg_83_1.duration_ = 5.53

		local var_83_0 = {
			ja = 3.033,
			ko = 4.066,
			zh = 5.066,
			en = 5.533
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play113172021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["10006ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos10006ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0, 100, 0)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10006ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0, 100, 0)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = arg_83_1.actors_["1041ui_story"].transform
			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 then
				arg_83_1.var_.moveOldPos1041ui_story = var_86_9.localPosition
			end

			local var_86_11 = 0.001

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 then
				local var_86_12 = (arg_83_1.time_ - var_86_10) / var_86_11
				local var_86_13 = Vector3.New(0, 100, 0)

				var_86_9.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1041ui_story, var_86_13, var_86_12)

				local var_86_14 = manager.ui.mainCamera.transform.position - var_86_9.position

				var_86_9.forward = Vector3.New(var_86_14.x, var_86_14.y, var_86_14.z)

				local var_86_15 = var_86_9.localEulerAngles

				var_86_15.z = 0
				var_86_15.x = 0
				var_86_9.localEulerAngles = var_86_15
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 then
				var_86_9.localPosition = Vector3.New(0, 100, 0)

				local var_86_16 = manager.ui.mainCamera.transform.position - var_86_9.position

				var_86_9.forward = Vector3.New(var_86_16.x, var_86_16.y, var_86_16.z)

				local var_86_17 = var_86_9.localEulerAngles

				var_86_17.z = 0
				var_86_17.x = 0
				var_86_9.localEulerAngles = var_86_17
			end

			local var_86_18 = manager.ui.mainCamera.transform
			local var_86_19 = 2

			if var_86_19 < arg_83_1.time_ and arg_83_1.time_ <= var_86_19 + arg_86_0 then
				arg_83_1.var_.shakeOldPos = var_86_18.localPosition
			end

			local var_86_20 = 0.6

			if var_86_19 <= arg_83_1.time_ and arg_83_1.time_ < var_86_19 + var_86_20 then
				local var_86_21 = (arg_83_1.time_ - var_86_19) / 0.066
				local var_86_22, var_86_23 = math.modf(var_86_21)

				var_86_18.localPosition = Vector3.New(var_86_23 * 0.13, var_86_23 * 0.13, var_86_23 * 0.13) + arg_83_1.var_.shakeOldPos
			end

			if arg_83_1.time_ >= var_86_19 + var_86_20 and arg_83_1.time_ < var_86_19 + var_86_20 + arg_86_0 then
				var_86_18.localPosition = arg_83_1.var_.shakeOldPos
			end

			local var_86_24 = 0

			if var_86_24 < arg_83_1.time_ and arg_83_1.time_ <= var_86_24 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_25 = 2

			if var_86_24 <= arg_83_1.time_ and arg_83_1.time_ < var_86_24 + var_86_25 then
				local var_86_26 = (arg_83_1.time_ - var_86_24) / var_86_25
				local var_86_27 = Color.New(1, 1, 1)

				var_86_27.a = Mathf.Lerp(1, 0, var_86_26)
				arg_83_1.mask_.color = var_86_27
			end

			if arg_83_1.time_ >= var_86_24 + var_86_25 and arg_83_1.time_ < var_86_24 + var_86_25 + arg_86_0 then
				local var_86_28 = Color.New(1, 1, 1)
				local var_86_29 = 0

				arg_83_1.mask_.enabled = false
				var_86_28.a = var_86_29
				arg_83_1.mask_.color = var_86_28
			end

			local var_86_30 = 0.766666666666667
			local var_86_31 = 1

			if var_86_30 < arg_83_1.time_ and arg_83_1.time_ <= var_86_30 + arg_86_0 then
				local var_86_32 = "play"
				local var_86_33 = "effect"

				arg_83_1:AudioAction(var_86_32, var_86_33, "se_story_10", "se_story_10_beat", "")
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_34 = 2
			local var_86_35 = 0.2

			if var_86_34 < arg_83_1.time_ and arg_83_1.time_ <= var_86_34 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_36 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_36:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_37 = arg_83_1:FormatText(StoryNameCfg[208].name)

				arg_83_1.leftNameTxt_.text = var_86_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_38 = arg_83_1:GetWordFromCfg(113172020)
				local var_86_39 = arg_83_1:FormatText(var_86_38.content)

				arg_83_1.text_.text = var_86_39

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_40 = 8
				local var_86_41 = utf8.len(var_86_39)
				local var_86_42 = var_86_40 <= 0 and var_86_35 or var_86_35 * (var_86_41 / var_86_40)

				if var_86_42 > 0 and var_86_35 < var_86_42 then
					arg_83_1.talkMaxDuration = var_86_42
					var_86_34 = var_86_34 + 0.3

					if var_86_42 + var_86_34 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_42 + var_86_34
					end
				end

				arg_83_1.text_.text = var_86_39
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172020", "story_v_out_113172.awb") ~= 0 then
					local var_86_43 = manager.audio:GetVoiceLength("story_v_out_113172", "113172020", "story_v_out_113172.awb") / 1000

					if var_86_43 + var_86_34 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_43 + var_86_34
					end

					if var_86_38.prefab_name ~= "" and arg_83_1.actors_[var_86_38.prefab_name] ~= nil then
						local var_86_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_38.prefab_name].transform, "story_v_out_113172", "113172020", "story_v_out_113172.awb")

						arg_83_1:RecordAudio("113172020", var_86_44)
						arg_83_1:RecordAudio("113172020", var_86_44)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_113172", "113172020", "story_v_out_113172.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_113172", "113172020", "story_v_out_113172.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_45 = var_86_34 + 0.3
			local var_86_46 = math.max(var_86_35, arg_83_1.talkMaxDuration)

			if var_86_45 <= arg_83_1.time_ and arg_83_1.time_ < var_86_45 + var_86_46 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_45) / var_86_46

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_45 + var_86_46 and arg_83_1.time_ < var_86_45 + var_86_46 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play113172021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 113172021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play113172022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.875

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_2 = arg_89_1:GetWordFromCfg(113172021)
				local var_92_3 = arg_89_1:FormatText(var_92_2.content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 35
				local var_92_5 = utf8.len(var_92_3)
				local var_92_6 = var_92_4 <= 0 and var_92_1 or var_92_1 * (var_92_5 / var_92_4)

				if var_92_6 > 0 and var_92_1 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_7 and arg_89_1.time_ < var_92_0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play113172022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 113172022
		arg_93_1.duration_ = 3.63

		local var_93_0 = {
			ja = 2.2,
			ko = 3.633,
			zh = 1.933,
			en = 2.366
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
				arg_93_0:Play113172023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = manager.ui.mainCamera.transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.shakeOldPos = var_96_0.localPosition
			end

			local var_96_2 = 0.6

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / 0.066
				local var_96_4, var_96_5 = math.modf(var_96_3)

				var_96_0.localPosition = Vector3.New(var_96_5 * 0.13, var_96_5 * 0.13, var_96_5 * 0.13) + arg_93_1.var_.shakeOldPos
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = arg_93_1.var_.shakeOldPos
			end

			local var_96_6 = 0

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.allBtn_.enabled = false
			end

			local var_96_7 = 0.6

			if arg_93_1.time_ >= var_96_6 + var_96_7 and arg_93_1.time_ < var_96_6 + var_96_7 + arg_96_0 then
				arg_93_1.allBtn_.enabled = true
			end

			local var_96_8 = 0
			local var_96_9 = 0.225

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_10 = arg_93_1:FormatText(StoryNameCfg[208].name)

				arg_93_1.leftNameTxt_.text = var_96_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1041")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_11 = arg_93_1:GetWordFromCfg(113172022)
				local var_96_12 = arg_93_1:FormatText(var_96_11.content)

				arg_93_1.text_.text = var_96_12

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 9
				local var_96_14 = utf8.len(var_96_12)
				local var_96_15 = var_96_13 <= 0 and var_96_9 or var_96_9 * (var_96_14 / var_96_13)

				if var_96_15 > 0 and var_96_9 < var_96_15 then
					arg_93_1.talkMaxDuration = var_96_15

					if var_96_15 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_15 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_12
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172022", "story_v_out_113172.awb") ~= 0 then
					local var_96_16 = manager.audio:GetVoiceLength("story_v_out_113172", "113172022", "story_v_out_113172.awb") / 1000

					if var_96_16 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_8
					end

					if var_96_11.prefab_name ~= "" and arg_93_1.actors_[var_96_11.prefab_name] ~= nil then
						local var_96_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_11.prefab_name].transform, "story_v_out_113172", "113172022", "story_v_out_113172.awb")

						arg_93_1:RecordAudio("113172022", var_96_17)
						arg_93_1:RecordAudio("113172022", var_96_17)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_113172", "113172022", "story_v_out_113172.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_113172", "113172022", "story_v_out_113172.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_18 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_18 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_18

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_18 and arg_93_1.time_ < var_96_8 + var_96_18 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play113172023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 113172023
		arg_97_1.duration_ = 6.1

		local var_97_0 = {
			ja = 5.2,
			ko = 2.3,
			zh = 2.333,
			en = 6.1
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play113172024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10006ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10006ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, -0.98, -5.65)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10006ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, -0.98, -5.65)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action4_1")
			end

			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 then
				arg_97_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_100_11 = arg_97_1.actors_["10006ui_story"]
			local var_100_12 = 0

			if var_100_12 < arg_97_1.time_ and arg_97_1.time_ <= var_100_12 + arg_100_0 and not isNil(var_100_11) and arg_97_1.var_.characterEffect10006ui_story == nil then
				arg_97_1.var_.characterEffect10006ui_story = var_100_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_13 = 0.2

			if var_100_12 <= arg_97_1.time_ and arg_97_1.time_ < var_100_12 + var_100_13 and not isNil(var_100_11) then
				local var_100_14 = (arg_97_1.time_ - var_100_12) / var_100_13

				if arg_97_1.var_.characterEffect10006ui_story and not isNil(var_100_11) then
					arg_97_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_12 + var_100_13 and arg_97_1.time_ < var_100_12 + var_100_13 + arg_100_0 and not isNil(var_100_11) and arg_97_1.var_.characterEffect10006ui_story then
				arg_97_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_100_15 = 0
			local var_100_16 = 0.225

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_17 = arg_97_1:FormatText(StoryNameCfg[225].name)

				arg_97_1.leftNameTxt_.text = var_100_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:GetWordFromCfg(113172023)
				local var_100_19 = arg_97_1:FormatText(var_100_18.content)

				arg_97_1.text_.text = var_100_19

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 9
				local var_100_21 = utf8.len(var_100_19)
				local var_100_22 = var_100_20 <= 0 and var_100_16 or var_100_16 * (var_100_21 / var_100_20)

				if var_100_22 > 0 and var_100_16 < var_100_22 then
					arg_97_1.talkMaxDuration = var_100_22

					if var_100_22 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_22 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_19
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172023", "story_v_out_113172.awb") ~= 0 then
					local var_100_23 = manager.audio:GetVoiceLength("story_v_out_113172", "113172023", "story_v_out_113172.awb") / 1000

					if var_100_23 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_23 + var_100_15
					end

					if var_100_18.prefab_name ~= "" and arg_97_1.actors_[var_100_18.prefab_name] ~= nil then
						local var_100_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_18.prefab_name].transform, "story_v_out_113172", "113172023", "story_v_out_113172.awb")

						arg_97_1:RecordAudio("113172023", var_100_24)
						arg_97_1:RecordAudio("113172023", var_100_24)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_113172", "113172023", "story_v_out_113172.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_113172", "113172023", "story_v_out_113172.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_25 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_25 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_15) / var_100_25

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_15 + var_100_25 and arg_97_1.time_ < var_100_15 + var_100_25 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play113172024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 113172024
		arg_101_1.duration_ = 3.27

		local var_101_0 = {
			ja = 3.266,
			ko = 1.999999999999,
			zh = 2.966,
			en = 2.766
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
				arg_101_0:Play113172025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_104_1 = 0
			local var_104_2 = 0.2

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_3 = arg_101_1:FormatText(StoryNameCfg[225].name)

				arg_101_1.leftNameTxt_.text = var_104_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(113172024)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_6 = 8
				local var_104_7 = utf8.len(var_104_5)
				local var_104_8 = var_104_6 <= 0 and var_104_2 or var_104_2 * (var_104_7 / var_104_6)

				if var_104_8 > 0 and var_104_2 < var_104_8 then
					arg_101_1.talkMaxDuration = var_104_8

					if var_104_8 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172024", "story_v_out_113172.awb") ~= 0 then
					local var_104_9 = manager.audio:GetVoiceLength("story_v_out_113172", "113172024", "story_v_out_113172.awb") / 1000

					if var_104_9 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_1
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_113172", "113172024", "story_v_out_113172.awb")

						arg_101_1:RecordAudio("113172024", var_104_10)
						arg_101_1:RecordAudio("113172024", var_104_10)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_113172", "113172024", "story_v_out_113172.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_113172", "113172024", "story_v_out_113172.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_11 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_11 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_11

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_11 and arg_101_1.time_ < var_104_1 + var_104_11 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play113172025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 113172025
		arg_105_1.duration_ = 8.53

		local var_105_0 = {
			ja = 5.866,
			ko = 7.533,
			zh = 6.033,
			en = 8.533
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
				arg_105_0:Play113172026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006actionlink/10006action443")
			end

			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_108_2 = 0
			local var_108_3 = 0.675

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_4 = arg_105_1:FormatText(StoryNameCfg[225].name)

				arg_105_1.leftNameTxt_.text = var_108_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_5 = arg_105_1:GetWordFromCfg(113172025)
				local var_108_6 = arg_105_1:FormatText(var_108_5.content)

				arg_105_1.text_.text = var_108_6

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_7 = 27
				local var_108_8 = utf8.len(var_108_6)
				local var_108_9 = var_108_7 <= 0 and var_108_3 or var_108_3 * (var_108_8 / var_108_7)

				if var_108_9 > 0 and var_108_3 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_6
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172025", "story_v_out_113172.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_113172", "113172025", "story_v_out_113172.awb") / 1000

					if var_108_10 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_2
					end

					if var_108_5.prefab_name ~= "" and arg_105_1.actors_[var_108_5.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_5.prefab_name].transform, "story_v_out_113172", "113172025", "story_v_out_113172.awb")

						arg_105_1:RecordAudio("113172025", var_108_11)
						arg_105_1:RecordAudio("113172025", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_113172", "113172025", "story_v_out_113172.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_113172", "113172025", "story_v_out_113172.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_12 and arg_105_1.time_ < var_108_2 + var_108_12 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play113172026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 113172026
		arg_109_1.duration_ = 6.47

		local var_109_0 = {
			ja = 6.466,
			ko = 3.166,
			zh = 2.9,
			en = 4.466
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
				arg_109_0:Play113172027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_112_1 = 0
			local var_112_2 = 0.35

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_3 = arg_109_1:FormatText(StoryNameCfg[225].name)

				arg_109_1.leftNameTxt_.text = var_112_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:GetWordFromCfg(113172026)
				local var_112_5 = arg_109_1:FormatText(var_112_4.content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 14
				local var_112_7 = utf8.len(var_112_5)
				local var_112_8 = var_112_6 <= 0 and var_112_2 or var_112_2 * (var_112_7 / var_112_6)

				if var_112_8 > 0 and var_112_2 < var_112_8 then
					arg_109_1.talkMaxDuration = var_112_8

					if var_112_8 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172026", "story_v_out_113172.awb") ~= 0 then
					local var_112_9 = manager.audio:GetVoiceLength("story_v_out_113172", "113172026", "story_v_out_113172.awb") / 1000

					if var_112_9 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_1
					end

					if var_112_4.prefab_name ~= "" and arg_109_1.actors_[var_112_4.prefab_name] ~= nil then
						local var_112_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_4.prefab_name].transform, "story_v_out_113172", "113172026", "story_v_out_113172.awb")

						arg_109_1:RecordAudio("113172026", var_112_10)
						arg_109_1:RecordAudio("113172026", var_112_10)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_113172", "113172026", "story_v_out_113172.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_113172", "113172026", "story_v_out_113172.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_11 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_11 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_11

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_11 and arg_109_1.time_ < var_112_1 + var_112_11 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play113172027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 113172027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play113172028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10006ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10006ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, 100, 0)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10006ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, 100, 0)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = 0
			local var_116_10 = 0.725

			if var_116_9 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_11 = arg_113_1:GetWordFromCfg(113172027)
				local var_116_12 = arg_113_1:FormatText(var_116_11.content)

				arg_113_1.text_.text = var_116_12

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 29
				local var_116_14 = utf8.len(var_116_12)
				local var_116_15 = var_116_13 <= 0 and var_116_10 or var_116_10 * (var_116_14 / var_116_13)

				if var_116_15 > 0 and var_116_10 < var_116_15 then
					arg_113_1.talkMaxDuration = var_116_15

					if var_116_15 + var_116_9 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_15 + var_116_9
					end
				end

				arg_113_1.text_.text = var_116_12
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_10, arg_113_1.talkMaxDuration)

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_9) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_9 + var_116_16 and arg_113_1.time_ < var_116_9 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play113172028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 113172028
		arg_117_1.duration_ = 11.23

		local var_117_0 = {
			ja = 10.966,
			ko = 9.166,
			zh = 11.233,
			en = 8.333
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
				arg_117_0:Play113172029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10006ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos10006ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0, -0.98, -5.65)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10006ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, -0.98, -5.65)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 then
				arg_117_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action3_1")
			end

			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 then
				arg_117_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_120_11 = arg_117_1.actors_["10006ui_story"]
			local var_120_12 = 0

			if var_120_12 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 and not isNil(var_120_11) and arg_117_1.var_.characterEffect10006ui_story == nil then
				arg_117_1.var_.characterEffect10006ui_story = var_120_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_13 = 0.2

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_13 and not isNil(var_120_11) then
				local var_120_14 = (arg_117_1.time_ - var_120_12) / var_120_13

				if arg_117_1.var_.characterEffect10006ui_story and not isNil(var_120_11) then
					arg_117_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_12 + var_120_13 and arg_117_1.time_ < var_120_12 + var_120_13 + arg_120_0 and not isNil(var_120_11) and arg_117_1.var_.characterEffect10006ui_story then
				arg_117_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_120_15 = 0
			local var_120_16 = 1.075

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_17 = arg_117_1:FormatText(StoryNameCfg[225].name)

				arg_117_1.leftNameTxt_.text = var_120_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(113172028)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 43
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172028", "story_v_out_113172.awb") ~= 0 then
					local var_120_23 = manager.audio:GetVoiceLength("story_v_out_113172", "113172028", "story_v_out_113172.awb") / 1000

					if var_120_23 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_15
					end

					if var_120_18.prefab_name ~= "" and arg_117_1.actors_[var_120_18.prefab_name] ~= nil then
						local var_120_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_18.prefab_name].transform, "story_v_out_113172", "113172028", "story_v_out_113172.awb")

						arg_117_1:RecordAudio("113172028", var_120_24)
						arg_117_1:RecordAudio("113172028", var_120_24)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_113172", "113172028", "story_v_out_113172.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_113172", "113172028", "story_v_out_113172.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_25 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_25 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_25

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_25 and arg_117_1.time_ < var_120_15 + var_120_25 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play113172029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 113172029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play113172030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10006ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10006ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, 100, 0)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10006ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, 100, 0)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = 0
			local var_124_10 = 1

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				local var_124_11 = "play"
				local var_124_12 = "effect"

				arg_121_1:AudioAction(var_124_11, var_124_12, "se_story_10", "se_story_10_snap", "")
			end

			local var_124_13 = 0
			local var_124_14 = 0.825

			if var_124_13 < arg_121_1.time_ and arg_121_1.time_ <= var_124_13 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_15 = arg_121_1:GetWordFromCfg(113172029)
				local var_124_16 = arg_121_1:FormatText(var_124_15.content)

				arg_121_1.text_.text = var_124_16

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_17 = 33
				local var_124_18 = utf8.len(var_124_16)
				local var_124_19 = var_124_17 <= 0 and var_124_14 or var_124_14 * (var_124_18 / var_124_17)

				if var_124_19 > 0 and var_124_14 < var_124_19 then
					arg_121_1.talkMaxDuration = var_124_19

					if var_124_19 + var_124_13 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_19 + var_124_13
					end
				end

				arg_121_1.text_.text = var_124_16
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_20 = math.max(var_124_14, arg_121_1.talkMaxDuration)

			if var_124_13 <= arg_121_1.time_ and arg_121_1.time_ < var_124_13 + var_124_20 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_13) / var_124_20

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_13 + var_124_20 and arg_121_1.time_ < var_124_13 + var_124_20 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play113172030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 113172030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play113172031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 0.85

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(113172030)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 34
				local var_128_5 = utf8.len(var_128_3)
				local var_128_6 = var_128_4 <= 0 and var_128_1 or var_128_1 * (var_128_5 / var_128_4)

				if var_128_6 > 0 and var_128_1 < var_128_6 then
					arg_125_1.talkMaxDuration = var_128_6

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_7 and arg_125_1.time_ < var_128_0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play113172031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 113172031
		arg_129_1.duration_ = 8.97

		local var_129_0 = {
			ja = 8.8,
			ko = 8.466,
			zh = 8.966,
			en = 8.833
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play113172032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10006ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10006ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(0, -0.98, -5.65)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10006ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -0.98, -5.65)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = 0

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 then
				arg_129_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action4_1")
			end

			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 then
				arg_129_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_132_11 = arg_129_1.actors_["10006ui_story"]
			local var_132_12 = 0

			if var_132_12 < arg_129_1.time_ and arg_129_1.time_ <= var_132_12 + arg_132_0 and not isNil(var_132_11) and arg_129_1.var_.characterEffect10006ui_story == nil then
				arg_129_1.var_.characterEffect10006ui_story = var_132_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_13 = 0.2

			if var_132_12 <= arg_129_1.time_ and arg_129_1.time_ < var_132_12 + var_132_13 and not isNil(var_132_11) then
				local var_132_14 = (arg_129_1.time_ - var_132_12) / var_132_13

				if arg_129_1.var_.characterEffect10006ui_story and not isNil(var_132_11) then
					arg_129_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_12 + var_132_13 and arg_129_1.time_ < var_132_12 + var_132_13 + arg_132_0 and not isNil(var_132_11) and arg_129_1.var_.characterEffect10006ui_story then
				arg_129_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_132_15 = 0
			local var_132_16 = 1.025

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_17 = arg_129_1:FormatText(StoryNameCfg[225].name)

				arg_129_1.leftNameTxt_.text = var_132_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_18 = arg_129_1:GetWordFromCfg(113172031)
				local var_132_19 = arg_129_1:FormatText(var_132_18.content)

				arg_129_1.text_.text = var_132_19

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_20 = 41
				local var_132_21 = utf8.len(var_132_19)
				local var_132_22 = var_132_20 <= 0 and var_132_16 or var_132_16 * (var_132_21 / var_132_20)

				if var_132_22 > 0 and var_132_16 < var_132_22 then
					arg_129_1.talkMaxDuration = var_132_22

					if var_132_22 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_22 + var_132_15
					end
				end

				arg_129_1.text_.text = var_132_19
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172031", "story_v_out_113172.awb") ~= 0 then
					local var_132_23 = manager.audio:GetVoiceLength("story_v_out_113172", "113172031", "story_v_out_113172.awb") / 1000

					if var_132_23 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_15
					end

					if var_132_18.prefab_name ~= "" and arg_129_1.actors_[var_132_18.prefab_name] ~= nil then
						local var_132_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_18.prefab_name].transform, "story_v_out_113172", "113172031", "story_v_out_113172.awb")

						arg_129_1:RecordAudio("113172031", var_132_24)
						arg_129_1:RecordAudio("113172031", var_132_24)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_113172", "113172031", "story_v_out_113172.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_113172", "113172031", "story_v_out_113172.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_25 = math.max(var_132_16, arg_129_1.talkMaxDuration)

			if var_132_15 <= arg_129_1.time_ and arg_129_1.time_ < var_132_15 + var_132_25 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_15) / var_132_25

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_15 + var_132_25 and arg_129_1.time_ < var_132_15 + var_132_25 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play113172032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 113172032
		arg_133_1.duration_ = 11.7

		local var_133_0 = {
			ja = 11.7,
			ko = 8.4,
			zh = 10.3,
			en = 9.633
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
				arg_133_0:Play113172033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006actionlink/10006action443")
			end

			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_136_2 = 0
			local var_136_3 = 1.1

			if var_136_2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_4 = arg_133_1:FormatText(StoryNameCfg[225].name)

				arg_133_1.leftNameTxt_.text = var_136_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_5 = arg_133_1:GetWordFromCfg(113172032)
				local var_136_6 = arg_133_1:FormatText(var_136_5.content)

				arg_133_1.text_.text = var_136_6

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 44
				local var_136_8 = utf8.len(var_136_6)
				local var_136_9 = var_136_7 <= 0 and var_136_3 or var_136_3 * (var_136_8 / var_136_7)

				if var_136_9 > 0 and var_136_3 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_6
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172032", "story_v_out_113172.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_113172", "113172032", "story_v_out_113172.awb") / 1000

					if var_136_10 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_2
					end

					if var_136_5.prefab_name ~= "" and arg_133_1.actors_[var_136_5.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_5.prefab_name].transform, "story_v_out_113172", "113172032", "story_v_out_113172.awb")

						arg_133_1:RecordAudio("113172032", var_136_11)
						arg_133_1:RecordAudio("113172032", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_113172", "113172032", "story_v_out_113172.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_113172", "113172032", "story_v_out_113172.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_12 and arg_133_1.time_ < var_136_2 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play113172033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 113172033
		arg_137_1.duration_ = 11.6

		local var_137_0 = {
			ja = 11.6,
			ko = 6.966,
			zh = 7.8,
			en = 10.6
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
				arg_137_0:Play113172034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_140_1 = 0
			local var_140_2 = 0.875

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_3 = arg_137_1:FormatText(StoryNameCfg[225].name)

				arg_137_1.leftNameTxt_.text = var_140_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:GetWordFromCfg(113172033)
				local var_140_5 = arg_137_1:FormatText(var_140_4.content)

				arg_137_1.text_.text = var_140_5

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 35
				local var_140_7 = utf8.len(var_140_5)
				local var_140_8 = var_140_6 <= 0 and var_140_2 or var_140_2 * (var_140_7 / var_140_6)

				if var_140_8 > 0 and var_140_2 < var_140_8 then
					arg_137_1.talkMaxDuration = var_140_8

					if var_140_8 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_5
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172033", "story_v_out_113172.awb") ~= 0 then
					local var_140_9 = manager.audio:GetVoiceLength("story_v_out_113172", "113172033", "story_v_out_113172.awb") / 1000

					if var_140_9 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_1
					end

					if var_140_4.prefab_name ~= "" and arg_137_1.actors_[var_140_4.prefab_name] ~= nil then
						local var_140_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_4.prefab_name].transform, "story_v_out_113172", "113172033", "story_v_out_113172.awb")

						arg_137_1:RecordAudio("113172033", var_140_10)
						arg_137_1:RecordAudio("113172033", var_140_10)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_113172", "113172033", "story_v_out_113172.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_113172", "113172033", "story_v_out_113172.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_11 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_11 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_11

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_11 and arg_137_1.time_ < var_140_1 + var_140_11 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play113172034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 113172034
		arg_141_1.duration_ = 9

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play113172035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_1 = 2

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_1 then
				local var_144_2 = (arg_141_1.time_ - var_144_0) / var_144_1
				local var_144_3 = Color.New(0, 0, 0)

				var_144_3.a = Mathf.Lerp(0, 1, var_144_2)
				arg_141_1.mask_.color = var_144_3
			end

			if arg_141_1.time_ >= var_144_0 + var_144_1 and arg_141_1.time_ < var_144_0 + var_144_1 + arg_144_0 then
				local var_144_4 = Color.New(0, 0, 0)

				var_144_4.a = 1
				arg_141_1.mask_.color = var_144_4
			end

			local var_144_5 = 2

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_6 = 2

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_6 then
				local var_144_7 = (arg_141_1.time_ - var_144_5) / var_144_6
				local var_144_8 = Color.New(1, 1, 1)

				var_144_8.a = Mathf.Lerp(1, 0, var_144_7)
				arg_141_1.mask_.color = var_144_8
			end

			if arg_141_1.time_ >= var_144_5 + var_144_6 and arg_141_1.time_ < var_144_5 + var_144_6 + arg_144_0 then
				local var_144_9 = Color.New(1, 1, 1)
				local var_144_10 = 0

				arg_141_1.mask_.enabled = false
				var_144_9.a = var_144_10
				arg_141_1.mask_.color = var_144_9
			end

			local var_144_11 = "OM0105"

			if arg_141_1.bgs_[var_144_11] == nil then
				local var_144_12 = Object.Instantiate(arg_141_1.paintGo_)

				var_144_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_144_11)
				var_144_12.name = var_144_11
				var_144_12.transform.parent = arg_141_1.stage_.transform
				var_144_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.bgs_[var_144_11] = var_144_12
			end

			local var_144_13 = 2

			if var_144_13 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				local var_144_14 = manager.ui.mainCamera.transform.localPosition
				local var_144_15 = Vector3.New(0, 0, 10) + Vector3.New(var_144_14.x, var_144_14.y, 0)
				local var_144_16 = arg_141_1.bgs_.OM0105

				var_144_16.transform.localPosition = var_144_15
				var_144_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_17 = var_144_16:GetComponent("SpriteRenderer")

				if var_144_17 and var_144_17.sprite then
					local var_144_18 = (var_144_16.transform.localPosition - var_144_14).z
					local var_144_19 = manager.ui.mainCameraCom_
					local var_144_20 = 2 * var_144_18 * Mathf.Tan(var_144_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_144_21 = var_144_20 * var_144_19.aspect
					local var_144_22 = var_144_17.sprite.bounds.size.x
					local var_144_23 = var_144_17.sprite.bounds.size.y
					local var_144_24 = var_144_21 / var_144_22
					local var_144_25 = var_144_20 / var_144_23
					local var_144_26 = var_144_25 < var_144_24 and var_144_24 or var_144_25

					var_144_16.transform.localScale = Vector3.New(var_144_26, var_144_26, 0)
				end

				for iter_144_0, iter_144_1 in pairs(arg_141_1.bgs_) do
					if iter_144_0 ~= "OM0105" then
						iter_144_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_144_27 = arg_141_1.actors_["10006ui_story"].transform
			local var_144_28 = 1.966

			if var_144_28 < arg_141_1.time_ and arg_141_1.time_ <= var_144_28 + arg_144_0 then
				arg_141_1.var_.moveOldPos10006ui_story = var_144_27.localPosition
			end

			local var_144_29 = 0.001

			if var_144_28 <= arg_141_1.time_ and arg_141_1.time_ < var_144_28 + var_144_29 then
				local var_144_30 = (arg_141_1.time_ - var_144_28) / var_144_29
				local var_144_31 = Vector3.New(0, 100, 0)

				var_144_27.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10006ui_story, var_144_31, var_144_30)

				local var_144_32 = manager.ui.mainCamera.transform.position - var_144_27.position

				var_144_27.forward = Vector3.New(var_144_32.x, var_144_32.y, var_144_32.z)

				local var_144_33 = var_144_27.localEulerAngles

				var_144_33.z = 0
				var_144_33.x = 0
				var_144_27.localEulerAngles = var_144_33
			end

			if arg_141_1.time_ >= var_144_28 + var_144_29 and arg_141_1.time_ < var_144_28 + var_144_29 + arg_144_0 then
				var_144_27.localPosition = Vector3.New(0, 100, 0)

				local var_144_34 = manager.ui.mainCamera.transform.position - var_144_27.position

				var_144_27.forward = Vector3.New(var_144_34.x, var_144_34.y, var_144_34.z)

				local var_144_35 = var_144_27.localEulerAngles

				var_144_35.z = 0
				var_144_35.x = 0
				var_144_27.localEulerAngles = var_144_35
			end

			local var_144_36 = arg_141_1.bgs_.OM0105.transform
			local var_144_37 = 2

			if var_144_37 < arg_141_1.time_ and arg_141_1.time_ <= var_144_37 + arg_144_0 then
				arg_141_1.var_.moveOldPosOM0105 = var_144_36.localPosition
			end

			local var_144_38 = 0.001

			if var_144_37 <= arg_141_1.time_ and arg_141_1.time_ < var_144_37 + var_144_38 then
				local var_144_39 = (arg_141_1.time_ - var_144_37) / var_144_38
				local var_144_40 = Vector3.New(0, 1, 9)

				var_144_36.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPosOM0105, var_144_40, var_144_39)
			end

			if arg_141_1.time_ >= var_144_37 + var_144_38 and arg_141_1.time_ < var_144_37 + var_144_38 + arg_144_0 then
				var_144_36.localPosition = Vector3.New(0, 1, 9)
			end

			local var_144_41 = arg_141_1.bgs_.OM0105.transform
			local var_144_42 = 2.034

			if var_144_42 < arg_141_1.time_ and arg_141_1.time_ <= var_144_42 + arg_144_0 then
				arg_141_1.var_.moveOldPosOM0105 = var_144_41.localPosition
			end

			local var_144_43 = 3.5

			if var_144_42 <= arg_141_1.time_ and arg_141_1.time_ < var_144_42 + var_144_43 then
				local var_144_44 = (arg_141_1.time_ - var_144_42) / var_144_43
				local var_144_45 = Vector3.New(0, 1, 10)

				var_144_41.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPosOM0105, var_144_45, var_144_44)
			end

			if arg_141_1.time_ >= var_144_42 + var_144_43 and arg_141_1.time_ < var_144_42 + var_144_43 + arg_144_0 then
				var_144_41.localPosition = Vector3.New(0, 1, 10)
			end

			local var_144_46 = 4

			if var_144_46 < arg_141_1.time_ and arg_141_1.time_ <= var_144_46 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			local var_144_47 = 1.534

			if arg_141_1.time_ >= var_144_46 + var_144_47 and arg_141_1.time_ < var_144_46 + var_144_47 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_48 = 4
			local var_144_49 = 0.725

			if var_144_48 < arg_141_1.time_ and arg_141_1.time_ <= var_144_48 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_50 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_50:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_51 = arg_141_1:GetWordFromCfg(113172034)
				local var_144_52 = arg_141_1:FormatText(var_144_51.content)

				arg_141_1.text_.text = var_144_52

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_53 = 29
				local var_144_54 = utf8.len(var_144_52)
				local var_144_55 = var_144_53 <= 0 and var_144_49 or var_144_49 * (var_144_54 / var_144_53)

				if var_144_55 > 0 and var_144_49 < var_144_55 then
					arg_141_1.talkMaxDuration = var_144_55
					var_144_48 = var_144_48 + 0.3

					if var_144_55 + var_144_48 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_55 + var_144_48
					end
				end

				arg_141_1.text_.text = var_144_52
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_56 = var_144_48 + 0.3
			local var_144_57 = math.max(var_144_49, arg_141_1.talkMaxDuration)

			if var_144_56 <= arg_141_1.time_ and arg_141_1.time_ < var_144_56 + var_144_57 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_56) / var_144_57

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_56 + var_144_57 and arg_141_1.time_ < var_144_56 + var_144_57 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "OM0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play113172035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 113172035
		arg_147_1.duration_ = 5.57

		local var_147_0 = {
			ja = 5.066,
			ko = 3.7,
			zh = 5.566,
			en = 4.533
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play113172036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.4

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[225].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(113172035)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 16
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172035", "story_v_out_113172.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_113172", "113172035", "story_v_out_113172.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_113172", "113172035", "story_v_out_113172.awb")

						arg_147_1:RecordAudio("113172035", var_150_9)
						arg_147_1:RecordAudio("113172035", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_113172", "113172035", "story_v_out_113172.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_113172", "113172035", "story_v_out_113172.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play113172036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 113172036
		arg_151_1.duration_ = 6.5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play113172037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = manager.ui.mainCamera.transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.shakeOldPos = var_154_0.localPosition
			end

			local var_154_2 = 1.2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / 0.066
				local var_154_4, var_154_5 = math.modf(var_154_3)

				var_154_0.localPosition = Vector3.New(var_154_5 * 0.13, var_154_5 * 0.13, var_154_5 * 0.13) + arg_151_1.var_.shakeOldPos
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = arg_151_1.var_.shakeOldPos
			end

			local var_154_6 = 0

			if var_154_6 < arg_151_1.time_ and arg_151_1.time_ <= var_154_6 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			local var_154_7 = 1.5

			if arg_151_1.time_ >= var_154_6 + var_154_7 and arg_151_1.time_ < var_154_6 + var_154_7 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			local var_154_8 = 0
			local var_154_9 = 1

			if var_154_8 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				local var_154_10 = "play"
				local var_154_11 = "effect"

				arg_151_1:AudioAction(var_154_10, var_154_11, "se_story_10", "se_story_10_light", "")
			end

			if arg_151_1.frameCnt_ <= 1 then
				arg_151_1.dialog_:SetActive(false)
			end

			local var_154_12 = 1.5
			local var_154_13 = 1.3

			if var_154_12 < arg_151_1.time_ and arg_151_1.time_ <= var_154_12 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_14 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_14:setOnUpdate(LuaHelper.FloatAction(function(arg_155_0)
					arg_151_1.dialogCg_.alpha = arg_155_0
				end))
				var_154_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_15 = arg_151_1:GetWordFromCfg(113172036)
				local var_154_16 = arg_151_1:FormatText(var_154_15.content)

				arg_151_1.text_.text = var_154_16

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_17 = 52
				local var_154_18 = utf8.len(var_154_16)
				local var_154_19 = var_154_17 <= 0 and var_154_13 or var_154_13 * (var_154_18 / var_154_17)

				if var_154_19 > 0 and var_154_13 < var_154_19 then
					arg_151_1.talkMaxDuration = var_154_19
					var_154_12 = var_154_12 + 0.3

					if var_154_19 + var_154_12 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_19 + var_154_12
					end
				end

				arg_151_1.text_.text = var_154_16
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_20 = var_154_12 + 0.3
			local var_154_21 = math.max(var_154_13, arg_151_1.talkMaxDuration)

			if var_154_20 <= arg_151_1.time_ and arg_151_1.time_ < var_154_20 + var_154_21 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_20) / var_154_21

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_20 + var_154_21 and arg_151_1.time_ < var_154_20 + var_154_21 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play113172037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 113172037
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play113172038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.8

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				local var_160_2 = "play"
				local var_160_3 = "effect"

				arg_157_1:AudioAction(var_160_2, var_160_3, "se_story_10", "se_story_10_crack", "")
			end

			local var_160_4 = 0
			local var_160_5 = 0.55

			if var_160_4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(113172037)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_8 = 22
				local var_160_9 = utf8.len(var_160_7)
				local var_160_10 = var_160_8 <= 0 and var_160_5 or var_160_5 * (var_160_9 / var_160_8)

				if var_160_10 > 0 and var_160_5 < var_160_10 then
					arg_157_1.talkMaxDuration = var_160_10

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_11 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_11 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_11

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_11 and arg_157_1.time_ < var_160_4 + var_160_11 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play113172038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 113172038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play113172039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.999999999999

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				local var_164_2 = "play"
				local var_164_3 = "effect"

				arg_161_1:AudioAction(var_164_2, var_164_3, "se_story_10", "se_story_10_fog02", "")
			end

			local var_164_4 = 0
			local var_164_5 = 0.725

			if var_164_4 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(113172038)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_8 = 29
				local var_164_9 = utf8.len(var_164_7)
				local var_164_10 = var_164_8 <= 0 and var_164_5 or var_164_5 * (var_164_9 / var_164_8)

				if var_164_10 > 0 and var_164_5 < var_164_10 then
					arg_161_1.talkMaxDuration = var_164_10

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_11 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_11 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_11

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_11 and arg_161_1.time_ < var_164_4 + var_164_11 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play113172039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 113172039
		arg_165_1.duration_ = 6.9

		local var_165_0 = {
			ja = 6.433,
			ko = 3.6,
			zh = 6.166,
			en = 6.9
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
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play113172040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.3

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[225].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(113172039)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172039", "story_v_out_113172.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_113172", "113172039", "story_v_out_113172.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_113172", "113172039", "story_v_out_113172.awb")

						arg_165_1:RecordAudio("113172039", var_168_9)
						arg_165_1:RecordAudio("113172039", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_113172", "113172039", "story_v_out_113172.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_113172", "113172039", "story_v_out_113172.awb")
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
	Play113172040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 113172040
		arg_169_1.duration_ = 5.8

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play113172041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = manager.ui.mainCamera.transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.shakeOldPos = var_172_0.localPosition
			end

			local var_172_2 = 0.6

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / 0.066
				local var_172_4, var_172_5 = math.modf(var_172_3)

				var_172_0.localPosition = Vector3.New(var_172_5 * 0.13, var_172_5 * 0.13, var_172_5 * 0.13) + arg_169_1.var_.shakeOldPos
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = arg_169_1.var_.shakeOldPos
			end

			local var_172_6 = 0

			if var_172_6 < arg_169_1.time_ and arg_169_1.time_ <= var_172_6 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			local var_172_7 = 0.8

			if arg_169_1.time_ >= var_172_6 + var_172_7 and arg_169_1.time_ < var_172_6 + var_172_7 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end

			local var_172_8 = 0
			local var_172_9 = 1

			if var_172_8 < arg_169_1.time_ and arg_169_1.time_ <= var_172_8 + arg_172_0 then
				local var_172_10 = "play"
				local var_172_11 = "effect"

				arg_169_1:AudioAction(var_172_10, var_172_11, "se_story_10", "se_story_10_fall", "")
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_12 = 0.8
			local var_172_13 = 0.425

			if var_172_12 < arg_169_1.time_ and arg_169_1.time_ <= var_172_12 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_14 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_14:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_169_1.dialogCg_.alpha = arg_173_0
				end))
				var_172_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_15 = arg_169_1:GetWordFromCfg(113172040)
				local var_172_16 = arg_169_1:FormatText(var_172_15.content)

				arg_169_1.text_.text = var_172_16

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_17 = 17
				local var_172_18 = utf8.len(var_172_16)
				local var_172_19 = var_172_17 <= 0 and var_172_13 or var_172_13 * (var_172_18 / var_172_17)

				if var_172_19 > 0 and var_172_13 < var_172_19 then
					arg_169_1.talkMaxDuration = var_172_19
					var_172_12 = var_172_12 + 0.3

					if var_172_19 + var_172_12 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_19 + var_172_12
					end
				end

				arg_169_1.text_.text = var_172_16
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_20 = var_172_12 + 0.3
			local var_172_21 = math.max(var_172_13, arg_169_1.talkMaxDuration)

			if var_172_20 <= arg_169_1.time_ and arg_169_1.time_ < var_172_20 + var_172_21 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_20) / var_172_21

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_20 + var_172_21 and arg_169_1.time_ < var_172_20 + var_172_21 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play113172041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 113172041
		arg_175_1.duration_ = 9.1

		local var_175_0 = {
			ja = 6.733,
			ko = 4.633,
			zh = 5.6,
			en = 9.1
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play113172042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.575

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[225].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:GetWordFromCfg(113172041)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 23
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172041", "story_v_out_113172.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_113172", "113172041", "story_v_out_113172.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_113172", "113172041", "story_v_out_113172.awb")

						arg_175_1:RecordAudio("113172041", var_178_9)
						arg_175_1:RecordAudio("113172041", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_113172", "113172041", "story_v_out_113172.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_113172", "113172041", "story_v_out_113172.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_10 and arg_175_1.time_ < var_178_0 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play113172042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 113172042
		arg_179_1.duration_ = 4.6

		local var_179_0 = {
			ja = 4.6,
			ko = 2.9,
			zh = 2.633,
			en = 4.4
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play113172043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.2

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[225].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(113172042)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 8
				local var_182_6 = utf8.len(var_182_4)
				local var_182_7 = var_182_5 <= 0 and var_182_1 or var_182_1 * (var_182_6 / var_182_5)

				if var_182_7 > 0 and var_182_1 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_0
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172042", "story_v_out_113172.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_113172", "113172042", "story_v_out_113172.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_113172", "113172042", "story_v_out_113172.awb")

						arg_179_1:RecordAudio("113172042", var_182_9)
						arg_179_1:RecordAudio("113172042", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_113172", "113172042", "story_v_out_113172.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_113172", "113172042", "story_v_out_113172.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_1, arg_179_1.talkMaxDuration)

			if var_182_0 <= arg_179_1.time_ and arg_179_1.time_ < var_182_0 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_0) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_0 + var_182_10 and arg_179_1.time_ < var_182_0 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play113172043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 113172043
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play113172044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.6

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_2 = arg_183_1:GetWordFromCfg(113172043)
				local var_186_3 = arg_183_1:FormatText(var_186_2.content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 24
				local var_186_5 = utf8.len(var_186_3)
				local var_186_6 = var_186_4 <= 0 and var_186_1 or var_186_1 * (var_186_5 / var_186_4)

				if var_186_6 > 0 and var_186_1 < var_186_6 then
					arg_183_1.talkMaxDuration = var_186_6

					if var_186_6 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_7 and arg_183_1.time_ < var_186_0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play113172044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 113172044
		arg_187_1.duration_ = 8.1

		local var_187_0 = {
			ja = 7.6,
			ko = 4.833,
			zh = 6.666,
			en = 8.1
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
			arg_187_1.auto_ = false
		end

		function arg_187_1.playNext_(arg_189_0)
			arg_187_1.onStoryFinished_()
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.525

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[225].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:GetWordFromCfg(113172044)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 21
				local var_190_6 = utf8.len(var_190_4)
				local var_190_7 = var_190_5 <= 0 and var_190_1 or var_190_1 * (var_190_6 / var_190_5)

				if var_190_7 > 0 and var_190_1 < var_190_7 then
					arg_187_1.talkMaxDuration = var_190_7

					if var_190_7 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_7 + var_190_0
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113172", "113172044", "story_v_out_113172.awb") ~= 0 then
					local var_190_8 = manager.audio:GetVoiceLength("story_v_out_113172", "113172044", "story_v_out_113172.awb") / 1000

					if var_190_8 + var_190_0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_0
					end

					if var_190_3.prefab_name ~= "" and arg_187_1.actors_[var_190_3.prefab_name] ~= nil then
						local var_190_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_3.prefab_name].transform, "story_v_out_113172", "113172044", "story_v_out_113172.awb")

						arg_187_1:RecordAudio("113172044", var_190_9)
						arg_187_1:RecordAudio("113172044", var_190_9)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_113172", "113172044", "story_v_out_113172.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_113172", "113172044", "story_v_out_113172.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_10 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_10 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_10

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_10 and arg_187_1.time_ < var_190_0 + var_190_10 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/OM0104",
		"TextureConfig/Background/F03b",
		"TextureConfig/Background/OM0105"
	},
	voices = {
		"story_v_out_113172.awb"
	}
}
