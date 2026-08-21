return {
	Play324011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324011001
		arg_1_1.duration_ = 74.5

		local var_1_0 = {
			zh = 73.9,
			ja = 74.5
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2009"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 68.6

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.ST2009

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
					if iter_4_0 ~= "ST2009" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 69.4

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

			local var_4_24 = 65.7

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_25 = 2.9

			if var_4_24 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				local var_4_26 = (arg_1_1.time_ - var_4_24) / var_4_25
				local var_4_27 = Color.New(0, 0, 0)

				var_4_27.a = Mathf.Lerp(0, 1, var_4_26)
				arg_1_1.mask_.color = var_4_27
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				local var_4_28 = Color.New(0, 0, 0)

				var_4_28.a = 1
				arg_1_1.mask_.color = var_4_28
			end

			local var_4_29 = 68.6

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_30 = 2.76666666666667

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30
				local var_4_32 = Color.New(0, 0, 0)

				var_4_32.a = Mathf.Lerp(1, 0, var_4_31)
				arg_1_1.mask_.color = var_4_32
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				local var_4_33 = Color.New(0, 0, 0)
				local var_4_34 = 0

				arg_1_1.mask_.enabled = false
				var_4_33.a = var_4_34
				arg_1_1.mask_.color = var_4_33
			end

			local var_4_35 = 68.6
			local var_4_36 = 1.49999999999999

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				local var_4_37 = "play"
				local var_4_38 = "effect"

				arg_1_1:AudioAction(var_4_37, var_4_38, "se_story_143", "se_story_143_amb_bar", "")
			end

			local var_4_39 = 70
			local var_4_40 = 1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_41 = "play"
				local var_4_42 = "music"

				arg_1_1:AudioAction(var_4_41, var_4_42, "bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun.awb")

				local var_4_43 = ""
				local var_4_44 = manager.audio:GetAudioName("bgm_activity_5_0_story_dahuaishucun", "bgm_activity_5_0_story_dahuaishucun")

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

			local var_4_45 = 69
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "effect"

				arg_1_1:AudioAction(var_4_47, var_4_48, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_49 = 0
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "bgm_activity_5_0_cg_shanbei", "bgm_activity_5_0_cg_shanbei", "bgm_activity_5_0_cg_shanbei.awb")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("bgm_activity_5_0_cg_shanbei", "bgm_activity_5_0_cg_shanbei")

				if var_4_54 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_54 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_54

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_54
						arg_1_1.bgmTxt2_.text = var_4_54
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

			local var_4_55 = "M01i"

			if arg_1_1.bgs_[var_4_55] == nil then
				local var_4_56 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_56:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_55)
				var_4_56.name = var_4_55
				var_4_56.transform.parent = arg_1_1.stage_.transform
				var_4_56.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_55] = var_4_56
			end

			local var_4_57 = arg_1_1.bgs_.M01i
			local var_4_58 = 0

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				local var_4_59 = var_4_57:GetComponent("SpriteRenderer")

				if var_4_59 then
					arg_1_1.var_.alphaOldValueM01i = var_4_59.color.a
					arg_1_1.var_.alphaMatValueM01i = var_4_59
				end

				arg_1_1.var_.alphaOldValueM01i = 0
			end

			local var_4_60 = 0.034

			if var_4_58 <= arg_1_1.time_ and arg_1_1.time_ < var_4_58 + var_4_60 then
				local var_4_61 = (arg_1_1.time_ - var_4_58) / var_4_60
				local var_4_62 = Mathf.Lerp(arg_1_1.var_.alphaOldValueM01i, 1, var_4_61)

				if arg_1_1.var_.alphaMatValueM01i then
					local var_4_63 = arg_1_1.var_.alphaMatValueM01i.color

					var_4_63.a = var_4_62
					arg_1_1.var_.alphaMatValueM01i.color = var_4_63
				end
			end

			if arg_1_1.time_ >= var_4_58 + var_4_60 and arg_1_1.time_ < var_4_58 + var_4_60 + arg_4_0 and arg_1_1.var_.alphaMatValueM01i then
				local var_4_64 = arg_1_1.var_.alphaMatValueM01i
				local var_4_65 = var_4_64.color

				var_4_65.a = 1
				var_4_64.color = var_4_65
			end

			local var_4_66 = arg_1_1.bgs_.M01i.transform
			local var_4_67 = 0.0333333333333333

			if var_4_67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_67 + arg_4_0 then
				arg_1_1.var_.moveOldPosM01i = var_4_66.localPosition
			end

			local var_4_68 = 0.001

			if var_4_67 <= arg_1_1.time_ and arg_1_1.time_ < var_4_67 + var_4_68 then
				local var_4_69 = (arg_1_1.time_ - var_4_67) / var_4_68
				local var_4_70 = Vector3.New(0, 0, 0)

				var_4_66.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosM01i, var_4_70, var_4_69)
			end

			if arg_1_1.time_ >= var_4_67 + var_4_68 and arg_1_1.time_ < var_4_67 + var_4_68 + arg_4_0 then
				var_4_66.localPosition = Vector3.New(0, 0, 0)
			end

			local var_4_71 = "J21f"

			if arg_1_1.bgs_[var_4_71] == nil then
				local var_4_72 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_72:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_71)
				var_4_72.name = var_4_71
				var_4_72.transform.parent = arg_1_1.stage_.transform
				var_4_72.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_71] = var_4_72
			end

			local var_4_73 = arg_1_1.bgs_.J21f
			local var_4_74 = 0

			if var_4_74 < arg_1_1.time_ and arg_1_1.time_ <= var_4_74 + arg_4_0 then
				local var_4_75 = var_4_73:GetComponent("SpriteRenderer")

				if var_4_75 then
					arg_1_1.var_.alphaOldValueJ21f = var_4_75.color.a
					arg_1_1.var_.alphaMatValueJ21f = var_4_75
				end

				arg_1_1.var_.alphaOldValueJ21f = 1
			end

			local var_4_76 = 0.034

			if var_4_74 <= arg_1_1.time_ and arg_1_1.time_ < var_4_74 + var_4_76 then
				local var_4_77 = (arg_1_1.time_ - var_4_74) / var_4_76
				local var_4_78 = Mathf.Lerp(arg_1_1.var_.alphaOldValueJ21f, 0, var_4_77)

				if arg_1_1.var_.alphaMatValueJ21f then
					local var_4_79 = arg_1_1.var_.alphaMatValueJ21f.color

					var_4_79.a = var_4_78
					arg_1_1.var_.alphaMatValueJ21f.color = var_4_79
				end
			end

			if arg_1_1.time_ >= var_4_74 + var_4_76 and arg_1_1.time_ < var_4_74 + var_4_76 + arg_4_0 and arg_1_1.var_.alphaMatValueJ21f then
				local var_4_80 = arg_1_1.var_.alphaMatValueJ21f
				local var_4_81 = var_4_80.color

				var_4_81.a = 0
				var_4_80.color = var_4_81
			end

			local var_4_82 = arg_1_1.bgs_.J21f.transform
			local var_4_83 = 0.0333333333333333

			if var_4_83 < arg_1_1.time_ and arg_1_1.time_ <= var_4_83 + arg_4_0 then
				arg_1_1.var_.moveOldPosJ21f = var_4_82.localPosition
			end

			local var_4_84 = 0.001

			if var_4_83 <= arg_1_1.time_ and arg_1_1.time_ < var_4_83 + var_4_84 then
				local var_4_85 = (arg_1_1.time_ - var_4_83) / var_4_84
				local var_4_86 = Vector3.New(0, 1, 0)

				var_4_82.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosJ21f, var_4_86, var_4_85)
			end

			if arg_1_1.time_ >= var_4_83 + var_4_84 and arg_1_1.time_ < var_4_83 + var_4_84 + arg_4_0 then
				var_4_82.localPosition = Vector3.New(0, 1, 0)
			end

			local var_4_87 = arg_1_1.bgs_.M01i
			local var_4_88 = 15.1666666666667

			if var_4_88 < arg_1_1.time_ and arg_1_1.time_ <= var_4_88 + arg_4_0 then
				local var_4_89 = var_4_87:GetComponent("SpriteRenderer")

				if var_4_89 then
					arg_1_1.var_.alphaOldValueM01i = var_4_89.color.a
					arg_1_1.var_.alphaMatValueM01i = var_4_89
				end

				arg_1_1.var_.alphaOldValueM01i = 1
			end

			local var_4_90 = 6.73333333333333

			if var_4_88 <= arg_1_1.time_ and arg_1_1.time_ < var_4_88 + var_4_90 then
				local var_4_91 = (arg_1_1.time_ - var_4_88) / var_4_90
				local var_4_92 = Mathf.Lerp(arg_1_1.var_.alphaOldValueM01i, 0, var_4_91)

				if arg_1_1.var_.alphaMatValueM01i then
					local var_4_93 = arg_1_1.var_.alphaMatValueM01i.color

					var_4_93.a = var_4_92
					arg_1_1.var_.alphaMatValueM01i.color = var_4_93
				end
			end

			if arg_1_1.time_ >= var_4_88 + var_4_90 and arg_1_1.time_ < var_4_88 + var_4_90 + arg_4_0 and arg_1_1.var_.alphaMatValueM01i then
				local var_4_94 = arg_1_1.var_.alphaMatValueM01i
				local var_4_95 = var_4_94.color

				var_4_95.a = 0
				var_4_94.color = var_4_95
			end

			local var_4_96 = "J24f"

			if arg_1_1.bgs_[var_4_96] == nil then
				local var_4_97 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_97:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_96)
				var_4_97.name = var_4_96
				var_4_97.transform.parent = arg_1_1.stage_.transform
				var_4_97.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_96] = var_4_97
			end

			local var_4_98 = arg_1_1.bgs_.J24f
			local var_4_99 = 32.3666666666667

			if var_4_99 < arg_1_1.time_ and arg_1_1.time_ <= var_4_99 + arg_4_0 then
				local var_4_100 = var_4_98:GetComponent("SpriteRenderer")

				if var_4_100 then
					arg_1_1.var_.alphaOldValueJ24f = var_4_100.color.a
					arg_1_1.var_.alphaMatValueJ24f = var_4_100
				end

				arg_1_1.var_.alphaOldValueJ24f = 0
			end

			local var_4_101 = 6.73333333333333

			if var_4_99 <= arg_1_1.time_ and arg_1_1.time_ < var_4_99 + var_4_101 then
				local var_4_102 = (arg_1_1.time_ - var_4_99) / var_4_101
				local var_4_103 = Mathf.Lerp(arg_1_1.var_.alphaOldValueJ24f, 1, var_4_102)

				if arg_1_1.var_.alphaMatValueJ24f then
					local var_4_104 = arg_1_1.var_.alphaMatValueJ24f.color

					var_4_104.a = var_4_103
					arg_1_1.var_.alphaMatValueJ24f.color = var_4_104
				end
			end

			if arg_1_1.time_ >= var_4_99 + var_4_101 and arg_1_1.time_ < var_4_99 + var_4_101 + arg_4_0 and arg_1_1.var_.alphaMatValueJ24f then
				local var_4_105 = arg_1_1.var_.alphaMatValueJ24f
				local var_4_106 = var_4_105.color

				var_4_106.a = 1
				var_4_105.color = var_4_106
			end

			local var_4_107 = arg_1_1.bgs_.J21f
			local var_4_108 = 15.1666666666667

			if var_4_108 < arg_1_1.time_ and arg_1_1.time_ <= var_4_108 + arg_4_0 then
				local var_4_109 = var_4_107:GetComponent("SpriteRenderer")

				if var_4_109 then
					arg_1_1.var_.alphaOldValueJ21f = var_4_109.color.a
					arg_1_1.var_.alphaMatValueJ21f = var_4_109
				end

				arg_1_1.var_.alphaOldValueJ21f = 0
			end

			local var_4_110 = 6.73333333333333

			if var_4_108 <= arg_1_1.time_ and arg_1_1.time_ < var_4_108 + var_4_110 then
				local var_4_111 = (arg_1_1.time_ - var_4_108) / var_4_110
				local var_4_112 = Mathf.Lerp(arg_1_1.var_.alphaOldValueJ21f, 1, var_4_111)

				if arg_1_1.var_.alphaMatValueJ21f then
					local var_4_113 = arg_1_1.var_.alphaMatValueJ21f.color

					var_4_113.a = var_4_112
					arg_1_1.var_.alphaMatValueJ21f.color = var_4_113
				end
			end

			if arg_1_1.time_ >= var_4_108 + var_4_110 and arg_1_1.time_ < var_4_108 + var_4_110 + arg_4_0 and arg_1_1.var_.alphaMatValueJ21f then
				local var_4_114 = arg_1_1.var_.alphaMatValueJ21f
				local var_4_115 = var_4_114.color

				var_4_115.a = 1
				var_4_114.color = var_4_115
			end

			local var_4_116 = arg_1_1.bgs_.J21f
			local var_4_117 = 32.3666666666667

			if var_4_117 < arg_1_1.time_ and arg_1_1.time_ <= var_4_117 + arg_4_0 then
				local var_4_118 = var_4_116:GetComponent("SpriteRenderer")

				if var_4_118 then
					arg_1_1.var_.alphaOldValueJ21f = var_4_118.color.a
					arg_1_1.var_.alphaMatValueJ21f = var_4_118
				end

				arg_1_1.var_.alphaOldValueJ21f = 1
			end

			local var_4_119 = 6.73333333333333

			if var_4_117 <= arg_1_1.time_ and arg_1_1.time_ < var_4_117 + var_4_119 then
				local var_4_120 = (arg_1_1.time_ - var_4_117) / var_4_119
				local var_4_121 = Mathf.Lerp(arg_1_1.var_.alphaOldValueJ21f, 0, var_4_120)

				if arg_1_1.var_.alphaMatValueJ21f then
					local var_4_122 = arg_1_1.var_.alphaMatValueJ21f.color

					var_4_122.a = var_4_121
					arg_1_1.var_.alphaMatValueJ21f.color = var_4_122
				end
			end

			if arg_1_1.time_ >= var_4_117 + var_4_119 and arg_1_1.time_ < var_4_117 + var_4_119 + arg_4_0 and arg_1_1.var_.alphaMatValueJ21f then
				local var_4_123 = arg_1_1.var_.alphaMatValueJ21f
				local var_4_124 = var_4_123.color

				var_4_124.a = 0
				var_4_123.color = var_4_124
			end

			local var_4_125 = arg_1_1.bgs_.J24f
			local var_4_126 = 0

			if var_4_126 < arg_1_1.time_ and arg_1_1.time_ <= var_4_126 + arg_4_0 then
				local var_4_127 = var_4_125:GetComponent("SpriteRenderer")

				if var_4_127 then
					arg_1_1.var_.alphaOldValueJ24f = var_4_127.color.a
					arg_1_1.var_.alphaMatValueJ24f = var_4_127
				end

				arg_1_1.var_.alphaOldValueJ24f = 1
			end

			local var_4_128 = 0.034

			if var_4_126 <= arg_1_1.time_ and arg_1_1.time_ < var_4_126 + var_4_128 then
				local var_4_129 = (arg_1_1.time_ - var_4_126) / var_4_128
				local var_4_130 = Mathf.Lerp(arg_1_1.var_.alphaOldValueJ24f, 0, var_4_129)

				if arg_1_1.var_.alphaMatValueJ24f then
					local var_4_131 = arg_1_1.var_.alphaMatValueJ24f.color

					var_4_131.a = var_4_130
					arg_1_1.var_.alphaMatValueJ24f.color = var_4_131
				end
			end

			if arg_1_1.time_ >= var_4_126 + var_4_128 and arg_1_1.time_ < var_4_126 + var_4_128 + arg_4_0 and arg_1_1.var_.alphaMatValueJ24f then
				local var_4_132 = arg_1_1.var_.alphaMatValueJ24f
				local var_4_133 = var_4_132.color

				var_4_133.a = 0
				var_4_132.color = var_4_133
			end

			local var_4_134 = arg_1_1.bgs_.J24f.transform
			local var_4_135 = 0.0333333333333333

			if var_4_135 < arg_1_1.time_ and arg_1_1.time_ <= var_4_135 + arg_4_0 then
				arg_1_1.var_.moveOldPosJ24f = var_4_134.localPosition
			end

			local var_4_136 = 0.001

			if var_4_135 <= arg_1_1.time_ and arg_1_1.time_ < var_4_135 + var_4_136 then
				local var_4_137 = (arg_1_1.time_ - var_4_135) / var_4_136
				local var_4_138 = Vector3.New(-1.82, 0.44, 0)

				var_4_134.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosJ24f, var_4_138, var_4_137)
			end

			if arg_1_1.time_ >= var_4_135 + var_4_136 and arg_1_1.time_ < var_4_135 + var_4_136 + arg_4_0 then
				var_4_134.localPosition = Vector3.New(-1.82, 0.44, 0)
			end

			local var_4_139 = 0

			if var_4_139 < arg_1_1.time_ and arg_1_1.time_ <= var_4_139 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_140 = 69.7333333333333

			if arg_1_1.time_ >= var_4_139 + var_4_140 and arg_1_1.time_ < var_4_139 + var_4_140 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_141 = 71.8
			local var_4_142 = 0.225

			if var_4_141 < arg_1_1.time_ and arg_1_1.time_ <= var_4_141 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_143 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_143:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_143:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_143:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_144 = arg_1_1:FormatText(StoryNameCfg[1494].name)

				arg_1_1.leftNameTxt_.text = var_4_144

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_145 = arg_1_1:GetWordFromCfg(324011001)
				local var_4_146 = arg_1_1:FormatText(var_4_145.content)

				arg_1_1.text_.text = var_4_146

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_147 = 9
				local var_4_148 = utf8.len(var_4_146)
				local var_4_149 = var_4_147 <= 0 and var_4_142 or var_4_142 * (var_4_148 / var_4_147)

				if var_4_149 > 0 and var_4_142 < var_4_149 then
					arg_1_1.talkMaxDuration = var_4_149
					var_4_141 = var_4_141 + 0.3

					if var_4_149 + var_4_141 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_149 + var_4_141
					end
				end

				arg_1_1.text_.text = var_4_146
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011001", "story_v_out_324011.awb") ~= 0 then
					local var_4_150 = manager.audio:GetVoiceLength("story_v_out_324011", "324011001", "story_v_out_324011.awb") / 1000

					if var_4_150 + var_4_141 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_150 + var_4_141
					end

					if var_4_145.prefab_name ~= "" and arg_1_1.actors_[var_4_145.prefab_name] ~= nil then
						local var_4_151 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_145.prefab_name].transform, "story_v_out_324011", "324011001", "story_v_out_324011.awb")

						arg_1_1:RecordAudio("324011001", var_4_151)
						arg_1_1:RecordAudio("324011001", var_4_151)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324011", "324011001", "story_v_out_324011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324011", "324011001", "story_v_out_324011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_152 = var_4_141 + 0.3
			local var_4_153 = math.max(var_4_142, arg_1_1.talkMaxDuration)

			if var_4_152 <= arg_1_1.time_ and arg_1_1.time_ < var_4_152 + var_4_153 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_152) / var_4_153

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_152 + var_4_153 and arg_1_1.time_ < var_4_152 + var_4_153 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = false,
				enableEffect = true,
				className = "StoryTextGroupNode",
				contentID = 324011064,
				charCount = 37,
				enableLayoutChange = true,
				duration = 4.625,
				groupID = "1",
				startTime = 2.55491181369871,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 270,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 245,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 0.893,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = false,
				enableEffect = true,
				className = "StoryTextGroupNode",
				contentID = 324011065,
				charCount = 36,
				enableLayoutChange = true,
				duration = 4.5,
				groupID = "2",
				startTime = 20.8333333333333,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 270,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 815,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 0.988,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = false,
				enableEffect = true,
				className = "StoryTextGroupNode",
				contentID = 324011066,
				charCount = 34,
				enableLayoutChange = true,
				duration = 4.25,
				groupID = "3",
				startTime = 38.2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 270,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 1362,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.UpperLeft
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 0.893,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			},
			{
				groupID = "",
				duration = 0.43333333333333,
				className = "StoryTextGroupNode",
				startTime = 68.6,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_ALL_TEXT_GROUP
			},
			{
				assetPath = "",
				actorName = "M01i",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "J21f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "J24f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play324011002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 324011002
		arg_9_1.duration_ = 2.07

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 2.066
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play324011003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1070ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1070ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_9_1.stage_.transform)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

					var_12_3.enabled = true

					local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

					if var_12_4 then
						var_12_4:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_3.transform, false)

					arg_9_1.var_[var_12_0 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_0 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_0 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_5 = arg_9_1.actors_["1070ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1070ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0, -0.95, -6.05)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1070ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1070ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1070ui_story == nil then
				arg_9_1.var_.characterEffect1070ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1070ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1070ui_story then
				arg_9_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_12_20 = 0
			local var_12_21 = 0.225

			if var_12_20 < arg_9_1.time_ and arg_9_1.time_ <= var_12_20 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_22 = arg_9_1:FormatText(StoryNameCfg[318].name)

				arg_9_1.leftNameTxt_.text = var_12_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:GetWordFromCfg(324011002)
				local var_12_24 = arg_9_1:FormatText(var_12_23.content)

				arg_9_1.text_.text = var_12_24

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 9
				local var_12_26 = utf8.len(var_12_24)
				local var_12_27 = var_12_25 <= 0 and var_12_21 or var_12_21 * (var_12_26 / var_12_25)

				if var_12_27 > 0 and var_12_21 < var_12_27 then
					arg_9_1.talkMaxDuration = var_12_27

					if var_12_27 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_27 + var_12_20
					end
				end

				arg_9_1.text_.text = var_12_24
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011002", "story_v_out_324011.awb") ~= 0 then
					local var_12_28 = manager.audio:GetVoiceLength("story_v_out_324011", "324011002", "story_v_out_324011.awb") / 1000

					if var_12_28 + var_12_20 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_20
					end

					if var_12_23.prefab_name ~= "" and arg_9_1.actors_[var_12_23.prefab_name] ~= nil then
						local var_12_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_23.prefab_name].transform, "story_v_out_324011", "324011002", "story_v_out_324011.awb")

						arg_9_1:RecordAudio("324011002", var_12_29)
						arg_9_1:RecordAudio("324011002", var_12_29)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_324011", "324011002", "story_v_out_324011.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_324011", "324011002", "story_v_out_324011.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_30 = math.max(var_12_21, arg_9_1.talkMaxDuration)

			if var_12_20 <= arg_9_1.time_ and arg_9_1.time_ < var_12_20 + var_12_30 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_20) / var_12_30

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_20 + var_12_30 and arg_9_1.time_ < var_12_20 + var_12_30 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play324011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 324011003
		arg_13_1.duration_ = 3.03

		local var_13_0 = {
			zh = 3.033,
			ja = 2.1
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
				arg_13_0:Play324011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1070ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1070ui_story == nil then
				arg_13_1.var_.characterEffect1070ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1070ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1070ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1070ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1070ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 0.325

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_8 = arg_13_1:FormatText(StoryNameCfg[1495].name)

				arg_13_1.leftNameTxt_.text = var_16_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_9 = arg_13_1:GetWordFromCfg(324011003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 13
				local var_16_12 = utf8.len(var_16_10)
				local var_16_13 = var_16_11 <= 0 and var_16_7 or var_16_7 * (var_16_12 / var_16_11)

				if var_16_13 > 0 and var_16_7 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011003", "story_v_out_324011.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_324011", "324011003", "story_v_out_324011.awb") / 1000

					if var_16_14 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_6
					end

					if var_16_9.prefab_name ~= "" and arg_13_1.actors_[var_16_9.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_9.prefab_name].transform, "story_v_out_324011", "324011003", "story_v_out_324011.awb")

						arg_13_1:RecordAudio("324011003", var_16_15)
						arg_13_1:RecordAudio("324011003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_324011", "324011003", "story_v_out_324011.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_324011", "324011003", "story_v_out_324011.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_16 and arg_13_1.time_ < var_16_6 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play324011004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 324011004
		arg_17_1.duration_ = 4.27

		local var_17_0 = {
			zh = 4.266,
			ja = 3.6
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
				arg_17_0:Play324011005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1070ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1070ui_story == nil then
				arg_17_1.var_.characterEffect1070ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect1070ui_story and not isNil(var_20_0) then
					arg_17_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1070ui_story then
				arg_17_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_20_4 = 0

			if var_20_4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_2")
			end

			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_20_6 = 0
			local var_20_7 = 0.4

			if var_20_6 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_8 = arg_17_1:FormatText(StoryNameCfg[318].name)

				arg_17_1.leftNameTxt_.text = var_20_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_9 = arg_17_1:GetWordFromCfg(324011004)
				local var_20_10 = arg_17_1:FormatText(var_20_9.content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_11 = 16
				local var_20_12 = utf8.len(var_20_10)
				local var_20_13 = var_20_11 <= 0 and var_20_7 or var_20_7 * (var_20_12 / var_20_11)

				if var_20_13 > 0 and var_20_7 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_10
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011004", "story_v_out_324011.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_324011", "324011004", "story_v_out_324011.awb") / 1000

					if var_20_14 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_6
					end

					if var_20_9.prefab_name ~= "" and arg_17_1.actors_[var_20_9.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_9.prefab_name].transform, "story_v_out_324011", "324011004", "story_v_out_324011.awb")

						arg_17_1:RecordAudio("324011004", var_20_15)
						arg_17_1:RecordAudio("324011004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_324011", "324011004", "story_v_out_324011.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_324011", "324011004", "story_v_out_324011.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_16 and arg_17_1.time_ < var_20_6 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play324011005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 324011005
		arg_21_1.duration_ = 3.43

		local var_21_0 = {
			zh = 3.333,
			ja = 3.433
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
				arg_21_0:Play324011006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1070ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1070ui_story == nil then
				arg_21_1.var_.characterEffect1070ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1070ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1070ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1070ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1070ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.375

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[1496].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_9 = arg_21_1:GetWordFromCfg(324011005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011005", "story_v_out_324011.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_324011", "324011005", "story_v_out_324011.awb") / 1000

					if var_24_14 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_6
					end

					if var_24_9.prefab_name ~= "" and arg_21_1.actors_[var_24_9.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_9.prefab_name].transform, "story_v_out_324011", "324011005", "story_v_out_324011.awb")

						arg_21_1:RecordAudio("324011005", var_24_15)
						arg_21_1:RecordAudio("324011005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_324011", "324011005", "story_v_out_324011.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_324011", "324011005", "story_v_out_324011.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_16 and arg_21_1.time_ < var_24_6 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play324011006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 324011006
		arg_25_1.duration_ = 11.1

		local var_25_0 = {
			zh = 7.866,
			ja = 11.1
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
				arg_25_0:Play324011007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1070ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1070ui_story == nil then
				arg_25_1.var_.characterEffect1070ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1070ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1070ui_story then
				arg_25_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_28_6 = 0
			local var_28_7 = 1.05

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[318].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(324011006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 42
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_7 or var_28_7 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_7 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011006", "story_v_out_324011.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_324011", "324011006", "story_v_out_324011.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_out_324011", "324011006", "story_v_out_324011.awb")

						arg_25_1:RecordAudio("324011006", var_28_15)
						arg_25_1:RecordAudio("324011006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_324011", "324011006", "story_v_out_324011.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_324011", "324011006", "story_v_out_324011.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_16 and arg_25_1.time_ < var_28_6 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play324011007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 324011007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play324011008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1070ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1070ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, 100, 0)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1070ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, 100, 0)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["1070ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1070ui_story == nil then
				arg_29_1.var_.characterEffect1070ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect1070ui_story and not isNil(var_32_9) then
					local var_32_13 = Mathf.Lerp(0, 0.5, var_32_12)

					arg_29_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1070ui_story.fillRatio = var_32_13
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1070ui_story then
				local var_32_14 = 0.5

				arg_29_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1070ui_story.fillRatio = var_32_14
			end

			local var_32_15 = 0
			local var_32_16 = 0.5

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_17 = arg_29_1:GetWordFromCfg(324011007)
				local var_32_18 = arg_29_1:FormatText(var_32_17.content)

				arg_29_1.text_.text = var_32_18

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_19 = 20
				local var_32_20 = utf8.len(var_32_18)
				local var_32_21 = var_32_19 <= 0 and var_32_16 or var_32_16 * (var_32_20 / var_32_19)

				if var_32_21 > 0 and var_32_16 < var_32_21 then
					arg_29_1.talkMaxDuration = var_32_21

					if var_32_21 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_21 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_18
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_22 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_22 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_22

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_22 and arg_29_1.time_ < var_32_15 + var_32_22 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play324011008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 324011008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play324011009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.65

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(324011008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 66
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play324011009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 324011009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play324011010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 1.3

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(324011009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 52
				local var_40_5 = utf8.len(var_40_3)
				local var_40_6 = var_40_4 <= 0 and var_40_1 or var_40_1 * (var_40_5 / var_40_4)

				if var_40_6 > 0 and var_40_1 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_7 and arg_37_1.time_ < var_40_0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play324011010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 324011010
		arg_41_1.duration_ = 3.63

		local var_41_0 = {
			zh = 3.1,
			ja = 3.633
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
				arg_41_0:Play324011011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.375

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_2 = arg_41_1:FormatText(StoryNameCfg[1494].name)

				arg_41_1.leftNameTxt_.text = var_44_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(324011010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011010", "story_v_out_324011.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_324011", "324011010", "story_v_out_324011.awb") / 1000

					if var_44_8 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_out_324011", "324011010", "story_v_out_324011.awb")

						arg_41_1:RecordAudio("324011010", var_44_9)
						arg_41_1:RecordAudio("324011010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_324011", "324011010", "story_v_out_324011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_324011", "324011010", "story_v_out_324011.awb")
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
	Play324011011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 324011011
		arg_45_1.duration_ = 4.4

		local var_45_0 = {
			zh = 2.466,
			ja = 4.4
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
				arg_45_0:Play324011012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1070ui_story"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1070ui_story = var_48_0.localPosition
			end

			local var_48_2 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2
				local var_48_4 = Vector3.New(0, -0.95, -6.05)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1070ui_story, var_48_4, var_48_3)

				local var_48_5 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_5.x, var_48_5.y, var_48_5.z)

				local var_48_6 = var_48_0.localEulerAngles

				var_48_6.z = 0
				var_48_6.x = 0
				var_48_0.localEulerAngles = var_48_6
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_48_7 = manager.ui.mainCamera.transform.position - var_48_0.position

				var_48_0.forward = Vector3.New(var_48_7.x, var_48_7.y, var_48_7.z)

				local var_48_8 = var_48_0.localEulerAngles

				var_48_8.z = 0
				var_48_8.x = 0
				var_48_0.localEulerAngles = var_48_8
			end

			local var_48_9 = arg_45_1.actors_["1070ui_story"]
			local var_48_10 = 0

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1070ui_story == nil then
				arg_45_1.var_.characterEffect1070ui_story = var_48_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_11 = 0.200000002980232

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_11 and not isNil(var_48_9) then
				local var_48_12 = (arg_45_1.time_ - var_48_10) / var_48_11

				if arg_45_1.var_.characterEffect1070ui_story and not isNil(var_48_9) then
					arg_45_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_10 + var_48_11 and arg_45_1.time_ < var_48_10 + var_48_11 + arg_48_0 and not isNil(var_48_9) and arg_45_1.var_.characterEffect1070ui_story then
				arg_45_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_48_13 = 0

			if var_48_13 < arg_45_1.time_ and arg_45_1.time_ <= var_48_13 + arg_48_0 then
				arg_45_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_48_14 = 0

			if var_48_14 < arg_45_1.time_ and arg_45_1.time_ <= var_48_14 + arg_48_0 then
				arg_45_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_48_15 = 0
			local var_48_16 = 0.325

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_17 = arg_45_1:FormatText(StoryNameCfg[318].name)

				arg_45_1.leftNameTxt_.text = var_48_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_18 = arg_45_1:GetWordFromCfg(324011011)
				local var_48_19 = arg_45_1:FormatText(var_48_18.content)

				arg_45_1.text_.text = var_48_19

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_20 = 13
				local var_48_21 = utf8.len(var_48_19)
				local var_48_22 = var_48_20 <= 0 and var_48_16 or var_48_16 * (var_48_21 / var_48_20)

				if var_48_22 > 0 and var_48_16 < var_48_22 then
					arg_45_1.talkMaxDuration = var_48_22

					if var_48_22 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_22 + var_48_15
					end
				end

				arg_45_1.text_.text = var_48_19
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011011", "story_v_out_324011.awb") ~= 0 then
					local var_48_23 = manager.audio:GetVoiceLength("story_v_out_324011", "324011011", "story_v_out_324011.awb") / 1000

					if var_48_23 + var_48_15 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_23 + var_48_15
					end

					if var_48_18.prefab_name ~= "" and arg_45_1.actors_[var_48_18.prefab_name] ~= nil then
						local var_48_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_18.prefab_name].transform, "story_v_out_324011", "324011011", "story_v_out_324011.awb")

						arg_45_1:RecordAudio("324011011", var_48_24)
						arg_45_1:RecordAudio("324011011", var_48_24)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_324011", "324011011", "story_v_out_324011.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_324011", "324011011", "story_v_out_324011.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_25 = math.max(var_48_16, arg_45_1.talkMaxDuration)

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_25 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_15) / var_48_25

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_15 + var_48_25 and arg_45_1.time_ < var_48_15 + var_48_25 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play324011012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 324011012
		arg_49_1.duration_ = 8

		local var_49_0 = {
			zh = 7.6,
			ja = 8
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
				arg_49_0:Play324011013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1070ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1070ui_story == nil then
				arg_49_1.var_.characterEffect1070ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1070ui_story and not isNil(var_52_0) then
					local var_52_4 = Mathf.Lerp(0, 0.5, var_52_3)

					arg_49_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1070ui_story.fillRatio = var_52_4
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1070ui_story then
				local var_52_5 = 0.5

				arg_49_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1070ui_story.fillRatio = var_52_5
			end

			local var_52_6 = 0
			local var_52_7 = 0.8

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[1495].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:GetWordFromCfg(324011012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 32
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011012", "story_v_out_324011.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_324011", "324011012", "story_v_out_324011.awb") / 1000

					if var_52_14 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_6
					end

					if var_52_9.prefab_name ~= "" and arg_49_1.actors_[var_52_9.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_9.prefab_name].transform, "story_v_out_324011", "324011012", "story_v_out_324011.awb")

						arg_49_1:RecordAudio("324011012", var_52_15)
						arg_49_1:RecordAudio("324011012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_324011", "324011012", "story_v_out_324011.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_324011", "324011012", "story_v_out_324011.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_16 and arg_49_1.time_ < var_52_6 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play324011013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 324011013
		arg_53_1.duration_ = 5.2

		local var_53_0 = {
			zh = 5.2,
			ja = 4.533
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play324011014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.425

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1495].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(324011013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 17
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011013", "story_v_out_324011.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_324011", "324011013", "story_v_out_324011.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_324011", "324011013", "story_v_out_324011.awb")

						arg_53_1:RecordAudio("324011013", var_56_9)
						arg_53_1:RecordAudio("324011013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_324011", "324011013", "story_v_out_324011.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_324011", "324011013", "story_v_out_324011.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play324011014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 324011014
		arg_57_1.duration_ = 8.07

		local var_57_0 = {
			zh = 6.133,
			ja = 8.066
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play324011015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.725

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[1496].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(324011014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 29
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011014", "story_v_out_324011.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_324011", "324011014", "story_v_out_324011.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_324011", "324011014", "story_v_out_324011.awb")

						arg_57_1:RecordAudio("324011014", var_60_9)
						arg_57_1:RecordAudio("324011014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_324011", "324011014", "story_v_out_324011.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_324011", "324011014", "story_v_out_324011.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play324011015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 324011015
		arg_61_1.duration_ = 10.17

		local var_61_0 = {
			zh = 6.866,
			ja = 10.166
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
				arg_61_0:Play324011016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1070ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1070ui_story == nil then
				arg_61_1.var_.characterEffect1070ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1070ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1070ui_story then
				arg_61_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_64_6 = 0
			local var_64_7 = 0.8

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[318].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_9 = arg_61_1:GetWordFromCfg(324011015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 32
				local var_64_12 = utf8.len(var_64_10)
				local var_64_13 = var_64_11 <= 0 and var_64_7 or var_64_7 * (var_64_12 / var_64_11)

				if var_64_13 > 0 and var_64_7 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011015", "story_v_out_324011.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_324011", "324011015", "story_v_out_324011.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_out_324011", "324011015", "story_v_out_324011.awb")

						arg_61_1:RecordAudio("324011015", var_64_15)
						arg_61_1:RecordAudio("324011015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_324011", "324011015", "story_v_out_324011.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_324011", "324011015", "story_v_out_324011.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_16 and arg_61_1.time_ < var_64_6 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play324011016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 324011016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play324011017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1070ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1070ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0, 100, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1070ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, 100, 0)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1070ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1070ui_story == nil then
				arg_65_1.var_.characterEffect1070ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1070ui_story and not isNil(var_68_9) then
					local var_68_13 = Mathf.Lerp(0, 0.5, var_68_12)

					arg_65_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1070ui_story.fillRatio = var_68_13
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1070ui_story then
				local var_68_14 = 0.5

				arg_65_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1070ui_story.fillRatio = var_68_14
			end

			local var_68_15 = 0
			local var_68_16 = 0.8

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_17 = arg_65_1:GetWordFromCfg(324011016)
				local var_68_18 = arg_65_1:FormatText(var_68_17.content)

				arg_65_1.text_.text = var_68_18

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_19 = 32
				local var_68_20 = utf8.len(var_68_18)
				local var_68_21 = var_68_19 <= 0 and var_68_16 or var_68_16 * (var_68_20 / var_68_19)

				if var_68_21 > 0 and var_68_16 < var_68_21 then
					arg_65_1.talkMaxDuration = var_68_21

					if var_68_21 + var_68_15 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_21 + var_68_15
					end
				end

				arg_65_1.text_.text = var_68_18
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_22 = math.max(var_68_16, arg_65_1.talkMaxDuration)

			if var_68_15 <= arg_65_1.time_ and arg_65_1.time_ < var_68_15 + var_68_22 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_15) / var_68_22

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_15 + var_68_22 and arg_65_1.time_ < var_68_15 + var_68_22 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play324011017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 324011017
		arg_69_1.duration_ = 7.57

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play324011018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = "ST2003"

			if arg_69_1.bgs_[var_72_0] == nil then
				local var_72_1 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_0)
				var_72_1.name = var_72_0
				var_72_1.transform.parent = arg_69_1.stage_.transform
				var_72_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_0] = var_72_1
			end

			local var_72_2 = 1.43333333333333

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				local var_72_3 = manager.ui.mainCamera.transform.localPosition
				local var_72_4 = Vector3.New(0, 0, 10) + Vector3.New(var_72_3.x, var_72_3.y, 0)
				local var_72_5 = arg_69_1.bgs_.ST2003

				var_72_5.transform.localPosition = var_72_4
				var_72_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_6 = var_72_5:GetComponent("SpriteRenderer")

				if var_72_6 and var_72_6.sprite then
					local var_72_7 = (var_72_5.transform.localPosition - var_72_3).z
					local var_72_8 = manager.ui.mainCameraCom_
					local var_72_9 = 2 * var_72_7 * Mathf.Tan(var_72_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_72_10 = var_72_9 * var_72_8.aspect
					local var_72_11 = var_72_6.sprite.bounds.size.x
					local var_72_12 = var_72_6.sprite.bounds.size.y
					local var_72_13 = var_72_10 / var_72_11
					local var_72_14 = var_72_9 / var_72_12
					local var_72_15 = var_72_14 < var_72_13 and var_72_13 or var_72_14

					var_72_5.transform.localScale = Vector3.New(var_72_15, var_72_15, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "ST2003" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			local var_72_17 = 0.3

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_18 = 0

			if var_72_18 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_19 = 1.43333333333333

			if var_72_18 <= arg_69_1.time_ and arg_69_1.time_ < var_72_18 + var_72_19 then
				local var_72_20 = (arg_69_1.time_ - var_72_18) / var_72_19
				local var_72_21 = Color.New(0, 0, 0)

				var_72_21.a = Mathf.Lerp(0, 1, var_72_20)
				arg_69_1.mask_.color = var_72_21
			end

			if arg_69_1.time_ >= var_72_18 + var_72_19 and arg_69_1.time_ < var_72_18 + var_72_19 + arg_72_0 then
				local var_72_22 = Color.New(0, 0, 0)

				var_72_22.a = 1
				arg_69_1.mask_.color = var_72_22
			end

			local var_72_23 = 1.43333333333333

			if var_72_23 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_24 = 2

			if var_72_23 <= arg_69_1.time_ and arg_69_1.time_ < var_72_23 + var_72_24 then
				local var_72_25 = (arg_69_1.time_ - var_72_23) / var_72_24
				local var_72_26 = Color.New(0, 0, 0)

				var_72_26.a = Mathf.Lerp(1, 0, var_72_25)
				arg_69_1.mask_.color = var_72_26
			end

			if arg_69_1.time_ >= var_72_23 + var_72_24 and arg_69_1.time_ < var_72_23 + var_72_24 + arg_72_0 then
				local var_72_27 = Color.New(0, 0, 0)
				local var_72_28 = 0

				arg_69_1.mask_.enabled = false
				var_72_27.a = var_72_28
				arg_69_1.mask_.color = var_72_27
			end

			local var_72_29 = 1.2
			local var_72_30 = 1

			if var_72_29 < arg_69_1.time_ and arg_69_1.time_ <= var_72_29 + arg_72_0 then
				local var_72_31 = "play"
				local var_72_32 = "effect"

				arg_69_1:AudioAction(var_72_31, var_72_32, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_72_33 = 0.1
			local var_72_34 = 1

			if var_72_33 < arg_69_1.time_ and arg_69_1.time_ <= var_72_33 + arg_72_0 then
				local var_72_35 = "stop"
				local var_72_36 = "effect"

				arg_69_1:AudioAction(var_72_35, var_72_36, "se_story_143", "se_story_143_amb_bar", "")
			end

			local var_72_37 = 0
			local var_72_38 = 1

			if var_72_37 < arg_69_1.time_ and arg_69_1.time_ <= var_72_37 + arg_72_0 then
				local var_72_39 = "play"
				local var_72_40 = "effect"

				arg_69_1:AudioAction(var_72_39, var_72_40, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_72_41 = 1
			local var_72_42 = 1

			if var_72_41 < arg_69_1.time_ and arg_69_1.time_ <= var_72_41 + arg_72_0 then
				local var_72_43 = "play"
				local var_72_44 = "music"

				arg_69_1:AudioAction(var_72_43, var_72_44, "bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong.awb")

				local var_72_45 = ""
				local var_72_46 = manager.audio:GetAudioName("bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong")

				if var_72_46 ~= "" then
					if arg_69_1.bgmTxt_.text ~= var_72_46 and arg_69_1.bgmTxt_.text ~= "" then
						if arg_69_1.bgmTxt2_.text ~= "" then
							arg_69_1.bgmTxt_.text = arg_69_1.bgmTxt2_.text
						end

						arg_69_1.bgmTxt2_.text = var_72_46

						arg_69_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_69_1.bgmTxt_.text = var_72_46
						arg_69_1.bgmTxt2_.text = var_72_46
					end

					if arg_69_1.bgmTimer then
						arg_69_1.bgmTimer:Stop()

						arg_69_1.bgmTimer = nil
					end

					if arg_69_1.settingData.show_music_name == 1 then
						arg_69_1.musicController:SetSelectedState("show")
						arg_69_1.musicAnimator_:Play("open", 0, 0)

						if arg_69_1.settingData.music_time ~= 0 then
							arg_69_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_69_1.settingData.music_time), function()
								if arg_69_1 == nil or isNil(arg_69_1.bgmTxt_) then
									return
								end

								arg_69_1.musicController:SetSelectedState("hide")
								arg_69_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_47 = 2.56666666666667
			local var_72_48 = 1.375

			if var_72_47 < arg_69_1.time_ and arg_69_1.time_ <= var_72_47 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_49 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_49:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_69_1.dialogCg_.alpha = arg_74_0
				end))
				var_72_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_50 = arg_69_1:GetWordFromCfg(324011017)
				local var_72_51 = arg_69_1:FormatText(var_72_50.content)

				arg_69_1.text_.text = var_72_51

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_52 = 55
				local var_72_53 = utf8.len(var_72_51)
				local var_72_54 = var_72_52 <= 0 and var_72_48 or var_72_48 * (var_72_53 / var_72_52)

				if var_72_54 > 0 and var_72_48 < var_72_54 then
					arg_69_1.talkMaxDuration = var_72_54
					var_72_47 = var_72_47 + 0.3

					if var_72_54 + var_72_47 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_54 + var_72_47
					end
				end

				arg_69_1.text_.text = var_72_51
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_55 = var_72_47 + 0.3
			local var_72_56 = math.max(var_72_48, arg_69_1.talkMaxDuration)

			if var_72_55 <= arg_69_1.time_ and arg_69_1.time_ < var_72_55 + var_72_56 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_55) / var_72_56

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_55 + var_72_56 and arg_69_1.time_ < var_72_55 + var_72_56 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play324011018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324011018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play324011019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 1.45

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_2 = arg_76_1:GetWordFromCfg(324011018)
				local var_79_3 = arg_76_1:FormatText(var_79_2.content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 58
				local var_79_5 = utf8.len(var_79_3)
				local var_79_6 = var_79_4 <= 0 and var_79_1 or var_79_1 * (var_79_5 / var_79_4)

				if var_79_6 > 0 and var_79_1 < var_79_6 then
					arg_76_1.talkMaxDuration = var_79_6

					if var_79_6 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_7 and arg_76_1.time_ < var_79_0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play324011019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324011019
		arg_80_1.duration_ = 3.17

		local var_80_0 = {
			zh = 2.966,
			ja = 3.166
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
				arg_80_0:Play324011020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1070ui_story"].transform
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.var_.moveOldPos1070ui_story = var_83_0.localPosition
			end

			local var_83_2 = 0.001

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2
				local var_83_4 = Vector3.New(0, -0.95, -6.05)

				var_83_0.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1070ui_story, var_83_4, var_83_3)

				local var_83_5 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_5.x, var_83_5.y, var_83_5.z)

				local var_83_6 = var_83_0.localEulerAngles

				var_83_6.z = 0
				var_83_6.x = 0
				var_83_0.localEulerAngles = var_83_6
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 then
				var_83_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_83_7 = manager.ui.mainCamera.transform.position - var_83_0.position

				var_83_0.forward = Vector3.New(var_83_7.x, var_83_7.y, var_83_7.z)

				local var_83_8 = var_83_0.localEulerAngles

				var_83_8.z = 0
				var_83_8.x = 0
				var_83_0.localEulerAngles = var_83_8
			end

			local var_83_9 = arg_80_1.actors_["1070ui_story"]
			local var_83_10 = 0

			if var_83_10 < arg_80_1.time_ and arg_80_1.time_ <= var_83_10 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1070ui_story == nil then
				arg_80_1.var_.characterEffect1070ui_story = var_83_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_11 = 0.200000002980232

			if var_83_10 <= arg_80_1.time_ and arg_80_1.time_ < var_83_10 + var_83_11 and not isNil(var_83_9) then
				local var_83_12 = (arg_80_1.time_ - var_83_10) / var_83_11

				if arg_80_1.var_.characterEffect1070ui_story and not isNil(var_83_9) then
					arg_80_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_10 + var_83_11 and arg_80_1.time_ < var_83_10 + var_83_11 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1070ui_story then
				arg_80_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_83_13 = 0

			if var_83_13 < arg_80_1.time_ and arg_80_1.time_ <= var_83_13 + arg_83_0 then
				arg_80_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_83_14 = 0

			if var_83_14 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_83_15 = 0
			local var_83_16 = 0.15

			if var_83_15 < arg_80_1.time_ and arg_80_1.time_ <= var_83_15 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_17 = arg_80_1:FormatText(StoryNameCfg[318].name)

				arg_80_1.leftNameTxt_.text = var_83_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_18 = arg_80_1:GetWordFromCfg(324011019)
				local var_83_19 = arg_80_1:FormatText(var_83_18.content)

				arg_80_1.text_.text = var_83_19

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_20 = 6
				local var_83_21 = utf8.len(var_83_19)
				local var_83_22 = var_83_20 <= 0 and var_83_16 or var_83_16 * (var_83_21 / var_83_20)

				if var_83_22 > 0 and var_83_16 < var_83_22 then
					arg_80_1.talkMaxDuration = var_83_22

					if var_83_22 + var_83_15 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_22 + var_83_15
					end
				end

				arg_80_1.text_.text = var_83_19
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011019", "story_v_out_324011.awb") ~= 0 then
					local var_83_23 = manager.audio:GetVoiceLength("story_v_out_324011", "324011019", "story_v_out_324011.awb") / 1000

					if var_83_23 + var_83_15 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_23 + var_83_15
					end

					if var_83_18.prefab_name ~= "" and arg_80_1.actors_[var_83_18.prefab_name] ~= nil then
						local var_83_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_18.prefab_name].transform, "story_v_out_324011", "324011019", "story_v_out_324011.awb")

						arg_80_1:RecordAudio("324011019", var_83_24)
						arg_80_1:RecordAudio("324011019", var_83_24)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_324011", "324011019", "story_v_out_324011.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_324011", "324011019", "story_v_out_324011.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_25 = math.max(var_83_16, arg_80_1.talkMaxDuration)

			if var_83_15 <= arg_80_1.time_ and arg_80_1.time_ < var_83_15 + var_83_25 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_15) / var_83_25

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_15 + var_83_25 and arg_80_1.time_ < var_83_15 + var_83_25 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play324011020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324011020
		arg_84_1.duration_ = 3.13

		local var_84_0 = {
			zh = 3.033,
			ja = 3.133
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
				arg_84_0:Play324011021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_87_1 = 0
			local var_87_2 = 0.275

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_3 = arg_84_1:FormatText(StoryNameCfg[318].name)

				arg_84_1.leftNameTxt_.text = var_87_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:GetWordFromCfg(324011020)
				local var_87_5 = arg_84_1:FormatText(var_87_4.content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_6 = 11
				local var_87_7 = utf8.len(var_87_5)
				local var_87_8 = var_87_6 <= 0 and var_87_2 or var_87_2 * (var_87_7 / var_87_6)

				if var_87_8 > 0 and var_87_2 < var_87_8 then
					arg_84_1.talkMaxDuration = var_87_8

					if var_87_8 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_8 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011020", "story_v_out_324011.awb") ~= 0 then
					local var_87_9 = manager.audio:GetVoiceLength("story_v_out_324011", "324011020", "story_v_out_324011.awb") / 1000

					if var_87_9 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_1
					end

					if var_87_4.prefab_name ~= "" and arg_84_1.actors_[var_87_4.prefab_name] ~= nil then
						local var_87_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_4.prefab_name].transform, "story_v_out_324011", "324011020", "story_v_out_324011.awb")

						arg_84_1:RecordAudio("324011020", var_87_10)
						arg_84_1:RecordAudio("324011020", var_87_10)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_324011", "324011020", "story_v_out_324011.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_324011", "324011020", "story_v_out_324011.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_11 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_11 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_11

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_11 and arg_84_1.time_ < var_87_1 + var_87_11 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play324011021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 324011021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play324011022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1070ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1070ui_story = var_91_0.localPosition
			end

			local var_91_2 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2
				local var_91_4 = Vector3.New(0, 100, 0)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1070ui_story, var_91_4, var_91_3)

				local var_91_5 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_5.x, var_91_5.y, var_91_5.z)

				local var_91_6 = var_91_0.localEulerAngles

				var_91_6.z = 0
				var_91_6.x = 0
				var_91_0.localEulerAngles = var_91_6
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, 100, 0)

				local var_91_7 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_7.x, var_91_7.y, var_91_7.z)

				local var_91_8 = var_91_0.localEulerAngles

				var_91_8.z = 0
				var_91_8.x = 0
				var_91_0.localEulerAngles = var_91_8
			end

			local var_91_9 = arg_88_1.actors_["1070ui_story"]
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1070ui_story == nil then
				arg_88_1.var_.characterEffect1070ui_story = var_91_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_11 = 0.200000002980232

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 and not isNil(var_91_9) then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11

				if arg_88_1.var_.characterEffect1070ui_story and not isNil(var_91_9) then
					local var_91_13 = Mathf.Lerp(0, 0.5, var_91_12)

					arg_88_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1070ui_story.fillRatio = var_91_13
				end
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1070ui_story then
				local var_91_14 = 0.5

				arg_88_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1070ui_story.fillRatio = var_91_14
			end

			local var_91_15 = 0.1
			local var_91_16 = 1

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				local var_91_17 = "play"
				local var_91_18 = "effect"

				arg_88_1:AudioAction(var_91_17, var_91_18, "se_story_150", "se_story_150_sword13", "")
			end

			local var_91_19 = 0.1
			local var_91_20 = 1

			if var_91_19 < arg_88_1.time_ and arg_88_1.time_ <= var_91_19 + arg_91_0 then
				local var_91_21 = "stop"
				local var_91_22 = "effect"

				arg_88_1:AudioAction(var_91_21, var_91_22, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_91_23 = 0
			local var_91_24 = 1.325

			if var_91_23 < arg_88_1.time_ and arg_88_1.time_ <= var_91_23 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_25 = arg_88_1:GetWordFromCfg(324011021)
				local var_91_26 = arg_88_1:FormatText(var_91_25.content)

				arg_88_1.text_.text = var_91_26

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_27 = 53
				local var_91_28 = utf8.len(var_91_26)
				local var_91_29 = var_91_27 <= 0 and var_91_24 or var_91_24 * (var_91_28 / var_91_27)

				if var_91_29 > 0 and var_91_24 < var_91_29 then
					arg_88_1.talkMaxDuration = var_91_29

					if var_91_29 + var_91_23 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_29 + var_91_23
					end
				end

				arg_88_1.text_.text = var_91_26
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_30 = math.max(var_91_24, arg_88_1.talkMaxDuration)

			if var_91_23 <= arg_88_1.time_ and arg_88_1.time_ < var_91_23 + var_91_30 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_23) / var_91_30

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_23 + var_91_30 and arg_88_1.time_ < var_91_23 + var_91_30 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play324011022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 324011022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play324011023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 0.725

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_2 = arg_92_1:GetWordFromCfg(324011022)
				local var_95_3 = arg_92_1:FormatText(var_95_2.content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 29
				local var_95_5 = utf8.len(var_95_3)
				local var_95_6 = var_95_4 <= 0 and var_95_1 or var_95_1 * (var_95_5 / var_95_4)

				if var_95_6 > 0 and var_95_1 < var_95_6 then
					arg_92_1.talkMaxDuration = var_95_6

					if var_95_6 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_7 and arg_92_1.time_ < var_95_0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play324011023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 324011023
		arg_96_1.duration_ = 5.3

		local var_96_0 = {
			zh = 5.3,
			ja = 5
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
				arg_96_0:Play324011024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1070ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1070ui_story = var_99_0.localPosition
			end

			local var_99_2 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2
				local var_99_4 = Vector3.New(0, -0.95, -6.05)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1070ui_story, var_99_4, var_99_3)

				local var_99_5 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_5.x, var_99_5.y, var_99_5.z)

				local var_99_6 = var_99_0.localEulerAngles

				var_99_6.z = 0
				var_99_6.x = 0
				var_99_0.localEulerAngles = var_99_6
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_99_7 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_7.x, var_99_7.y, var_99_7.z)

				local var_99_8 = var_99_0.localEulerAngles

				var_99_8.z = 0
				var_99_8.x = 0
				var_99_0.localEulerAngles = var_99_8
			end

			local var_99_9 = arg_96_1.actors_["1070ui_story"]
			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1070ui_story == nil then
				arg_96_1.var_.characterEffect1070ui_story = var_99_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_11 = 0.200000002980232

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_11 and not isNil(var_99_9) then
				local var_99_12 = (arg_96_1.time_ - var_99_10) / var_99_11

				if arg_96_1.var_.characterEffect1070ui_story and not isNil(var_99_9) then
					arg_96_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_10 + var_99_11 and arg_96_1.time_ < var_99_10 + var_99_11 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1070ui_story then
				arg_96_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_99_13 = 0

			if var_99_13 < arg_96_1.time_ and arg_96_1.time_ <= var_99_13 + arg_99_0 then
				arg_96_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_99_14 = 0

			if var_99_14 < arg_96_1.time_ and arg_96_1.time_ <= var_99_14 + arg_99_0 then
				arg_96_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_99_15 = 0
			local var_99_16 = 0.325

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_17 = arg_96_1:FormatText(StoryNameCfg[318].name)

				arg_96_1.leftNameTxt_.text = var_99_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(324011023)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_20 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011023", "story_v_out_324011.awb") ~= 0 then
					local var_99_23 = manager.audio:GetVoiceLength("story_v_out_324011", "324011023", "story_v_out_324011.awb") / 1000

					if var_99_23 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_15
					end

					if var_99_18.prefab_name ~= "" and arg_96_1.actors_[var_99_18.prefab_name] ~= nil then
						local var_99_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_18.prefab_name].transform, "story_v_out_324011", "324011023", "story_v_out_324011.awb")

						arg_96_1:RecordAudio("324011023", var_99_24)
						arg_96_1:RecordAudio("324011023", var_99_24)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_324011", "324011023", "story_v_out_324011.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_324011", "324011023", "story_v_out_324011.awb")
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
				actorName = "1070ui_story",
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
	Play324011024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 324011024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play324011025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1070ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1070ui_story == nil then
				arg_100_1.var_.characterEffect1070ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1070ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1070ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1070ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1070ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 1.525

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_8 = arg_100_1:GetWordFromCfg(324011024)
				local var_103_9 = arg_100_1:FormatText(var_103_8.content)

				arg_100_1.text_.text = var_103_9

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_10 = 61
				local var_103_11 = utf8.len(var_103_9)
				local var_103_12 = var_103_10 <= 0 and var_103_7 or var_103_7 * (var_103_11 / var_103_10)

				if var_103_12 > 0 and var_103_7 < var_103_12 then
					arg_100_1.talkMaxDuration = var_103_12

					if var_103_12 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_12 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_9
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_13 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_13 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_13

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_13 and arg_100_1.time_ < var_103_6 + var_103_13 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play324011025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 324011025
		arg_104_1.duration_ = 11.8

		local var_104_0 = {
			zh = 9.2,
			ja = 11.8
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
				arg_104_0:Play324011026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1070ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1070ui_story == nil then
				arg_104_1.var_.characterEffect1070ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect1070ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect1070ui_story then
				arg_104_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_107_4 = 0

			if var_107_4 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action442")
			end

			local var_107_5 = 0
			local var_107_6 = 0.85

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_7 = arg_104_1:FormatText(StoryNameCfg[318].name)

				arg_104_1.leftNameTxt_.text = var_107_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_8 = arg_104_1:GetWordFromCfg(324011025)
				local var_107_9 = arg_104_1:FormatText(var_107_8.content)

				arg_104_1.text_.text = var_107_9

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_10 = 34
				local var_107_11 = utf8.len(var_107_9)
				local var_107_12 = var_107_10 <= 0 and var_107_6 or var_107_6 * (var_107_11 / var_107_10)

				if var_107_12 > 0 and var_107_6 < var_107_12 then
					arg_104_1.talkMaxDuration = var_107_12

					if var_107_12 + var_107_5 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_5
					end
				end

				arg_104_1.text_.text = var_107_9
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011025", "story_v_out_324011.awb") ~= 0 then
					local var_107_13 = manager.audio:GetVoiceLength("story_v_out_324011", "324011025", "story_v_out_324011.awb") / 1000

					if var_107_13 + var_107_5 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_13 + var_107_5
					end

					if var_107_8.prefab_name ~= "" and arg_104_1.actors_[var_107_8.prefab_name] ~= nil then
						local var_107_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_8.prefab_name].transform, "story_v_out_324011", "324011025", "story_v_out_324011.awb")

						arg_104_1:RecordAudio("324011025", var_107_14)
						arg_104_1:RecordAudio("324011025", var_107_14)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_324011", "324011025", "story_v_out_324011.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_324011", "324011025", "story_v_out_324011.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_15 = math.max(var_107_6, arg_104_1.talkMaxDuration)

			if var_107_5 <= arg_104_1.time_ and arg_104_1.time_ < var_107_5 + var_107_15 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_5) / var_107_15

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_5 + var_107_15 and arg_104_1.time_ < var_107_5 + var_107_15 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play324011026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 324011026
		arg_108_1.duration_ = 12.9

		local var_108_0 = {
			zh = 10.2,
			ja = 12.9
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
				arg_108_0:Play324011027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.9

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[318].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:GetWordFromCfg(324011026)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011026", "story_v_out_324011.awb") ~= 0 then
					local var_111_8 = manager.audio:GetVoiceLength("story_v_out_324011", "324011026", "story_v_out_324011.awb") / 1000

					if var_111_8 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_0
					end

					if var_111_3.prefab_name ~= "" and arg_108_1.actors_[var_111_3.prefab_name] ~= nil then
						local var_111_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_3.prefab_name].transform, "story_v_out_324011", "324011026", "story_v_out_324011.awb")

						arg_108_1:RecordAudio("324011026", var_111_9)
						arg_108_1:RecordAudio("324011026", var_111_9)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_324011", "324011026", "story_v_out_324011.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_324011", "324011026", "story_v_out_324011.awb")
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
	Play324011027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 324011027
		arg_112_1.duration_ = 12.8

		local var_112_0 = {
			zh = 9.8,
			ja = 12.8
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play324011028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action426")
			end

			local var_115_1 = 0
			local var_115_2 = 1.075

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_3 = arg_112_1:FormatText(StoryNameCfg[318].name)

				arg_112_1.leftNameTxt_.text = var_115_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_4 = arg_112_1:GetWordFromCfg(324011027)
				local var_115_5 = arg_112_1:FormatText(var_115_4.content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_6 = 43
				local var_115_7 = utf8.len(var_115_5)
				local var_115_8 = var_115_6 <= 0 and var_115_2 or var_115_2 * (var_115_7 / var_115_6)

				if var_115_8 > 0 and var_115_2 < var_115_8 then
					arg_112_1.talkMaxDuration = var_115_8

					if var_115_8 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_8 + var_115_1
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011027", "story_v_out_324011.awb") ~= 0 then
					local var_115_9 = manager.audio:GetVoiceLength("story_v_out_324011", "324011027", "story_v_out_324011.awb") / 1000

					if var_115_9 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_1
					end

					if var_115_4.prefab_name ~= "" and arg_112_1.actors_[var_115_4.prefab_name] ~= nil then
						local var_115_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_4.prefab_name].transform, "story_v_out_324011", "324011027", "story_v_out_324011.awb")

						arg_112_1:RecordAudio("324011027", var_115_10)
						arg_112_1:RecordAudio("324011027", var_115_10)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_324011", "324011027", "story_v_out_324011.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_324011", "324011027", "story_v_out_324011.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_11 = math.max(var_115_2, arg_112_1.talkMaxDuration)

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_11 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_1) / var_115_11

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_1 + var_115_11 and arg_112_1.time_ < var_115_1 + var_115_11 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play324011028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 324011028
		arg_116_1.duration_ = 12.33

		local var_116_0 = {
			zh = 10.966,
			ja = 12.333
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
				arg_116_0:Play324011029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 1.05

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_2 = arg_116_1:FormatText(StoryNameCfg[318].name)

				arg_116_1.leftNameTxt_.text = var_119_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:GetWordFromCfg(324011028)
				local var_119_4 = arg_116_1:FormatText(var_119_3.content)

				arg_116_1.text_.text = var_119_4

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 42
				local var_119_6 = utf8.len(var_119_4)
				local var_119_7 = var_119_5 <= 0 and var_119_1 or var_119_1 * (var_119_6 / var_119_5)

				if var_119_7 > 0 and var_119_1 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_4
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011028", "story_v_out_324011.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_324011", "324011028", "story_v_out_324011.awb") / 1000

					if var_119_8 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_0
					end

					if var_119_3.prefab_name ~= "" and arg_116_1.actors_[var_119_3.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_3.prefab_name].transform, "story_v_out_324011", "324011028", "story_v_out_324011.awb")

						arg_116_1:RecordAudio("324011028", var_119_9)
						arg_116_1:RecordAudio("324011028", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_324011", "324011028", "story_v_out_324011.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_324011", "324011028", "story_v_out_324011.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_10 and arg_116_1.time_ < var_119_0 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play324011029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 324011029
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play324011030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1070ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1070ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(0, 100, 0)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1070ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0, 100, 0)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = arg_120_1.actors_["1070ui_story"]
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect1070ui_story == nil then
				arg_120_1.var_.characterEffect1070ui_story = var_123_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_11 = 0.200000002980232

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 and not isNil(var_123_9) then
				local var_123_12 = (arg_120_1.time_ - var_123_10) / var_123_11

				if arg_120_1.var_.characterEffect1070ui_story and not isNil(var_123_9) then
					local var_123_13 = Mathf.Lerp(0, 0.5, var_123_12)

					arg_120_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1070ui_story.fillRatio = var_123_13
				end
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect1070ui_story then
				local var_123_14 = 0.5

				arg_120_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1070ui_story.fillRatio = var_123_14
			end

			local var_123_15 = 0.1
			local var_123_16 = 1

			if var_123_15 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				local var_123_17 = "play"
				local var_123_18 = "effect"

				arg_120_1:AudioAction(var_123_17, var_123_18, "se_story_150", "se_story_150_wind", "")
			end

			local var_123_19 = 0
			local var_123_20 = 1.375

			if var_123_19 < arg_120_1.time_ and arg_120_1.time_ <= var_123_19 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_21 = arg_120_1:GetWordFromCfg(324011029)
				local var_123_22 = arg_120_1:FormatText(var_123_21.content)

				arg_120_1.text_.text = var_123_22

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_23 = 55
				local var_123_24 = utf8.len(var_123_22)
				local var_123_25 = var_123_23 <= 0 and var_123_20 or var_123_20 * (var_123_24 / var_123_23)

				if var_123_25 > 0 and var_123_20 < var_123_25 then
					arg_120_1.talkMaxDuration = var_123_25

					if var_123_25 + var_123_19 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_25 + var_123_19
					end
				end

				arg_120_1.text_.text = var_123_22
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_26 = math.max(var_123_20, arg_120_1.talkMaxDuration)

			if var_123_19 <= arg_120_1.time_ and arg_120_1.time_ < var_123_19 + var_123_26 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_19) / var_123_26

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_19 + var_123_26 and arg_120_1.time_ < var_123_19 + var_123_26 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play324011030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324011030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play324011031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 1.525

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_2 = arg_124_1:GetWordFromCfg(324011030)
				local var_127_3 = arg_124_1:FormatText(var_127_2.content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 61
				local var_127_5 = utf8.len(var_127_3)
				local var_127_6 = var_127_4 <= 0 and var_127_1 or var_127_1 * (var_127_5 / var_127_4)

				if var_127_6 > 0 and var_127_1 < var_127_6 then
					arg_124_1.talkMaxDuration = var_127_6

					if var_127_6 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_7 and arg_124_1.time_ < var_127_0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play324011031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324011031
		arg_128_1.duration_ = 4.13

		local var_128_0 = {
			zh = 1.999999999999,
			ja = 4.133
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
				arg_128_0:Play324011032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1070ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1070ui_story = var_131_0.localPosition
			end

			local var_131_2 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2
				local var_131_4 = Vector3.New(0, -0.95, -6.05)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1070ui_story, var_131_4, var_131_3)

				local var_131_5 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_5.x, var_131_5.y, var_131_5.z)

				local var_131_6 = var_131_0.localEulerAngles

				var_131_6.z = 0
				var_131_6.x = 0
				var_131_0.localEulerAngles = var_131_6
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_131_7 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_7.x, var_131_7.y, var_131_7.z)

				local var_131_8 = var_131_0.localEulerAngles

				var_131_8.z = 0
				var_131_8.x = 0
				var_131_0.localEulerAngles = var_131_8
			end

			local var_131_9 = arg_128_1.actors_["1070ui_story"]
			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1070ui_story == nil then
				arg_128_1.var_.characterEffect1070ui_story = var_131_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_11 = 0.200000002980232

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_11 and not isNil(var_131_9) then
				local var_131_12 = (arg_128_1.time_ - var_131_10) / var_131_11

				if arg_128_1.var_.characterEffect1070ui_story and not isNil(var_131_9) then
					arg_128_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_10 + var_131_11 and arg_128_1.time_ < var_131_10 + var_131_11 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1070ui_story then
				arg_128_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_131_13 = 0

			if var_131_13 < arg_128_1.time_ and arg_128_1.time_ <= var_131_13 + arg_131_0 then
				arg_128_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_131_14 = 0

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_131_15 = 0
			local var_131_16 = 0.2

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_17 = arg_128_1:FormatText(StoryNameCfg[318].name)

				arg_128_1.leftNameTxt_.text = var_131_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_18 = arg_128_1:GetWordFromCfg(324011031)
				local var_131_19 = arg_128_1:FormatText(var_131_18.content)

				arg_128_1.text_.text = var_131_19

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_20 = 8
				local var_131_21 = utf8.len(var_131_19)
				local var_131_22 = var_131_20 <= 0 and var_131_16 or var_131_16 * (var_131_21 / var_131_20)

				if var_131_22 > 0 and var_131_16 < var_131_22 then
					arg_128_1.talkMaxDuration = var_131_22

					if var_131_22 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_22 + var_131_15
					end
				end

				arg_128_1.text_.text = var_131_19
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011031", "story_v_out_324011.awb") ~= 0 then
					local var_131_23 = manager.audio:GetVoiceLength("story_v_out_324011", "324011031", "story_v_out_324011.awb") / 1000

					if var_131_23 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_15
					end

					if var_131_18.prefab_name ~= "" and arg_128_1.actors_[var_131_18.prefab_name] ~= nil then
						local var_131_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_18.prefab_name].transform, "story_v_out_324011", "324011031", "story_v_out_324011.awb")

						arg_128_1:RecordAudio("324011031", var_131_24)
						arg_128_1:RecordAudio("324011031", var_131_24)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_324011", "324011031", "story_v_out_324011.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_324011", "324011031", "story_v_out_324011.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_25 = math.max(var_131_16, arg_128_1.talkMaxDuration)

			if var_131_15 <= arg_128_1.time_ and arg_128_1.time_ < var_131_15 + var_131_25 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_15) / var_131_25

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_15 + var_131_25 and arg_128_1.time_ < var_131_15 + var_131_25 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play324011032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324011032
		arg_132_1.duration_ = 6.73

		local var_132_0 = {
			zh = 4.5,
			ja = 6.733
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
				arg_132_0:Play324011033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.525

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[318].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(324011032)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 21
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011032", "story_v_out_324011.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_324011", "324011032", "story_v_out_324011.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_324011", "324011032", "story_v_out_324011.awb")

						arg_132_1:RecordAudio("324011032", var_135_9)
						arg_132_1:RecordAudio("324011032", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_324011", "324011032", "story_v_out_324011.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_324011", "324011032", "story_v_out_324011.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play324011033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324011033
		arg_136_1.duration_ = 12.43

		local var_136_0 = {
			zh = 7.266,
			ja = 12.433
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
				arg_136_0:Play324011034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0
			local var_139_1 = 0.975

			if var_139_0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_2 = arg_136_1:FormatText(StoryNameCfg[318].name)

				arg_136_1.leftNameTxt_.text = var_139_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_3 = arg_136_1:GetWordFromCfg(324011033)
				local var_139_4 = arg_136_1:FormatText(var_139_3.content)

				arg_136_1.text_.text = var_139_4

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 39
				local var_139_6 = utf8.len(var_139_4)
				local var_139_7 = var_139_5 <= 0 and var_139_1 or var_139_1 * (var_139_6 / var_139_5)

				if var_139_7 > 0 and var_139_1 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_0
					end
				end

				arg_136_1.text_.text = var_139_4
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011033", "story_v_out_324011.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_324011", "324011033", "story_v_out_324011.awb") / 1000

					if var_139_8 + var_139_0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_0
					end

					if var_139_3.prefab_name ~= "" and arg_136_1.actors_[var_139_3.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_3.prefab_name].transform, "story_v_out_324011", "324011033", "story_v_out_324011.awb")

						arg_136_1:RecordAudio("324011033", var_139_9)
						arg_136_1:RecordAudio("324011033", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_324011", "324011033", "story_v_out_324011.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_324011", "324011033", "story_v_out_324011.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_1, arg_136_1.talkMaxDuration)

			if var_139_0 <= arg_136_1.time_ and arg_136_1.time_ < var_139_0 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_0) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_0 + var_139_10 and arg_136_1.time_ < var_139_0 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play324011034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 324011034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play324011035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1070ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1070ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(0, 100, 0)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1070ui_story, var_143_4, var_143_3)

				local var_143_5 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_5.x, var_143_5.y, var_143_5.z)

				local var_143_6 = var_143_0.localEulerAngles

				var_143_6.z = 0
				var_143_6.x = 0
				var_143_0.localEulerAngles = var_143_6
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, 100, 0)

				local var_143_7 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_7.x, var_143_7.y, var_143_7.z)

				local var_143_8 = var_143_0.localEulerAngles

				var_143_8.z = 0
				var_143_8.x = 0
				var_143_0.localEulerAngles = var_143_8
			end

			local var_143_9 = arg_140_1.actors_["1070ui_story"]
			local var_143_10 = 0

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 and not isNil(var_143_9) and arg_140_1.var_.characterEffect1070ui_story == nil then
				arg_140_1.var_.characterEffect1070ui_story = var_143_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_11 = 0.200000002980232

			if var_143_10 <= arg_140_1.time_ and arg_140_1.time_ < var_143_10 + var_143_11 and not isNil(var_143_9) then
				local var_143_12 = (arg_140_1.time_ - var_143_10) / var_143_11

				if arg_140_1.var_.characterEffect1070ui_story and not isNil(var_143_9) then
					local var_143_13 = Mathf.Lerp(0, 0.5, var_143_12)

					arg_140_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1070ui_story.fillRatio = var_143_13
				end
			end

			if arg_140_1.time_ >= var_143_10 + var_143_11 and arg_140_1.time_ < var_143_10 + var_143_11 + arg_143_0 and not isNil(var_143_9) and arg_140_1.var_.characterEffect1070ui_story then
				local var_143_14 = 0.5

				arg_140_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1070ui_story.fillRatio = var_143_14
			end

			local var_143_15 = 0
			local var_143_16 = 1.525

			if var_143_15 < arg_140_1.time_ and arg_140_1.time_ <= var_143_15 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_17 = arg_140_1:GetWordFromCfg(324011034)
				local var_143_18 = arg_140_1:FormatText(var_143_17.content)

				arg_140_1.text_.text = var_143_18

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_19 = 61
				local var_143_20 = utf8.len(var_143_18)
				local var_143_21 = var_143_19 <= 0 and var_143_16 or var_143_16 * (var_143_20 / var_143_19)

				if var_143_21 > 0 and var_143_16 < var_143_21 then
					arg_140_1.talkMaxDuration = var_143_21

					if var_143_21 + var_143_15 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_21 + var_143_15
					end
				end

				arg_140_1.text_.text = var_143_18
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_22 = math.max(var_143_16, arg_140_1.talkMaxDuration)

			if var_143_15 <= arg_140_1.time_ and arg_140_1.time_ < var_143_15 + var_143_22 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_15) / var_143_22

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_15 + var_143_22 and arg_140_1.time_ < var_143_15 + var_143_22 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play324011035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 324011035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play324011036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 1.1

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_2 = arg_144_1:GetWordFromCfg(324011035)
				local var_147_3 = arg_144_1:FormatText(var_147_2.content)

				arg_144_1.text_.text = var_147_3

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 44
				local var_147_5 = utf8.len(var_147_3)
				local var_147_6 = var_147_4 <= 0 and var_147_1 or var_147_1 * (var_147_5 / var_147_4)

				if var_147_6 > 0 and var_147_1 < var_147_6 then
					arg_144_1.talkMaxDuration = var_147_6

					if var_147_6 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_6 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_3
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_7 and arg_144_1.time_ < var_147_0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play324011036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 324011036
		arg_148_1.duration_ = 5.43

		local var_148_0 = {
			zh = 2.033,
			ja = 5.433
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
				arg_148_0:Play324011037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = "10039ui_story"

			if arg_148_1.actors_[var_151_0] == nil then
				local var_151_1 = Asset.Load("Char/" .. "10039ui_story")

				if not isNil(var_151_1) then
					local var_151_2 = Object.Instantiate(Asset.Load("Char/" .. "10039ui_story"), arg_148_1.stage_.transform)

					var_151_2.name = var_151_0
					var_151_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_148_1.actors_[var_151_0] = var_151_2

					local var_151_3 = var_151_2:GetComponentInChildren(typeof(CharacterEffect))

					var_151_3.enabled = true

					local var_151_4 = GameObjectTools.GetOrAddComponent(var_151_2, typeof(DynamicBoneHelper))

					if var_151_4 then
						var_151_4:EnableDynamicBone(false)
					end

					arg_148_1:ShowWeapon(var_151_3.transform, false)

					arg_148_1.var_[var_151_0 .. "Animator"] = var_151_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_148_1.var_[var_151_0 .. "Animator"].applyRootMotion = true
					arg_148_1.var_[var_151_0 .. "LipSync"] = var_151_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_151_5 = arg_148_1.actors_["10039ui_story"].transform
			local var_151_6 = 0

			if var_151_6 < arg_148_1.time_ and arg_148_1.time_ <= var_151_6 + arg_151_0 then
				arg_148_1.var_.moveOldPos10039ui_story = var_151_5.localPosition
			end

			local var_151_7 = 0.001

			if var_151_6 <= arg_148_1.time_ and arg_148_1.time_ < var_151_6 + var_151_7 then
				local var_151_8 = (arg_148_1.time_ - var_151_6) / var_151_7
				local var_151_9 = Vector3.New(0, -0.8, -6.2)

				var_151_5.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos10039ui_story, var_151_9, var_151_8)

				local var_151_10 = manager.ui.mainCamera.transform.position - var_151_5.position

				var_151_5.forward = Vector3.New(var_151_10.x, var_151_10.y, var_151_10.z)

				local var_151_11 = var_151_5.localEulerAngles

				var_151_11.z = 0
				var_151_11.x = 0
				var_151_5.localEulerAngles = var_151_11
			end

			if arg_148_1.time_ >= var_151_6 + var_151_7 and arg_148_1.time_ < var_151_6 + var_151_7 + arg_151_0 then
				var_151_5.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_151_12 = manager.ui.mainCamera.transform.position - var_151_5.position

				var_151_5.forward = Vector3.New(var_151_12.x, var_151_12.y, var_151_12.z)

				local var_151_13 = var_151_5.localEulerAngles

				var_151_13.z = 0
				var_151_13.x = 0
				var_151_5.localEulerAngles = var_151_13
			end

			local var_151_14 = arg_148_1.actors_["10039ui_story"]
			local var_151_15 = 0

			if var_151_15 < arg_148_1.time_ and arg_148_1.time_ <= var_151_15 + arg_151_0 and not isNil(var_151_14) and arg_148_1.var_.characterEffect10039ui_story == nil then
				arg_148_1.var_.characterEffect10039ui_story = var_151_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_16 = 0.200000002980232

			if var_151_15 <= arg_148_1.time_ and arg_148_1.time_ < var_151_15 + var_151_16 and not isNil(var_151_14) then
				local var_151_17 = (arg_148_1.time_ - var_151_15) / var_151_16

				if arg_148_1.var_.characterEffect10039ui_story and not isNil(var_151_14) then
					arg_148_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= var_151_15 + var_151_16 and arg_148_1.time_ < var_151_15 + var_151_16 + arg_151_0 and not isNil(var_151_14) and arg_148_1.var_.characterEffect10039ui_story then
				arg_148_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_151_18 = 0

			if var_151_18 < arg_148_1.time_ and arg_148_1.time_ <= var_151_18 + arg_151_0 then
				arg_148_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_151_19 = 0

			if var_151_19 < arg_148_1.time_ and arg_148_1.time_ <= var_151_19 + arg_151_0 then
				arg_148_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_151_20 = 0
			local var_151_21 = 0.275

			if var_151_20 < arg_148_1.time_ and arg_148_1.time_ <= var_151_20 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_22 = arg_148_1:FormatText(StoryNameCfg[472].name)

				arg_148_1.leftNameTxt_.text = var_151_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_23 = arg_148_1:GetWordFromCfg(324011036)
				local var_151_24 = arg_148_1:FormatText(var_151_23.content)

				arg_148_1.text_.text = var_151_24

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_25 = 11
				local var_151_26 = utf8.len(var_151_24)
				local var_151_27 = var_151_25 <= 0 and var_151_21 or var_151_21 * (var_151_26 / var_151_25)

				if var_151_27 > 0 and var_151_21 < var_151_27 then
					arg_148_1.talkMaxDuration = var_151_27

					if var_151_27 + var_151_20 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_27 + var_151_20
					end
				end

				arg_148_1.text_.text = var_151_24
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011036", "story_v_out_324011.awb") ~= 0 then
					local var_151_28 = manager.audio:GetVoiceLength("story_v_out_324011", "324011036", "story_v_out_324011.awb") / 1000

					if var_151_28 + var_151_20 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_28 + var_151_20
					end

					if var_151_23.prefab_name ~= "" and arg_148_1.actors_[var_151_23.prefab_name] ~= nil then
						local var_151_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_23.prefab_name].transform, "story_v_out_324011", "324011036", "story_v_out_324011.awb")

						arg_148_1:RecordAudio("324011036", var_151_29)
						arg_148_1:RecordAudio("324011036", var_151_29)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_324011", "324011036", "story_v_out_324011.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_324011", "324011036", "story_v_out_324011.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_30 = math.max(var_151_21, arg_148_1.talkMaxDuration)

			if var_151_20 <= arg_148_1.time_ and arg_148_1.time_ < var_151_20 + var_151_30 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_20) / var_151_30

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_20 + var_151_30 and arg_148_1.time_ < var_151_20 + var_151_30 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play324011037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 324011037
		arg_152_1.duration_ = 2.23

		local var_152_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_152_0:Play324011038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["10039ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos10039ui_story = var_155_0.localPosition
			end

			local var_155_2 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2
				local var_155_4 = Vector3.New(-0.7, -0.8, -6.2)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10039ui_story, var_155_4, var_155_3)

				local var_155_5 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_5.x, var_155_5.y, var_155_5.z)

				local var_155_6 = var_155_0.localEulerAngles

				var_155_6.z = 0
				var_155_6.x = 0
				var_155_0.localEulerAngles = var_155_6
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_155_7 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_7.x, var_155_7.y, var_155_7.z)

				local var_155_8 = var_155_0.localEulerAngles

				var_155_8.z = 0
				var_155_8.x = 0
				var_155_0.localEulerAngles = var_155_8
			end

			local var_155_9 = arg_152_1.actors_["1070ui_story"].transform
			local var_155_10 = 0

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 then
				arg_152_1.var_.moveOldPos1070ui_story = var_155_9.localPosition
			end

			local var_155_11 = 0.001

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_11 then
				local var_155_12 = (arg_152_1.time_ - var_155_10) / var_155_11
				local var_155_13 = Vector3.New(0.7, -0.95, -6.05)

				var_155_9.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1070ui_story, var_155_13, var_155_12)

				local var_155_14 = manager.ui.mainCamera.transform.position - var_155_9.position

				var_155_9.forward = Vector3.New(var_155_14.x, var_155_14.y, var_155_14.z)

				local var_155_15 = var_155_9.localEulerAngles

				var_155_15.z = 0
				var_155_15.x = 0
				var_155_9.localEulerAngles = var_155_15
			end

			if arg_152_1.time_ >= var_155_10 + var_155_11 and arg_152_1.time_ < var_155_10 + var_155_11 + arg_155_0 then
				var_155_9.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_155_16 = manager.ui.mainCamera.transform.position - var_155_9.position

				var_155_9.forward = Vector3.New(var_155_16.x, var_155_16.y, var_155_16.z)

				local var_155_17 = var_155_9.localEulerAngles

				var_155_17.z = 0
				var_155_17.x = 0
				var_155_9.localEulerAngles = var_155_17
			end

			local var_155_18 = arg_152_1.actors_["1070ui_story"]
			local var_155_19 = 0

			if var_155_19 < arg_152_1.time_ and arg_152_1.time_ <= var_155_19 + arg_155_0 and not isNil(var_155_18) and arg_152_1.var_.characterEffect1070ui_story == nil then
				arg_152_1.var_.characterEffect1070ui_story = var_155_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_20 = 0.200000002980232

			if var_155_19 <= arg_152_1.time_ and arg_152_1.time_ < var_155_19 + var_155_20 and not isNil(var_155_18) then
				local var_155_21 = (arg_152_1.time_ - var_155_19) / var_155_20

				if arg_152_1.var_.characterEffect1070ui_story and not isNil(var_155_18) then
					arg_152_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_19 + var_155_20 and arg_152_1.time_ < var_155_19 + var_155_20 + arg_155_0 and not isNil(var_155_18) and arg_152_1.var_.characterEffect1070ui_story then
				arg_152_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_155_22 = arg_152_1.actors_["10039ui_story"]
			local var_155_23 = 0

			if var_155_23 < arg_152_1.time_ and arg_152_1.time_ <= var_155_23 + arg_155_0 and not isNil(var_155_22) and arg_152_1.var_.characterEffect10039ui_story == nil then
				arg_152_1.var_.characterEffect10039ui_story = var_155_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_24 = 0.200000002980232

			if var_155_23 <= arg_152_1.time_ and arg_152_1.time_ < var_155_23 + var_155_24 and not isNil(var_155_22) then
				local var_155_25 = (arg_152_1.time_ - var_155_23) / var_155_24

				if arg_152_1.var_.characterEffect10039ui_story and not isNil(var_155_22) then
					local var_155_26 = Mathf.Lerp(0, 0.5, var_155_25)

					arg_152_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_152_1.var_.characterEffect10039ui_story.fillRatio = var_155_26
				end
			end

			if arg_152_1.time_ >= var_155_23 + var_155_24 and arg_152_1.time_ < var_155_23 + var_155_24 + arg_155_0 and not isNil(var_155_22) and arg_152_1.var_.characterEffect10039ui_story then
				local var_155_27 = 0.5

				arg_152_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_152_1.var_.characterEffect10039ui_story.fillRatio = var_155_27
			end

			local var_155_28 = 0

			if var_155_28 < arg_152_1.time_ and arg_152_1.time_ <= var_155_28 + arg_155_0 then
				arg_152_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			local var_155_29 = 0

			if var_155_29 < arg_152_1.time_ and arg_152_1.time_ <= var_155_29 + arg_155_0 then
				arg_152_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_155_30 = 0
			local var_155_31 = 0.125

			if var_155_30 < arg_152_1.time_ and arg_152_1.time_ <= var_155_30 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_32 = arg_152_1:FormatText(StoryNameCfg[318].name)

				arg_152_1.leftNameTxt_.text = var_155_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_33 = arg_152_1:GetWordFromCfg(324011037)
				local var_155_34 = arg_152_1:FormatText(var_155_33.content)

				arg_152_1.text_.text = var_155_34

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_35 = 5
				local var_155_36 = utf8.len(var_155_34)
				local var_155_37 = var_155_35 <= 0 and var_155_31 or var_155_31 * (var_155_36 / var_155_35)

				if var_155_37 > 0 and var_155_31 < var_155_37 then
					arg_152_1.talkMaxDuration = var_155_37

					if var_155_37 + var_155_30 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_37 + var_155_30
					end
				end

				arg_152_1.text_.text = var_155_34
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011037", "story_v_out_324011.awb") ~= 0 then
					local var_155_38 = manager.audio:GetVoiceLength("story_v_out_324011", "324011037", "story_v_out_324011.awb") / 1000

					if var_155_38 + var_155_30 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_38 + var_155_30
					end

					if var_155_33.prefab_name ~= "" and arg_152_1.actors_[var_155_33.prefab_name] ~= nil then
						local var_155_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_33.prefab_name].transform, "story_v_out_324011", "324011037", "story_v_out_324011.awb")

						arg_152_1:RecordAudio("324011037", var_155_39)
						arg_152_1:RecordAudio("324011037", var_155_39)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_324011", "324011037", "story_v_out_324011.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_324011", "324011037", "story_v_out_324011.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_40 = math.max(var_155_31, arg_152_1.talkMaxDuration)

			if var_155_30 <= arg_152_1.time_ and arg_152_1.time_ < var_155_30 + var_155_40 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_30) / var_155_40

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_30 + var_155_40 and arg_152_1.time_ < var_155_30 + var_155_40 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play324011038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 324011038
		arg_156_1.duration_ = 2.37

		local var_156_0 = {
			zh = 1.866,
			ja = 2.366
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play324011039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["10039ui_story"]
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect10039ui_story == nil then
				arg_156_1.var_.characterEffect10039ui_story = var_159_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_2 = 0.200000002980232

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 and not isNil(var_159_0) then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2

				if arg_156_1.var_.characterEffect10039ui_story and not isNil(var_159_0) then
					arg_156_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 and not isNil(var_159_0) and arg_156_1.var_.characterEffect10039ui_story then
				arg_156_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_159_4 = arg_156_1.actors_["1070ui_story"]
			local var_159_5 = 0

			if var_159_5 < arg_156_1.time_ and arg_156_1.time_ <= var_159_5 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect1070ui_story == nil then
				arg_156_1.var_.characterEffect1070ui_story = var_159_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_6 = 0.200000002980232

			if var_159_5 <= arg_156_1.time_ and arg_156_1.time_ < var_159_5 + var_159_6 and not isNil(var_159_4) then
				local var_159_7 = (arg_156_1.time_ - var_159_5) / var_159_6

				if arg_156_1.var_.characterEffect1070ui_story and not isNil(var_159_4) then
					local var_159_8 = Mathf.Lerp(0, 0.5, var_159_7)

					arg_156_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1070ui_story.fillRatio = var_159_8
				end
			end

			if arg_156_1.time_ >= var_159_5 + var_159_6 and arg_156_1.time_ < var_159_5 + var_159_6 + arg_159_0 and not isNil(var_159_4) and arg_156_1.var_.characterEffect1070ui_story then
				local var_159_9 = 0.5

				arg_156_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1070ui_story.fillRatio = var_159_9
			end

			local var_159_10 = 0
			local var_159_11 = 0.125

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_12 = arg_156_1:FormatText(StoryNameCfg[472].name)

				arg_156_1.leftNameTxt_.text = var_159_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_13 = arg_156_1:GetWordFromCfg(324011038)
				local var_159_14 = arg_156_1:FormatText(var_159_13.content)

				arg_156_1.text_.text = var_159_14

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_15 = 5
				local var_159_16 = utf8.len(var_159_14)
				local var_159_17 = var_159_15 <= 0 and var_159_11 or var_159_11 * (var_159_16 / var_159_15)

				if var_159_17 > 0 and var_159_11 < var_159_17 then
					arg_156_1.talkMaxDuration = var_159_17

					if var_159_17 + var_159_10 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_17 + var_159_10
					end
				end

				arg_156_1.text_.text = var_159_14
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011038", "story_v_out_324011.awb") ~= 0 then
					local var_159_18 = manager.audio:GetVoiceLength("story_v_out_324011", "324011038", "story_v_out_324011.awb") / 1000

					if var_159_18 + var_159_10 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_18 + var_159_10
					end

					if var_159_13.prefab_name ~= "" and arg_156_1.actors_[var_159_13.prefab_name] ~= nil then
						local var_159_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_13.prefab_name].transform, "story_v_out_324011", "324011038", "story_v_out_324011.awb")

						arg_156_1:RecordAudio("324011038", var_159_19)
						arg_156_1:RecordAudio("324011038", var_159_19)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_324011", "324011038", "story_v_out_324011.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_324011", "324011038", "story_v_out_324011.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_20 = math.max(var_159_11, arg_156_1.talkMaxDuration)

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_20 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_10) / var_159_20

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_10 + var_159_20 and arg_156_1.time_ < var_159_10 + var_159_20 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play324011039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 324011039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play324011040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10039ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10039ui_story == nil then
				arg_160_1.var_.characterEffect10039ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect10039ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_160_1.var_.characterEffect10039ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10039ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_160_1.var_.characterEffect10039ui_story.fillRatio = var_163_5
			end

			local var_163_6 = arg_160_1.actors_["10039ui_story"].transform
			local var_163_7 = 0

			if var_163_7 < arg_160_1.time_ and arg_160_1.time_ <= var_163_7 + arg_163_0 then
				arg_160_1.var_.moveOldPos10039ui_story = var_163_6.localPosition
			end

			local var_163_8 = 0.001

			if var_163_7 <= arg_160_1.time_ and arg_160_1.time_ < var_163_7 + var_163_8 then
				local var_163_9 = (arg_160_1.time_ - var_163_7) / var_163_8
				local var_163_10 = Vector3.New(0, 100, 0)

				var_163_6.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10039ui_story, var_163_10, var_163_9)

				local var_163_11 = manager.ui.mainCamera.transform.position - var_163_6.position

				var_163_6.forward = Vector3.New(var_163_11.x, var_163_11.y, var_163_11.z)

				local var_163_12 = var_163_6.localEulerAngles

				var_163_12.z = 0
				var_163_12.x = 0
				var_163_6.localEulerAngles = var_163_12
			end

			if arg_160_1.time_ >= var_163_7 + var_163_8 and arg_160_1.time_ < var_163_7 + var_163_8 + arg_163_0 then
				var_163_6.localPosition = Vector3.New(0, 100, 0)

				local var_163_13 = manager.ui.mainCamera.transform.position - var_163_6.position

				var_163_6.forward = Vector3.New(var_163_13.x, var_163_13.y, var_163_13.z)

				local var_163_14 = var_163_6.localEulerAngles

				var_163_14.z = 0
				var_163_14.x = 0
				var_163_6.localEulerAngles = var_163_14
			end

			local var_163_15 = arg_160_1.actors_["1070ui_story"].transform
			local var_163_16 = 0

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1.var_.moveOldPos1070ui_story = var_163_15.localPosition
			end

			local var_163_17 = 0.001

			if var_163_16 <= arg_160_1.time_ and arg_160_1.time_ < var_163_16 + var_163_17 then
				local var_163_18 = (arg_160_1.time_ - var_163_16) / var_163_17
				local var_163_19 = Vector3.New(0, 100, 0)

				var_163_15.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1070ui_story, var_163_19, var_163_18)

				local var_163_20 = manager.ui.mainCamera.transform.position - var_163_15.position

				var_163_15.forward = Vector3.New(var_163_20.x, var_163_20.y, var_163_20.z)

				local var_163_21 = var_163_15.localEulerAngles

				var_163_21.z = 0
				var_163_21.x = 0
				var_163_15.localEulerAngles = var_163_21
			end

			if arg_160_1.time_ >= var_163_16 + var_163_17 and arg_160_1.time_ < var_163_16 + var_163_17 + arg_163_0 then
				var_163_15.localPosition = Vector3.New(0, 100, 0)

				local var_163_22 = manager.ui.mainCamera.transform.position - var_163_15.position

				var_163_15.forward = Vector3.New(var_163_22.x, var_163_22.y, var_163_22.z)

				local var_163_23 = var_163_15.localEulerAngles

				var_163_23.z = 0
				var_163_23.x = 0
				var_163_15.localEulerAngles = var_163_23
			end

			local var_163_24 = 0.5
			local var_163_25 = 1

			if var_163_24 < arg_160_1.time_ and arg_160_1.time_ <= var_163_24 + arg_163_0 then
				local var_163_26 = "play"
				local var_163_27 = "effect"

				arg_160_1:AudioAction(var_163_26, var_163_27, "se_story_side_1094", "se_story_1094_run", "")
			end

			local var_163_28 = 0
			local var_163_29 = 1.325

			if var_163_28 < arg_160_1.time_ and arg_160_1.time_ <= var_163_28 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_30 = arg_160_1:GetWordFromCfg(324011039)
				local var_163_31 = arg_160_1:FormatText(var_163_30.content)

				arg_160_1.text_.text = var_163_31

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_32 = 53
				local var_163_33 = utf8.len(var_163_31)
				local var_163_34 = var_163_32 <= 0 and var_163_29 or var_163_29 * (var_163_33 / var_163_32)

				if var_163_34 > 0 and var_163_29 < var_163_34 then
					arg_160_1.talkMaxDuration = var_163_34

					if var_163_34 + var_163_28 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_34 + var_163_28
					end
				end

				arg_160_1.text_.text = var_163_31
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_35 = math.max(var_163_29, arg_160_1.talkMaxDuration)

			if var_163_28 <= arg_160_1.time_ and arg_160_1.time_ < var_163_28 + var_163_35 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_28) / var_163_35

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_28 + var_163_35 and arg_160_1.time_ < var_163_28 + var_163_35 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play324011040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 324011040
		arg_164_1.duration_ = 13.47

		local var_164_0 = {
			zh = 10.166,
			ja = 13.466
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play324011041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1070ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos1070ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(0.7, -0.95, -6.05)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1070ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = arg_164_1.actors_["1070ui_story"]
			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect1070ui_story == nil then
				arg_164_1.var_.characterEffect1070ui_story = var_167_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_11 = 0.200000002980232

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_11 and not isNil(var_167_9) then
				local var_167_12 = (arg_164_1.time_ - var_167_10) / var_167_11

				if arg_164_1.var_.characterEffect1070ui_story and not isNil(var_167_9) then
					arg_164_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_10 + var_167_11 and arg_164_1.time_ < var_167_10 + var_167_11 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect1070ui_story then
				arg_164_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_167_13 = 0

			if var_167_13 < arg_164_1.time_ and arg_164_1.time_ <= var_167_13 + arg_167_0 then
				arg_164_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action435")
			end

			local var_167_14 = 0

			if var_167_14 < arg_164_1.time_ and arg_164_1.time_ <= var_167_14 + arg_167_0 then
				arg_164_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_167_15 = 0
			local var_167_16 = 1.325

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_17 = arg_164_1:FormatText(StoryNameCfg[318].name)

				arg_164_1.leftNameTxt_.text = var_167_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_18 = arg_164_1:GetWordFromCfg(324011040)
				local var_167_19 = arg_164_1:FormatText(var_167_18.content)

				arg_164_1.text_.text = var_167_19

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_20 = 53
				local var_167_21 = utf8.len(var_167_19)
				local var_167_22 = var_167_20 <= 0 and var_167_16 or var_167_16 * (var_167_21 / var_167_20)

				if var_167_22 > 0 and var_167_16 < var_167_22 then
					arg_164_1.talkMaxDuration = var_167_22

					if var_167_22 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_22 + var_167_15
					end
				end

				arg_164_1.text_.text = var_167_19
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011040", "story_v_out_324011.awb") ~= 0 then
					local var_167_23 = manager.audio:GetVoiceLength("story_v_out_324011", "324011040", "story_v_out_324011.awb") / 1000

					if var_167_23 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_23 + var_167_15
					end

					if var_167_18.prefab_name ~= "" and arg_164_1.actors_[var_167_18.prefab_name] ~= nil then
						local var_167_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_18.prefab_name].transform, "story_v_out_324011", "324011040", "story_v_out_324011.awb")

						arg_164_1:RecordAudio("324011040", var_167_24)
						arg_164_1:RecordAudio("324011040", var_167_24)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_324011", "324011040", "story_v_out_324011.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_324011", "324011040", "story_v_out_324011.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_25 = math.max(var_167_16, arg_164_1.talkMaxDuration)

			if var_167_15 <= arg_164_1.time_ and arg_164_1.time_ < var_167_15 + var_167_25 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_15) / var_167_25

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_15 + var_167_25 and arg_164_1.time_ < var_167_15 + var_167_25 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play324011041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 324011041
		arg_168_1.duration_ = 8.87

		local var_168_0 = {
			zh = 6.3,
			ja = 8.866
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play324011042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10039ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos10039ui_story = var_171_0.localPosition
			end

			local var_171_2 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2
				local var_171_4 = Vector3.New(-0.7, -0.8, -6.2)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10039ui_story, var_171_4, var_171_3)

				local var_171_5 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_5.x, var_171_5.y, var_171_5.z)

				local var_171_6 = var_171_0.localEulerAngles

				var_171_6.z = 0
				var_171_6.x = 0
				var_171_0.localEulerAngles = var_171_6
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(-0.7, -0.8, -6.2)

				local var_171_7 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_7.x, var_171_7.y, var_171_7.z)

				local var_171_8 = var_171_0.localEulerAngles

				var_171_8.z = 0
				var_171_8.x = 0
				var_171_0.localEulerAngles = var_171_8
			end

			local var_171_9 = arg_168_1.actors_["10039ui_story"]
			local var_171_10 = 0

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect10039ui_story == nil then
				arg_168_1.var_.characterEffect10039ui_story = var_171_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_11 = 0.200000002980232

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_11 and not isNil(var_171_9) then
				local var_171_12 = (arg_168_1.time_ - var_171_10) / var_171_11

				if arg_168_1.var_.characterEffect10039ui_story and not isNil(var_171_9) then
					arg_168_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_10 + var_171_11 and arg_168_1.time_ < var_171_10 + var_171_11 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect10039ui_story then
				arg_168_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_171_13 = arg_168_1.actors_["1070ui_story"]
			local var_171_14 = 0

			if var_171_14 < arg_168_1.time_ and arg_168_1.time_ <= var_171_14 + arg_171_0 and not isNil(var_171_13) and arg_168_1.var_.characterEffect1070ui_story == nil then
				arg_168_1.var_.characterEffect1070ui_story = var_171_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_15 = 0.200000002980232

			if var_171_14 <= arg_168_1.time_ and arg_168_1.time_ < var_171_14 + var_171_15 and not isNil(var_171_13) then
				local var_171_16 = (arg_168_1.time_ - var_171_14) / var_171_15

				if arg_168_1.var_.characterEffect1070ui_story and not isNil(var_171_13) then
					local var_171_17 = Mathf.Lerp(0, 0.5, var_171_16)

					arg_168_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_168_1.var_.characterEffect1070ui_story.fillRatio = var_171_17
				end
			end

			if arg_168_1.time_ >= var_171_14 + var_171_15 and arg_168_1.time_ < var_171_14 + var_171_15 + arg_171_0 and not isNil(var_171_13) and arg_168_1.var_.characterEffect1070ui_story then
				local var_171_18 = 0.5

				arg_168_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_168_1.var_.characterEffect1070ui_story.fillRatio = var_171_18
			end

			local var_171_19 = 0

			if var_171_19 < arg_168_1.time_ and arg_168_1.time_ <= var_171_19 + arg_171_0 then
				arg_168_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_1")
			end

			local var_171_20 = 0

			if var_171_20 < arg_168_1.time_ and arg_168_1.time_ <= var_171_20 + arg_171_0 then
				arg_168_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_171_21 = 0
			local var_171_22 = 0.65

			if var_171_21 < arg_168_1.time_ and arg_168_1.time_ <= var_171_21 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_23 = arg_168_1:FormatText(StoryNameCfg[472].name)

				arg_168_1.leftNameTxt_.text = var_171_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_24 = arg_168_1:GetWordFromCfg(324011041)
				local var_171_25 = arg_168_1:FormatText(var_171_24.content)

				arg_168_1.text_.text = var_171_25

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_26 = 26
				local var_171_27 = utf8.len(var_171_25)
				local var_171_28 = var_171_26 <= 0 and var_171_22 or var_171_22 * (var_171_27 / var_171_26)

				if var_171_28 > 0 and var_171_22 < var_171_28 then
					arg_168_1.talkMaxDuration = var_171_28

					if var_171_28 + var_171_21 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_28 + var_171_21
					end
				end

				arg_168_1.text_.text = var_171_25
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011041", "story_v_out_324011.awb") ~= 0 then
					local var_171_29 = manager.audio:GetVoiceLength("story_v_out_324011", "324011041", "story_v_out_324011.awb") / 1000

					if var_171_29 + var_171_21 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_29 + var_171_21
					end

					if var_171_24.prefab_name ~= "" and arg_168_1.actors_[var_171_24.prefab_name] ~= nil then
						local var_171_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_24.prefab_name].transform, "story_v_out_324011", "324011041", "story_v_out_324011.awb")

						arg_168_1:RecordAudio("324011041", var_171_30)
						arg_168_1:RecordAudio("324011041", var_171_30)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_324011", "324011041", "story_v_out_324011.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_324011", "324011041", "story_v_out_324011.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_31 = math.max(var_171_22, arg_168_1.talkMaxDuration)

			if var_171_21 <= arg_168_1.time_ and arg_168_1.time_ < var_171_21 + var_171_31 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_21) / var_171_31

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_21 + var_171_31 and arg_168_1.time_ < var_171_21 + var_171_31 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play324011042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324011042
		arg_172_1.duration_ = 4.03

		local var_172_0 = {
			zh = 3.033,
			ja = 4.033
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
				arg_172_0:Play324011043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1070ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1070ui_story == nil then
				arg_172_1.var_.characterEffect1070ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1070ui_story and not isNil(var_175_0) then
					arg_172_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1070ui_story then
				arg_172_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_175_4 = arg_172_1.actors_["10039ui_story"]
			local var_175_5 = 0

			if var_175_5 < arg_172_1.time_ and arg_172_1.time_ <= var_175_5 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect10039ui_story == nil then
				arg_172_1.var_.characterEffect10039ui_story = var_175_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_6 = 0.200000002980232

			if var_175_5 <= arg_172_1.time_ and arg_172_1.time_ < var_175_5 + var_175_6 and not isNil(var_175_4) then
				local var_175_7 = (arg_172_1.time_ - var_175_5) / var_175_6

				if arg_172_1.var_.characterEffect10039ui_story and not isNil(var_175_4) then
					local var_175_8 = Mathf.Lerp(0, 0.5, var_175_7)

					arg_172_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_172_1.var_.characterEffect10039ui_story.fillRatio = var_175_8
				end
			end

			if arg_172_1.time_ >= var_175_5 + var_175_6 and arg_172_1.time_ < var_175_5 + var_175_6 + arg_175_0 and not isNil(var_175_4) and arg_172_1.var_.characterEffect10039ui_story then
				local var_175_9 = 0.5

				arg_172_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_172_1.var_.characterEffect10039ui_story.fillRatio = var_175_9
			end

			local var_175_10 = 0
			local var_175_11 = 0.3

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_12 = arg_172_1:FormatText(StoryNameCfg[318].name)

				arg_172_1.leftNameTxt_.text = var_175_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_13 = arg_172_1:GetWordFromCfg(324011042)
				local var_175_14 = arg_172_1:FormatText(var_175_13.content)

				arg_172_1.text_.text = var_175_14

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_15 = 12
				local var_175_16 = utf8.len(var_175_14)
				local var_175_17 = var_175_15 <= 0 and var_175_11 or var_175_11 * (var_175_16 / var_175_15)

				if var_175_17 > 0 and var_175_11 < var_175_17 then
					arg_172_1.talkMaxDuration = var_175_17

					if var_175_17 + var_175_10 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_17 + var_175_10
					end
				end

				arg_172_1.text_.text = var_175_14
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011042", "story_v_out_324011.awb") ~= 0 then
					local var_175_18 = manager.audio:GetVoiceLength("story_v_out_324011", "324011042", "story_v_out_324011.awb") / 1000

					if var_175_18 + var_175_10 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_18 + var_175_10
					end

					if var_175_13.prefab_name ~= "" and arg_172_1.actors_[var_175_13.prefab_name] ~= nil then
						local var_175_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_13.prefab_name].transform, "story_v_out_324011", "324011042", "story_v_out_324011.awb")

						arg_172_1:RecordAudio("324011042", var_175_19)
						arg_172_1:RecordAudio("324011042", var_175_19)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_324011", "324011042", "story_v_out_324011.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_324011", "324011042", "story_v_out_324011.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_20 = math.max(var_175_11, arg_172_1.talkMaxDuration)

			if var_175_10 <= arg_172_1.time_ and arg_172_1.time_ < var_175_10 + var_175_20 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_10) / var_175_20

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_10 + var_175_20 and arg_172_1.time_ < var_175_10 + var_175_20 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play324011043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 324011043
		arg_176_1.duration_ = 7.5

		local var_176_0 = {
			zh = 7.5,
			ja = 5.8
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play324011044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10039ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10039ui_story == nil then
				arg_176_1.var_.characterEffect10039ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect10039ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10039ui_story then
				arg_176_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_179_4 = arg_176_1.actors_["1070ui_story"]
			local var_179_5 = 0

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 and not isNil(var_179_4) and arg_176_1.var_.characterEffect1070ui_story == nil then
				arg_176_1.var_.characterEffect1070ui_story = var_179_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_6 = 0.200000002980232

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_6 and not isNil(var_179_4) then
				local var_179_7 = (arg_176_1.time_ - var_179_5) / var_179_6

				if arg_176_1.var_.characterEffect1070ui_story and not isNil(var_179_4) then
					local var_179_8 = Mathf.Lerp(0, 0.5, var_179_7)

					arg_176_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1070ui_story.fillRatio = var_179_8
				end
			end

			if arg_176_1.time_ >= var_179_5 + var_179_6 and arg_176_1.time_ < var_179_5 + var_179_6 + arg_179_0 and not isNil(var_179_4) and arg_176_1.var_.characterEffect1070ui_story then
				local var_179_9 = 0.5

				arg_176_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1070ui_story.fillRatio = var_179_9
			end

			local var_179_10 = 0
			local var_179_11 = 0.65

			if var_179_10 < arg_176_1.time_ and arg_176_1.time_ <= var_179_10 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_12 = arg_176_1:FormatText(StoryNameCfg[472].name)

				arg_176_1.leftNameTxt_.text = var_179_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_13 = arg_176_1:GetWordFromCfg(324011043)
				local var_179_14 = arg_176_1:FormatText(var_179_13.content)

				arg_176_1.text_.text = var_179_14

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_15 = 26
				local var_179_16 = utf8.len(var_179_14)
				local var_179_17 = var_179_15 <= 0 and var_179_11 or var_179_11 * (var_179_16 / var_179_15)

				if var_179_17 > 0 and var_179_11 < var_179_17 then
					arg_176_1.talkMaxDuration = var_179_17

					if var_179_17 + var_179_10 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_17 + var_179_10
					end
				end

				arg_176_1.text_.text = var_179_14
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011043", "story_v_out_324011.awb") ~= 0 then
					local var_179_18 = manager.audio:GetVoiceLength("story_v_out_324011", "324011043", "story_v_out_324011.awb") / 1000

					if var_179_18 + var_179_10 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_18 + var_179_10
					end

					if var_179_13.prefab_name ~= "" and arg_176_1.actors_[var_179_13.prefab_name] ~= nil then
						local var_179_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_13.prefab_name].transform, "story_v_out_324011", "324011043", "story_v_out_324011.awb")

						arg_176_1:RecordAudio("324011043", var_179_19)
						arg_176_1:RecordAudio("324011043", var_179_19)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_324011", "324011043", "story_v_out_324011.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_324011", "324011043", "story_v_out_324011.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_20 = math.max(var_179_11, arg_176_1.talkMaxDuration)

			if var_179_10 <= arg_176_1.time_ and arg_176_1.time_ < var_179_10 + var_179_20 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_10) / var_179_20

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_10 + var_179_20 and arg_176_1.time_ < var_179_10 + var_179_20 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play324011044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 324011044
		arg_180_1.duration_ = 3.1

		local var_180_0 = {
			zh = 2.533,
			ja = 3.1
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play324011045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1070ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1070ui_story == nil then
				arg_180_1.var_.characterEffect1070ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1070ui_story and not isNil(var_183_0) then
					arg_180_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1070ui_story then
				arg_180_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_183_4 = arg_180_1.actors_["10039ui_story"]
			local var_183_5 = 0

			if var_183_5 < arg_180_1.time_ and arg_180_1.time_ <= var_183_5 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.characterEffect10039ui_story == nil then
				arg_180_1.var_.characterEffect10039ui_story = var_183_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_6 = 0.200000002980232

			if var_183_5 <= arg_180_1.time_ and arg_180_1.time_ < var_183_5 + var_183_6 and not isNil(var_183_4) then
				local var_183_7 = (arg_180_1.time_ - var_183_5) / var_183_6

				if arg_180_1.var_.characterEffect10039ui_story and not isNil(var_183_4) then
					local var_183_8 = Mathf.Lerp(0, 0.5, var_183_7)

					arg_180_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_180_1.var_.characterEffect10039ui_story.fillRatio = var_183_8
				end
			end

			if arg_180_1.time_ >= var_183_5 + var_183_6 and arg_180_1.time_ < var_183_5 + var_183_6 + arg_183_0 and not isNil(var_183_4) and arg_180_1.var_.characterEffect10039ui_story then
				local var_183_9 = 0.5

				arg_180_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_180_1.var_.characterEffect10039ui_story.fillRatio = var_183_9
			end

			local var_183_10 = 0

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 then
				arg_180_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_2")
			end

			local var_183_11 = 0

			if var_183_11 < arg_180_1.time_ and arg_180_1.time_ <= var_183_11 + arg_183_0 then
				arg_180_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_183_12 = 0
			local var_183_13 = 0.3

			if var_183_12 < arg_180_1.time_ and arg_180_1.time_ <= var_183_12 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_14 = arg_180_1:FormatText(StoryNameCfg[318].name)

				arg_180_1.leftNameTxt_.text = var_183_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_15 = arg_180_1:GetWordFromCfg(324011044)
				local var_183_16 = arg_180_1:FormatText(var_183_15.content)

				arg_180_1.text_.text = var_183_16

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_17 = 12
				local var_183_18 = utf8.len(var_183_16)
				local var_183_19 = var_183_17 <= 0 and var_183_13 or var_183_13 * (var_183_18 / var_183_17)

				if var_183_19 > 0 and var_183_13 < var_183_19 then
					arg_180_1.talkMaxDuration = var_183_19

					if var_183_19 + var_183_12 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_19 + var_183_12
					end
				end

				arg_180_1.text_.text = var_183_16
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011044", "story_v_out_324011.awb") ~= 0 then
					local var_183_20 = manager.audio:GetVoiceLength("story_v_out_324011", "324011044", "story_v_out_324011.awb") / 1000

					if var_183_20 + var_183_12 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_20 + var_183_12
					end

					if var_183_15.prefab_name ~= "" and arg_180_1.actors_[var_183_15.prefab_name] ~= nil then
						local var_183_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_15.prefab_name].transform, "story_v_out_324011", "324011044", "story_v_out_324011.awb")

						arg_180_1:RecordAudio("324011044", var_183_21)
						arg_180_1:RecordAudio("324011044", var_183_21)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_324011", "324011044", "story_v_out_324011.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_324011", "324011044", "story_v_out_324011.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_22 = math.max(var_183_13, arg_180_1.talkMaxDuration)

			if var_183_12 <= arg_180_1.time_ and arg_180_1.time_ < var_183_12 + var_183_22 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_12) / var_183_22

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_12 + var_183_22 and arg_180_1.time_ < var_183_12 + var_183_22 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play324011045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 324011045
		arg_184_1.duration_ = 7.7

		local var_184_0 = {
			zh = 3.3,
			ja = 7.7
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
				arg_184_0:Play324011046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10039ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10039ui_story == nil then
				arg_184_1.var_.characterEffect10039ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect10039ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10039ui_story then
				arg_184_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_187_4 = arg_184_1.actors_["1070ui_story"]
			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect1070ui_story == nil then
				arg_184_1.var_.characterEffect1070ui_story = var_187_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_6 = 0.200000002980232

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_6 and not isNil(var_187_4) then
				local var_187_7 = (arg_184_1.time_ - var_187_5) / var_187_6

				if arg_184_1.var_.characterEffect1070ui_story and not isNil(var_187_4) then
					local var_187_8 = Mathf.Lerp(0, 0.5, var_187_7)

					arg_184_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1070ui_story.fillRatio = var_187_8
				end
			end

			if arg_184_1.time_ >= var_187_5 + var_187_6 and arg_184_1.time_ < var_187_5 + var_187_6 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect1070ui_story then
				local var_187_9 = 0.5

				arg_184_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1070ui_story.fillRatio = var_187_9
			end

			local var_187_10 = 0

			if var_187_10 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 then
				arg_184_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action452")
			end

			local var_187_11 = 0
			local var_187_12 = 0.3

			if var_187_11 < arg_184_1.time_ and arg_184_1.time_ <= var_187_11 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_13 = arg_184_1:FormatText(StoryNameCfg[472].name)

				arg_184_1.leftNameTxt_.text = var_187_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_14 = arg_184_1:GetWordFromCfg(324011045)
				local var_187_15 = arg_184_1:FormatText(var_187_14.content)

				arg_184_1.text_.text = var_187_15

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_16 = 12
				local var_187_17 = utf8.len(var_187_15)
				local var_187_18 = var_187_16 <= 0 and var_187_12 or var_187_12 * (var_187_17 / var_187_16)

				if var_187_18 > 0 and var_187_12 < var_187_18 then
					arg_184_1.talkMaxDuration = var_187_18

					if var_187_18 + var_187_11 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_18 + var_187_11
					end
				end

				arg_184_1.text_.text = var_187_15
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011045", "story_v_out_324011.awb") ~= 0 then
					local var_187_19 = manager.audio:GetVoiceLength("story_v_out_324011", "324011045", "story_v_out_324011.awb") / 1000

					if var_187_19 + var_187_11 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_19 + var_187_11
					end

					if var_187_14.prefab_name ~= "" and arg_184_1.actors_[var_187_14.prefab_name] ~= nil then
						local var_187_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_14.prefab_name].transform, "story_v_out_324011", "324011045", "story_v_out_324011.awb")

						arg_184_1:RecordAudio("324011045", var_187_20)
						arg_184_1:RecordAudio("324011045", var_187_20)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_324011", "324011045", "story_v_out_324011.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_324011", "324011045", "story_v_out_324011.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_21 = math.max(var_187_12, arg_184_1.talkMaxDuration)

			if var_187_11 <= arg_184_1.time_ and arg_184_1.time_ < var_187_11 + var_187_21 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_11) / var_187_21

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_11 + var_187_21 and arg_184_1.time_ < var_187_11 + var_187_21 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play324011046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 324011046
		arg_188_1.duration_ = 13.7

		local var_188_0 = {
			zh = 11.2,
			ja = 13.7
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
				arg_188_0:Play324011047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 1.2

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_2 = arg_188_1:FormatText(StoryNameCfg[472].name)

				arg_188_1.leftNameTxt_.text = var_191_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_3 = arg_188_1:GetWordFromCfg(324011046)
				local var_191_4 = arg_188_1:FormatText(var_191_3.content)

				arg_188_1.text_.text = var_191_4

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 48
				local var_191_6 = utf8.len(var_191_4)
				local var_191_7 = var_191_5 <= 0 and var_191_1 or var_191_1 * (var_191_6 / var_191_5)

				if var_191_7 > 0 and var_191_1 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_4
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011046", "story_v_out_324011.awb") ~= 0 then
					local var_191_8 = manager.audio:GetVoiceLength("story_v_out_324011", "324011046", "story_v_out_324011.awb") / 1000

					if var_191_8 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_0
					end

					if var_191_3.prefab_name ~= "" and arg_188_1.actors_[var_191_3.prefab_name] ~= nil then
						local var_191_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_3.prefab_name].transform, "story_v_out_324011", "324011046", "story_v_out_324011.awb")

						arg_188_1:RecordAudio("324011046", var_191_9)
						arg_188_1:RecordAudio("324011046", var_191_9)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_324011", "324011046", "story_v_out_324011.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_324011", "324011046", "story_v_out_324011.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_10 and arg_188_1.time_ < var_191_0 + var_191_10 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play324011047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 324011047
		arg_192_1.duration_ = 3.7

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play324011048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["1070ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1070ui_story == nil then
				arg_192_1.var_.characterEffect1070ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.200000002980232

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect1070ui_story and not isNil(var_195_0) then
					arg_192_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect1070ui_story then
				arg_192_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_195_4 = arg_192_1.actors_["10039ui_story"]
			local var_195_5 = 0

			if var_195_5 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect10039ui_story == nil then
				arg_192_1.var_.characterEffect10039ui_story = var_195_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_6 = 0.200000002980232

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_6 and not isNil(var_195_4) then
				local var_195_7 = (arg_192_1.time_ - var_195_5) / var_195_6

				if arg_192_1.var_.characterEffect10039ui_story and not isNil(var_195_4) then
					local var_195_8 = Mathf.Lerp(0, 0.5, var_195_7)

					arg_192_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_192_1.var_.characterEffect10039ui_story.fillRatio = var_195_8
				end
			end

			if arg_192_1.time_ >= var_195_5 + var_195_6 and arg_192_1.time_ < var_195_5 + var_195_6 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect10039ui_story then
				local var_195_9 = 0.5

				arg_192_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_192_1.var_.characterEffect10039ui_story.fillRatio = var_195_9
			end

			local var_195_10 = 0

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 then
				arg_192_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_195_11 = 0

			if var_195_11 < arg_192_1.time_ and arg_192_1.time_ <= var_195_11 + arg_195_0 then
				arg_192_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_195_12 = 0
			local var_195_13 = 0.4

			if var_195_12 < arg_192_1.time_ and arg_192_1.time_ <= var_195_12 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_14 = arg_192_1:FormatText(StoryNameCfg[318].name)

				arg_192_1.leftNameTxt_.text = var_195_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_15 = arg_192_1:GetWordFromCfg(324011047)
				local var_195_16 = arg_192_1:FormatText(var_195_15.content)

				arg_192_1.text_.text = var_195_16

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_17 = 16
				local var_195_18 = utf8.len(var_195_16)
				local var_195_19 = var_195_17 <= 0 and var_195_13 or var_195_13 * (var_195_18 / var_195_17)

				if var_195_19 > 0 and var_195_13 < var_195_19 then
					arg_192_1.talkMaxDuration = var_195_19

					if var_195_19 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_19 + var_195_12
					end
				end

				arg_192_1.text_.text = var_195_16
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011047", "story_v_out_324011.awb") ~= 0 then
					local var_195_20 = manager.audio:GetVoiceLength("story_v_out_324011", "324011047", "story_v_out_324011.awb") / 1000

					if var_195_20 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_20 + var_195_12
					end

					if var_195_15.prefab_name ~= "" and arg_192_1.actors_[var_195_15.prefab_name] ~= nil then
						local var_195_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_15.prefab_name].transform, "story_v_out_324011", "324011047", "story_v_out_324011.awb")

						arg_192_1:RecordAudio("324011047", var_195_21)
						arg_192_1:RecordAudio("324011047", var_195_21)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_324011", "324011047", "story_v_out_324011.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_324011", "324011047", "story_v_out_324011.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_22 = math.max(var_195_13, arg_192_1.talkMaxDuration)

			if var_195_12 <= arg_192_1.time_ and arg_192_1.time_ < var_195_12 + var_195_22 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_12) / var_195_22

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_12 + var_195_22 and arg_192_1.time_ < var_195_12 + var_195_22 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play324011048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 324011048
		arg_196_1.duration_ = 4.3

		local var_196_0 = {
			zh = 2.766,
			ja = 4.3
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play324011049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10039ui_story"]
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect10039ui_story == nil then
				arg_196_1.var_.characterEffect10039ui_story = var_199_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.200000002980232

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_2 and not isNil(var_199_0) then
				local var_199_3 = (arg_196_1.time_ - var_199_1) / var_199_2

				if arg_196_1.var_.characterEffect10039ui_story and not isNil(var_199_0) then
					arg_196_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= var_199_1 + var_199_2 and arg_196_1.time_ < var_199_1 + var_199_2 + arg_199_0 and not isNil(var_199_0) and arg_196_1.var_.characterEffect10039ui_story then
				arg_196_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_199_4 = arg_196_1.actors_["1070ui_story"]
			local var_199_5 = 0

			if var_199_5 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 and not isNil(var_199_4) and arg_196_1.var_.characterEffect1070ui_story == nil then
				arg_196_1.var_.characterEffect1070ui_story = var_199_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_6 = 0.200000002980232

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_6 and not isNil(var_199_4) then
				local var_199_7 = (arg_196_1.time_ - var_199_5) / var_199_6

				if arg_196_1.var_.characterEffect1070ui_story and not isNil(var_199_4) then
					local var_199_8 = Mathf.Lerp(0, 0.5, var_199_7)

					arg_196_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_196_1.var_.characterEffect1070ui_story.fillRatio = var_199_8
				end
			end

			if arg_196_1.time_ >= var_199_5 + var_199_6 and arg_196_1.time_ < var_199_5 + var_199_6 + arg_199_0 and not isNil(var_199_4) and arg_196_1.var_.characterEffect1070ui_story then
				local var_199_9 = 0.5

				arg_196_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_196_1.var_.characterEffect1070ui_story.fillRatio = var_199_9
			end

			local var_199_10 = 0

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 then
				arg_196_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action2_2")
			end

			local var_199_11 = 0

			if var_199_11 < arg_196_1.time_ and arg_196_1.time_ <= var_199_11 + arg_199_0 then
				arg_196_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_199_12 = 0
			local var_199_13 = 0.2

			if var_199_12 < arg_196_1.time_ and arg_196_1.time_ <= var_199_12 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_14 = arg_196_1:FormatText(StoryNameCfg[472].name)

				arg_196_1.leftNameTxt_.text = var_199_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_15 = arg_196_1:GetWordFromCfg(324011048)
				local var_199_16 = arg_196_1:FormatText(var_199_15.content)

				arg_196_1.text_.text = var_199_16

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_17 = 8
				local var_199_18 = utf8.len(var_199_16)
				local var_199_19 = var_199_17 <= 0 and var_199_13 or var_199_13 * (var_199_18 / var_199_17)

				if var_199_19 > 0 and var_199_13 < var_199_19 then
					arg_196_1.talkMaxDuration = var_199_19

					if var_199_19 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_19 + var_199_12
					end
				end

				arg_196_1.text_.text = var_199_16
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011048", "story_v_out_324011.awb") ~= 0 then
					local var_199_20 = manager.audio:GetVoiceLength("story_v_out_324011", "324011048", "story_v_out_324011.awb") / 1000

					if var_199_20 + var_199_12 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_20 + var_199_12
					end

					if var_199_15.prefab_name ~= "" and arg_196_1.actors_[var_199_15.prefab_name] ~= nil then
						local var_199_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_15.prefab_name].transform, "story_v_out_324011", "324011048", "story_v_out_324011.awb")

						arg_196_1:RecordAudio("324011048", var_199_21)
						arg_196_1:RecordAudio("324011048", var_199_21)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_324011", "324011048", "story_v_out_324011.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_324011", "324011048", "story_v_out_324011.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_22 = math.max(var_199_13, arg_196_1.talkMaxDuration)

			if var_199_12 <= arg_196_1.time_ and arg_196_1.time_ < var_199_12 + var_199_22 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_12) / var_199_22

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_12 + var_199_22 and arg_196_1.time_ < var_199_12 + var_199_22 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play324011049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 324011049
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play324011050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10039ui_story"]
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect10039ui_story == nil then
				arg_200_1.var_.characterEffect10039ui_story = var_203_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_2 and not isNil(var_203_0) then
				local var_203_3 = (arg_200_1.time_ - var_203_1) / var_203_2

				if arg_200_1.var_.characterEffect10039ui_story and not isNil(var_203_0) then
					local var_203_4 = Mathf.Lerp(0, 0.5, var_203_3)

					arg_200_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_200_1.var_.characterEffect10039ui_story.fillRatio = var_203_4
				end
			end

			if arg_200_1.time_ >= var_203_1 + var_203_2 and arg_200_1.time_ < var_203_1 + var_203_2 + arg_203_0 and not isNil(var_203_0) and arg_200_1.var_.characterEffect10039ui_story then
				local var_203_5 = 0.5

				arg_200_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_200_1.var_.characterEffect10039ui_story.fillRatio = var_203_5
			end

			local var_203_6 = 0

			if var_203_6 < arg_200_1.time_ and arg_200_1.time_ <= var_203_6 + arg_203_0 then
				arg_200_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_203_7 = 0
			local var_203_8 = 0.975

			if var_203_7 < arg_200_1.time_ and arg_200_1.time_ <= var_203_7 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_9 = arg_200_1:GetWordFromCfg(324011049)
				local var_203_10 = arg_200_1:FormatText(var_203_9.content)

				arg_200_1.text_.text = var_203_10

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_11 = 39
				local var_203_12 = utf8.len(var_203_10)
				local var_203_13 = var_203_11 <= 0 and var_203_8 or var_203_8 * (var_203_12 / var_203_11)

				if var_203_13 > 0 and var_203_8 < var_203_13 then
					arg_200_1.talkMaxDuration = var_203_13

					if var_203_13 + var_203_7 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_13 + var_203_7
					end
				end

				arg_200_1.text_.text = var_203_10
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_14 = math.max(var_203_8, arg_200_1.talkMaxDuration)

			if var_203_7 <= arg_200_1.time_ and arg_200_1.time_ < var_203_7 + var_203_14 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_7) / var_203_14

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_7 + var_203_14 and arg_200_1.time_ < var_203_7 + var_203_14 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play324011050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 324011050
		arg_204_1.duration_ = 9.5

		local var_204_0 = {
			zh = 9.5,
			ja = 8.966
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
				arg_204_0:Play324011051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["10039ui_story"]
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect10039ui_story == nil then
				arg_204_1.var_.characterEffect10039ui_story = var_207_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_2 = 0.200000002980232

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_2 and not isNil(var_207_0) then
				local var_207_3 = (arg_204_1.time_ - var_207_1) / var_207_2

				if arg_204_1.var_.characterEffect10039ui_story and not isNil(var_207_0) then
					arg_204_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_1 + var_207_2 and arg_204_1.time_ < var_207_1 + var_207_2 + arg_207_0 and not isNil(var_207_0) and arg_204_1.var_.characterEffect10039ui_story then
				arg_204_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_207_4 = 0

			if var_207_4 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_207_5 = 0

			if var_207_5 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 then
				arg_204_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_207_6 = 0
			local var_207_7 = 1

			if var_207_6 < arg_204_1.time_ and arg_204_1.time_ <= var_207_6 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_8 = arg_204_1:FormatText(StoryNameCfg[472].name)

				arg_204_1.leftNameTxt_.text = var_207_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_9 = arg_204_1:GetWordFromCfg(324011050)
				local var_207_10 = arg_204_1:FormatText(var_207_9.content)

				arg_204_1.text_.text = var_207_10

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_11 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011050", "story_v_out_324011.awb") ~= 0 then
					local var_207_14 = manager.audio:GetVoiceLength("story_v_out_324011", "324011050", "story_v_out_324011.awb") / 1000

					if var_207_14 + var_207_6 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_14 + var_207_6
					end

					if var_207_9.prefab_name ~= "" and arg_204_1.actors_[var_207_9.prefab_name] ~= nil then
						local var_207_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_9.prefab_name].transform, "story_v_out_324011", "324011050", "story_v_out_324011.awb")

						arg_204_1:RecordAudio("324011050", var_207_15)
						arg_204_1:RecordAudio("324011050", var_207_15)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_324011", "324011050", "story_v_out_324011.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_324011", "324011050", "story_v_out_324011.awb")
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
	Play324011051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 324011051
		arg_208_1.duration_ = 6.57

		local var_208_0 = {
			zh = 5.533,
			ja = 6.566
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play324011052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["1070ui_story"]
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1070ui_story == nil then
				arg_208_1.var_.characterEffect1070ui_story = var_211_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_2 and not isNil(var_211_0) then
				local var_211_3 = (arg_208_1.time_ - var_211_1) / var_211_2

				if arg_208_1.var_.characterEffect1070ui_story and not isNil(var_211_0) then
					arg_208_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_1 + var_211_2 and arg_208_1.time_ < var_211_1 + var_211_2 + arg_211_0 and not isNil(var_211_0) and arg_208_1.var_.characterEffect1070ui_story then
				arg_208_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_211_4 = arg_208_1.actors_["10039ui_story"]
			local var_211_5 = 0

			if var_211_5 < arg_208_1.time_ and arg_208_1.time_ <= var_211_5 + arg_211_0 and not isNil(var_211_4) and arg_208_1.var_.characterEffect10039ui_story == nil then
				arg_208_1.var_.characterEffect10039ui_story = var_211_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_6 = 0.200000002980232

			if var_211_5 <= arg_208_1.time_ and arg_208_1.time_ < var_211_5 + var_211_6 and not isNil(var_211_4) then
				local var_211_7 = (arg_208_1.time_ - var_211_5) / var_211_6

				if arg_208_1.var_.characterEffect10039ui_story and not isNil(var_211_4) then
					local var_211_8 = Mathf.Lerp(0, 0.5, var_211_7)

					arg_208_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10039ui_story.fillRatio = var_211_8
				end
			end

			if arg_208_1.time_ >= var_211_5 + var_211_6 and arg_208_1.time_ < var_211_5 + var_211_6 + arg_211_0 and not isNil(var_211_4) and arg_208_1.var_.characterEffect10039ui_story then
				local var_211_9 = 0.5

				arg_208_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10039ui_story.fillRatio = var_211_9
			end

			local var_211_10 = 0
			local var_211_11 = 0.525

			if var_211_10 < arg_208_1.time_ and arg_208_1.time_ <= var_211_10 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_12 = arg_208_1:FormatText(StoryNameCfg[318].name)

				arg_208_1.leftNameTxt_.text = var_211_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_13 = arg_208_1:GetWordFromCfg(324011051)
				local var_211_14 = arg_208_1:FormatText(var_211_13.content)

				arg_208_1.text_.text = var_211_14

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_15 = 21
				local var_211_16 = utf8.len(var_211_14)
				local var_211_17 = var_211_15 <= 0 and var_211_11 or var_211_11 * (var_211_16 / var_211_15)

				if var_211_17 > 0 and var_211_11 < var_211_17 then
					arg_208_1.talkMaxDuration = var_211_17

					if var_211_17 + var_211_10 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_17 + var_211_10
					end
				end

				arg_208_1.text_.text = var_211_14
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011051", "story_v_out_324011.awb") ~= 0 then
					local var_211_18 = manager.audio:GetVoiceLength("story_v_out_324011", "324011051", "story_v_out_324011.awb") / 1000

					if var_211_18 + var_211_10 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_18 + var_211_10
					end

					if var_211_13.prefab_name ~= "" and arg_208_1.actors_[var_211_13.prefab_name] ~= nil then
						local var_211_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_13.prefab_name].transform, "story_v_out_324011", "324011051", "story_v_out_324011.awb")

						arg_208_1:RecordAudio("324011051", var_211_19)
						arg_208_1:RecordAudio("324011051", var_211_19)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_324011", "324011051", "story_v_out_324011.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_324011", "324011051", "story_v_out_324011.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_20 = math.max(var_211_11, arg_208_1.talkMaxDuration)

			if var_211_10 <= arg_208_1.time_ and arg_208_1.time_ < var_211_10 + var_211_20 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_10) / var_211_20

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_10 + var_211_20 and arg_208_1.time_ < var_211_10 + var_211_20 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play324011052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 324011052
		arg_212_1.duration_ = 6.3

		local var_212_0 = {
			zh = 3.166,
			ja = 6.3
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
				arg_212_0:Play324011053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["10039ui_story"]
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect10039ui_story == nil then
				arg_212_1.var_.characterEffect10039ui_story = var_215_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_2 = 0.200000002980232

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_2 and not isNil(var_215_0) then
				local var_215_3 = (arg_212_1.time_ - var_215_1) / var_215_2

				if arg_212_1.var_.characterEffect10039ui_story and not isNil(var_215_0) then
					arg_212_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_1 + var_215_2 and arg_212_1.time_ < var_215_1 + var_215_2 + arg_215_0 and not isNil(var_215_0) and arg_212_1.var_.characterEffect10039ui_story then
				arg_212_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_215_4 = arg_212_1.actors_["1070ui_story"]
			local var_215_5 = 0

			if var_215_5 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 and not isNil(var_215_4) and arg_212_1.var_.characterEffect1070ui_story == nil then
				arg_212_1.var_.characterEffect1070ui_story = var_215_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_6 = 0.200000002980232

			if var_215_5 <= arg_212_1.time_ and arg_212_1.time_ < var_215_5 + var_215_6 and not isNil(var_215_4) then
				local var_215_7 = (arg_212_1.time_ - var_215_5) / var_215_6

				if arg_212_1.var_.characterEffect1070ui_story and not isNil(var_215_4) then
					local var_215_8 = Mathf.Lerp(0, 0.5, var_215_7)

					arg_212_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1070ui_story.fillRatio = var_215_8
				end
			end

			if arg_212_1.time_ >= var_215_5 + var_215_6 and arg_212_1.time_ < var_215_5 + var_215_6 + arg_215_0 and not isNil(var_215_4) and arg_212_1.var_.characterEffect1070ui_story then
				local var_215_9 = 0.5

				arg_212_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1070ui_story.fillRatio = var_215_9
			end

			local var_215_10 = 0

			if var_215_10 < arg_212_1.time_ and arg_212_1.time_ <= var_215_10 + arg_215_0 then
				arg_212_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_1")
			end

			local var_215_11 = 0
			local var_215_12 = 0.325

			if var_215_11 < arg_212_1.time_ and arg_212_1.time_ <= var_215_11 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_13 = arg_212_1:FormatText(StoryNameCfg[472].name)

				arg_212_1.leftNameTxt_.text = var_215_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_14 = arg_212_1:GetWordFromCfg(324011052)
				local var_215_15 = arg_212_1:FormatText(var_215_14.content)

				arg_212_1.text_.text = var_215_15

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_16 = 13
				local var_215_17 = utf8.len(var_215_15)
				local var_215_18 = var_215_16 <= 0 and var_215_12 or var_215_12 * (var_215_17 / var_215_16)

				if var_215_18 > 0 and var_215_12 < var_215_18 then
					arg_212_1.talkMaxDuration = var_215_18

					if var_215_18 + var_215_11 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_18 + var_215_11
					end
				end

				arg_212_1.text_.text = var_215_15
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011052", "story_v_out_324011.awb") ~= 0 then
					local var_215_19 = manager.audio:GetVoiceLength("story_v_out_324011", "324011052", "story_v_out_324011.awb") / 1000

					if var_215_19 + var_215_11 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_19 + var_215_11
					end

					if var_215_14.prefab_name ~= "" and arg_212_1.actors_[var_215_14.prefab_name] ~= nil then
						local var_215_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_14.prefab_name].transform, "story_v_out_324011", "324011052", "story_v_out_324011.awb")

						arg_212_1:RecordAudio("324011052", var_215_20)
						arg_212_1:RecordAudio("324011052", var_215_20)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_324011", "324011052", "story_v_out_324011.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_324011", "324011052", "story_v_out_324011.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_21 = math.max(var_215_12, arg_212_1.talkMaxDuration)

			if var_215_11 <= arg_212_1.time_ and arg_212_1.time_ < var_215_11 + var_215_21 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_11) / var_215_21

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_11 + var_215_21 and arg_212_1.time_ < var_215_11 + var_215_21 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play324011053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 324011053
		arg_216_1.duration_ = 3.9

		local var_216_0 = {
			zh = 3.9,
			ja = 3.866
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
				arg_216_0:Play324011054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["1070ui_story"]
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1070ui_story == nil then
				arg_216_1.var_.characterEffect1070ui_story = var_219_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_2 and not isNil(var_219_0) then
				local var_219_3 = (arg_216_1.time_ - var_219_1) / var_219_2

				if arg_216_1.var_.characterEffect1070ui_story and not isNil(var_219_0) then
					arg_216_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_1 + var_219_2 and arg_216_1.time_ < var_219_1 + var_219_2 + arg_219_0 and not isNil(var_219_0) and arg_216_1.var_.characterEffect1070ui_story then
				arg_216_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_219_4 = arg_216_1.actors_["10039ui_story"]
			local var_219_5 = 0

			if var_219_5 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 and not isNil(var_219_4) and arg_216_1.var_.characterEffect10039ui_story == nil then
				arg_216_1.var_.characterEffect10039ui_story = var_219_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_6 = 0.200000002980232

			if var_219_5 <= arg_216_1.time_ and arg_216_1.time_ < var_219_5 + var_219_6 and not isNil(var_219_4) then
				local var_219_7 = (arg_216_1.time_ - var_219_5) / var_219_6

				if arg_216_1.var_.characterEffect10039ui_story and not isNil(var_219_4) then
					local var_219_8 = Mathf.Lerp(0, 0.5, var_219_7)

					arg_216_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10039ui_story.fillRatio = var_219_8
				end
			end

			if arg_216_1.time_ >= var_219_5 + var_219_6 and arg_216_1.time_ < var_219_5 + var_219_6 + arg_219_0 and not isNil(var_219_4) and arg_216_1.var_.characterEffect10039ui_story then
				local var_219_9 = 0.5

				arg_216_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10039ui_story.fillRatio = var_219_9
			end

			local var_219_10 = 0

			if var_219_10 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 then
				arg_216_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			local var_219_11 = 0
			local var_219_12 = 0.425

			if var_219_11 < arg_216_1.time_ and arg_216_1.time_ <= var_219_11 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_13 = arg_216_1:FormatText(StoryNameCfg[318].name)

				arg_216_1.leftNameTxt_.text = var_219_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_14 = arg_216_1:GetWordFromCfg(324011053)
				local var_219_15 = arg_216_1:FormatText(var_219_14.content)

				arg_216_1.text_.text = var_219_15

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_16 = 17
				local var_219_17 = utf8.len(var_219_15)
				local var_219_18 = var_219_16 <= 0 and var_219_12 or var_219_12 * (var_219_17 / var_219_16)

				if var_219_18 > 0 and var_219_12 < var_219_18 then
					arg_216_1.talkMaxDuration = var_219_18

					if var_219_18 + var_219_11 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_18 + var_219_11
					end
				end

				arg_216_1.text_.text = var_219_15
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011053", "story_v_out_324011.awb") ~= 0 then
					local var_219_19 = manager.audio:GetVoiceLength("story_v_out_324011", "324011053", "story_v_out_324011.awb") / 1000

					if var_219_19 + var_219_11 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_19 + var_219_11
					end

					if var_219_14.prefab_name ~= "" and arg_216_1.actors_[var_219_14.prefab_name] ~= nil then
						local var_219_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_14.prefab_name].transform, "story_v_out_324011", "324011053", "story_v_out_324011.awb")

						arg_216_1:RecordAudio("324011053", var_219_20)
						arg_216_1:RecordAudio("324011053", var_219_20)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_324011", "324011053", "story_v_out_324011.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_324011", "324011053", "story_v_out_324011.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_21 = math.max(var_219_12, arg_216_1.talkMaxDuration)

			if var_219_11 <= arg_216_1.time_ and arg_216_1.time_ < var_219_11 + var_219_21 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_11) / var_219_21

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_11 + var_219_21 and arg_216_1.time_ < var_219_11 + var_219_21 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play324011054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 324011054
		arg_220_1.duration_ = 9.4

		local var_220_0 = {
			zh = 7.533,
			ja = 9.4
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play324011055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["10039ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect10039ui_story == nil then
				arg_220_1.var_.characterEffect10039ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect10039ui_story and not isNil(var_223_0) then
					arg_220_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect10039ui_story then
				arg_220_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_223_4 = arg_220_1.actors_["1070ui_story"]
			local var_223_5 = 0

			if var_223_5 < arg_220_1.time_ and arg_220_1.time_ <= var_223_5 + arg_223_0 and not isNil(var_223_4) and arg_220_1.var_.characterEffect1070ui_story == nil then
				arg_220_1.var_.characterEffect1070ui_story = var_223_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_6 = 0.200000002980232

			if var_223_5 <= arg_220_1.time_ and arg_220_1.time_ < var_223_5 + var_223_6 and not isNil(var_223_4) then
				local var_223_7 = (arg_220_1.time_ - var_223_5) / var_223_6

				if arg_220_1.var_.characterEffect1070ui_story and not isNil(var_223_4) then
					local var_223_8 = Mathf.Lerp(0, 0.5, var_223_7)

					arg_220_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1070ui_story.fillRatio = var_223_8
				end
			end

			if arg_220_1.time_ >= var_223_5 + var_223_6 and arg_220_1.time_ < var_223_5 + var_223_6 + arg_223_0 and not isNil(var_223_4) and arg_220_1.var_.characterEffect1070ui_story then
				local var_223_9 = 0.5

				arg_220_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1070ui_story.fillRatio = var_223_9
			end

			local var_223_10 = 0

			if var_223_10 < arg_220_1.time_ and arg_220_1.time_ <= var_223_10 + arg_223_0 then
				arg_220_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_2")
			end

			local var_223_11 = 0
			local var_223_12 = 0.725

			if var_223_11 < arg_220_1.time_ and arg_220_1.time_ <= var_223_11 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_13 = arg_220_1:FormatText(StoryNameCfg[472].name)

				arg_220_1.leftNameTxt_.text = var_223_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_14 = arg_220_1:GetWordFromCfg(324011054)
				local var_223_15 = arg_220_1:FormatText(var_223_14.content)

				arg_220_1.text_.text = var_223_15

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_16 = 29
				local var_223_17 = utf8.len(var_223_15)
				local var_223_18 = var_223_16 <= 0 and var_223_12 or var_223_12 * (var_223_17 / var_223_16)

				if var_223_18 > 0 and var_223_12 < var_223_18 then
					arg_220_1.talkMaxDuration = var_223_18

					if var_223_18 + var_223_11 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_18 + var_223_11
					end
				end

				arg_220_1.text_.text = var_223_15
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011054", "story_v_out_324011.awb") ~= 0 then
					local var_223_19 = manager.audio:GetVoiceLength("story_v_out_324011", "324011054", "story_v_out_324011.awb") / 1000

					if var_223_19 + var_223_11 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_19 + var_223_11
					end

					if var_223_14.prefab_name ~= "" and arg_220_1.actors_[var_223_14.prefab_name] ~= nil then
						local var_223_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_14.prefab_name].transform, "story_v_out_324011", "324011054", "story_v_out_324011.awb")

						arg_220_1:RecordAudio("324011054", var_223_20)
						arg_220_1:RecordAudio("324011054", var_223_20)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_324011", "324011054", "story_v_out_324011.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_324011", "324011054", "story_v_out_324011.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_21 = math.max(var_223_12, arg_220_1.talkMaxDuration)

			if var_223_11 <= arg_220_1.time_ and arg_220_1.time_ < var_223_11 + var_223_21 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_11) / var_223_21

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_11 + var_223_21 and arg_220_1.time_ < var_223_11 + var_223_21 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play324011055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 324011055
		arg_224_1.duration_ = 2.3

		local var_224_0 = {
			zh = 2.3,
			ja = 2.2
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
				arg_224_0:Play324011056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["1070ui_story"]
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1070ui_story == nil then
				arg_224_1.var_.characterEffect1070ui_story = var_227_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_2 and not isNil(var_227_0) then
				local var_227_3 = (arg_224_1.time_ - var_227_1) / var_227_2

				if arg_224_1.var_.characterEffect1070ui_story and not isNil(var_227_0) then
					arg_224_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= var_227_1 + var_227_2 and arg_224_1.time_ < var_227_1 + var_227_2 + arg_227_0 and not isNil(var_227_0) and arg_224_1.var_.characterEffect1070ui_story then
				arg_224_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_227_4 = arg_224_1.actors_["10039ui_story"]
			local var_227_5 = 0

			if var_227_5 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 and not isNil(var_227_4) and arg_224_1.var_.characterEffect10039ui_story == nil then
				arg_224_1.var_.characterEffect10039ui_story = var_227_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_6 = 0.200000002980232

			if var_227_5 <= arg_224_1.time_ and arg_224_1.time_ < var_227_5 + var_227_6 and not isNil(var_227_4) then
				local var_227_7 = (arg_224_1.time_ - var_227_5) / var_227_6

				if arg_224_1.var_.characterEffect10039ui_story and not isNil(var_227_4) then
					local var_227_8 = Mathf.Lerp(0, 0.5, var_227_7)

					arg_224_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_224_1.var_.characterEffect10039ui_story.fillRatio = var_227_8
				end
			end

			if arg_224_1.time_ >= var_227_5 + var_227_6 and arg_224_1.time_ < var_227_5 + var_227_6 + arg_227_0 and not isNil(var_227_4) and arg_224_1.var_.characterEffect10039ui_story then
				local var_227_9 = 0.5

				arg_224_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_224_1.var_.characterEffect10039ui_story.fillRatio = var_227_9
			end

			local var_227_10 = 0

			if var_227_10 < arg_224_1.time_ and arg_224_1.time_ <= var_227_10 + arg_227_0 then
				arg_224_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_2")
			end

			local var_227_11 = 0

			if var_227_11 < arg_224_1.time_ and arg_224_1.time_ <= var_227_11 + arg_227_0 then
				arg_224_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_227_12 = 0
			local var_227_13 = 0.125

			if var_227_12 < arg_224_1.time_ and arg_224_1.time_ <= var_227_12 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_14 = arg_224_1:FormatText(StoryNameCfg[318].name)

				arg_224_1.leftNameTxt_.text = var_227_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_15 = arg_224_1:GetWordFromCfg(324011055)
				local var_227_16 = arg_224_1:FormatText(var_227_15.content)

				arg_224_1.text_.text = var_227_16

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_17 = 5
				local var_227_18 = utf8.len(var_227_16)
				local var_227_19 = var_227_17 <= 0 and var_227_13 or var_227_13 * (var_227_18 / var_227_17)

				if var_227_19 > 0 and var_227_13 < var_227_19 then
					arg_224_1.talkMaxDuration = var_227_19

					if var_227_19 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_19 + var_227_12
					end
				end

				arg_224_1.text_.text = var_227_16
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011055", "story_v_out_324011.awb") ~= 0 then
					local var_227_20 = manager.audio:GetVoiceLength("story_v_out_324011", "324011055", "story_v_out_324011.awb") / 1000

					if var_227_20 + var_227_12 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_20 + var_227_12
					end

					if var_227_15.prefab_name ~= "" and arg_224_1.actors_[var_227_15.prefab_name] ~= nil then
						local var_227_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_15.prefab_name].transform, "story_v_out_324011", "324011055", "story_v_out_324011.awb")

						arg_224_1:RecordAudio("324011055", var_227_21)
						arg_224_1:RecordAudio("324011055", var_227_21)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_324011", "324011055", "story_v_out_324011.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_324011", "324011055", "story_v_out_324011.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_22 = math.max(var_227_13, arg_224_1.talkMaxDuration)

			if var_227_12 <= arg_224_1.time_ and arg_224_1.time_ < var_227_12 + var_227_22 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_12) / var_227_22

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_12 + var_227_22 and arg_224_1.time_ < var_227_12 + var_227_22 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play324011056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 324011056
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play324011057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["1070ui_story"]
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1070ui_story == nil then
				arg_228_1.var_.characterEffect1070ui_story = var_231_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_2 and not isNil(var_231_0) then
				local var_231_3 = (arg_228_1.time_ - var_231_1) / var_231_2

				if arg_228_1.var_.characterEffect1070ui_story and not isNil(var_231_0) then
					local var_231_4 = Mathf.Lerp(0, 0.5, var_231_3)

					arg_228_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1070ui_story.fillRatio = var_231_4
				end
			end

			if arg_228_1.time_ >= var_231_1 + var_231_2 and arg_228_1.time_ < var_231_1 + var_231_2 + arg_231_0 and not isNil(var_231_0) and arg_228_1.var_.characterEffect1070ui_story then
				local var_231_5 = 0.5

				arg_228_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1070ui_story.fillRatio = var_231_5
			end

			local var_231_6 = 0
			local var_231_7 = 0.55

			if var_231_6 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_8 = arg_228_1:GetWordFromCfg(324011056)
				local var_231_9 = arg_228_1:FormatText(var_231_8.content)

				arg_228_1.text_.text = var_231_9

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_10 = 22
				local var_231_11 = utf8.len(var_231_9)
				local var_231_12 = var_231_10 <= 0 and var_231_7 or var_231_7 * (var_231_11 / var_231_10)

				if var_231_12 > 0 and var_231_7 < var_231_12 then
					arg_228_1.talkMaxDuration = var_231_12

					if var_231_12 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_12 + var_231_6
					end
				end

				arg_228_1.text_.text = var_231_9
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_13 = math.max(var_231_7, arg_228_1.talkMaxDuration)

			if var_231_6 <= arg_228_1.time_ and arg_228_1.time_ < var_231_6 + var_231_13 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_6) / var_231_13

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_6 + var_231_13 and arg_228_1.time_ < var_231_6 + var_231_13 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play324011057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 324011057
		arg_232_1.duration_ = 12.27

		local var_232_0 = {
			zh = 6.7,
			ja = 12.266
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
				arg_232_0:Play324011058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["1070ui_story"]
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1070ui_story == nil then
				arg_232_1.var_.characterEffect1070ui_story = var_235_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_2 and not isNil(var_235_0) then
				local var_235_3 = (arg_232_1.time_ - var_235_1) / var_235_2

				if arg_232_1.var_.characterEffect1070ui_story and not isNil(var_235_0) then
					arg_232_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_1 + var_235_2 and arg_232_1.time_ < var_235_1 + var_235_2 + arg_235_0 and not isNil(var_235_0) and arg_232_1.var_.characterEffect1070ui_story then
				arg_232_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_235_4 = 0

			if var_235_4 < arg_232_1.time_ and arg_232_1.time_ <= var_235_4 + arg_235_0 then
				arg_232_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_235_5 = 0

			if var_235_5 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 then
				arg_232_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_235_6 = 0
			local var_235_7 = 0.75

			if var_235_6 < arg_232_1.time_ and arg_232_1.time_ <= var_235_6 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_8 = arg_232_1:FormatText(StoryNameCfg[318].name)

				arg_232_1.leftNameTxt_.text = var_235_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_9 = arg_232_1:GetWordFromCfg(324011057)
				local var_235_10 = arg_232_1:FormatText(var_235_9.content)

				arg_232_1.text_.text = var_235_10

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_11 = 30
				local var_235_12 = utf8.len(var_235_10)
				local var_235_13 = var_235_11 <= 0 and var_235_7 or var_235_7 * (var_235_12 / var_235_11)

				if var_235_13 > 0 and var_235_7 < var_235_13 then
					arg_232_1.talkMaxDuration = var_235_13

					if var_235_13 + var_235_6 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_13 + var_235_6
					end
				end

				arg_232_1.text_.text = var_235_10
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011057", "story_v_out_324011.awb") ~= 0 then
					local var_235_14 = manager.audio:GetVoiceLength("story_v_out_324011", "324011057", "story_v_out_324011.awb") / 1000

					if var_235_14 + var_235_6 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_14 + var_235_6
					end

					if var_235_9.prefab_name ~= "" and arg_232_1.actors_[var_235_9.prefab_name] ~= nil then
						local var_235_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_9.prefab_name].transform, "story_v_out_324011", "324011057", "story_v_out_324011.awb")

						arg_232_1:RecordAudio("324011057", var_235_15)
						arg_232_1:RecordAudio("324011057", var_235_15)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_324011", "324011057", "story_v_out_324011.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_324011", "324011057", "story_v_out_324011.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_16 = math.max(var_235_7, arg_232_1.talkMaxDuration)

			if var_235_6 <= arg_232_1.time_ and arg_232_1.time_ < var_235_6 + var_235_16 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_6) / var_235_16

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_6 + var_235_16 and arg_232_1.time_ < var_235_6 + var_235_16 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play324011058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 324011058
		arg_236_1.duration_ = 4.87

		local var_236_0 = {
			zh = 2.1,
			ja = 4.866
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play324011059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10039ui_story"]
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect10039ui_story == nil then
				arg_236_1.var_.characterEffect10039ui_story = var_239_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_2 and not isNil(var_239_0) then
				local var_239_3 = (arg_236_1.time_ - var_239_1) / var_239_2

				if arg_236_1.var_.characterEffect10039ui_story and not isNil(var_239_0) then
					arg_236_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= var_239_1 + var_239_2 and arg_236_1.time_ < var_239_1 + var_239_2 + arg_239_0 and not isNil(var_239_0) and arg_236_1.var_.characterEffect10039ui_story then
				arg_236_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_239_4 = arg_236_1.actors_["1070ui_story"]
			local var_239_5 = 0

			if var_239_5 < arg_236_1.time_ and arg_236_1.time_ <= var_239_5 + arg_239_0 and not isNil(var_239_4) and arg_236_1.var_.characterEffect1070ui_story == nil then
				arg_236_1.var_.characterEffect1070ui_story = var_239_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_6 = 0.200000002980232

			if var_239_5 <= arg_236_1.time_ and arg_236_1.time_ < var_239_5 + var_239_6 and not isNil(var_239_4) then
				local var_239_7 = (arg_236_1.time_ - var_239_5) / var_239_6

				if arg_236_1.var_.characterEffect1070ui_story and not isNil(var_239_4) then
					local var_239_8 = Mathf.Lerp(0, 0.5, var_239_7)

					arg_236_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_236_1.var_.characterEffect1070ui_story.fillRatio = var_239_8
				end
			end

			if arg_236_1.time_ >= var_239_5 + var_239_6 and arg_236_1.time_ < var_239_5 + var_239_6 + arg_239_0 and not isNil(var_239_4) and arg_236_1.var_.characterEffect1070ui_story then
				local var_239_9 = 0.5

				arg_236_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_236_1.var_.characterEffect1070ui_story.fillRatio = var_239_9
			end

			local var_239_10 = 0
			local var_239_11 = 0.225

			if var_239_10 < arg_236_1.time_ and arg_236_1.time_ <= var_239_10 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_12 = arg_236_1:FormatText(StoryNameCfg[472].name)

				arg_236_1.leftNameTxt_.text = var_239_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_13 = arg_236_1:GetWordFromCfg(324011058)
				local var_239_14 = arg_236_1:FormatText(var_239_13.content)

				arg_236_1.text_.text = var_239_14

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_15 = 9
				local var_239_16 = utf8.len(var_239_14)
				local var_239_17 = var_239_15 <= 0 and var_239_11 or var_239_11 * (var_239_16 / var_239_15)

				if var_239_17 > 0 and var_239_11 < var_239_17 then
					arg_236_1.talkMaxDuration = var_239_17

					if var_239_17 + var_239_10 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_17 + var_239_10
					end
				end

				arg_236_1.text_.text = var_239_14
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011058", "story_v_out_324011.awb") ~= 0 then
					local var_239_18 = manager.audio:GetVoiceLength("story_v_out_324011", "324011058", "story_v_out_324011.awb") / 1000

					if var_239_18 + var_239_10 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_18 + var_239_10
					end

					if var_239_13.prefab_name ~= "" and arg_236_1.actors_[var_239_13.prefab_name] ~= nil then
						local var_239_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_13.prefab_name].transform, "story_v_out_324011", "324011058", "story_v_out_324011.awb")

						arg_236_1:RecordAudio("324011058", var_239_19)
						arg_236_1:RecordAudio("324011058", var_239_19)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_324011", "324011058", "story_v_out_324011.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_324011", "324011058", "story_v_out_324011.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_20 = math.max(var_239_11, arg_236_1.talkMaxDuration)

			if var_239_10 <= arg_236_1.time_ and arg_236_1.time_ < var_239_10 + var_239_20 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_10) / var_239_20

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_10 + var_239_20 and arg_236_1.time_ < var_239_10 + var_239_20 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play324011059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 324011059
		arg_240_1.duration_ = 16.4

		local var_240_0 = {
			zh = 11.466,
			ja = 16.4
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
				arg_240_0:Play324011060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_1")
			end

			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_243_2 = 0
			local var_243_3 = 1.2

			if var_243_2 < arg_240_1.time_ and arg_240_1.time_ <= var_243_2 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_4 = arg_240_1:FormatText(StoryNameCfg[472].name)

				arg_240_1.leftNameTxt_.text = var_243_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_5 = arg_240_1:GetWordFromCfg(324011059)
				local var_243_6 = arg_240_1:FormatText(var_243_5.content)

				arg_240_1.text_.text = var_243_6

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_7 = 48
				local var_243_8 = utf8.len(var_243_6)
				local var_243_9 = var_243_7 <= 0 and var_243_3 or var_243_3 * (var_243_8 / var_243_7)

				if var_243_9 > 0 and var_243_3 < var_243_9 then
					arg_240_1.talkMaxDuration = var_243_9

					if var_243_9 + var_243_2 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_9 + var_243_2
					end
				end

				arg_240_1.text_.text = var_243_6
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011059", "story_v_out_324011.awb") ~= 0 then
					local var_243_10 = manager.audio:GetVoiceLength("story_v_out_324011", "324011059", "story_v_out_324011.awb") / 1000

					if var_243_10 + var_243_2 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_10 + var_243_2
					end

					if var_243_5.prefab_name ~= "" and arg_240_1.actors_[var_243_5.prefab_name] ~= nil then
						local var_243_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_5.prefab_name].transform, "story_v_out_324011", "324011059", "story_v_out_324011.awb")

						arg_240_1:RecordAudio("324011059", var_243_11)
						arg_240_1:RecordAudio("324011059", var_243_11)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_324011", "324011059", "story_v_out_324011.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_324011", "324011059", "story_v_out_324011.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_12 = math.max(var_243_3, arg_240_1.talkMaxDuration)

			if var_243_2 <= arg_240_1.time_ and arg_240_1.time_ < var_243_2 + var_243_12 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_2) / var_243_12

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_2 + var_243_12 and arg_240_1.time_ < var_243_2 + var_243_12 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play324011060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 324011060
		arg_244_1.duration_ = 6.3

		local var_244_0 = {
			zh = 6.3,
			ja = 5.1
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play324011061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1070ui_story"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1070ui_story == nil then
				arg_244_1.var_.characterEffect1070ui_story = var_247_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.characterEffect1070ui_story and not isNil(var_247_0) then
					arg_244_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.characterEffect1070ui_story then
				arg_244_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_247_4 = arg_244_1.actors_["10039ui_story"]
			local var_247_5 = 0

			if var_247_5 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 and not isNil(var_247_4) and arg_244_1.var_.characterEffect10039ui_story == nil then
				arg_244_1.var_.characterEffect10039ui_story = var_247_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_6 = 0.200000002980232

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_6 and not isNil(var_247_4) then
				local var_247_7 = (arg_244_1.time_ - var_247_5) / var_247_6

				if arg_244_1.var_.characterEffect10039ui_story and not isNil(var_247_4) then
					local var_247_8 = Mathf.Lerp(0, 0.5, var_247_7)

					arg_244_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_244_1.var_.characterEffect10039ui_story.fillRatio = var_247_8
				end
			end

			if arg_244_1.time_ >= var_247_5 + var_247_6 and arg_244_1.time_ < var_247_5 + var_247_6 + arg_247_0 and not isNil(var_247_4) and arg_244_1.var_.characterEffect10039ui_story then
				local var_247_9 = 0.5

				arg_244_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_244_1.var_.characterEffect10039ui_story.fillRatio = var_247_9
			end

			local var_247_10 = 0

			if var_247_10 < arg_244_1.time_ and arg_244_1.time_ <= var_247_10 + arg_247_0 then
				arg_244_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_247_11 = 0

			if var_247_11 < arg_244_1.time_ and arg_244_1.time_ <= var_247_11 + arg_247_0 then
				arg_244_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_247_12 = 0
			local var_247_13 = 0.525

			if var_247_12 < arg_244_1.time_ and arg_244_1.time_ <= var_247_12 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_14 = arg_244_1:FormatText(StoryNameCfg[318].name)

				arg_244_1.leftNameTxt_.text = var_247_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_15 = arg_244_1:GetWordFromCfg(324011060)
				local var_247_16 = arg_244_1:FormatText(var_247_15.content)

				arg_244_1.text_.text = var_247_16

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_17 = 21
				local var_247_18 = utf8.len(var_247_16)
				local var_247_19 = var_247_17 <= 0 and var_247_13 or var_247_13 * (var_247_18 / var_247_17)

				if var_247_19 > 0 and var_247_13 < var_247_19 then
					arg_244_1.talkMaxDuration = var_247_19

					if var_247_19 + var_247_12 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_19 + var_247_12
					end
				end

				arg_244_1.text_.text = var_247_16
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011060", "story_v_out_324011.awb") ~= 0 then
					local var_247_20 = manager.audio:GetVoiceLength("story_v_out_324011", "324011060", "story_v_out_324011.awb") / 1000

					if var_247_20 + var_247_12 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_20 + var_247_12
					end

					if var_247_15.prefab_name ~= "" and arg_244_1.actors_[var_247_15.prefab_name] ~= nil then
						local var_247_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_15.prefab_name].transform, "story_v_out_324011", "324011060", "story_v_out_324011.awb")

						arg_244_1:RecordAudio("324011060", var_247_21)
						arg_244_1:RecordAudio("324011060", var_247_21)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_324011", "324011060", "story_v_out_324011.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_324011", "324011060", "story_v_out_324011.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_22 = math.max(var_247_13, arg_244_1.talkMaxDuration)

			if var_247_12 <= arg_244_1.time_ and arg_244_1.time_ < var_247_12 + var_247_22 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_12) / var_247_22

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_12 + var_247_22 and arg_244_1.time_ < var_247_12 + var_247_22 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play324011061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 324011061
		arg_248_1.duration_ = 5.63

		local var_248_0 = {
			zh = 5.333,
			ja = 5.633
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
				arg_248_0:Play324011062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["10039ui_story"]
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect10039ui_story == nil then
				arg_248_1.var_.characterEffect10039ui_story = var_251_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_2 and not isNil(var_251_0) then
				local var_251_3 = (arg_248_1.time_ - var_251_1) / var_251_2

				if arg_248_1.var_.characterEffect10039ui_story and not isNil(var_251_0) then
					arg_248_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_1 + var_251_2 and arg_248_1.time_ < var_251_1 + var_251_2 + arg_251_0 and not isNil(var_251_0) and arg_248_1.var_.characterEffect10039ui_story then
				arg_248_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_251_4 = arg_248_1.actors_["1070ui_story"]
			local var_251_5 = 0

			if var_251_5 < arg_248_1.time_ and arg_248_1.time_ <= var_251_5 + arg_251_0 and not isNil(var_251_4) and arg_248_1.var_.characterEffect1070ui_story == nil then
				arg_248_1.var_.characterEffect1070ui_story = var_251_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_6 = 0.200000002980232

			if var_251_5 <= arg_248_1.time_ and arg_248_1.time_ < var_251_5 + var_251_6 and not isNil(var_251_4) then
				local var_251_7 = (arg_248_1.time_ - var_251_5) / var_251_6

				if arg_248_1.var_.characterEffect1070ui_story and not isNil(var_251_4) then
					local var_251_8 = Mathf.Lerp(0, 0.5, var_251_7)

					arg_248_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1070ui_story.fillRatio = var_251_8
				end
			end

			if arg_248_1.time_ >= var_251_5 + var_251_6 and arg_248_1.time_ < var_251_5 + var_251_6 + arg_251_0 and not isNil(var_251_4) and arg_248_1.var_.characterEffect1070ui_story then
				local var_251_9 = 0.5

				arg_248_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1070ui_story.fillRatio = var_251_9
			end

			local var_251_10 = 0
			local var_251_11 = 0.575

			if var_251_10 < arg_248_1.time_ and arg_248_1.time_ <= var_251_10 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_12 = arg_248_1:FormatText(StoryNameCfg[472].name)

				arg_248_1.leftNameTxt_.text = var_251_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_13 = arg_248_1:GetWordFromCfg(324011061)
				local var_251_14 = arg_248_1:FormatText(var_251_13.content)

				arg_248_1.text_.text = var_251_14

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_15 = 23
				local var_251_16 = utf8.len(var_251_14)
				local var_251_17 = var_251_15 <= 0 and var_251_11 or var_251_11 * (var_251_16 / var_251_15)

				if var_251_17 > 0 and var_251_11 < var_251_17 then
					arg_248_1.talkMaxDuration = var_251_17

					if var_251_17 + var_251_10 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_17 + var_251_10
					end
				end

				arg_248_1.text_.text = var_251_14
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011061", "story_v_out_324011.awb") ~= 0 then
					local var_251_18 = manager.audio:GetVoiceLength("story_v_out_324011", "324011061", "story_v_out_324011.awb") / 1000

					if var_251_18 + var_251_10 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_18 + var_251_10
					end

					if var_251_13.prefab_name ~= "" and arg_248_1.actors_[var_251_13.prefab_name] ~= nil then
						local var_251_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_13.prefab_name].transform, "story_v_out_324011", "324011061", "story_v_out_324011.awb")

						arg_248_1:RecordAudio("324011061", var_251_19)
						arg_248_1:RecordAudio("324011061", var_251_19)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_324011", "324011061", "story_v_out_324011.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_324011", "324011061", "story_v_out_324011.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_20 = math.max(var_251_11, arg_248_1.talkMaxDuration)

			if var_251_10 <= arg_248_1.time_ and arg_248_1.time_ < var_251_10 + var_251_20 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_10) / var_251_20

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_10 + var_251_20 and arg_248_1.time_ < var_251_10 + var_251_20 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play324011062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 324011062
		arg_252_1.duration_ = 10.2

		local var_252_0 = {
			zh = 8.9,
			ja = 10.2
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play324011063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["1070ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1070ui_story == nil then
				arg_252_1.var_.characterEffect1070ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect1070ui_story and not isNil(var_255_0) then
					arg_252_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect1070ui_story then
				arg_252_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_255_4 = arg_252_1.actors_["10039ui_story"]
			local var_255_5 = 0

			if var_255_5 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 and not isNil(var_255_4) and arg_252_1.var_.characterEffect10039ui_story == nil then
				arg_252_1.var_.characterEffect10039ui_story = var_255_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_6 = 0.200000002980232

			if var_255_5 <= arg_252_1.time_ and arg_252_1.time_ < var_255_5 + var_255_6 and not isNil(var_255_4) then
				local var_255_7 = (arg_252_1.time_ - var_255_5) / var_255_6

				if arg_252_1.var_.characterEffect10039ui_story and not isNil(var_255_4) then
					local var_255_8 = Mathf.Lerp(0, 0.5, var_255_7)

					arg_252_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_252_1.var_.characterEffect10039ui_story.fillRatio = var_255_8
				end
			end

			if arg_252_1.time_ >= var_255_5 + var_255_6 and arg_252_1.time_ < var_255_5 + var_255_6 + arg_255_0 and not isNil(var_255_4) and arg_252_1.var_.characterEffect10039ui_story then
				local var_255_9 = 0.5

				arg_252_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_252_1.var_.characterEffect10039ui_story.fillRatio = var_255_9
			end

			local var_255_10 = 0

			if var_255_10 < arg_252_1.time_ and arg_252_1.time_ <= var_255_10 + arg_255_0 then
				arg_252_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_255_11 = 0
			local var_255_12 = 0.85

			if var_255_11 < arg_252_1.time_ and arg_252_1.time_ <= var_255_11 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_13 = arg_252_1:FormatText(StoryNameCfg[318].name)

				arg_252_1.leftNameTxt_.text = var_255_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_14 = arg_252_1:GetWordFromCfg(324011062)
				local var_255_15 = arg_252_1:FormatText(var_255_14.content)

				arg_252_1.text_.text = var_255_15

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_16 = 34
				local var_255_17 = utf8.len(var_255_15)
				local var_255_18 = var_255_16 <= 0 and var_255_12 or var_255_12 * (var_255_17 / var_255_16)

				if var_255_18 > 0 and var_255_12 < var_255_18 then
					arg_252_1.talkMaxDuration = var_255_18

					if var_255_18 + var_255_11 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_18 + var_255_11
					end
				end

				arg_252_1.text_.text = var_255_15
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011062", "story_v_out_324011.awb") ~= 0 then
					local var_255_19 = manager.audio:GetVoiceLength("story_v_out_324011", "324011062", "story_v_out_324011.awb") / 1000

					if var_255_19 + var_255_11 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_19 + var_255_11
					end

					if var_255_14.prefab_name ~= "" and arg_252_1.actors_[var_255_14.prefab_name] ~= nil then
						local var_255_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_14.prefab_name].transform, "story_v_out_324011", "324011062", "story_v_out_324011.awb")

						arg_252_1:RecordAudio("324011062", var_255_20)
						arg_252_1:RecordAudio("324011062", var_255_20)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_324011", "324011062", "story_v_out_324011.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_324011", "324011062", "story_v_out_324011.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_21 = math.max(var_255_12, arg_252_1.talkMaxDuration)

			if var_255_11 <= arg_252_1.time_ and arg_252_1.time_ < var_255_11 + var_255_21 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_11) / var_255_21

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_11 + var_255_21 and arg_252_1.time_ < var_255_11 + var_255_21 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play324011063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 324011063
		arg_256_1.duration_ = 5.37

		local var_256_0 = {
			zh = 5.3,
			ja = 5.366
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
			arg_256_1.auto_ = false
		end

		function arg_256_1.playNext_(arg_258_0)
			arg_256_1.onStoryFinished_()
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["10039ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect10039ui_story == nil then
				arg_256_1.var_.characterEffect10039ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect10039ui_story and not isNil(var_259_0) then
					arg_256_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect10039ui_story then
				arg_256_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_259_4 = arg_256_1.actors_["1070ui_story"]
			local var_259_5 = 0

			if var_259_5 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 and not isNil(var_259_4) and arg_256_1.var_.characterEffect1070ui_story == nil then
				arg_256_1.var_.characterEffect1070ui_story = var_259_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_6 = 0.200000002980232

			if var_259_5 <= arg_256_1.time_ and arg_256_1.time_ < var_259_5 + var_259_6 and not isNil(var_259_4) then
				local var_259_7 = (arg_256_1.time_ - var_259_5) / var_259_6

				if arg_256_1.var_.characterEffect1070ui_story and not isNil(var_259_4) then
					local var_259_8 = Mathf.Lerp(0, 0.5, var_259_7)

					arg_256_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_256_1.var_.characterEffect1070ui_story.fillRatio = var_259_8
				end
			end

			if arg_256_1.time_ >= var_259_5 + var_259_6 and arg_256_1.time_ < var_259_5 + var_259_6 + arg_259_0 and not isNil(var_259_4) and arg_256_1.var_.characterEffect1070ui_story then
				local var_259_9 = 0.5

				arg_256_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_256_1.var_.characterEffect1070ui_story.fillRatio = var_259_9
			end

			local var_259_10 = 0

			if var_259_10 < arg_256_1.time_ and arg_256_1.time_ <= var_259_10 + arg_259_0 then
				arg_256_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_2")
			end

			local var_259_11 = 0

			if var_259_11 < arg_256_1.time_ and arg_256_1.time_ <= var_259_11 + arg_259_0 then
				arg_256_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_259_12 = 0
			local var_259_13 = 0.525

			if var_259_12 < arg_256_1.time_ and arg_256_1.time_ <= var_259_12 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_14 = arg_256_1:FormatText(StoryNameCfg[472].name)

				arg_256_1.leftNameTxt_.text = var_259_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_15 = arg_256_1:GetWordFromCfg(324011063)
				local var_259_16 = arg_256_1:FormatText(var_259_15.content)

				arg_256_1.text_.text = var_259_16

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_17 = 21
				local var_259_18 = utf8.len(var_259_16)
				local var_259_19 = var_259_17 <= 0 and var_259_13 or var_259_13 * (var_259_18 / var_259_17)

				if var_259_19 > 0 and var_259_13 < var_259_19 then
					arg_256_1.talkMaxDuration = var_259_19

					if var_259_19 + var_259_12 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_19 + var_259_12
					end
				end

				arg_256_1.text_.text = var_259_16
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324011", "324011063", "story_v_out_324011.awb") ~= 0 then
					local var_259_20 = manager.audio:GetVoiceLength("story_v_out_324011", "324011063", "story_v_out_324011.awb") / 1000

					if var_259_20 + var_259_12 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_20 + var_259_12
					end

					if var_259_15.prefab_name ~= "" and arg_256_1.actors_[var_259_15.prefab_name] ~= nil then
						local var_259_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_15.prefab_name].transform, "story_v_out_324011", "324011063", "story_v_out_324011.awb")

						arg_256_1:RecordAudio("324011063", var_259_21)
						arg_256_1:RecordAudio("324011063", var_259_21)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_324011", "324011063", "story_v_out_324011.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_324011", "324011063", "story_v_out_324011.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_22 = math.max(var_259_13, arg_256_1.talkMaxDuration)

			if var_259_12 <= arg_256_1.time_ and arg_256_1.time_ < var_259_12 + var_259_22 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_12) / var_259_22

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_12 + var_259_22 and arg_256_1.time_ < var_259_12 + var_259_22 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2009",
		"TextureConfig/Background/ST2003"
	},
	voices = {
		"story_v_out_324011.awb"
	}
}
