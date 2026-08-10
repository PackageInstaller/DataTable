return {
	Play323011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323011001
		arg_1_1.duration_ = 122.4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play323011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "STblack"

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
				local var_4_5 = arg_1_1.bgs_.STblack

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
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 112.3

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				local var_4_17 = manager.ui.mainCamera.transform.localPosition
				local var_4_18 = Vector3.New(0, 0, 10) + Vector3.New(var_4_17.x, var_4_17.y, 0)
				local var_4_19 = arg_1_1.bgs_.STblack

				var_4_19.transform.localPosition = var_4_18
				var_4_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_20 = var_4_19:GetComponent("SpriteRenderer")

				if var_4_20 and var_4_20.sprite then
					local var_4_21 = (var_4_19.transform.localPosition - var_4_17).z
					local var_4_22 = manager.ui.mainCameraCom_
					local var_4_23 = 2 * var_4_21 * Mathf.Tan(var_4_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_24 = var_4_23 * var_4_22.aspect
					local var_4_25 = var_4_20.sprite.bounds.size.x
					local var_4_26 = var_4_20.sprite.bounds.size.y
					local var_4_27 = var_4_24 / var_4_25
					local var_4_28 = var_4_23 / var_4_26
					local var_4_29 = var_4_28 < var_4_27 and var_4_27 or var_4_28

					var_4_19.transform.localScale = Vector3.New(var_4_29, var_4_29, 0)
				end

				for iter_4_2, iter_4_3 in pairs(arg_1_1.bgs_) do
					if iter_4_2 ~= "STblack" then
						iter_4_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_30 = 112.3

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_31 = 0.3

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_32 = 110.3

			if var_4_32 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_33 = 2

			if var_4_32 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				local var_4_34 = (arg_1_1.time_ - var_4_32) / var_4_33
				local var_4_35 = Color.New(0, 0, 0)

				var_4_35.a = Mathf.Lerp(0, 1, var_4_34)
				arg_1_1.mask_.color = var_4_35
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				local var_4_36 = Color.New(0, 0, 0)

				var_4_36.a = 1
				arg_1_1.mask_.color = var_4_36
			end

			local var_4_37 = 112.3

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_38 = 2

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38
				local var_4_40 = Color.New(0, 0, 0)

				var_4_40.a = Mathf.Lerp(1, 0, var_4_39)
				arg_1_1.mask_.color = var_4_40
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 then
				local var_4_41 = Color.New(0, 0, 0)
				local var_4_42 = 0

				arg_1_1.mask_.enabled = false
				var_4_41.a = var_4_42
				arg_1_1.mask_.color = var_4_41
			end

			local var_4_43 = 110.3

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_44 = arg_1_1:GetWordFromCfg(102)
				local var_4_45 = arg_1_1:FormatText(var_4_44.content)

				arg_1_1.fswt_.text = var_4_45

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_46 = 112.3

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_47 = arg_1_1:GetWordFromCfg(102)
				local var_4_48 = arg_1_1:FormatText(var_4_47.content)

				arg_1_1.fswt_.text = var_4_48

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_49 = 112.316666666667

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_50 = arg_1_1:GetWordFromCfg(102)
				local var_4_51 = arg_1_1:FormatText(var_4_50.content)

				arg_1_1.fswt_.text = var_4_51

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_52 = 113.65

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_53 = 0
			local var_4_54 = 0.650000000000006
			local var_4_55 = arg_1_1:GetWordFromCfg(102)
			local var_4_56 = arg_1_1:FormatText(var_4_55.content)
			local var_4_57, var_4_58 = arg_1_1:GetPercentByPara(var_4_56, 1)

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_59 = var_4_53 <= 0 and var_4_54 or var_4_54 * ((var_4_58 - arg_1_1.typewritterCharCountI18N) / var_4_53)

				if var_4_59 > 0 and var_4_54 < var_4_59 then
					arg_1_1.talkMaxDuration = var_4_59

					if var_4_59 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_59 + var_4_52
					end
				end
			end

			local var_4_60 = 0.650000000000006
			local var_4_61 = math.max(var_4_60, arg_1_1.talkMaxDuration)

			if var_4_52 <= arg_1_1.time_ and arg_1_1.time_ < var_4_52 + var_4_61 then
				local var_4_62 = (arg_1_1.time_ - var_4_52) / var_4_61

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_57, var_4_62)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_52 + var_4_61 and arg_1_1.time_ < var_4_52 + var_4_61 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_57

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_58
			end

			local var_4_63 = 112.3

			if var_4_63 < arg_1_1.time_ and arg_1_1.time_ <= var_4_63 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_64 = 7.3

			if arg_1_1.time_ >= var_4_63 + var_4_64 and arg_1_1.time_ < var_4_63 + var_4_64 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_65 = 0
			local var_4_66 = 1

			if var_4_65 < arg_1_1.time_ and arg_1_1.time_ <= var_4_65 + arg_4_0 then
				local var_4_67 = "play"
				local var_4_68 = "music"

				arg_1_1:AudioAction(var_4_67, var_4_68, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_69 = ""
				local var_4_70 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_70 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_70 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_70

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_70
						arg_1_1.bgmTxt2_.text = var_4_70
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

			local var_4_71 = 110.3
			local var_4_72 = 1.34166666666666

			if var_4_71 < arg_1_1.time_ and arg_1_1.time_ <= var_4_71 + arg_4_0 then
				local var_4_73 = "play"
				local var_4_74 = "music"

				arg_1_1:AudioAction(var_4_73, var_4_74, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_75 = ""
				local var_4_76 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_76 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_76 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_76

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_76
						arg_1_1.bgmTxt2_.text = var_4_76
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

			local var_4_77 = 113.033333333333
			local var_4_78 = 1

			if var_4_77 < arg_1_1.time_ and arg_1_1.time_ <= var_4_77 + arg_4_0 then
				local var_4_79 = "play"
				local var_4_80 = "effect"

				arg_1_1:AudioAction(var_4_79, var_4_80, "se_story_148", "se_story_148_cloth_wear", "")
			end

			local var_4_81 = 112.3
			local var_4_82 = 10.1
			local var_4_83 = manager.audio:GetVoiceLength("story_v_out_323011", "323011001", "0") / 1000

			if var_4_83 > 0 and var_4_82 < var_4_83 and var_4_83 + var_4_81 > arg_1_1.duration_ then
				local var_4_84 = var_4_83

				arg_1_1.duration_ = var_4_83 + var_4_81
			end

			if var_4_81 < arg_1_1.time_ and arg_1_1.time_ <= var_4_81 + arg_4_0 then
				local var_4_85 = "play"
				local var_4_86 = "voice"

				arg_1_1:AudioAction(var_4_85, var_4_86, "story_v_out_323011", "323011001", "0")
			end

			local var_4_87 = 0.3

			if var_4_87 < arg_1_1.time_ and arg_1_1.time_ <= var_4_87 + arg_4_0 then
				SetActive(arg_1_1.dialog_, false)
				SetActive(arg_1_1.allBtn_.gameObject, false)
				arg_1_1.hideBtnsController_:SetSelectedIndex(1)
				arg_1_1:StopAllVoice()
				arg_1_1:PlayOnlyBgm()
				manager.video:Play("SofdecAsset/story/story_103230101.usm", function(arg_7_0)
					arg_1_1.time_ = var_4_87 + 109.990000000224

					if arg_1_1.state_ == "pause" then
						arg_1_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_8_0)
					if arg_8_0 then
						arg_1_1.state_ = "pause"
					else
						arg_1_1.state_ = "playing"
					end
				end, 10323011)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_4_88 = 110

			if var_4_87 <= arg_1_1.time_ and arg_1_1.time_ < var_4_87 + var_4_88 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_87 + var_4_88 and arg_1_1.time_ < var_4_87 + var_4_88 + arg_4_0 then
				-- block empty
			end

			local var_4_89 = 110.3

			if var_4_89 < arg_1_1.time_ and arg_1_1.time_ <= var_4_89 + arg_4_0 then
				SetActive(arg_1_1.dialog_, true)
				SetActive(arg_1_1.allBtn_.gameObject, true)
				arg_1_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_1_1.isInLoopVideo = false
			end

			local var_4_90 = 1.38333333333333

			if var_4_89 <= arg_1_1.time_ and arg_1_1.time_ < var_4_89 + var_4_90 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_89 + var_4_90 and arg_1_1.time_ < var_4_89 + var_4_90 + arg_4_0 then
				-- block empty
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323011002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 323011002
		arg_9_1.duration_ = 14.6

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play323011003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				local var_12_1 = manager.ui.mainCamera.transform.localPosition
				local var_12_2 = Vector3.New(0, 0, 10) + Vector3.New(var_12_1.x, var_12_1.y, 0)
				local var_12_3 = arg_9_1.bgs_.STblack

				var_12_3.transform.localPosition = var_12_2
				var_12_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_12_4 = var_12_3:GetComponent("SpriteRenderer")

				if var_12_4 and var_12_4.sprite then
					local var_12_5 = (var_12_3.transform.localPosition - var_12_1).z
					local var_12_6 = manager.ui.mainCameraCom_
					local var_12_7 = 2 * var_12_5 * Mathf.Tan(var_12_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_12_8 = var_12_7 * var_12_6.aspect
					local var_12_9 = var_12_4.sprite.bounds.size.x
					local var_12_10 = var_12_4.sprite.bounds.size.y
					local var_12_11 = var_12_8 / var_12_9
					local var_12_12 = var_12_7 / var_12_10
					local var_12_13 = var_12_12 < var_12_11 and var_12_11 or var_12_12

					var_12_3.transform.localScale = Vector3.New(var_12_13, var_12_13, 0)
				end

				for iter_12_0, iter_12_1 in pairs(arg_9_1.bgs_) do
					if iter_12_0 ~= "STblack" then
						iter_12_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_12_14 = "ST2015"

			if arg_9_1.bgs_[var_12_14] == nil then
				local var_12_15 = Object.Instantiate(arg_9_1.paintGo_)

				var_12_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_12_14)
				var_12_15.name = var_12_14
				var_12_15.transform.parent = arg_9_1.stage_.transform
				var_12_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.bgs_[var_12_14] = var_12_15
			end

			local var_12_16 = 0.9

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				local var_12_17 = manager.ui.mainCamera.transform.localPosition
				local var_12_18 = Vector3.New(0, 0, 10) + Vector3.New(var_12_17.x, var_12_17.y, 0)
				local var_12_19 = arg_9_1.bgs_.ST2015

				var_12_19.transform.localPosition = var_12_18
				var_12_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_12_20 = var_12_19:GetComponent("SpriteRenderer")

				if var_12_20 and var_12_20.sprite then
					local var_12_21 = (var_12_19.transform.localPosition - var_12_17).z
					local var_12_22 = manager.ui.mainCameraCom_
					local var_12_23 = 2 * var_12_21 * Mathf.Tan(var_12_22.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_12_24 = var_12_23 * var_12_22.aspect
					local var_12_25 = var_12_20.sprite.bounds.size.x
					local var_12_26 = var_12_20.sprite.bounds.size.y
					local var_12_27 = var_12_24 / var_12_25
					local var_12_28 = var_12_23 / var_12_26
					local var_12_29 = var_12_28 < var_12_27 and var_12_27 or var_12_28

					var_12_19.transform.localScale = Vector3.New(var_12_29, var_12_29, 0)
				end

				for iter_12_2, iter_12_3 in pairs(arg_9_1.bgs_) do
					if iter_12_2 ~= "ST2015" then
						iter_12_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_12_30 = 0

			if var_12_30 < arg_9_1.time_ and arg_9_1.time_ <= var_12_30 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			local var_12_31 = 0.3

			if arg_9_1.time_ >= var_12_30 + var_12_31 and arg_9_1.time_ < var_12_30 + var_12_31 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			local var_12_32 = 0.9

			if var_12_32 < arg_9_1.time_ and arg_9_1.time_ <= var_12_32 + arg_12_0 then
				arg_9_1.mask_.enabled = true
				arg_9_1.mask_.raycastTarget = true

				arg_9_1:SetGaussion(false)
			end

			local var_12_33 = 2

			if var_12_32 <= arg_9_1.time_ and arg_9_1.time_ < var_12_32 + var_12_33 then
				local var_12_34 = (arg_9_1.time_ - var_12_32) / var_12_33
				local var_12_35 = Color.New(0, 0, 0)

				var_12_35.a = Mathf.Lerp(1, 0, var_12_34)
				arg_9_1.mask_.color = var_12_35
			end

			if arg_9_1.time_ >= var_12_32 + var_12_33 and arg_9_1.time_ < var_12_32 + var_12_33 + arg_12_0 then
				local var_12_36 = Color.New(0, 0, 0)
				local var_12_37 = 0

				arg_9_1.mask_.enabled = false
				var_12_36.a = var_12_37
				arg_9_1.mask_.color = var_12_36
			end

			local var_12_38 = 0.633333333333333
			local var_12_39 = 1

			if var_12_38 < arg_9_1.time_ and arg_9_1.time_ <= var_12_38 + arg_12_0 then
				local var_12_40 = "play"
				local var_12_41 = "effect"

				arg_9_1:AudioAction(var_12_40, var_12_41, "se_story_143", "se_story_143_amb_town", "")
			end

			local var_12_42 = 2.3
			local var_12_43 = 1

			if var_12_42 < arg_9_1.time_ and arg_9_1.time_ <= var_12_42 + arg_12_0 then
				local var_12_44 = "play"
				local var_12_45 = "effect"

				arg_9_1:AudioAction(var_12_44, var_12_45, "se_story_131", "se_story_131__opendoor", "")
			end

			local var_12_46 = 1.43333333333333
			local var_12_47 = 13.166
			local var_12_48 = manager.audio:GetVoiceLength("story_v_out_323011", "323011002", "0") / 1000

			if var_12_48 > 0 and var_12_47 < var_12_48 and var_12_48 + var_12_46 > arg_9_1.duration_ then
				local var_12_49 = var_12_48

				arg_9_1.duration_ = var_12_48 + var_12_46
			end

			if var_12_46 < arg_9_1.time_ and arg_9_1.time_ <= var_12_46 + arg_12_0 then
				local var_12_50 = "play"
				local var_12_51 = "voice"

				arg_9_1:AudioAction(var_12_50, var_12_51, "story_v_out_323011", "323011002", "0")
			end

			local var_12_52 = 0

			if var_12_52 < arg_9_1.time_ and arg_9_1.time_ <= var_12_52 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			local var_12_53 = 3.83333333333333

			if arg_9_1.time_ >= var_12_52 + var_12_53 and arg_9_1.time_ < var_12_52 + var_12_53 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play323011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 323011003
		arg_13_1.duration_ = 5.27

		local var_13_0 = {
			zh = 3.43266666666667,
			ja = 5.26666666666667
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
				arg_13_0:Play323011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1024ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1024ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_13_1.stage_.transform)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

					var_16_3.enabled = true

					local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

					if var_16_4 then
						var_16_4:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_3.transform, false)

					arg_13_1.var_[var_16_0 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_0 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_0 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_5 = arg_13_1.actors_["1024ui_story"]
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1024ui_story == nil then
				arg_13_1.var_.characterEffect1024ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_7 = 0.200000002980232

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 and not isNil(var_16_5) then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7

				if arg_13_1.var_.characterEffect1024ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1024ui_story then
				arg_13_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			local var_16_9 = 0

			if var_16_9 < arg_13_1.time_ and arg_13_1.time_ <= var_16_9 + arg_16_0 then
				arg_13_1.fswbg_:SetActive(false)
				arg_13_1.dialog_:SetActive(false)
				SetActive(arg_13_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_13_1:ShowNextGo(false)
			end

			local var_16_10 = 0.0166666666666667

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.fswbg_:SetActive(false)
				arg_13_1.dialog_:SetActive(false)
				SetActive(arg_13_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_13_1:ShowNextGo(false)
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_11 = 0.0666666666666667
			local var_16_12 = 0.05

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_13 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_13:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_14 = arg_13_1:FormatText(StoryNameCfg[1444].name)

				arg_13_1.leftNameTxt_.text = var_16_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10163")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_15 = arg_13_1:GetWordFromCfg(323011003)
				local var_16_16 = arg_13_1:FormatText(var_16_15.content)

				arg_13_1.text_.text = var_16_16

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 2
				local var_16_18 = utf8.len(var_16_16)
				local var_16_19 = var_16_17 <= 0 and var_16_12 or var_16_12 * (var_16_18 / var_16_17)

				if var_16_19 > 0 and var_16_12 < var_16_19 then
					arg_13_1.talkMaxDuration = var_16_19
					var_16_11 = var_16_11 + 0.3

					if var_16_19 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_11
					end
				end

				arg_13_1.text_.text = var_16_16
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011003", "story_v_out_323011.awb") ~= 0 then
					local var_16_20 = manager.audio:GetVoiceLength("story_v_out_323011", "323011003", "story_v_out_323011.awb") / 1000

					if var_16_20 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_20 + var_16_11
					end

					if var_16_15.prefab_name ~= "" and arg_13_1.actors_[var_16_15.prefab_name] ~= nil then
						local var_16_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_15.prefab_name].transform, "story_v_out_323011", "323011003", "story_v_out_323011.awb")

						arg_13_1:RecordAudio("323011003", var_16_21)
						arg_13_1:RecordAudio("323011003", var_16_21)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_323011", "323011003", "story_v_out_323011.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_323011", "323011003", "story_v_out_323011.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = var_16_11 + 0.3
			local var_16_23 = math.max(var_16_12, arg_13_1.talkMaxDuration)

			if var_16_22 <= arg_13_1.time_ and arg_13_1.time_ < var_16_22 + var_16_23 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_22) / var_16_23

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_22 + var_16_23 and arg_13_1.time_ < var_16_22 + var_16_23 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play323011004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 323011004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play323011005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1024ui_story"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1024ui_story == nil then
				arg_19_1.var_.characterEffect1024ui_story = var_22_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_2 = 0.200000002980232

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 and not isNil(var_22_0) then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2

				if arg_19_1.var_.characterEffect1024ui_story and not isNil(var_22_0) then
					local var_22_4 = Mathf.Lerp(0, 0.5, var_22_3)

					arg_19_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1024ui_story.fillRatio = var_22_4
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.characterEffect1024ui_story then
				local var_22_5 = 0.5

				arg_19_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1024ui_story.fillRatio = var_22_5
			end

			local var_22_6 = 0.1
			local var_22_7 = 1

			if var_22_6 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				local var_22_8 = "play"
				local var_22_9 = "effect"

				arg_19_1:AudioAction(var_22_8, var_22_9, "se_story_148", "se_story_148_cloth", "")
			end

			local var_22_10 = 0
			local var_22_11 = 1.425

			if var_22_10 < arg_19_1.time_ and arg_19_1.time_ <= var_22_10 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_12 = arg_19_1:GetWordFromCfg(323011004)
				local var_22_13 = arg_19_1:FormatText(var_22_12.content)

				arg_19_1.text_.text = var_22_13

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_14 = 57
				local var_22_15 = utf8.len(var_22_13)
				local var_22_16 = var_22_14 <= 0 and var_22_11 or var_22_11 * (var_22_15 / var_22_14)

				if var_22_16 > 0 and var_22_11 < var_22_16 then
					arg_19_1.talkMaxDuration = var_22_16

					if var_22_16 + var_22_10 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_16 + var_22_10
					end
				end

				arg_19_1.text_.text = var_22_13
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_17 = math.max(var_22_11, arg_19_1.talkMaxDuration)

			if var_22_10 <= arg_19_1.time_ and arg_19_1.time_ < var_22_10 + var_22_17 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_10) / var_22_17

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_10 + var_22_17 and arg_19_1.time_ < var_22_10 + var_22_17 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play323011005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 323011005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play323011006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0
			local var_26_1 = 1.725

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_2 = arg_23_1:GetWordFromCfg(323011005)
				local var_26_3 = arg_23_1:FormatText(var_26_2.content)

				arg_23_1.text_.text = var_26_3

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 69
				local var_26_5 = utf8.len(var_26_3)
				local var_26_6 = var_26_4 <= 0 and var_26_1 or var_26_1 * (var_26_5 / var_26_4)

				if var_26_6 > 0 and var_26_1 < var_26_6 then
					arg_23_1.talkMaxDuration = var_26_6

					if var_26_6 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_6 + var_26_0
					end
				end

				arg_23_1.text_.text = var_26_3
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_1, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_7 and arg_23_1.time_ < var_26_0 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play323011006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 323011006
		arg_27_1.duration_ = 4.33

		local var_27_0 = {
			zh = 2.4,
			ja = 4.333
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play323011007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 0.3

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				local var_30_2 = "play"
				local var_30_3 = "music"

				arg_27_1:AudioAction(var_30_2, var_30_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_30_4 = ""
				local var_30_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_30_5 ~= "" then
					if arg_27_1.bgmTxt_.text ~= var_30_5 and arg_27_1.bgmTxt_.text ~= "" then
						if arg_27_1.bgmTxt2_.text ~= "" then
							arg_27_1.bgmTxt_.text = arg_27_1.bgmTxt2_.text
						end

						arg_27_1.bgmTxt2_.text = var_30_5

						arg_27_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_27_1.bgmTxt_.text = var_30_5
						arg_27_1.bgmTxt2_.text = var_30_5
					end

					if arg_27_1.bgmTimer then
						arg_27_1.bgmTimer:Stop()

						arg_27_1.bgmTimer = nil
					end

					if arg_27_1.settingData.show_music_name == 1 then
						arg_27_1.musicController:SetSelectedState("show")
						arg_27_1.musicAnimator_:Play("open", 0, 0)

						if arg_27_1.settingData.music_time ~= 0 then
							arg_27_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_27_1.settingData.music_time), function()
								if arg_27_1 == nil or isNil(arg_27_1.bgmTxt_) then
									return
								end

								arg_27_1.musicController:SetSelectedState("hide")
								arg_27_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_30_6 = 0.433333333333333
			local var_30_7 = 1

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				local var_30_8 = "play"
				local var_30_9 = "music"

				arg_27_1:AudioAction(var_30_8, var_30_9, "bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily.awb")

				local var_30_10 = ""
				local var_30_11 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily")

				if var_30_11 ~= "" then
					if arg_27_1.bgmTxt_.text ~= var_30_11 and arg_27_1.bgmTxt_.text ~= "" then
						if arg_27_1.bgmTxt2_.text ~= "" then
							arg_27_1.bgmTxt_.text = arg_27_1.bgmTxt2_.text
						end

						arg_27_1.bgmTxt2_.text = var_30_11

						arg_27_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_27_1.bgmTxt_.text = var_30_11
						arg_27_1.bgmTxt2_.text = var_30_11
					end

					if arg_27_1.bgmTimer then
						arg_27_1.bgmTimer:Stop()

						arg_27_1.bgmTimer = nil
					end

					if arg_27_1.settingData.show_music_name == 1 then
						arg_27_1.musicController:SetSelectedState("show")
						arg_27_1.musicAnimator_:Play("open", 0, 0)

						if arg_27_1.settingData.music_time ~= 0 then
							arg_27_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_27_1.settingData.music_time), function()
								if arg_27_1 == nil or isNil(arg_27_1.bgmTxt_) then
									return
								end

								arg_27_1.musicController:SetSelectedState("hide")
								arg_27_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_30_12 = 0
			local var_30_13 = 0.15

			if var_30_12 < arg_27_1.time_ and arg_27_1.time_ <= var_30_12 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_14 = arg_27_1:FormatText(StoryNameCfg[1445].name)

				arg_27_1.leftNameTxt_.text = var_30_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_15 = arg_27_1:GetWordFromCfg(323011006)
				local var_30_16 = arg_27_1:FormatText(var_30_15.content)

				arg_27_1.text_.text = var_30_16

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_17 = 6
				local var_30_18 = utf8.len(var_30_16)
				local var_30_19 = var_30_17 <= 0 and var_30_13 or var_30_13 * (var_30_18 / var_30_17)

				if var_30_19 > 0 and var_30_13 < var_30_19 then
					arg_27_1.talkMaxDuration = var_30_19

					if var_30_19 + var_30_12 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_19 + var_30_12
					end
				end

				arg_27_1.text_.text = var_30_16
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011006", "story_v_out_323011.awb") ~= 0 then
					local var_30_20 = manager.audio:GetVoiceLength("story_v_out_323011", "323011006", "story_v_out_323011.awb") / 1000

					if var_30_20 + var_30_12 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_20 + var_30_12
					end

					if var_30_15.prefab_name ~= "" and arg_27_1.actors_[var_30_15.prefab_name] ~= nil then
						local var_30_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_15.prefab_name].transform, "story_v_out_323011", "323011006", "story_v_out_323011.awb")

						arg_27_1:RecordAudio("323011006", var_30_21)
						arg_27_1:RecordAudio("323011006", var_30_21)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_323011", "323011006", "story_v_out_323011.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_323011", "323011006", "story_v_out_323011.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_22 = math.max(var_30_13, arg_27_1.talkMaxDuration)

			if var_30_12 <= arg_27_1.time_ and arg_27_1.time_ < var_30_12 + var_30_22 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_12) / var_30_22

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_12 + var_30_22 and arg_27_1.time_ < var_30_12 + var_30_22 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play323011007 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 323011007
		arg_33_1.duration_ = 6.23

		local var_33_0 = {
			zh = 5.933,
			ja = 6.233
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
				arg_33_0:Play323011008(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "10163ui_story"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Char/" .. "10163ui_story")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(Asset.Load("Char/" .. "10163ui_story"), arg_33_1.stage_.transform)

					var_36_2.name = var_36_0
					var_36_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_33_1.actors_[var_36_0] = var_36_2

					local var_36_3 = var_36_2:GetComponentInChildren(typeof(CharacterEffect))

					var_36_3.enabled = true

					local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_2, typeof(DynamicBoneHelper))

					if var_36_4 then
						var_36_4:EnableDynamicBone(false)
					end

					arg_33_1:ShowWeapon(var_36_3.transform, false)

					arg_33_1.var_[var_36_0 .. "Animator"] = var_36_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_33_1.var_[var_36_0 .. "Animator"].applyRootMotion = true
					arg_33_1.var_[var_36_0 .. "LipSync"] = var_36_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_36_5 = arg_33_1.actors_["10163ui_story"].transform
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.var_.moveOldPos10163ui_story = var_36_5.localPosition

				local var_36_7 = GameObjectTools.GetOrAddComponent(var_36_5.gameObject, typeof(DynamicBoneHelper))

				if var_36_7 then
					var_36_7:EnableDynamicBone(false)
				end
			end

			local var_36_8 = 0.001

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_8 then
				local var_36_9 = (arg_33_1.time_ - var_36_6) / var_36_8
				local var_36_10 = Vector3.New(0, -1.08, -5.83)

				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10163ui_story, var_36_10, var_36_9)

				local var_36_11 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_11.x, var_36_11.y, var_36_11.z)

				local var_36_12 = var_36_5.localEulerAngles

				var_36_12.z = 0
				var_36_12.x = 0
				var_36_5.localEulerAngles = var_36_12
			end

			if arg_33_1.time_ >= var_36_6 + var_36_8 and arg_33_1.time_ < var_36_6 + var_36_8 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_36_13 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_13.x, var_36_13.y, var_36_13.z)

				local var_36_14 = var_36_5.localEulerAngles

				var_36_14.z = 0
				var_36_14.x = 0
				var_36_5.localEulerAngles = var_36_14

				local var_36_15 = GameObjectTools.GetOrAddComponent(var_36_5.gameObject, typeof(DynamicBoneHelper))

				if var_36_15 then
					var_36_15:EnableDynamicBone(true)
				end
			end

			local var_36_16 = arg_33_1.actors_["10163ui_story"]
			local var_36_17 = 0

			if var_36_17 < arg_33_1.time_ and arg_33_1.time_ <= var_36_17 + arg_36_0 and not isNil(var_36_16) and arg_33_1.var_.characterEffect10163ui_story == nil then
				arg_33_1.var_.characterEffect10163ui_story = var_36_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_18 = 0.200000002980232

			if var_36_17 <= arg_33_1.time_ and arg_33_1.time_ < var_36_17 + var_36_18 and not isNil(var_36_16) then
				local var_36_19 = (arg_33_1.time_ - var_36_17) / var_36_18

				if arg_33_1.var_.characterEffect10163ui_story and not isNil(var_36_16) then
					arg_33_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_17 + var_36_18 and arg_33_1.time_ < var_36_17 + var_36_18 + arg_36_0 and not isNil(var_36_16) and arg_33_1.var_.characterEffect10163ui_story then
				arg_33_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_36_20 = 0

			if var_36_20 < arg_33_1.time_ and arg_33_1.time_ <= var_36_20 + arg_36_0 then
				arg_33_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_1")
			end

			local var_36_21 = 0

			if var_36_21 < arg_33_1.time_ and arg_33_1.time_ <= var_36_21 + arg_36_0 then
				arg_33_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_36_22 = 0
			local var_36_23 = 0.425

			if var_36_22 < arg_33_1.time_ and arg_33_1.time_ <= var_36_22 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_24 = arg_33_1:FormatText(StoryNameCfg[1444].name)

				arg_33_1.leftNameTxt_.text = var_36_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_25 = arg_33_1:GetWordFromCfg(323011007)
				local var_36_26 = arg_33_1:FormatText(var_36_25.content)

				arg_33_1.text_.text = var_36_26

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_27 = 17
				local var_36_28 = utf8.len(var_36_26)
				local var_36_29 = var_36_27 <= 0 and var_36_23 or var_36_23 * (var_36_28 / var_36_27)

				if var_36_29 > 0 and var_36_23 < var_36_29 then
					arg_33_1.talkMaxDuration = var_36_29

					if var_36_29 + var_36_22 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_29 + var_36_22
					end
				end

				arg_33_1.text_.text = var_36_26
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011007", "story_v_out_323011.awb") ~= 0 then
					local var_36_30 = manager.audio:GetVoiceLength("story_v_out_323011", "323011007", "story_v_out_323011.awb") / 1000

					if var_36_30 + var_36_22 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_30 + var_36_22
					end

					if var_36_25.prefab_name ~= "" and arg_33_1.actors_[var_36_25.prefab_name] ~= nil then
						local var_36_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_25.prefab_name].transform, "story_v_out_323011", "323011007", "story_v_out_323011.awb")

						arg_33_1:RecordAudio("323011007", var_36_31)
						arg_33_1:RecordAudio("323011007", var_36_31)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_323011", "323011007", "story_v_out_323011.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_323011", "323011007", "story_v_out_323011.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_32 = math.max(var_36_23, arg_33_1.talkMaxDuration)

			if var_36_22 <= arg_33_1.time_ and arg_33_1.time_ < var_36_22 + var_36_32 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_22) / var_36_32

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_22 + var_36_32 and arg_33_1.time_ < var_36_22 + var_36_32 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
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
	Play323011008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 323011008
		arg_37_1.duration_ = 7.13

		local var_37_0 = {
			zh = 4.6,
			ja = 7.133
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
				arg_37_0:Play323011009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10163ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10163ui_story == nil then
				arg_37_1.var_.characterEffect10163ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect10163ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10163ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect10163ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10163ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.475

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[1445].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_9 = arg_37_1:GetWordFromCfg(323011008)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011008", "story_v_out_323011.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_323011", "323011008", "story_v_out_323011.awb") / 1000

					if var_40_14 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_6
					end

					if var_40_9.prefab_name ~= "" and arg_37_1.actors_[var_40_9.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_9.prefab_name].transform, "story_v_out_323011", "323011008", "story_v_out_323011.awb")

						arg_37_1:RecordAudio("323011008", var_40_15)
						arg_37_1:RecordAudio("323011008", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_323011", "323011008", "story_v_out_323011.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_323011", "323011008", "story_v_out_323011.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_16 and arg_37_1.time_ < var_40_6 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play323011009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 323011009
		arg_41_1.duration_ = 4.63

		local var_41_0 = {
			zh = 4.633,
			ja = 4.333
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
				arg_41_0:Play323011010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10163ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10163ui_story == nil then
				arg_41_1.var_.characterEffect10163ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10163ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10163ui_story then
				arg_41_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_44_4 = 0
			local var_44_5 = 0.325

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_6 = arg_41_1:FormatText(StoryNameCfg[1444].name)

				arg_41_1.leftNameTxt_.text = var_44_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:GetWordFromCfg(323011009)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011009", "story_v_out_323011.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_323011", "323011009", "story_v_out_323011.awb") / 1000

					if var_44_12 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_4
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_323011", "323011009", "story_v_out_323011.awb")

						arg_41_1:RecordAudio("323011009", var_44_13)
						arg_41_1:RecordAudio("323011009", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_323011", "323011009", "story_v_out_323011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_323011", "323011009", "story_v_out_323011.awb")
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
	Play323011010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 323011010
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play323011011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["10163ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10163ui_story == nil then
				arg_45_1.var_.characterEffect10163ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect10163ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10163ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect10163ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10163ui_story.fillRatio = var_48_5
			end

			local var_48_6 = 0
			local var_48_7 = 0.7

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

				local var_48_8 = arg_45_1:GetWordFromCfg(323011010)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 28
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
	Play323011011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 323011011
		arg_49_1.duration_ = 3.83

		local var_49_0 = {
			zh = 3.833,
			ja = 3.233
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
				arg_49_0:Play323011012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10163ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10163ui_story == nil then
				arg_49_1.var_.characterEffect10163ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect10163ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10163ui_story then
				arg_49_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_2")
			end

			local var_52_5 = 0
			local var_52_6 = 0.25

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_7 = arg_49_1:FormatText(StoryNameCfg[1444].name)

				arg_49_1.leftNameTxt_.text = var_52_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(323011011)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_10 = 10
				local var_52_11 = utf8.len(var_52_9)
				local var_52_12 = var_52_10 <= 0 and var_52_6 or var_52_6 * (var_52_11 / var_52_10)

				if var_52_12 > 0 and var_52_6 < var_52_12 then
					arg_49_1.talkMaxDuration = var_52_12

					if var_52_12 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_5
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011011", "story_v_out_323011.awb") ~= 0 then
					local var_52_13 = manager.audio:GetVoiceLength("story_v_out_323011", "323011011", "story_v_out_323011.awb") / 1000

					if var_52_13 + var_52_5 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_5
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_323011", "323011011", "story_v_out_323011.awb")

						arg_49_1:RecordAudio("323011011", var_52_14)
						arg_49_1:RecordAudio("323011011", var_52_14)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_323011", "323011011", "story_v_out_323011.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_323011", "323011011", "story_v_out_323011.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_15 = math.max(var_52_6, arg_49_1.talkMaxDuration)

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_15 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_5) / var_52_15

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_5 + var_52_15 and arg_49_1.time_ < var_52_5 + var_52_15 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play323011012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 323011012
		arg_53_1.duration_ = 2.5

		local var_53_0 = {
			zh = 1.733,
			ja = 2.5
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
				arg_53_0:Play323011013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10163ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10163ui_story == nil then
				arg_53_1.var_.characterEffect10163ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect10163ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10163ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect10163ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10163ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 0.125

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_8 = arg_53_1:FormatText(StoryNameCfg[1445].name)

				arg_53_1.leftNameTxt_.text = var_56_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_9 = arg_53_1:GetWordFromCfg(323011012)
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

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011012", "story_v_out_323011.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_323011", "323011012", "story_v_out_323011.awb") / 1000

					if var_56_14 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_6
					end

					if var_56_9.prefab_name ~= "" and arg_53_1.actors_[var_56_9.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_9.prefab_name].transform, "story_v_out_323011", "323011012", "story_v_out_323011.awb")

						arg_53_1:RecordAudio("323011012", var_56_15)
						arg_53_1:RecordAudio("323011012", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_323011", "323011012", "story_v_out_323011.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_323011", "323011012", "story_v_out_323011.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_16 and arg_53_1.time_ < var_56_6 + var_56_16 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play323011013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 323011013
		arg_57_1.duration_ = 3.17

		local var_57_0 = {
			zh = 1.999999999999,
			ja = 3.166
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
				arg_57_0:Play323011014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10163ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10163ui_story == nil then
				arg_57_1.var_.characterEffect10163ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect10163ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10163ui_story then
				arg_57_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_60_4 = 0

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_1")
			end

			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_60_6 = 0
			local var_60_7 = 0.2

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[1444].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_9 = arg_57_1:GetWordFromCfg(323011013)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 7
				local var_60_12 = utf8.len(var_60_10)
				local var_60_13 = var_60_11 <= 0 and var_60_7 or var_60_7 * (var_60_12 / var_60_11)

				if var_60_13 > 0 and var_60_7 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011013", "story_v_out_323011.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_323011", "323011013", "story_v_out_323011.awb") / 1000

					if var_60_14 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_6
					end

					if var_60_9.prefab_name ~= "" and arg_57_1.actors_[var_60_9.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_9.prefab_name].transform, "story_v_out_323011", "323011013", "story_v_out_323011.awb")

						arg_57_1:RecordAudio("323011013", var_60_15)
						arg_57_1:RecordAudio("323011013", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_323011", "323011013", "story_v_out_323011.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_323011", "323011013", "story_v_out_323011.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_16 and arg_57_1.time_ < var_60_6 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play323011014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 323011014
		arg_61_1.duration_ = 3

		local var_61_0 = {
			zh = 2.466,
			ja = 3
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
				arg_61_0:Play323011015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.15

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[1444].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(323011014)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011014", "story_v_out_323011.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011014", "story_v_out_323011.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_323011", "323011014", "story_v_out_323011.awb")

						arg_61_1:RecordAudio("323011014", var_64_9)
						arg_61_1:RecordAudio("323011014", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_323011", "323011014", "story_v_out_323011.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_323011", "323011014", "story_v_out_323011.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play323011015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 323011015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play323011016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10163ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10163ui_story = var_68_0.localPosition

				local var_68_2 = GameObjectTools.GetOrAddComponent(var_68_0.gameObject, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(false)
				end
			end

			local var_68_3 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_3 then
				local var_68_4 = (arg_65_1.time_ - var_68_1) / var_68_3
				local var_68_5 = Vector3.New(0, 100, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10163ui_story, var_68_5, var_68_4)

				local var_68_6 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_6.x, var_68_6.y, var_68_6.z)

				local var_68_7 = var_68_0.localEulerAngles

				var_68_7.z = 0
				var_68_7.x = 0
				var_68_0.localEulerAngles = var_68_7
			end

			if arg_65_1.time_ >= var_68_1 + var_68_3 and arg_65_1.time_ < var_68_1 + var_68_3 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, 100, 0)

				local var_68_8 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_8.x, var_68_8.y, var_68_8.z)

				local var_68_9 = var_68_0.localEulerAngles

				var_68_9.z = 0
				var_68_9.x = 0
				var_68_0.localEulerAngles = var_68_9

				local var_68_10 = GameObjectTools.GetOrAddComponent(var_68_0.gameObject, typeof(DynamicBoneHelper))

				if var_68_10 then
					var_68_10:EnableDynamicBone(true)
				end
			end

			local var_68_11 = arg_65_1.actors_["10163ui_story"]
			local var_68_12 = 0

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 and not isNil(var_68_11) and arg_65_1.var_.characterEffect10163ui_story == nil then
				arg_65_1.var_.characterEffect10163ui_story = var_68_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_13 = 0.200000002980232

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_13 and not isNil(var_68_11) then
				local var_68_14 = (arg_65_1.time_ - var_68_12) / var_68_13

				if arg_65_1.var_.characterEffect10163ui_story and not isNil(var_68_11) then
					local var_68_15 = Mathf.Lerp(0, 0.5, var_68_14)

					arg_65_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10163ui_story.fillRatio = var_68_15
				end
			end

			if arg_65_1.time_ >= var_68_12 + var_68_13 and arg_65_1.time_ < var_68_12 + var_68_13 + arg_68_0 and not isNil(var_68_11) and arg_65_1.var_.characterEffect10163ui_story then
				local var_68_16 = 0.5

				arg_65_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10163ui_story.fillRatio = var_68_16
			end

			local var_68_17 = 0
			local var_68_18 = 1.6

			if var_68_17 < arg_65_1.time_ and arg_65_1.time_ <= var_68_17 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_19 = arg_65_1:GetWordFromCfg(323011015)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 64
				local var_68_22 = utf8.len(var_68_20)
				local var_68_23 = var_68_21 <= 0 and var_68_18 or var_68_18 * (var_68_22 / var_68_21)

				if var_68_23 > 0 and var_68_18 < var_68_23 then
					arg_65_1.talkMaxDuration = var_68_23

					if var_68_23 + var_68_17 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_17
					end
				end

				arg_65_1.text_.text = var_68_20
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_24 = math.max(var_68_18, arg_65_1.talkMaxDuration)

			if var_68_17 <= arg_65_1.time_ and arg_65_1.time_ < var_68_17 + var_68_24 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_17) / var_68_24

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_17 + var_68_24 and arg_65_1.time_ < var_68_17 + var_68_24 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
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
	Play323011016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 323011016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play323011017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 1.475

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_2 = arg_69_1:GetWordFromCfg(323011016)
				local var_72_3 = arg_69_1:FormatText(var_72_2.content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 59
				local var_72_5 = utf8.len(var_72_3)
				local var_72_6 = var_72_4 <= 0 and var_72_1 or var_72_1 * (var_72_5 / var_72_4)

				if var_72_6 > 0 and var_72_1 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_7 and arg_69_1.time_ < var_72_0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play323011017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 323011017
		arg_73_1.duration_ = 4.3

		local var_73_0 = {
			zh = 4.033,
			ja = 4.3
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
				arg_73_0:Play323011018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = "10165ui_story"

			if arg_73_1.actors_[var_76_0] == nil then
				local var_76_1 = Asset.Load("Char/" .. "10165ui_story")

				if not isNil(var_76_1) then
					local var_76_2 = Object.Instantiate(Asset.Load("Char/" .. "10165ui_story"), arg_73_1.stage_.transform)

					var_76_2.name = var_76_0
					var_76_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_73_1.actors_[var_76_0] = var_76_2

					local var_76_3 = var_76_2:GetComponentInChildren(typeof(CharacterEffect))

					var_76_3.enabled = true

					local var_76_4 = GameObjectTools.GetOrAddComponent(var_76_2, typeof(DynamicBoneHelper))

					if var_76_4 then
						var_76_4:EnableDynamicBone(false)
					end

					arg_73_1:ShowWeapon(var_76_3.transform, false)

					arg_73_1.var_[var_76_0 .. "Animator"] = var_76_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_73_1.var_[var_76_0 .. "Animator"].applyRootMotion = true
					arg_73_1.var_[var_76_0 .. "LipSync"] = var_76_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_76_5 = arg_73_1.actors_["10165ui_story"].transform
			local var_76_6 = 0

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.var_.moveOldPos10165ui_story = var_76_5.localPosition

				local var_76_7 = GameObjectTools.GetOrAddComponent(var_76_5.gameObject, typeof(DynamicBoneHelper))

				if var_76_7 then
					var_76_7:EnableDynamicBone(false)
				end
			end

			local var_76_8 = 0.001

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_8 then
				local var_76_9 = (arg_73_1.time_ - var_76_6) / var_76_8
				local var_76_10 = Vector3.New(0, -1.08, -5.83)

				var_76_5.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10165ui_story, var_76_10, var_76_9)

				local var_76_11 = manager.ui.mainCamera.transform.position - var_76_5.position

				var_76_5.forward = Vector3.New(var_76_11.x, var_76_11.y, var_76_11.z)

				local var_76_12 = var_76_5.localEulerAngles

				var_76_12.z = 0
				var_76_12.x = 0
				var_76_5.localEulerAngles = var_76_12
			end

			if arg_73_1.time_ >= var_76_6 + var_76_8 and arg_73_1.time_ < var_76_6 + var_76_8 + arg_76_0 then
				var_76_5.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_76_13 = manager.ui.mainCamera.transform.position - var_76_5.position

				var_76_5.forward = Vector3.New(var_76_13.x, var_76_13.y, var_76_13.z)

				local var_76_14 = var_76_5.localEulerAngles

				var_76_14.z = 0
				var_76_14.x = 0
				var_76_5.localEulerAngles = var_76_14

				local var_76_15 = GameObjectTools.GetOrAddComponent(var_76_5.gameObject, typeof(DynamicBoneHelper))

				if var_76_15 then
					var_76_15:EnableDynamicBone(true)
				end
			end

			local var_76_16 = arg_73_1.actors_["10165ui_story"]
			local var_76_17 = 0

			if var_76_17 < arg_73_1.time_ and arg_73_1.time_ <= var_76_17 + arg_76_0 and not isNil(var_76_16) and arg_73_1.var_.characterEffect10165ui_story == nil then
				arg_73_1.var_.characterEffect10165ui_story = var_76_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_18 = 0.200000002980232

			if var_76_17 <= arg_73_1.time_ and arg_73_1.time_ < var_76_17 + var_76_18 and not isNil(var_76_16) then
				local var_76_19 = (arg_73_1.time_ - var_76_17) / var_76_18

				if arg_73_1.var_.characterEffect10165ui_story and not isNil(var_76_16) then
					arg_73_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_17 + var_76_18 and arg_73_1.time_ < var_76_17 + var_76_18 + arg_76_0 and not isNil(var_76_16) and arg_73_1.var_.characterEffect10165ui_story then
				arg_73_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_76_20 = 0

			if var_76_20 < arg_73_1.time_ and arg_73_1.time_ <= var_76_20 + arg_76_0 then
				arg_73_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			local var_76_21 = 0

			if var_76_21 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_76_22 = 1.05
			local var_76_23 = 1

			if var_76_22 < arg_73_1.time_ and arg_73_1.time_ <= var_76_22 + arg_76_0 then
				local var_76_24 = "play"
				local var_76_25 = "effect"

				arg_73_1:AudioAction(var_76_24, var_76_25, "se_story_140", "se_story_140_foley_down", "")
			end

			local var_76_26 = 0
			local var_76_27 = 0.25

			if var_76_26 < arg_73_1.time_ and arg_73_1.time_ <= var_76_26 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_28 = arg_73_1:FormatText(StoryNameCfg[1446].name)

				arg_73_1.leftNameTxt_.text = var_76_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_29 = arg_73_1:GetWordFromCfg(323011017)
				local var_76_30 = arg_73_1:FormatText(var_76_29.content)

				arg_73_1.text_.text = var_76_30

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_31 = 10
				local var_76_32 = utf8.len(var_76_30)
				local var_76_33 = var_76_31 <= 0 and var_76_27 or var_76_27 * (var_76_32 / var_76_31)

				if var_76_33 > 0 and var_76_27 < var_76_33 then
					arg_73_1.talkMaxDuration = var_76_33

					if var_76_33 + var_76_26 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_33 + var_76_26
					end
				end

				arg_73_1.text_.text = var_76_30
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011017", "story_v_out_323011.awb") ~= 0 then
					local var_76_34 = manager.audio:GetVoiceLength("story_v_out_323011", "323011017", "story_v_out_323011.awb") / 1000

					if var_76_34 + var_76_26 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_34 + var_76_26
					end

					if var_76_29.prefab_name ~= "" and arg_73_1.actors_[var_76_29.prefab_name] ~= nil then
						local var_76_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_29.prefab_name].transform, "story_v_out_323011", "323011017", "story_v_out_323011.awb")

						arg_73_1:RecordAudio("323011017", var_76_35)
						arg_73_1:RecordAudio("323011017", var_76_35)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_323011", "323011017", "story_v_out_323011.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_323011", "323011017", "story_v_out_323011.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_36 = math.max(var_76_27, arg_73_1.talkMaxDuration)

			if var_76_26 <= arg_73_1.time_ and arg_73_1.time_ < var_76_26 + var_76_36 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_26) / var_76_36

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_26 + var_76_36 and arg_73_1.time_ < var_76_26 + var_76_36 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
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
	Play323011018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 323011018
		arg_77_1.duration_ = 2.87

		local var_77_0 = {
			zh = 2.266,
			ja = 2.866
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
				arg_77_0:Play323011019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10163ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10163ui_story = var_80_0.localPosition

				local var_80_2 = GameObjectTools.GetOrAddComponent(var_80_0.gameObject, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(false)
				end
			end

			local var_80_3 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_3 then
				local var_80_4 = (arg_77_1.time_ - var_80_1) / var_80_3
				local var_80_5 = Vector3.New(-0.74, -1.08, -5.83)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10163ui_story, var_80_5, var_80_4)

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

			local var_80_11 = arg_77_1.actors_["10163ui_story"]
			local var_80_12 = 0

			if var_80_12 < arg_77_1.time_ and arg_77_1.time_ <= var_80_12 + arg_80_0 and not isNil(var_80_11) and arg_77_1.var_.characterEffect10163ui_story == nil then
				arg_77_1.var_.characterEffect10163ui_story = var_80_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_13 = 0.200000002980232

			if var_80_12 <= arg_77_1.time_ and arg_77_1.time_ < var_80_12 + var_80_13 and not isNil(var_80_11) then
				local var_80_14 = (arg_77_1.time_ - var_80_12) / var_80_13

				if arg_77_1.var_.characterEffect10163ui_story and not isNil(var_80_11) then
					arg_77_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_12 + var_80_13 and arg_77_1.time_ < var_80_12 + var_80_13 + arg_80_0 and not isNil(var_80_11) and arg_77_1.var_.characterEffect10163ui_story then
				arg_77_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_80_15 = arg_77_1.actors_["10165ui_story"]
			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.characterEffect10165ui_story == nil then
				arg_77_1.var_.characterEffect10165ui_story = var_80_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_17 = 0.200000002980232

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 and not isNil(var_80_15) then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17

				if arg_77_1.var_.characterEffect10165ui_story and not isNil(var_80_15) then
					local var_80_19 = Mathf.Lerp(0, 0.5, var_80_18)

					arg_77_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10165ui_story.fillRatio = var_80_19
				end
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.characterEffect10165ui_story then
				local var_80_20 = 0.5

				arg_77_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10165ui_story.fillRatio = var_80_20
			end

			local var_80_21 = 0

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_2")
			end

			local var_80_22 = 0

			if var_80_22 < arg_77_1.time_ and arg_77_1.time_ <= var_80_22 + arg_80_0 then
				arg_77_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_80_23 = arg_77_1.actors_["10165ui_story"].transform
			local var_80_24 = 0

			if var_80_24 < arg_77_1.time_ and arg_77_1.time_ <= var_80_24 + arg_80_0 then
				arg_77_1.var_.moveOldPos10165ui_story = var_80_23.localPosition

				local var_80_25 = GameObjectTools.GetOrAddComponent(var_80_23.gameObject, typeof(DynamicBoneHelper))

				if var_80_25 then
					var_80_25:EnableDynamicBone(false)
				end
			end

			local var_80_26 = 0.001

			if var_80_24 <= arg_77_1.time_ and arg_77_1.time_ < var_80_24 + var_80_26 then
				local var_80_27 = (arg_77_1.time_ - var_80_24) / var_80_26
				local var_80_28 = Vector3.New(0.7, -1.08, -5.83)

				var_80_23.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10165ui_story, var_80_28, var_80_27)

				local var_80_29 = manager.ui.mainCamera.transform.position - var_80_23.position

				var_80_23.forward = Vector3.New(var_80_29.x, var_80_29.y, var_80_29.z)

				local var_80_30 = var_80_23.localEulerAngles

				var_80_30.z = 0
				var_80_30.x = 0
				var_80_23.localEulerAngles = var_80_30
			end

			if arg_77_1.time_ >= var_80_24 + var_80_26 and arg_77_1.time_ < var_80_24 + var_80_26 + arg_80_0 then
				var_80_23.localPosition = Vector3.New(0.7, -1.08, -5.83)

				local var_80_31 = manager.ui.mainCamera.transform.position - var_80_23.position

				var_80_23.forward = Vector3.New(var_80_31.x, var_80_31.y, var_80_31.z)

				local var_80_32 = var_80_23.localEulerAngles

				var_80_32.z = 0
				var_80_32.x = 0
				var_80_23.localEulerAngles = var_80_32

				local var_80_33 = GameObjectTools.GetOrAddComponent(var_80_23.gameObject, typeof(DynamicBoneHelper))

				if var_80_33 then
					var_80_33:EnableDynamicBone(true)
				end
			end

			local var_80_34 = 0
			local var_80_35 = 0.2

			if var_80_34 < arg_77_1.time_ and arg_77_1.time_ <= var_80_34 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_36 = arg_77_1:FormatText(StoryNameCfg[1444].name)

				arg_77_1.leftNameTxt_.text = var_80_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_37 = arg_77_1:GetWordFromCfg(323011018)
				local var_80_38 = arg_77_1:FormatText(var_80_37.content)

				arg_77_1.text_.text = var_80_38

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_39 = 8
				local var_80_40 = utf8.len(var_80_38)
				local var_80_41 = var_80_39 <= 0 and var_80_35 or var_80_35 * (var_80_40 / var_80_39)

				if var_80_41 > 0 and var_80_35 < var_80_41 then
					arg_77_1.talkMaxDuration = var_80_41

					if var_80_41 + var_80_34 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_41 + var_80_34
					end
				end

				arg_77_1.text_.text = var_80_38
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011018", "story_v_out_323011.awb") ~= 0 then
					local var_80_42 = manager.audio:GetVoiceLength("story_v_out_323011", "323011018", "story_v_out_323011.awb") / 1000

					if var_80_42 + var_80_34 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_42 + var_80_34
					end

					if var_80_37.prefab_name ~= "" and arg_77_1.actors_[var_80_37.prefab_name] ~= nil then
						local var_80_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_37.prefab_name].transform, "story_v_out_323011", "323011018", "story_v_out_323011.awb")

						arg_77_1:RecordAudio("323011018", var_80_43)
						arg_77_1:RecordAudio("323011018", var_80_43)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_323011", "323011018", "story_v_out_323011.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_323011", "323011018", "story_v_out_323011.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_44 = math.max(var_80_35, arg_77_1.talkMaxDuration)

			if var_80_34 <= arg_77_1.time_ and arg_77_1.time_ < var_80_34 + var_80_44 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_34) / var_80_44

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_34 + var_80_44 and arg_77_1.time_ < var_80_34 + var_80_44 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10165ui_story",
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
	Play323011019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 323011019
		arg_81_1.duration_ = 6.63

		local var_81_0 = {
			zh = 6.633,
			ja = 6.566
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
				arg_81_0:Play323011020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10165ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10165ui_story == nil then
				arg_81_1.var_.characterEffect10165ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect10165ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10165ui_story then
				arg_81_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_84_4 = arg_81_1.actors_["10163ui_story"]
			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect10163ui_story == nil then
				arg_81_1.var_.characterEffect10163ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.200000002980232

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_6 and not isNil(var_84_4) then
				local var_84_7 = (arg_81_1.time_ - var_84_5) / var_84_6

				if arg_81_1.var_.characterEffect10163ui_story and not isNil(var_84_4) then
					local var_84_8 = Mathf.Lerp(0, 0.5, var_84_7)

					arg_81_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10163ui_story.fillRatio = var_84_8
				end
			end

			if arg_81_1.time_ >= var_84_5 + var_84_6 and arg_81_1.time_ < var_84_5 + var_84_6 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect10163ui_story then
				local var_84_9 = 0.5

				arg_81_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10163ui_story.fillRatio = var_84_9
			end

			local var_84_10 = 0

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_2")
			end

			local var_84_11 = 0

			if var_84_11 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_84_12 = 0
			local var_84_13 = 0.55

			if var_84_12 < arg_81_1.time_ and arg_81_1.time_ <= var_84_12 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_14 = arg_81_1:FormatText(StoryNameCfg[1446].name)

				arg_81_1.leftNameTxt_.text = var_84_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_15 = arg_81_1:GetWordFromCfg(323011019)
				local var_84_16 = arg_81_1:FormatText(var_84_15.content)

				arg_81_1.text_.text = var_84_16

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_17 = 22
				local var_84_18 = utf8.len(var_84_16)
				local var_84_19 = var_84_17 <= 0 and var_84_13 or var_84_13 * (var_84_18 / var_84_17)

				if var_84_19 > 0 and var_84_13 < var_84_19 then
					arg_81_1.talkMaxDuration = var_84_19

					if var_84_19 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_19 + var_84_12
					end
				end

				arg_81_1.text_.text = var_84_16
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011019", "story_v_out_323011.awb") ~= 0 then
					local var_84_20 = manager.audio:GetVoiceLength("story_v_out_323011", "323011019", "story_v_out_323011.awb") / 1000

					if var_84_20 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_20 + var_84_12
					end

					if var_84_15.prefab_name ~= "" and arg_81_1.actors_[var_84_15.prefab_name] ~= nil then
						local var_84_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_15.prefab_name].transform, "story_v_out_323011", "323011019", "story_v_out_323011.awb")

						arg_81_1:RecordAudio("323011019", var_84_21)
						arg_81_1:RecordAudio("323011019", var_84_21)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_323011", "323011019", "story_v_out_323011.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_323011", "323011019", "story_v_out_323011.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_22 = math.max(var_84_13, arg_81_1.talkMaxDuration)

			if var_84_12 <= arg_81_1.time_ and arg_81_1.time_ < var_84_12 + var_84_22 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_12) / var_84_22

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_12 + var_84_22 and arg_81_1.time_ < var_84_12 + var_84_22 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play323011020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 323011020
		arg_85_1.duration_ = 10.17

		local var_85_0 = {
			zh = 7.4,
			ja = 10.166
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
				arg_85_0:Play323011021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10163ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10163ui_story == nil then
				arg_85_1.var_.characterEffect10163ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.characterEffect10163ui_story and not isNil(var_88_0) then
					arg_85_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect10163ui_story then
				arg_85_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_88_4 = arg_85_1.actors_["10165ui_story"]
			local var_88_5 = 0

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect10165ui_story == nil then
				arg_85_1.var_.characterEffect10165ui_story = var_88_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_6 = 0.200000002980232

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_6 and not isNil(var_88_4) then
				local var_88_7 = (arg_85_1.time_ - var_88_5) / var_88_6

				if arg_85_1.var_.characterEffect10165ui_story and not isNil(var_88_4) then
					local var_88_8 = Mathf.Lerp(0, 0.5, var_88_7)

					arg_85_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10165ui_story.fillRatio = var_88_8
				end
			end

			if arg_85_1.time_ >= var_88_5 + var_88_6 and arg_85_1.time_ < var_88_5 + var_88_6 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect10165ui_story then
				local var_88_9 = 0.5

				arg_85_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10165ui_story.fillRatio = var_88_9
			end

			local var_88_10 = 0
			local var_88_11 = 0.625

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_12 = arg_85_1:FormatText(StoryNameCfg[1444].name)

				arg_85_1.leftNameTxt_.text = var_88_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_13 = arg_85_1:GetWordFromCfg(323011020)
				local var_88_14 = arg_85_1:FormatText(var_88_13.content)

				arg_85_1.text_.text = var_88_14

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_15 = 25
				local var_88_16 = utf8.len(var_88_14)
				local var_88_17 = var_88_15 <= 0 and var_88_11 or var_88_11 * (var_88_16 / var_88_15)

				if var_88_17 > 0 and var_88_11 < var_88_17 then
					arg_85_1.talkMaxDuration = var_88_17

					if var_88_17 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_17 + var_88_10
					end
				end

				arg_85_1.text_.text = var_88_14
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011020", "story_v_out_323011.awb") ~= 0 then
					local var_88_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011020", "story_v_out_323011.awb") / 1000

					if var_88_18 + var_88_10 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_18 + var_88_10
					end

					if var_88_13.prefab_name ~= "" and arg_85_1.actors_[var_88_13.prefab_name] ~= nil then
						local var_88_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_13.prefab_name].transform, "story_v_out_323011", "323011020", "story_v_out_323011.awb")

						arg_85_1:RecordAudio("323011020", var_88_19)
						arg_85_1:RecordAudio("323011020", var_88_19)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_323011", "323011020", "story_v_out_323011.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_323011", "323011020", "story_v_out_323011.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_20 = math.max(var_88_11, arg_85_1.talkMaxDuration)

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_20 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_10) / var_88_20

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_10 + var_88_20 and arg_85_1.time_ < var_88_10 + var_88_20 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play323011021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 323011021
		arg_89_1.duration_ = 2

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play323011022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10165ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10165ui_story == nil then
				arg_89_1.var_.characterEffect10165ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect10165ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10165ui_story then
				arg_89_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_92_4 = arg_89_1.actors_["10163ui_story"]
			local var_92_5 = 0

			if var_92_5 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect10163ui_story == nil then
				arg_89_1.var_.characterEffect10163ui_story = var_92_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_6 = 0.200000002980232

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_6 and not isNil(var_92_4) then
				local var_92_7 = (arg_89_1.time_ - var_92_5) / var_92_6

				if arg_89_1.var_.characterEffect10163ui_story and not isNil(var_92_4) then
					local var_92_8 = Mathf.Lerp(0, 0.5, var_92_7)

					arg_89_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10163ui_story.fillRatio = var_92_8
				end
			end

			if arg_89_1.time_ >= var_92_5 + var_92_6 and arg_89_1.time_ < var_92_5 + var_92_6 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect10163ui_story then
				local var_92_9 = 0.5

				arg_89_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10163ui_story.fillRatio = var_92_9
			end

			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 then
				arg_89_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_92_11 = 0

			if var_92_11 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_92_12 = 0
			local var_92_13 = 0.075

			if var_92_12 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_14 = arg_89_1:FormatText(StoryNameCfg[1446].name)

				arg_89_1.leftNameTxt_.text = var_92_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_15 = arg_89_1:GetWordFromCfg(323011021)
				local var_92_16 = arg_89_1:FormatText(var_92_15.content)

				arg_89_1.text_.text = var_92_16

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_17 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011021", "story_v_out_323011.awb") ~= 0 then
					local var_92_20 = manager.audio:GetVoiceLength("story_v_out_323011", "323011021", "story_v_out_323011.awb") / 1000

					if var_92_20 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_20 + var_92_12
					end

					if var_92_15.prefab_name ~= "" and arg_89_1.actors_[var_92_15.prefab_name] ~= nil then
						local var_92_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_15.prefab_name].transform, "story_v_out_323011", "323011021", "story_v_out_323011.awb")

						arg_89_1:RecordAudio("323011021", var_92_21)
						arg_89_1:RecordAudio("323011021", var_92_21)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_323011", "323011021", "story_v_out_323011.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_323011", "323011021", "story_v_out_323011.awb")
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
	Play323011022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 323011022
		arg_93_1.duration_ = 6.8

		local var_93_0 = {
			zh = 4.1,
			ja = 6.8
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
				arg_93_0:Play323011023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10163ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10163ui_story == nil then
				arg_93_1.var_.characterEffect10163ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect10163ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10163ui_story then
				arg_93_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_96_4 = arg_93_1.actors_["10165ui_story"]
			local var_96_5 = 0

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect10165ui_story == nil then
				arg_93_1.var_.characterEffect10165ui_story = var_96_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_6 = 0.200000002980232

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_6 and not isNil(var_96_4) then
				local var_96_7 = (arg_93_1.time_ - var_96_5) / var_96_6

				if arg_93_1.var_.characterEffect10165ui_story and not isNil(var_96_4) then
					local var_96_8 = Mathf.Lerp(0, 0.5, var_96_7)

					arg_93_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10165ui_story.fillRatio = var_96_8
				end
			end

			if arg_93_1.time_ >= var_96_5 + var_96_6 and arg_93_1.time_ < var_96_5 + var_96_6 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect10165ui_story then
				local var_96_9 = 0.5

				arg_93_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10165ui_story.fillRatio = var_96_9
			end

			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_1")
			end

			local var_96_11 = 0
			local var_96_12 = 0.375

			if var_96_11 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_13 = arg_93_1:FormatText(StoryNameCfg[1444].name)

				arg_93_1.leftNameTxt_.text = var_96_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_14 = arg_93_1:GetWordFromCfg(323011022)
				local var_96_15 = arg_93_1:FormatText(var_96_14.content)

				arg_93_1.text_.text = var_96_15

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011022", "story_v_out_323011.awb") ~= 0 then
					local var_96_19 = manager.audio:GetVoiceLength("story_v_out_323011", "323011022", "story_v_out_323011.awb") / 1000

					if var_96_19 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_11
					end

					if var_96_14.prefab_name ~= "" and arg_93_1.actors_[var_96_14.prefab_name] ~= nil then
						local var_96_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_14.prefab_name].transform, "story_v_out_323011", "323011022", "story_v_out_323011.awb")

						arg_93_1:RecordAudio("323011022", var_96_20)
						arg_93_1:RecordAudio("323011022", var_96_20)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_323011", "323011022", "story_v_out_323011.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_323011", "323011022", "story_v_out_323011.awb")
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
	Play323011023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 323011023
		arg_97_1.duration_ = 9.1

		local var_97_0 = {
			zh = 9.1,
			ja = 6.466
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
				arg_97_0:Play323011024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10165ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10165ui_story == nil then
				arg_97_1.var_.characterEffect10165ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect10165ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10165ui_story then
				arg_97_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_100_4 = arg_97_1.actors_["10163ui_story"]
			local var_100_5 = 0

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect10163ui_story == nil then
				arg_97_1.var_.characterEffect10163ui_story = var_100_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_6 = 0.200000002980232

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_6 and not isNil(var_100_4) then
				local var_100_7 = (arg_97_1.time_ - var_100_5) / var_100_6

				if arg_97_1.var_.characterEffect10163ui_story and not isNil(var_100_4) then
					local var_100_8 = Mathf.Lerp(0, 0.5, var_100_7)

					arg_97_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10163ui_story.fillRatio = var_100_8
				end
			end

			if arg_97_1.time_ >= var_100_5 + var_100_6 and arg_97_1.time_ < var_100_5 + var_100_6 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect10163ui_story then
				local var_100_9 = 0.5

				arg_97_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10163ui_story.fillRatio = var_100_9
			end

			local var_100_10 = 0
			local var_100_11 = 0.775

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_12 = arg_97_1:FormatText(StoryNameCfg[1446].name)

				arg_97_1.leftNameTxt_.text = var_100_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_13 = arg_97_1:GetWordFromCfg(323011023)
				local var_100_14 = arg_97_1:FormatText(var_100_13.content)

				arg_97_1.text_.text = var_100_14

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_15 = 32
				local var_100_16 = utf8.len(var_100_14)
				local var_100_17 = var_100_15 <= 0 and var_100_11 or var_100_11 * (var_100_16 / var_100_15)

				if var_100_17 > 0 and var_100_11 < var_100_17 then
					arg_97_1.talkMaxDuration = var_100_17

					if var_100_17 + var_100_10 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_17 + var_100_10
					end
				end

				arg_97_1.text_.text = var_100_14
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011023", "story_v_out_323011.awb") ~= 0 then
					local var_100_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011023", "story_v_out_323011.awb") / 1000

					if var_100_18 + var_100_10 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_18 + var_100_10
					end

					if var_100_13.prefab_name ~= "" and arg_97_1.actors_[var_100_13.prefab_name] ~= nil then
						local var_100_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_13.prefab_name].transform, "story_v_out_323011", "323011023", "story_v_out_323011.awb")

						arg_97_1:RecordAudio("323011023", var_100_19)
						arg_97_1:RecordAudio("323011023", var_100_19)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_323011", "323011023", "story_v_out_323011.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_323011", "323011023", "story_v_out_323011.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_20 = math.max(var_100_11, arg_97_1.talkMaxDuration)

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_20 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_10) / var_100_20

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_10 + var_100_20 and arg_97_1.time_ < var_100_10 + var_100_20 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play323011024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 323011024
		arg_101_1.duration_ = 12.1

		local var_101_0 = {
			zh = 8.2,
			ja = 12.1
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
				arg_101_0:Play323011025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10163ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10163ui_story == nil then
				arg_101_1.var_.characterEffect10163ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10163ui_story and not isNil(var_104_0) then
					arg_101_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10163ui_story then
				arg_101_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_104_4 = arg_101_1.actors_["10165ui_story"]
			local var_104_5 = 0

			if var_104_5 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect10165ui_story == nil then
				arg_101_1.var_.characterEffect10165ui_story = var_104_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_6 = 0.200000002980232

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_6 and not isNil(var_104_4) then
				local var_104_7 = (arg_101_1.time_ - var_104_5) / var_104_6

				if arg_101_1.var_.characterEffect10165ui_story and not isNil(var_104_4) then
					local var_104_8 = Mathf.Lerp(0, 0.5, var_104_7)

					arg_101_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10165ui_story.fillRatio = var_104_8
				end
			end

			if arg_101_1.time_ >= var_104_5 + var_104_6 and arg_101_1.time_ < var_104_5 + var_104_6 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect10165ui_story then
				local var_104_9 = 0.5

				arg_101_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10165ui_story.fillRatio = var_104_9
			end

			local var_104_10 = 0
			local var_104_11 = 0.7

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_12 = arg_101_1:FormatText(StoryNameCfg[1444].name)

				arg_101_1.leftNameTxt_.text = var_104_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_13 = arg_101_1:GetWordFromCfg(323011024)
				local var_104_14 = arg_101_1:FormatText(var_104_13.content)

				arg_101_1.text_.text = var_104_14

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_15 = 28
				local var_104_16 = utf8.len(var_104_14)
				local var_104_17 = var_104_15 <= 0 and var_104_11 or var_104_11 * (var_104_16 / var_104_15)

				if var_104_17 > 0 and var_104_11 < var_104_17 then
					arg_101_1.talkMaxDuration = var_104_17

					if var_104_17 + var_104_10 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_17 + var_104_10
					end
				end

				arg_101_1.text_.text = var_104_14
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011024", "story_v_out_323011.awb") ~= 0 then
					local var_104_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011024", "story_v_out_323011.awb") / 1000

					if var_104_18 + var_104_10 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_18 + var_104_10
					end

					if var_104_13.prefab_name ~= "" and arg_101_1.actors_[var_104_13.prefab_name] ~= nil then
						local var_104_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_13.prefab_name].transform, "story_v_out_323011", "323011024", "story_v_out_323011.awb")

						arg_101_1:RecordAudio("323011024", var_104_19)
						arg_101_1:RecordAudio("323011024", var_104_19)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_323011", "323011024", "story_v_out_323011.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_323011", "323011024", "story_v_out_323011.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_20 = math.max(var_104_11, arg_101_1.talkMaxDuration)

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_20 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_10) / var_104_20

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_10 + var_104_20 and arg_101_1.time_ < var_104_10 + var_104_20 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play323011025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 323011025
		arg_105_1.duration_ = 2

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play323011026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10165ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10165ui_story == nil then
				arg_105_1.var_.characterEffect10165ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect10165ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10165ui_story then
				arg_105_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_108_4 = arg_105_1.actors_["10163ui_story"]
			local var_108_5 = 0

			if var_108_5 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect10163ui_story == nil then
				arg_105_1.var_.characterEffect10163ui_story = var_108_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.200000002980232

			if var_108_5 <= arg_105_1.time_ and arg_105_1.time_ < var_108_5 + var_108_6 and not isNil(var_108_4) then
				local var_108_7 = (arg_105_1.time_ - var_108_5) / var_108_6

				if arg_105_1.var_.characterEffect10163ui_story and not isNil(var_108_4) then
					local var_108_8 = Mathf.Lerp(0, 0.5, var_108_7)

					arg_105_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10163ui_story.fillRatio = var_108_8
				end
			end

			if arg_105_1.time_ >= var_108_5 + var_108_6 and arg_105_1.time_ < var_108_5 + var_108_6 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect10163ui_story then
				local var_108_9 = 0.5

				arg_105_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10163ui_story.fillRatio = var_108_9
			end

			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_108_11 = 0
			local var_108_12 = 0.075

			if var_108_11 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_13 = arg_105_1:FormatText(StoryNameCfg[1446].name)

				arg_105_1.leftNameTxt_.text = var_108_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_14 = arg_105_1:GetWordFromCfg(323011025)
				local var_108_15 = arg_105_1:FormatText(var_108_14.content)

				arg_105_1.text_.text = var_108_15

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_16 = 3
				local var_108_17 = utf8.len(var_108_15)
				local var_108_18 = var_108_16 <= 0 and var_108_12 or var_108_12 * (var_108_17 / var_108_16)

				if var_108_18 > 0 and var_108_12 < var_108_18 then
					arg_105_1.talkMaxDuration = var_108_18

					if var_108_18 + var_108_11 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_18 + var_108_11
					end
				end

				arg_105_1.text_.text = var_108_15
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011025", "story_v_out_323011.awb") ~= 0 then
					local var_108_19 = manager.audio:GetVoiceLength("story_v_out_323011", "323011025", "story_v_out_323011.awb") / 1000

					if var_108_19 + var_108_11 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_19 + var_108_11
					end

					if var_108_14.prefab_name ~= "" and arg_105_1.actors_[var_108_14.prefab_name] ~= nil then
						local var_108_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_14.prefab_name].transform, "story_v_out_323011", "323011025", "story_v_out_323011.awb")

						arg_105_1:RecordAudio("323011025", var_108_20)
						arg_105_1:RecordAudio("323011025", var_108_20)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_323011", "323011025", "story_v_out_323011.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_323011", "323011025", "story_v_out_323011.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_21 = math.max(var_108_12, arg_105_1.talkMaxDuration)

			if var_108_11 <= arg_105_1.time_ and arg_105_1.time_ < var_108_11 + var_108_21 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_11) / var_108_21

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_11 + var_108_21 and arg_105_1.time_ < var_108_11 + var_108_21 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play323011026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 323011026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play323011027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10165ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10165ui_story == nil then
				arg_109_1.var_.characterEffect10165ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect10165ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10165ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10165ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10165ui_story.fillRatio = var_112_5
			end

			local var_112_6 = arg_109_1.actors_["10163ui_story"].transform
			local var_112_7 = 0

			if var_112_7 < arg_109_1.time_ and arg_109_1.time_ <= var_112_7 + arg_112_0 then
				arg_109_1.var_.moveOldPos10163ui_story = var_112_6.localPosition

				local var_112_8 = GameObjectTools.GetOrAddComponent(var_112_6.gameObject, typeof(DynamicBoneHelper))

				if var_112_8 then
					var_112_8:EnableDynamicBone(false)
				end
			end

			local var_112_9 = 0.001

			if var_112_7 <= arg_109_1.time_ and arg_109_1.time_ < var_112_7 + var_112_9 then
				local var_112_10 = (arg_109_1.time_ - var_112_7) / var_112_9
				local var_112_11 = Vector3.New(0, 100, 0)

				var_112_6.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10163ui_story, var_112_11, var_112_10)

				local var_112_12 = manager.ui.mainCamera.transform.position - var_112_6.position

				var_112_6.forward = Vector3.New(var_112_12.x, var_112_12.y, var_112_12.z)

				local var_112_13 = var_112_6.localEulerAngles

				var_112_13.z = 0
				var_112_13.x = 0
				var_112_6.localEulerAngles = var_112_13
			end

			if arg_109_1.time_ >= var_112_7 + var_112_9 and arg_109_1.time_ < var_112_7 + var_112_9 + arg_112_0 then
				var_112_6.localPosition = Vector3.New(0, 100, 0)

				local var_112_14 = manager.ui.mainCamera.transform.position - var_112_6.position

				var_112_6.forward = Vector3.New(var_112_14.x, var_112_14.y, var_112_14.z)

				local var_112_15 = var_112_6.localEulerAngles

				var_112_15.z = 0
				var_112_15.x = 0
				var_112_6.localEulerAngles = var_112_15

				local var_112_16 = GameObjectTools.GetOrAddComponent(var_112_6.gameObject, typeof(DynamicBoneHelper))

				if var_112_16 then
					var_112_16:EnableDynamicBone(true)
				end
			end

			local var_112_17 = arg_109_1.actors_["10165ui_story"].transform
			local var_112_18 = 0

			if var_112_18 < arg_109_1.time_ and arg_109_1.time_ <= var_112_18 + arg_112_0 then
				arg_109_1.var_.moveOldPos10165ui_story = var_112_17.localPosition

				local var_112_19 = GameObjectTools.GetOrAddComponent(var_112_17.gameObject, typeof(DynamicBoneHelper))

				if var_112_19 then
					var_112_19:EnableDynamicBone(false)
				end
			end

			local var_112_20 = 0.001

			if var_112_18 <= arg_109_1.time_ and arg_109_1.time_ < var_112_18 + var_112_20 then
				local var_112_21 = (arg_109_1.time_ - var_112_18) / var_112_20
				local var_112_22 = Vector3.New(0, 100, 0)

				var_112_17.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10165ui_story, var_112_22, var_112_21)

				local var_112_23 = manager.ui.mainCamera.transform.position - var_112_17.position

				var_112_17.forward = Vector3.New(var_112_23.x, var_112_23.y, var_112_23.z)

				local var_112_24 = var_112_17.localEulerAngles

				var_112_24.z = 0
				var_112_24.x = 0
				var_112_17.localEulerAngles = var_112_24
			end

			if arg_109_1.time_ >= var_112_18 + var_112_20 and arg_109_1.time_ < var_112_18 + var_112_20 + arg_112_0 then
				var_112_17.localPosition = Vector3.New(0, 100, 0)

				local var_112_25 = manager.ui.mainCamera.transform.position - var_112_17.position

				var_112_17.forward = Vector3.New(var_112_25.x, var_112_25.y, var_112_25.z)

				local var_112_26 = var_112_17.localEulerAngles

				var_112_26.z = 0
				var_112_26.x = 0
				var_112_17.localEulerAngles = var_112_26

				local var_112_27 = GameObjectTools.GetOrAddComponent(var_112_17.gameObject, typeof(DynamicBoneHelper))

				if var_112_27 then
					var_112_27:EnableDynamicBone(true)
				end
			end

			local var_112_28 = 0.166666666666667
			local var_112_29 = 1

			if var_112_28 < arg_109_1.time_ and arg_109_1.time_ <= var_112_28 + arg_112_0 then
				local var_112_30 = "play"
				local var_112_31 = "effect"

				arg_109_1:AudioAction(var_112_30, var_112_31, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_112_32 = 0
			local var_112_33 = 1.3

			if var_112_32 < arg_109_1.time_ and arg_109_1.time_ <= var_112_32 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_34 = arg_109_1:GetWordFromCfg(323011026)
				local var_112_35 = arg_109_1:FormatText(var_112_34.content)

				arg_109_1.text_.text = var_112_35

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_36 = 52
				local var_112_37 = utf8.len(var_112_35)
				local var_112_38 = var_112_36 <= 0 and var_112_33 or var_112_33 * (var_112_37 / var_112_36)

				if var_112_38 > 0 and var_112_33 < var_112_38 then
					arg_109_1.talkMaxDuration = var_112_38

					if var_112_38 + var_112_32 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_38 + var_112_32
					end
				end

				arg_109_1.text_.text = var_112_35
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_39 = math.max(var_112_33, arg_109_1.talkMaxDuration)

			if var_112_32 <= arg_109_1.time_ and arg_109_1.time_ < var_112_32 + var_112_39 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_32) / var_112_39

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_32 + var_112_39 and arg_109_1.time_ < var_112_32 + var_112_39 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play323011027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 323011027
		arg_113_1.duration_ = 8.5

		local var_113_0 = {
			zh = 3.8,
			ja = 8.5
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
				arg_113_0:Play323011028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10163ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect10163ui_story == nil then
				arg_113_1.var_.characterEffect10163ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect10163ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect10163ui_story then
				arg_113_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_116_4 = 0

			if var_116_4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_2")
			end

			local var_116_5 = 0

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_116_6 = arg_113_1.actors_["10163ui_story"].transform
			local var_116_7 = 0

			if var_116_7 < arg_113_1.time_ and arg_113_1.time_ <= var_116_7 + arg_116_0 then
				arg_113_1.var_.moveOldPos10163ui_story = var_116_6.localPosition

				local var_116_8 = GameObjectTools.GetOrAddComponent(var_116_6.gameObject, typeof(DynamicBoneHelper))

				if var_116_8 then
					var_116_8:EnableDynamicBone(false)
				end
			end

			local var_116_9 = 0.001

			if var_116_7 <= arg_113_1.time_ and arg_113_1.time_ < var_116_7 + var_116_9 then
				local var_116_10 = (arg_113_1.time_ - var_116_7) / var_116_9
				local var_116_11 = Vector3.New(0, -1.08, -5.83)

				var_116_6.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10163ui_story, var_116_11, var_116_10)

				local var_116_12 = manager.ui.mainCamera.transform.position - var_116_6.position

				var_116_6.forward = Vector3.New(var_116_12.x, var_116_12.y, var_116_12.z)

				local var_116_13 = var_116_6.localEulerAngles

				var_116_13.z = 0
				var_116_13.x = 0
				var_116_6.localEulerAngles = var_116_13
			end

			if arg_113_1.time_ >= var_116_7 + var_116_9 and arg_113_1.time_ < var_116_7 + var_116_9 + arg_116_0 then
				var_116_6.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_116_14 = manager.ui.mainCamera.transform.position - var_116_6.position

				var_116_6.forward = Vector3.New(var_116_14.x, var_116_14.y, var_116_14.z)

				local var_116_15 = var_116_6.localEulerAngles

				var_116_15.z = 0
				var_116_15.x = 0
				var_116_6.localEulerAngles = var_116_15

				local var_116_16 = GameObjectTools.GetOrAddComponent(var_116_6.gameObject, typeof(DynamicBoneHelper))

				if var_116_16 then
					var_116_16:EnableDynamicBone(true)
				end
			end

			local var_116_17 = 0
			local var_116_18 = 0.325

			if var_116_17 < arg_113_1.time_ and arg_113_1.time_ <= var_116_17 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_19 = arg_113_1:FormatText(StoryNameCfg[1444].name)

				arg_113_1.leftNameTxt_.text = var_116_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_20 = arg_113_1:GetWordFromCfg(323011027)
				local var_116_21 = arg_113_1:FormatText(var_116_20.content)

				arg_113_1.text_.text = var_116_21

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_22 = 13
				local var_116_23 = utf8.len(var_116_21)
				local var_116_24 = var_116_22 <= 0 and var_116_18 or var_116_18 * (var_116_23 / var_116_22)

				if var_116_24 > 0 and var_116_18 < var_116_24 then
					arg_113_1.talkMaxDuration = var_116_24

					if var_116_24 + var_116_17 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_24 + var_116_17
					end
				end

				arg_113_1.text_.text = var_116_21
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011027", "story_v_out_323011.awb") ~= 0 then
					local var_116_25 = manager.audio:GetVoiceLength("story_v_out_323011", "323011027", "story_v_out_323011.awb") / 1000

					if var_116_25 + var_116_17 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_25 + var_116_17
					end

					if var_116_20.prefab_name ~= "" and arg_113_1.actors_[var_116_20.prefab_name] ~= nil then
						local var_116_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_20.prefab_name].transform, "story_v_out_323011", "323011027", "story_v_out_323011.awb")

						arg_113_1:RecordAudio("323011027", var_116_26)
						arg_113_1:RecordAudio("323011027", var_116_26)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_323011", "323011027", "story_v_out_323011.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_323011", "323011027", "story_v_out_323011.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_27 = math.max(var_116_18, arg_113_1.talkMaxDuration)

			if var_116_17 <= arg_113_1.time_ and arg_113_1.time_ < var_116_17 + var_116_27 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_17) / var_116_27

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_17 + var_116_27 and arg_113_1.time_ < var_116_17 + var_116_27 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
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
	Play323011028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 323011028
		arg_117_1.duration_ = 10.03

		local var_117_0 = {
			zh = 5.166,
			ja = 10.033
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
				arg_117_0:Play323011029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.525

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[1444].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(323011028)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 21
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011028", "story_v_out_323011.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011028", "story_v_out_323011.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_323011", "323011028", "story_v_out_323011.awb")

						arg_117_1:RecordAudio("323011028", var_120_9)
						arg_117_1:RecordAudio("323011028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_323011", "323011028", "story_v_out_323011.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_323011", "323011028", "story_v_out_323011.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play323011029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 323011029
		arg_121_1.duration_ = 4.2

		local var_121_0 = {
			zh = 3,
			ja = 4.2
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
				arg_121_0:Play323011030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10165ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10165ui_story == nil then
				arg_121_1.var_.characterEffect10165ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect10165ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect10165ui_story then
				arg_121_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_124_4 = arg_121_1.actors_["10163ui_story"]
			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect10163ui_story == nil then
				arg_121_1.var_.characterEffect10163ui_story = var_124_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_6 = 0.200000002980232

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_6 and not isNil(var_124_4) then
				local var_124_7 = (arg_121_1.time_ - var_124_5) / var_124_6

				if arg_121_1.var_.characterEffect10163ui_story and not isNil(var_124_4) then
					local var_124_8 = Mathf.Lerp(0, 0.5, var_124_7)

					arg_121_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10163ui_story.fillRatio = var_124_8
				end
			end

			if arg_121_1.time_ >= var_124_5 + var_124_6 and arg_121_1.time_ < var_124_5 + var_124_6 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect10163ui_story then
				local var_124_9 = 0.5

				arg_121_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10163ui_story.fillRatio = var_124_9
			end

			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			local var_124_11 = arg_121_1.actors_["10163ui_story"].transform
			local var_124_12 = 0

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.var_.moveOldPos10163ui_story = var_124_11.localPosition

				local var_124_13 = GameObjectTools.GetOrAddComponent(var_124_11.gameObject, typeof(DynamicBoneHelper))

				if var_124_13 then
					var_124_13:EnableDynamicBone(false)
				end
			end

			local var_124_14 = 0.001

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_14 then
				local var_124_15 = (arg_121_1.time_ - var_124_12) / var_124_14
				local var_124_16 = Vector3.New(-0.74, -1.08, -5.83)

				var_124_11.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10163ui_story, var_124_16, var_124_15)

				local var_124_17 = manager.ui.mainCamera.transform.position - var_124_11.position

				var_124_11.forward = Vector3.New(var_124_17.x, var_124_17.y, var_124_17.z)

				local var_124_18 = var_124_11.localEulerAngles

				var_124_18.z = 0
				var_124_18.x = 0
				var_124_11.localEulerAngles = var_124_18
			end

			if arg_121_1.time_ >= var_124_12 + var_124_14 and arg_121_1.time_ < var_124_12 + var_124_14 + arg_124_0 then
				var_124_11.localPosition = Vector3.New(-0.74, -1.08, -5.83)

				local var_124_19 = manager.ui.mainCamera.transform.position - var_124_11.position

				var_124_11.forward = Vector3.New(var_124_19.x, var_124_19.y, var_124_19.z)

				local var_124_20 = var_124_11.localEulerAngles

				var_124_20.z = 0
				var_124_20.x = 0
				var_124_11.localEulerAngles = var_124_20

				local var_124_21 = GameObjectTools.GetOrAddComponent(var_124_11.gameObject, typeof(DynamicBoneHelper))

				if var_124_21 then
					var_124_21:EnableDynamicBone(true)
				end
			end

			local var_124_22 = arg_121_1.actors_["10165ui_story"].transform
			local var_124_23 = 0

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 then
				arg_121_1.var_.moveOldPos10165ui_story = var_124_22.localPosition

				local var_124_24 = GameObjectTools.GetOrAddComponent(var_124_22.gameObject, typeof(DynamicBoneHelper))

				if var_124_24 then
					var_124_24:EnableDynamicBone(false)
				end
			end

			local var_124_25 = 0.001

			if var_124_23 <= arg_121_1.time_ and arg_121_1.time_ < var_124_23 + var_124_25 then
				local var_124_26 = (arg_121_1.time_ - var_124_23) / var_124_25
				local var_124_27 = Vector3.New(0.7, -1.08, -5.83)

				var_124_22.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10165ui_story, var_124_27, var_124_26)

				local var_124_28 = manager.ui.mainCamera.transform.position - var_124_22.position

				var_124_22.forward = Vector3.New(var_124_28.x, var_124_28.y, var_124_28.z)

				local var_124_29 = var_124_22.localEulerAngles

				var_124_29.z = 0
				var_124_29.x = 0
				var_124_22.localEulerAngles = var_124_29
			end

			if arg_121_1.time_ >= var_124_23 + var_124_25 and arg_121_1.time_ < var_124_23 + var_124_25 + arg_124_0 then
				var_124_22.localPosition = Vector3.New(0.7, -1.08, -5.83)

				local var_124_30 = manager.ui.mainCamera.transform.position - var_124_22.position

				var_124_22.forward = Vector3.New(var_124_30.x, var_124_30.y, var_124_30.z)

				local var_124_31 = var_124_22.localEulerAngles

				var_124_31.z = 0
				var_124_31.x = 0
				var_124_22.localEulerAngles = var_124_31

				local var_124_32 = GameObjectTools.GetOrAddComponent(var_124_22.gameObject, typeof(DynamicBoneHelper))

				if var_124_32 then
					var_124_32:EnableDynamicBone(true)
				end
			end

			local var_124_33 = 0
			local var_124_34 = 0.325

			if var_124_33 < arg_121_1.time_ and arg_121_1.time_ <= var_124_33 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_35 = arg_121_1:FormatText(StoryNameCfg[1446].name)

				arg_121_1.leftNameTxt_.text = var_124_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_36 = arg_121_1:GetWordFromCfg(323011029)
				local var_124_37 = arg_121_1:FormatText(var_124_36.content)

				arg_121_1.text_.text = var_124_37

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_38 = 13
				local var_124_39 = utf8.len(var_124_37)
				local var_124_40 = var_124_38 <= 0 and var_124_34 or var_124_34 * (var_124_39 / var_124_38)

				if var_124_40 > 0 and var_124_34 < var_124_40 then
					arg_121_1.talkMaxDuration = var_124_40

					if var_124_40 + var_124_33 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_40 + var_124_33
					end
				end

				arg_121_1.text_.text = var_124_37
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011029", "story_v_out_323011.awb") ~= 0 then
					local var_124_41 = manager.audio:GetVoiceLength("story_v_out_323011", "323011029", "story_v_out_323011.awb") / 1000

					if var_124_41 + var_124_33 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_41 + var_124_33
					end

					if var_124_36.prefab_name ~= "" and arg_121_1.actors_[var_124_36.prefab_name] ~= nil then
						local var_124_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_36.prefab_name].transform, "story_v_out_323011", "323011029", "story_v_out_323011.awb")

						arg_121_1:RecordAudio("323011029", var_124_42)
						arg_121_1:RecordAudio("323011029", var_124_42)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_323011", "323011029", "story_v_out_323011.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_323011", "323011029", "story_v_out_323011.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_43 = math.max(var_124_34, arg_121_1.talkMaxDuration)

			if var_124_33 <= arg_121_1.time_ and arg_121_1.time_ < var_124_33 + var_124_43 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_33) / var_124_43

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_33 + var_124_43 and arg_121_1.time_ < var_124_33 + var_124_43 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play323011030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 323011030
		arg_125_1.duration_ = 7.5

		local var_125_0 = {
			zh = 3.3,
			ja = 7.5
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
				arg_125_0:Play323011031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10163ui_story"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10163ui_story == nil then
				arg_125_1.var_.characterEffect10163ui_story = var_128_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.characterEffect10163ui_story and not isNil(var_128_0) then
					arg_125_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.characterEffect10163ui_story then
				arg_125_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_128_4 = arg_125_1.actors_["10165ui_story"]
			local var_128_5 = 0

			if var_128_5 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect10165ui_story == nil then
				arg_125_1.var_.characterEffect10165ui_story = var_128_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.200000002980232

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 and not isNil(var_128_4) then
				local var_128_7 = (arg_125_1.time_ - var_128_5) / var_128_6

				if arg_125_1.var_.characterEffect10165ui_story and not isNil(var_128_4) then
					local var_128_8 = Mathf.Lerp(0, 0.5, var_128_7)

					arg_125_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10165ui_story.fillRatio = var_128_8
				end
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect10165ui_story then
				local var_128_9 = 0.5

				arg_125_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10165ui_story.fillRatio = var_128_9
			end

			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 then
				arg_125_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			local var_128_11 = 0

			if var_128_11 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_128_12 = 0
			local var_128_13 = 0.35

			if var_128_12 < arg_125_1.time_ and arg_125_1.time_ <= var_128_12 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_14 = arg_125_1:FormatText(StoryNameCfg[1444].name)

				arg_125_1.leftNameTxt_.text = var_128_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_15 = arg_125_1:GetWordFromCfg(323011030)
				local var_128_16 = arg_125_1:FormatText(var_128_15.content)

				arg_125_1.text_.text = var_128_16

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_17 = 14
				local var_128_18 = utf8.len(var_128_16)
				local var_128_19 = var_128_17 <= 0 and var_128_13 or var_128_13 * (var_128_18 / var_128_17)

				if var_128_19 > 0 and var_128_13 < var_128_19 then
					arg_125_1.talkMaxDuration = var_128_19

					if var_128_19 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_19 + var_128_12
					end
				end

				arg_125_1.text_.text = var_128_16
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011030", "story_v_out_323011.awb") ~= 0 then
					local var_128_20 = manager.audio:GetVoiceLength("story_v_out_323011", "323011030", "story_v_out_323011.awb") / 1000

					if var_128_20 + var_128_12 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_20 + var_128_12
					end

					if var_128_15.prefab_name ~= "" and arg_125_1.actors_[var_128_15.prefab_name] ~= nil then
						local var_128_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_15.prefab_name].transform, "story_v_out_323011", "323011030", "story_v_out_323011.awb")

						arg_125_1:RecordAudio("323011030", var_128_21)
						arg_125_1:RecordAudio("323011030", var_128_21)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_323011", "323011030", "story_v_out_323011.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_323011", "323011030", "story_v_out_323011.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_22 = math.max(var_128_13, arg_125_1.talkMaxDuration)

			if var_128_12 <= arg_125_1.time_ and arg_125_1.time_ < var_128_12 + var_128_22 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_12) / var_128_22

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_12 + var_128_22 and arg_125_1.time_ < var_128_12 + var_128_22 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play323011031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 323011031
		arg_129_1.duration_ = 5.47

		local var_129_0 = {
			zh = 5.466,
			ja = 4.8
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
				arg_129_0:Play323011032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10165ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10165ui_story == nil then
				arg_129_1.var_.characterEffect10165ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect10165ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect10165ui_story then
				arg_129_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_132_4 = arg_129_1.actors_["10163ui_story"]
			local var_132_5 = 0

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect10163ui_story == nil then
				arg_129_1.var_.characterEffect10163ui_story = var_132_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_6 = 0.200000002980232

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_6 and not isNil(var_132_4) then
				local var_132_7 = (arg_129_1.time_ - var_132_5) / var_132_6

				if arg_129_1.var_.characterEffect10163ui_story and not isNil(var_132_4) then
					local var_132_8 = Mathf.Lerp(0, 0.5, var_132_7)

					arg_129_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10163ui_story.fillRatio = var_132_8
				end
			end

			if arg_129_1.time_ >= var_132_5 + var_132_6 and arg_129_1.time_ < var_132_5 + var_132_6 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect10163ui_story then
				local var_132_9 = 0.5

				arg_129_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10163ui_story.fillRatio = var_132_9
			end

			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 then
				arg_129_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_2")
			end

			local var_132_11 = 0

			if var_132_11 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_132_12 = 0
			local var_132_13 = 0.525

			if var_132_12 < arg_129_1.time_ and arg_129_1.time_ <= var_132_12 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_14 = arg_129_1:FormatText(StoryNameCfg[1446].name)

				arg_129_1.leftNameTxt_.text = var_132_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_15 = arg_129_1:GetWordFromCfg(323011031)
				local var_132_16 = arg_129_1:FormatText(var_132_15.content)

				arg_129_1.text_.text = var_132_16

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_17 = 22
				local var_132_18 = utf8.len(var_132_16)
				local var_132_19 = var_132_17 <= 0 and var_132_13 or var_132_13 * (var_132_18 / var_132_17)

				if var_132_19 > 0 and var_132_13 < var_132_19 then
					arg_129_1.talkMaxDuration = var_132_19

					if var_132_19 + var_132_12 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_19 + var_132_12
					end
				end

				arg_129_1.text_.text = var_132_16
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011031", "story_v_out_323011.awb") ~= 0 then
					local var_132_20 = manager.audio:GetVoiceLength("story_v_out_323011", "323011031", "story_v_out_323011.awb") / 1000

					if var_132_20 + var_132_12 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_20 + var_132_12
					end

					if var_132_15.prefab_name ~= "" and arg_129_1.actors_[var_132_15.prefab_name] ~= nil then
						local var_132_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_15.prefab_name].transform, "story_v_out_323011", "323011031", "story_v_out_323011.awb")

						arg_129_1:RecordAudio("323011031", var_132_21)
						arg_129_1:RecordAudio("323011031", var_132_21)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_323011", "323011031", "story_v_out_323011.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_323011", "323011031", "story_v_out_323011.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_22 = math.max(var_132_13, arg_129_1.talkMaxDuration)

			if var_132_12 <= arg_129_1.time_ and arg_129_1.time_ < var_132_12 + var_132_22 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_12) / var_132_22

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_12 + var_132_22 and arg_129_1.time_ < var_132_12 + var_132_22 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play323011032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 323011032
		arg_133_1.duration_ = 12.4

		local var_133_0 = {
			zh = 9.866,
			ja = 12.4
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
				arg_133_0:Play323011033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["10163ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10163ui_story == nil then
				arg_133_1.var_.characterEffect10163ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect10163ui_story and not isNil(var_136_0) then
					arg_133_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect10163ui_story then
				arg_133_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_136_4 = arg_133_1.actors_["10165ui_story"]
			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect10165ui_story == nil then
				arg_133_1.var_.characterEffect10165ui_story = var_136_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_6 = 0.200000002980232

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_6 and not isNil(var_136_4) then
				local var_136_7 = (arg_133_1.time_ - var_136_5) / var_136_6

				if arg_133_1.var_.characterEffect10165ui_story and not isNil(var_136_4) then
					local var_136_8 = Mathf.Lerp(0, 0.5, var_136_7)

					arg_133_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10165ui_story.fillRatio = var_136_8
				end
			end

			if arg_133_1.time_ >= var_136_5 + var_136_6 and arg_133_1.time_ < var_136_5 + var_136_6 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect10165ui_story then
				local var_136_9 = 0.5

				arg_133_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10165ui_story.fillRatio = var_136_9
			end

			local var_136_10 = 0
			local var_136_11 = 0.875

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_12 = arg_133_1:FormatText(StoryNameCfg[1444].name)

				arg_133_1.leftNameTxt_.text = var_136_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_13 = arg_133_1:GetWordFromCfg(323011032)
				local var_136_14 = arg_133_1:FormatText(var_136_13.content)

				arg_133_1.text_.text = var_136_14

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_15 = 35
				local var_136_16 = utf8.len(var_136_14)
				local var_136_17 = var_136_15 <= 0 and var_136_11 or var_136_11 * (var_136_16 / var_136_15)

				if var_136_17 > 0 and var_136_11 < var_136_17 then
					arg_133_1.talkMaxDuration = var_136_17

					if var_136_17 + var_136_10 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_17 + var_136_10
					end
				end

				arg_133_1.text_.text = var_136_14
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011032", "story_v_out_323011.awb") ~= 0 then
					local var_136_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011032", "story_v_out_323011.awb") / 1000

					if var_136_18 + var_136_10 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_18 + var_136_10
					end

					if var_136_13.prefab_name ~= "" and arg_133_1.actors_[var_136_13.prefab_name] ~= nil then
						local var_136_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_13.prefab_name].transform, "story_v_out_323011", "323011032", "story_v_out_323011.awb")

						arg_133_1:RecordAudio("323011032", var_136_19)
						arg_133_1:RecordAudio("323011032", var_136_19)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_323011", "323011032", "story_v_out_323011.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_323011", "323011032", "story_v_out_323011.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_20 = math.max(var_136_11, arg_133_1.talkMaxDuration)

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_20 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_10) / var_136_20

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_10 + var_136_20 and arg_133_1.time_ < var_136_10 + var_136_20 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play323011033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 323011033
		arg_137_1.duration_ = 10.43

		local var_137_0 = {
			zh = 10.433,
			ja = 8.5
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
				arg_137_0:Play323011034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10165ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect10165ui_story == nil then
				arg_137_1.var_.characterEffect10165ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect10165ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect10165ui_story then
				arg_137_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_140_4 = arg_137_1.actors_["10163ui_story"]
			local var_140_5 = 0

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect10163ui_story == nil then
				arg_137_1.var_.characterEffect10163ui_story = var_140_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_6 = 0.200000002980232

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_6 and not isNil(var_140_4) then
				local var_140_7 = (arg_137_1.time_ - var_140_5) / var_140_6

				if arg_137_1.var_.characterEffect10163ui_story and not isNil(var_140_4) then
					local var_140_8 = Mathf.Lerp(0, 0.5, var_140_7)

					arg_137_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10163ui_story.fillRatio = var_140_8
				end
			end

			if arg_137_1.time_ >= var_140_5 + var_140_6 and arg_137_1.time_ < var_140_5 + var_140_6 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect10163ui_story then
				local var_140_9 = 0.5

				arg_137_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10163ui_story.fillRatio = var_140_9
			end

			local var_140_10 = 0
			local var_140_11 = 0.9

			if var_140_10 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_12 = arg_137_1:FormatText(StoryNameCfg[1446].name)

				arg_137_1.leftNameTxt_.text = var_140_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_13 = arg_137_1:GetWordFromCfg(323011033)
				local var_140_14 = arg_137_1:FormatText(var_140_13.content)

				arg_137_1.text_.text = var_140_14

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_15 = 38
				local var_140_16 = utf8.len(var_140_14)
				local var_140_17 = var_140_15 <= 0 and var_140_11 or var_140_11 * (var_140_16 / var_140_15)

				if var_140_17 > 0 and var_140_11 < var_140_17 then
					arg_137_1.talkMaxDuration = var_140_17

					if var_140_17 + var_140_10 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_17 + var_140_10
					end
				end

				arg_137_1.text_.text = var_140_14
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011033", "story_v_out_323011.awb") ~= 0 then
					local var_140_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011033", "story_v_out_323011.awb") / 1000

					if var_140_18 + var_140_10 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_18 + var_140_10
					end

					if var_140_13.prefab_name ~= "" and arg_137_1.actors_[var_140_13.prefab_name] ~= nil then
						local var_140_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_13.prefab_name].transform, "story_v_out_323011", "323011033", "story_v_out_323011.awb")

						arg_137_1:RecordAudio("323011033", var_140_19)
						arg_137_1:RecordAudio("323011033", var_140_19)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_323011", "323011033", "story_v_out_323011.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_323011", "323011033", "story_v_out_323011.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_20 = math.max(var_140_11, arg_137_1.talkMaxDuration)

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_20 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_10) / var_140_20

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_10 + var_140_20 and arg_137_1.time_ < var_140_10 + var_140_20 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play323011034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 323011034
		arg_141_1.duration_ = 18.53

		local var_141_0 = {
			zh = 14.2,
			ja = 18.533
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
				arg_141_0:Play323011035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10163ui_story"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10163ui_story == nil then
				arg_141_1.var_.characterEffect10163ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.characterEffect10163ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect10163ui_story then
				arg_141_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_144_4 = arg_141_1.actors_["10165ui_story"]
			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect10165ui_story == nil then
				arg_141_1.var_.characterEffect10165ui_story = var_144_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_6 = 0.200000002980232

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_6 and not isNil(var_144_4) then
				local var_144_7 = (arg_141_1.time_ - var_144_5) / var_144_6

				if arg_141_1.var_.characterEffect10165ui_story and not isNil(var_144_4) then
					local var_144_8 = Mathf.Lerp(0, 0.5, var_144_7)

					arg_141_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10165ui_story.fillRatio = var_144_8
				end
			end

			if arg_141_1.time_ >= var_144_5 + var_144_6 and arg_141_1.time_ < var_144_5 + var_144_6 + arg_144_0 and not isNil(var_144_4) and arg_141_1.var_.characterEffect10165ui_story then
				local var_144_9 = 0.5

				arg_141_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10165ui_story.fillRatio = var_144_9
			end

			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_2")
			end

			local var_144_11 = 0

			if var_144_11 < arg_141_1.time_ and arg_141_1.time_ <= var_144_11 + arg_144_0 then
				arg_141_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_144_12 = 0
			local var_144_13 = 1.225

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_14 = arg_141_1:FormatText(StoryNameCfg[1444].name)

				arg_141_1.leftNameTxt_.text = var_144_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_15 = arg_141_1:GetWordFromCfg(323011034)
				local var_144_16 = arg_141_1:FormatText(var_144_15.content)

				arg_141_1.text_.text = var_144_16

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_17 = 48
				local var_144_18 = utf8.len(var_144_16)
				local var_144_19 = var_144_17 <= 0 and var_144_13 or var_144_13 * (var_144_18 / var_144_17)

				if var_144_19 > 0 and var_144_13 < var_144_19 then
					arg_141_1.talkMaxDuration = var_144_19

					if var_144_19 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_19 + var_144_12
					end
				end

				arg_141_1.text_.text = var_144_16
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011034", "story_v_out_323011.awb") ~= 0 then
					local var_144_20 = manager.audio:GetVoiceLength("story_v_out_323011", "323011034", "story_v_out_323011.awb") / 1000

					if var_144_20 + var_144_12 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_20 + var_144_12
					end

					if var_144_15.prefab_name ~= "" and arg_141_1.actors_[var_144_15.prefab_name] ~= nil then
						local var_144_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_15.prefab_name].transform, "story_v_out_323011", "323011034", "story_v_out_323011.awb")

						arg_141_1:RecordAudio("323011034", var_144_21)
						arg_141_1:RecordAudio("323011034", var_144_21)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_323011", "323011034", "story_v_out_323011.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_323011", "323011034", "story_v_out_323011.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_22 = math.max(var_144_13, arg_141_1.talkMaxDuration)

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_22 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_12) / var_144_22

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_12 + var_144_22 and arg_141_1.time_ < var_144_12 + var_144_22 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play323011035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 323011035
		arg_145_1.duration_ = 2.53

		local var_145_0 = {
			zh = 2.533,
			ja = 2.433
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
				arg_145_0:Play323011036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10165ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10165ui_story == nil then
				arg_145_1.var_.characterEffect10165ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect10165ui_story and not isNil(var_148_0) then
					arg_145_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect10165ui_story then
				arg_145_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_148_4 = arg_145_1.actors_["10163ui_story"]
			local var_148_5 = 0

			if var_148_5 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10163ui_story == nil then
				arg_145_1.var_.characterEffect10163ui_story = var_148_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_6 = 0.200000002980232

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_6 and not isNil(var_148_4) then
				local var_148_7 = (arg_145_1.time_ - var_148_5) / var_148_6

				if arg_145_1.var_.characterEffect10163ui_story and not isNil(var_148_4) then
					local var_148_8 = Mathf.Lerp(0, 0.5, var_148_7)

					arg_145_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10163ui_story.fillRatio = var_148_8
				end
			end

			if arg_145_1.time_ >= var_148_5 + var_148_6 and arg_145_1.time_ < var_148_5 + var_148_6 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect10163ui_story then
				local var_148_9 = 0.5

				arg_145_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10163ui_story.fillRatio = var_148_9
			end

			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_148_11 = 0

			if var_148_11 < arg_145_1.time_ and arg_145_1.time_ <= var_148_11 + arg_148_0 then
				arg_145_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_148_12 = 0
			local var_148_13 = 0.225

			if var_148_12 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_14 = arg_145_1:FormatText(StoryNameCfg[1446].name)

				arg_145_1.leftNameTxt_.text = var_148_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_15 = arg_145_1:GetWordFromCfg(323011035)
				local var_148_16 = arg_145_1:FormatText(var_148_15.content)

				arg_145_1.text_.text = var_148_16

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_17 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011035", "story_v_out_323011.awb") ~= 0 then
					local var_148_20 = manager.audio:GetVoiceLength("story_v_out_323011", "323011035", "story_v_out_323011.awb") / 1000

					if var_148_20 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_20 + var_148_12
					end

					if var_148_15.prefab_name ~= "" and arg_145_1.actors_[var_148_15.prefab_name] ~= nil then
						local var_148_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_15.prefab_name].transform, "story_v_out_323011", "323011035", "story_v_out_323011.awb")

						arg_145_1:RecordAudio("323011035", var_148_21)
						arg_145_1:RecordAudio("323011035", var_148_21)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_323011", "323011035", "story_v_out_323011.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_323011", "323011035", "story_v_out_323011.awb")
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
	Play323011036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 323011036
		arg_149_1.duration_ = 2

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play323011037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10163ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10163ui_story == nil then
				arg_149_1.var_.characterEffect10163ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect10163ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect10163ui_story then
				arg_149_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["10165ui_story"]
			local var_152_5 = 0

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect10165ui_story == nil then
				arg_149_1.var_.characterEffect10165ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_6 = 0.200000002980232

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_6 and not isNil(var_152_4) then
				local var_152_7 = (arg_149_1.time_ - var_152_5) / var_152_6

				if arg_149_1.var_.characterEffect10165ui_story and not isNil(var_152_4) then
					local var_152_8 = Mathf.Lerp(0, 0.5, var_152_7)

					arg_149_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10165ui_story.fillRatio = var_152_8
				end
			end

			if arg_149_1.time_ >= var_152_5 + var_152_6 and arg_149_1.time_ < var_152_5 + var_152_6 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect10165ui_story then
				local var_152_9 = 0.5

				arg_149_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10165ui_story.fillRatio = var_152_9
			end

			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_152_11 = 0

			if var_152_11 < arg_149_1.time_ and arg_149_1.time_ <= var_152_11 + arg_152_0 then
				arg_149_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_152_12 = 0
			local var_152_13 = 0.1

			if var_152_12 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_14 = arg_149_1:FormatText(StoryNameCfg[1444].name)

				arg_149_1.leftNameTxt_.text = var_152_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_15 = arg_149_1:GetWordFromCfg(323011036)
				local var_152_16 = arg_149_1:FormatText(var_152_15.content)

				arg_149_1.text_.text = var_152_16

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_17 = 4
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

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011036", "story_v_out_323011.awb") ~= 0 then
					local var_152_20 = manager.audio:GetVoiceLength("story_v_out_323011", "323011036", "story_v_out_323011.awb") / 1000

					if var_152_20 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_20 + var_152_12
					end

					if var_152_15.prefab_name ~= "" and arg_149_1.actors_[var_152_15.prefab_name] ~= nil then
						local var_152_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_15.prefab_name].transform, "story_v_out_323011", "323011036", "story_v_out_323011.awb")

						arg_149_1:RecordAudio("323011036", var_152_21)
						arg_149_1:RecordAudio("323011036", var_152_21)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_323011", "323011036", "story_v_out_323011.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_323011", "323011036", "story_v_out_323011.awb")
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
	Play323011037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 323011037
		arg_153_1.duration_ = 5.5

		local var_153_0 = {
			zh = 5.5,
			ja = 5.366
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
				arg_153_0:Play323011038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["10165ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10165ui_story == nil then
				arg_153_1.var_.characterEffect10165ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect10165ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect10165ui_story then
				arg_153_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_156_4 = arg_153_1.actors_["10163ui_story"]
			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect10163ui_story == nil then
				arg_153_1.var_.characterEffect10163ui_story = var_156_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_6 = 0.200000002980232

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 and not isNil(var_156_4) then
				local var_156_7 = (arg_153_1.time_ - var_156_5) / var_156_6

				if arg_153_1.var_.characterEffect10163ui_story and not isNil(var_156_4) then
					local var_156_8 = Mathf.Lerp(0, 0.5, var_156_7)

					arg_153_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10163ui_story.fillRatio = var_156_8
				end
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect10163ui_story then
				local var_156_9 = 0.5

				arg_153_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10163ui_story.fillRatio = var_156_9
			end

			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_156_11 = 0
			local var_156_12 = 0.675

			if var_156_11 < arg_153_1.time_ and arg_153_1.time_ <= var_156_11 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_13 = arg_153_1:FormatText(StoryNameCfg[1446].name)

				arg_153_1.leftNameTxt_.text = var_156_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_14 = arg_153_1:GetWordFromCfg(323011037)
				local var_156_15 = arg_153_1:FormatText(var_156_14.content)

				arg_153_1.text_.text = var_156_15

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_16 = 27
				local var_156_17 = utf8.len(var_156_15)
				local var_156_18 = var_156_16 <= 0 and var_156_12 or var_156_12 * (var_156_17 / var_156_16)

				if var_156_18 > 0 and var_156_12 < var_156_18 then
					arg_153_1.talkMaxDuration = var_156_18

					if var_156_18 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_18 + var_156_11
					end
				end

				arg_153_1.text_.text = var_156_15
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011037", "story_v_out_323011.awb") ~= 0 then
					local var_156_19 = manager.audio:GetVoiceLength("story_v_out_323011", "323011037", "story_v_out_323011.awb") / 1000

					if var_156_19 + var_156_11 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_19 + var_156_11
					end

					if var_156_14.prefab_name ~= "" and arg_153_1.actors_[var_156_14.prefab_name] ~= nil then
						local var_156_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_14.prefab_name].transform, "story_v_out_323011", "323011037", "story_v_out_323011.awb")

						arg_153_1:RecordAudio("323011037", var_156_20)
						arg_153_1:RecordAudio("323011037", var_156_20)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_323011", "323011037", "story_v_out_323011.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_323011", "323011037", "story_v_out_323011.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_21 = math.max(var_156_12, arg_153_1.talkMaxDuration)

			if var_156_11 <= arg_153_1.time_ and arg_153_1.time_ < var_156_11 + var_156_21 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_11) / var_156_21

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_11 + var_156_21 and arg_153_1.time_ < var_156_11 + var_156_21 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play323011038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 323011038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play323011039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10163ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10163ui_story = var_160_0.localPosition

				local var_160_2 = GameObjectTools.GetOrAddComponent(var_160_0.gameObject, typeof(DynamicBoneHelper))

				if var_160_2 then
					var_160_2:EnableDynamicBone(false)
				end
			end

			local var_160_3 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_3 then
				local var_160_4 = (arg_157_1.time_ - var_160_1) / var_160_3
				local var_160_5 = Vector3.New(0, 100, 0)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10163ui_story, var_160_5, var_160_4)

				local var_160_6 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_6.x, var_160_6.y, var_160_6.z)

				local var_160_7 = var_160_0.localEulerAngles

				var_160_7.z = 0
				var_160_7.x = 0
				var_160_0.localEulerAngles = var_160_7
			end

			if arg_157_1.time_ >= var_160_1 + var_160_3 and arg_157_1.time_ < var_160_1 + var_160_3 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, 100, 0)

				local var_160_8 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_8.x, var_160_8.y, var_160_8.z)

				local var_160_9 = var_160_0.localEulerAngles

				var_160_9.z = 0
				var_160_9.x = 0
				var_160_0.localEulerAngles = var_160_9

				local var_160_10 = GameObjectTools.GetOrAddComponent(var_160_0.gameObject, typeof(DynamicBoneHelper))

				if var_160_10 then
					var_160_10:EnableDynamicBone(true)
				end
			end

			local var_160_11 = arg_157_1.actors_["10165ui_story"].transform
			local var_160_12 = 0

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 then
				arg_157_1.var_.moveOldPos10165ui_story = var_160_11.localPosition

				local var_160_13 = GameObjectTools.GetOrAddComponent(var_160_11.gameObject, typeof(DynamicBoneHelper))

				if var_160_13 then
					var_160_13:EnableDynamicBone(false)
				end
			end

			local var_160_14 = 0.001

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_14 then
				local var_160_15 = (arg_157_1.time_ - var_160_12) / var_160_14
				local var_160_16 = Vector3.New(0, 100, 0)

				var_160_11.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10165ui_story, var_160_16, var_160_15)

				local var_160_17 = manager.ui.mainCamera.transform.position - var_160_11.position

				var_160_11.forward = Vector3.New(var_160_17.x, var_160_17.y, var_160_17.z)

				local var_160_18 = var_160_11.localEulerAngles

				var_160_18.z = 0
				var_160_18.x = 0
				var_160_11.localEulerAngles = var_160_18
			end

			if arg_157_1.time_ >= var_160_12 + var_160_14 and arg_157_1.time_ < var_160_12 + var_160_14 + arg_160_0 then
				var_160_11.localPosition = Vector3.New(0, 100, 0)

				local var_160_19 = manager.ui.mainCamera.transform.position - var_160_11.position

				var_160_11.forward = Vector3.New(var_160_19.x, var_160_19.y, var_160_19.z)

				local var_160_20 = var_160_11.localEulerAngles

				var_160_20.z = 0
				var_160_20.x = 0
				var_160_11.localEulerAngles = var_160_20

				local var_160_21 = GameObjectTools.GetOrAddComponent(var_160_11.gameObject, typeof(DynamicBoneHelper))

				if var_160_21 then
					var_160_21:EnableDynamicBone(true)
				end
			end

			local var_160_22 = arg_157_1.actors_["10165ui_story"]
			local var_160_23 = 0

			if var_160_23 < arg_157_1.time_ and arg_157_1.time_ <= var_160_23 + arg_160_0 and not isNil(var_160_22) and arg_157_1.var_.characterEffect10165ui_story == nil then
				arg_157_1.var_.characterEffect10165ui_story = var_160_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_24 = 0.200000002980232

			if var_160_23 <= arg_157_1.time_ and arg_157_1.time_ < var_160_23 + var_160_24 and not isNil(var_160_22) then
				local var_160_25 = (arg_157_1.time_ - var_160_23) / var_160_24

				if arg_157_1.var_.characterEffect10165ui_story and not isNil(var_160_22) then
					local var_160_26 = Mathf.Lerp(0, 0.5, var_160_25)

					arg_157_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10165ui_story.fillRatio = var_160_26
				end
			end

			if arg_157_1.time_ >= var_160_23 + var_160_24 and arg_157_1.time_ < var_160_23 + var_160_24 + arg_160_0 and not isNil(var_160_22) and arg_157_1.var_.characterEffect10165ui_story then
				local var_160_27 = 0.5

				arg_157_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10165ui_story.fillRatio = var_160_27
			end

			local var_160_28 = 0.366666666666667
			local var_160_29 = 1

			if var_160_28 < arg_157_1.time_ and arg_157_1.time_ <= var_160_28 + arg_160_0 then
				local var_160_30 = "play"
				local var_160_31 = "effect"

				arg_157_1:AudioAction(var_160_30, var_160_31, "se_story_148", "se_story_148_helmet_hit", "")
			end

			local var_160_32 = 0
			local var_160_33 = 0.925

			if var_160_32 < arg_157_1.time_ and arg_157_1.time_ <= var_160_32 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_34 = arg_157_1:GetWordFromCfg(323011038)
				local var_160_35 = arg_157_1:FormatText(var_160_34.content)

				arg_157_1.text_.text = var_160_35

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_36 = 37
				local var_160_37 = utf8.len(var_160_35)
				local var_160_38 = var_160_36 <= 0 and var_160_33 or var_160_33 * (var_160_37 / var_160_36)

				if var_160_38 > 0 and var_160_33 < var_160_38 then
					arg_157_1.talkMaxDuration = var_160_38

					if var_160_38 + var_160_32 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_38 + var_160_32
					end
				end

				arg_157_1.text_.text = var_160_35
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_39 = math.max(var_160_33, arg_157_1.talkMaxDuration)

			if var_160_32 <= arg_157_1.time_ and arg_157_1.time_ < var_160_32 + var_160_39 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_32) / var_160_39

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_32 + var_160_39 and arg_157_1.time_ < var_160_32 + var_160_39 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play323011039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 323011039
		arg_161_1.duration_ = 12.1

		local var_161_0 = {
			zh = 12.1,
			ja = 11.466
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
				arg_161_0:Play323011040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["10163ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos10163ui_story = var_164_0.localPosition

				local var_164_2 = GameObjectTools.GetOrAddComponent(var_164_0.gameObject, typeof(DynamicBoneHelper))

				if var_164_2 then
					var_164_2:EnableDynamicBone(false)
				end
			end

			local var_164_3 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_3 then
				local var_164_4 = (arg_161_1.time_ - var_164_1) / var_164_3
				local var_164_5 = Vector3.New(0, -1.08, -5.83)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10163ui_story, var_164_5, var_164_4)

				local var_164_6 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_6.x, var_164_6.y, var_164_6.z)

				local var_164_7 = var_164_0.localEulerAngles

				var_164_7.z = 0
				var_164_7.x = 0
				var_164_0.localEulerAngles = var_164_7
			end

			if arg_161_1.time_ >= var_164_1 + var_164_3 and arg_161_1.time_ < var_164_1 + var_164_3 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_164_8 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_8.x, var_164_8.y, var_164_8.z)

				local var_164_9 = var_164_0.localEulerAngles

				var_164_9.z = 0
				var_164_9.x = 0
				var_164_0.localEulerAngles = var_164_9

				local var_164_10 = GameObjectTools.GetOrAddComponent(var_164_0.gameObject, typeof(DynamicBoneHelper))

				if var_164_10 then
					var_164_10:EnableDynamicBone(true)
				end
			end

			local var_164_11 = arg_161_1.actors_["10163ui_story"]
			local var_164_12 = 0

			if var_164_12 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 and not isNil(var_164_11) and arg_161_1.var_.characterEffect10163ui_story == nil then
				arg_161_1.var_.characterEffect10163ui_story = var_164_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_13 = 0.200000002980232

			if var_164_12 <= arg_161_1.time_ and arg_161_1.time_ < var_164_12 + var_164_13 and not isNil(var_164_11) then
				local var_164_14 = (arg_161_1.time_ - var_164_12) / var_164_13

				if arg_161_1.var_.characterEffect10163ui_story and not isNil(var_164_11) then
					arg_161_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_12 + var_164_13 and arg_161_1.time_ < var_164_12 + var_164_13 + arg_164_0 and not isNil(var_164_11) and arg_161_1.var_.characterEffect10163ui_story then
				arg_161_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_164_15 = 0

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				arg_161_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_1")
			end

			local var_164_16 = 0

			if var_164_16 < arg_161_1.time_ and arg_161_1.time_ <= var_164_16 + arg_164_0 then
				arg_161_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_164_17 = 0
			local var_164_18 = 1.1

			if var_164_17 < arg_161_1.time_ and arg_161_1.time_ <= var_164_17 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_19 = arg_161_1:FormatText(StoryNameCfg[1444].name)

				arg_161_1.leftNameTxt_.text = var_164_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_20 = arg_161_1:GetWordFromCfg(323011039)
				local var_164_21 = arg_161_1:FormatText(var_164_20.content)

				arg_161_1.text_.text = var_164_21

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_22 = 45
				local var_164_23 = utf8.len(var_164_21)
				local var_164_24 = var_164_22 <= 0 and var_164_18 or var_164_18 * (var_164_23 / var_164_22)

				if var_164_24 > 0 and var_164_18 < var_164_24 then
					arg_161_1.talkMaxDuration = var_164_24

					if var_164_24 + var_164_17 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_24 + var_164_17
					end
				end

				arg_161_1.text_.text = var_164_21
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011039", "story_v_out_323011.awb") ~= 0 then
					local var_164_25 = manager.audio:GetVoiceLength("story_v_out_323011", "323011039", "story_v_out_323011.awb") / 1000

					if var_164_25 + var_164_17 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_25 + var_164_17
					end

					if var_164_20.prefab_name ~= "" and arg_161_1.actors_[var_164_20.prefab_name] ~= nil then
						local var_164_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_20.prefab_name].transform, "story_v_out_323011", "323011039", "story_v_out_323011.awb")

						arg_161_1:RecordAudio("323011039", var_164_26)
						arg_161_1:RecordAudio("323011039", var_164_26)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_323011", "323011039", "story_v_out_323011.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_323011", "323011039", "story_v_out_323011.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_27 = math.max(var_164_18, arg_161_1.talkMaxDuration)

			if var_164_17 <= arg_161_1.time_ and arg_161_1.time_ < var_164_17 + var_164_27 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_17) / var_164_27

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_17 + var_164_27 and arg_161_1.time_ < var_164_17 + var_164_27 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play323011040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 323011040
		arg_165_1.duration_ = 8.1

		local var_165_0 = {
			zh = 6.3,
			ja = 8.1
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
				arg_165_0:Play323011041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.475

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_2 = arg_165_1:FormatText(StoryNameCfg[1444].name)

				arg_165_1.leftNameTxt_.text = var_168_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_3 = arg_165_1:GetWordFromCfg(323011040)
				local var_168_4 = arg_165_1:FormatText(var_168_3.content)

				arg_165_1.text_.text = var_168_4

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_5 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011040", "story_v_out_323011.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011040", "story_v_out_323011.awb") / 1000

					if var_168_8 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_0
					end

					if var_168_3.prefab_name ~= "" and arg_165_1.actors_[var_168_3.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_3.prefab_name].transform, "story_v_out_323011", "323011040", "story_v_out_323011.awb")

						arg_165_1:RecordAudio("323011040", var_168_9)
						arg_165_1:RecordAudio("323011040", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_323011", "323011040", "story_v_out_323011.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_323011", "323011040", "story_v_out_323011.awb")
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
	Play323011041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 323011041
		arg_169_1.duration_ = 10.57

		local var_169_0 = {
			zh = 10.566,
			ja = 8.633
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play323011042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10165ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos10165ui_story = var_172_0.localPosition

				local var_172_2 = GameObjectTools.GetOrAddComponent(var_172_0.gameObject, typeof(DynamicBoneHelper))

				if var_172_2 then
					var_172_2:EnableDynamicBone(false)
				end
			end

			local var_172_3 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_3 then
				local var_172_4 = (arg_169_1.time_ - var_172_1) / var_172_3
				local var_172_5 = Vector3.New(0.7, -1.08, -5.83)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10165ui_story, var_172_5, var_172_4)

				local var_172_6 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_6.x, var_172_6.y, var_172_6.z)

				local var_172_7 = var_172_0.localEulerAngles

				var_172_7.z = 0
				var_172_7.x = 0
				var_172_0.localEulerAngles = var_172_7
			end

			if arg_169_1.time_ >= var_172_1 + var_172_3 and arg_169_1.time_ < var_172_1 + var_172_3 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0.7, -1.08, -5.83)

				local var_172_8 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_8.x, var_172_8.y, var_172_8.z)

				local var_172_9 = var_172_0.localEulerAngles

				var_172_9.z = 0
				var_172_9.x = 0
				var_172_0.localEulerAngles = var_172_9

				local var_172_10 = GameObjectTools.GetOrAddComponent(var_172_0.gameObject, typeof(DynamicBoneHelper))

				if var_172_10 then
					var_172_10:EnableDynamicBone(true)
				end
			end

			local var_172_11 = arg_169_1.actors_["10163ui_story"].transform
			local var_172_12 = 0

			if var_172_12 < arg_169_1.time_ and arg_169_1.time_ <= var_172_12 + arg_172_0 then
				arg_169_1.var_.moveOldPos10163ui_story = var_172_11.localPosition

				local var_172_13 = GameObjectTools.GetOrAddComponent(var_172_11.gameObject, typeof(DynamicBoneHelper))

				if var_172_13 then
					var_172_13:EnableDynamicBone(false)
				end
			end

			local var_172_14 = 0.001

			if var_172_12 <= arg_169_1.time_ and arg_169_1.time_ < var_172_12 + var_172_14 then
				local var_172_15 = (arg_169_1.time_ - var_172_12) / var_172_14
				local var_172_16 = Vector3.New(-0.74, -1.08, -5.83)

				var_172_11.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10163ui_story, var_172_16, var_172_15)

				local var_172_17 = manager.ui.mainCamera.transform.position - var_172_11.position

				var_172_11.forward = Vector3.New(var_172_17.x, var_172_17.y, var_172_17.z)

				local var_172_18 = var_172_11.localEulerAngles

				var_172_18.z = 0
				var_172_18.x = 0
				var_172_11.localEulerAngles = var_172_18
			end

			if arg_169_1.time_ >= var_172_12 + var_172_14 and arg_169_1.time_ < var_172_12 + var_172_14 + arg_172_0 then
				var_172_11.localPosition = Vector3.New(-0.74, -1.08, -5.83)

				local var_172_19 = manager.ui.mainCamera.transform.position - var_172_11.position

				var_172_11.forward = Vector3.New(var_172_19.x, var_172_19.y, var_172_19.z)

				local var_172_20 = var_172_11.localEulerAngles

				var_172_20.z = 0
				var_172_20.x = 0
				var_172_11.localEulerAngles = var_172_20

				local var_172_21 = GameObjectTools.GetOrAddComponent(var_172_11.gameObject, typeof(DynamicBoneHelper))

				if var_172_21 then
					var_172_21:EnableDynamicBone(true)
				end
			end

			local var_172_22 = arg_169_1.actors_["10165ui_story"]
			local var_172_23 = 0

			if var_172_23 < arg_169_1.time_ and arg_169_1.time_ <= var_172_23 + arg_172_0 and not isNil(var_172_22) and arg_169_1.var_.characterEffect10165ui_story == nil then
				arg_169_1.var_.characterEffect10165ui_story = var_172_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_24 = 0.200000002980232

			if var_172_23 <= arg_169_1.time_ and arg_169_1.time_ < var_172_23 + var_172_24 and not isNil(var_172_22) then
				local var_172_25 = (arg_169_1.time_ - var_172_23) / var_172_24

				if arg_169_1.var_.characterEffect10165ui_story and not isNil(var_172_22) then
					arg_169_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_23 + var_172_24 and arg_169_1.time_ < var_172_23 + var_172_24 + arg_172_0 and not isNil(var_172_22) and arg_169_1.var_.characterEffect10165ui_story then
				arg_169_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_172_26 = arg_169_1.actors_["10163ui_story"]
			local var_172_27 = 0

			if var_172_27 < arg_169_1.time_ and arg_169_1.time_ <= var_172_27 + arg_172_0 and not isNil(var_172_26) and arg_169_1.var_.characterEffect10163ui_story == nil then
				arg_169_1.var_.characterEffect10163ui_story = var_172_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_28 = 0.200000002980232

			if var_172_27 <= arg_169_1.time_ and arg_169_1.time_ < var_172_27 + var_172_28 and not isNil(var_172_26) then
				local var_172_29 = (arg_169_1.time_ - var_172_27) / var_172_28

				if arg_169_1.var_.characterEffect10163ui_story and not isNil(var_172_26) then
					local var_172_30 = Mathf.Lerp(0, 0.5, var_172_29)

					arg_169_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_169_1.var_.characterEffect10163ui_story.fillRatio = var_172_30
				end
			end

			if arg_169_1.time_ >= var_172_27 + var_172_28 and arg_169_1.time_ < var_172_27 + var_172_28 + arg_172_0 and not isNil(var_172_26) and arg_169_1.var_.characterEffect10163ui_story then
				local var_172_31 = 0.5

				arg_169_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_169_1.var_.characterEffect10163ui_story.fillRatio = var_172_31
			end

			local var_172_32 = 0

			if var_172_32 < arg_169_1.time_ and arg_169_1.time_ <= var_172_32 + arg_172_0 then
				arg_169_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_172_33 = 0

			if var_172_33 < arg_169_1.time_ and arg_169_1.time_ <= var_172_33 + arg_172_0 then
				arg_169_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_172_34 = 0
			local var_172_35 = 0.7

			if var_172_34 < arg_169_1.time_ and arg_169_1.time_ <= var_172_34 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_36 = arg_169_1:FormatText(StoryNameCfg[1446].name)

				arg_169_1.leftNameTxt_.text = var_172_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_37 = arg_169_1:GetWordFromCfg(323011041)
				local var_172_38 = arg_169_1:FormatText(var_172_37.content)

				arg_169_1.text_.text = var_172_38

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_39 = 28
				local var_172_40 = utf8.len(var_172_38)
				local var_172_41 = var_172_39 <= 0 and var_172_35 or var_172_35 * (var_172_40 / var_172_39)

				if var_172_41 > 0 and var_172_35 < var_172_41 then
					arg_169_1.talkMaxDuration = var_172_41

					if var_172_41 + var_172_34 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_41 + var_172_34
					end
				end

				arg_169_1.text_.text = var_172_38
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011041", "story_v_out_323011.awb") ~= 0 then
					local var_172_42 = manager.audio:GetVoiceLength("story_v_out_323011", "323011041", "story_v_out_323011.awb") / 1000

					if var_172_42 + var_172_34 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_42 + var_172_34
					end

					if var_172_37.prefab_name ~= "" and arg_169_1.actors_[var_172_37.prefab_name] ~= nil then
						local var_172_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_37.prefab_name].transform, "story_v_out_323011", "323011041", "story_v_out_323011.awb")

						arg_169_1:RecordAudio("323011041", var_172_43)
						arg_169_1:RecordAudio("323011041", var_172_43)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_323011", "323011041", "story_v_out_323011.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_323011", "323011041", "story_v_out_323011.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_44 = math.max(var_172_35, arg_169_1.talkMaxDuration)

			if var_172_34 <= arg_169_1.time_ and arg_169_1.time_ < var_172_34 + var_172_44 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_34) / var_172_44

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_34 + var_172_44 and arg_169_1.time_ < var_172_34 + var_172_44 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play323011042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 323011042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play323011043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10163ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos10163ui_story = var_176_0.localPosition

				local var_176_2 = GameObjectTools.GetOrAddComponent(var_176_0.gameObject, typeof(DynamicBoneHelper))

				if var_176_2 then
					var_176_2:EnableDynamicBone(false)
				end
			end

			local var_176_3 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_3 then
				local var_176_4 = (arg_173_1.time_ - var_176_1) / var_176_3
				local var_176_5 = Vector3.New(0, 100, 0)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10163ui_story, var_176_5, var_176_4)

				local var_176_6 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_6.x, var_176_6.y, var_176_6.z)

				local var_176_7 = var_176_0.localEulerAngles

				var_176_7.z = 0
				var_176_7.x = 0
				var_176_0.localEulerAngles = var_176_7
			end

			if arg_173_1.time_ >= var_176_1 + var_176_3 and arg_173_1.time_ < var_176_1 + var_176_3 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, 100, 0)

				local var_176_8 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_8.x, var_176_8.y, var_176_8.z)

				local var_176_9 = var_176_0.localEulerAngles

				var_176_9.z = 0
				var_176_9.x = 0
				var_176_0.localEulerAngles = var_176_9

				local var_176_10 = GameObjectTools.GetOrAddComponent(var_176_0.gameObject, typeof(DynamicBoneHelper))

				if var_176_10 then
					var_176_10:EnableDynamicBone(true)
				end
			end

			local var_176_11 = arg_173_1.actors_["10165ui_story"].transform
			local var_176_12 = 0

			if var_176_12 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 then
				arg_173_1.var_.moveOldPos10165ui_story = var_176_11.localPosition

				local var_176_13 = GameObjectTools.GetOrAddComponent(var_176_11.gameObject, typeof(DynamicBoneHelper))

				if var_176_13 then
					var_176_13:EnableDynamicBone(false)
				end
			end

			local var_176_14 = 0.001

			if var_176_12 <= arg_173_1.time_ and arg_173_1.time_ < var_176_12 + var_176_14 then
				local var_176_15 = (arg_173_1.time_ - var_176_12) / var_176_14
				local var_176_16 = Vector3.New(0, 100, 0)

				var_176_11.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10165ui_story, var_176_16, var_176_15)

				local var_176_17 = manager.ui.mainCamera.transform.position - var_176_11.position

				var_176_11.forward = Vector3.New(var_176_17.x, var_176_17.y, var_176_17.z)

				local var_176_18 = var_176_11.localEulerAngles

				var_176_18.z = 0
				var_176_18.x = 0
				var_176_11.localEulerAngles = var_176_18
			end

			if arg_173_1.time_ >= var_176_12 + var_176_14 and arg_173_1.time_ < var_176_12 + var_176_14 + arg_176_0 then
				var_176_11.localPosition = Vector3.New(0, 100, 0)

				local var_176_19 = manager.ui.mainCamera.transform.position - var_176_11.position

				var_176_11.forward = Vector3.New(var_176_19.x, var_176_19.y, var_176_19.z)

				local var_176_20 = var_176_11.localEulerAngles

				var_176_20.z = 0
				var_176_20.x = 0
				var_176_11.localEulerAngles = var_176_20

				local var_176_21 = GameObjectTools.GetOrAddComponent(var_176_11.gameObject, typeof(DynamicBoneHelper))

				if var_176_21 then
					var_176_21:EnableDynamicBone(true)
				end
			end

			local var_176_22 = arg_173_1.actors_["10165ui_story"]
			local var_176_23 = 0

			if var_176_23 < arg_173_1.time_ and arg_173_1.time_ <= var_176_23 + arg_176_0 and not isNil(var_176_22) and arg_173_1.var_.characterEffect10165ui_story == nil then
				arg_173_1.var_.characterEffect10165ui_story = var_176_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_24 = 0.200000002980232

			if var_176_23 <= arg_173_1.time_ and arg_173_1.time_ < var_176_23 + var_176_24 and not isNil(var_176_22) then
				local var_176_25 = (arg_173_1.time_ - var_176_23) / var_176_24

				if arg_173_1.var_.characterEffect10165ui_story and not isNil(var_176_22) then
					local var_176_26 = Mathf.Lerp(0, 0.5, var_176_25)

					arg_173_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10165ui_story.fillRatio = var_176_26
				end
			end

			if arg_173_1.time_ >= var_176_23 + var_176_24 and arg_173_1.time_ < var_176_23 + var_176_24 + arg_176_0 and not isNil(var_176_22) and arg_173_1.var_.characterEffect10165ui_story then
				local var_176_27 = 0.5

				arg_173_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10165ui_story.fillRatio = var_176_27
			end

			local var_176_28 = 0
			local var_176_29 = 1.1

			if var_176_28 < arg_173_1.time_ and arg_173_1.time_ <= var_176_28 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_30 = arg_173_1:GetWordFromCfg(323011042)
				local var_176_31 = arg_173_1:FormatText(var_176_30.content)

				arg_173_1.text_.text = var_176_31

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_32 = 44
				local var_176_33 = utf8.len(var_176_31)
				local var_176_34 = var_176_32 <= 0 and var_176_29 or var_176_29 * (var_176_33 / var_176_32)

				if var_176_34 > 0 and var_176_29 < var_176_34 then
					arg_173_1.talkMaxDuration = var_176_34

					if var_176_34 + var_176_28 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_34 + var_176_28
					end
				end

				arg_173_1.text_.text = var_176_31
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_35 = math.max(var_176_29, arg_173_1.talkMaxDuration)

			if var_176_28 <= arg_173_1.time_ and arg_173_1.time_ < var_176_28 + var_176_35 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_28) / var_176_35

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_28 + var_176_35 and arg_173_1.time_ < var_176_28 + var_176_35 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play323011043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 323011043
		arg_177_1.duration_ = 6.4

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play323011044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 1.4

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				local var_180_1 = manager.ui.mainCamera.transform.localPosition
				local var_180_2 = Vector3.New(0, 0, 10) + Vector3.New(var_180_1.x, var_180_1.y, 0)
				local var_180_3 = arg_177_1.bgs_.STblack

				var_180_3.transform.localPosition = var_180_2
				var_180_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_180_4 = var_180_3:GetComponent("SpriteRenderer")

				if var_180_4 and var_180_4.sprite then
					local var_180_5 = (var_180_3.transform.localPosition - var_180_1).z
					local var_180_6 = manager.ui.mainCameraCom_
					local var_180_7 = 2 * var_180_5 * Mathf.Tan(var_180_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_180_8 = var_180_7 * var_180_6.aspect
					local var_180_9 = var_180_4.sprite.bounds.size.x
					local var_180_10 = var_180_4.sprite.bounds.size.y
					local var_180_11 = var_180_8 / var_180_9
					local var_180_12 = var_180_7 / var_180_10
					local var_180_13 = var_180_12 < var_180_11 and var_180_11 or var_180_12

					var_180_3.transform.localScale = Vector3.New(var_180_13, var_180_13, 0)
				end

				for iter_180_0, iter_180_1 in pairs(arg_177_1.bgs_) do
					if iter_180_0 ~= "STblack" then
						iter_180_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_180_14 = 1.4

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 then
				arg_177_1.allBtn_.enabled = false
			end

			local var_180_15 = 0.3

			if arg_177_1.time_ >= var_180_14 + var_180_15 and arg_177_1.time_ < var_180_14 + var_180_15 + arg_180_0 then
				arg_177_1.allBtn_.enabled = true
			end

			local var_180_16 = 0

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_17 = 1.41666666666667

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_17 then
				local var_180_18 = (arg_177_1.time_ - var_180_16) / var_180_17
				local var_180_19 = Color.New(0, 0, 0)

				var_180_19.a = Mathf.Lerp(0, 1, var_180_18)
				arg_177_1.mask_.color = var_180_19
			end

			if arg_177_1.time_ >= var_180_16 + var_180_17 and arg_177_1.time_ < var_180_16 + var_180_17 + arg_180_0 then
				local var_180_20 = Color.New(0, 0, 0)

				var_180_20.a = 1
				arg_177_1.mask_.color = var_180_20
			end

			local var_180_21 = 1.4

			if var_180_21 < arg_177_1.time_ and arg_177_1.time_ <= var_180_21 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_22 = 2

			if var_180_21 <= arg_177_1.time_ and arg_177_1.time_ < var_180_21 + var_180_22 then
				local var_180_23 = (arg_177_1.time_ - var_180_21) / var_180_22
				local var_180_24 = Color.New(0, 0, 0)

				var_180_24.a = Mathf.Lerp(1, 0, var_180_23)
				arg_177_1.mask_.color = var_180_24
			end

			if arg_177_1.time_ >= var_180_21 + var_180_22 and arg_177_1.time_ < var_180_21 + var_180_22 + arg_180_0 then
				local var_180_25 = Color.New(0, 0, 0)
				local var_180_26 = 0

				arg_177_1.mask_.enabled = false
				var_180_25.a = var_180_26
				arg_177_1.mask_.color = var_180_25
			end

			local var_180_27 = 1.4

			if var_180_27 < arg_177_1.time_ and arg_177_1.time_ <= var_180_27 + arg_180_0 then
				arg_177_1.cswbg_:SetActive(true)

				local var_180_28 = arg_177_1.cswt_:GetComponent("RectTransform")

				arg_177_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_180_28.offsetMin = Vector2.New(400, -200)
				var_180_28.offsetMax = Vector2.New(-400, -262.5)

				local var_180_29 = arg_177_1:GetWordFromCfg(419175)
				local var_180_30 = arg_177_1:FormatText(var_180_29.content)

				arg_177_1.cswt_.text = var_180_30

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.cswt_)

				arg_177_1.cswt_.fontSize = 108
				arg_177_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_177_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_177_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_180_31 = 1.4

			if var_180_31 < arg_177_1.time_ and arg_177_1.time_ <= var_180_31 + arg_180_0 then
				arg_177_1.fswbg_:SetActive(true)
				arg_177_1.dialog_:SetActive(false)

				arg_177_1.fswtw_.percent = 0

				local var_180_32 = arg_177_1:GetWordFromCfg(102)
				local var_180_33 = arg_177_1:FormatText(var_180_32.content)

				arg_177_1.fswt_.text = var_180_33

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.fswt_)

				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_177_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_177_1.fswtw_:SetDirty()

				arg_177_1.typewritterCharCountI18N = 0

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_34 = 2.75

			if var_180_34 < arg_177_1.time_ and arg_177_1.time_ <= var_180_34 + arg_180_0 then
				arg_177_1.var_.oldValueTypewriter = arg_177_1.fswtw_.percent

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_35 = 0
			local var_180_36 = 0.65
			local var_180_37 = arg_177_1:GetWordFromCfg(102)
			local var_180_38 = arg_177_1:FormatText(var_180_37.content)
			local var_180_39, var_180_40 = arg_177_1:GetPercentByPara(var_180_38, 1)

			if var_180_34 < arg_177_1.time_ and arg_177_1.time_ <= var_180_34 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				local var_180_41 = var_180_35 <= 0 and var_180_36 or var_180_36 * ((var_180_40 - arg_177_1.typewritterCharCountI18N) / var_180_35)

				if var_180_41 > 0 and var_180_36 < var_180_41 then
					arg_177_1.talkMaxDuration = var_180_41

					if var_180_41 + var_180_34 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_41 + var_180_34
					end
				end
			end

			local var_180_42 = 0.65
			local var_180_43 = math.max(var_180_42, arg_177_1.talkMaxDuration)

			if var_180_34 <= arg_177_1.time_ and arg_177_1.time_ < var_180_34 + var_180_43 then
				local var_180_44 = (arg_177_1.time_ - var_180_34) / var_180_43

				arg_177_1.fswtw_.percent = Mathf.Lerp(arg_177_1.var_.oldValueTypewriter, var_180_39, var_180_44)
				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_177_1.fswtw_:SetDirty()
			end

			if arg_177_1.time_ >= var_180_34 + var_180_43 and arg_177_1.time_ < var_180_34 + var_180_43 + arg_180_0 then
				arg_177_1.fswtw_.percent = var_180_39

				arg_177_1.fswtw_:SetDirty()
				arg_177_1:ShowNextGo(true)

				arg_177_1.typewritterCharCountI18N = var_180_40
			end

			local var_180_45 = 1.41666666666667
			local var_180_46 = 1

			if var_180_45 < arg_177_1.time_ and arg_177_1.time_ <= var_180_45 + arg_180_0 then
				local var_180_47 = "play"
				local var_180_48 = "effect"

				arg_177_1:AudioAction(var_180_47, var_180_48, "se_story_148", "se_story_148_bell_temple_china01", "")
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play323011044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 323011044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play323011045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				local var_184_1 = arg_181_1.fswbg_.transform:Find("textbox/adapt/content") or arg_181_1.fswbg_.transform:Find("textbox/content")
				local var_184_2 = arg_181_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_184_3 = var_184_1:GetComponent("Text")
				local var_184_4 = var_184_1:GetComponent("RectTransform")

				var_184_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_184_4.offsetMin = Vector2.New(0, 0)
				var_184_4.offsetMax = Vector2.New(0, 0)
			end

			local var_184_5 = 0

			if var_184_5 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1.fswbg_:SetActive(true)
				arg_181_1.dialog_:SetActive(false)

				arg_181_1.fswtw_.percent = 0

				local var_184_6 = arg_181_1:GetWordFromCfg(323011044)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.fswt_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.fswt_)

				arg_181_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_181_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_181_1.fswtw_:SetDirty()

				arg_181_1.typewritterCharCountI18N = 0

				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_181_1:ShowNextGo(false)
			end

			local var_184_8 = 0.433333333333333

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.var_.oldValueTypewriter = arg_181_1.fswtw_.percent

				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_181_1:ShowNextGo(false)
			end

			local var_184_9 = 2
			local var_184_10 = 0.133333333333333
			local var_184_11 = arg_181_1:GetWordFromCfg(323011044)
			local var_184_12 = arg_181_1:FormatText(var_184_11.content)
			local var_184_13, var_184_14 = arg_181_1:GetPercentByPara(var_184_12, 1)

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				local var_184_15 = var_184_9 <= 0 and var_184_10 or var_184_10 * ((var_184_14 - arg_181_1.typewritterCharCountI18N) / var_184_9)

				if var_184_15 > 0 and var_184_10 < var_184_15 then
					arg_181_1.talkMaxDuration = var_184_15

					if var_184_15 + var_184_8 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_15 + var_184_8
					end
				end
			end

			local var_184_16 = 0.133333333333333
			local var_184_17 = math.max(var_184_16, arg_181_1.talkMaxDuration)

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_17 then
				local var_184_18 = (arg_181_1.time_ - var_184_8) / var_184_17

				arg_181_1.fswtw_.percent = Mathf.Lerp(arg_181_1.var_.oldValueTypewriter, var_184_13, var_184_18)
				arg_181_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_181_1.fswtw_:SetDirty()
			end

			if arg_181_1.time_ >= var_184_8 + var_184_17 and arg_181_1.time_ < var_184_8 + var_184_17 + arg_184_0 then
				arg_181_1.fswtw_.percent = var_184_13

				arg_181_1.fswtw_:SetDirty()
				arg_181_1:ShowNextGo(true)

				arg_181_1.typewritterCharCountI18N = var_184_14
			end

			local var_184_19 = 0.433333333333333
			local var_184_20 = 1
			local var_184_21 = manager.audio:GetVoiceLength("story_v_out_323011", "323011044", "0") / 1000

			if var_184_21 > 0 and var_184_20 < var_184_21 and var_184_21 + var_184_19 > arg_181_1.duration_ then
				local var_184_22 = var_184_21

				arg_181_1.duration_ = var_184_21 + var_184_19
			end

			if var_184_19 < arg_181_1.time_ and arg_181_1.time_ <= var_184_19 + arg_184_0 then
				local var_184_23 = "play"
				local var_184_24 = "voice"

				arg_181_1:AudioAction(var_184_23, var_184_24, "story_v_out_323011", "323011044", "0")
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play323011045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 323011045
		arg_185_1.duration_ = 1.43

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play323011046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.fswbg_:SetActive(true)
				arg_185_1.dialog_:SetActive(false)

				arg_185_1.fswtw_.percent = 0

				local var_188_1 = arg_185_1:GetWordFromCfg(323011045)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.fswt_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.fswt_)

				arg_185_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_185_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_185_1.fswtw_:SetDirty()

				arg_185_1.typewritterCharCountI18N = 0

				SetActive(arg_185_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_185_1:ShowNextGo(false)
			end

			local var_188_3 = 0.433333333333333

			if var_188_3 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.var_.oldValueTypewriter = arg_185_1.fswtw_.percent

				SetActive(arg_185_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_185_1:ShowNextGo(false)
			end

			local var_188_4 = 5
			local var_188_5 = 0.333333333333333
			local var_188_6 = arg_185_1:GetWordFromCfg(323011045)
			local var_188_7 = arg_185_1:FormatText(var_188_6.content)
			local var_188_8, var_188_9 = arg_185_1:GetPercentByPara(var_188_7, 1)

			if var_188_3 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				local var_188_10 = var_188_4 <= 0 and var_188_5 or var_188_5 * ((var_188_9 - arg_185_1.typewritterCharCountI18N) / var_188_4)

				if var_188_10 > 0 and var_188_5 < var_188_10 then
					arg_185_1.talkMaxDuration = var_188_10

					if var_188_10 + var_188_3 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_3
					end
				end
			end

			local var_188_11 = 0.333333333333333
			local var_188_12 = math.max(var_188_11, arg_185_1.talkMaxDuration)

			if var_188_3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_3 + var_188_12 then
				local var_188_13 = (arg_185_1.time_ - var_188_3) / var_188_12

				arg_185_1.fswtw_.percent = Mathf.Lerp(arg_185_1.var_.oldValueTypewriter, var_188_8, var_188_13)
				arg_185_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_185_1.fswtw_:SetDirty()
			end

			if arg_185_1.time_ >= var_188_3 + var_188_12 and arg_185_1.time_ < var_188_3 + var_188_12 + arg_188_0 then
				arg_185_1.fswtw_.percent = var_188_8

				arg_185_1.fswtw_:SetDirty()
				arg_185_1:ShowNextGo(true)

				arg_185_1.typewritterCharCountI18N = var_188_9
			end

			local var_188_14 = 0.433333333333333
			local var_188_15 = 1
			local var_188_16 = manager.audio:GetVoiceLength("story_v_out_323011", "323011045", "0") / 1000

			if var_188_16 > 0 and var_188_15 < var_188_16 and var_188_16 + var_188_14 > arg_185_1.duration_ then
				local var_188_17 = var_188_16

				arg_185_1.duration_ = var_188_16 + var_188_14
			end

			if var_188_14 < arg_185_1.time_ and arg_185_1.time_ <= var_188_14 + arg_188_0 then
				local var_188_18 = "play"
				local var_188_19 = "voice"

				arg_185_1:AudioAction(var_188_18, var_188_19, "story_v_out_323011", "323011045", "0")
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play323011046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 323011046
		arg_189_1.duration_ = 13.23

		local var_189_0 = {
			zh = 9.19966666666667,
			ja = 13.2326666666667
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play323011047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 1

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				local var_192_1 = manager.ui.mainCamera.transform.localPosition
				local var_192_2 = Vector3.New(0, 0, 10) + Vector3.New(var_192_1.x, var_192_1.y, 0)
				local var_192_3 = arg_189_1.bgs_.ST2015

				var_192_3.transform.localPosition = var_192_2
				var_192_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_4 = var_192_3:GetComponent("SpriteRenderer")

				if var_192_4 and var_192_4.sprite then
					local var_192_5 = (var_192_3.transform.localPosition - var_192_1).z
					local var_192_6 = manager.ui.mainCameraCom_
					local var_192_7 = 2 * var_192_5 * Mathf.Tan(var_192_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_192_8 = var_192_7 * var_192_6.aspect
					local var_192_9 = var_192_4.sprite.bounds.size.x
					local var_192_10 = var_192_4.sprite.bounds.size.y
					local var_192_11 = var_192_8 / var_192_9
					local var_192_12 = var_192_7 / var_192_10
					local var_192_13 = var_192_12 < var_192_11 and var_192_11 or var_192_12

					var_192_3.transform.localScale = Vector3.New(var_192_13, var_192_13, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "ST2015" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_192_14 = 1

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1.allBtn_.enabled = false
			end

			local var_192_15 = 0.3

			if arg_189_1.time_ >= var_192_14 + var_192_15 and arg_189_1.time_ < var_192_14 + var_192_15 + arg_192_0 then
				arg_189_1.allBtn_.enabled = true
			end

			local var_192_16 = 0

			if var_192_16 < arg_189_1.time_ and arg_189_1.time_ <= var_192_16 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_17 = 1.01666666666667

			if var_192_16 <= arg_189_1.time_ and arg_189_1.time_ < var_192_16 + var_192_17 then
				local var_192_18 = (arg_189_1.time_ - var_192_16) / var_192_17
				local var_192_19 = Color.New(0, 0, 0)

				var_192_19.a = Mathf.Lerp(0, 1, var_192_18)
				arg_189_1.mask_.color = var_192_19
			end

			if arg_189_1.time_ >= var_192_16 + var_192_17 and arg_189_1.time_ < var_192_16 + var_192_17 + arg_192_0 then
				local var_192_20 = Color.New(0, 0, 0)

				var_192_20.a = 1
				arg_189_1.mask_.color = var_192_20
			end

			local var_192_21 = 1

			if var_192_21 < arg_189_1.time_ and arg_189_1.time_ <= var_192_21 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_22 = 2

			if var_192_21 <= arg_189_1.time_ and arg_189_1.time_ < var_192_21 + var_192_22 then
				local var_192_23 = (arg_189_1.time_ - var_192_21) / var_192_22
				local var_192_24 = Color.New(0, 0, 0)

				var_192_24.a = Mathf.Lerp(1, 0, var_192_23)
				arg_189_1.mask_.color = var_192_24
			end

			if arg_189_1.time_ >= var_192_21 + var_192_22 and arg_189_1.time_ < var_192_21 + var_192_22 + arg_192_0 then
				local var_192_25 = Color.New(0, 0, 0)
				local var_192_26 = 0

				arg_189_1.mask_.enabled = false
				var_192_25.a = var_192_26
				arg_189_1.mask_.color = var_192_25
			end

			local var_192_27 = 1

			if var_192_27 < arg_189_1.time_ and arg_189_1.time_ <= var_192_27 + arg_192_0 then
				arg_189_1.cswbg_:SetActive(false)
			end

			local var_192_28 = 1

			if var_192_28 < arg_189_1.time_ and arg_189_1.time_ <= var_192_28 + arg_192_0 then
				arg_189_1.fswbg_:SetActive(false)
				arg_189_1.dialog_:SetActive(false)
				SetActive(arg_189_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_189_1:ShowNextGo(false)
			end

			local var_192_29 = 1.01666666666667

			if var_192_29 < arg_189_1.time_ and arg_189_1.time_ <= var_192_29 + arg_192_0 then
				arg_189_1.fswbg_:SetActive(false)
				arg_189_1.dialog_:SetActive(false)
				SetActive(arg_189_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_189_1:ShowNextGo(false)
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_30 = 1.86666666666667
			local var_192_31 = 1.65

			if var_192_30 < arg_189_1.time_ and arg_189_1.time_ <= var_192_30 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_32 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_32:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_33 = arg_189_1:FormatText(StoryNameCfg[1444].name)

				arg_189_1.leftNameTxt_.text = var_192_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10163")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_34 = arg_189_1:GetWordFromCfg(323011046)
				local var_192_35 = arg_189_1:FormatText(var_192_34.content)

				arg_189_1.text_.text = var_192_35

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_36 = 29
				local var_192_37 = utf8.len(var_192_35)
				local var_192_38 = var_192_36 <= 0 and var_192_31 or var_192_31 * (var_192_37 / var_192_36)

				if var_192_38 > 0 and var_192_31 < var_192_38 then
					arg_189_1.talkMaxDuration = var_192_38
					var_192_30 = var_192_30 + 0.3

					if var_192_38 + var_192_30 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_38 + var_192_30
					end
				end

				arg_189_1.text_.text = var_192_35
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011046", "story_v_out_323011.awb") ~= 0 then
					local var_192_39 = manager.audio:GetVoiceLength("story_v_out_323011", "323011046", "story_v_out_323011.awb") / 1000

					if var_192_39 + var_192_30 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_39 + var_192_30
					end

					if var_192_34.prefab_name ~= "" and arg_189_1.actors_[var_192_34.prefab_name] ~= nil then
						local var_192_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_34.prefab_name].transform, "story_v_out_323011", "323011046", "story_v_out_323011.awb")

						arg_189_1:RecordAudio("323011046", var_192_40)
						arg_189_1:RecordAudio("323011046", var_192_40)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_323011", "323011046", "story_v_out_323011.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_323011", "323011046", "story_v_out_323011.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_41 = var_192_30 + 0.3
			local var_192_42 = math.max(var_192_31, arg_189_1.talkMaxDuration)

			if var_192_41 <= arg_189_1.time_ and arg_189_1.time_ < var_192_41 + var_192_42 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_41) / var_192_42

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_41 + var_192_42 and arg_189_1.time_ < var_192_41 + var_192_42 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play323011047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 323011047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play323011048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 1.65

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_2 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_2:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:GetWordFromCfg(323011047)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 66
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7
					var_198_0 = var_198_0 + 0.3

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = var_198_0 + 0.3
			local var_198_9 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_9 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_8) / var_198_9

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_8 + var_198_9 and arg_195_1.time_ < var_198_8 + var_198_9 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play323011048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 323011048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play323011049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 1.35

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_2 = arg_201_1:GetWordFromCfg(323011048)
				local var_204_3 = arg_201_1:FormatText(var_204_2.content)

				arg_201_1.text_.text = var_204_3

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 54
				local var_204_5 = utf8.len(var_204_3)
				local var_204_6 = var_204_4 <= 0 and var_204_1 or var_204_1 * (var_204_5 / var_204_4)

				if var_204_6 > 0 and var_204_1 < var_204_6 then
					arg_201_1.talkMaxDuration = var_204_6

					if var_204_6 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_3
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_7 and arg_201_1.time_ < var_204_0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play323011049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 323011049
		arg_205_1.duration_ = 5.57

		local var_205_0 = {
			zh = 4.3,
			ja = 5.566
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play323011050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10163ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos10163ui_story = var_208_0.localPosition

				local var_208_2 = GameObjectTools.GetOrAddComponent(var_208_0.gameObject, typeof(DynamicBoneHelper))

				if var_208_2 then
					var_208_2:EnableDynamicBone(false)
				end
			end

			local var_208_3 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_3 then
				local var_208_4 = (arg_205_1.time_ - var_208_1) / var_208_3
				local var_208_5 = Vector3.New(-0.74, -1.08, -5.83)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10163ui_story, var_208_5, var_208_4)

				local var_208_6 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_6.x, var_208_6.y, var_208_6.z)

				local var_208_7 = var_208_0.localEulerAngles

				var_208_7.z = 0
				var_208_7.x = 0
				var_208_0.localEulerAngles = var_208_7
			end

			if arg_205_1.time_ >= var_208_1 + var_208_3 and arg_205_1.time_ < var_208_1 + var_208_3 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(-0.74, -1.08, -5.83)

				local var_208_8 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_8.x, var_208_8.y, var_208_8.z)

				local var_208_9 = var_208_0.localEulerAngles

				var_208_9.z = 0
				var_208_9.x = 0
				var_208_0.localEulerAngles = var_208_9

				local var_208_10 = GameObjectTools.GetOrAddComponent(var_208_0.gameObject, typeof(DynamicBoneHelper))

				if var_208_10 then
					var_208_10:EnableDynamicBone(true)
				end
			end

			local var_208_11 = arg_205_1.actors_["10163ui_story"]
			local var_208_12 = 0

			if var_208_12 < arg_205_1.time_ and arg_205_1.time_ <= var_208_12 + arg_208_0 and not isNil(var_208_11) and arg_205_1.var_.characterEffect10163ui_story == nil then
				arg_205_1.var_.characterEffect10163ui_story = var_208_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_13 = 0.200000002980232

			if var_208_12 <= arg_205_1.time_ and arg_205_1.time_ < var_208_12 + var_208_13 and not isNil(var_208_11) then
				local var_208_14 = (arg_205_1.time_ - var_208_12) / var_208_13

				if arg_205_1.var_.characterEffect10163ui_story and not isNil(var_208_11) then
					arg_205_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= var_208_12 + var_208_13 and arg_205_1.time_ < var_208_12 + var_208_13 + arg_208_0 and not isNil(var_208_11) and arg_205_1.var_.characterEffect10163ui_story then
				arg_205_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_208_15 = 0

			if var_208_15 < arg_205_1.time_ and arg_205_1.time_ <= var_208_15 + arg_208_0 then
				arg_205_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			local var_208_16 = 0

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 then
				arg_205_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_208_17 = 0
			local var_208_18 = 0.375

			if var_208_17 < arg_205_1.time_ and arg_205_1.time_ <= var_208_17 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_19 = arg_205_1:FormatText(StoryNameCfg[1444].name)

				arg_205_1.leftNameTxt_.text = var_208_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_20 = arg_205_1:GetWordFromCfg(323011049)
				local var_208_21 = arg_205_1:FormatText(var_208_20.content)

				arg_205_1.text_.text = var_208_21

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_22 = 15
				local var_208_23 = utf8.len(var_208_21)
				local var_208_24 = var_208_22 <= 0 and var_208_18 or var_208_18 * (var_208_23 / var_208_22)

				if var_208_24 > 0 and var_208_18 < var_208_24 then
					arg_205_1.talkMaxDuration = var_208_24

					if var_208_24 + var_208_17 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_24 + var_208_17
					end
				end

				arg_205_1.text_.text = var_208_21
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011049", "story_v_out_323011.awb") ~= 0 then
					local var_208_25 = manager.audio:GetVoiceLength("story_v_out_323011", "323011049", "story_v_out_323011.awb") / 1000

					if var_208_25 + var_208_17 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_25 + var_208_17
					end

					if var_208_20.prefab_name ~= "" and arg_205_1.actors_[var_208_20.prefab_name] ~= nil then
						local var_208_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_20.prefab_name].transform, "story_v_out_323011", "323011049", "story_v_out_323011.awb")

						arg_205_1:RecordAudio("323011049", var_208_26)
						arg_205_1:RecordAudio("323011049", var_208_26)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_323011", "323011049", "story_v_out_323011.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_323011", "323011049", "story_v_out_323011.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_27 = math.max(var_208_18, arg_205_1.talkMaxDuration)

			if var_208_17 <= arg_205_1.time_ and arg_205_1.time_ < var_208_17 + var_208_27 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_17) / var_208_27

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_17 + var_208_27 and arg_205_1.time_ < var_208_17 + var_208_27 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play323011050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 323011050
		arg_209_1.duration_ = 6.43

		local var_209_0 = {
			zh = 6.433,
			ja = 6.4
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play323011051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10165ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos10165ui_story = var_212_0.localPosition

				local var_212_2 = GameObjectTools.GetOrAddComponent(var_212_0.gameObject, typeof(DynamicBoneHelper))

				if var_212_2 then
					var_212_2:EnableDynamicBone(false)
				end
			end

			local var_212_3 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_3 then
				local var_212_4 = (arg_209_1.time_ - var_212_1) / var_212_3
				local var_212_5 = Vector3.New(0.7, -1.08, -5.83)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10165ui_story, var_212_5, var_212_4)

				local var_212_6 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_6.x, var_212_6.y, var_212_6.z)

				local var_212_7 = var_212_0.localEulerAngles

				var_212_7.z = 0
				var_212_7.x = 0
				var_212_0.localEulerAngles = var_212_7
			end

			if arg_209_1.time_ >= var_212_1 + var_212_3 and arg_209_1.time_ < var_212_1 + var_212_3 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0.7, -1.08, -5.83)

				local var_212_8 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_8.x, var_212_8.y, var_212_8.z)

				local var_212_9 = var_212_0.localEulerAngles

				var_212_9.z = 0
				var_212_9.x = 0
				var_212_0.localEulerAngles = var_212_9

				local var_212_10 = GameObjectTools.GetOrAddComponent(var_212_0.gameObject, typeof(DynamicBoneHelper))

				if var_212_10 then
					var_212_10:EnableDynamicBone(true)
				end
			end

			local var_212_11 = arg_209_1.actors_["10165ui_story"]
			local var_212_12 = 0

			if var_212_12 < arg_209_1.time_ and arg_209_1.time_ <= var_212_12 + arg_212_0 and not isNil(var_212_11) and arg_209_1.var_.characterEffect10165ui_story == nil then
				arg_209_1.var_.characterEffect10165ui_story = var_212_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_13 = 0.200000002980232

			if var_212_12 <= arg_209_1.time_ and arg_209_1.time_ < var_212_12 + var_212_13 and not isNil(var_212_11) then
				local var_212_14 = (arg_209_1.time_ - var_212_12) / var_212_13

				if arg_209_1.var_.characterEffect10165ui_story and not isNil(var_212_11) then
					arg_209_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_12 + var_212_13 and arg_209_1.time_ < var_212_12 + var_212_13 + arg_212_0 and not isNil(var_212_11) and arg_209_1.var_.characterEffect10165ui_story then
				arg_209_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_212_15 = arg_209_1.actors_["10163ui_story"]
			local var_212_16 = 0

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 and not isNil(var_212_15) and arg_209_1.var_.characterEffect10163ui_story == nil then
				arg_209_1.var_.characterEffect10163ui_story = var_212_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_17 = 0.200000002980232

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_17 and not isNil(var_212_15) then
				local var_212_18 = (arg_209_1.time_ - var_212_16) / var_212_17

				if arg_209_1.var_.characterEffect10163ui_story and not isNil(var_212_15) then
					local var_212_19 = Mathf.Lerp(0, 0.5, var_212_18)

					arg_209_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_209_1.var_.characterEffect10163ui_story.fillRatio = var_212_19
				end
			end

			if arg_209_1.time_ >= var_212_16 + var_212_17 and arg_209_1.time_ < var_212_16 + var_212_17 + arg_212_0 and not isNil(var_212_15) and arg_209_1.var_.characterEffect10163ui_story then
				local var_212_20 = 0.5

				arg_209_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_209_1.var_.characterEffect10163ui_story.fillRatio = var_212_20
			end

			local var_212_21 = 0

			if var_212_21 < arg_209_1.time_ and arg_209_1.time_ <= var_212_21 + arg_212_0 then
				arg_209_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			local var_212_22 = 0

			if var_212_22 < arg_209_1.time_ and arg_209_1.time_ <= var_212_22 + arg_212_0 then
				arg_209_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_212_23 = 0
			local var_212_24 = 0.55

			if var_212_23 < arg_209_1.time_ and arg_209_1.time_ <= var_212_23 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_25 = arg_209_1:FormatText(StoryNameCfg[1446].name)

				arg_209_1.leftNameTxt_.text = var_212_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_26 = arg_209_1:GetWordFromCfg(323011050)
				local var_212_27 = arg_209_1:FormatText(var_212_26.content)

				arg_209_1.text_.text = var_212_27

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_28 = 25
				local var_212_29 = utf8.len(var_212_27)
				local var_212_30 = var_212_28 <= 0 and var_212_24 or var_212_24 * (var_212_29 / var_212_28)

				if var_212_30 > 0 and var_212_24 < var_212_30 then
					arg_209_1.talkMaxDuration = var_212_30

					if var_212_30 + var_212_23 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_30 + var_212_23
					end
				end

				arg_209_1.text_.text = var_212_27
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011050", "story_v_out_323011.awb") ~= 0 then
					local var_212_31 = manager.audio:GetVoiceLength("story_v_out_323011", "323011050", "story_v_out_323011.awb") / 1000

					if var_212_31 + var_212_23 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_31 + var_212_23
					end

					if var_212_26.prefab_name ~= "" and arg_209_1.actors_[var_212_26.prefab_name] ~= nil then
						local var_212_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_26.prefab_name].transform, "story_v_out_323011", "323011050", "story_v_out_323011.awb")

						arg_209_1:RecordAudio("323011050", var_212_32)
						arg_209_1:RecordAudio("323011050", var_212_32)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_323011", "323011050", "story_v_out_323011.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_323011", "323011050", "story_v_out_323011.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_33 = math.max(var_212_24, arg_209_1.talkMaxDuration)

			if var_212_23 <= arg_209_1.time_ and arg_209_1.time_ < var_212_23 + var_212_33 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_23) / var_212_33

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_23 + var_212_33 and arg_209_1.time_ < var_212_23 + var_212_33 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play323011051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 323011051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play323011052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10163ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos10163ui_story = var_216_0.localPosition

				local var_216_2 = GameObjectTools.GetOrAddComponent(var_216_0.gameObject, typeof(DynamicBoneHelper))

				if var_216_2 then
					var_216_2:EnableDynamicBone(false)
				end
			end

			local var_216_3 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_3 then
				local var_216_4 = (arg_213_1.time_ - var_216_1) / var_216_3
				local var_216_5 = Vector3.New(0, 100, 0)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10163ui_story, var_216_5, var_216_4)

				local var_216_6 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_6.x, var_216_6.y, var_216_6.z)

				local var_216_7 = var_216_0.localEulerAngles

				var_216_7.z = 0
				var_216_7.x = 0
				var_216_0.localEulerAngles = var_216_7
			end

			if arg_213_1.time_ >= var_216_1 + var_216_3 and arg_213_1.time_ < var_216_1 + var_216_3 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, 100, 0)

				local var_216_8 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_8.x, var_216_8.y, var_216_8.z)

				local var_216_9 = var_216_0.localEulerAngles

				var_216_9.z = 0
				var_216_9.x = 0
				var_216_0.localEulerAngles = var_216_9

				local var_216_10 = GameObjectTools.GetOrAddComponent(var_216_0.gameObject, typeof(DynamicBoneHelper))

				if var_216_10 then
					var_216_10:EnableDynamicBone(true)
				end
			end

			local var_216_11 = arg_213_1.actors_["10165ui_story"].transform
			local var_216_12 = 0

			if var_216_12 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 then
				arg_213_1.var_.moveOldPos10165ui_story = var_216_11.localPosition

				local var_216_13 = GameObjectTools.GetOrAddComponent(var_216_11.gameObject, typeof(DynamicBoneHelper))

				if var_216_13 then
					var_216_13:EnableDynamicBone(false)
				end
			end

			local var_216_14 = 0.001

			if var_216_12 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_14 then
				local var_216_15 = (arg_213_1.time_ - var_216_12) / var_216_14
				local var_216_16 = Vector3.New(0, 100, 0)

				var_216_11.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10165ui_story, var_216_16, var_216_15)

				local var_216_17 = manager.ui.mainCamera.transform.position - var_216_11.position

				var_216_11.forward = Vector3.New(var_216_17.x, var_216_17.y, var_216_17.z)

				local var_216_18 = var_216_11.localEulerAngles

				var_216_18.z = 0
				var_216_18.x = 0
				var_216_11.localEulerAngles = var_216_18
			end

			if arg_213_1.time_ >= var_216_12 + var_216_14 and arg_213_1.time_ < var_216_12 + var_216_14 + arg_216_0 then
				var_216_11.localPosition = Vector3.New(0, 100, 0)

				local var_216_19 = manager.ui.mainCamera.transform.position - var_216_11.position

				var_216_11.forward = Vector3.New(var_216_19.x, var_216_19.y, var_216_19.z)

				local var_216_20 = var_216_11.localEulerAngles

				var_216_20.z = 0
				var_216_20.x = 0
				var_216_11.localEulerAngles = var_216_20

				local var_216_21 = GameObjectTools.GetOrAddComponent(var_216_11.gameObject, typeof(DynamicBoneHelper))

				if var_216_21 then
					var_216_21:EnableDynamicBone(true)
				end
			end

			local var_216_22 = arg_213_1.actors_["10165ui_story"]
			local var_216_23 = 0

			if var_216_23 < arg_213_1.time_ and arg_213_1.time_ <= var_216_23 + arg_216_0 and not isNil(var_216_22) and arg_213_1.var_.characterEffect10165ui_story == nil then
				arg_213_1.var_.characterEffect10165ui_story = var_216_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_24 = 0.200000002980232

			if var_216_23 <= arg_213_1.time_ and arg_213_1.time_ < var_216_23 + var_216_24 and not isNil(var_216_22) then
				local var_216_25 = (arg_213_1.time_ - var_216_23) / var_216_24

				if arg_213_1.var_.characterEffect10165ui_story and not isNil(var_216_22) then
					local var_216_26 = Mathf.Lerp(0, 0.5, var_216_25)

					arg_213_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_213_1.var_.characterEffect10165ui_story.fillRatio = var_216_26
				end
			end

			if arg_213_1.time_ >= var_216_23 + var_216_24 and arg_213_1.time_ < var_216_23 + var_216_24 + arg_216_0 and not isNil(var_216_22) and arg_213_1.var_.characterEffect10165ui_story then
				local var_216_27 = 0.5

				arg_213_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_213_1.var_.characterEffect10165ui_story.fillRatio = var_216_27
			end

			local var_216_28 = 0.05
			local var_216_29 = 1

			if var_216_28 < arg_213_1.time_ and arg_213_1.time_ <= var_216_28 + arg_216_0 then
				local var_216_30 = "play"
				local var_216_31 = "effect"

				arg_213_1:AudioAction(var_216_30, var_216_31, "se_story_148", "se_story_148_cloth", "")
			end

			local var_216_32 = 0
			local var_216_33 = 1.05

			if var_216_32 < arg_213_1.time_ and arg_213_1.time_ <= var_216_32 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_34 = arg_213_1:GetWordFromCfg(323011051)
				local var_216_35 = arg_213_1:FormatText(var_216_34.content)

				arg_213_1.text_.text = var_216_35

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_36 = 42
				local var_216_37 = utf8.len(var_216_35)
				local var_216_38 = var_216_36 <= 0 and var_216_33 or var_216_33 * (var_216_37 / var_216_36)

				if var_216_38 > 0 and var_216_33 < var_216_38 then
					arg_213_1.talkMaxDuration = var_216_38

					if var_216_38 + var_216_32 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_38 + var_216_32
					end
				end

				arg_213_1.text_.text = var_216_35
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_39 = math.max(var_216_33, arg_213_1.talkMaxDuration)

			if var_216_32 <= arg_213_1.time_ and arg_213_1.time_ < var_216_32 + var_216_39 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_32) / var_216_39

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_32 + var_216_39 and arg_213_1.time_ < var_216_32 + var_216_39 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play323011052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 323011052
		arg_217_1.duration_ = 4.3

		local var_217_0 = {
			zh = 3.3,
			ja = 4.3
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play323011053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.25

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[1445].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(323011052)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 10
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011052", "story_v_out_323011.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011052", "story_v_out_323011.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_323011", "323011052", "story_v_out_323011.awb")

						arg_217_1:RecordAudio("323011052", var_220_9)
						arg_217_1:RecordAudio("323011052", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_323011", "323011052", "story_v_out_323011.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_323011", "323011052", "story_v_out_323011.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_10 and arg_217_1.time_ < var_220_0 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play323011053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 323011053
		arg_221_1.duration_ = 5.43

		local var_221_0 = {
			zh = 3.233,
			ja = 5.433
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play323011054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10163ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10163ui_story = var_224_0.localPosition

				local var_224_2 = GameObjectTools.GetOrAddComponent(var_224_0.gameObject, typeof(DynamicBoneHelper))

				if var_224_2 then
					var_224_2:EnableDynamicBone(false)
				end
			end

			local var_224_3 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_3 then
				local var_224_4 = (arg_221_1.time_ - var_224_1) / var_224_3
				local var_224_5 = Vector3.New(0, -1.08, -5.83)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10163ui_story, var_224_5, var_224_4)

				local var_224_6 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_6.x, var_224_6.y, var_224_6.z)

				local var_224_7 = var_224_0.localEulerAngles

				var_224_7.z = 0
				var_224_7.x = 0
				var_224_0.localEulerAngles = var_224_7
			end

			if arg_221_1.time_ >= var_224_1 + var_224_3 and arg_221_1.time_ < var_224_1 + var_224_3 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_224_8 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_8.x, var_224_8.y, var_224_8.z)

				local var_224_9 = var_224_0.localEulerAngles

				var_224_9.z = 0
				var_224_9.x = 0
				var_224_0.localEulerAngles = var_224_9

				local var_224_10 = GameObjectTools.GetOrAddComponent(var_224_0.gameObject, typeof(DynamicBoneHelper))

				if var_224_10 then
					var_224_10:EnableDynamicBone(true)
				end
			end

			local var_224_11 = arg_221_1.actors_["10163ui_story"]
			local var_224_12 = 0

			if var_224_12 < arg_221_1.time_ and arg_221_1.time_ <= var_224_12 + arg_224_0 and not isNil(var_224_11) and arg_221_1.var_.characterEffect10163ui_story == nil then
				arg_221_1.var_.characterEffect10163ui_story = var_224_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_13 = 0.200000002980232

			if var_224_12 <= arg_221_1.time_ and arg_221_1.time_ < var_224_12 + var_224_13 and not isNil(var_224_11) then
				local var_224_14 = (arg_221_1.time_ - var_224_12) / var_224_13

				if arg_221_1.var_.characterEffect10163ui_story and not isNil(var_224_11) then
					arg_221_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_12 + var_224_13 and arg_221_1.time_ < var_224_12 + var_224_13 + arg_224_0 and not isNil(var_224_11) and arg_221_1.var_.characterEffect10163ui_story then
				arg_221_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_224_15 = 0

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_1")
			end

			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 then
				arg_221_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_224_17 = 0

			if var_224_17 < arg_221_1.time_ and arg_221_1.time_ <= var_224_17 + arg_224_0 then
				arg_221_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_224_18 = 0
			local var_224_19 = 0.25

			if var_224_18 < arg_221_1.time_ and arg_221_1.time_ <= var_224_18 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_20 = arg_221_1:FormatText(StoryNameCfg[1444].name)

				arg_221_1.leftNameTxt_.text = var_224_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_21 = arg_221_1:GetWordFromCfg(323011053)
				local var_224_22 = arg_221_1:FormatText(var_224_21.content)

				arg_221_1.text_.text = var_224_22

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_23 = 10
				local var_224_24 = utf8.len(var_224_22)
				local var_224_25 = var_224_23 <= 0 and var_224_19 or var_224_19 * (var_224_24 / var_224_23)

				if var_224_25 > 0 and var_224_19 < var_224_25 then
					arg_221_1.talkMaxDuration = var_224_25

					if var_224_25 + var_224_18 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_25 + var_224_18
					end
				end

				arg_221_1.text_.text = var_224_22
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011053", "story_v_out_323011.awb") ~= 0 then
					local var_224_26 = manager.audio:GetVoiceLength("story_v_out_323011", "323011053", "story_v_out_323011.awb") / 1000

					if var_224_26 + var_224_18 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_26 + var_224_18
					end

					if var_224_21.prefab_name ~= "" and arg_221_1.actors_[var_224_21.prefab_name] ~= nil then
						local var_224_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_21.prefab_name].transform, "story_v_out_323011", "323011053", "story_v_out_323011.awb")

						arg_221_1:RecordAudio("323011053", var_224_27)
						arg_221_1:RecordAudio("323011053", var_224_27)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_323011", "323011053", "story_v_out_323011.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_323011", "323011053", "story_v_out_323011.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_28 = math.max(var_224_19, arg_221_1.talkMaxDuration)

			if var_224_18 <= arg_221_1.time_ and arg_221_1.time_ < var_224_18 + var_224_28 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_18) / var_224_28

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_18 + var_224_28 and arg_221_1.time_ < var_224_18 + var_224_28 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play323011054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 323011054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play323011055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10163ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos10163ui_story = var_228_0.localPosition

				local var_228_2 = GameObjectTools.GetOrAddComponent(var_228_0.gameObject, typeof(DynamicBoneHelper))

				if var_228_2 then
					var_228_2:EnableDynamicBone(false)
				end
			end

			local var_228_3 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_3 then
				local var_228_4 = (arg_225_1.time_ - var_228_1) / var_228_3
				local var_228_5 = Vector3.New(0, 100, 0)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10163ui_story, var_228_5, var_228_4)

				local var_228_6 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_6.x, var_228_6.y, var_228_6.z)

				local var_228_7 = var_228_0.localEulerAngles

				var_228_7.z = 0
				var_228_7.x = 0
				var_228_0.localEulerAngles = var_228_7
			end

			if arg_225_1.time_ >= var_228_1 + var_228_3 and arg_225_1.time_ < var_228_1 + var_228_3 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, 100, 0)

				local var_228_8 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_8.x, var_228_8.y, var_228_8.z)

				local var_228_9 = var_228_0.localEulerAngles

				var_228_9.z = 0
				var_228_9.x = 0
				var_228_0.localEulerAngles = var_228_9

				local var_228_10 = GameObjectTools.GetOrAddComponent(var_228_0.gameObject, typeof(DynamicBoneHelper))

				if var_228_10 then
					var_228_10:EnableDynamicBone(true)
				end
			end

			local var_228_11 = arg_225_1.actors_["10163ui_story"]
			local var_228_12 = 0

			if var_228_12 < arg_225_1.time_ and arg_225_1.time_ <= var_228_12 + arg_228_0 and not isNil(var_228_11) and arg_225_1.var_.characterEffect10163ui_story == nil then
				arg_225_1.var_.characterEffect10163ui_story = var_228_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_13 = 0.200000002980232

			if var_228_12 <= arg_225_1.time_ and arg_225_1.time_ < var_228_12 + var_228_13 and not isNil(var_228_11) then
				local var_228_14 = (arg_225_1.time_ - var_228_12) / var_228_13

				if arg_225_1.var_.characterEffect10163ui_story and not isNil(var_228_11) then
					local var_228_15 = Mathf.Lerp(0, 0.5, var_228_14)

					arg_225_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10163ui_story.fillRatio = var_228_15
				end
			end

			if arg_225_1.time_ >= var_228_12 + var_228_13 and arg_225_1.time_ < var_228_12 + var_228_13 + arg_228_0 and not isNil(var_228_11) and arg_225_1.var_.characterEffect10163ui_story then
				local var_228_16 = 0.5

				arg_225_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10163ui_story.fillRatio = var_228_16
			end

			local var_228_17 = 0.034000001847744
			local var_228_18 = 1

			if var_228_17 < arg_225_1.time_ and arg_225_1.time_ <= var_228_17 + arg_228_0 then
				local var_228_19 = "play"
				local var_228_20 = "effect"

				arg_225_1:AudioAction(var_228_19, var_228_20, "se_story_140", "se_story_140_foley_paperbag01", "")
			end

			local var_228_21 = 0
			local var_228_22 = 1.25

			if var_228_21 < arg_225_1.time_ and arg_225_1.time_ <= var_228_21 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_23 = arg_225_1:GetWordFromCfg(323011054)
				local var_228_24 = arg_225_1:FormatText(var_228_23.content)

				arg_225_1.text_.text = var_228_24

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_25 = 50
				local var_228_26 = utf8.len(var_228_24)
				local var_228_27 = var_228_25 <= 0 and var_228_22 or var_228_22 * (var_228_26 / var_228_25)

				if var_228_27 > 0 and var_228_22 < var_228_27 then
					arg_225_1.talkMaxDuration = var_228_27

					if var_228_27 + var_228_21 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_27 + var_228_21
					end
				end

				arg_225_1.text_.text = var_228_24
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_28 = math.max(var_228_22, arg_225_1.talkMaxDuration)

			if var_228_21 <= arg_225_1.time_ and arg_225_1.time_ < var_228_21 + var_228_28 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_21) / var_228_28

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_21 + var_228_28 and arg_225_1.time_ < var_228_21 + var_228_28 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play323011055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 323011055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play323011056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 1.125

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_2 = arg_229_1:GetWordFromCfg(323011055)
				local var_232_3 = arg_229_1:FormatText(var_232_2.content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 45
				local var_232_5 = utf8.len(var_232_3)
				local var_232_6 = var_232_4 <= 0 and var_232_1 or var_232_1 * (var_232_5 / var_232_4)

				if var_232_6 > 0 and var_232_1 < var_232_6 then
					arg_229_1.talkMaxDuration = var_232_6

					if var_232_6 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_7 and arg_229_1.time_ < var_232_0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play323011056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 323011056
		arg_233_1.duration_ = 8.01

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play323011057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = "J21h"

			if arg_233_1.bgs_[var_236_0] == nil then
				local var_236_1 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_236_0)
				var_236_1.name = var_236_0
				var_236_1.transform.parent = arg_233_1.stage_.transform
				var_236_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_[var_236_0] = var_236_1
			end

			local var_236_2 = 1.56666666666667

			if var_236_2 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				local var_236_3 = manager.ui.mainCamera.transform.localPosition
				local var_236_4 = Vector3.New(0, 0, 10) + Vector3.New(var_236_3.x, var_236_3.y, 0)
				local var_236_5 = arg_233_1.bgs_.J21h

				var_236_5.transform.localPosition = var_236_4
				var_236_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_6 = var_236_5:GetComponent("SpriteRenderer")

				if var_236_6 and var_236_6.sprite then
					local var_236_7 = (var_236_5.transform.localPosition - var_236_3).z
					local var_236_8 = manager.ui.mainCameraCom_
					local var_236_9 = 2 * var_236_7 * Mathf.Tan(var_236_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_236_10 = var_236_9 * var_236_8.aspect
					local var_236_11 = var_236_6.sprite.bounds.size.x
					local var_236_12 = var_236_6.sprite.bounds.size.y
					local var_236_13 = var_236_10 / var_236_11
					local var_236_14 = var_236_9 / var_236_12
					local var_236_15 = var_236_14 < var_236_13 and var_236_13 or var_236_14

					var_236_5.transform.localScale = Vector3.New(var_236_15, var_236_15, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "J21h" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_16 = 0

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			local var_236_17 = 0.3

			if arg_233_1.time_ >= var_236_16 + var_236_17 and arg_233_1.time_ < var_236_16 + var_236_17 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			local var_236_18 = 0

			if var_236_18 < arg_233_1.time_ and arg_233_1.time_ <= var_236_18 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_19 = 1.56666666666667

			if var_236_18 <= arg_233_1.time_ and arg_233_1.time_ < var_236_18 + var_236_19 then
				local var_236_20 = (arg_233_1.time_ - var_236_18) / var_236_19
				local var_236_21 = Color.New(0, 0, 0)

				var_236_21.a = Mathf.Lerp(0, 1, var_236_20)
				arg_233_1.mask_.color = var_236_21
			end

			if arg_233_1.time_ >= var_236_18 + var_236_19 and arg_233_1.time_ < var_236_18 + var_236_19 + arg_236_0 then
				local var_236_22 = Color.New(0, 0, 0)

				var_236_22.a = 1
				arg_233_1.mask_.color = var_236_22
			end

			local var_236_23 = 1.56666666666667

			if var_236_23 < arg_233_1.time_ and arg_233_1.time_ <= var_236_23 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_24 = 2

			if var_236_23 <= arg_233_1.time_ and arg_233_1.time_ < var_236_23 + var_236_24 then
				local var_236_25 = (arg_233_1.time_ - var_236_23) / var_236_24
				local var_236_26 = Color.New(0, 0, 0)

				var_236_26.a = Mathf.Lerp(1, 0, var_236_25)
				arg_233_1.mask_.color = var_236_26
			end

			if arg_233_1.time_ >= var_236_23 + var_236_24 and arg_233_1.time_ < var_236_23 + var_236_24 + arg_236_0 then
				local var_236_27 = Color.New(0, 0, 0)
				local var_236_28 = 0

				arg_233_1.mask_.enabled = false
				var_236_27.a = var_236_28
				arg_233_1.mask_.color = var_236_27
			end

			local var_236_29 = manager.ui.mainCamera.transform
			local var_236_30 = 1.56666666666667

			if var_236_30 < arg_233_1.time_ and arg_233_1.time_ <= var_236_30 + arg_236_0 then
				local var_236_31 = arg_233_1.var_.effect2323
				local var_236_32
				local var_236_33 = var_236_29

				if not var_236_31 then
					var_236_31 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_out"), var_236_33)
					var_236_31.name = "2323"
					arg_233_1.var_.effect2323 = var_236_31
				else
					var_236_31.transform:SetParent(var_236_33)
				end

				var_236_31.transform.localPosition = Vector3.New(0, 0, -1.6)
				var_236_31.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_236_34 = 1.7777777777777777
				local var_236_35 = Screen.width / Screen.height
				local var_236_36 = var_236_35 / var_236_34
				local var_236_37 = Mathf.Max(var_236_34 / var_236_35, 1)
				local var_236_38 = Mathf.Max(var_236_36, var_236_37)

				var_236_31.transform.localScale = Vector3.New(var_236_31.transform.localScale.x * var_236_38, var_236_31.transform.localScale.y * var_236_38, var_236_31.transform.localScale.z * var_236_38)
			end

			local var_236_39 = 0.166666666666667
			local var_236_40 = 1

			if var_236_39 < arg_233_1.time_ and arg_233_1.time_ <= var_236_39 + arg_236_0 then
				local var_236_41 = "stop"
				local var_236_42 = "effect"

				arg_233_1:AudioAction(var_236_41, var_236_42, "se_story_143", "se_story_143_amb_town", "")
			end

			local var_236_43 = 1.16666666666667
			local var_236_44 = 1

			if var_236_43 < arg_233_1.time_ and arg_233_1.time_ <= var_236_43 + arg_236_0 then
				local var_236_45 = "play"
				local var_236_46 = "effect"

				arg_233_1:AudioAction(var_236_45, var_236_46, "se_story_148", "se_story_148_amb_wind", "")
			end

			local var_236_47 = 3.33333333333333
			local var_236_48 = 1

			if var_236_47 < arg_233_1.time_ and arg_233_1.time_ <= var_236_47 + arg_236_0 then
				local var_236_49 = "play"
				local var_236_50 = "effect"

				arg_233_1:AudioAction(var_236_49, var_236_50, "se_story_148", "se_story_148_bell_temple_china02", "")
			end

			local var_236_51 = 0.166666666666667
			local var_236_52 = 0.3

			if var_236_51 < arg_233_1.time_ and arg_233_1.time_ <= var_236_51 + arg_236_0 then
				local var_236_53 = "play"
				local var_236_54 = "music"

				arg_233_1:AudioAction(var_236_53, var_236_54, "ui_battle", "ui_battle_stopbgm", "")

				local var_236_55 = ""
				local var_236_56 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_236_56 ~= "" then
					if arg_233_1.bgmTxt_.text ~= var_236_56 and arg_233_1.bgmTxt_.text ~= "" then
						if arg_233_1.bgmTxt2_.text ~= "" then
							arg_233_1.bgmTxt_.text = arg_233_1.bgmTxt2_.text
						end

						arg_233_1.bgmTxt2_.text = var_236_56

						arg_233_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_233_1.bgmTxt_.text = var_236_56
						arg_233_1.bgmTxt2_.text = var_236_56
					end

					if arg_233_1.bgmTimer then
						arg_233_1.bgmTimer:Stop()

						arg_233_1.bgmTimer = nil
					end

					if arg_233_1.settingData.show_music_name == 1 then
						arg_233_1.musicController:SetSelectedState("show")
						arg_233_1.musicAnimator_:Play("open", 0, 0)

						if arg_233_1.settingData.music_time ~= 0 then
							arg_233_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_233_1.settingData.music_time), function()
								if arg_233_1 == nil or isNil(arg_233_1.bgmTxt_) then
									return
								end

								arg_233_1.musicController:SetSelectedState("hide")
								arg_233_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_236_57 = 1.16666666666667
			local var_236_58 = 1

			if var_236_57 < arg_233_1.time_ and arg_233_1.time_ <= var_236_57 + arg_236_0 then
				local var_236_59 = "play"
				local var_236_60 = "music"

				arg_233_1:AudioAction(var_236_59, var_236_60, "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_236_61 = ""
				local var_236_62 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

				if var_236_62 ~= "" then
					if arg_233_1.bgmTxt_.text ~= var_236_62 and arg_233_1.bgmTxt_.text ~= "" then
						if arg_233_1.bgmTxt2_.text ~= "" then
							arg_233_1.bgmTxt_.text = arg_233_1.bgmTxt2_.text
						end

						arg_233_1.bgmTxt2_.text = var_236_62

						arg_233_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_233_1.bgmTxt_.text = var_236_62
						arg_233_1.bgmTxt2_.text = var_236_62
					end

					if arg_233_1.bgmTimer then
						arg_233_1.bgmTimer:Stop()

						arg_233_1.bgmTimer = nil
					end

					if arg_233_1.settingData.show_music_name == 1 then
						arg_233_1.musicController:SetSelectedState("show")
						arg_233_1.musicAnimator_:Play("open", 0, 0)

						if arg_233_1.settingData.music_time ~= 0 then
							arg_233_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_233_1.settingData.music_time), function()
								if arg_233_1 == nil or isNil(arg_233_1.bgmTxt_) then
									return
								end

								arg_233_1.musicController:SetSelectedState("hide")
								arg_233_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_63 = 3.0096003908664
			local var_236_64 = 1.575

			if var_236_63 < arg_233_1.time_ and arg_233_1.time_ <= var_236_63 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_65 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_65:setOnUpdate(LuaHelper.FloatAction(function(arg_239_0)
					arg_233_1.dialogCg_.alpha = arg_239_0
				end))
				var_236_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_66 = arg_233_1:GetWordFromCfg(323011056)
				local var_236_67 = arg_233_1:FormatText(var_236_66.content)

				arg_233_1.text_.text = var_236_67

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_68 = 63
				local var_236_69 = utf8.len(var_236_67)
				local var_236_70 = var_236_68 <= 0 and var_236_64 or var_236_64 * (var_236_69 / var_236_68)

				if var_236_70 > 0 and var_236_64 < var_236_70 then
					arg_233_1.talkMaxDuration = var_236_70
					var_236_63 = var_236_63 + 0.3

					if var_236_70 + var_236_63 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_70 + var_236_63
					end
				end

				arg_233_1.text_.text = var_236_67
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_71 = var_236_63 + 0.3
			local var_236_72 = math.max(var_236_64, arg_233_1.talkMaxDuration)

			if var_236_71 <= arg_233_1.time_ and arg_233_1.time_ < var_236_71 + var_236_72 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_71) / var_236_72

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_71 + var_236_72 and arg_233_1.time_ < var_236_71 + var_236_72 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play323011057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 323011057
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play323011058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = manager.ui.mainCamera.transform
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				local var_244_2 = arg_241_1.var_.effect2323

				if var_244_2 then
					Object.Destroy(var_244_2)

					arg_241_1.var_.effect2323 = nil
				end
			end

			local var_244_3 = 0
			local var_244_4 = 0.95

			if var_244_3 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_5 = arg_241_1:GetWordFromCfg(323011057)
				local var_244_6 = arg_241_1:FormatText(var_244_5.content)

				arg_241_1.text_.text = var_244_6

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 38
				local var_244_8 = utf8.len(var_244_6)
				local var_244_9 = var_244_7 <= 0 and var_244_4 or var_244_4 * (var_244_8 / var_244_7)

				if var_244_9 > 0 and var_244_4 < var_244_9 then
					arg_241_1.talkMaxDuration = var_244_9

					if var_244_9 + var_244_3 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_9 + var_244_3
					end
				end

				arg_241_1.text_.text = var_244_6
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_4, arg_241_1.talkMaxDuration)

			if var_244_3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_3 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_3) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_3 + var_244_10 and arg_241_1.time_ < var_244_3 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play323011058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 323011058
		arg_245_1.duration_ = 2.8

		local var_245_0 = {
			zh = 1.999999999999,
			ja = 2.8
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play323011059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = "10167ui_story"

			if arg_245_1.actors_[var_248_0] == nil then
				local var_248_1 = Asset.Load("Char/" .. "10167ui_story")

				if not isNil(var_248_1) then
					local var_248_2 = Object.Instantiate(Asset.Load("Char/" .. "10167ui_story"), arg_245_1.stage_.transform)

					var_248_2.name = var_248_0
					var_248_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_245_1.actors_[var_248_0] = var_248_2

					local var_248_3 = var_248_2:GetComponentInChildren(typeof(CharacterEffect))

					var_248_3.enabled = true

					local var_248_4 = GameObjectTools.GetOrAddComponent(var_248_2, typeof(DynamicBoneHelper))

					if var_248_4 then
						var_248_4:EnableDynamicBone(false)
					end

					arg_245_1:ShowWeapon(var_248_3.transform, false)

					arg_245_1.var_[var_248_0 .. "Animator"] = var_248_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_245_1.var_[var_248_0 .. "Animator"].applyRootMotion = true
					arg_245_1.var_[var_248_0 .. "LipSync"] = var_248_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_248_5 = arg_245_1.actors_["10167ui_story"].transform
			local var_248_6 = 0

			if var_248_6 < arg_245_1.time_ and arg_245_1.time_ <= var_248_6 + arg_248_0 then
				arg_245_1.var_.moveOldPos10167ui_story = var_248_5.localPosition

				local var_248_7 = GameObjectTools.GetOrAddComponent(var_248_5.gameObject, typeof(DynamicBoneHelper))

				if var_248_7 then
					var_248_7:EnableDynamicBone(false)
				end
			end

			local var_248_8 = 0.001

			if var_248_6 <= arg_245_1.time_ and arg_245_1.time_ < var_248_6 + var_248_8 then
				local var_248_9 = (arg_245_1.time_ - var_248_6) / var_248_8
				local var_248_10 = Vector3.New(0, -1.28, -5.73)

				var_248_5.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10167ui_story, var_248_10, var_248_9)

				local var_248_11 = manager.ui.mainCamera.transform.position - var_248_5.position

				var_248_5.forward = Vector3.New(var_248_11.x, var_248_11.y, var_248_11.z)

				local var_248_12 = var_248_5.localEulerAngles

				var_248_12.z = 0
				var_248_12.x = 0
				var_248_5.localEulerAngles = var_248_12
			end

			if arg_245_1.time_ >= var_248_6 + var_248_8 and arg_245_1.time_ < var_248_6 + var_248_8 + arg_248_0 then
				var_248_5.localPosition = Vector3.New(0, -1.28, -5.73)

				local var_248_13 = manager.ui.mainCamera.transform.position - var_248_5.position

				var_248_5.forward = Vector3.New(var_248_13.x, var_248_13.y, var_248_13.z)

				local var_248_14 = var_248_5.localEulerAngles

				var_248_14.z = 0
				var_248_14.x = 0
				var_248_5.localEulerAngles = var_248_14

				local var_248_15 = GameObjectTools.GetOrAddComponent(var_248_5.gameObject, typeof(DynamicBoneHelper))

				if var_248_15 then
					var_248_15:EnableDynamicBone(true)
				end
			end

			local var_248_16 = arg_245_1.actors_["10167ui_story"]
			local var_248_17 = 0

			if var_248_17 < arg_245_1.time_ and arg_245_1.time_ <= var_248_17 + arg_248_0 and not isNil(var_248_16) and arg_245_1.var_.characterEffect10167ui_story == nil then
				arg_245_1.var_.characterEffect10167ui_story = var_248_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_18 = 0.200000002980232

			if var_248_17 <= arg_245_1.time_ and arg_245_1.time_ < var_248_17 + var_248_18 and not isNil(var_248_16) then
				local var_248_19 = (arg_245_1.time_ - var_248_17) / var_248_18

				if arg_245_1.var_.characterEffect10167ui_story and not isNil(var_248_16) then
					arg_245_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_17 + var_248_18 and arg_245_1.time_ < var_248_17 + var_248_18 + arg_248_0 and not isNil(var_248_16) and arg_245_1.var_.characterEffect10167ui_story then
				arg_245_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_248_20 = 0

			if var_248_20 < arg_245_1.time_ and arg_245_1.time_ <= var_248_20 + arg_248_0 then
				arg_245_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			local var_248_21 = 0

			if var_248_21 < arg_245_1.time_ and arg_245_1.time_ <= var_248_21 + arg_248_0 then
				arg_245_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_248_22 = 0
			local var_248_23 = 0.1

			if var_248_22 < arg_245_1.time_ and arg_245_1.time_ <= var_248_22 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_24 = arg_245_1:FormatText(StoryNameCfg[1447].name)

				arg_245_1.leftNameTxt_.text = var_248_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_25 = arg_245_1:GetWordFromCfg(323011058)
				local var_248_26 = arg_245_1:FormatText(var_248_25.content)

				arg_245_1.text_.text = var_248_26

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_27 = 4
				local var_248_28 = utf8.len(var_248_26)
				local var_248_29 = var_248_27 <= 0 and var_248_23 or var_248_23 * (var_248_28 / var_248_27)

				if var_248_29 > 0 and var_248_23 < var_248_29 then
					arg_245_1.talkMaxDuration = var_248_29

					if var_248_29 + var_248_22 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_29 + var_248_22
					end
				end

				arg_245_1.text_.text = var_248_26
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011058", "story_v_out_323011.awb") ~= 0 then
					local var_248_30 = manager.audio:GetVoiceLength("story_v_out_323011", "323011058", "story_v_out_323011.awb") / 1000

					if var_248_30 + var_248_22 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_30 + var_248_22
					end

					if var_248_25.prefab_name ~= "" and arg_245_1.actors_[var_248_25.prefab_name] ~= nil then
						local var_248_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_25.prefab_name].transform, "story_v_out_323011", "323011058", "story_v_out_323011.awb")

						arg_245_1:RecordAudio("323011058", var_248_31)
						arg_245_1:RecordAudio("323011058", var_248_31)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_323011", "323011058", "story_v_out_323011.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_323011", "323011058", "story_v_out_323011.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_32 = math.max(var_248_23, arg_245_1.talkMaxDuration)

			if var_248_22 <= arg_245_1.time_ and arg_245_1.time_ < var_248_22 + var_248_32 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_22) / var_248_32

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_22 + var_248_32 and arg_245_1.time_ < var_248_22 + var_248_32 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play323011059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 323011059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play323011060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10167ui_story"].transform
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.var_.moveOldPos10167ui_story = var_252_0.localPosition

				local var_252_2 = GameObjectTools.GetOrAddComponent(var_252_0.gameObject, typeof(DynamicBoneHelper))

				if var_252_2 then
					var_252_2:EnableDynamicBone(false)
				end
			end

			local var_252_3 = 0.001

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_3 then
				local var_252_4 = (arg_249_1.time_ - var_252_1) / var_252_3
				local var_252_5 = Vector3.New(0, 100, 0)

				var_252_0.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10167ui_story, var_252_5, var_252_4)

				local var_252_6 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_6.x, var_252_6.y, var_252_6.z)

				local var_252_7 = var_252_0.localEulerAngles

				var_252_7.z = 0
				var_252_7.x = 0
				var_252_0.localEulerAngles = var_252_7
			end

			if arg_249_1.time_ >= var_252_1 + var_252_3 and arg_249_1.time_ < var_252_1 + var_252_3 + arg_252_0 then
				var_252_0.localPosition = Vector3.New(0, 100, 0)

				local var_252_8 = manager.ui.mainCamera.transform.position - var_252_0.position

				var_252_0.forward = Vector3.New(var_252_8.x, var_252_8.y, var_252_8.z)

				local var_252_9 = var_252_0.localEulerAngles

				var_252_9.z = 0
				var_252_9.x = 0
				var_252_0.localEulerAngles = var_252_9

				local var_252_10 = GameObjectTools.GetOrAddComponent(var_252_0.gameObject, typeof(DynamicBoneHelper))

				if var_252_10 then
					var_252_10:EnableDynamicBone(true)
				end
			end

			local var_252_11 = arg_249_1.actors_["10167ui_story"]
			local var_252_12 = 0

			if var_252_12 < arg_249_1.time_ and arg_249_1.time_ <= var_252_12 + arg_252_0 and not isNil(var_252_11) and arg_249_1.var_.characterEffect10167ui_story == nil then
				arg_249_1.var_.characterEffect10167ui_story = var_252_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_13 = 0.200000002980232

			if var_252_12 <= arg_249_1.time_ and arg_249_1.time_ < var_252_12 + var_252_13 and not isNil(var_252_11) then
				local var_252_14 = (arg_249_1.time_ - var_252_12) / var_252_13

				if arg_249_1.var_.characterEffect10167ui_story and not isNil(var_252_11) then
					local var_252_15 = Mathf.Lerp(0, 0.5, var_252_14)

					arg_249_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10167ui_story.fillRatio = var_252_15
				end
			end

			if arg_249_1.time_ >= var_252_12 + var_252_13 and arg_249_1.time_ < var_252_12 + var_252_13 + arg_252_0 and not isNil(var_252_11) and arg_249_1.var_.characterEffect10167ui_story then
				local var_252_16 = 0.5

				arg_249_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10167ui_story.fillRatio = var_252_16
			end

			local var_252_17 = 0
			local var_252_18 = 1.45

			if var_252_17 < arg_249_1.time_ and arg_249_1.time_ <= var_252_17 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_19 = arg_249_1:GetWordFromCfg(323011059)
				local var_252_20 = arg_249_1:FormatText(var_252_19.content)

				arg_249_1.text_.text = var_252_20

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_21 = 58
				local var_252_22 = utf8.len(var_252_20)
				local var_252_23 = var_252_21 <= 0 and var_252_18 or var_252_18 * (var_252_22 / var_252_21)

				if var_252_23 > 0 and var_252_18 < var_252_23 then
					arg_249_1.talkMaxDuration = var_252_23

					if var_252_23 + var_252_17 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_23 + var_252_17
					end
				end

				arg_249_1.text_.text = var_252_20
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_24 = math.max(var_252_18, arg_249_1.talkMaxDuration)

			if var_252_17 <= arg_249_1.time_ and arg_249_1.time_ < var_252_17 + var_252_24 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_17) / var_252_24

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_17 + var_252_24 and arg_249_1.time_ < var_252_17 + var_252_24 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play323011060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 323011060
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play323011061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 1.425

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:GetWordFromCfg(323011060)
				local var_256_3 = arg_253_1:FormatText(var_256_2.content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 57
				local var_256_5 = utf8.len(var_256_3)
				local var_256_6 = var_256_4 <= 0 and var_256_1 or var_256_1 * (var_256_5 / var_256_4)

				if var_256_6 > 0 and var_256_1 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_3
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_7 and arg_253_1.time_ < var_256_0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play323011061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 323011061
		arg_257_1.duration_ = 3.63

		local var_257_0 = {
			zh = 1.999999999999,
			ja = 3.633
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play323011062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10165ui_story"].transform
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.var_.moveOldPos10165ui_story = var_260_0.localPosition

				local var_260_2 = GameObjectTools.GetOrAddComponent(var_260_0.gameObject, typeof(DynamicBoneHelper))

				if var_260_2 then
					var_260_2:EnableDynamicBone(false)
				end
			end

			local var_260_3 = 0.001

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_3 then
				local var_260_4 = (arg_257_1.time_ - var_260_1) / var_260_3
				local var_260_5 = Vector3.New(0, -1.08, -5.83)

				var_260_0.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10165ui_story, var_260_5, var_260_4)

				local var_260_6 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_6.x, var_260_6.y, var_260_6.z)

				local var_260_7 = var_260_0.localEulerAngles

				var_260_7.z = 0
				var_260_7.x = 0
				var_260_0.localEulerAngles = var_260_7
			end

			if arg_257_1.time_ >= var_260_1 + var_260_3 and arg_257_1.time_ < var_260_1 + var_260_3 + arg_260_0 then
				var_260_0.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_260_8 = manager.ui.mainCamera.transform.position - var_260_0.position

				var_260_0.forward = Vector3.New(var_260_8.x, var_260_8.y, var_260_8.z)

				local var_260_9 = var_260_0.localEulerAngles

				var_260_9.z = 0
				var_260_9.x = 0
				var_260_0.localEulerAngles = var_260_9

				local var_260_10 = GameObjectTools.GetOrAddComponent(var_260_0.gameObject, typeof(DynamicBoneHelper))

				if var_260_10 then
					var_260_10:EnableDynamicBone(true)
				end
			end

			local var_260_11 = arg_257_1.actors_["10165ui_story"]
			local var_260_12 = 0

			if var_260_12 < arg_257_1.time_ and arg_257_1.time_ <= var_260_12 + arg_260_0 and not isNil(var_260_11) and arg_257_1.var_.characterEffect10165ui_story == nil then
				arg_257_1.var_.characterEffect10165ui_story = var_260_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_13 = 0.200000002980232

			if var_260_12 <= arg_257_1.time_ and arg_257_1.time_ < var_260_12 + var_260_13 and not isNil(var_260_11) then
				local var_260_14 = (arg_257_1.time_ - var_260_12) / var_260_13

				if arg_257_1.var_.characterEffect10165ui_story and not isNil(var_260_11) then
					arg_257_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_12 + var_260_13 and arg_257_1.time_ < var_260_12 + var_260_13 + arg_260_0 and not isNil(var_260_11) and arg_257_1.var_.characterEffect10165ui_story then
				arg_257_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_260_15 = 0

			if var_260_15 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 then
				arg_257_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			local var_260_16 = 0

			if var_260_16 < arg_257_1.time_ and arg_257_1.time_ <= var_260_16 + arg_260_0 then
				arg_257_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_260_17 = 0
			local var_260_18 = 0.125

			if var_260_17 < arg_257_1.time_ and arg_257_1.time_ <= var_260_17 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_19 = arg_257_1:FormatText(StoryNameCfg[1446].name)

				arg_257_1.leftNameTxt_.text = var_260_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_20 = arg_257_1:GetWordFromCfg(323011061)
				local var_260_21 = arg_257_1:FormatText(var_260_20.content)

				arg_257_1.text_.text = var_260_21

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_22 = 5
				local var_260_23 = utf8.len(var_260_21)
				local var_260_24 = var_260_22 <= 0 and var_260_18 or var_260_18 * (var_260_23 / var_260_22)

				if var_260_24 > 0 and var_260_18 < var_260_24 then
					arg_257_1.talkMaxDuration = var_260_24

					if var_260_24 + var_260_17 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_24 + var_260_17
					end
				end

				arg_257_1.text_.text = var_260_21
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011061", "story_v_out_323011.awb") ~= 0 then
					local var_260_25 = manager.audio:GetVoiceLength("story_v_out_323011", "323011061", "story_v_out_323011.awb") / 1000

					if var_260_25 + var_260_17 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_25 + var_260_17
					end

					if var_260_20.prefab_name ~= "" and arg_257_1.actors_[var_260_20.prefab_name] ~= nil then
						local var_260_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_20.prefab_name].transform, "story_v_out_323011", "323011061", "story_v_out_323011.awb")

						arg_257_1:RecordAudio("323011061", var_260_26)
						arg_257_1:RecordAudio("323011061", var_260_26)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_323011", "323011061", "story_v_out_323011.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_323011", "323011061", "story_v_out_323011.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_27 = math.max(var_260_18, arg_257_1.talkMaxDuration)

			if var_260_17 <= arg_257_1.time_ and arg_257_1.time_ < var_260_17 + var_260_27 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_17) / var_260_27

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_17 + var_260_27 and arg_257_1.time_ < var_260_17 + var_260_27 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play323011062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 323011062
		arg_261_1.duration_ = 5.9

		local var_261_0 = {
			zh = 5.9,
			ja = 5
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play323011063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10165ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos10165ui_story = var_264_0.localPosition

				local var_264_2 = GameObjectTools.GetOrAddComponent(var_264_0.gameObject, typeof(DynamicBoneHelper))

				if var_264_2 then
					var_264_2:EnableDynamicBone(false)
				end
			end

			local var_264_3 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_3 then
				local var_264_4 = (arg_261_1.time_ - var_264_1) / var_264_3
				local var_264_5 = Vector3.New(0, 100, 0)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10165ui_story, var_264_5, var_264_4)

				local var_264_6 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_6.x, var_264_6.y, var_264_6.z)

				local var_264_7 = var_264_0.localEulerAngles

				var_264_7.z = 0
				var_264_7.x = 0
				var_264_0.localEulerAngles = var_264_7
			end

			if arg_261_1.time_ >= var_264_1 + var_264_3 and arg_261_1.time_ < var_264_1 + var_264_3 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, 100, 0)

				local var_264_8 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_8.x, var_264_8.y, var_264_8.z)

				local var_264_9 = var_264_0.localEulerAngles

				var_264_9.z = 0
				var_264_9.x = 0
				var_264_0.localEulerAngles = var_264_9

				local var_264_10 = GameObjectTools.GetOrAddComponent(var_264_0.gameObject, typeof(DynamicBoneHelper))

				if var_264_10 then
					var_264_10:EnableDynamicBone(true)
				end
			end

			local var_264_11 = arg_261_1.actors_["10167ui_story"].transform
			local var_264_12 = 0

			if var_264_12 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 then
				arg_261_1.var_.moveOldPos10167ui_story = var_264_11.localPosition

				local var_264_13 = GameObjectTools.GetOrAddComponent(var_264_11.gameObject, typeof(DynamicBoneHelper))

				if var_264_13 then
					var_264_13:EnableDynamicBone(false)
				end
			end

			local var_264_14 = 0.001

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_14 then
				local var_264_15 = (arg_261_1.time_ - var_264_12) / var_264_14
				local var_264_16 = Vector3.New(-0.96, -1.28, -5.73)

				var_264_11.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10167ui_story, var_264_16, var_264_15)

				local var_264_17 = manager.ui.mainCamera.transform.position - var_264_11.position

				var_264_11.forward = Vector3.New(var_264_17.x, var_264_17.y, var_264_17.z)

				local var_264_18 = var_264_11.localEulerAngles

				var_264_18.z = 0
				var_264_18.x = 0
				var_264_11.localEulerAngles = var_264_18
			end

			if arg_261_1.time_ >= var_264_12 + var_264_14 and arg_261_1.time_ < var_264_12 + var_264_14 + arg_264_0 then
				var_264_11.localPosition = Vector3.New(-0.96, -1.28, -5.73)

				local var_264_19 = manager.ui.mainCamera.transform.position - var_264_11.position

				var_264_11.forward = Vector3.New(var_264_19.x, var_264_19.y, var_264_19.z)

				local var_264_20 = var_264_11.localEulerAngles

				var_264_20.z = 0
				var_264_20.x = 0
				var_264_11.localEulerAngles = var_264_20

				local var_264_21 = GameObjectTools.GetOrAddComponent(var_264_11.gameObject, typeof(DynamicBoneHelper))

				if var_264_21 then
					var_264_21:EnableDynamicBone(true)
				end
			end

			local var_264_22 = arg_261_1.actors_["10167ui_story"]
			local var_264_23 = 0

			if var_264_23 < arg_261_1.time_ and arg_261_1.time_ <= var_264_23 + arg_264_0 and not isNil(var_264_22) and arg_261_1.var_.characterEffect10167ui_story == nil then
				arg_261_1.var_.characterEffect10167ui_story = var_264_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_24 = 0.200000002980232

			if var_264_23 <= arg_261_1.time_ and arg_261_1.time_ < var_264_23 + var_264_24 and not isNil(var_264_22) then
				local var_264_25 = (arg_261_1.time_ - var_264_23) / var_264_24

				if arg_261_1.var_.characterEffect10167ui_story and not isNil(var_264_22) then
					arg_261_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_23 + var_264_24 and arg_261_1.time_ < var_264_23 + var_264_24 + arg_264_0 and not isNil(var_264_22) and arg_261_1.var_.characterEffect10167ui_story then
				arg_261_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_264_26 = arg_261_1.actors_["10165ui_story"]
			local var_264_27 = 0

			if var_264_27 < arg_261_1.time_ and arg_261_1.time_ <= var_264_27 + arg_264_0 and not isNil(var_264_26) and arg_261_1.var_.characterEffect10165ui_story == nil then
				arg_261_1.var_.characterEffect10165ui_story = var_264_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_28 = 0.200000002980232

			if var_264_27 <= arg_261_1.time_ and arg_261_1.time_ < var_264_27 + var_264_28 and not isNil(var_264_26) then
				local var_264_29 = (arg_261_1.time_ - var_264_27) / var_264_28

				if arg_261_1.var_.characterEffect10165ui_story and not isNil(var_264_26) then
					local var_264_30 = Mathf.Lerp(0, 0.5, var_264_29)

					arg_261_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_261_1.var_.characterEffect10165ui_story.fillRatio = var_264_30
				end
			end

			if arg_261_1.time_ >= var_264_27 + var_264_28 and arg_261_1.time_ < var_264_27 + var_264_28 + arg_264_0 and not isNil(var_264_26) and arg_261_1.var_.characterEffect10165ui_story then
				local var_264_31 = 0.5

				arg_261_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_261_1.var_.characterEffect10165ui_story.fillRatio = var_264_31
			end

			local var_264_32 = 0

			if var_264_32 < arg_261_1.time_ and arg_261_1.time_ <= var_264_32 + arg_264_0 then
				arg_261_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_1")
			end

			local var_264_33 = 0

			if var_264_33 < arg_261_1.time_ and arg_261_1.time_ <= var_264_33 + arg_264_0 then
				arg_261_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_264_34 = 0
			local var_264_35 = 0.325

			if var_264_34 < arg_261_1.time_ and arg_261_1.time_ <= var_264_34 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_36 = arg_261_1:FormatText(StoryNameCfg[1447].name)

				arg_261_1.leftNameTxt_.text = var_264_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_37 = arg_261_1:GetWordFromCfg(323011062)
				local var_264_38 = arg_261_1:FormatText(var_264_37.content)

				arg_261_1.text_.text = var_264_38

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_39 = 13
				local var_264_40 = utf8.len(var_264_38)
				local var_264_41 = var_264_39 <= 0 and var_264_35 or var_264_35 * (var_264_40 / var_264_39)

				if var_264_41 > 0 and var_264_35 < var_264_41 then
					arg_261_1.talkMaxDuration = var_264_41

					if var_264_41 + var_264_34 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_41 + var_264_34
					end
				end

				arg_261_1.text_.text = var_264_38
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011062", "story_v_out_323011.awb") ~= 0 then
					local var_264_42 = manager.audio:GetVoiceLength("story_v_out_323011", "323011062", "story_v_out_323011.awb") / 1000

					if var_264_42 + var_264_34 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_42 + var_264_34
					end

					if var_264_37.prefab_name ~= "" and arg_261_1.actors_[var_264_37.prefab_name] ~= nil then
						local var_264_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_37.prefab_name].transform, "story_v_out_323011", "323011062", "story_v_out_323011.awb")

						arg_261_1:RecordAudio("323011062", var_264_43)
						arg_261_1:RecordAudio("323011062", var_264_43)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_323011", "323011062", "story_v_out_323011.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_323011", "323011062", "story_v_out_323011.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_44 = math.max(var_264_35, arg_261_1.talkMaxDuration)

			if var_264_34 <= arg_261_1.time_ and arg_261_1.time_ < var_264_34 + var_264_44 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_34) / var_264_44

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_34 + var_264_44 and arg_261_1.time_ < var_264_34 + var_264_44 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play323011063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 323011063
		arg_265_1.duration_ = 5.4

		local var_265_0 = {
			zh = 3.5,
			ja = 5.4
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play323011064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["10163ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos10163ui_story = var_268_0.localPosition

				local var_268_2 = GameObjectTools.GetOrAddComponent(var_268_0.gameObject, typeof(DynamicBoneHelper))

				if var_268_2 then
					var_268_2:EnableDynamicBone(false)
				end
			end

			local var_268_3 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_3 then
				local var_268_4 = (arg_265_1.time_ - var_268_1) / var_268_3
				local var_268_5 = Vector3.New(0.7, -1.08, -5.83)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10163ui_story, var_268_5, var_268_4)

				local var_268_6 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_6.x, var_268_6.y, var_268_6.z)

				local var_268_7 = var_268_0.localEulerAngles

				var_268_7.z = 0
				var_268_7.x = 0
				var_268_0.localEulerAngles = var_268_7
			end

			if arg_265_1.time_ >= var_268_1 + var_268_3 and arg_265_1.time_ < var_268_1 + var_268_3 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0.7, -1.08, -5.83)

				local var_268_8 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_8.x, var_268_8.y, var_268_8.z)

				local var_268_9 = var_268_0.localEulerAngles

				var_268_9.z = 0
				var_268_9.x = 0
				var_268_0.localEulerAngles = var_268_9

				local var_268_10 = GameObjectTools.GetOrAddComponent(var_268_0.gameObject, typeof(DynamicBoneHelper))

				if var_268_10 then
					var_268_10:EnableDynamicBone(true)
				end
			end

			local var_268_11 = arg_265_1.actors_["10163ui_story"]
			local var_268_12 = 0

			if var_268_12 < arg_265_1.time_ and arg_265_1.time_ <= var_268_12 + arg_268_0 and not isNil(var_268_11) and arg_265_1.var_.characterEffect10163ui_story == nil then
				arg_265_1.var_.characterEffect10163ui_story = var_268_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_13 = 0.200000002980232

			if var_268_12 <= arg_265_1.time_ and arg_265_1.time_ < var_268_12 + var_268_13 and not isNil(var_268_11) then
				local var_268_14 = (arg_265_1.time_ - var_268_12) / var_268_13

				if arg_265_1.var_.characterEffect10163ui_story and not isNil(var_268_11) then
					arg_265_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_12 + var_268_13 and arg_265_1.time_ < var_268_12 + var_268_13 + arg_268_0 and not isNil(var_268_11) and arg_265_1.var_.characterEffect10163ui_story then
				arg_265_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_268_15 = arg_265_1.actors_["10167ui_story"]
			local var_268_16 = 0

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.characterEffect10167ui_story == nil then
				arg_265_1.var_.characterEffect10167ui_story = var_268_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_17 = 0.200000002980232

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_17 and not isNil(var_268_15) then
				local var_268_18 = (arg_265_1.time_ - var_268_16) / var_268_17

				if arg_265_1.var_.characterEffect10167ui_story and not isNil(var_268_15) then
					local var_268_19 = Mathf.Lerp(0, 0.5, var_268_18)

					arg_265_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_265_1.var_.characterEffect10167ui_story.fillRatio = var_268_19
				end
			end

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 and not isNil(var_268_15) and arg_265_1.var_.characterEffect10167ui_story then
				local var_268_20 = 0.5

				arg_265_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_265_1.var_.characterEffect10167ui_story.fillRatio = var_268_20
			end

			local var_268_21 = 0

			if var_268_21 < arg_265_1.time_ and arg_265_1.time_ <= var_268_21 + arg_268_0 then
				arg_265_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_1")
			end

			local var_268_22 = 0.034000001847744

			if var_268_22 < arg_265_1.time_ and arg_265_1.time_ <= var_268_22 + arg_268_0 then
				arg_265_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_268_23 = 0
			local var_268_24 = 0.275

			if var_268_23 < arg_265_1.time_ and arg_265_1.time_ <= var_268_23 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_25 = arg_265_1:FormatText(StoryNameCfg[1444].name)

				arg_265_1.leftNameTxt_.text = var_268_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_26 = arg_265_1:GetWordFromCfg(323011063)
				local var_268_27 = arg_265_1:FormatText(var_268_26.content)

				arg_265_1.text_.text = var_268_27

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_28 = 11
				local var_268_29 = utf8.len(var_268_27)
				local var_268_30 = var_268_28 <= 0 and var_268_24 or var_268_24 * (var_268_29 / var_268_28)

				if var_268_30 > 0 and var_268_24 < var_268_30 then
					arg_265_1.talkMaxDuration = var_268_30

					if var_268_30 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_30 + var_268_23
					end
				end

				arg_265_1.text_.text = var_268_27
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011063", "story_v_out_323011.awb") ~= 0 then
					local var_268_31 = manager.audio:GetVoiceLength("story_v_out_323011", "323011063", "story_v_out_323011.awb") / 1000

					if var_268_31 + var_268_23 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_31 + var_268_23
					end

					if var_268_26.prefab_name ~= "" and arg_265_1.actors_[var_268_26.prefab_name] ~= nil then
						local var_268_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_26.prefab_name].transform, "story_v_out_323011", "323011063", "story_v_out_323011.awb")

						arg_265_1:RecordAudio("323011063", var_268_32)
						arg_265_1:RecordAudio("323011063", var_268_32)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_323011", "323011063", "story_v_out_323011.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_323011", "323011063", "story_v_out_323011.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_33 = math.max(var_268_24, arg_265_1.talkMaxDuration)

			if var_268_23 <= arg_265_1.time_ and arg_265_1.time_ < var_268_23 + var_268_33 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_23) / var_268_33

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_23 + var_268_33 and arg_265_1.time_ < var_268_23 + var_268_33 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play323011064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 323011064
		arg_269_1.duration_ = 2.9

		local var_269_0 = {
			zh = 2.9,
			ja = 2.8
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play323011065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["10167ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect10167ui_story == nil then
				arg_269_1.var_.characterEffect10167ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect10167ui_story and not isNil(var_272_0) then
					arg_269_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect10167ui_story then
				arg_269_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_272_4 = arg_269_1.actors_["10163ui_story"]
			local var_272_5 = 0

			if var_272_5 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 and not isNil(var_272_4) and arg_269_1.var_.characterEffect10163ui_story == nil then
				arg_269_1.var_.characterEffect10163ui_story = var_272_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_6 = 0.200000002980232

			if var_272_5 <= arg_269_1.time_ and arg_269_1.time_ < var_272_5 + var_272_6 and not isNil(var_272_4) then
				local var_272_7 = (arg_269_1.time_ - var_272_5) / var_272_6

				if arg_269_1.var_.characterEffect10163ui_story and not isNil(var_272_4) then
					local var_272_8 = Mathf.Lerp(0, 0.5, var_272_7)

					arg_269_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_269_1.var_.characterEffect10163ui_story.fillRatio = var_272_8
				end
			end

			if arg_269_1.time_ >= var_272_5 + var_272_6 and arg_269_1.time_ < var_272_5 + var_272_6 + arg_272_0 and not isNil(var_272_4) and arg_269_1.var_.characterEffect10163ui_story then
				local var_272_9 = 0.5

				arg_269_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_269_1.var_.characterEffect10163ui_story.fillRatio = var_272_9
			end

			local var_272_10 = 0
			local var_272_11 = 0.15

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_12 = arg_269_1:FormatText(StoryNameCfg[1447].name)

				arg_269_1.leftNameTxt_.text = var_272_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_13 = arg_269_1:GetWordFromCfg(323011064)
				local var_272_14 = arg_269_1:FormatText(var_272_13.content)

				arg_269_1.text_.text = var_272_14

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_15 = 6
				local var_272_16 = utf8.len(var_272_14)
				local var_272_17 = var_272_15 <= 0 and var_272_11 or var_272_11 * (var_272_16 / var_272_15)

				if var_272_17 > 0 and var_272_11 < var_272_17 then
					arg_269_1.talkMaxDuration = var_272_17

					if var_272_17 + var_272_10 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_17 + var_272_10
					end
				end

				arg_269_1.text_.text = var_272_14
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011064", "story_v_out_323011.awb") ~= 0 then
					local var_272_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011064", "story_v_out_323011.awb") / 1000

					if var_272_18 + var_272_10 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_18 + var_272_10
					end

					if var_272_13.prefab_name ~= "" and arg_269_1.actors_[var_272_13.prefab_name] ~= nil then
						local var_272_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_13.prefab_name].transform, "story_v_out_323011", "323011064", "story_v_out_323011.awb")

						arg_269_1:RecordAudio("323011064", var_272_19)
						arg_269_1:RecordAudio("323011064", var_272_19)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_323011", "323011064", "story_v_out_323011.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_323011", "323011064", "story_v_out_323011.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_20 = math.max(var_272_11, arg_269_1.talkMaxDuration)

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_20 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_10) / var_272_20

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_10 + var_272_20 and arg_269_1.time_ < var_272_10 + var_272_20 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play323011065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 323011065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play323011066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10167ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos10167ui_story = var_276_0.localPosition

				local var_276_2 = GameObjectTools.GetOrAddComponent(var_276_0.gameObject, typeof(DynamicBoneHelper))

				if var_276_2 then
					var_276_2:EnableDynamicBone(false)
				end
			end

			local var_276_3 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_3 then
				local var_276_4 = (arg_273_1.time_ - var_276_1) / var_276_3
				local var_276_5 = Vector3.New(0, 100, 0)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10167ui_story, var_276_5, var_276_4)

				local var_276_6 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_6.x, var_276_6.y, var_276_6.z)

				local var_276_7 = var_276_0.localEulerAngles

				var_276_7.z = 0
				var_276_7.x = 0
				var_276_0.localEulerAngles = var_276_7
			end

			if arg_273_1.time_ >= var_276_1 + var_276_3 and arg_273_1.time_ < var_276_1 + var_276_3 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, 100, 0)

				local var_276_8 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_8.x, var_276_8.y, var_276_8.z)

				local var_276_9 = var_276_0.localEulerAngles

				var_276_9.z = 0
				var_276_9.x = 0
				var_276_0.localEulerAngles = var_276_9

				local var_276_10 = GameObjectTools.GetOrAddComponent(var_276_0.gameObject, typeof(DynamicBoneHelper))

				if var_276_10 then
					var_276_10:EnableDynamicBone(true)
				end
			end

			local var_276_11 = arg_273_1.actors_["10163ui_story"].transform
			local var_276_12 = 0

			if var_276_12 < arg_273_1.time_ and arg_273_1.time_ <= var_276_12 + arg_276_0 then
				arg_273_1.var_.moveOldPos10163ui_story = var_276_11.localPosition

				local var_276_13 = GameObjectTools.GetOrAddComponent(var_276_11.gameObject, typeof(DynamicBoneHelper))

				if var_276_13 then
					var_276_13:EnableDynamicBone(false)
				end
			end

			local var_276_14 = 0.001

			if var_276_12 <= arg_273_1.time_ and arg_273_1.time_ < var_276_12 + var_276_14 then
				local var_276_15 = (arg_273_1.time_ - var_276_12) / var_276_14
				local var_276_16 = Vector3.New(0, 100, 0)

				var_276_11.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10163ui_story, var_276_16, var_276_15)

				local var_276_17 = manager.ui.mainCamera.transform.position - var_276_11.position

				var_276_11.forward = Vector3.New(var_276_17.x, var_276_17.y, var_276_17.z)

				local var_276_18 = var_276_11.localEulerAngles

				var_276_18.z = 0
				var_276_18.x = 0
				var_276_11.localEulerAngles = var_276_18
			end

			if arg_273_1.time_ >= var_276_12 + var_276_14 and arg_273_1.time_ < var_276_12 + var_276_14 + arg_276_0 then
				var_276_11.localPosition = Vector3.New(0, 100, 0)

				local var_276_19 = manager.ui.mainCamera.transform.position - var_276_11.position

				var_276_11.forward = Vector3.New(var_276_19.x, var_276_19.y, var_276_19.z)

				local var_276_20 = var_276_11.localEulerAngles

				var_276_20.z = 0
				var_276_20.x = 0
				var_276_11.localEulerAngles = var_276_20

				local var_276_21 = GameObjectTools.GetOrAddComponent(var_276_11.gameObject, typeof(DynamicBoneHelper))

				if var_276_21 then
					var_276_21:EnableDynamicBone(true)
				end
			end

			local var_276_22 = arg_273_1.actors_["10167ui_story"]
			local var_276_23 = 0

			if var_276_23 < arg_273_1.time_ and arg_273_1.time_ <= var_276_23 + arg_276_0 and not isNil(var_276_22) and arg_273_1.var_.characterEffect10167ui_story == nil then
				arg_273_1.var_.characterEffect10167ui_story = var_276_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_24 = 0.200000002980232

			if var_276_23 <= arg_273_1.time_ and arg_273_1.time_ < var_276_23 + var_276_24 and not isNil(var_276_22) then
				local var_276_25 = (arg_273_1.time_ - var_276_23) / var_276_24

				if arg_273_1.var_.characterEffect10167ui_story and not isNil(var_276_22) then
					local var_276_26 = Mathf.Lerp(0, 0.5, var_276_25)

					arg_273_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_273_1.var_.characterEffect10167ui_story.fillRatio = var_276_26
				end
			end

			if arg_273_1.time_ >= var_276_23 + var_276_24 and arg_273_1.time_ < var_276_23 + var_276_24 + arg_276_0 and not isNil(var_276_22) and arg_273_1.var_.characterEffect10167ui_story then
				local var_276_27 = 0.5

				arg_273_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_273_1.var_.characterEffect10167ui_story.fillRatio = var_276_27
			end

			local var_276_28 = 0
			local var_276_29 = 1.025

			if var_276_28 < arg_273_1.time_ and arg_273_1.time_ <= var_276_28 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_30 = arg_273_1:GetWordFromCfg(323011065)
				local var_276_31 = arg_273_1:FormatText(var_276_30.content)

				arg_273_1.text_.text = var_276_31

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_32 = 41
				local var_276_33 = utf8.len(var_276_31)
				local var_276_34 = var_276_32 <= 0 and var_276_29 or var_276_29 * (var_276_33 / var_276_32)

				if var_276_34 > 0 and var_276_29 < var_276_34 then
					arg_273_1.talkMaxDuration = var_276_34

					if var_276_34 + var_276_28 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_34 + var_276_28
					end
				end

				arg_273_1.text_.text = var_276_31
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_35 = math.max(var_276_29, arg_273_1.talkMaxDuration)

			if var_276_28 <= arg_273_1.time_ and arg_273_1.time_ < var_276_28 + var_276_35 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_28) / var_276_35

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_28 + var_276_35 and arg_273_1.time_ < var_276_28 + var_276_35 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play323011066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 323011066
		arg_277_1.duration_ = 3.63

		local var_277_0 = {
			zh = 3.633,
			ja = 2.266
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play323011067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["10163ui_story"].transform
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.var_.moveOldPos10163ui_story = var_280_0.localPosition

				local var_280_2 = GameObjectTools.GetOrAddComponent(var_280_0.gameObject, typeof(DynamicBoneHelper))

				if var_280_2 then
					var_280_2:EnableDynamicBone(false)
				end
			end

			local var_280_3 = 0.001

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_3 then
				local var_280_4 = (arg_277_1.time_ - var_280_1) / var_280_3
				local var_280_5 = Vector3.New(0.7, -1.08, -5.83)

				var_280_0.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10163ui_story, var_280_5, var_280_4)

				local var_280_6 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_6.x, var_280_6.y, var_280_6.z)

				local var_280_7 = var_280_0.localEulerAngles

				var_280_7.z = 0
				var_280_7.x = 0
				var_280_0.localEulerAngles = var_280_7
			end

			if arg_277_1.time_ >= var_280_1 + var_280_3 and arg_277_1.time_ < var_280_1 + var_280_3 + arg_280_0 then
				var_280_0.localPosition = Vector3.New(0.7, -1.08, -5.83)

				local var_280_8 = manager.ui.mainCamera.transform.position - var_280_0.position

				var_280_0.forward = Vector3.New(var_280_8.x, var_280_8.y, var_280_8.z)

				local var_280_9 = var_280_0.localEulerAngles

				var_280_9.z = 0
				var_280_9.x = 0
				var_280_0.localEulerAngles = var_280_9

				local var_280_10 = GameObjectTools.GetOrAddComponent(var_280_0.gameObject, typeof(DynamicBoneHelper))

				if var_280_10 then
					var_280_10:EnableDynamicBone(true)
				end
			end

			local var_280_11 = arg_277_1.actors_["10163ui_story"]
			local var_280_12 = 0

			if var_280_12 < arg_277_1.time_ and arg_277_1.time_ <= var_280_12 + arg_280_0 and not isNil(var_280_11) and arg_277_1.var_.characterEffect10163ui_story == nil then
				arg_277_1.var_.characterEffect10163ui_story = var_280_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_13 = 0.200000002980232

			if var_280_12 <= arg_277_1.time_ and arg_277_1.time_ < var_280_12 + var_280_13 and not isNil(var_280_11) then
				local var_280_14 = (arg_277_1.time_ - var_280_12) / var_280_13

				if arg_277_1.var_.characterEffect10163ui_story and not isNil(var_280_11) then
					arg_277_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_12 + var_280_13 and arg_277_1.time_ < var_280_12 + var_280_13 + arg_280_0 and not isNil(var_280_11) and arg_277_1.var_.characterEffect10163ui_story then
				arg_277_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_280_15 = 0

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				arg_277_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_2")
			end

			local var_280_16 = 0

			if var_280_16 < arg_277_1.time_ and arg_277_1.time_ <= var_280_16 + arg_280_0 then
				arg_277_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_280_17 = 0
			local var_280_18 = 0.225

			if var_280_17 < arg_277_1.time_ and arg_277_1.time_ <= var_280_17 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_19 = arg_277_1:FormatText(StoryNameCfg[1444].name)

				arg_277_1.leftNameTxt_.text = var_280_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_20 = arg_277_1:GetWordFromCfg(323011066)
				local var_280_21 = arg_277_1:FormatText(var_280_20.content)

				arg_277_1.text_.text = var_280_21

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_22 = 9
				local var_280_23 = utf8.len(var_280_21)
				local var_280_24 = var_280_22 <= 0 and var_280_18 or var_280_18 * (var_280_23 / var_280_22)

				if var_280_24 > 0 and var_280_18 < var_280_24 then
					arg_277_1.talkMaxDuration = var_280_24

					if var_280_24 + var_280_17 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_24 + var_280_17
					end
				end

				arg_277_1.text_.text = var_280_21
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011066", "story_v_out_323011.awb") ~= 0 then
					local var_280_25 = manager.audio:GetVoiceLength("story_v_out_323011", "323011066", "story_v_out_323011.awb") / 1000

					if var_280_25 + var_280_17 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_25 + var_280_17
					end

					if var_280_20.prefab_name ~= "" and arg_277_1.actors_[var_280_20.prefab_name] ~= nil then
						local var_280_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_20.prefab_name].transform, "story_v_out_323011", "323011066", "story_v_out_323011.awb")

						arg_277_1:RecordAudio("323011066", var_280_26)
						arg_277_1:RecordAudio("323011066", var_280_26)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_323011", "323011066", "story_v_out_323011.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_323011", "323011066", "story_v_out_323011.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_27 = math.max(var_280_18, arg_277_1.talkMaxDuration)

			if var_280_17 <= arg_277_1.time_ and arg_277_1.time_ < var_280_17 + var_280_27 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_17) / var_280_27

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_17 + var_280_27 and arg_277_1.time_ < var_280_17 + var_280_27 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play323011067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 323011067
		arg_281_1.duration_ = 8.4

		local var_281_0 = {
			zh = 5.4,
			ja = 8.4
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play323011068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10167ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos10167ui_story = var_284_0.localPosition

				local var_284_2 = GameObjectTools.GetOrAddComponent(var_284_0.gameObject, typeof(DynamicBoneHelper))

				if var_284_2 then
					var_284_2:EnableDynamicBone(false)
				end
			end

			local var_284_3 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_3 then
				local var_284_4 = (arg_281_1.time_ - var_284_1) / var_284_3
				local var_284_5 = Vector3.New(-0.96, -1.28, -5.73)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10167ui_story, var_284_5, var_284_4)

				local var_284_6 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_6.x, var_284_6.y, var_284_6.z)

				local var_284_7 = var_284_0.localEulerAngles

				var_284_7.z = 0
				var_284_7.x = 0
				var_284_0.localEulerAngles = var_284_7
			end

			if arg_281_1.time_ >= var_284_1 + var_284_3 and arg_281_1.time_ < var_284_1 + var_284_3 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(-0.96, -1.28, -5.73)

				local var_284_8 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_8.x, var_284_8.y, var_284_8.z)

				local var_284_9 = var_284_0.localEulerAngles

				var_284_9.z = 0
				var_284_9.x = 0
				var_284_0.localEulerAngles = var_284_9

				local var_284_10 = GameObjectTools.GetOrAddComponent(var_284_0.gameObject, typeof(DynamicBoneHelper))

				if var_284_10 then
					var_284_10:EnableDynamicBone(true)
				end
			end

			local var_284_11 = arg_281_1.actors_["10167ui_story"]
			local var_284_12 = 0

			if var_284_12 < arg_281_1.time_ and arg_281_1.time_ <= var_284_12 + arg_284_0 and not isNil(var_284_11) and arg_281_1.var_.characterEffect10167ui_story == nil then
				arg_281_1.var_.characterEffect10167ui_story = var_284_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_13 = 0.200000002980232

			if var_284_12 <= arg_281_1.time_ and arg_281_1.time_ < var_284_12 + var_284_13 and not isNil(var_284_11) then
				local var_284_14 = (arg_281_1.time_ - var_284_12) / var_284_13

				if arg_281_1.var_.characterEffect10167ui_story and not isNil(var_284_11) then
					arg_281_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_12 + var_284_13 and arg_281_1.time_ < var_284_12 + var_284_13 + arg_284_0 and not isNil(var_284_11) and arg_281_1.var_.characterEffect10167ui_story then
				arg_281_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_284_15 = arg_281_1.actors_["10163ui_story"]
			local var_284_16 = 0

			if var_284_16 < arg_281_1.time_ and arg_281_1.time_ <= var_284_16 + arg_284_0 and not isNil(var_284_15) and arg_281_1.var_.characterEffect10163ui_story == nil then
				arg_281_1.var_.characterEffect10163ui_story = var_284_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_17 = 0.200000002980232

			if var_284_16 <= arg_281_1.time_ and arg_281_1.time_ < var_284_16 + var_284_17 and not isNil(var_284_15) then
				local var_284_18 = (arg_281_1.time_ - var_284_16) / var_284_17

				if arg_281_1.var_.characterEffect10163ui_story and not isNil(var_284_15) then
					local var_284_19 = Mathf.Lerp(0, 0.5, var_284_18)

					arg_281_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_281_1.var_.characterEffect10163ui_story.fillRatio = var_284_19
				end
			end

			if arg_281_1.time_ >= var_284_16 + var_284_17 and arg_281_1.time_ < var_284_16 + var_284_17 + arg_284_0 and not isNil(var_284_15) and arg_281_1.var_.characterEffect10163ui_story then
				local var_284_20 = 0.5

				arg_281_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_281_1.var_.characterEffect10163ui_story.fillRatio = var_284_20
			end

			local var_284_21 = 0

			if var_284_21 < arg_281_1.time_ and arg_281_1.time_ <= var_284_21 + arg_284_0 then
				arg_281_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_2")
			end

			local var_284_22 = 0

			if var_284_22 < arg_281_1.time_ and arg_281_1.time_ <= var_284_22 + arg_284_0 then
				arg_281_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_284_23 = 0
			local var_284_24 = 0.5

			if var_284_23 < arg_281_1.time_ and arg_281_1.time_ <= var_284_23 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_25 = arg_281_1:FormatText(StoryNameCfg[1447].name)

				arg_281_1.leftNameTxt_.text = var_284_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_26 = arg_281_1:GetWordFromCfg(323011067)
				local var_284_27 = arg_281_1:FormatText(var_284_26.content)

				arg_281_1.text_.text = var_284_27

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_28 = 20
				local var_284_29 = utf8.len(var_284_27)
				local var_284_30 = var_284_28 <= 0 and var_284_24 or var_284_24 * (var_284_29 / var_284_28)

				if var_284_30 > 0 and var_284_24 < var_284_30 then
					arg_281_1.talkMaxDuration = var_284_30

					if var_284_30 + var_284_23 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_30 + var_284_23
					end
				end

				arg_281_1.text_.text = var_284_27
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011067", "story_v_out_323011.awb") ~= 0 then
					local var_284_31 = manager.audio:GetVoiceLength("story_v_out_323011", "323011067", "story_v_out_323011.awb") / 1000

					if var_284_31 + var_284_23 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_31 + var_284_23
					end

					if var_284_26.prefab_name ~= "" and arg_281_1.actors_[var_284_26.prefab_name] ~= nil then
						local var_284_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_26.prefab_name].transform, "story_v_out_323011", "323011067", "story_v_out_323011.awb")

						arg_281_1:RecordAudio("323011067", var_284_32)
						arg_281_1:RecordAudio("323011067", var_284_32)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_323011", "323011067", "story_v_out_323011.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_323011", "323011067", "story_v_out_323011.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_33 = math.max(var_284_24, arg_281_1.talkMaxDuration)

			if var_284_23 <= arg_281_1.time_ and arg_281_1.time_ < var_284_23 + var_284_33 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_23) / var_284_33

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_23 + var_284_33 and arg_281_1.time_ < var_284_23 + var_284_33 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play323011068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 323011068
		arg_285_1.duration_ = 5.5

		local var_285_0 = {
			zh = 5.1,
			ja = 5.5
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play323011069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10163ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect10163ui_story == nil then
				arg_285_1.var_.characterEffect10163ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect10163ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect10163ui_story then
				arg_285_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_288_4 = arg_285_1.actors_["10167ui_story"]
			local var_288_5 = 0

			if var_288_5 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect10167ui_story == nil then
				arg_285_1.var_.characterEffect10167ui_story = var_288_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_6 = 0.200000002980232

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_6 and not isNil(var_288_4) then
				local var_288_7 = (arg_285_1.time_ - var_288_5) / var_288_6

				if arg_285_1.var_.characterEffect10167ui_story and not isNil(var_288_4) then
					local var_288_8 = Mathf.Lerp(0, 0.5, var_288_7)

					arg_285_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_285_1.var_.characterEffect10167ui_story.fillRatio = var_288_8
				end
			end

			if arg_285_1.time_ >= var_288_5 + var_288_6 and arg_285_1.time_ < var_288_5 + var_288_6 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect10167ui_story then
				local var_288_9 = 0.5

				arg_285_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_285_1.var_.characterEffect10167ui_story.fillRatio = var_288_9
			end

			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_288_11 = 0
			local var_288_12 = 0.575

			if var_288_11 < arg_285_1.time_ and arg_285_1.time_ <= var_288_11 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_13 = arg_285_1:FormatText(StoryNameCfg[1444].name)

				arg_285_1.leftNameTxt_.text = var_288_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_14 = arg_285_1:GetWordFromCfg(323011068)
				local var_288_15 = arg_285_1:FormatText(var_288_14.content)

				arg_285_1.text_.text = var_288_15

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_16 = 23
				local var_288_17 = utf8.len(var_288_15)
				local var_288_18 = var_288_16 <= 0 and var_288_12 or var_288_12 * (var_288_17 / var_288_16)

				if var_288_18 > 0 and var_288_12 < var_288_18 then
					arg_285_1.talkMaxDuration = var_288_18

					if var_288_18 + var_288_11 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_18 + var_288_11
					end
				end

				arg_285_1.text_.text = var_288_15
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011068", "story_v_out_323011.awb") ~= 0 then
					local var_288_19 = manager.audio:GetVoiceLength("story_v_out_323011", "323011068", "story_v_out_323011.awb") / 1000

					if var_288_19 + var_288_11 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_19 + var_288_11
					end

					if var_288_14.prefab_name ~= "" and arg_285_1.actors_[var_288_14.prefab_name] ~= nil then
						local var_288_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_14.prefab_name].transform, "story_v_out_323011", "323011068", "story_v_out_323011.awb")

						arg_285_1:RecordAudio("323011068", var_288_20)
						arg_285_1:RecordAudio("323011068", var_288_20)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_323011", "323011068", "story_v_out_323011.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_323011", "323011068", "story_v_out_323011.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_21 = math.max(var_288_12, arg_285_1.talkMaxDuration)

			if var_288_11 <= arg_285_1.time_ and arg_285_1.time_ < var_288_11 + var_288_21 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_11) / var_288_21

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_11 + var_288_21 and arg_285_1.time_ < var_288_11 + var_288_21 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play323011069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 323011069
		arg_289_1.duration_ = 4.13

		local var_289_0 = {
			zh = 4.1,
			ja = 4.133
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play323011070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["10167ui_story"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect10167ui_story == nil then
				arg_289_1.var_.characterEffect10167ui_story = var_292_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.characterEffect10167ui_story and not isNil(var_292_0) then
					arg_289_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.characterEffect10167ui_story then
				arg_289_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_292_4 = arg_289_1.actors_["10163ui_story"]
			local var_292_5 = 0

			if var_292_5 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect10163ui_story == nil then
				arg_289_1.var_.characterEffect10163ui_story = var_292_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_6 = 0.200000002980232

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_6 and not isNil(var_292_4) then
				local var_292_7 = (arg_289_1.time_ - var_292_5) / var_292_6

				if arg_289_1.var_.characterEffect10163ui_story and not isNil(var_292_4) then
					local var_292_8 = Mathf.Lerp(0, 0.5, var_292_7)

					arg_289_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_289_1.var_.characterEffect10163ui_story.fillRatio = var_292_8
				end
			end

			if arg_289_1.time_ >= var_292_5 + var_292_6 and arg_289_1.time_ < var_292_5 + var_292_6 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect10163ui_story then
				local var_292_9 = 0.5

				arg_289_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_289_1.var_.characterEffect10163ui_story.fillRatio = var_292_9
			end

			local var_292_10 = 0
			local var_292_11 = 0.375

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_12 = arg_289_1:FormatText(StoryNameCfg[1447].name)

				arg_289_1.leftNameTxt_.text = var_292_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_13 = arg_289_1:GetWordFromCfg(323011069)
				local var_292_14 = arg_289_1:FormatText(var_292_13.content)

				arg_289_1.text_.text = var_292_14

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_15 = 15
				local var_292_16 = utf8.len(var_292_14)
				local var_292_17 = var_292_15 <= 0 and var_292_11 or var_292_11 * (var_292_16 / var_292_15)

				if var_292_17 > 0 and var_292_11 < var_292_17 then
					arg_289_1.talkMaxDuration = var_292_17

					if var_292_17 + var_292_10 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_17 + var_292_10
					end
				end

				arg_289_1.text_.text = var_292_14
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011069", "story_v_out_323011.awb") ~= 0 then
					local var_292_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011069", "story_v_out_323011.awb") / 1000

					if var_292_18 + var_292_10 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_18 + var_292_10
					end

					if var_292_13.prefab_name ~= "" and arg_289_1.actors_[var_292_13.prefab_name] ~= nil then
						local var_292_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_13.prefab_name].transform, "story_v_out_323011", "323011069", "story_v_out_323011.awb")

						arg_289_1:RecordAudio("323011069", var_292_19)
						arg_289_1:RecordAudio("323011069", var_292_19)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_323011", "323011069", "story_v_out_323011.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_323011", "323011069", "story_v_out_323011.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_20 = math.max(var_292_11, arg_289_1.talkMaxDuration)

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_20 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_10) / var_292_20

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_10 + var_292_20 and arg_289_1.time_ < var_292_10 + var_292_20 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play323011070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 323011070
		arg_293_1.duration_ = 15.6

		local var_293_0 = {
			zh = 8.4,
			ja = 15.6
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play323011071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action29_1")
			end

			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_296_2 = 0
			local var_296_3 = 0.975

			if var_296_2 < arg_293_1.time_ and arg_293_1.time_ <= var_296_2 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_4 = arg_293_1:FormatText(StoryNameCfg[1447].name)

				arg_293_1.leftNameTxt_.text = var_296_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_5 = arg_293_1:GetWordFromCfg(323011070)
				local var_296_6 = arg_293_1:FormatText(var_296_5.content)

				arg_293_1.text_.text = var_296_6

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_7 = 39
				local var_296_8 = utf8.len(var_296_6)
				local var_296_9 = var_296_7 <= 0 and var_296_3 or var_296_3 * (var_296_8 / var_296_7)

				if var_296_9 > 0 and var_296_3 < var_296_9 then
					arg_293_1.talkMaxDuration = var_296_9

					if var_296_9 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_9 + var_296_2
					end
				end

				arg_293_1.text_.text = var_296_6
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011070", "story_v_out_323011.awb") ~= 0 then
					local var_296_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011070", "story_v_out_323011.awb") / 1000

					if var_296_10 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_2
					end

					if var_296_5.prefab_name ~= "" and arg_293_1.actors_[var_296_5.prefab_name] ~= nil then
						local var_296_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_5.prefab_name].transform, "story_v_out_323011", "323011070", "story_v_out_323011.awb")

						arg_293_1:RecordAudio("323011070", var_296_11)
						arg_293_1:RecordAudio("323011070", var_296_11)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_323011", "323011070", "story_v_out_323011.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_323011", "323011070", "story_v_out_323011.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_12 = math.max(var_296_3, arg_293_1.talkMaxDuration)

			if var_296_2 <= arg_293_1.time_ and arg_293_1.time_ < var_296_2 + var_296_12 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_2) / var_296_12

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_2 + var_296_12 and arg_293_1.time_ < var_296_2 + var_296_12 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play323011071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 323011071
		arg_297_1.duration_ = 5.7

		local var_297_0 = {
			zh = 4.2,
			ja = 5.7
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play323011072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["10163ui_story"]
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect10163ui_story == nil then
				arg_297_1.var_.characterEffect10163ui_story = var_300_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_2 = 0.200000002980232

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_2 and not isNil(var_300_0) then
				local var_300_3 = (arg_297_1.time_ - var_300_1) / var_300_2

				if arg_297_1.var_.characterEffect10163ui_story and not isNil(var_300_0) then
					arg_297_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= var_300_1 + var_300_2 and arg_297_1.time_ < var_300_1 + var_300_2 + arg_300_0 and not isNil(var_300_0) and arg_297_1.var_.characterEffect10163ui_story then
				arg_297_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_300_4 = arg_297_1.actors_["10167ui_story"]
			local var_300_5 = 0

			if var_300_5 < arg_297_1.time_ and arg_297_1.time_ <= var_300_5 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect10167ui_story == nil then
				arg_297_1.var_.characterEffect10167ui_story = var_300_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_6 = 0.200000002980232

			if var_300_5 <= arg_297_1.time_ and arg_297_1.time_ < var_300_5 + var_300_6 and not isNil(var_300_4) then
				local var_300_7 = (arg_297_1.time_ - var_300_5) / var_300_6

				if arg_297_1.var_.characterEffect10167ui_story and not isNil(var_300_4) then
					local var_300_8 = Mathf.Lerp(0, 0.5, var_300_7)

					arg_297_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_297_1.var_.characterEffect10167ui_story.fillRatio = var_300_8
				end
			end

			if arg_297_1.time_ >= var_300_5 + var_300_6 and arg_297_1.time_ < var_300_5 + var_300_6 + arg_300_0 and not isNil(var_300_4) and arg_297_1.var_.characterEffect10167ui_story then
				local var_300_9 = 0.5

				arg_297_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_297_1.var_.characterEffect10167ui_story.fillRatio = var_300_9
			end

			local var_300_10 = 0

			if var_300_10 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 then
				arg_297_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_300_11 = 0
			local var_300_12 = 0.3

			if var_300_11 < arg_297_1.time_ and arg_297_1.time_ <= var_300_11 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_13 = arg_297_1:FormatText(StoryNameCfg[1444].name)

				arg_297_1.leftNameTxt_.text = var_300_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_14 = arg_297_1:GetWordFromCfg(323011071)
				local var_300_15 = arg_297_1:FormatText(var_300_14.content)

				arg_297_1.text_.text = var_300_15

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_16 = 12
				local var_300_17 = utf8.len(var_300_15)
				local var_300_18 = var_300_16 <= 0 and var_300_12 or var_300_12 * (var_300_17 / var_300_16)

				if var_300_18 > 0 and var_300_12 < var_300_18 then
					arg_297_1.talkMaxDuration = var_300_18

					if var_300_18 + var_300_11 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_18 + var_300_11
					end
				end

				arg_297_1.text_.text = var_300_15
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011071", "story_v_out_323011.awb") ~= 0 then
					local var_300_19 = manager.audio:GetVoiceLength("story_v_out_323011", "323011071", "story_v_out_323011.awb") / 1000

					if var_300_19 + var_300_11 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_19 + var_300_11
					end

					if var_300_14.prefab_name ~= "" and arg_297_1.actors_[var_300_14.prefab_name] ~= nil then
						local var_300_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_14.prefab_name].transform, "story_v_out_323011", "323011071", "story_v_out_323011.awb")

						arg_297_1:RecordAudio("323011071", var_300_20)
						arg_297_1:RecordAudio("323011071", var_300_20)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_323011", "323011071", "story_v_out_323011.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_323011", "323011071", "story_v_out_323011.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_21 = math.max(var_300_12, arg_297_1.talkMaxDuration)

			if var_300_11 <= arg_297_1.time_ and arg_297_1.time_ < var_300_11 + var_300_21 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_11) / var_300_21

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_11 + var_300_21 and arg_297_1.time_ < var_300_11 + var_300_21 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play323011072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 323011072
		arg_301_1.duration_ = 9.93

		local var_301_0 = {
			zh = 5.2,
			ja = 9.933
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play323011073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 0.675

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_2 = arg_301_1:FormatText(StoryNameCfg[1444].name)

				arg_301_1.leftNameTxt_.text = var_304_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_3 = arg_301_1:GetWordFromCfg(323011072)
				local var_304_4 = arg_301_1:FormatText(var_304_3.content)

				arg_301_1.text_.text = var_304_4

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011072", "story_v_out_323011.awb") ~= 0 then
					local var_304_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011072", "story_v_out_323011.awb") / 1000

					if var_304_8 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_0
					end

					if var_304_3.prefab_name ~= "" and arg_301_1.actors_[var_304_3.prefab_name] ~= nil then
						local var_304_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_3.prefab_name].transform, "story_v_out_323011", "323011072", "story_v_out_323011.awb")

						arg_301_1:RecordAudio("323011072", var_304_9)
						arg_301_1:RecordAudio("323011072", var_304_9)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_323011", "323011072", "story_v_out_323011.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_323011", "323011072", "story_v_out_323011.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_10 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_10 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_10

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_10 and arg_301_1.time_ < var_304_0 + var_304_10 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play323011073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 323011073
		arg_305_1.duration_ = 11.53

		local var_305_0 = {
			zh = 7.1,
			ja = 11.533
		}
		local var_305_1 = manager.audio:GetLocalizationFlag()

		if var_305_0[var_305_1] ~= nil then
			arg_305_1.duration_ = var_305_0[var_305_1]
		end

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play323011074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["10167ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect10167ui_story == nil then
				arg_305_1.var_.characterEffect10167ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect10167ui_story and not isNil(var_308_0) then
					arg_305_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect10167ui_story then
				arg_305_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_308_4 = arg_305_1.actors_["10163ui_story"]
			local var_308_5 = 0

			if var_308_5 < arg_305_1.time_ and arg_305_1.time_ <= var_308_5 + arg_308_0 and not isNil(var_308_4) and arg_305_1.var_.characterEffect10163ui_story == nil then
				arg_305_1.var_.characterEffect10163ui_story = var_308_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_6 = 0.200000002980232

			if var_308_5 <= arg_305_1.time_ and arg_305_1.time_ < var_308_5 + var_308_6 and not isNil(var_308_4) then
				local var_308_7 = (arg_305_1.time_ - var_308_5) / var_308_6

				if arg_305_1.var_.characterEffect10163ui_story and not isNil(var_308_4) then
					local var_308_8 = Mathf.Lerp(0, 0.5, var_308_7)

					arg_305_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_305_1.var_.characterEffect10163ui_story.fillRatio = var_308_8
				end
			end

			if arg_305_1.time_ >= var_308_5 + var_308_6 and arg_305_1.time_ < var_308_5 + var_308_6 + arg_308_0 and not isNil(var_308_4) and arg_305_1.var_.characterEffect10163ui_story then
				local var_308_9 = 0.5

				arg_305_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_305_1.var_.characterEffect10163ui_story.fillRatio = var_308_9
			end

			local var_308_10 = 0

			if var_308_10 < arg_305_1.time_ and arg_305_1.time_ <= var_308_10 + arg_308_0 then
				arg_305_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166actionlink/10166action42915")
			end

			local var_308_11 = 0
			local var_308_12 = 0.7

			if var_308_11 < arg_305_1.time_ and arg_305_1.time_ <= var_308_11 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_13 = arg_305_1:FormatText(StoryNameCfg[1447].name)

				arg_305_1.leftNameTxt_.text = var_308_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_14 = arg_305_1:GetWordFromCfg(323011073)
				local var_308_15 = arg_305_1:FormatText(var_308_14.content)

				arg_305_1.text_.text = var_308_15

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_16 = 28
				local var_308_17 = utf8.len(var_308_15)
				local var_308_18 = var_308_16 <= 0 and var_308_12 or var_308_12 * (var_308_17 / var_308_16)

				if var_308_18 > 0 and var_308_12 < var_308_18 then
					arg_305_1.talkMaxDuration = var_308_18

					if var_308_18 + var_308_11 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_18 + var_308_11
					end
				end

				arg_305_1.text_.text = var_308_15
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011073", "story_v_out_323011.awb") ~= 0 then
					local var_308_19 = manager.audio:GetVoiceLength("story_v_out_323011", "323011073", "story_v_out_323011.awb") / 1000

					if var_308_19 + var_308_11 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_19 + var_308_11
					end

					if var_308_14.prefab_name ~= "" and arg_305_1.actors_[var_308_14.prefab_name] ~= nil then
						local var_308_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_14.prefab_name].transform, "story_v_out_323011", "323011073", "story_v_out_323011.awb")

						arg_305_1:RecordAudio("323011073", var_308_20)
						arg_305_1:RecordAudio("323011073", var_308_20)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_323011", "323011073", "story_v_out_323011.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_323011", "323011073", "story_v_out_323011.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_21 = math.max(var_308_12, arg_305_1.talkMaxDuration)

			if var_308_11 <= arg_305_1.time_ and arg_305_1.time_ < var_308_11 + var_308_21 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_11) / var_308_21

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_11 + var_308_21 and arg_305_1.time_ < var_308_11 + var_308_21 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play323011074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 323011074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play323011075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["10167ui_story"]
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect10167ui_story == nil then
				arg_309_1.var_.characterEffect10167ui_story = var_312_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_2 and not isNil(var_312_0) then
				local var_312_3 = (arg_309_1.time_ - var_312_1) / var_312_2

				if arg_309_1.var_.characterEffect10167ui_story and not isNil(var_312_0) then
					local var_312_4 = Mathf.Lerp(0, 0.5, var_312_3)

					arg_309_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_309_1.var_.characterEffect10167ui_story.fillRatio = var_312_4
				end
			end

			if arg_309_1.time_ >= var_312_1 + var_312_2 and arg_309_1.time_ < var_312_1 + var_312_2 + arg_312_0 and not isNil(var_312_0) and arg_309_1.var_.characterEffect10167ui_story then
				local var_312_5 = 0.5

				arg_309_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_309_1.var_.characterEffect10167ui_story.fillRatio = var_312_5
			end

			local var_312_6 = 0
			local var_312_7 = 1.425

			if var_312_6 < arg_309_1.time_ and arg_309_1.time_ <= var_312_6 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_8 = arg_309_1:GetWordFromCfg(323011074)
				local var_312_9 = arg_309_1:FormatText(var_312_8.content)

				arg_309_1.text_.text = var_312_9

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_10 = 57
				local var_312_11 = utf8.len(var_312_9)
				local var_312_12 = var_312_10 <= 0 and var_312_7 or var_312_7 * (var_312_11 / var_312_10)

				if var_312_12 > 0 and var_312_7 < var_312_12 then
					arg_309_1.talkMaxDuration = var_312_12

					if var_312_12 + var_312_6 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_12 + var_312_6
					end
				end

				arg_309_1.text_.text = var_312_9
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_13 = math.max(var_312_7, arg_309_1.talkMaxDuration)

			if var_312_6 <= arg_309_1.time_ and arg_309_1.time_ < var_312_6 + var_312_13 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_6) / var_312_13

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_6 + var_312_13 and arg_309_1.time_ < var_312_6 + var_312_13 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play323011075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 323011075
		arg_313_1.duration_ = 7.2

		local var_313_0 = {
			zh = 7,
			ja = 7.2
		}
		local var_313_1 = manager.audio:GetLocalizationFlag()

		if var_313_0[var_313_1] ~= nil then
			arg_313_1.duration_ = var_313_0[var_313_1]
		end

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play323011076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["10167ui_story"]
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect10167ui_story == nil then
				arg_313_1.var_.characterEffect10167ui_story = var_316_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 and not isNil(var_316_0) then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2

				if arg_313_1.var_.characterEffect10167ui_story and not isNil(var_316_0) then
					arg_313_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 and not isNil(var_316_0) and arg_313_1.var_.characterEffect10167ui_story then
				arg_313_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_316_4 = 0

			if var_316_4 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166actionlink/10166action4158")
			end

			local var_316_5 = 0

			if var_316_5 < arg_313_1.time_ and arg_313_1.time_ <= var_316_5 + arg_316_0 then
				arg_313_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_316_6 = 0
			local var_316_7 = 0.525

			if var_316_6 < arg_313_1.time_ and arg_313_1.time_ <= var_316_6 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_8 = arg_313_1:FormatText(StoryNameCfg[1447].name)

				arg_313_1.leftNameTxt_.text = var_316_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_9 = arg_313_1:GetWordFromCfg(323011075)
				local var_316_10 = arg_313_1:FormatText(var_316_9.content)

				arg_313_1.text_.text = var_316_10

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_11 = 21
				local var_316_12 = utf8.len(var_316_10)
				local var_316_13 = var_316_11 <= 0 and var_316_7 or var_316_7 * (var_316_12 / var_316_11)

				if var_316_13 > 0 and var_316_7 < var_316_13 then
					arg_313_1.talkMaxDuration = var_316_13

					if var_316_13 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_13 + var_316_6
					end
				end

				arg_313_1.text_.text = var_316_10
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011075", "story_v_out_323011.awb") ~= 0 then
					local var_316_14 = manager.audio:GetVoiceLength("story_v_out_323011", "323011075", "story_v_out_323011.awb") / 1000

					if var_316_14 + var_316_6 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_14 + var_316_6
					end

					if var_316_9.prefab_name ~= "" and arg_313_1.actors_[var_316_9.prefab_name] ~= nil then
						local var_316_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_9.prefab_name].transform, "story_v_out_323011", "323011075", "story_v_out_323011.awb")

						arg_313_1:RecordAudio("323011075", var_316_15)
						arg_313_1:RecordAudio("323011075", var_316_15)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_323011", "323011075", "story_v_out_323011.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_323011", "323011075", "story_v_out_323011.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_16 = math.max(var_316_7, arg_313_1.talkMaxDuration)

			if var_316_6 <= arg_313_1.time_ and arg_313_1.time_ < var_316_6 + var_316_16 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_6) / var_316_16

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_6 + var_316_16 and arg_313_1.time_ < var_316_6 + var_316_16 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play323011076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 323011076
		arg_317_1.duration_ = 4.4

		local var_317_0 = {
			zh = 3.766,
			ja = 4.4
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play323011077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["10163ui_story"]
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect10163ui_story == nil then
				arg_317_1.var_.characterEffect10163ui_story = var_320_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 and not isNil(var_320_0) then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2

				if arg_317_1.var_.characterEffect10163ui_story and not isNil(var_320_0) then
					arg_317_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 and not isNil(var_320_0) and arg_317_1.var_.characterEffect10163ui_story then
				arg_317_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_320_4 = arg_317_1.actors_["10167ui_story"]
			local var_320_5 = 0

			if var_320_5 < arg_317_1.time_ and arg_317_1.time_ <= var_320_5 + arg_320_0 and not isNil(var_320_4) and arg_317_1.var_.characterEffect10167ui_story == nil then
				arg_317_1.var_.characterEffect10167ui_story = var_320_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_6 = 0.200000002980232

			if var_320_5 <= arg_317_1.time_ and arg_317_1.time_ < var_320_5 + var_320_6 and not isNil(var_320_4) then
				local var_320_7 = (arg_317_1.time_ - var_320_5) / var_320_6

				if arg_317_1.var_.characterEffect10167ui_story and not isNil(var_320_4) then
					local var_320_8 = Mathf.Lerp(0, 0.5, var_320_7)

					arg_317_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_317_1.var_.characterEffect10167ui_story.fillRatio = var_320_8
				end
			end

			if arg_317_1.time_ >= var_320_5 + var_320_6 and arg_317_1.time_ < var_320_5 + var_320_6 + arg_320_0 and not isNil(var_320_4) and arg_317_1.var_.characterEffect10167ui_story then
				local var_320_9 = 0.5

				arg_317_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_317_1.var_.characterEffect10167ui_story.fillRatio = var_320_9
			end

			local var_320_10 = 0

			if var_320_10 < arg_317_1.time_ and arg_317_1.time_ <= var_320_10 + arg_320_0 then
				arg_317_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_1")
			end

			local var_320_11 = 0
			local var_320_12 = 0.25

			if var_320_11 < arg_317_1.time_ and arg_317_1.time_ <= var_320_11 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_13 = arg_317_1:FormatText(StoryNameCfg[1444].name)

				arg_317_1.leftNameTxt_.text = var_320_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_14 = arg_317_1:GetWordFromCfg(323011076)
				local var_320_15 = arg_317_1:FormatText(var_320_14.content)

				arg_317_1.text_.text = var_320_15

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_16 = 10
				local var_320_17 = utf8.len(var_320_15)
				local var_320_18 = var_320_16 <= 0 and var_320_12 or var_320_12 * (var_320_17 / var_320_16)

				if var_320_18 > 0 and var_320_12 < var_320_18 then
					arg_317_1.talkMaxDuration = var_320_18

					if var_320_18 + var_320_11 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_18 + var_320_11
					end
				end

				arg_317_1.text_.text = var_320_15
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011076", "story_v_out_323011.awb") ~= 0 then
					local var_320_19 = manager.audio:GetVoiceLength("story_v_out_323011", "323011076", "story_v_out_323011.awb") / 1000

					if var_320_19 + var_320_11 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_19 + var_320_11
					end

					if var_320_14.prefab_name ~= "" and arg_317_1.actors_[var_320_14.prefab_name] ~= nil then
						local var_320_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_14.prefab_name].transform, "story_v_out_323011", "323011076", "story_v_out_323011.awb")

						arg_317_1:RecordAudio("323011076", var_320_20)
						arg_317_1:RecordAudio("323011076", var_320_20)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_323011", "323011076", "story_v_out_323011.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_323011", "323011076", "story_v_out_323011.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_21 = math.max(var_320_12, arg_317_1.talkMaxDuration)

			if var_320_11 <= arg_317_1.time_ and arg_317_1.time_ < var_320_11 + var_320_21 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_11) / var_320_21

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_11 + var_320_21 and arg_317_1.time_ < var_320_11 + var_320_21 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play323011077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 323011077
		arg_321_1.duration_ = 9.6

		local var_321_0 = {
			zh = 6.733,
			ja = 9.6
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play323011078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.575

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[1444].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_3 = arg_321_1:GetWordFromCfg(323011077)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 23
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011077", "story_v_out_323011.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011077", "story_v_out_323011.awb") / 1000

					if var_324_8 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_0
					end

					if var_324_3.prefab_name ~= "" and arg_321_1.actors_[var_324_3.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_3.prefab_name].transform, "story_v_out_323011", "323011077", "story_v_out_323011.awb")

						arg_321_1:RecordAudio("323011077", var_324_9)
						arg_321_1:RecordAudio("323011077", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_323011", "323011077", "story_v_out_323011.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_323011", "323011077", "story_v_out_323011.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_10 and arg_321_1.time_ < var_324_0 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play323011078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 323011078
		arg_325_1.duration_ = 2

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play323011079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["10167ui_story"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect10167ui_story == nil then
				arg_325_1.var_.characterEffect10167ui_story = var_328_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.characterEffect10167ui_story and not isNil(var_328_0) then
					arg_325_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.characterEffect10167ui_story then
				arg_325_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_328_4 = arg_325_1.actors_["10163ui_story"]
			local var_328_5 = 0

			if var_328_5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect10163ui_story == nil then
				arg_325_1.var_.characterEffect10163ui_story = var_328_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_6 = 0.200000002980232

			if var_328_5 <= arg_325_1.time_ and arg_325_1.time_ < var_328_5 + var_328_6 and not isNil(var_328_4) then
				local var_328_7 = (arg_325_1.time_ - var_328_5) / var_328_6

				if arg_325_1.var_.characterEffect10163ui_story and not isNil(var_328_4) then
					local var_328_8 = Mathf.Lerp(0, 0.5, var_328_7)

					arg_325_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_325_1.var_.characterEffect10163ui_story.fillRatio = var_328_8
				end
			end

			if arg_325_1.time_ >= var_328_5 + var_328_6 and arg_325_1.time_ < var_328_5 + var_328_6 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect10163ui_story then
				local var_328_9 = 0.5

				arg_325_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_325_1.var_.characterEffect10163ui_story.fillRatio = var_328_9
			end

			local var_328_10 = 0

			if var_328_10 < arg_325_1.time_ and arg_325_1.time_ <= var_328_10 + arg_328_0 then
				arg_325_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_328_11 = 0
			local var_328_12 = 0.05

			if var_328_11 < arg_325_1.time_ and arg_325_1.time_ <= var_328_11 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_13 = arg_325_1:FormatText(StoryNameCfg[1447].name)

				arg_325_1.leftNameTxt_.text = var_328_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_14 = arg_325_1:GetWordFromCfg(323011078)
				local var_328_15 = arg_325_1:FormatText(var_328_14.content)

				arg_325_1.text_.text = var_328_15

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_16 = 2
				local var_328_17 = utf8.len(var_328_15)
				local var_328_18 = var_328_16 <= 0 and var_328_12 or var_328_12 * (var_328_17 / var_328_16)

				if var_328_18 > 0 and var_328_12 < var_328_18 then
					arg_325_1.talkMaxDuration = var_328_18

					if var_328_18 + var_328_11 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_18 + var_328_11
					end
				end

				arg_325_1.text_.text = var_328_15
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011078", "story_v_out_323011.awb") ~= 0 then
					local var_328_19 = manager.audio:GetVoiceLength("story_v_out_323011", "323011078", "story_v_out_323011.awb") / 1000

					if var_328_19 + var_328_11 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_19 + var_328_11
					end

					if var_328_14.prefab_name ~= "" and arg_325_1.actors_[var_328_14.prefab_name] ~= nil then
						local var_328_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_14.prefab_name].transform, "story_v_out_323011", "323011078", "story_v_out_323011.awb")

						arg_325_1:RecordAudio("323011078", var_328_20)
						arg_325_1:RecordAudio("323011078", var_328_20)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_323011", "323011078", "story_v_out_323011.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_323011", "323011078", "story_v_out_323011.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_21 = math.max(var_328_12, arg_325_1.talkMaxDuration)

			if var_328_11 <= arg_325_1.time_ and arg_325_1.time_ < var_328_11 + var_328_21 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_11) / var_328_21

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_11 + var_328_21 and arg_325_1.time_ < var_328_11 + var_328_21 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play323011079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 323011079
		arg_329_1.duration_ = 6.9

		local var_329_0 = {
			zh = 3.7,
			ja = 6.9
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play323011080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["10163ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect10163ui_story == nil then
				arg_329_1.var_.characterEffect10163ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect10163ui_story and not isNil(var_332_0) then
					arg_329_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect10163ui_story then
				arg_329_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_332_4 = arg_329_1.actors_["10167ui_story"]
			local var_332_5 = 0

			if var_332_5 < arg_329_1.time_ and arg_329_1.time_ <= var_332_5 + arg_332_0 and not isNil(var_332_4) and arg_329_1.var_.characterEffect10167ui_story == nil then
				arg_329_1.var_.characterEffect10167ui_story = var_332_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_6 = 0.200000002980232

			if var_332_5 <= arg_329_1.time_ and arg_329_1.time_ < var_332_5 + var_332_6 and not isNil(var_332_4) then
				local var_332_7 = (arg_329_1.time_ - var_332_5) / var_332_6

				if arg_329_1.var_.characterEffect10167ui_story and not isNil(var_332_4) then
					local var_332_8 = Mathf.Lerp(0, 0.5, var_332_7)

					arg_329_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_329_1.var_.characterEffect10167ui_story.fillRatio = var_332_8
				end
			end

			if arg_329_1.time_ >= var_332_5 + var_332_6 and arg_329_1.time_ < var_332_5 + var_332_6 + arg_332_0 and not isNil(var_332_4) and arg_329_1.var_.characterEffect10167ui_story then
				local var_332_9 = 0.5

				arg_329_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_329_1.var_.characterEffect10167ui_story.fillRatio = var_332_9
			end

			local var_332_10 = 0

			if var_332_10 < arg_329_1.time_ and arg_329_1.time_ <= var_332_10 + arg_332_0 then
				arg_329_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_2")
			end

			local var_332_11 = 0

			if var_332_11 < arg_329_1.time_ and arg_329_1.time_ <= var_332_11 + arg_332_0 then
				arg_329_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_332_12 = 0
			local var_332_13 = 0.3

			if var_332_12 < arg_329_1.time_ and arg_329_1.time_ <= var_332_12 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_14 = arg_329_1:FormatText(StoryNameCfg[1444].name)

				arg_329_1.leftNameTxt_.text = var_332_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_15 = arg_329_1:GetWordFromCfg(323011079)
				local var_332_16 = arg_329_1:FormatText(var_332_15.content)

				arg_329_1.text_.text = var_332_16

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_17 = 12
				local var_332_18 = utf8.len(var_332_16)
				local var_332_19 = var_332_17 <= 0 and var_332_13 or var_332_13 * (var_332_18 / var_332_17)

				if var_332_19 > 0 and var_332_13 < var_332_19 then
					arg_329_1.talkMaxDuration = var_332_19

					if var_332_19 + var_332_12 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_19 + var_332_12
					end
				end

				arg_329_1.text_.text = var_332_16
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011079", "story_v_out_323011.awb") ~= 0 then
					local var_332_20 = manager.audio:GetVoiceLength("story_v_out_323011", "323011079", "story_v_out_323011.awb") / 1000

					if var_332_20 + var_332_12 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_20 + var_332_12
					end

					if var_332_15.prefab_name ~= "" and arg_329_1.actors_[var_332_15.prefab_name] ~= nil then
						local var_332_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_15.prefab_name].transform, "story_v_out_323011", "323011079", "story_v_out_323011.awb")

						arg_329_1:RecordAudio("323011079", var_332_21)
						arg_329_1:RecordAudio("323011079", var_332_21)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_323011", "323011079", "story_v_out_323011.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_323011", "323011079", "story_v_out_323011.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_22 = math.max(var_332_13, arg_329_1.talkMaxDuration)

			if var_332_12 <= arg_329_1.time_ and arg_329_1.time_ < var_332_12 + var_332_22 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_12) / var_332_22

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_12 + var_332_22 and arg_329_1.time_ < var_332_12 + var_332_22 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play323011080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 323011080
		arg_333_1.duration_ = 4.67

		local var_333_0 = {
			zh = 2.866,
			ja = 4.666
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play323011081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["10167ui_story"]
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect10167ui_story == nil then
				arg_333_1.var_.characterEffect10167ui_story = var_336_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_2 = 0.200000002980232

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 and not isNil(var_336_0) then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2

				if arg_333_1.var_.characterEffect10167ui_story and not isNil(var_336_0) then
					arg_333_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 and not isNil(var_336_0) and arg_333_1.var_.characterEffect10167ui_story then
				arg_333_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_336_4 = arg_333_1.actors_["10163ui_story"]
			local var_336_5 = 0

			if var_336_5 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 and not isNil(var_336_4) and arg_333_1.var_.characterEffect10163ui_story == nil then
				arg_333_1.var_.characterEffect10163ui_story = var_336_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_6 = 0.200000002980232

			if var_336_5 <= arg_333_1.time_ and arg_333_1.time_ < var_336_5 + var_336_6 and not isNil(var_336_4) then
				local var_336_7 = (arg_333_1.time_ - var_336_5) / var_336_6

				if arg_333_1.var_.characterEffect10163ui_story and not isNil(var_336_4) then
					local var_336_8 = Mathf.Lerp(0, 0.5, var_336_7)

					arg_333_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_333_1.var_.characterEffect10163ui_story.fillRatio = var_336_8
				end
			end

			if arg_333_1.time_ >= var_336_5 + var_336_6 and arg_333_1.time_ < var_336_5 + var_336_6 + arg_336_0 and not isNil(var_336_4) and arg_333_1.var_.characterEffect10163ui_story then
				local var_336_9 = 0.5

				arg_333_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_333_1.var_.characterEffect10163ui_story.fillRatio = var_336_9
			end

			local var_336_10 = 0

			if var_336_10 < arg_333_1.time_ and arg_333_1.time_ <= var_336_10 + arg_336_0 then
				arg_333_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_2")
			end

			local var_336_11 = 0
			local var_336_12 = 0.225

			if var_336_11 < arg_333_1.time_ and arg_333_1.time_ <= var_336_11 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_13 = arg_333_1:FormatText(StoryNameCfg[1447].name)

				arg_333_1.leftNameTxt_.text = var_336_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_14 = arg_333_1:GetWordFromCfg(323011080)
				local var_336_15 = arg_333_1:FormatText(var_336_14.content)

				arg_333_1.text_.text = var_336_15

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_16 = 9
				local var_336_17 = utf8.len(var_336_15)
				local var_336_18 = var_336_16 <= 0 and var_336_12 or var_336_12 * (var_336_17 / var_336_16)

				if var_336_18 > 0 and var_336_12 < var_336_18 then
					arg_333_1.talkMaxDuration = var_336_18

					if var_336_18 + var_336_11 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_18 + var_336_11
					end
				end

				arg_333_1.text_.text = var_336_15
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011080", "story_v_out_323011.awb") ~= 0 then
					local var_336_19 = manager.audio:GetVoiceLength("story_v_out_323011", "323011080", "story_v_out_323011.awb") / 1000

					if var_336_19 + var_336_11 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_19 + var_336_11
					end

					if var_336_14.prefab_name ~= "" and arg_333_1.actors_[var_336_14.prefab_name] ~= nil then
						local var_336_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_14.prefab_name].transform, "story_v_out_323011", "323011080", "story_v_out_323011.awb")

						arg_333_1:RecordAudio("323011080", var_336_20)
						arg_333_1:RecordAudio("323011080", var_336_20)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_323011", "323011080", "story_v_out_323011.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_323011", "323011080", "story_v_out_323011.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_21 = math.max(var_336_12, arg_333_1.talkMaxDuration)

			if var_336_11 <= arg_333_1.time_ and arg_333_1.time_ < var_336_11 + var_336_21 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_11) / var_336_21

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_11 + var_336_21 and arg_333_1.time_ < var_336_11 + var_336_21 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play323011081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 323011081
		arg_337_1.duration_ = 4.63

		local var_337_0 = {
			zh = 3.7,
			ja = 4.633
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play323011082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 0.3

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[1447].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_3 = arg_337_1:GetWordFromCfg(323011081)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 12
				local var_340_6 = utf8.len(var_340_4)
				local var_340_7 = var_340_5 <= 0 and var_340_1 or var_340_1 * (var_340_6 / var_340_5)

				if var_340_7 > 0 and var_340_1 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011081", "story_v_out_323011.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011081", "story_v_out_323011.awb") / 1000

					if var_340_8 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_0
					end

					if var_340_3.prefab_name ~= "" and arg_337_1.actors_[var_340_3.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_3.prefab_name].transform, "story_v_out_323011", "323011081", "story_v_out_323011.awb")

						arg_337_1:RecordAudio("323011081", var_340_9)
						arg_337_1:RecordAudio("323011081", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_323011", "323011081", "story_v_out_323011.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_323011", "323011081", "story_v_out_323011.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_10 and arg_337_1.time_ < var_340_0 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play323011082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 323011082
		arg_341_1.duration_ = 4.1

		local var_341_0 = {
			zh = 2.566,
			ja = 4.1
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play323011083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["10163ui_story"]
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect10163ui_story == nil then
				arg_341_1.var_.characterEffect10163ui_story = var_344_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 and not isNil(var_344_0) then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2

				if arg_341_1.var_.characterEffect10163ui_story and not isNil(var_344_0) then
					arg_341_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 and not isNil(var_344_0) and arg_341_1.var_.characterEffect10163ui_story then
				arg_341_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_344_4 = arg_341_1.actors_["10167ui_story"]
			local var_344_5 = 0

			if var_344_5 < arg_341_1.time_ and arg_341_1.time_ <= var_344_5 + arg_344_0 and not isNil(var_344_4) and arg_341_1.var_.characterEffect10167ui_story == nil then
				arg_341_1.var_.characterEffect10167ui_story = var_344_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_6 = 0.200000002980232

			if var_344_5 <= arg_341_1.time_ and arg_341_1.time_ < var_344_5 + var_344_6 and not isNil(var_344_4) then
				local var_344_7 = (arg_341_1.time_ - var_344_5) / var_344_6

				if arg_341_1.var_.characterEffect10167ui_story and not isNil(var_344_4) then
					local var_344_8 = Mathf.Lerp(0, 0.5, var_344_7)

					arg_341_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_341_1.var_.characterEffect10167ui_story.fillRatio = var_344_8
				end
			end

			if arg_341_1.time_ >= var_344_5 + var_344_6 and arg_341_1.time_ < var_344_5 + var_344_6 + arg_344_0 and not isNil(var_344_4) and arg_341_1.var_.characterEffect10167ui_story then
				local var_344_9 = 0.5

				arg_341_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_341_1.var_.characterEffect10167ui_story.fillRatio = var_344_9
			end

			local var_344_10 = 0
			local var_344_11 = 0.175

			if var_344_10 < arg_341_1.time_ and arg_341_1.time_ <= var_344_10 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_12 = arg_341_1:FormatText(StoryNameCfg[1444].name)

				arg_341_1.leftNameTxt_.text = var_344_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_13 = arg_341_1:GetWordFromCfg(323011082)
				local var_344_14 = arg_341_1:FormatText(var_344_13.content)

				arg_341_1.text_.text = var_344_14

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_15 = 7
				local var_344_16 = utf8.len(var_344_14)
				local var_344_17 = var_344_15 <= 0 and var_344_11 or var_344_11 * (var_344_16 / var_344_15)

				if var_344_17 > 0 and var_344_11 < var_344_17 then
					arg_341_1.talkMaxDuration = var_344_17

					if var_344_17 + var_344_10 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_17 + var_344_10
					end
				end

				arg_341_1.text_.text = var_344_14
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011082", "story_v_out_323011.awb") ~= 0 then
					local var_344_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011082", "story_v_out_323011.awb") / 1000

					if var_344_18 + var_344_10 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_18 + var_344_10
					end

					if var_344_13.prefab_name ~= "" and arg_341_1.actors_[var_344_13.prefab_name] ~= nil then
						local var_344_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_13.prefab_name].transform, "story_v_out_323011", "323011082", "story_v_out_323011.awb")

						arg_341_1:RecordAudio("323011082", var_344_19)
						arg_341_1:RecordAudio("323011082", var_344_19)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_323011", "323011082", "story_v_out_323011.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_323011", "323011082", "story_v_out_323011.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_20 = math.max(var_344_11, arg_341_1.talkMaxDuration)

			if var_344_10 <= arg_341_1.time_ and arg_341_1.time_ < var_344_10 + var_344_20 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_10) / var_344_20

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_10 + var_344_20 and arg_341_1.time_ < var_344_10 + var_344_20 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play323011083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 323011083
		arg_345_1.duration_ = 7.57

		local var_345_0 = {
			zh = 5.766,
			ja = 7.566
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play323011084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["10167ui_story"]
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect10167ui_story == nil then
				arg_345_1.var_.characterEffect10167ui_story = var_348_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_2 and not isNil(var_348_0) then
				local var_348_3 = (arg_345_1.time_ - var_348_1) / var_348_2

				if arg_345_1.var_.characterEffect10167ui_story and not isNil(var_348_0) then
					arg_345_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= var_348_1 + var_348_2 and arg_345_1.time_ < var_348_1 + var_348_2 + arg_348_0 and not isNil(var_348_0) and arg_345_1.var_.characterEffect10167ui_story then
				arg_345_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_348_4 = arg_345_1.actors_["10163ui_story"]
			local var_348_5 = 0

			if var_348_5 < arg_345_1.time_ and arg_345_1.time_ <= var_348_5 + arg_348_0 and not isNil(var_348_4) and arg_345_1.var_.characterEffect10163ui_story == nil then
				arg_345_1.var_.characterEffect10163ui_story = var_348_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_6 = 0.200000002980232

			if var_348_5 <= arg_345_1.time_ and arg_345_1.time_ < var_348_5 + var_348_6 and not isNil(var_348_4) then
				local var_348_7 = (arg_345_1.time_ - var_348_5) / var_348_6

				if arg_345_1.var_.characterEffect10163ui_story and not isNil(var_348_4) then
					local var_348_8 = Mathf.Lerp(0, 0.5, var_348_7)

					arg_345_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_345_1.var_.characterEffect10163ui_story.fillRatio = var_348_8
				end
			end

			if arg_345_1.time_ >= var_348_5 + var_348_6 and arg_345_1.time_ < var_348_5 + var_348_6 + arg_348_0 and not isNil(var_348_4) and arg_345_1.var_.characterEffect10163ui_story then
				local var_348_9 = 0.5

				arg_345_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_345_1.var_.characterEffect10163ui_story.fillRatio = var_348_9
			end

			local var_348_10 = 0
			local var_348_11 = 0.55

			if var_348_10 < arg_345_1.time_ and arg_345_1.time_ <= var_348_10 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				local var_348_12 = arg_345_1:FormatText(StoryNameCfg[1447].name)

				arg_345_1.leftNameTxt_.text = var_348_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_13 = arg_345_1:GetWordFromCfg(323011083)
				local var_348_14 = arg_345_1:FormatText(var_348_13.content)

				arg_345_1.text_.text = var_348_14

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_15 = 22
				local var_348_16 = utf8.len(var_348_14)
				local var_348_17 = var_348_15 <= 0 and var_348_11 or var_348_11 * (var_348_16 / var_348_15)

				if var_348_17 > 0 and var_348_11 < var_348_17 then
					arg_345_1.talkMaxDuration = var_348_17

					if var_348_17 + var_348_10 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_17 + var_348_10
					end
				end

				arg_345_1.text_.text = var_348_14
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011083", "story_v_out_323011.awb") ~= 0 then
					local var_348_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011083", "story_v_out_323011.awb") / 1000

					if var_348_18 + var_348_10 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_18 + var_348_10
					end

					if var_348_13.prefab_name ~= "" and arg_345_1.actors_[var_348_13.prefab_name] ~= nil then
						local var_348_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_13.prefab_name].transform, "story_v_out_323011", "323011083", "story_v_out_323011.awb")

						arg_345_1:RecordAudio("323011083", var_348_19)
						arg_345_1:RecordAudio("323011083", var_348_19)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_323011", "323011083", "story_v_out_323011.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_323011", "323011083", "story_v_out_323011.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_20 = math.max(var_348_11, arg_345_1.talkMaxDuration)

			if var_348_10 <= arg_345_1.time_ and arg_345_1.time_ < var_348_10 + var_348_20 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_10) / var_348_20

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_10 + var_348_20 and arg_345_1.time_ < var_348_10 + var_348_20 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play323011084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 323011084
		arg_349_1.duration_ = 4.43

		local var_349_0 = {
			zh = 4.433,
			ja = 4.166
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play323011085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["10163ui_story"]
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect10163ui_story == nil then
				arg_349_1.var_.characterEffect10163ui_story = var_352_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 and not isNil(var_352_0) then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2

				if arg_349_1.var_.characterEffect10163ui_story and not isNil(var_352_0) then
					arg_349_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 and not isNil(var_352_0) and arg_349_1.var_.characterEffect10163ui_story then
				arg_349_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_352_4 = arg_349_1.actors_["10167ui_story"]
			local var_352_5 = 0

			if var_352_5 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 and not isNil(var_352_4) and arg_349_1.var_.characterEffect10167ui_story == nil then
				arg_349_1.var_.characterEffect10167ui_story = var_352_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_6 = 0.200000002980232

			if var_352_5 <= arg_349_1.time_ and arg_349_1.time_ < var_352_5 + var_352_6 and not isNil(var_352_4) then
				local var_352_7 = (arg_349_1.time_ - var_352_5) / var_352_6

				if arg_349_1.var_.characterEffect10167ui_story and not isNil(var_352_4) then
					local var_352_8 = Mathf.Lerp(0, 0.5, var_352_7)

					arg_349_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_349_1.var_.characterEffect10167ui_story.fillRatio = var_352_8
				end
			end

			if arg_349_1.time_ >= var_352_5 + var_352_6 and arg_349_1.time_ < var_352_5 + var_352_6 + arg_352_0 and not isNil(var_352_4) and arg_349_1.var_.characterEffect10167ui_story then
				local var_352_9 = 0.5

				arg_349_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_349_1.var_.characterEffect10167ui_story.fillRatio = var_352_9
			end

			local var_352_10 = 0
			local var_352_11 = 0.275

			if var_352_10 < arg_349_1.time_ and arg_349_1.time_ <= var_352_10 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_12 = arg_349_1:FormatText(StoryNameCfg[1444].name)

				arg_349_1.leftNameTxt_.text = var_352_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_13 = arg_349_1:GetWordFromCfg(323011084)
				local var_352_14 = arg_349_1:FormatText(var_352_13.content)

				arg_349_1.text_.text = var_352_14

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_15 = 11
				local var_352_16 = utf8.len(var_352_14)
				local var_352_17 = var_352_15 <= 0 and var_352_11 or var_352_11 * (var_352_16 / var_352_15)

				if var_352_17 > 0 and var_352_11 < var_352_17 then
					arg_349_1.talkMaxDuration = var_352_17

					if var_352_17 + var_352_10 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_17 + var_352_10
					end
				end

				arg_349_1.text_.text = var_352_14
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011084", "story_v_out_323011.awb") ~= 0 then
					local var_352_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011084", "story_v_out_323011.awb") / 1000

					if var_352_18 + var_352_10 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_18 + var_352_10
					end

					if var_352_13.prefab_name ~= "" and arg_349_1.actors_[var_352_13.prefab_name] ~= nil then
						local var_352_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_13.prefab_name].transform, "story_v_out_323011", "323011084", "story_v_out_323011.awb")

						arg_349_1:RecordAudio("323011084", var_352_19)
						arg_349_1:RecordAudio("323011084", var_352_19)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_323011", "323011084", "story_v_out_323011.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_323011", "323011084", "story_v_out_323011.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_20 = math.max(var_352_11, arg_349_1.talkMaxDuration)

			if var_352_10 <= arg_349_1.time_ and arg_349_1.time_ < var_352_10 + var_352_20 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_10) / var_352_20

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_10 + var_352_20 and arg_349_1.time_ < var_352_10 + var_352_20 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play323011085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 323011085
		arg_353_1.duration_ = 9.07

		local var_353_0 = {
			zh = 7,
			ja = 9.066
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play323011086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["10167ui_story"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect10167ui_story == nil then
				arg_353_1.var_.characterEffect10167ui_story = var_356_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.characterEffect10167ui_story and not isNil(var_356_0) then
					arg_353_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.characterEffect10167ui_story then
				arg_353_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_356_4 = arg_353_1.actors_["10163ui_story"]
			local var_356_5 = 0

			if var_356_5 < arg_353_1.time_ and arg_353_1.time_ <= var_356_5 + arg_356_0 and not isNil(var_356_4) and arg_353_1.var_.characterEffect10163ui_story == nil then
				arg_353_1.var_.characterEffect10163ui_story = var_356_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_6 = 0.200000002980232

			if var_356_5 <= arg_353_1.time_ and arg_353_1.time_ < var_356_5 + var_356_6 and not isNil(var_356_4) then
				local var_356_7 = (arg_353_1.time_ - var_356_5) / var_356_6

				if arg_353_1.var_.characterEffect10163ui_story and not isNil(var_356_4) then
					local var_356_8 = Mathf.Lerp(0, 0.5, var_356_7)

					arg_353_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_353_1.var_.characterEffect10163ui_story.fillRatio = var_356_8
				end
			end

			if arg_353_1.time_ >= var_356_5 + var_356_6 and arg_353_1.time_ < var_356_5 + var_356_6 + arg_356_0 and not isNil(var_356_4) and arg_353_1.var_.characterEffect10163ui_story then
				local var_356_9 = 0.5

				arg_353_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_353_1.var_.characterEffect10163ui_story.fillRatio = var_356_9
			end

			local var_356_10 = 0

			if var_356_10 < arg_353_1.time_ and arg_353_1.time_ <= var_356_10 + arg_356_0 then
				arg_353_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action12_1")
			end

			local var_356_11 = 0
			local var_356_12 = 0.75

			if var_356_11 < arg_353_1.time_ and arg_353_1.time_ <= var_356_11 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_13 = arg_353_1:FormatText(StoryNameCfg[1447].name)

				arg_353_1.leftNameTxt_.text = var_356_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_14 = arg_353_1:GetWordFromCfg(323011085)
				local var_356_15 = arg_353_1:FormatText(var_356_14.content)

				arg_353_1.text_.text = var_356_15

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_16 = 30
				local var_356_17 = utf8.len(var_356_15)
				local var_356_18 = var_356_16 <= 0 and var_356_12 or var_356_12 * (var_356_17 / var_356_16)

				if var_356_18 > 0 and var_356_12 < var_356_18 then
					arg_353_1.talkMaxDuration = var_356_18

					if var_356_18 + var_356_11 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_18 + var_356_11
					end
				end

				arg_353_1.text_.text = var_356_15
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011085", "story_v_out_323011.awb") ~= 0 then
					local var_356_19 = manager.audio:GetVoiceLength("story_v_out_323011", "323011085", "story_v_out_323011.awb") / 1000

					if var_356_19 + var_356_11 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_19 + var_356_11
					end

					if var_356_14.prefab_name ~= "" and arg_353_1.actors_[var_356_14.prefab_name] ~= nil then
						local var_356_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_14.prefab_name].transform, "story_v_out_323011", "323011085", "story_v_out_323011.awb")

						arg_353_1:RecordAudio("323011085", var_356_20)
						arg_353_1:RecordAudio("323011085", var_356_20)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_323011", "323011085", "story_v_out_323011.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_323011", "323011085", "story_v_out_323011.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_21 = math.max(var_356_12, arg_353_1.talkMaxDuration)

			if var_356_11 <= arg_353_1.time_ and arg_353_1.time_ < var_356_11 + var_356_21 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_11) / var_356_21

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_11 + var_356_21 and arg_353_1.time_ < var_356_11 + var_356_21 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play323011086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 323011086
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play323011087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["10167ui_story"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos10167ui_story = var_360_0.localPosition

				local var_360_2 = GameObjectTools.GetOrAddComponent(var_360_0.gameObject, typeof(DynamicBoneHelper))

				if var_360_2 then
					var_360_2:EnableDynamicBone(false)
				end
			end

			local var_360_3 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_3 then
				local var_360_4 = (arg_357_1.time_ - var_360_1) / var_360_3
				local var_360_5 = Vector3.New(0, 100, 0)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10167ui_story, var_360_5, var_360_4)

				local var_360_6 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_6.x, var_360_6.y, var_360_6.z)

				local var_360_7 = var_360_0.localEulerAngles

				var_360_7.z = 0
				var_360_7.x = 0
				var_360_0.localEulerAngles = var_360_7
			end

			if arg_357_1.time_ >= var_360_1 + var_360_3 and arg_357_1.time_ < var_360_1 + var_360_3 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0, 100, 0)

				local var_360_8 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_8.x, var_360_8.y, var_360_8.z)

				local var_360_9 = var_360_0.localEulerAngles

				var_360_9.z = 0
				var_360_9.x = 0
				var_360_0.localEulerAngles = var_360_9

				local var_360_10 = GameObjectTools.GetOrAddComponent(var_360_0.gameObject, typeof(DynamicBoneHelper))

				if var_360_10 then
					var_360_10:EnableDynamicBone(true)
				end
			end

			local var_360_11 = arg_357_1.actors_["10163ui_story"].transform
			local var_360_12 = 0

			if var_360_12 < arg_357_1.time_ and arg_357_1.time_ <= var_360_12 + arg_360_0 then
				arg_357_1.var_.moveOldPos10163ui_story = var_360_11.localPosition

				local var_360_13 = GameObjectTools.GetOrAddComponent(var_360_11.gameObject, typeof(DynamicBoneHelper))

				if var_360_13 then
					var_360_13:EnableDynamicBone(false)
				end
			end

			local var_360_14 = 0.001

			if var_360_12 <= arg_357_1.time_ and arg_357_1.time_ < var_360_12 + var_360_14 then
				local var_360_15 = (arg_357_1.time_ - var_360_12) / var_360_14
				local var_360_16 = Vector3.New(0, 100, 0)

				var_360_11.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10163ui_story, var_360_16, var_360_15)

				local var_360_17 = manager.ui.mainCamera.transform.position - var_360_11.position

				var_360_11.forward = Vector3.New(var_360_17.x, var_360_17.y, var_360_17.z)

				local var_360_18 = var_360_11.localEulerAngles

				var_360_18.z = 0
				var_360_18.x = 0
				var_360_11.localEulerAngles = var_360_18
			end

			if arg_357_1.time_ >= var_360_12 + var_360_14 and arg_357_1.time_ < var_360_12 + var_360_14 + arg_360_0 then
				var_360_11.localPosition = Vector3.New(0, 100, 0)

				local var_360_19 = manager.ui.mainCamera.transform.position - var_360_11.position

				var_360_11.forward = Vector3.New(var_360_19.x, var_360_19.y, var_360_19.z)

				local var_360_20 = var_360_11.localEulerAngles

				var_360_20.z = 0
				var_360_20.x = 0
				var_360_11.localEulerAngles = var_360_20

				local var_360_21 = GameObjectTools.GetOrAddComponent(var_360_11.gameObject, typeof(DynamicBoneHelper))

				if var_360_21 then
					var_360_21:EnableDynamicBone(true)
				end
			end

			local var_360_22 = arg_357_1.actors_["10167ui_story"]
			local var_360_23 = 0

			if var_360_23 < arg_357_1.time_ and arg_357_1.time_ <= var_360_23 + arg_360_0 and not isNil(var_360_22) and arg_357_1.var_.characterEffect10167ui_story == nil then
				arg_357_1.var_.characterEffect10167ui_story = var_360_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_24 = 0.200000002980232

			if var_360_23 <= arg_357_1.time_ and arg_357_1.time_ < var_360_23 + var_360_24 and not isNil(var_360_22) then
				local var_360_25 = (arg_357_1.time_ - var_360_23) / var_360_24

				if arg_357_1.var_.characterEffect10167ui_story and not isNil(var_360_22) then
					local var_360_26 = Mathf.Lerp(0, 0.5, var_360_25)

					arg_357_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_357_1.var_.characterEffect10167ui_story.fillRatio = var_360_26
				end
			end

			if arg_357_1.time_ >= var_360_23 + var_360_24 and arg_357_1.time_ < var_360_23 + var_360_24 + arg_360_0 and not isNil(var_360_22) and arg_357_1.var_.characterEffect10167ui_story then
				local var_360_27 = 0.5

				arg_357_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_357_1.var_.characterEffect10167ui_story.fillRatio = var_360_27
			end

			local var_360_28 = 0
			local var_360_29 = 0.75

			if var_360_28 < arg_357_1.time_ and arg_357_1.time_ <= var_360_28 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_30 = arg_357_1:GetWordFromCfg(323011086)
				local var_360_31 = arg_357_1:FormatText(var_360_30.content)

				arg_357_1.text_.text = var_360_31

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_32 = 30
				local var_360_33 = utf8.len(var_360_31)
				local var_360_34 = var_360_32 <= 0 and var_360_29 or var_360_29 * (var_360_33 / var_360_32)

				if var_360_34 > 0 and var_360_29 < var_360_34 then
					arg_357_1.talkMaxDuration = var_360_34

					if var_360_34 + var_360_28 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_34 + var_360_28
					end
				end

				arg_357_1.text_.text = var_360_31
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_35 = math.max(var_360_29, arg_357_1.talkMaxDuration)

			if var_360_28 <= arg_357_1.time_ and arg_357_1.time_ < var_360_28 + var_360_35 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_28) / var_360_35

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_28 + var_360_35 and arg_357_1.time_ < var_360_28 + var_360_35 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10167ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10163ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_357_1:InitPlayNodeList()
	end,
	Play323011087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 323011087
		arg_361_1.duration_ = 6.43

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play323011088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 1.43333333333333

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				local var_364_1 = manager.ui.mainCamera.transform.localPosition
				local var_364_2 = Vector3.New(0, 0, 10) + Vector3.New(var_364_1.x, var_364_1.y, 0)
				local var_364_3 = arg_361_1.bgs_.STblack

				var_364_3.transform.localPosition = var_364_2
				var_364_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_364_4 = var_364_3:GetComponent("SpriteRenderer")

				if var_364_4 and var_364_4.sprite then
					local var_364_5 = (var_364_3.transform.localPosition - var_364_1).z
					local var_364_6 = manager.ui.mainCameraCom_
					local var_364_7 = 2 * var_364_5 * Mathf.Tan(var_364_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_364_8 = var_364_7 * var_364_6.aspect
					local var_364_9 = var_364_4.sprite.bounds.size.x
					local var_364_10 = var_364_4.sprite.bounds.size.y
					local var_364_11 = var_364_8 / var_364_9
					local var_364_12 = var_364_7 / var_364_10
					local var_364_13 = var_364_12 < var_364_11 and var_364_11 or var_364_12

					var_364_3.transform.localScale = Vector3.New(var_364_13, var_364_13, 0)
				end

				for iter_364_0, iter_364_1 in pairs(arg_361_1.bgs_) do
					if iter_364_0 ~= "STblack" then
						iter_364_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_364_14 = 1.43333333333333

			if var_364_14 < arg_361_1.time_ and arg_361_1.time_ <= var_364_14 + arg_364_0 then
				arg_361_1.allBtn_.enabled = false
			end

			local var_364_15 = 0.3

			if arg_361_1.time_ >= var_364_14 + var_364_15 and arg_361_1.time_ < var_364_14 + var_364_15 + arg_364_0 then
				arg_361_1.allBtn_.enabled = true
			end

			local var_364_16 = 0

			if var_364_16 < arg_361_1.time_ and arg_361_1.time_ <= var_364_16 + arg_364_0 then
				arg_361_1.mask_.enabled = true
				arg_361_1.mask_.raycastTarget = true

				arg_361_1:SetGaussion(false)
			end

			local var_364_17 = 1.45

			if var_364_16 <= arg_361_1.time_ and arg_361_1.time_ < var_364_16 + var_364_17 then
				local var_364_18 = (arg_361_1.time_ - var_364_16) / var_364_17
				local var_364_19 = Color.New(0, 0, 0)

				var_364_19.a = Mathf.Lerp(0, 1, var_364_18)
				arg_361_1.mask_.color = var_364_19
			end

			if arg_361_1.time_ >= var_364_16 + var_364_17 and arg_361_1.time_ < var_364_16 + var_364_17 + arg_364_0 then
				local var_364_20 = Color.New(0, 0, 0)

				var_364_20.a = 1
				arg_361_1.mask_.color = var_364_20
			end

			local var_364_21 = 1.43333333333333

			if var_364_21 < arg_361_1.time_ and arg_361_1.time_ <= var_364_21 + arg_364_0 then
				arg_361_1.mask_.enabled = true
				arg_361_1.mask_.raycastTarget = true

				arg_361_1:SetGaussion(false)
			end

			local var_364_22 = 2

			if var_364_21 <= arg_361_1.time_ and arg_361_1.time_ < var_364_21 + var_364_22 then
				local var_364_23 = (arg_361_1.time_ - var_364_21) / var_364_22
				local var_364_24 = Color.New(0, 0, 0)

				var_364_24.a = Mathf.Lerp(1, 0, var_364_23)
				arg_361_1.mask_.color = var_364_24
			end

			if arg_361_1.time_ >= var_364_21 + var_364_22 and arg_361_1.time_ < var_364_21 + var_364_22 + arg_364_0 then
				local var_364_25 = Color.New(0, 0, 0)
				local var_364_26 = 0

				arg_361_1.mask_.enabled = false
				var_364_25.a = var_364_26
				arg_361_1.mask_.color = var_364_25
			end

			local var_364_27 = 1.43333333333333

			if var_364_27 < arg_361_1.time_ and arg_361_1.time_ <= var_364_27 + arg_364_0 then
				arg_361_1.cswbg_:SetActive(true)

				local var_364_28 = arg_361_1.cswt_:GetComponent("RectTransform")

				arg_361_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_364_28.offsetMin = Vector2.New(400, -200)
				var_364_28.offsetMax = Vector2.New(-400, -262.5)

				local var_364_29 = arg_361_1:GetWordFromCfg(419176)
				local var_364_30 = arg_361_1:FormatText(var_364_29.content)

				arg_361_1.cswt_.text = var_364_30

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.cswt_)

				arg_361_1.cswt_.fontSize = 108
				arg_361_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_361_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_361_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_364_31 = 1.43333333333333

			if var_364_31 < arg_361_1.time_ and arg_361_1.time_ <= var_364_31 + arg_364_0 then
				arg_361_1.fswbg_:SetActive(true)
				arg_361_1.dialog_:SetActive(false)

				arg_361_1.fswtw_.percent = 0

				local var_364_32 = arg_361_1:GetWordFromCfg(102)
				local var_364_33 = arg_361_1:FormatText(var_364_32.content)

				arg_361_1.fswt_.text = var_364_33

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.fswt_)

				arg_361_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_361_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_361_1.fswtw_:SetDirty()

				arg_361_1.typewritterCharCountI18N = 0

				SetActive(arg_361_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_361_1:ShowNextGo(false)
			end

			local var_364_34 = 2.78333333333333

			if var_364_34 < arg_361_1.time_ and arg_361_1.time_ <= var_364_34 + arg_364_0 then
				arg_361_1.var_.oldValueTypewriter = arg_361_1.fswtw_.percent

				SetActive(arg_361_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_361_1:ShowNextGo(false)
			end

			local var_364_35 = 0
			local var_364_36 = 0.65
			local var_364_37 = arg_361_1:GetWordFromCfg(102)
			local var_364_38 = arg_361_1:FormatText(var_364_37.content)
			local var_364_39, var_364_40 = arg_361_1:GetPercentByPara(var_364_38, 1)

			if var_364_34 < arg_361_1.time_ and arg_361_1.time_ <= var_364_34 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0

				local var_364_41 = var_364_35 <= 0 and var_364_36 or var_364_36 * ((var_364_40 - arg_361_1.typewritterCharCountI18N) / var_364_35)

				if var_364_41 > 0 and var_364_36 < var_364_41 then
					arg_361_1.talkMaxDuration = var_364_41

					if var_364_41 + var_364_34 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_41 + var_364_34
					end
				end
			end

			local var_364_42 = 0.65
			local var_364_43 = math.max(var_364_42, arg_361_1.talkMaxDuration)

			if var_364_34 <= arg_361_1.time_ and arg_361_1.time_ < var_364_34 + var_364_43 then
				local var_364_44 = (arg_361_1.time_ - var_364_34) / var_364_43

				arg_361_1.fswtw_.percent = Mathf.Lerp(arg_361_1.var_.oldValueTypewriter, var_364_39, var_364_44)
				arg_361_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_361_1.fswtw_:SetDirty()
			end

			if arg_361_1.time_ >= var_364_34 + var_364_43 and arg_361_1.time_ < var_364_34 + var_364_43 + arg_364_0 then
				arg_361_1.fswtw_.percent = var_364_39

				arg_361_1.fswtw_:SetDirty()
				arg_361_1:ShowNextGo(true)

				arg_361_1.typewritterCharCountI18N = var_364_40
			end

			local var_364_45 = 1.43333333333333
			local var_364_46 = 1

			if var_364_45 < arg_361_1.time_ and arg_361_1.time_ <= var_364_45 + arg_364_0 then
				local var_364_47 = "play"
				local var_364_48 = "effect"

				arg_361_1:AudioAction(var_364_47, var_364_48, "se_story_148", "se_story_148_bell_temple_china01", "")
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play323011088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 323011088
		arg_365_1.duration_ = 2

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play323011089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["10167ui_story"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect10167ui_story == nil then
				arg_365_1.var_.characterEffect10167ui_story = var_368_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.characterEffect10167ui_story and not isNil(var_368_0) then
					arg_365_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.characterEffect10167ui_story then
				arg_365_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_368_4 = 0

			if var_368_4 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1.fswbg_:SetActive(true)
				arg_365_1.dialog_:SetActive(false)

				arg_365_1.fswtw_.percent = 0

				local var_368_5 = arg_365_1:GetWordFromCfg(323011088)
				local var_368_6 = arg_365_1:FormatText(var_368_5.content)

				arg_365_1.fswt_.text = var_368_6

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.fswt_)

				arg_365_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_365_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_365_1.fswtw_:SetDirty()

				arg_365_1.typewritterCharCountI18N = 0

				SetActive(arg_365_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_365_1:ShowNextGo(false)
			end

			local var_368_7 = 1.1

			if var_368_7 < arg_365_1.time_ and arg_365_1.time_ <= var_368_7 + arg_368_0 then
				arg_365_1.var_.oldValueTypewriter = arg_365_1.fswtw_.percent

				SetActive(arg_365_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_365_1:ShowNextGo(false)
			end

			local var_368_8 = 3
			local var_368_9 = 0.2
			local var_368_10 = arg_365_1:GetWordFromCfg(323011088)
			local var_368_11 = arg_365_1:FormatText(var_368_10.content)
			local var_368_12, var_368_13 = arg_365_1:GetPercentByPara(var_368_11, 1)

			if var_368_7 < arg_365_1.time_ and arg_365_1.time_ <= var_368_7 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0

				local var_368_14 = var_368_8 <= 0 and var_368_9 or var_368_9 * ((var_368_13 - arg_365_1.typewritterCharCountI18N) / var_368_8)

				if var_368_14 > 0 and var_368_9 < var_368_14 then
					arg_365_1.talkMaxDuration = var_368_14

					if var_368_14 + var_368_7 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_14 + var_368_7
					end
				end
			end

			local var_368_15 = 0.2
			local var_368_16 = math.max(var_368_15, arg_365_1.talkMaxDuration)

			if var_368_7 <= arg_365_1.time_ and arg_365_1.time_ < var_368_7 + var_368_16 then
				local var_368_17 = (arg_365_1.time_ - var_368_7) / var_368_16

				arg_365_1.fswtw_.percent = Mathf.Lerp(arg_365_1.var_.oldValueTypewriter, var_368_12, var_368_17)
				arg_365_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_365_1.fswtw_:SetDirty()
			end

			if arg_365_1.time_ >= var_368_7 + var_368_16 and arg_365_1.time_ < var_368_7 + var_368_16 + arg_368_0 then
				arg_365_1.fswtw_.percent = var_368_12

				arg_365_1.fswtw_:SetDirty()
				arg_365_1:ShowNextGo(true)

				arg_365_1.typewritterCharCountI18N = var_368_13
			end

			local var_368_18 = 0

			if var_368_18 < arg_365_1.time_ and arg_365_1.time_ <= var_368_18 + arg_368_0 then
				arg_365_1.allBtn_.enabled = false
			end

			local var_368_19 = 1.3

			if arg_365_1.time_ >= var_368_18 + var_368_19 and arg_365_1.time_ < var_368_18 + var_368_19 + arg_368_0 then
				arg_365_1.allBtn_.enabled = true
			end

			local var_368_20 = 1
			local var_368_21 = 1
			local var_368_22 = manager.audio:GetVoiceLength("story_v_out_323011", "323011088", "0") / 1000

			if var_368_22 > 0 and var_368_21 < var_368_22 and var_368_22 + var_368_20 > arg_365_1.duration_ then
				local var_368_23 = var_368_22

				arg_365_1.duration_ = var_368_22 + var_368_20
			end

			if var_368_20 < arg_365_1.time_ and arg_365_1.time_ <= var_368_20 + arg_368_0 then
				local var_368_24 = "play"
				local var_368_25 = "voice"

				arg_365_1:AudioAction(var_368_24, var_368_25, "story_v_out_323011", "323011088", "0")
			end

			local var_368_26 = 1
			local var_368_27 = 1

			if var_368_26 < arg_365_1.time_ and arg_365_1.time_ <= var_368_26 + arg_368_0 then
				local var_368_28 = "play"
				local var_368_29 = "music"

				arg_365_1:AudioAction(var_368_28, var_368_29, "bgm_activity_4_8_story_dahuang_jianmenguan", "battle", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_368_30 = ""
				local var_368_31 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "battle")

				if var_368_31 ~= "" then
					if arg_365_1.bgmTxt_.text ~= var_368_31 and arg_365_1.bgmTxt_.text ~= "" then
						if arg_365_1.bgmTxt2_.text ~= "" then
							arg_365_1.bgmTxt_.text = arg_365_1.bgmTxt2_.text
						end

						arg_365_1.bgmTxt2_.text = var_368_31

						arg_365_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_365_1.bgmTxt_.text = var_368_31
						arg_365_1.bgmTxt2_.text = var_368_31
					end

					if arg_365_1.bgmTimer then
						arg_365_1.bgmTimer:Stop()

						arg_365_1.bgmTimer = nil
					end

					if arg_365_1.settingData.show_music_name == 1 then
						arg_365_1.musicController:SetSelectedState("show")
						arg_365_1.musicAnimator_:Play("open", 0, 0)

						if arg_365_1.settingData.music_time ~= 0 then
							arg_365_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_365_1.settingData.music_time), function()
								if arg_365_1 == nil or isNil(arg_365_1.bgmTxt_) then
									return
								end

								arg_365_1.musicController:SetSelectedState("hide")
								arg_365_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play323011089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 323011089
		arg_370_1.duration_ = 1.3

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play323011090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = arg_370_1.actors_["10165ui_story"]
			local var_373_1 = 0

			if var_373_1 < arg_370_1.time_ and arg_370_1.time_ <= var_373_1 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect10165ui_story == nil then
				arg_370_1.var_.characterEffect10165ui_story = var_373_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_2 = 0.200000002980232

			if var_373_1 <= arg_370_1.time_ and arg_370_1.time_ < var_373_1 + var_373_2 and not isNil(var_373_0) then
				local var_373_3 = (arg_370_1.time_ - var_373_1) / var_373_2

				if arg_370_1.var_.characterEffect10165ui_story and not isNil(var_373_0) then
					arg_370_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= var_373_1 + var_373_2 and arg_370_1.time_ < var_373_1 + var_373_2 + arg_373_0 and not isNil(var_373_0) and arg_370_1.var_.characterEffect10165ui_story then
				arg_370_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_373_4 = arg_370_1.actors_["10167ui_story"]
			local var_373_5 = 0

			if var_373_5 < arg_370_1.time_ and arg_370_1.time_ <= var_373_5 + arg_373_0 and not isNil(var_373_4) and arg_370_1.var_.characterEffect10167ui_story == nil then
				arg_370_1.var_.characterEffect10167ui_story = var_373_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_6 = 0.200000002980232

			if var_373_5 <= arg_370_1.time_ and arg_370_1.time_ < var_373_5 + var_373_6 and not isNil(var_373_4) then
				local var_373_7 = (arg_370_1.time_ - var_373_5) / var_373_6

				if arg_370_1.var_.characterEffect10167ui_story and not isNil(var_373_4) then
					local var_373_8 = Mathf.Lerp(0, 0.5, var_373_7)

					arg_370_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_370_1.var_.characterEffect10167ui_story.fillRatio = var_373_8
				end
			end

			if arg_370_1.time_ >= var_373_5 + var_373_6 and arg_370_1.time_ < var_373_5 + var_373_6 + arg_373_0 and not isNil(var_373_4) and arg_370_1.var_.characterEffect10167ui_story then
				local var_373_9 = 0.5

				arg_370_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_370_1.var_.characterEffect10167ui_story.fillRatio = var_373_9
			end

			local var_373_10 = 0

			if var_373_10 < arg_370_1.time_ and arg_370_1.time_ <= var_373_10 + arg_373_0 then
				arg_370_1.fswbg_:SetActive(true)
				arg_370_1.dialog_:SetActive(false)

				arg_370_1.fswtw_.percent = 0

				local var_373_11 = arg_370_1:GetWordFromCfg(323011089)
				local var_373_12 = arg_370_1:FormatText(var_373_11.content)

				arg_370_1.fswt_.text = var_373_12

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.fswt_)

				arg_370_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_370_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_370_1.fswtw_:SetDirty()

				arg_370_1.typewritterCharCountI18N = 0

				SetActive(arg_370_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_370_1:ShowNextGo(false)
			end

			local var_373_13 = 0.433333333333333

			if var_373_13 < arg_370_1.time_ and arg_370_1.time_ <= var_373_13 + arg_373_0 then
				arg_370_1.var_.oldValueTypewriter = arg_370_1.fswtw_.percent

				SetActive(arg_370_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_370_1:ShowNextGo(false)
			end

			local var_373_14 = 10
			local var_373_15 = 0.666666666666667
			local var_373_16 = arg_370_1:GetWordFromCfg(323011089)
			local var_373_17 = arg_370_1:FormatText(var_373_16.content)
			local var_373_18, var_373_19 = arg_370_1:GetPercentByPara(var_373_17, 1)

			if var_373_13 < arg_370_1.time_ and arg_370_1.time_ <= var_373_13 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0

				local var_373_20 = var_373_14 <= 0 and var_373_15 or var_373_15 * ((var_373_19 - arg_370_1.typewritterCharCountI18N) / var_373_14)

				if var_373_20 > 0 and var_373_15 < var_373_20 then
					arg_370_1.talkMaxDuration = var_373_20

					if var_373_20 + var_373_13 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_20 + var_373_13
					end
				end
			end

			local var_373_21 = 0.666666666666667
			local var_373_22 = math.max(var_373_21, arg_370_1.talkMaxDuration)

			if var_373_13 <= arg_370_1.time_ and arg_370_1.time_ < var_373_13 + var_373_22 then
				local var_373_23 = (arg_370_1.time_ - var_373_13) / var_373_22

				arg_370_1.fswtw_.percent = Mathf.Lerp(arg_370_1.var_.oldValueTypewriter, var_373_18, var_373_23)
				arg_370_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_370_1.fswtw_:SetDirty()
			end

			if arg_370_1.time_ >= var_373_13 + var_373_22 and arg_370_1.time_ < var_373_13 + var_373_22 + arg_373_0 then
				arg_370_1.fswtw_.percent = var_373_18

				arg_370_1.fswtw_:SetDirty()
				arg_370_1:ShowNextGo(true)

				arg_370_1.typewritterCharCountI18N = var_373_19
			end

			local var_373_24 = 0.3
			local var_373_25 = 1
			local var_373_26 = manager.audio:GetVoiceLength("story_v_out_323011", "323011089", "0") / 1000

			if var_373_26 > 0 and var_373_25 < var_373_26 and var_373_26 + var_373_24 > arg_370_1.duration_ then
				local var_373_27 = var_373_26

				arg_370_1.duration_ = var_373_26 + var_373_24
			end

			if var_373_24 < arg_370_1.time_ and arg_370_1.time_ <= var_373_24 + arg_373_0 then
				local var_373_28 = "play"
				local var_373_29 = "voice"

				arg_370_1:AudioAction(var_373_28, var_373_29, "story_v_out_323011", "323011089", "0")
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play323011090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 323011090
		arg_374_1.duration_ = 7.77

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play323011091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = "J21f"

			if arg_374_1.bgs_[var_377_0] == nil then
				local var_377_1 = Object.Instantiate(arg_374_1.paintGo_)

				var_377_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_377_0)
				var_377_1.name = var_377_0
				var_377_1.transform.parent = arg_374_1.stage_.transform
				var_377_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_374_1.bgs_[var_377_0] = var_377_1
			end

			local var_377_2 = 1

			if var_377_2 < arg_374_1.time_ and arg_374_1.time_ <= var_377_2 + arg_377_0 then
				local var_377_3 = manager.ui.mainCamera.transform.localPosition
				local var_377_4 = Vector3.New(0, 0, 10) + Vector3.New(var_377_3.x, var_377_3.y, 0)
				local var_377_5 = arg_374_1.bgs_.J21f

				var_377_5.transform.localPosition = var_377_4
				var_377_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_377_6 = var_377_5:GetComponent("SpriteRenderer")

				if var_377_6 and var_377_6.sprite then
					local var_377_7 = (var_377_5.transform.localPosition - var_377_3).z
					local var_377_8 = manager.ui.mainCameraCom_
					local var_377_9 = 2 * var_377_7 * Mathf.Tan(var_377_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_377_10 = var_377_9 * var_377_8.aspect
					local var_377_11 = var_377_6.sprite.bounds.size.x
					local var_377_12 = var_377_6.sprite.bounds.size.y
					local var_377_13 = var_377_10 / var_377_11
					local var_377_14 = var_377_9 / var_377_12
					local var_377_15 = var_377_14 < var_377_13 and var_377_13 or var_377_14

					var_377_5.transform.localScale = Vector3.New(var_377_15, var_377_15, 0)
				end

				for iter_377_0, iter_377_1 in pairs(arg_374_1.bgs_) do
					if iter_377_0 ~= "J21f" then
						iter_377_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_377_16 = 1

			if var_377_16 < arg_374_1.time_ and arg_374_1.time_ <= var_377_16 + arg_377_0 then
				arg_374_1.allBtn_.enabled = false
			end

			local var_377_17 = 0.3

			if arg_374_1.time_ >= var_377_16 + var_377_17 and arg_374_1.time_ < var_377_16 + var_377_17 + arg_377_0 then
				arg_374_1.allBtn_.enabled = true
			end

			local var_377_18 = 0

			if var_377_18 < arg_374_1.time_ and arg_374_1.time_ <= var_377_18 + arg_377_0 then
				arg_374_1.mask_.enabled = true
				arg_374_1.mask_.raycastTarget = true

				arg_374_1:SetGaussion(false)
			end

			local var_377_19 = 1

			if var_377_18 <= arg_374_1.time_ and arg_374_1.time_ < var_377_18 + var_377_19 then
				local var_377_20 = (arg_374_1.time_ - var_377_18) / var_377_19
				local var_377_21 = Color.New(1, 1, 1)

				var_377_21.a = Mathf.Lerp(0, 1, var_377_20)
				arg_374_1.mask_.color = var_377_21
			end

			if arg_374_1.time_ >= var_377_18 + var_377_19 and arg_374_1.time_ < var_377_18 + var_377_19 + arg_377_0 then
				local var_377_22 = Color.New(1, 1, 1)

				var_377_22.a = 1
				arg_374_1.mask_.color = var_377_22
			end

			local var_377_23 = 1

			if var_377_23 < arg_374_1.time_ and arg_374_1.time_ <= var_377_23 + arg_377_0 then
				arg_374_1.mask_.enabled = true
				arg_374_1.mask_.raycastTarget = true

				arg_374_1:SetGaussion(false)
			end

			local var_377_24 = 2

			if var_377_23 <= arg_374_1.time_ and arg_374_1.time_ < var_377_23 + var_377_24 then
				local var_377_25 = (arg_374_1.time_ - var_377_23) / var_377_24
				local var_377_26 = Color.New(1, 1, 1)

				var_377_26.a = Mathf.Lerp(1, 0, var_377_25)
				arg_374_1.mask_.color = var_377_26
			end

			if arg_374_1.time_ >= var_377_23 + var_377_24 and arg_374_1.time_ < var_377_23 + var_377_24 + arg_377_0 then
				local var_377_27 = Color.New(1, 1, 1)
				local var_377_28 = 0

				arg_374_1.mask_.enabled = false
				var_377_27.a = var_377_28
				arg_374_1.mask_.color = var_377_27
			end

			local var_377_29 = arg_374_1.actors_["10165ui_story"]
			local var_377_30 = 1

			if var_377_30 < arg_374_1.time_ and arg_374_1.time_ <= var_377_30 + arg_377_0 and not isNil(var_377_29) and arg_374_1.var_.characterEffect10165ui_story == nil then
				arg_374_1.var_.characterEffect10165ui_story = var_377_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_31 = 0.200000002980232

			if var_377_30 <= arg_374_1.time_ and arg_374_1.time_ < var_377_30 + var_377_31 and not isNil(var_377_29) then
				local var_377_32 = (arg_374_1.time_ - var_377_30) / var_377_31

				if arg_374_1.var_.characterEffect10165ui_story and not isNil(var_377_29) then
					local var_377_33 = Mathf.Lerp(0, 0.5, var_377_32)

					arg_374_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_374_1.var_.characterEffect10165ui_story.fillRatio = var_377_33
				end
			end

			if arg_374_1.time_ >= var_377_30 + var_377_31 and arg_374_1.time_ < var_377_30 + var_377_31 + arg_377_0 and not isNil(var_377_29) and arg_374_1.var_.characterEffect10165ui_story then
				local var_377_34 = 0.5

				arg_374_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_374_1.var_.characterEffect10165ui_story.fillRatio = var_377_34
			end

			local var_377_35 = 1

			if var_377_35 < arg_374_1.time_ and arg_374_1.time_ <= var_377_35 + arg_377_0 then
				arg_374_1.fswbg_:SetActive(false)
				arg_374_1.dialog_:SetActive(false)
				SetActive(arg_374_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_374_1:ShowNextGo(false)
			end

			local var_377_36 = 1.01666666666667

			if var_377_36 < arg_374_1.time_ and arg_374_1.time_ <= var_377_36 + arg_377_0 then
				arg_374_1.fswbg_:SetActive(false)
				arg_374_1.dialog_:SetActive(false)
				SetActive(arg_374_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_374_1:ShowNextGo(false)
			end

			local var_377_37 = 1

			if var_377_37 < arg_374_1.time_ and arg_374_1.time_ <= var_377_37 + arg_377_0 then
				arg_374_1.cswbg_:SetActive(false)
			end

			local var_377_38 = 2.93333333333333
			local var_377_39 = 1

			if var_377_38 < arg_374_1.time_ and arg_374_1.time_ <= var_377_38 + arg_377_0 then
				local var_377_40 = "play"
				local var_377_41 = "effect"

				arg_374_1:AudioAction(var_377_40, var_377_41, "se_story_148", "se_story_148_door_huge", "")
			end

			if arg_374_1.frameCnt_ <= 1 then
				arg_374_1.dialog_:SetActive(false)
			end

			local var_377_42 = 2.76666666666667
			local var_377_43 = 1.375

			if var_377_42 < arg_374_1.time_ and arg_374_1.time_ <= var_377_42 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0

				arg_374_1.dialog_:SetActive(true)

				arg_374_1.dialogCg_.alpha = 0

				local var_377_44 = LeanTween.value(arg_374_1.dialog_, 0, 1, 0.3)

				var_377_44:setOnUpdate(LuaHelper.FloatAction(function(arg_378_0)
					arg_374_1.dialogCg_.alpha = arg_378_0
				end))
				var_377_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_374_1.dialog_)
					var_377_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_374_1.duration_ = arg_374_1.duration_ + 0.3

				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_45 = arg_374_1:GetWordFromCfg(323011090)
				local var_377_46 = arg_374_1:FormatText(var_377_45.content)

				arg_374_1.text_.text = var_377_46

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_47 = 55
				local var_377_48 = utf8.len(var_377_46)
				local var_377_49 = var_377_47 <= 0 and var_377_43 or var_377_43 * (var_377_48 / var_377_47)

				if var_377_49 > 0 and var_377_43 < var_377_49 then
					arg_374_1.talkMaxDuration = var_377_49
					var_377_42 = var_377_42 + 0.3

					if var_377_49 + var_377_42 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_49 + var_377_42
					end
				end

				arg_374_1.text_.text = var_377_46
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_50 = var_377_42 + 0.3
			local var_377_51 = math.max(var_377_43, arg_374_1.talkMaxDuration)

			if var_377_50 <= arg_374_1.time_ and arg_374_1.time_ < var_377_50 + var_377_51 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_50) / var_377_51

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_50 + var_377_51 and arg_374_1.time_ < var_377_50 + var_377_51 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play323011091 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 323011091
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play323011092(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 1.35

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_2 = arg_380_1:GetWordFromCfg(323011091)
				local var_383_3 = arg_380_1:FormatText(var_383_2.content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_4 = 54
				local var_383_5 = utf8.len(var_383_3)
				local var_383_6 = var_383_4 <= 0 and var_383_1 or var_383_1 * (var_383_5 / var_383_4)

				if var_383_6 > 0 and var_383_1 < var_383_6 then
					arg_380_1.talkMaxDuration = var_383_6

					if var_383_6 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_6 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_7 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_7 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_7

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_7 and arg_380_1.time_ < var_383_0 + var_383_7 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play323011092 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 323011092
		arg_384_1.duration_ = 3.3

		local var_384_0 = {
			zh = 3.3,
			ja = 2.566
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play323011093(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["10165ui_story"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect10165ui_story == nil then
				arg_384_1.var_.characterEffect10165ui_story = var_387_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.characterEffect10165ui_story and not isNil(var_387_0) then
					arg_384_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect10165ui_story then
				arg_384_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_387_4 = 0
			local var_387_5 = 0.2

			if var_387_4 < arg_384_1.time_ and arg_384_1.time_ <= var_387_4 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_6 = arg_384_1:FormatText(StoryNameCfg[1446].name)

				arg_384_1.leftNameTxt_.text = var_387_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10165")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_7 = arg_384_1:GetWordFromCfg(323011092)
				local var_387_8 = arg_384_1:FormatText(var_387_7.content)

				arg_384_1.text_.text = var_387_8

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_9 = 8
				local var_387_10 = utf8.len(var_387_8)
				local var_387_11 = var_387_9 <= 0 and var_387_5 or var_387_5 * (var_387_10 / var_387_9)

				if var_387_11 > 0 and var_387_5 < var_387_11 then
					arg_384_1.talkMaxDuration = var_387_11

					if var_387_11 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_11 + var_387_4
					end
				end

				arg_384_1.text_.text = var_387_8
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011092", "story_v_out_323011.awb") ~= 0 then
					local var_387_12 = manager.audio:GetVoiceLength("story_v_out_323011", "323011092", "story_v_out_323011.awb") / 1000

					if var_387_12 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_12 + var_387_4
					end

					if var_387_7.prefab_name ~= "" and arg_384_1.actors_[var_387_7.prefab_name] ~= nil then
						local var_387_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_7.prefab_name].transform, "story_v_out_323011", "323011092", "story_v_out_323011.awb")

						arg_384_1:RecordAudio("323011092", var_387_13)
						arg_384_1:RecordAudio("323011092", var_387_13)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_323011", "323011092", "story_v_out_323011.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_323011", "323011092", "story_v_out_323011.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_14 = math.max(var_387_5, arg_384_1.talkMaxDuration)

			if var_387_4 <= arg_384_1.time_ and arg_384_1.time_ < var_387_4 + var_387_14 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_4) / var_387_14

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_4 + var_387_14 and arg_384_1.time_ < var_387_4 + var_387_14 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play323011093 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 323011093
		arg_388_1.duration_ = 1.17

		local var_388_0 = {
			zh = 1.166,
			ja = 1.133
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play323011094(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["10163ui_story"]
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect10163ui_story == nil then
				arg_388_1.var_.characterEffect10163ui_story = var_391_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 and not isNil(var_391_0) then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2

				if arg_388_1.var_.characterEffect10163ui_story and not isNil(var_391_0) then
					arg_388_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 and not isNil(var_391_0) and arg_388_1.var_.characterEffect10163ui_story then
				arg_388_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_391_4 = arg_388_1.actors_["10165ui_story"]
			local var_391_5 = 0

			if var_391_5 < arg_388_1.time_ and arg_388_1.time_ <= var_391_5 + arg_391_0 and not isNil(var_391_4) and arg_388_1.var_.characterEffect10165ui_story == nil then
				arg_388_1.var_.characterEffect10165ui_story = var_391_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_6 = 0.200000002980232

			if var_391_5 <= arg_388_1.time_ and arg_388_1.time_ < var_391_5 + var_391_6 and not isNil(var_391_4) then
				local var_391_7 = (arg_388_1.time_ - var_391_5) / var_391_6

				if arg_388_1.var_.characterEffect10165ui_story and not isNil(var_391_4) then
					local var_391_8 = Mathf.Lerp(0, 0.5, var_391_7)

					arg_388_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_388_1.var_.characterEffect10165ui_story.fillRatio = var_391_8
				end
			end

			if arg_388_1.time_ >= var_391_5 + var_391_6 and arg_388_1.time_ < var_391_5 + var_391_6 + arg_391_0 and not isNil(var_391_4) and arg_388_1.var_.characterEffect10165ui_story then
				local var_391_9 = 0.5

				arg_388_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_388_1.var_.characterEffect10165ui_story.fillRatio = var_391_9
			end

			local var_391_10 = 0
			local var_391_11 = 1

			if var_391_10 < arg_388_1.time_ and arg_388_1.time_ <= var_391_10 + arg_391_0 then
				local var_391_12 = "play"
				local var_391_13 = "music"

				arg_388_1:AudioAction(var_391_12, var_391_13, "bgm_activity_4_8_story_dahuang_jianmenguan", "battle", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_391_14 = ""
				local var_391_15 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "battle")

				if var_391_15 ~= "" then
					if arg_388_1.bgmTxt_.text ~= var_391_15 and arg_388_1.bgmTxt_.text ~= "" then
						if arg_388_1.bgmTxt2_.text ~= "" then
							arg_388_1.bgmTxt_.text = arg_388_1.bgmTxt2_.text
						end

						arg_388_1.bgmTxt2_.text = var_391_15

						arg_388_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_388_1.bgmTxt_.text = var_391_15
						arg_388_1.bgmTxt2_.text = var_391_15
					end

					if arg_388_1.bgmTimer then
						arg_388_1.bgmTimer:Stop()

						arg_388_1.bgmTimer = nil
					end

					if arg_388_1.settingData.show_music_name == 1 then
						arg_388_1.musicController:SetSelectedState("show")
						arg_388_1.musicAnimator_:Play("open", 0, 0)

						if arg_388_1.settingData.music_time ~= 0 then
							arg_388_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_388_1.settingData.music_time), function()
								if arg_388_1 == nil or isNil(arg_388_1.bgmTxt_) then
									return
								end

								arg_388_1.musicController:SetSelectedState("hide")
								arg_388_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_391_16 = 0
			local var_391_17 = 0.075

			if var_391_16 < arg_388_1.time_ and arg_388_1.time_ <= var_391_16 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_18 = arg_388_1:FormatText(StoryNameCfg[1444].name)

				arg_388_1.leftNameTxt_.text = var_391_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10163")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_19 = arg_388_1:GetWordFromCfg(323011093)
				local var_391_20 = arg_388_1:FormatText(var_391_19.content)

				arg_388_1.text_.text = var_391_20

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_21 = 3
				local var_391_22 = utf8.len(var_391_20)
				local var_391_23 = var_391_21 <= 0 and var_391_17 or var_391_17 * (var_391_22 / var_391_21)

				if var_391_23 > 0 and var_391_17 < var_391_23 then
					arg_388_1.talkMaxDuration = var_391_23

					if var_391_23 + var_391_16 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_23 + var_391_16
					end
				end

				arg_388_1.text_.text = var_391_20
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011093", "story_v_out_323011.awb") ~= 0 then
					local var_391_24 = manager.audio:GetVoiceLength("story_v_out_323011", "323011093", "story_v_out_323011.awb") / 1000

					if var_391_24 + var_391_16 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_24 + var_391_16
					end

					if var_391_19.prefab_name ~= "" and arg_388_1.actors_[var_391_19.prefab_name] ~= nil then
						local var_391_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_19.prefab_name].transform, "story_v_out_323011", "323011093", "story_v_out_323011.awb")

						arg_388_1:RecordAudio("323011093", var_391_25)
						arg_388_1:RecordAudio("323011093", var_391_25)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_323011", "323011093", "story_v_out_323011.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_323011", "323011093", "story_v_out_323011.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_26 = math.max(var_391_17, arg_388_1.talkMaxDuration)

			if var_391_16 <= arg_388_1.time_ and arg_388_1.time_ < var_391_16 + var_391_26 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_16) / var_391_26

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_16 + var_391_26 and arg_388_1.time_ < var_391_16 + var_391_26 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play323011094 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 323011094
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play323011095(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["10163ui_story"]
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect10163ui_story == nil then
				arg_393_1.var_.characterEffect10163ui_story = var_396_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_2 = 0.200000002980232

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.characterEffect10163ui_story and not isNil(var_396_0) then
					local var_396_4 = Mathf.Lerp(0, 0.5, var_396_3)

					arg_393_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_393_1.var_.characterEffect10163ui_story.fillRatio = var_396_4
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.characterEffect10163ui_story then
				local var_396_5 = 0.5

				arg_393_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_393_1.var_.characterEffect10163ui_story.fillRatio = var_396_5
			end

			local var_396_6 = 0
			local var_396_7 = 0.925

			if var_396_6 < arg_393_1.time_ and arg_393_1.time_ <= var_396_6 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_8 = arg_393_1:GetWordFromCfg(323011094)
				local var_396_9 = arg_393_1:FormatText(var_396_8.content)

				arg_393_1.text_.text = var_396_9

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_10 = 37
				local var_396_11 = utf8.len(var_396_9)
				local var_396_12 = var_396_10 <= 0 and var_396_7 or var_396_7 * (var_396_11 / var_396_10)

				if var_396_12 > 0 and var_396_7 < var_396_12 then
					arg_393_1.talkMaxDuration = var_396_12

					if var_396_12 + var_396_6 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_12 + var_396_6
					end
				end

				arg_393_1.text_.text = var_396_9
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_13 = math.max(var_396_7, arg_393_1.talkMaxDuration)

			if var_396_6 <= arg_393_1.time_ and arg_393_1.time_ < var_396_6 + var_396_13 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_6) / var_396_13

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_6 + var_396_13 and arg_393_1.time_ < var_396_6 + var_396_13 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play323011095 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 323011095
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play323011096(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 0.9

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_2 = arg_397_1:GetWordFromCfg(323011095)
				local var_400_3 = arg_397_1:FormatText(var_400_2.content)

				arg_397_1.text_.text = var_400_3

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_4 = 36
				local var_400_5 = utf8.len(var_400_3)
				local var_400_6 = var_400_4 <= 0 and var_400_1 or var_400_1 * (var_400_5 / var_400_4)

				if var_400_6 > 0 and var_400_1 < var_400_6 then
					arg_397_1.talkMaxDuration = var_400_6

					if var_400_6 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_6 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_3
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_7 and arg_397_1.time_ < var_400_0 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play323011096 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 323011096
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play323011097(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 0.9

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_2 = arg_401_1:GetWordFromCfg(323011096)
				local var_404_3 = arg_401_1:FormatText(var_404_2.content)

				arg_401_1.text_.text = var_404_3

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 36
				local var_404_5 = utf8.len(var_404_3)
				local var_404_6 = var_404_4 <= 0 and var_404_1 or var_404_1 * (var_404_5 / var_404_4)

				if var_404_6 > 0 and var_404_1 < var_404_6 then
					arg_401_1.talkMaxDuration = var_404_6

					if var_404_6 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_6 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_3
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_7 and arg_401_1.time_ < var_404_0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play323011097 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 323011097
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play323011098(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["10163ui_story"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect10163ui_story == nil then
				arg_405_1.var_.characterEffect10163ui_story = var_408_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.characterEffect10163ui_story and not isNil(var_408_0) then
					arg_405_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect10163ui_story then
				arg_405_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_408_4 = 0

			if var_408_4 < arg_405_1.time_ and arg_405_1.time_ <= var_408_4 + arg_408_0 then
				arg_405_1.cswbg_:SetActive(true)

				local var_408_5 = arg_405_1.cswt_:GetComponent("RectTransform")

				arg_405_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_408_5.offsetMin = Vector2.New(400, -200)
				var_408_5.offsetMax = Vector2.New(-400, -262.5)

				local var_408_6 = arg_405_1:GetWordFromCfg(419177)
				local var_408_7 = arg_405_1:FormatText(var_408_6.content)

				arg_405_1.cswt_.text = var_408_7

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.cswt_)

				arg_405_1.cswt_.fontSize = 108
				arg_405_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_405_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_405_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_408_8 = 0

			if var_408_8 < arg_405_1.time_ and arg_405_1.time_ <= var_408_8 + arg_408_0 then
				arg_405_1.fswbg_:SetActive(true)
				arg_405_1.dialog_:SetActive(false)

				arg_405_1.fswtw_.percent = 0

				local var_408_9 = arg_405_1:GetWordFromCfg(323011097)
				local var_408_10 = arg_405_1:FormatText(var_408_9.content)

				arg_405_1.fswt_.text = var_408_10

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.fswt_)

				arg_405_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_405_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_405_1.fswtw_:SetDirty()

				arg_405_1.typewritterCharCountI18N = 0

				SetActive(arg_405_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_405_1:ShowNextGo(false)
			end

			local var_408_11 = 0.766666666666667

			if var_408_11 < arg_405_1.time_ and arg_405_1.time_ <= var_408_11 + arg_408_0 then
				arg_405_1.var_.oldValueTypewriter = arg_405_1.fswtw_.percent

				SetActive(arg_405_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_405_1:ShowNextGo(false)
			end

			local var_408_12 = 5
			local var_408_13 = 0.333333333333333
			local var_408_14 = arg_405_1:GetWordFromCfg(323011097)
			local var_408_15 = arg_405_1:FormatText(var_408_14.content)
			local var_408_16, var_408_17 = arg_405_1:GetPercentByPara(var_408_15, 1)

			if var_408_11 < arg_405_1.time_ and arg_405_1.time_ <= var_408_11 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0

				local var_408_18 = var_408_12 <= 0 and var_408_13 or var_408_13 * ((var_408_17 - arg_405_1.typewritterCharCountI18N) / var_408_12)

				if var_408_18 > 0 and var_408_13 < var_408_18 then
					arg_405_1.talkMaxDuration = var_408_18

					if var_408_18 + var_408_11 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_18 + var_408_11
					end
				end
			end

			local var_408_19 = 0.333333333333333
			local var_408_20 = math.max(var_408_19, arg_405_1.talkMaxDuration)

			if var_408_11 <= arg_405_1.time_ and arg_405_1.time_ < var_408_11 + var_408_20 then
				local var_408_21 = (arg_405_1.time_ - var_408_11) / var_408_20

				arg_405_1.fswtw_.percent = Mathf.Lerp(arg_405_1.var_.oldValueTypewriter, var_408_16, var_408_21)
				arg_405_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_405_1.fswtw_:SetDirty()
			end

			if arg_405_1.time_ >= var_408_11 + var_408_20 and arg_405_1.time_ < var_408_11 + var_408_20 + arg_408_0 then
				arg_405_1.fswtw_.percent = var_408_16

				arg_405_1.fswtw_:SetDirty()
				arg_405_1:ShowNextGo(true)

				arg_405_1.typewritterCharCountI18N = var_408_17
			end

			local var_408_22 = 0.682114500552416
			local var_408_23 = 1

			if var_408_22 < arg_405_1.time_ and arg_405_1.time_ <= var_408_22 + arg_408_0 then
				local var_408_24 = "play"
				local var_408_25 = "effect"

				arg_405_1:AudioAction(var_408_24, var_408_25, "se_story_148", "se_story_148_bell_temple_china02", "")
			end

			local var_408_26 = 0.766666666666667
			local var_408_27 = 1
			local var_408_28 = manager.audio:GetVoiceLength("story_v_out_323011", "323011097", "0") / 1000

			if var_408_28 > 0 and var_408_27 < var_408_28 and var_408_28 + var_408_26 > arg_405_1.duration_ then
				local var_408_29 = var_408_28

				arg_405_1.duration_ = var_408_28 + var_408_26
			end

			if var_408_26 < arg_405_1.time_ and arg_405_1.time_ <= var_408_26 + arg_408_0 then
				local var_408_30 = "play"
				local var_408_31 = "voice"

				arg_405_1:AudioAction(var_408_30, var_408_31, "story_v_out_323011", "323011097", "0")
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play323011098 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 323011098
		arg_409_1.duration_ = 5.2

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play323011099(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["10163ui_story"]
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect10163ui_story == nil then
				arg_409_1.var_.characterEffect10163ui_story = var_412_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_2 = 0.200000002980232

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 and not isNil(var_412_0) then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2

				if arg_409_1.var_.characterEffect10163ui_story and not isNil(var_412_0) then
					local var_412_4 = Mathf.Lerp(0, 0.5, var_412_3)

					arg_409_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_409_1.var_.characterEffect10163ui_story.fillRatio = var_412_4
				end
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 and not isNil(var_412_0) and arg_409_1.var_.characterEffect10163ui_story then
				local var_412_5 = 0.5

				arg_409_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_409_1.var_.characterEffect10163ui_story.fillRatio = var_412_5
			end

			local var_412_6 = 0

			if var_412_6 < arg_409_1.time_ and arg_409_1.time_ <= var_412_6 + arg_412_0 then
				arg_409_1.fswbg_:SetActive(false)
				arg_409_1.dialog_:SetActive(false)
				SetActive(arg_409_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_409_1:ShowNextGo(false)
			end

			local var_412_7 = 0.0166666666666667

			if var_412_7 < arg_409_1.time_ and arg_409_1.time_ <= var_412_7 + arg_412_0 then
				arg_409_1.fswbg_:SetActive(false)
				arg_409_1.dialog_:SetActive(false)
				SetActive(arg_409_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_409_1:ShowNextGo(false)
			end

			local var_412_8 = 0

			if var_412_8 < arg_409_1.time_ and arg_409_1.time_ <= var_412_8 + arg_412_0 then
				arg_409_1.cswbg_:SetActive(false)
			end

			if arg_409_1.frameCnt_ <= 1 then
				arg_409_1.dialog_:SetActive(false)
			end

			local var_412_9 = 0.200000002980232
			local var_412_10 = 0.95

			if var_412_9 < arg_409_1.time_ and arg_409_1.time_ <= var_412_9 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0

				arg_409_1.dialog_:SetActive(true)

				arg_409_1.dialogCg_.alpha = 0

				local var_412_11 = LeanTween.value(arg_409_1.dialog_, 0, 1, 0.3)

				var_412_11:setOnUpdate(LuaHelper.FloatAction(function(arg_413_0)
					arg_409_1.dialogCg_.alpha = arg_413_0
				end))
				var_412_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_409_1.dialog_)
					var_412_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_409_1.duration_ = arg_409_1.duration_ + 0.3

				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_12 = arg_409_1:GetWordFromCfg(323011098)
				local var_412_13 = arg_409_1:FormatText(var_412_12.content)

				arg_409_1.text_.text = var_412_13

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_14 = 38
				local var_412_15 = utf8.len(var_412_13)
				local var_412_16 = var_412_14 <= 0 and var_412_10 or var_412_10 * (var_412_15 / var_412_14)

				if var_412_16 > 0 and var_412_10 < var_412_16 then
					arg_409_1.talkMaxDuration = var_412_16
					var_412_9 = var_412_9 + 0.3

					if var_412_16 + var_412_9 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_16 + var_412_9
					end
				end

				arg_409_1.text_.text = var_412_13
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_17 = var_412_9 + 0.3
			local var_412_18 = math.max(var_412_10, arg_409_1.talkMaxDuration)

			if var_412_17 <= arg_409_1.time_ and arg_409_1.time_ < var_412_17 + var_412_18 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_17) / var_412_18

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_17 + var_412_18 and arg_409_1.time_ < var_412_17 + var_412_18 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play323011099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 323011099
		arg_415_1.duration_ = 7.5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play323011100(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 1.36666666666667

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				local var_418_1 = manager.ui.mainCamera.transform.localPosition
				local var_418_2 = Vector3.New(0, 0, 10) + Vector3.New(var_418_1.x, var_418_1.y, 0)
				local var_418_3 = arg_415_1.bgs_.STblack

				var_418_3.transform.localPosition = var_418_2
				var_418_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_418_4 = var_418_3:GetComponent("SpriteRenderer")

				if var_418_4 and var_418_4.sprite then
					local var_418_5 = (var_418_3.transform.localPosition - var_418_1).z
					local var_418_6 = manager.ui.mainCameraCom_
					local var_418_7 = 2 * var_418_5 * Mathf.Tan(var_418_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_418_8 = var_418_7 * var_418_6.aspect
					local var_418_9 = var_418_4.sprite.bounds.size.x
					local var_418_10 = var_418_4.sprite.bounds.size.y
					local var_418_11 = var_418_8 / var_418_9
					local var_418_12 = var_418_7 / var_418_10
					local var_418_13 = var_418_12 < var_418_11 and var_418_11 or var_418_12

					var_418_3.transform.localScale = Vector3.New(var_418_13, var_418_13, 0)
				end

				for iter_418_0, iter_418_1 in pairs(arg_415_1.bgs_) do
					if iter_418_0 ~= "STblack" then
						iter_418_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_418_14 = 0

			if var_418_14 < arg_415_1.time_ and arg_415_1.time_ <= var_418_14 + arg_418_0 then
				arg_415_1.allBtn_.enabled = false
			end

			local var_418_15 = 0.3

			if arg_415_1.time_ >= var_418_14 + var_418_15 and arg_415_1.time_ < var_418_14 + var_418_15 + arg_418_0 then
				arg_415_1.allBtn_.enabled = true
			end

			local var_418_16 = 0

			if var_418_16 < arg_415_1.time_ and arg_415_1.time_ <= var_418_16 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_17 = 1.36666666666667

			if var_418_16 <= arg_415_1.time_ and arg_415_1.time_ < var_418_16 + var_418_17 then
				local var_418_18 = (arg_415_1.time_ - var_418_16) / var_418_17
				local var_418_19 = Color.New(0, 0, 0)

				var_418_19.a = Mathf.Lerp(0, 1, var_418_18)
				arg_415_1.mask_.color = var_418_19
			end

			if arg_415_1.time_ >= var_418_16 + var_418_17 and arg_415_1.time_ < var_418_16 + var_418_17 + arg_418_0 then
				local var_418_20 = Color.New(0, 0, 0)

				var_418_20.a = 1
				arg_415_1.mask_.color = var_418_20
			end

			local var_418_21 = 1.36666666666667

			if var_418_21 < arg_415_1.time_ and arg_415_1.time_ <= var_418_21 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_22 = 1.5

			if var_418_21 <= arg_415_1.time_ and arg_415_1.time_ < var_418_21 + var_418_22 then
				local var_418_23 = (arg_415_1.time_ - var_418_21) / var_418_22
				local var_418_24 = Color.New(0, 0, 0)

				var_418_24.a = Mathf.Lerp(1, 0, var_418_23)
				arg_415_1.mask_.color = var_418_24
			end

			if arg_415_1.time_ >= var_418_21 + var_418_22 and arg_415_1.time_ < var_418_21 + var_418_22 + arg_418_0 then
				local var_418_25 = Color.New(0, 0, 0)
				local var_418_26 = 0

				arg_415_1.mask_.enabled = false
				var_418_25.a = var_418_26
				arg_415_1.mask_.color = var_418_25
			end

			local var_418_27 = 0.3
			local var_418_28 = 0.3

			if var_418_27 < arg_415_1.time_ and arg_415_1.time_ <= var_418_27 + arg_418_0 then
				local var_418_29 = "play"
				local var_418_30 = "music"

				arg_415_1:AudioAction(var_418_29, var_418_30, "ui_battle", "ui_battle_stopbgm", "")

				local var_418_31 = ""
				local var_418_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_418_32 ~= "" then
					if arg_415_1.bgmTxt_.text ~= var_418_32 and arg_415_1.bgmTxt_.text ~= "" then
						if arg_415_1.bgmTxt2_.text ~= "" then
							arg_415_1.bgmTxt_.text = arg_415_1.bgmTxt2_.text
						end

						arg_415_1.bgmTxt2_.text = var_418_32

						arg_415_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_415_1.bgmTxt_.text = var_418_32
						arg_415_1.bgmTxt2_.text = var_418_32
					end

					if arg_415_1.bgmTimer then
						arg_415_1.bgmTimer:Stop()

						arg_415_1.bgmTimer = nil
					end

					if arg_415_1.settingData.show_music_name == 1 then
						arg_415_1.musicController:SetSelectedState("show")
						arg_415_1.musicAnimator_:Play("open", 0, 0)

						if arg_415_1.settingData.music_time ~= 0 then
							arg_415_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_415_1.settingData.music_time), function()
								if arg_415_1 == nil or isNil(arg_415_1.bgmTxt_) then
									return
								end

								arg_415_1.musicController:SetSelectedState("hide")
								arg_415_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_415_1.frameCnt_ <= 1 then
				arg_415_1.dialog_:SetActive(false)
			end

			local var_418_33 = 2.5
			local var_418_34 = 0.1

			if var_418_33 < arg_415_1.time_ and arg_415_1.time_ <= var_418_33 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				arg_415_1.dialog_:SetActive(true)

				arg_415_1.dialogCg_.alpha = 0

				local var_418_35 = LeanTween.value(arg_415_1.dialog_, 0, 1, 0.3)

				var_418_35:setOnUpdate(LuaHelper.FloatAction(function(arg_420_0)
					arg_415_1.dialogCg_.alpha = arg_420_0
				end))
				var_418_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_415_1.dialog_)
					var_418_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_415_1.duration_ = arg_415_1.duration_ + 0.3

				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_36 = arg_415_1:FormatText(StoryNameCfg[7].name)

				arg_415_1.leftNameTxt_.text = var_418_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_37 = arg_415_1:GetWordFromCfg(323011099)
				local var_418_38 = arg_415_1:FormatText(var_418_37.content)

				arg_415_1.text_.text = var_418_38

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_39 = 2
				local var_418_40 = utf8.len(var_418_38)
				local var_418_41 = var_418_39 <= 0 and var_418_34 or var_418_34 * (var_418_40 / var_418_39)

				if var_418_41 > 0 and var_418_34 < var_418_41 then
					arg_415_1.talkMaxDuration = var_418_41
					var_418_33 = var_418_33 + 0.3

					if var_418_41 + var_418_33 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_41 + var_418_33
					end
				end

				arg_415_1.text_.text = var_418_38
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_42 = var_418_33 + 0.3
			local var_418_43 = math.max(var_418_34, arg_415_1.talkMaxDuration)

			if var_418_42 <= arg_415_1.time_ and arg_415_1.time_ < var_418_42 + var_418_43 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_42) / var_418_43

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_42 + var_418_43 and arg_415_1.time_ < var_418_42 + var_418_43 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play323011100 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 323011100
		arg_422_1.duration_ = 2.77

		local var_422_0 = {
			zh = 2.7,
			ja = 2.766
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play323011101(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = "1071ui_story"

			if arg_422_1.actors_[var_425_0] == nil then
				local var_425_1 = Asset.Load("Char/" .. "1071ui_story")

				if not isNil(var_425_1) then
					local var_425_2 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_422_1.stage_.transform)

					var_425_2.name = var_425_0
					var_425_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_422_1.actors_[var_425_0] = var_425_2

					local var_425_3 = var_425_2:GetComponentInChildren(typeof(CharacterEffect))

					var_425_3.enabled = true

					local var_425_4 = GameObjectTools.GetOrAddComponent(var_425_2, typeof(DynamicBoneHelper))

					if var_425_4 then
						var_425_4:EnableDynamicBone(false)
					end

					arg_422_1:ShowWeapon(var_425_3.transform, false)

					arg_422_1.var_[var_425_0 .. "Animator"] = var_425_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_422_1.var_[var_425_0 .. "Animator"].applyRootMotion = true
					arg_422_1.var_[var_425_0 .. "LipSync"] = var_425_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_425_5 = arg_422_1.actors_["1071ui_story"]
			local var_425_6 = 0

			if var_425_6 < arg_422_1.time_ and arg_422_1.time_ <= var_425_6 + arg_425_0 and not isNil(var_425_5) and arg_422_1.var_.characterEffect1071ui_story == nil then
				arg_422_1.var_.characterEffect1071ui_story = var_425_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_7 = 0.200000002980232

			if var_425_6 <= arg_422_1.time_ and arg_422_1.time_ < var_425_6 + var_425_7 and not isNil(var_425_5) then
				local var_425_8 = (arg_422_1.time_ - var_425_6) / var_425_7

				if arg_422_1.var_.characterEffect1071ui_story and not isNil(var_425_5) then
					arg_422_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= var_425_6 + var_425_7 and arg_422_1.time_ < var_425_6 + var_425_7 + arg_425_0 and not isNil(var_425_5) and arg_422_1.var_.characterEffect1071ui_story then
				arg_422_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_425_9 = 0
			local var_425_10 = 0.225

			if var_425_9 < arg_422_1.time_ and arg_422_1.time_ <= var_425_9 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				local var_425_11 = arg_422_1:FormatText(StoryNameCfg[384].name)

				arg_422_1.leftNameTxt_.text = var_425_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_12 = arg_422_1:GetWordFromCfg(323011100)
				local var_425_13 = arg_422_1:FormatText(var_425_12.content)

				arg_422_1.text_.text = var_425_13

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_14 = 9
				local var_425_15 = utf8.len(var_425_13)
				local var_425_16 = var_425_14 <= 0 and var_425_10 or var_425_10 * (var_425_15 / var_425_14)

				if var_425_16 > 0 and var_425_10 < var_425_16 then
					arg_422_1.talkMaxDuration = var_425_16

					if var_425_16 + var_425_9 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_16 + var_425_9
					end
				end

				arg_422_1.text_.text = var_425_13
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011100", "story_v_out_323011.awb") ~= 0 then
					local var_425_17 = manager.audio:GetVoiceLength("story_v_out_323011", "323011100", "story_v_out_323011.awb") / 1000

					if var_425_17 + var_425_9 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_17 + var_425_9
					end

					if var_425_12.prefab_name ~= "" and arg_422_1.actors_[var_425_12.prefab_name] ~= nil then
						local var_425_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_12.prefab_name].transform, "story_v_out_323011", "323011100", "story_v_out_323011.awb")

						arg_422_1:RecordAudio("323011100", var_425_18)
						arg_422_1:RecordAudio("323011100", var_425_18)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_323011", "323011100", "story_v_out_323011.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_323011", "323011100", "story_v_out_323011.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_19 = math.max(var_425_10, arg_422_1.talkMaxDuration)

			if var_425_9 <= arg_422_1.time_ and arg_422_1.time_ < var_425_9 + var_425_19 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_9) / var_425_19

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_9 + var_425_19 and arg_422_1.time_ < var_425_9 + var_425_19 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play323011101 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 323011101
		arg_426_1.duration_ = 7.67

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play323011102(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = "J13f"

			if arg_426_1.bgs_[var_429_0] == nil then
				local var_429_1 = Object.Instantiate(arg_426_1.paintGo_)

				var_429_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_429_0)
				var_429_1.name = var_429_0
				var_429_1.transform.parent = arg_426_1.stage_.transform
				var_429_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_426_1.bgs_[var_429_0] = var_429_1
			end

			local var_429_2 = 1

			if var_429_2 < arg_426_1.time_ and arg_426_1.time_ <= var_429_2 + arg_429_0 then
				local var_429_3 = manager.ui.mainCamera.transform.localPosition
				local var_429_4 = Vector3.New(0, 0, 10) + Vector3.New(var_429_3.x, var_429_3.y, 0)
				local var_429_5 = arg_426_1.bgs_.J13f

				var_429_5.transform.localPosition = var_429_4
				var_429_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_429_6 = var_429_5:GetComponent("SpriteRenderer")

				if var_429_6 and var_429_6.sprite then
					local var_429_7 = (var_429_5.transform.localPosition - var_429_3).z
					local var_429_8 = manager.ui.mainCameraCom_
					local var_429_9 = 2 * var_429_7 * Mathf.Tan(var_429_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_429_10 = var_429_9 * var_429_8.aspect
					local var_429_11 = var_429_6.sprite.bounds.size.x
					local var_429_12 = var_429_6.sprite.bounds.size.y
					local var_429_13 = var_429_10 / var_429_11
					local var_429_14 = var_429_9 / var_429_12
					local var_429_15 = var_429_14 < var_429_13 and var_429_13 or var_429_14

					var_429_5.transform.localScale = Vector3.New(var_429_15, var_429_15, 0)
				end

				for iter_429_0, iter_429_1 in pairs(arg_426_1.bgs_) do
					if iter_429_0 ~= "J13f" then
						iter_429_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_429_16 = 0

			if var_429_16 < arg_426_1.time_ and arg_426_1.time_ <= var_429_16 + arg_429_0 then
				arg_426_1.allBtn_.enabled = false
			end

			local var_429_17 = 0.3

			if arg_426_1.time_ >= var_429_16 + var_429_17 and arg_426_1.time_ < var_429_16 + var_429_17 + arg_429_0 then
				arg_426_1.allBtn_.enabled = true
			end

			local var_429_18 = 0

			if var_429_18 < arg_426_1.time_ and arg_426_1.time_ <= var_429_18 + arg_429_0 then
				arg_426_1.mask_.enabled = true
				arg_426_1.mask_.raycastTarget = true

				arg_426_1:SetGaussion(false)
			end

			local var_429_19 = 1

			if var_429_18 <= arg_426_1.time_ and arg_426_1.time_ < var_429_18 + var_429_19 then
				local var_429_20 = (arg_426_1.time_ - var_429_18) / var_429_19
				local var_429_21 = Color.New(0, 0, 0)

				var_429_21.a = Mathf.Lerp(0, 1, var_429_20)
				arg_426_1.mask_.color = var_429_21
			end

			if arg_426_1.time_ >= var_429_18 + var_429_19 and arg_426_1.time_ < var_429_18 + var_429_19 + arg_429_0 then
				local var_429_22 = Color.New(0, 0, 0)

				var_429_22.a = 1
				arg_426_1.mask_.color = var_429_22
			end

			local var_429_23 = 0.975

			if var_429_23 < arg_426_1.time_ and arg_426_1.time_ <= var_429_23 + arg_429_0 then
				arg_426_1.mask_.enabled = true
				arg_426_1.mask_.raycastTarget = true

				arg_426_1:SetGaussion(false)
			end

			local var_429_24 = 1.96666666666667

			if var_429_23 <= arg_426_1.time_ and arg_426_1.time_ < var_429_23 + var_429_24 then
				local var_429_25 = (arg_426_1.time_ - var_429_23) / var_429_24
				local var_429_26 = Color.New(0, 0, 0)

				var_429_26.a = Mathf.Lerp(1, 0, var_429_25)
				arg_426_1.mask_.color = var_429_26
			end

			if arg_426_1.time_ >= var_429_23 + var_429_24 and arg_426_1.time_ < var_429_23 + var_429_24 + arg_429_0 then
				local var_429_27 = Color.New(0, 0, 0)
				local var_429_28 = 0

				arg_426_1.mask_.enabled = false
				var_429_27.a = var_429_28
				arg_426_1.mask_.color = var_429_27
			end

			local var_429_29 = arg_426_1.actors_["1071ui_story"]
			local var_429_30 = 0

			if var_429_30 < arg_426_1.time_ and arg_426_1.time_ <= var_429_30 + arg_429_0 and not isNil(var_429_29) and arg_426_1.var_.characterEffect1071ui_story == nil then
				arg_426_1.var_.characterEffect1071ui_story = var_429_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_31 = 0.200000002980232

			if var_429_30 <= arg_426_1.time_ and arg_426_1.time_ < var_429_30 + var_429_31 and not isNil(var_429_29) then
				local var_429_32 = (arg_426_1.time_ - var_429_30) / var_429_31

				if arg_426_1.var_.characterEffect1071ui_story and not isNil(var_429_29) then
					local var_429_33 = Mathf.Lerp(0, 0.5, var_429_32)

					arg_426_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_426_1.var_.characterEffect1071ui_story.fillRatio = var_429_33
				end
			end

			if arg_426_1.time_ >= var_429_30 + var_429_31 and arg_426_1.time_ < var_429_30 + var_429_31 + arg_429_0 and not isNil(var_429_29) and arg_426_1.var_.characterEffect1071ui_story then
				local var_429_34 = 0.5

				arg_426_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_426_1.var_.characterEffect1071ui_story.fillRatio = var_429_34
			end

			local var_429_35 = 0.1
			local var_429_36 = 1

			if var_429_35 < arg_426_1.time_ and arg_426_1.time_ <= var_429_35 + arg_429_0 then
				local var_429_37 = "stop"
				local var_429_38 = "effect"

				arg_426_1:AudioAction(var_429_37, var_429_38, "se_story_148", "se_story_148_amb_wind", "")
			end

			local var_429_39 = 0.7
			local var_429_40 = 1

			if var_429_39 < arg_426_1.time_ and arg_426_1.time_ <= var_429_39 + arg_429_0 then
				local var_429_41 = "play"
				local var_429_42 = "effect"

				arg_426_1:AudioAction(var_429_41, var_429_42, "se_story_1311", "se_story_1311_wind", "")
			end

			if arg_426_1.frameCnt_ <= 1 then
				arg_426_1.dialog_:SetActive(false)
			end

			local var_429_43 = 2.66666666666667
			local var_429_44 = 0.975

			if var_429_43 < arg_426_1.time_ and arg_426_1.time_ <= var_429_43 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0

				arg_426_1.dialog_:SetActive(true)

				arg_426_1.dialogCg_.alpha = 0

				local var_429_45 = LeanTween.value(arg_426_1.dialog_, 0, 1, 0.3)

				var_429_45:setOnUpdate(LuaHelper.FloatAction(function(arg_430_0)
					arg_426_1.dialogCg_.alpha = arg_430_0
				end))
				var_429_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_426_1.dialog_)
					var_429_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_426_1.duration_ = arg_426_1.duration_ + 0.3

				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_46 = arg_426_1:GetWordFromCfg(323011101)
				local var_429_47 = arg_426_1:FormatText(var_429_46.content)

				arg_426_1.text_.text = var_429_47

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_48 = 39
				local var_429_49 = utf8.len(var_429_47)
				local var_429_50 = var_429_48 <= 0 and var_429_44 or var_429_44 * (var_429_49 / var_429_48)

				if var_429_50 > 0 and var_429_44 < var_429_50 then
					arg_426_1.talkMaxDuration = var_429_50
					var_429_43 = var_429_43 + 0.3

					if var_429_50 + var_429_43 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_50 + var_429_43
					end
				end

				arg_426_1.text_.text = var_429_47
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_51 = var_429_43 + 0.3
			local var_429_52 = math.max(var_429_44, arg_426_1.talkMaxDuration)

			if var_429_51 <= arg_426_1.time_ and arg_426_1.time_ < var_429_51 + var_429_52 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_51) / var_429_52

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_51 + var_429_52 and arg_426_1.time_ < var_429_51 + var_429_52 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play323011102 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 323011102
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play323011103(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0
			local var_435_1 = 1.45

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_2 = arg_432_1:GetWordFromCfg(323011102)
				local var_435_3 = arg_432_1:FormatText(var_435_2.content)

				arg_432_1.text_.text = var_435_3

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_4 = 58
				local var_435_5 = utf8.len(var_435_3)
				local var_435_6 = var_435_4 <= 0 and var_435_1 or var_435_1 * (var_435_5 / var_435_4)

				if var_435_6 > 0 and var_435_1 < var_435_6 then
					arg_432_1.talkMaxDuration = var_435_6

					if var_435_6 + var_435_0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_6 + var_435_0
					end
				end

				arg_432_1.text_.text = var_435_3
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_7 = math.max(var_435_1, arg_432_1.talkMaxDuration)

			if var_435_0 <= arg_432_1.time_ and arg_432_1.time_ < var_435_0 + var_435_7 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_0) / var_435_7

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_0 + var_435_7 and arg_432_1.time_ < var_435_0 + var_435_7 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play323011103 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 323011103
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play323011104(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0
			local var_439_1 = 0.45

			if var_439_0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_2 = arg_436_1:GetWordFromCfg(323011103)
				local var_439_3 = arg_436_1:FormatText(var_439_2.content)

				arg_436_1.text_.text = var_439_3

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_4 = 18
				local var_439_5 = utf8.len(var_439_3)
				local var_439_6 = var_439_4 <= 0 and var_439_1 or var_439_1 * (var_439_5 / var_439_4)

				if var_439_6 > 0 and var_439_1 < var_439_6 then
					arg_436_1.talkMaxDuration = var_439_6

					if var_439_6 + var_439_0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_6 + var_439_0
					end
				end

				arg_436_1.text_.text = var_439_3
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_7 = math.max(var_439_1, arg_436_1.talkMaxDuration)

			if var_439_0 <= arg_436_1.time_ and arg_436_1.time_ < var_439_0 + var_439_7 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_0) / var_439_7

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_0 + var_439_7 and arg_436_1.time_ < var_439_0 + var_439_7 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play323011104 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 323011104
		arg_440_1.duration_ = 3.33

		local var_440_0 = {
			zh = 1.2,
			ja = 3.333
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play323011105(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["1071ui_story"]
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect1071ui_story == nil then
				arg_440_1.var_.characterEffect1071ui_story = var_443_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_2 = 0.200000002980232

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 and not isNil(var_443_0) then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2

				if arg_440_1.var_.characterEffect1071ui_story and not isNil(var_443_0) then
					arg_440_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 and not isNil(var_443_0) and arg_440_1.var_.characterEffect1071ui_story then
				arg_440_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_443_4 = 0
			local var_443_5 = 0.1

			if var_443_4 < arg_440_1.time_ and arg_440_1.time_ <= var_443_4 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_6 = arg_440_1:FormatText(StoryNameCfg[384].name)

				arg_440_1.leftNameTxt_.text = var_443_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_7 = arg_440_1:GetWordFromCfg(323011104)
				local var_443_8 = arg_440_1:FormatText(var_443_7.content)

				arg_440_1.text_.text = var_443_8

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_9 = 4
				local var_443_10 = utf8.len(var_443_8)
				local var_443_11 = var_443_9 <= 0 and var_443_5 or var_443_5 * (var_443_10 / var_443_9)

				if var_443_11 > 0 and var_443_5 < var_443_11 then
					arg_440_1.talkMaxDuration = var_443_11

					if var_443_11 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_11 + var_443_4
					end
				end

				arg_440_1.text_.text = var_443_8
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011104", "story_v_out_323011.awb") ~= 0 then
					local var_443_12 = manager.audio:GetVoiceLength("story_v_out_323011", "323011104", "story_v_out_323011.awb") / 1000

					if var_443_12 + var_443_4 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_12 + var_443_4
					end

					if var_443_7.prefab_name ~= "" and arg_440_1.actors_[var_443_7.prefab_name] ~= nil then
						local var_443_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_7.prefab_name].transform, "story_v_out_323011", "323011104", "story_v_out_323011.awb")

						arg_440_1:RecordAudio("323011104", var_443_13)
						arg_440_1:RecordAudio("323011104", var_443_13)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_323011", "323011104", "story_v_out_323011.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_323011", "323011104", "story_v_out_323011.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_14 = math.max(var_443_5, arg_440_1.talkMaxDuration)

			if var_443_4 <= arg_440_1.time_ and arg_440_1.time_ < var_443_4 + var_443_14 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_4) / var_443_14

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_4 + var_443_14 and arg_440_1.time_ < var_443_4 + var_443_14 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play323011105 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 323011105
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play323011106(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["1071ui_story"]
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect1071ui_story == nil then
				arg_444_1.var_.characterEffect1071ui_story = var_447_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_2 = 0.200000002980232

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 and not isNil(var_447_0) then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2

				if arg_444_1.var_.characterEffect1071ui_story and not isNil(var_447_0) then
					local var_447_4 = Mathf.Lerp(0, 0.5, var_447_3)

					arg_444_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_444_1.var_.characterEffect1071ui_story.fillRatio = var_447_4
				end
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 and not isNil(var_447_0) and arg_444_1.var_.characterEffect1071ui_story then
				local var_447_5 = 0.5

				arg_444_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_444_1.var_.characterEffect1071ui_story.fillRatio = var_447_5
			end

			local var_447_6 = 0
			local var_447_7 = 0.2

			if var_447_6 < arg_444_1.time_ and arg_444_1.time_ <= var_447_6 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_8 = arg_444_1:FormatText(StoryNameCfg[7].name)

				arg_444_1.leftNameTxt_.text = var_447_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_9 = arg_444_1:GetWordFromCfg(323011105)
				local var_447_10 = arg_444_1:FormatText(var_447_9.content)

				arg_444_1.text_.text = var_447_10

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_11 = 8
				local var_447_12 = utf8.len(var_447_10)
				local var_447_13 = var_447_11 <= 0 and var_447_7 or var_447_7 * (var_447_12 / var_447_11)

				if var_447_13 > 0 and var_447_7 < var_447_13 then
					arg_444_1.talkMaxDuration = var_447_13

					if var_447_13 + var_447_6 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_13 + var_447_6
					end
				end

				arg_444_1.text_.text = var_447_10
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_14 = math.max(var_447_7, arg_444_1.talkMaxDuration)

			if var_447_6 <= arg_444_1.time_ and arg_444_1.time_ < var_447_6 + var_447_14 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_6) / var_447_14

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_6 + var_447_14 and arg_444_1.time_ < var_447_6 + var_447_14 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play323011106 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 323011106
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
			arg_448_1.auto_ = false
		end

		function arg_448_1.playNext_(arg_450_0)
			arg_448_1.onStoryFinished_()
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0
			local var_451_1 = 0.8

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, false)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_2 = arg_448_1:GetWordFromCfg(323011106)
				local var_451_3 = arg_448_1:FormatText(var_451_2.content)

				arg_448_1.text_.text = var_451_3

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_4 = 32
				local var_451_5 = utf8.len(var_451_3)
				local var_451_6 = var_451_4 <= 0 and var_451_1 or var_451_1 * (var_451_5 / var_451_4)

				if var_451_6 > 0 and var_451_1 < var_451_6 then
					arg_448_1.talkMaxDuration = var_451_6

					if var_451_6 + var_451_0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_6 + var_451_0
					end
				end

				arg_448_1.text_.text = var_451_3
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_7 = math.max(var_451_1, arg_448_1.talkMaxDuration)

			if var_451_0 <= arg_448_1.time_ and arg_448_1.time_ < var_451_0 + var_451_7 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_0) / var_451_7

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_0 + var_451_7 and arg_448_1.time_ < var_451_0 + var_451_7 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"SofdecAsset/story/story_103230101.usm",
		"TextureConfig/Background/ST2015",
		"TextureConfig/Background/J21h",
		"TextureConfig/Background/J21f",
		"TextureConfig/Background/J13f"
	},
	voices = {
		"story_v_out_323011.awb"
	}
}
