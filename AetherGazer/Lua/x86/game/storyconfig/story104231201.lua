return {
	Play423121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423121001
		arg_1_1.duration_ = 4.57

		local var_1_0 = {
			zh = 4.566,
			ja = 4.3
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
				arg_1_0:Play423121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST0112a"

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
				local var_4_5 = arg_1_1.bgs_.ST0112a

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
					if iter_4_0 ~= "ST0112a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.4

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

			local var_4_24 = ""

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(var_4_25, arg_1_1.canvasGo_.transform)

					var_4_26.transform:SetSiblingIndex(1)

					var_4_26.name = var_4_24
					var_4_26.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_24] = var_4_26

					local var_4_27 = var_4_26:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs(var_4_27) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_28 = arg_1_1.actors_[""]
			local var_4_29 = 1.8

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps == nil then
				arg_1_1.var_.actorSpriteComps = var_4_28:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_30 = 0.2

			if var_4_29 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 and not isNil(var_4_28) then
				local var_4_31 = (arg_1_1.time_ - var_4_29) / var_4_30

				if arg_1_1.var_.actorSpriteComps then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								local var_4_32 = Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, var_4_31)
								local var_4_33 = Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, var_4_31)
								local var_4_34 = Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, var_4_31)

								iter_4_5.color = Color.New(var_4_32, var_4_33, var_4_34)
							else
								local var_4_35 = Mathf.Lerp(iter_4_5.color.r, 1, var_4_31)

								iter_4_5.color = Color.New(var_4_35, var_4_35, var_4_35)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 and not isNil(var_4_28) and arg_1_1.var_.actorSpriteComps then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps:ToTable()) do
					if iter_4_7 then
						if arg_1_1.isInRecall_ then
							iter_4_7.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_4_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_1_1.var_.actorSpriteComps = nil
			end

			local var_4_36 = "3054"

			if arg_1_1.actors_[var_4_36] == nil then
				local var_4_37 = Asset.Load("Widget/System/Story/StoryExpression/" .. "3054")

				if not isNil(var_4_37) then
					local var_4_38 = Object.Instantiate(var_4_37, arg_1_1.canvasGo_.transform)

					var_4_38.transform:SetSiblingIndex(1)

					var_4_38.name = var_4_36
					var_4_38.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_36] = var_4_38

					local var_4_39 = var_4_38:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_8, iter_4_9 in ipairs(var_4_39) do
							iter_4_9.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_40 = arg_1_1.actors_["3054"].transform
			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.var_.moveOldPos3054 = var_4_40.localPosition
				var_4_40.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("3054", 2)

				local var_4_42 = var_4_40.childCount

				for iter_4_10 = 0, var_4_42 - 1 do
					local var_4_43 = var_4_40:GetChild(iter_4_10)

					if var_4_43.name == "split_3" or not string.find(var_4_43.name, "split") then
						var_4_43.gameObject:SetActive(true)
					else
						var_4_43.gameObject:SetActive(false)
					end
				end
			end

			local var_4_44 = 0.001

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_44 then
				local var_4_45 = (arg_1_1.time_ - var_4_41) / var_4_44
				local var_4_46 = Vector3.New(-390, -275, -280)

				var_4_40.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos3054, var_4_46, var_4_45)
			end

			if arg_1_1.time_ >= var_4_41 + var_4_44 and arg_1_1.time_ < var_4_41 + var_4_44 + arg_4_0 then
				var_4_40.localPosition = Vector3.New(-390, -275, -280)
			end

			local var_4_47 = "10146"

			if arg_1_1.actors_[var_4_47] == nil then
				local var_4_48 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10146")

				if not isNil(var_4_48) then
					local var_4_49 = Object.Instantiate(var_4_48, arg_1_1.canvasGo_.transform)

					var_4_49.transform:SetSiblingIndex(1)

					var_4_49.name = var_4_47
					var_4_49.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_47] = var_4_49

					local var_4_50 = var_4_49:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_1_1.isInRecall_ then
						for iter_4_11, iter_4_12 in ipairs(var_4_50) do
							iter_4_12.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_51 = arg_1_1.actors_["10146"].transform
			local var_4_52 = 2.299999999999

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.var_.moveOldPos10146 = var_4_51.localPosition
				var_4_51.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10146", 4)

				local var_4_53 = var_4_51.childCount

				for iter_4_13 = 0, var_4_53 - 1 do
					local var_4_54 = var_4_51:GetChild(iter_4_13)

					if var_4_54.name == "split_6" or not string.find(var_4_54.name, "split") then
						var_4_54.gameObject:SetActive(true)
					else
						var_4_54.gameObject:SetActive(false)
					end
				end
			end

			local var_4_55 = 0.001

			if var_4_52 <= arg_1_1.time_ and arg_1_1.time_ < var_4_52 + var_4_55 then
				local var_4_56 = (arg_1_1.time_ - var_4_52) / var_4_55
				local var_4_57 = Vector3.New(390, -350, -320)

				var_4_51.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10146, var_4_57, var_4_56)
			end

			if arg_1_1.time_ >= var_4_52 + var_4_55 and arg_1_1.time_ < var_4_52 + var_4_55 + arg_4_0 then
				var_4_51.localPosition = Vector3.New(390, -350, -320)
			end

			local var_4_58 = arg_1_1.actors_["10146"]
			local var_4_59 = 2.299999999999

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				local var_4_60 = var_4_58:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_60 then
					arg_1_1.var_.alphaOldValue10146 = var_4_60.alpha
					arg_1_1.var_.characterEffect10146 = var_4_60
				end

				arg_1_1.var_.alphaOldValue10146 = 0
			end

			local var_4_61 = 0.5

			if var_4_59 <= arg_1_1.time_ and arg_1_1.time_ < var_4_59 + var_4_61 then
				local var_4_62 = (arg_1_1.time_ - var_4_59) / var_4_61
				local var_4_63 = Mathf.Lerp(arg_1_1.var_.alphaOldValue10146, 1, var_4_62)

				if arg_1_1.var_.characterEffect10146 then
					arg_1_1.var_.characterEffect10146.alpha = var_4_63
				end
			end

			if arg_1_1.time_ >= var_4_59 + var_4_61 and arg_1_1.time_ < var_4_59 + var_4_61 + arg_4_0 and arg_1_1.var_.characterEffect10146 then
				arg_1_1.var_.characterEffect10146.alpha = 1
			end

			local var_4_64 = arg_1_1.actors_["3054"]
			local var_4_65 = 1.799999999999

			if var_4_65 < arg_1_1.time_ and arg_1_1.time_ <= var_4_65 + arg_4_0 then
				local var_4_66 = var_4_64:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_66 then
					arg_1_1.var_.alphaOldValue3054 = var_4_66.alpha
					arg_1_1.var_.characterEffect3054 = var_4_66
				end

				arg_1_1.var_.alphaOldValue3054 = 0
			end

			local var_4_67 = 0.5

			if var_4_65 <= arg_1_1.time_ and arg_1_1.time_ < var_4_65 + var_4_67 then
				local var_4_68 = (arg_1_1.time_ - var_4_65) / var_4_67
				local var_4_69 = Mathf.Lerp(arg_1_1.var_.alphaOldValue3054, 1, var_4_68)

				if arg_1_1.var_.characterEffect3054 then
					arg_1_1.var_.characterEffect3054.alpha = var_4_69
				end
			end

			if arg_1_1.time_ >= var_4_65 + var_4_67 and arg_1_1.time_ < var_4_65 + var_4_67 + arg_4_0 and arg_1_1.var_.characterEffect3054 then
				arg_1_1.var_.characterEffect3054.alpha = 1
			end

			local var_4_70 = 0.166666666666667
			local var_4_71 = 1

			if var_4_70 < arg_1_1.time_ and arg_1_1.time_ <= var_4_70 + arg_4_0 then
				local var_4_72 = "play"
				local var_4_73 = "effect"

				arg_1_1:AudioAction(var_4_72, var_4_73, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_4_74 = 0
			local var_4_75 = 0.3

			if var_4_74 < arg_1_1.time_ and arg_1_1.time_ <= var_4_74 + arg_4_0 then
				local var_4_76 = "play"
				local var_4_77 = "music"

				arg_1_1:AudioAction(var_4_76, var_4_77, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_78 = ""
				local var_4_79 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_79 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_79 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_79

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_79
						arg_1_1.bgmTxt2_.text = var_4_79
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

			local var_4_80 = 0.500666666666667
			local var_4_81 = 1

			if var_4_80 < arg_1_1.time_ and arg_1_1.time_ <= var_4_80 + arg_4_0 then
				local var_4_82 = "play"
				local var_4_83 = "music"

				arg_1_1:AudioAction(var_4_82, var_4_83, "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_4_84 = ""
				local var_4_85 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if var_4_85 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_85 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_85

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_85
						arg_1_1.bgmTxt2_.text = var_4_85
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

			local var_4_86 = 2
			local var_4_87 = 0.05

			if var_4_86 < arg_1_1.time_ and arg_1_1.time_ <= var_4_86 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_88 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_88:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_88:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_88:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_89 = arg_1_1:FormatText(StoryNameCfg[1349].name)

				arg_1_1.leftNameTxt_.text = var_4_89

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_90 = arg_1_1:GetWordFromCfg(423121001)
				local var_4_91 = arg_1_1:FormatText(var_4_90.content)

				arg_1_1.text_.text = var_4_91

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_92 = 2
				local var_4_93 = utf8.len(var_4_91)
				local var_4_94 = var_4_92 <= 0 and var_4_87 or var_4_87 * (var_4_93 / var_4_92)

				if var_4_94 > 0 and var_4_87 < var_4_94 then
					arg_1_1.talkMaxDuration = var_4_94
					var_4_86 = var_4_86 + 0.3

					if var_4_94 + var_4_86 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_94 + var_4_86
					end
				end

				arg_1_1.text_.text = var_4_91
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121001", "story_v_out_423121.awb") ~= 0 then
					local var_4_95 = manager.audio:GetVoiceLength("story_v_out_423121", "423121001", "story_v_out_423121.awb") / 1000

					if var_4_95 + var_4_86 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_95 + var_4_86
					end

					if var_4_90.prefab_name ~= "" and arg_1_1.actors_[var_4_90.prefab_name] ~= nil then
						local var_4_96 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_90.prefab_name].transform, "story_v_out_423121", "423121001", "story_v_out_423121.awb")

						arg_1_1:RecordAudio("423121001", var_4_96)
						arg_1_1:RecordAudio("423121001", var_4_96)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423121", "423121001", "story_v_out_423121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423121", "423121001", "story_v_out_423121.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_97 = var_4_86 + 0.3
			local var_4_98 = math.max(var_4_87, arg_1_1.talkMaxDuration)

			if var_4_97 <= arg_1_1.time_ and arg_1_1.time_ < var_4_97 + var_4_98 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_97) / var_4_98

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_97 + var_4_98 and arg_1_1.time_ < var_4_97 + var_4_98 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.299999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play423121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423121002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play423121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["3054"]
			local var_12_1 = 0.034

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				local var_12_2 = var_12_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_2 then
					arg_9_1.var_.alphaOldValue3054 = var_12_2.alpha
					arg_9_1.var_.characterEffect3054 = var_12_2
				end

				arg_9_1.var_.alphaOldValue3054 = 1
			end

			local var_12_3 = 0.5

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_3 then
				local var_12_4 = (arg_9_1.time_ - var_12_1) / var_12_3
				local var_12_5 = Mathf.Lerp(arg_9_1.var_.alphaOldValue3054, 0, var_12_4)

				if arg_9_1.var_.characterEffect3054 then
					arg_9_1.var_.characterEffect3054.alpha = var_12_5
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_3 and arg_9_1.time_ < var_12_1 + var_12_3 + arg_12_0 and arg_9_1.var_.characterEffect3054 then
				arg_9_1.var_.characterEffect3054.alpha = 0
			end

			local var_12_6 = arg_9_1.actors_["10146"]
			local var_12_7 = 0

			if var_12_7 < arg_9_1.time_ and arg_9_1.time_ <= var_12_7 + arg_12_0 then
				local var_12_8 = var_12_6:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_8 then
					arg_9_1.var_.alphaOldValue10146 = var_12_8.alpha
					arg_9_1.var_.characterEffect10146 = var_12_8
				end

				arg_9_1.var_.alphaOldValue10146 = 1
			end

			local var_12_9 = 0.5

			if var_12_7 <= arg_9_1.time_ and arg_9_1.time_ < var_12_7 + var_12_9 then
				local var_12_10 = (arg_9_1.time_ - var_12_7) / var_12_9
				local var_12_11 = Mathf.Lerp(arg_9_1.var_.alphaOldValue10146, 0, var_12_10)

				if arg_9_1.var_.characterEffect10146 then
					arg_9_1.var_.characterEffect10146.alpha = var_12_11
				end
			end

			if arg_9_1.time_ >= var_12_7 + var_12_9 and arg_9_1.time_ < var_12_7 + var_12_9 + arg_12_0 and arg_9_1.var_.characterEffect10146 then
				arg_9_1.var_.characterEffect10146.alpha = 0
			end

			local var_12_12 = 0
			local var_12_13 = 1.675

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(423121002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_16 = 67
				local var_12_17 = utf8.len(var_12_15)
				local var_12_18 = var_12_16 <= 0 and var_12_13 or var_12_13 * (var_12_17 / var_12_16)

				if var_12_18 > 0 and var_12_13 < var_12_18 then
					arg_9_1.talkMaxDuration = var_12_18

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_19 = math.max(var_12_13, arg_9_1.talkMaxDuration)

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_19 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_12) / var_12_19

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_12 + var_12_19 and arg_9_1.time_ < var_12_12 + var_12_19 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play423121003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423121003
		arg_13_1.duration_ = 9.23

		local var_13_0 = {
			zh = 6.8,
			ja = 9.233
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
				arg_13_0:Play423121004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.675

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[1335].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(423121003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121003", "story_v_out_423121.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_423121", "423121003", "story_v_out_423121.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_423121", "423121003", "story_v_out_423121.awb")

						arg_13_1:RecordAudio("423121003", var_16_9)
						arg_13_1:RecordAudio("423121003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_423121", "423121003", "story_v_out_423121.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_423121", "423121003", "story_v_out_423121.awb")
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
	Play423121004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423121004
		arg_17_1.duration_ = 6.57

		local var_17_0 = {
			zh = 6.433,
			ja = 6.566
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
				arg_17_0:Play423121005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.65

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[1335].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(423121004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121004", "story_v_out_423121.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_423121", "423121004", "story_v_out_423121.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_423121", "423121004", "story_v_out_423121.awb")

						arg_17_1:RecordAudio("423121004", var_20_9)
						arg_17_1:RecordAudio("423121004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_423121", "423121004", "story_v_out_423121.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_423121", "423121004", "story_v_out_423121.awb")
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
	Play423121005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423121005
		arg_21_1.duration_ = 5.27

		local var_21_0 = {
			zh = 3.566,
			ja = 5.266
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
				arg_21_0:Play423121006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["10146"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10146 == nil then
				arg_21_1.var_.actorSpriteComps10146 = var_24_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_2 = 0.2

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.actorSpriteComps10146 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								local var_24_4 = Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, var_24_3)
								local var_24_5 = Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, var_24_3)
								local var_24_6 = Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, var_24_3)

								iter_24_1.color = Color.New(var_24_4, var_24_5, var_24_6)
							else
								local var_24_7 = Mathf.Lerp(iter_24_1.color.r, 1, var_24_3)

								iter_24_1.color = Color.New(var_24_7, var_24_7, var_24_7)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.actorSpriteComps10146 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_24_3 then
						if arg_21_1.isInRecall_ then
							iter_24_3.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps10146 = nil
			end

			local var_24_8 = arg_21_1.actors_["10146"].transform
			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.var_.moveOldPos10146 = var_24_8.localPosition
				var_24_8.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10146", 3)

				local var_24_10 = var_24_8.childCount

				for iter_24_4 = 0, var_24_10 - 1 do
					local var_24_11 = var_24_8:GetChild(iter_24_4)

					if var_24_11.name == "split_6" or not string.find(var_24_11.name, "split") then
						var_24_11.gameObject:SetActive(true)
					else
						var_24_11.gameObject:SetActive(false)
					end
				end
			end

			local var_24_12 = 0.001

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_12 then
				local var_24_13 = (arg_21_1.time_ - var_24_9) / var_24_12
				local var_24_14 = Vector3.New(0, -350, -320)

				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10146, var_24_14, var_24_13)
			end

			if arg_21_1.time_ >= var_24_9 + var_24_12 and arg_21_1.time_ < var_24_9 + var_24_12 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(0, -350, -320)
			end

			local var_24_15 = arg_21_1.actors_["10146"]
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				local var_24_17 = var_24_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_24_17 then
					arg_21_1.var_.alphaOldValue10146 = var_24_17.alpha
					arg_21_1.var_.characterEffect10146 = var_24_17
				end

				arg_21_1.var_.alphaOldValue10146 = 0
			end

			local var_24_18 = 0.034

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_18 then
				local var_24_19 = (arg_21_1.time_ - var_24_16) / var_24_18
				local var_24_20 = Mathf.Lerp(arg_21_1.var_.alphaOldValue10146, 1, var_24_19)

				if arg_21_1.var_.characterEffect10146 then
					arg_21_1.var_.characterEffect10146.alpha = var_24_20
				end
			end

			if arg_21_1.time_ >= var_24_16 + var_24_18 and arg_21_1.time_ < var_24_16 + var_24_18 + arg_24_0 and arg_21_1.var_.characterEffect10146 then
				arg_21_1.var_.characterEffect10146.alpha = 1
			end

			local var_24_21 = 0
			local var_24_22 = 0.35

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_23 = arg_21_1:FormatText(StoryNameCfg[1338].name)

				arg_21_1.leftNameTxt_.text = var_24_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_24 = arg_21_1:GetWordFromCfg(423121005)
				local var_24_25 = arg_21_1:FormatText(var_24_24.content)

				arg_21_1.text_.text = var_24_25

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_26 = 14
				local var_24_27 = utf8.len(var_24_25)
				local var_24_28 = var_24_26 <= 0 and var_24_22 or var_24_22 * (var_24_27 / var_24_26)

				if var_24_28 > 0 and var_24_22 < var_24_28 then
					arg_21_1.talkMaxDuration = var_24_28

					if var_24_28 + var_24_21 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_28 + var_24_21
					end
				end

				arg_21_1.text_.text = var_24_25
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121005", "story_v_out_423121.awb") ~= 0 then
					local var_24_29 = manager.audio:GetVoiceLength("story_v_out_423121", "423121005", "story_v_out_423121.awb") / 1000

					if var_24_29 + var_24_21 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_29 + var_24_21
					end

					if var_24_24.prefab_name ~= "" and arg_21_1.actors_[var_24_24.prefab_name] ~= nil then
						local var_24_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_24.prefab_name].transform, "story_v_out_423121", "423121005", "story_v_out_423121.awb")

						arg_21_1:RecordAudio("423121005", var_24_30)
						arg_21_1:RecordAudio("423121005", var_24_30)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_423121", "423121005", "story_v_out_423121.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_423121", "423121005", "story_v_out_423121.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_31 = math.max(var_24_22, arg_21_1.talkMaxDuration)

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_31 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_21) / var_24_31

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_21 + var_24_31 and arg_21_1.time_ < var_24_21 + var_24_31 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play423121006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423121006
		arg_25_1.duration_ = 8.07

		local var_25_0 = {
			zh = 5.933,
			ja = 8.066
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
				arg_25_0:Play423121007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10146"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10146 == nil then
				arg_25_1.var_.actorSpriteComps10146 = var_28_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.actorSpriteComps10146 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								local var_28_4 = Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor2.r, var_28_3)
								local var_28_5 = Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor2.g, var_28_3)
								local var_28_6 = Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor2.b, var_28_3)

								iter_28_1.color = Color.New(var_28_4, var_28_5, var_28_6)
							else
								local var_28_7 = Mathf.Lerp(iter_28_1.color.r, 0.5, var_28_3)

								iter_28_1.color = Color.New(var_28_7, var_28_7, var_28_7)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.actorSpriteComps10146 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_28_3 then
						if arg_25_1.isInRecall_ then
							iter_28_3.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10146 = nil
			end

			local var_28_8 = arg_25_1.actors_["10146"].transform
			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.var_.moveOldPos10146 = var_28_8.localPosition
				var_28_8.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10146", 7)

				local var_28_10 = var_28_8.childCount

				for iter_28_4 = 0, var_28_10 - 1 do
					local var_28_11 = var_28_8:GetChild(iter_28_4)

					if var_28_11.name == "" or not string.find(var_28_11.name, "split") then
						var_28_11.gameObject:SetActive(true)
					else
						var_28_11.gameObject:SetActive(false)
					end
				end
			end

			local var_28_12 = 0.001

			if var_28_9 <= arg_25_1.time_ and arg_25_1.time_ < var_28_9 + var_28_12 then
				local var_28_13 = (arg_25_1.time_ - var_28_9) / var_28_12
				local var_28_14 = Vector3.New(0, -2000, 0)

				var_28_8.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10146, var_28_14, var_28_13)
			end

			if arg_25_1.time_ >= var_28_9 + var_28_12 and arg_25_1.time_ < var_28_9 + var_28_12 + arg_28_0 then
				var_28_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_28_15 = 0
			local var_28_16 = 0.475

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[1336].name)

				arg_25_1.leftNameTxt_.text = var_28_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_18 = arg_25_1:GetWordFromCfg(423121006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 19
				local var_28_21 = utf8.len(var_28_19)
				local var_28_22 = var_28_20 <= 0 and var_28_16 or var_28_16 * (var_28_21 / var_28_20)

				if var_28_22 > 0 and var_28_16 < var_28_22 then
					arg_25_1.talkMaxDuration = var_28_22

					if var_28_22 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121006", "story_v_out_423121.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121006", "story_v_out_423121.awb") / 1000

					if var_28_23 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_15
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_423121", "423121006", "story_v_out_423121.awb")

						arg_25_1:RecordAudio("423121006", var_28_24)
						arg_25_1:RecordAudio("423121006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_423121", "423121006", "story_v_out_423121.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_423121", "423121006", "story_v_out_423121.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_25 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_25 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_25

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_25 and arg_25_1.time_ < var_28_15 + var_28_25 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play423121007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423121007
		arg_29_1.duration_ = 9.83

		local var_29_0 = {
			zh = 6.866,
			ja = 9.833
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
				arg_29_0:Play423121008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.875

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[1336].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(423121007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121007", "story_v_out_423121.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_423121", "423121007", "story_v_out_423121.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_423121", "423121007", "story_v_out_423121.awb")

						arg_29_1:RecordAudio("423121007", var_32_9)
						arg_29_1:RecordAudio("423121007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_423121", "423121007", "story_v_out_423121.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_423121", "423121007", "story_v_out_423121.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play423121008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423121008
		arg_33_1.duration_ = 12.43

		local var_33_0 = {
			zh = 9.333,
			ja = 12.433
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
				arg_33_0:Play423121009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.2

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[1336].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_3 = arg_33_1:GetWordFromCfg(423121008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121008", "story_v_out_423121.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_423121", "423121008", "story_v_out_423121.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_423121", "423121008", "story_v_out_423121.awb")

						arg_33_1:RecordAudio("423121008", var_36_9)
						arg_33_1:RecordAudio("423121008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_423121", "423121008", "story_v_out_423121.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_423121", "423121008", "story_v_out_423121.awb")
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
	Play423121009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423121009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play423121010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 1.275

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

				local var_40_2 = arg_37_1:GetWordFromCfg(423121009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 51
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
	Play423121010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423121010
		arg_41_1.duration_ = 13.4

		local var_41_0 = {
			zh = 6.333,
			ja = 13.4
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
				arg_41_0:Play423121011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10146"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10146 == nil then
				arg_41_1.var_.actorSpriteComps10146 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps10146 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								local var_44_4 = Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor1.r, var_44_3)
								local var_44_5 = Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor1.g, var_44_3)
								local var_44_6 = Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor1.b, var_44_3)

								iter_44_1.color = Color.New(var_44_4, var_44_5, var_44_6)
							else
								local var_44_7 = Mathf.Lerp(iter_44_1.color.r, 1, var_44_3)

								iter_44_1.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps10146 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10146 = nil
			end

			local var_44_8 = arg_41_1.actors_["10146"].transform
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.var_.moveOldPos10146 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10146", 3)

				local var_44_10 = var_44_8.childCount

				for iter_44_4 = 0, var_44_10 - 1 do
					local var_44_11 = var_44_8:GetChild(iter_44_4)

					if var_44_11.name == "split_4" or not string.find(var_44_11.name, "split") then
						var_44_11.gameObject:SetActive(true)
					else
						var_44_11.gameObject:SetActive(false)
					end
				end
			end

			local var_44_12 = 0.001

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_12 then
				local var_44_13 = (arg_41_1.time_ - var_44_9) / var_44_12
				local var_44_14 = Vector3.New(0, -350, -320)

				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10146, var_44_14, var_44_13)
			end

			if arg_41_1.time_ >= var_44_9 + var_44_12 and arg_41_1.time_ < var_44_9 + var_44_12 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(0, -350, -320)
			end

			local var_44_15 = 0
			local var_44_16 = 0.775

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[1338].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(423121010)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 31
				local var_44_21 = utf8.len(var_44_19)
				local var_44_22 = var_44_20 <= 0 and var_44_16 or var_44_16 * (var_44_21 / var_44_20)

				if var_44_22 > 0 and var_44_16 < var_44_22 then
					arg_41_1.talkMaxDuration = var_44_22

					if var_44_22 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_22 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_19
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121010", "story_v_out_423121.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121010", "story_v_out_423121.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_423121", "423121010", "story_v_out_423121.awb")

						arg_41_1:RecordAudio("423121010", var_44_24)
						arg_41_1:RecordAudio("423121010", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423121", "423121010", "story_v_out_423121.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423121", "423121010", "story_v_out_423121.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_25 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_25

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_25 and arg_41_1.time_ < var_44_15 + var_44_25 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play423121011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423121011
		arg_45_1.duration_ = 7.9

		local var_45_0 = {
			zh = 4.8,
			ja = 7.9
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
				arg_45_0:Play423121012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.65

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[1338].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(423121011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121011", "story_v_out_423121.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_423121", "423121011", "story_v_out_423121.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_423121", "423121011", "story_v_out_423121.awb")

						arg_45_1:RecordAudio("423121011", var_48_9)
						arg_45_1:RecordAudio("423121011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_423121", "423121011", "story_v_out_423121.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_423121", "423121011", "story_v_out_423121.awb")
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
	Play423121012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423121012
		arg_49_1.duration_ = 8.1

		local var_49_0 = {
			zh = 6.966,
			ja = 8.1
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
				arg_49_0:Play423121013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["3054"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps3054 == nil then
				arg_49_1.var_.actorSpriteComps3054 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps3054 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_52_1 then
							if arg_49_1.isInRecall_ then
								local var_52_4 = Mathf.Lerp(iter_52_1.color.r, arg_49_1.hightColor1.r, var_52_3)
								local var_52_5 = Mathf.Lerp(iter_52_1.color.g, arg_49_1.hightColor1.g, var_52_3)
								local var_52_6 = Mathf.Lerp(iter_52_1.color.b, arg_49_1.hightColor1.b, var_52_3)

								iter_52_1.color = Color.New(var_52_4, var_52_5, var_52_6)
							else
								local var_52_7 = Mathf.Lerp(iter_52_1.color.r, 1, var_52_3)

								iter_52_1.color = Color.New(var_52_7, var_52_7, var_52_7)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps3054 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps3054 = nil
			end

			local var_52_8 = arg_49_1.actors_["10146"]
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10146 == nil then
				arg_49_1.var_.actorSpriteComps10146 = var_52_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_10 = 0.2

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_10 and not isNil(var_52_8) then
				local var_52_11 = (arg_49_1.time_ - var_52_9) / var_52_10

				if arg_49_1.var_.actorSpriteComps10146 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_52_5 then
							if arg_49_1.isInRecall_ then
								local var_52_12 = Mathf.Lerp(iter_52_5.color.r, arg_49_1.hightColor2.r, var_52_11)
								local var_52_13 = Mathf.Lerp(iter_52_5.color.g, arg_49_1.hightColor2.g, var_52_11)
								local var_52_14 = Mathf.Lerp(iter_52_5.color.b, arg_49_1.hightColor2.b, var_52_11)

								iter_52_5.color = Color.New(var_52_12, var_52_13, var_52_14)
							else
								local var_52_15 = Mathf.Lerp(iter_52_5.color.r, 0.5, var_52_11)

								iter_52_5.color = Color.New(var_52_15, var_52_15, var_52_15)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_9 + var_52_10 and arg_49_1.time_ < var_52_9 + var_52_10 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps10146 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_52_7 then
						if arg_49_1.isInRecall_ then
							iter_52_7.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10146 = nil
			end

			local var_52_16 = arg_49_1.actors_["3054"].transform
			local var_52_17 = 0

			if var_52_17 < arg_49_1.time_ and arg_49_1.time_ <= var_52_17 + arg_52_0 then
				arg_49_1.var_.moveOldPos3054 = var_52_16.localPosition
				var_52_16.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("3054", 2)

				local var_52_18 = var_52_16.childCount

				for iter_52_8 = 0, var_52_18 - 1 do
					local var_52_19 = var_52_16:GetChild(iter_52_8)

					if var_52_19.name == "" or not string.find(var_52_19.name, "split") then
						var_52_19.gameObject:SetActive(true)
					else
						var_52_19.gameObject:SetActive(false)
					end
				end
			end

			local var_52_20 = 0.001

			if var_52_17 <= arg_49_1.time_ and arg_49_1.time_ < var_52_17 + var_52_20 then
				local var_52_21 = (arg_49_1.time_ - var_52_17) / var_52_20
				local var_52_22 = Vector3.New(-390, -275, -280)

				var_52_16.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos3054, var_52_22, var_52_21)
			end

			if arg_49_1.time_ >= var_52_17 + var_52_20 and arg_49_1.time_ < var_52_17 + var_52_20 + arg_52_0 then
				var_52_16.localPosition = Vector3.New(-390, -275, -280)
			end

			local var_52_23 = arg_49_1.actors_["10146"].transform
			local var_52_24 = 0

			if var_52_24 < arg_49_1.time_ and arg_49_1.time_ <= var_52_24 + arg_52_0 then
				arg_49_1.var_.moveOldPos10146 = var_52_23.localPosition
				var_52_23.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10146", 4)

				local var_52_25 = var_52_23.childCount

				for iter_52_9 = 0, var_52_25 - 1 do
					local var_52_26 = var_52_23:GetChild(iter_52_9)

					if var_52_26.name == "split_4" or not string.find(var_52_26.name, "split") then
						var_52_26.gameObject:SetActive(true)
					else
						var_52_26.gameObject:SetActive(false)
					end
				end
			end

			local var_52_27 = 0.001

			if var_52_24 <= arg_49_1.time_ and arg_49_1.time_ < var_52_24 + var_52_27 then
				local var_52_28 = (arg_49_1.time_ - var_52_24) / var_52_27
				local var_52_29 = Vector3.New(390, -350, -320)

				var_52_23.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10146, var_52_29, var_52_28)
			end

			if arg_49_1.time_ >= var_52_24 + var_52_27 and arg_49_1.time_ < var_52_24 + var_52_27 + arg_52_0 then
				var_52_23.localPosition = Vector3.New(390, -350, -320)
			end

			local var_52_30 = arg_49_1.actors_["3054"]
			local var_52_31 = 0

			if var_52_31 < arg_49_1.time_ and arg_49_1.time_ <= var_52_31 + arg_52_0 then
				local var_52_32 = var_52_30:GetComponentInChildren(typeof(CanvasGroup))

				if var_52_32 then
					arg_49_1.var_.alphaOldValue3054 = var_52_32.alpha
					arg_49_1.var_.characterEffect3054 = var_52_32
				end

				arg_49_1.var_.alphaOldValue3054 = 0
			end

			local var_52_33 = 0.034

			if var_52_31 <= arg_49_1.time_ and arg_49_1.time_ < var_52_31 + var_52_33 then
				local var_52_34 = (arg_49_1.time_ - var_52_31) / var_52_33
				local var_52_35 = Mathf.Lerp(arg_49_1.var_.alphaOldValue3054, 1, var_52_34)

				if arg_49_1.var_.characterEffect3054 then
					arg_49_1.var_.characterEffect3054.alpha = var_52_35
				end
			end

			if arg_49_1.time_ >= var_52_31 + var_52_33 and arg_49_1.time_ < var_52_31 + var_52_33 + arg_52_0 and arg_49_1.var_.characterEffect3054 then
				arg_49_1.var_.characterEffect3054.alpha = 1
			end

			local var_52_36 = 0
			local var_52_37 = 0.575

			if var_52_36 < arg_49_1.time_ and arg_49_1.time_ <= var_52_36 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_38 = arg_49_1:FormatText(StoryNameCfg[1339].name)

				arg_49_1.leftNameTxt_.text = var_52_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_39 = arg_49_1:GetWordFromCfg(423121012)
				local var_52_40 = arg_49_1:FormatText(var_52_39.content)

				arg_49_1.text_.text = var_52_40

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_41 = 23
				local var_52_42 = utf8.len(var_52_40)
				local var_52_43 = var_52_41 <= 0 and var_52_37 or var_52_37 * (var_52_42 / var_52_41)

				if var_52_43 > 0 and var_52_37 < var_52_43 then
					arg_49_1.talkMaxDuration = var_52_43

					if var_52_43 + var_52_36 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_43 + var_52_36
					end
				end

				arg_49_1.text_.text = var_52_40
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121012", "story_v_out_423121.awb") ~= 0 then
					local var_52_44 = manager.audio:GetVoiceLength("story_v_out_423121", "423121012", "story_v_out_423121.awb") / 1000

					if var_52_44 + var_52_36 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_44 + var_52_36
					end

					if var_52_39.prefab_name ~= "" and arg_49_1.actors_[var_52_39.prefab_name] ~= nil then
						local var_52_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_39.prefab_name].transform, "story_v_out_423121", "423121012", "story_v_out_423121.awb")

						arg_49_1:RecordAudio("423121012", var_52_45)
						arg_49_1:RecordAudio("423121012", var_52_45)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_423121", "423121012", "story_v_out_423121.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_423121", "423121012", "story_v_out_423121.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_46 = math.max(var_52_37, arg_49_1.talkMaxDuration)

			if var_52_36 <= arg_49_1.time_ and arg_49_1.time_ < var_52_36 + var_52_46 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_36) / var_52_46

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_36 + var_52_46 and arg_49_1.time_ < var_52_36 + var_52_46 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play423121013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423121013
		arg_53_1.duration_ = 7.27

		local var_53_0 = {
			zh = 5.733,
			ja = 7.266
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
				arg_53_0:Play423121014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.575

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1339].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(423121013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121013", "story_v_out_423121.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_423121", "423121013", "story_v_out_423121.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_423121", "423121013", "story_v_out_423121.awb")

						arg_53_1:RecordAudio("423121013", var_56_9)
						arg_53_1:RecordAudio("423121013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_423121", "423121013", "story_v_out_423121.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_423121", "423121013", "story_v_out_423121.awb")
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
	Play423121014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 423121014
		arg_57_1.duration_ = 6.5

		local var_57_0 = {
			zh = 6.5,
			ja = 6.466
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
				arg_57_0:Play423121015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.65

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[1339].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(423121014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121014", "story_v_out_423121.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_423121", "423121014", "story_v_out_423121.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_423121", "423121014", "story_v_out_423121.awb")

						arg_57_1:RecordAudio("423121014", var_60_9)
						arg_57_1:RecordAudio("423121014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_423121", "423121014", "story_v_out_423121.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_423121", "423121014", "story_v_out_423121.awb")
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
	Play423121015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 423121015
		arg_61_1.duration_ = 9.2

		local var_61_0 = {
			zh = 5.333,
			ja = 9.2
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
				arg_61_0:Play423121016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10146"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10146 == nil then
				arg_61_1.var_.actorSpriteComps10146 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.2

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10146 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 1, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10146 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10146 = nil
			end

			local var_64_8 = arg_61_1.actors_["3054"]
			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps3054 == nil then
				arg_61_1.var_.actorSpriteComps3054 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_10 = 0.2

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 and not isNil(var_64_8) then
				local var_64_11 = (arg_61_1.time_ - var_64_9) / var_64_10

				if arg_61_1.var_.actorSpriteComps3054 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_12 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor2.r, var_64_11)
								local var_64_13 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor2.g, var_64_11)
								local var_64_14 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor2.b, var_64_11)

								iter_64_5.color = Color.New(var_64_12, var_64_13, var_64_14)
							else
								local var_64_15 = Mathf.Lerp(iter_64_5.color.r, 0.5, var_64_11)

								iter_64_5.color = Color.New(var_64_15, var_64_15, var_64_15)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps3054 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps3054 = nil
			end

			local var_64_16 = arg_61_1.actors_["10146"].transform
			local var_64_17 = 0

			if var_64_17 < arg_61_1.time_ and arg_61_1.time_ <= var_64_17 + arg_64_0 then
				arg_61_1.var_.moveOldPos10146 = var_64_16.localPosition
				var_64_16.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10146", 4)

				local var_64_18 = var_64_16.childCount

				for iter_64_8 = 0, var_64_18 - 1 do
					local var_64_19 = var_64_16:GetChild(iter_64_8)

					if var_64_19.name == "split_6" or not string.find(var_64_19.name, "split") then
						var_64_19.gameObject:SetActive(true)
					else
						var_64_19.gameObject:SetActive(false)
					end
				end
			end

			local var_64_20 = 0.001

			if var_64_17 <= arg_61_1.time_ and arg_61_1.time_ < var_64_17 + var_64_20 then
				local var_64_21 = (arg_61_1.time_ - var_64_17) / var_64_20
				local var_64_22 = Vector3.New(390, -350, -320)

				var_64_16.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10146, var_64_22, var_64_21)
			end

			if arg_61_1.time_ >= var_64_17 + var_64_20 and arg_61_1.time_ < var_64_17 + var_64_20 + arg_64_0 then
				var_64_16.localPosition = Vector3.New(390, -350, -320)
			end

			local var_64_23 = 0
			local var_64_24 = 0.575

			if var_64_23 < arg_61_1.time_ and arg_61_1.time_ <= var_64_23 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_25 = arg_61_1:FormatText(StoryNameCfg[1338].name)

				arg_61_1.leftNameTxt_.text = var_64_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_26 = arg_61_1:GetWordFromCfg(423121015)
				local var_64_27 = arg_61_1:FormatText(var_64_26.content)

				arg_61_1.text_.text = var_64_27

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_28 = 23
				local var_64_29 = utf8.len(var_64_27)
				local var_64_30 = var_64_28 <= 0 and var_64_24 or var_64_24 * (var_64_29 / var_64_28)

				if var_64_30 > 0 and var_64_24 < var_64_30 then
					arg_61_1.talkMaxDuration = var_64_30

					if var_64_30 + var_64_23 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_30 + var_64_23
					end
				end

				arg_61_1.text_.text = var_64_27
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121015", "story_v_out_423121.awb") ~= 0 then
					local var_64_31 = manager.audio:GetVoiceLength("story_v_out_423121", "423121015", "story_v_out_423121.awb") / 1000

					if var_64_31 + var_64_23 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_31 + var_64_23
					end

					if var_64_26.prefab_name ~= "" and arg_61_1.actors_[var_64_26.prefab_name] ~= nil then
						local var_64_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_26.prefab_name].transform, "story_v_out_423121", "423121015", "story_v_out_423121.awb")

						arg_61_1:RecordAudio("423121015", var_64_32)
						arg_61_1:RecordAudio("423121015", var_64_32)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_423121", "423121015", "story_v_out_423121.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_423121", "423121015", "story_v_out_423121.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_33 = math.max(var_64_24, arg_61_1.talkMaxDuration)

			if var_64_23 <= arg_61_1.time_ and arg_61_1.time_ < var_64_23 + var_64_33 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_23) / var_64_33

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_23 + var_64_33 and arg_61_1.time_ < var_64_23 + var_64_33 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play423121016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 423121016
		arg_65_1.duration_ = 11.4

		local var_65_0 = {
			zh = 6.566,
			ja = 11.4
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
				arg_65_0:Play423121017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["3054"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps3054 == nil then
				arg_65_1.var_.actorSpriteComps3054 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps3054 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 1, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps3054 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps3054 = nil
			end

			local var_68_8 = arg_65_1.actors_["10146"]
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10146 == nil then
				arg_65_1.var_.actorSpriteComps10146 = var_68_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_10 = 0.2

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_10 and not isNil(var_68_8) then
				local var_68_11 = (arg_65_1.time_ - var_68_9) / var_68_10

				if arg_65_1.var_.actorSpriteComps10146 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								local var_68_12 = Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor2.r, var_68_11)
								local var_68_13 = Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor2.g, var_68_11)
								local var_68_14 = Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor2.b, var_68_11)

								iter_68_5.color = Color.New(var_68_12, var_68_13, var_68_14)
							else
								local var_68_15 = Mathf.Lerp(iter_68_5.color.r, 0.5, var_68_11)

								iter_68_5.color = Color.New(var_68_15, var_68_15, var_68_15)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_9 + var_68_10 and arg_65_1.time_ < var_68_9 + var_68_10 + arg_68_0 and not isNil(var_68_8) and arg_65_1.var_.actorSpriteComps10146 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_68_7 then
						if arg_65_1.isInRecall_ then
							iter_68_7.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10146 = nil
			end

			local var_68_16 = 0
			local var_68_17 = 0.725

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_18 = arg_65_1:FormatText(StoryNameCfg[1339].name)

				arg_65_1.leftNameTxt_.text = var_68_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_19 = arg_65_1:GetWordFromCfg(423121016)
				local var_68_20 = arg_65_1:FormatText(var_68_19.content)

				arg_65_1.text_.text = var_68_20

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_21 = 29
				local var_68_22 = utf8.len(var_68_20)
				local var_68_23 = var_68_21 <= 0 and var_68_17 or var_68_17 * (var_68_22 / var_68_21)

				if var_68_23 > 0 and var_68_17 < var_68_23 then
					arg_65_1.talkMaxDuration = var_68_23

					if var_68_23 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_23 + var_68_16
					end
				end

				arg_65_1.text_.text = var_68_20
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121016", "story_v_out_423121.awb") ~= 0 then
					local var_68_24 = manager.audio:GetVoiceLength("story_v_out_423121", "423121016", "story_v_out_423121.awb") / 1000

					if var_68_24 + var_68_16 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_24 + var_68_16
					end

					if var_68_19.prefab_name ~= "" and arg_65_1.actors_[var_68_19.prefab_name] ~= nil then
						local var_68_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_19.prefab_name].transform, "story_v_out_423121", "423121016", "story_v_out_423121.awb")

						arg_65_1:RecordAudio("423121016", var_68_25)
						arg_65_1:RecordAudio("423121016", var_68_25)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_423121", "423121016", "story_v_out_423121.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_423121", "423121016", "story_v_out_423121.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_26 = math.max(var_68_17, arg_65_1.talkMaxDuration)

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_26 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_16) / var_68_26

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_16 + var_68_26 and arg_65_1.time_ < var_68_16 + var_68_26 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play423121017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 423121017
		arg_69_1.duration_ = 11.83

		local var_69_0 = {
			zh = 7.066,
			ja = 11.833
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play423121018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0
			local var_72_1 = 0.9

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_2 = arg_69_1:FormatText(StoryNameCfg[1339].name)

				arg_69_1.leftNameTxt_.text = var_72_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:GetWordFromCfg(423121017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 36
				local var_72_6 = utf8.len(var_72_4)
				local var_72_7 = var_72_5 <= 0 and var_72_1 or var_72_1 * (var_72_6 / var_72_5)

				if var_72_7 > 0 and var_72_1 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_0
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121017", "story_v_out_423121.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_423121", "423121017", "story_v_out_423121.awb") / 1000

					if var_72_8 + var_72_0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_0
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_423121", "423121017", "story_v_out_423121.awb")

						arg_69_1:RecordAudio("423121017", var_72_9)
						arg_69_1:RecordAudio("423121017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_423121", "423121017", "story_v_out_423121.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_423121", "423121017", "story_v_out_423121.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_1, arg_69_1.talkMaxDuration)

			if var_72_0 <= arg_69_1.time_ and arg_69_1.time_ < var_72_0 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_0) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_0 + var_72_10 and arg_69_1.time_ < var_72_0 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play423121018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 423121018
		arg_73_1.duration_ = 7.07

		local var_73_0 = {
			zh = 3.433,
			ja = 7.066
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
				arg_73_0:Play423121019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10146"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10146 == nil then
				arg_73_1.var_.actorSpriteComps10146 = var_76_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_2 = 0.2

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.actorSpriteComps10146 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								local var_76_4 = Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, var_76_3)
								local var_76_5 = Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, var_76_3)
								local var_76_6 = Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, var_76_3)

								iter_76_1.color = Color.New(var_76_4, var_76_5, var_76_6)
							else
								local var_76_7 = Mathf.Lerp(iter_76_1.color.r, 1, var_76_3)

								iter_76_1.color = Color.New(var_76_7, var_76_7, var_76_7)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.actorSpriteComps10146 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_76_3 then
						if arg_73_1.isInRecall_ then
							iter_76_3.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10146 = nil
			end

			local var_76_8 = arg_73_1.actors_["3054"]
			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps3054 == nil then
				arg_73_1.var_.actorSpriteComps3054 = var_76_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_10 = 0.2

			if var_76_9 <= arg_73_1.time_ and arg_73_1.time_ < var_76_9 + var_76_10 and not isNil(var_76_8) then
				local var_76_11 = (arg_73_1.time_ - var_76_9) / var_76_10

				if arg_73_1.var_.actorSpriteComps3054 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_76_5 then
							if arg_73_1.isInRecall_ then
								local var_76_12 = Mathf.Lerp(iter_76_5.color.r, arg_73_1.hightColor2.r, var_76_11)
								local var_76_13 = Mathf.Lerp(iter_76_5.color.g, arg_73_1.hightColor2.g, var_76_11)
								local var_76_14 = Mathf.Lerp(iter_76_5.color.b, arg_73_1.hightColor2.b, var_76_11)

								iter_76_5.color = Color.New(var_76_12, var_76_13, var_76_14)
							else
								local var_76_15 = Mathf.Lerp(iter_76_5.color.r, 0.5, var_76_11)

								iter_76_5.color = Color.New(var_76_15, var_76_15, var_76_15)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_9 + var_76_10 and arg_73_1.time_ < var_76_9 + var_76_10 + arg_76_0 and not isNil(var_76_8) and arg_73_1.var_.actorSpriteComps3054 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_76_7 then
						if arg_73_1.isInRecall_ then
							iter_76_7.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps3054 = nil
			end

			local var_76_16 = 0
			local var_76_17 = 0.375

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_18 = arg_73_1:FormatText(StoryNameCfg[1338].name)

				arg_73_1.leftNameTxt_.text = var_76_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_19 = arg_73_1:GetWordFromCfg(423121018)
				local var_76_20 = arg_73_1:FormatText(var_76_19.content)

				arg_73_1.text_.text = var_76_20

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_21 = 15
				local var_76_22 = utf8.len(var_76_20)
				local var_76_23 = var_76_21 <= 0 and var_76_17 or var_76_17 * (var_76_22 / var_76_21)

				if var_76_23 > 0 and var_76_17 < var_76_23 then
					arg_73_1.talkMaxDuration = var_76_23

					if var_76_23 + var_76_16 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_23 + var_76_16
					end
				end

				arg_73_1.text_.text = var_76_20
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121018", "story_v_out_423121.awb") ~= 0 then
					local var_76_24 = manager.audio:GetVoiceLength("story_v_out_423121", "423121018", "story_v_out_423121.awb") / 1000

					if var_76_24 + var_76_16 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_24 + var_76_16
					end

					if var_76_19.prefab_name ~= "" and arg_73_1.actors_[var_76_19.prefab_name] ~= nil then
						local var_76_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_19.prefab_name].transform, "story_v_out_423121", "423121018", "story_v_out_423121.awb")

						arg_73_1:RecordAudio("423121018", var_76_25)
						arg_73_1:RecordAudio("423121018", var_76_25)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_423121", "423121018", "story_v_out_423121.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_423121", "423121018", "story_v_out_423121.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_26 = math.max(var_76_17, arg_73_1.talkMaxDuration)

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_26 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_16) / var_76_26

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_16 + var_76_26 and arg_73_1.time_ < var_76_16 + var_76_26 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play423121019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 423121019
		arg_77_1.duration_ = 8.27

		local var_77_0 = {
			zh = 7.8,
			ja = 8.266
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
				arg_77_0:Play423121020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["3054"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps3054 == nil then
				arg_77_1.var_.actorSpriteComps3054 = var_80_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_2 = 0.2

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.actorSpriteComps3054 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								local var_80_4 = Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor1.r, var_80_3)
								local var_80_5 = Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor1.g, var_80_3)
								local var_80_6 = Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor1.b, var_80_3)

								iter_80_1.color = Color.New(var_80_4, var_80_5, var_80_6)
							else
								local var_80_7 = Mathf.Lerp(iter_80_1.color.r, 1, var_80_3)

								iter_80_1.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.actorSpriteComps3054 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_80_3 then
						if arg_77_1.isInRecall_ then
							iter_80_3.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps3054 = nil
			end

			local var_80_8 = arg_77_1.actors_["10146"]
			local var_80_9 = 0

			if var_80_9 < arg_77_1.time_ and arg_77_1.time_ <= var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10146 == nil then
				arg_77_1.var_.actorSpriteComps10146 = var_80_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_10 = 0.2

			if var_80_9 <= arg_77_1.time_ and arg_77_1.time_ < var_80_9 + var_80_10 and not isNil(var_80_8) then
				local var_80_11 = (arg_77_1.time_ - var_80_9) / var_80_10

				if arg_77_1.var_.actorSpriteComps10146 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								local var_80_12 = Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor2.r, var_80_11)
								local var_80_13 = Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor2.g, var_80_11)
								local var_80_14 = Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor2.b, var_80_11)

								iter_80_5.color = Color.New(var_80_12, var_80_13, var_80_14)
							else
								local var_80_15 = Mathf.Lerp(iter_80_5.color.r, 0.5, var_80_11)

								iter_80_5.color = Color.New(var_80_15, var_80_15, var_80_15)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_9 + var_80_10 and arg_77_1.time_ < var_80_9 + var_80_10 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10146 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_80_7 then
						if arg_77_1.isInRecall_ then
							iter_80_7.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10146 = nil
			end

			local var_80_16 = arg_77_1.actors_["3054"].transform
			local var_80_17 = 0

			if var_80_17 < arg_77_1.time_ and arg_77_1.time_ <= var_80_17 + arg_80_0 then
				arg_77_1.var_.moveOldPos3054 = var_80_16.localPosition
				var_80_16.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("3054", 2)

				local var_80_18 = var_80_16.childCount

				for iter_80_8 = 0, var_80_18 - 1 do
					local var_80_19 = var_80_16:GetChild(iter_80_8)

					if var_80_19.name == "split_3" or not string.find(var_80_19.name, "split") then
						var_80_19.gameObject:SetActive(true)
					else
						var_80_19.gameObject:SetActive(false)
					end
				end
			end

			local var_80_20 = 0.001

			if var_80_17 <= arg_77_1.time_ and arg_77_1.time_ < var_80_17 + var_80_20 then
				local var_80_21 = (arg_77_1.time_ - var_80_17) / var_80_20
				local var_80_22 = Vector3.New(-390, -275, -280)

				var_80_16.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos3054, var_80_22, var_80_21)
			end

			if arg_77_1.time_ >= var_80_17 + var_80_20 and arg_77_1.time_ < var_80_17 + var_80_20 + arg_80_0 then
				var_80_16.localPosition = Vector3.New(-390, -275, -280)
			end

			local var_80_23 = 0
			local var_80_24 = 0.725

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_25 = arg_77_1:FormatText(StoryNameCfg[1339].name)

				arg_77_1.leftNameTxt_.text = var_80_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_26 = arg_77_1:GetWordFromCfg(423121019)
				local var_80_27 = arg_77_1:FormatText(var_80_26.content)

				arg_77_1.text_.text = var_80_27

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_28 = 29
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

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121019", "story_v_out_423121.awb") ~= 0 then
					local var_80_31 = manager.audio:GetVoiceLength("story_v_out_423121", "423121019", "story_v_out_423121.awb") / 1000

					if var_80_31 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_31 + var_80_23
					end

					if var_80_26.prefab_name ~= "" and arg_77_1.actors_[var_80_26.prefab_name] ~= nil then
						local var_80_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_26.prefab_name].transform, "story_v_out_423121", "423121019", "story_v_out_423121.awb")

						arg_77_1:RecordAudio("423121019", var_80_32)
						arg_77_1:RecordAudio("423121019", var_80_32)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_423121", "423121019", "story_v_out_423121.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_423121", "423121019", "story_v_out_423121.awb")
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
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play423121020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 423121020
		arg_81_1.duration_ = 6.37

		local var_81_0 = {
			zh = 5.466,
			ja = 6.366
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
				arg_81_0:Play423121021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.575

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[1339].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(423121020)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 23
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121020", "story_v_out_423121.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_423121", "423121020", "story_v_out_423121.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_423121", "423121020", "story_v_out_423121.awb")

						arg_81_1:RecordAudio("423121020", var_84_9)
						arg_81_1:RecordAudio("423121020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_423121", "423121020", "story_v_out_423121.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_423121", "423121020", "story_v_out_423121.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play423121021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 423121021
		arg_85_1.duration_ = 4.57

		local var_85_0 = {
			zh = 3.1,
			ja = 4.566
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
				arg_85_0:Play423121022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10146"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10146 == nil then
				arg_85_1.var_.actorSpriteComps10146 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 0.2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps10146 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								local var_88_4 = Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, var_88_3)
								local var_88_5 = Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, var_88_3)
								local var_88_6 = Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, var_88_3)

								iter_88_1.color = Color.New(var_88_4, var_88_5, var_88_6)
							else
								local var_88_7 = Mathf.Lerp(iter_88_1.color.r, 1, var_88_3)

								iter_88_1.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10146 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10146 = nil
			end

			local var_88_8 = arg_85_1.actors_["3054"]
			local var_88_9 = 0

			if var_88_9 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps3054 == nil then
				arg_85_1.var_.actorSpriteComps3054 = var_88_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_10 = 0.2

			if var_88_9 <= arg_85_1.time_ and arg_85_1.time_ < var_88_9 + var_88_10 and not isNil(var_88_8) then
				local var_88_11 = (arg_85_1.time_ - var_88_9) / var_88_10

				if arg_85_1.var_.actorSpriteComps3054 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								local var_88_12 = Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor2.r, var_88_11)
								local var_88_13 = Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor2.g, var_88_11)
								local var_88_14 = Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor2.b, var_88_11)

								iter_88_5.color = Color.New(var_88_12, var_88_13, var_88_14)
							else
								local var_88_15 = Mathf.Lerp(iter_88_5.color.r, 0.5, var_88_11)

								iter_88_5.color = Color.New(var_88_15, var_88_15, var_88_15)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_9 + var_88_10 and arg_85_1.time_ < var_88_9 + var_88_10 + arg_88_0 and not isNil(var_88_8) and arg_85_1.var_.actorSpriteComps3054 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_88_7 then
						if arg_85_1.isInRecall_ then
							iter_88_7.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps3054 = nil
			end

			local var_88_16 = arg_85_1.actors_["10146"].transform
			local var_88_17 = 0

			if var_88_17 < arg_85_1.time_ and arg_85_1.time_ <= var_88_17 + arg_88_0 then
				arg_85_1.var_.moveOldPos10146 = var_88_16.localPosition
				var_88_16.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10146", 4)

				local var_88_18 = var_88_16.childCount

				for iter_88_8 = 0, var_88_18 - 1 do
					local var_88_19 = var_88_16:GetChild(iter_88_8)

					if var_88_19.name == "split_6" or not string.find(var_88_19.name, "split") then
						var_88_19.gameObject:SetActive(true)
					else
						var_88_19.gameObject:SetActive(false)
					end
				end
			end

			local var_88_20 = 0.001

			if var_88_17 <= arg_85_1.time_ and arg_85_1.time_ < var_88_17 + var_88_20 then
				local var_88_21 = (arg_85_1.time_ - var_88_17) / var_88_20
				local var_88_22 = Vector3.New(390, -350, -320)

				var_88_16.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10146, var_88_22, var_88_21)
			end

			if arg_85_1.time_ >= var_88_17 + var_88_20 and arg_85_1.time_ < var_88_17 + var_88_20 + arg_88_0 then
				var_88_16.localPosition = Vector3.New(390, -350, -320)
			end

			local var_88_23 = 0
			local var_88_24 = 0.425

			if var_88_23 < arg_85_1.time_ and arg_85_1.time_ <= var_88_23 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_25 = arg_85_1:FormatText(StoryNameCfg[1338].name)

				arg_85_1.leftNameTxt_.text = var_88_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_26 = arg_85_1:GetWordFromCfg(423121021)
				local var_88_27 = arg_85_1:FormatText(var_88_26.content)

				arg_85_1.text_.text = var_88_27

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_28 = 17
				local var_88_29 = utf8.len(var_88_27)
				local var_88_30 = var_88_28 <= 0 and var_88_24 or var_88_24 * (var_88_29 / var_88_28)

				if var_88_30 > 0 and var_88_24 < var_88_30 then
					arg_85_1.talkMaxDuration = var_88_30

					if var_88_30 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_30 + var_88_23
					end
				end

				arg_85_1.text_.text = var_88_27
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121021", "story_v_out_423121.awb") ~= 0 then
					local var_88_31 = manager.audio:GetVoiceLength("story_v_out_423121", "423121021", "story_v_out_423121.awb") / 1000

					if var_88_31 + var_88_23 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_31 + var_88_23
					end

					if var_88_26.prefab_name ~= "" and arg_85_1.actors_[var_88_26.prefab_name] ~= nil then
						local var_88_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_26.prefab_name].transform, "story_v_out_423121", "423121021", "story_v_out_423121.awb")

						arg_85_1:RecordAudio("423121021", var_88_32)
						arg_85_1:RecordAudio("423121021", var_88_32)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_423121", "423121021", "story_v_out_423121.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_423121", "423121021", "story_v_out_423121.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_33 = math.max(var_88_24, arg_85_1.talkMaxDuration)

			if var_88_23 <= arg_85_1.time_ and arg_85_1.time_ < var_88_23 + var_88_33 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_23) / var_88_33

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_23 + var_88_33 and arg_85_1.time_ < var_88_23 + var_88_33 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play423121022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 423121022
		arg_89_1.duration_ = 4.77

		local var_89_0 = {
			zh = 4.766,
			ja = 3.6
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
				arg_89_0:Play423121023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["3054"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps3054 == nil then
				arg_89_1.var_.actorSpriteComps3054 = var_92_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.actorSpriteComps3054 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_92_1 then
							if arg_89_1.isInRecall_ then
								local var_92_4 = Mathf.Lerp(iter_92_1.color.r, arg_89_1.hightColor1.r, var_92_3)
								local var_92_5 = Mathf.Lerp(iter_92_1.color.g, arg_89_1.hightColor1.g, var_92_3)
								local var_92_6 = Mathf.Lerp(iter_92_1.color.b, arg_89_1.hightColor1.b, var_92_3)

								iter_92_1.color = Color.New(var_92_4, var_92_5, var_92_6)
							else
								local var_92_7 = Mathf.Lerp(iter_92_1.color.r, 1, var_92_3)

								iter_92_1.color = Color.New(var_92_7, var_92_7, var_92_7)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.actorSpriteComps3054 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_92_3 then
						if arg_89_1.isInRecall_ then
							iter_92_3.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps3054 = nil
			end

			local var_92_8 = arg_89_1.actors_["10146"]
			local var_92_9 = 0

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10146 == nil then
				arg_89_1.var_.actorSpriteComps10146 = var_92_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_10 = 0.2

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_10 and not isNil(var_92_8) then
				local var_92_11 = (arg_89_1.time_ - var_92_9) / var_92_10

				if arg_89_1.var_.actorSpriteComps10146 then
					for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_92_5 then
							if arg_89_1.isInRecall_ then
								local var_92_12 = Mathf.Lerp(iter_92_5.color.r, arg_89_1.hightColor2.r, var_92_11)
								local var_92_13 = Mathf.Lerp(iter_92_5.color.g, arg_89_1.hightColor2.g, var_92_11)
								local var_92_14 = Mathf.Lerp(iter_92_5.color.b, arg_89_1.hightColor2.b, var_92_11)

								iter_92_5.color = Color.New(var_92_12, var_92_13, var_92_14)
							else
								local var_92_15 = Mathf.Lerp(iter_92_5.color.r, 0.5, var_92_11)

								iter_92_5.color = Color.New(var_92_15, var_92_15, var_92_15)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_9 + var_92_10 and arg_89_1.time_ < var_92_9 + var_92_10 + arg_92_0 and not isNil(var_92_8) and arg_89_1.var_.actorSpriteComps10146 then
				for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_92_7 then
						if arg_89_1.isInRecall_ then
							iter_92_7.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10146 = nil
			end

			local var_92_16 = 0
			local var_92_17 = 0.425

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_18 = arg_89_1:FormatText(StoryNameCfg[1339].name)

				arg_89_1.leftNameTxt_.text = var_92_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_19 = arg_89_1:GetWordFromCfg(423121022)
				local var_92_20 = arg_89_1:FormatText(var_92_19.content)

				arg_89_1.text_.text = var_92_20

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_21 = 17
				local var_92_22 = utf8.len(var_92_20)
				local var_92_23 = var_92_21 <= 0 and var_92_17 or var_92_17 * (var_92_22 / var_92_21)

				if var_92_23 > 0 and var_92_17 < var_92_23 then
					arg_89_1.talkMaxDuration = var_92_23

					if var_92_23 + var_92_16 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_16
					end
				end

				arg_89_1.text_.text = var_92_20
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121022", "story_v_out_423121.awb") ~= 0 then
					local var_92_24 = manager.audio:GetVoiceLength("story_v_out_423121", "423121022", "story_v_out_423121.awb") / 1000

					if var_92_24 + var_92_16 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_24 + var_92_16
					end

					if var_92_19.prefab_name ~= "" and arg_89_1.actors_[var_92_19.prefab_name] ~= nil then
						local var_92_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_19.prefab_name].transform, "story_v_out_423121", "423121022", "story_v_out_423121.awb")

						arg_89_1:RecordAudio("423121022", var_92_25)
						arg_89_1:RecordAudio("423121022", var_92_25)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_423121", "423121022", "story_v_out_423121.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_423121", "423121022", "story_v_out_423121.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_26 = math.max(var_92_17, arg_89_1.talkMaxDuration)

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_26 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_16) / var_92_26

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_16 + var_92_26 and arg_89_1.time_ < var_92_16 + var_92_26 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play423121023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 423121023
		arg_93_1.duration_ = 8.77

		local var_93_0 = {
			zh = 5.7,
			ja = 8.766
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
				arg_93_0:Play423121024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10146"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10146 == nil then
				arg_93_1.var_.actorSpriteComps10146 = var_96_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_2 = 0.2

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.actorSpriteComps10146 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_96_1 then
							if arg_93_1.isInRecall_ then
								local var_96_4 = Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor1.r, var_96_3)
								local var_96_5 = Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor1.g, var_96_3)
								local var_96_6 = Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor1.b, var_96_3)

								iter_96_1.color = Color.New(var_96_4, var_96_5, var_96_6)
							else
								local var_96_7 = Mathf.Lerp(iter_96_1.color.r, 1, var_96_3)

								iter_96_1.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.actorSpriteComps10146 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_96_3 then
						if arg_93_1.isInRecall_ then
							iter_96_3.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10146 = nil
			end

			local var_96_8 = arg_93_1.actors_["3054"]
			local var_96_9 = 0

			if var_96_9 < arg_93_1.time_ and arg_93_1.time_ <= var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps3054 == nil then
				arg_93_1.var_.actorSpriteComps3054 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_10 = 0.2

			if var_96_9 <= arg_93_1.time_ and arg_93_1.time_ < var_96_9 + var_96_10 and not isNil(var_96_8) then
				local var_96_11 = (arg_93_1.time_ - var_96_9) / var_96_10

				if arg_93_1.var_.actorSpriteComps3054 then
					for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_96_5 then
							if arg_93_1.isInRecall_ then
								local var_96_12 = Mathf.Lerp(iter_96_5.color.r, arg_93_1.hightColor2.r, var_96_11)
								local var_96_13 = Mathf.Lerp(iter_96_5.color.g, arg_93_1.hightColor2.g, var_96_11)
								local var_96_14 = Mathf.Lerp(iter_96_5.color.b, arg_93_1.hightColor2.b, var_96_11)

								iter_96_5.color = Color.New(var_96_12, var_96_13, var_96_14)
							else
								local var_96_15 = Mathf.Lerp(iter_96_5.color.r, 0.5, var_96_11)

								iter_96_5.color = Color.New(var_96_15, var_96_15, var_96_15)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_9 + var_96_10 and arg_93_1.time_ < var_96_9 + var_96_10 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps3054 then
				for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_96_7 then
						if arg_93_1.isInRecall_ then
							iter_96_7.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps3054 = nil
			end

			local var_96_16 = 0
			local var_96_17 = 0.7

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_18 = arg_93_1:FormatText(StoryNameCfg[1338].name)

				arg_93_1.leftNameTxt_.text = var_96_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_19 = arg_93_1:GetWordFromCfg(423121023)
				local var_96_20 = arg_93_1:FormatText(var_96_19.content)

				arg_93_1.text_.text = var_96_20

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_21 = 28
				local var_96_22 = utf8.len(var_96_20)
				local var_96_23 = var_96_21 <= 0 and var_96_17 or var_96_17 * (var_96_22 / var_96_21)

				if var_96_23 > 0 and var_96_17 < var_96_23 then
					arg_93_1.talkMaxDuration = var_96_23

					if var_96_23 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_23 + var_96_16
					end
				end

				arg_93_1.text_.text = var_96_20
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121023", "story_v_out_423121.awb") ~= 0 then
					local var_96_24 = manager.audio:GetVoiceLength("story_v_out_423121", "423121023", "story_v_out_423121.awb") / 1000

					if var_96_24 + var_96_16 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_24 + var_96_16
					end

					if var_96_19.prefab_name ~= "" and arg_93_1.actors_[var_96_19.prefab_name] ~= nil then
						local var_96_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_19.prefab_name].transform, "story_v_out_423121", "423121023", "story_v_out_423121.awb")

						arg_93_1:RecordAudio("423121023", var_96_25)
						arg_93_1:RecordAudio("423121023", var_96_25)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_423121", "423121023", "story_v_out_423121.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_423121", "423121023", "story_v_out_423121.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_26 = math.max(var_96_17, arg_93_1.talkMaxDuration)

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_26 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_16) / var_96_26

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_16 + var_96_26 and arg_93_1.time_ < var_96_16 + var_96_26 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play423121024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 423121024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play423121025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10146"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10146 == nil then
				arg_97_1.var_.actorSpriteComps10146 = var_100_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_2 = 0.2

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.actorSpriteComps10146 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								local var_100_4 = Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, var_100_3)
								local var_100_5 = Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, var_100_3)
								local var_100_6 = Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, var_100_3)

								iter_100_1.color = Color.New(var_100_4, var_100_5, var_100_6)
							else
								local var_100_7 = Mathf.Lerp(iter_100_1.color.r, 0.5, var_100_3)

								iter_100_1.color = Color.New(var_100_7, var_100_7, var_100_7)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.actorSpriteComps10146 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_100_3 then
						if arg_97_1.isInRecall_ then
							iter_100_3.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10146 = nil
			end

			local var_100_8 = arg_97_1.actors_["10146"].transform
			local var_100_9 = 0

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.var_.moveOldPos10146 = var_100_8.localPosition
				var_100_8.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10146", 7)

				local var_100_10 = var_100_8.childCount

				for iter_100_4 = 0, var_100_10 - 1 do
					local var_100_11 = var_100_8:GetChild(iter_100_4)

					if var_100_11.name == "" or not string.find(var_100_11.name, "split") then
						var_100_11.gameObject:SetActive(true)
					else
						var_100_11.gameObject:SetActive(false)
					end
				end
			end

			local var_100_12 = 0.001

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_12 then
				local var_100_13 = (arg_97_1.time_ - var_100_9) / var_100_12
				local var_100_14 = Vector3.New(0, -2000, 0)

				var_100_8.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10146, var_100_14, var_100_13)
			end

			if arg_97_1.time_ >= var_100_9 + var_100_12 and arg_97_1.time_ < var_100_9 + var_100_12 + arg_100_0 then
				var_100_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_15 = arg_97_1.actors_["3054"].transform
			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 then
				arg_97_1.var_.moveOldPos3054 = var_100_15.localPosition
				var_100_15.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("3054", 7)

				local var_100_17 = var_100_15.childCount

				for iter_100_5 = 0, var_100_17 - 1 do
					local var_100_18 = var_100_15:GetChild(iter_100_5)

					if var_100_18.name == "" or not string.find(var_100_18.name, "split") then
						var_100_18.gameObject:SetActive(true)
					else
						var_100_18.gameObject:SetActive(false)
					end
				end
			end

			local var_100_19 = 0.001

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_19 then
				local var_100_20 = (arg_97_1.time_ - var_100_16) / var_100_19
				local var_100_21 = Vector3.New(0, -2000, 0)

				var_100_15.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos3054, var_100_21, var_100_20)
			end

			if arg_97_1.time_ >= var_100_16 + var_100_19 and arg_97_1.time_ < var_100_16 + var_100_19 + arg_100_0 then
				var_100_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_22 = 0
			local var_100_23 = 1.375

			if var_100_22 < arg_97_1.time_ and arg_97_1.time_ <= var_100_22 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_24 = arg_97_1:GetWordFromCfg(423121024)
				local var_100_25 = arg_97_1:FormatText(var_100_24.content)

				arg_97_1.text_.text = var_100_25

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_26 = 55
				local var_100_27 = utf8.len(var_100_25)
				local var_100_28 = var_100_26 <= 0 and var_100_23 or var_100_23 * (var_100_27 / var_100_26)

				if var_100_28 > 0 and var_100_23 < var_100_28 then
					arg_97_1.talkMaxDuration = var_100_28

					if var_100_28 + var_100_22 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_28 + var_100_22
					end
				end

				arg_97_1.text_.text = var_100_25
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_29 = math.max(var_100_23, arg_97_1.talkMaxDuration)

			if var_100_22 <= arg_97_1.time_ and arg_97_1.time_ < var_100_22 + var_100_29 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_22) / var_100_29

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_22 + var_100_29 and arg_97_1.time_ < var_100_22 + var_100_29 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play423121025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 423121025
		arg_101_1.duration_ = 7.8

		local var_101_0 = {
			zh = 5.733,
			ja = 7.8
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
				arg_101_0:Play423121026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["3054"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps3054 == nil then
				arg_101_1.var_.actorSpriteComps3054 = var_104_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_2 = 0.2

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.actorSpriteComps3054 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								local var_104_4 = Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor1.r, var_104_3)
								local var_104_5 = Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor1.g, var_104_3)
								local var_104_6 = Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor1.b, var_104_3)

								iter_104_1.color = Color.New(var_104_4, var_104_5, var_104_6)
							else
								local var_104_7 = Mathf.Lerp(iter_104_1.color.r, 1, var_104_3)

								iter_104_1.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.actorSpriteComps3054 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_104_3 then
						if arg_101_1.isInRecall_ then
							iter_104_3.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps3054 = nil
			end

			local var_104_8 = arg_101_1.actors_["3054"].transform
			local var_104_9 = 0

			if var_104_9 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 then
				arg_101_1.var_.moveOldPos3054 = var_104_8.localPosition
				var_104_8.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("3054", 4)

				local var_104_10 = var_104_8.childCount

				for iter_104_4 = 0, var_104_10 - 1 do
					local var_104_11 = var_104_8:GetChild(iter_104_4)

					if var_104_11.name == "split_3" or not string.find(var_104_11.name, "split") then
						var_104_11.gameObject:SetActive(true)
					else
						var_104_11.gameObject:SetActive(false)
					end
				end
			end

			local var_104_12 = 0.001

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_12 then
				local var_104_13 = (arg_101_1.time_ - var_104_9) / var_104_12
				local var_104_14 = Vector3.New(390, -275, -280)

				var_104_8.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos3054, var_104_14, var_104_13)
			end

			if arg_101_1.time_ >= var_104_9 + var_104_12 and arg_101_1.time_ < var_104_9 + var_104_12 + arg_104_0 then
				var_104_8.localPosition = Vector3.New(390, -275, -280)
			end

			local var_104_15 = arg_101_1.actors_["10146"].transform
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 then
				arg_101_1.var_.moveOldPos10146 = var_104_15.localPosition
				var_104_15.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10146", 2)

				local var_104_17 = var_104_15.childCount

				for iter_104_5 = 0, var_104_17 - 1 do
					local var_104_18 = var_104_15:GetChild(iter_104_5)

					if var_104_18.name == "split_6" or not string.find(var_104_18.name, "split") then
						var_104_18.gameObject:SetActive(true)
					else
						var_104_18.gameObject:SetActive(false)
					end
				end
			end

			local var_104_19 = 0.001

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_19 then
				local var_104_20 = (arg_101_1.time_ - var_104_16) / var_104_19
				local var_104_21 = Vector3.New(-390, -350, -320)

				var_104_15.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10146, var_104_21, var_104_20)
			end

			if arg_101_1.time_ >= var_104_16 + var_104_19 and arg_101_1.time_ < var_104_16 + var_104_19 + arg_104_0 then
				var_104_15.localPosition = Vector3.New(-390, -350, -320)
			end

			local var_104_22 = arg_101_1.actors_["3054"]
			local var_104_23 = 0

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				local var_104_24 = var_104_22:GetComponentInChildren(typeof(CanvasGroup))

				if var_104_24 then
					arg_101_1.var_.alphaOldValue3054 = var_104_24.alpha
					arg_101_1.var_.characterEffect3054 = var_104_24
				end

				arg_101_1.var_.alphaOldValue3054 = 0
			end

			local var_104_25 = 0.5

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_25 then
				local var_104_26 = (arg_101_1.time_ - var_104_23) / var_104_25
				local var_104_27 = Mathf.Lerp(arg_101_1.var_.alphaOldValue3054, 1, var_104_26)

				if arg_101_1.var_.characterEffect3054 then
					arg_101_1.var_.characterEffect3054.alpha = var_104_27
				end
			end

			if arg_101_1.time_ >= var_104_23 + var_104_25 and arg_101_1.time_ < var_104_23 + var_104_25 + arg_104_0 and arg_101_1.var_.characterEffect3054 then
				arg_101_1.var_.characterEffect3054.alpha = 1
			end

			local var_104_28 = 0
			local var_104_29 = 0.575

			if var_104_28 < arg_101_1.time_ and arg_101_1.time_ <= var_104_28 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_30 = arg_101_1:FormatText(StoryNameCfg[1339].name)

				arg_101_1.leftNameTxt_.text = var_104_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_31 = arg_101_1:GetWordFromCfg(423121025)
				local var_104_32 = arg_101_1:FormatText(var_104_31.content)

				arg_101_1.text_.text = var_104_32

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_33 = 23
				local var_104_34 = utf8.len(var_104_32)
				local var_104_35 = var_104_33 <= 0 and var_104_29 or var_104_29 * (var_104_34 / var_104_33)

				if var_104_35 > 0 and var_104_29 < var_104_35 then
					arg_101_1.talkMaxDuration = var_104_35

					if var_104_35 + var_104_28 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_35 + var_104_28
					end
				end

				arg_101_1.text_.text = var_104_32
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121025", "story_v_out_423121.awb") ~= 0 then
					local var_104_36 = manager.audio:GetVoiceLength("story_v_out_423121", "423121025", "story_v_out_423121.awb") / 1000

					if var_104_36 + var_104_28 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_36 + var_104_28
					end

					if var_104_31.prefab_name ~= "" and arg_101_1.actors_[var_104_31.prefab_name] ~= nil then
						local var_104_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_31.prefab_name].transform, "story_v_out_423121", "423121025", "story_v_out_423121.awb")

						arg_101_1:RecordAudio("423121025", var_104_37)
						arg_101_1:RecordAudio("423121025", var_104_37)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_423121", "423121025", "story_v_out_423121.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_423121", "423121025", "story_v_out_423121.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_38 = math.max(var_104_29, arg_101_1.talkMaxDuration)

			if var_104_28 <= arg_101_1.time_ and arg_101_1.time_ < var_104_28 + var_104_38 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_28) / var_104_38

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_28 + var_104_38 and arg_101_1.time_ < var_104_28 + var_104_38 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play423121026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 423121026
		arg_105_1.duration_ = 8.83

		local var_105_0 = {
			zh = 6.8,
			ja = 8.833
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
				arg_105_0:Play423121027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10146"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10146 == nil then
				arg_105_1.var_.actorSpriteComps10146 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps10146 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 1, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10146 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10146 = nil
			end

			local var_108_8 = arg_105_1.actors_["3054"]
			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps3054 == nil then
				arg_105_1.var_.actorSpriteComps3054 = var_108_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_10 = 0.2

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_10 and not isNil(var_108_8) then
				local var_108_11 = (arg_105_1.time_ - var_108_9) / var_108_10

				if arg_105_1.var_.actorSpriteComps3054 then
					for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_108_5 then
							if arg_105_1.isInRecall_ then
								local var_108_12 = Mathf.Lerp(iter_108_5.color.r, arg_105_1.hightColor2.r, var_108_11)
								local var_108_13 = Mathf.Lerp(iter_108_5.color.g, arg_105_1.hightColor2.g, var_108_11)
								local var_108_14 = Mathf.Lerp(iter_108_5.color.b, arg_105_1.hightColor2.b, var_108_11)

								iter_108_5.color = Color.New(var_108_12, var_108_13, var_108_14)
							else
								local var_108_15 = Mathf.Lerp(iter_108_5.color.r, 0.5, var_108_11)

								iter_108_5.color = Color.New(var_108_15, var_108_15, var_108_15)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_9 + var_108_10 and arg_105_1.time_ < var_108_9 + var_108_10 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps3054 then
				for iter_108_6, iter_108_7 in pairs(arg_105_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_108_7 then
						if arg_105_1.isInRecall_ then
							iter_108_7.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps3054 = nil
			end

			local var_108_16 = arg_105_1.actors_["10146"].transform
			local var_108_17 = 0

			if var_108_17 < arg_105_1.time_ and arg_105_1.time_ <= var_108_17 + arg_108_0 then
				arg_105_1.var_.moveOldPos10146 = var_108_16.localPosition
				var_108_16.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10146", 2)

				local var_108_18 = var_108_16.childCount

				for iter_108_8 = 0, var_108_18 - 1 do
					local var_108_19 = var_108_16:GetChild(iter_108_8)

					if var_108_19.name == "split_6" or not string.find(var_108_19.name, "split") then
						var_108_19.gameObject:SetActive(true)
					else
						var_108_19.gameObject:SetActive(false)
					end
				end
			end

			local var_108_20 = 0.001

			if var_108_17 <= arg_105_1.time_ and arg_105_1.time_ < var_108_17 + var_108_20 then
				local var_108_21 = (arg_105_1.time_ - var_108_17) / var_108_20
				local var_108_22 = Vector3.New(-390, -350, -320)

				var_108_16.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10146, var_108_22, var_108_21)
			end

			if arg_105_1.time_ >= var_108_17 + var_108_20 and arg_105_1.time_ < var_108_17 + var_108_20 + arg_108_0 then
				var_108_16.localPosition = Vector3.New(-390, -350, -320)
			end

			local var_108_23 = 0
			local var_108_24 = 0.775

			if var_108_23 < arg_105_1.time_ and arg_105_1.time_ <= var_108_23 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_25 = arg_105_1:FormatText(StoryNameCfg[1338].name)

				arg_105_1.leftNameTxt_.text = var_108_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_26 = arg_105_1:GetWordFromCfg(423121026)
				local var_108_27 = arg_105_1:FormatText(var_108_26.content)

				arg_105_1.text_.text = var_108_27

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_28 = 31
				local var_108_29 = utf8.len(var_108_27)
				local var_108_30 = var_108_28 <= 0 and var_108_24 or var_108_24 * (var_108_29 / var_108_28)

				if var_108_30 > 0 and var_108_24 < var_108_30 then
					arg_105_1.talkMaxDuration = var_108_30

					if var_108_30 + var_108_23 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_30 + var_108_23
					end
				end

				arg_105_1.text_.text = var_108_27
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121026", "story_v_out_423121.awb") ~= 0 then
					local var_108_31 = manager.audio:GetVoiceLength("story_v_out_423121", "423121026", "story_v_out_423121.awb") / 1000

					if var_108_31 + var_108_23 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_31 + var_108_23
					end

					if var_108_26.prefab_name ~= "" and arg_105_1.actors_[var_108_26.prefab_name] ~= nil then
						local var_108_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_26.prefab_name].transform, "story_v_out_423121", "423121026", "story_v_out_423121.awb")

						arg_105_1:RecordAudio("423121026", var_108_32)
						arg_105_1:RecordAudio("423121026", var_108_32)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_423121", "423121026", "story_v_out_423121.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_423121", "423121026", "story_v_out_423121.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_33 = math.max(var_108_24, arg_105_1.talkMaxDuration)

			if var_108_23 <= arg_105_1.time_ and arg_105_1.time_ < var_108_23 + var_108_33 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_23) / var_108_33

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_23 + var_108_33 and arg_105_1.time_ < var_108_23 + var_108_33 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play423121027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 423121027
		arg_109_1.duration_ = 4.5

		local var_109_0 = {
			zh = 4.5,
			ja = 2.733
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
				arg_109_0:Play423121028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["3054"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps3054 == nil then
				arg_109_1.var_.actorSpriteComps3054 = var_112_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_2 = 0.2

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.actorSpriteComps3054 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								local var_112_4 = Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor1.r, var_112_3)
								local var_112_5 = Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor1.g, var_112_3)
								local var_112_6 = Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor1.b, var_112_3)

								iter_112_1.color = Color.New(var_112_4, var_112_5, var_112_6)
							else
								local var_112_7 = Mathf.Lerp(iter_112_1.color.r, 1, var_112_3)

								iter_112_1.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.actorSpriteComps3054 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_112_3 then
						if arg_109_1.isInRecall_ then
							iter_112_3.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps3054 = nil
			end

			local var_112_8 = arg_109_1.actors_["10146"]
			local var_112_9 = 0

			if var_112_9 < arg_109_1.time_ and arg_109_1.time_ <= var_112_9 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps10146 == nil then
				arg_109_1.var_.actorSpriteComps10146 = var_112_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_10 = 0.2

			if var_112_9 <= arg_109_1.time_ and arg_109_1.time_ < var_112_9 + var_112_10 and not isNil(var_112_8) then
				local var_112_11 = (arg_109_1.time_ - var_112_9) / var_112_10

				if arg_109_1.var_.actorSpriteComps10146 then
					for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_112_5 then
							if arg_109_1.isInRecall_ then
								local var_112_12 = Mathf.Lerp(iter_112_5.color.r, arg_109_1.hightColor2.r, var_112_11)
								local var_112_13 = Mathf.Lerp(iter_112_5.color.g, arg_109_1.hightColor2.g, var_112_11)
								local var_112_14 = Mathf.Lerp(iter_112_5.color.b, arg_109_1.hightColor2.b, var_112_11)

								iter_112_5.color = Color.New(var_112_12, var_112_13, var_112_14)
							else
								local var_112_15 = Mathf.Lerp(iter_112_5.color.r, 0.5, var_112_11)

								iter_112_5.color = Color.New(var_112_15, var_112_15, var_112_15)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_9 + var_112_10 and arg_109_1.time_ < var_112_9 + var_112_10 + arg_112_0 and not isNil(var_112_8) and arg_109_1.var_.actorSpriteComps10146 then
				for iter_112_6, iter_112_7 in pairs(arg_109_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_112_7 then
						if arg_109_1.isInRecall_ then
							iter_112_7.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10146 = nil
			end

			local var_112_16 = arg_109_1.actors_["3054"].transform
			local var_112_17 = 0

			if var_112_17 < arg_109_1.time_ and arg_109_1.time_ <= var_112_17 + arg_112_0 then
				arg_109_1.var_.moveOldPos3054 = var_112_16.localPosition
				var_112_16.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("3054", 4)

				local var_112_18 = var_112_16.childCount

				for iter_112_8 = 0, var_112_18 - 1 do
					local var_112_19 = var_112_16:GetChild(iter_112_8)

					if var_112_19.name == "split_5" or not string.find(var_112_19.name, "split") then
						var_112_19.gameObject:SetActive(true)
					else
						var_112_19.gameObject:SetActive(false)
					end
				end
			end

			local var_112_20 = 0.001

			if var_112_17 <= arg_109_1.time_ and arg_109_1.time_ < var_112_17 + var_112_20 then
				local var_112_21 = (arg_109_1.time_ - var_112_17) / var_112_20
				local var_112_22 = Vector3.New(390, -275, -280)

				var_112_16.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos3054, var_112_22, var_112_21)
			end

			if arg_109_1.time_ >= var_112_17 + var_112_20 and arg_109_1.time_ < var_112_17 + var_112_20 + arg_112_0 then
				var_112_16.localPosition = Vector3.New(390, -275, -280)
			end

			local var_112_23 = 0
			local var_112_24 = 0.35

			if var_112_23 < arg_109_1.time_ and arg_109_1.time_ <= var_112_23 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_25 = arg_109_1:FormatText(StoryNameCfg[1339].name)

				arg_109_1.leftNameTxt_.text = var_112_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_26 = arg_109_1:GetWordFromCfg(423121027)
				local var_112_27 = arg_109_1:FormatText(var_112_26.content)

				arg_109_1.text_.text = var_112_27

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_28 = 14
				local var_112_29 = utf8.len(var_112_27)
				local var_112_30 = var_112_28 <= 0 and var_112_24 or var_112_24 * (var_112_29 / var_112_28)

				if var_112_30 > 0 and var_112_24 < var_112_30 then
					arg_109_1.talkMaxDuration = var_112_30

					if var_112_30 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_30 + var_112_23
					end
				end

				arg_109_1.text_.text = var_112_27
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121027", "story_v_out_423121.awb") ~= 0 then
					local var_112_31 = manager.audio:GetVoiceLength("story_v_out_423121", "423121027", "story_v_out_423121.awb") / 1000

					if var_112_31 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_31 + var_112_23
					end

					if var_112_26.prefab_name ~= "" and arg_109_1.actors_[var_112_26.prefab_name] ~= nil then
						local var_112_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_26.prefab_name].transform, "story_v_out_423121", "423121027", "story_v_out_423121.awb")

						arg_109_1:RecordAudio("423121027", var_112_32)
						arg_109_1:RecordAudio("423121027", var_112_32)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_423121", "423121027", "story_v_out_423121.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_423121", "423121027", "story_v_out_423121.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_33 = math.max(var_112_24, arg_109_1.talkMaxDuration)

			if var_112_23 <= arg_109_1.time_ and arg_109_1.time_ < var_112_23 + var_112_33 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_23) / var_112_33

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_23 + var_112_33 and arg_109_1.time_ < var_112_23 + var_112_33 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play423121028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 423121028
		arg_113_1.duration_ = 8.13

		local var_113_0 = {
			zh = 5.8,
			ja = 8.133
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
				arg_113_0:Play423121029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["3054"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps3054 == nil then
				arg_113_1.var_.actorSpriteComps3054 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.2

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps3054 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								local var_116_4 = Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor2.r, var_116_3)
								local var_116_5 = Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor2.g, var_116_3)
								local var_116_6 = Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor2.b, var_116_3)

								iter_116_1.color = Color.New(var_116_4, var_116_5, var_116_6)
							else
								local var_116_7 = Mathf.Lerp(iter_116_1.color.r, 0.5, var_116_3)

								iter_116_1.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps3054 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps3054 = nil
			end

			local var_116_8 = 0
			local var_116_9 = 0.725

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_10 = arg_113_1:FormatText(StoryNameCfg[1336].name)

				arg_113_1.leftNameTxt_.text = var_116_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_11 = arg_113_1:GetWordFromCfg(423121028)
				local var_116_12 = arg_113_1:FormatText(var_116_11.content)

				arg_113_1.text_.text = var_116_12

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 29
				local var_116_14 = utf8.len(var_116_12)
				local var_116_15 = var_116_13 <= 0 and var_116_9 or var_116_9 * (var_116_14 / var_116_13)

				if var_116_15 > 0 and var_116_9 < var_116_15 then
					arg_113_1.talkMaxDuration = var_116_15

					if var_116_15 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_15 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_12
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121028", "story_v_out_423121.awb") ~= 0 then
					local var_116_16 = manager.audio:GetVoiceLength("story_v_out_423121", "423121028", "story_v_out_423121.awb") / 1000

					if var_116_16 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_16 + var_116_8
					end

					if var_116_11.prefab_name ~= "" and arg_113_1.actors_[var_116_11.prefab_name] ~= nil then
						local var_116_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_11.prefab_name].transform, "story_v_out_423121", "423121028", "story_v_out_423121.awb")

						arg_113_1:RecordAudio("423121028", var_116_17)
						arg_113_1:RecordAudio("423121028", var_116_17)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_423121", "423121028", "story_v_out_423121.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_423121", "423121028", "story_v_out_423121.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_18 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_18 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_18

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_18 and arg_113_1.time_ < var_116_8 + var_116_18 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play423121029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 423121029
		arg_117_1.duration_ = 11.63

		local var_117_0 = {
			zh = 8.565999999999,
			ja = 11.632999999999
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
				arg_117_0:Play423121030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 1.999999999999

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				local var_120_1 = manager.ui.mainCamera.transform.localPosition
				local var_120_2 = Vector3.New(0, 0, 10) + Vector3.New(var_120_1.x, var_120_1.y, 0)
				local var_120_3 = arg_117_1.bgs_.ST0112a

				var_120_3.transform.localPosition = var_120_2
				var_120_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_120_4 = var_120_3:GetComponent("SpriteRenderer")

				if var_120_4 and var_120_4.sprite then
					local var_120_5 = (var_120_3.transform.localPosition - var_120_1).z
					local var_120_6 = manager.ui.mainCameraCom_
					local var_120_7 = 2 * var_120_5 * Mathf.Tan(var_120_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_120_8 = var_120_7 * var_120_6.aspect
					local var_120_9 = var_120_4.sprite.bounds.size.x
					local var_120_10 = var_120_4.sprite.bounds.size.y
					local var_120_11 = var_120_8 / var_120_9
					local var_120_12 = var_120_7 / var_120_10
					local var_120_13 = var_120_12 < var_120_11 and var_120_11 or var_120_12

					var_120_3.transform.localScale = Vector3.New(var_120_13, var_120_13, 0)
				end

				for iter_120_0, iter_120_1 in pairs(arg_117_1.bgs_) do
					if iter_120_0 ~= "ST0112a" then
						iter_120_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_120_14 = 3.999999999999

			if var_120_14 < arg_117_1.time_ and arg_117_1.time_ <= var_120_14 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			local var_120_15 = 0.3

			if arg_117_1.time_ >= var_120_14 + var_120_15 and arg_117_1.time_ < var_120_14 + var_120_15 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_17 = 2

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 then
				local var_120_18 = (arg_117_1.time_ - var_120_16) / var_120_17
				local var_120_19 = Color.New(0, 0, 0)

				var_120_19.a = Mathf.Lerp(0, 1, var_120_18)
				arg_117_1.mask_.color = var_120_19
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 then
				local var_120_20 = Color.New(0, 0, 0)

				var_120_20.a = 1
				arg_117_1.mask_.color = var_120_20
			end

			local var_120_21 = 2

			if var_120_21 < arg_117_1.time_ and arg_117_1.time_ <= var_120_21 + arg_120_0 then
				arg_117_1.mask_.enabled = true
				arg_117_1.mask_.raycastTarget = true

				arg_117_1:SetGaussion(false)
			end

			local var_120_22 = 2

			if var_120_21 <= arg_117_1.time_ and arg_117_1.time_ < var_120_21 + var_120_22 then
				local var_120_23 = (arg_117_1.time_ - var_120_21) / var_120_22
				local var_120_24 = Color.New(0, 0, 0)

				var_120_24.a = Mathf.Lerp(1, 0, var_120_23)
				arg_117_1.mask_.color = var_120_24
			end

			if arg_117_1.time_ >= var_120_21 + var_120_22 and arg_117_1.time_ < var_120_21 + var_120_22 + arg_120_0 then
				local var_120_25 = Color.New(0, 0, 0)
				local var_120_26 = 0

				arg_117_1.mask_.enabled = false
				var_120_25.a = var_120_26
				arg_117_1.mask_.color = var_120_25
			end

			local var_120_27 = arg_117_1.actors_["10146"]
			local var_120_28 = 3.8

			if var_120_28 < arg_117_1.time_ and arg_117_1.time_ <= var_120_28 + arg_120_0 and not isNil(var_120_27) and arg_117_1.var_.actorSpriteComps10146 == nil then
				arg_117_1.var_.actorSpriteComps10146 = var_120_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_29 = 0.2

			if var_120_28 <= arg_117_1.time_ and arg_117_1.time_ < var_120_28 + var_120_29 and not isNil(var_120_27) then
				local var_120_30 = (arg_117_1.time_ - var_120_28) / var_120_29

				if arg_117_1.var_.actorSpriteComps10146 then
					for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_120_3 then
							if arg_117_1.isInRecall_ then
								local var_120_31 = Mathf.Lerp(iter_120_3.color.r, arg_117_1.hightColor1.r, var_120_30)
								local var_120_32 = Mathf.Lerp(iter_120_3.color.g, arg_117_1.hightColor1.g, var_120_30)
								local var_120_33 = Mathf.Lerp(iter_120_3.color.b, arg_117_1.hightColor1.b, var_120_30)

								iter_120_3.color = Color.New(var_120_31, var_120_32, var_120_33)
							else
								local var_120_34 = Mathf.Lerp(iter_120_3.color.r, 1, var_120_30)

								iter_120_3.color = Color.New(var_120_34, var_120_34, var_120_34)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_28 + var_120_29 and arg_117_1.time_ < var_120_28 + var_120_29 + arg_120_0 and not isNil(var_120_27) and arg_117_1.var_.actorSpriteComps10146 then
				for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_120_5 then
						if arg_117_1.isInRecall_ then
							iter_120_5.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10146 = nil
			end

			local var_120_35 = arg_117_1.actors_["10146"].transform
			local var_120_36 = 3.8

			if var_120_36 < arg_117_1.time_ and arg_117_1.time_ <= var_120_36 + arg_120_0 then
				arg_117_1.var_.moveOldPos10146 = var_120_35.localPosition
				var_120_35.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10146", 3)

				local var_120_37 = var_120_35.childCount

				for iter_120_6 = 0, var_120_37 - 1 do
					local var_120_38 = var_120_35:GetChild(iter_120_6)

					if var_120_38.name == "split_6" or not string.find(var_120_38.name, "split") then
						var_120_38.gameObject:SetActive(true)
					else
						var_120_38.gameObject:SetActive(false)
					end
				end
			end

			local var_120_39 = 0.001

			if var_120_36 <= arg_117_1.time_ and arg_117_1.time_ < var_120_36 + var_120_39 then
				local var_120_40 = (arg_117_1.time_ - var_120_36) / var_120_39
				local var_120_41 = Vector3.New(0, -350, -320)

				var_120_35.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10146, var_120_41, var_120_40)
			end

			if arg_117_1.time_ >= var_120_36 + var_120_39 and arg_117_1.time_ < var_120_36 + var_120_39 + arg_120_0 then
				var_120_35.localPosition = Vector3.New(0, -350, -320)
			end

			local var_120_42 = arg_117_1.actors_["3054"].transform
			local var_120_43 = 1.966

			if var_120_43 < arg_117_1.time_ and arg_117_1.time_ <= var_120_43 + arg_120_0 then
				arg_117_1.var_.moveOldPos3054 = var_120_42.localPosition
				var_120_42.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("3054", 7)

				local var_120_44 = var_120_42.childCount

				for iter_120_7 = 0, var_120_44 - 1 do
					local var_120_45 = var_120_42:GetChild(iter_120_7)

					if var_120_45.name == "" or not string.find(var_120_45.name, "split") then
						var_120_45.gameObject:SetActive(true)
					else
						var_120_45.gameObject:SetActive(false)
					end
				end
			end

			local var_120_46 = 0.001

			if var_120_43 <= arg_117_1.time_ and arg_117_1.time_ < var_120_43 + var_120_46 then
				local var_120_47 = (arg_117_1.time_ - var_120_43) / var_120_46
				local var_120_48 = Vector3.New(0, -2000, 0)

				var_120_42.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos3054, var_120_48, var_120_47)
			end

			if arg_117_1.time_ >= var_120_43 + var_120_46 and arg_117_1.time_ < var_120_43 + var_120_46 + arg_120_0 then
				var_120_42.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_120_49 = arg_117_1.actors_["10146"].transform
			local var_120_50 = 1.966

			if var_120_50 < arg_117_1.time_ and arg_117_1.time_ <= var_120_50 + arg_120_0 then
				arg_117_1.var_.moveOldPos10146 = var_120_49.localPosition
				var_120_49.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10146", 7)

				local var_120_51 = var_120_49.childCount

				for iter_120_8 = 0, var_120_51 - 1 do
					local var_120_52 = var_120_49:GetChild(iter_120_8)

					if var_120_52.name == "split_6" or not string.find(var_120_52.name, "split") then
						var_120_52.gameObject:SetActive(true)
					else
						var_120_52.gameObject:SetActive(false)
					end
				end
			end

			local var_120_53 = 0.001

			if var_120_50 <= arg_117_1.time_ and arg_117_1.time_ < var_120_50 + var_120_53 then
				local var_120_54 = (arg_117_1.time_ - var_120_50) / var_120_53
				local var_120_55 = Vector3.New(0, -2000, 0)

				var_120_49.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10146, var_120_55, var_120_54)
			end

			if arg_117_1.time_ >= var_120_50 + var_120_53 and arg_117_1.time_ < var_120_50 + var_120_53 + arg_120_0 then
				var_120_49.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_120_56 = 0.3
			local var_120_57 = 0.3

			if var_120_56 < arg_117_1.time_ and arg_117_1.time_ <= var_120_56 + arg_120_0 then
				local var_120_58 = "play"
				local var_120_59 = "music"

				arg_117_1:AudioAction(var_120_58, var_120_59, "ui_battle", "ui_battle_stopbgm", "")

				local var_120_60 = ""
				local var_120_61 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_120_61 ~= "" then
					if arg_117_1.bgmTxt_.text ~= var_120_61 and arg_117_1.bgmTxt_.text ~= "" then
						if arg_117_1.bgmTxt2_.text ~= "" then
							arg_117_1.bgmTxt_.text = arg_117_1.bgmTxt2_.text
						end

						arg_117_1.bgmTxt2_.text = var_120_61

						arg_117_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_117_1.bgmTxt_.text = var_120_61
						arg_117_1.bgmTxt2_.text = var_120_61
					end

					if arg_117_1.bgmTimer then
						arg_117_1.bgmTimer:Stop()

						arg_117_1.bgmTimer = nil
					end

					if arg_117_1.settingData.show_music_name == 1 then
						arg_117_1.musicController:SetSelectedState("show")
						arg_117_1.musicAnimator_:Play("open", 0, 0)

						if arg_117_1.settingData.music_time ~= 0 then
							arg_117_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_117_1.settingData.music_time), function()
								if arg_117_1 == nil or isNil(arg_117_1.bgmTxt_) then
									return
								end

								arg_117_1.musicController:SetSelectedState("hide")
								arg_117_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_120_62 = 1.36666666666667
			local var_120_63 = 1

			if var_120_62 < arg_117_1.time_ and arg_117_1.time_ <= var_120_62 + arg_120_0 then
				local var_120_64 = "play"
				local var_120_65 = "music"

				arg_117_1:AudioAction(var_120_64, var_120_65, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_120_66 = ""
				local var_120_67 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_120_67 ~= "" then
					if arg_117_1.bgmTxt_.text ~= var_120_67 and arg_117_1.bgmTxt_.text ~= "" then
						if arg_117_1.bgmTxt2_.text ~= "" then
							arg_117_1.bgmTxt_.text = arg_117_1.bgmTxt2_.text
						end

						arg_117_1.bgmTxt2_.text = var_120_67

						arg_117_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_117_1.bgmTxt_.text = var_120_67
						arg_117_1.bgmTxt2_.text = var_120_67
					end

					if arg_117_1.bgmTimer then
						arg_117_1.bgmTimer:Stop()

						arg_117_1.bgmTimer = nil
					end

					if arg_117_1.settingData.show_music_name == 1 then
						arg_117_1.musicController:SetSelectedState("show")
						arg_117_1.musicAnimator_:Play("open", 0, 0)

						if arg_117_1.settingData.music_time ~= 0 then
							arg_117_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_117_1.settingData.music_time), function()
								if arg_117_1 == nil or isNil(arg_117_1.bgmTxt_) then
									return
								end

								arg_117_1.musicController:SetSelectedState("hide")
								arg_117_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_68 = 3.999999999999
			local var_120_69 = 0.55

			if var_120_68 < arg_117_1.time_ and arg_117_1.time_ <= var_120_68 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_70 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_70:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_117_1.dialogCg_.alpha = arg_123_0
				end))
				var_120_70:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_70:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_71 = arg_117_1:FormatText(StoryNameCfg[1338].name)

				arg_117_1.leftNameTxt_.text = var_120_71

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_72 = arg_117_1:GetWordFromCfg(423121029)
				local var_120_73 = arg_117_1:FormatText(var_120_72.content)

				arg_117_1.text_.text = var_120_73

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_74 = 22
				local var_120_75 = utf8.len(var_120_73)
				local var_120_76 = var_120_74 <= 0 and var_120_69 or var_120_69 * (var_120_75 / var_120_74)

				if var_120_76 > 0 and var_120_69 < var_120_76 then
					arg_117_1.talkMaxDuration = var_120_76
					var_120_68 = var_120_68 + 0.3

					if var_120_76 + var_120_68 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_76 + var_120_68
					end
				end

				arg_117_1.text_.text = var_120_73
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121029", "story_v_out_423121.awb") ~= 0 then
					local var_120_77 = manager.audio:GetVoiceLength("story_v_out_423121", "423121029", "story_v_out_423121.awb") / 1000

					if var_120_77 + var_120_68 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_77 + var_120_68
					end

					if var_120_72.prefab_name ~= "" and arg_117_1.actors_[var_120_72.prefab_name] ~= nil then
						local var_120_78 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_72.prefab_name].transform, "story_v_out_423121", "423121029", "story_v_out_423121.awb")

						arg_117_1:RecordAudio("423121029", var_120_78)
						arg_117_1:RecordAudio("423121029", var_120_78)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_423121", "423121029", "story_v_out_423121.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_423121", "423121029", "story_v_out_423121.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_79 = var_120_68 + 0.3
			local var_120_80 = math.max(var_120_69, arg_117_1.talkMaxDuration)

			if var_120_79 <= arg_117_1.time_ and arg_117_1.time_ < var_120_79 + var_120_80 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_79) / var_120_80

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_79 + var_120_80 and arg_117_1.time_ < var_120_79 + var_120_80 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play423121030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 423121030
		arg_125_1.duration_ = 10.6

		local var_125_0 = {
			zh = 7.666,
			ja = 10.6
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
				arg_125_0:Play423121031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["10146"]
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10146 == nil then
				arg_125_1.var_.actorSpriteComps10146 = var_128_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_2 = 0.2

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 and not isNil(var_128_0) then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2

				if arg_125_1.var_.actorSpriteComps10146 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								local var_128_4 = Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor2.r, var_128_3)
								local var_128_5 = Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor2.g, var_128_3)
								local var_128_6 = Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor2.b, var_128_3)

								iter_128_1.color = Color.New(var_128_4, var_128_5, var_128_6)
							else
								local var_128_7 = Mathf.Lerp(iter_128_1.color.r, 0.5, var_128_3)

								iter_128_1.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 and not isNil(var_128_0) and arg_125_1.var_.actorSpriteComps10146 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_128_3 then
						if arg_125_1.isInRecall_ then
							iter_128_3.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10146 = nil
			end

			local var_128_8 = 0
			local var_128_9 = 0.85

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_10 = arg_125_1:FormatText(StoryNameCfg[1335].name)

				arg_125_1.leftNameTxt_.text = var_128_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_11 = arg_125_1:GetWordFromCfg(423121030)
				local var_128_12 = arg_125_1:FormatText(var_128_11.content)

				arg_125_1.text_.text = var_128_12

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 34
				local var_128_14 = utf8.len(var_128_12)
				local var_128_15 = var_128_13 <= 0 and var_128_9 or var_128_9 * (var_128_14 / var_128_13)

				if var_128_15 > 0 and var_128_9 < var_128_15 then
					arg_125_1.talkMaxDuration = var_128_15

					if var_128_15 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_15 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_12
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121030", "story_v_out_423121.awb") ~= 0 then
					local var_128_16 = manager.audio:GetVoiceLength("story_v_out_423121", "423121030", "story_v_out_423121.awb") / 1000

					if var_128_16 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_16 + var_128_8
					end

					if var_128_11.prefab_name ~= "" and arg_125_1.actors_[var_128_11.prefab_name] ~= nil then
						local var_128_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_11.prefab_name].transform, "story_v_out_423121", "423121030", "story_v_out_423121.awb")

						arg_125_1:RecordAudio("423121030", var_128_17)
						arg_125_1:RecordAudio("423121030", var_128_17)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_423121", "423121030", "story_v_out_423121.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_423121", "423121030", "story_v_out_423121.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_18 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_18 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_18

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_18 and arg_125_1.time_ < var_128_8 + var_128_18 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play423121031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 423121031
		arg_129_1.duration_ = 10.17

		local var_129_0 = {
			zh = 5.633,
			ja = 10.166
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
				arg_129_0:Play423121032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["3054"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps3054 == nil then
				arg_129_1.var_.actorSpriteComps3054 = var_132_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_2 = 0.2

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.actorSpriteComps3054 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								local var_132_4 = Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor1.r, var_132_3)
								local var_132_5 = Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor1.g, var_132_3)
								local var_132_6 = Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor1.b, var_132_3)

								iter_132_1.color = Color.New(var_132_4, var_132_5, var_132_6)
							else
								local var_132_7 = Mathf.Lerp(iter_132_1.color.r, 1, var_132_3)

								iter_132_1.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.actorSpriteComps3054 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_132_3 then
						if arg_129_1.isInRecall_ then
							iter_132_3.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps3054 = nil
			end

			local var_132_8 = arg_129_1.actors_["3054"].transform
			local var_132_9 = 0

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 then
				arg_129_1.var_.moveOldPos3054 = var_132_8.localPosition
				var_132_8.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("3054", 3)

				local var_132_10 = var_132_8.childCount

				for iter_132_4 = 0, var_132_10 - 1 do
					local var_132_11 = var_132_8:GetChild(iter_132_4)

					if var_132_11.name == "" or not string.find(var_132_11.name, "split") then
						var_132_11.gameObject:SetActive(true)
					else
						var_132_11.gameObject:SetActive(false)
					end
				end
			end

			local var_132_12 = 0.001

			if var_132_9 <= arg_129_1.time_ and arg_129_1.time_ < var_132_9 + var_132_12 then
				local var_132_13 = (arg_129_1.time_ - var_132_9) / var_132_12
				local var_132_14 = Vector3.New(0, -275, -280)

				var_132_8.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos3054, var_132_14, var_132_13)
			end

			if arg_129_1.time_ >= var_132_9 + var_132_12 and arg_129_1.time_ < var_132_9 + var_132_12 + arg_132_0 then
				var_132_8.localPosition = Vector3.New(0, -275, -280)
			end

			local var_132_15 = 0
			local var_132_16 = 0.8

			if var_132_15 < arg_129_1.time_ and arg_129_1.time_ <= var_132_15 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_17 = arg_129_1:FormatText(StoryNameCfg[1339].name)

				arg_129_1.leftNameTxt_.text = var_132_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_18 = arg_129_1:GetWordFromCfg(423121031)
				local var_132_19 = arg_129_1:FormatText(var_132_18.content)

				arg_129_1.text_.text = var_132_19

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_20 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121031", "story_v_out_423121.awb") ~= 0 then
					local var_132_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121031", "story_v_out_423121.awb") / 1000

					if var_132_23 + var_132_15 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_23 + var_132_15
					end

					if var_132_18.prefab_name ~= "" and arg_129_1.actors_[var_132_18.prefab_name] ~= nil then
						local var_132_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_18.prefab_name].transform, "story_v_out_423121", "423121031", "story_v_out_423121.awb")

						arg_129_1:RecordAudio("423121031", var_132_24)
						arg_129_1:RecordAudio("423121031", var_132_24)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_423121", "423121031", "story_v_out_423121.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_423121", "423121031", "story_v_out_423121.awb")
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
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play423121032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 423121032
		arg_133_1.duration_ = 7.67

		local var_133_0 = {
			zh = 5.733,
			ja = 7.666
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
				arg_133_0:Play423121033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["3054"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps3054 == nil then
				arg_133_1.var_.actorSpriteComps3054 = var_136_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_2 = 0.2

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.actorSpriteComps3054 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_136_1 then
							if arg_133_1.isInRecall_ then
								local var_136_4 = Mathf.Lerp(iter_136_1.color.r, arg_133_1.hightColor2.r, var_136_3)
								local var_136_5 = Mathf.Lerp(iter_136_1.color.g, arg_133_1.hightColor2.g, var_136_3)
								local var_136_6 = Mathf.Lerp(iter_136_1.color.b, arg_133_1.hightColor2.b, var_136_3)

								iter_136_1.color = Color.New(var_136_4, var_136_5, var_136_6)
							else
								local var_136_7 = Mathf.Lerp(iter_136_1.color.r, 0.5, var_136_3)

								iter_136_1.color = Color.New(var_136_7, var_136_7, var_136_7)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.actorSpriteComps3054 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_136_3 then
						if arg_133_1.isInRecall_ then
							iter_136_3.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps3054 = nil
			end

			local var_136_8 = 0
			local var_136_9 = 0.625

			if var_136_8 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_10 = arg_133_1:FormatText(StoryNameCfg[1335].name)

				arg_133_1.leftNameTxt_.text = var_136_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_11 = arg_133_1:GetWordFromCfg(423121032)
				local var_136_12 = arg_133_1:FormatText(var_136_11.content)

				arg_133_1.text_.text = var_136_12

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 25
				local var_136_14 = utf8.len(var_136_12)
				local var_136_15 = var_136_13 <= 0 and var_136_9 or var_136_9 * (var_136_14 / var_136_13)

				if var_136_15 > 0 and var_136_9 < var_136_15 then
					arg_133_1.talkMaxDuration = var_136_15

					if var_136_15 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_15 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_12
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121032", "story_v_out_423121.awb") ~= 0 then
					local var_136_16 = manager.audio:GetVoiceLength("story_v_out_423121", "423121032", "story_v_out_423121.awb") / 1000

					if var_136_16 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_16 + var_136_8
					end

					if var_136_11.prefab_name ~= "" and arg_133_1.actors_[var_136_11.prefab_name] ~= nil then
						local var_136_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_11.prefab_name].transform, "story_v_out_423121", "423121032", "story_v_out_423121.awb")

						arg_133_1:RecordAudio("423121032", var_136_17)
						arg_133_1:RecordAudio("423121032", var_136_17)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_423121", "423121032", "story_v_out_423121.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_423121", "423121032", "story_v_out_423121.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_18 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_18 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_18

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_18 and arg_133_1.time_ < var_136_8 + var_136_18 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play423121033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 423121033
		arg_137_1.duration_ = 9.23

		local var_137_0 = {
			zh = 9,
			ja = 9.233
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
				arg_137_0:Play423121034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["3054"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps3054 == nil then
				arg_137_1.var_.actorSpriteComps3054 = var_140_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_2 = 0.2

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.actorSpriteComps3054 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								local var_140_4 = Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor1.r, var_140_3)
								local var_140_5 = Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor1.g, var_140_3)
								local var_140_6 = Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor1.b, var_140_3)

								iter_140_1.color = Color.New(var_140_4, var_140_5, var_140_6)
							else
								local var_140_7 = Mathf.Lerp(iter_140_1.color.r, 1, var_140_3)

								iter_140_1.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.actorSpriteComps3054 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_140_3 then
						if arg_137_1.isInRecall_ then
							iter_140_3.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps3054 = nil
			end

			local var_140_8 = arg_137_1.actors_["3054"].transform
			local var_140_9 = 0

			if var_140_9 < arg_137_1.time_ and arg_137_1.time_ <= var_140_9 + arg_140_0 then
				arg_137_1.var_.moveOldPos3054 = var_140_8.localPosition
				var_140_8.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("3054", 3)

				local var_140_10 = var_140_8.childCount

				for iter_140_4 = 0, var_140_10 - 1 do
					local var_140_11 = var_140_8:GetChild(iter_140_4)

					if var_140_11.name == "split_5" or not string.find(var_140_11.name, "split") then
						var_140_11.gameObject:SetActive(true)
					else
						var_140_11.gameObject:SetActive(false)
					end
				end
			end

			local var_140_12 = 0.001

			if var_140_9 <= arg_137_1.time_ and arg_137_1.time_ < var_140_9 + var_140_12 then
				local var_140_13 = (arg_137_1.time_ - var_140_9) / var_140_12
				local var_140_14 = Vector3.New(0, -275, -280)

				var_140_8.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos3054, var_140_14, var_140_13)
			end

			if arg_137_1.time_ >= var_140_9 + var_140_12 and arg_137_1.time_ < var_140_9 + var_140_12 + arg_140_0 then
				var_140_8.localPosition = Vector3.New(0, -275, -280)
			end

			local var_140_15 = 0
			local var_140_16 = 0.825

			if var_140_15 < arg_137_1.time_ and arg_137_1.time_ <= var_140_15 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_17 = arg_137_1:FormatText(StoryNameCfg[1339].name)

				arg_137_1.leftNameTxt_.text = var_140_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_18 = arg_137_1:GetWordFromCfg(423121033)
				local var_140_19 = arg_137_1:FormatText(var_140_18.content)

				arg_137_1.text_.text = var_140_19

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_20 = 33
				local var_140_21 = utf8.len(var_140_19)
				local var_140_22 = var_140_20 <= 0 and var_140_16 or var_140_16 * (var_140_21 / var_140_20)

				if var_140_22 > 0 and var_140_16 < var_140_22 then
					arg_137_1.talkMaxDuration = var_140_22

					if var_140_22 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_22 + var_140_15
					end
				end

				arg_137_1.text_.text = var_140_19
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121033", "story_v_out_423121.awb") ~= 0 then
					local var_140_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121033", "story_v_out_423121.awb") / 1000

					if var_140_23 + var_140_15 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_23 + var_140_15
					end

					if var_140_18.prefab_name ~= "" and arg_137_1.actors_[var_140_18.prefab_name] ~= nil then
						local var_140_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_18.prefab_name].transform, "story_v_out_423121", "423121033", "story_v_out_423121.awb")

						arg_137_1:RecordAudio("423121033", var_140_24)
						arg_137_1:RecordAudio("423121033", var_140_24)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_423121", "423121033", "story_v_out_423121.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_423121", "423121033", "story_v_out_423121.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_25 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_15 <= arg_137_1.time_ and arg_137_1.time_ < var_140_15 + var_140_25 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_15) / var_140_25

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_15 + var_140_25 and arg_137_1.time_ < var_140_15 + var_140_25 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play423121034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 423121034
		arg_141_1.duration_ = 9.9

		local var_141_0 = {
			zh = 5.133,
			ja = 9.9
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
				arg_141_0:Play423121035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10146"]
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10146 == nil then
				arg_141_1.var_.actorSpriteComps10146 = var_144_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_2 = 0.2

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 and not isNil(var_144_0) then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2

				if arg_141_1.var_.actorSpriteComps10146 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								local var_144_4 = Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor1.r, var_144_3)
								local var_144_5 = Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor1.g, var_144_3)
								local var_144_6 = Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor1.b, var_144_3)

								iter_144_1.color = Color.New(var_144_4, var_144_5, var_144_6)
							else
								local var_144_7 = Mathf.Lerp(iter_144_1.color.r, 1, var_144_3)

								iter_144_1.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.actorSpriteComps10146 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_144_3 then
						if arg_141_1.isInRecall_ then
							iter_144_3.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10146 = nil
			end

			local var_144_8 = arg_141_1.actors_["3054"]
			local var_144_9 = 0

			if var_144_9 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps3054 == nil then
				arg_141_1.var_.actorSpriteComps3054 = var_144_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_10 = 0.2

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_10 and not isNil(var_144_8) then
				local var_144_11 = (arg_141_1.time_ - var_144_9) / var_144_10

				if arg_141_1.var_.actorSpriteComps3054 then
					for iter_144_4, iter_144_5 in pairs(arg_141_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_144_5 then
							if arg_141_1.isInRecall_ then
								local var_144_12 = Mathf.Lerp(iter_144_5.color.r, arg_141_1.hightColor2.r, var_144_11)
								local var_144_13 = Mathf.Lerp(iter_144_5.color.g, arg_141_1.hightColor2.g, var_144_11)
								local var_144_14 = Mathf.Lerp(iter_144_5.color.b, arg_141_1.hightColor2.b, var_144_11)

								iter_144_5.color = Color.New(var_144_12, var_144_13, var_144_14)
							else
								local var_144_15 = Mathf.Lerp(iter_144_5.color.r, 0.5, var_144_11)

								iter_144_5.color = Color.New(var_144_15, var_144_15, var_144_15)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_9 + var_144_10 and arg_141_1.time_ < var_144_9 + var_144_10 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps3054 then
				for iter_144_6, iter_144_7 in pairs(arg_141_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_144_7 then
						if arg_141_1.isInRecall_ then
							iter_144_7.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps3054 = nil
			end

			local var_144_16 = arg_141_1.actors_["10146"].transform
			local var_144_17 = 0

			if var_144_17 < arg_141_1.time_ and arg_141_1.time_ <= var_144_17 + arg_144_0 then
				arg_141_1.var_.moveOldPos10146 = var_144_16.localPosition
				var_144_16.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10146", 4)

				local var_144_18 = var_144_16.childCount

				for iter_144_8 = 0, var_144_18 - 1 do
					local var_144_19 = var_144_16:GetChild(iter_144_8)

					if var_144_19.name == "split_6" or not string.find(var_144_19.name, "split") then
						var_144_19.gameObject:SetActive(true)
					else
						var_144_19.gameObject:SetActive(false)
					end
				end
			end

			local var_144_20 = 0.001

			if var_144_17 <= arg_141_1.time_ and arg_141_1.time_ < var_144_17 + var_144_20 then
				local var_144_21 = (arg_141_1.time_ - var_144_17) / var_144_20
				local var_144_22 = Vector3.New(390, -350, -320)

				var_144_16.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10146, var_144_22, var_144_21)
			end

			if arg_141_1.time_ >= var_144_17 + var_144_20 and arg_141_1.time_ < var_144_17 + var_144_20 + arg_144_0 then
				var_144_16.localPosition = Vector3.New(390, -350, -320)
			end

			local var_144_23 = arg_141_1.actors_["3054"].transform
			local var_144_24 = 0

			if var_144_24 < arg_141_1.time_ and arg_141_1.time_ <= var_144_24 + arg_144_0 then
				arg_141_1.var_.moveOldPos3054 = var_144_23.localPosition
				var_144_23.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("3054", 2)

				local var_144_25 = var_144_23.childCount

				for iter_144_9 = 0, var_144_25 - 1 do
					local var_144_26 = var_144_23:GetChild(iter_144_9)

					if var_144_26.name == "split_5" or not string.find(var_144_26.name, "split") then
						var_144_26.gameObject:SetActive(true)
					else
						var_144_26.gameObject:SetActive(false)
					end
				end
			end

			local var_144_27 = 0.001

			if var_144_24 <= arg_141_1.time_ and arg_141_1.time_ < var_144_24 + var_144_27 then
				local var_144_28 = (arg_141_1.time_ - var_144_24) / var_144_27
				local var_144_29 = Vector3.New(-390, -275, -280)

				var_144_23.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos3054, var_144_29, var_144_28)
			end

			if arg_141_1.time_ >= var_144_24 + var_144_27 and arg_141_1.time_ < var_144_24 + var_144_27 + arg_144_0 then
				var_144_23.localPosition = Vector3.New(-390, -275, -280)
			end

			local var_144_30 = 0
			local var_144_31 = 0.575

			if var_144_30 < arg_141_1.time_ and arg_141_1.time_ <= var_144_30 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_32 = arg_141_1:FormatText(StoryNameCfg[1338].name)

				arg_141_1.leftNameTxt_.text = var_144_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_33 = arg_141_1:GetWordFromCfg(423121034)
				local var_144_34 = arg_141_1:FormatText(var_144_33.content)

				arg_141_1.text_.text = var_144_34

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_35 = 23
				local var_144_36 = utf8.len(var_144_34)
				local var_144_37 = var_144_35 <= 0 and var_144_31 or var_144_31 * (var_144_36 / var_144_35)

				if var_144_37 > 0 and var_144_31 < var_144_37 then
					arg_141_1.talkMaxDuration = var_144_37

					if var_144_37 + var_144_30 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_37 + var_144_30
					end
				end

				arg_141_1.text_.text = var_144_34
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121034", "story_v_out_423121.awb") ~= 0 then
					local var_144_38 = manager.audio:GetVoiceLength("story_v_out_423121", "423121034", "story_v_out_423121.awb") / 1000

					if var_144_38 + var_144_30 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_38 + var_144_30
					end

					if var_144_33.prefab_name ~= "" and arg_141_1.actors_[var_144_33.prefab_name] ~= nil then
						local var_144_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_33.prefab_name].transform, "story_v_out_423121", "423121034", "story_v_out_423121.awb")

						arg_141_1:RecordAudio("423121034", var_144_39)
						arg_141_1:RecordAudio("423121034", var_144_39)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_423121", "423121034", "story_v_out_423121.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_423121", "423121034", "story_v_out_423121.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_40 = math.max(var_144_31, arg_141_1.talkMaxDuration)

			if var_144_30 <= arg_141_1.time_ and arg_141_1.time_ < var_144_30 + var_144_40 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_30) / var_144_40

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_30 + var_144_40 and arg_141_1.time_ < var_144_30 + var_144_40 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play423121035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 423121035
		arg_145_1.duration_ = 15.43

		local var_145_0 = {
			zh = 9.1,
			ja = 15.433
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
				arg_145_0:Play423121036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10146"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos10146 = var_148_0.localPosition
				var_148_0.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10146", 4)

				local var_148_2 = var_148_0.childCount

				for iter_148_0 = 0, var_148_2 - 1 do
					local var_148_3 = var_148_0:GetChild(iter_148_0)

					if var_148_3.name == "" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_4 then
				local var_148_5 = (arg_145_1.time_ - var_148_1) / var_148_4
				local var_148_6 = Vector3.New(390, -350, -320)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10146, var_148_6, var_148_5)
			end

			if arg_145_1.time_ >= var_148_1 + var_148_4 and arg_145_1.time_ < var_148_1 + var_148_4 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(390, -350, -320)
			end

			local var_148_7 = arg_145_1.actors_["3054"].transform
			local var_148_8 = 0

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.var_.moveOldPos3054 = var_148_7.localPosition
				var_148_7.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("3054", 2)

				local var_148_9 = var_148_7.childCount

				for iter_148_1 = 0, var_148_9 - 1 do
					local var_148_10 = var_148_7:GetChild(iter_148_1)

					if var_148_10.name == "split_5" or not string.find(var_148_10.name, "split") then
						var_148_10.gameObject:SetActive(true)
					else
						var_148_10.gameObject:SetActive(false)
					end
				end
			end

			local var_148_11 = 0.001

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_11 then
				local var_148_12 = (arg_145_1.time_ - var_148_8) / var_148_11
				local var_148_13 = Vector3.New(-390, -275, -280)

				var_148_7.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos3054, var_148_13, var_148_12)
			end

			if arg_145_1.time_ >= var_148_8 + var_148_11 and arg_145_1.time_ < var_148_8 + var_148_11 + arg_148_0 then
				var_148_7.localPosition = Vector3.New(-390, -275, -280)
			end

			local var_148_14 = 0
			local var_148_15 = 1

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_16 = arg_145_1:FormatText(StoryNameCfg[1338].name)

				arg_145_1.leftNameTxt_.text = var_148_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_17 = arg_145_1:GetWordFromCfg(423121035)
				local var_148_18 = arg_145_1:FormatText(var_148_17.content)

				arg_145_1.text_.text = var_148_18

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_19 = 40
				local var_148_20 = utf8.len(var_148_18)
				local var_148_21 = var_148_19 <= 0 and var_148_15 or var_148_15 * (var_148_20 / var_148_19)

				if var_148_21 > 0 and var_148_15 < var_148_21 then
					arg_145_1.talkMaxDuration = var_148_21

					if var_148_21 + var_148_14 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_21 + var_148_14
					end
				end

				arg_145_1.text_.text = var_148_18
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121035", "story_v_out_423121.awb") ~= 0 then
					local var_148_22 = manager.audio:GetVoiceLength("story_v_out_423121", "423121035", "story_v_out_423121.awb") / 1000

					if var_148_22 + var_148_14 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_14
					end

					if var_148_17.prefab_name ~= "" and arg_145_1.actors_[var_148_17.prefab_name] ~= nil then
						local var_148_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_17.prefab_name].transform, "story_v_out_423121", "423121035", "story_v_out_423121.awb")

						arg_145_1:RecordAudio("423121035", var_148_23)
						arg_145_1:RecordAudio("423121035", var_148_23)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_423121", "423121035", "story_v_out_423121.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_423121", "423121035", "story_v_out_423121.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_24 = math.max(var_148_15, arg_145_1.talkMaxDuration)

			if var_148_14 <= arg_145_1.time_ and arg_145_1.time_ < var_148_14 + var_148_24 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_14) / var_148_24

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_14 + var_148_24 and arg_145_1.time_ < var_148_14 + var_148_24 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play423121036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 423121036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play423121037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10146"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10146 == nil then
				arg_149_1.var_.actorSpriteComps10146 = var_152_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_2 = 0.2

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.actorSpriteComps10146 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								local var_152_4 = Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor2.r, var_152_3)
								local var_152_5 = Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor2.g, var_152_3)
								local var_152_6 = Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor2.b, var_152_3)

								iter_152_1.color = Color.New(var_152_4, var_152_5, var_152_6)
							else
								local var_152_7 = Mathf.Lerp(iter_152_1.color.r, 0.5, var_152_3)

								iter_152_1.color = Color.New(var_152_7, var_152_7, var_152_7)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.actorSpriteComps10146 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_152_3 then
						if arg_149_1.isInRecall_ then
							iter_152_3.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10146 = nil
			end

			local var_152_8 = arg_149_1.actors_["10146"].transform
			local var_152_9 = 0

			if var_152_9 < arg_149_1.time_ and arg_149_1.time_ <= var_152_9 + arg_152_0 then
				arg_149_1.var_.moveOldPos10146 = var_152_8.localPosition
				var_152_8.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10146", 7)

				local var_152_10 = var_152_8.childCount

				for iter_152_4 = 0, var_152_10 - 1 do
					local var_152_11 = var_152_8:GetChild(iter_152_4)

					if var_152_11.name == "" or not string.find(var_152_11.name, "split") then
						var_152_11.gameObject:SetActive(true)
					else
						var_152_11.gameObject:SetActive(false)
					end
				end
			end

			local var_152_12 = 0.001

			if var_152_9 <= arg_149_1.time_ and arg_149_1.time_ < var_152_9 + var_152_12 then
				local var_152_13 = (arg_149_1.time_ - var_152_9) / var_152_12
				local var_152_14 = Vector3.New(0, -2000, 0)

				var_152_8.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10146, var_152_14, var_152_13)
			end

			if arg_149_1.time_ >= var_152_9 + var_152_12 and arg_149_1.time_ < var_152_9 + var_152_12 + arg_152_0 then
				var_152_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_152_15 = arg_149_1.actors_["3054"].transform
			local var_152_16 = 0

			if var_152_16 < arg_149_1.time_ and arg_149_1.time_ <= var_152_16 + arg_152_0 then
				arg_149_1.var_.moveOldPos3054 = var_152_15.localPosition
				var_152_15.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("3054", 7)

				local var_152_17 = var_152_15.childCount

				for iter_152_5 = 0, var_152_17 - 1 do
					local var_152_18 = var_152_15:GetChild(iter_152_5)

					if var_152_18.name == "" or not string.find(var_152_18.name, "split") then
						var_152_18.gameObject:SetActive(true)
					else
						var_152_18.gameObject:SetActive(false)
					end
				end
			end

			local var_152_19 = 0.001

			if var_152_16 <= arg_149_1.time_ and arg_149_1.time_ < var_152_16 + var_152_19 then
				local var_152_20 = (arg_149_1.time_ - var_152_16) / var_152_19
				local var_152_21 = Vector3.New(0, -2000, 0)

				var_152_15.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos3054, var_152_21, var_152_20)
			end

			if arg_149_1.time_ >= var_152_16 + var_152_19 and arg_149_1.time_ < var_152_16 + var_152_19 + arg_152_0 then
				var_152_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_152_22 = 1.26666666666667
			local var_152_23 = 1

			if var_152_22 < arg_149_1.time_ and arg_149_1.time_ <= var_152_22 + arg_152_0 then
				local var_152_24 = "play"
				local var_152_25 = "effect"

				arg_149_1:AudioAction(var_152_24, var_152_25, "se_story_144", "se_story_144_door_close", "")
			end

			local var_152_26 = 0
			local var_152_27 = 1.375

			if var_152_26 < arg_149_1.time_ and arg_149_1.time_ <= var_152_26 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_28 = arg_149_1:GetWordFromCfg(423121036)
				local var_152_29 = arg_149_1:FormatText(var_152_28.content)

				arg_149_1.text_.text = var_152_29

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_30 = 55
				local var_152_31 = utf8.len(var_152_29)
				local var_152_32 = var_152_30 <= 0 and var_152_27 or var_152_27 * (var_152_31 / var_152_30)

				if var_152_32 > 0 and var_152_27 < var_152_32 then
					arg_149_1.talkMaxDuration = var_152_32

					if var_152_32 + var_152_26 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_32 + var_152_26
					end
				end

				arg_149_1.text_.text = var_152_29
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_33 = math.max(var_152_27, arg_149_1.talkMaxDuration)

			if var_152_26 <= arg_149_1.time_ and arg_149_1.time_ < var_152_26 + var_152_33 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_26) / var_152_33

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_26 + var_152_33 and arg_149_1.time_ < var_152_26 + var_152_33 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play423121037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 423121037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play423121038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 1.1

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_2 = arg_153_1:GetWordFromCfg(423121037)
				local var_156_3 = arg_153_1:FormatText(var_156_2.content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 44
				local var_156_5 = utf8.len(var_156_3)
				local var_156_6 = var_156_4 <= 0 and var_156_1 or var_156_1 * (var_156_5 / var_156_4)

				if var_156_6 > 0 and var_156_1 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_7 and arg_153_1.time_ < var_156_0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play423121038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 423121038
		arg_157_1.duration_ = 3.73

		local var_157_0 = {
			zh = 3.3,
			ja = 3.733
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play423121039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.375

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[1336].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:GetWordFromCfg(423121038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 15
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121038", "story_v_out_423121.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_423121", "423121038", "story_v_out_423121.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_423121", "423121038", "story_v_out_423121.awb")

						arg_157_1:RecordAudio("423121038", var_160_9)
						arg_157_1:RecordAudio("423121038", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_423121", "423121038", "story_v_out_423121.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_423121", "423121038", "story_v_out_423121.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_10 and arg_157_1.time_ < var_160_0 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play423121039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 423121039
		arg_161_1.duration_ = 9.3

		local var_161_0 = {
			zh = 7.166,
			ja = 9.3
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
				arg_161_0:Play423121040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["3054"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps3054 == nil then
				arg_161_1.var_.actorSpriteComps3054 = var_164_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_2 = 0.2

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.actorSpriteComps3054 then
					for iter_164_0, iter_164_1 in pairs(arg_161_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_164_1 then
							if arg_161_1.isInRecall_ then
								local var_164_4 = Mathf.Lerp(iter_164_1.color.r, arg_161_1.hightColor1.r, var_164_3)
								local var_164_5 = Mathf.Lerp(iter_164_1.color.g, arg_161_1.hightColor1.g, var_164_3)
								local var_164_6 = Mathf.Lerp(iter_164_1.color.b, arg_161_1.hightColor1.b, var_164_3)

								iter_164_1.color = Color.New(var_164_4, var_164_5, var_164_6)
							else
								local var_164_7 = Mathf.Lerp(iter_164_1.color.r, 1, var_164_3)

								iter_164_1.color = Color.New(var_164_7, var_164_7, var_164_7)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.actorSpriteComps3054 then
				for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_164_3 then
						if arg_161_1.isInRecall_ then
							iter_164_3.color = arg_161_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_164_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_161_1.var_.actorSpriteComps3054 = nil
			end

			local var_164_8 = arg_161_1.actors_["3054"].transform
			local var_164_9 = 0

			if var_164_9 < arg_161_1.time_ and arg_161_1.time_ <= var_164_9 + arg_164_0 then
				arg_161_1.var_.moveOldPos3054 = var_164_8.localPosition
				var_164_8.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("3054", 3)

				local var_164_10 = var_164_8.childCount

				for iter_164_4 = 0, var_164_10 - 1 do
					local var_164_11 = var_164_8:GetChild(iter_164_4)

					if var_164_11.name == "" or not string.find(var_164_11.name, "split") then
						var_164_11.gameObject:SetActive(true)
					else
						var_164_11.gameObject:SetActive(false)
					end
				end
			end

			local var_164_12 = 0.001

			if var_164_9 <= arg_161_1.time_ and arg_161_1.time_ < var_164_9 + var_164_12 then
				local var_164_13 = (arg_161_1.time_ - var_164_9) / var_164_12
				local var_164_14 = Vector3.New(0, -275, -280)

				var_164_8.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos3054, var_164_14, var_164_13)
			end

			if arg_161_1.time_ >= var_164_9 + var_164_12 and arg_161_1.time_ < var_164_9 + var_164_12 + arg_164_0 then
				var_164_8.localPosition = Vector3.New(0, -275, -280)
			end

			local var_164_15 = 0
			local var_164_16 = 0.775

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_17 = arg_161_1:FormatText(StoryNameCfg[1339].name)

				arg_161_1.leftNameTxt_.text = var_164_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_18 = arg_161_1:GetWordFromCfg(423121039)
				local var_164_19 = arg_161_1:FormatText(var_164_18.content)

				arg_161_1.text_.text = var_164_19

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_20 = 31
				local var_164_21 = utf8.len(var_164_19)
				local var_164_22 = var_164_20 <= 0 and var_164_16 or var_164_16 * (var_164_21 / var_164_20)

				if var_164_22 > 0 and var_164_16 < var_164_22 then
					arg_161_1.talkMaxDuration = var_164_22

					if var_164_22 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_22 + var_164_15
					end
				end

				arg_161_1.text_.text = var_164_19
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121039", "story_v_out_423121.awb") ~= 0 then
					local var_164_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121039", "story_v_out_423121.awb") / 1000

					if var_164_23 + var_164_15 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_23 + var_164_15
					end

					if var_164_18.prefab_name ~= "" and arg_161_1.actors_[var_164_18.prefab_name] ~= nil then
						local var_164_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_18.prefab_name].transform, "story_v_out_423121", "423121039", "story_v_out_423121.awb")

						arg_161_1:RecordAudio("423121039", var_164_24)
						arg_161_1:RecordAudio("423121039", var_164_24)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_423121", "423121039", "story_v_out_423121.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_423121", "423121039", "story_v_out_423121.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_25 = math.max(var_164_16, arg_161_1.talkMaxDuration)

			if var_164_15 <= arg_161_1.time_ and arg_161_1.time_ < var_164_15 + var_164_25 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_15) / var_164_25

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_15 + var_164_25 and arg_161_1.time_ < var_164_15 + var_164_25 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play423121040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 423121040
		arg_165_1.duration_ = 9.63

		local var_165_0 = {
			zh = 8.166,
			ja = 9.633
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
				arg_165_0:Play423121041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["3054"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos3054 = var_168_0.localPosition
				var_168_0.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("3054", 3)

				local var_168_2 = var_168_0.childCount

				for iter_168_0 = 0, var_168_2 - 1 do
					local var_168_3 = var_168_0:GetChild(iter_168_0)

					if var_168_3.name == "" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_4 then
				local var_168_5 = (arg_165_1.time_ - var_168_1) / var_168_4
				local var_168_6 = Vector3.New(0, -275, -280)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos3054, var_168_6, var_168_5)
			end

			if arg_165_1.time_ >= var_168_1 + var_168_4 and arg_165_1.time_ < var_168_1 + var_168_4 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0, -275, -280)
			end

			local var_168_7 = 0
			local var_168_8 = 0.675

			if var_168_7 < arg_165_1.time_ and arg_165_1.time_ <= var_168_7 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_9 = arg_165_1:FormatText(StoryNameCfg[1339].name)

				arg_165_1.leftNameTxt_.text = var_168_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_10 = arg_165_1:GetWordFromCfg(423121040)
				local var_168_11 = arg_165_1:FormatText(var_168_10.content)

				arg_165_1.text_.text = var_168_11

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_12 = 27
				local var_168_13 = utf8.len(var_168_11)
				local var_168_14 = var_168_12 <= 0 and var_168_8 or var_168_8 * (var_168_13 / var_168_12)

				if var_168_14 > 0 and var_168_8 < var_168_14 then
					arg_165_1.talkMaxDuration = var_168_14

					if var_168_14 + var_168_7 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_14 + var_168_7
					end
				end

				arg_165_1.text_.text = var_168_11
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121040", "story_v_out_423121.awb") ~= 0 then
					local var_168_15 = manager.audio:GetVoiceLength("story_v_out_423121", "423121040", "story_v_out_423121.awb") / 1000

					if var_168_15 + var_168_7 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_7
					end

					if var_168_10.prefab_name ~= "" and arg_165_1.actors_[var_168_10.prefab_name] ~= nil then
						local var_168_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_10.prefab_name].transform, "story_v_out_423121", "423121040", "story_v_out_423121.awb")

						arg_165_1:RecordAudio("423121040", var_168_16)
						arg_165_1:RecordAudio("423121040", var_168_16)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_423121", "423121040", "story_v_out_423121.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_423121", "423121040", "story_v_out_423121.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_17 = math.max(var_168_8, arg_165_1.talkMaxDuration)

			if var_168_7 <= arg_165_1.time_ and arg_165_1.time_ < var_168_7 + var_168_17 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_7) / var_168_17

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_7 + var_168_17 and arg_165_1.time_ < var_168_7 + var_168_17 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play423121041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 423121041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play423121042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["3054"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps3054 == nil then
				arg_169_1.var_.actorSpriteComps3054 = var_172_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_2 = 0.2

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.actorSpriteComps3054 then
					for iter_172_0, iter_172_1 in pairs(arg_169_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_172_1 then
							if arg_169_1.isInRecall_ then
								local var_172_4 = Mathf.Lerp(iter_172_1.color.r, arg_169_1.hightColor2.r, var_172_3)
								local var_172_5 = Mathf.Lerp(iter_172_1.color.g, arg_169_1.hightColor2.g, var_172_3)
								local var_172_6 = Mathf.Lerp(iter_172_1.color.b, arg_169_1.hightColor2.b, var_172_3)

								iter_172_1.color = Color.New(var_172_4, var_172_5, var_172_6)
							else
								local var_172_7 = Mathf.Lerp(iter_172_1.color.r, 0.5, var_172_3)

								iter_172_1.color = Color.New(var_172_7, var_172_7, var_172_7)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.actorSpriteComps3054 then
				for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_172_3 then
						if arg_169_1.isInRecall_ then
							iter_172_3.color = arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_172_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_169_1.var_.actorSpriteComps3054 = nil
			end

			local var_172_8 = arg_169_1.actors_["3054"].transform
			local var_172_9 = 0

			if var_172_9 < arg_169_1.time_ and arg_169_1.time_ <= var_172_9 + arg_172_0 then
				arg_169_1.var_.moveOldPos3054 = var_172_8.localPosition
				var_172_8.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("3054", 7)

				local var_172_10 = var_172_8.childCount

				for iter_172_4 = 0, var_172_10 - 1 do
					local var_172_11 = var_172_8:GetChild(iter_172_4)

					if var_172_11.name == "" or not string.find(var_172_11.name, "split") then
						var_172_11.gameObject:SetActive(true)
					else
						var_172_11.gameObject:SetActive(false)
					end
				end
			end

			local var_172_12 = 0.001

			if var_172_9 <= arg_169_1.time_ and arg_169_1.time_ < var_172_9 + var_172_12 then
				local var_172_13 = (arg_169_1.time_ - var_172_9) / var_172_12
				local var_172_14 = Vector3.New(0, -2000, 0)

				var_172_8.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos3054, var_172_14, var_172_13)
			end

			if arg_169_1.time_ >= var_172_9 + var_172_12 and arg_169_1.time_ < var_172_9 + var_172_12 + arg_172_0 then
				var_172_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_172_15 = 0
			local var_172_16 = 1.3

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_17 = arg_169_1:GetWordFromCfg(423121041)
				local var_172_18 = arg_169_1:FormatText(var_172_17.content)

				arg_169_1.text_.text = var_172_18

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_19 = 52
				local var_172_20 = utf8.len(var_172_18)
				local var_172_21 = var_172_19 <= 0 and var_172_16 or var_172_16 * (var_172_20 / var_172_19)

				if var_172_21 > 0 and var_172_16 < var_172_21 then
					arg_169_1.talkMaxDuration = var_172_21

					if var_172_21 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_21 + var_172_15
					end
				end

				arg_169_1.text_.text = var_172_18
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_22 = math.max(var_172_16, arg_169_1.talkMaxDuration)

			if var_172_15 <= arg_169_1.time_ and arg_169_1.time_ < var_172_15 + var_172_22 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_15) / var_172_22

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_15 + var_172_22 and arg_169_1.time_ < var_172_15 + var_172_22 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play423121042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 423121042
		arg_173_1.duration_ = 7.2

		local var_173_0 = {
			zh = 7.2,
			ja = 6.7
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play423121043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["3054"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps3054 == nil then
				arg_173_1.var_.actorSpriteComps3054 = var_176_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_2 = 0.2

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.actorSpriteComps3054 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								local var_176_4 = Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, var_176_3)
								local var_176_5 = Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, var_176_3)
								local var_176_6 = Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, var_176_3)

								iter_176_1.color = Color.New(var_176_4, var_176_5, var_176_6)
							else
								local var_176_7 = Mathf.Lerp(iter_176_1.color.r, 1, var_176_3)

								iter_176_1.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.actorSpriteComps3054 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_176_3 then
						if arg_173_1.isInRecall_ then
							iter_176_3.color = arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_176_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps3054 = nil
			end

			local var_176_8 = arg_173_1.actors_["3054"].transform
			local var_176_9 = 0

			if var_176_9 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 then
				arg_173_1.var_.moveOldPos3054 = var_176_8.localPosition
				var_176_8.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("3054", 3)

				local var_176_10 = var_176_8.childCount

				for iter_176_4 = 0, var_176_10 - 1 do
					local var_176_11 = var_176_8:GetChild(iter_176_4)

					if var_176_11.name == "" or not string.find(var_176_11.name, "split") then
						var_176_11.gameObject:SetActive(true)
					else
						var_176_11.gameObject:SetActive(false)
					end
				end
			end

			local var_176_12 = 0.001

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_12 then
				local var_176_13 = (arg_173_1.time_ - var_176_9) / var_176_12
				local var_176_14 = Vector3.New(0, -275, -280)

				var_176_8.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos3054, var_176_14, var_176_13)
			end

			if arg_173_1.time_ >= var_176_9 + var_176_12 and arg_173_1.time_ < var_176_9 + var_176_12 + arg_176_0 then
				var_176_8.localPosition = Vector3.New(0, -275, -280)
			end

			local var_176_15 = 0
			local var_176_16 = 0.725

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_17 = arg_173_1:FormatText(StoryNameCfg[1339].name)

				arg_173_1.leftNameTxt_.text = var_176_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_18 = arg_173_1:GetWordFromCfg(423121042)
				local var_176_19 = arg_173_1:FormatText(var_176_18.content)

				arg_173_1.text_.text = var_176_19

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_20 = 29
				local var_176_21 = utf8.len(var_176_19)
				local var_176_22 = var_176_20 <= 0 and var_176_16 or var_176_16 * (var_176_21 / var_176_20)

				if var_176_22 > 0 and var_176_16 < var_176_22 then
					arg_173_1.talkMaxDuration = var_176_22

					if var_176_22 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_22 + var_176_15
					end
				end

				arg_173_1.text_.text = var_176_19
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121042", "story_v_out_423121.awb") ~= 0 then
					local var_176_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121042", "story_v_out_423121.awb") / 1000

					if var_176_23 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_23 + var_176_15
					end

					if var_176_18.prefab_name ~= "" and arg_173_1.actors_[var_176_18.prefab_name] ~= nil then
						local var_176_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_18.prefab_name].transform, "story_v_out_423121", "423121042", "story_v_out_423121.awb")

						arg_173_1:RecordAudio("423121042", var_176_24)
						arg_173_1:RecordAudio("423121042", var_176_24)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_423121", "423121042", "story_v_out_423121.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_423121", "423121042", "story_v_out_423121.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_25 = math.max(var_176_16, arg_173_1.talkMaxDuration)

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_25 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_15) / var_176_25

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_15 + var_176_25 and arg_173_1.time_ < var_176_15 + var_176_25 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play423121043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 423121043
		arg_177_1.duration_ = 6.73

		local var_177_0 = {
			zh = 5.166,
			ja = 6.733
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play423121044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["3054"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos3054 = var_180_0.localPosition
				var_180_0.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("3054", 3)

				local var_180_2 = var_180_0.childCount

				for iter_180_0 = 0, var_180_2 - 1 do
					local var_180_3 = var_180_0:GetChild(iter_180_0)

					if var_180_3.name == "" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_4 then
				local var_180_5 = (arg_177_1.time_ - var_180_1) / var_180_4
				local var_180_6 = Vector3.New(0, -275, -280)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos3054, var_180_6, var_180_5)
			end

			if arg_177_1.time_ >= var_180_1 + var_180_4 and arg_177_1.time_ < var_180_1 + var_180_4 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -275, -280)
			end

			local var_180_7 = 0
			local var_180_8 = 0.5

			if var_180_7 < arg_177_1.time_ and arg_177_1.time_ <= var_180_7 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_9 = arg_177_1:FormatText(StoryNameCfg[1339].name)

				arg_177_1.leftNameTxt_.text = var_180_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_10 = arg_177_1:GetWordFromCfg(423121043)
				local var_180_11 = arg_177_1:FormatText(var_180_10.content)

				arg_177_1.text_.text = var_180_11

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_12 = 20
				local var_180_13 = utf8.len(var_180_11)
				local var_180_14 = var_180_12 <= 0 and var_180_8 or var_180_8 * (var_180_13 / var_180_12)

				if var_180_14 > 0 and var_180_8 < var_180_14 then
					arg_177_1.talkMaxDuration = var_180_14

					if var_180_14 + var_180_7 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_7
					end
				end

				arg_177_1.text_.text = var_180_11
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121043", "story_v_out_423121.awb") ~= 0 then
					local var_180_15 = manager.audio:GetVoiceLength("story_v_out_423121", "423121043", "story_v_out_423121.awb") / 1000

					if var_180_15 + var_180_7 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_15 + var_180_7
					end

					if var_180_10.prefab_name ~= "" and arg_177_1.actors_[var_180_10.prefab_name] ~= nil then
						local var_180_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_10.prefab_name].transform, "story_v_out_423121", "423121043", "story_v_out_423121.awb")

						arg_177_1:RecordAudio("423121043", var_180_16)
						arg_177_1:RecordAudio("423121043", var_180_16)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_423121", "423121043", "story_v_out_423121.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_423121", "423121043", "story_v_out_423121.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_17 = math.max(var_180_8, arg_177_1.talkMaxDuration)

			if var_180_7 <= arg_177_1.time_ and arg_177_1.time_ < var_180_7 + var_180_17 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_7) / var_180_17

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_7 + var_180_17 and arg_177_1.time_ < var_180_7 + var_180_17 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play423121044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 423121044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play423121045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["3054"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps3054 == nil then
				arg_181_1.var_.actorSpriteComps3054 = var_184_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_2 = 0.2

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.actorSpriteComps3054 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_184_1 then
							if arg_181_1.isInRecall_ then
								local var_184_4 = Mathf.Lerp(iter_184_1.color.r, arg_181_1.hightColor2.r, var_184_3)
								local var_184_5 = Mathf.Lerp(iter_184_1.color.g, arg_181_1.hightColor2.g, var_184_3)
								local var_184_6 = Mathf.Lerp(iter_184_1.color.b, arg_181_1.hightColor2.b, var_184_3)

								iter_184_1.color = Color.New(var_184_4, var_184_5, var_184_6)
							else
								local var_184_7 = Mathf.Lerp(iter_184_1.color.r, 0.5, var_184_3)

								iter_184_1.color = Color.New(var_184_7, var_184_7, var_184_7)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.actorSpriteComps3054 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_184_3 then
						if arg_181_1.isInRecall_ then
							iter_184_3.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps3054 = nil
			end

			local var_184_8 = arg_181_1.actors_["3054"].transform
			local var_184_9 = 0

			if var_184_9 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 then
				arg_181_1.var_.moveOldPos3054 = var_184_8.localPosition
				var_184_8.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("3054", 7)

				local var_184_10 = var_184_8.childCount

				for iter_184_4 = 0, var_184_10 - 1 do
					local var_184_11 = var_184_8:GetChild(iter_184_4)

					if var_184_11.name == "" or not string.find(var_184_11.name, "split") then
						var_184_11.gameObject:SetActive(true)
					else
						var_184_11.gameObject:SetActive(false)
					end
				end
			end

			local var_184_12 = 0.001

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_12 then
				local var_184_13 = (arg_181_1.time_ - var_184_9) / var_184_12
				local var_184_14 = Vector3.New(0, -2000, 0)

				var_184_8.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos3054, var_184_14, var_184_13)
			end

			if arg_181_1.time_ >= var_184_9 + var_184_12 and arg_181_1.time_ < var_184_9 + var_184_12 + arg_184_0 then
				var_184_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_184_15 = 0.6
			local var_184_16 = 1

			if var_184_15 < arg_181_1.time_ and arg_181_1.time_ <= var_184_15 + arg_184_0 then
				local var_184_17 = "play"
				local var_184_18 = "effect"

				arg_181_1:AudioAction(var_184_17, var_184_18, "se_story_144", "se_story_144_gun03", "")
			end

			local var_184_19 = 0
			local var_184_20 = 1.25

			if var_184_19 < arg_181_1.time_ and arg_181_1.time_ <= var_184_19 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_21 = arg_181_1:GetWordFromCfg(423121044)
				local var_184_22 = arg_181_1:FormatText(var_184_21.content)

				arg_181_1.text_.text = var_184_22

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_23 = 50
				local var_184_24 = utf8.len(var_184_22)
				local var_184_25 = var_184_23 <= 0 and var_184_20 or var_184_20 * (var_184_24 / var_184_23)

				if var_184_25 > 0 and var_184_20 < var_184_25 then
					arg_181_1.talkMaxDuration = var_184_25

					if var_184_25 + var_184_19 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_25 + var_184_19
					end
				end

				arg_181_1.text_.text = var_184_22
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_26 = math.max(var_184_20, arg_181_1.talkMaxDuration)

			if var_184_19 <= arg_181_1.time_ and arg_181_1.time_ < var_184_19 + var_184_26 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_19) / var_184_26

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_19 + var_184_26 and arg_181_1.time_ < var_184_19 + var_184_26 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play423121045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 423121045
		arg_185_1.duration_ = 7.3

		local var_185_0 = {
			zh = 7.3,
			ja = 7.066
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play423121046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["3054"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps3054 == nil then
				arg_185_1.var_.actorSpriteComps3054 = var_188_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_2 = 0.2

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.actorSpriteComps3054 then
					for iter_188_0, iter_188_1 in pairs(arg_185_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_188_1 then
							if arg_185_1.isInRecall_ then
								local var_188_4 = Mathf.Lerp(iter_188_1.color.r, arg_185_1.hightColor1.r, var_188_3)
								local var_188_5 = Mathf.Lerp(iter_188_1.color.g, arg_185_1.hightColor1.g, var_188_3)
								local var_188_6 = Mathf.Lerp(iter_188_1.color.b, arg_185_1.hightColor1.b, var_188_3)

								iter_188_1.color = Color.New(var_188_4, var_188_5, var_188_6)
							else
								local var_188_7 = Mathf.Lerp(iter_188_1.color.r, 1, var_188_3)

								iter_188_1.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.actorSpriteComps3054 then
				for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_188_3 then
						if arg_185_1.isInRecall_ then
							iter_188_3.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps3054 = nil
			end

			local var_188_8 = arg_185_1.actors_["3054"].transform
			local var_188_9 = 0

			if var_188_9 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 then
				arg_185_1.var_.moveOldPos3054 = var_188_8.localPosition
				var_188_8.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("3054", 3)

				local var_188_10 = var_188_8.childCount

				for iter_188_4 = 0, var_188_10 - 1 do
					local var_188_11 = var_188_8:GetChild(iter_188_4)

					if var_188_11.name == "split_3" or not string.find(var_188_11.name, "split") then
						var_188_11.gameObject:SetActive(true)
					else
						var_188_11.gameObject:SetActive(false)
					end
				end
			end

			local var_188_12 = 0.001

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_12 then
				local var_188_13 = (arg_185_1.time_ - var_188_9) / var_188_12
				local var_188_14 = Vector3.New(0, -275, -280)

				var_188_8.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos3054, var_188_14, var_188_13)
			end

			if arg_185_1.time_ >= var_188_9 + var_188_12 and arg_185_1.time_ < var_188_9 + var_188_12 + arg_188_0 then
				var_188_8.localPosition = Vector3.New(0, -275, -280)
			end

			local var_188_15 = 0
			local var_188_16 = 0.625

			if var_188_15 < arg_185_1.time_ and arg_185_1.time_ <= var_188_15 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_17 = arg_185_1:FormatText(StoryNameCfg[1339].name)

				arg_185_1.leftNameTxt_.text = var_188_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_18 = arg_185_1:GetWordFromCfg(423121045)
				local var_188_19 = arg_185_1:FormatText(var_188_18.content)

				arg_185_1.text_.text = var_188_19

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_20 = 25
				local var_188_21 = utf8.len(var_188_19)
				local var_188_22 = var_188_20 <= 0 and var_188_16 or var_188_16 * (var_188_21 / var_188_20)

				if var_188_22 > 0 and var_188_16 < var_188_22 then
					arg_185_1.talkMaxDuration = var_188_22

					if var_188_22 + var_188_15 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_22 + var_188_15
					end
				end

				arg_185_1.text_.text = var_188_19
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121045", "story_v_out_423121.awb") ~= 0 then
					local var_188_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121045", "story_v_out_423121.awb") / 1000

					if var_188_23 + var_188_15 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_23 + var_188_15
					end

					if var_188_18.prefab_name ~= "" and arg_185_1.actors_[var_188_18.prefab_name] ~= nil then
						local var_188_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_18.prefab_name].transform, "story_v_out_423121", "423121045", "story_v_out_423121.awb")

						arg_185_1:RecordAudio("423121045", var_188_24)
						arg_185_1:RecordAudio("423121045", var_188_24)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_423121", "423121045", "story_v_out_423121.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_423121", "423121045", "story_v_out_423121.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_25 = math.max(var_188_16, arg_185_1.talkMaxDuration)

			if var_188_15 <= arg_185_1.time_ and arg_185_1.time_ < var_188_15 + var_188_25 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_15) / var_188_25

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_15 + var_188_25 and arg_185_1.time_ < var_188_15 + var_188_25 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play423121046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 423121046
		arg_189_1.duration_ = 10.37

		local var_189_0 = {
			zh = 8.533,
			ja = 10.366
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
				arg_189_0:Play423121047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.65

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[1339].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(423121046)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 27
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121046", "story_v_out_423121.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_423121", "423121046", "story_v_out_423121.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_423121", "423121046", "story_v_out_423121.awb")

						arg_189_1:RecordAudio("423121046", var_192_9)
						arg_189_1:RecordAudio("423121046", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_423121", "423121046", "story_v_out_423121.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_423121", "423121046", "story_v_out_423121.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play423121047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 423121047
		arg_193_1.duration_ = 10.43

		local var_193_0 = {
			zh = 10.433,
			ja = 10.266
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play423121048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["3054"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos3054 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("3054", 3)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(0, -275, -280)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos3054, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(0, -275, -280)
			end

			local var_196_7 = 0
			local var_196_8 = 0.875

			if var_196_7 < arg_193_1.time_ and arg_193_1.time_ <= var_196_7 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_9 = arg_193_1:FormatText(StoryNameCfg[1339].name)

				arg_193_1.leftNameTxt_.text = var_196_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_10 = arg_193_1:GetWordFromCfg(423121047)
				local var_196_11 = arg_193_1:FormatText(var_196_10.content)

				arg_193_1.text_.text = var_196_11

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_12 = 35
				local var_196_13 = utf8.len(var_196_11)
				local var_196_14 = var_196_12 <= 0 and var_196_8 or var_196_8 * (var_196_13 / var_196_12)

				if var_196_14 > 0 and var_196_8 < var_196_14 then
					arg_193_1.talkMaxDuration = var_196_14

					if var_196_14 + var_196_7 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_7
					end
				end

				arg_193_1.text_.text = var_196_11
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121047", "story_v_out_423121.awb") ~= 0 then
					local var_196_15 = manager.audio:GetVoiceLength("story_v_out_423121", "423121047", "story_v_out_423121.awb") / 1000

					if var_196_15 + var_196_7 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_15 + var_196_7
					end

					if var_196_10.prefab_name ~= "" and arg_193_1.actors_[var_196_10.prefab_name] ~= nil then
						local var_196_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_10.prefab_name].transform, "story_v_out_423121", "423121047", "story_v_out_423121.awb")

						arg_193_1:RecordAudio("423121047", var_196_16)
						arg_193_1:RecordAudio("423121047", var_196_16)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_423121", "423121047", "story_v_out_423121.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_423121", "423121047", "story_v_out_423121.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_17 = math.max(var_196_8, arg_193_1.talkMaxDuration)

			if var_196_7 <= arg_193_1.time_ and arg_193_1.time_ < var_196_7 + var_196_17 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_7) / var_196_17

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_7 + var_196_17 and arg_193_1.time_ < var_196_7 + var_196_17 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play423121048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 423121048
		arg_197_1.duration_ = 9

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play423121049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = "ST0112"

			if arg_197_1.bgs_[var_200_0] == nil then
				local var_200_1 = Object.Instantiate(arg_197_1.paintGo_)

				var_200_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_200_0)
				var_200_1.name = var_200_0
				var_200_1.transform.parent = arg_197_1.stage_.transform
				var_200_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_197_1.bgs_[var_200_0] = var_200_1
			end

			local var_200_2 = 2

			if var_200_2 < arg_197_1.time_ and arg_197_1.time_ <= var_200_2 + arg_200_0 then
				local var_200_3 = manager.ui.mainCamera.transform.localPosition
				local var_200_4 = Vector3.New(0, 0, 10) + Vector3.New(var_200_3.x, var_200_3.y, 0)
				local var_200_5 = arg_197_1.bgs_.ST0112

				var_200_5.transform.localPosition = var_200_4
				var_200_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_6 = var_200_5:GetComponent("SpriteRenderer")

				if var_200_6 and var_200_6.sprite then
					local var_200_7 = (var_200_5.transform.localPosition - var_200_3).z
					local var_200_8 = manager.ui.mainCameraCom_
					local var_200_9 = 2 * var_200_7 * Mathf.Tan(var_200_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_200_10 = var_200_9 * var_200_8.aspect
					local var_200_11 = var_200_6.sprite.bounds.size.x
					local var_200_12 = var_200_6.sprite.bounds.size.y
					local var_200_13 = var_200_10 / var_200_11
					local var_200_14 = var_200_9 / var_200_12
					local var_200_15 = var_200_14 < var_200_13 and var_200_13 or var_200_14

					var_200_5.transform.localScale = Vector3.New(var_200_15, var_200_15, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "ST0112" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_16 = 3.999999999999

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1.allBtn_.enabled = false
			end

			local var_200_17 = 0.3

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 then
				arg_197_1.allBtn_.enabled = true
			end

			local var_200_18 = 0

			if var_200_18 < arg_197_1.time_ and arg_197_1.time_ <= var_200_18 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_19 = 2

			if var_200_18 <= arg_197_1.time_ and arg_197_1.time_ < var_200_18 + var_200_19 then
				local var_200_20 = (arg_197_1.time_ - var_200_18) / var_200_19
				local var_200_21 = Color.New(0, 0, 0)

				var_200_21.a = Mathf.Lerp(0, 1, var_200_20)
				arg_197_1.mask_.color = var_200_21
			end

			if arg_197_1.time_ >= var_200_18 + var_200_19 and arg_197_1.time_ < var_200_18 + var_200_19 + arg_200_0 then
				local var_200_22 = Color.New(0, 0, 0)

				var_200_22.a = 1
				arg_197_1.mask_.color = var_200_22
			end

			local var_200_23 = 2

			if var_200_23 < arg_197_1.time_ and arg_197_1.time_ <= var_200_23 + arg_200_0 then
				arg_197_1.mask_.enabled = true
				arg_197_1.mask_.raycastTarget = true

				arg_197_1:SetGaussion(false)
			end

			local var_200_24 = 2

			if var_200_23 <= arg_197_1.time_ and arg_197_1.time_ < var_200_23 + var_200_24 then
				local var_200_25 = (arg_197_1.time_ - var_200_23) / var_200_24
				local var_200_26 = Color.New(0, 0, 0)

				var_200_26.a = Mathf.Lerp(1, 0, var_200_25)
				arg_197_1.mask_.color = var_200_26
			end

			if arg_197_1.time_ >= var_200_23 + var_200_24 and arg_197_1.time_ < var_200_23 + var_200_24 + arg_200_0 then
				local var_200_27 = Color.New(0, 0, 0)
				local var_200_28 = 0

				arg_197_1.mask_.enabled = false
				var_200_27.a = var_200_28
				arg_197_1.mask_.color = var_200_27
			end

			local var_200_29 = arg_197_1.actors_["3054"]
			local var_200_30 = 1.9

			if var_200_30 < arg_197_1.time_ and arg_197_1.time_ <= var_200_30 + arg_200_0 and not isNil(var_200_29) and arg_197_1.var_.actorSpriteComps3054 == nil then
				arg_197_1.var_.actorSpriteComps3054 = var_200_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_31 = 0.1

			if var_200_30 <= arg_197_1.time_ and arg_197_1.time_ < var_200_30 + var_200_31 and not isNil(var_200_29) then
				local var_200_32 = (arg_197_1.time_ - var_200_30) / var_200_31

				if arg_197_1.var_.actorSpriteComps3054 then
					for iter_200_2, iter_200_3 in pairs(arg_197_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_200_3 then
							if arg_197_1.isInRecall_ then
								local var_200_33 = Mathf.Lerp(iter_200_3.color.r, arg_197_1.hightColor2.r, var_200_32)
								local var_200_34 = Mathf.Lerp(iter_200_3.color.g, arg_197_1.hightColor2.g, var_200_32)
								local var_200_35 = Mathf.Lerp(iter_200_3.color.b, arg_197_1.hightColor2.b, var_200_32)

								iter_200_3.color = Color.New(var_200_33, var_200_34, var_200_35)
							else
								local var_200_36 = Mathf.Lerp(iter_200_3.color.r, 0.5, var_200_32)

								iter_200_3.color = Color.New(var_200_36, var_200_36, var_200_36)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_30 + var_200_31 and arg_197_1.time_ < var_200_30 + var_200_31 + arg_200_0 and not isNil(var_200_29) and arg_197_1.var_.actorSpriteComps3054 then
				for iter_200_4, iter_200_5 in pairs(arg_197_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_200_5 then
						if arg_197_1.isInRecall_ then
							iter_200_5.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps3054 = nil
			end

			local var_200_37 = arg_197_1.actors_["3054"].transform
			local var_200_38 = 1.966

			if var_200_38 < arg_197_1.time_ and arg_197_1.time_ <= var_200_38 + arg_200_0 then
				arg_197_1.var_.moveOldPos3054 = var_200_37.localPosition
				var_200_37.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("3054", 7)

				local var_200_39 = var_200_37.childCount

				for iter_200_6 = 0, var_200_39 - 1 do
					local var_200_40 = var_200_37:GetChild(iter_200_6)

					if var_200_40.name == "" or not string.find(var_200_40.name, "split") then
						var_200_40.gameObject:SetActive(true)
					else
						var_200_40.gameObject:SetActive(false)
					end
				end
			end

			local var_200_41 = 0.001

			if var_200_38 <= arg_197_1.time_ and arg_197_1.time_ < var_200_38 + var_200_41 then
				local var_200_42 = (arg_197_1.time_ - var_200_38) / var_200_41
				local var_200_43 = Vector3.New(0, -2000, 0)

				var_200_37.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos3054, var_200_43, var_200_42)
			end

			if arg_197_1.time_ >= var_200_38 + var_200_41 and arg_197_1.time_ < var_200_38 + var_200_41 + arg_200_0 then
				var_200_37.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_200_44 = 0.266666666666667
			local var_200_45 = 0.3

			if var_200_44 < arg_197_1.time_ and arg_197_1.time_ <= var_200_44 + arg_200_0 then
				local var_200_46 = "play"
				local var_200_47 = "music"

				arg_197_1:AudioAction(var_200_46, var_200_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_200_48 = ""
				local var_200_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_200_49 ~= "" then
					if arg_197_1.bgmTxt_.text ~= var_200_49 and arg_197_1.bgmTxt_.text ~= "" then
						if arg_197_1.bgmTxt2_.text ~= "" then
							arg_197_1.bgmTxt_.text = arg_197_1.bgmTxt2_.text
						end

						arg_197_1.bgmTxt2_.text = var_200_49

						arg_197_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_197_1.bgmTxt_.text = var_200_49
						arg_197_1.bgmTxt2_.text = var_200_49
					end

					if arg_197_1.bgmTimer then
						arg_197_1.bgmTimer:Stop()

						arg_197_1.bgmTimer = nil
					end

					if arg_197_1.settingData.show_music_name == 1 then
						arg_197_1.musicController:SetSelectedState("show")
						arg_197_1.musicAnimator_:Play("open", 0, 0)

						if arg_197_1.settingData.music_time ~= 0 then
							arg_197_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_197_1.settingData.music_time), function()
								if arg_197_1 == nil or isNil(arg_197_1.bgmTxt_) then
									return
								end

								arg_197_1.musicController:SetSelectedState("hide")
								arg_197_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_200_50 = 1.4
			local var_200_51 = 1

			if var_200_50 < arg_197_1.time_ and arg_197_1.time_ <= var_200_50 + arg_200_0 then
				local var_200_52 = "play"
				local var_200_53 = "music"

				arg_197_1:AudioAction(var_200_52, var_200_53, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_200_54 = ""
				local var_200_55 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if var_200_55 ~= "" then
					if arg_197_1.bgmTxt_.text ~= var_200_55 and arg_197_1.bgmTxt_.text ~= "" then
						if arg_197_1.bgmTxt2_.text ~= "" then
							arg_197_1.bgmTxt_.text = arg_197_1.bgmTxt2_.text
						end

						arg_197_1.bgmTxt2_.text = var_200_55

						arg_197_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_197_1.bgmTxt_.text = var_200_55
						arg_197_1.bgmTxt2_.text = var_200_55
					end

					if arg_197_1.bgmTimer then
						arg_197_1.bgmTimer:Stop()

						arg_197_1.bgmTimer = nil
					end

					if arg_197_1.settingData.show_music_name == 1 then
						arg_197_1.musicController:SetSelectedState("show")
						arg_197_1.musicAnimator_:Play("open", 0, 0)

						if arg_197_1.settingData.music_time ~= 0 then
							arg_197_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_197_1.settingData.music_time), function()
								if arg_197_1 == nil or isNil(arg_197_1.bgmTxt_) then
									return
								end

								arg_197_1.musicController:SetSelectedState("hide")
								arg_197_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_197_1.frameCnt_ <= 1 then
				arg_197_1.dialog_:SetActive(false)
			end

			local var_200_56 = 4
			local var_200_57 = 0.325

			if var_200_56 < arg_197_1.time_ and arg_197_1.time_ <= var_200_56 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				arg_197_1.dialog_:SetActive(true)

				arg_197_1.dialogCg_.alpha = 0

				local var_200_58 = LeanTween.value(arg_197_1.dialog_, 0, 1, 0.3)

				var_200_58:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_197_1.dialogCg_.alpha = arg_203_0
				end))
				var_200_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_197_1.dialog_)
					var_200_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_197_1.duration_ = arg_197_1.duration_ + 0.3

				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_59 = arg_197_1:FormatText(StoryNameCfg[7].name)

				arg_197_1.leftNameTxt_.text = var_200_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_60 = arg_197_1:GetWordFromCfg(423121048)
				local var_200_61 = arg_197_1:FormatText(var_200_60.content)

				arg_197_1.text_.text = var_200_61

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_62 = 13
				local var_200_63 = utf8.len(var_200_61)
				local var_200_64 = var_200_62 <= 0 and var_200_57 or var_200_57 * (var_200_63 / var_200_62)

				if var_200_64 > 0 and var_200_57 < var_200_64 then
					arg_197_1.talkMaxDuration = var_200_64
					var_200_56 = var_200_56 + 0.3

					if var_200_64 + var_200_56 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_64 + var_200_56
					end
				end

				arg_197_1.text_.text = var_200_61
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_65 = var_200_56 + 0.3
			local var_200_66 = math.max(var_200_57, arg_197_1.talkMaxDuration)

			if var_200_65 <= arg_197_1.time_ and arg_197_1.time_ < var_200_65 + var_200_66 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_65) / var_200_66

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_65 + var_200_66 and arg_197_1.time_ < var_200_65 + var_200_66 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play423121049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 423121049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play423121050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1
			local var_208_1 = 1

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				local var_208_2 = "play"
				local var_208_3 = "effect"

				arg_205_1:AudioAction(var_208_2, var_208_3, "se_story_144", "se_story_144_door_open", "")
			end

			local var_208_4 = 0
			local var_208_5 = 1.2

			if var_208_4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:GetWordFromCfg(423121049)
				local var_208_7 = arg_205_1:FormatText(var_208_6.content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_8 = 48
				local var_208_9 = utf8.len(var_208_7)
				local var_208_10 = var_208_8 <= 0 and var_208_5 or var_208_5 * (var_208_9 / var_208_8)

				if var_208_10 > 0 and var_208_5 < var_208_10 then
					arg_205_1.talkMaxDuration = var_208_10

					if var_208_10 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_11 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_11 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_11

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_11 and arg_205_1.time_ < var_208_4 + var_208_11 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play423121050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 423121050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play423121051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.166666666666667
			local var_212_1 = 1

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				local var_212_2 = "play"
				local var_212_3 = "effect"

				arg_209_1:AudioAction(var_212_2, var_212_3, "se_story_139", "se_story_139_bed", "")
			end

			local var_212_4 = 0
			local var_212_5 = 1.425

			if var_212_4 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(423121050)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_8 = 57
				local var_212_9 = utf8.len(var_212_7)
				local var_212_10 = var_212_8 <= 0 and var_212_5 or var_212_5 * (var_212_9 / var_212_8)

				if var_212_10 > 0 and var_212_5 < var_212_10 then
					arg_209_1.talkMaxDuration = var_212_10

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_11 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_11 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_11

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_11 and arg_209_1.time_ < var_212_4 + var_212_11 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play423121051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 423121051
		arg_213_1.duration_ = 1

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"

			SetActive(arg_213_1.choicesGo_, true)

			for iter_214_0, iter_214_1 in ipairs(arg_213_1.choices_) do
				local var_214_0 = iter_214_0 <= 2

				SetActive(iter_214_1.go, var_214_0)
			end

			arg_213_1.choices_[1].txt.text = arg_213_1:FormatText(StoryChoiceCfg[1375].name)
			arg_213_1.choices_[2].txt.text = arg_213_1:FormatText(StoryChoiceCfg[1376].name)
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play423121052(arg_213_1)
			end

			if arg_215_0 == 2 then
				arg_213_0:Play423121052(arg_213_1)
			end

			arg_213_1:RecordChoiceLog(423121051, 1375, 1376)
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.allBtn_.enabled = false
			end

			local var_216_1 = 0.5

			if arg_213_1.time_ >= var_216_0 + var_216_1 and arg_213_1.time_ < var_216_0 + var_216_1 + arg_216_0 then
				arg_213_1.allBtn_.enabled = true
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play423121052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 423121052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play423121053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.925

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_2 = arg_217_1:GetWordFromCfg(423121052)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 37
				local var_220_5 = utf8.len(var_220_3)
				local var_220_6 = var_220_4 <= 0 and var_220_1 or var_220_1 * (var_220_5 / var_220_4)

				if var_220_6 > 0 and var_220_1 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_7 and arg_217_1.time_ < var_220_0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play423121053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 423121053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play423121054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = manager.ui.mainCamera.transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.shakeOldPos = var_224_0.localPosition
			end

			local var_224_2 = 0.6

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / 0.066
				local var_224_4, var_224_5 = math.modf(var_224_3)

				var_224_0.localPosition = Vector3.New(var_224_5 * 0.13, var_224_5 * 0.13, var_224_5 * 0.13) + arg_221_1.var_.shakeOldPos
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = arg_221_1.var_.shakeOldPos
			end

			local var_224_6 = 0

			if var_224_6 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.allBtn_.enabled = false
			end

			local var_224_7 = 0.6

			if arg_221_1.time_ >= var_224_6 + var_224_7 and arg_221_1.time_ < var_224_6 + var_224_7 + arg_224_0 then
				arg_221_1.allBtn_.enabled = true
			end

			local var_224_8 = 0
			local var_224_9 = 0.4

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_10 = arg_221_1:FormatText(StoryNameCfg[7].name)

				arg_221_1.leftNameTxt_.text = var_224_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_11 = arg_221_1:GetWordFromCfg(423121053)
				local var_224_12 = arg_221_1:FormatText(var_224_11.content)

				arg_221_1.text_.text = var_224_12

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 16
				local var_224_14 = utf8.len(var_224_12)
				local var_224_15 = var_224_13 <= 0 and var_224_9 or var_224_9 * (var_224_14 / var_224_13)

				if var_224_15 > 0 and var_224_9 < var_224_15 then
					arg_221_1.talkMaxDuration = var_224_15

					if var_224_15 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_15 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_12
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_16 and arg_221_1.time_ < var_224_8 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play423121054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 423121054
		arg_225_1.duration_ = 10.93

		local var_225_0 = {
			zh = 7.633,
			ja = 10.933
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play423121055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = "1083"

			if arg_225_1.actors_[var_228_0] == nil then
				local var_228_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_228_1) then
					local var_228_2 = Object.Instantiate(var_228_1, arg_225_1.canvasGo_.transform)

					var_228_2.transform:SetSiblingIndex(1)

					var_228_2.name = var_228_0
					var_228_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_225_1.actors_[var_228_0] = var_228_2

					local var_228_3 = var_228_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_225_1.isInRecall_ then
						for iter_228_0, iter_228_1 in ipairs(var_228_3) do
							iter_228_1.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_228_4 = arg_225_1.actors_["1083"]
			local var_228_5 = 0

			if var_228_5 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.actorSpriteComps1083 == nil then
				arg_225_1.var_.actorSpriteComps1083 = var_228_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_6 = 0.2

			if var_228_5 <= arg_225_1.time_ and arg_225_1.time_ < var_228_5 + var_228_6 and not isNil(var_228_4) then
				local var_228_7 = (arg_225_1.time_ - var_228_5) / var_228_6

				if arg_225_1.var_.actorSpriteComps1083 then
					for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_228_3 then
							if arg_225_1.isInRecall_ then
								local var_228_8 = Mathf.Lerp(iter_228_3.color.r, arg_225_1.hightColor1.r, var_228_7)
								local var_228_9 = Mathf.Lerp(iter_228_3.color.g, arg_225_1.hightColor1.g, var_228_7)
								local var_228_10 = Mathf.Lerp(iter_228_3.color.b, arg_225_1.hightColor1.b, var_228_7)

								iter_228_3.color = Color.New(var_228_8, var_228_9, var_228_10)
							else
								local var_228_11 = Mathf.Lerp(iter_228_3.color.r, 1, var_228_7)

								iter_228_3.color = Color.New(var_228_11, var_228_11, var_228_11)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_5 + var_228_6 and arg_225_1.time_ < var_228_5 + var_228_6 + arg_228_0 and not isNil(var_228_4) and arg_225_1.var_.actorSpriteComps1083 then
				for iter_228_4, iter_228_5 in pairs(arg_225_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_228_5 then
						if arg_225_1.isInRecall_ then
							iter_228_5.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps1083 = nil
			end

			local var_228_12 = arg_225_1.actors_["1083"].transform
			local var_228_13 = 0

			if var_228_13 < arg_225_1.time_ and arg_225_1.time_ <= var_228_13 + arg_228_0 then
				arg_225_1.var_.moveOldPos1083 = var_228_12.localPosition
				var_228_12.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("1083", 3)

				local var_228_14 = var_228_12.childCount

				for iter_228_6 = 0, var_228_14 - 1 do
					local var_228_15 = var_228_12:GetChild(iter_228_6)

					if var_228_15.name == "split_4" or not string.find(var_228_15.name, "split") then
						var_228_15.gameObject:SetActive(true)
					else
						var_228_15.gameObject:SetActive(false)
					end
				end
			end

			local var_228_16 = 0.001

			if var_228_13 <= arg_225_1.time_ and arg_225_1.time_ < var_228_13 + var_228_16 then
				local var_228_17 = (arg_225_1.time_ - var_228_13) / var_228_16
				local var_228_18 = Vector3.New(-50, -345, -345)

				var_228_12.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1083, var_228_18, var_228_17)
			end

			if arg_225_1.time_ >= var_228_13 + var_228_16 and arg_225_1.time_ < var_228_13 + var_228_16 + arg_228_0 then
				var_228_12.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_228_19 = arg_225_1.actors_["1083"]
			local var_228_20 = 0

			if var_228_20 < arg_225_1.time_ and arg_225_1.time_ <= var_228_20 + arg_228_0 then
				local var_228_21 = var_228_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_228_21 then
					arg_225_1.var_.alphaOldValue1083 = var_228_21.alpha
					arg_225_1.var_.characterEffect1083 = var_228_21
				end

				arg_225_1.var_.alphaOldValue1083 = 0
			end

			local var_228_22 = 0.6

			if var_228_20 <= arg_225_1.time_ and arg_225_1.time_ < var_228_20 + var_228_22 then
				local var_228_23 = (arg_225_1.time_ - var_228_20) / var_228_22
				local var_228_24 = Mathf.Lerp(arg_225_1.var_.alphaOldValue1083, 1, var_228_23)

				if arg_225_1.var_.characterEffect1083 then
					arg_225_1.var_.characterEffect1083.alpha = var_228_24
				end
			end

			if arg_225_1.time_ >= var_228_20 + var_228_22 and arg_225_1.time_ < var_228_20 + var_228_22 + arg_228_0 and arg_225_1.var_.characterEffect1083 then
				arg_225_1.var_.characterEffect1083.alpha = 1
			end

			local var_228_25 = 0
			local var_228_26 = 0.6

			if var_228_25 < arg_225_1.time_ and arg_225_1.time_ <= var_228_25 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				arg_225_1.dialog_:SetActive(true)

				arg_225_1.dialogCg_.alpha = 0

				local var_228_27 = LeanTween.value(arg_225_1.dialog_, 0, 1, 0.3)

				var_228_27:setOnUpdate(LuaHelper.FloatAction(function(arg_229_0)
					arg_225_1.dialogCg_.alpha = arg_229_0
				end))
				var_228_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_225_1.dialog_)
					var_228_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_225_1.duration_ = arg_225_1.duration_ + 0.3

				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_28 = arg_225_1:FormatText(StoryNameCfg[1332].name)

				arg_225_1.leftNameTxt_.text = var_228_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_29 = arg_225_1:GetWordFromCfg(423121054)
				local var_228_30 = arg_225_1:FormatText(var_228_29.content)

				arg_225_1.text_.text = var_228_30

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_31 = 24
				local var_228_32 = utf8.len(var_228_30)
				local var_228_33 = var_228_31 <= 0 and var_228_26 or var_228_26 * (var_228_32 / var_228_31)

				if var_228_33 > 0 and var_228_26 < var_228_33 then
					arg_225_1.talkMaxDuration = var_228_33
					var_228_25 = var_228_25 + 0.3

					if var_228_33 + var_228_25 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_33 + var_228_25
					end
				end

				arg_225_1.text_.text = var_228_30
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121054", "story_v_out_423121.awb") ~= 0 then
					local var_228_34 = manager.audio:GetVoiceLength("story_v_out_423121", "423121054", "story_v_out_423121.awb") / 1000

					if var_228_34 + var_228_25 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_34 + var_228_25
					end

					if var_228_29.prefab_name ~= "" and arg_225_1.actors_[var_228_29.prefab_name] ~= nil then
						local var_228_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_29.prefab_name].transform, "story_v_out_423121", "423121054", "story_v_out_423121.awb")

						arg_225_1:RecordAudio("423121054", var_228_35)
						arg_225_1:RecordAudio("423121054", var_228_35)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_423121", "423121054", "story_v_out_423121.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_423121", "423121054", "story_v_out_423121.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_36 = var_228_25 + 0.3
			local var_228_37 = math.max(var_228_26, arg_225_1.talkMaxDuration)

			if var_228_36 <= arg_225_1.time_ and arg_225_1.time_ < var_228_36 + var_228_37 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_36) / var_228_37

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_36 + var_228_37 and arg_225_1.time_ < var_228_36 + var_228_37 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play423121055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 423121055
		arg_231_1.duration_ = 5.3

		local var_231_0 = {
			zh = 5.3,
			ja = 1.8
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play423121056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1083"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos1083 = var_234_0.localPosition
				var_234_0.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("1083", 3)

				local var_234_2 = var_234_0.childCount

				for iter_234_0 = 0, var_234_2 - 1 do
					local var_234_3 = var_234_0:GetChild(iter_234_0)

					if var_234_3.name == "split_6" or not string.find(var_234_3.name, "split") then
						var_234_3.gameObject:SetActive(true)
					else
						var_234_3.gameObject:SetActive(false)
					end
				end
			end

			local var_234_4 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_4 then
				local var_234_5 = (arg_231_1.time_ - var_234_1) / var_234_4
				local var_234_6 = Vector3.New(-50, -345, -345)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1083, var_234_6, var_234_5)
			end

			if arg_231_1.time_ >= var_234_1 + var_234_4 and arg_231_1.time_ < var_234_1 + var_234_4 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_234_7 = 0
			local var_234_8 = 0.425

			if var_234_7 < arg_231_1.time_ and arg_231_1.time_ <= var_234_7 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_9 = arg_231_1:FormatText(StoryNameCfg[1332].name)

				arg_231_1.leftNameTxt_.text = var_234_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_10 = arg_231_1:GetWordFromCfg(423121055)
				local var_234_11 = arg_231_1:FormatText(var_234_10.content)

				arg_231_1.text_.text = var_234_11

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_12 = 17
				local var_234_13 = utf8.len(var_234_11)
				local var_234_14 = var_234_12 <= 0 and var_234_8 or var_234_8 * (var_234_13 / var_234_12)

				if var_234_14 > 0 and var_234_8 < var_234_14 then
					arg_231_1.talkMaxDuration = var_234_14

					if var_234_14 + var_234_7 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_14 + var_234_7
					end
				end

				arg_231_1.text_.text = var_234_11
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121055", "story_v_out_423121.awb") ~= 0 then
					local var_234_15 = manager.audio:GetVoiceLength("story_v_out_423121", "423121055", "story_v_out_423121.awb") / 1000

					if var_234_15 + var_234_7 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_15 + var_234_7
					end

					if var_234_10.prefab_name ~= "" and arg_231_1.actors_[var_234_10.prefab_name] ~= nil then
						local var_234_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_10.prefab_name].transform, "story_v_out_423121", "423121055", "story_v_out_423121.awb")

						arg_231_1:RecordAudio("423121055", var_234_16)
						arg_231_1:RecordAudio("423121055", var_234_16)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_423121", "423121055", "story_v_out_423121.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_423121", "423121055", "story_v_out_423121.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_17 = math.max(var_234_8, arg_231_1.talkMaxDuration)

			if var_234_7 <= arg_231_1.time_ and arg_231_1.time_ < var_234_7 + var_234_17 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_7) / var_234_17

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_7 + var_234_17 and arg_231_1.time_ < var_234_7 + var_234_17 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play423121056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 423121056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play423121057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1083"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1083 == nil then
				arg_235_1.var_.actorSpriteComps1083 = var_238_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_2 = 0.2

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.actorSpriteComps1083 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								local var_238_4 = Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor2.r, var_238_3)
								local var_238_5 = Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor2.g, var_238_3)
								local var_238_6 = Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor2.b, var_238_3)

								iter_238_1.color = Color.New(var_238_4, var_238_5, var_238_6)
							else
								local var_238_7 = Mathf.Lerp(iter_238_1.color.r, 0.5, var_238_3)

								iter_238_1.color = Color.New(var_238_7, var_238_7, var_238_7)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.actorSpriteComps1083 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_238_3 then
						if arg_235_1.isInRecall_ then
							iter_238_3.color = arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_238_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_235_1.var_.actorSpriteComps1083 = nil
			end

			local var_238_8 = 0
			local var_238_9 = 0.45

			if var_238_8 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_10 = arg_235_1:FormatText(StoryNameCfg[7].name)

				arg_235_1.leftNameTxt_.text = var_238_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_11 = arg_235_1:GetWordFromCfg(423121056)
				local var_238_12 = arg_235_1:FormatText(var_238_11.content)

				arg_235_1.text_.text = var_238_12

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 18
				local var_238_14 = utf8.len(var_238_12)
				local var_238_15 = var_238_13 <= 0 and var_238_9 or var_238_9 * (var_238_14 / var_238_13)

				if var_238_15 > 0 and var_238_9 < var_238_15 then
					arg_235_1.talkMaxDuration = var_238_15

					if var_238_15 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_15 + var_238_8
					end
				end

				arg_235_1.text_.text = var_238_12
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_9, arg_235_1.talkMaxDuration)

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_8) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_8 + var_238_16 and arg_235_1.time_ < var_238_8 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play423121057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 423121057
		arg_239_1.duration_ = 7.23

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play423121058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1083"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1083 = var_242_0.localPosition
				var_242_0.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1083", 7)

				local var_242_2 = var_242_0.childCount

				for iter_242_0 = 0, var_242_2 - 1 do
					local var_242_3 = var_242_0:GetChild(iter_242_0)

					if var_242_3.name == "" or not string.find(var_242_3.name, "split") then
						var_242_3.gameObject:SetActive(true)
					else
						var_242_3.gameObject:SetActive(false)
					end
				end
			end

			local var_242_4 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_4 then
				local var_242_5 = (arg_239_1.time_ - var_242_1) / var_242_4
				local var_242_6 = Vector3.New(0, -2000, 0)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1083, var_242_6, var_242_5)
			end

			if arg_239_1.time_ >= var_242_1 + var_242_4 and arg_239_1.time_ < var_242_1 + var_242_4 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_242_7 = manager.ui.mainCamera.transform
			local var_242_8 = 0

			if var_242_8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 then
				arg_239_1.var_.shakeOldPos = var_242_7.localPosition
			end

			local var_242_9 = 0.6

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_9 then
				local var_242_10 = (arg_239_1.time_ - var_242_8) / 0.066
				local var_242_11, var_242_12 = math.modf(var_242_10)

				var_242_7.localPosition = Vector3.New(var_242_12 * 0.02, var_242_12 * 0.02, var_242_12 * 0.02) + arg_239_1.var_.shakeOldPos
			end

			if arg_239_1.time_ >= var_242_8 + var_242_9 and arg_239_1.time_ < var_242_8 + var_242_9 + arg_242_0 then
				var_242_7.localPosition = arg_239_1.var_.shakeOldPos
			end

			local var_242_13 = manager.ui.mainCamera.transform
			local var_242_14 = 0.733333333333333

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1.var_.shakeOldPos = var_242_13.localPosition
			end

			local var_242_15 = 0.6

			if var_242_14 <= arg_239_1.time_ and arg_239_1.time_ < var_242_14 + var_242_15 then
				local var_242_16 = (arg_239_1.time_ - var_242_14) / 0.066
				local var_242_17, var_242_18 = math.modf(var_242_16)

				var_242_13.localPosition = Vector3.New(var_242_18 * 0.13, var_242_18 * 0.13, var_242_18 * 0.13) + arg_239_1.var_.shakeOldPos
			end

			if arg_239_1.time_ >= var_242_14 + var_242_15 and arg_239_1.time_ < var_242_14 + var_242_15 + arg_242_0 then
				var_242_13.localPosition = arg_239_1.var_.shakeOldPos
			end

			local var_242_19 = arg_239_1.bgs_.ST0112.transform
			local var_242_20 = 0

			if var_242_20 < arg_239_1.time_ and arg_239_1.time_ <= var_242_20 + arg_242_0 then
				arg_239_1.var_.moveOldPosST0112 = var_242_19.localPosition
			end

			local var_242_21 = 3

			if var_242_20 <= arg_239_1.time_ and arg_239_1.time_ < var_242_20 + var_242_21 then
				local var_242_22 = (arg_239_1.time_ - var_242_20) / var_242_21
				local var_242_23 = Vector3.New(0, 1, 9)

				var_242_19.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPosST0112, var_242_23, var_242_22)
			end

			if arg_239_1.time_ >= var_242_20 + var_242_21 and arg_239_1.time_ < var_242_20 + var_242_21 + arg_242_0 then
				var_242_19.localPosition = Vector3.New(0, 1, 9)
			end

			local var_242_24 = 0

			if var_242_24 < arg_239_1.time_ and arg_239_1.time_ <= var_242_24 + arg_242_0 then
				arg_239_1.allBtn_.enabled = false
			end

			local var_242_25 = 2.23333333333333

			if arg_239_1.time_ >= var_242_24 + var_242_25 and arg_239_1.time_ < var_242_24 + var_242_25 + arg_242_0 then
				arg_239_1.allBtn_.enabled = true
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_26 = 2.23333333333333
			local var_242_27 = 1.475

			if var_242_26 < arg_239_1.time_ and arg_239_1.time_ <= var_242_26 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_28 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_28:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_29 = arg_239_1:GetWordFromCfg(423121057)
				local var_242_30 = arg_239_1:FormatText(var_242_29.content)

				arg_239_1.text_.text = var_242_30

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_31 = 59
				local var_242_32 = utf8.len(var_242_30)
				local var_242_33 = var_242_31 <= 0 and var_242_27 or var_242_27 * (var_242_32 / var_242_31)

				if var_242_33 > 0 and var_242_27 < var_242_33 then
					arg_239_1.talkMaxDuration = var_242_33
					var_242_26 = var_242_26 + 0.3

					if var_242_33 + var_242_26 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_33 + var_242_26
					end
				end

				arg_239_1.text_.text = var_242_30
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_34 = var_242_26 + 0.3
			local var_242_35 = math.max(var_242_27, arg_239_1.talkMaxDuration)

			if var_242_34 <= arg_239_1.time_ and arg_239_1.time_ < var_242_34 + var_242_35 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_34) / var_242_35

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_34 + var_242_35 and arg_239_1.time_ < var_242_34 + var_242_35 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "ST0112",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeInQuart
				}
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play423121058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 423121058
		arg_245_1.duration_ = 5.87

		local var_245_0 = {
			zh = 4.766,
			ja = 5.866
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
				arg_245_0:Play423121059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1083"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps1083 == nil then
				arg_245_1.var_.actorSpriteComps1083 = var_248_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_2 = 0.2

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.actorSpriteComps1083 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_248_1 then
							if arg_245_1.isInRecall_ then
								local var_248_4 = Mathf.Lerp(iter_248_1.color.r, arg_245_1.hightColor1.r, var_248_3)
								local var_248_5 = Mathf.Lerp(iter_248_1.color.g, arg_245_1.hightColor1.g, var_248_3)
								local var_248_6 = Mathf.Lerp(iter_248_1.color.b, arg_245_1.hightColor1.b, var_248_3)

								iter_248_1.color = Color.New(var_248_4, var_248_5, var_248_6)
							else
								local var_248_7 = Mathf.Lerp(iter_248_1.color.r, 1, var_248_3)

								iter_248_1.color = Color.New(var_248_7, var_248_7, var_248_7)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.actorSpriteComps1083 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_248_3 then
						if arg_245_1.isInRecall_ then
							iter_248_3.color = arg_245_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_248_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_245_1.var_.actorSpriteComps1083 = nil
			end

			local var_248_8 = arg_245_1.actors_["1083"].transform
			local var_248_9 = 0

			if var_248_9 < arg_245_1.time_ and arg_245_1.time_ <= var_248_9 + arg_248_0 then
				arg_245_1.var_.moveOldPos1083 = var_248_8.localPosition
				var_248_8.localScale = Vector3.New(1, 1, 1)

				arg_245_1:CheckSpriteTmpPos("1083", 3)

				local var_248_10 = var_248_8.childCount

				for iter_248_4 = 0, var_248_10 - 1 do
					local var_248_11 = var_248_8:GetChild(iter_248_4)

					if var_248_11.name == "split_4" or not string.find(var_248_11.name, "split") then
						var_248_11.gameObject:SetActive(true)
					else
						var_248_11.gameObject:SetActive(false)
					end
				end
			end

			local var_248_12 = 0.001

			if var_248_9 <= arg_245_1.time_ and arg_245_1.time_ < var_248_9 + var_248_12 then
				local var_248_13 = (arg_245_1.time_ - var_248_9) / var_248_12
				local var_248_14 = Vector3.New(-50, -345, -345)

				var_248_8.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1083, var_248_14, var_248_13)
			end

			if arg_245_1.time_ >= var_248_9 + var_248_12 and arg_245_1.time_ < var_248_9 + var_248_12 + arg_248_0 then
				var_248_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_248_15 = 0.2
			local var_248_16 = 1

			if var_248_15 < arg_245_1.time_ and arg_245_1.time_ <= var_248_15 + arg_248_0 then
				local var_248_17 = "play"
				local var_248_18 = "effect"

				arg_245_1:AudioAction(var_248_17, var_248_18, "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_248_19 = 0
			local var_248_20 = 0.625

			if var_248_19 < arg_245_1.time_ and arg_245_1.time_ <= var_248_19 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_21 = arg_245_1:FormatText(StoryNameCfg[1332].name)

				arg_245_1.leftNameTxt_.text = var_248_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_22 = arg_245_1:GetWordFromCfg(423121058)
				local var_248_23 = arg_245_1:FormatText(var_248_22.content)

				arg_245_1.text_.text = var_248_23

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_24 = 25
				local var_248_25 = utf8.len(var_248_23)
				local var_248_26 = var_248_24 <= 0 and var_248_20 or var_248_20 * (var_248_25 / var_248_24)

				if var_248_26 > 0 and var_248_20 < var_248_26 then
					arg_245_1.talkMaxDuration = var_248_26

					if var_248_26 + var_248_19 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_26 + var_248_19
					end
				end

				arg_245_1.text_.text = var_248_23
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121058", "story_v_out_423121.awb") ~= 0 then
					local var_248_27 = manager.audio:GetVoiceLength("story_v_out_423121", "423121058", "story_v_out_423121.awb") / 1000

					if var_248_27 + var_248_19 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_27 + var_248_19
					end

					if var_248_22.prefab_name ~= "" and arg_245_1.actors_[var_248_22.prefab_name] ~= nil then
						local var_248_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_22.prefab_name].transform, "story_v_out_423121", "423121058", "story_v_out_423121.awb")

						arg_245_1:RecordAudio("423121058", var_248_28)
						arg_245_1:RecordAudio("423121058", var_248_28)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_423121", "423121058", "story_v_out_423121.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_423121", "423121058", "story_v_out_423121.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_29 = math.max(var_248_20, arg_245_1.talkMaxDuration)

			if var_248_19 <= arg_245_1.time_ and arg_245_1.time_ < var_248_19 + var_248_29 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_19) / var_248_29

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_19 + var_248_29 and arg_245_1.time_ < var_248_19 + var_248_29 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play423121059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 423121059
		arg_249_1.duration_ = 7.57

		local var_249_0 = {
			zh = 5.166,
			ja = 7.566
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play423121060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.7

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_2 = arg_249_1:FormatText(StoryNameCfg[1332].name)

				arg_249_1.leftNameTxt_.text = var_252_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_3 = arg_249_1:GetWordFromCfg(423121059)
				local var_252_4 = arg_249_1:FormatText(var_252_3.content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 28
				local var_252_6 = utf8.len(var_252_4)
				local var_252_7 = var_252_5 <= 0 and var_252_1 or var_252_1 * (var_252_6 / var_252_5)

				if var_252_7 > 0 and var_252_1 < var_252_7 then
					arg_249_1.talkMaxDuration = var_252_7

					if var_252_7 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_7 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121059", "story_v_out_423121.awb") ~= 0 then
					local var_252_8 = manager.audio:GetVoiceLength("story_v_out_423121", "423121059", "story_v_out_423121.awb") / 1000

					if var_252_8 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_8 + var_252_0
					end

					if var_252_3.prefab_name ~= "" and arg_249_1.actors_[var_252_3.prefab_name] ~= nil then
						local var_252_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_3.prefab_name].transform, "story_v_out_423121", "423121059", "story_v_out_423121.awb")

						arg_249_1:RecordAudio("423121059", var_252_9)
						arg_249_1:RecordAudio("423121059", var_252_9)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_423121", "423121059", "story_v_out_423121.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_423121", "423121059", "story_v_out_423121.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_10 and arg_249_1.time_ < var_252_0 + var_252_10 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play423121060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 423121060
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play423121061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["1083"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps1083 == nil then
				arg_253_1.var_.actorSpriteComps1083 = var_256_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_2 = 0.2

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.actorSpriteComps1083 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								local var_256_4 = Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor2.r, var_256_3)
								local var_256_5 = Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor2.g, var_256_3)
								local var_256_6 = Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor2.b, var_256_3)

								iter_256_1.color = Color.New(var_256_4, var_256_5, var_256_6)
							else
								local var_256_7 = Mathf.Lerp(iter_256_1.color.r, 0.5, var_256_3)

								iter_256_1.color = Color.New(var_256_7, var_256_7, var_256_7)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.actorSpriteComps1083 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_256_3 then
						if arg_253_1.isInRecall_ then
							iter_256_3.color = arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_256_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_253_1.var_.actorSpriteComps1083 = nil
			end

			local var_256_8 = 0
			local var_256_9 = 0.725

			if var_256_8 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_10 = arg_253_1:FormatText(StoryNameCfg[7].name)

				arg_253_1.leftNameTxt_.text = var_256_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_11 = arg_253_1:GetWordFromCfg(423121060)
				local var_256_12 = arg_253_1:FormatText(var_256_11.content)

				arg_253_1.text_.text = var_256_12

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 29
				local var_256_14 = utf8.len(var_256_12)
				local var_256_15 = var_256_13 <= 0 and var_256_9 or var_256_9 * (var_256_14 / var_256_13)

				if var_256_15 > 0 and var_256_9 < var_256_15 then
					arg_253_1.talkMaxDuration = var_256_15

					if var_256_15 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_15 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_12
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_16 and arg_253_1.time_ < var_256_8 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play423121061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 423121061
		arg_257_1.duration_ = 3.67

		local var_257_0 = {
			zh = 2.133,
			ja = 3.666
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
				arg_257_0:Play423121062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1083"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps1083 == nil then
				arg_257_1.var_.actorSpriteComps1083 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 0.2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps1083 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								local var_260_4 = Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor1.r, var_260_3)
								local var_260_5 = Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor1.g, var_260_3)
								local var_260_6 = Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor1.b, var_260_3)

								iter_260_1.color = Color.New(var_260_4, var_260_5, var_260_6)
							else
								local var_260_7 = Mathf.Lerp(iter_260_1.color.r, 1, var_260_3)

								iter_260_1.color = Color.New(var_260_7, var_260_7, var_260_7)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps1083 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_260_3 then
						if arg_257_1.isInRecall_ then
							iter_260_3.color = arg_257_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_260_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps1083 = nil
			end

			local var_260_8 = arg_257_1.actors_["1083"].transform
			local var_260_9 = 0

			if var_260_9 < arg_257_1.time_ and arg_257_1.time_ <= var_260_9 + arg_260_0 then
				arg_257_1.var_.moveOldPos1083 = var_260_8.localPosition
				var_260_8.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("1083", 3)

				local var_260_10 = var_260_8.childCount

				for iter_260_4 = 0, var_260_10 - 1 do
					local var_260_11 = var_260_8:GetChild(iter_260_4)

					if var_260_11.name == "split_7" or not string.find(var_260_11.name, "split") then
						var_260_11.gameObject:SetActive(true)
					else
						var_260_11.gameObject:SetActive(false)
					end
				end
			end

			local var_260_12 = 0.001

			if var_260_9 <= arg_257_1.time_ and arg_257_1.time_ < var_260_9 + var_260_12 then
				local var_260_13 = (arg_257_1.time_ - var_260_9) / var_260_12
				local var_260_14 = Vector3.New(-50, -345, -345)

				var_260_8.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos1083, var_260_14, var_260_13)
			end

			if arg_257_1.time_ >= var_260_9 + var_260_12 and arg_257_1.time_ < var_260_9 + var_260_12 + arg_260_0 then
				var_260_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_260_15 = 0
			local var_260_16 = 0.25

			if var_260_15 < arg_257_1.time_ and arg_257_1.time_ <= var_260_15 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_17 = arg_257_1:FormatText(StoryNameCfg[1332].name)

				arg_257_1.leftNameTxt_.text = var_260_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_18 = arg_257_1:GetWordFromCfg(423121061)
				local var_260_19 = arg_257_1:FormatText(var_260_18.content)

				arg_257_1.text_.text = var_260_19

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_20 = 10
				local var_260_21 = utf8.len(var_260_19)
				local var_260_22 = var_260_20 <= 0 and var_260_16 or var_260_16 * (var_260_21 / var_260_20)

				if var_260_22 > 0 and var_260_16 < var_260_22 then
					arg_257_1.talkMaxDuration = var_260_22

					if var_260_22 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_22 + var_260_15
					end
				end

				arg_257_1.text_.text = var_260_19
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121061", "story_v_out_423121.awb") ~= 0 then
					local var_260_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121061", "story_v_out_423121.awb") / 1000

					if var_260_23 + var_260_15 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_23 + var_260_15
					end

					if var_260_18.prefab_name ~= "" and arg_257_1.actors_[var_260_18.prefab_name] ~= nil then
						local var_260_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_18.prefab_name].transform, "story_v_out_423121", "423121061", "story_v_out_423121.awb")

						arg_257_1:RecordAudio("423121061", var_260_24)
						arg_257_1:RecordAudio("423121061", var_260_24)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_423121", "423121061", "story_v_out_423121.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_423121", "423121061", "story_v_out_423121.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_25 = math.max(var_260_16, arg_257_1.talkMaxDuration)

			if var_260_15 <= arg_257_1.time_ and arg_257_1.time_ < var_260_15 + var_260_25 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_15) / var_260_25

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_15 + var_260_25 and arg_257_1.time_ < var_260_15 + var_260_25 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play423121062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 423121062
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play423121063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1083"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.actorSpriteComps1083 == nil then
				arg_261_1.var_.actorSpriteComps1083 = var_264_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_2 = 0.2

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.actorSpriteComps1083 then
					for iter_264_0, iter_264_1 in pairs(arg_261_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_264_1 then
							if arg_261_1.isInRecall_ then
								local var_264_4 = Mathf.Lerp(iter_264_1.color.r, arg_261_1.hightColor2.r, var_264_3)
								local var_264_5 = Mathf.Lerp(iter_264_1.color.g, arg_261_1.hightColor2.g, var_264_3)
								local var_264_6 = Mathf.Lerp(iter_264_1.color.b, arg_261_1.hightColor2.b, var_264_3)

								iter_264_1.color = Color.New(var_264_4, var_264_5, var_264_6)
							else
								local var_264_7 = Mathf.Lerp(iter_264_1.color.r, 0.5, var_264_3)

								iter_264_1.color = Color.New(var_264_7, var_264_7, var_264_7)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.actorSpriteComps1083 then
				for iter_264_2, iter_264_3 in pairs(arg_261_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_264_3 then
						if arg_261_1.isInRecall_ then
							iter_264_3.color = arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_264_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps1083 = nil
			end

			local var_264_8 = 0
			local var_264_9 = 0.775

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_10 = arg_261_1:FormatText(StoryNameCfg[7].name)

				arg_261_1.leftNameTxt_.text = var_264_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_11 = arg_261_1:GetWordFromCfg(423121062)
				local var_264_12 = arg_261_1:FormatText(var_264_11.content)

				arg_261_1.text_.text = var_264_12

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_13 = 31
				local var_264_14 = utf8.len(var_264_12)
				local var_264_15 = var_264_13 <= 0 and var_264_9 or var_264_9 * (var_264_14 / var_264_13)

				if var_264_15 > 0 and var_264_9 < var_264_15 then
					arg_261_1.talkMaxDuration = var_264_15

					if var_264_15 + var_264_8 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_15 + var_264_8
					end
				end

				arg_261_1.text_.text = var_264_12
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_16 = math.max(var_264_9, arg_261_1.talkMaxDuration)

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_16 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_8) / var_264_16

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_8 + var_264_16 and arg_261_1.time_ < var_264_8 + var_264_16 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play423121063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 423121063
		arg_265_1.duration_ = 3.83

		local var_265_0 = {
			zh = 3.566,
			ja = 3.833
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
				arg_265_0:Play423121064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1083"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps1083 == nil then
				arg_265_1.var_.actorSpriteComps1083 = var_268_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_2 = 0.2

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.actorSpriteComps1083 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								local var_268_4 = Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor1.r, var_268_3)
								local var_268_5 = Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor1.g, var_268_3)
								local var_268_6 = Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor1.b, var_268_3)

								iter_268_1.color = Color.New(var_268_4, var_268_5, var_268_6)
							else
								local var_268_7 = Mathf.Lerp(iter_268_1.color.r, 1, var_268_3)

								iter_268_1.color = Color.New(var_268_7, var_268_7, var_268_7)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.actorSpriteComps1083 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_268_3 then
						if arg_265_1.isInRecall_ then
							iter_268_3.color = arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_268_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps1083 = nil
			end

			local var_268_8 = arg_265_1.actors_["1083"].transform
			local var_268_9 = 0

			if var_268_9 < arg_265_1.time_ and arg_265_1.time_ <= var_268_9 + arg_268_0 then
				arg_265_1.var_.moveOldPos1083 = var_268_8.localPosition
				var_268_8.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("1083", 3)

				local var_268_10 = var_268_8.childCount

				for iter_268_4 = 0, var_268_10 - 1 do
					local var_268_11 = var_268_8:GetChild(iter_268_4)

					if var_268_11.name == "split_4" or not string.find(var_268_11.name, "split") then
						var_268_11.gameObject:SetActive(true)
					else
						var_268_11.gameObject:SetActive(false)
					end
				end
			end

			local var_268_12 = 0.001

			if var_268_9 <= arg_265_1.time_ and arg_265_1.time_ < var_268_9 + var_268_12 then
				local var_268_13 = (arg_265_1.time_ - var_268_9) / var_268_12
				local var_268_14 = Vector3.New(-50, -345, -345)

				var_268_8.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1083, var_268_14, var_268_13)
			end

			if arg_265_1.time_ >= var_268_9 + var_268_12 and arg_265_1.time_ < var_268_9 + var_268_12 + arg_268_0 then
				var_268_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_268_15 = 0
			local var_268_16 = 0.15

			if var_268_15 < arg_265_1.time_ and arg_265_1.time_ <= var_268_15 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_17 = arg_265_1:FormatText(StoryNameCfg[1332].name)

				arg_265_1.leftNameTxt_.text = var_268_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_18 = arg_265_1:GetWordFromCfg(423121063)
				local var_268_19 = arg_265_1:FormatText(var_268_18.content)

				arg_265_1.text_.text = var_268_19

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_20 = 6
				local var_268_21 = utf8.len(var_268_19)
				local var_268_22 = var_268_20 <= 0 and var_268_16 or var_268_16 * (var_268_21 / var_268_20)

				if var_268_22 > 0 and var_268_16 < var_268_22 then
					arg_265_1.talkMaxDuration = var_268_22

					if var_268_22 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_22 + var_268_15
					end
				end

				arg_265_1.text_.text = var_268_19
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121063", "story_v_out_423121.awb") ~= 0 then
					local var_268_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121063", "story_v_out_423121.awb") / 1000

					if var_268_23 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_23 + var_268_15
					end

					if var_268_18.prefab_name ~= "" and arg_265_1.actors_[var_268_18.prefab_name] ~= nil then
						local var_268_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_18.prefab_name].transform, "story_v_out_423121", "423121063", "story_v_out_423121.awb")

						arg_265_1:RecordAudio("423121063", var_268_24)
						arg_265_1:RecordAudio("423121063", var_268_24)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_423121", "423121063", "story_v_out_423121.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_423121", "423121063", "story_v_out_423121.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_25 = math.max(var_268_16, arg_265_1.talkMaxDuration)

			if var_268_15 <= arg_265_1.time_ and arg_265_1.time_ < var_268_15 + var_268_25 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_15) / var_268_25

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_15 + var_268_25 and arg_265_1.time_ < var_268_15 + var_268_25 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play423121064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 423121064
		arg_269_1.duration_ = 6.53

		local var_269_0 = {
			zh = 4.633,
			ja = 6.533
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
				arg_269_0:Play423121065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.575

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[1332].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:GetWordFromCfg(423121064)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 23
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121064", "story_v_out_423121.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_423121", "423121064", "story_v_out_423121.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_423121", "423121064", "story_v_out_423121.awb")

						arg_269_1:RecordAudio("423121064", var_272_9)
						arg_269_1:RecordAudio("423121064", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_423121", "423121064", "story_v_out_423121.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_423121", "423121064", "story_v_out_423121.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play423121065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 423121065
		arg_273_1.duration_ = 2.5

		local var_273_0 = {
			zh = 2.166,
			ja = 2.5
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play423121066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1083"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos1083 = var_276_0.localPosition
				var_276_0.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("1083", 3)

				local var_276_2 = var_276_0.childCount

				for iter_276_0 = 0, var_276_2 - 1 do
					local var_276_3 = var_276_0:GetChild(iter_276_0)

					if var_276_3.name == "split_7" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_4 then
				local var_276_5 = (arg_273_1.time_ - var_276_1) / var_276_4
				local var_276_6 = Vector3.New(-50, -345, -345)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1083, var_276_6, var_276_5)
			end

			if arg_273_1.time_ >= var_276_1 + var_276_4 and arg_273_1.time_ < var_276_1 + var_276_4 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_276_7 = 0
			local var_276_8 = 0.275

			if var_276_7 < arg_273_1.time_ and arg_273_1.time_ <= var_276_7 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_9 = arg_273_1:FormatText(StoryNameCfg[1332].name)

				arg_273_1.leftNameTxt_.text = var_276_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_10 = arg_273_1:GetWordFromCfg(423121065)
				local var_276_11 = arg_273_1:FormatText(var_276_10.content)

				arg_273_1.text_.text = var_276_11

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_12 = 11
				local var_276_13 = utf8.len(var_276_11)
				local var_276_14 = var_276_12 <= 0 and var_276_8 or var_276_8 * (var_276_13 / var_276_12)

				if var_276_14 > 0 and var_276_8 < var_276_14 then
					arg_273_1.talkMaxDuration = var_276_14

					if var_276_14 + var_276_7 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_14 + var_276_7
					end
				end

				arg_273_1.text_.text = var_276_11
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121065", "story_v_out_423121.awb") ~= 0 then
					local var_276_15 = manager.audio:GetVoiceLength("story_v_out_423121", "423121065", "story_v_out_423121.awb") / 1000

					if var_276_15 + var_276_7 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_15 + var_276_7
					end

					if var_276_10.prefab_name ~= "" and arg_273_1.actors_[var_276_10.prefab_name] ~= nil then
						local var_276_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_10.prefab_name].transform, "story_v_out_423121", "423121065", "story_v_out_423121.awb")

						arg_273_1:RecordAudio("423121065", var_276_16)
						arg_273_1:RecordAudio("423121065", var_276_16)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_423121", "423121065", "story_v_out_423121.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_423121", "423121065", "story_v_out_423121.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_17 = math.max(var_276_8, arg_273_1.talkMaxDuration)

			if var_276_7 <= arg_273_1.time_ and arg_273_1.time_ < var_276_7 + var_276_17 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_7) / var_276_17

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_7 + var_276_17 and arg_273_1.time_ < var_276_7 + var_276_17 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play423121066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 423121066
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play423121067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1083"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps1083 == nil then
				arg_277_1.var_.actorSpriteComps1083 = var_280_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_2 = 0.2

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.actorSpriteComps1083 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_280_1 then
							if arg_277_1.isInRecall_ then
								local var_280_4 = Mathf.Lerp(iter_280_1.color.r, arg_277_1.hightColor2.r, var_280_3)
								local var_280_5 = Mathf.Lerp(iter_280_1.color.g, arg_277_1.hightColor2.g, var_280_3)
								local var_280_6 = Mathf.Lerp(iter_280_1.color.b, arg_277_1.hightColor2.b, var_280_3)

								iter_280_1.color = Color.New(var_280_4, var_280_5, var_280_6)
							else
								local var_280_7 = Mathf.Lerp(iter_280_1.color.r, 0.5, var_280_3)

								iter_280_1.color = Color.New(var_280_7, var_280_7, var_280_7)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.actorSpriteComps1083 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_280_3 then
						if arg_277_1.isInRecall_ then
							iter_280_3.color = arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_280_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_277_1.var_.actorSpriteComps1083 = nil
			end

			local var_280_8 = arg_277_1.actors_["1083"].transform
			local var_280_9 = 0

			if var_280_9 < arg_277_1.time_ and arg_277_1.time_ <= var_280_9 + arg_280_0 then
				arg_277_1.var_.moveOldPos1083 = var_280_8.localPosition
				var_280_8.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("1083", 7)

				local var_280_10 = var_280_8.childCount

				for iter_280_4 = 0, var_280_10 - 1 do
					local var_280_11 = var_280_8:GetChild(iter_280_4)

					if var_280_11.name == "" or not string.find(var_280_11.name, "split") then
						var_280_11.gameObject:SetActive(true)
					else
						var_280_11.gameObject:SetActive(false)
					end
				end
			end

			local var_280_12 = 0.001

			if var_280_9 <= arg_277_1.time_ and arg_277_1.time_ < var_280_9 + var_280_12 then
				local var_280_13 = (arg_277_1.time_ - var_280_9) / var_280_12
				local var_280_14 = Vector3.New(0, -2000, 0)

				var_280_8.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1083, var_280_14, var_280_13)
			end

			if arg_277_1.time_ >= var_280_9 + var_280_12 and arg_277_1.time_ < var_280_9 + var_280_12 + arg_280_0 then
				var_280_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_280_15 = 0.166666666666667
			local var_280_16 = 1

			if var_280_15 < arg_277_1.time_ and arg_277_1.time_ <= var_280_15 + arg_280_0 then
				local var_280_17 = "play"
				local var_280_18 = "effect"

				arg_277_1:AudioAction(var_280_17, var_280_18, "se_story_side_1093", "se_story_1093_message_calling", "")
			end

			local var_280_19 = 0
			local var_280_20 = 1.275

			if var_280_19 < arg_277_1.time_ and arg_277_1.time_ <= var_280_19 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_21 = arg_277_1:GetWordFromCfg(423121066)
				local var_280_22 = arg_277_1:FormatText(var_280_21.content)

				arg_277_1.text_.text = var_280_22

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_23 = 51
				local var_280_24 = utf8.len(var_280_22)
				local var_280_25 = var_280_23 <= 0 and var_280_20 or var_280_20 * (var_280_24 / var_280_23)

				if var_280_25 > 0 and var_280_20 < var_280_25 then
					arg_277_1.talkMaxDuration = var_280_25

					if var_280_25 + var_280_19 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_25 + var_280_19
					end
				end

				arg_277_1.text_.text = var_280_22
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_26 = math.max(var_280_20, arg_277_1.talkMaxDuration)

			if var_280_19 <= arg_277_1.time_ and arg_277_1.time_ < var_280_19 + var_280_26 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_19) / var_280_26

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_19 + var_280_26 and arg_277_1.time_ < var_280_19 + var_280_26 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play423121067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 423121067
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play423121068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0
			local var_284_1 = 0.65

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(423121067)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 26
				local var_284_5 = utf8.len(var_284_3)
				local var_284_6 = var_284_4 <= 0 and var_284_1 or var_284_1 * (var_284_5 / var_284_4)

				if var_284_6 > 0 and var_284_1 < var_284_6 then
					arg_281_1.talkMaxDuration = var_284_6

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_7 and arg_281_1.time_ < var_284_0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play423121068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 423121068
		arg_285_1.duration_ = 5.63

		local var_285_0 = {
			zh = 4.533,
			ja = 5.633
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
				arg_285_0:Play423121069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10146"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos10146 = var_288_0.localPosition
				var_288_0.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10146", 2)

				local var_288_2 = var_288_0.childCount

				for iter_288_0 = 0, var_288_2 - 1 do
					local var_288_3 = var_288_0:GetChild(iter_288_0)

					if var_288_3.name == "" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_4 then
				local var_288_5 = (arg_285_1.time_ - var_288_1) / var_288_4
				local var_288_6 = Vector3.New(-390, -350, -320)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10146, var_288_6, var_288_5)
			end

			if arg_285_1.time_ >= var_288_1 + var_288_4 and arg_285_1.time_ < var_288_1 + var_288_4 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(-390, -350, -320)
			end

			local var_288_7 = arg_285_1.actors_["10146"]
			local var_288_8 = 0

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				local var_288_9 = var_288_7:GetComponentInChildren(typeof(CanvasGroup))

				if var_288_9 then
					arg_285_1.var_.alphaOldValue10146 = var_288_9.alpha
					arg_285_1.var_.characterEffect10146 = var_288_9
				end
			end

			local var_288_10 = 0.0333333333333333

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_10 then
				local var_288_11 = (arg_285_1.time_ - var_288_8) / var_288_10
				local var_288_12 = Mathf.Lerp(arg_285_1.var_.alphaOldValue10146, 0.6, var_288_11)

				if arg_285_1.var_.characterEffect10146 then
					arg_285_1.var_.characterEffect10146.alpha = var_288_12
				end
			end

			if arg_285_1.time_ >= var_288_8 + var_288_10 and arg_285_1.time_ < var_288_8 + var_288_10 + arg_288_0 and arg_285_1.var_.characterEffect10146 then
				arg_285_1.var_.characterEffect10146.alpha = 0.6
			end

			local var_288_13 = arg_285_1.actors_["10146"]
			local var_288_14 = 0

			if var_288_14 < arg_285_1.time_ and arg_285_1.time_ <= var_288_14 + arg_288_0 then
				arg_285_1:SetSpriteNiuquEffect("10146", true)
			end

			local var_288_15 = 0
			local var_288_16 = 0.525

			if var_288_15 < arg_285_1.time_ and arg_285_1.time_ <= var_288_15 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_17 = arg_285_1:FormatText(StoryNameCfg[1338].name)

				arg_285_1.leftNameTxt_.text = var_288_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_18 = arg_285_1:GetWordFromCfg(423121068)
				local var_288_19 = arg_285_1:FormatText(var_288_18.content)

				arg_285_1.text_.text = var_288_19

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_20 = 21
				local var_288_21 = utf8.len(var_288_19)
				local var_288_22 = var_288_20 <= 0 and var_288_16 or var_288_16 * (var_288_21 / var_288_20)

				if var_288_22 > 0 and var_288_16 < var_288_22 then
					arg_285_1.talkMaxDuration = var_288_22

					if var_288_22 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_22 + var_288_15
					end
				end

				arg_285_1.text_.text = var_288_19
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121068", "story_v_out_423121.awb") ~= 0 then
					local var_288_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121068", "story_v_out_423121.awb") / 1000

					if var_288_23 + var_288_15 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_23 + var_288_15
					end

					if var_288_18.prefab_name ~= "" and arg_285_1.actors_[var_288_18.prefab_name] ~= nil then
						local var_288_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_18.prefab_name].transform, "story_v_out_423121", "423121068", "story_v_out_423121.awb")

						arg_285_1:RecordAudio("423121068", var_288_24)
						arg_285_1:RecordAudio("423121068", var_288_24)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_423121", "423121068", "story_v_out_423121.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_423121", "423121068", "story_v_out_423121.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_25 = math.max(var_288_16, arg_285_1.talkMaxDuration)

			if var_288_15 <= arg_285_1.time_ and arg_285_1.time_ < var_288_15 + var_288_25 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_15) / var_288_25

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_15 + var_288_25 and arg_285_1.time_ < var_288_15 + var_288_25 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	Play423121069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 423121069
		arg_289_1.duration_ = 2.6

		local var_289_0 = {
			zh = 2.6,
			ja = 1.733
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
				arg_289_0:Play423121070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1083"]
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps1083 == nil then
				arg_289_1.var_.actorSpriteComps1083 = var_292_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_2 = 0.2

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 and not isNil(var_292_0) then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2

				if arg_289_1.var_.actorSpriteComps1083 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								local var_292_4 = Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor1.r, var_292_3)
								local var_292_5 = Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor1.g, var_292_3)
								local var_292_6 = Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor1.b, var_292_3)

								iter_292_1.color = Color.New(var_292_4, var_292_5, var_292_6)
							else
								local var_292_7 = Mathf.Lerp(iter_292_1.color.r, 1, var_292_3)

								iter_292_1.color = Color.New(var_292_7, var_292_7, var_292_7)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 and not isNil(var_292_0) and arg_289_1.var_.actorSpriteComps1083 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_292_3 then
						if arg_289_1.isInRecall_ then
							iter_292_3.color = arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_292_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_289_1.var_.actorSpriteComps1083 = nil
			end

			local var_292_8 = arg_289_1.actors_["1083"].transform
			local var_292_9 = 0

			if var_292_9 < arg_289_1.time_ and arg_289_1.time_ <= var_292_9 + arg_292_0 then
				arg_289_1.var_.moveOldPos1083 = var_292_8.localPosition
				var_292_8.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("1083", 4)

				local var_292_10 = var_292_8.childCount

				for iter_292_4 = 0, var_292_10 - 1 do
					local var_292_11 = var_292_8:GetChild(iter_292_4)

					if var_292_11.name == "split_7" or not string.find(var_292_11.name, "split") then
						var_292_11.gameObject:SetActive(true)
					else
						var_292_11.gameObject:SetActive(false)
					end
				end
			end

			local var_292_12 = 0.001

			if var_292_9 <= arg_289_1.time_ and arg_289_1.time_ < var_292_9 + var_292_12 then
				local var_292_13 = (arg_289_1.time_ - var_292_9) / var_292_12
				local var_292_14 = Vector3.New(390, -345, -345)

				var_292_8.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1083, var_292_14, var_292_13)
			end

			if arg_289_1.time_ >= var_292_9 + var_292_12 and arg_289_1.time_ < var_292_9 + var_292_12 + arg_292_0 then
				var_292_8.localPosition = Vector3.New(390, -345, -345)
			end

			local var_292_15 = 0
			local var_292_16 = 0.325

			if var_292_15 < arg_289_1.time_ and arg_289_1.time_ <= var_292_15 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_17 = arg_289_1:FormatText(StoryNameCfg[1332].name)

				arg_289_1.leftNameTxt_.text = var_292_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_18 = arg_289_1:GetWordFromCfg(423121069)
				local var_292_19 = arg_289_1:FormatText(var_292_18.content)

				arg_289_1.text_.text = var_292_19

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_20 = 13
				local var_292_21 = utf8.len(var_292_19)
				local var_292_22 = var_292_20 <= 0 and var_292_16 or var_292_16 * (var_292_21 / var_292_20)

				if var_292_22 > 0 and var_292_16 < var_292_22 then
					arg_289_1.talkMaxDuration = var_292_22

					if var_292_22 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_22 + var_292_15
					end
				end

				arg_289_1.text_.text = var_292_19
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121069", "story_v_out_423121.awb") ~= 0 then
					local var_292_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121069", "story_v_out_423121.awb") / 1000

					if var_292_23 + var_292_15 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_23 + var_292_15
					end

					if var_292_18.prefab_name ~= "" and arg_289_1.actors_[var_292_18.prefab_name] ~= nil then
						local var_292_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_18.prefab_name].transform, "story_v_out_423121", "423121069", "story_v_out_423121.awb")

						arg_289_1:RecordAudio("423121069", var_292_24)
						arg_289_1:RecordAudio("423121069", var_292_24)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_423121", "423121069", "story_v_out_423121.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_423121", "423121069", "story_v_out_423121.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_25 = math.max(var_292_16, arg_289_1.talkMaxDuration)

			if var_292_15 <= arg_289_1.time_ and arg_289_1.time_ < var_292_15 + var_292_25 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_15) / var_292_25

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_15 + var_292_25 and arg_289_1.time_ < var_292_15 + var_292_25 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play423121070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 423121070
		arg_293_1.duration_ = 8.97

		local var_293_0 = {
			zh = 6.333,
			ja = 8.966
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
				arg_293_0:Play423121071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["10146"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos10146 = var_296_0.localPosition
				var_296_0.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("10146", 2)

				local var_296_2 = var_296_0.childCount

				for iter_296_0 = 0, var_296_2 - 1 do
					local var_296_3 = var_296_0:GetChild(iter_296_0)

					if var_296_3.name == "" or not string.find(var_296_3.name, "split") then
						var_296_3.gameObject:SetActive(true)
					else
						var_296_3.gameObject:SetActive(false)
					end
				end
			end

			local var_296_4 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_4 then
				local var_296_5 = (arg_293_1.time_ - var_296_1) / var_296_4
				local var_296_6 = Vector3.New(-390, -350, -320)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10146, var_296_6, var_296_5)
			end

			if arg_293_1.time_ >= var_296_1 + var_296_4 and arg_293_1.time_ < var_296_1 + var_296_4 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(-390, -350, -320)
			end

			local var_296_7 = 0
			local var_296_8 = 0.7

			if var_296_7 < arg_293_1.time_ and arg_293_1.time_ <= var_296_7 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_9 = arg_293_1:FormatText(StoryNameCfg[1338].name)

				arg_293_1.leftNameTxt_.text = var_296_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_10 = arg_293_1:GetWordFromCfg(423121070)
				local var_296_11 = arg_293_1:FormatText(var_296_10.content)

				arg_293_1.text_.text = var_296_11

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_12 = 28
				local var_296_13 = utf8.len(var_296_11)
				local var_296_14 = var_296_12 <= 0 and var_296_8 or var_296_8 * (var_296_13 / var_296_12)

				if var_296_14 > 0 and var_296_8 < var_296_14 then
					arg_293_1.talkMaxDuration = var_296_14

					if var_296_14 + var_296_7 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_14 + var_296_7
					end
				end

				arg_293_1.text_.text = var_296_11
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121070", "story_v_out_423121.awb") ~= 0 then
					local var_296_15 = manager.audio:GetVoiceLength("story_v_out_423121", "423121070", "story_v_out_423121.awb") / 1000

					if var_296_15 + var_296_7 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_15 + var_296_7
					end

					if var_296_10.prefab_name ~= "" and arg_293_1.actors_[var_296_10.prefab_name] ~= nil then
						local var_296_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_10.prefab_name].transform, "story_v_out_423121", "423121070", "story_v_out_423121.awb")

						arg_293_1:RecordAudio("423121070", var_296_16)
						arg_293_1:RecordAudio("423121070", var_296_16)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_423121", "423121070", "story_v_out_423121.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_423121", "423121070", "story_v_out_423121.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_17 = math.max(var_296_8, arg_293_1.talkMaxDuration)

			if var_296_7 <= arg_293_1.time_ and arg_293_1.time_ < var_296_7 + var_296_17 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_7) / var_296_17

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_7 + var_296_17 and arg_293_1.time_ < var_296_7 + var_296_17 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play423121071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 423121071
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play423121072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = arg_297_1.actors_["10146"].transform
			local var_300_1 = 0

			if var_300_1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_1 + arg_300_0 then
				arg_297_1.var_.moveOldPos10146 = var_300_0.localPosition
				var_300_0.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("10146", 7)

				local var_300_2 = var_300_0.childCount

				for iter_300_0 = 0, var_300_2 - 1 do
					local var_300_3 = var_300_0:GetChild(iter_300_0)

					if var_300_3.name == "" or not string.find(var_300_3.name, "split") then
						var_300_3.gameObject:SetActive(true)
					else
						var_300_3.gameObject:SetActive(false)
					end
				end
			end

			local var_300_4 = 0.001

			if var_300_1 <= arg_297_1.time_ and arg_297_1.time_ < var_300_1 + var_300_4 then
				local var_300_5 = (arg_297_1.time_ - var_300_1) / var_300_4
				local var_300_6 = Vector3.New(0, -2000, 0)

				var_300_0.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos10146, var_300_6, var_300_5)
			end

			if arg_297_1.time_ >= var_300_1 + var_300_4 and arg_297_1.time_ < var_300_1 + var_300_4 + arg_300_0 then
				var_300_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_300_7 = arg_297_1.actors_["1083"].transform
			local var_300_8 = 0

			if var_300_8 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.var_.moveOldPos1083 = var_300_7.localPosition
				var_300_7.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1083", 7)

				local var_300_9 = var_300_7.childCount

				for iter_300_1 = 0, var_300_9 - 1 do
					local var_300_10 = var_300_7:GetChild(iter_300_1)

					if var_300_10.name == "" or not string.find(var_300_10.name, "split") then
						var_300_10.gameObject:SetActive(true)
					else
						var_300_10.gameObject:SetActive(false)
					end
				end
			end

			local var_300_11 = 0.001

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_11 then
				local var_300_12 = (arg_297_1.time_ - var_300_8) / var_300_11
				local var_300_13 = Vector3.New(0, -2000, 0)

				var_300_7.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1083, var_300_13, var_300_12)
			end

			if arg_297_1.time_ >= var_300_8 + var_300_11 and arg_297_1.time_ < var_300_8 + var_300_11 + arg_300_0 then
				var_300_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_300_14 = 0
			local var_300_15 = 1.175

			if var_300_14 < arg_297_1.time_ and arg_297_1.time_ <= var_300_14 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_16 = arg_297_1:GetWordFromCfg(423121071)
				local var_300_17 = arg_297_1:FormatText(var_300_16.content)

				arg_297_1.text_.text = var_300_17

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_18 = 47
				local var_300_19 = utf8.len(var_300_17)
				local var_300_20 = var_300_18 <= 0 and var_300_15 or var_300_15 * (var_300_19 / var_300_18)

				if var_300_20 > 0 and var_300_15 < var_300_20 then
					arg_297_1.talkMaxDuration = var_300_20

					if var_300_20 + var_300_14 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_20 + var_300_14
					end
				end

				arg_297_1.text_.text = var_300_17
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_21 = math.max(var_300_15, arg_297_1.talkMaxDuration)

			if var_300_14 <= arg_297_1.time_ and arg_297_1.time_ < var_300_14 + var_300_21 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_14) / var_300_21

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_14 + var_300_21 and arg_297_1.time_ < var_300_14 + var_300_21 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play423121072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 423121072
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play423121073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0
			local var_304_1 = 1.5

			if var_304_0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_2 = arg_301_1:GetWordFromCfg(423121072)
				local var_304_3 = arg_301_1:FormatText(var_304_2.content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 60
				local var_304_5 = utf8.len(var_304_3)
				local var_304_6 = var_304_4 <= 0 and var_304_1 or var_304_1 * (var_304_5 / var_304_4)

				if var_304_6 > 0 and var_304_1 < var_304_6 then
					arg_301_1.talkMaxDuration = var_304_6

					if var_304_6 + var_304_0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_6 + var_304_0
					end
				end

				arg_301_1.text_.text = var_304_3
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_1, arg_301_1.talkMaxDuration)

			if var_304_0 <= arg_301_1.time_ and arg_301_1.time_ < var_304_0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_0 + var_304_7 and arg_301_1.time_ < var_304_0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play423121073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 423121073
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play423121074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0
			local var_308_1 = 0.625

			if var_308_0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_2 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:GetWordFromCfg(423121073)
				local var_308_4 = arg_305_1:FormatText(var_308_3.content)

				arg_305_1.text_.text = var_308_4

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 25
				local var_308_6 = utf8.len(var_308_4)
				local var_308_7 = var_308_5 <= 0 and var_308_1 or var_308_1 * (var_308_6 / var_308_5)

				if var_308_7 > 0 and var_308_1 < var_308_7 then
					arg_305_1.talkMaxDuration = var_308_7

					if var_308_7 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_7 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_4
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_8 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_8 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_8

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_8 and arg_305_1.time_ < var_308_0 + var_308_8 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play423121074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 423121074
		arg_309_1.duration_ = 17.63

		local var_309_0 = {
			zh = 7.366,
			ja = 17.633
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play423121075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = arg_309_1.actors_["10146"].transform
			local var_312_1 = 0

			if var_312_1 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.var_.moveOldPos10146 = var_312_0.localPosition
				var_312_0.localScale = Vector3.New(1, 1, 1)

				arg_309_1:CheckSpriteTmpPos("10146", 3)

				local var_312_2 = var_312_0.childCount

				for iter_312_0 = 0, var_312_2 - 1 do
					local var_312_3 = var_312_0:GetChild(iter_312_0)

					if var_312_3.name == "split_6" or not string.find(var_312_3.name, "split") then
						var_312_3.gameObject:SetActive(true)
					else
						var_312_3.gameObject:SetActive(false)
					end
				end
			end

			local var_312_4 = 0.001

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_4 then
				local var_312_5 = (arg_309_1.time_ - var_312_1) / var_312_4
				local var_312_6 = Vector3.New(0, -350, -320)

				var_312_0.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10146, var_312_6, var_312_5)
			end

			if arg_309_1.time_ >= var_312_1 + var_312_4 and arg_309_1.time_ < var_312_1 + var_312_4 + arg_312_0 then
				var_312_0.localPosition = Vector3.New(0, -350, -320)
			end

			local var_312_7 = 0
			local var_312_8 = 0.9

			if var_312_7 < arg_309_1.time_ and arg_309_1.time_ <= var_312_7 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_9 = arg_309_1:FormatText(StoryNameCfg[1338].name)

				arg_309_1.leftNameTxt_.text = var_312_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_10 = arg_309_1:GetWordFromCfg(423121074)
				local var_312_11 = arg_309_1:FormatText(var_312_10.content)

				arg_309_1.text_.text = var_312_11

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_12 = 36
				local var_312_13 = utf8.len(var_312_11)
				local var_312_14 = var_312_12 <= 0 and var_312_8 or var_312_8 * (var_312_13 / var_312_12)

				if var_312_14 > 0 and var_312_8 < var_312_14 then
					arg_309_1.talkMaxDuration = var_312_14

					if var_312_14 + var_312_7 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_14 + var_312_7
					end
				end

				arg_309_1.text_.text = var_312_11
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121074", "story_v_out_423121.awb") ~= 0 then
					local var_312_15 = manager.audio:GetVoiceLength("story_v_out_423121", "423121074", "story_v_out_423121.awb") / 1000

					if var_312_15 + var_312_7 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_15 + var_312_7
					end

					if var_312_10.prefab_name ~= "" and arg_309_1.actors_[var_312_10.prefab_name] ~= nil then
						local var_312_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_10.prefab_name].transform, "story_v_out_423121", "423121074", "story_v_out_423121.awb")

						arg_309_1:RecordAudio("423121074", var_312_16)
						arg_309_1:RecordAudio("423121074", var_312_16)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_423121", "423121074", "story_v_out_423121.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_423121", "423121074", "story_v_out_423121.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_17 = math.max(var_312_8, arg_309_1.talkMaxDuration)

			if var_312_7 <= arg_309_1.time_ and arg_309_1.time_ < var_312_7 + var_312_17 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_7) / var_312_17

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_7 + var_312_17 and arg_309_1.time_ < var_312_7 + var_312_17 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play423121075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 423121075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play423121076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.5

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[7].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_313_1.callingController_:SetSelectedState("normal")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:GetWordFromCfg(423121075)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 20
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_8 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_8 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_8

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_8 and arg_313_1.time_ < var_316_0 + var_316_8 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play423121076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 423121076
		arg_317_1.duration_ = 17.4

		local var_317_0 = {
			zh = 10.666,
			ja = 17.4
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
				arg_317_0:Play423121077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["10146"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos10146 = var_320_0.localPosition
				var_320_0.localScale = Vector3.New(1, 1, 1)

				arg_317_1:CheckSpriteTmpPos("10146", 3)

				local var_320_2 = var_320_0.childCount

				for iter_320_0 = 0, var_320_2 - 1 do
					local var_320_3 = var_320_0:GetChild(iter_320_0)

					if var_320_3.name == "split_6" or not string.find(var_320_3.name, "split") then
						var_320_3.gameObject:SetActive(true)
					else
						var_320_3.gameObject:SetActive(false)
					end
				end
			end

			local var_320_4 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_4 then
				local var_320_5 = (arg_317_1.time_ - var_320_1) / var_320_4
				local var_320_6 = Vector3.New(0, -350, -320)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10146, var_320_6, var_320_5)
			end

			if arg_317_1.time_ >= var_320_1 + var_320_4 and arg_317_1.time_ < var_320_1 + var_320_4 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0, -350, -320)
			end

			local var_320_7 = 0
			local var_320_8 = 1.375

			if var_320_7 < arg_317_1.time_ and arg_317_1.time_ <= var_320_7 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_9 = arg_317_1:FormatText(StoryNameCfg[1338].name)

				arg_317_1.leftNameTxt_.text = var_320_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_10 = arg_317_1:GetWordFromCfg(423121076)
				local var_320_11 = arg_317_1:FormatText(var_320_10.content)

				arg_317_1.text_.text = var_320_11

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_12 = 55
				local var_320_13 = utf8.len(var_320_11)
				local var_320_14 = var_320_12 <= 0 and var_320_8 or var_320_8 * (var_320_13 / var_320_12)

				if var_320_14 > 0 and var_320_8 < var_320_14 then
					arg_317_1.talkMaxDuration = var_320_14

					if var_320_14 + var_320_7 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_14 + var_320_7
					end
				end

				arg_317_1.text_.text = var_320_11
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121076", "story_v_out_423121.awb") ~= 0 then
					local var_320_15 = manager.audio:GetVoiceLength("story_v_out_423121", "423121076", "story_v_out_423121.awb") / 1000

					if var_320_15 + var_320_7 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_15 + var_320_7
					end

					if var_320_10.prefab_name ~= "" and arg_317_1.actors_[var_320_10.prefab_name] ~= nil then
						local var_320_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_10.prefab_name].transform, "story_v_out_423121", "423121076", "story_v_out_423121.awb")

						arg_317_1:RecordAudio("423121076", var_320_16)
						arg_317_1:RecordAudio("423121076", var_320_16)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_423121", "423121076", "story_v_out_423121.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_423121", "423121076", "story_v_out_423121.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_17 = math.max(var_320_8, arg_317_1.talkMaxDuration)

			if var_320_7 <= arg_317_1.time_ and arg_317_1.time_ < var_320_7 + var_320_17 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_7) / var_320_17

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_7 + var_320_17 and arg_317_1.time_ < var_320_7 + var_320_17 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	Play423121077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 423121077
		arg_321_1.duration_ = 4.23

		local var_321_0 = {
			zh = 4.233,
			ja = 3.333
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
				arg_321_0:Play423121078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1083"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.actorSpriteComps1083 == nil then
				arg_321_1.var_.actorSpriteComps1083 = var_324_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_2 = 0.2

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.actorSpriteComps1083 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_324_1 then
							if arg_321_1.isInRecall_ then
								local var_324_4 = Mathf.Lerp(iter_324_1.color.r, arg_321_1.hightColor1.r, var_324_3)
								local var_324_5 = Mathf.Lerp(iter_324_1.color.g, arg_321_1.hightColor1.g, var_324_3)
								local var_324_6 = Mathf.Lerp(iter_324_1.color.b, arg_321_1.hightColor1.b, var_324_3)

								iter_324_1.color = Color.New(var_324_4, var_324_5, var_324_6)
							else
								local var_324_7 = Mathf.Lerp(iter_324_1.color.r, 1, var_324_3)

								iter_324_1.color = Color.New(var_324_7, var_324_7, var_324_7)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.actorSpriteComps1083 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_324_3 then
						if arg_321_1.isInRecall_ then
							iter_324_3.color = arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_324_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_321_1.var_.actorSpriteComps1083 = nil
			end

			local var_324_8 = arg_321_1.actors_["10146"].transform
			local var_324_9 = 0

			if var_324_9 < arg_321_1.time_ and arg_321_1.time_ <= var_324_9 + arg_324_0 then
				arg_321_1.var_.moveOldPos10146 = var_324_8.localPosition
				var_324_8.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("10146", 2)

				local var_324_10 = var_324_8.childCount

				for iter_324_4 = 0, var_324_10 - 1 do
					local var_324_11 = var_324_8:GetChild(iter_324_4)

					if var_324_11.name == "split_6" or not string.find(var_324_11.name, "split") then
						var_324_11.gameObject:SetActive(true)
					else
						var_324_11.gameObject:SetActive(false)
					end
				end
			end

			local var_324_12 = 0.001

			if var_324_9 <= arg_321_1.time_ and arg_321_1.time_ < var_324_9 + var_324_12 then
				local var_324_13 = (arg_321_1.time_ - var_324_9) / var_324_12
				local var_324_14 = Vector3.New(-390, -350, -320)

				var_324_8.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10146, var_324_14, var_324_13)
			end

			if arg_321_1.time_ >= var_324_9 + var_324_12 and arg_321_1.time_ < var_324_9 + var_324_12 + arg_324_0 then
				var_324_8.localPosition = Vector3.New(-390, -350, -320)
			end

			local var_324_15 = arg_321_1.actors_["1083"].transform
			local var_324_16 = 0

			if var_324_16 < arg_321_1.time_ and arg_321_1.time_ <= var_324_16 + arg_324_0 then
				arg_321_1.var_.moveOldPos1083 = var_324_15.localPosition
				var_324_15.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("1083", 4)

				local var_324_17 = var_324_15.childCount

				for iter_324_5 = 0, var_324_17 - 1 do
					local var_324_18 = var_324_15:GetChild(iter_324_5)

					if var_324_18.name == "split_7" or not string.find(var_324_18.name, "split") then
						var_324_18.gameObject:SetActive(true)
					else
						var_324_18.gameObject:SetActive(false)
					end
				end
			end

			local var_324_19 = 0.001

			if var_324_16 <= arg_321_1.time_ and arg_321_1.time_ < var_324_16 + var_324_19 then
				local var_324_20 = (arg_321_1.time_ - var_324_16) / var_324_19
				local var_324_21 = Vector3.New(390, -345, -345)

				var_324_15.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1083, var_324_21, var_324_20)
			end

			if arg_321_1.time_ >= var_324_16 + var_324_19 and arg_321_1.time_ < var_324_16 + var_324_19 + arg_324_0 then
				var_324_15.localPosition = Vector3.New(390, -345, -345)
			end

			local var_324_22 = 0
			local var_324_23 = 0.325

			if var_324_22 < arg_321_1.time_ and arg_321_1.time_ <= var_324_22 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_24 = arg_321_1:FormatText(StoryNameCfg[1332].name)

				arg_321_1.leftNameTxt_.text = var_324_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_25 = arg_321_1:GetWordFromCfg(423121077)
				local var_324_26 = arg_321_1:FormatText(var_324_25.content)

				arg_321_1.text_.text = var_324_26

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_27 = 13
				local var_324_28 = utf8.len(var_324_26)
				local var_324_29 = var_324_27 <= 0 and var_324_23 or var_324_23 * (var_324_28 / var_324_27)

				if var_324_29 > 0 and var_324_23 < var_324_29 then
					arg_321_1.talkMaxDuration = var_324_29

					if var_324_29 + var_324_22 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_29 + var_324_22
					end
				end

				arg_321_1.text_.text = var_324_26
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121077", "story_v_out_423121.awb") ~= 0 then
					local var_324_30 = manager.audio:GetVoiceLength("story_v_out_423121", "423121077", "story_v_out_423121.awb") / 1000

					if var_324_30 + var_324_22 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_30 + var_324_22
					end

					if var_324_25.prefab_name ~= "" and arg_321_1.actors_[var_324_25.prefab_name] ~= nil then
						local var_324_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_25.prefab_name].transform, "story_v_out_423121", "423121077", "story_v_out_423121.awb")

						arg_321_1:RecordAudio("423121077", var_324_31)
						arg_321_1:RecordAudio("423121077", var_324_31)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_423121", "423121077", "story_v_out_423121.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_423121", "423121077", "story_v_out_423121.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_32 = math.max(var_324_23, arg_321_1.talkMaxDuration)

			if var_324_22 <= arg_321_1.time_ and arg_321_1.time_ < var_324_22 + var_324_32 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_22) / var_324_32

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_22 + var_324_32 and arg_321_1.time_ < var_324_22 + var_324_32 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play423121078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 423121078
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play423121079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1083"]
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.actorSpriteComps1083 == nil then
				arg_325_1.var_.actorSpriteComps1083 = var_328_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_2 = 0.2

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 and not isNil(var_328_0) then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2

				if arg_325_1.var_.actorSpriteComps1083 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_328_1 then
							if arg_325_1.isInRecall_ then
								local var_328_4 = Mathf.Lerp(iter_328_1.color.r, arg_325_1.hightColor2.r, var_328_3)
								local var_328_5 = Mathf.Lerp(iter_328_1.color.g, arg_325_1.hightColor2.g, var_328_3)
								local var_328_6 = Mathf.Lerp(iter_328_1.color.b, arg_325_1.hightColor2.b, var_328_3)

								iter_328_1.color = Color.New(var_328_4, var_328_5, var_328_6)
							else
								local var_328_7 = Mathf.Lerp(iter_328_1.color.r, 0.5, var_328_3)

								iter_328_1.color = Color.New(var_328_7, var_328_7, var_328_7)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 and not isNil(var_328_0) and arg_325_1.var_.actorSpriteComps1083 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_328_3 then
						if arg_325_1.isInRecall_ then
							iter_328_3.color = arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_328_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_325_1.var_.actorSpriteComps1083 = nil
			end

			local var_328_8 = arg_325_1.actors_["10146"].transform
			local var_328_9 = 0

			if var_328_9 < arg_325_1.time_ and arg_325_1.time_ <= var_328_9 + arg_328_0 then
				arg_325_1.var_.moveOldPos10146 = var_328_8.localPosition
				var_328_8.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("10146", 7)

				local var_328_10 = var_328_8.childCount

				for iter_328_4 = 0, var_328_10 - 1 do
					local var_328_11 = var_328_8:GetChild(iter_328_4)

					if var_328_11.name == "" or not string.find(var_328_11.name, "split") then
						var_328_11.gameObject:SetActive(true)
					else
						var_328_11.gameObject:SetActive(false)
					end
				end
			end

			local var_328_12 = 0.001

			if var_328_9 <= arg_325_1.time_ and arg_325_1.time_ < var_328_9 + var_328_12 then
				local var_328_13 = (arg_325_1.time_ - var_328_9) / var_328_12
				local var_328_14 = Vector3.New(0, -2000, 0)

				var_328_8.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos10146, var_328_14, var_328_13)
			end

			if arg_325_1.time_ >= var_328_9 + var_328_12 and arg_325_1.time_ < var_328_9 + var_328_12 + arg_328_0 then
				var_328_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_328_15 = arg_325_1.actors_["1083"].transform
			local var_328_16 = 0

			if var_328_16 < arg_325_1.time_ and arg_325_1.time_ <= var_328_16 + arg_328_0 then
				arg_325_1.var_.moveOldPos1083 = var_328_15.localPosition
				var_328_15.localScale = Vector3.New(1, 1, 1)

				arg_325_1:CheckSpriteTmpPos("1083", 7)

				local var_328_17 = var_328_15.childCount

				for iter_328_5 = 0, var_328_17 - 1 do
					local var_328_18 = var_328_15:GetChild(iter_328_5)

					if var_328_18.name == "" or not string.find(var_328_18.name, "split") then
						var_328_18.gameObject:SetActive(true)
					else
						var_328_18.gameObject:SetActive(false)
					end
				end
			end

			local var_328_19 = 0.001

			if var_328_16 <= arg_325_1.time_ and arg_325_1.time_ < var_328_16 + var_328_19 then
				local var_328_20 = (arg_325_1.time_ - var_328_16) / var_328_19
				local var_328_21 = Vector3.New(0, -2000, 0)

				var_328_15.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1083, var_328_21, var_328_20)
			end

			if arg_325_1.time_ >= var_328_16 + var_328_19 and arg_325_1.time_ < var_328_16 + var_328_19 + arg_328_0 then
				var_328_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_328_22 = 0
			local var_328_23 = 1.925

			if var_328_22 < arg_325_1.time_ and arg_325_1.time_ <= var_328_22 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_24 = arg_325_1:GetWordFromCfg(423121078)
				local var_328_25 = arg_325_1:FormatText(var_328_24.content)

				arg_325_1.text_.text = var_328_25

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_26 = 77
				local var_328_27 = utf8.len(var_328_25)
				local var_328_28 = var_328_26 <= 0 and var_328_23 or var_328_23 * (var_328_27 / var_328_26)

				if var_328_28 > 0 and var_328_23 < var_328_28 then
					arg_325_1.talkMaxDuration = var_328_28

					if var_328_28 + var_328_22 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_28 + var_328_22
					end
				end

				arg_325_1.text_.text = var_328_25
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_29 = math.max(var_328_23, arg_325_1.talkMaxDuration)

			if var_328_22 <= arg_325_1.time_ and arg_325_1.time_ < var_328_22 + var_328_29 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_22) / var_328_29

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_22 + var_328_29 and arg_325_1.time_ < var_328_22 + var_328_29 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play423121079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 423121079
		arg_329_1.duration_ = 12.43

		local var_329_0 = {
			zh = 7.566,
			ja = 12.433
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
				arg_329_0:Play423121080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["10146"].transform
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.var_.moveOldPos10146 = var_332_0.localPosition
				var_332_0.localScale = Vector3.New(1, 1, 1)

				arg_329_1:CheckSpriteTmpPos("10146", 3)

				local var_332_2 = var_332_0.childCount

				for iter_332_0 = 0, var_332_2 - 1 do
					local var_332_3 = var_332_0:GetChild(iter_332_0)

					if var_332_3.name == "" or not string.find(var_332_3.name, "split") then
						var_332_3.gameObject:SetActive(true)
					else
						var_332_3.gameObject:SetActive(false)
					end
				end
			end

			local var_332_4 = 0.001

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_4 then
				local var_332_5 = (arg_329_1.time_ - var_332_1) / var_332_4
				local var_332_6 = Vector3.New(0, -350, -320)

				var_332_0.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos10146, var_332_6, var_332_5)
			end

			if arg_329_1.time_ >= var_332_1 + var_332_4 and arg_329_1.time_ < var_332_1 + var_332_4 + arg_332_0 then
				var_332_0.localPosition = Vector3.New(0, -350, -320)
			end

			local var_332_7 = 0
			local var_332_8 = 0.75

			if var_332_7 < arg_329_1.time_ and arg_329_1.time_ <= var_332_7 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_9 = arg_329_1:FormatText(StoryNameCfg[1338].name)

				arg_329_1.leftNameTxt_.text = var_332_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_10 = arg_329_1:GetWordFromCfg(423121079)
				local var_332_11 = arg_329_1:FormatText(var_332_10.content)

				arg_329_1.text_.text = var_332_11

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_12 = 30
				local var_332_13 = utf8.len(var_332_11)
				local var_332_14 = var_332_12 <= 0 and var_332_8 or var_332_8 * (var_332_13 / var_332_12)

				if var_332_14 > 0 and var_332_8 < var_332_14 then
					arg_329_1.talkMaxDuration = var_332_14

					if var_332_14 + var_332_7 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_14 + var_332_7
					end
				end

				arg_329_1.text_.text = var_332_11
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121079", "story_v_out_423121.awb") ~= 0 then
					local var_332_15 = manager.audio:GetVoiceLength("story_v_out_423121", "423121079", "story_v_out_423121.awb") / 1000

					if var_332_15 + var_332_7 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_15 + var_332_7
					end

					if var_332_10.prefab_name ~= "" and arg_329_1.actors_[var_332_10.prefab_name] ~= nil then
						local var_332_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_10.prefab_name].transform, "story_v_out_423121", "423121079", "story_v_out_423121.awb")

						arg_329_1:RecordAudio("423121079", var_332_16)
						arg_329_1:RecordAudio("423121079", var_332_16)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_423121", "423121079", "story_v_out_423121.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_423121", "423121079", "story_v_out_423121.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_17 = math.max(var_332_8, arg_329_1.talkMaxDuration)

			if var_332_7 <= arg_329_1.time_ and arg_329_1.time_ < var_332_7 + var_332_17 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_7) / var_332_17

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_7 + var_332_17 and arg_329_1.time_ < var_332_7 + var_332_17 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_329_1:InitPlayNodeList()
	end,
	Play423121080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 423121080
		arg_333_1.duration_ = 2.27

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play423121081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["10146"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos10146 = var_336_0.localPosition
				var_336_0.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("10146", 7)

				local var_336_2 = var_336_0.childCount

				for iter_336_0 = 0, var_336_2 - 1 do
					local var_336_3 = var_336_0:GetChild(iter_336_0)

					if var_336_3.name == "" or not string.find(var_336_3.name, "split") then
						var_336_3.gameObject:SetActive(true)
					else
						var_336_3.gameObject:SetActive(false)
					end
				end
			end

			local var_336_4 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_4 then
				local var_336_5 = (arg_333_1.time_ - var_336_1) / var_336_4
				local var_336_6 = Vector3.New(0, -2000, 0)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10146, var_336_6, var_336_5)
			end

			if arg_333_1.time_ >= var_336_1 + var_336_4 and arg_333_1.time_ < var_336_1 + var_336_4 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_336_7 = 1.26666666666667
			local var_336_8 = 1

			if var_336_7 < arg_333_1.time_ and arg_333_1.time_ <= var_336_7 + arg_336_0 then
				local var_336_9 = "play"
				local var_336_10 = "effect"

				arg_333_1:AudioAction(var_336_9, var_336_10, "se_story_144", "se_story_144_countdown", "")
			end

			local var_336_11 = 0
			local var_336_12 = 1.725

			if var_336_11 < arg_333_1.time_ and arg_333_1.time_ <= var_336_11 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_13 = arg_333_1:GetWordFromCfg(423121080)
				local var_336_14 = arg_333_1:FormatText(var_336_13.content)

				arg_333_1.text_.text = var_336_14

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_15 = 69
				local var_336_16 = utf8.len(var_336_14)
				local var_336_17 = var_336_15 <= 0 and var_336_12 or var_336_12 * (var_336_16 / var_336_15)

				if var_336_17 > 0 and var_336_12 < var_336_17 then
					arg_333_1.talkMaxDuration = var_336_17

					if var_336_17 + var_336_11 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_17 + var_336_11
					end
				end

				arg_333_1.text_.text = var_336_14
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121080", "story_v_out_423121.awb") ~= 0 then
					local var_336_18 = manager.audio:GetVoiceLength("story_v_out_423121", "423121080", "story_v_out_423121.awb") / 1000

					if var_336_18 + var_336_11 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_18 + var_336_11
					end

					if var_336_13.prefab_name ~= "" and arg_333_1.actors_[var_336_13.prefab_name] ~= nil then
						local var_336_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_13.prefab_name].transform, "story_v_out_423121", "423121080", "story_v_out_423121.awb")

						arg_333_1:RecordAudio("423121080", var_336_19)
						arg_333_1:RecordAudio("423121080", var_336_19)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_423121", "423121080", "story_v_out_423121.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_423121", "423121080", "story_v_out_423121.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_20 = math.max(var_336_12, arg_333_1.talkMaxDuration)

			if var_336_11 <= arg_333_1.time_ and arg_333_1.time_ < var_336_11 + var_336_20 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_11) / var_336_20

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_11 + var_336_20 and arg_333_1.time_ < var_336_11 + var_336_20 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play423121081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 423121081
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play423121082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0
			local var_340_1 = 0.625

			if var_340_0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_2 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_3 = arg_337_1:GetWordFromCfg(423121081)
				local var_340_4 = arg_337_1:FormatText(var_340_3.content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 25
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
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_8 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 <= arg_337_1.time_ and arg_337_1.time_ < var_340_0 + var_340_8 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_0) / var_340_8

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_0 + var_340_8 and arg_337_1.time_ < var_340_0 + var_340_8 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play423121082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 423121082
		arg_341_1.duration_ = 9.93

		local var_341_0 = {
			zh = 5.566,
			ja = 9.933
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
				arg_341_0:Play423121083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["10146"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos10146 = var_344_0.localPosition
				var_344_0.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("10146", 3)

				local var_344_2 = var_344_0.childCount

				for iter_344_0 = 0, var_344_2 - 1 do
					local var_344_3 = var_344_0:GetChild(iter_344_0)

					if var_344_3.name == "" or not string.find(var_344_3.name, "split") then
						var_344_3.gameObject:SetActive(true)
					else
						var_344_3.gameObject:SetActive(false)
					end
				end
			end

			local var_344_4 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_4 then
				local var_344_5 = (arg_341_1.time_ - var_344_1) / var_344_4
				local var_344_6 = Vector3.New(0, -350, -320)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos10146, var_344_6, var_344_5)
			end

			if arg_341_1.time_ >= var_344_1 + var_344_4 and arg_341_1.time_ < var_344_1 + var_344_4 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(0, -350, -320)
			end

			local var_344_7 = 0
			local var_344_8 = 0.575

			if var_344_7 < arg_341_1.time_ and arg_341_1.time_ <= var_344_7 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				local var_344_9 = arg_341_1:FormatText(StoryNameCfg[1338].name)

				arg_341_1.leftNameTxt_.text = var_344_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_10 = arg_341_1:GetWordFromCfg(423121082)
				local var_344_11 = arg_341_1:FormatText(var_344_10.content)

				arg_341_1.text_.text = var_344_11

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_12 = 23
				local var_344_13 = utf8.len(var_344_11)
				local var_344_14 = var_344_12 <= 0 and var_344_8 or var_344_8 * (var_344_13 / var_344_12)

				if var_344_14 > 0 and var_344_8 < var_344_14 then
					arg_341_1.talkMaxDuration = var_344_14

					if var_344_14 + var_344_7 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_14 + var_344_7
					end
				end

				arg_341_1.text_.text = var_344_11
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121082", "story_v_out_423121.awb") ~= 0 then
					local var_344_15 = manager.audio:GetVoiceLength("story_v_out_423121", "423121082", "story_v_out_423121.awb") / 1000

					if var_344_15 + var_344_7 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_15 + var_344_7
					end

					if var_344_10.prefab_name ~= "" and arg_341_1.actors_[var_344_10.prefab_name] ~= nil then
						local var_344_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_10.prefab_name].transform, "story_v_out_423121", "423121082", "story_v_out_423121.awb")

						arg_341_1:RecordAudio("423121082", var_344_16)
						arg_341_1:RecordAudio("423121082", var_344_16)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_423121", "423121082", "story_v_out_423121.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_423121", "423121082", "story_v_out_423121.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_17 = math.max(var_344_8, arg_341_1.talkMaxDuration)

			if var_344_7 <= arg_341_1.time_ and arg_341_1.time_ < var_344_7 + var_344_17 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_7) / var_344_17

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_7 + var_344_17 and arg_341_1.time_ < var_344_7 + var_344_17 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_341_1:InitPlayNodeList()
	end,
	Play423121083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 423121083
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play423121084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = arg_345_1.actors_["10146"].transform
			local var_348_1 = 0

			if var_348_1 < arg_345_1.time_ and arg_345_1.time_ <= var_348_1 + arg_348_0 then
				arg_345_1.var_.moveOldPos10146 = var_348_0.localPosition
				var_348_0.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("10146", 7)

				local var_348_2 = var_348_0.childCount

				for iter_348_0 = 0, var_348_2 - 1 do
					local var_348_3 = var_348_0:GetChild(iter_348_0)

					if var_348_3.name == "" or not string.find(var_348_3.name, "split") then
						var_348_3.gameObject:SetActive(true)
					else
						var_348_3.gameObject:SetActive(false)
					end
				end
			end

			local var_348_4 = 0.001

			if var_348_1 <= arg_345_1.time_ and arg_345_1.time_ < var_348_1 + var_348_4 then
				local var_348_5 = (arg_345_1.time_ - var_348_1) / var_348_4
				local var_348_6 = Vector3.New(0, -2000, 0)

				var_348_0.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10146, var_348_6, var_348_5)
			end

			if arg_345_1.time_ >= var_348_1 + var_348_4 and arg_345_1.time_ < var_348_1 + var_348_4 + arg_348_0 then
				var_348_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_348_7 = arg_345_1.actors_["10146"]
			local var_348_8 = 0

			if var_348_8 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1:SetSpriteNiuquEffect("10146", false)
			end

			local var_348_9 = 0
			local var_348_10 = 1.1

			if var_348_9 < arg_345_1.time_ and arg_345_1.time_ <= var_348_9 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_11 = arg_345_1:GetWordFromCfg(423121083)
				local var_348_12 = arg_345_1:FormatText(var_348_11.content)

				arg_345_1.text_.text = var_348_12

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_13 = 44
				local var_348_14 = utf8.len(var_348_12)
				local var_348_15 = var_348_13 <= 0 and var_348_10 or var_348_10 * (var_348_14 / var_348_13)

				if var_348_15 > 0 and var_348_10 < var_348_15 then
					arg_345_1.talkMaxDuration = var_348_15

					if var_348_15 + var_348_9 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_15 + var_348_9
					end
				end

				arg_345_1.text_.text = var_348_12
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_16 = math.max(var_348_10, arg_345_1.talkMaxDuration)

			if var_348_9 <= arg_345_1.time_ and arg_345_1.time_ < var_348_9 + var_348_16 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_9) / var_348_16

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_9 + var_348_16 and arg_345_1.time_ < var_348_9 + var_348_16 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play423121084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 423121084
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play423121085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0
			local var_352_1 = 0.925

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_2 = arg_349_1:FormatText(StoryNameCfg[7].name)

				arg_349_1.leftNameTxt_.text = var_352_2

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

				local var_352_3 = arg_349_1:GetWordFromCfg(423121084)
				local var_352_4 = arg_349_1:FormatText(var_352_3.content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 37
				local var_352_6 = utf8.len(var_352_4)
				local var_352_7 = var_352_5 <= 0 and var_352_1 or var_352_1 * (var_352_6 / var_352_5)

				if var_352_7 > 0 and var_352_1 < var_352_7 then
					arg_349_1.talkMaxDuration = var_352_7

					if var_352_7 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_7 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_4
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_8 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_8 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_8

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_8 and arg_349_1.time_ < var_352_0 + var_352_8 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play423121085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 423121085
		arg_353_1.duration_ = 4.87

		local var_353_0 = {
			zh = 4.866,
			ja = 2.633
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
				arg_353_0:Play423121086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = arg_353_1.actors_["1083"]
			local var_356_1 = 0

			if var_356_1 < arg_353_1.time_ and arg_353_1.time_ <= var_356_1 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.actorSpriteComps1083 == nil then
				arg_353_1.var_.actorSpriteComps1083 = var_356_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_2 = 0.2

			if var_356_1 <= arg_353_1.time_ and arg_353_1.time_ < var_356_1 + var_356_2 and not isNil(var_356_0) then
				local var_356_3 = (arg_353_1.time_ - var_356_1) / var_356_2

				if arg_353_1.var_.actorSpriteComps1083 then
					for iter_356_0, iter_356_1 in pairs(arg_353_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_356_1 then
							if arg_353_1.isInRecall_ then
								local var_356_4 = Mathf.Lerp(iter_356_1.color.r, arg_353_1.hightColor1.r, var_356_3)
								local var_356_5 = Mathf.Lerp(iter_356_1.color.g, arg_353_1.hightColor1.g, var_356_3)
								local var_356_6 = Mathf.Lerp(iter_356_1.color.b, arg_353_1.hightColor1.b, var_356_3)

								iter_356_1.color = Color.New(var_356_4, var_356_5, var_356_6)
							else
								local var_356_7 = Mathf.Lerp(iter_356_1.color.r, 1, var_356_3)

								iter_356_1.color = Color.New(var_356_7, var_356_7, var_356_7)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= var_356_1 + var_356_2 and arg_353_1.time_ < var_356_1 + var_356_2 + arg_356_0 and not isNil(var_356_0) and arg_353_1.var_.actorSpriteComps1083 then
				for iter_356_2, iter_356_3 in pairs(arg_353_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_356_3 then
						if arg_353_1.isInRecall_ then
							iter_356_3.color = arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_356_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_353_1.var_.actorSpriteComps1083 = nil
			end

			local var_356_8 = arg_353_1.actors_["1083"].transform
			local var_356_9 = 0

			if var_356_9 < arg_353_1.time_ and arg_353_1.time_ <= var_356_9 + arg_356_0 then
				arg_353_1.var_.moveOldPos1083 = var_356_8.localPosition
				var_356_8.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("1083", 3)

				local var_356_10 = var_356_8.childCount

				for iter_356_4 = 0, var_356_10 - 1 do
					local var_356_11 = var_356_8:GetChild(iter_356_4)

					if var_356_11.name == "split_7" or not string.find(var_356_11.name, "split") then
						var_356_11.gameObject:SetActive(true)
					else
						var_356_11.gameObject:SetActive(false)
					end
				end
			end

			local var_356_12 = 0.001

			if var_356_9 <= arg_353_1.time_ and arg_353_1.time_ < var_356_9 + var_356_12 then
				local var_356_13 = (arg_353_1.time_ - var_356_9) / var_356_12
				local var_356_14 = Vector3.New(-50, -345, -345)

				var_356_8.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1083, var_356_14, var_356_13)
			end

			if arg_353_1.time_ >= var_356_9 + var_356_12 and arg_353_1.time_ < var_356_9 + var_356_12 + arg_356_0 then
				var_356_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_356_15 = 0
			local var_356_16 = 0.525

			if var_356_15 < arg_353_1.time_ and arg_353_1.time_ <= var_356_15 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_17 = arg_353_1:FormatText(StoryNameCfg[1332].name)

				arg_353_1.leftNameTxt_.text = var_356_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_18 = arg_353_1:GetWordFromCfg(423121085)
				local var_356_19 = arg_353_1:FormatText(var_356_18.content)

				arg_353_1.text_.text = var_356_19

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_20 = 21
				local var_356_21 = utf8.len(var_356_19)
				local var_356_22 = var_356_20 <= 0 and var_356_16 or var_356_16 * (var_356_21 / var_356_20)

				if var_356_22 > 0 and var_356_16 < var_356_22 then
					arg_353_1.talkMaxDuration = var_356_22

					if var_356_22 + var_356_15 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_22 + var_356_15
					end
				end

				arg_353_1.text_.text = var_356_19
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121085", "story_v_out_423121.awb") ~= 0 then
					local var_356_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121085", "story_v_out_423121.awb") / 1000

					if var_356_23 + var_356_15 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_23 + var_356_15
					end

					if var_356_18.prefab_name ~= "" and arg_353_1.actors_[var_356_18.prefab_name] ~= nil then
						local var_356_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_18.prefab_name].transform, "story_v_out_423121", "423121085", "story_v_out_423121.awb")

						arg_353_1:RecordAudio("423121085", var_356_24)
						arg_353_1:RecordAudio("423121085", var_356_24)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_423121", "423121085", "story_v_out_423121.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_423121", "423121085", "story_v_out_423121.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_25 = math.max(var_356_16, arg_353_1.talkMaxDuration)

			if var_356_15 <= arg_353_1.time_ and arg_353_1.time_ < var_356_15 + var_356_25 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_15) / var_356_25

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_15 + var_356_25 and arg_353_1.time_ < var_356_15 + var_356_25 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play423121086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 423121086
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play423121087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1083"]
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps1083 == nil then
				arg_357_1.var_.actorSpriteComps1083 = var_360_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_2 = 0.2

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 and not isNil(var_360_0) then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2

				if arg_357_1.var_.actorSpriteComps1083 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								local var_360_4 = Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor2.r, var_360_3)
								local var_360_5 = Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor2.g, var_360_3)
								local var_360_6 = Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor2.b, var_360_3)

								iter_360_1.color = Color.New(var_360_4, var_360_5, var_360_6)
							else
								local var_360_7 = Mathf.Lerp(iter_360_1.color.r, 0.5, var_360_3)

								iter_360_1.color = Color.New(var_360_7, var_360_7, var_360_7)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 and not isNil(var_360_0) and arg_357_1.var_.actorSpriteComps1083 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_360_3 then
						if arg_357_1.isInRecall_ then
							iter_360_3.color = arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_360_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_357_1.var_.actorSpriteComps1083 = nil
			end

			local var_360_8 = 0
			local var_360_9 = 0.75

			if var_360_8 < arg_357_1.time_ and arg_357_1.time_ <= var_360_8 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_10 = arg_357_1:FormatText(StoryNameCfg[7].name)

				arg_357_1.leftNameTxt_.text = var_360_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_11 = arg_357_1:GetWordFromCfg(423121086)
				local var_360_12 = arg_357_1:FormatText(var_360_11.content)

				arg_357_1.text_.text = var_360_12

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_13 = 30
				local var_360_14 = utf8.len(var_360_12)
				local var_360_15 = var_360_13 <= 0 and var_360_9 or var_360_9 * (var_360_14 / var_360_13)

				if var_360_15 > 0 and var_360_9 < var_360_15 then
					arg_357_1.talkMaxDuration = var_360_15

					if var_360_15 + var_360_8 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_15 + var_360_8
					end
				end

				arg_357_1.text_.text = var_360_12
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_16 = math.max(var_360_9, arg_357_1.talkMaxDuration)

			if var_360_8 <= arg_357_1.time_ and arg_357_1.time_ < var_360_8 + var_360_16 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_8) / var_360_16

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_8 + var_360_16 and arg_357_1.time_ < var_360_8 + var_360_16 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play423121087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 423121087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play423121088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.925

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				local var_364_2 = arg_361_1:FormatText(StoryNameCfg[7].name)

				arg_361_1.leftNameTxt_.text = var_364_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:GetWordFromCfg(423121087)
				local var_364_4 = arg_361_1:FormatText(var_364_3.content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 37
				local var_364_6 = utf8.len(var_364_4)
				local var_364_7 = var_364_5 <= 0 and var_364_1 or var_364_1 * (var_364_6 / var_364_5)

				if var_364_7 > 0 and var_364_1 < var_364_7 then
					arg_361_1.talkMaxDuration = var_364_7

					if var_364_7 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_7 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_8 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_8 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_8

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_8 and arg_361_1.time_ < var_364_0 + var_364_8 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play423121088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 423121088
		arg_365_1.duration_ = 6.53

		local var_365_0 = {
			zh = 6.533,
			ja = 2.966
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play423121089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = arg_365_1.actors_["1083"]
			local var_368_1 = 0

			if var_368_1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_1 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.actorSpriteComps1083 == nil then
				arg_365_1.var_.actorSpriteComps1083 = var_368_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_2 = 0.2

			if var_368_1 <= arg_365_1.time_ and arg_365_1.time_ < var_368_1 + var_368_2 and not isNil(var_368_0) then
				local var_368_3 = (arg_365_1.time_ - var_368_1) / var_368_2

				if arg_365_1.var_.actorSpriteComps1083 then
					for iter_368_0, iter_368_1 in pairs(arg_365_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_368_1 then
							if arg_365_1.isInRecall_ then
								local var_368_4 = Mathf.Lerp(iter_368_1.color.r, arg_365_1.hightColor1.r, var_368_3)
								local var_368_5 = Mathf.Lerp(iter_368_1.color.g, arg_365_1.hightColor1.g, var_368_3)
								local var_368_6 = Mathf.Lerp(iter_368_1.color.b, arg_365_1.hightColor1.b, var_368_3)

								iter_368_1.color = Color.New(var_368_4, var_368_5, var_368_6)
							else
								local var_368_7 = Mathf.Lerp(iter_368_1.color.r, 1, var_368_3)

								iter_368_1.color = Color.New(var_368_7, var_368_7, var_368_7)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= var_368_1 + var_368_2 and arg_365_1.time_ < var_368_1 + var_368_2 + arg_368_0 and not isNil(var_368_0) and arg_365_1.var_.actorSpriteComps1083 then
				for iter_368_2, iter_368_3 in pairs(arg_365_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_368_3 then
						if arg_365_1.isInRecall_ then
							iter_368_3.color = arg_365_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_368_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_365_1.var_.actorSpriteComps1083 = nil
			end

			local var_368_8 = arg_365_1.actors_["1083"].transform
			local var_368_9 = 0

			if var_368_9 < arg_365_1.time_ and arg_365_1.time_ <= var_368_9 + arg_368_0 then
				arg_365_1.var_.moveOldPos1083 = var_368_8.localPosition
				var_368_8.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("1083", 3)

				local var_368_10 = var_368_8.childCount

				for iter_368_4 = 0, var_368_10 - 1 do
					local var_368_11 = var_368_8:GetChild(iter_368_4)

					if var_368_11.name == "split_6" or not string.find(var_368_11.name, "split") then
						var_368_11.gameObject:SetActive(true)
					else
						var_368_11.gameObject:SetActive(false)
					end
				end
			end

			local var_368_12 = 0.001

			if var_368_9 <= arg_365_1.time_ and arg_365_1.time_ < var_368_9 + var_368_12 then
				local var_368_13 = (arg_365_1.time_ - var_368_9) / var_368_12
				local var_368_14 = Vector3.New(-50, -345, -345)

				var_368_8.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1083, var_368_14, var_368_13)
			end

			if arg_365_1.time_ >= var_368_9 + var_368_12 and arg_365_1.time_ < var_368_9 + var_368_12 + arg_368_0 then
				var_368_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_368_15 = 0
			local var_368_16 = 0.725

			if var_368_15 < arg_365_1.time_ and arg_365_1.time_ <= var_368_15 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_17 = arg_365_1:FormatText(StoryNameCfg[1332].name)

				arg_365_1.leftNameTxt_.text = var_368_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_18 = arg_365_1:GetWordFromCfg(423121088)
				local var_368_19 = arg_365_1:FormatText(var_368_18.content)

				arg_365_1.text_.text = var_368_19

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_20 = 29
				local var_368_21 = utf8.len(var_368_19)
				local var_368_22 = var_368_20 <= 0 and var_368_16 or var_368_16 * (var_368_21 / var_368_20)

				if var_368_22 > 0 and var_368_16 < var_368_22 then
					arg_365_1.talkMaxDuration = var_368_22

					if var_368_22 + var_368_15 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_22 + var_368_15
					end
				end

				arg_365_1.text_.text = var_368_19
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121088", "story_v_out_423121.awb") ~= 0 then
					local var_368_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121088", "story_v_out_423121.awb") / 1000

					if var_368_23 + var_368_15 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_23 + var_368_15
					end

					if var_368_18.prefab_name ~= "" and arg_365_1.actors_[var_368_18.prefab_name] ~= nil then
						local var_368_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_18.prefab_name].transform, "story_v_out_423121", "423121088", "story_v_out_423121.awb")

						arg_365_1:RecordAudio("423121088", var_368_24)
						arg_365_1:RecordAudio("423121088", var_368_24)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_423121", "423121088", "story_v_out_423121.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_423121", "423121088", "story_v_out_423121.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_25 = math.max(var_368_16, arg_365_1.talkMaxDuration)

			if var_368_15 <= arg_365_1.time_ and arg_365_1.time_ < var_368_15 + var_368_25 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_15) / var_368_25

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_15 + var_368_25 and arg_365_1.time_ < var_368_15 + var_368_25 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_365_1:InitPlayNodeList()
	end,
	Play423121089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 423121089
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play423121090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = arg_369_1.actors_["1083"]
			local var_372_1 = 0

			if var_372_1 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps1083 == nil then
				arg_369_1.var_.actorSpriteComps1083 = var_372_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_2 = 0.2

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 and not isNil(var_372_0) then
				local var_372_3 = (arg_369_1.time_ - var_372_1) / var_372_2

				if arg_369_1.var_.actorSpriteComps1083 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_372_1 then
							if arg_369_1.isInRecall_ then
								local var_372_4 = Mathf.Lerp(iter_372_1.color.r, arg_369_1.hightColor2.r, var_372_3)
								local var_372_5 = Mathf.Lerp(iter_372_1.color.g, arg_369_1.hightColor2.g, var_372_3)
								local var_372_6 = Mathf.Lerp(iter_372_1.color.b, arg_369_1.hightColor2.b, var_372_3)

								iter_372_1.color = Color.New(var_372_4, var_372_5, var_372_6)
							else
								local var_372_7 = Mathf.Lerp(iter_372_1.color.r, 0.5, var_372_3)

								iter_372_1.color = Color.New(var_372_7, var_372_7, var_372_7)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 and not isNil(var_372_0) and arg_369_1.var_.actorSpriteComps1083 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_372_3 then
						if arg_369_1.isInRecall_ then
							iter_372_3.color = arg_369_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_372_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_369_1.var_.actorSpriteComps1083 = nil
			end

			local var_372_8 = 0
			local var_372_9 = 0.65

			if var_372_8 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				local var_372_10 = arg_369_1:FormatText(StoryNameCfg[7].name)

				arg_369_1.leftNameTxt_.text = var_372_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_11 = arg_369_1:GetWordFromCfg(423121089)
				local var_372_12 = arg_369_1:FormatText(var_372_11.content)

				arg_369_1.text_.text = var_372_12

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_13 = 26
				local var_372_14 = utf8.len(var_372_12)
				local var_372_15 = var_372_13 <= 0 and var_372_9 or var_372_9 * (var_372_14 / var_372_13)

				if var_372_15 > 0 and var_372_9 < var_372_15 then
					arg_369_1.talkMaxDuration = var_372_15

					if var_372_15 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_15 + var_372_8
					end
				end

				arg_369_1.text_.text = var_372_12
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_16 = math.max(var_372_9, arg_369_1.talkMaxDuration)

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_16 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_8) / var_372_16

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_8 + var_372_16 and arg_369_1.time_ < var_372_8 + var_372_16 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play423121090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 423121090
		arg_373_1.duration_ = 8

		local var_373_0 = {
			zh = 7.566,
			ja = 8
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play423121091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = arg_373_1.actors_["1083"]
			local var_376_1 = 0

			if var_376_1 < arg_373_1.time_ and arg_373_1.time_ <= var_376_1 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.actorSpriteComps1083 == nil then
				arg_373_1.var_.actorSpriteComps1083 = var_376_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_2 = 0.2

			if var_376_1 <= arg_373_1.time_ and arg_373_1.time_ < var_376_1 + var_376_2 and not isNil(var_376_0) then
				local var_376_3 = (arg_373_1.time_ - var_376_1) / var_376_2

				if arg_373_1.var_.actorSpriteComps1083 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_376_1 then
							if arg_373_1.isInRecall_ then
								local var_376_4 = Mathf.Lerp(iter_376_1.color.r, arg_373_1.hightColor1.r, var_376_3)
								local var_376_5 = Mathf.Lerp(iter_376_1.color.g, arg_373_1.hightColor1.g, var_376_3)
								local var_376_6 = Mathf.Lerp(iter_376_1.color.b, arg_373_1.hightColor1.b, var_376_3)

								iter_376_1.color = Color.New(var_376_4, var_376_5, var_376_6)
							else
								local var_376_7 = Mathf.Lerp(iter_376_1.color.r, 1, var_376_3)

								iter_376_1.color = Color.New(var_376_7, var_376_7, var_376_7)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= var_376_1 + var_376_2 and arg_373_1.time_ < var_376_1 + var_376_2 + arg_376_0 and not isNil(var_376_0) and arg_373_1.var_.actorSpriteComps1083 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_376_3 then
						if arg_373_1.isInRecall_ then
							iter_376_3.color = arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_376_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_373_1.var_.actorSpriteComps1083 = nil
			end

			local var_376_8 = arg_373_1.actors_["1083"].transform
			local var_376_9 = 0

			if var_376_9 < arg_373_1.time_ and arg_373_1.time_ <= var_376_9 + arg_376_0 then
				arg_373_1.var_.moveOldPos1083 = var_376_8.localPosition
				var_376_8.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1083", 3)

				local var_376_10 = var_376_8.childCount

				for iter_376_4 = 0, var_376_10 - 1 do
					local var_376_11 = var_376_8:GetChild(iter_376_4)

					if var_376_11.name == "split_7" or not string.find(var_376_11.name, "split") then
						var_376_11.gameObject:SetActive(true)
					else
						var_376_11.gameObject:SetActive(false)
					end
				end
			end

			local var_376_12 = 0.001

			if var_376_9 <= arg_373_1.time_ and arg_373_1.time_ < var_376_9 + var_376_12 then
				local var_376_13 = (arg_373_1.time_ - var_376_9) / var_376_12
				local var_376_14 = Vector3.New(-50, -345, -345)

				var_376_8.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1083, var_376_14, var_376_13)
			end

			if arg_373_1.time_ >= var_376_9 + var_376_12 and arg_373_1.time_ < var_376_9 + var_376_12 + arg_376_0 then
				var_376_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_376_15 = arg_373_1.actors_["1083"]
			local var_376_16 = 0

			if var_376_16 < arg_373_1.time_ and arg_373_1.time_ <= var_376_16 + arg_376_0 then
				local var_376_17 = var_376_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_376_17 then
					arg_373_1.var_.alphaOldValue1083 = var_376_17.alpha
					arg_373_1.var_.characterEffect1083 = var_376_17
				end

				arg_373_1.var_.alphaOldValue1083 = 0
			end

			local var_376_18 = 0.0333333333333333

			if var_376_16 <= arg_373_1.time_ and arg_373_1.time_ < var_376_16 + var_376_18 then
				local var_376_19 = (arg_373_1.time_ - var_376_16) / var_376_18
				local var_376_20 = Mathf.Lerp(arg_373_1.var_.alphaOldValue1083, 1, var_376_19)

				if arg_373_1.var_.characterEffect1083 then
					arg_373_1.var_.characterEffect1083.alpha = var_376_20
				end
			end

			if arg_373_1.time_ >= var_376_16 + var_376_18 and arg_373_1.time_ < var_376_16 + var_376_18 + arg_376_0 and arg_373_1.var_.characterEffect1083 then
				arg_373_1.var_.characterEffect1083.alpha = 1
			end

			local var_376_21 = 0
			local var_376_22 = 0.825

			if var_376_21 < arg_373_1.time_ and arg_373_1.time_ <= var_376_21 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				local var_376_23 = arg_373_1:FormatText(StoryNameCfg[1332].name)

				arg_373_1.leftNameTxt_.text = var_376_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_24 = arg_373_1:GetWordFromCfg(423121090)
				local var_376_25 = arg_373_1:FormatText(var_376_24.content)

				arg_373_1.text_.text = var_376_25

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_26 = 33
				local var_376_27 = utf8.len(var_376_25)
				local var_376_28 = var_376_26 <= 0 and var_376_22 or var_376_22 * (var_376_27 / var_376_26)

				if var_376_28 > 0 and var_376_22 < var_376_28 then
					arg_373_1.talkMaxDuration = var_376_28

					if var_376_28 + var_376_21 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_28 + var_376_21
					end
				end

				arg_373_1.text_.text = var_376_25
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121090", "story_v_out_423121.awb") ~= 0 then
					local var_376_29 = manager.audio:GetVoiceLength("story_v_out_423121", "423121090", "story_v_out_423121.awb") / 1000

					if var_376_29 + var_376_21 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_29 + var_376_21
					end

					if var_376_24.prefab_name ~= "" and arg_373_1.actors_[var_376_24.prefab_name] ~= nil then
						local var_376_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_24.prefab_name].transform, "story_v_out_423121", "423121090", "story_v_out_423121.awb")

						arg_373_1:RecordAudio("423121090", var_376_30)
						arg_373_1:RecordAudio("423121090", var_376_30)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_423121", "423121090", "story_v_out_423121.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_423121", "423121090", "story_v_out_423121.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_31 = math.max(var_376_22, arg_373_1.talkMaxDuration)

			if var_376_21 <= arg_373_1.time_ and arg_373_1.time_ < var_376_21 + var_376_31 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_21) / var_376_31

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_21 + var_376_31 and arg_373_1.time_ < var_376_21 + var_376_31 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play423121091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 423121091
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play423121092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1083"]
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.actorSpriteComps1083 == nil then
				arg_377_1.var_.actorSpriteComps1083 = var_380_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_2 = 0.2

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 and not isNil(var_380_0) then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2

				if arg_377_1.var_.actorSpriteComps1083 then
					for iter_380_0, iter_380_1 in pairs(arg_377_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_380_1 then
							if arg_377_1.isInRecall_ then
								local var_380_4 = Mathf.Lerp(iter_380_1.color.r, arg_377_1.hightColor2.r, var_380_3)
								local var_380_5 = Mathf.Lerp(iter_380_1.color.g, arg_377_1.hightColor2.g, var_380_3)
								local var_380_6 = Mathf.Lerp(iter_380_1.color.b, arg_377_1.hightColor2.b, var_380_3)

								iter_380_1.color = Color.New(var_380_4, var_380_5, var_380_6)
							else
								local var_380_7 = Mathf.Lerp(iter_380_1.color.r, 0.5, var_380_3)

								iter_380_1.color = Color.New(var_380_7, var_380_7, var_380_7)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 and not isNil(var_380_0) and arg_377_1.var_.actorSpriteComps1083 then
				for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_380_3 then
						if arg_377_1.isInRecall_ then
							iter_380_3.color = arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_380_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_377_1.var_.actorSpriteComps1083 = nil
			end

			local var_380_8 = 0
			local var_380_9 = 0.675

			if var_380_8 < arg_377_1.time_ and arg_377_1.time_ <= var_380_8 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_10 = arg_377_1:FormatText(StoryNameCfg[7].name)

				arg_377_1.leftNameTxt_.text = var_380_10

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

				local var_380_11 = arg_377_1:GetWordFromCfg(423121091)
				local var_380_12 = arg_377_1:FormatText(var_380_11.content)

				arg_377_1.text_.text = var_380_12

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_13 = 27
				local var_380_14 = utf8.len(var_380_12)
				local var_380_15 = var_380_13 <= 0 and var_380_9 or var_380_9 * (var_380_14 / var_380_13)

				if var_380_15 > 0 and var_380_9 < var_380_15 then
					arg_377_1.talkMaxDuration = var_380_15

					if var_380_15 + var_380_8 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_15 + var_380_8
					end
				end

				arg_377_1.text_.text = var_380_12
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_16 = math.max(var_380_9, arg_377_1.talkMaxDuration)

			if var_380_8 <= arg_377_1.time_ and arg_377_1.time_ < var_380_8 + var_380_16 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_8) / var_380_16

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_8 + var_380_16 and arg_377_1.time_ < var_380_8 + var_380_16 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play423121092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 423121092
		arg_381_1.duration_ = 4.77

		local var_381_0 = {
			zh = 2.833,
			ja = 4.766
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play423121093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1083"]
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.actorSpriteComps1083 == nil then
				arg_381_1.var_.actorSpriteComps1083 = var_384_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_2 = 0.2

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 and not isNil(var_384_0) then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2

				if arg_381_1.var_.actorSpriteComps1083 then
					for iter_384_0, iter_384_1 in pairs(arg_381_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_384_1 then
							if arg_381_1.isInRecall_ then
								local var_384_4 = Mathf.Lerp(iter_384_1.color.r, arg_381_1.hightColor1.r, var_384_3)
								local var_384_5 = Mathf.Lerp(iter_384_1.color.g, arg_381_1.hightColor1.g, var_384_3)
								local var_384_6 = Mathf.Lerp(iter_384_1.color.b, arg_381_1.hightColor1.b, var_384_3)

								iter_384_1.color = Color.New(var_384_4, var_384_5, var_384_6)
							else
								local var_384_7 = Mathf.Lerp(iter_384_1.color.r, 1, var_384_3)

								iter_384_1.color = Color.New(var_384_7, var_384_7, var_384_7)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 and not isNil(var_384_0) and arg_381_1.var_.actorSpriteComps1083 then
				for iter_384_2, iter_384_3 in pairs(arg_381_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_384_3 then
						if arg_381_1.isInRecall_ then
							iter_384_3.color = arg_381_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_384_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_381_1.var_.actorSpriteComps1083 = nil
			end

			local var_384_8 = arg_381_1.actors_["1083"].transform
			local var_384_9 = 0

			if var_384_9 < arg_381_1.time_ and arg_381_1.time_ <= var_384_9 + arg_384_0 then
				arg_381_1.var_.moveOldPos1083 = var_384_8.localPosition
				var_384_8.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("1083", 3)

				local var_384_10 = var_384_8.childCount

				for iter_384_4 = 0, var_384_10 - 1 do
					local var_384_11 = var_384_8:GetChild(iter_384_4)

					if var_384_11.name == "split_4" or not string.find(var_384_11.name, "split") then
						var_384_11.gameObject:SetActive(true)
					else
						var_384_11.gameObject:SetActive(false)
					end
				end
			end

			local var_384_12 = 0.001

			if var_384_9 <= arg_381_1.time_ and arg_381_1.time_ < var_384_9 + var_384_12 then
				local var_384_13 = (arg_381_1.time_ - var_384_9) / var_384_12
				local var_384_14 = Vector3.New(-50, -345, -345)

				var_384_8.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1083, var_384_14, var_384_13)
			end

			if arg_381_1.time_ >= var_384_9 + var_384_12 and arg_381_1.time_ < var_384_9 + var_384_12 + arg_384_0 then
				var_384_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_384_15 = 0
			local var_384_16 = 0.35

			if var_384_15 < arg_381_1.time_ and arg_381_1.time_ <= var_384_15 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_17 = arg_381_1:FormatText(StoryNameCfg[1332].name)

				arg_381_1.leftNameTxt_.text = var_384_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_18 = arg_381_1:GetWordFromCfg(423121092)
				local var_384_19 = arg_381_1:FormatText(var_384_18.content)

				arg_381_1.text_.text = var_384_19

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_20 = 14
				local var_384_21 = utf8.len(var_384_19)
				local var_384_22 = var_384_20 <= 0 and var_384_16 or var_384_16 * (var_384_21 / var_384_20)

				if var_384_22 > 0 and var_384_16 < var_384_22 then
					arg_381_1.talkMaxDuration = var_384_22

					if var_384_22 + var_384_15 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_22 + var_384_15
					end
				end

				arg_381_1.text_.text = var_384_19
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121092", "story_v_out_423121.awb") ~= 0 then
					local var_384_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121092", "story_v_out_423121.awb") / 1000

					if var_384_23 + var_384_15 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_23 + var_384_15
					end

					if var_384_18.prefab_name ~= "" and arg_381_1.actors_[var_384_18.prefab_name] ~= nil then
						local var_384_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_18.prefab_name].transform, "story_v_out_423121", "423121092", "story_v_out_423121.awb")

						arg_381_1:RecordAudio("423121092", var_384_24)
						arg_381_1:RecordAudio("423121092", var_384_24)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_423121", "423121092", "story_v_out_423121.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_423121", "423121092", "story_v_out_423121.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_25 = math.max(var_384_16, arg_381_1.talkMaxDuration)

			if var_384_15 <= arg_381_1.time_ and arg_381_1.time_ < var_384_15 + var_384_25 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_15) / var_384_25

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_15 + var_384_25 and arg_381_1.time_ < var_384_15 + var_384_25 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play423121093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 423121093
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play423121094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["1083"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.actorSpriteComps1083 == nil then
				arg_385_1.var_.actorSpriteComps1083 = var_388_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_2 = 0.2

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.actorSpriteComps1083 then
					for iter_388_0, iter_388_1 in pairs(arg_385_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_388_1 then
							if arg_385_1.isInRecall_ then
								local var_388_4 = Mathf.Lerp(iter_388_1.color.r, arg_385_1.hightColor2.r, var_388_3)
								local var_388_5 = Mathf.Lerp(iter_388_1.color.g, arg_385_1.hightColor2.g, var_388_3)
								local var_388_6 = Mathf.Lerp(iter_388_1.color.b, arg_385_1.hightColor2.b, var_388_3)

								iter_388_1.color = Color.New(var_388_4, var_388_5, var_388_6)
							else
								local var_388_7 = Mathf.Lerp(iter_388_1.color.r, 0.5, var_388_3)

								iter_388_1.color = Color.New(var_388_7, var_388_7, var_388_7)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.actorSpriteComps1083 then
				for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_388_3 then
						if arg_385_1.isInRecall_ then
							iter_388_3.color = arg_385_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_388_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_385_1.var_.actorSpriteComps1083 = nil
			end

			local var_388_8 = 0
			local var_388_9 = 0.35

			if var_388_8 < arg_385_1.time_ and arg_385_1.time_ <= var_388_8 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_10 = arg_385_1:FormatText(StoryNameCfg[7].name)

				arg_385_1.leftNameTxt_.text = var_388_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, true)
				arg_385_1.iconController_:SetSelectedState("hero")

				arg_385_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_385_1.callingController_:SetSelectedState("normal")

				arg_385_1.keyicon_.color = Color.New(1, 1, 1)
				arg_385_1.icon_.color = Color.New(1, 1, 1)

				local var_388_11 = arg_385_1:GetWordFromCfg(423121093)
				local var_388_12 = arg_385_1:FormatText(var_388_11.content)

				arg_385_1.text_.text = var_388_12

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_13 = 14
				local var_388_14 = utf8.len(var_388_12)
				local var_388_15 = var_388_13 <= 0 and var_388_9 or var_388_9 * (var_388_14 / var_388_13)

				if var_388_15 > 0 and var_388_9 < var_388_15 then
					arg_385_1.talkMaxDuration = var_388_15

					if var_388_15 + var_388_8 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_15 + var_388_8
					end
				end

				arg_385_1.text_.text = var_388_12
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_16 = math.max(var_388_9, arg_385_1.talkMaxDuration)

			if var_388_8 <= arg_385_1.time_ and arg_385_1.time_ < var_388_8 + var_388_16 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_8) / var_388_16

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_8 + var_388_16 and arg_385_1.time_ < var_388_8 + var_388_16 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play423121094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 423121094
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play423121095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1083"].transform
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.var_.moveOldPos1083 = var_392_0.localPosition
				var_392_0.localScale = Vector3.New(1, 1, 1)

				arg_389_1:CheckSpriteTmpPos("1083", 7)

				local var_392_2 = var_392_0.childCount

				for iter_392_0 = 0, var_392_2 - 1 do
					local var_392_3 = var_392_0:GetChild(iter_392_0)

					if var_392_3.name == "" or not string.find(var_392_3.name, "split") then
						var_392_3.gameObject:SetActive(true)
					else
						var_392_3.gameObject:SetActive(false)
					end
				end
			end

			local var_392_4 = 0.001

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_4 then
				local var_392_5 = (arg_389_1.time_ - var_392_1) / var_392_4
				local var_392_6 = Vector3.New(0, -2000, 0)

				var_392_0.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1083, var_392_6, var_392_5)
			end

			if arg_389_1.time_ >= var_392_1 + var_392_4 and arg_389_1.time_ < var_392_1 + var_392_4 + arg_392_0 then
				var_392_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_392_7 = 0.9
			local var_392_8 = 1

			if var_392_7 < arg_389_1.time_ and arg_389_1.time_ <= var_392_7 + arg_392_0 then
				local var_392_9 = "play"
				local var_392_10 = "effect"

				arg_389_1:AudioAction(var_392_9, var_392_10, "se_story_1310", "se_story_1310_clap", "")
			end

			local var_392_11 = 0
			local var_392_12 = 1.325

			if var_392_11 < arg_389_1.time_ and arg_389_1.time_ <= var_392_11 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_13 = arg_389_1:GetWordFromCfg(423121094)
				local var_392_14 = arg_389_1:FormatText(var_392_13.content)

				arg_389_1.text_.text = var_392_14

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_15 = 53
				local var_392_16 = utf8.len(var_392_14)
				local var_392_17 = var_392_15 <= 0 and var_392_12 or var_392_12 * (var_392_16 / var_392_15)

				if var_392_17 > 0 and var_392_12 < var_392_17 then
					arg_389_1.talkMaxDuration = var_392_17

					if var_392_17 + var_392_11 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_17 + var_392_11
					end
				end

				arg_389_1.text_.text = var_392_14
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_18 = math.max(var_392_12, arg_389_1.talkMaxDuration)

			if var_392_11 <= arg_389_1.time_ and arg_389_1.time_ < var_392_11 + var_392_18 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_11) / var_392_18

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_11 + var_392_18 and arg_389_1.time_ < var_392_11 + var_392_18 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play423121095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 423121095
		arg_393_1.duration_ = 8.17

		local var_393_0 = {
			zh = 5.8,
			ja = 8.166
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play423121096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1083"]
			local var_396_1 = 1.8

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.actorSpriteComps1083 == nil then
				arg_393_1.var_.actorSpriteComps1083 = var_396_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_2 = 0.2

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_2 and not isNil(var_396_0) then
				local var_396_3 = (arg_393_1.time_ - var_396_1) / var_396_2

				if arg_393_1.var_.actorSpriteComps1083 then
					for iter_396_0, iter_396_1 in pairs(arg_393_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_396_1 then
							if arg_393_1.isInRecall_ then
								local var_396_4 = Mathf.Lerp(iter_396_1.color.r, arg_393_1.hightColor1.r, var_396_3)
								local var_396_5 = Mathf.Lerp(iter_396_1.color.g, arg_393_1.hightColor1.g, var_396_3)
								local var_396_6 = Mathf.Lerp(iter_396_1.color.b, arg_393_1.hightColor1.b, var_396_3)

								iter_396_1.color = Color.New(var_396_4, var_396_5, var_396_6)
							else
								local var_396_7 = Mathf.Lerp(iter_396_1.color.r, 1, var_396_3)

								iter_396_1.color = Color.New(var_396_7, var_396_7, var_396_7)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= var_396_1 + var_396_2 and arg_393_1.time_ < var_396_1 + var_396_2 + arg_396_0 and not isNil(var_396_0) and arg_393_1.var_.actorSpriteComps1083 then
				for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_396_3 then
						if arg_393_1.isInRecall_ then
							iter_396_3.color = arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_396_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_393_1.var_.actorSpriteComps1083 = nil
			end

			local var_396_8 = arg_393_1.actors_["1083"].transform
			local var_396_9 = 1.8

			if var_396_9 < arg_393_1.time_ and arg_393_1.time_ <= var_396_9 + arg_396_0 then
				arg_393_1.var_.moveOldPos1083 = var_396_8.localPosition
				var_396_8.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("1083", 3)

				local var_396_10 = var_396_8.childCount

				for iter_396_4 = 0, var_396_10 - 1 do
					local var_396_11 = var_396_8:GetChild(iter_396_4)

					if var_396_11.name == "split_7" or not string.find(var_396_11.name, "split") then
						var_396_11.gameObject:SetActive(true)
					else
						var_396_11.gameObject:SetActive(false)
					end
				end
			end

			local var_396_12 = 0.001

			if var_396_9 <= arg_393_1.time_ and arg_393_1.time_ < var_396_9 + var_396_12 then
				local var_396_13 = (arg_393_1.time_ - var_396_9) / var_396_12
				local var_396_14 = Vector3.New(-50, -345, -345)

				var_396_8.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1083, var_396_14, var_396_13)
			end

			if arg_393_1.time_ >= var_396_9 + var_396_12 and arg_393_1.time_ < var_396_9 + var_396_12 + arg_396_0 then
				var_396_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_396_15 = 0

			if var_396_15 < arg_393_1.time_ and arg_393_1.time_ <= var_396_15 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_16 = 1

			if var_396_15 <= arg_393_1.time_ and arg_393_1.time_ < var_396_15 + var_396_16 then
				local var_396_17 = (arg_393_1.time_ - var_396_15) / var_396_16
				local var_396_18 = Color.New(0, 0, 0)

				var_396_18.a = Mathf.Lerp(0, 1, var_396_17)
				arg_393_1.mask_.color = var_396_18
			end

			if arg_393_1.time_ >= var_396_15 + var_396_16 and arg_393_1.time_ < var_396_15 + var_396_16 + arg_396_0 then
				local var_396_19 = Color.New(0, 0, 0)

				var_396_19.a = 1
				arg_393_1.mask_.color = var_396_19
			end

			local var_396_20 = 1

			if var_396_20 < arg_393_1.time_ and arg_393_1.time_ <= var_396_20 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_21 = 1

			if var_396_20 <= arg_393_1.time_ and arg_393_1.time_ < var_396_20 + var_396_21 then
				local var_396_22 = (arg_393_1.time_ - var_396_20) / var_396_21
				local var_396_23 = Color.New(0, 0, 0)

				var_396_23.a = Mathf.Lerp(1, 0, var_396_22)
				arg_393_1.mask_.color = var_396_23
			end

			if arg_393_1.time_ >= var_396_20 + var_396_21 and arg_393_1.time_ < var_396_20 + var_396_21 + arg_396_0 then
				local var_396_24 = Color.New(0, 0, 0)
				local var_396_25 = 0

				arg_393_1.mask_.enabled = false
				var_396_24.a = var_396_25
				arg_393_1.mask_.color = var_396_24
			end

			if arg_393_1.frameCnt_ <= 1 then
				arg_393_1.dialog_:SetActive(false)
			end

			local var_396_26 = 2
			local var_396_27 = 0.525

			if var_396_26 < arg_393_1.time_ and arg_393_1.time_ <= var_396_26 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				arg_393_1.dialog_:SetActive(true)

				arg_393_1.dialogCg_.alpha = 0

				local var_396_28 = LeanTween.value(arg_393_1.dialog_, 0, 1, 0.3)

				var_396_28:setOnUpdate(LuaHelper.FloatAction(function(arg_397_0)
					arg_393_1.dialogCg_.alpha = arg_397_0
				end))
				var_396_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_393_1.dialog_)
					var_396_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_393_1.duration_ = arg_393_1.duration_ + 0.3

				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_29 = arg_393_1:FormatText(StoryNameCfg[1332].name)

				arg_393_1.leftNameTxt_.text = var_396_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_30 = arg_393_1:GetWordFromCfg(423121095)
				local var_396_31 = arg_393_1:FormatText(var_396_30.content)

				arg_393_1.text_.text = var_396_31

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_32 = 21
				local var_396_33 = utf8.len(var_396_31)
				local var_396_34 = var_396_32 <= 0 and var_396_27 or var_396_27 * (var_396_33 / var_396_32)

				if var_396_34 > 0 and var_396_27 < var_396_34 then
					arg_393_1.talkMaxDuration = var_396_34
					var_396_26 = var_396_26 + 0.3

					if var_396_34 + var_396_26 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_34 + var_396_26
					end
				end

				arg_393_1.text_.text = var_396_31
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121095", "story_v_out_423121.awb") ~= 0 then
					local var_396_35 = manager.audio:GetVoiceLength("story_v_out_423121", "423121095", "story_v_out_423121.awb") / 1000

					if var_396_35 + var_396_26 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_35 + var_396_26
					end

					if var_396_30.prefab_name ~= "" and arg_393_1.actors_[var_396_30.prefab_name] ~= nil then
						local var_396_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_30.prefab_name].transform, "story_v_out_423121", "423121095", "story_v_out_423121.awb")

						arg_393_1:RecordAudio("423121095", var_396_36)
						arg_393_1:RecordAudio("423121095", var_396_36)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_423121", "423121095", "story_v_out_423121.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_423121", "423121095", "story_v_out_423121.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_37 = var_396_26 + 0.3
			local var_396_38 = math.max(var_396_27, arg_393_1.talkMaxDuration)

			if var_396_37 <= arg_393_1.time_ and arg_393_1.time_ < var_396_37 + var_396_38 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_37) / var_396_38

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_37 + var_396_38 and arg_393_1.time_ < var_396_37 + var_396_38 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play423121096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 423121096
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play423121097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1083"]
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.actorSpriteComps1083 == nil then
				arg_399_1.var_.actorSpriteComps1083 = var_402_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_2 = 0.2

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 and not isNil(var_402_0) then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2

				if arg_399_1.var_.actorSpriteComps1083 then
					for iter_402_0, iter_402_1 in pairs(arg_399_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_402_1 then
							if arg_399_1.isInRecall_ then
								local var_402_4 = Mathf.Lerp(iter_402_1.color.r, arg_399_1.hightColor2.r, var_402_3)
								local var_402_5 = Mathf.Lerp(iter_402_1.color.g, arg_399_1.hightColor2.g, var_402_3)
								local var_402_6 = Mathf.Lerp(iter_402_1.color.b, arg_399_1.hightColor2.b, var_402_3)

								iter_402_1.color = Color.New(var_402_4, var_402_5, var_402_6)
							else
								local var_402_7 = Mathf.Lerp(iter_402_1.color.r, 0.5, var_402_3)

								iter_402_1.color = Color.New(var_402_7, var_402_7, var_402_7)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 and not isNil(var_402_0) and arg_399_1.var_.actorSpriteComps1083 then
				for iter_402_2, iter_402_3 in pairs(arg_399_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_402_3 then
						if arg_399_1.isInRecall_ then
							iter_402_3.color = arg_399_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_402_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_399_1.var_.actorSpriteComps1083 = nil
			end

			local var_402_8 = 0
			local var_402_9 = 0.875

			if var_402_8 < arg_399_1.time_ and arg_399_1.time_ <= var_402_8 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_10 = arg_399_1:FormatText(StoryNameCfg[7].name)

				arg_399_1.leftNameTxt_.text = var_402_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_11 = arg_399_1:GetWordFromCfg(423121096)
				local var_402_12 = arg_399_1:FormatText(var_402_11.content)

				arg_399_1.text_.text = var_402_12

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_13 = 35
				local var_402_14 = utf8.len(var_402_12)
				local var_402_15 = var_402_13 <= 0 and var_402_9 or var_402_9 * (var_402_14 / var_402_13)

				if var_402_15 > 0 and var_402_9 < var_402_15 then
					arg_399_1.talkMaxDuration = var_402_15

					if var_402_15 + var_402_8 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_15 + var_402_8
					end
				end

				arg_399_1.text_.text = var_402_12
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_16 = math.max(var_402_9, arg_399_1.talkMaxDuration)

			if var_402_8 <= arg_399_1.time_ and arg_399_1.time_ < var_402_8 + var_402_16 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_8) / var_402_16

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_8 + var_402_16 and arg_399_1.time_ < var_402_8 + var_402_16 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play423121097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 423121097
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play423121098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0
			local var_406_1 = 1.175

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_2 = arg_403_1:FormatText(StoryNameCfg[7].name)

				arg_403_1.leftNameTxt_.text = var_406_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_3 = arg_403_1:GetWordFromCfg(423121097)
				local var_406_4 = arg_403_1:FormatText(var_406_3.content)

				arg_403_1.text_.text = var_406_4

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 47
				local var_406_6 = utf8.len(var_406_4)
				local var_406_7 = var_406_5 <= 0 and var_406_1 or var_406_1 * (var_406_6 / var_406_5)

				if var_406_7 > 0 and var_406_1 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_0
					end
				end

				arg_403_1.text_.text = var_406_4
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_8 = math.max(var_406_1, arg_403_1.talkMaxDuration)

			if var_406_0 <= arg_403_1.time_ and arg_403_1.time_ < var_406_0 + var_406_8 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_0) / var_406_8

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_0 + var_406_8 and arg_403_1.time_ < var_406_0 + var_406_8 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play423121098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 423121098
		arg_407_1.duration_ = 8.23

		local var_407_0 = {
			zh = 5.366,
			ja = 8.233
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play423121099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1083"]
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.actorSpriteComps1083 == nil then
				arg_407_1.var_.actorSpriteComps1083 = var_410_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_2 = 0.2

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 and not isNil(var_410_0) then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2

				if arg_407_1.var_.actorSpriteComps1083 then
					for iter_410_0, iter_410_1 in pairs(arg_407_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_410_1 then
							if arg_407_1.isInRecall_ then
								local var_410_4 = Mathf.Lerp(iter_410_1.color.r, arg_407_1.hightColor1.r, var_410_3)
								local var_410_5 = Mathf.Lerp(iter_410_1.color.g, arg_407_1.hightColor1.g, var_410_3)
								local var_410_6 = Mathf.Lerp(iter_410_1.color.b, arg_407_1.hightColor1.b, var_410_3)

								iter_410_1.color = Color.New(var_410_4, var_410_5, var_410_6)
							else
								local var_410_7 = Mathf.Lerp(iter_410_1.color.r, 1, var_410_3)

								iter_410_1.color = Color.New(var_410_7, var_410_7, var_410_7)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.actorSpriteComps1083 then
				for iter_410_2, iter_410_3 in pairs(arg_407_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_410_3 then
						if arg_407_1.isInRecall_ then
							iter_410_3.color = arg_407_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_410_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_407_1.var_.actorSpriteComps1083 = nil
			end

			local var_410_8 = arg_407_1.actors_["1083"].transform
			local var_410_9 = 0

			if var_410_9 < arg_407_1.time_ and arg_407_1.time_ <= var_410_9 + arg_410_0 then
				arg_407_1.var_.moveOldPos1083 = var_410_8.localPosition
				var_410_8.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("1083", 3)

				local var_410_10 = var_410_8.childCount

				for iter_410_4 = 0, var_410_10 - 1 do
					local var_410_11 = var_410_8:GetChild(iter_410_4)

					if var_410_11.name == "split_7" or not string.find(var_410_11.name, "split") then
						var_410_11.gameObject:SetActive(true)
					else
						var_410_11.gameObject:SetActive(false)
					end
				end
			end

			local var_410_12 = 0.001

			if var_410_9 <= arg_407_1.time_ and arg_407_1.time_ < var_410_9 + var_410_12 then
				local var_410_13 = (arg_407_1.time_ - var_410_9) / var_410_12
				local var_410_14 = Vector3.New(-50, -345, -345)

				var_410_8.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1083, var_410_14, var_410_13)
			end

			if arg_407_1.time_ >= var_410_9 + var_410_12 and arg_407_1.time_ < var_410_9 + var_410_12 + arg_410_0 then
				var_410_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_410_15 = 0
			local var_410_16 = 0.65

			if var_410_15 < arg_407_1.time_ and arg_407_1.time_ <= var_410_15 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_17 = arg_407_1:FormatText(StoryNameCfg[1332].name)

				arg_407_1.leftNameTxt_.text = var_410_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_18 = arg_407_1:GetWordFromCfg(423121098)
				local var_410_19 = arg_407_1:FormatText(var_410_18.content)

				arg_407_1.text_.text = var_410_19

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_20 = 26
				local var_410_21 = utf8.len(var_410_19)
				local var_410_22 = var_410_20 <= 0 and var_410_16 or var_410_16 * (var_410_21 / var_410_20)

				if var_410_22 > 0 and var_410_16 < var_410_22 then
					arg_407_1.talkMaxDuration = var_410_22

					if var_410_22 + var_410_15 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_22 + var_410_15
					end
				end

				arg_407_1.text_.text = var_410_19
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121098", "story_v_out_423121.awb") ~= 0 then
					local var_410_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121098", "story_v_out_423121.awb") / 1000

					if var_410_23 + var_410_15 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_23 + var_410_15
					end

					if var_410_18.prefab_name ~= "" and arg_407_1.actors_[var_410_18.prefab_name] ~= nil then
						local var_410_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_18.prefab_name].transform, "story_v_out_423121", "423121098", "story_v_out_423121.awb")

						arg_407_1:RecordAudio("423121098", var_410_24)
						arg_407_1:RecordAudio("423121098", var_410_24)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_423121", "423121098", "story_v_out_423121.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_423121", "423121098", "story_v_out_423121.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_25 = math.max(var_410_16, arg_407_1.talkMaxDuration)

			if var_410_15 <= arg_407_1.time_ and arg_407_1.time_ < var_410_15 + var_410_25 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_15) / var_410_25

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_15 + var_410_25 and arg_407_1.time_ < var_410_15 + var_410_25 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_407_1:InitPlayNodeList()
	end,
	Play423121099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 423121099
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play423121100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1083"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.actorSpriteComps1083 == nil then
				arg_411_1.var_.actorSpriteComps1083 = var_414_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_2 = 0.2

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 and not isNil(var_414_0) then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.actorSpriteComps1083 then
					for iter_414_0, iter_414_1 in pairs(arg_411_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_414_1 then
							if arg_411_1.isInRecall_ then
								local var_414_4 = Mathf.Lerp(iter_414_1.color.r, arg_411_1.hightColor2.r, var_414_3)
								local var_414_5 = Mathf.Lerp(iter_414_1.color.g, arg_411_1.hightColor2.g, var_414_3)
								local var_414_6 = Mathf.Lerp(iter_414_1.color.b, arg_411_1.hightColor2.b, var_414_3)

								iter_414_1.color = Color.New(var_414_4, var_414_5, var_414_6)
							else
								local var_414_7 = Mathf.Lerp(iter_414_1.color.r, 0.5, var_414_3)

								iter_414_1.color = Color.New(var_414_7, var_414_7, var_414_7)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.actorSpriteComps1083 then
				for iter_414_2, iter_414_3 in pairs(arg_411_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_414_3 then
						if arg_411_1.isInRecall_ then
							iter_414_3.color = arg_411_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_414_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_411_1.var_.actorSpriteComps1083 = nil
			end

			local var_414_8 = 0
			local var_414_9 = 0.7

			if var_414_8 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_10 = arg_411_1:FormatText(StoryNameCfg[7].name)

				arg_411_1.leftNameTxt_.text = var_414_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_11 = arg_411_1:GetWordFromCfg(423121099)
				local var_414_12 = arg_411_1:FormatText(var_414_11.content)

				arg_411_1.text_.text = var_414_12

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_13 = 28
				local var_414_14 = utf8.len(var_414_12)
				local var_414_15 = var_414_13 <= 0 and var_414_9 or var_414_9 * (var_414_14 / var_414_13)

				if var_414_15 > 0 and var_414_9 < var_414_15 then
					arg_411_1.talkMaxDuration = var_414_15

					if var_414_15 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_15 + var_414_8
					end
				end

				arg_411_1.text_.text = var_414_12
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_16 = math.max(var_414_9, arg_411_1.talkMaxDuration)

			if var_414_8 <= arg_411_1.time_ and arg_411_1.time_ < var_414_8 + var_414_16 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_8) / var_414_16

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_8 + var_414_16 and arg_411_1.time_ < var_414_8 + var_414_16 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play423121100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 423121100
		arg_415_1.duration_ = 8

		local var_415_0 = {
			zh = 6.466,
			ja = 8
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play423121101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["1083"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.actorSpriteComps1083 == nil then
				arg_415_1.var_.actorSpriteComps1083 = var_418_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_2 = 0.2

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 and not isNil(var_418_0) then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2

				if arg_415_1.var_.actorSpriteComps1083 then
					for iter_418_0, iter_418_1 in pairs(arg_415_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_418_1 then
							if arg_415_1.isInRecall_ then
								local var_418_4 = Mathf.Lerp(iter_418_1.color.r, arg_415_1.hightColor1.r, var_418_3)
								local var_418_5 = Mathf.Lerp(iter_418_1.color.g, arg_415_1.hightColor1.g, var_418_3)
								local var_418_6 = Mathf.Lerp(iter_418_1.color.b, arg_415_1.hightColor1.b, var_418_3)

								iter_418_1.color = Color.New(var_418_4, var_418_5, var_418_6)
							else
								local var_418_7 = Mathf.Lerp(iter_418_1.color.r, 1, var_418_3)

								iter_418_1.color = Color.New(var_418_7, var_418_7, var_418_7)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.actorSpriteComps1083 then
				for iter_418_2, iter_418_3 in pairs(arg_415_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_418_3 then
						if arg_415_1.isInRecall_ then
							iter_418_3.color = arg_415_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_418_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_415_1.var_.actorSpriteComps1083 = nil
			end

			local var_418_8 = arg_415_1.actors_["1083"].transform
			local var_418_9 = 0

			if var_418_9 < arg_415_1.time_ and arg_415_1.time_ <= var_418_9 + arg_418_0 then
				arg_415_1.var_.moveOldPos1083 = var_418_8.localPosition
				var_418_8.localScale = Vector3.New(1, 1, 1)

				arg_415_1:CheckSpriteTmpPos("1083", 3)

				local var_418_10 = var_418_8.childCount

				for iter_418_4 = 0, var_418_10 - 1 do
					local var_418_11 = var_418_8:GetChild(iter_418_4)

					if var_418_11.name == "" or not string.find(var_418_11.name, "split") then
						var_418_11.gameObject:SetActive(true)
					else
						var_418_11.gameObject:SetActive(false)
					end
				end
			end

			local var_418_12 = 0.001

			if var_418_9 <= arg_415_1.time_ and arg_415_1.time_ < var_418_9 + var_418_12 then
				local var_418_13 = (arg_415_1.time_ - var_418_9) / var_418_12
				local var_418_14 = Vector3.New(-50, -345, -345)

				var_418_8.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1083, var_418_14, var_418_13)
			end

			if arg_415_1.time_ >= var_418_9 + var_418_12 and arg_415_1.time_ < var_418_9 + var_418_12 + arg_418_0 then
				var_418_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_418_15 = 0
			local var_418_16 = 0.55

			if var_418_15 < arg_415_1.time_ and arg_415_1.time_ <= var_418_15 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_17 = arg_415_1:FormatText(StoryNameCfg[1332].name)

				arg_415_1.leftNameTxt_.text = var_418_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_18 = arg_415_1:GetWordFromCfg(423121100)
				local var_418_19 = arg_415_1:FormatText(var_418_18.content)

				arg_415_1.text_.text = var_418_19

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_20 = 22
				local var_418_21 = utf8.len(var_418_19)
				local var_418_22 = var_418_20 <= 0 and var_418_16 or var_418_16 * (var_418_21 / var_418_20)

				if var_418_22 > 0 and var_418_16 < var_418_22 then
					arg_415_1.talkMaxDuration = var_418_22

					if var_418_22 + var_418_15 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_22 + var_418_15
					end
				end

				arg_415_1.text_.text = var_418_19
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423121", "423121100", "story_v_out_423121.awb") ~= 0 then
					local var_418_23 = manager.audio:GetVoiceLength("story_v_out_423121", "423121100", "story_v_out_423121.awb") / 1000

					if var_418_23 + var_418_15 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_23 + var_418_15
					end

					if var_418_18.prefab_name ~= "" and arg_415_1.actors_[var_418_18.prefab_name] ~= nil then
						local var_418_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_18.prefab_name].transform, "story_v_out_423121", "423121100", "story_v_out_423121.awb")

						arg_415_1:RecordAudio("423121100", var_418_24)
						arg_415_1:RecordAudio("423121100", var_418_24)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_423121", "423121100", "story_v_out_423121.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_423121", "423121100", "story_v_out_423121.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_25 = math.max(var_418_16, arg_415_1.talkMaxDuration)

			if var_418_15 <= arg_415_1.time_ and arg_415_1.time_ < var_418_15 + var_418_25 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_15) / var_418_25

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_15 + var_418_25 and arg_415_1.time_ < var_418_15 + var_418_25 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play423121101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 423121101
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play423121102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = arg_419_1.actors_["1083"]
			local var_422_1 = 0

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.actorSpriteComps1083 == nil then
				arg_419_1.var_.actorSpriteComps1083 = var_422_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_422_2 = 0.2

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 and not isNil(var_422_0) then
				local var_422_3 = (arg_419_1.time_ - var_422_1) / var_422_2

				if arg_419_1.var_.actorSpriteComps1083 then
					for iter_422_0, iter_422_1 in pairs(arg_419_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_422_1 then
							if arg_419_1.isInRecall_ then
								local var_422_4 = Mathf.Lerp(iter_422_1.color.r, arg_419_1.hightColor2.r, var_422_3)
								local var_422_5 = Mathf.Lerp(iter_422_1.color.g, arg_419_1.hightColor2.g, var_422_3)
								local var_422_6 = Mathf.Lerp(iter_422_1.color.b, arg_419_1.hightColor2.b, var_422_3)

								iter_422_1.color = Color.New(var_422_4, var_422_5, var_422_6)
							else
								local var_422_7 = Mathf.Lerp(iter_422_1.color.r, 0.5, var_422_3)

								iter_422_1.color = Color.New(var_422_7, var_422_7, var_422_7)
							end
						end
					end
				end
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 and not isNil(var_422_0) and arg_419_1.var_.actorSpriteComps1083 then
				for iter_422_2, iter_422_3 in pairs(arg_419_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_422_3 then
						if arg_419_1.isInRecall_ then
							iter_422_3.color = arg_419_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_422_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_419_1.var_.actorSpriteComps1083 = nil
			end

			local var_422_8 = 0
			local var_422_9 = 0.575

			if var_422_8 < arg_419_1.time_ and arg_419_1.time_ <= var_422_8 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_10 = arg_419_1:FormatText(StoryNameCfg[7].name)

				arg_419_1.leftNameTxt_.text = var_422_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_11 = arg_419_1:GetWordFromCfg(423121101)
				local var_422_12 = arg_419_1:FormatText(var_422_11.content)

				arg_419_1.text_.text = var_422_12

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_13 = 23
				local var_422_14 = utf8.len(var_422_12)
				local var_422_15 = var_422_13 <= 0 and var_422_9 or var_422_9 * (var_422_14 / var_422_13)

				if var_422_15 > 0 and var_422_9 < var_422_15 then
					arg_419_1.talkMaxDuration = var_422_15

					if var_422_15 + var_422_8 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_15 + var_422_8
					end
				end

				arg_419_1.text_.text = var_422_12
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_16 = math.max(var_422_9, arg_419_1.talkMaxDuration)

			if var_422_8 <= arg_419_1.time_ and arg_419_1.time_ < var_422_8 + var_422_16 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_8) / var_422_16

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_8 + var_422_16 and arg_419_1.time_ < var_422_8 + var_422_16 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play423121102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 423121102
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play423121103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1083"].transform
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
				arg_423_1.var_.moveOldPos1083 = var_426_0.localPosition
				var_426_0.localScale = Vector3.New(1, 1, 1)

				arg_423_1:CheckSpriteTmpPos("1083", 7)

				local var_426_2 = var_426_0.childCount

				for iter_426_0 = 0, var_426_2 - 1 do
					local var_426_3 = var_426_0:GetChild(iter_426_0)

					if var_426_3.name == "" or not string.find(var_426_3.name, "split") then
						var_426_3.gameObject:SetActive(true)
					else
						var_426_3.gameObject:SetActive(false)
					end
				end
			end

			local var_426_4 = 0.001

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_4 then
				local var_426_5 = (arg_423_1.time_ - var_426_1) / var_426_4
				local var_426_6 = Vector3.New(0, -2000, 0)

				var_426_0.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1083, var_426_6, var_426_5)
			end

			if arg_423_1.time_ >= var_426_1 + var_426_4 and arg_423_1.time_ < var_426_1 + var_426_4 + arg_426_0 then
				var_426_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_426_7 = 1
			local var_426_8 = 1

			if var_426_7 < arg_423_1.time_ and arg_423_1.time_ <= var_426_7 + arg_426_0 then
				local var_426_9 = "play"
				local var_426_10 = "effect"

				arg_423_1:AudioAction(var_426_9, var_426_10, "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_426_11 = 0
			local var_426_12 = 1.05

			if var_426_11 < arg_423_1.time_ and arg_423_1.time_ <= var_426_11 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_13 = arg_423_1:GetWordFromCfg(423121102)
				local var_426_14 = arg_423_1:FormatText(var_426_13.content)

				arg_423_1.text_.text = var_426_14

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_15 = 42
				local var_426_16 = utf8.len(var_426_14)
				local var_426_17 = var_426_15 <= 0 and var_426_12 or var_426_12 * (var_426_16 / var_426_15)

				if var_426_17 > 0 and var_426_12 < var_426_17 then
					arg_423_1.talkMaxDuration = var_426_17

					if var_426_17 + var_426_11 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_17 + var_426_11
					end
				end

				arg_423_1.text_.text = var_426_14
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_18 = math.max(var_426_12, arg_423_1.talkMaxDuration)

			if var_426_11 <= arg_423_1.time_ and arg_423_1.time_ < var_426_11 + var_426_18 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_11) / var_426_18

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_11 + var_426_18 and arg_423_1.time_ < var_426_11 + var_426_18 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play423121103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 423121103
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
			arg_427_1.auto_ = false
		end

		function arg_427_1.playNext_(arg_429_0)
			arg_427_1.onStoryFinished_()
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 0.625

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_2 = arg_427_1:FormatText(StoryNameCfg[7].name)

				arg_427_1.leftNameTxt_.text = var_430_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_3 = arg_427_1:GetWordFromCfg(423121103)
				local var_430_4 = arg_427_1:FormatText(var_430_3.content)

				arg_427_1.text_.text = var_430_4

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_5 = 25
				local var_430_6 = utf8.len(var_430_4)
				local var_430_7 = var_430_5 <= 0 and var_430_1 or var_430_1 * (var_430_6 / var_430_5)

				if var_430_7 > 0 and var_430_1 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_4
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_8 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_8 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_8

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_8 and arg_427_1.time_ < var_430_0 + var_430_8 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0112a",
		"TextureConfig/Background/ST0112"
	},
	voices = {
		"story_v_out_423121.awb"
	}
}
