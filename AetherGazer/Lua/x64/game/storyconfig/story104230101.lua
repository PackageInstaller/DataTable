return {
	Play423011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423011001
		arg_1_1.duration_ = 8.63

		local var_1_0 = {
			zh = 7.2,
			ja = 8.633
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
				arg_1_0:Play423011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I25g"

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
				local var_4_5 = arg_1_1.bgs_.I25g

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
					if iter_4_0 ~= "I25g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

			local var_4_24 = manager.ui.mainCamera.transform
			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = arg_1_1.var_.effectfengsha1
				local var_4_27
				local var_4_28 = var_4_24

				if not var_4_26 then
					var_4_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), var_4_28)
					var_4_26.name = "fengsha1"
					arg_1_1.var_.effectfengsha1 = var_4_26
				else
					var_4_26.transform:SetParent(var_4_28)
				end

				var_4_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_26.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_29 = 0.166666666666667
			local var_4_30 = 1

			if var_4_29 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				local var_4_31 = "play"
				local var_4_32 = "effect"

				arg_1_1:AudioAction(var_4_31, var_4_32, "se_story_144", "se_story_144_amb_town_loop", "")
			end

			local var_4_33 = 0
			local var_4_34 = 0.3

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "music"

				arg_1_1:AudioAction(var_4_35, var_4_36, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_37 = ""
				local var_4_38 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_38 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_38 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_38

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_38
						arg_1_1.bgmTxt2_.text = var_4_38
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

			local var_4_39 = 0.500666666666667
			local var_4_40 = 1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_41 = "play"
				local var_4_42 = "music"

				arg_1_1:AudioAction(var_4_41, var_4_42, "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street.awb")

				local var_4_43 = ""
				local var_4_44 = manager.audio:GetAudioName("bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street")

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

			local var_4_45 = 1.16666666666667
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "effect"

				arg_1_1:AudioAction(var_4_47, var_4_48, "se_story_144", "se_story_144_crack", "")
			end

			local var_4_49 = manager.ui.mainCamera.transform
			local var_4_50 = 0

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_51 = arg_1_1.var_.effecthuaijiudianying1
				local var_4_52
				local var_4_53 = var_4_49

				if not var_4_51 then
					var_4_51 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xuehuaping"), var_4_53)
					var_4_51.name = "huaijiudianying1"
					arg_1_1.var_.effecthuaijiudianying1 = var_4_51
				else
					var_4_51.transform:SetParent(var_4_53)
				end

				var_4_51.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_51.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_54 = 0

			arg_1_1.isInRecall_ = true

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_1_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_1_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_4_2, iter_4_3 in pairs(arg_1_1.actors_) do
					local var_4_55 = iter_4_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_4_4, iter_4_5 in ipairs(var_4_55) do
						if iter_4_5.color.r > 0.51 then
							iter_4_5.color = Color.New(0.82, 0.77, 0.62)
						else
							iter_4_5.color = Color.New(0.46, 0.43, 0.35)
						end
					end
				end
			end

			local var_4_56 = 0.1

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_56 then
				local var_4_57 = (arg_1_1.time_ - var_4_54) / var_4_56

				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_4_57)
			end

			if arg_1_1.time_ >= var_4_54 + var_4_56 and arg_1_1.time_ < var_4_54 + var_4_56 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_58 = 2
			local var_4_59 = 0.675

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_60 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_60:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_61 = arg_1_1:FormatText(StoryNameCfg[36].name)

				arg_1_1.leftNameTxt_.text = var_4_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10148_split_3")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_1_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_4_62 = arg_1_1:GetWordFromCfg(423011001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 27
				local var_4_65 = utf8.len(var_4_63)
				local var_4_66 = var_4_64 <= 0 and var_4_59 or var_4_59 * (var_4_65 / var_4_64)

				if var_4_66 > 0 and var_4_59 < var_4_66 then
					arg_1_1.talkMaxDuration = var_4_66
					var_4_58 = var_4_58 + 0.3

					if var_4_66 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_58
					end
				end

				arg_1_1.text_.text = var_4_63
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011001", "story_v_out_423011.awb") ~= 0 then
					local var_4_67 = manager.audio:GetVoiceLength("story_v_out_423011", "423011001", "story_v_out_423011.awb") / 1000

					if var_4_67 + var_4_58 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_58
					end

					if var_4_62.prefab_name ~= "" and arg_1_1.actors_[var_4_62.prefab_name] ~= nil then
						local var_4_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_62.prefab_name].transform, "story_v_out_423011", "423011001", "story_v_out_423011.awb")

						arg_1_1:RecordAudio("423011001", var_4_68)
						arg_1_1:RecordAudio("423011001", var_4_68)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423011", "423011001", "story_v_out_423011.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423011", "423011001", "story_v_out_423011.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_69 = var_4_58 + 0.3
			local var_4_70 = math.max(var_4_59, arg_1_1.talkMaxDuration)

			if var_4_69 <= arg_1_1.time_ and arg_1_1.time_ < var_4_69 + var_4_70 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_69) / var_4_70

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_69 + var_4_70 and arg_1_1.time_ < var_4_69 + var_4_70 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play423011002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423011002
		arg_9_1.duration_ = 6

		local var_9_0 = {
			zh = 4,
			ja = 6
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
				arg_9_0:Play423011003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 0.425

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_2 = arg_9_1:FormatText(StoryNameCfg[36].name)

				arg_9_1.leftNameTxt_.text = var_12_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10148_split_6")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(0.82, 0.77, 0.62)
				arg_9_1.icon_.color = Color.New(0.82, 0.77, 0.62)

				local var_12_3 = arg_9_1:GetWordFromCfg(423011002)
				local var_12_4 = arg_9_1:FormatText(var_12_3.content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 17
				local var_12_6 = utf8.len(var_12_4)
				local var_12_7 = var_12_5 <= 0 and var_12_1 or var_12_1 * (var_12_6 / var_12_5)

				if var_12_7 > 0 and var_12_1 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011002", "story_v_out_423011.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011002", "story_v_out_423011.awb") / 1000

					if var_12_8 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_0
					end

					if var_12_3.prefab_name ~= "" and arg_9_1.actors_[var_12_3.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_3.prefab_name].transform, "story_v_out_423011", "423011002", "story_v_out_423011.awb")

						arg_9_1:RecordAudio("423011002", var_12_9)
						arg_9_1:RecordAudio("423011002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_423011", "423011002", "story_v_out_423011.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_423011", "423011002", "story_v_out_423011.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_10 and arg_9_1.time_ < var_12_0 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play423011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423011003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play423011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = manager.ui.mainCamera.transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.shakeOldPos = var_16_0.localPosition
			end

			local var_16_2 = 0.6

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / 0.066
				local var_16_4, var_16_5 = math.modf(var_16_3)

				var_16_0.localPosition = Vector3.New(var_16_5 * 0.13, var_16_5 * 0.13, var_16_5 * 0.13) + arg_13_1.var_.shakeOldPos
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = arg_13_1.var_.shakeOldPos
			end

			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.allBtn_.enabled = false
			end

			local var_16_7 = 0.6

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				arg_13_1.allBtn_.enabled = true
			end

			local var_16_8 = 0.166666666666667
			local var_16_9 = 1

			if var_16_8 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				local var_16_10 = "play"
				local var_16_11 = "effect"

				arg_13_1:AudioAction(var_16_10, var_16_11, "se_story_144", "se_story_144_doorhit", "")
			end

			local var_16_12 = 0
			local var_16_13 = 1.425

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_14 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_14:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_15 = arg_13_1:GetWordFromCfg(423011003)
				local var_16_16 = arg_13_1:FormatText(var_16_15.content)

				arg_13_1.text_.text = var_16_16

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 57
				local var_16_18 = utf8.len(var_16_16)
				local var_16_19 = var_16_17 <= 0 and var_16_13 or var_16_13 * (var_16_18 / var_16_17)

				if var_16_19 > 0 and var_16_13 < var_16_19 then
					arg_13_1.talkMaxDuration = var_16_19
					var_16_12 = var_16_12 + 0.3

					if var_16_19 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_16
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_20 = var_16_12 + 0.3
			local var_16_21 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_21 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_20) / var_16_21

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_20 + var_16_21 and arg_13_1.time_ < var_16_20 + var_16_21 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play423011004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 423011004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play423011005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0
			local var_22_1 = 1

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				local var_22_2 = "play"
				local var_22_3 = "effect"

				arg_19_1:AudioAction(var_22_2, var_22_3, "se_story_144", "se_story_144_amb_town_wind_loop", "")
			end

			local var_22_4 = 0
			local var_22_5 = 1.25

			if var_22_4 < arg_19_1.time_ and arg_19_1.time_ <= var_22_4 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_6 = arg_19_1:GetWordFromCfg(423011004)
				local var_22_7 = arg_19_1:FormatText(var_22_6.content)

				arg_19_1.text_.text = var_22_7

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_8 = 50
				local var_22_9 = utf8.len(var_22_7)
				local var_22_10 = var_22_8 <= 0 and var_22_5 or var_22_5 * (var_22_9 / var_22_8)

				if var_22_10 > 0 and var_22_5 < var_22_10 then
					arg_19_1.talkMaxDuration = var_22_10

					if var_22_10 + var_22_4 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_10 + var_22_4
					end
				end

				arg_19_1.text_.text = var_22_7
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_11 = math.max(var_22_5, arg_19_1.talkMaxDuration)

			if var_22_4 <= arg_19_1.time_ and arg_19_1.time_ < var_22_4 + var_22_11 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_4) / var_22_11

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_4 + var_22_11 and arg_19_1.time_ < var_22_4 + var_22_11 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play423011005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 423011005
		arg_23_1.duration_ = 3.7

		local var_23_0 = {
			zh = 3,
			ja = 3.7
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play423011006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = "1083"

			if arg_23_1.actors_[var_26_0] == nil then
				local var_26_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_26_1) then
					local var_26_2 = Object.Instantiate(var_26_1, arg_23_1.canvasGo_.transform)

					var_26_2.transform:SetSiblingIndex(1)

					var_26_2.name = var_26_0
					var_26_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_23_1.actors_[var_26_0] = var_26_2

					local var_26_3 = var_26_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_23_1.isInRecall_ then
						for iter_26_0, iter_26_1 in ipairs(var_26_3) do
							iter_26_1.color = arg_23_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_26_4 = arg_23_1.actors_["1083"]
			local var_26_5 = 0

			if var_26_5 < arg_23_1.time_ and arg_23_1.time_ <= var_26_5 + arg_26_0 and not isNil(var_26_4) and arg_23_1.var_.actorSpriteComps1083 == nil then
				arg_23_1.var_.actorSpriteComps1083 = var_26_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_6 = 0.2

			if var_26_5 <= arg_23_1.time_ and arg_23_1.time_ < var_26_5 + var_26_6 and not isNil(var_26_4) then
				local var_26_7 = (arg_23_1.time_ - var_26_5) / var_26_6

				if arg_23_1.var_.actorSpriteComps1083 then
					for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_26_3 then
							if arg_23_1.isInRecall_ then
								local var_26_8 = Mathf.Lerp(iter_26_3.color.r, arg_23_1.hightColor1.r, var_26_7)
								local var_26_9 = Mathf.Lerp(iter_26_3.color.g, arg_23_1.hightColor1.g, var_26_7)
								local var_26_10 = Mathf.Lerp(iter_26_3.color.b, arg_23_1.hightColor1.b, var_26_7)

								iter_26_3.color = Color.New(var_26_8, var_26_9, var_26_10)
							else
								local var_26_11 = Mathf.Lerp(iter_26_3.color.r, 1, var_26_7)

								iter_26_3.color = Color.New(var_26_11, var_26_11, var_26_11)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= var_26_5 + var_26_6 and arg_23_1.time_ < var_26_5 + var_26_6 + arg_26_0 and not isNil(var_26_4) and arg_23_1.var_.actorSpriteComps1083 then
				for iter_26_4, iter_26_5 in pairs(arg_23_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_26_5 then
						if arg_23_1.isInRecall_ then
							iter_26_5.color = arg_23_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_26_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_23_1.var_.actorSpriteComps1083 = nil
			end

			local var_26_12 = arg_23_1.actors_["1083"].transform
			local var_26_13 = 0

			if var_26_13 < arg_23_1.time_ and arg_23_1.time_ <= var_26_13 + arg_26_0 then
				arg_23_1.var_.moveOldPos1083 = var_26_12.localPosition
				var_26_12.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("1083", 3)

				local var_26_14 = var_26_12.childCount

				for iter_26_6 = 0, var_26_14 - 1 do
					local var_26_15 = var_26_12:GetChild(iter_26_6)

					if var_26_15.name == "" or not string.find(var_26_15.name, "split") then
						var_26_15.gameObject:SetActive(true)
					else
						var_26_15.gameObject:SetActive(false)
					end
				end
			end

			local var_26_16 = 0.001

			if var_26_13 <= arg_23_1.time_ and arg_23_1.time_ < var_26_13 + var_26_16 then
				local var_26_17 = (arg_23_1.time_ - var_26_13) / var_26_16
				local var_26_18 = Vector3.New(-50, -345, -345)

				var_26_12.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1083, var_26_18, var_26_17)
			end

			if arg_23_1.time_ >= var_26_13 + var_26_16 and arg_23_1.time_ < var_26_13 + var_26_16 + arg_26_0 then
				var_26_12.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_26_19 = arg_23_1.actors_["1083"]
			local var_26_20 = 0

			if var_26_20 < arg_23_1.time_ and arg_23_1.time_ <= var_26_20 + arg_26_0 then
				local var_26_21 = var_26_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_26_21 then
					arg_23_1.var_.alphaOldValue1083 = var_26_21.alpha
					arg_23_1.var_.characterEffect1083 = var_26_21
				end

				arg_23_1.var_.alphaOldValue1083 = 0
			end

			local var_26_22 = 0.5

			if var_26_20 <= arg_23_1.time_ and arg_23_1.time_ < var_26_20 + var_26_22 then
				local var_26_23 = (arg_23_1.time_ - var_26_20) / var_26_22
				local var_26_24 = Mathf.Lerp(arg_23_1.var_.alphaOldValue1083, 1, var_26_23)

				if arg_23_1.var_.characterEffect1083 then
					arg_23_1.var_.characterEffect1083.alpha = var_26_24
				end
			end

			if arg_23_1.time_ >= var_26_20 + var_26_22 and arg_23_1.time_ < var_26_20 + var_26_22 + arg_26_0 and arg_23_1.var_.characterEffect1083 then
				arg_23_1.var_.characterEffect1083.alpha = 1
			end

			local var_26_25 = 0
			local var_26_26 = 1

			if var_26_25 < arg_23_1.time_ and arg_23_1.time_ <= var_26_25 + arg_26_0 then
				local var_26_27 = "play"
				local var_26_28 = "effect"

				arg_23_1:AudioAction(var_26_27, var_26_28, "se_story_144", "se_story_144_footstep_cowboy", "")
			end

			local var_26_29 = 0
			local var_26_30 = 0.2

			if var_26_29 < arg_23_1.time_ and arg_23_1.time_ <= var_26_29 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_31 = arg_23_1:FormatText(StoryNameCfg[1325].name)

				arg_23_1.leftNameTxt_.text = var_26_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_32 = arg_23_1:GetWordFromCfg(423011005)
				local var_26_33 = arg_23_1:FormatText(var_26_32.content)

				arg_23_1.text_.text = var_26_33

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_34 = 8
				local var_26_35 = utf8.len(var_26_33)
				local var_26_36 = var_26_34 <= 0 and var_26_30 or var_26_30 * (var_26_35 / var_26_34)

				if var_26_36 > 0 and var_26_30 < var_26_36 then
					arg_23_1.talkMaxDuration = var_26_36

					if var_26_36 + var_26_29 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_36 + var_26_29
					end
				end

				arg_23_1.text_.text = var_26_33
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011005", "story_v_out_423011.awb") ~= 0 then
					local var_26_37 = manager.audio:GetVoiceLength("story_v_out_423011", "423011005", "story_v_out_423011.awb") / 1000

					if var_26_37 + var_26_29 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_37 + var_26_29
					end

					if var_26_32.prefab_name ~= "" and arg_23_1.actors_[var_26_32.prefab_name] ~= nil then
						local var_26_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_32.prefab_name].transform, "story_v_out_423011", "423011005", "story_v_out_423011.awb")

						arg_23_1:RecordAudio("423011005", var_26_38)
						arg_23_1:RecordAudio("423011005", var_26_38)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_423011", "423011005", "story_v_out_423011.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_423011", "423011005", "story_v_out_423011.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_39 = math.max(var_26_30, arg_23_1.talkMaxDuration)

			if var_26_29 <= arg_23_1.time_ and arg_23_1.time_ < var_26_29 + var_26_39 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_29) / var_26_39

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_29 + var_26_39 and arg_23_1.time_ < var_26_29 + var_26_39 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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

		arg_23_1:InitPlayNodeList()
	end,
	Play423011006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 423011006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play423011007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1083"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps1083 == nil then
				arg_27_1.var_.actorSpriteComps1083 = var_30_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_2 = 0.2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.actorSpriteComps1083 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								local var_30_4 = Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor2.r, var_30_3)
								local var_30_5 = Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor2.g, var_30_3)
								local var_30_6 = Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor2.b, var_30_3)

								iter_30_1.color = Color.New(var_30_4, var_30_5, var_30_6)
							else
								local var_30_7 = Mathf.Lerp(iter_30_1.color.r, 0.5, var_30_3)

								iter_30_1.color = Color.New(var_30_7, var_30_7, var_30_7)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps1083 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_30_3 then
						if arg_27_1.isInRecall_ then
							iter_30_3.color = arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_30_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_27_1.var_.actorSpriteComps1083 = nil
			end

			local var_30_8 = arg_27_1.actors_["1083"].transform
			local var_30_9 = 0.6

			if var_30_9 < arg_27_1.time_ and arg_27_1.time_ <= var_30_9 + arg_30_0 then
				arg_27_1.var_.moveOldPos1083 = var_30_8.localPosition
				var_30_8.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("1083", 7)

				local var_30_10 = var_30_8.childCount

				for iter_30_4 = 0, var_30_10 - 1 do
					local var_30_11 = var_30_8:GetChild(iter_30_4)

					if var_30_11.name == "" or not string.find(var_30_11.name, "split") then
						var_30_11.gameObject:SetActive(true)
					else
						var_30_11.gameObject:SetActive(false)
					end
				end
			end

			local var_30_12 = 0.001

			if var_30_9 <= arg_27_1.time_ and arg_27_1.time_ < var_30_9 + var_30_12 then
				local var_30_13 = (arg_27_1.time_ - var_30_9) / var_30_12
				local var_30_14 = Vector3.New(0, -2000, 0)

				var_30_8.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1083, var_30_14, var_30_13)
			end

			if arg_27_1.time_ >= var_30_9 + var_30_12 and arg_27_1.time_ < var_30_9 + var_30_12 + arg_30_0 then
				var_30_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_30_15 = arg_27_1.actors_["1083"]
			local var_30_16 = 0

			if var_30_16 < arg_27_1.time_ and arg_27_1.time_ <= var_30_16 + arg_30_0 then
				local var_30_17 = var_30_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_30_17 then
					arg_27_1.var_.alphaOldValue1083 = var_30_17.alpha
					arg_27_1.var_.characterEffect1083 = var_30_17
				end

				arg_27_1.var_.alphaOldValue1083 = 1
			end

			local var_30_18 = 0.5

			if var_30_16 <= arg_27_1.time_ and arg_27_1.time_ < var_30_16 + var_30_18 then
				local var_30_19 = (arg_27_1.time_ - var_30_16) / var_30_18
				local var_30_20 = Mathf.Lerp(arg_27_1.var_.alphaOldValue1083, 0, var_30_19)

				if arg_27_1.var_.characterEffect1083 then
					arg_27_1.var_.characterEffect1083.alpha = var_30_20
				end
			end

			if arg_27_1.time_ >= var_30_16 + var_30_18 and arg_27_1.time_ < var_30_16 + var_30_18 + arg_30_0 and arg_27_1.var_.characterEffect1083 then
				arg_27_1.var_.characterEffect1083.alpha = 0
			end

			local var_30_21 = arg_27_1.actors_["1083"]
			local var_30_22 = 0.634

			if var_30_22 < arg_27_1.time_ and arg_27_1.time_ <= var_30_22 + arg_30_0 then
				local var_30_23 = var_30_21:GetComponentInChildren(typeof(CanvasGroup))

				if var_30_23 then
					arg_27_1.var_.alphaOldValue1083 = var_30_23.alpha
					arg_27_1.var_.characterEffect1083 = var_30_23
				end

				arg_27_1.var_.alphaOldValue1083 = 0
			end

			local var_30_24 = 0.0333333333333333

			if var_30_22 <= arg_27_1.time_ and arg_27_1.time_ < var_30_22 + var_30_24 then
				local var_30_25 = (arg_27_1.time_ - var_30_22) / var_30_24
				local var_30_26 = Mathf.Lerp(arg_27_1.var_.alphaOldValue1083, 1, var_30_25)

				if arg_27_1.var_.characterEffect1083 then
					arg_27_1.var_.characterEffect1083.alpha = var_30_26
				end
			end

			if arg_27_1.time_ >= var_30_22 + var_30_24 and arg_27_1.time_ < var_30_22 + var_30_24 + arg_30_0 and arg_27_1.var_.characterEffect1083 then
				arg_27_1.var_.characterEffect1083.alpha = 1
			end

			local var_30_27 = 0
			local var_30_28 = 1.2

			if var_30_27 < arg_27_1.time_ and arg_27_1.time_ <= var_30_27 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_29 = arg_27_1:GetWordFromCfg(423011006)
				local var_30_30 = arg_27_1:FormatText(var_30_29.content)

				arg_27_1.text_.text = var_30_30

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_31 = 48
				local var_30_32 = utf8.len(var_30_30)
				local var_30_33 = var_30_31 <= 0 and var_30_28 or var_30_28 * (var_30_32 / var_30_31)

				if var_30_33 > 0 and var_30_28 < var_30_33 then
					arg_27_1.talkMaxDuration = var_30_33

					if var_30_33 + var_30_27 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_33 + var_30_27
					end
				end

				arg_27_1.text_.text = var_30_30
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_34 = math.max(var_30_28, arg_27_1.talkMaxDuration)

			if var_30_27 <= arg_27_1.time_ and arg_27_1.time_ < var_30_27 + var_30_34 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_27) / var_30_34

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_27 + var_30_34 and arg_27_1.time_ < var_30_27 + var_30_34 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play423011007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 423011007
		arg_31_1.duration_ = 3.47

		local var_31_0 = {
			zh = 2.266,
			ja = 3.466
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play423011008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = "10148"

			if arg_31_1.actors_[var_34_0] == nil then
				local var_34_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

				if not isNil(var_34_1) then
					local var_34_2 = Object.Instantiate(var_34_1, arg_31_1.canvasGo_.transform)

					var_34_2.transform:SetSiblingIndex(1)

					var_34_2.name = var_34_0
					var_34_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_31_1.actors_[var_34_0] = var_34_2

					local var_34_3 = var_34_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_31_1.isInRecall_ then
						for iter_34_0, iter_34_1 in ipairs(var_34_3) do
							iter_34_1.color = arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_34_4 = arg_31_1.actors_["10148"]
			local var_34_5 = 0

			if var_34_5 < arg_31_1.time_ and arg_31_1.time_ <= var_34_5 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.actorSpriteComps10148 == nil then
				arg_31_1.var_.actorSpriteComps10148 = var_34_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_6 = 0.2

			if var_34_5 <= arg_31_1.time_ and arg_31_1.time_ < var_34_5 + var_34_6 and not isNil(var_34_4) then
				local var_34_7 = (arg_31_1.time_ - var_34_5) / var_34_6

				if arg_31_1.var_.actorSpriteComps10148 then
					for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_34_3 then
							if arg_31_1.isInRecall_ then
								local var_34_8 = Mathf.Lerp(iter_34_3.color.r, arg_31_1.hightColor1.r, var_34_7)
								local var_34_9 = Mathf.Lerp(iter_34_3.color.g, arg_31_1.hightColor1.g, var_34_7)
								local var_34_10 = Mathf.Lerp(iter_34_3.color.b, arg_31_1.hightColor1.b, var_34_7)

								iter_34_3.color = Color.New(var_34_8, var_34_9, var_34_10)
							else
								local var_34_11 = Mathf.Lerp(iter_34_3.color.r, 1, var_34_7)

								iter_34_3.color = Color.New(var_34_11, var_34_11, var_34_11)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= var_34_5 + var_34_6 and arg_31_1.time_ < var_34_5 + var_34_6 + arg_34_0 and not isNil(var_34_4) and arg_31_1.var_.actorSpriteComps10148 then
				for iter_34_4, iter_34_5 in pairs(arg_31_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_34_5 then
						if arg_31_1.isInRecall_ then
							iter_34_5.color = arg_31_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_34_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_31_1.var_.actorSpriteComps10148 = nil
			end

			local var_34_12 = arg_31_1.actors_["10148"].transform
			local var_34_13 = 0

			if var_34_13 < arg_31_1.time_ and arg_31_1.time_ <= var_34_13 + arg_34_0 then
				arg_31_1.var_.moveOldPos10148 = var_34_12.localPosition
				var_34_12.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("10148", 3)

				local var_34_14 = var_34_12.childCount

				for iter_34_6 = 0, var_34_14 - 1 do
					local var_34_15 = var_34_12:GetChild(iter_34_6)

					if var_34_15.name == "split_6" or not string.find(var_34_15.name, "split") then
						var_34_15.gameObject:SetActive(true)
					else
						var_34_15.gameObject:SetActive(false)
					end
				end
			end

			local var_34_16 = 0.001

			if var_34_13 <= arg_31_1.time_ and arg_31_1.time_ < var_34_13 + var_34_16 then
				local var_34_17 = (arg_31_1.time_ - var_34_13) / var_34_16
				local var_34_18 = Vector3.New(0, -350, -270)

				var_34_12.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10148, var_34_18, var_34_17)
			end

			if arg_31_1.time_ >= var_34_13 + var_34_16 and arg_31_1.time_ < var_34_13 + var_34_16 + arg_34_0 then
				var_34_12.localPosition = Vector3.New(0, -350, -270)
			end

			local var_34_19 = arg_31_1.actors_["10148"]
			local var_34_20 = 0

			if var_34_20 < arg_31_1.time_ and arg_31_1.time_ <= var_34_20 + arg_34_0 then
				local var_34_21 = var_34_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_34_21 then
					arg_31_1.var_.alphaOldValue10148 = var_34_21.alpha
					arg_31_1.var_.characterEffect10148 = var_34_21
				end

				arg_31_1.var_.alphaOldValue10148 = 0
			end

			local var_34_22 = 0.5

			if var_34_20 <= arg_31_1.time_ and arg_31_1.time_ < var_34_20 + var_34_22 then
				local var_34_23 = (arg_31_1.time_ - var_34_20) / var_34_22
				local var_34_24 = Mathf.Lerp(arg_31_1.var_.alphaOldValue10148, 1, var_34_23)

				if arg_31_1.var_.characterEffect10148 then
					arg_31_1.var_.characterEffect10148.alpha = var_34_24
				end
			end

			if arg_31_1.time_ >= var_34_20 + var_34_22 and arg_31_1.time_ < var_34_20 + var_34_22 + arg_34_0 and arg_31_1.var_.characterEffect10148 then
				arg_31_1.var_.characterEffect10148.alpha = 1
			end

			if arg_31_1.frameCnt_ <= 1 then
				arg_31_1.dialog_:SetActive(false)
			end

			local var_34_25 = 0.5
			local var_34_26 = 0.2

			if var_34_25 < arg_31_1.time_ and arg_31_1.time_ <= var_34_25 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_27 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_27:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_31_1.dialogCg_.alpha = arg_35_0
				end))
				var_34_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_28 = arg_31_1:FormatText(StoryNameCfg[1326].name)

				arg_31_1.leftNameTxt_.text = var_34_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_29 = arg_31_1:GetWordFromCfg(423011007)
				local var_34_30 = arg_31_1:FormatText(var_34_29.content)

				arg_31_1.text_.text = var_34_30

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_31 = 8
				local var_34_32 = utf8.len(var_34_30)
				local var_34_33 = var_34_31 <= 0 and var_34_26 or var_34_26 * (var_34_32 / var_34_31)

				if var_34_33 > 0 and var_34_26 < var_34_33 then
					arg_31_1.talkMaxDuration = var_34_33
					var_34_25 = var_34_25 + 0.3

					if var_34_33 + var_34_25 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_33 + var_34_25
					end
				end

				arg_31_1.text_.text = var_34_30
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011007", "story_v_out_423011.awb") ~= 0 then
					local var_34_34 = manager.audio:GetVoiceLength("story_v_out_423011", "423011007", "story_v_out_423011.awb") / 1000

					if var_34_34 + var_34_25 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_34 + var_34_25
					end

					if var_34_29.prefab_name ~= "" and arg_31_1.actors_[var_34_29.prefab_name] ~= nil then
						local var_34_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_29.prefab_name].transform, "story_v_out_423011", "423011007", "story_v_out_423011.awb")

						arg_31_1:RecordAudio("423011007", var_34_35)
						arg_31_1:RecordAudio("423011007", var_34_35)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_423011", "423011007", "story_v_out_423011.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_423011", "423011007", "story_v_out_423011.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_36 = var_34_25 + 0.3
			local var_34_37 = math.max(var_34_26, arg_31_1.talkMaxDuration)

			if var_34_36 <= arg_31_1.time_ and arg_31_1.time_ < var_34_36 + var_34_37 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_36) / var_34_37

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_36 + var_34_37 and arg_31_1.time_ < var_34_36 + var_34_37 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play423011008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423011008
		arg_37_1.duration_ = 3.63

		local var_37_0 = {
			zh = 3.266,
			ja = 3.633
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
				arg_37_0:Play423011009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.35

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[1326].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(423011008)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011008", "story_v_out_423011.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011008", "story_v_out_423011.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_423011", "423011008", "story_v_out_423011.awb")

						arg_37_1:RecordAudio("423011008", var_40_9)
						arg_37_1:RecordAudio("423011008", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_423011", "423011008", "story_v_out_423011.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_423011", "423011008", "story_v_out_423011.awb")
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
	Play423011009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423011009
		arg_41_1.duration_ = 8.63

		local var_41_0 = {
			zh = 8.633,
			ja = 7.266
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
				arg_41_0:Play423011010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1083"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1083 == nil then
				arg_41_1.var_.actorSpriteComps1083 = var_44_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_2 = 0.2

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.actorSpriteComps1083 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.actorSpriteComps1083 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_44_3 then
						if arg_41_1.isInRecall_ then
							iter_44_3.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps1083 = nil
			end

			local var_44_8 = arg_41_1.actors_["10148"]
			local var_44_9 = 0

			if var_44_9 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10148 == nil then
				arg_41_1.var_.actorSpriteComps10148 = var_44_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_10 = 0.2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 and not isNil(var_44_8) then
				local var_44_11 = (arg_41_1.time_ - var_44_9) / var_44_10

				if arg_41_1.var_.actorSpriteComps10148 then
					for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_44_5 then
							if arg_41_1.isInRecall_ then
								local var_44_12 = Mathf.Lerp(iter_44_5.color.r, arg_41_1.hightColor2.r, var_44_11)
								local var_44_13 = Mathf.Lerp(iter_44_5.color.g, arg_41_1.hightColor2.g, var_44_11)
								local var_44_14 = Mathf.Lerp(iter_44_5.color.b, arg_41_1.hightColor2.b, var_44_11)

								iter_44_5.color = Color.New(var_44_12, var_44_13, var_44_14)
							else
								local var_44_15 = Mathf.Lerp(iter_44_5.color.r, 0.5, var_44_11)

								iter_44_5.color = Color.New(var_44_15, var_44_15, var_44_15)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 and not isNil(var_44_8) and arg_41_1.var_.actorSpriteComps10148 then
				for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_44_7 then
						if arg_41_1.isInRecall_ then
							iter_44_7.color = arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_44_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10148 = nil
			end

			local var_44_16 = arg_41_1.actors_["1083"].transform
			local var_44_17 = 0

			if var_44_17 < arg_41_1.time_ and arg_41_1.time_ <= var_44_17 + arg_44_0 then
				arg_41_1.var_.moveOldPos1083 = var_44_16.localPosition
				var_44_16.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1083", 4)

				local var_44_18 = var_44_16.childCount

				for iter_44_8 = 0, var_44_18 - 1 do
					local var_44_19 = var_44_16:GetChild(iter_44_8)

					if var_44_19.name == "" or not string.find(var_44_19.name, "split") then
						var_44_19.gameObject:SetActive(true)
					else
						var_44_19.gameObject:SetActive(false)
					end
				end
			end

			local var_44_20 = 0.001

			if var_44_17 <= arg_41_1.time_ and arg_41_1.time_ < var_44_17 + var_44_20 then
				local var_44_21 = (arg_41_1.time_ - var_44_17) / var_44_20
				local var_44_22 = Vector3.New(390, -345, -345)

				var_44_16.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1083, var_44_22, var_44_21)
			end

			if arg_41_1.time_ >= var_44_17 + var_44_20 and arg_41_1.time_ < var_44_17 + var_44_20 + arg_44_0 then
				var_44_16.localPosition = Vector3.New(390, -345, -345)
			end

			local var_44_23 = arg_41_1.actors_["10148"].transform
			local var_44_24 = 0

			if var_44_24 < arg_41_1.time_ and arg_41_1.time_ <= var_44_24 + arg_44_0 then
				arg_41_1.var_.moveOldPos10148 = var_44_23.localPosition
				var_44_23.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10148", 2)

				local var_44_25 = var_44_23.childCount

				for iter_44_9 = 0, var_44_25 - 1 do
					local var_44_26 = var_44_23:GetChild(iter_44_9)

					if var_44_26.name == "split_6" or not string.find(var_44_26.name, "split") then
						var_44_26.gameObject:SetActive(true)
					else
						var_44_26.gameObject:SetActive(false)
					end
				end
			end

			local var_44_27 = 0.001

			if var_44_24 <= arg_41_1.time_ and arg_41_1.time_ < var_44_24 + var_44_27 then
				local var_44_28 = (arg_41_1.time_ - var_44_24) / var_44_27
				local var_44_29 = Vector3.New(-390, -350, -270)

				var_44_23.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10148, var_44_29, var_44_28)
			end

			if arg_41_1.time_ >= var_44_24 + var_44_27 and arg_41_1.time_ < var_44_24 + var_44_27 + arg_44_0 then
				var_44_23.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_44_30 = 0
			local var_44_31 = 0.775

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_32 = arg_41_1:FormatText(StoryNameCfg[1325].name)

				arg_41_1.leftNameTxt_.text = var_44_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_33 = arg_41_1:GetWordFromCfg(423011009)
				local var_44_34 = arg_41_1:FormatText(var_44_33.content)

				arg_41_1.text_.text = var_44_34

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_35 = 31
				local var_44_36 = utf8.len(var_44_34)
				local var_44_37 = var_44_35 <= 0 and var_44_31 or var_44_31 * (var_44_36 / var_44_35)

				if var_44_37 > 0 and var_44_31 < var_44_37 then
					arg_41_1.talkMaxDuration = var_44_37

					if var_44_37 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_37 + var_44_30
					end
				end

				arg_41_1.text_.text = var_44_34
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011009", "story_v_out_423011.awb") ~= 0 then
					local var_44_38 = manager.audio:GetVoiceLength("story_v_out_423011", "423011009", "story_v_out_423011.awb") / 1000

					if var_44_38 + var_44_30 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_38 + var_44_30
					end

					if var_44_33.prefab_name ~= "" and arg_41_1.actors_[var_44_33.prefab_name] ~= nil then
						local var_44_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_33.prefab_name].transform, "story_v_out_423011", "423011009", "story_v_out_423011.awb")

						arg_41_1:RecordAudio("423011009", var_44_39)
						arg_41_1:RecordAudio("423011009", var_44_39)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423011", "423011009", "story_v_out_423011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423011", "423011009", "story_v_out_423011.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_40 = math.max(var_44_31, arg_41_1.talkMaxDuration)

			if var_44_30 <= arg_41_1.time_ and arg_41_1.time_ < var_44_30 + var_44_40 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_30) / var_44_40

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_30 + var_44_40 and arg_41_1.time_ < var_44_30 + var_44_40 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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
				actorName = "10148",
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
	Play423011010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423011010
		arg_45_1.duration_ = 6.23

		local var_45_0 = {
			zh = 5.166,
			ja = 6.233
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
				arg_45_0:Play423011011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.525

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[1325].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(423011010)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011010", "story_v_out_423011.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011010", "story_v_out_423011.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_423011", "423011010", "story_v_out_423011.awb")

						arg_45_1:RecordAudio("423011010", var_48_9)
						arg_45_1:RecordAudio("423011010", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_423011", "423011010", "story_v_out_423011.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_423011", "423011010", "story_v_out_423011.awb")
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
	Play423011011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423011011
		arg_49_1.duration_ = 5.2

		local var_49_0 = {
			zh = 3.366,
			ja = 5.2
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
				arg_49_0:Play423011012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10148"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10148 == nil then
				arg_49_1.var_.actorSpriteComps10148 = var_52_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_2 = 0.2

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.actorSpriteComps10148 then
					for iter_52_0, iter_52_1 in pairs(arg_49_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.actorSpriteComps10148 then
				for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_52_3 then
						if arg_49_1.isInRecall_ then
							iter_52_3.color = arg_49_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_52_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10148 = nil
			end

			local var_52_8 = arg_49_1.actors_["1083"]
			local var_52_9 = 0

			if var_52_9 < arg_49_1.time_ and arg_49_1.time_ <= var_52_9 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps1083 == nil then
				arg_49_1.var_.actorSpriteComps1083 = var_52_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_10 = 0.2

			if var_52_9 <= arg_49_1.time_ and arg_49_1.time_ < var_52_9 + var_52_10 and not isNil(var_52_8) then
				local var_52_11 = (arg_49_1.time_ - var_52_9) / var_52_10

				if arg_49_1.var_.actorSpriteComps1083 then
					for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_49_1.time_ >= var_52_9 + var_52_10 and arg_49_1.time_ < var_52_9 + var_52_10 + arg_52_0 and not isNil(var_52_8) and arg_49_1.var_.actorSpriteComps1083 then
				for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_52_7 then
						if arg_49_1.isInRecall_ then
							iter_52_7.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1083 = nil
			end

			local var_52_16 = arg_49_1.actors_["10148"].transform
			local var_52_17 = 0

			if var_52_17 < arg_49_1.time_ and arg_49_1.time_ <= var_52_17 + arg_52_0 then
				arg_49_1.var_.moveOldPos10148 = var_52_16.localPosition
				var_52_16.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10148", 2)

				local var_52_18 = var_52_16.childCount

				for iter_52_8 = 0, var_52_18 - 1 do
					local var_52_19 = var_52_16:GetChild(iter_52_8)

					if var_52_19.name == "split_1" or not string.find(var_52_19.name, "split") then
						var_52_19.gameObject:SetActive(true)
					else
						var_52_19.gameObject:SetActive(false)
					end
				end
			end

			local var_52_20 = 0.001

			if var_52_17 <= arg_49_1.time_ and arg_49_1.time_ < var_52_17 + var_52_20 then
				local var_52_21 = (arg_49_1.time_ - var_52_17) / var_52_20
				local var_52_22 = Vector3.New(-390, -350, -270)

				var_52_16.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10148, var_52_22, var_52_21)
			end

			if arg_49_1.time_ >= var_52_17 + var_52_20 and arg_49_1.time_ < var_52_17 + var_52_20 + arg_52_0 then
				var_52_16.localPosition = Vector3.New(-390, -350, -270)
			end

			local var_52_23 = 0
			local var_52_24 = 0.275

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_25 = arg_49_1:FormatText(StoryNameCfg[1326].name)

				arg_49_1.leftNameTxt_.text = var_52_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_26 = arg_49_1:GetWordFromCfg(423011011)
				local var_52_27 = arg_49_1:FormatText(var_52_26.content)

				arg_49_1.text_.text = var_52_27

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_28 = 11
				local var_52_29 = utf8.len(var_52_27)
				local var_52_30 = var_52_28 <= 0 and var_52_24 or var_52_24 * (var_52_29 / var_52_28)

				if var_52_30 > 0 and var_52_24 < var_52_30 then
					arg_49_1.talkMaxDuration = var_52_30

					if var_52_30 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_30 + var_52_23
					end
				end

				arg_49_1.text_.text = var_52_27
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011011", "story_v_out_423011.awb") ~= 0 then
					local var_52_31 = manager.audio:GetVoiceLength("story_v_out_423011", "423011011", "story_v_out_423011.awb") / 1000

					if var_52_31 + var_52_23 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_31 + var_52_23
					end

					if var_52_26.prefab_name ~= "" and arg_49_1.actors_[var_52_26.prefab_name] ~= nil then
						local var_52_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_26.prefab_name].transform, "story_v_out_423011", "423011011", "story_v_out_423011.awb")

						arg_49_1:RecordAudio("423011011", var_52_32)
						arg_49_1:RecordAudio("423011011", var_52_32)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_423011", "423011011", "story_v_out_423011.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_423011", "423011011", "story_v_out_423011.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_33 = math.max(var_52_24, arg_49_1.talkMaxDuration)

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_33 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_23) / var_52_33

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_23 + var_52_33 and arg_49_1.time_ < var_52_23 + var_52_33 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423011012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423011012
		arg_53_1.duration_ = 5.7

		local var_53_0 = {
			zh = 5.7,
			ja = 4.133
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
				arg_53_0:Play423011013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.625

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[1326].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(423011012)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011012", "story_v_out_423011.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011012", "story_v_out_423011.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_423011", "423011012", "story_v_out_423011.awb")

						arg_53_1:RecordAudio("423011012", var_56_9)
						arg_53_1:RecordAudio("423011012", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_423011", "423011012", "story_v_out_423011.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_423011", "423011012", "story_v_out_423011.awb")
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
	Play423011013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 423011013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play423011014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10148"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10148 == nil then
				arg_57_1.var_.actorSpriteComps10148 = var_60_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_2 = 0.2

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.actorSpriteComps10148 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								local var_60_4 = Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, var_60_3)
								local var_60_5 = Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, var_60_3)
								local var_60_6 = Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, var_60_3)

								iter_60_1.color = Color.New(var_60_4, var_60_5, var_60_6)
							else
								local var_60_7 = Mathf.Lerp(iter_60_1.color.r, 0.5, var_60_3)

								iter_60_1.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.actorSpriteComps10148 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_60_3 then
						if arg_57_1.isInRecall_ then
							iter_60_3.color = arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_60_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10148 = nil
			end

			local var_60_8 = arg_57_1.actors_["10148"].transform
			local var_60_9 = 0

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.var_.moveOldPos10148 = var_60_8.localPosition
				var_60_8.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10148", 7)

				local var_60_10 = var_60_8.childCount

				for iter_60_4 = 0, var_60_10 - 1 do
					local var_60_11 = var_60_8:GetChild(iter_60_4)

					if var_60_11.name == "" or not string.find(var_60_11.name, "split") then
						var_60_11.gameObject:SetActive(true)
					else
						var_60_11.gameObject:SetActive(false)
					end
				end
			end

			local var_60_12 = 0.001

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_12 then
				local var_60_13 = (arg_57_1.time_ - var_60_9) / var_60_12
				local var_60_14 = Vector3.New(0, -2000, 0)

				var_60_8.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10148, var_60_14, var_60_13)
			end

			if arg_57_1.time_ >= var_60_9 + var_60_12 and arg_57_1.time_ < var_60_9 + var_60_12 + arg_60_0 then
				var_60_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_15 = arg_57_1.actors_["1083"].transform
			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.var_.moveOldPos1083 = var_60_15.localPosition
				var_60_15.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1083", 7)

				local var_60_17 = var_60_15.childCount

				for iter_60_5 = 0, var_60_17 - 1 do
					local var_60_18 = var_60_15:GetChild(iter_60_5)

					if var_60_18.name == "" or not string.find(var_60_18.name, "split") then
						var_60_18.gameObject:SetActive(true)
					else
						var_60_18.gameObject:SetActive(false)
					end
				end
			end

			local var_60_19 = 0.001

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_19 then
				local var_60_20 = (arg_57_1.time_ - var_60_16) / var_60_19
				local var_60_21 = Vector3.New(0, -2000, 0)

				var_60_15.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1083, var_60_21, var_60_20)
			end

			if arg_57_1.time_ >= var_60_16 + var_60_19 and arg_57_1.time_ < var_60_16 + var_60_19 + arg_60_0 then
				var_60_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_22 = 0.533333333333333
			local var_60_23 = 1

			if var_60_22 < arg_57_1.time_ and arg_57_1.time_ <= var_60_22 + arg_60_0 then
				local var_60_24 = "play"
				local var_60_25 = "effect"

				arg_57_1:AudioAction(var_60_24, var_60_25, "se_story_144", "se_story_144_foley_gun03", "")
			end

			local var_60_26 = 0
			local var_60_27 = 1.35

			if var_60_26 < arg_57_1.time_ and arg_57_1.time_ <= var_60_26 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_28 = arg_57_1:GetWordFromCfg(423011013)
				local var_60_29 = arg_57_1:FormatText(var_60_28.content)

				arg_57_1.text_.text = var_60_29

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_30 = 54
				local var_60_31 = utf8.len(var_60_29)
				local var_60_32 = var_60_30 <= 0 and var_60_27 or var_60_27 * (var_60_31 / var_60_30)

				if var_60_32 > 0 and var_60_27 < var_60_32 then
					arg_57_1.talkMaxDuration = var_60_32

					if var_60_32 + var_60_26 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_32 + var_60_26
					end
				end

				arg_57_1.text_.text = var_60_29
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_33 = math.max(var_60_27, arg_57_1.talkMaxDuration)

			if var_60_26 <= arg_57_1.time_ and arg_57_1.time_ < var_60_26 + var_60_33 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_26) / var_60_33

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_26 + var_60_33 and arg_57_1.time_ < var_60_26 + var_60_33 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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

		arg_57_1:InitPlayNodeList()
	end,
	Play423011014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 423011014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play423011015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.425

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(423011014)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 57
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play423011015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 423011015
		arg_65_1.duration_ = 3.73

		local var_65_0 = {
			zh = 3.733,
			ja = 3.7
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
				arg_65_0:Play423011016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1083"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1083 == nil then
				arg_65_1.var_.actorSpriteComps1083 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.2

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps1083 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps1083 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1083 = nil
			end

			local var_68_8 = arg_65_1.actors_["1083"].transform
			local var_68_9 = 0

			if var_68_9 < arg_65_1.time_ and arg_65_1.time_ <= var_68_9 + arg_68_0 then
				arg_65_1.var_.moveOldPos1083 = var_68_8.localPosition
				var_68_8.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("1083", 3)

				local var_68_10 = var_68_8.childCount

				for iter_68_4 = 0, var_68_10 - 1 do
					local var_68_11 = var_68_8:GetChild(iter_68_4)

					if var_68_11.name == "split_7" or not string.find(var_68_11.name, "split") then
						var_68_11.gameObject:SetActive(true)
					else
						var_68_11.gameObject:SetActive(false)
					end
				end
			end

			local var_68_12 = 0.001

			if var_68_9 <= arg_65_1.time_ and arg_65_1.time_ < var_68_9 + var_68_12 then
				local var_68_13 = (arg_65_1.time_ - var_68_9) / var_68_12
				local var_68_14 = Vector3.New(-50, -345, -345)

				var_68_8.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1083, var_68_14, var_68_13)
			end

			if arg_65_1.time_ >= var_68_9 + var_68_12 and arg_65_1.time_ < var_68_9 + var_68_12 + arg_68_0 then
				var_68_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_68_15 = 0.034
			local var_68_16 = 1

			if var_68_15 < arg_65_1.time_ and arg_65_1.time_ <= var_68_15 + arg_68_0 then
				local var_68_17 = "play"
				local var_68_18 = "effect"

				arg_65_1:AudioAction(var_68_17, var_68_18, "se_story_144", "se_story_144_bell01", "")
			end

			local var_68_19 = 0
			local var_68_20 = 0.35

			if var_68_19 < arg_65_1.time_ and arg_65_1.time_ <= var_68_19 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_21 = arg_65_1:FormatText(StoryNameCfg[1325].name)

				arg_65_1.leftNameTxt_.text = var_68_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_22 = arg_65_1:GetWordFromCfg(423011015)
				local var_68_23 = arg_65_1:FormatText(var_68_22.content)

				arg_65_1.text_.text = var_68_23

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_24 = 14
				local var_68_25 = utf8.len(var_68_23)
				local var_68_26 = var_68_24 <= 0 and var_68_20 or var_68_20 * (var_68_25 / var_68_24)

				if var_68_26 > 0 and var_68_20 < var_68_26 then
					arg_65_1.talkMaxDuration = var_68_26

					if var_68_26 + var_68_19 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_26 + var_68_19
					end
				end

				arg_65_1.text_.text = var_68_23
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011015", "story_v_out_423011.awb") ~= 0 then
					local var_68_27 = manager.audio:GetVoiceLength("story_v_out_423011", "423011015", "story_v_out_423011.awb") / 1000

					if var_68_27 + var_68_19 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_27 + var_68_19
					end

					if var_68_22.prefab_name ~= "" and arg_65_1.actors_[var_68_22.prefab_name] ~= nil then
						local var_68_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_22.prefab_name].transform, "story_v_out_423011", "423011015", "story_v_out_423011.awb")

						arg_65_1:RecordAudio("423011015", var_68_28)
						arg_65_1:RecordAudio("423011015", var_68_28)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_423011", "423011015", "story_v_out_423011.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_423011", "423011015", "story_v_out_423011.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_29 = math.max(var_68_20, arg_65_1.talkMaxDuration)

			if var_68_19 <= arg_65_1.time_ and arg_65_1.time_ < var_68_19 + var_68_29 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_19) / var_68_29

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_19 + var_68_29 and arg_65_1.time_ < var_68_19 + var_68_29 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play423011016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 423011016
		arg_69_1.duration_ = 7

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play423011017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1083"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps1083 == nil then
				arg_69_1.var_.actorSpriteComps1083 = var_72_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.actorSpriteComps1083 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_72_1 then
							if arg_69_1.isInRecall_ then
								local var_72_4 = Mathf.Lerp(iter_72_1.color.r, arg_69_1.hightColor2.r, var_72_3)
								local var_72_5 = Mathf.Lerp(iter_72_1.color.g, arg_69_1.hightColor2.g, var_72_3)
								local var_72_6 = Mathf.Lerp(iter_72_1.color.b, arg_69_1.hightColor2.b, var_72_3)

								iter_72_1.color = Color.New(var_72_4, var_72_5, var_72_6)
							else
								local var_72_7 = Mathf.Lerp(iter_72_1.color.r, 0.5, var_72_3)

								iter_72_1.color = Color.New(var_72_7, var_72_7, var_72_7)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.actorSpriteComps1083 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_72_3 then
						if arg_69_1.isInRecall_ then
							iter_72_3.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1083 = nil
			end

			local var_72_8 = arg_69_1.actors_["1083"].transform
			local var_72_9 = 0

			if var_72_9 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.var_.moveOldPos1083 = var_72_8.localPosition
				var_72_8.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1083", 7)

				local var_72_10 = var_72_8.childCount

				for iter_72_4 = 0, var_72_10 - 1 do
					local var_72_11 = var_72_8:GetChild(iter_72_4)

					if var_72_11.name == "" or not string.find(var_72_11.name, "split") then
						var_72_11.gameObject:SetActive(true)
					else
						var_72_11.gameObject:SetActive(false)
					end
				end
			end

			local var_72_12 = 0.001

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_12 then
				local var_72_13 = (arg_69_1.time_ - var_72_9) / var_72_12
				local var_72_14 = Vector3.New(0, -2000, 0)

				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1083, var_72_14, var_72_13)
			end

			if arg_69_1.time_ >= var_72_9 + var_72_12 and arg_69_1.time_ < var_72_9 + var_72_12 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_72_15 = manager.ui.mainCamera.transform
			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 then
				local var_72_17 = arg_69_1.var_.effectjilieqiangsheng1
				local var_72_18
				local var_72_19 = var_72_15

				if not var_72_17 then
					var_72_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_72_19)
					var_72_17.name = "jilieqiangsheng1"
					arg_69_1.var_.effectjilieqiangsheng1 = var_72_17
				else
					var_72_17.transform:SetParent(var_72_19)
				end

				var_72_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_72_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_72_20 = manager.ui.mainCamera.transform
			local var_72_21 = 2.5

			if var_72_21 < arg_69_1.time_ and arg_69_1.time_ <= var_72_21 + arg_72_0 then
				local var_72_22 = arg_69_1.var_.effectjilieqiangsheng1

				if var_72_22 then
					Object.Destroy(var_72_22)

					arg_69_1.var_.effectjilieqiangsheng1 = nil
				end
			end

			local var_72_23 = manager.ui.mainCamera.transform
			local var_72_24 = 0.3

			if var_72_24 < arg_69_1.time_ and arg_69_1.time_ <= var_72_24 + arg_72_0 then
				local var_72_25 = arg_69_1.var_.effectjilieqiangsheng2
				local var_72_26
				local var_72_27 = var_72_23

				if not var_72_25 then
					var_72_25 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_72_27)
					var_72_25.name = "jilieqiangsheng2"
					arg_69_1.var_.effectjilieqiangsheng2 = var_72_25
				else
					var_72_25.transform:SetParent(var_72_27)
				end

				var_72_25.transform.localPosition = Vector3.New(2.32, 0, 0)
				var_72_25.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_72_28 = manager.ui.mainCamera.transform
			local var_72_29 = 2.5

			if var_72_29 < arg_69_1.time_ and arg_69_1.time_ <= var_72_29 + arg_72_0 then
				local var_72_30 = arg_69_1.var_.effectjilieqiangsheng2

				if var_72_30 then
					Object.Destroy(var_72_30)

					arg_69_1.var_.effectjilieqiangsheng2 = nil
				end
			end

			local var_72_31 = manager.ui.mainCamera.transform
			local var_72_32 = 0.6

			if var_72_32 < arg_69_1.time_ and arg_69_1.time_ <= var_72_32 + arg_72_0 then
				local var_72_33 = arg_69_1.var_.effectjilieqiangsheng3
				local var_72_34
				local var_72_35 = var_72_31

				if not var_72_33 then
					var_72_33 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_72_35)
					var_72_33.name = "jilieqiangsheng3"
					arg_69_1.var_.effectjilieqiangsheng3 = var_72_33
				else
					var_72_33.transform:SetParent(var_72_35)
				end

				var_72_33.transform.localPosition = Vector3.New(0.75, -1.71, 0)
				var_72_33.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_72_36 = manager.ui.mainCamera.transform
			local var_72_37 = 2.5

			if var_72_37 < arg_69_1.time_ and arg_69_1.time_ <= var_72_37 + arg_72_0 then
				local var_72_38 = arg_69_1.var_.effectjilieqiangsheng3

				if var_72_38 then
					Object.Destroy(var_72_38)

					arg_69_1.var_.effectjilieqiangsheng3 = nil
				end
			end

			local var_72_39 = manager.ui.mainCamera.transform
			local var_72_40 = 1

			if var_72_40 < arg_69_1.time_ and arg_69_1.time_ <= var_72_40 + arg_72_0 then
				local var_72_41 = arg_69_1.var_.effectjilieqiangsheng4
				local var_72_42
				local var_72_43 = var_72_39

				if not var_72_41 then
					var_72_41 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_72_43)
					var_72_41.name = "jilieqiangsheng4"
					arg_69_1.var_.effectjilieqiangsheng4 = var_72_41
				else
					var_72_41.transform:SetParent(var_72_43)
				end

				var_72_41.transform.localPosition = Vector3.New(-1.47, -0.85, 0)
				var_72_41.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_72_44 = manager.ui.mainCamera.transform
			local var_72_45 = 2.5

			if var_72_45 < arg_69_1.time_ and arg_69_1.time_ <= var_72_45 + arg_72_0 then
				local var_72_46 = arg_69_1.var_.effectjilieqiangsheng4

				if var_72_46 then
					Object.Destroy(var_72_46)

					arg_69_1.var_.effectjilieqiangsheng4 = nil
				end
			end

			local var_72_47 = 0

			if var_72_47 < arg_69_1.time_ and arg_69_1.time_ <= var_72_47 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			local var_72_48 = 2

			if arg_69_1.time_ >= var_72_47 + var_72_48 and arg_69_1.time_ < var_72_47 + var_72_48 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_49 = 0.034
			local var_72_50 = 1

			if var_72_49 < arg_69_1.time_ and arg_69_1.time_ <= var_72_49 + arg_72_0 then
				local var_72_51 = "play"
				local var_72_52 = "effect"

				arg_69_1:AudioAction(var_72_51, var_72_52, "se_story_144", "se_story_144_gun_battle02", "")
			end

			local var_72_53 = manager.ui.mainCamera.transform
			local var_72_54 = 0.034

			if var_72_54 < arg_69_1.time_ and arg_69_1.time_ <= var_72_54 + arg_72_0 then
				arg_69_1.var_.shakeOldPos = var_72_53.localPosition
			end

			local var_72_55 = 1

			if var_72_54 <= arg_69_1.time_ and arg_69_1.time_ < var_72_54 + var_72_55 then
				local var_72_56 = (arg_69_1.time_ - var_72_54) / 0.066
				local var_72_57, var_72_58 = math.modf(var_72_56)

				var_72_53.localPosition = Vector3.New(var_72_58 * 0.13, var_72_58 * 0.13, var_72_58 * 0.13) + arg_69_1.var_.shakeOldPos
			end

			if arg_69_1.time_ >= var_72_54 + var_72_55 and arg_69_1.time_ < var_72_54 + var_72_55 + arg_72_0 then
				var_72_53.localPosition = arg_69_1.var_.shakeOldPos
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_59 = 2
			local var_72_60 = 1.625

			if var_72_59 < arg_69_1.time_ and arg_69_1.time_ <= var_72_59 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_61 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_61:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_62 = arg_69_1:GetWordFromCfg(423011016)
				local var_72_63 = arg_69_1:FormatText(var_72_62.content)

				arg_69_1.text_.text = var_72_63

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_64 = 65
				local var_72_65 = utf8.len(var_72_63)
				local var_72_66 = var_72_64 <= 0 and var_72_60 or var_72_60 * (var_72_65 / var_72_64)

				if var_72_66 > 0 and var_72_60 < var_72_66 then
					arg_69_1.talkMaxDuration = var_72_66
					var_72_59 = var_72_59 + 0.3

					if var_72_66 + var_72_59 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_66 + var_72_59
					end
				end

				arg_69_1.text_.text = var_72_63
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_67 = var_72_59 + 0.3
			local var_72_68 = math.max(var_72_60, arg_69_1.talkMaxDuration)

			if var_72_67 <= arg_69_1.time_ and arg_69_1.time_ < var_72_67 + var_72_68 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_67) / var_72_68

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_67 + var_72_68 and arg_69_1.time_ < var_72_67 + var_72_68 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play423011017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 423011017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play423011018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.1
			local var_78_1 = 1

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				local var_78_2 = "play"
				local var_78_3 = "effect"

				arg_75_1:AudioAction(var_78_2, var_78_3, "se_story_144", "se_story_144_footstep_cowboy", "")
			end

			local var_78_4 = 0
			local var_78_5 = 1.95

			if var_78_4 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_6 = arg_75_1:GetWordFromCfg(423011017)
				local var_78_7 = arg_75_1:FormatText(var_78_6.content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_8 = 86
				local var_78_9 = utf8.len(var_78_7)
				local var_78_10 = var_78_8 <= 0 and var_78_5 or var_78_5 * (var_78_9 / var_78_8)

				if var_78_10 > 0 and var_78_5 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_4
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_11 = math.max(var_78_5, arg_75_1.talkMaxDuration)

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_11 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_4) / var_78_11

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_4 + var_78_11 and arg_75_1.time_ < var_78_4 + var_78_11 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play423011018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 423011018
		arg_79_1.duration_ = 8.8

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play423011019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = "ST0111"

			if arg_79_1.bgs_[var_82_0] == nil then
				local var_82_1 = Object.Instantiate(arg_79_1.paintGo_)

				var_82_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_82_0)
				var_82_1.name = var_82_0
				var_82_1.transform.parent = arg_79_1.stage_.transform
				var_82_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.bgs_[var_82_0] = var_82_1
			end

			local var_82_2 = 2

			if var_82_2 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				local var_82_3 = manager.ui.mainCamera.transform.localPosition
				local var_82_4 = Vector3.New(0, 0, 10) + Vector3.New(var_82_3.x, var_82_3.y, 0)
				local var_82_5 = arg_79_1.bgs_.ST0111

				var_82_5.transform.localPosition = var_82_4
				var_82_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_82_6 = var_82_5:GetComponent("SpriteRenderer")

				if var_82_6 and var_82_6.sprite then
					local var_82_7 = (var_82_5.transform.localPosition - var_82_3).z
					local var_82_8 = manager.ui.mainCameraCom_
					local var_82_9 = 2 * var_82_7 * Mathf.Tan(var_82_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_82_10 = var_82_9 * var_82_8.aspect
					local var_82_11 = var_82_6.sprite.bounds.size.x
					local var_82_12 = var_82_6.sprite.bounds.size.y
					local var_82_13 = var_82_10 / var_82_11
					local var_82_14 = var_82_9 / var_82_12
					local var_82_15 = var_82_14 < var_82_13 and var_82_13 or var_82_14

					var_82_5.transform.localScale = Vector3.New(var_82_15, var_82_15, 0)
				end

				for iter_82_0, iter_82_1 in pairs(arg_79_1.bgs_) do
					if iter_82_0 ~= "ST0111" then
						iter_82_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_82_16 = 3.8

			if var_82_16 < arg_79_1.time_ and arg_79_1.time_ <= var_82_16 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			local var_82_17 = 0.3

			if arg_79_1.time_ >= var_82_16 + var_82_17 and arg_79_1.time_ < var_82_16 + var_82_17 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			local var_82_18 = 0

			if var_82_18 < arg_79_1.time_ and arg_79_1.time_ <= var_82_18 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_19 = 2

			if var_82_18 <= arg_79_1.time_ and arg_79_1.time_ < var_82_18 + var_82_19 then
				local var_82_20 = (arg_79_1.time_ - var_82_18) / var_82_19
				local var_82_21 = Color.New(0, 0, 0)

				var_82_21.a = Mathf.Lerp(0, 1, var_82_20)
				arg_79_1.mask_.color = var_82_21
			end

			if arg_79_1.time_ >= var_82_18 + var_82_19 and arg_79_1.time_ < var_82_18 + var_82_19 + arg_82_0 then
				local var_82_22 = Color.New(0, 0, 0)

				var_82_22.a = 1
				arg_79_1.mask_.color = var_82_22
			end

			local var_82_23 = 2

			if var_82_23 < arg_79_1.time_ and arg_79_1.time_ <= var_82_23 + arg_82_0 then
				arg_79_1.mask_.enabled = true
				arg_79_1.mask_.raycastTarget = true

				arg_79_1:SetGaussion(false)
			end

			local var_82_24 = 2

			if var_82_23 <= arg_79_1.time_ and arg_79_1.time_ < var_82_23 + var_82_24 then
				local var_82_25 = (arg_79_1.time_ - var_82_23) / var_82_24
				local var_82_26 = Color.New(0, 0, 0)

				var_82_26.a = Mathf.Lerp(1, 0, var_82_25)
				arg_79_1.mask_.color = var_82_26
			end

			if arg_79_1.time_ >= var_82_23 + var_82_24 and arg_79_1.time_ < var_82_23 + var_82_24 + arg_82_0 then
				local var_82_27 = Color.New(0, 0, 0)
				local var_82_28 = 0

				arg_79_1.mask_.enabled = false
				var_82_27.a = var_82_28
				arg_79_1.mask_.color = var_82_27
			end

			local var_82_29 = manager.ui.mainCamera.transform
			local var_82_30 = 2

			if var_82_30 < arg_79_1.time_ and arg_79_1.time_ <= var_82_30 + arg_82_0 then
				local var_82_31 = arg_79_1.var_.effectfengsha1

				if var_82_31 then
					Object.Destroy(var_82_31)

					arg_79_1.var_.effectfengsha1 = nil
				end
			end

			local var_82_32 = 0.133333333333333
			local var_82_33 = 1

			if var_82_32 < arg_79_1.time_ and arg_79_1.time_ <= var_82_32 + arg_82_0 then
				local var_82_34 = "stop"
				local var_82_35 = "effect"

				arg_79_1:AudioAction(var_82_34, var_82_35, "se_story_144", "se_story_144_amb_town_wind_loop", "")
			end

			local var_82_36 = 0.133333333333333
			local var_82_37 = 1

			if var_82_36 < arg_79_1.time_ and arg_79_1.time_ <= var_82_36 + arg_82_0 then
				local var_82_38 = "stop"
				local var_82_39 = "effect"

				arg_79_1:AudioAction(var_82_38, var_82_39, "se_story_144", "se_story_144_amb_town_loop", "")
			end

			local var_82_40 = 1.6
			local var_82_41 = 1

			if var_82_40 < arg_79_1.time_ and arg_79_1.time_ <= var_82_40 + arg_82_0 then
				local var_82_42 = "play"
				local var_82_43 = "effect"

				arg_79_1:AudioAction(var_82_42, var_82_43, "se_story_144", "se_story_144_amb_train", "")
			end

			local var_82_44 = 2

			arg_79_1.isInRecall_ = false

			if var_82_44 < arg_79_1.time_ and arg_79_1.time_ <= var_82_44 + arg_82_0 then
				arg_79_1.screenFilterGo_:SetActive(false)

				for iter_82_2, iter_82_3 in pairs(arg_79_1.actors_) do
					local var_82_45 = iter_82_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_82_4, iter_82_5 in ipairs(var_82_45) do
						if iter_82_5.color.r > 0.51 then
							iter_82_5.color = Color.New(1, 1, 1)
						else
							iter_82_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_82_46 = 0.1

			if var_82_44 <= arg_79_1.time_ and arg_79_1.time_ < var_82_44 + var_82_46 then
				local var_82_47 = (arg_79_1.time_ - var_82_44) / var_82_46

				arg_79_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_82_47)
			end

			if arg_79_1.time_ >= var_82_44 + var_82_46 and arg_79_1.time_ < var_82_44 + var_82_46 + arg_82_0 then
				arg_79_1.screenFilterEffect_.weight = 0
			end

			local var_82_48 = manager.ui.mainCamera.transform
			local var_82_49 = 2

			if var_82_49 < arg_79_1.time_ and arg_79_1.time_ <= var_82_49 + arg_82_0 then
				local var_82_50 = arg_79_1.var_.effecthuaijiudianying1

				if var_82_50 then
					Object.Destroy(var_82_50)

					arg_79_1.var_.effecthuaijiudianying1 = nil
				end
			end

			local var_82_51 = 1.6
			local var_82_52 = 1

			if var_82_51 < arg_79_1.time_ and arg_79_1.time_ <= var_82_51 + arg_82_0 then
				local var_82_53 = "play"
				local var_82_54 = "effect"

				arg_79_1:AudioAction(var_82_53, var_82_54, "se_story_144", "se_story_144_bgm_street_down", "")
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_55 = 3.8
			local var_82_56 = 1.675

			if var_82_55 < arg_79_1.time_ and arg_79_1.time_ <= var_82_55 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_57 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_57:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_58 = arg_79_1:GetWordFromCfg(423011018)
				local var_82_59 = arg_79_1:FormatText(var_82_58.content)

				arg_79_1.text_.text = var_82_59

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_60 = 67
				local var_82_61 = utf8.len(var_82_59)
				local var_82_62 = var_82_60 <= 0 and var_82_56 or var_82_56 * (var_82_61 / var_82_60)

				if var_82_62 > 0 and var_82_56 < var_82_62 then
					arg_79_1.talkMaxDuration = var_82_62
					var_82_55 = var_82_55 + 0.3

					if var_82_62 + var_82_55 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_62 + var_82_55
					end
				end

				arg_79_1.text_.text = var_82_59
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_63 = var_82_55 + 0.3
			local var_82_64 = math.max(var_82_56, arg_79_1.talkMaxDuration)

			if var_82_63 <= arg_79_1.time_ and arg_79_1.time_ < var_82_63 + var_82_64 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_63) / var_82_64

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_63 + var_82_64 and arg_79_1.time_ < var_82_63 + var_82_64 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play423011019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 423011019
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play423011020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.575

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[7].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(423011019)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 23
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_8 and arg_85_1.time_ < var_88_0 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play423011020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 423011020
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play423011021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.7

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[7].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(423011020)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 28
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_8 and arg_89_1.time_ < var_92_0 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play423011021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 423011021
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play423011022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.825

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_2 = arg_93_1:GetWordFromCfg(423011021)
				local var_96_3 = arg_93_1:FormatText(var_96_2.content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 33
				local var_96_5 = utf8.len(var_96_3)
				local var_96_6 = var_96_4 <= 0 and var_96_1 or var_96_1 * (var_96_5 / var_96_4)

				if var_96_6 > 0 and var_96_1 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_7 and arg_93_1.time_ < var_96_0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play423011022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 423011022
		arg_97_1.duration_ = 7.73

		local var_97_0 = {
			zh = 5.9,
			ja = 7.733
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
				arg_97_0:Play423011023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.7

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[224].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladya")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(423011022)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 28
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011022", "story_v_out_423011.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011022", "story_v_out_423011.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_423011", "423011022", "story_v_out_423011.awb")

						arg_97_1:RecordAudio("423011022", var_100_9)
						arg_97_1:RecordAudio("423011022", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_423011", "423011022", "story_v_out_423011.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_423011", "423011022", "story_v_out_423011.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play423011023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 423011023
		arg_101_1.duration_ = 7.03

		local var_101_0 = {
			zh = 4.833,
			ja = 7.033
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
				arg_101_0:Play423011024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.225

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(423011023)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 49
				local var_104_5 = utf8.len(var_104_3)
				local var_104_6 = var_104_4 <= 0 and var_104_1 or var_104_1 * (var_104_5 / var_104_4)

				if var_104_6 > 0 and var_104_1 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011023", "story_v_out_423011.awb") ~= 0 then
					local var_104_7 = manager.audio:GetVoiceLength("story_v_out_423011", "423011023", "story_v_out_423011.awb") / 1000

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end

					if var_104_2.prefab_name ~= "" and arg_101_1.actors_[var_104_2.prefab_name] ~= nil then
						local var_104_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_2.prefab_name].transform, "story_v_out_423011", "423011023", "story_v_out_423011.awb")

						arg_101_1:RecordAudio("423011023", var_104_8)
						arg_101_1:RecordAudio("423011023", var_104_8)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_423011", "423011023", "story_v_out_423011.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_423011", "423011023", "story_v_out_423011.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_9 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_9 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_9

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_9 and arg_101_1.time_ < var_104_0 + var_104_9 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play423011024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 423011024
		arg_105_1.duration_ = 9.9

		local var_105_0 = {
			zh = 7.8,
			ja = 9.9
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
				arg_105_0:Play423011025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 1.275

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(423011024)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 51
				local var_108_5 = utf8.len(var_108_3)
				local var_108_6 = var_108_4 <= 0 and var_108_1 or var_108_1 * (var_108_5 / var_108_4)

				if var_108_6 > 0 and var_108_1 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011024", "story_v_out_423011.awb") ~= 0 then
					local var_108_7 = manager.audio:GetVoiceLength("story_v_out_423011", "423011024", "story_v_out_423011.awb") / 1000

					if var_108_7 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_7 + var_108_0
					end

					if var_108_2.prefab_name ~= "" and arg_105_1.actors_[var_108_2.prefab_name] ~= nil then
						local var_108_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_2.prefab_name].transform, "story_v_out_423011", "423011024", "story_v_out_423011.awb")

						arg_105_1:RecordAudio("423011024", var_108_8)
						arg_105_1:RecordAudio("423011024", var_108_8)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_423011", "423011024", "story_v_out_423011.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_423011", "423011024", "story_v_out_423011.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_9 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_9 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_9

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_9 and arg_105_1.time_ < var_108_0 + var_108_9 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play423011025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 423011025
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play423011026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.325

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[7].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:GetWordFromCfg(423011025)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 13
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_8 and arg_109_1.time_ < var_112_0 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play423011026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 423011026
		arg_113_1.duration_ = 7.5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play423011027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = "ST0113"

			if arg_113_1.bgs_[var_116_0] == nil then
				local var_116_1 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_116_0)
				var_116_1.name = var_116_0
				var_116_1.transform.parent = arg_113_1.stage_.transform
				var_116_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_[var_116_0] = var_116_1
			end

			local var_116_2 = 1

			if var_116_2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				local var_116_3 = manager.ui.mainCamera.transform.localPosition
				local var_116_4 = Vector3.New(0, 0, 10) + Vector3.New(var_116_3.x, var_116_3.y, 0)
				local var_116_5 = arg_113_1.bgs_.ST0113

				var_116_5.transform.localPosition = var_116_4
				var_116_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_6 = var_116_5:GetComponent("SpriteRenderer")

				if var_116_6 and var_116_6.sprite then
					local var_116_7 = (var_116_5.transform.localPosition - var_116_3).z
					local var_116_8 = manager.ui.mainCameraCom_
					local var_116_9 = 2 * var_116_7 * Mathf.Tan(var_116_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_116_10 = var_116_9 * var_116_8.aspect
					local var_116_11 = var_116_6.sprite.bounds.size.x
					local var_116_12 = var_116_6.sprite.bounds.size.y
					local var_116_13 = var_116_10 / var_116_11
					local var_116_14 = var_116_9 / var_116_12
					local var_116_15 = var_116_14 < var_116_13 and var_116_13 or var_116_14

					var_116_5.transform.localScale = Vector3.New(var_116_15, var_116_15, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "ST0113" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_17 = 1

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17
				local var_116_19 = Color.New(0, 0, 0)

				var_116_19.a = Mathf.Lerp(0, 1, var_116_18)
				arg_113_1.mask_.color = var_116_19
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 then
				local var_116_20 = Color.New(0, 0, 0)

				var_116_20.a = 1
				arg_113_1.mask_.color = var_116_20
			end

			local var_116_21 = 1

			if var_116_21 < arg_113_1.time_ and arg_113_1.time_ <= var_116_21 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_22 = 1

			if var_116_21 <= arg_113_1.time_ and arg_113_1.time_ < var_116_21 + var_116_22 then
				local var_116_23 = (arg_113_1.time_ - var_116_21) / var_116_22
				local var_116_24 = Color.New(0, 0, 0)

				var_116_24.a = Mathf.Lerp(1, 0, var_116_23)
				arg_113_1.mask_.color = var_116_24
			end

			if arg_113_1.time_ >= var_116_21 + var_116_22 and arg_113_1.time_ < var_116_21 + var_116_22 + arg_116_0 then
				local var_116_25 = Color.New(0, 0, 0)
				local var_116_26 = 0

				arg_113_1.mask_.enabled = false
				var_116_25.a = var_116_26
				arg_113_1.mask_.color = var_116_25
			end

			local var_116_27 = manager.ui.mainCamera.transform
			local var_116_28 = 1

			if var_116_28 < arg_113_1.time_ and arg_113_1.time_ <= var_116_28 + arg_116_0 then
				local var_116_29 = arg_113_1.var_.effectchechuangwai2
				local var_116_30
				local var_116_31 = var_116_27

				if not var_116_29 then
					var_116_29 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), var_116_31)
					var_116_29.name = "chechuangwai2"
					arg_113_1.var_.effectchechuangwai2 = var_116_29
				else
					var_116_29.transform:SetParent(var_116_31)
				end

				var_116_29.transform.localPosition = Vector3.New(0, 0, 0)
				var_116_29.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_116_32 = manager.ui.mainCameraCom_
				local var_116_33 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_116_32.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_116_34 = var_116_29.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_116_35 = 15
				local var_116_36 = 2 * var_116_35 * Mathf.Tan(var_116_32.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_116_32.aspect
				local var_116_37 = 1
				local var_116_38 = 1.7777777777777777

				if var_116_38 < var_116_32.aspect then
					var_116_37 = var_116_36 / (2 * var_116_35 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_116_38)
				end

				for iter_116_2, iter_116_3 in ipairs(var_116_34) do
					local var_116_39 = iter_116_3.transform.localScale

					iter_116_3.transform.localScale = Vector3.New(var_116_39.x / var_116_33 * var_116_37, var_116_39.y / var_116_33, var_116_39.z)
				end
			end

			local var_116_40 = arg_113_1.bgs_.ST0113.transform
			local var_116_41 = 1

			if var_116_41 < arg_113_1.time_ and arg_113_1.time_ <= var_116_41 + arg_116_0 then
				arg_113_1.var_.moveOldPosST0113 = var_116_40.localPosition
			end

			local var_116_42 = 6.5

			if var_116_41 <= arg_113_1.time_ and arg_113_1.time_ < var_116_41 + var_116_42 then
				local var_116_43 = (arg_113_1.time_ - var_116_41) / var_116_42
				local var_116_44 = Vector3.New(0, 1, 10)

				var_116_40.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPosST0113, var_116_44, var_116_43)
			end

			if arg_113_1.time_ >= var_116_41 + var_116_42 and arg_113_1.time_ < var_116_41 + var_116_42 + arg_116_0 then
				var_116_40.localPosition = Vector3.New(0, 1, 10)
			end

			local var_116_45 = manager.ui.mainCamera.transform
			local var_116_46 = 1

			if var_116_46 < arg_113_1.time_ and arg_113_1.time_ <= var_116_46 + arg_116_0 then
				local var_116_47 = arg_113_1.var_.effectchechuangwai1
				local var_116_48
				local var_116_49 = var_116_45

				if not var_116_47 then
					var_116_47 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy_ui"), var_116_49)
					var_116_47.name = "chechuangwai1"
					arg_113_1.var_.effectchechuangwai1 = var_116_47
				else
					var_116_47.transform:SetParent(var_116_49)
				end

				var_116_47.transform.localPosition = Vector3.New(0, 0, 0)
				var_116_47.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_116_50 = manager.ui.mainCameraCom_
				local var_116_51 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_116_50.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_116_52 = var_116_47.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_116_53 = 15
				local var_116_54 = 2 * var_116_53 * Mathf.Tan(var_116_50.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_116_50.aspect
				local var_116_55 = 1
				local var_116_56 = 1.7777777777777777

				if var_116_56 < var_116_50.aspect then
					var_116_55 = var_116_54 / (2 * var_116_53 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_116_56)
				end

				for iter_116_4, iter_116_5 in ipairs(var_116_52) do
					local var_116_57 = iter_116_5.transform.localScale

					iter_116_5.transform.localScale = Vector3.New(var_116_57.x / var_116_51 * var_116_55, var_116_57.y / var_116_51, var_116_57.z)
				end
			end

			local var_116_58 = 2
			local var_116_59 = 1.325

			if var_116_58 < arg_113_1.time_ and arg_113_1.time_ <= var_116_58 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_60 = arg_113_1:GetWordFromCfg(423011026)
				local var_116_61 = arg_113_1:FormatText(var_116_60.content)

				arg_113_1.text_.text = var_116_61

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_62 = 53
				local var_116_63 = utf8.len(var_116_61)
				local var_116_64 = var_116_62 <= 0 and var_116_59 or var_116_59 * (var_116_63 / var_116_62)

				if var_116_64 > 0 and var_116_59 < var_116_64 then
					arg_113_1.talkMaxDuration = var_116_64

					if var_116_64 + var_116_58 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_64 + var_116_58
					end
				end

				arg_113_1.text_.text = var_116_61
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_65 = math.max(var_116_59, arg_113_1.talkMaxDuration)

			if var_116_58 <= arg_113_1.time_ and arg_113_1.time_ < var_116_58 + var_116_65 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_58) / var_116_65

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_58 + var_116_65 and arg_113_1.time_ < var_116_58 + var_116_65 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST0113",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 6.5,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInSine
				}
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play423011027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 423011027
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play423011028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 1

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				local var_120_2 = "play"
				local var_120_3 = "effect"

				arg_117_1:AudioAction(var_120_2, var_120_3, "se_story", "se_story_communication", "")
			end

			local var_120_4 = 0
			local var_120_5 = 0.625

			if var_120_4 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_6 = arg_117_1:FormatText(StoryNameCfg[7].name)

				arg_117_1.leftNameTxt_.text = var_120_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_7 = arg_117_1:GetWordFromCfg(423011027)
				local var_120_8 = arg_117_1:FormatText(var_120_7.content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 25
				local var_120_10 = utf8.len(var_120_8)
				local var_120_11 = var_120_9 <= 0 and var_120_5 or var_120_5 * (var_120_10 / var_120_9)

				if var_120_11 > 0 and var_120_5 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_12 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_12 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_12

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_12 and arg_117_1.time_ < var_120_4 + var_120_12 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play423011028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 423011028
		arg_121_1.duration_ = 7

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play423011029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 1

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				local var_124_1 = manager.ui.mainCamera.transform.localPosition
				local var_124_2 = Vector3.New(0, 0, 10) + Vector3.New(var_124_1.x, var_124_1.y, 0)
				local var_124_3 = arg_121_1.bgs_.ST0111

				var_124_3.transform.localPosition = var_124_2
				var_124_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_124_4 = var_124_3:GetComponent("SpriteRenderer")

				if var_124_4 and var_124_4.sprite then
					local var_124_5 = (var_124_3.transform.localPosition - var_124_1).z
					local var_124_6 = manager.ui.mainCameraCom_
					local var_124_7 = 2 * var_124_5 * Mathf.Tan(var_124_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_124_8 = var_124_7 * var_124_6.aspect
					local var_124_9 = var_124_4.sprite.bounds.size.x
					local var_124_10 = var_124_4.sprite.bounds.size.y
					local var_124_11 = var_124_8 / var_124_9
					local var_124_12 = var_124_7 / var_124_10
					local var_124_13 = var_124_12 < var_124_11 and var_124_11 or var_124_12

					var_124_3.transform.localScale = Vector3.New(var_124_13, var_124_13, 0)
				end

				for iter_124_0, iter_124_1 in pairs(arg_121_1.bgs_) do
					if iter_124_0 ~= "ST0111" then
						iter_124_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_124_14 = 0

			if var_124_14 < arg_121_1.time_ and arg_121_1.time_ <= var_124_14 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_15 = 1

			if var_124_14 <= arg_121_1.time_ and arg_121_1.time_ < var_124_14 + var_124_15 then
				local var_124_16 = (arg_121_1.time_ - var_124_14) / var_124_15
				local var_124_17 = Color.New(0, 0, 0)

				var_124_17.a = Mathf.Lerp(0, 1, var_124_16)
				arg_121_1.mask_.color = var_124_17
			end

			if arg_121_1.time_ >= var_124_14 + var_124_15 and arg_121_1.time_ < var_124_14 + var_124_15 + arg_124_0 then
				local var_124_18 = Color.New(0, 0, 0)

				var_124_18.a = 1
				arg_121_1.mask_.color = var_124_18
			end

			local var_124_19 = 1

			if var_124_19 < arg_121_1.time_ and arg_121_1.time_ <= var_124_19 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_20 = 1

			if var_124_19 <= arg_121_1.time_ and arg_121_1.time_ < var_124_19 + var_124_20 then
				local var_124_21 = (arg_121_1.time_ - var_124_19) / var_124_20
				local var_124_22 = Color.New(0, 0, 0)

				var_124_22.a = Mathf.Lerp(1, 0, var_124_21)
				arg_121_1.mask_.color = var_124_22
			end

			if arg_121_1.time_ >= var_124_19 + var_124_20 and arg_121_1.time_ < var_124_19 + var_124_20 + arg_124_0 then
				local var_124_23 = Color.New(0, 0, 0)
				local var_124_24 = 0

				arg_121_1.mask_.enabled = false
				var_124_23.a = var_124_24
				arg_121_1.mask_.color = var_124_23
			end

			local var_124_25 = manager.ui.mainCamera.transform
			local var_124_26 = 1

			if var_124_26 < arg_121_1.time_ and arg_121_1.time_ <= var_124_26 + arg_124_0 then
				local var_124_27 = arg_121_1.var_.effectchechuangwai2

				if var_124_27 then
					Object.Destroy(var_124_27)

					arg_121_1.var_.effectchechuangwai2 = nil
				end
			end

			local var_124_28 = manager.ui.mainCamera.transform
			local var_124_29 = 1

			if var_124_29 < arg_121_1.time_ and arg_121_1.time_ <= var_124_29 + arg_124_0 then
				local var_124_30 = arg_121_1.var_.effectchechuangwai1

				if var_124_30 then
					Object.Destroy(var_124_30)

					arg_121_1.var_.effectchechuangwai1 = nil
				end
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_31 = 2
			local var_124_32 = 0.325

			if var_124_31 < arg_121_1.time_ and arg_121_1.time_ <= var_124_31 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_33 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_33:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_34 = arg_121_1:FormatText(StoryNameCfg[7].name)

				arg_121_1.leftNameTxt_.text = var_124_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_35 = arg_121_1:GetWordFromCfg(423011028)
				local var_124_36 = arg_121_1:FormatText(var_124_35.content)

				arg_121_1.text_.text = var_124_36

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_37 = 13
				local var_124_38 = utf8.len(var_124_36)
				local var_124_39 = var_124_37 <= 0 and var_124_32 or var_124_32 * (var_124_38 / var_124_37)

				if var_124_39 > 0 and var_124_32 < var_124_39 then
					arg_121_1.talkMaxDuration = var_124_39
					var_124_31 = var_124_31 + 0.3

					if var_124_39 + var_124_31 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_39 + var_124_31
					end
				end

				arg_121_1.text_.text = var_124_36
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_40 = var_124_31 + 0.3
			local var_124_41 = math.max(var_124_32, arg_121_1.talkMaxDuration)

			if var_124_40 <= arg_121_1.time_ and arg_121_1.time_ < var_124_40 + var_124_41 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_40) / var_124_41

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_40 + var_124_41 and arg_121_1.time_ < var_124_40 + var_124_41 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play423011029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 423011029
		arg_127_1.duration_ = 9.3

		local var_127_0 = {
			zh = 5.5,
			ja = 9.3
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play423011030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "1047"

			if arg_127_1.actors_[var_130_0] == nil then
				local var_130_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1047")

				if not isNil(var_130_1) then
					local var_130_2 = Object.Instantiate(var_130_1, arg_127_1.canvasGo_.transform)

					var_130_2.transform:SetSiblingIndex(1)

					var_130_2.name = var_130_0
					var_130_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_127_1.actors_[var_130_0] = var_130_2

					local var_130_3 = var_130_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_127_1.isInRecall_ then
						for iter_130_0, iter_130_1 in ipairs(var_130_3) do
							iter_130_1.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_130_4 = arg_127_1.actors_["1047"].transform
			local var_130_5 = 0

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.var_.moveOldPos1047 = var_130_4.localPosition
				var_130_4.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1047", 3)

				local var_130_6 = var_130_4.childCount

				for iter_130_2 = 0, var_130_6 - 1 do
					local var_130_7 = var_130_4:GetChild(iter_130_2)

					if var_130_7.name == "" or not string.find(var_130_7.name, "split") then
						var_130_7.gameObject:SetActive(true)
					else
						var_130_7.gameObject:SetActive(false)
					end
				end
			end

			local var_130_8 = 0.001

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_8 then
				local var_130_9 = (arg_127_1.time_ - var_130_5) / var_130_8
				local var_130_10 = Vector3.New(-38.9, -360, -319.3)

				var_130_4.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1047, var_130_10, var_130_9)
			end

			if arg_127_1.time_ >= var_130_5 + var_130_8 and arg_127_1.time_ < var_130_5 + var_130_8 + arg_130_0 then
				var_130_4.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_130_11 = arg_127_1.actors_["1047"]
			local var_130_12 = 0

			if var_130_12 < arg_127_1.time_ and arg_127_1.time_ <= var_130_12 + arg_130_0 then
				arg_127_1:SetSpriteNiuquEffect("1047", true)
			end

			local var_130_13 = arg_127_1.actors_["1047"]
			local var_130_14 = 0

			if var_130_14 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				local var_130_15 = var_130_13:GetComponentInChildren(typeof(CanvasGroup))

				if var_130_15 then
					arg_127_1.var_.alphaOldValue1047 = var_130_15.alpha
					arg_127_1.var_.characterEffect1047 = var_130_15
				end
			end

			local var_130_16 = 0.5

			if var_130_14 <= arg_127_1.time_ and arg_127_1.time_ < var_130_14 + var_130_16 then
				local var_130_17 = (arg_127_1.time_ - var_130_14) / var_130_16
				local var_130_18 = Mathf.Lerp(arg_127_1.var_.alphaOldValue1047, 0.6, var_130_17)

				if arg_127_1.var_.characterEffect1047 then
					arg_127_1.var_.characterEffect1047.alpha = var_130_18
				end
			end

			if arg_127_1.time_ >= var_130_14 + var_130_16 and arg_127_1.time_ < var_130_14 + var_130_16 + arg_130_0 and arg_127_1.var_.characterEffect1047 then
				arg_127_1.var_.characterEffect1047.alpha = 0.6
			end

			local var_130_19 = 0
			local var_130_20 = 0.825

			if var_130_19 < arg_127_1.time_ and arg_127_1.time_ <= var_130_19 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_21 = arg_127_1:FormatText(StoryNameCfg[1296].name)

				arg_127_1.leftNameTxt_.text = var_130_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_22 = arg_127_1:GetWordFromCfg(423011029)
				local var_130_23 = arg_127_1:FormatText(var_130_22.content)

				arg_127_1.text_.text = var_130_23

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_24 = 33
				local var_130_25 = utf8.len(var_130_23)
				local var_130_26 = var_130_24 <= 0 and var_130_20 or var_130_20 * (var_130_25 / var_130_24)

				if var_130_26 > 0 and var_130_20 < var_130_26 then
					arg_127_1.talkMaxDuration = var_130_26

					if var_130_26 + var_130_19 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_26 + var_130_19
					end
				end

				arg_127_1.text_.text = var_130_23
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011029", "story_v_out_423011.awb") ~= 0 then
					local var_130_27 = manager.audio:GetVoiceLength("story_v_out_423011", "423011029", "story_v_out_423011.awb") / 1000

					if var_130_27 + var_130_19 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_27 + var_130_19
					end

					if var_130_22.prefab_name ~= "" and arg_127_1.actors_[var_130_22.prefab_name] ~= nil then
						local var_130_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_22.prefab_name].transform, "story_v_out_423011", "423011029", "story_v_out_423011.awb")

						arg_127_1:RecordAudio("423011029", var_130_28)
						arg_127_1:RecordAudio("423011029", var_130_28)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_423011", "423011029", "story_v_out_423011.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_423011", "423011029", "story_v_out_423011.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_29 = math.max(var_130_20, arg_127_1.talkMaxDuration)

			if var_130_19 <= arg_127_1.time_ and arg_127_1.time_ < var_130_19 + var_130_29 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_19) / var_130_29

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_19 + var_130_29 and arg_127_1.time_ < var_130_19 + var_130_29 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play423011030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 423011030
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play423011031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.725

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(423011030)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 29
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play423011031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 423011031
		arg_135_1.duration_ = 7.9

		local var_135_0 = {
			zh = 6.3,
			ja = 7.9
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play423011032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0
			local var_138_1 = 0.675

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_2 = arg_135_1:FormatText(StoryNameCfg[1296].name)

				arg_135_1.leftNameTxt_.text = var_138_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_3 = arg_135_1:GetWordFromCfg(423011031)
				local var_138_4 = arg_135_1:FormatText(var_138_3.content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_5 = 27
				local var_138_6 = utf8.len(var_138_4)
				local var_138_7 = var_138_5 <= 0 and var_138_1 or var_138_1 * (var_138_6 / var_138_5)

				if var_138_7 > 0 and var_138_1 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011031", "story_v_out_423011.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011031", "story_v_out_423011.awb") / 1000

					if var_138_8 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_0
					end

					if var_138_3.prefab_name ~= "" and arg_135_1.actors_[var_138_3.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_3.prefab_name].transform, "story_v_out_423011", "423011031", "story_v_out_423011.awb")

						arg_135_1:RecordAudio("423011031", var_138_9)
						arg_135_1:RecordAudio("423011031", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_423011", "423011031", "story_v_out_423011.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_423011", "423011031", "story_v_out_423011.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_10 and arg_135_1.time_ < var_138_0 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play423011032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 423011032
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play423011033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 0.6

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_2 = arg_139_1:FormatText(StoryNameCfg[7].name)

				arg_139_1.leftNameTxt_.text = var_142_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_3 = arg_139_1:GetWordFromCfg(423011032)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_5 = 24
				local var_142_6 = utf8.len(var_142_4)
				local var_142_7 = var_142_5 <= 0 and var_142_1 or var_142_1 * (var_142_6 / var_142_5)

				if var_142_7 > 0 and var_142_1 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_8 and arg_139_1.time_ < var_142_0 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play423011033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 423011033
		arg_143_1.duration_ = 4.33

		local var_143_0 = {
			zh = 3.933,
			ja = 4.333
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
				arg_143_0:Play423011034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.425

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[1296].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:GetWordFromCfg(423011033)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 17
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011033", "story_v_out_423011.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011033", "story_v_out_423011.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_423011", "423011033", "story_v_out_423011.awb")

						arg_143_1:RecordAudio("423011033", var_146_9)
						arg_143_1:RecordAudio("423011033", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_423011", "423011033", "story_v_out_423011.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_423011", "423011033", "story_v_out_423011.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play423011034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 423011034
		arg_147_1.duration_ = 1

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"

			SetActive(arg_147_1.choicesGo_, true)

			for iter_148_0, iter_148_1 in ipairs(arg_147_1.choices_) do
				local var_148_0 = iter_148_0 <= 2

				SetActive(iter_148_1.go, var_148_0)
			end

			arg_147_1.choices_[1].txt.text = arg_147_1:FormatText(StoryChoiceCfg[1359].name)
			arg_147_1.choices_[2].txt.text = arg_147_1:FormatText(StoryChoiceCfg[1360].name)
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play423011035(arg_147_1)
			end

			if arg_149_0 == 2 then
				arg_147_0:Play423011038(arg_147_1)
			end

			arg_147_1:RecordChoiceLog(423011034, 1359, 1360)
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			local var_150_1 = 0.5

			if arg_147_1.time_ >= var_150_0 + var_150_1 and arg_147_1.time_ < var_150_0 + var_150_1 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play423011035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 423011035
		arg_151_1.duration_ = 5.97

		local var_151_0 = {
			zh = 5,
			ja = 5.966
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play423011036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.625

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[1296].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(423011035)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 25
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011035", "story_v_out_423011.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011035", "story_v_out_423011.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_423011", "423011035", "story_v_out_423011.awb")

						arg_151_1:RecordAudio("423011035", var_154_9)
						arg_151_1:RecordAudio("423011035", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_423011", "423011035", "story_v_out_423011.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_423011", "423011035", "story_v_out_423011.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_10 and arg_151_1.time_ < var_154_0 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play423011036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 423011036
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play423011037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.15

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[7].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(423011036)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 6
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_8 and arg_155_1.time_ < var_158_0 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play423011037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 423011037
		arg_159_1.duration_ = 3.6

		local var_159_0 = {
			zh = 2.533,
			ja = 3.6
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play423011041(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.25

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[1296].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(423011037)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 10
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011037", "story_v_out_423011.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011037", "story_v_out_423011.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_423011", "423011037", "story_v_out_423011.awb")

						arg_159_1:RecordAudio("423011037", var_162_9)
						arg_159_1:RecordAudio("423011037", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_423011", "423011037", "story_v_out_423011.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_423011", "423011037", "story_v_out_423011.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play423011041 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 423011041
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play423011042(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.95

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_2 = arg_163_1:GetWordFromCfg(423011041)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 38
				local var_166_5 = utf8.len(var_166_3)
				local var_166_6 = var_166_4 <= 0 and var_166_1 or var_166_1 * (var_166_5 / var_166_4)

				if var_166_6 > 0 and var_166_1 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_7 and arg_163_1.time_ < var_166_0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play423011042 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 423011042
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play423011043(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0
			local var_170_1 = 0.75

			if var_170_0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_2 = arg_167_1:FormatText(StoryNameCfg[7].name)

				arg_167_1.leftNameTxt_.text = var_170_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_3 = arg_167_1:GetWordFromCfg(423011042)
				local var_170_4 = arg_167_1:FormatText(var_170_3.content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 30
				local var_170_6 = utf8.len(var_170_4)
				local var_170_7 = var_170_5 <= 0 and var_170_1 or var_170_1 * (var_170_6 / var_170_5)

				if var_170_7 > 0 and var_170_1 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_0
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_8 = math.max(var_170_1, arg_167_1.talkMaxDuration)

			if var_170_0 <= arg_167_1.time_ and arg_167_1.time_ < var_170_0 + var_170_8 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_0) / var_170_8

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_0 + var_170_8 and arg_167_1.time_ < var_170_0 + var_170_8 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play423011043 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 423011043
		arg_171_1.duration_ = 9.03

		local var_171_0 = {
			zh = 4.366,
			ja = 9.033
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play423011044(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 0.475

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[1296].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(423011043)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 19
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011043", "story_v_out_423011.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011043", "story_v_out_423011.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_423011", "423011043", "story_v_out_423011.awb")

						arg_171_1:RecordAudio("423011043", var_174_9)
						arg_171_1:RecordAudio("423011043", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_423011", "423011043", "story_v_out_423011.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_423011", "423011043", "story_v_out_423011.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play423011044 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 423011044
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play423011045(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.525

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_3 = arg_175_1:GetWordFromCfg(423011044)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 21
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
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_8 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_8 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_8

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_8 and arg_175_1.time_ < var_178_0 + var_178_8 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play423011045 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 423011045
		arg_179_1.duration_ = 12.53

		local var_179_0 = {
			zh = 8.1,
			ja = 12.533
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
				arg_179_0:Play423011046(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0
			local var_182_1 = 0.9

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_2 = arg_179_1:FormatText(StoryNameCfg[1296].name)

				arg_179_1.leftNameTxt_.text = var_182_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:GetWordFromCfg(423011045)
				local var_182_4 = arg_179_1:FormatText(var_182_3.content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011045", "story_v_out_423011.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011045", "story_v_out_423011.awb") / 1000

					if var_182_8 + var_182_0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_0
					end

					if var_182_3.prefab_name ~= "" and arg_179_1.actors_[var_182_3.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_3.prefab_name].transform, "story_v_out_423011", "423011045", "story_v_out_423011.awb")

						arg_179_1:RecordAudio("423011045", var_182_9)
						arg_179_1:RecordAudio("423011045", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_423011", "423011045", "story_v_out_423011.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_423011", "423011045", "story_v_out_423011.awb")
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
	Play423011046 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 423011046
		arg_183_1.duration_ = 10.9

		local var_183_0 = {
			zh = 6.833,
			ja = 10.9
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play423011047(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.7

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[1296].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:GetWordFromCfg(423011046)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 28
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011046", "story_v_out_423011.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011046", "story_v_out_423011.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_423011", "423011046", "story_v_out_423011.awb")

						arg_183_1:RecordAudio("423011046", var_186_9)
						arg_183_1:RecordAudio("423011046", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_423011", "423011046", "story_v_out_423011.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_423011", "423011046", "story_v_out_423011.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play423011047 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 423011047
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play423011048(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0
			local var_190_1 = 0.5

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_2 = arg_187_1:FormatText(StoryNameCfg[7].name)

				arg_187_1.leftNameTxt_.text = var_190_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_3 = arg_187_1:GetWordFromCfg(423011047)
				local var_190_4 = arg_187_1:FormatText(var_190_3.content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 20
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
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_8 = math.max(var_190_1, arg_187_1.talkMaxDuration)

			if var_190_0 <= arg_187_1.time_ and arg_187_1.time_ < var_190_0 + var_190_8 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_0) / var_190_8

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_0 + var_190_8 and arg_187_1.time_ < var_190_0 + var_190_8 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play423011048 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 423011048
		arg_191_1.duration_ = 12

		local var_191_0 = {
			zh = 5.966,
			ja = 12
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play423011049(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.675

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[1296].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:GetWordFromCfg(423011048)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 27
				local var_194_6 = utf8.len(var_194_4)
				local var_194_7 = var_194_5 <= 0 and var_194_1 or var_194_1 * (var_194_6 / var_194_5)

				if var_194_7 > 0 and var_194_1 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011048", "story_v_out_423011.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011048", "story_v_out_423011.awb") / 1000

					if var_194_8 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_0
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_423011", "423011048", "story_v_out_423011.awb")

						arg_191_1:RecordAudio("423011048", var_194_9)
						arg_191_1:RecordAudio("423011048", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_423011", "423011048", "story_v_out_423011.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_423011", "423011048", "story_v_out_423011.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_10 and arg_191_1.time_ < var_194_0 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play423011049 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 423011049
		arg_195_1.duration_ = 9.2

		local var_195_0 = {
			zh = 5.5,
			ja = 9.2
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play423011050(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 0.675

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[1296].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:GetWordFromCfg(423011049)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 27
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011049", "story_v_out_423011.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011049", "story_v_out_423011.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_423011", "423011049", "story_v_out_423011.awb")

						arg_195_1:RecordAudio("423011049", var_198_9)
						arg_195_1:RecordAudio("423011049", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_423011", "423011049", "story_v_out_423011.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_423011", "423011049", "story_v_out_423011.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_10 and arg_195_1.time_ < var_198_0 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play423011050 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 423011050
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play423011051(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 0.55

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[7].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_3 = arg_199_1:GetWordFromCfg(423011050)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 22
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_8 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_8 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_8

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_8 and arg_199_1.time_ < var_202_0 + var_202_8 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play423011051 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 423011051
		arg_203_1.duration_ = 7.2

		local var_203_0 = {
			zh = 6,
			ja = 7.2
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play423011052(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 0.65

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[1296].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(423011051)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 26
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011051", "story_v_out_423011.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011051", "story_v_out_423011.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_423011", "423011051", "story_v_out_423011.awb")

						arg_203_1:RecordAudio("423011051", var_206_9)
						arg_203_1:RecordAudio("423011051", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_423011", "423011051", "story_v_out_423011.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_423011", "423011051", "story_v_out_423011.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play423011052 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 423011052
		arg_207_1.duration_ = 9

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play423011053(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 2

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				local var_210_1 = manager.ui.mainCamera.transform.localPosition
				local var_210_2 = Vector3.New(0, 0, 10) + Vector3.New(var_210_1.x, var_210_1.y, 0)
				local var_210_3 = arg_207_1.bgs_.ST0111

				var_210_3.transform.localPosition = var_210_2
				var_210_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_4 = var_210_3:GetComponent("SpriteRenderer")

				if var_210_4 and var_210_4.sprite then
					local var_210_5 = (var_210_3.transform.localPosition - var_210_1).z
					local var_210_6 = manager.ui.mainCameraCom_
					local var_210_7 = 2 * var_210_5 * Mathf.Tan(var_210_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_210_8 = var_210_7 * var_210_6.aspect
					local var_210_9 = var_210_4.sprite.bounds.size.x
					local var_210_10 = var_210_4.sprite.bounds.size.y
					local var_210_11 = var_210_8 / var_210_9
					local var_210_12 = var_210_7 / var_210_10
					local var_210_13 = var_210_12 < var_210_11 and var_210_11 or var_210_12

					var_210_3.transform.localScale = Vector3.New(var_210_13, var_210_13, 0)
				end

				for iter_210_0, iter_210_1 in pairs(arg_207_1.bgs_) do
					if iter_210_0 ~= "ST0111" then
						iter_210_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_14 = 3.999999999999

			if var_210_14 < arg_207_1.time_ and arg_207_1.time_ <= var_210_14 + arg_210_0 then
				arg_207_1.allBtn_.enabled = false
			end

			local var_210_15 = 0.3

			if arg_207_1.time_ >= var_210_14 + var_210_15 and arg_207_1.time_ < var_210_14 + var_210_15 + arg_210_0 then
				arg_207_1.allBtn_.enabled = true
			end

			local var_210_16 = 0

			if var_210_16 < arg_207_1.time_ and arg_207_1.time_ <= var_210_16 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_17 = 2

			if var_210_16 <= arg_207_1.time_ and arg_207_1.time_ < var_210_16 + var_210_17 then
				local var_210_18 = (arg_207_1.time_ - var_210_16) / var_210_17
				local var_210_19 = Color.New(0, 0, 0)

				var_210_19.a = Mathf.Lerp(0, 1, var_210_18)
				arg_207_1.mask_.color = var_210_19
			end

			if arg_207_1.time_ >= var_210_16 + var_210_17 and arg_207_1.time_ < var_210_16 + var_210_17 + arg_210_0 then
				local var_210_20 = Color.New(0, 0, 0)

				var_210_20.a = 1
				arg_207_1.mask_.color = var_210_20
			end

			local var_210_21 = 2

			if var_210_21 < arg_207_1.time_ and arg_207_1.time_ <= var_210_21 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_22 = 2

			if var_210_21 <= arg_207_1.time_ and arg_207_1.time_ < var_210_21 + var_210_22 then
				local var_210_23 = (arg_207_1.time_ - var_210_21) / var_210_22
				local var_210_24 = Color.New(0, 0, 0)

				var_210_24.a = Mathf.Lerp(1, 0, var_210_23)
				arg_207_1.mask_.color = var_210_24
			end

			if arg_207_1.time_ >= var_210_21 + var_210_22 and arg_207_1.time_ < var_210_21 + var_210_22 + arg_210_0 then
				local var_210_25 = Color.New(0, 0, 0)
				local var_210_26 = 0

				arg_207_1.mask_.enabled = false
				var_210_25.a = var_210_26
				arg_207_1.mask_.color = var_210_25
			end

			local var_210_27 = arg_207_1.actors_["1047"]
			local var_210_28 = 1.966

			if var_210_28 < arg_207_1.time_ and arg_207_1.time_ <= var_210_28 + arg_210_0 and not isNil(var_210_27) and arg_207_1.var_.actorSpriteComps1047 == nil then
				arg_207_1.var_.actorSpriteComps1047 = var_210_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_29 = 0.034

			if var_210_28 <= arg_207_1.time_ and arg_207_1.time_ < var_210_28 + var_210_29 and not isNil(var_210_27) then
				local var_210_30 = (arg_207_1.time_ - var_210_28) / var_210_29

				if arg_207_1.var_.actorSpriteComps1047 then
					for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_210_3 then
							if arg_207_1.isInRecall_ then
								local var_210_31 = Mathf.Lerp(iter_210_3.color.r, arg_207_1.hightColor2.r, var_210_30)
								local var_210_32 = Mathf.Lerp(iter_210_3.color.g, arg_207_1.hightColor2.g, var_210_30)
								local var_210_33 = Mathf.Lerp(iter_210_3.color.b, arg_207_1.hightColor2.b, var_210_30)

								iter_210_3.color = Color.New(var_210_31, var_210_32, var_210_33)
							else
								local var_210_34 = Mathf.Lerp(iter_210_3.color.r, 0.5, var_210_30)

								iter_210_3.color = Color.New(var_210_34, var_210_34, var_210_34)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= var_210_28 + var_210_29 and arg_207_1.time_ < var_210_28 + var_210_29 + arg_210_0 and not isNil(var_210_27) and arg_207_1.var_.actorSpriteComps1047 then
				for iter_210_4, iter_210_5 in pairs(arg_207_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_210_5 then
						if arg_207_1.isInRecall_ then
							iter_210_5.color = arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_210_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_207_1.var_.actorSpriteComps1047 = nil
			end

			local var_210_35 = arg_207_1.actors_["1047"].transform
			local var_210_36 = 1.966

			if var_210_36 < arg_207_1.time_ and arg_207_1.time_ <= var_210_36 + arg_210_0 then
				arg_207_1.var_.moveOldPos1047 = var_210_35.localPosition
				var_210_35.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("1047", 7)

				local var_210_37 = var_210_35.childCount

				for iter_210_6 = 0, var_210_37 - 1 do
					local var_210_38 = var_210_35:GetChild(iter_210_6)

					if var_210_38.name == "" or not string.find(var_210_38.name, "split") then
						var_210_38.gameObject:SetActive(true)
					else
						var_210_38.gameObject:SetActive(false)
					end
				end
			end

			local var_210_39 = 0.001

			if var_210_36 <= arg_207_1.time_ and arg_207_1.time_ < var_210_36 + var_210_39 then
				local var_210_40 = (arg_207_1.time_ - var_210_36) / var_210_39
				local var_210_41 = Vector3.New(0, -2000, 0)

				var_210_35.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1047, var_210_41, var_210_40)
			end

			if arg_207_1.time_ >= var_210_36 + var_210_39 and arg_207_1.time_ < var_210_36 + var_210_39 + arg_210_0 then
				var_210_35.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_210_42 = arg_207_1.actors_["1047"]
			local var_210_43 = 2

			if var_210_43 < arg_207_1.time_ and arg_207_1.time_ <= var_210_43 + arg_210_0 then
				arg_207_1:SetSpriteNiuquEffect("1047", false)
			end

			if arg_207_1.frameCnt_ <= 1 then
				arg_207_1.dialog_:SetActive(false)
			end

			local var_210_44 = 4
			local var_210_45 = 0.6

			if var_210_44 < arg_207_1.time_ and arg_207_1.time_ <= var_210_44 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				arg_207_1.dialog_:SetActive(true)

				arg_207_1.dialogCg_.alpha = 0

				local var_210_46 = LeanTween.value(arg_207_1.dialog_, 0, 1, 0.3)

				var_210_46:setOnUpdate(LuaHelper.FloatAction(function(arg_211_0)
					arg_207_1.dialogCg_.alpha = arg_211_0
				end))
				var_210_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_207_1.dialog_)
					var_210_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_207_1.duration_ = arg_207_1.duration_ + 0.3

				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_47 = arg_207_1:GetWordFromCfg(423011052)
				local var_210_48 = arg_207_1:FormatText(var_210_47.content)

				arg_207_1.text_.text = var_210_48

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_49 = 24
				local var_210_50 = utf8.len(var_210_48)
				local var_210_51 = var_210_49 <= 0 and var_210_45 or var_210_45 * (var_210_50 / var_210_49)

				if var_210_51 > 0 and var_210_45 < var_210_51 then
					arg_207_1.talkMaxDuration = var_210_51
					var_210_44 = var_210_44 + 0.3

					if var_210_51 + var_210_44 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_51 + var_210_44
					end
				end

				arg_207_1.text_.text = var_210_48
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_52 = var_210_44 + 0.3
			local var_210_53 = math.max(var_210_45, arg_207_1.talkMaxDuration)

			if var_210_52 <= arg_207_1.time_ and arg_207_1.time_ < var_210_52 + var_210_53 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_52) / var_210_53

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_52 + var_210_53 and arg_207_1.time_ < var_210_52 + var_210_53 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play423011053 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 423011053
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play423011054(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.575

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[7].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_3 = arg_213_1:GetWordFromCfg(423011053)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 23
				local var_216_6 = utf8.len(var_216_4)
				local var_216_7 = var_216_5 <= 0 and var_216_1 or var_216_1 * (var_216_6 / var_216_5)

				if var_216_7 > 0 and var_216_1 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_0
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_8 = math.max(var_216_1, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_8 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_0) / var_216_8

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_8 and arg_213_1.time_ < var_216_0 + var_216_8 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play423011054 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 423011054
		arg_217_1.duration_ = 18.3

		local var_217_0 = {
			zh = 11.466,
			ja = 18.3
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
				arg_217_0:Play423011055(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 1.3

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[672].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(423011054)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 52
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

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011054", "story_v_out_423011.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011054", "story_v_out_423011.awb") / 1000

					if var_220_8 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_0
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_423011", "423011054", "story_v_out_423011.awb")

						arg_217_1:RecordAudio("423011054", var_220_9)
						arg_217_1:RecordAudio("423011054", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_423011", "423011054", "story_v_out_423011.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_423011", "423011054", "story_v_out_423011.awb")
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
	Play423011055 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 423011055
		arg_221_1.duration_ = 13.83

		local var_221_0 = {
			zh = 10.4,
			ja = 13.833
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
				arg_221_0:Play423011056(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 1.125

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[672].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(423011055)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 45
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011055", "story_v_out_423011.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011055", "story_v_out_423011.awb") / 1000

					if var_224_8 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_0
					end

					if var_224_3.prefab_name ~= "" and arg_221_1.actors_[var_224_3.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_3.prefab_name].transform, "story_v_out_423011", "423011055", "story_v_out_423011.awb")

						arg_221_1:RecordAudio("423011055", var_224_9)
						arg_221_1:RecordAudio("423011055", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_423011", "423011055", "story_v_out_423011.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_423011", "423011055", "story_v_out_423011.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_10 and arg_221_1.time_ < var_224_0 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play423011056 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 423011056
		arg_225_1.duration_ = 11.47

		local var_225_0 = {
			zh = 6.733,
			ja = 11.466
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
				arg_225_0:Play423011057(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.1
			local var_228_1 = 1

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				local var_228_2 = "play"
				local var_228_3 = "effect"

				arg_225_1:AudioAction(var_228_2, var_228_3, "se_story_16", "se_story_16_channel", "")
			end

			local var_228_4 = 0
			local var_228_5 = 0.725

			if var_228_4 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_6 = arg_225_1:FormatText(StoryNameCfg[672].name)

				arg_225_1.leftNameTxt_.text = var_228_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_7 = arg_225_1:GetWordFromCfg(423011056)
				local var_228_8 = arg_225_1:FormatText(var_228_7.content)

				arg_225_1.text_.text = var_228_8

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 29
				local var_228_10 = utf8.len(var_228_8)
				local var_228_11 = var_228_9 <= 0 and var_228_5 or var_228_5 * (var_228_10 / var_228_9)

				if var_228_11 > 0 and var_228_5 < var_228_11 then
					arg_225_1.talkMaxDuration = var_228_11

					if var_228_11 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_8
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011056", "story_v_out_423011.awb") ~= 0 then
					local var_228_12 = manager.audio:GetVoiceLength("story_v_out_423011", "423011056", "story_v_out_423011.awb") / 1000

					if var_228_12 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_12 + var_228_4
					end

					if var_228_7.prefab_name ~= "" and arg_225_1.actors_[var_228_7.prefab_name] ~= nil then
						local var_228_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_7.prefab_name].transform, "story_v_out_423011", "423011056", "story_v_out_423011.awb")

						arg_225_1:RecordAudio("423011056", var_228_13)
						arg_225_1:RecordAudio("423011056", var_228_13)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_423011", "423011056", "story_v_out_423011.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_423011", "423011056", "story_v_out_423011.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_14 and arg_225_1.time_ < var_228_4 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play423011057 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 423011057
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play423011058(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 1.425

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

				local var_232_2 = arg_229_1:GetWordFromCfg(423011057)
				local var_232_3 = arg_229_1:FormatText(var_232_2.content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 57
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
	Play423011058 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 423011058
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play423011059(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.4

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[7].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:GetWordFromCfg(423011058)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 16
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_8 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_8 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_8

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_8 and arg_233_1.time_ < var_236_0 + var_236_8 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play423011059 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 423011059
		arg_237_1.duration_ = 5.23

		local var_237_0 = {
			zh = 5.233,
			ja = 3.966
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play423011060(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.5

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[1327].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:GetWordFromCfg(423011059)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 20
				local var_240_6 = utf8.len(var_240_4)
				local var_240_7 = var_240_5 <= 0 and var_240_1 or var_240_1 * (var_240_6 / var_240_5)

				if var_240_7 > 0 and var_240_1 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011059", "story_v_out_423011.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011059", "story_v_out_423011.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_423011", "423011059", "story_v_out_423011.awb")

						arg_237_1:RecordAudio("423011059", var_240_9)
						arg_237_1:RecordAudio("423011059", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_423011", "423011059", "story_v_out_423011.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_423011", "423011059", "story_v_out_423011.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_10 and arg_237_1.time_ < var_240_0 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play423011060 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 423011060
		arg_241_1.duration_ = 7

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play423011061(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = manager.ui.mainCamera.transform
			local var_244_1 = 0.1

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.var_.shakeOldPos = var_244_0.localPosition
			end

			local var_244_2 = 1

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / 0.066
				local var_244_4, var_244_5 = math.modf(var_244_3)

				var_244_0.localPosition = Vector3.New(var_244_5 * 0.13, var_244_5 * 0.13, var_244_5 * 0.13) + arg_241_1.var_.shakeOldPos
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 then
				var_244_0.localPosition = arg_241_1.var_.shakeOldPos
			end

			local var_244_6 = 0

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.allBtn_.enabled = false
			end

			local var_244_7 = 2

			if arg_241_1.time_ >= var_244_6 + var_244_7 and arg_241_1.time_ < var_244_6 + var_244_7 + arg_244_0 then
				arg_241_1.allBtn_.enabled = true
			end

			local var_244_8
			local var_244_9 = 0.533333333333333

			if var_244_9 < arg_241_1.time_ and arg_241_1.time_ <= var_244_9 + arg_244_0 then
				local var_244_10 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_244_10 then
					var_244_10.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_244_10.radialBlurScale = 1
					var_244_10.radialBlurGradient = 1
					var_244_10.radialBlurIntensity = 1

					if var_244_8 then
						var_244_10.radialBlurTarget = var_244_8.transform
					end
				end
			end

			local var_244_11 = 1.5

			if var_244_9 <= arg_241_1.time_ and arg_241_1.time_ < var_244_9 + var_244_11 then
				local var_244_12 = (arg_241_1.time_ - var_244_9) / var_244_11
				local var_244_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_244_13 then
					var_244_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_244_13.radialBlurScale = Mathf.Lerp(1, 0.625, var_244_12)
					var_244_13.radialBlurGradient = Mathf.Lerp(1, 1, var_244_12)
					var_244_13.radialBlurIntensity = Mathf.Lerp(1, 1, var_244_12)
				end
			end

			if arg_241_1.time_ >= var_244_9 + var_244_11 and arg_241_1.time_ < var_244_9 + var_244_11 + arg_244_0 then
				local var_244_14 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_244_14 then
					var_244_14.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_244_14.radialBlurScale = 0.625
					var_244_14.radialBlurGradient = 1
					var_244_14.radialBlurIntensity = 1
				end
			end

			local var_244_15 = 0
			local var_244_16 = 1

			if var_244_15 < arg_241_1.time_ and arg_241_1.time_ <= var_244_15 + arg_244_0 then
				local var_244_17 = "play"
				local var_244_18 = "effect"

				arg_241_1:AudioAction(var_244_17, var_244_18, "se_story_144", "se_story_144_train_shake", "")
			end

			local var_244_19 = 0.1
			local var_244_20 = 0.3

			if var_244_19 < arg_241_1.time_ and arg_241_1.time_ <= var_244_19 + arg_244_0 then
				local var_244_21 = "play"
				local var_244_22 = "music"

				arg_241_1:AudioAction(var_244_21, var_244_22, "ui_battle", "ui_battle_stopbgm", "")

				local var_244_23 = ""
				local var_244_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_244_24 ~= "" then
					if arg_241_1.bgmTxt_.text ~= var_244_24 and arg_241_1.bgmTxt_.text ~= "" then
						if arg_241_1.bgmTxt2_.text ~= "" then
							arg_241_1.bgmTxt_.text = arg_241_1.bgmTxt2_.text
						end

						arg_241_1.bgmTxt2_.text = var_244_24

						arg_241_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_241_1.bgmTxt_.text = var_244_24
						arg_241_1.bgmTxt2_.text = var_244_24
					end

					if arg_241_1.bgmTimer then
						arg_241_1.bgmTimer:Stop()

						arg_241_1.bgmTimer = nil
					end

					if arg_241_1.settingData.show_music_name == 1 then
						arg_241_1.musicController:SetSelectedState("show")
						arg_241_1.musicAnimator_:Play("open", 0, 0)

						if arg_241_1.settingData.music_time ~= 0 then
							arg_241_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_241_1.settingData.music_time), function()
								if arg_241_1 == nil or isNil(arg_241_1.bgmTxt_) then
									return
								end

								arg_241_1.musicController:SetSelectedState("hide")
								arg_241_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_244_25 = 0.166666666666667
			local var_244_26 = 1

			if var_244_25 < arg_241_1.time_ and arg_241_1.time_ <= var_244_25 + arg_244_0 then
				local var_244_27 = "stop"
				local var_244_28 = "effect"

				arg_241_1:AudioAction(var_244_27, var_244_28, "se_story_144", "se_story_144_amb_train", "")
			end

			if arg_241_1.frameCnt_ <= 1 then
				arg_241_1.dialog_:SetActive(false)
			end

			local var_244_29 = 2
			local var_244_30 = 1.425

			if var_244_29 < arg_241_1.time_ and arg_241_1.time_ <= var_244_29 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				arg_241_1.dialog_:SetActive(true)

				arg_241_1.dialogCg_.alpha = 0

				local var_244_31 = LeanTween.value(arg_241_1.dialog_, 0, 1, 0.3)

				var_244_31:setOnUpdate(LuaHelper.FloatAction(function(arg_246_0)
					arg_241_1.dialogCg_.alpha = arg_246_0
				end))
				var_244_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_241_1.dialog_)
					var_244_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_241_1.duration_ = arg_241_1.duration_ + 0.3

				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_32 = arg_241_1:GetWordFromCfg(423011060)
				local var_244_33 = arg_241_1:FormatText(var_244_32.content)

				arg_241_1.text_.text = var_244_33

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_34 = 57
				local var_244_35 = utf8.len(var_244_33)
				local var_244_36 = var_244_34 <= 0 and var_244_30 or var_244_30 * (var_244_35 / var_244_34)

				if var_244_36 > 0 and var_244_30 < var_244_36 then
					arg_241_1.talkMaxDuration = var_244_36
					var_244_29 = var_244_29 + 0.3

					if var_244_36 + var_244_29 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_36 + var_244_29
					end
				end

				arg_241_1.text_.text = var_244_33
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_37 = var_244_29 + 0.3
			local var_244_38 = math.max(var_244_30, arg_241_1.talkMaxDuration)

			if var_244_37 <= arg_241_1.time_ and arg_241_1.time_ < var_244_37 + var_244_38 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_37) / var_244_38

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_37 + var_244_38 and arg_241_1.time_ < var_244_37 + var_244_38 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play423011061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 423011061
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play423011062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.1
			local var_251_1 = 1

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				local var_251_2 = "play"
				local var_251_3 = "effect"

				arg_248_1:AudioAction(var_251_2, var_251_3, "se_story_129", "se_story_129_alarm", "")
			end

			local var_251_4 = manager.ui.mainCamera.transform
			local var_251_5 = 0

			if var_251_5 < arg_248_1.time_ and arg_248_1.time_ <= var_251_5 + arg_251_0 then
				local var_251_6 = arg_248_1.var_.effectliechebaozhajinggao1
				local var_251_7
				local var_251_8 = var_251_4

				if not var_251_6 then
					var_251_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), var_251_8)
					var_251_6.name = "liechebaozhajinggao1"
					arg_248_1.var_.effectliechebaozhajinggao1 = var_251_6
				else
					var_251_6.transform:SetParent(var_251_8)
				end

				var_251_6.transform.localPosition = Vector3.New(0, 0, -2)
				var_251_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_251_9 = 1.7777777777777777
				local var_251_10 = Screen.width / Screen.height
				local var_251_11 = var_251_10 / var_251_9
				local var_251_12 = Mathf.Max(var_251_9 / var_251_10, 1)

				var_251_6.transform.localScale = Vector3.New(var_251_6.transform.localScale.x * var_251_11, var_251_6.transform.localScale.y * var_251_12, var_251_6.transform.localScale.z)
			end

			local var_251_13 = 0
			local var_251_14 = 1.575

			if var_251_13 < arg_248_1.time_ and arg_248_1.time_ <= var_251_13 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_15 = arg_248_1:GetWordFromCfg(423011061)
				local var_251_16 = arg_248_1:FormatText(var_251_15.content)

				arg_248_1.text_.text = var_251_16

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_17 = 63
				local var_251_18 = utf8.len(var_251_16)
				local var_251_19 = var_251_17 <= 0 and var_251_14 or var_251_14 * (var_251_18 / var_251_17)

				if var_251_19 > 0 and var_251_14 < var_251_19 then
					arg_248_1.talkMaxDuration = var_251_19

					if var_251_19 + var_251_13 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_19 + var_251_13
					end
				end

				arg_248_1.text_.text = var_251_16
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_20 = math.max(var_251_14, arg_248_1.talkMaxDuration)

			if var_251_13 <= arg_248_1.time_ and arg_248_1.time_ < var_251_13 + var_251_20 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_13) / var_251_20

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_13 + var_251_20 and arg_248_1.time_ < var_251_13 + var_251_20 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play423011062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 423011062
		arg_252_1.duration_ = 7.83

		local var_252_0 = {
			zh = 7.033,
			ja = 7.833
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
				arg_252_0:Play423011063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 5.63333333333333
			local var_255_1 = 1

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				local var_255_2 = "play"
				local var_255_3 = "effect"

				arg_252_1:AudioAction(var_255_2, var_255_3, "se_story_140", "se_story_140_microphone", "")
			end

			local var_255_4 = 0
			local var_255_5 = 0.85

			if var_255_4 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_6 = arg_252_1:FormatText(StoryNameCfg[672].name)

				arg_252_1.leftNameTxt_.text = var_255_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_252_1.callingController_:SetSelectedState("calling")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_7 = arg_252_1:GetWordFromCfg(423011062)
				local var_255_8 = arg_252_1:FormatText(var_255_7.content)

				arg_252_1.text_.text = var_255_8

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_9 = 34
				local var_255_10 = utf8.len(var_255_8)
				local var_255_11 = var_255_9 <= 0 and var_255_5 or var_255_5 * (var_255_10 / var_255_9)

				if var_255_11 > 0 and var_255_5 < var_255_11 then
					arg_252_1.talkMaxDuration = var_255_11

					if var_255_11 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_4
					end
				end

				arg_252_1.text_.text = var_255_8
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011062", "story_v_out_423011.awb") ~= 0 then
					local var_255_12 = manager.audio:GetVoiceLength("story_v_out_423011", "423011062", "story_v_out_423011.awb") / 1000

					if var_255_12 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_12 + var_255_4
					end

					if var_255_7.prefab_name ~= "" and arg_252_1.actors_[var_255_7.prefab_name] ~= nil then
						local var_255_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_7.prefab_name].transform, "story_v_out_423011", "423011062", "story_v_out_423011.awb")

						arg_252_1:RecordAudio("423011062", var_255_13)
						arg_252_1:RecordAudio("423011062", var_255_13)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_423011", "423011062", "story_v_out_423011.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_423011", "423011062", "story_v_out_423011.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_5, arg_252_1.talkMaxDuration)

			if var_255_4 <= arg_252_1.time_ and arg_252_1.time_ < var_255_4 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_4) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_4 + var_255_14 and arg_252_1.time_ < var_255_4 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play423011063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 423011063
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play423011064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0
			local var_259_1 = 0.3

			if var_259_0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_0 + arg_259_0 then
				local var_259_2 = "play"
				local var_259_3 = "music"

				arg_256_1:AudioAction(var_259_2, var_259_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_259_4 = ""
				local var_259_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_259_5 ~= "" then
					if arg_256_1.bgmTxt_.text ~= var_259_5 and arg_256_1.bgmTxt_.text ~= "" then
						if arg_256_1.bgmTxt2_.text ~= "" then
							arg_256_1.bgmTxt_.text = arg_256_1.bgmTxt2_.text
						end

						arg_256_1.bgmTxt2_.text = var_259_5

						arg_256_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_256_1.bgmTxt_.text = var_259_5
						arg_256_1.bgmTxt2_.text = var_259_5
					end

					if arg_256_1.bgmTimer then
						arg_256_1.bgmTimer:Stop()

						arg_256_1.bgmTimer = nil
					end

					if arg_256_1.settingData.show_music_name == 1 then
						arg_256_1.musicController:SetSelectedState("show")
						arg_256_1.musicAnimator_:Play("open", 0, 0)

						if arg_256_1.settingData.music_time ~= 0 then
							arg_256_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_256_1.settingData.music_time), function()
								if arg_256_1 == nil or isNil(arg_256_1.bgmTxt_) then
									return
								end

								arg_256_1.musicController:SetSelectedState("hide")
								arg_256_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_259_6 = 0.500666666666667
			local var_259_7 = 1

			if var_259_6 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				local var_259_8 = "play"
				local var_259_9 = "music"

				arg_256_1:AudioAction(var_259_8, var_259_9, "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous.awb")

				local var_259_10 = ""
				local var_259_11 = manager.audio:GetAudioName("bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous")

				if var_259_11 ~= "" then
					if arg_256_1.bgmTxt_.text ~= var_259_11 and arg_256_1.bgmTxt_.text ~= "" then
						if arg_256_1.bgmTxt2_.text ~= "" then
							arg_256_1.bgmTxt_.text = arg_256_1.bgmTxt2_.text
						end

						arg_256_1.bgmTxt2_.text = var_259_11

						arg_256_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_256_1.bgmTxt_.text = var_259_11
						arg_256_1.bgmTxt2_.text = var_259_11
					end

					if arg_256_1.bgmTimer then
						arg_256_1.bgmTimer:Stop()

						arg_256_1.bgmTimer = nil
					end

					if arg_256_1.settingData.show_music_name == 1 then
						arg_256_1.musicController:SetSelectedState("show")
						arg_256_1.musicAnimator_:Play("open", 0, 0)

						if arg_256_1.settingData.music_time ~= 0 then
							arg_256_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_256_1.settingData.music_time), function()
								if arg_256_1 == nil or isNil(arg_256_1.bgmTxt_) then
									return
								end

								arg_256_1.musicController:SetSelectedState("hide")
								arg_256_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_259_12 = 0
			local var_259_13 = 1.6

			if var_259_12 < arg_256_1.time_ and arg_256_1.time_ <= var_259_12 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_14 = arg_256_1:GetWordFromCfg(423011063)
				local var_259_15 = arg_256_1:FormatText(var_259_14.content)

				arg_256_1.text_.text = var_259_15

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_16 = 64
				local var_259_17 = utf8.len(var_259_15)
				local var_259_18 = var_259_16 <= 0 and var_259_13 or var_259_13 * (var_259_17 / var_259_16)

				if var_259_18 > 0 and var_259_13 < var_259_18 then
					arg_256_1.talkMaxDuration = var_259_18

					if var_259_18 + var_259_12 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_18 + var_259_12
					end
				end

				arg_256_1.text_.text = var_259_15
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_19 = math.max(var_259_13, arg_256_1.talkMaxDuration)

			if var_259_12 <= arg_256_1.time_ and arg_256_1.time_ < var_259_12 + var_259_19 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_12) / var_259_19

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_12 + var_259_19 and arg_256_1.time_ < var_259_12 + var_259_19 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play423011064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 423011064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play423011065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 0
			local var_265_1 = 0.225

			if var_265_0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				local var_265_2 = arg_262_1:FormatText(StoryNameCfg[7].name)

				arg_262_1.leftNameTxt_.text = var_265_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_3 = arg_262_1:GetWordFromCfg(423011064)
				local var_265_4 = arg_262_1:FormatText(var_265_3.content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_5 = 9
				local var_265_6 = utf8.len(var_265_4)
				local var_265_7 = var_265_5 <= 0 and var_265_1 or var_265_1 * (var_265_6 / var_265_5)

				if var_265_7 > 0 and var_265_1 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_0
					end
				end

				arg_262_1.text_.text = var_265_4
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_8 = math.max(var_265_1, arg_262_1.talkMaxDuration)

			if var_265_0 <= arg_262_1.time_ and arg_262_1.time_ < var_265_0 + var_265_8 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_0) / var_265_8

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_0 + var_265_8 and arg_262_1.time_ < var_265_0 + var_265_8 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play423011065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 423011065
		arg_266_1.duration_ = 10.43

		local var_266_0 = {
			zh = 6.1,
			ja = 10.433
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play423011066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.725

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[1327].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:GetWordFromCfg(423011065)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 29
				local var_269_6 = utf8.len(var_269_4)
				local var_269_7 = var_269_5 <= 0 and var_269_1 or var_269_1 * (var_269_6 / var_269_5)

				if var_269_7 > 0 and var_269_1 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011065", "story_v_out_423011.awb") ~= 0 then
					local var_269_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011065", "story_v_out_423011.awb") / 1000

					if var_269_8 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_8 + var_269_0
					end

					if var_269_3.prefab_name ~= "" and arg_266_1.actors_[var_269_3.prefab_name] ~= nil then
						local var_269_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_3.prefab_name].transform, "story_v_out_423011", "423011065", "story_v_out_423011.awb")

						arg_266_1:RecordAudio("423011065", var_269_9)
						arg_266_1:RecordAudio("423011065", var_269_9)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_423011", "423011065", "story_v_out_423011.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_423011", "423011065", "story_v_out_423011.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_10 and arg_266_1.time_ < var_269_0 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play423011066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 423011066
		arg_270_1.duration_ = 5.53

		local var_270_0 = {
			zh = 5.4,
			ja = 5.533
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play423011067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.75

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[1327].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(423011066)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 30
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011066", "story_v_out_423011.awb") ~= 0 then
					local var_273_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011066", "story_v_out_423011.awb") / 1000

					if var_273_8 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_8 + var_273_0
					end

					if var_273_3.prefab_name ~= "" and arg_270_1.actors_[var_273_3.prefab_name] ~= nil then
						local var_273_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_3.prefab_name].transform, "story_v_out_423011", "423011066", "story_v_out_423011.awb")

						arg_270_1:RecordAudio("423011066", var_273_9)
						arg_270_1:RecordAudio("423011066", var_273_9)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_423011", "423011066", "story_v_out_423011.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_423011", "423011066", "story_v_out_423011.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_10 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_10 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_10

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_10 and arg_270_1.time_ < var_273_0 + var_273_10 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play423011067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 423011067
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play423011068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.575

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_2 = arg_274_1:FormatText(StoryNameCfg[7].name)

				arg_274_1.leftNameTxt_.text = var_277_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:GetWordFromCfg(423011067)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 23
				local var_277_6 = utf8.len(var_277_4)
				local var_277_7 = var_277_5 <= 0 and var_277_1 or var_277_1 * (var_277_6 / var_277_5)

				if var_277_7 > 0 and var_277_1 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_8 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_8 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_8

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_8 and arg_274_1.time_ < var_277_0 + var_277_8 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play423011068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 423011068
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play423011069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 1.45

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_2 = arg_278_1:GetWordFromCfg(423011068)
				local var_281_3 = arg_278_1:FormatText(var_281_2.content)

				arg_278_1.text_.text = var_281_3

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 58
				local var_281_5 = utf8.len(var_281_3)
				local var_281_6 = var_281_4 <= 0 and var_281_1 or var_281_1 * (var_281_5 / var_281_4)

				if var_281_6 > 0 and var_281_1 < var_281_6 then
					arg_278_1.talkMaxDuration = var_281_6

					if var_281_6 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_6 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_3
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_7 and arg_278_1.time_ < var_281_0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play423011069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 423011069
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play423011070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0
			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				local var_285_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_285_2 then
					var_285_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_285_2.radialBlurScale = 1
					var_285_2.radialBlurGradient = 1
					var_285_2.radialBlurIntensity = 1

					if var_285_0 then
						var_285_2.radialBlurTarget = var_285_0.transform
					end
				end
			end

			local var_285_3 = 1.5

			if var_285_1 <= arg_282_1.time_ and arg_282_1.time_ < var_285_1 + var_285_3 then
				local var_285_4 = (arg_282_1.time_ - var_285_1) / var_285_3
				local var_285_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_285_5 then
					var_285_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_285_5.radialBlurScale = Mathf.Lerp(1, 0, var_285_4)
					var_285_5.radialBlurGradient = Mathf.Lerp(1, 1, var_285_4)
					var_285_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_285_4)
				end
			end

			if arg_282_1.time_ >= var_285_1 + var_285_3 and arg_282_1.time_ < var_285_1 + var_285_3 + arg_285_0 then
				local var_285_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_285_6 then
					var_285_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_285_6.radialBlurScale = 0
					var_285_6.radialBlurGradient = 1
					var_285_6.radialBlurIntensity = 1
				end
			end

			local var_285_7 = 0

			if var_285_7 < arg_282_1.time_ and arg_282_1.time_ <= var_285_7 + arg_285_0 then
				arg_282_1.allBtn_.enabled = false
			end

			local var_285_8 = 1.5

			if arg_282_1.time_ >= var_285_7 + var_285_8 and arg_282_1.time_ < var_285_7 + var_285_8 + arg_285_0 then
				arg_282_1.allBtn_.enabled = true
			end

			local var_285_9 = manager.ui.mainCamera.transform
			local var_285_10 = 0

			if var_285_10 < arg_282_1.time_ and arg_282_1.time_ <= var_285_10 + arg_285_0 then
				local var_285_11 = arg_282_1.var_.effectliechebaozhajinggao1

				if var_285_11 then
					Object.Destroy(var_285_11)

					arg_282_1.var_.effectliechebaozhajinggao1 = nil
				end
			end

			local var_285_12 = manager.ui.mainCamera.transform
			local var_285_13 = 0

			if var_285_13 < arg_282_1.time_ and arg_282_1.time_ <= var_285_13 + arg_285_0 then
				local var_285_14 = arg_282_1.var_.effectliechebaozhajinggao2
				local var_285_15
				local var_285_16 = var_285_12

				if not var_285_14 then
					var_285_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_out"), var_285_16)
					var_285_14.name = "liechebaozhajinggao2"
					arg_282_1.var_.effectliechebaozhajinggao2 = var_285_14
				else
					var_285_14.transform:SetParent(var_285_16)
				end

				var_285_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_285_14.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_285_17 = manager.ui.mainCameraCom_
				local var_285_18 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_285_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_285_19 = var_285_14.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_285_20 = 15
				local var_285_21 = 2 * var_285_20 * Mathf.Tan(var_285_17.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_285_17.aspect
				local var_285_22 = 1
				local var_285_23 = 1.7777777777777777

				if var_285_23 < var_285_17.aspect then
					var_285_22 = var_285_21 / (2 * var_285_20 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_285_23)
				end

				for iter_285_0, iter_285_1 in ipairs(var_285_19) do
					local var_285_24 = iter_285_1.transform.localScale

					iter_285_1.transform.localScale = Vector3.New(var_285_24.x / var_285_18 * var_285_22, var_285_24.y / var_285_18, var_285_24.z)
				end
			end

			local var_285_25 = manager.ui.mainCamera.transform
			local var_285_26 = 2

			if var_285_26 < arg_282_1.time_ and arg_282_1.time_ <= var_285_26 + arg_285_0 then
				local var_285_27 = arg_282_1.var_.effectliechebaozhajinggao2

				if var_285_27 then
					Object.Destroy(var_285_27)

					arg_282_1.var_.effectliechebaozhajinggao2 = nil
				end
			end

			local var_285_28 = 0
			local var_285_29 = 1.7

			if var_285_28 < arg_282_1.time_ and arg_282_1.time_ <= var_285_28 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_30 = arg_282_1:GetWordFromCfg(423011069)
				local var_285_31 = arg_282_1:FormatText(var_285_30.content)

				arg_282_1.text_.text = var_285_31

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_32 = 68
				local var_285_33 = utf8.len(var_285_31)
				local var_285_34 = var_285_32 <= 0 and var_285_29 or var_285_29 * (var_285_33 / var_285_32)

				if var_285_34 > 0 and var_285_29 < var_285_34 then
					arg_282_1.talkMaxDuration = var_285_34

					if var_285_34 + var_285_28 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_34 + var_285_28
					end
				end

				arg_282_1.text_.text = var_285_31
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_35 = math.max(var_285_29, arg_282_1.talkMaxDuration)

			if var_285_28 <= arg_282_1.time_ and arg_282_1.time_ < var_285_28 + var_285_35 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_28) / var_285_35

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_28 + var_285_35 and arg_282_1.time_ < var_285_28 + var_285_35 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play423011070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 423011070
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play423011071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.225

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[7].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:GetWordFromCfg(423011070)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 9
				local var_289_6 = utf8.len(var_289_4)
				local var_289_7 = var_289_5 <= 0 and var_289_1 or var_289_1 * (var_289_6 / var_289_5)

				if var_289_7 > 0 and var_289_1 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_8 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_8 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_8

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_8 and arg_286_1.time_ < var_289_0 + var_289_8 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play423011071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 423011071
		arg_290_1.duration_ = 9.4

		local var_290_0 = {
			zh = 7.3,
			ja = 9.4
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play423011072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0
			local var_293_1 = 0.85

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_2 = arg_290_1:FormatText(StoryNameCfg[1327].name)

				arg_290_1.leftNameTxt_.text = var_293_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:GetWordFromCfg(423011071)
				local var_293_4 = arg_290_1:FormatText(var_293_3.content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 34
				local var_293_6 = utf8.len(var_293_4)
				local var_293_7 = var_293_5 <= 0 and var_293_1 or var_293_1 * (var_293_6 / var_293_5)

				if var_293_7 > 0 and var_293_1 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011071", "story_v_out_423011.awb") ~= 0 then
					local var_293_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011071", "story_v_out_423011.awb") / 1000

					if var_293_8 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_0
					end

					if var_293_3.prefab_name ~= "" and arg_290_1.actors_[var_293_3.prefab_name] ~= nil then
						local var_293_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_3.prefab_name].transform, "story_v_out_423011", "423011071", "story_v_out_423011.awb")

						arg_290_1:RecordAudio("423011071", var_293_9)
						arg_290_1:RecordAudio("423011071", var_293_9)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_423011", "423011071", "story_v_out_423011.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_423011", "423011071", "story_v_out_423011.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_10 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_10 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_10

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_10 and arg_290_1.time_ < var_293_0 + var_293_10 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play423011072 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 423011072
		arg_294_1.duration_ = 7.1

		local var_294_0 = {
			zh = 4.8,
			ja = 7.1
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play423011073(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0
			local var_297_1 = 0.7

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				local var_297_2 = arg_294_1:FormatText(StoryNameCfg[1327].name)

				arg_294_1.leftNameTxt_.text = var_297_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_3 = arg_294_1:GetWordFromCfg(423011072)
				local var_297_4 = arg_294_1:FormatText(var_297_3.content)

				arg_294_1.text_.text = var_297_4

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 28
				local var_297_6 = utf8.len(var_297_4)
				local var_297_7 = var_297_5 <= 0 and var_297_1 or var_297_1 * (var_297_6 / var_297_5)

				if var_297_7 > 0 and var_297_1 < var_297_7 then
					arg_294_1.talkMaxDuration = var_297_7

					if var_297_7 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_7 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_4
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011072", "story_v_out_423011.awb") ~= 0 then
					local var_297_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011072", "story_v_out_423011.awb") / 1000

					if var_297_8 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_0
					end

					if var_297_3.prefab_name ~= "" and arg_294_1.actors_[var_297_3.prefab_name] ~= nil then
						local var_297_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_3.prefab_name].transform, "story_v_out_423011", "423011072", "story_v_out_423011.awb")

						arg_294_1:RecordAudio("423011072", var_297_9)
						arg_294_1:RecordAudio("423011072", var_297_9)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_423011", "423011072", "story_v_out_423011.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_423011", "423011072", "story_v_out_423011.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_10 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_10 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_10

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_10 and arg_294_1.time_ < var_297_0 + var_297_10 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play423011073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 423011073
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play423011074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.4
			local var_301_1 = 1

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				local var_301_2 = "play"
				local var_301_3 = "effect"

				arg_298_1:AudioAction(var_301_2, var_301_3, "se_story_144", "se_story_144_countdown", "")
			end

			local var_301_4 = 0
			local var_301_5 = 0.65

			if var_301_4 < arg_298_1.time_ and arg_298_1.time_ <= var_301_4 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				local var_301_6 = arg_298_1:FormatText(StoryNameCfg[7].name)

				arg_298_1.leftNameTxt_.text = var_301_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_7 = arg_298_1:GetWordFromCfg(423011073)
				local var_301_8 = arg_298_1:FormatText(var_301_7.content)

				arg_298_1.text_.text = var_301_8

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_9 = 26
				local var_301_10 = utf8.len(var_301_8)
				local var_301_11 = var_301_9 <= 0 and var_301_5 or var_301_5 * (var_301_10 / var_301_9)

				if var_301_11 > 0 and var_301_5 < var_301_11 then
					arg_298_1.talkMaxDuration = var_301_11

					if var_301_11 + var_301_4 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_11 + var_301_4
					end
				end

				arg_298_1.text_.text = var_301_8
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_12 = math.max(var_301_5, arg_298_1.talkMaxDuration)

			if var_301_4 <= arg_298_1.time_ and arg_298_1.time_ < var_301_4 + var_301_12 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_4) / var_301_12

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_4 + var_301_12 and arg_298_1.time_ < var_301_4 + var_301_12 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play423011074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 423011074
		arg_302_1.duration_ = 5.2

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play423011075(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = manager.ui.mainCamera.transform
			local var_305_1 = 0

			if var_305_1 < arg_302_1.time_ and arg_302_1.time_ <= var_305_1 + arg_305_0 then
				local var_305_2 = arg_302_1.var_.effectshuangchongbaozha
				local var_305_3
				local var_305_4 = var_305_0

				if not var_305_2 then
					var_305_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), var_305_4)
					var_305_2.name = "shuangchongbaozha"
					arg_302_1.var_.effectshuangchongbaozha = var_305_2
				else
					var_305_2.transform:SetParent(var_305_4)
				end

				var_305_2.transform.localPosition = Vector3.New(-5, 1, -3)
				var_305_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_305_5 = manager.ui.mainCamera.transform
			local var_305_6 = 5

			if var_305_6 < arg_302_1.time_ and arg_302_1.time_ <= var_305_6 + arg_305_0 then
				local var_305_7 = arg_302_1.var_.effectshuangchongbaozha

				if var_305_7 then
					Object.Destroy(var_305_7)

					arg_302_1.var_.effectshuangchongbaozha = nil
				end
			end

			local var_305_8 = manager.ui.mainCamera.transform
			local var_305_9 = 0

			if var_305_9 < arg_302_1.time_ and arg_302_1.time_ <= var_305_9 + arg_305_0 then
				local var_305_10 = arg_302_1.var_.effectshuangchongbaozha1
				local var_305_11
				local var_305_12 = var_305_8

				if not var_305_10 then
					var_305_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), var_305_12)
					var_305_10.name = "shuangchongbaozha1"
					arg_302_1.var_.effectshuangchongbaozha1 = var_305_10
				else
					var_305_10.transform:SetParent(var_305_12)
				end

				var_305_10.transform.localPosition = Vector3.New(6, 1, -3)
				var_305_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_305_13 = manager.ui.mainCamera.transform
			local var_305_14 = 5

			if var_305_14 < arg_302_1.time_ and arg_302_1.time_ <= var_305_14 + arg_305_0 then
				local var_305_15 = arg_302_1.var_.effectshuangchongbaozha1

				if var_305_15 then
					Object.Destroy(var_305_15)

					arg_302_1.var_.effectshuangchongbaozha1 = nil
				end
			end

			local var_305_16 = 0
			local var_305_17 = 1

			if var_305_16 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				local var_305_18 = "play"
				local var_305_19 = "effect"

				arg_302_1:AudioAction(var_305_18, var_305_19, "se_story_144", "se_story_144_explosion02", "")
			end

			local var_305_20 = manager.ui.mainCamera.transform
			local var_305_21 = 0

			if var_305_21 < arg_302_1.time_ and arg_302_1.time_ <= var_305_21 + arg_305_0 then
				arg_302_1.var_.shakeOldPos = var_305_20.localPosition
			end

			local var_305_22 = 1

			if var_305_21 <= arg_302_1.time_ and arg_302_1.time_ < var_305_21 + var_305_22 then
				local var_305_23 = (arg_302_1.time_ - var_305_21) / 0.066
				local var_305_24, var_305_25 = math.modf(var_305_23)

				var_305_20.localPosition = Vector3.New(var_305_25 * 0.13, var_305_25 * 0.13, var_305_25 * 0.13) + arg_302_1.var_.shakeOldPos
			end

			if arg_302_1.time_ >= var_305_21 + var_305_22 and arg_302_1.time_ < var_305_21 + var_305_22 + arg_305_0 then
				var_305_20.localPosition = arg_302_1.var_.shakeOldPos
			end

			local var_305_26 = manager.ui.mainCamera.transform
			local var_305_27 = 0.266666666666667

			if var_305_27 < arg_302_1.time_ and arg_302_1.time_ <= var_305_27 + arg_305_0 then
				local var_305_28 = arg_302_1.var_.effectliechebaozha2
				local var_305_29
				local var_305_30 = var_305_26

				if not var_305_28 then
					var_305_28 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), var_305_30)
					var_305_28.name = "liechebaozha2"
					arg_302_1.var_.effectliechebaozha2 = var_305_28
				else
					var_305_28.transform:SetParent(var_305_30)
				end

				var_305_28.transform.localPosition = Vector3.New(0, 0, 0)
				var_305_28.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_305_31 = 0.266666666666667
			local var_305_32 = 1

			if var_305_31 < arg_302_1.time_ and arg_302_1.time_ <= var_305_31 + arg_305_0 then
				local var_305_33 = "play"
				local var_305_34 = "effect"

				arg_302_1:AudioAction(var_305_33, var_305_34, "se_story_17", "se_story_17_fire_loop", "")
			end

			local var_305_35 = 0
			local var_305_36 = 1.125

			if var_305_35 < arg_302_1.time_ and arg_302_1.time_ <= var_305_35 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_37 = arg_302_1:GetWordFromCfg(423011074)
				local var_305_38 = arg_302_1:FormatText(var_305_37.content)

				arg_302_1.text_.text = var_305_38

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_39 = 45
				local var_305_40 = utf8.len(var_305_38)
				local var_305_41 = var_305_39 <= 0 and var_305_36 or var_305_36 * (var_305_40 / var_305_39)

				if var_305_41 > 0 and var_305_36 < var_305_41 then
					arg_302_1.talkMaxDuration = var_305_41

					if var_305_41 + var_305_35 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_41 + var_305_35
					end
				end

				arg_302_1.text_.text = var_305_38
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_42 = math.max(var_305_36, arg_302_1.talkMaxDuration)

			if var_305_35 <= arg_302_1.time_ and arg_302_1.time_ < var_305_35 + var_305_42 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_35) / var_305_42

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_35 + var_305_42 and arg_302_1.time_ < var_305_35 + var_305_42 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play423011075 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 423011075
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play423011076(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0
			local var_309_1 = 1.5

			if var_309_0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, false)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_2 = arg_306_1:GetWordFromCfg(423011075)
				local var_309_3 = arg_306_1:FormatText(var_309_2.content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 60
				local var_309_5 = utf8.len(var_309_3)
				local var_309_6 = var_309_4 <= 0 and var_309_1 or var_309_1 * (var_309_5 / var_309_4)

				if var_309_6 > 0 and var_309_1 < var_309_6 then
					arg_306_1.talkMaxDuration = var_309_6

					if var_309_6 + var_309_0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_6 + var_309_0
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_1, arg_306_1.talkMaxDuration)

			if var_309_0 <= arg_306_1.time_ and arg_306_1.time_ < var_309_0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_0 + var_309_7 and arg_306_1.time_ < var_309_0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play423011076 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 423011076
		arg_310_1.duration_ = 8.31

		local var_310_0 = {
			zh = 5.575,
			ja = 8.308
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play423011077(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = manager.ui.mainCamera.transform
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.var_.shakeOldPos = var_313_0.localPosition
			end

			local var_313_2 = 0.6

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / 0.066
				local var_313_4, var_313_5 = math.modf(var_313_3)

				var_313_0.localPosition = Vector3.New(var_313_5 * 0.13, var_313_5 * 0.13, var_313_5 * 0.13) + arg_310_1.var_.shakeOldPos
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 then
				var_313_0.localPosition = arg_310_1.var_.shakeOldPos
			end

			local var_313_6 = 0

			if var_313_6 < arg_310_1.time_ and arg_310_1.time_ <= var_313_6 + arg_313_0 then
				arg_310_1.allBtn_.enabled = false
			end

			local var_313_7 = 0.6

			if arg_310_1.time_ >= var_313_6 + var_313_7 and arg_310_1.time_ < var_313_6 + var_313_7 + arg_313_0 then
				arg_310_1.allBtn_.enabled = true
			end

			local var_313_8 = 0.166666666666667
			local var_313_9 = 1

			if var_313_8 < arg_310_1.time_ and arg_310_1.time_ <= var_313_8 + arg_313_0 then
				local var_313_10 = "play"
				local var_313_11 = "effect"

				arg_310_1:AudioAction(var_313_10, var_313_11, "se_story_144", "se_story_144_gun01", "")
			end

			if arg_310_1.frameCnt_ <= 1 then
				arg_310_1.dialog_:SetActive(false)
			end

			local var_313_12 = 0.375
			local var_313_13 = 0.625

			if var_313_12 < arg_310_1.time_ and arg_310_1.time_ <= var_313_12 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0

				arg_310_1.dialog_:SetActive(true)

				arg_310_1.dialogCg_.alpha = 0

				local var_313_14 = LeanTween.value(arg_310_1.dialog_, 0, 1, 0.3)

				var_313_14:setOnUpdate(LuaHelper.FloatAction(function(arg_314_0)
					arg_310_1.dialogCg_.alpha = arg_314_0
				end))
				var_313_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_310_1.dialog_)
					var_313_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_310_1.duration_ = arg_310_1.duration_ + 0.3

				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_15 = arg_310_1:FormatText(StoryNameCfg[36].name)

				arg_310_1.leftNameTxt_.text = var_313_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_16 = arg_310_1:GetWordFromCfg(423011076)
				local var_313_17 = arg_310_1:FormatText(var_313_16.content)

				arg_310_1.text_.text = var_313_17

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_18 = 25
				local var_313_19 = utf8.len(var_313_17)
				local var_313_20 = var_313_18 <= 0 and var_313_13 or var_313_13 * (var_313_19 / var_313_18)

				if var_313_20 > 0 and var_313_13 < var_313_20 then
					arg_310_1.talkMaxDuration = var_313_20
					var_313_12 = var_313_12 + 0.3

					if var_313_20 + var_313_12 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_20 + var_313_12
					end
				end

				arg_310_1.text_.text = var_313_17
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011076", "story_v_out_423011.awb") ~= 0 then
					local var_313_21 = manager.audio:GetVoiceLength("story_v_out_423011", "423011076", "story_v_out_423011.awb") / 1000

					if var_313_21 + var_313_12 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_21 + var_313_12
					end

					if var_313_16.prefab_name ~= "" and arg_310_1.actors_[var_313_16.prefab_name] ~= nil then
						local var_313_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_16.prefab_name].transform, "story_v_out_423011", "423011076", "story_v_out_423011.awb")

						arg_310_1:RecordAudio("423011076", var_313_22)
						arg_310_1:RecordAudio("423011076", var_313_22)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_423011", "423011076", "story_v_out_423011.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_423011", "423011076", "story_v_out_423011.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_23 = var_313_12 + 0.3
			local var_313_24 = math.max(var_313_13, arg_310_1.talkMaxDuration)

			if var_313_23 <= arg_310_1.time_ and arg_310_1.time_ < var_313_23 + var_313_24 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_23) / var_313_24

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_23 + var_313_24 and arg_310_1.time_ < var_313_23 + var_313_24 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play423011077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 423011077
		arg_316_1.duration_ = 8.6

		local var_316_0 = {
			zh = 5.9,
			ja = 8.6
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play423011078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.575

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_2 = arg_316_1:FormatText(StoryNameCfg[36].name)

				arg_316_1.leftNameTxt_.text = var_319_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:GetWordFromCfg(423011077)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 23
				local var_319_6 = utf8.len(var_319_4)
				local var_319_7 = var_319_5 <= 0 and var_319_1 or var_319_1 * (var_319_6 / var_319_5)

				if var_319_7 > 0 and var_319_1 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011077", "story_v_out_423011.awb") ~= 0 then
					local var_319_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011077", "story_v_out_423011.awb") / 1000

					if var_319_8 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_8 + var_319_0
					end

					if var_319_3.prefab_name ~= "" and arg_316_1.actors_[var_319_3.prefab_name] ~= nil then
						local var_319_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_3.prefab_name].transform, "story_v_out_423011", "423011077", "story_v_out_423011.awb")

						arg_316_1:RecordAudio("423011077", var_319_9)
						arg_316_1:RecordAudio("423011077", var_319_9)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_423011", "423011077", "story_v_out_423011.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_423011", "423011077", "story_v_out_423011.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_10 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_10 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_10

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_10 and arg_316_1.time_ < var_319_0 + var_319_10 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play423011078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 423011078
		arg_320_1.duration_ = 10.8

		local var_320_0 = {
			zh = 10.8,
			ja = 7.666
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play423011079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 1.125

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_2 = arg_320_1:FormatText(StoryNameCfg[1328].name)

				arg_320_1.leftNameTxt_.text = var_323_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_3 = arg_320_1:GetWordFromCfg(423011078)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_5 = 45
				local var_323_6 = utf8.len(var_323_4)
				local var_323_7 = var_323_5 <= 0 and var_323_1 or var_323_1 * (var_323_6 / var_323_5)

				if var_323_7 > 0 and var_323_1 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011078", "story_v_out_423011.awb") ~= 0 then
					local var_323_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011078", "story_v_out_423011.awb") / 1000

					if var_323_8 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_8 + var_323_0
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_out_423011", "423011078", "story_v_out_423011.awb")

						arg_320_1:RecordAudio("423011078", var_323_9)
						arg_320_1:RecordAudio("423011078", var_323_9)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_423011", "423011078", "story_v_out_423011.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_423011", "423011078", "story_v_out_423011.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_10 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_10 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_10

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_10 and arg_320_1.time_ < var_323_0 + var_323_10 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play423011079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 423011079
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play423011080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 1.55

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_2 = arg_324_1:GetWordFromCfg(423011079)
				local var_327_3 = arg_324_1:FormatText(var_327_2.content)

				arg_324_1.text_.text = var_327_3

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 62
				local var_327_5 = utf8.len(var_327_3)
				local var_327_6 = var_327_4 <= 0 and var_327_1 or var_327_1 * (var_327_5 / var_327_4)

				if var_327_6 > 0 and var_327_1 < var_327_6 then
					arg_324_1.talkMaxDuration = var_327_6

					if var_327_6 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_6 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_3
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_7 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_7 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_7

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_7 and arg_324_1.time_ < var_327_0 + var_327_7 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play423011080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 423011080
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play423011081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 0.675

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_2 = arg_328_1:FormatText(StoryNameCfg[7].name)

				arg_328_1.leftNameTxt_.text = var_331_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_3 = arg_328_1:GetWordFromCfg(423011080)
				local var_331_4 = arg_328_1:FormatText(var_331_3.content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 27
				local var_331_6 = utf8.len(var_331_4)
				local var_331_7 = var_331_5 <= 0 and var_331_1 or var_331_1 * (var_331_6 / var_331_5)

				if var_331_7 > 0 and var_331_1 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_8 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_8 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_8

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_8 and arg_328_1.time_ < var_331_0 + var_331_8 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play423011081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 423011081
		arg_332_1.duration_ = 13.37

		local var_332_0 = {
			zh = 7.4,
			ja = 13.366
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play423011082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0
			local var_335_1 = 0.75

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_2 = arg_332_1:FormatText(StoryNameCfg[1328].name)

				arg_332_1.leftNameTxt_.text = var_335_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, true)
				arg_332_1.iconController_:SetSelectedState("hero")

				arg_332_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_332_1.callingController_:SetSelectedState("normal")

				arg_332_1.keyicon_.color = Color.New(1, 1, 1)
				arg_332_1.icon_.color = Color.New(1, 1, 1)

				local var_335_3 = arg_332_1:GetWordFromCfg(423011081)
				local var_335_4 = arg_332_1:FormatText(var_335_3.content)

				arg_332_1.text_.text = var_335_4

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_5 = 30
				local var_335_6 = utf8.len(var_335_4)
				local var_335_7 = var_335_5 <= 0 and var_335_1 or var_335_1 * (var_335_6 / var_335_5)

				if var_335_7 > 0 and var_335_1 < var_335_7 then
					arg_332_1.talkMaxDuration = var_335_7

					if var_335_7 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_7 + var_335_0
					end
				end

				arg_332_1.text_.text = var_335_4
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011081", "story_v_out_423011.awb") ~= 0 then
					local var_335_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011081", "story_v_out_423011.awb") / 1000

					if var_335_8 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_8 + var_335_0
					end

					if var_335_3.prefab_name ~= "" and arg_332_1.actors_[var_335_3.prefab_name] ~= nil then
						local var_335_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_3.prefab_name].transform, "story_v_out_423011", "423011081", "story_v_out_423011.awb")

						arg_332_1:RecordAudio("423011081", var_335_9)
						arg_332_1:RecordAudio("423011081", var_335_9)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_423011", "423011081", "story_v_out_423011.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_423011", "423011081", "story_v_out_423011.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_10 = math.max(var_335_1, arg_332_1.talkMaxDuration)

			if var_335_0 <= arg_332_1.time_ and arg_332_1.time_ < var_335_0 + var_335_10 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_0) / var_335_10

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_0 + var_335_10 and arg_332_1.time_ < var_335_0 + var_335_10 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play423011082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 423011082
		arg_336_1.duration_ = 6.27

		local var_336_0 = {
			zh = 5.333,
			ja = 6.266
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play423011083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0
			local var_339_1 = 0.55

			if var_339_0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_2 = arg_336_1:FormatText(StoryNameCfg[1329].name)

				arg_336_1.leftNameTxt_.text = var_339_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, true)
				arg_336_1.iconController_:SetSelectedState("hero")

				arg_336_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_336_1.callingController_:SetSelectedState("normal")

				arg_336_1.keyicon_.color = Color.New(1, 1, 1)
				arg_336_1.icon_.color = Color.New(1, 1, 1)

				local var_339_3 = arg_336_1:GetWordFromCfg(423011082)
				local var_339_4 = arg_336_1:FormatText(var_339_3.content)

				arg_336_1.text_.text = var_339_4

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_5 = 22
				local var_339_6 = utf8.len(var_339_4)
				local var_339_7 = var_339_5 <= 0 and var_339_1 or var_339_1 * (var_339_6 / var_339_5)

				if var_339_7 > 0 and var_339_1 < var_339_7 then
					arg_336_1.talkMaxDuration = var_339_7

					if var_339_7 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_7 + var_339_0
					end
				end

				arg_336_1.text_.text = var_339_4
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011082", "story_v_out_423011.awb") ~= 0 then
					local var_339_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011082", "story_v_out_423011.awb") / 1000

					if var_339_8 + var_339_0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_8 + var_339_0
					end

					if var_339_3.prefab_name ~= "" and arg_336_1.actors_[var_339_3.prefab_name] ~= nil then
						local var_339_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_3.prefab_name].transform, "story_v_out_423011", "423011082", "story_v_out_423011.awb")

						arg_336_1:RecordAudio("423011082", var_339_9)
						arg_336_1:RecordAudio("423011082", var_339_9)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_423011", "423011082", "story_v_out_423011.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_423011", "423011082", "story_v_out_423011.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_10 = math.max(var_339_1, arg_336_1.talkMaxDuration)

			if var_339_0 <= arg_336_1.time_ and arg_336_1.time_ < var_339_0 + var_339_10 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_0) / var_339_10

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_0 + var_339_10 and arg_336_1.time_ < var_339_0 + var_339_10 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play423011083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 423011083
		arg_340_1.duration_ = 3.37

		local var_340_0 = {
			zh = 2.066,
			ja = 3.366
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play423011084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0
			local var_343_1 = 1.325

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_2 = arg_340_1:GetWordFromCfg(423011083)
				local var_343_3 = arg_340_1:FormatText(var_343_2.content)

				arg_340_1.text_.text = var_343_3

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_4 = 53
				local var_343_5 = utf8.len(var_343_3)
				local var_343_6 = var_343_4 <= 0 and var_343_1 or var_343_1 * (var_343_5 / var_343_4)

				if var_343_6 > 0 and var_343_1 < var_343_6 then
					arg_340_1.talkMaxDuration = var_343_6

					if var_343_6 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_6 + var_343_0
					end
				end

				arg_340_1.text_.text = var_343_3
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011083", "story_v_out_423011.awb") ~= 0 then
					local var_343_7 = manager.audio:GetVoiceLength("story_v_out_423011", "423011083", "story_v_out_423011.awb") / 1000

					if var_343_7 + var_343_0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_0
					end

					if var_343_2.prefab_name ~= "" and arg_340_1.actors_[var_343_2.prefab_name] ~= nil then
						local var_343_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_2.prefab_name].transform, "story_v_out_423011", "423011083", "story_v_out_423011.awb")

						arg_340_1:RecordAudio("423011083", var_343_8)
						arg_340_1:RecordAudio("423011083", var_343_8)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_423011", "423011083", "story_v_out_423011.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_423011", "423011083", "story_v_out_423011.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_9 = math.max(var_343_1, arg_340_1.talkMaxDuration)

			if var_343_0 <= arg_340_1.time_ and arg_340_1.time_ < var_343_0 + var_343_9 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_0) / var_343_9

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_0 + var_343_9 and arg_340_1.time_ < var_343_0 + var_343_9 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play423011084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 423011084
		arg_344_1.duration_ = 5

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play423011085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 0.975

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, false)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_2 = arg_344_1:GetWordFromCfg(423011084)
				local var_347_3 = arg_344_1:FormatText(var_347_2.content)

				arg_344_1.text_.text = var_347_3

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_4 = 39
				local var_347_5 = utf8.len(var_347_3)
				local var_347_6 = var_347_4 <= 0 and var_347_1 or var_347_1 * (var_347_5 / var_347_4)

				if var_347_6 > 0 and var_347_1 < var_347_6 then
					arg_344_1.talkMaxDuration = var_347_6

					if var_347_6 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_6 + var_347_0
					end
				end

				arg_344_1.text_.text = var_347_3
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)
				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_7 = math.max(var_347_1, arg_344_1.talkMaxDuration)

			if var_347_0 <= arg_344_1.time_ and arg_344_1.time_ < var_347_0 + var_347_7 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_0) / var_347_7

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_0 + var_347_7 and arg_344_1.time_ < var_347_0 + var_347_7 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play423011085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 423011085
		arg_348_1.duration_ = 5

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play423011086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.825

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[7].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, true)
				arg_348_1.iconController_:SetSelectedState("hero")

				arg_348_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_348_1.callingController_:SetSelectedState("normal")

				arg_348_1.keyicon_.color = Color.New(1, 1, 1)
				arg_348_1.icon_.color = Color.New(1, 1, 1)

				local var_351_3 = arg_348_1:GetWordFromCfg(423011085)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 33
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_8 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_8 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_8

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_8 and arg_348_1.time_ < var_351_0 + var_351_8 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play423011086 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 423011086
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play423011087(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0
			local var_355_1 = 0.7

			if var_355_0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_2 = arg_352_1:FormatText(StoryNameCfg[7].name)

				arg_352_1.leftNameTxt_.text = var_355_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:GetWordFromCfg(423011086)
				local var_355_4 = arg_352_1:FormatText(var_355_3.content)

				arg_352_1.text_.text = var_355_4

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 28
				local var_355_6 = utf8.len(var_355_4)
				local var_355_7 = var_355_5 <= 0 and var_355_1 or var_355_1 * (var_355_6 / var_355_5)

				if var_355_7 > 0 and var_355_1 < var_355_7 then
					arg_352_1.talkMaxDuration = var_355_7

					if var_355_7 + var_355_0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_7 + var_355_0
					end
				end

				arg_352_1.text_.text = var_355_4
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_8 = math.max(var_355_1, arg_352_1.talkMaxDuration)

			if var_355_0 <= arg_352_1.time_ and arg_352_1.time_ < var_355_0 + var_355_8 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_0) / var_355_8

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_0 + var_355_8 and arg_352_1.time_ < var_355_0 + var_355_8 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play423011087 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 423011087
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play423011088(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0.166666666666667
			local var_359_1 = 1

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				local var_359_2 = "play"
				local var_359_3 = "effect"

				arg_356_1:AudioAction(var_359_2, var_359_3, "se_story_side_1033", "se_story_1033_button", "")
			end

			local var_359_4 = 0
			local var_359_5 = 1.075

			if var_359_4 < arg_356_1.time_ and arg_356_1.time_ <= var_359_4 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_6 = arg_356_1:GetWordFromCfg(423011087)
				local var_359_7 = arg_356_1:FormatText(var_359_6.content)

				arg_356_1.text_.text = var_359_7

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_8 = 43
				local var_359_9 = utf8.len(var_359_7)
				local var_359_10 = var_359_8 <= 0 and var_359_5 or var_359_5 * (var_359_9 / var_359_8)

				if var_359_10 > 0 and var_359_5 < var_359_10 then
					arg_356_1.talkMaxDuration = var_359_10

					if var_359_10 + var_359_4 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_10 + var_359_4
					end
				end

				arg_356_1.text_.text = var_359_7
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_11 = math.max(var_359_5, arg_356_1.talkMaxDuration)

			if var_359_4 <= arg_356_1.time_ and arg_356_1.time_ < var_359_4 + var_359_11 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_4) / var_359_11

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_4 + var_359_11 and arg_356_1.time_ < var_359_4 + var_359_11 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play423011088 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 423011088
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play423011089(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				local var_363_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_363_2 then
					var_363_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_363_2.radialBlurScale = 0
					var_363_2.radialBlurGradient = 1
					var_363_2.radialBlurIntensity = 1

					if var_363_0 then
						var_363_2.radialBlurTarget = var_363_0.transform
					end
				end
			end

			local var_363_3 = 1

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_3 then
				local var_363_4 = (arg_360_1.time_ - var_363_1) / var_363_3
				local var_363_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_363_5 then
					var_363_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_363_5.radialBlurScale = Mathf.Lerp(0, 0, var_363_4)
					var_363_5.radialBlurGradient = Mathf.Lerp(1, 1, var_363_4)
					var_363_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_363_4)
				end
			end

			if arg_360_1.time_ >= var_363_1 + var_363_3 and arg_360_1.time_ < var_363_1 + var_363_3 + arg_363_0 then
				local var_363_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_363_6 then
					var_363_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_363_6.radialBlurScale = 0
					var_363_6.radialBlurGradient = 1
					var_363_6.radialBlurIntensity = 1
				end
			end

			local var_363_7 = 0.233333333333333
			local var_363_8 = 1

			if var_363_7 < arg_360_1.time_ and arg_360_1.time_ <= var_363_7 + arg_363_0 then
				local var_363_9 = "play"
				local var_363_10 = "effect"

				arg_360_1:AudioAction(var_363_9, var_363_10, "se_story", "se_story_explosion", "")
			end

			local var_363_11 = 0
			local var_363_12 = 1.55

			if var_363_11 < arg_360_1.time_ and arg_360_1.time_ <= var_363_11 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_13 = arg_360_1:GetWordFromCfg(423011088)
				local var_363_14 = arg_360_1:FormatText(var_363_13.content)

				arg_360_1.text_.text = var_363_14

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_15 = 62
				local var_363_16 = utf8.len(var_363_14)
				local var_363_17 = var_363_15 <= 0 and var_363_12 or var_363_12 * (var_363_16 / var_363_15)

				if var_363_17 > 0 and var_363_12 < var_363_17 then
					arg_360_1.talkMaxDuration = var_363_17

					if var_363_17 + var_363_11 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_17 + var_363_11
					end
				end

				arg_360_1.text_.text = var_363_14
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_18 = math.max(var_363_12, arg_360_1.talkMaxDuration)

			if var_363_11 <= arg_360_1.time_ and arg_360_1.time_ < var_363_11 + var_363_18 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_11) / var_363_18

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_11 + var_363_18 and arg_360_1.time_ < var_363_11 + var_363_18 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play423011089 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 423011089
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play423011090(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.175

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[7].name)

				arg_364_1.leftNameTxt_.text = var_367_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_3 = arg_364_1:GetWordFromCfg(423011089)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 7
				local var_367_6 = utf8.len(var_367_4)
				local var_367_7 = var_367_5 <= 0 and var_367_1 or var_367_1 * (var_367_6 / var_367_5)

				if var_367_7 > 0 and var_367_1 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_8 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_8 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_8

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_8 and arg_364_1.time_ < var_367_0 + var_367_8 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play423011090 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 423011090
		arg_368_1.duration_ = 2.9

		local var_368_0 = {
			zh = 2.033,
			ja = 2.9
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play423011091(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.175

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[1329].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_3 = arg_368_1:GetWordFromCfg(423011090)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 7
				local var_371_6 = utf8.len(var_371_4)
				local var_371_7 = var_371_5 <= 0 and var_371_1 or var_371_1 * (var_371_6 / var_371_5)

				if var_371_7 > 0 and var_371_1 < var_371_7 then
					arg_368_1.talkMaxDuration = var_371_7

					if var_371_7 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_7 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011090", "story_v_out_423011.awb") ~= 0 then
					local var_371_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011090", "story_v_out_423011.awb") / 1000

					if var_371_8 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_0
					end

					if var_371_3.prefab_name ~= "" and arg_368_1.actors_[var_371_3.prefab_name] ~= nil then
						local var_371_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_3.prefab_name].transform, "story_v_out_423011", "423011090", "story_v_out_423011.awb")

						arg_368_1:RecordAudio("423011090", var_371_9)
						arg_368_1:RecordAudio("423011090", var_371_9)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_423011", "423011090", "story_v_out_423011.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_423011", "423011090", "story_v_out_423011.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_10 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_10 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_10

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_10 and arg_368_1.time_ < var_371_0 + var_371_10 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play423011091 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 423011091
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play423011092(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0
			local var_375_1 = 1.6

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_2 = arg_372_1:GetWordFromCfg(423011091)
				local var_375_3 = arg_372_1:FormatText(var_375_2.content)

				arg_372_1.text_.text = var_375_3

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_4 = 64
				local var_375_5 = utf8.len(var_375_3)
				local var_375_6 = var_375_4 <= 0 and var_375_1 or var_375_1 * (var_375_5 / var_375_4)

				if var_375_6 > 0 and var_375_1 < var_375_6 then
					arg_372_1.talkMaxDuration = var_375_6

					if var_375_6 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_6 + var_375_0
					end
				end

				arg_372_1.text_.text = var_375_3
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_1, arg_372_1.talkMaxDuration)

			if var_375_0 <= arg_372_1.time_ and arg_372_1.time_ < var_375_0 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_0) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_0 + var_375_7 and arg_372_1.time_ < var_375_0 + var_375_7 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play423011092 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 423011092
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play423011093(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.15
			local var_379_1 = 1

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				local var_379_2 = "play"
				local var_379_3 = "effect"

				arg_376_1:AudioAction(var_379_2, var_379_3, "se_story_144", "se_story_144_motorcycle_gun", "")
			end

			local var_379_4 = 0
			local var_379_5 = 1.15

			if var_379_4 < arg_376_1.time_ and arg_376_1.time_ <= var_379_4 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_6 = arg_376_1:GetWordFromCfg(423011092)
				local var_379_7 = arg_376_1:FormatText(var_379_6.content)

				arg_376_1.text_.text = var_379_7

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_8 = 46
				local var_379_9 = utf8.len(var_379_7)
				local var_379_10 = var_379_8 <= 0 and var_379_5 or var_379_5 * (var_379_9 / var_379_8)

				if var_379_10 > 0 and var_379_5 < var_379_10 then
					arg_376_1.talkMaxDuration = var_379_10

					if var_379_10 + var_379_4 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_10 + var_379_4
					end
				end

				arg_376_1.text_.text = var_379_7
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_11 = math.max(var_379_5, arg_376_1.talkMaxDuration)

			if var_379_4 <= arg_376_1.time_ and arg_376_1.time_ < var_379_4 + var_379_11 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_4) / var_379_11

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_4 + var_379_11 and arg_376_1.time_ < var_379_4 + var_379_11 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play423011093 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 423011093
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play423011094(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 0.55

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

				local var_383_2 = arg_380_1:GetWordFromCfg(423011093)
				local var_383_3 = arg_380_1:FormatText(var_383_2.content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_4 = 22
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
	Play423011094 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 423011094
		arg_384_1.duration_ = 2.3

		local var_384_0 = {
			zh = 1.6,
			ja = 2.3
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
				arg_384_0:Play423011095(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0
			local var_387_1 = 0.175

			if var_387_0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_2 = arg_384_1:FormatText(StoryNameCfg[36].name)

				arg_384_1.leftNameTxt_.text = var_387_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_3 = arg_384_1:GetWordFromCfg(423011094)
				local var_387_4 = arg_384_1:FormatText(var_387_3.content)

				arg_384_1.text_.text = var_387_4

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_5 = 7
				local var_387_6 = utf8.len(var_387_4)
				local var_387_7 = var_387_5 <= 0 and var_387_1 or var_387_1 * (var_387_6 / var_387_5)

				if var_387_7 > 0 and var_387_1 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_0
					end
				end

				arg_384_1.text_.text = var_387_4
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011094", "story_v_out_423011.awb") ~= 0 then
					local var_387_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011094", "story_v_out_423011.awb") / 1000

					if var_387_8 + var_387_0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_8 + var_387_0
					end

					if var_387_3.prefab_name ~= "" and arg_384_1.actors_[var_387_3.prefab_name] ~= nil then
						local var_387_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_3.prefab_name].transform, "story_v_out_423011", "423011094", "story_v_out_423011.awb")

						arg_384_1:RecordAudio("423011094", var_387_9)
						arg_384_1:RecordAudio("423011094", var_387_9)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_423011", "423011094", "story_v_out_423011.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_423011", "423011094", "story_v_out_423011.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_10 = math.max(var_387_1, arg_384_1.talkMaxDuration)

			if var_387_0 <= arg_384_1.time_ and arg_384_1.time_ < var_387_0 + var_387_10 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_0) / var_387_10

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_0 + var_387_10 and arg_384_1.time_ < var_387_0 + var_387_10 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play423011095 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 423011095
		arg_388_1.duration_ = 9.97

		local var_388_0 = {
			zh = 8.133,
			ja = 9.966
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
				arg_388_0:Play423011096(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 2

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				local var_391_1 = manager.ui.mainCamera.transform.localPosition
				local var_391_2 = Vector3.New(0, 0, 10) + Vector3.New(var_391_1.x, var_391_1.y, 0)
				local var_391_3 = arg_388_1.bgs_.ST0111

				var_391_3.transform.localPosition = var_391_2
				var_391_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_391_4 = var_391_3:GetComponent("SpriteRenderer")

				if var_391_4 and var_391_4.sprite then
					local var_391_5 = (var_391_3.transform.localPosition - var_391_1).z
					local var_391_6 = manager.ui.mainCameraCom_
					local var_391_7 = 2 * var_391_5 * Mathf.Tan(var_391_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_391_8 = var_391_7 * var_391_6.aspect
					local var_391_9 = var_391_4.sprite.bounds.size.x
					local var_391_10 = var_391_4.sprite.bounds.size.y
					local var_391_11 = var_391_8 / var_391_9
					local var_391_12 = var_391_7 / var_391_10
					local var_391_13 = var_391_12 < var_391_11 and var_391_11 or var_391_12

					var_391_3.transform.localScale = Vector3.New(var_391_13, var_391_13, 0)
				end

				for iter_391_0, iter_391_1 in pairs(arg_388_1.bgs_) do
					if iter_391_0 ~= "ST0111" then
						iter_391_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_391_14 = 3.999999999999

			if var_391_14 < arg_388_1.time_ and arg_388_1.time_ <= var_391_14 + arg_391_0 then
				arg_388_1.allBtn_.enabled = false
			end

			local var_391_15 = 0.3

			if arg_388_1.time_ >= var_391_14 + var_391_15 and arg_388_1.time_ < var_391_14 + var_391_15 + arg_391_0 then
				arg_388_1.allBtn_.enabled = true
			end

			local var_391_16 = 0

			if var_391_16 < arg_388_1.time_ and arg_388_1.time_ <= var_391_16 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_17 = 2

			if var_391_16 <= arg_388_1.time_ and arg_388_1.time_ < var_391_16 + var_391_17 then
				local var_391_18 = (arg_388_1.time_ - var_391_16) / var_391_17
				local var_391_19 = Color.New(0, 0, 0)

				var_391_19.a = Mathf.Lerp(0, 1, var_391_18)
				arg_388_1.mask_.color = var_391_19
			end

			if arg_388_1.time_ >= var_391_16 + var_391_17 and arg_388_1.time_ < var_391_16 + var_391_17 + arg_391_0 then
				local var_391_20 = Color.New(0, 0, 0)

				var_391_20.a = 1
				arg_388_1.mask_.color = var_391_20
			end

			local var_391_21 = 2

			if var_391_21 < arg_388_1.time_ and arg_388_1.time_ <= var_391_21 + arg_391_0 then
				arg_388_1.mask_.enabled = true
				arg_388_1.mask_.raycastTarget = true

				arg_388_1:SetGaussion(false)
			end

			local var_391_22 = 2

			if var_391_21 <= arg_388_1.time_ and arg_388_1.time_ < var_391_21 + var_391_22 then
				local var_391_23 = (arg_388_1.time_ - var_391_21) / var_391_22
				local var_391_24 = Color.New(0, 0, 0)

				var_391_24.a = Mathf.Lerp(1, 0, var_391_23)
				arg_388_1.mask_.color = var_391_24
			end

			if arg_388_1.time_ >= var_391_21 + var_391_22 and arg_388_1.time_ < var_391_21 + var_391_22 + arg_391_0 then
				local var_391_25 = Color.New(0, 0, 0)
				local var_391_26 = 0

				arg_388_1.mask_.enabled = false
				var_391_25.a = var_391_26
				arg_388_1.mask_.color = var_391_25
			end

			if arg_388_1.frameCnt_ <= 1 then
				arg_388_1.dialog_:SetActive(false)
			end

			local var_391_27 = 4
			local var_391_28 = 0.5

			if var_391_27 < arg_388_1.time_ and arg_388_1.time_ <= var_391_27 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0

				arg_388_1.dialog_:SetActive(true)

				arg_388_1.dialogCg_.alpha = 0

				local var_391_29 = LeanTween.value(arg_388_1.dialog_, 0, 1, 0.3)

				var_391_29:setOnUpdate(LuaHelper.FloatAction(function(arg_392_0)
					arg_388_1.dialogCg_.alpha = arg_392_0
				end))
				var_391_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_388_1.dialog_)
					var_391_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_388_1.duration_ = arg_388_1.duration_ + 0.3

				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_30 = arg_388_1:FormatText(StoryNameCfg[1329].name)

				arg_388_1.leftNameTxt_.text = var_391_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, true)
				arg_388_1.iconController_:SetSelectedState("hero")

				arg_388_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2084")

				arg_388_1.callingController_:SetSelectedState("normal")

				arg_388_1.keyicon_.color = Color.New(1, 1, 1)
				arg_388_1.icon_.color = Color.New(1, 1, 1)

				local var_391_31 = arg_388_1:GetWordFromCfg(423011095)
				local var_391_32 = arg_388_1:FormatText(var_391_31.content)

				arg_388_1.text_.text = var_391_32

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_33 = 21
				local var_391_34 = utf8.len(var_391_32)
				local var_391_35 = var_391_33 <= 0 and var_391_28 or var_391_28 * (var_391_34 / var_391_33)

				if var_391_35 > 0 and var_391_28 < var_391_35 then
					arg_388_1.talkMaxDuration = var_391_35
					var_391_27 = var_391_27 + 0.3

					if var_391_35 + var_391_27 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_35 + var_391_27
					end
				end

				arg_388_1.text_.text = var_391_32
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011095", "story_v_out_423011.awb") ~= 0 then
					local var_391_36 = manager.audio:GetVoiceLength("story_v_out_423011", "423011095", "story_v_out_423011.awb") / 1000

					if var_391_36 + var_391_27 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_36 + var_391_27
					end

					if var_391_31.prefab_name ~= "" and arg_388_1.actors_[var_391_31.prefab_name] ~= nil then
						local var_391_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_31.prefab_name].transform, "story_v_out_423011", "423011095", "story_v_out_423011.awb")

						arg_388_1:RecordAudio("423011095", var_391_37)
						arg_388_1:RecordAudio("423011095", var_391_37)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_423011", "423011095", "story_v_out_423011.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_423011", "423011095", "story_v_out_423011.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_38 = var_391_27 + 0.3
			local var_391_39 = math.max(var_391_28, arg_388_1.talkMaxDuration)

			if var_391_38 <= arg_388_1.time_ and arg_388_1.time_ < var_391_38 + var_391_39 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_38) / var_391_39

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_38 + var_391_39 and arg_388_1.time_ < var_391_38 + var_391_39 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play423011096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 423011096
		arg_394_1.duration_ = 6.33

		local var_394_0 = {
			zh = 3.266,
			ja = 6.333
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play423011097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0
			local var_397_1 = 0.4

			if var_397_0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				local var_397_2 = arg_394_1:FormatText(StoryNameCfg[1328].name)

				arg_394_1.leftNameTxt_.text = var_397_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, true)
				arg_394_1.iconController_:SetSelectedState("hero")

				arg_394_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_394_1.callingController_:SetSelectedState("normal")

				arg_394_1.keyicon_.color = Color.New(1, 1, 1)
				arg_394_1.icon_.color = Color.New(1, 1, 1)

				local var_397_3 = arg_394_1:GetWordFromCfg(423011096)
				local var_397_4 = arg_394_1:FormatText(var_397_3.content)

				arg_394_1.text_.text = var_397_4

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_5 = 16
				local var_397_6 = utf8.len(var_397_4)
				local var_397_7 = var_397_5 <= 0 and var_397_1 or var_397_1 * (var_397_6 / var_397_5)

				if var_397_7 > 0 and var_397_1 < var_397_7 then
					arg_394_1.talkMaxDuration = var_397_7

					if var_397_7 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_7 + var_397_0
					end
				end

				arg_394_1.text_.text = var_397_4
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011096", "story_v_out_423011.awb") ~= 0 then
					local var_397_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011096", "story_v_out_423011.awb") / 1000

					if var_397_8 + var_397_0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_8 + var_397_0
					end

					if var_397_3.prefab_name ~= "" and arg_394_1.actors_[var_397_3.prefab_name] ~= nil then
						local var_397_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_3.prefab_name].transform, "story_v_out_423011", "423011096", "story_v_out_423011.awb")

						arg_394_1:RecordAudio("423011096", var_397_9)
						arg_394_1:RecordAudio("423011096", var_397_9)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_423011", "423011096", "story_v_out_423011.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_423011", "423011096", "story_v_out_423011.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_10 = math.max(var_397_1, arg_394_1.talkMaxDuration)

			if var_397_0 <= arg_394_1.time_ and arg_394_1.time_ < var_397_0 + var_397_10 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_0) / var_397_10

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_0 + var_397_10 and arg_394_1.time_ < var_397_0 + var_397_10 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play423011097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 423011097
		arg_398_1.duration_ = 7.87

		local var_398_0 = {
			zh = 6.933,
			ja = 7.866
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play423011098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 0
			local var_401_1 = 0.775

			if var_401_0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				local var_401_2 = arg_398_1:FormatText(StoryNameCfg[1330].name)

				arg_398_1.leftNameTxt_.text = var_401_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, true)
				arg_398_1.iconController_:SetSelectedState("hero")

				arg_398_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_398_1.callingController_:SetSelectedState("normal")

				arg_398_1.keyicon_.color = Color.New(1, 1, 1)
				arg_398_1.icon_.color = Color.New(1, 1, 1)

				local var_401_3 = arg_398_1:GetWordFromCfg(423011097)
				local var_401_4 = arg_398_1:FormatText(var_401_3.content)

				arg_398_1.text_.text = var_401_4

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_5 = 32
				local var_401_6 = utf8.len(var_401_4)
				local var_401_7 = var_401_5 <= 0 and var_401_1 or var_401_1 * (var_401_6 / var_401_5)

				if var_401_7 > 0 and var_401_1 < var_401_7 then
					arg_398_1.talkMaxDuration = var_401_7

					if var_401_7 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_7 + var_401_0
					end
				end

				arg_398_1.text_.text = var_401_4
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011097", "story_v_out_423011.awb") ~= 0 then
					local var_401_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011097", "story_v_out_423011.awb") / 1000

					if var_401_8 + var_401_0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_8 + var_401_0
					end

					if var_401_3.prefab_name ~= "" and arg_398_1.actors_[var_401_3.prefab_name] ~= nil then
						local var_401_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_3.prefab_name].transform, "story_v_out_423011", "423011097", "story_v_out_423011.awb")

						arg_398_1:RecordAudio("423011097", var_401_9)
						arg_398_1:RecordAudio("423011097", var_401_9)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_423011", "423011097", "story_v_out_423011.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_423011", "423011097", "story_v_out_423011.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_10 = math.max(var_401_1, arg_398_1.talkMaxDuration)

			if var_401_0 <= arg_398_1.time_ and arg_398_1.time_ < var_401_0 + var_401_10 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_0) / var_401_10

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_0 + var_401_10 and arg_398_1.time_ < var_401_0 + var_401_10 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play423011098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 423011098
		arg_402_1.duration_ = 3.77

		local var_402_0 = {
			zh = 3.766,
			ja = 3.633
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play423011099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0
			local var_405_1 = 0.375

			if var_405_0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				local var_405_2 = arg_402_1:FormatText(StoryNameCfg[1330].name)

				arg_402_1.leftNameTxt_.text = var_405_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_3 = arg_402_1:GetWordFromCfg(423011098)
				local var_405_4 = arg_402_1:FormatText(var_405_3.content)

				arg_402_1.text_.text = var_405_4

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_5 = 15
				local var_405_6 = utf8.len(var_405_4)
				local var_405_7 = var_405_5 <= 0 and var_405_1 or var_405_1 * (var_405_6 / var_405_5)

				if var_405_7 > 0 and var_405_1 < var_405_7 then
					arg_402_1.talkMaxDuration = var_405_7

					if var_405_7 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_7 + var_405_0
					end
				end

				arg_402_1.text_.text = var_405_4
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011098", "story_v_out_423011.awb") ~= 0 then
					local var_405_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011098", "story_v_out_423011.awb") / 1000

					if var_405_8 + var_405_0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_8 + var_405_0
					end

					if var_405_3.prefab_name ~= "" and arg_402_1.actors_[var_405_3.prefab_name] ~= nil then
						local var_405_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_3.prefab_name].transform, "story_v_out_423011", "423011098", "story_v_out_423011.awb")

						arg_402_1:RecordAudio("423011098", var_405_9)
						arg_402_1:RecordAudio("423011098", var_405_9)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_423011", "423011098", "story_v_out_423011.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_423011", "423011098", "story_v_out_423011.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_10 = math.max(var_405_1, arg_402_1.talkMaxDuration)

			if var_405_0 <= arg_402_1.time_ and arg_402_1.time_ < var_405_0 + var_405_10 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_0) / var_405_10

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_0 + var_405_10 and arg_402_1.time_ < var_405_0 + var_405_10 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play423011099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 423011099
		arg_406_1.duration_ = 12.37

		local var_406_0 = {
			zh = 8.2,
			ja = 12.366
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play423011100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = manager.ui.mainCamera.transform
			local var_409_1 = 0

			if var_409_1 < arg_406_1.time_ and arg_406_1.time_ <= var_409_1 + arg_409_0 then
				arg_406_1.var_.shakeOldPos = var_409_0.localPosition
			end

			local var_409_2 = 0.5

			if var_409_1 <= arg_406_1.time_ and arg_406_1.time_ < var_409_1 + var_409_2 then
				local var_409_3 = (arg_406_1.time_ - var_409_1) / 0.066
				local var_409_4, var_409_5 = math.modf(var_409_3)

				var_409_0.localPosition = Vector3.New(var_409_5 * 0.13, var_409_5 * 0.13, var_409_5 * 0.13) + arg_406_1.var_.shakeOldPos
			end

			if arg_406_1.time_ >= var_409_1 + var_409_2 and arg_406_1.time_ < var_409_1 + var_409_2 + arg_409_0 then
				var_409_0.localPosition = arg_406_1.var_.shakeOldPos
			end

			local var_409_6 = 0

			if var_409_6 < arg_406_1.time_ and arg_406_1.time_ <= var_409_6 + arg_409_0 then
				arg_406_1.allBtn_.enabled = false
			end

			local var_409_7 = 0.5

			if arg_406_1.time_ >= var_409_6 + var_409_7 and arg_406_1.time_ < var_409_6 + var_409_7 + arg_409_0 then
				arg_406_1.allBtn_.enabled = true
			end

			local var_409_8 = 0
			local var_409_9 = 1.075

			if var_409_8 < arg_406_1.time_ and arg_406_1.time_ <= var_409_8 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_10 = arg_406_1:FormatText(StoryNameCfg[1328].name)

				arg_406_1.leftNameTxt_.text = var_409_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_11 = arg_406_1:GetWordFromCfg(423011099)
				local var_409_12 = arg_406_1:FormatText(var_409_11.content)

				arg_406_1.text_.text = var_409_12

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_13 = 43
				local var_409_14 = utf8.len(var_409_12)
				local var_409_15 = var_409_13 <= 0 and var_409_9 or var_409_9 * (var_409_14 / var_409_13)

				if var_409_15 > 0 and var_409_9 < var_409_15 then
					arg_406_1.talkMaxDuration = var_409_15

					if var_409_15 + var_409_8 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_15 + var_409_8
					end
				end

				arg_406_1.text_.text = var_409_12
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011099", "story_v_out_423011.awb") ~= 0 then
					local var_409_16 = manager.audio:GetVoiceLength("story_v_out_423011", "423011099", "story_v_out_423011.awb") / 1000

					if var_409_16 + var_409_8 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_16 + var_409_8
					end

					if var_409_11.prefab_name ~= "" and arg_406_1.actors_[var_409_11.prefab_name] ~= nil then
						local var_409_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_11.prefab_name].transform, "story_v_out_423011", "423011099", "story_v_out_423011.awb")

						arg_406_1:RecordAudio("423011099", var_409_17)
						arg_406_1:RecordAudio("423011099", var_409_17)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_423011", "423011099", "story_v_out_423011.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_423011", "423011099", "story_v_out_423011.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_18 = math.max(var_409_9, arg_406_1.talkMaxDuration)

			if var_409_8 <= arg_406_1.time_ and arg_406_1.time_ < var_409_8 + var_409_18 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_8) / var_409_18

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_8 + var_409_18 and arg_406_1.time_ < var_409_8 + var_409_18 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play423011100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 423011100
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play423011101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0
			local var_413_1 = 0.775

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_2 = arg_410_1:GetWordFromCfg(423011100)
				local var_413_3 = arg_410_1:FormatText(var_413_2.content)

				arg_410_1.text_.text = var_413_3

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_4 = 31
				local var_413_5 = utf8.len(var_413_3)
				local var_413_6 = var_413_4 <= 0 and var_413_1 or var_413_1 * (var_413_5 / var_413_4)

				if var_413_6 > 0 and var_413_1 < var_413_6 then
					arg_410_1.talkMaxDuration = var_413_6

					if var_413_6 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_6 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_3
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_7 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_7 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_7

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_7 and arg_410_1.time_ < var_413_0 + var_413_7 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play423011101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 423011101
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play423011102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 1.225

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_2 = arg_414_1:GetWordFromCfg(423011101)
				local var_417_3 = arg_414_1:FormatText(var_417_2.content)

				arg_414_1.text_.text = var_417_3

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_4 = 49
				local var_417_5 = utf8.len(var_417_3)
				local var_417_6 = var_417_4 <= 0 and var_417_1 or var_417_1 * (var_417_5 / var_417_4)

				if var_417_6 > 0 and var_417_1 < var_417_6 then
					arg_414_1.talkMaxDuration = var_417_6

					if var_417_6 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_6 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_3
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_7 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_7 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_7

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_7 and arg_414_1.time_ < var_417_0 + var_417_7 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play423011102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 423011102
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play423011103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0
			local var_421_1 = 0.775

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				local var_421_2 = arg_418_1:FormatText(StoryNameCfg[7].name)

				arg_418_1.leftNameTxt_.text = var_421_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, true)
				arg_418_1.iconController_:SetSelectedState("hero")

				arg_418_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_418_1.callingController_:SetSelectedState("normal")

				arg_418_1.keyicon_.color = Color.New(1, 1, 1)
				arg_418_1.icon_.color = Color.New(1, 1, 1)

				local var_421_3 = arg_418_1:GetWordFromCfg(423011102)
				local var_421_4 = arg_418_1:FormatText(var_421_3.content)

				arg_418_1.text_.text = var_421_4

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_5 = 31
				local var_421_6 = utf8.len(var_421_4)
				local var_421_7 = var_421_5 <= 0 and var_421_1 or var_421_1 * (var_421_6 / var_421_5)

				if var_421_7 > 0 and var_421_1 < var_421_7 then
					arg_418_1.talkMaxDuration = var_421_7

					if var_421_7 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_7 + var_421_0
					end
				end

				arg_418_1.text_.text = var_421_4
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_8 = math.max(var_421_1, arg_418_1.talkMaxDuration)

			if var_421_0 <= arg_418_1.time_ and arg_418_1.time_ < var_421_0 + var_421_8 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_0) / var_421_8

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_0 + var_421_8 and arg_418_1.time_ < var_421_0 + var_421_8 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play423011103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 423011103
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play423011104(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0
			local var_425_1 = 0.925

			if var_425_0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_2 = arg_422_1:GetWordFromCfg(423011103)
				local var_425_3 = arg_422_1:FormatText(var_425_2.content)

				arg_422_1.text_.text = var_425_3

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_4 = 37
				local var_425_5 = utf8.len(var_425_3)
				local var_425_6 = var_425_4 <= 0 and var_425_1 or var_425_1 * (var_425_5 / var_425_4)

				if var_425_6 > 0 and var_425_1 < var_425_6 then
					arg_422_1.talkMaxDuration = var_425_6

					if var_425_6 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_6 + var_425_0
					end
				end

				arg_422_1.text_.text = var_425_3
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_7 = math.max(var_425_1, arg_422_1.talkMaxDuration)

			if var_425_0 <= arg_422_1.time_ and arg_422_1.time_ < var_425_0 + var_425_7 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_0) / var_425_7

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_0 + var_425_7 and arg_422_1.time_ < var_425_0 + var_425_7 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play423011104 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 423011104
		arg_426_1.duration_ = 13.23

		local var_426_0 = {
			zh = 10.366,
			ja = 13.233
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play423011105(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = 0
			local var_429_1 = 1.025

			if var_429_0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_0 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_2 = arg_426_1:FormatText(StoryNameCfg[1327].name)

				arg_426_1.leftNameTxt_.text = var_429_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, true)
				arg_426_1.iconController_:SetSelectedState("hero")

				arg_426_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_426_1.callingController_:SetSelectedState("normal")

				arg_426_1.keyicon_.color = Color.New(1, 1, 1)
				arg_426_1.icon_.color = Color.New(1, 1, 1)

				local var_429_3 = arg_426_1:GetWordFromCfg(423011104)
				local var_429_4 = arg_426_1:FormatText(var_429_3.content)

				arg_426_1.text_.text = var_429_4

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_5 = 41
				local var_429_6 = utf8.len(var_429_4)
				local var_429_7 = var_429_5 <= 0 and var_429_1 or var_429_1 * (var_429_6 / var_429_5)

				if var_429_7 > 0 and var_429_1 < var_429_7 then
					arg_426_1.talkMaxDuration = var_429_7

					if var_429_7 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_7 + var_429_0
					end
				end

				arg_426_1.text_.text = var_429_4
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011104", "story_v_out_423011.awb") ~= 0 then
					local var_429_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011104", "story_v_out_423011.awb") / 1000

					if var_429_8 + var_429_0 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_8 + var_429_0
					end

					if var_429_3.prefab_name ~= "" and arg_426_1.actors_[var_429_3.prefab_name] ~= nil then
						local var_429_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_3.prefab_name].transform, "story_v_out_423011", "423011104", "story_v_out_423011.awb")

						arg_426_1:RecordAudio("423011104", var_429_9)
						arg_426_1:RecordAudio("423011104", var_429_9)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_423011", "423011104", "story_v_out_423011.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_423011", "423011104", "story_v_out_423011.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_10 = math.max(var_429_1, arg_426_1.talkMaxDuration)

			if var_429_0 <= arg_426_1.time_ and arg_426_1.time_ < var_429_0 + var_429_10 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_0) / var_429_10

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_0 + var_429_10 and arg_426_1.time_ < var_429_0 + var_429_10 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play423011105 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 423011105
		arg_430_1.duration_ = 6.87

		local var_430_0 = {
			zh = 5.2,
			ja = 6.866
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play423011106(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0
			local var_433_1 = 0.65

			if var_433_0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_2 = arg_430_1:FormatText(StoryNameCfg[1327].name)

				arg_430_1.leftNameTxt_.text = var_433_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_3 = arg_430_1:GetWordFromCfg(423011105)
				local var_433_4 = arg_430_1:FormatText(var_433_3.content)

				arg_430_1.text_.text = var_433_4

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_5 = 26
				local var_433_6 = utf8.len(var_433_4)
				local var_433_7 = var_433_5 <= 0 and var_433_1 or var_433_1 * (var_433_6 / var_433_5)

				if var_433_7 > 0 and var_433_1 < var_433_7 then
					arg_430_1.talkMaxDuration = var_433_7

					if var_433_7 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_7 + var_433_0
					end
				end

				arg_430_1.text_.text = var_433_4
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011105", "story_v_out_423011.awb") ~= 0 then
					local var_433_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011105", "story_v_out_423011.awb") / 1000

					if var_433_8 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_8 + var_433_0
					end

					if var_433_3.prefab_name ~= "" and arg_430_1.actors_[var_433_3.prefab_name] ~= nil then
						local var_433_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_3.prefab_name].transform, "story_v_out_423011", "423011105", "story_v_out_423011.awb")

						arg_430_1:RecordAudio("423011105", var_433_9)
						arg_430_1:RecordAudio("423011105", var_433_9)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_423011", "423011105", "story_v_out_423011.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_423011", "423011105", "story_v_out_423011.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_10 = math.max(var_433_1, arg_430_1.talkMaxDuration)

			if var_433_0 <= arg_430_1.time_ and arg_430_1.time_ < var_433_0 + var_433_10 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_0) / var_433_10

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_0 + var_433_10 and arg_430_1.time_ < var_433_0 + var_433_10 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play423011106 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 423011106
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play423011107(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0
			local var_437_1 = 0.9

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_2 = arg_434_1:GetWordFromCfg(423011106)
				local var_437_3 = arg_434_1:FormatText(var_437_2.content)

				arg_434_1.text_.text = var_437_3

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_4 = 36
				local var_437_5 = utf8.len(var_437_3)
				local var_437_6 = var_437_4 <= 0 and var_437_1 or var_437_1 * (var_437_5 / var_437_4)

				if var_437_6 > 0 and var_437_1 < var_437_6 then
					arg_434_1.talkMaxDuration = var_437_6

					if var_437_6 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_6 + var_437_0
					end
				end

				arg_434_1.text_.text = var_437_3
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_7 = math.max(var_437_1, arg_434_1.talkMaxDuration)

			if var_437_0 <= arg_434_1.time_ and arg_434_1.time_ < var_437_0 + var_437_7 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_0) / var_437_7

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_0 + var_437_7 and arg_434_1.time_ < var_437_0 + var_437_7 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play423011107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 423011107
		arg_438_1.duration_ = 5

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play423011108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0.533333333333333
			local var_441_1 = 1

			if var_441_0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_0 + arg_441_0 then
				local var_441_2 = "play"
				local var_441_3 = "effect"

				arg_438_1:AudioAction(var_441_2, var_441_3, "se_story_1310", "se_story_1310_hitdoor", "")
			end

			local var_441_4 = 0
			local var_441_5 = 1.05

			if var_441_4 < arg_438_1.time_ and arg_438_1.time_ <= var_441_4 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, false)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_6 = arg_438_1:GetWordFromCfg(423011107)
				local var_441_7 = arg_438_1:FormatText(var_441_6.content)

				arg_438_1.text_.text = var_441_7

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_8 = 42
				local var_441_9 = utf8.len(var_441_7)
				local var_441_10 = var_441_8 <= 0 and var_441_5 or var_441_5 * (var_441_9 / var_441_8)

				if var_441_10 > 0 and var_441_5 < var_441_10 then
					arg_438_1.talkMaxDuration = var_441_10

					if var_441_10 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_10 + var_441_4
					end
				end

				arg_438_1.text_.text = var_441_7
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)
				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_11 = math.max(var_441_5, arg_438_1.talkMaxDuration)

			if var_441_4 <= arg_438_1.time_ and arg_438_1.time_ < var_441_4 + var_441_11 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_4) / var_441_11

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_4 + var_441_11 and arg_438_1.time_ < var_441_4 + var_441_11 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play423011108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 423011108
		arg_442_1.duration_ = 14.47

		local var_442_0 = {
			zh = 13.9,
			ja = 14.466
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play423011109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = "SS2301"

			if arg_442_1.bgs_[var_445_0] == nil then
				local var_445_1 = Object.Instantiate(arg_442_1.paintGo_)

				var_445_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_445_0)
				var_445_1.name = var_445_0
				var_445_1.transform.parent = arg_442_1.stage_.transform
				var_445_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_442_1.bgs_[var_445_0] = var_445_1
			end

			local var_445_2 = 2

			if var_445_2 < arg_442_1.time_ and arg_442_1.time_ <= var_445_2 + arg_445_0 then
				local var_445_3 = manager.ui.mainCamera.transform.localPosition
				local var_445_4 = Vector3.New(0, 0, 10) + Vector3.New(var_445_3.x, var_445_3.y, 0)
				local var_445_5 = arg_442_1.bgs_.SS2301

				var_445_5.transform.localPosition = var_445_4
				var_445_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_445_6 = var_445_5:GetComponent("SpriteRenderer")

				if var_445_6 and var_445_6.sprite then
					local var_445_7 = (var_445_5.transform.localPosition - var_445_3).z
					local var_445_8 = manager.ui.mainCameraCom_
					local var_445_9 = 2 * var_445_7 * Mathf.Tan(var_445_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_445_10 = var_445_9 * var_445_8.aspect
					local var_445_11 = var_445_6.sprite.bounds.size.x
					local var_445_12 = var_445_6.sprite.bounds.size.y
					local var_445_13 = var_445_10 / var_445_11
					local var_445_14 = var_445_9 / var_445_12
					local var_445_15 = var_445_14 < var_445_13 and var_445_13 or var_445_14

					var_445_5.transform.localScale = Vector3.New(var_445_15, var_445_15, 0)
				end

				for iter_445_0, iter_445_1 in pairs(arg_442_1.bgs_) do
					if iter_445_0 ~= "SS2301" then
						iter_445_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_445_16 = 4

			if var_445_16 < arg_442_1.time_ and arg_442_1.time_ <= var_445_16 + arg_445_0 then
				arg_442_1.allBtn_.enabled = false
			end

			local var_445_17 = 0.3

			if arg_442_1.time_ >= var_445_16 + var_445_17 and arg_442_1.time_ < var_445_16 + var_445_17 + arg_445_0 then
				arg_442_1.allBtn_.enabled = true
			end

			local var_445_18 = 0

			if var_445_18 < arg_442_1.time_ and arg_442_1.time_ <= var_445_18 + arg_445_0 then
				arg_442_1.mask_.enabled = true
				arg_442_1.mask_.raycastTarget = true

				arg_442_1:SetGaussion(false)
			end

			local var_445_19 = 2

			if var_445_18 <= arg_442_1.time_ and arg_442_1.time_ < var_445_18 + var_445_19 then
				local var_445_20 = (arg_442_1.time_ - var_445_18) / var_445_19
				local var_445_21 = Color.New(0, 0, 0)

				var_445_21.a = Mathf.Lerp(0, 1, var_445_20)
				arg_442_1.mask_.color = var_445_21
			end

			if arg_442_1.time_ >= var_445_18 + var_445_19 and arg_442_1.time_ < var_445_18 + var_445_19 + arg_445_0 then
				local var_445_22 = Color.New(0, 0, 0)

				var_445_22.a = 1
				arg_442_1.mask_.color = var_445_22
			end

			local var_445_23 = 2

			if var_445_23 < arg_442_1.time_ and arg_442_1.time_ <= var_445_23 + arg_445_0 then
				arg_442_1.mask_.enabled = true
				arg_442_1.mask_.raycastTarget = true

				arg_442_1:SetGaussion(false)
			end

			local var_445_24 = 2

			if var_445_23 <= arg_442_1.time_ and arg_442_1.time_ < var_445_23 + var_445_24 then
				local var_445_25 = (arg_442_1.time_ - var_445_23) / var_445_24
				local var_445_26 = Color.New(0, 0, 0)

				var_445_26.a = Mathf.Lerp(1, 0, var_445_25)
				arg_442_1.mask_.color = var_445_26
			end

			if arg_442_1.time_ >= var_445_23 + var_445_24 and arg_442_1.time_ < var_445_23 + var_445_24 + arg_445_0 then
				local var_445_27 = Color.New(0, 0, 0)
				local var_445_28 = 0

				arg_442_1.mask_.enabled = false
				var_445_27.a = var_445_28
				arg_442_1.mask_.color = var_445_27
			end

			local var_445_29 = manager.ui.mainCamera.transform
			local var_445_30 = 2

			if var_445_30 < arg_442_1.time_ and arg_442_1.time_ <= var_445_30 + arg_445_0 then
				local var_445_31 = arg_442_1.var_.effectliechebaozha2

				if var_445_31 then
					Object.Destroy(var_445_31)

					arg_442_1.var_.effectliechebaozha2 = nil
				end
			end

			local var_445_32 = arg_442_1.bgs_.SS2301.transform
			local var_445_33 = 1.9

			if var_445_33 < arg_442_1.time_ and arg_442_1.time_ <= var_445_33 + arg_445_0 then
				arg_442_1.var_.moveOldPosSS2301 = var_445_32.localPosition
			end

			local var_445_34 = 0.1

			if var_445_33 <= arg_442_1.time_ and arg_442_1.time_ < var_445_33 + var_445_34 then
				local var_445_35 = (arg_442_1.time_ - var_445_33) / var_445_34
				local var_445_36 = Vector3.New(0, 1, 9.5)

				var_445_32.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPosSS2301, var_445_36, var_445_35)
			end

			if arg_442_1.time_ >= var_445_33 + var_445_34 and arg_442_1.time_ < var_445_33 + var_445_34 + arg_445_0 then
				var_445_32.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_445_37 = arg_442_1.bgs_.SS2301.transform
			local var_445_38 = 2

			if var_445_38 < arg_442_1.time_ and arg_442_1.time_ <= var_445_38 + arg_445_0 then
				arg_442_1.var_.moveOldPosSS2301 = var_445_37.localPosition
			end

			local var_445_39 = 4.5

			if var_445_38 <= arg_442_1.time_ and arg_442_1.time_ < var_445_38 + var_445_39 then
				local var_445_40 = (arg_442_1.time_ - var_445_38) / var_445_39
				local var_445_41 = Vector3.New(0, 1, 10)

				var_445_37.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPosSS2301, var_445_41, var_445_40)
			end

			if arg_442_1.time_ >= var_445_38 + var_445_39 and arg_442_1.time_ < var_445_38 + var_445_39 + arg_445_0 then
				var_445_37.localPosition = Vector3.New(0, 1, 10)
			end

			local var_445_42 = manager.ui.mainCamera.transform
			local var_445_43 = 2

			if var_445_43 < arg_442_1.time_ and arg_442_1.time_ <= var_445_43 + arg_445_0 then
				local var_445_44 = arg_442_1.var_.effectcangmendakai
				local var_445_45
				local var_445_46 = var_445_42

				if not var_445_44 then
					var_445_44 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), var_445_46)
					var_445_44.name = "cangmendakai"
					arg_442_1.var_.effectcangmendakai = var_445_44
				else
					var_445_44.transform:SetParent(var_445_46)
				end

				var_445_44.transform.localPosition = Vector3.New(0, 0, 0)
				var_445_44.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_445_47 = 1.56666666666667
			local var_445_48 = 1

			if var_445_47 < arg_442_1.time_ and arg_442_1.time_ <= var_445_47 + arg_445_0 then
				local var_445_49 = "play"
				local var_445_50 = "effect"

				arg_442_1:AudioAction(var_445_49, var_445_50, "se_story_144", "se_story_144_amb_town_wind_loop", "")
			end

			local var_445_51 = 0.166666666666667
			local var_445_52 = 1

			if var_445_51 < arg_442_1.time_ and arg_442_1.time_ <= var_445_51 + arg_445_0 then
				local var_445_53 = "stop"
				local var_445_54 = "effect"

				arg_442_1:AudioAction(var_445_53, var_445_54, "se_story_17", "se_story_17_fire_loop", "")
			end

			if arg_442_1.frameCnt_ <= 1 then
				arg_442_1.dialog_:SetActive(false)
			end

			local var_445_55 = 4
			local var_445_56 = 0.85

			if var_445_55 < arg_442_1.time_ and arg_442_1.time_ <= var_445_55 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0

				arg_442_1.dialog_:SetActive(true)

				arg_442_1.dialogCg_.alpha = 0

				local var_445_57 = LeanTween.value(arg_442_1.dialog_, 0, 1, 0.3)

				var_445_57:setOnUpdate(LuaHelper.FloatAction(function(arg_446_0)
					arg_442_1.dialogCg_.alpha = arg_446_0
				end))
				var_445_57:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_442_1.dialog_)
					var_445_57:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_442_1.duration_ = arg_442_1.duration_ + 0.3

				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_58 = arg_442_1:FormatText(StoryNameCfg[36].name)

				arg_442_1.leftNameTxt_.text = var_445_58

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_59 = arg_442_1:GetWordFromCfg(423011108)
				local var_445_60 = arg_442_1:FormatText(var_445_59.content)

				arg_442_1.text_.text = var_445_60

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_61 = 34
				local var_445_62 = utf8.len(var_445_60)
				local var_445_63 = var_445_61 <= 0 and var_445_56 or var_445_56 * (var_445_62 / var_445_61)

				if var_445_63 > 0 and var_445_56 < var_445_63 then
					arg_442_1.talkMaxDuration = var_445_63
					var_445_55 = var_445_55 + 0.3

					if var_445_63 + var_445_55 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_63 + var_445_55
					end
				end

				arg_442_1.text_.text = var_445_60
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011108", "story_v_out_423011.awb") ~= 0 then
					local var_445_64 = manager.audio:GetVoiceLength("story_v_out_423011", "423011108", "story_v_out_423011.awb") / 1000

					if var_445_64 + var_445_55 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_64 + var_445_55
					end

					if var_445_59.prefab_name ~= "" and arg_442_1.actors_[var_445_59.prefab_name] ~= nil then
						local var_445_65 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_59.prefab_name].transform, "story_v_out_423011", "423011108", "story_v_out_423011.awb")

						arg_442_1:RecordAudio("423011108", var_445_65)
						arg_442_1:RecordAudio("423011108", var_445_65)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_423011", "423011108", "story_v_out_423011.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_423011", "423011108", "story_v_out_423011.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_66 = var_445_55 + 0.3
			local var_445_67 = math.max(var_445_56, arg_442_1.talkMaxDuration)

			if var_445_66 <= arg_442_1.time_ and arg_442_1.time_ < var_445_66 + var_445_67 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_66) / var_445_67

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_66 + var_445_67 and arg_442_1.time_ < var_445_66 + var_445_67 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play423011109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 423011109
		arg_448_1.duration_ = 5

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play423011110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0.333333333333333
			local var_451_1 = 1

			if var_451_0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_0 + arg_451_0 then
				local var_451_2 = "play"
				local var_451_3 = "effect"

				arg_448_1:AudioAction(var_451_2, var_451_3, "se_story_144", "se_story_144_footstep02", "")
			end

			local var_451_4 = 0
			local var_451_5 = 0.875

			if var_451_4 < arg_448_1.time_ and arg_448_1.time_ <= var_451_4 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, false)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_6 = arg_448_1:GetWordFromCfg(423011109)
				local var_451_7 = arg_448_1:FormatText(var_451_6.content)

				arg_448_1.text_.text = var_451_7

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_8 = 35
				local var_451_9 = utf8.len(var_451_7)
				local var_451_10 = var_451_8 <= 0 and var_451_5 or var_451_5 * (var_451_9 / var_451_8)

				if var_451_10 > 0 and var_451_5 < var_451_10 then
					arg_448_1.talkMaxDuration = var_451_10

					if var_451_10 + var_451_4 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_10 + var_451_4
					end
				end

				arg_448_1.text_.text = var_451_7
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_11 = math.max(var_451_5, arg_448_1.talkMaxDuration)

			if var_451_4 <= arg_448_1.time_ and arg_448_1.time_ < var_451_4 + var_451_11 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_4) / var_451_11

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_4 + var_451_11 and arg_448_1.time_ < var_451_4 + var_451_11 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play423011110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 423011110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play423011111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 0
			local var_455_1 = 0.9

			if var_455_0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_2 = arg_452_1:GetWordFromCfg(423011110)
				local var_455_3 = arg_452_1:FormatText(var_455_2.content)

				arg_452_1.text_.text = var_455_3

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_4 = 36
				local var_455_5 = utf8.len(var_455_3)
				local var_455_6 = var_455_4 <= 0 and var_455_1 or var_455_1 * (var_455_5 / var_455_4)

				if var_455_6 > 0 and var_455_1 < var_455_6 then
					arg_452_1.talkMaxDuration = var_455_6

					if var_455_6 + var_455_0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_6 + var_455_0
					end
				end

				arg_452_1.text_.text = var_455_3
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_7 = math.max(var_455_1, arg_452_1.talkMaxDuration)

			if var_455_0 <= arg_452_1.time_ and arg_452_1.time_ < var_455_0 + var_455_7 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_0) / var_455_7

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_0 + var_455_7 and arg_452_1.time_ < var_455_0 + var_455_7 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play423011111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 423011111
		arg_456_1.duration_ = 7.43

		local var_456_0 = {
			zh = 5.366,
			ja = 7.433
		}
		local var_456_1 = manager.audio:GetLocalizationFlag()

		if var_456_0[var_456_1] ~= nil then
			arg_456_1.duration_ = var_456_0[var_456_1]
		end

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play423011112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0
			local var_459_1 = 0.55

			if var_459_0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				local var_459_2 = arg_456_1:FormatText(StoryNameCfg[36].name)

				arg_456_1.leftNameTxt_.text = var_459_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_3 = arg_456_1:GetWordFromCfg(423011111)
				local var_459_4 = arg_456_1:FormatText(var_459_3.content)

				arg_456_1.text_.text = var_459_4

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_5 = 22
				local var_459_6 = utf8.len(var_459_4)
				local var_459_7 = var_459_5 <= 0 and var_459_1 or var_459_1 * (var_459_6 / var_459_5)

				if var_459_7 > 0 and var_459_1 < var_459_7 then
					arg_456_1.talkMaxDuration = var_459_7

					if var_459_7 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_7 + var_459_0
					end
				end

				arg_456_1.text_.text = var_459_4
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011111", "story_v_out_423011.awb") ~= 0 then
					local var_459_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011111", "story_v_out_423011.awb") / 1000

					if var_459_8 + var_459_0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_8 + var_459_0
					end

					if var_459_3.prefab_name ~= "" and arg_456_1.actors_[var_459_3.prefab_name] ~= nil then
						local var_459_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_3.prefab_name].transform, "story_v_out_423011", "423011111", "story_v_out_423011.awb")

						arg_456_1:RecordAudio("423011111", var_459_9)
						arg_456_1:RecordAudio("423011111", var_459_9)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_423011", "423011111", "story_v_out_423011.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_423011", "423011111", "story_v_out_423011.awb")
				end

				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_10 = math.max(var_459_1, arg_456_1.talkMaxDuration)

			if var_459_0 <= arg_456_1.time_ and arg_456_1.time_ < var_459_0 + var_459_10 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_0) / var_459_10

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_0 + var_459_10 and arg_456_1.time_ < var_459_0 + var_459_10 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play423011112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 423011112
		arg_460_1.duration_ = 9.83

		local var_460_0 = {
			zh = 9.266,
			ja = 9.833
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play423011113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0
			local var_463_1 = 1.05

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				local var_463_2 = arg_460_1:FormatText(StoryNameCfg[36].name)

				arg_460_1.leftNameTxt_.text = var_463_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_3 = arg_460_1:GetWordFromCfg(423011112)
				local var_463_4 = arg_460_1:FormatText(var_463_3.content)

				arg_460_1.text_.text = var_463_4

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_5 = 42
				local var_463_6 = utf8.len(var_463_4)
				local var_463_7 = var_463_5 <= 0 and var_463_1 or var_463_1 * (var_463_6 / var_463_5)

				if var_463_7 > 0 and var_463_1 < var_463_7 then
					arg_460_1.talkMaxDuration = var_463_7

					if var_463_7 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_7 + var_463_0
					end
				end

				arg_460_1.text_.text = var_463_4
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011112", "story_v_out_423011.awb") ~= 0 then
					local var_463_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011112", "story_v_out_423011.awb") / 1000

					if var_463_8 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_8 + var_463_0
					end

					if var_463_3.prefab_name ~= "" and arg_460_1.actors_[var_463_3.prefab_name] ~= nil then
						local var_463_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_3.prefab_name].transform, "story_v_out_423011", "423011112", "story_v_out_423011.awb")

						arg_460_1:RecordAudio("423011112", var_463_9)
						arg_460_1:RecordAudio("423011112", var_463_9)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_out_423011", "423011112", "story_v_out_423011.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_out_423011", "423011112", "story_v_out_423011.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_10 = math.max(var_463_1, arg_460_1.talkMaxDuration)

			if var_463_0 <= arg_460_1.time_ and arg_460_1.time_ < var_463_0 + var_463_10 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_0) / var_463_10

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_0 + var_463_10 and arg_460_1.time_ < var_463_0 + var_463_10 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play423011113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 423011113
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play423011114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0
			local var_467_1 = 1.425

			if var_467_0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_2 = arg_464_1:GetWordFromCfg(423011113)
				local var_467_3 = arg_464_1:FormatText(var_467_2.content)

				arg_464_1.text_.text = var_467_3

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_4 = 57
				local var_467_5 = utf8.len(var_467_3)
				local var_467_6 = var_467_4 <= 0 and var_467_1 or var_467_1 * (var_467_5 / var_467_4)

				if var_467_6 > 0 and var_467_1 < var_467_6 then
					arg_464_1.talkMaxDuration = var_467_6

					if var_467_6 + var_467_0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_6 + var_467_0
					end
				end

				arg_464_1.text_.text = var_467_3
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_7 = math.max(var_467_1, arg_464_1.talkMaxDuration)

			if var_467_0 <= arg_464_1.time_ and arg_464_1.time_ < var_467_0 + var_467_7 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_0) / var_467_7

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_0 + var_467_7 and arg_464_1.time_ < var_467_0 + var_467_7 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play423011114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 423011114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play423011115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0
			local var_471_1 = 1.4

			if var_471_0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_2 = arg_468_1:GetWordFromCfg(423011114)
				local var_471_3 = arg_468_1:FormatText(var_471_2.content)

				arg_468_1.text_.text = var_471_3

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_4 = 56
				local var_471_5 = utf8.len(var_471_3)
				local var_471_6 = var_471_4 <= 0 and var_471_1 or var_471_1 * (var_471_5 / var_471_4)

				if var_471_6 > 0 and var_471_1 < var_471_6 then
					arg_468_1.talkMaxDuration = var_471_6

					if var_471_6 + var_471_0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_6 + var_471_0
					end
				end

				arg_468_1.text_.text = var_471_3
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_7 = math.max(var_471_1, arg_468_1.talkMaxDuration)

			if var_471_0 <= arg_468_1.time_ and arg_468_1.time_ < var_471_0 + var_471_7 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_0) / var_471_7

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_0 + var_471_7 and arg_468_1.time_ < var_471_0 + var_471_7 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play423011115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 423011115
		arg_472_1.duration_ = 11.07

		local var_472_0 = {
			zh = 9.43333333333333,
			ja = 11.0663333333333
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play423011116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = manager.ui.mainCamera.transform
			local var_475_1 = 0

			if var_475_1 < arg_472_1.time_ and arg_472_1.time_ <= var_475_1 + arg_475_0 then
				local var_475_2 = arg_472_1.var_.effecttanmaozi1
				local var_475_3
				local var_475_4 = var_475_0

				if not var_475_2 then
					var_475_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_in_keep"), var_475_4)
					var_475_2.name = "tanmaozi1"
					arg_472_1.var_.effecttanmaozi1 = var_475_2
				else
					var_475_2.transform:SetParent(var_475_4)
				end

				var_475_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_475_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_475_5 = manager.ui.mainCamera.transform
			local var_475_6 = 1.2

			if var_475_6 < arg_472_1.time_ and arg_472_1.time_ <= var_475_6 + arg_475_0 then
				local var_475_7 = arg_472_1.var_.effecttanmaozi2
				local var_475_8
				local var_475_9 = var_475_5

				if not var_475_7 then
					var_475_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), var_475_9)
					var_475_7.name = "tanmaozi2"
					arg_472_1.var_.effecttanmaozi2 = var_475_7
				else
					var_475_7.transform:SetParent(var_475_9)
				end

				var_475_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_475_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_475_10 = manager.ui.mainCamera.transform
			local var_475_11 = 1.2

			if var_475_11 < arg_472_1.time_ and arg_472_1.time_ <= var_475_11 + arg_475_0 then
				local var_475_12 = arg_472_1.var_.effecttanmaozi1

				if var_475_12 then
					Object.Destroy(var_475_12)

					arg_472_1.var_.effecttanmaozi1 = nil
				end
			end

			local var_475_13 = arg_472_1.bgs_.SS2301.transform
			local var_475_14 = 1.18333333333333

			if var_475_14 < arg_472_1.time_ and arg_472_1.time_ <= var_475_14 + arg_475_0 then
				arg_472_1.var_.moveOldPosSS2301 = var_475_13.localPosition
			end

			local var_475_15 = 0.001

			if var_475_14 <= arg_472_1.time_ and arg_472_1.time_ < var_475_14 + var_475_15 then
				local var_475_16 = (arg_472_1.time_ - var_475_14) / var_475_15
				local var_475_17 = Vector3.New(0, 0, 4.5)

				var_475_13.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPosSS2301, var_475_17, var_475_16)
			end

			if arg_472_1.time_ >= var_475_14 + var_475_15 and arg_472_1.time_ < var_475_14 + var_475_15 + arg_475_0 then
				var_475_13.localPosition = Vector3.New(0, 0, 4.5)
			end

			local var_475_18 = arg_472_1.bgs_.SS2301.transform
			local var_475_19 = 1.2

			if var_475_19 < arg_472_1.time_ and arg_472_1.time_ <= var_475_19 + arg_475_0 then
				arg_472_1.var_.moveOldPosSS2301 = var_475_18.localPosition
			end

			local var_475_20 = 5

			if var_475_19 <= arg_472_1.time_ and arg_472_1.time_ < var_475_19 + var_475_20 then
				local var_475_21 = (arg_472_1.time_ - var_475_19) / var_475_20
				local var_475_22 = Vector3.New(0, 0, 5)

				var_475_18.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPosSS2301, var_475_22, var_475_21)
			end

			if arg_472_1.time_ >= var_475_19 + var_475_20 and arg_472_1.time_ < var_475_19 + var_475_20 + arg_475_0 then
				var_475_18.localPosition = Vector3.New(0, 0, 5)
			end

			local var_475_23 = 2.23333333333333

			if var_475_23 < arg_472_1.time_ and arg_472_1.time_ <= var_475_23 + arg_475_0 then
				arg_472_1.allBtn_.enabled = false
			end

			local var_475_24 = 1.5

			if arg_472_1.time_ >= var_475_23 + var_475_24 and arg_472_1.time_ < var_475_23 + var_475_24 + arg_475_0 then
				arg_472_1.allBtn_.enabled = true
			end

			if arg_472_1.frameCnt_ <= 1 then
				arg_472_1.dialog_:SetActive(false)
			end

			local var_475_25 = 2.23333333333333
			local var_475_26 = 0.675

			if var_475_25 < arg_472_1.time_ and arg_472_1.time_ <= var_475_25 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0

				arg_472_1.dialog_:SetActive(true)

				arg_472_1.dialogCg_.alpha = 0

				local var_475_27 = LeanTween.value(arg_472_1.dialog_, 0, 1, 0.3)

				var_475_27:setOnUpdate(LuaHelper.FloatAction(function(arg_476_0)
					arg_472_1.dialogCg_.alpha = arg_476_0
				end))
				var_475_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_472_1.dialog_)
					var_475_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_472_1.duration_ = arg_472_1.duration_ + 0.3

				SetActive(arg_472_1.leftNameGo_, true)

				local var_475_28 = arg_472_1:FormatText(StoryNameCfg[36].name)

				arg_472_1.leftNameTxt_.text = var_475_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_29 = arg_472_1:GetWordFromCfg(423011115)
				local var_475_30 = arg_472_1:FormatText(var_475_29.content)

				arg_472_1.text_.text = var_475_30

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_31 = 27
				local var_475_32 = utf8.len(var_475_30)
				local var_475_33 = var_475_31 <= 0 and var_475_26 or var_475_26 * (var_475_32 / var_475_31)

				if var_475_33 > 0 and var_475_26 < var_475_33 then
					arg_472_1.talkMaxDuration = var_475_33
					var_475_25 = var_475_25 + 0.3

					if var_475_33 + var_475_25 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_33 + var_475_25
					end
				end

				arg_472_1.text_.text = var_475_30
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011115", "story_v_out_423011.awb") ~= 0 then
					local var_475_34 = manager.audio:GetVoiceLength("story_v_out_423011", "423011115", "story_v_out_423011.awb") / 1000

					if var_475_34 + var_475_25 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_34 + var_475_25
					end

					if var_475_29.prefab_name ~= "" and arg_472_1.actors_[var_475_29.prefab_name] ~= nil then
						local var_475_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_29.prefab_name].transform, "story_v_out_423011", "423011115", "story_v_out_423011.awb")

						arg_472_1:RecordAudio("423011115", var_475_35)
						arg_472_1:RecordAudio("423011115", var_475_35)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_423011", "423011115", "story_v_out_423011.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_423011", "423011115", "story_v_out_423011.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_36 = var_475_25 + 0.3
			local var_475_37 = math.max(var_475_26, arg_472_1.talkMaxDuration)

			if var_475_36 <= arg_472_1.time_ and arg_472_1.time_ < var_475_36 + var_475_37 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_36) / var_475_37

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_36 + var_475_37 and arg_472_1.time_ < var_475_36 + var_475_37 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666665,
				className = "StoryMoveNode",
				startTime = 1.18333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2301",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play423011116 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 423011116
		arg_478_1.duration_ = 8.9

		local var_478_0 = {
			zh = 8.9,
			ja = 7.633
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play423011117(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			local var_481_0 = 0
			local var_481_1 = 1.025

			if var_481_0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				local var_481_2 = arg_478_1:FormatText(StoryNameCfg[36].name)

				arg_478_1.leftNameTxt_.text = var_481_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_3 = arg_478_1:GetWordFromCfg(423011116)
				local var_481_4 = arg_478_1:FormatText(var_481_3.content)

				arg_478_1.text_.text = var_481_4

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 41
				local var_481_6 = utf8.len(var_481_4)
				local var_481_7 = var_481_5 <= 0 and var_481_1 or var_481_1 * (var_481_6 / var_481_5)

				if var_481_7 > 0 and var_481_1 < var_481_7 then
					arg_478_1.talkMaxDuration = var_481_7

					if var_481_7 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_7 + var_481_0
					end
				end

				arg_478_1.text_.text = var_481_4
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011116", "story_v_out_423011.awb") ~= 0 then
					local var_481_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011116", "story_v_out_423011.awb") / 1000

					if var_481_8 + var_481_0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_8 + var_481_0
					end

					if var_481_3.prefab_name ~= "" and arg_478_1.actors_[var_481_3.prefab_name] ~= nil then
						local var_481_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_3.prefab_name].transform, "story_v_out_423011", "423011116", "story_v_out_423011.awb")

						arg_478_1:RecordAudio("423011116", var_481_9)
						arg_478_1:RecordAudio("423011116", var_481_9)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_423011", "423011116", "story_v_out_423011.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_423011", "423011116", "story_v_out_423011.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_10 = math.max(var_481_1, arg_478_1.talkMaxDuration)

			if var_481_0 <= arg_478_1.time_ and arg_478_1.time_ < var_481_0 + var_481_10 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_0) / var_481_10

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_0 + var_481_10 and arg_478_1.time_ < var_481_0 + var_481_10 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play423011117 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 423011117
		arg_482_1.duration_ = 12.3

		local var_482_0 = {
			zh = 10.466,
			ja = 12.3
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play423011118(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 0.8

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				local var_485_2 = arg_482_1:FormatText(StoryNameCfg[36].name)

				arg_482_1.leftNameTxt_.text = var_485_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_3 = arg_482_1:GetWordFromCfg(423011117)
				local var_485_4 = arg_482_1:FormatText(var_485_3.content)

				arg_482_1.text_.text = var_485_4

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_5 = 32
				local var_485_6 = utf8.len(var_485_4)
				local var_485_7 = var_485_5 <= 0 and var_485_1 or var_485_1 * (var_485_6 / var_485_5)

				if var_485_7 > 0 and var_485_1 < var_485_7 then
					arg_482_1.talkMaxDuration = var_485_7

					if var_485_7 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_7 + var_485_0
					end
				end

				arg_482_1.text_.text = var_485_4
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011117", "story_v_out_423011.awb") ~= 0 then
					local var_485_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011117", "story_v_out_423011.awb") / 1000

					if var_485_8 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_8 + var_485_0
					end

					if var_485_3.prefab_name ~= "" and arg_482_1.actors_[var_485_3.prefab_name] ~= nil then
						local var_485_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_3.prefab_name].transform, "story_v_out_423011", "423011117", "story_v_out_423011.awb")

						arg_482_1:RecordAudio("423011117", var_485_9)
						arg_482_1:RecordAudio("423011117", var_485_9)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_423011", "423011117", "story_v_out_423011.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_423011", "423011117", "story_v_out_423011.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_10 = math.max(var_485_1, arg_482_1.talkMaxDuration)

			if var_485_0 <= arg_482_1.time_ and arg_482_1.time_ < var_485_0 + var_485_10 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_0) / var_485_10

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_0 + var_485_10 and arg_482_1.time_ < var_485_0 + var_485_10 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play423011118 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 423011118
		arg_486_1.duration_ = 3.07

		local var_486_0 = {
			zh = 2.7,
			ja = 3.066
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play423011119(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0
			local var_489_1 = 0.175

			if var_489_0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				local var_489_2 = arg_486_1:FormatText(StoryNameCfg[36].name)

				arg_486_1.leftNameTxt_.text = var_489_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_3 = arg_486_1:GetWordFromCfg(423011118)
				local var_489_4 = arg_486_1:FormatText(var_489_3.content)

				arg_486_1.text_.text = var_489_4

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_5 = 7
				local var_489_6 = utf8.len(var_489_4)
				local var_489_7 = var_489_5 <= 0 and var_489_1 or var_489_1 * (var_489_6 / var_489_5)

				if var_489_7 > 0 and var_489_1 < var_489_7 then
					arg_486_1.talkMaxDuration = var_489_7

					if var_489_7 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_7 + var_489_0
					end
				end

				arg_486_1.text_.text = var_489_4
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011118", "story_v_out_423011.awb") ~= 0 then
					local var_489_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011118", "story_v_out_423011.awb") / 1000

					if var_489_8 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_8 + var_489_0
					end

					if var_489_3.prefab_name ~= "" and arg_486_1.actors_[var_489_3.prefab_name] ~= nil then
						local var_489_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_3.prefab_name].transform, "story_v_out_423011", "423011118", "story_v_out_423011.awb")

						arg_486_1:RecordAudio("423011118", var_489_9)
						arg_486_1:RecordAudio("423011118", var_489_9)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_423011", "423011118", "story_v_out_423011.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_423011", "423011118", "story_v_out_423011.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_10 = math.max(var_489_1, arg_486_1.talkMaxDuration)

			if var_489_0 <= arg_486_1.time_ and arg_486_1.time_ < var_489_0 + var_489_10 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_0) / var_489_10

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_0 + var_489_10 and arg_486_1.time_ < var_489_0 + var_489_10 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play423011119 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 423011119
		arg_490_1.duration_ = 3.9

		local var_490_0 = {
			zh = 2.166,
			ja = 3.9
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play423011120(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0
			local var_493_1 = 0.4

			if var_493_0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_2 = arg_490_1:FormatText(StoryNameCfg[36].name)

				arg_490_1.leftNameTxt_.text = var_493_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_3 = arg_490_1:GetWordFromCfg(423011119)
				local var_493_4 = arg_490_1:FormatText(var_493_3.content)

				arg_490_1.text_.text = var_493_4

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 16
				local var_493_6 = utf8.len(var_493_4)
				local var_493_7 = var_493_5 <= 0 and var_493_1 or var_493_1 * (var_493_6 / var_493_5)

				if var_493_7 > 0 and var_493_1 < var_493_7 then
					arg_490_1.talkMaxDuration = var_493_7

					if var_493_7 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_7 + var_493_0
					end
				end

				arg_490_1.text_.text = var_493_4
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011119", "story_v_out_423011.awb") ~= 0 then
					local var_493_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011119", "story_v_out_423011.awb") / 1000

					if var_493_8 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_8 + var_493_0
					end

					if var_493_3.prefab_name ~= "" and arg_490_1.actors_[var_493_3.prefab_name] ~= nil then
						local var_493_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_3.prefab_name].transform, "story_v_out_423011", "423011119", "story_v_out_423011.awb")

						arg_490_1:RecordAudio("423011119", var_493_9)
						arg_490_1:RecordAudio("423011119", var_493_9)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_423011", "423011119", "story_v_out_423011.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_423011", "423011119", "story_v_out_423011.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_10 = math.max(var_493_1, arg_490_1.talkMaxDuration)

			if var_493_0 <= arg_490_1.time_ and arg_490_1.time_ < var_493_0 + var_493_10 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_0) / var_493_10

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_0 + var_493_10 and arg_490_1.time_ < var_493_0 + var_493_10 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play423011120 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 423011120
		arg_494_1.duration_ = 9

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play423011121(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = "SS2301a"

			if arg_494_1.bgs_[var_497_0] == nil then
				local var_497_1 = Object.Instantiate(arg_494_1.paintGo_)

				var_497_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_497_0)
				var_497_1.name = var_497_0
				var_497_1.transform.parent = arg_494_1.stage_.transform
				var_497_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_494_1.bgs_[var_497_0] = var_497_1
			end

			local var_497_2 = 2

			if var_497_2 < arg_494_1.time_ and arg_494_1.time_ <= var_497_2 + arg_497_0 then
				local var_497_3 = manager.ui.mainCamera.transform.localPosition
				local var_497_4 = Vector3.New(0, 0, 10) + Vector3.New(var_497_3.x, var_497_3.y, 0)
				local var_497_5 = arg_494_1.bgs_.SS2301a

				var_497_5.transform.localPosition = var_497_4
				var_497_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_497_6 = var_497_5:GetComponent("SpriteRenderer")

				if var_497_6 and var_497_6.sprite then
					local var_497_7 = (var_497_5.transform.localPosition - var_497_3).z
					local var_497_8 = manager.ui.mainCameraCom_
					local var_497_9 = 2 * var_497_7 * Mathf.Tan(var_497_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_497_10 = var_497_9 * var_497_8.aspect
					local var_497_11 = var_497_6.sprite.bounds.size.x
					local var_497_12 = var_497_6.sprite.bounds.size.y
					local var_497_13 = var_497_10 / var_497_11
					local var_497_14 = var_497_9 / var_497_12
					local var_497_15 = var_497_14 < var_497_13 and var_497_13 or var_497_14

					var_497_5.transform.localScale = Vector3.New(var_497_15, var_497_15, 0)
				end

				for iter_497_0, iter_497_1 in pairs(arg_494_1.bgs_) do
					if iter_497_0 ~= "SS2301a" then
						iter_497_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_497_16 = 4

			if var_497_16 < arg_494_1.time_ and arg_494_1.time_ <= var_497_16 + arg_497_0 then
				arg_494_1.allBtn_.enabled = false
			end

			local var_497_17 = 0.3

			if arg_494_1.time_ >= var_497_16 + var_497_17 and arg_494_1.time_ < var_497_16 + var_497_17 + arg_497_0 then
				arg_494_1.allBtn_.enabled = true
			end

			local var_497_18 = 0

			if var_497_18 < arg_494_1.time_ and arg_494_1.time_ <= var_497_18 + arg_497_0 then
				arg_494_1.mask_.enabled = true
				arg_494_1.mask_.raycastTarget = true

				arg_494_1:SetGaussion(false)
			end

			local var_497_19 = 2

			if var_497_18 <= arg_494_1.time_ and arg_494_1.time_ < var_497_18 + var_497_19 then
				local var_497_20 = (arg_494_1.time_ - var_497_18) / var_497_19
				local var_497_21 = Color.New(0, 0, 0)

				var_497_21.a = Mathf.Lerp(0, 1, var_497_20)
				arg_494_1.mask_.color = var_497_21
			end

			if arg_494_1.time_ >= var_497_18 + var_497_19 and arg_494_1.time_ < var_497_18 + var_497_19 + arg_497_0 then
				local var_497_22 = Color.New(0, 0, 0)

				var_497_22.a = 1
				arg_494_1.mask_.color = var_497_22
			end

			local var_497_23 = 2

			if var_497_23 < arg_494_1.time_ and arg_494_1.time_ <= var_497_23 + arg_497_0 then
				arg_494_1.mask_.enabled = true
				arg_494_1.mask_.raycastTarget = true

				arg_494_1:SetGaussion(false)
			end

			local var_497_24 = 2

			if var_497_23 <= arg_494_1.time_ and arg_494_1.time_ < var_497_23 + var_497_24 then
				local var_497_25 = (arg_494_1.time_ - var_497_23) / var_497_24
				local var_497_26 = Color.New(0, 0, 0)

				var_497_26.a = Mathf.Lerp(1, 0, var_497_25)
				arg_494_1.mask_.color = var_497_26
			end

			if arg_494_1.time_ >= var_497_23 + var_497_24 and arg_494_1.time_ < var_497_23 + var_497_24 + arg_497_0 then
				local var_497_27 = Color.New(0, 0, 0)
				local var_497_28 = 0

				arg_494_1.mask_.enabled = false
				var_497_27.a = var_497_28
				arg_494_1.mask_.color = var_497_27
			end

			if arg_494_1.frameCnt_ <= 1 then
				arg_494_1.dialog_:SetActive(false)
			end

			local var_497_29 = 4
			local var_497_30 = 1.075

			if var_497_29 < arg_494_1.time_ and arg_494_1.time_ <= var_497_29 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0

				arg_494_1.dialog_:SetActive(true)

				arg_494_1.dialogCg_.alpha = 0

				local var_497_31 = LeanTween.value(arg_494_1.dialog_, 0, 1, 0.3)

				var_497_31:setOnUpdate(LuaHelper.FloatAction(function(arg_498_0)
					arg_494_1.dialogCg_.alpha = arg_498_0
				end))
				var_497_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_494_1.dialog_)
					var_497_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_494_1.duration_ = arg_494_1.duration_ + 0.3

				SetActive(arg_494_1.leftNameGo_, false)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_32 = arg_494_1:GetWordFromCfg(423011120)
				local var_497_33 = arg_494_1:FormatText(var_497_32.content)

				arg_494_1.text_.text = var_497_33

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_34 = 43
				local var_497_35 = utf8.len(var_497_33)
				local var_497_36 = var_497_34 <= 0 and var_497_30 or var_497_30 * (var_497_35 / var_497_34)

				if var_497_36 > 0 and var_497_30 < var_497_36 then
					arg_494_1.talkMaxDuration = var_497_36
					var_497_29 = var_497_29 + 0.3

					if var_497_36 + var_497_29 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_36 + var_497_29
					end
				end

				arg_494_1.text_.text = var_497_33
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_37 = var_497_29 + 0.3
			local var_497_38 = math.max(var_497_30, arg_494_1.talkMaxDuration)

			if var_497_37 <= arg_494_1.time_ and arg_494_1.time_ < var_497_37 + var_497_38 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_37) / var_497_38

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_37 + var_497_38 and arg_494_1.time_ < var_497_37 + var_497_38 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play423011121 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 423011121
		arg_500_1.duration_ = 7.73

		local var_500_0 = {
			zh = 5.7,
			ja = 7.733
		}
		local var_500_1 = manager.audio:GetLocalizationFlag()

		if var_500_0[var_500_1] ~= nil then
			arg_500_1.duration_ = var_500_0[var_500_1]
		end

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play423011122(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 0
			local var_503_1 = 0.675

			if var_503_0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				local var_503_2 = arg_500_1:FormatText(StoryNameCfg[36].name)

				arg_500_1.leftNameTxt_.text = var_503_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_3 = arg_500_1:GetWordFromCfg(423011121)
				local var_503_4 = arg_500_1:FormatText(var_503_3.content)

				arg_500_1.text_.text = var_503_4

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_5 = 27
				local var_503_6 = utf8.len(var_503_4)
				local var_503_7 = var_503_5 <= 0 and var_503_1 or var_503_1 * (var_503_6 / var_503_5)

				if var_503_7 > 0 and var_503_1 < var_503_7 then
					arg_500_1.talkMaxDuration = var_503_7

					if var_503_7 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_7 + var_503_0
					end
				end

				arg_500_1.text_.text = var_503_4
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011121", "story_v_out_423011.awb") ~= 0 then
					local var_503_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011121", "story_v_out_423011.awb") / 1000

					if var_503_8 + var_503_0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_8 + var_503_0
					end

					if var_503_3.prefab_name ~= "" and arg_500_1.actors_[var_503_3.prefab_name] ~= nil then
						local var_503_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_3.prefab_name].transform, "story_v_out_423011", "423011121", "story_v_out_423011.awb")

						arg_500_1:RecordAudio("423011121", var_503_9)
						arg_500_1:RecordAudio("423011121", var_503_9)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_423011", "423011121", "story_v_out_423011.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_423011", "423011121", "story_v_out_423011.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_10 = math.max(var_503_1, arg_500_1.talkMaxDuration)

			if var_503_0 <= arg_500_1.time_ and arg_500_1.time_ < var_503_0 + var_503_10 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_0) / var_503_10

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_0 + var_503_10 and arg_500_1.time_ < var_503_0 + var_503_10 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play423011122 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 423011122
		arg_504_1.duration_ = 6.8

		local var_504_0 = {
			zh = 5.8,
			ja = 6.8
		}
		local var_504_1 = manager.audio:GetLocalizationFlag()

		if var_504_0[var_504_1] ~= nil then
			arg_504_1.duration_ = var_504_0[var_504_1]
		end

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play423011123(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0
			local var_507_1 = 0.6

			if var_507_0 < arg_504_1.time_ and arg_504_1.time_ <= var_507_0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, true)

				local var_507_2 = arg_504_1:FormatText(StoryNameCfg[1330].name)

				arg_504_1.leftNameTxt_.text = var_507_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_504_1.leftNameTxt_.transform)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1.leftNameTxt_.text)
				SetActive(arg_504_1.iconTrs_.gameObject, true)
				arg_504_1.iconController_:SetSelectedState("hero")

				arg_504_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_504_1.callingController_:SetSelectedState("normal")

				arg_504_1.keyicon_.color = Color.New(1, 1, 1)
				arg_504_1.icon_.color = Color.New(1, 1, 1)

				local var_507_3 = arg_504_1:GetWordFromCfg(423011122)
				local var_507_4 = arg_504_1:FormatText(var_507_3.content)

				arg_504_1.text_.text = var_507_4

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_5 = 24
				local var_507_6 = utf8.len(var_507_4)
				local var_507_7 = var_507_5 <= 0 and var_507_1 or var_507_1 * (var_507_6 / var_507_5)

				if var_507_7 > 0 and var_507_1 < var_507_7 then
					arg_504_1.talkMaxDuration = var_507_7

					if var_507_7 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_7 + var_507_0
					end
				end

				arg_504_1.text_.text = var_507_4
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011122", "story_v_out_423011.awb") ~= 0 then
					local var_507_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011122", "story_v_out_423011.awb") / 1000

					if var_507_8 + var_507_0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_8 + var_507_0
					end

					if var_507_3.prefab_name ~= "" and arg_504_1.actors_[var_507_3.prefab_name] ~= nil then
						local var_507_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_504_1.actors_[var_507_3.prefab_name].transform, "story_v_out_423011", "423011122", "story_v_out_423011.awb")

						arg_504_1:RecordAudio("423011122", var_507_9)
						arg_504_1:RecordAudio("423011122", var_507_9)
					else
						arg_504_1:AudioAction("play", "voice", "story_v_out_423011", "423011122", "story_v_out_423011.awb")
					end

					arg_504_1:RecordHistoryTalkVoice("story_v_out_423011", "423011122", "story_v_out_423011.awb")
				end

				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_10 = math.max(var_507_1, arg_504_1.talkMaxDuration)

			if var_507_0 <= arg_504_1.time_ and arg_504_1.time_ < var_507_0 + var_507_10 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - var_507_0) / var_507_10

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= var_507_0 + var_507_10 and arg_504_1.time_ < var_507_0 + var_507_10 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play423011123 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 423011123
		arg_508_1.duration_ = 2.3

		local var_508_0 = {
			zh = 2.166,
			ja = 2.3
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play423011124(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			local var_511_0 = 0
			local var_511_1 = 0.175

			if var_511_0 < arg_508_1.time_ and arg_508_1.time_ <= var_511_0 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0
				arg_508_1.dialogCg_.alpha = 1

				arg_508_1.dialog_:SetActive(true)
				SetActive(arg_508_1.leftNameGo_, true)

				local var_511_2 = arg_508_1:FormatText(StoryNameCfg[1330].name)

				arg_508_1.leftNameTxt_.text = var_511_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, true)
				arg_508_1.iconController_:SetSelectedState("hero")

				arg_508_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_508_1.callingController_:SetSelectedState("normal")

				arg_508_1.keyicon_.color = Color.New(1, 1, 1)
				arg_508_1.icon_.color = Color.New(1, 1, 1)

				local var_511_3 = arg_508_1:GetWordFromCfg(423011123)
				local var_511_4 = arg_508_1:FormatText(var_511_3.content)

				arg_508_1.text_.text = var_511_4

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_5 = 7
				local var_511_6 = utf8.len(var_511_4)
				local var_511_7 = var_511_5 <= 0 and var_511_1 or var_511_1 * (var_511_6 / var_511_5)

				if var_511_7 > 0 and var_511_1 < var_511_7 then
					arg_508_1.talkMaxDuration = var_511_7

					if var_511_7 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_7 + var_511_0
					end
				end

				arg_508_1.text_.text = var_511_4
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011123", "story_v_out_423011.awb") ~= 0 then
					local var_511_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011123", "story_v_out_423011.awb") / 1000

					if var_511_8 + var_511_0 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_8 + var_511_0
					end

					if var_511_3.prefab_name ~= "" and arg_508_1.actors_[var_511_3.prefab_name] ~= nil then
						local var_511_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_3.prefab_name].transform, "story_v_out_423011", "423011123", "story_v_out_423011.awb")

						arg_508_1:RecordAudio("423011123", var_511_9)
						arg_508_1:RecordAudio("423011123", var_511_9)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_423011", "423011123", "story_v_out_423011.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_423011", "423011123", "story_v_out_423011.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_10 = math.max(var_511_1, arg_508_1.talkMaxDuration)

			if var_511_0 <= arg_508_1.time_ and arg_508_1.time_ < var_511_0 + var_511_10 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_0) / var_511_10

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_0 + var_511_10 and arg_508_1.time_ < var_511_0 + var_511_10 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {}

		arg_508_1:InitPlayNodeList()
	end,
	Play423011124 = function(arg_512_0, arg_512_1)
		arg_512_1.time_ = 0
		arg_512_1.frameCnt_ = 0
		arg_512_1.state_ = "playing"
		arg_512_1.curTalkId_ = 423011124
		arg_512_1.duration_ = 2.6

		local var_512_0 = {
			zh = 2.6,
			ja = 2.333
		}
		local var_512_1 = manager.audio:GetLocalizationFlag()

		if var_512_0[var_512_1] ~= nil then
			arg_512_1.duration_ = var_512_0[var_512_1]
		end

		SetActive(arg_512_1.tipsGo_, false)

		function arg_512_1.onSingleLineFinish_()
			arg_512_1.onSingleLineUpdate_ = nil
			arg_512_1.onSingleLineFinish_ = nil
			arg_512_1.state_ = "waiting"
		end

		function arg_512_1.playNext_(arg_514_0)
			if arg_514_0 == 1 then
				arg_512_0:Play423011125(arg_512_1)
			end
		end

		function arg_512_1.onSingleLineUpdate_(arg_515_0)
			local var_515_0 = manager.ui.mainCamera.transform
			local var_515_1 = 0.866666666666667

			if var_515_1 < arg_512_1.time_ and arg_512_1.time_ <= var_515_1 + arg_515_0 then
				local var_515_2 = arg_512_1.var_.effectaishizhenjing1
				local var_515_3
				local var_515_4 = var_515_0

				if not var_515_2 then
					var_515_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_515_4)
					var_515_2.name = "aishizhenjing1"
					arg_512_1.var_.effectaishizhenjing1 = var_515_2
				else
					var_515_2.transform:SetParent(var_515_4)
				end

				var_515_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_515_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_515_5 = manager.ui.mainCamera.transform
			local var_515_6 = 1.86666666666667

			if var_515_6 < arg_512_1.time_ and arg_512_1.time_ <= var_515_6 + arg_515_0 then
				local var_515_7 = arg_512_1.var_.effectaishizhenjing1

				if var_515_7 then
					Object.Destroy(var_515_7)

					arg_512_1.var_.effectaishizhenjing1 = nil
				end
			end

			local var_515_8 = manager.ui.mainCamera.transform
			local var_515_9 = 0.233333333333334

			if var_515_9 < arg_512_1.time_ and arg_512_1.time_ <= var_515_9 + arg_515_0 then
				local var_515_10 = arg_512_1.var_.effectaishizhenjing2
				local var_515_11
				local var_515_12 = var_515_8

				if not var_515_10 then
					var_515_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_moviemask"), var_515_12)
					var_515_10.name = "aishizhenjing2"
					arg_512_1.var_.effectaishizhenjing2 = var_515_10
				else
					var_515_10.transform:SetParent(var_515_12)
				end

				var_515_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_515_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_515_13 = arg_512_1.bgs_.SS2301a.transform
			local var_515_14 = 0

			if var_515_14 < arg_512_1.time_ and arg_512_1.time_ <= var_515_14 + arg_515_0 then
				arg_512_1.var_.moveOldPosSS2301a = var_515_13.localPosition
			end

			local var_515_15 = 1.3

			if var_515_14 <= arg_512_1.time_ and arg_512_1.time_ < var_515_14 + var_515_15 then
				local var_515_16 = (arg_512_1.time_ - var_515_14) / var_515_15
				local var_515_17 = Vector3.New(0, -1.2, 0)

				var_515_13.localPosition = Vector3.Lerp(arg_512_1.var_.moveOldPosSS2301a, var_515_17, var_515_16)
			end

			if arg_512_1.time_ >= var_515_14 + var_515_15 and arg_512_1.time_ < var_515_14 + var_515_15 + arg_515_0 then
				var_515_13.localPosition = Vector3.New(0, -1.2, 0)
			end

			local var_515_18 = manager.ui.mainCamera.transform
			local var_515_19 = 0.866666666666667

			if var_515_19 < arg_512_1.time_ and arg_512_1.time_ <= var_515_19 + arg_515_0 then
				arg_512_1.var_.shakeOldPos = var_515_18.localPosition
			end

			local var_515_20 = 0.6

			if var_515_19 <= arg_512_1.time_ and arg_512_1.time_ < var_515_19 + var_515_20 then
				local var_515_21 = (arg_512_1.time_ - var_515_19) / 0.066
				local var_515_22, var_515_23 = math.modf(var_515_21)

				var_515_18.localPosition = Vector3.New(var_515_23 * 0.13, var_515_23 * 0.13, var_515_23 * 0.13) + arg_512_1.var_.shakeOldPos
			end

			if arg_512_1.time_ >= var_515_19 + var_515_20 and arg_512_1.time_ < var_515_19 + var_515_20 + arg_515_0 then
				var_515_18.localPosition = arg_512_1.var_.shakeOldPos
			end

			local var_515_24 = 0.866666666666667
			local var_515_25 = 1

			if var_515_24 < arg_512_1.time_ and arg_512_1.time_ <= var_515_24 + arg_515_0 then
				local var_515_26 = "play"
				local var_515_27 = "effect"

				arg_512_1:AudioAction(var_515_26, var_515_27, "se_story_144", "se_story_144_thunder02", "")
			end

			if arg_512_1.frameCnt_ <= 1 then
				arg_512_1.dialog_:SetActive(false)
			end

			local var_515_28 = 1
			local var_515_29 = 0.125

			if var_515_28 < arg_512_1.time_ and arg_512_1.time_ <= var_515_28 + arg_515_0 then
				arg_512_1.talkMaxDuration = 0

				arg_512_1.dialog_:SetActive(true)

				arg_512_1.dialogCg_.alpha = 0

				local var_515_30 = LeanTween.value(arg_512_1.dialog_, 0, 1, 0.3)

				var_515_30:setOnUpdate(LuaHelper.FloatAction(function(arg_516_0)
					arg_512_1.dialogCg_.alpha = arg_516_0
				end))
				var_515_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_512_1.dialog_)
					var_515_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_512_1.duration_ = arg_512_1.duration_ + 0.3

				SetActive(arg_512_1.leftNameGo_, true)

				local var_515_31 = arg_512_1:FormatText(StoryNameCfg[36].name)

				arg_512_1.leftNameTxt_.text = var_515_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_512_1.leftNameTxt_.transform)

				arg_512_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_512_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_512_1:RecordName(arg_512_1.leftNameTxt_.text)
				SetActive(arg_512_1.iconTrs_.gameObject, false)
				arg_512_1.callingController_:SetSelectedState("normal")

				local var_515_32 = arg_512_1:GetWordFromCfg(423011124)
				local var_515_33 = arg_512_1:FormatText(var_515_32.content)

				arg_512_1.text_.text = var_515_33

				LuaForUtil.ClearLinePrefixSymbol(arg_512_1.text_)

				local var_515_34 = 5
				local var_515_35 = utf8.len(var_515_33)
				local var_515_36 = var_515_34 <= 0 and var_515_29 or var_515_29 * (var_515_35 / var_515_34)

				if var_515_36 > 0 and var_515_29 < var_515_36 then
					arg_512_1.talkMaxDuration = var_515_36
					var_515_28 = var_515_28 + 0.3

					if var_515_36 + var_515_28 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_36 + var_515_28
					end
				end

				arg_512_1.text_.text = var_515_33
				arg_512_1.typewritter.percent = 0

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011124", "story_v_out_423011.awb") ~= 0 then
					local var_515_37 = manager.audio:GetVoiceLength("story_v_out_423011", "423011124", "story_v_out_423011.awb") / 1000

					if var_515_37 + var_515_28 > arg_512_1.duration_ then
						arg_512_1.duration_ = var_515_37 + var_515_28
					end

					if var_515_32.prefab_name ~= "" and arg_512_1.actors_[var_515_32.prefab_name] ~= nil then
						local var_515_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_512_1.actors_[var_515_32.prefab_name].transform, "story_v_out_423011", "423011124", "story_v_out_423011.awb")

						arg_512_1:RecordAudio("423011124", var_515_38)
						arg_512_1:RecordAudio("423011124", var_515_38)
					else
						arg_512_1:AudioAction("play", "voice", "story_v_out_423011", "423011124", "story_v_out_423011.awb")
					end

					arg_512_1:RecordHistoryTalkVoice("story_v_out_423011", "423011124", "story_v_out_423011.awb")
				end

				arg_512_1:RecordContent(arg_512_1.text_.text)
			end

			local var_515_39 = var_515_28 + 0.3
			local var_515_40 = math.max(var_515_29, arg_512_1.talkMaxDuration)

			if var_515_39 <= arg_512_1.time_ and arg_512_1.time_ < var_515_39 + var_515_40 then
				arg_512_1.typewritter.percent = (arg_512_1.time_ - var_515_39) / var_515_40

				arg_512_1.typewritter:SetDirty()
			end

			if arg_512_1.time_ >= var_515_39 + var_515_40 and arg_512_1.time_ < var_515_39 + var_515_40 + arg_515_0 then
				arg_512_1.typewritter.percent = 1

				arg_512_1.typewritter:SetDirty()
				arg_512_1:ShowNextGo(true)
			end
		end

		arg_512_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2301a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, -1.2, 0),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_512_1:InitPlayNodeList()
	end,
	Play423011125 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 423011125
		arg_518_1.duration_ = 4.5

		local var_518_0 = {
			zh = 2.466,
			ja = 4.5
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play423011126(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = 0
			local var_521_1 = 0.275

			if var_521_0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_0 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_2 = arg_518_1:FormatText(StoryNameCfg[1330].name)

				arg_518_1.leftNameTxt_.text = var_521_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, true)
				arg_518_1.iconController_:SetSelectedState("hero")

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_3 = arg_518_1:GetWordFromCfg(423011125)
				local var_521_4 = arg_518_1:FormatText(var_521_3.content)

				arg_518_1.text_.text = var_521_4

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_5 = 11
				local var_521_6 = utf8.len(var_521_4)
				local var_521_7 = var_521_5 <= 0 and var_521_1 or var_521_1 * (var_521_6 / var_521_5)

				if var_521_7 > 0 and var_521_1 < var_521_7 then
					arg_518_1.talkMaxDuration = var_521_7

					if var_521_7 + var_521_0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_7 + var_521_0
					end
				end

				arg_518_1.text_.text = var_521_4
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011125", "story_v_out_423011.awb") ~= 0 then
					local var_521_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011125", "story_v_out_423011.awb") / 1000

					if var_521_8 + var_521_0 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_8 + var_521_0
					end

					if var_521_3.prefab_name ~= "" and arg_518_1.actors_[var_521_3.prefab_name] ~= nil then
						local var_521_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_3.prefab_name].transform, "story_v_out_423011", "423011125", "story_v_out_423011.awb")

						arg_518_1:RecordAudio("423011125", var_521_9)
						arg_518_1:RecordAudio("423011125", var_521_9)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_423011", "423011125", "story_v_out_423011.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_423011", "423011125", "story_v_out_423011.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_10 = math.max(var_521_1, arg_518_1.talkMaxDuration)

			if var_521_0 <= arg_518_1.time_ and arg_518_1.time_ < var_521_0 + var_521_10 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_0) / var_521_10

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_0 + var_521_10 and arg_518_1.time_ < var_521_0 + var_521_10 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play423011126 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 423011126
		arg_522_1.duration_ = 9

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play423011127(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = 2

			if var_525_0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_0 + arg_525_0 then
				local var_525_1 = manager.ui.mainCamera.transform.localPosition
				local var_525_2 = Vector3.New(0, 0, 10) + Vector3.New(var_525_1.x, var_525_1.y, 0)
				local var_525_3 = arg_522_1.bgs_.ST0111

				var_525_3.transform.localPosition = var_525_2
				var_525_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_525_4 = var_525_3:GetComponent("SpriteRenderer")

				if var_525_4 and var_525_4.sprite then
					local var_525_5 = (var_525_3.transform.localPosition - var_525_1).z
					local var_525_6 = manager.ui.mainCameraCom_
					local var_525_7 = 2 * var_525_5 * Mathf.Tan(var_525_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_525_8 = var_525_7 * var_525_6.aspect
					local var_525_9 = var_525_4.sprite.bounds.size.x
					local var_525_10 = var_525_4.sprite.bounds.size.y
					local var_525_11 = var_525_8 / var_525_9
					local var_525_12 = var_525_7 / var_525_10
					local var_525_13 = var_525_12 < var_525_11 and var_525_11 or var_525_12

					var_525_3.transform.localScale = Vector3.New(var_525_13, var_525_13, 0)
				end

				for iter_525_0, iter_525_1 in pairs(arg_522_1.bgs_) do
					if iter_525_0 ~= "ST0111" then
						iter_525_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_525_14 = 4

			if var_525_14 < arg_522_1.time_ and arg_522_1.time_ <= var_525_14 + arg_525_0 then
				arg_522_1.allBtn_.enabled = false
			end

			local var_525_15 = 0.3

			if arg_522_1.time_ >= var_525_14 + var_525_15 and arg_522_1.time_ < var_525_14 + var_525_15 + arg_525_0 then
				arg_522_1.allBtn_.enabled = true
			end

			local var_525_16 = 0

			if var_525_16 < arg_522_1.time_ and arg_522_1.time_ <= var_525_16 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_17 = 2

			if var_525_16 <= arg_522_1.time_ and arg_522_1.time_ < var_525_16 + var_525_17 then
				local var_525_18 = (arg_522_1.time_ - var_525_16) / var_525_17
				local var_525_19 = Color.New(0, 0, 0)

				var_525_19.a = Mathf.Lerp(0, 1, var_525_18)
				arg_522_1.mask_.color = var_525_19
			end

			if arg_522_1.time_ >= var_525_16 + var_525_17 and arg_522_1.time_ < var_525_16 + var_525_17 + arg_525_0 then
				local var_525_20 = Color.New(0, 0, 0)

				var_525_20.a = 1
				arg_522_1.mask_.color = var_525_20
			end

			local var_525_21 = 2

			if var_525_21 < arg_522_1.time_ and arg_522_1.time_ <= var_525_21 + arg_525_0 then
				arg_522_1.mask_.enabled = true
				arg_522_1.mask_.raycastTarget = true

				arg_522_1:SetGaussion(false)
			end

			local var_525_22 = 2

			if var_525_21 <= arg_522_1.time_ and arg_522_1.time_ < var_525_21 + var_525_22 then
				local var_525_23 = (arg_522_1.time_ - var_525_21) / var_525_22
				local var_525_24 = Color.New(0, 0, 0)

				var_525_24.a = Mathf.Lerp(1, 0, var_525_23)
				arg_522_1.mask_.color = var_525_24
			end

			if arg_522_1.time_ >= var_525_21 + var_525_22 and arg_522_1.time_ < var_525_21 + var_525_22 + arg_525_0 then
				local var_525_25 = Color.New(0, 0, 0)
				local var_525_26 = 0

				arg_522_1.mask_.enabled = false
				var_525_25.a = var_525_26
				arg_522_1.mask_.color = var_525_25
			end

			local var_525_27 = manager.ui.mainCamera.transform
			local var_525_28 = 2

			if var_525_28 < arg_522_1.time_ and arg_522_1.time_ <= var_525_28 + arg_525_0 then
				local var_525_29 = arg_522_1.var_.effectaishizhenjing2

				if var_525_29 then
					Object.Destroy(var_525_29)

					arg_522_1.var_.effectaishizhenjing2 = nil
				end
			end

			if arg_522_1.frameCnt_ <= 1 then
				arg_522_1.dialog_:SetActive(false)
			end

			local var_525_30 = 4
			local var_525_31 = 1.325

			if var_525_30 < arg_522_1.time_ and arg_522_1.time_ <= var_525_30 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0

				arg_522_1.dialog_:SetActive(true)

				arg_522_1.dialogCg_.alpha = 0

				local var_525_32 = LeanTween.value(arg_522_1.dialog_, 0, 1, 0.3)

				var_525_32:setOnUpdate(LuaHelper.FloatAction(function(arg_526_0)
					arg_522_1.dialogCg_.alpha = arg_526_0
				end))
				var_525_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_522_1.dialog_)
					var_525_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_522_1.duration_ = arg_522_1.duration_ + 0.3

				SetActive(arg_522_1.leftNameGo_, false)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_33 = arg_522_1:GetWordFromCfg(423011126)
				local var_525_34 = arg_522_1:FormatText(var_525_33.content)

				arg_522_1.text_.text = var_525_34

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_35 = 53
				local var_525_36 = utf8.len(var_525_34)
				local var_525_37 = var_525_35 <= 0 and var_525_31 or var_525_31 * (var_525_36 / var_525_35)

				if var_525_37 > 0 and var_525_31 < var_525_37 then
					arg_522_1.talkMaxDuration = var_525_37
					var_525_30 = var_525_30 + 0.3

					if var_525_37 + var_525_30 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_37 + var_525_30
					end
				end

				arg_522_1.text_.text = var_525_34
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_38 = var_525_30 + 0.3
			local var_525_39 = math.max(var_525_31, arg_522_1.talkMaxDuration)

			if var_525_38 <= arg_522_1.time_ and arg_522_1.time_ < var_525_38 + var_525_39 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_38) / var_525_39

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_38 + var_525_39 and arg_522_1.time_ < var_525_38 + var_525_39 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play423011127 = function(arg_528_0, arg_528_1)
		arg_528_1.time_ = 0
		arg_528_1.frameCnt_ = 0
		arg_528_1.state_ = "playing"
		arg_528_1.curTalkId_ = 423011127
		arg_528_1.duration_ = 8.57

		local var_528_0 = {
			zh = 8.566,
			ja = 8.5
		}
		local var_528_1 = manager.audio:GetLocalizationFlag()

		if var_528_0[var_528_1] ~= nil then
			arg_528_1.duration_ = var_528_0[var_528_1]
		end

		SetActive(arg_528_1.tipsGo_, false)

		function arg_528_1.onSingleLineFinish_()
			arg_528_1.onSingleLineUpdate_ = nil
			arg_528_1.onSingleLineFinish_ = nil
			arg_528_1.state_ = "waiting"
		end

		function arg_528_1.playNext_(arg_530_0)
			if arg_530_0 == 1 then
				arg_528_0:Play423011128(arg_528_1)
			end
		end

		function arg_528_1.onSingleLineUpdate_(arg_531_0)
			local var_531_0 = arg_528_1.actors_["1083"]
			local var_531_1 = 0

			if var_531_1 < arg_528_1.time_ and arg_528_1.time_ <= var_531_1 + arg_531_0 and not isNil(var_531_0) and arg_528_1.var_.actorSpriteComps1083 == nil then
				arg_528_1.var_.actorSpriteComps1083 = var_531_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_531_2 = 0.2

			if var_531_1 <= arg_528_1.time_ and arg_528_1.time_ < var_531_1 + var_531_2 and not isNil(var_531_0) then
				local var_531_3 = (arg_528_1.time_ - var_531_1) / var_531_2

				if arg_528_1.var_.actorSpriteComps1083 then
					for iter_531_0, iter_531_1 in pairs(arg_528_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_531_1 then
							if arg_528_1.isInRecall_ then
								local var_531_4 = Mathf.Lerp(iter_531_1.color.r, arg_528_1.hightColor1.r, var_531_3)
								local var_531_5 = Mathf.Lerp(iter_531_1.color.g, arg_528_1.hightColor1.g, var_531_3)
								local var_531_6 = Mathf.Lerp(iter_531_1.color.b, arg_528_1.hightColor1.b, var_531_3)

								iter_531_1.color = Color.New(var_531_4, var_531_5, var_531_6)
							else
								local var_531_7 = Mathf.Lerp(iter_531_1.color.r, 1, var_531_3)

								iter_531_1.color = Color.New(var_531_7, var_531_7, var_531_7)
							end
						end
					end
				end
			end

			if arg_528_1.time_ >= var_531_1 + var_531_2 and arg_528_1.time_ < var_531_1 + var_531_2 + arg_531_0 and not isNil(var_531_0) and arg_528_1.var_.actorSpriteComps1083 then
				for iter_531_2, iter_531_3 in pairs(arg_528_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_531_3 then
						if arg_528_1.isInRecall_ then
							iter_531_3.color = arg_528_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_531_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_528_1.var_.actorSpriteComps1083 = nil
			end

			local var_531_8 = arg_528_1.actors_["1083"].transform
			local var_531_9 = 0

			if var_531_9 < arg_528_1.time_ and arg_528_1.time_ <= var_531_9 + arg_531_0 then
				arg_528_1.var_.moveOldPos1083 = var_531_8.localPosition
				var_531_8.localScale = Vector3.New(1, 1, 1)

				arg_528_1:CheckSpriteTmpPos("1083", 3)

				local var_531_10 = var_531_8.childCount

				for iter_531_4 = 0, var_531_10 - 1 do
					local var_531_11 = var_531_8:GetChild(iter_531_4)

					if var_531_11.name == "split_3" or not string.find(var_531_11.name, "split") then
						var_531_11.gameObject:SetActive(true)
					else
						var_531_11.gameObject:SetActive(false)
					end
				end
			end

			local var_531_12 = 0.001

			if var_531_9 <= arg_528_1.time_ and arg_528_1.time_ < var_531_9 + var_531_12 then
				local var_531_13 = (arg_528_1.time_ - var_531_9) / var_531_12
				local var_531_14 = Vector3.New(-50, -345, -345)

				var_531_8.localPosition = Vector3.Lerp(arg_528_1.var_.moveOldPos1083, var_531_14, var_531_13)
			end

			if arg_528_1.time_ >= var_531_9 + var_531_12 and arg_528_1.time_ < var_531_9 + var_531_12 + arg_531_0 then
				var_531_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_531_15 = 0
			local var_531_16 = 0.775

			if var_531_15 < arg_528_1.time_ and arg_528_1.time_ <= var_531_15 + arg_531_0 then
				arg_528_1.talkMaxDuration = 0
				arg_528_1.dialogCg_.alpha = 1

				arg_528_1.dialog_:SetActive(true)
				SetActive(arg_528_1.leftNameGo_, true)

				local var_531_17 = arg_528_1:FormatText(StoryNameCfg[36].name)

				arg_528_1.leftNameTxt_.text = var_531_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_528_1.leftNameTxt_.transform)

				arg_528_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_528_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_528_1:RecordName(arg_528_1.leftNameTxt_.text)
				SetActive(arg_528_1.iconTrs_.gameObject, false)
				arg_528_1.callingController_:SetSelectedState("normal")

				local var_531_18 = arg_528_1:GetWordFromCfg(423011127)
				local var_531_19 = arg_528_1:FormatText(var_531_18.content)

				arg_528_1.text_.text = var_531_19

				LuaForUtil.ClearLinePrefixSymbol(arg_528_1.text_)

				local var_531_20 = 31
				local var_531_21 = utf8.len(var_531_19)
				local var_531_22 = var_531_20 <= 0 and var_531_16 or var_531_16 * (var_531_21 / var_531_20)

				if var_531_22 > 0 and var_531_16 < var_531_22 then
					arg_528_1.talkMaxDuration = var_531_22

					if var_531_22 + var_531_15 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_22 + var_531_15
					end
				end

				arg_528_1.text_.text = var_531_19
				arg_528_1.typewritter.percent = 0

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011127", "story_v_out_423011.awb") ~= 0 then
					local var_531_23 = manager.audio:GetVoiceLength("story_v_out_423011", "423011127", "story_v_out_423011.awb") / 1000

					if var_531_23 + var_531_15 > arg_528_1.duration_ then
						arg_528_1.duration_ = var_531_23 + var_531_15
					end

					if var_531_18.prefab_name ~= "" and arg_528_1.actors_[var_531_18.prefab_name] ~= nil then
						local var_531_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_528_1.actors_[var_531_18.prefab_name].transform, "story_v_out_423011", "423011127", "story_v_out_423011.awb")

						arg_528_1:RecordAudio("423011127", var_531_24)
						arg_528_1:RecordAudio("423011127", var_531_24)
					else
						arg_528_1:AudioAction("play", "voice", "story_v_out_423011", "423011127", "story_v_out_423011.awb")
					end

					arg_528_1:RecordHistoryTalkVoice("story_v_out_423011", "423011127", "story_v_out_423011.awb")
				end

				arg_528_1:RecordContent(arg_528_1.text_.text)
			end

			local var_531_25 = math.max(var_531_16, arg_528_1.talkMaxDuration)

			if var_531_15 <= arg_528_1.time_ and arg_528_1.time_ < var_531_15 + var_531_25 then
				arg_528_1.typewritter.percent = (arg_528_1.time_ - var_531_15) / var_531_25

				arg_528_1.typewritter:SetDirty()
			end

			if arg_528_1.time_ >= var_531_15 + var_531_25 and arg_528_1.time_ < var_531_15 + var_531_25 + arg_531_0 then
				arg_528_1.typewritter.percent = 1

				arg_528_1.typewritter:SetDirty()
				arg_528_1:ShowNextGo(true)
			end
		end

		arg_528_1.nodeConfigList_ = {
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

		arg_528_1:InitPlayNodeList()
	end,
	Play423011128 = function(arg_532_0, arg_532_1)
		arg_532_1.time_ = 0
		arg_532_1.frameCnt_ = 0
		arg_532_1.state_ = "playing"
		arg_532_1.curTalkId_ = 423011128
		arg_532_1.duration_ = 3.9

		local var_532_0 = {
			zh = 2.6,
			ja = 3.9
		}
		local var_532_1 = manager.audio:GetLocalizationFlag()

		if var_532_0[var_532_1] ~= nil then
			arg_532_1.duration_ = var_532_0[var_532_1]
		end

		SetActive(arg_532_1.tipsGo_, false)

		function arg_532_1.onSingleLineFinish_()
			arg_532_1.onSingleLineUpdate_ = nil
			arg_532_1.onSingleLineFinish_ = nil
			arg_532_1.state_ = "waiting"
		end

		function arg_532_1.playNext_(arg_534_0)
			if arg_534_0 == 1 then
				arg_532_0:Play423011129(arg_532_1)
			end
		end

		function arg_532_1.onSingleLineUpdate_(arg_535_0)
			local var_535_0 = 0
			local var_535_1 = 0.3

			if var_535_0 < arg_532_1.time_ and arg_532_1.time_ <= var_535_0 + arg_535_0 then
				arg_532_1.talkMaxDuration = 0
				arg_532_1.dialogCg_.alpha = 1

				arg_532_1.dialog_:SetActive(true)
				SetActive(arg_532_1.leftNameGo_, true)

				local var_535_2 = arg_532_1:FormatText(StoryNameCfg[36].name)

				arg_532_1.leftNameTxt_.text = var_535_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_532_1.leftNameTxt_.transform)

				arg_532_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_532_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_532_1:RecordName(arg_532_1.leftNameTxt_.text)
				SetActive(arg_532_1.iconTrs_.gameObject, false)
				arg_532_1.callingController_:SetSelectedState("normal")

				local var_535_3 = arg_532_1:GetWordFromCfg(423011128)
				local var_535_4 = arg_532_1:FormatText(var_535_3.content)

				arg_532_1.text_.text = var_535_4

				LuaForUtil.ClearLinePrefixSymbol(arg_532_1.text_)

				local var_535_5 = 12
				local var_535_6 = utf8.len(var_535_4)
				local var_535_7 = var_535_5 <= 0 and var_535_1 or var_535_1 * (var_535_6 / var_535_5)

				if var_535_7 > 0 and var_535_1 < var_535_7 then
					arg_532_1.talkMaxDuration = var_535_7

					if var_535_7 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_7 + var_535_0
					end
				end

				arg_532_1.text_.text = var_535_4
				arg_532_1.typewritter.percent = 0

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011128", "story_v_out_423011.awb") ~= 0 then
					local var_535_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011128", "story_v_out_423011.awb") / 1000

					if var_535_8 + var_535_0 > arg_532_1.duration_ then
						arg_532_1.duration_ = var_535_8 + var_535_0
					end

					if var_535_3.prefab_name ~= "" and arg_532_1.actors_[var_535_3.prefab_name] ~= nil then
						local var_535_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_532_1.actors_[var_535_3.prefab_name].transform, "story_v_out_423011", "423011128", "story_v_out_423011.awb")

						arg_532_1:RecordAudio("423011128", var_535_9)
						arg_532_1:RecordAudio("423011128", var_535_9)
					else
						arg_532_1:AudioAction("play", "voice", "story_v_out_423011", "423011128", "story_v_out_423011.awb")
					end

					arg_532_1:RecordHistoryTalkVoice("story_v_out_423011", "423011128", "story_v_out_423011.awb")
				end

				arg_532_1:RecordContent(arg_532_1.text_.text)
			end

			local var_535_10 = math.max(var_535_1, arg_532_1.talkMaxDuration)

			if var_535_0 <= arg_532_1.time_ and arg_532_1.time_ < var_535_0 + var_535_10 then
				arg_532_1.typewritter.percent = (arg_532_1.time_ - var_535_0) / var_535_10

				arg_532_1.typewritter:SetDirty()
			end

			if arg_532_1.time_ >= var_535_0 + var_535_10 and arg_532_1.time_ < var_535_0 + var_535_10 + arg_535_0 then
				arg_532_1.typewritter.percent = 1

				arg_532_1.typewritter:SetDirty()
				arg_532_1:ShowNextGo(true)
			end
		end

		arg_532_1.nodeConfigList_ = {}

		arg_532_1:InitPlayNodeList()
	end,
	Play423011129 = function(arg_536_0, arg_536_1)
		arg_536_1.time_ = 0
		arg_536_1.frameCnt_ = 0
		arg_536_1.state_ = "playing"
		arg_536_1.curTalkId_ = 423011129
		arg_536_1.duration_ = 2.7

		local var_536_0 = {
			zh = 2.7,
			ja = 2.566
		}
		local var_536_1 = manager.audio:GetLocalizationFlag()

		if var_536_0[var_536_1] ~= nil then
			arg_536_1.duration_ = var_536_0[var_536_1]
		end

		SetActive(arg_536_1.tipsGo_, false)

		function arg_536_1.onSingleLineFinish_()
			arg_536_1.onSingleLineUpdate_ = nil
			arg_536_1.onSingleLineFinish_ = nil
			arg_536_1.state_ = "waiting"
		end

		function arg_536_1.playNext_(arg_538_0)
			if arg_538_0 == 1 then
				arg_536_0:Play423011130(arg_536_1)
			end
		end

		function arg_536_1.onSingleLineUpdate_(arg_539_0)
			local var_539_0 = arg_536_1.actors_["1083"]
			local var_539_1 = 0

			if var_539_1 < arg_536_1.time_ and arg_536_1.time_ <= var_539_1 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.actorSpriteComps1083 == nil then
				arg_536_1.var_.actorSpriteComps1083 = var_539_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_539_2 = 0.2

			if var_539_1 <= arg_536_1.time_ and arg_536_1.time_ < var_539_1 + var_539_2 and not isNil(var_539_0) then
				local var_539_3 = (arg_536_1.time_ - var_539_1) / var_539_2

				if arg_536_1.var_.actorSpriteComps1083 then
					for iter_539_0, iter_539_1 in pairs(arg_536_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_539_1 then
							if arg_536_1.isInRecall_ then
								local var_539_4 = Mathf.Lerp(iter_539_1.color.r, arg_536_1.hightColor2.r, var_539_3)
								local var_539_5 = Mathf.Lerp(iter_539_1.color.g, arg_536_1.hightColor2.g, var_539_3)
								local var_539_6 = Mathf.Lerp(iter_539_1.color.b, arg_536_1.hightColor2.b, var_539_3)

								iter_539_1.color = Color.New(var_539_4, var_539_5, var_539_6)
							else
								local var_539_7 = Mathf.Lerp(iter_539_1.color.r, 0.5, var_539_3)

								iter_539_1.color = Color.New(var_539_7, var_539_7, var_539_7)
							end
						end
					end
				end
			end

			if arg_536_1.time_ >= var_539_1 + var_539_2 and arg_536_1.time_ < var_539_1 + var_539_2 + arg_539_0 and not isNil(var_539_0) and arg_536_1.var_.actorSpriteComps1083 then
				for iter_539_2, iter_539_3 in pairs(arg_536_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_539_3 then
						if arg_536_1.isInRecall_ then
							iter_539_3.color = arg_536_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_539_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_536_1.var_.actorSpriteComps1083 = nil
			end

			local var_539_8 = 0
			local var_539_9 = 0.225

			if var_539_8 < arg_536_1.time_ and arg_536_1.time_ <= var_539_8 + arg_539_0 then
				arg_536_1.talkMaxDuration = 0
				arg_536_1.dialogCg_.alpha = 1

				arg_536_1.dialog_:SetActive(true)
				SetActive(arg_536_1.leftNameGo_, true)

				local var_539_10 = arg_536_1:FormatText(StoryNameCfg[1330].name)

				arg_536_1.leftNameTxt_.text = var_539_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_536_1.leftNameTxt_.transform)

				arg_536_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_536_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_536_1:RecordName(arg_536_1.leftNameTxt_.text)
				SetActive(arg_536_1.iconTrs_.gameObject, true)
				arg_536_1.iconController_:SetSelectedState("hero")

				arg_536_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_536_1.callingController_:SetSelectedState("normal")

				arg_536_1.keyicon_.color = Color.New(1, 1, 1)
				arg_536_1.icon_.color = Color.New(1, 1, 1)

				local var_539_11 = arg_536_1:GetWordFromCfg(423011129)
				local var_539_12 = arg_536_1:FormatText(var_539_11.content)

				arg_536_1.text_.text = var_539_12

				LuaForUtil.ClearLinePrefixSymbol(arg_536_1.text_)

				local var_539_13 = 9
				local var_539_14 = utf8.len(var_539_12)
				local var_539_15 = var_539_13 <= 0 and var_539_9 or var_539_9 * (var_539_14 / var_539_13)

				if var_539_15 > 0 and var_539_9 < var_539_15 then
					arg_536_1.talkMaxDuration = var_539_15

					if var_539_15 + var_539_8 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_15 + var_539_8
					end
				end

				arg_536_1.text_.text = var_539_12
				arg_536_1.typewritter.percent = 0

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011129", "story_v_out_423011.awb") ~= 0 then
					local var_539_16 = manager.audio:GetVoiceLength("story_v_out_423011", "423011129", "story_v_out_423011.awb") / 1000

					if var_539_16 + var_539_8 > arg_536_1.duration_ then
						arg_536_1.duration_ = var_539_16 + var_539_8
					end

					if var_539_11.prefab_name ~= "" and arg_536_1.actors_[var_539_11.prefab_name] ~= nil then
						local var_539_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_536_1.actors_[var_539_11.prefab_name].transform, "story_v_out_423011", "423011129", "story_v_out_423011.awb")

						arg_536_1:RecordAudio("423011129", var_539_17)
						arg_536_1:RecordAudio("423011129", var_539_17)
					else
						arg_536_1:AudioAction("play", "voice", "story_v_out_423011", "423011129", "story_v_out_423011.awb")
					end

					arg_536_1:RecordHistoryTalkVoice("story_v_out_423011", "423011129", "story_v_out_423011.awb")
				end

				arg_536_1:RecordContent(arg_536_1.text_.text)
			end

			local var_539_18 = math.max(var_539_9, arg_536_1.talkMaxDuration)

			if var_539_8 <= arg_536_1.time_ and arg_536_1.time_ < var_539_8 + var_539_18 then
				arg_536_1.typewritter.percent = (arg_536_1.time_ - var_539_8) / var_539_18

				arg_536_1.typewritter:SetDirty()
			end

			if arg_536_1.time_ >= var_539_8 + var_539_18 and arg_536_1.time_ < var_539_8 + var_539_18 + arg_539_0 then
				arg_536_1.typewritter.percent = 1

				arg_536_1.typewritter:SetDirty()
				arg_536_1:ShowNextGo(true)
			end
		end

		arg_536_1.nodeConfigList_ = {}

		arg_536_1:InitPlayNodeList()
	end,
	Play423011130 = function(arg_540_0, arg_540_1)
		arg_540_1.time_ = 0
		arg_540_1.frameCnt_ = 0
		arg_540_1.state_ = "playing"
		arg_540_1.curTalkId_ = 423011130
		arg_540_1.duration_ = 7.27

		local var_540_0 = {
			zh = 7.266,
			ja = 6.566
		}
		local var_540_1 = manager.audio:GetLocalizationFlag()

		if var_540_0[var_540_1] ~= nil then
			arg_540_1.duration_ = var_540_0[var_540_1]
		end

		SetActive(arg_540_1.tipsGo_, false)

		function arg_540_1.onSingleLineFinish_()
			arg_540_1.onSingleLineUpdate_ = nil
			arg_540_1.onSingleLineFinish_ = nil
			arg_540_1.state_ = "waiting"
		end

		function arg_540_1.playNext_(arg_542_0)
			if arg_542_0 == 1 then
				arg_540_0:Play423011131(arg_540_1)
			end
		end

		function arg_540_1.onSingleLineUpdate_(arg_543_0)
			local var_543_0 = arg_540_1.actors_["1083"]
			local var_543_1 = 0

			if var_543_1 < arg_540_1.time_ and arg_540_1.time_ <= var_543_1 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.actorSpriteComps1083 == nil then
				arg_540_1.var_.actorSpriteComps1083 = var_543_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_543_2 = 0.2

			if var_543_1 <= arg_540_1.time_ and arg_540_1.time_ < var_543_1 + var_543_2 and not isNil(var_543_0) then
				local var_543_3 = (arg_540_1.time_ - var_543_1) / var_543_2

				if arg_540_1.var_.actorSpriteComps1083 then
					for iter_543_0, iter_543_1 in pairs(arg_540_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_543_1 then
							if arg_540_1.isInRecall_ then
								local var_543_4 = Mathf.Lerp(iter_543_1.color.r, arg_540_1.hightColor1.r, var_543_3)
								local var_543_5 = Mathf.Lerp(iter_543_1.color.g, arg_540_1.hightColor1.g, var_543_3)
								local var_543_6 = Mathf.Lerp(iter_543_1.color.b, arg_540_1.hightColor1.b, var_543_3)

								iter_543_1.color = Color.New(var_543_4, var_543_5, var_543_6)
							else
								local var_543_7 = Mathf.Lerp(iter_543_1.color.r, 1, var_543_3)

								iter_543_1.color = Color.New(var_543_7, var_543_7, var_543_7)
							end
						end
					end
				end
			end

			if arg_540_1.time_ >= var_543_1 + var_543_2 and arg_540_1.time_ < var_543_1 + var_543_2 + arg_543_0 and not isNil(var_543_0) and arg_540_1.var_.actorSpriteComps1083 then
				for iter_543_2, iter_543_3 in pairs(arg_540_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_543_3 then
						if arg_540_1.isInRecall_ then
							iter_543_3.color = arg_540_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_543_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_540_1.var_.actorSpriteComps1083 = nil
			end

			local var_543_8 = arg_540_1.actors_["1083"].transform
			local var_543_9 = 0

			if var_543_9 < arg_540_1.time_ and arg_540_1.time_ <= var_543_9 + arg_543_0 then
				arg_540_1.var_.moveOldPos1083 = var_543_8.localPosition
				var_543_8.localScale = Vector3.New(1, 1, 1)

				arg_540_1:CheckSpriteTmpPos("1083", 3)

				local var_543_10 = var_543_8.childCount

				for iter_543_4 = 0, var_543_10 - 1 do
					local var_543_11 = var_543_8:GetChild(iter_543_4)

					if var_543_11.name == "split_7" or not string.find(var_543_11.name, "split") then
						var_543_11.gameObject:SetActive(true)
					else
						var_543_11.gameObject:SetActive(false)
					end
				end
			end

			local var_543_12 = 0.001

			if var_543_9 <= arg_540_1.time_ and arg_540_1.time_ < var_543_9 + var_543_12 then
				local var_543_13 = (arg_540_1.time_ - var_543_9) / var_543_12
				local var_543_14 = Vector3.New(-50, -345, -345)

				var_543_8.localPosition = Vector3.Lerp(arg_540_1.var_.moveOldPos1083, var_543_14, var_543_13)
			end

			if arg_540_1.time_ >= var_543_9 + var_543_12 and arg_540_1.time_ < var_543_9 + var_543_12 + arg_543_0 then
				var_543_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_543_15 = 0
			local var_543_16 = 0.85

			if var_543_15 < arg_540_1.time_ and arg_540_1.time_ <= var_543_15 + arg_543_0 then
				arg_540_1.talkMaxDuration = 0
				arg_540_1.dialogCg_.alpha = 1

				arg_540_1.dialog_:SetActive(true)
				SetActive(arg_540_1.leftNameGo_, true)

				local var_543_17 = arg_540_1:FormatText(StoryNameCfg[36].name)

				arg_540_1.leftNameTxt_.text = var_543_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_540_1.leftNameTxt_.transform)

				arg_540_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_540_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_540_1:RecordName(arg_540_1.leftNameTxt_.text)
				SetActive(arg_540_1.iconTrs_.gameObject, false)
				arg_540_1.callingController_:SetSelectedState("normal")

				local var_543_18 = arg_540_1:GetWordFromCfg(423011130)
				local var_543_19 = arg_540_1:FormatText(var_543_18.content)

				arg_540_1.text_.text = var_543_19

				LuaForUtil.ClearLinePrefixSymbol(arg_540_1.text_)

				local var_543_20 = 34
				local var_543_21 = utf8.len(var_543_19)
				local var_543_22 = var_543_20 <= 0 and var_543_16 or var_543_16 * (var_543_21 / var_543_20)

				if var_543_22 > 0 and var_543_16 < var_543_22 then
					arg_540_1.talkMaxDuration = var_543_22

					if var_543_22 + var_543_15 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_22 + var_543_15
					end
				end

				arg_540_1.text_.text = var_543_19
				arg_540_1.typewritter.percent = 0

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011130", "story_v_out_423011.awb") ~= 0 then
					local var_543_23 = manager.audio:GetVoiceLength("story_v_out_423011", "423011130", "story_v_out_423011.awb") / 1000

					if var_543_23 + var_543_15 > arg_540_1.duration_ then
						arg_540_1.duration_ = var_543_23 + var_543_15
					end

					if var_543_18.prefab_name ~= "" and arg_540_1.actors_[var_543_18.prefab_name] ~= nil then
						local var_543_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_540_1.actors_[var_543_18.prefab_name].transform, "story_v_out_423011", "423011130", "story_v_out_423011.awb")

						arg_540_1:RecordAudio("423011130", var_543_24)
						arg_540_1:RecordAudio("423011130", var_543_24)
					else
						arg_540_1:AudioAction("play", "voice", "story_v_out_423011", "423011130", "story_v_out_423011.awb")
					end

					arg_540_1:RecordHistoryTalkVoice("story_v_out_423011", "423011130", "story_v_out_423011.awb")
				end

				arg_540_1:RecordContent(arg_540_1.text_.text)
			end

			local var_543_25 = math.max(var_543_16, arg_540_1.talkMaxDuration)

			if var_543_15 <= arg_540_1.time_ and arg_540_1.time_ < var_543_15 + var_543_25 then
				arg_540_1.typewritter.percent = (arg_540_1.time_ - var_543_15) / var_543_25

				arg_540_1.typewritter:SetDirty()
			end

			if arg_540_1.time_ >= var_543_15 + var_543_25 and arg_540_1.time_ < var_543_15 + var_543_25 + arg_543_0 then
				arg_540_1.typewritter.percent = 1

				arg_540_1.typewritter:SetDirty()
				arg_540_1:ShowNextGo(true)
			end
		end

		arg_540_1.nodeConfigList_ = {
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

		arg_540_1:InitPlayNodeList()
	end,
	Play423011131 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 423011131
		arg_544_1.duration_ = 5.2

		local var_544_0 = {
			zh = 4.433,
			ja = 5.2
		}
		local var_544_1 = manager.audio:GetLocalizationFlag()

		if var_544_0[var_544_1] ~= nil then
			arg_544_1.duration_ = var_544_0[var_544_1]
		end

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play423011132(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			local var_547_0 = arg_544_1.actors_["1083"].transform
			local var_547_1 = 0

			if var_547_1 < arg_544_1.time_ and arg_544_1.time_ <= var_547_1 + arg_547_0 then
				arg_544_1.var_.moveOldPos1083 = var_547_0.localPosition
				var_547_0.localScale = Vector3.New(1, 1, 1)

				arg_544_1:CheckSpriteTmpPos("1083", 3)

				local var_547_2 = var_547_0.childCount

				for iter_547_0 = 0, var_547_2 - 1 do
					local var_547_3 = var_547_0:GetChild(iter_547_0)

					if var_547_3.name == "split_3" or not string.find(var_547_3.name, "split") then
						var_547_3.gameObject:SetActive(true)
					else
						var_547_3.gameObject:SetActive(false)
					end
				end
			end

			local var_547_4 = 0.001

			if var_547_1 <= arg_544_1.time_ and arg_544_1.time_ < var_547_1 + var_547_4 then
				local var_547_5 = (arg_544_1.time_ - var_547_1) / var_547_4
				local var_547_6 = Vector3.New(-50, -345, -345)

				var_547_0.localPosition = Vector3.Lerp(arg_544_1.var_.moveOldPos1083, var_547_6, var_547_5)
			end

			if arg_544_1.time_ >= var_547_1 + var_547_4 and arg_544_1.time_ < var_547_1 + var_547_4 + arg_547_0 then
				var_547_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_547_7 = 0
			local var_547_8 = 0.45

			if var_547_7 < arg_544_1.time_ and arg_544_1.time_ <= var_547_7 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, true)

				local var_547_9 = arg_544_1:FormatText(StoryNameCfg[36].name)

				arg_544_1.leftNameTxt_.text = var_547_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_544_1.leftNameTxt_.transform)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1.leftNameTxt_.text)
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_10 = arg_544_1:GetWordFromCfg(423011131)
				local var_547_11 = arg_544_1:FormatText(var_547_10.content)

				arg_544_1.text_.text = var_547_11

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_12 = 18
				local var_547_13 = utf8.len(var_547_11)
				local var_547_14 = var_547_12 <= 0 and var_547_8 or var_547_8 * (var_547_13 / var_547_12)

				if var_547_14 > 0 and var_547_8 < var_547_14 then
					arg_544_1.talkMaxDuration = var_547_14

					if var_547_14 + var_547_7 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_14 + var_547_7
					end
				end

				arg_544_1.text_.text = var_547_11
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011131", "story_v_out_423011.awb") ~= 0 then
					local var_547_15 = manager.audio:GetVoiceLength("story_v_out_423011", "423011131", "story_v_out_423011.awb") / 1000

					if var_547_15 + var_547_7 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_15 + var_547_7
					end

					if var_547_10.prefab_name ~= "" and arg_544_1.actors_[var_547_10.prefab_name] ~= nil then
						local var_547_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_544_1.actors_[var_547_10.prefab_name].transform, "story_v_out_423011", "423011131", "story_v_out_423011.awb")

						arg_544_1:RecordAudio("423011131", var_547_16)
						arg_544_1:RecordAudio("423011131", var_547_16)
					else
						arg_544_1:AudioAction("play", "voice", "story_v_out_423011", "423011131", "story_v_out_423011.awb")
					end

					arg_544_1:RecordHistoryTalkVoice("story_v_out_423011", "423011131", "story_v_out_423011.awb")
				end

				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_17 = math.max(var_547_8, arg_544_1.talkMaxDuration)

			if var_547_7 <= arg_544_1.time_ and arg_544_1.time_ < var_547_7 + var_547_17 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_7) / var_547_17

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_7 + var_547_17 and arg_544_1.time_ < var_547_7 + var_547_17 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {
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

		arg_544_1:InitPlayNodeList()
	end,
	Play423011132 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 423011132
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play423011133(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = arg_548_1.actors_["1083"]
			local var_551_1 = 0

			if var_551_1 < arg_548_1.time_ and arg_548_1.time_ <= var_551_1 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.actorSpriteComps1083 == nil then
				arg_548_1.var_.actorSpriteComps1083 = var_551_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_551_2 = 0.2

			if var_551_1 <= arg_548_1.time_ and arg_548_1.time_ < var_551_1 + var_551_2 and not isNil(var_551_0) then
				local var_551_3 = (arg_548_1.time_ - var_551_1) / var_551_2

				if arg_548_1.var_.actorSpriteComps1083 then
					for iter_551_0, iter_551_1 in pairs(arg_548_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_551_1 then
							if arg_548_1.isInRecall_ then
								local var_551_4 = Mathf.Lerp(iter_551_1.color.r, arg_548_1.hightColor2.r, var_551_3)
								local var_551_5 = Mathf.Lerp(iter_551_1.color.g, arg_548_1.hightColor2.g, var_551_3)
								local var_551_6 = Mathf.Lerp(iter_551_1.color.b, arg_548_1.hightColor2.b, var_551_3)

								iter_551_1.color = Color.New(var_551_4, var_551_5, var_551_6)
							else
								local var_551_7 = Mathf.Lerp(iter_551_1.color.r, 0.5, var_551_3)

								iter_551_1.color = Color.New(var_551_7, var_551_7, var_551_7)
							end
						end
					end
				end
			end

			if arg_548_1.time_ >= var_551_1 + var_551_2 and arg_548_1.time_ < var_551_1 + var_551_2 + arg_551_0 and not isNil(var_551_0) and arg_548_1.var_.actorSpriteComps1083 then
				for iter_551_2, iter_551_3 in pairs(arg_548_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_551_3 then
						if arg_548_1.isInRecall_ then
							iter_551_3.color = arg_548_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_551_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_548_1.var_.actorSpriteComps1083 = nil
			end

			local var_551_8 = arg_548_1.actors_["1083"].transform
			local var_551_9 = 0

			if var_551_9 < arg_548_1.time_ and arg_548_1.time_ <= var_551_9 + arg_551_0 then
				arg_548_1.var_.moveOldPos1083 = var_551_8.localPosition
				var_551_8.localScale = Vector3.New(1, 1, 1)

				arg_548_1:CheckSpriteTmpPos("1083", 7)

				local var_551_10 = var_551_8.childCount

				for iter_551_4 = 0, var_551_10 - 1 do
					local var_551_11 = var_551_8:GetChild(iter_551_4)

					if var_551_11.name == "" or not string.find(var_551_11.name, "split") then
						var_551_11.gameObject:SetActive(true)
					else
						var_551_11.gameObject:SetActive(false)
					end
				end
			end

			local var_551_12 = 0.001

			if var_551_9 <= arg_548_1.time_ and arg_548_1.time_ < var_551_9 + var_551_12 then
				local var_551_13 = (arg_548_1.time_ - var_551_9) / var_551_12
				local var_551_14 = Vector3.New(0, -2000, 0)

				var_551_8.localPosition = Vector3.Lerp(arg_548_1.var_.moveOldPos1083, var_551_14, var_551_13)
			end

			if arg_548_1.time_ >= var_551_9 + var_551_12 and arg_548_1.time_ < var_551_9 + var_551_12 + arg_551_0 then
				var_551_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_551_15 = 0.666666666666667
			local var_551_16 = 1

			if var_551_15 < arg_548_1.time_ and arg_548_1.time_ <= var_551_15 + arg_551_0 then
				local var_551_17 = "play"
				local var_551_18 = "effect"

				arg_548_1:AudioAction(var_551_17, var_551_18, "se_story_144", "se_story_144_footstep_back", "")
			end

			local var_551_19 = 0
			local var_551_20 = 1.2

			if var_551_19 < arg_548_1.time_ and arg_548_1.time_ <= var_551_19 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_21 = arg_548_1:GetWordFromCfg(423011132)
				local var_551_22 = arg_548_1:FormatText(var_551_21.content)

				arg_548_1.text_.text = var_551_22

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_23 = 48
				local var_551_24 = utf8.len(var_551_22)
				local var_551_25 = var_551_23 <= 0 and var_551_20 or var_551_20 * (var_551_24 / var_551_23)

				if var_551_25 > 0 and var_551_20 < var_551_25 then
					arg_548_1.talkMaxDuration = var_551_25

					if var_551_25 + var_551_19 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_25 + var_551_19
					end
				end

				arg_548_1.text_.text = var_551_22
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_26 = math.max(var_551_20, arg_548_1.talkMaxDuration)

			if var_551_19 <= arg_548_1.time_ and arg_548_1.time_ < var_551_19 + var_551_26 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - var_551_19) / var_551_26

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= var_551_19 + var_551_26 and arg_548_1.time_ < var_551_19 + var_551_26 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {
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

		arg_548_1:InitPlayNodeList()
	end,
	Play423011133 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 423011133
		arg_552_1.duration_ = 5

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play423011134(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			local var_555_0 = 0
			local var_555_1 = 0.275

			if var_555_0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_0 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0
				arg_552_1.dialogCg_.alpha = 1

				arg_552_1.dialog_:SetActive(true)
				SetActive(arg_552_1.leftNameGo_, true)

				local var_555_2 = arg_552_1:FormatText(StoryNameCfg[7].name)

				arg_552_1.leftNameTxt_.text = var_555_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_552_1.leftNameTxt_.transform)

				arg_552_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_552_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_552_1:RecordName(arg_552_1.leftNameTxt_.text)
				SetActive(arg_552_1.iconTrs_.gameObject, true)
				arg_552_1.iconController_:SetSelectedState("hero")

				arg_552_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_552_1.callingController_:SetSelectedState("normal")

				arg_552_1.keyicon_.color = Color.New(1, 1, 1)
				arg_552_1.icon_.color = Color.New(1, 1, 1)

				local var_555_3 = arg_552_1:GetWordFromCfg(423011133)
				local var_555_4 = arg_552_1:FormatText(var_555_3.content)

				arg_552_1.text_.text = var_555_4

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.text_)

				local var_555_5 = 11
				local var_555_6 = utf8.len(var_555_4)
				local var_555_7 = var_555_5 <= 0 and var_555_1 or var_555_1 * (var_555_6 / var_555_5)

				if var_555_7 > 0 and var_555_1 < var_555_7 then
					arg_552_1.talkMaxDuration = var_555_7

					if var_555_7 + var_555_0 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_7 + var_555_0
					end
				end

				arg_552_1.text_.text = var_555_4
				arg_552_1.typewritter.percent = 0

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(false)
				arg_552_1:RecordContent(arg_552_1.text_.text)
			end

			local var_555_8 = math.max(var_555_1, arg_552_1.talkMaxDuration)

			if var_555_0 <= arg_552_1.time_ and arg_552_1.time_ < var_555_0 + var_555_8 then
				arg_552_1.typewritter.percent = (arg_552_1.time_ - var_555_0) / var_555_8

				arg_552_1.typewritter:SetDirty()
			end

			if arg_552_1.time_ >= var_555_0 + var_555_8 and arg_552_1.time_ < var_555_0 + var_555_8 + arg_555_0 then
				arg_552_1.typewritter.percent = 1

				arg_552_1.typewritter:SetDirty()
				arg_552_1:ShowNextGo(true)
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play423011134 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 423011134
		arg_556_1.duration_ = 6

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play423011135(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			local var_559_0 = manager.ui.mainCamera.transform
			local var_559_1 = 0

			if var_559_1 < arg_556_1.time_ and arg_556_1.time_ <= var_559_1 + arg_559_0 then
				arg_556_1.var_.shakeOldPos = var_559_0.localPosition
			end

			local var_559_2 = 1

			if var_559_1 <= arg_556_1.time_ and arg_556_1.time_ < var_559_1 + var_559_2 then
				local var_559_3 = (arg_556_1.time_ - var_559_1) / 0.066
				local var_559_4, var_559_5 = math.modf(var_559_3)

				var_559_0.localPosition = Vector3.New(var_559_5 * 0.13, var_559_5 * 0.13, var_559_5 * 0.13) + arg_556_1.var_.shakeOldPos
			end

			if arg_556_1.time_ >= var_559_1 + var_559_2 and arg_556_1.time_ < var_559_1 + var_559_2 + arg_559_0 then
				var_559_0.localPosition = arg_556_1.var_.shakeOldPos
			end

			local var_559_6 = manager.ui.mainCamera.transform
			local var_559_7 = 0

			if var_559_7 < arg_556_1.time_ and arg_556_1.time_ <= var_559_7 + arg_559_0 then
				local var_559_8 = arg_556_1.var_.effectfeichumuxie
				local var_559_9
				local var_559_10 = var_559_6

				if not var_559_8 then
					var_559_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_559_10)
					var_559_8.name = "feichumuxie"
					arg_556_1.var_.effectfeichumuxie = var_559_8
				else
					var_559_8.transform:SetParent(var_559_10)
				end

				var_559_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_559_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_559_11 = manager.ui.mainCamera.transform
			local var_559_12 = 1.5

			if var_559_12 < arg_556_1.time_ and arg_556_1.time_ <= var_559_12 + arg_559_0 then
				local var_559_13 = arg_556_1.var_.effectfeichumuxie

				if var_559_13 then
					Object.Destroy(var_559_13)

					arg_556_1.var_.effectfeichumuxie = nil
				end
			end

			local var_559_14 = 0

			if var_559_14 < arg_556_1.time_ and arg_556_1.time_ <= var_559_14 + arg_559_0 then
				arg_556_1.allBtn_.enabled = false
			end

			local var_559_15 = 1

			if arg_556_1.time_ >= var_559_14 + var_559_15 and arg_556_1.time_ < var_559_14 + var_559_15 + arg_559_0 then
				arg_556_1.allBtn_.enabled = true
			end

			local var_559_16 = 0.166666666666667
			local var_559_17 = 1

			if var_559_16 < arg_556_1.time_ and arg_556_1.time_ <= var_559_16 + arg_559_0 then
				local var_559_18 = "play"
				local var_559_19 = "effect"

				arg_556_1:AudioAction(var_559_18, var_559_19, "se_story_15", "se_story_15_gun05", "")
			end

			if arg_556_1.frameCnt_ <= 1 then
				arg_556_1.dialog_:SetActive(false)
			end

			local var_559_20 = 1
			local var_559_21 = 1.075

			if var_559_20 < arg_556_1.time_ and arg_556_1.time_ <= var_559_20 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0

				arg_556_1.dialog_:SetActive(true)

				arg_556_1.dialogCg_.alpha = 0

				local var_559_22 = LeanTween.value(arg_556_1.dialog_, 0, 1, 0.3)

				var_559_22:setOnUpdate(LuaHelper.FloatAction(function(arg_560_0)
					arg_556_1.dialogCg_.alpha = arg_560_0
				end))
				var_559_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_556_1.dialog_)
					var_559_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_556_1.duration_ = arg_556_1.duration_ + 0.3

				SetActive(arg_556_1.leftNameGo_, false)

				arg_556_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_556_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_556_1:RecordName(arg_556_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_556_1.iconTrs_.gameObject, false)
				arg_556_1.callingController_:SetSelectedState("normal")

				local var_559_23 = arg_556_1:GetWordFromCfg(423011134)
				local var_559_24 = arg_556_1:FormatText(var_559_23.content)

				arg_556_1.text_.text = var_559_24

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.text_)

				local var_559_25 = 43
				local var_559_26 = utf8.len(var_559_24)
				local var_559_27 = var_559_25 <= 0 and var_559_21 or var_559_21 * (var_559_26 / var_559_25)

				if var_559_27 > 0 and var_559_21 < var_559_27 then
					arg_556_1.talkMaxDuration = var_559_27
					var_559_20 = var_559_20 + 0.3

					if var_559_27 + var_559_20 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_27 + var_559_20
					end
				end

				arg_556_1.text_.text = var_559_24
				arg_556_1.typewritter.percent = 0

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(false)
				arg_556_1:RecordContent(arg_556_1.text_.text)
			end

			local var_559_28 = var_559_20 + 0.3
			local var_559_29 = math.max(var_559_21, arg_556_1.talkMaxDuration)

			if var_559_28 <= arg_556_1.time_ and arg_556_1.time_ < var_559_28 + var_559_29 then
				arg_556_1.typewritter.percent = (arg_556_1.time_ - var_559_28) / var_559_29

				arg_556_1.typewritter:SetDirty()
			end

			if arg_556_1.time_ >= var_559_28 + var_559_29 and arg_556_1.time_ < var_559_28 + var_559_29 + arg_559_0 then
				arg_556_1.typewritter.percent = 1

				arg_556_1.typewritter:SetDirty()
				arg_556_1:ShowNextGo(true)
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play423011135 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 423011135
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play423011136(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0
			local var_565_1 = 1.15

			if var_565_0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, false)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_562_1.iconTrs_.gameObject, false)
				arg_562_1.callingController_:SetSelectedState("normal")

				local var_565_2 = arg_562_1:GetWordFromCfg(423011135)
				local var_565_3 = arg_562_1:FormatText(var_565_2.content)

				arg_562_1.text_.text = var_565_3

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_4 = 46
				local var_565_5 = utf8.len(var_565_3)
				local var_565_6 = var_565_4 <= 0 and var_565_1 or var_565_1 * (var_565_5 / var_565_4)

				if var_565_6 > 0 and var_565_1 < var_565_6 then
					arg_562_1.talkMaxDuration = var_565_6

					if var_565_6 + var_565_0 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_6 + var_565_0
					end
				end

				arg_562_1.text_.text = var_565_3
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_7 = math.max(var_565_1, arg_562_1.talkMaxDuration)

			if var_565_0 <= arg_562_1.time_ and arg_562_1.time_ < var_565_0 + var_565_7 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_0) / var_565_7

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_0 + var_565_7 and arg_562_1.time_ < var_565_0 + var_565_7 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play423011136 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 423011136
		arg_566_1.duration_ = 5

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play423011137(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 0.166666666666667
			local var_569_1 = 1

			if var_569_0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_0 + arg_569_0 then
				local var_569_2 = "play"
				local var_569_3 = "effect"

				arg_566_1:AudioAction(var_569_2, var_569_3, "se_story_1311", "se_story_1311_gun01", "")
			end

			local var_569_4 = 0
			local var_569_5 = 1.25

			if var_569_4 < arg_566_1.time_ and arg_566_1.time_ <= var_569_4 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, false)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_6 = arg_566_1:GetWordFromCfg(423011136)
				local var_569_7 = arg_566_1:FormatText(var_569_6.content)

				arg_566_1.text_.text = var_569_7

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_8 = 50
				local var_569_9 = utf8.len(var_569_7)
				local var_569_10 = var_569_8 <= 0 and var_569_5 or var_569_5 * (var_569_9 / var_569_8)

				if var_569_10 > 0 and var_569_5 < var_569_10 then
					arg_566_1.talkMaxDuration = var_569_10

					if var_569_10 + var_569_4 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_10 + var_569_4
					end
				end

				arg_566_1.text_.text = var_569_7
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)
				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_11 = math.max(var_569_5, arg_566_1.talkMaxDuration)

			if var_569_4 <= arg_566_1.time_ and arg_566_1.time_ < var_569_4 + var_569_11 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_4) / var_569_11

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_4 + var_569_11 and arg_566_1.time_ < var_569_4 + var_569_11 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play423011137 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 423011137
		arg_570_1.duration_ = 5.8

		local var_570_0 = {
			zh = 3.433,
			ja = 5.8
		}
		local var_570_1 = manager.audio:GetLocalizationFlag()

		if var_570_0[var_570_1] ~= nil then
			arg_570_1.duration_ = var_570_0[var_570_1]
		end

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play423011138(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = arg_570_1.actors_["1083"]
			local var_573_1 = 0

			if var_573_1 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.actorSpriteComps1083 == nil then
				arg_570_1.var_.actorSpriteComps1083 = var_573_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_573_2 = 0.2

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_2 and not isNil(var_573_0) then
				local var_573_3 = (arg_570_1.time_ - var_573_1) / var_573_2

				if arg_570_1.var_.actorSpriteComps1083 then
					for iter_573_0, iter_573_1 in pairs(arg_570_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_573_1 then
							if arg_570_1.isInRecall_ then
								local var_573_4 = Mathf.Lerp(iter_573_1.color.r, arg_570_1.hightColor1.r, var_573_3)
								local var_573_5 = Mathf.Lerp(iter_573_1.color.g, arg_570_1.hightColor1.g, var_573_3)
								local var_573_6 = Mathf.Lerp(iter_573_1.color.b, arg_570_1.hightColor1.b, var_573_3)

								iter_573_1.color = Color.New(var_573_4, var_573_5, var_573_6)
							else
								local var_573_7 = Mathf.Lerp(iter_573_1.color.r, 1, var_573_3)

								iter_573_1.color = Color.New(var_573_7, var_573_7, var_573_7)
							end
						end
					end
				end
			end

			if arg_570_1.time_ >= var_573_1 + var_573_2 and arg_570_1.time_ < var_573_1 + var_573_2 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.actorSpriteComps1083 then
				for iter_573_2, iter_573_3 in pairs(arg_570_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_573_3 then
						if arg_570_1.isInRecall_ then
							iter_573_3.color = arg_570_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_573_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_570_1.var_.actorSpriteComps1083 = nil
			end

			local var_573_8 = arg_570_1.actors_["1083"].transform
			local var_573_9 = 0

			if var_573_9 < arg_570_1.time_ and arg_570_1.time_ <= var_573_9 + arg_573_0 then
				arg_570_1.var_.moveOldPos1083 = var_573_8.localPosition
				var_573_8.localScale = Vector3.New(1, 1, 1)

				arg_570_1:CheckSpriteTmpPos("1083", 3)

				local var_573_10 = var_573_8.childCount

				for iter_573_4 = 0, var_573_10 - 1 do
					local var_573_11 = var_573_8:GetChild(iter_573_4)

					if var_573_11.name == "split_3" or not string.find(var_573_11.name, "split") then
						var_573_11.gameObject:SetActive(true)
					else
						var_573_11.gameObject:SetActive(false)
					end
				end
			end

			local var_573_12 = 0.001

			if var_573_9 <= arg_570_1.time_ and arg_570_1.time_ < var_573_9 + var_573_12 then
				local var_573_13 = (arg_570_1.time_ - var_573_9) / var_573_12
				local var_573_14 = Vector3.New(-50, -345, -345)

				var_573_8.localPosition = Vector3.Lerp(arg_570_1.var_.moveOldPos1083, var_573_14, var_573_13)
			end

			if arg_570_1.time_ >= var_573_9 + var_573_12 and arg_570_1.time_ < var_573_9 + var_573_12 + arg_573_0 then
				var_573_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_573_15 = 0
			local var_573_16 = 0.475

			if var_573_15 < arg_570_1.time_ and arg_570_1.time_ <= var_573_15 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, true)

				local var_573_17 = arg_570_1:FormatText(StoryNameCfg[36].name)

				arg_570_1.leftNameTxt_.text = var_573_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_570_1.leftNameTxt_.transform)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1.leftNameTxt_.text)
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_18 = arg_570_1:GetWordFromCfg(423011137)
				local var_573_19 = arg_570_1:FormatText(var_573_18.content)

				arg_570_1.text_.text = var_573_19

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_20 = 19
				local var_573_21 = utf8.len(var_573_19)
				local var_573_22 = var_573_20 <= 0 and var_573_16 or var_573_16 * (var_573_21 / var_573_20)

				if var_573_22 > 0 and var_573_16 < var_573_22 then
					arg_570_1.talkMaxDuration = var_573_22

					if var_573_22 + var_573_15 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_22 + var_573_15
					end
				end

				arg_570_1.text_.text = var_573_19
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011137", "story_v_out_423011.awb") ~= 0 then
					local var_573_23 = manager.audio:GetVoiceLength("story_v_out_423011", "423011137", "story_v_out_423011.awb") / 1000

					if var_573_23 + var_573_15 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_23 + var_573_15
					end

					if var_573_18.prefab_name ~= "" and arg_570_1.actors_[var_573_18.prefab_name] ~= nil then
						local var_573_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_570_1.actors_[var_573_18.prefab_name].transform, "story_v_out_423011", "423011137", "story_v_out_423011.awb")

						arg_570_1:RecordAudio("423011137", var_573_24)
						arg_570_1:RecordAudio("423011137", var_573_24)
					else
						arg_570_1:AudioAction("play", "voice", "story_v_out_423011", "423011137", "story_v_out_423011.awb")
					end

					arg_570_1:RecordHistoryTalkVoice("story_v_out_423011", "423011137", "story_v_out_423011.awb")
				end

				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_25 = math.max(var_573_16, arg_570_1.talkMaxDuration)

			if var_573_15 <= arg_570_1.time_ and arg_570_1.time_ < var_573_15 + var_573_25 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_15) / var_573_25

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_15 + var_573_25 and arg_570_1.time_ < var_573_15 + var_573_25 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {
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

		arg_570_1:InitPlayNodeList()
	end,
	Play423011138 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 423011138
		arg_574_1.duration_ = 4.43

		local var_574_0 = {
			zh = 3.466,
			ja = 4.433
		}
		local var_574_1 = manager.audio:GetLocalizationFlag()

		if var_574_0[var_574_1] ~= nil then
			arg_574_1.duration_ = var_574_0[var_574_1]
		end

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play423011139(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = arg_574_1.actors_["1083"]
			local var_577_1 = 0

			if var_577_1 < arg_574_1.time_ and arg_574_1.time_ <= var_577_1 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.actorSpriteComps1083 == nil then
				arg_574_1.var_.actorSpriteComps1083 = var_577_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_577_2 = 0.2

			if var_577_1 <= arg_574_1.time_ and arg_574_1.time_ < var_577_1 + var_577_2 and not isNil(var_577_0) then
				local var_577_3 = (arg_574_1.time_ - var_577_1) / var_577_2

				if arg_574_1.var_.actorSpriteComps1083 then
					for iter_577_0, iter_577_1 in pairs(arg_574_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_577_1 then
							if arg_574_1.isInRecall_ then
								local var_577_4 = Mathf.Lerp(iter_577_1.color.r, arg_574_1.hightColor2.r, var_577_3)
								local var_577_5 = Mathf.Lerp(iter_577_1.color.g, arg_574_1.hightColor2.g, var_577_3)
								local var_577_6 = Mathf.Lerp(iter_577_1.color.b, arg_574_1.hightColor2.b, var_577_3)

								iter_577_1.color = Color.New(var_577_4, var_577_5, var_577_6)
							else
								local var_577_7 = Mathf.Lerp(iter_577_1.color.r, 0.5, var_577_3)

								iter_577_1.color = Color.New(var_577_7, var_577_7, var_577_7)
							end
						end
					end
				end
			end

			if arg_574_1.time_ >= var_577_1 + var_577_2 and arg_574_1.time_ < var_577_1 + var_577_2 + arg_577_0 and not isNil(var_577_0) and arg_574_1.var_.actorSpriteComps1083 then
				for iter_577_2, iter_577_3 in pairs(arg_574_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_577_3 then
						if arg_574_1.isInRecall_ then
							iter_577_3.color = arg_574_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_577_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_574_1.var_.actorSpriteComps1083 = nil
			end

			local var_577_8 = 0
			local var_577_9 = 0.375

			if var_577_8 < arg_574_1.time_ and arg_574_1.time_ <= var_577_8 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				local var_577_10 = arg_574_1:FormatText(StoryNameCfg[1330].name)

				arg_574_1.leftNameTxt_.text = var_577_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, true)
				arg_574_1.iconController_:SetSelectedState("hero")

				arg_574_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2083")

				arg_574_1.callingController_:SetSelectedState("normal")

				arg_574_1.keyicon_.color = Color.New(1, 1, 1)
				arg_574_1.icon_.color = Color.New(1, 1, 1)

				local var_577_11 = arg_574_1:GetWordFromCfg(423011138)
				local var_577_12 = arg_574_1:FormatText(var_577_11.content)

				arg_574_1.text_.text = var_577_12

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_13 = 15
				local var_577_14 = utf8.len(var_577_12)
				local var_577_15 = var_577_13 <= 0 and var_577_9 or var_577_9 * (var_577_14 / var_577_13)

				if var_577_15 > 0 and var_577_9 < var_577_15 then
					arg_574_1.talkMaxDuration = var_577_15

					if var_577_15 + var_577_8 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_15 + var_577_8
					end
				end

				arg_574_1.text_.text = var_577_12
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011138", "story_v_out_423011.awb") ~= 0 then
					local var_577_16 = manager.audio:GetVoiceLength("story_v_out_423011", "423011138", "story_v_out_423011.awb") / 1000

					if var_577_16 + var_577_8 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_16 + var_577_8
					end

					if var_577_11.prefab_name ~= "" and arg_574_1.actors_[var_577_11.prefab_name] ~= nil then
						local var_577_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_574_1.actors_[var_577_11.prefab_name].transform, "story_v_out_423011", "423011138", "story_v_out_423011.awb")

						arg_574_1:RecordAudio("423011138", var_577_17)
						arg_574_1:RecordAudio("423011138", var_577_17)
					else
						arg_574_1:AudioAction("play", "voice", "story_v_out_423011", "423011138", "story_v_out_423011.awb")
					end

					arg_574_1:RecordHistoryTalkVoice("story_v_out_423011", "423011138", "story_v_out_423011.awb")
				end

				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_18 = math.max(var_577_9, arg_574_1.talkMaxDuration)

			if var_577_8 <= arg_574_1.time_ and arg_574_1.time_ < var_577_8 + var_577_18 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_8) / var_577_18

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_8 + var_577_18 and arg_574_1.time_ < var_577_8 + var_577_18 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play423011139 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 423011139
		arg_578_1.duration_ = 6.8

		local var_578_0 = {
			zh = 5.033,
			ja = 6.8
		}
		local var_578_1 = manager.audio:GetLocalizationFlag()

		if var_578_0[var_578_1] ~= nil then
			arg_578_1.duration_ = var_578_0[var_578_1]
		end

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play423011140(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = arg_578_1.actors_["1083"]
			local var_581_1 = 0

			if var_581_1 < arg_578_1.time_ and arg_578_1.time_ <= var_581_1 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.actorSpriteComps1083 == nil then
				arg_578_1.var_.actorSpriteComps1083 = var_581_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_581_2 = 0.2

			if var_581_1 <= arg_578_1.time_ and arg_578_1.time_ < var_581_1 + var_581_2 and not isNil(var_581_0) then
				local var_581_3 = (arg_578_1.time_ - var_581_1) / var_581_2

				if arg_578_1.var_.actorSpriteComps1083 then
					for iter_581_0, iter_581_1 in pairs(arg_578_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_581_1 then
							if arg_578_1.isInRecall_ then
								local var_581_4 = Mathf.Lerp(iter_581_1.color.r, arg_578_1.hightColor1.r, var_581_3)
								local var_581_5 = Mathf.Lerp(iter_581_1.color.g, arg_578_1.hightColor1.g, var_581_3)
								local var_581_6 = Mathf.Lerp(iter_581_1.color.b, arg_578_1.hightColor1.b, var_581_3)

								iter_581_1.color = Color.New(var_581_4, var_581_5, var_581_6)
							else
								local var_581_7 = Mathf.Lerp(iter_581_1.color.r, 1, var_581_3)

								iter_581_1.color = Color.New(var_581_7, var_581_7, var_581_7)
							end
						end
					end
				end
			end

			if arg_578_1.time_ >= var_581_1 + var_581_2 and arg_578_1.time_ < var_581_1 + var_581_2 + arg_581_0 and not isNil(var_581_0) and arg_578_1.var_.actorSpriteComps1083 then
				for iter_581_2, iter_581_3 in pairs(arg_578_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_581_3 then
						if arg_578_1.isInRecall_ then
							iter_581_3.color = arg_578_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_581_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_578_1.var_.actorSpriteComps1083 = nil
			end

			local var_581_8 = arg_578_1.actors_["1083"].transform
			local var_581_9 = 0

			if var_581_9 < arg_578_1.time_ and arg_578_1.time_ <= var_581_9 + arg_581_0 then
				arg_578_1.var_.moveOldPos1083 = var_581_8.localPosition
				var_581_8.localScale = Vector3.New(1, 1, 1)

				arg_578_1:CheckSpriteTmpPos("1083", 3)

				local var_581_10 = var_581_8.childCount

				for iter_581_4 = 0, var_581_10 - 1 do
					local var_581_11 = var_581_8:GetChild(iter_581_4)

					if var_581_11.name == "" or not string.find(var_581_11.name, "split") then
						var_581_11.gameObject:SetActive(true)
					else
						var_581_11.gameObject:SetActive(false)
					end
				end
			end

			local var_581_12 = 0.001

			if var_581_9 <= arg_578_1.time_ and arg_578_1.time_ < var_581_9 + var_581_12 then
				local var_581_13 = (arg_578_1.time_ - var_581_9) / var_581_12
				local var_581_14 = Vector3.New(-50, -345, -345)

				var_581_8.localPosition = Vector3.Lerp(arg_578_1.var_.moveOldPos1083, var_581_14, var_581_13)
			end

			if arg_578_1.time_ >= var_581_9 + var_581_12 and arg_578_1.time_ < var_581_9 + var_581_12 + arg_581_0 then
				var_581_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_581_15 = 0
			local var_581_16 = 0.575

			if var_581_15 < arg_578_1.time_ and arg_578_1.time_ <= var_581_15 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				local var_581_17 = arg_578_1:FormatText(StoryNameCfg[36].name)

				arg_578_1.leftNameTxt_.text = var_581_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_18 = arg_578_1:GetWordFromCfg(423011139)
				local var_581_19 = arg_578_1:FormatText(var_581_18.content)

				arg_578_1.text_.text = var_581_19

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_20 = 23
				local var_581_21 = utf8.len(var_581_19)
				local var_581_22 = var_581_20 <= 0 and var_581_16 or var_581_16 * (var_581_21 / var_581_20)

				if var_581_22 > 0 and var_581_16 < var_581_22 then
					arg_578_1.talkMaxDuration = var_581_22

					if var_581_22 + var_581_15 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_22 + var_581_15
					end
				end

				arg_578_1.text_.text = var_581_19
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011139", "story_v_out_423011.awb") ~= 0 then
					local var_581_23 = manager.audio:GetVoiceLength("story_v_out_423011", "423011139", "story_v_out_423011.awb") / 1000

					if var_581_23 + var_581_15 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_23 + var_581_15
					end

					if var_581_18.prefab_name ~= "" and arg_578_1.actors_[var_581_18.prefab_name] ~= nil then
						local var_581_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_18.prefab_name].transform, "story_v_out_423011", "423011139", "story_v_out_423011.awb")

						arg_578_1:RecordAudio("423011139", var_581_24)
						arg_578_1:RecordAudio("423011139", var_581_24)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_out_423011", "423011139", "story_v_out_423011.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_out_423011", "423011139", "story_v_out_423011.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_25 = math.max(var_581_16, arg_578_1.talkMaxDuration)

			if var_581_15 <= arg_578_1.time_ and arg_578_1.time_ < var_581_15 + var_581_25 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_15) / var_581_25

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_15 + var_581_25 and arg_578_1.time_ < var_581_15 + var_581_25 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {
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

		arg_578_1:InitPlayNodeList()
	end,
	Play423011140 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 423011140
		arg_582_1.duration_ = 5

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play423011141(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = arg_582_1.actors_["1083"]
			local var_585_1 = 0

			if var_585_1 < arg_582_1.time_ and arg_582_1.time_ <= var_585_1 + arg_585_0 and not isNil(var_585_0) and arg_582_1.var_.actorSpriteComps1083 == nil then
				arg_582_1.var_.actorSpriteComps1083 = var_585_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_585_2 = 0.2

			if var_585_1 <= arg_582_1.time_ and arg_582_1.time_ < var_585_1 + var_585_2 and not isNil(var_585_0) then
				local var_585_3 = (arg_582_1.time_ - var_585_1) / var_585_2

				if arg_582_1.var_.actorSpriteComps1083 then
					for iter_585_0, iter_585_1 in pairs(arg_582_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_585_1 then
							if arg_582_1.isInRecall_ then
								local var_585_4 = Mathf.Lerp(iter_585_1.color.r, arg_582_1.hightColor2.r, var_585_3)
								local var_585_5 = Mathf.Lerp(iter_585_1.color.g, arg_582_1.hightColor2.g, var_585_3)
								local var_585_6 = Mathf.Lerp(iter_585_1.color.b, arg_582_1.hightColor2.b, var_585_3)

								iter_585_1.color = Color.New(var_585_4, var_585_5, var_585_6)
							else
								local var_585_7 = Mathf.Lerp(iter_585_1.color.r, 0.5, var_585_3)

								iter_585_1.color = Color.New(var_585_7, var_585_7, var_585_7)
							end
						end
					end
				end
			end

			if arg_582_1.time_ >= var_585_1 + var_585_2 and arg_582_1.time_ < var_585_1 + var_585_2 + arg_585_0 and not isNil(var_585_0) and arg_582_1.var_.actorSpriteComps1083 then
				for iter_585_2, iter_585_3 in pairs(arg_582_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_585_3 then
						if arg_582_1.isInRecall_ then
							iter_585_3.color = arg_582_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_585_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_582_1.var_.actorSpriteComps1083 = nil
			end

			local var_585_8 = 0
			local var_585_9 = 0.35

			if var_585_8 < arg_582_1.time_ and arg_582_1.time_ <= var_585_8 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				local var_585_10 = arg_582_1:FormatText(StoryNameCfg[7].name)

				arg_582_1.leftNameTxt_.text = var_585_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, true)
				arg_582_1.iconController_:SetSelectedState("hero")

				arg_582_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_582_1.callingController_:SetSelectedState("normal")

				arg_582_1.keyicon_.color = Color.New(1, 1, 1)
				arg_582_1.icon_.color = Color.New(1, 1, 1)

				local var_585_11 = arg_582_1:GetWordFromCfg(423011140)
				local var_585_12 = arg_582_1:FormatText(var_585_11.content)

				arg_582_1.text_.text = var_585_12

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_13 = 14
				local var_585_14 = utf8.len(var_585_12)
				local var_585_15 = var_585_13 <= 0 and var_585_9 or var_585_9 * (var_585_14 / var_585_13)

				if var_585_15 > 0 and var_585_9 < var_585_15 then
					arg_582_1.talkMaxDuration = var_585_15

					if var_585_15 + var_585_8 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_15 + var_585_8
					end
				end

				arg_582_1.text_.text = var_585_12
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)
				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_16 = math.max(var_585_9, arg_582_1.talkMaxDuration)

			if var_585_8 <= arg_582_1.time_ and arg_582_1.time_ < var_585_8 + var_585_16 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_8) / var_585_16

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_8 + var_585_16 and arg_582_1.time_ < var_585_8 + var_585_16 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play423011141 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 423011141
		arg_586_1.duration_ = 5.8

		local var_586_0 = {
			zh = 5.8,
			ja = 4.9
		}
		local var_586_1 = manager.audio:GetLocalizationFlag()

		if var_586_0[var_586_1] ~= nil then
			arg_586_1.duration_ = var_586_0[var_586_1]
		end

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play423011142(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = arg_586_1.actors_["1083"]
			local var_589_1 = 0

			if var_589_1 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.actorSpriteComps1083 == nil then
				arg_586_1.var_.actorSpriteComps1083 = var_589_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_589_2 = 0.2

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_2 and not isNil(var_589_0) then
				local var_589_3 = (arg_586_1.time_ - var_589_1) / var_589_2

				if arg_586_1.var_.actorSpriteComps1083 then
					for iter_589_0, iter_589_1 in pairs(arg_586_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_589_1 then
							if arg_586_1.isInRecall_ then
								local var_589_4 = Mathf.Lerp(iter_589_1.color.r, arg_586_1.hightColor1.r, var_589_3)
								local var_589_5 = Mathf.Lerp(iter_589_1.color.g, arg_586_1.hightColor1.g, var_589_3)
								local var_589_6 = Mathf.Lerp(iter_589_1.color.b, arg_586_1.hightColor1.b, var_589_3)

								iter_589_1.color = Color.New(var_589_4, var_589_5, var_589_6)
							else
								local var_589_7 = Mathf.Lerp(iter_589_1.color.r, 1, var_589_3)

								iter_589_1.color = Color.New(var_589_7, var_589_7, var_589_7)
							end
						end
					end
				end
			end

			if arg_586_1.time_ >= var_589_1 + var_589_2 and arg_586_1.time_ < var_589_1 + var_589_2 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.actorSpriteComps1083 then
				for iter_589_2, iter_589_3 in pairs(arg_586_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_589_3 then
						if arg_586_1.isInRecall_ then
							iter_589_3.color = arg_586_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_589_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_586_1.var_.actorSpriteComps1083 = nil
			end

			local var_589_8 = arg_586_1.actors_["1083"].transform
			local var_589_9 = 0

			if var_589_9 < arg_586_1.time_ and arg_586_1.time_ <= var_589_9 + arg_589_0 then
				arg_586_1.var_.moveOldPos1083 = var_589_8.localPosition
				var_589_8.localScale = Vector3.New(1, 1, 1)

				arg_586_1:CheckSpriteTmpPos("1083", 3)

				local var_589_10 = var_589_8.childCount

				for iter_589_4 = 0, var_589_10 - 1 do
					local var_589_11 = var_589_8:GetChild(iter_589_4)

					if var_589_11.name == "" or not string.find(var_589_11.name, "split") then
						var_589_11.gameObject:SetActive(true)
					else
						var_589_11.gameObject:SetActive(false)
					end
				end
			end

			local var_589_12 = 0.001

			if var_589_9 <= arg_586_1.time_ and arg_586_1.time_ < var_589_9 + var_589_12 then
				local var_589_13 = (arg_586_1.time_ - var_589_9) / var_589_12
				local var_589_14 = Vector3.New(-50, -345, -345)

				var_589_8.localPosition = Vector3.Lerp(arg_586_1.var_.moveOldPos1083, var_589_14, var_589_13)
			end

			if arg_586_1.time_ >= var_589_9 + var_589_12 and arg_586_1.time_ < var_589_9 + var_589_12 + arg_589_0 then
				var_589_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_589_15 = 0
			local var_589_16 = 0.625

			if var_589_15 < arg_586_1.time_ and arg_586_1.time_ <= var_589_15 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, true)

				local var_589_17 = arg_586_1:FormatText(StoryNameCfg[36].name)

				arg_586_1.leftNameTxt_.text = var_589_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_586_1.leftNameTxt_.transform)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1.leftNameTxt_.text)
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_18 = arg_586_1:GetWordFromCfg(423011141)
				local var_589_19 = arg_586_1:FormatText(var_589_18.content)

				arg_586_1.text_.text = var_589_19

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_20 = 25
				local var_589_21 = utf8.len(var_589_19)
				local var_589_22 = var_589_20 <= 0 and var_589_16 or var_589_16 * (var_589_21 / var_589_20)

				if var_589_22 > 0 and var_589_16 < var_589_22 then
					arg_586_1.talkMaxDuration = var_589_22

					if var_589_22 + var_589_15 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_22 + var_589_15
					end
				end

				arg_586_1.text_.text = var_589_19
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011141", "story_v_out_423011.awb") ~= 0 then
					local var_589_23 = manager.audio:GetVoiceLength("story_v_out_423011", "423011141", "story_v_out_423011.awb") / 1000

					if var_589_23 + var_589_15 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_23 + var_589_15
					end

					if var_589_18.prefab_name ~= "" and arg_586_1.actors_[var_589_18.prefab_name] ~= nil then
						local var_589_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_586_1.actors_[var_589_18.prefab_name].transform, "story_v_out_423011", "423011141", "story_v_out_423011.awb")

						arg_586_1:RecordAudio("423011141", var_589_24)
						arg_586_1:RecordAudio("423011141", var_589_24)
					else
						arg_586_1:AudioAction("play", "voice", "story_v_out_423011", "423011141", "story_v_out_423011.awb")
					end

					arg_586_1:RecordHistoryTalkVoice("story_v_out_423011", "423011141", "story_v_out_423011.awb")
				end

				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_25 = math.max(var_589_16, arg_586_1.talkMaxDuration)

			if var_589_15 <= arg_586_1.time_ and arg_586_1.time_ < var_589_15 + var_589_25 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_15) / var_589_25

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_15 + var_589_25 and arg_586_1.time_ < var_589_15 + var_589_25 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {
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

		arg_586_1:InitPlayNodeList()
	end,
	Play423011142 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 423011142
		arg_590_1.duration_ = 4.23

		local var_590_0 = {
			zh = 2.733,
			ja = 4.233
		}
		local var_590_1 = manager.audio:GetLocalizationFlag()

		if var_590_0[var_590_1] ~= nil then
			arg_590_1.duration_ = var_590_0[var_590_1]
		end

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play423011143(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = arg_590_1.actors_["1083"].transform
			local var_593_1 = 0

			if var_593_1 < arg_590_1.time_ and arg_590_1.time_ <= var_593_1 + arg_593_0 then
				arg_590_1.var_.moveOldPos1083 = var_593_0.localPosition
				var_593_0.localScale = Vector3.New(1, 1, 1)

				arg_590_1:CheckSpriteTmpPos("1083", 3)

				local var_593_2 = var_593_0.childCount

				for iter_593_0 = 0, var_593_2 - 1 do
					local var_593_3 = var_593_0:GetChild(iter_593_0)

					if var_593_3.name == "" or not string.find(var_593_3.name, "split") then
						var_593_3.gameObject:SetActive(true)
					else
						var_593_3.gameObject:SetActive(false)
					end
				end
			end

			local var_593_4 = 0.001

			if var_593_1 <= arg_590_1.time_ and arg_590_1.time_ < var_593_1 + var_593_4 then
				local var_593_5 = (arg_590_1.time_ - var_593_1) / var_593_4
				local var_593_6 = Vector3.New(-50, -345, -345)

				var_593_0.localPosition = Vector3.Lerp(arg_590_1.var_.moveOldPos1083, var_593_6, var_593_5)
			end

			if arg_590_1.time_ >= var_593_1 + var_593_4 and arg_590_1.time_ < var_593_1 + var_593_4 + arg_593_0 then
				var_593_0.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_593_7 = 0
			local var_593_8 = 0.35

			if var_593_7 < arg_590_1.time_ and arg_590_1.time_ <= var_593_7 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, true)

				local var_593_9 = arg_590_1:FormatText(StoryNameCfg[36].name)

				arg_590_1.leftNameTxt_.text = var_593_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_590_1.leftNameTxt_.transform)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1.leftNameTxt_.text)
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_10 = arg_590_1:GetWordFromCfg(423011142)
				local var_593_11 = arg_590_1:FormatText(var_593_10.content)

				arg_590_1.text_.text = var_593_11

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_12 = 14
				local var_593_13 = utf8.len(var_593_11)
				local var_593_14 = var_593_12 <= 0 and var_593_8 or var_593_8 * (var_593_13 / var_593_12)

				if var_593_14 > 0 and var_593_8 < var_593_14 then
					arg_590_1.talkMaxDuration = var_593_14

					if var_593_14 + var_593_7 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_14 + var_593_7
					end
				end

				arg_590_1.text_.text = var_593_11
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011142", "story_v_out_423011.awb") ~= 0 then
					local var_593_15 = manager.audio:GetVoiceLength("story_v_out_423011", "423011142", "story_v_out_423011.awb") / 1000

					if var_593_15 + var_593_7 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_15 + var_593_7
					end

					if var_593_10.prefab_name ~= "" and arg_590_1.actors_[var_593_10.prefab_name] ~= nil then
						local var_593_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_590_1.actors_[var_593_10.prefab_name].transform, "story_v_out_423011", "423011142", "story_v_out_423011.awb")

						arg_590_1:RecordAudio("423011142", var_593_16)
						arg_590_1:RecordAudio("423011142", var_593_16)
					else
						arg_590_1:AudioAction("play", "voice", "story_v_out_423011", "423011142", "story_v_out_423011.awb")
					end

					arg_590_1:RecordHistoryTalkVoice("story_v_out_423011", "423011142", "story_v_out_423011.awb")
				end

				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_17 = math.max(var_593_8, arg_590_1.talkMaxDuration)

			if var_593_7 <= arg_590_1.time_ and arg_590_1.time_ < var_593_7 + var_593_17 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_7) / var_593_17

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_7 + var_593_17 and arg_590_1.time_ < var_593_7 + var_593_17 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {
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

		arg_590_1:InitPlayNodeList()
	end,
	Play423011143 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 423011143
		arg_594_1.duration_ = 5

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play423011144(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = arg_594_1.actors_["1083"]
			local var_597_1 = 0

			if var_597_1 < arg_594_1.time_ and arg_594_1.time_ <= var_597_1 + arg_597_0 and not isNil(var_597_0) and arg_594_1.var_.actorSpriteComps1083 == nil then
				arg_594_1.var_.actorSpriteComps1083 = var_597_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_597_2 = 0.2

			if var_597_1 <= arg_594_1.time_ and arg_594_1.time_ < var_597_1 + var_597_2 and not isNil(var_597_0) then
				local var_597_3 = (arg_594_1.time_ - var_597_1) / var_597_2

				if arg_594_1.var_.actorSpriteComps1083 then
					for iter_597_0, iter_597_1 in pairs(arg_594_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_597_1 then
							if arg_594_1.isInRecall_ then
								local var_597_4 = Mathf.Lerp(iter_597_1.color.r, arg_594_1.hightColor2.r, var_597_3)
								local var_597_5 = Mathf.Lerp(iter_597_1.color.g, arg_594_1.hightColor2.g, var_597_3)
								local var_597_6 = Mathf.Lerp(iter_597_1.color.b, arg_594_1.hightColor2.b, var_597_3)

								iter_597_1.color = Color.New(var_597_4, var_597_5, var_597_6)
							else
								local var_597_7 = Mathf.Lerp(iter_597_1.color.r, 0.5, var_597_3)

								iter_597_1.color = Color.New(var_597_7, var_597_7, var_597_7)
							end
						end
					end
				end
			end

			if arg_594_1.time_ >= var_597_1 + var_597_2 and arg_594_1.time_ < var_597_1 + var_597_2 + arg_597_0 and not isNil(var_597_0) and arg_594_1.var_.actorSpriteComps1083 then
				for iter_597_2, iter_597_3 in pairs(arg_594_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_597_3 then
						if arg_594_1.isInRecall_ then
							iter_597_3.color = arg_594_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_597_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_594_1.var_.actorSpriteComps1083 = nil
			end

			local var_597_8 = arg_594_1.actors_["1083"].transform
			local var_597_9 = 0

			if var_597_9 < arg_594_1.time_ and arg_594_1.time_ <= var_597_9 + arg_597_0 then
				arg_594_1.var_.moveOldPos1083 = var_597_8.localPosition
				var_597_8.localScale = Vector3.New(1, 1, 1)

				arg_594_1:CheckSpriteTmpPos("1083", 7)

				local var_597_10 = var_597_8.childCount

				for iter_597_4 = 0, var_597_10 - 1 do
					local var_597_11 = var_597_8:GetChild(iter_597_4)

					if var_597_11.name == "" or not string.find(var_597_11.name, "split") then
						var_597_11.gameObject:SetActive(true)
					else
						var_597_11.gameObject:SetActive(false)
					end
				end
			end

			local var_597_12 = 0.001

			if var_597_9 <= arg_594_1.time_ and arg_594_1.time_ < var_597_9 + var_597_12 then
				local var_597_13 = (arg_594_1.time_ - var_597_9) / var_597_12
				local var_597_14 = Vector3.New(0, -2000, 0)

				var_597_8.localPosition = Vector3.Lerp(arg_594_1.var_.moveOldPos1083, var_597_14, var_597_13)
			end

			if arg_594_1.time_ >= var_597_9 + var_597_12 and arg_594_1.time_ < var_597_9 + var_597_12 + arg_597_0 then
				var_597_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_597_15 = 0
			local var_597_16 = 1.45

			if var_597_15 < arg_594_1.time_ and arg_594_1.time_ <= var_597_15 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, false)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_17 = arg_594_1:GetWordFromCfg(423011143)
				local var_597_18 = arg_594_1:FormatText(var_597_17.content)

				arg_594_1.text_.text = var_597_18

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_19 = 58
				local var_597_20 = utf8.len(var_597_18)
				local var_597_21 = var_597_19 <= 0 and var_597_16 or var_597_16 * (var_597_20 / var_597_19)

				if var_597_21 > 0 and var_597_16 < var_597_21 then
					arg_594_1.talkMaxDuration = var_597_21

					if var_597_21 + var_597_15 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_21 + var_597_15
					end
				end

				arg_594_1.text_.text = var_597_18
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)
				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_22 = math.max(var_597_16, arg_594_1.talkMaxDuration)

			if var_597_15 <= arg_594_1.time_ and arg_594_1.time_ < var_597_15 + var_597_22 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_15) / var_597_22

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_15 + var_597_22 and arg_594_1.time_ < var_597_15 + var_597_22 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {
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

		arg_594_1:InitPlayNodeList()
	end,
	Play423011144 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 423011144
		arg_598_1.duration_ = 13.57

		local var_598_0 = {
			zh = 11.166,
			ja = 13.566
		}
		local var_598_1 = manager.audio:GetLocalizationFlag()

		if var_598_0[var_598_1] ~= nil then
			arg_598_1.duration_ = var_598_0[var_598_1]
		end

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play423011145(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			local var_601_0 = "I24f"

			if arg_598_1.bgs_[var_601_0] == nil then
				local var_601_1 = Object.Instantiate(arg_598_1.paintGo_)

				var_601_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_601_0)
				var_601_1.name = var_601_0
				var_601_1.transform.parent = arg_598_1.stage_.transform
				var_601_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_598_1.bgs_[var_601_0] = var_601_1
			end

			local var_601_2 = 2

			if var_601_2 < arg_598_1.time_ and arg_598_1.time_ <= var_601_2 + arg_601_0 then
				local var_601_3 = manager.ui.mainCamera.transform.localPosition
				local var_601_4 = Vector3.New(0, 0, 10) + Vector3.New(var_601_3.x, var_601_3.y, 0)
				local var_601_5 = arg_598_1.bgs_.I24f

				var_601_5.transform.localPosition = var_601_4
				var_601_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_601_6 = var_601_5:GetComponent("SpriteRenderer")

				if var_601_6 and var_601_6.sprite then
					local var_601_7 = (var_601_5.transform.localPosition - var_601_3).z
					local var_601_8 = manager.ui.mainCameraCom_
					local var_601_9 = 2 * var_601_7 * Mathf.Tan(var_601_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_601_10 = var_601_9 * var_601_8.aspect
					local var_601_11 = var_601_6.sprite.bounds.size.x
					local var_601_12 = var_601_6.sprite.bounds.size.y
					local var_601_13 = var_601_10 / var_601_11
					local var_601_14 = var_601_9 / var_601_12
					local var_601_15 = var_601_14 < var_601_13 and var_601_13 or var_601_14

					var_601_5.transform.localScale = Vector3.New(var_601_15, var_601_15, 0)
				end

				for iter_601_0, iter_601_1 in pairs(arg_598_1.bgs_) do
					if iter_601_0 ~= "I24f" then
						iter_601_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_601_16 = 4

			if var_601_16 < arg_598_1.time_ and arg_598_1.time_ <= var_601_16 + arg_601_0 then
				arg_598_1.allBtn_.enabled = false
			end

			local var_601_17 = 0.3

			if arg_598_1.time_ >= var_601_16 + var_601_17 and arg_598_1.time_ < var_601_16 + var_601_17 + arg_601_0 then
				arg_598_1.allBtn_.enabled = true
			end

			local var_601_18 = 0

			if var_601_18 < arg_598_1.time_ and arg_598_1.time_ <= var_601_18 + arg_601_0 then
				arg_598_1.mask_.enabled = true
				arg_598_1.mask_.raycastTarget = true

				arg_598_1:SetGaussion(false)
			end

			local var_601_19 = 2

			if var_601_18 <= arg_598_1.time_ and arg_598_1.time_ < var_601_18 + var_601_19 then
				local var_601_20 = (arg_598_1.time_ - var_601_18) / var_601_19
				local var_601_21 = Color.New(0, 0, 0)

				var_601_21.a = Mathf.Lerp(0, 1, var_601_20)
				arg_598_1.mask_.color = var_601_21
			end

			if arg_598_1.time_ >= var_601_18 + var_601_19 and arg_598_1.time_ < var_601_18 + var_601_19 + arg_601_0 then
				local var_601_22 = Color.New(0, 0, 0)

				var_601_22.a = 1
				arg_598_1.mask_.color = var_601_22
			end

			local var_601_23 = 2

			if var_601_23 < arg_598_1.time_ and arg_598_1.time_ <= var_601_23 + arg_601_0 then
				arg_598_1.mask_.enabled = true
				arg_598_1.mask_.raycastTarget = true

				arg_598_1:SetGaussion(false)
			end

			local var_601_24 = 2

			if var_601_23 <= arg_598_1.time_ and arg_598_1.time_ < var_601_23 + var_601_24 then
				local var_601_25 = (arg_598_1.time_ - var_601_23) / var_601_24
				local var_601_26 = Color.New(0, 0, 0)

				var_601_26.a = Mathf.Lerp(1, 0, var_601_25)
				arg_598_1.mask_.color = var_601_26
			end

			if arg_598_1.time_ >= var_601_23 + var_601_24 and arg_598_1.time_ < var_601_23 + var_601_24 + arg_601_0 then
				local var_601_27 = Color.New(0, 0, 0)
				local var_601_28 = 0

				arg_598_1.mask_.enabled = false
				var_601_27.a = var_601_28
				arg_598_1.mask_.color = var_601_27
			end

			local var_601_29 = arg_598_1.actors_["1083"]
			local var_601_30 = 3.8

			if var_601_30 < arg_598_1.time_ and arg_598_1.time_ <= var_601_30 + arg_601_0 and not isNil(var_601_29) and arg_598_1.var_.actorSpriteComps1083 == nil then
				arg_598_1.var_.actorSpriteComps1083 = var_601_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_601_31 = 0.2

			if var_601_30 <= arg_598_1.time_ and arg_598_1.time_ < var_601_30 + var_601_31 and not isNil(var_601_29) then
				local var_601_32 = (arg_598_1.time_ - var_601_30) / var_601_31

				if arg_598_1.var_.actorSpriteComps1083 then
					for iter_601_2, iter_601_3 in pairs(arg_598_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_601_3 then
							if arg_598_1.isInRecall_ then
								local var_601_33 = Mathf.Lerp(iter_601_3.color.r, arg_598_1.hightColor1.r, var_601_32)
								local var_601_34 = Mathf.Lerp(iter_601_3.color.g, arg_598_1.hightColor1.g, var_601_32)
								local var_601_35 = Mathf.Lerp(iter_601_3.color.b, arg_598_1.hightColor1.b, var_601_32)

								iter_601_3.color = Color.New(var_601_33, var_601_34, var_601_35)
							else
								local var_601_36 = Mathf.Lerp(iter_601_3.color.r, 1, var_601_32)

								iter_601_3.color = Color.New(var_601_36, var_601_36, var_601_36)
							end
						end
					end
				end
			end

			if arg_598_1.time_ >= var_601_30 + var_601_31 and arg_598_1.time_ < var_601_30 + var_601_31 + arg_601_0 and not isNil(var_601_29) and arg_598_1.var_.actorSpriteComps1083 then
				for iter_601_4, iter_601_5 in pairs(arg_598_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_601_5 then
						if arg_598_1.isInRecall_ then
							iter_601_5.color = arg_598_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_601_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_598_1.var_.actorSpriteComps1083 = nil
			end

			local var_601_37 = arg_598_1.actors_["1083"].transform
			local var_601_38 = 3.8

			if var_601_38 < arg_598_1.time_ and arg_598_1.time_ <= var_601_38 + arg_601_0 then
				arg_598_1.var_.moveOldPos1083 = var_601_37.localPosition
				var_601_37.localScale = Vector3.New(1, 1, 1)

				arg_598_1:CheckSpriteTmpPos("1083", 3)

				local var_601_39 = var_601_37.childCount

				for iter_601_6 = 0, var_601_39 - 1 do
					local var_601_40 = var_601_37:GetChild(iter_601_6)

					if var_601_40.name == "" or not string.find(var_601_40.name, "split") then
						var_601_40.gameObject:SetActive(true)
					else
						var_601_40.gameObject:SetActive(false)
					end
				end
			end

			local var_601_41 = 0.001

			if var_601_38 <= arg_598_1.time_ and arg_598_1.time_ < var_601_38 + var_601_41 then
				local var_601_42 = (arg_598_1.time_ - var_601_38) / var_601_41
				local var_601_43 = Vector3.New(-50, -345, -345)

				var_601_37.localPosition = Vector3.Lerp(arg_598_1.var_.moveOldPos1083, var_601_43, var_601_42)
			end

			if arg_598_1.time_ >= var_601_38 + var_601_41 and arg_598_1.time_ < var_601_38 + var_601_41 + arg_601_0 then
				var_601_37.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_601_44 = 0.4
			local var_601_45 = 1

			if var_601_44 < arg_598_1.time_ and arg_598_1.time_ <= var_601_44 + arg_601_0 then
				local var_601_46 = "stop"
				local var_601_47 = "effect"

				arg_598_1:AudioAction(var_601_46, var_601_47, "se_story_144", "se_story_144_amb_town_wind_loop", "")
			end

			local var_601_48 = 1.53333333333333
			local var_601_49 = 1

			if var_601_48 < arg_598_1.time_ and arg_598_1.time_ <= var_601_48 + arg_601_0 then
				local var_601_50 = "play"
				local var_601_51 = "effect"

				arg_598_1:AudioAction(var_601_50, var_601_51, "se_story_144", "se_story_144_amb_train_roof", "")
			end

			local var_601_52 = manager.ui.mainCamera.transform
			local var_601_53 = 2

			if var_601_53 < arg_598_1.time_ and arg_598_1.time_ <= var_601_53 + arg_601_0 then
				local var_601_54 = arg_598_1.var_.effectcangmendakai

				if var_601_54 then
					Object.Destroy(var_601_54)

					arg_598_1.var_.effectcangmendakai = nil
				end
			end

			local var_601_55 = manager.ui.mainCamera.transform
			local var_601_56 = 2

			if var_601_56 < arg_598_1.time_ and arg_598_1.time_ <= var_601_56 + arg_601_0 then
				local var_601_57 = arg_598_1.var_.effectchedingsudu1
				local var_601_58
				local var_601_59 = var_601_55

				if not var_601_57 then
					var_601_57 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_601_59)
					var_601_57.name = "chedingsudu1"
					arg_598_1.var_.effectchedingsudu1 = var_601_57
				else
					var_601_57.transform:SetParent(var_601_59)
				end

				var_601_57.transform.localPosition = Vector3.New(0, 0, -4)
				var_601_57.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_598_1.frameCnt_ <= 1 then
				arg_598_1.dialog_:SetActive(false)
			end

			local var_601_60 = 4
			local var_601_61 = 0.7

			if var_601_60 < arg_598_1.time_ and arg_598_1.time_ <= var_601_60 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0

				arg_598_1.dialog_:SetActive(true)

				arg_598_1.dialogCg_.alpha = 0

				local var_601_62 = LeanTween.value(arg_598_1.dialog_, 0, 1, 0.3)

				var_601_62:setOnUpdate(LuaHelper.FloatAction(function(arg_602_0)
					arg_598_1.dialogCg_.alpha = arg_602_0
				end))
				var_601_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_598_1.dialog_)
					var_601_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_598_1.duration_ = arg_598_1.duration_ + 0.3

				SetActive(arg_598_1.leftNameGo_, true)

				local var_601_63 = arg_598_1:FormatText(StoryNameCfg[36].name)

				arg_598_1.leftNameTxt_.text = var_601_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_64 = arg_598_1:GetWordFromCfg(423011144)
				local var_601_65 = arg_598_1:FormatText(var_601_64.content)

				arg_598_1.text_.text = var_601_65

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_66 = 28
				local var_601_67 = utf8.len(var_601_65)
				local var_601_68 = var_601_66 <= 0 and var_601_61 or var_601_61 * (var_601_67 / var_601_66)

				if var_601_68 > 0 and var_601_61 < var_601_68 then
					arg_598_1.talkMaxDuration = var_601_68
					var_601_60 = var_601_60 + 0.3

					if var_601_68 + var_601_60 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_68 + var_601_60
					end
				end

				arg_598_1.text_.text = var_601_65
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011144", "story_v_out_423011.awb") ~= 0 then
					local var_601_69 = manager.audio:GetVoiceLength("story_v_out_423011", "423011144", "story_v_out_423011.awb") / 1000

					if var_601_69 + var_601_60 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_69 + var_601_60
					end

					if var_601_64.prefab_name ~= "" and arg_598_1.actors_[var_601_64.prefab_name] ~= nil then
						local var_601_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_64.prefab_name].transform, "story_v_out_423011", "423011144", "story_v_out_423011.awb")

						arg_598_1:RecordAudio("423011144", var_601_70)
						arg_598_1:RecordAudio("423011144", var_601_70)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_out_423011", "423011144", "story_v_out_423011.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_out_423011", "423011144", "story_v_out_423011.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_71 = var_601_60 + 0.3
			local var_601_72 = math.max(var_601_61, arg_598_1.talkMaxDuration)

			if var_601_71 <= arg_598_1.time_ and arg_598_1.time_ < var_601_71 + var_601_72 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_71) / var_601_72

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_71 + var_601_72 and arg_598_1.time_ < var_601_71 + var_601_72 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_598_1:InitPlayNodeList()
	end,
	Play423011145 = function(arg_604_0, arg_604_1)
		arg_604_1.time_ = 0
		arg_604_1.frameCnt_ = 0
		arg_604_1.state_ = "playing"
		arg_604_1.curTalkId_ = 423011145
		arg_604_1.duration_ = 6.6

		local var_604_0 = {
			zh = 4.1,
			ja = 6.6
		}
		local var_604_1 = manager.audio:GetLocalizationFlag()

		if var_604_0[var_604_1] ~= nil then
			arg_604_1.duration_ = var_604_0[var_604_1]
		end

		SetActive(arg_604_1.tipsGo_, false)

		function arg_604_1.onSingleLineFinish_()
			arg_604_1.onSingleLineUpdate_ = nil
			arg_604_1.onSingleLineFinish_ = nil
			arg_604_1.state_ = "waiting"
		end

		function arg_604_1.playNext_(arg_606_0)
			if arg_606_0 == 1 then
				arg_604_0:Play423011146(arg_604_1)
			end
		end

		function arg_604_1.onSingleLineUpdate_(arg_607_0)
			local var_607_0 = arg_604_1.actors_["1083"]
			local var_607_1 = 0

			if var_607_1 < arg_604_1.time_ and arg_604_1.time_ <= var_607_1 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.actorSpriteComps1083 == nil then
				arg_604_1.var_.actorSpriteComps1083 = var_607_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_607_2 = 0.2

			if var_607_1 <= arg_604_1.time_ and arg_604_1.time_ < var_607_1 + var_607_2 and not isNil(var_607_0) then
				local var_607_3 = (arg_604_1.time_ - var_607_1) / var_607_2

				if arg_604_1.var_.actorSpriteComps1083 then
					for iter_607_0, iter_607_1 in pairs(arg_604_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_607_1 then
							if arg_604_1.isInRecall_ then
								local var_607_4 = Mathf.Lerp(iter_607_1.color.r, arg_604_1.hightColor2.r, var_607_3)
								local var_607_5 = Mathf.Lerp(iter_607_1.color.g, arg_604_1.hightColor2.g, var_607_3)
								local var_607_6 = Mathf.Lerp(iter_607_1.color.b, arg_604_1.hightColor2.b, var_607_3)

								iter_607_1.color = Color.New(var_607_4, var_607_5, var_607_6)
							else
								local var_607_7 = Mathf.Lerp(iter_607_1.color.r, 0.5, var_607_3)

								iter_607_1.color = Color.New(var_607_7, var_607_7, var_607_7)
							end
						end
					end
				end
			end

			if arg_604_1.time_ >= var_607_1 + var_607_2 and arg_604_1.time_ < var_607_1 + var_607_2 + arg_607_0 and not isNil(var_607_0) and arg_604_1.var_.actorSpriteComps1083 then
				for iter_607_2, iter_607_3 in pairs(arg_604_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_607_3 then
						if arg_604_1.isInRecall_ then
							iter_607_3.color = arg_604_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_607_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_604_1.var_.actorSpriteComps1083 = nil
			end

			local var_607_8 = 0
			local var_607_9 = 0.575

			if var_607_8 < arg_604_1.time_ and arg_604_1.time_ <= var_607_8 + arg_607_0 then
				arg_604_1.talkMaxDuration = 0
				arg_604_1.dialogCg_.alpha = 1

				arg_604_1.dialog_:SetActive(true)
				SetActive(arg_604_1.leftNameGo_, true)

				local var_607_10 = arg_604_1:FormatText(StoryNameCfg[1328].name)

				arg_604_1.leftNameTxt_.text = var_607_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_604_1.leftNameTxt_.transform)

				arg_604_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_604_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_604_1:RecordName(arg_604_1.leftNameTxt_.text)
				SetActive(arg_604_1.iconTrs_.gameObject, true)
				arg_604_1.iconController_:SetSelectedState("hero")

				arg_604_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2074")

				arg_604_1.callingController_:SetSelectedState("normal")

				arg_604_1.keyicon_.color = Color.New(1, 1, 1)
				arg_604_1.icon_.color = Color.New(1, 1, 1)

				local var_607_11 = arg_604_1:GetWordFromCfg(423011145)
				local var_607_12 = arg_604_1:FormatText(var_607_11.content)

				arg_604_1.text_.text = var_607_12

				LuaForUtil.ClearLinePrefixSymbol(arg_604_1.text_)

				local var_607_13 = 23
				local var_607_14 = utf8.len(var_607_12)
				local var_607_15 = var_607_13 <= 0 and var_607_9 or var_607_9 * (var_607_14 / var_607_13)

				if var_607_15 > 0 and var_607_9 < var_607_15 then
					arg_604_1.talkMaxDuration = var_607_15

					if var_607_15 + var_607_8 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_15 + var_607_8
					end
				end

				arg_604_1.text_.text = var_607_12
				arg_604_1.typewritter.percent = 0

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011145", "story_v_out_423011.awb") ~= 0 then
					local var_607_16 = manager.audio:GetVoiceLength("story_v_out_423011", "423011145", "story_v_out_423011.awb") / 1000

					if var_607_16 + var_607_8 > arg_604_1.duration_ then
						arg_604_1.duration_ = var_607_16 + var_607_8
					end

					if var_607_11.prefab_name ~= "" and arg_604_1.actors_[var_607_11.prefab_name] ~= nil then
						local var_607_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_604_1.actors_[var_607_11.prefab_name].transform, "story_v_out_423011", "423011145", "story_v_out_423011.awb")

						arg_604_1:RecordAudio("423011145", var_607_17)
						arg_604_1:RecordAudio("423011145", var_607_17)
					else
						arg_604_1:AudioAction("play", "voice", "story_v_out_423011", "423011145", "story_v_out_423011.awb")
					end

					arg_604_1:RecordHistoryTalkVoice("story_v_out_423011", "423011145", "story_v_out_423011.awb")
				end

				arg_604_1:RecordContent(arg_604_1.text_.text)
			end

			local var_607_18 = math.max(var_607_9, arg_604_1.talkMaxDuration)

			if var_607_8 <= arg_604_1.time_ and arg_604_1.time_ < var_607_8 + var_607_18 then
				arg_604_1.typewritter.percent = (arg_604_1.time_ - var_607_8) / var_607_18

				arg_604_1.typewritter:SetDirty()
			end

			if arg_604_1.time_ >= var_607_8 + var_607_18 and arg_604_1.time_ < var_607_8 + var_607_18 + arg_607_0 then
				arg_604_1.typewritter.percent = 1

				arg_604_1.typewritter:SetDirty()
				arg_604_1:ShowNextGo(true)
			end
		end

		arg_604_1.nodeConfigList_ = {}

		arg_604_1:InitPlayNodeList()
	end,
	Play423011146 = function(arg_608_0, arg_608_1)
		arg_608_1.time_ = 0
		arg_608_1.frameCnt_ = 0
		arg_608_1.state_ = "playing"
		arg_608_1.curTalkId_ = 423011146
		arg_608_1.duration_ = 4.23

		local var_608_0 = {
			zh = 4.066,
			ja = 4.233
		}
		local var_608_1 = manager.audio:GetLocalizationFlag()

		if var_608_0[var_608_1] ~= nil then
			arg_608_1.duration_ = var_608_0[var_608_1]
		end

		SetActive(arg_608_1.tipsGo_, false)

		function arg_608_1.onSingleLineFinish_()
			arg_608_1.onSingleLineUpdate_ = nil
			arg_608_1.onSingleLineFinish_ = nil
			arg_608_1.state_ = "waiting"
		end

		function arg_608_1.playNext_(arg_610_0)
			if arg_610_0 == 1 then
				arg_608_0:Play423011147(arg_608_1)
			end
		end

		function arg_608_1.onSingleLineUpdate_(arg_611_0)
			local var_611_0 = arg_608_1.actors_["1083"]
			local var_611_1 = 0

			if var_611_1 < arg_608_1.time_ and arg_608_1.time_ <= var_611_1 + arg_611_0 and not isNil(var_611_0) and arg_608_1.var_.actorSpriteComps1083 == nil then
				arg_608_1.var_.actorSpriteComps1083 = var_611_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_611_2 = 0.2

			if var_611_1 <= arg_608_1.time_ and arg_608_1.time_ < var_611_1 + var_611_2 and not isNil(var_611_0) then
				local var_611_3 = (arg_608_1.time_ - var_611_1) / var_611_2

				if arg_608_1.var_.actorSpriteComps1083 then
					for iter_611_0, iter_611_1 in pairs(arg_608_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_611_1 then
							if arg_608_1.isInRecall_ then
								local var_611_4 = Mathf.Lerp(iter_611_1.color.r, arg_608_1.hightColor1.r, var_611_3)
								local var_611_5 = Mathf.Lerp(iter_611_1.color.g, arg_608_1.hightColor1.g, var_611_3)
								local var_611_6 = Mathf.Lerp(iter_611_1.color.b, arg_608_1.hightColor1.b, var_611_3)

								iter_611_1.color = Color.New(var_611_4, var_611_5, var_611_6)
							else
								local var_611_7 = Mathf.Lerp(iter_611_1.color.r, 1, var_611_3)

								iter_611_1.color = Color.New(var_611_7, var_611_7, var_611_7)
							end
						end
					end
				end
			end

			if arg_608_1.time_ >= var_611_1 + var_611_2 and arg_608_1.time_ < var_611_1 + var_611_2 + arg_611_0 and not isNil(var_611_0) and arg_608_1.var_.actorSpriteComps1083 then
				for iter_611_2, iter_611_3 in pairs(arg_608_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_611_3 then
						if arg_608_1.isInRecall_ then
							iter_611_3.color = arg_608_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_611_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_608_1.var_.actorSpriteComps1083 = nil
			end

			local var_611_8 = arg_608_1.actors_["1083"].transform
			local var_611_9 = 0

			if var_611_9 < arg_608_1.time_ and arg_608_1.time_ <= var_611_9 + arg_611_0 then
				arg_608_1.var_.moveOldPos1083 = var_611_8.localPosition
				var_611_8.localScale = Vector3.New(1, 1, 1)

				arg_608_1:CheckSpriteTmpPos("1083", 3)

				local var_611_10 = var_611_8.childCount

				for iter_611_4 = 0, var_611_10 - 1 do
					local var_611_11 = var_611_8:GetChild(iter_611_4)

					if var_611_11.name == "split_7" or not string.find(var_611_11.name, "split") then
						var_611_11.gameObject:SetActive(true)
					else
						var_611_11.gameObject:SetActive(false)
					end
				end
			end

			local var_611_12 = 0.001

			if var_611_9 <= arg_608_1.time_ and arg_608_1.time_ < var_611_9 + var_611_12 then
				local var_611_13 = (arg_608_1.time_ - var_611_9) / var_611_12
				local var_611_14 = Vector3.New(-50, -345, -345)

				var_611_8.localPosition = Vector3.Lerp(arg_608_1.var_.moveOldPos1083, var_611_14, var_611_13)
			end

			if arg_608_1.time_ >= var_611_9 + var_611_12 and arg_608_1.time_ < var_611_9 + var_611_12 + arg_611_0 then
				var_611_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_611_15 = 0
			local var_611_16 = 0.475

			if var_611_15 < arg_608_1.time_ and arg_608_1.time_ <= var_611_15 + arg_611_0 then
				arg_608_1.talkMaxDuration = 0
				arg_608_1.dialogCg_.alpha = 1

				arg_608_1.dialog_:SetActive(true)
				SetActive(arg_608_1.leftNameGo_, true)

				local var_611_17 = arg_608_1:FormatText(StoryNameCfg[36].name)

				arg_608_1.leftNameTxt_.text = var_611_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_608_1.leftNameTxt_.transform)

				arg_608_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_608_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_608_1:RecordName(arg_608_1.leftNameTxt_.text)
				SetActive(arg_608_1.iconTrs_.gameObject, false)
				arg_608_1.callingController_:SetSelectedState("normal")

				local var_611_18 = arg_608_1:GetWordFromCfg(423011146)
				local var_611_19 = arg_608_1:FormatText(var_611_18.content)

				arg_608_1.text_.text = var_611_19

				LuaForUtil.ClearLinePrefixSymbol(arg_608_1.text_)

				local var_611_20 = 19
				local var_611_21 = utf8.len(var_611_19)
				local var_611_22 = var_611_20 <= 0 and var_611_16 or var_611_16 * (var_611_21 / var_611_20)

				if var_611_22 > 0 and var_611_16 < var_611_22 then
					arg_608_1.talkMaxDuration = var_611_22

					if var_611_22 + var_611_15 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_22 + var_611_15
					end
				end

				arg_608_1.text_.text = var_611_19
				arg_608_1.typewritter.percent = 0

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011146", "story_v_out_423011.awb") ~= 0 then
					local var_611_23 = manager.audio:GetVoiceLength("story_v_out_423011", "423011146", "story_v_out_423011.awb") / 1000

					if var_611_23 + var_611_15 > arg_608_1.duration_ then
						arg_608_1.duration_ = var_611_23 + var_611_15
					end

					if var_611_18.prefab_name ~= "" and arg_608_1.actors_[var_611_18.prefab_name] ~= nil then
						local var_611_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_608_1.actors_[var_611_18.prefab_name].transform, "story_v_out_423011", "423011146", "story_v_out_423011.awb")

						arg_608_1:RecordAudio("423011146", var_611_24)
						arg_608_1:RecordAudio("423011146", var_611_24)
					else
						arg_608_1:AudioAction("play", "voice", "story_v_out_423011", "423011146", "story_v_out_423011.awb")
					end

					arg_608_1:RecordHistoryTalkVoice("story_v_out_423011", "423011146", "story_v_out_423011.awb")
				end

				arg_608_1:RecordContent(arg_608_1.text_.text)
			end

			local var_611_25 = math.max(var_611_16, arg_608_1.talkMaxDuration)

			if var_611_15 <= arg_608_1.time_ and arg_608_1.time_ < var_611_15 + var_611_25 then
				arg_608_1.typewritter.percent = (arg_608_1.time_ - var_611_15) / var_611_25

				arg_608_1.typewritter:SetDirty()
			end

			if arg_608_1.time_ >= var_611_15 + var_611_25 and arg_608_1.time_ < var_611_15 + var_611_25 + arg_611_0 then
				arg_608_1.typewritter.percent = 1

				arg_608_1.typewritter:SetDirty()
				arg_608_1:ShowNextGo(true)
			end
		end

		arg_608_1.nodeConfigList_ = {
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

		arg_608_1:InitPlayNodeList()
	end,
	Play423011147 = function(arg_612_0, arg_612_1)
		arg_612_1.time_ = 0
		arg_612_1.frameCnt_ = 0
		arg_612_1.state_ = "playing"
		arg_612_1.curTalkId_ = 423011147
		arg_612_1.duration_ = 5.17

		local var_612_0 = {
			zh = 4.133,
			ja = 5.166
		}
		local var_612_1 = manager.audio:GetLocalizationFlag()

		if var_612_0[var_612_1] ~= nil then
			arg_612_1.duration_ = var_612_0[var_612_1]
		end

		SetActive(arg_612_1.tipsGo_, false)

		function arg_612_1.onSingleLineFinish_()
			arg_612_1.onSingleLineUpdate_ = nil
			arg_612_1.onSingleLineFinish_ = nil
			arg_612_1.state_ = "waiting"
			arg_612_1.auto_ = false
		end

		function arg_612_1.playNext_(arg_614_0)
			arg_612_1.onStoryFinished_()
		end

		function arg_612_1.onSingleLineUpdate_(arg_615_0)
			local var_615_0 = 0
			local var_615_1 = 0.5

			if var_615_0 < arg_612_1.time_ and arg_612_1.time_ <= var_615_0 + arg_615_0 then
				arg_612_1.talkMaxDuration = 0
				arg_612_1.dialogCg_.alpha = 1

				arg_612_1.dialog_:SetActive(true)
				SetActive(arg_612_1.leftNameGo_, true)

				local var_615_2 = arg_612_1:FormatText(StoryNameCfg[36].name)

				arg_612_1.leftNameTxt_.text = var_615_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_612_1.leftNameTxt_.transform)

				arg_612_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_612_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_612_1:RecordName(arg_612_1.leftNameTxt_.text)
				SetActive(arg_612_1.iconTrs_.gameObject, false)
				arg_612_1.callingController_:SetSelectedState("normal")

				local var_615_3 = arg_612_1:GetWordFromCfg(423011147)
				local var_615_4 = arg_612_1:FormatText(var_615_3.content)

				arg_612_1.text_.text = var_615_4

				LuaForUtil.ClearLinePrefixSymbol(arg_612_1.text_)

				local var_615_5 = 20
				local var_615_6 = utf8.len(var_615_4)
				local var_615_7 = var_615_5 <= 0 and var_615_1 or var_615_1 * (var_615_6 / var_615_5)

				if var_615_7 > 0 and var_615_1 < var_615_7 then
					arg_612_1.talkMaxDuration = var_615_7

					if var_615_7 + var_615_0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_7 + var_615_0
					end
				end

				arg_612_1.text_.text = var_615_4
				arg_612_1.typewritter.percent = 0

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011147", "story_v_out_423011.awb") ~= 0 then
					local var_615_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011147", "story_v_out_423011.awb") / 1000

					if var_615_8 + var_615_0 > arg_612_1.duration_ then
						arg_612_1.duration_ = var_615_8 + var_615_0
					end

					if var_615_3.prefab_name ~= "" and arg_612_1.actors_[var_615_3.prefab_name] ~= nil then
						local var_615_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_612_1.actors_[var_615_3.prefab_name].transform, "story_v_out_423011", "423011147", "story_v_out_423011.awb")

						arg_612_1:RecordAudio("423011147", var_615_9)
						arg_612_1:RecordAudio("423011147", var_615_9)
					else
						arg_612_1:AudioAction("play", "voice", "story_v_out_423011", "423011147", "story_v_out_423011.awb")
					end

					arg_612_1:RecordHistoryTalkVoice("story_v_out_423011", "423011147", "story_v_out_423011.awb")
				end

				arg_612_1:RecordContent(arg_612_1.text_.text)
			end

			local var_615_10 = math.max(var_615_1, arg_612_1.talkMaxDuration)

			if var_615_0 <= arg_612_1.time_ and arg_612_1.time_ < var_615_0 + var_615_10 then
				arg_612_1.typewritter.percent = (arg_612_1.time_ - var_615_0) / var_615_10

				arg_612_1.typewritter:SetDirty()
			end

			if arg_612_1.time_ >= var_615_0 + var_615_10 and arg_612_1.time_ < var_615_0 + var_615_10 + arg_615_0 then
				arg_612_1.typewritter.percent = 1

				arg_612_1.typewritter:SetDirty()
				arg_612_1:ShowNextGo(true)
			end
		end

		arg_612_1.nodeConfigList_ = {}

		arg_612_1:InitPlayNodeList()
	end,
	Play423011038 = function(arg_616_0, arg_616_1)
		arg_616_1.time_ = 0
		arg_616_1.frameCnt_ = 0
		arg_616_1.state_ = "playing"
		arg_616_1.curTalkId_ = 423011038
		arg_616_1.duration_ = 7.53

		local var_616_0 = {
			zh = 5.9,
			ja = 7.533
		}
		local var_616_1 = manager.audio:GetLocalizationFlag()

		if var_616_0[var_616_1] ~= nil then
			arg_616_1.duration_ = var_616_0[var_616_1]
		end

		SetActive(arg_616_1.tipsGo_, false)

		function arg_616_1.onSingleLineFinish_()
			arg_616_1.onSingleLineUpdate_ = nil
			arg_616_1.onSingleLineFinish_ = nil
			arg_616_1.state_ = "waiting"
		end

		function arg_616_1.playNext_(arg_618_0)
			if arg_618_0 == 1 then
				arg_616_0:Play423011039(arg_616_1)
			end
		end

		function arg_616_1.onSingleLineUpdate_(arg_619_0)
			local var_619_0 = 0
			local var_619_1 = 0.675

			if var_619_0 < arg_616_1.time_ and arg_616_1.time_ <= var_619_0 + arg_619_0 then
				arg_616_1.talkMaxDuration = 0
				arg_616_1.dialogCg_.alpha = 1

				arg_616_1.dialog_:SetActive(true)
				SetActive(arg_616_1.leftNameGo_, true)

				local var_619_2 = arg_616_1:FormatText(StoryNameCfg[1296].name)

				arg_616_1.leftNameTxt_.text = var_619_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_616_1.leftNameTxt_.transform)

				arg_616_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_616_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_616_1:RecordName(arg_616_1.leftNameTxt_.text)
				SetActive(arg_616_1.iconTrs_.gameObject, false)
				arg_616_1.callingController_:SetSelectedState("normal")

				local var_619_3 = arg_616_1:GetWordFromCfg(423011038)
				local var_619_4 = arg_616_1:FormatText(var_619_3.content)

				arg_616_1.text_.text = var_619_4

				LuaForUtil.ClearLinePrefixSymbol(arg_616_1.text_)

				local var_619_5 = 27
				local var_619_6 = utf8.len(var_619_4)
				local var_619_7 = var_619_5 <= 0 and var_619_1 or var_619_1 * (var_619_6 / var_619_5)

				if var_619_7 > 0 and var_619_1 < var_619_7 then
					arg_616_1.talkMaxDuration = var_619_7

					if var_619_7 + var_619_0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_7 + var_619_0
					end
				end

				arg_616_1.text_.text = var_619_4
				arg_616_1.typewritter.percent = 0

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011038", "story_v_out_423011.awb") ~= 0 then
					local var_619_8 = manager.audio:GetVoiceLength("story_v_out_423011", "423011038", "story_v_out_423011.awb") / 1000

					if var_619_8 + var_619_0 > arg_616_1.duration_ then
						arg_616_1.duration_ = var_619_8 + var_619_0
					end

					if var_619_3.prefab_name ~= "" and arg_616_1.actors_[var_619_3.prefab_name] ~= nil then
						local var_619_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_616_1.actors_[var_619_3.prefab_name].transform, "story_v_out_423011", "423011038", "story_v_out_423011.awb")

						arg_616_1:RecordAudio("423011038", var_619_9)
						arg_616_1:RecordAudio("423011038", var_619_9)
					else
						arg_616_1:AudioAction("play", "voice", "story_v_out_423011", "423011038", "story_v_out_423011.awb")
					end

					arg_616_1:RecordHistoryTalkVoice("story_v_out_423011", "423011038", "story_v_out_423011.awb")
				end

				arg_616_1:RecordContent(arg_616_1.text_.text)
			end

			local var_619_10 = math.max(var_619_1, arg_616_1.talkMaxDuration)

			if var_619_0 <= arg_616_1.time_ and arg_616_1.time_ < var_619_0 + var_619_10 then
				arg_616_1.typewritter.percent = (arg_616_1.time_ - var_619_0) / var_619_10

				arg_616_1.typewritter:SetDirty()
			end

			if arg_616_1.time_ >= var_619_0 + var_619_10 and arg_616_1.time_ < var_619_0 + var_619_10 + arg_619_0 then
				arg_616_1.typewritter.percent = 1

				arg_616_1.typewritter:SetDirty()
				arg_616_1:ShowNextGo(true)
			end
		end

		arg_616_1.nodeConfigList_ = {}

		arg_616_1:InitPlayNodeList()
	end,
	Play423011039 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 423011039
		arg_620_1.duration_ = 5

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play423011040(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 0
			local var_623_1 = 0.35

			if var_623_0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_0 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, true)

				local var_623_2 = arg_620_1:FormatText(StoryNameCfg[7].name)

				arg_620_1.leftNameTxt_.text = var_623_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_620_1.leftNameTxt_.transform)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1.leftNameTxt_.text)
				SetActive(arg_620_1.iconTrs_.gameObject, true)
				arg_620_1.iconController_:SetSelectedState("hero")

				arg_620_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_620_1.callingController_:SetSelectedState("normal")

				arg_620_1.keyicon_.color = Color.New(1, 1, 1)
				arg_620_1.icon_.color = Color.New(1, 1, 1)

				local var_623_3 = arg_620_1:GetWordFromCfg(423011039)
				local var_623_4 = arg_620_1:FormatText(var_623_3.content)

				arg_620_1.text_.text = var_623_4

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_5 = 14
				local var_623_6 = utf8.len(var_623_4)
				local var_623_7 = var_623_5 <= 0 and var_623_1 or var_623_1 * (var_623_6 / var_623_5)

				if var_623_7 > 0 and var_623_1 < var_623_7 then
					arg_620_1.talkMaxDuration = var_623_7

					if var_623_7 + var_623_0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_7 + var_623_0
					end
				end

				arg_620_1.text_.text = var_623_4
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)
				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_8 = math.max(var_623_1, arg_620_1.talkMaxDuration)

			if var_623_0 <= arg_620_1.time_ and arg_620_1.time_ < var_623_0 + var_623_8 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_0) / var_623_8

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_0 + var_623_8 and arg_620_1.time_ < var_623_0 + var_623_8 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play423011040 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 423011040
		arg_624_1.duration_ = 6

		local var_624_0 = {
			zh = 3.733,
			ja = 6
		}
		local var_624_1 = manager.audio:GetLocalizationFlag()

		if var_624_0[var_624_1] ~= nil then
			arg_624_1.duration_ = var_624_0[var_624_1]
		end

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play423011041(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = arg_624_1.actors_["1047"].transform
			local var_627_1 = 0

			if var_627_1 < arg_624_1.time_ and arg_624_1.time_ <= var_627_1 + arg_627_0 then
				arg_624_1.var_.moveOldPos1047 = var_627_0.localPosition
				var_627_0.localScale = Vector3.New(1, 1, 1)

				arg_624_1:CheckSpriteTmpPos("1047", 3)

				local var_627_2 = var_627_0.childCount

				for iter_627_0 = 0, var_627_2 - 1 do
					local var_627_3 = var_627_0:GetChild(iter_627_0)

					if var_627_3.name == "split_1" or not string.find(var_627_3.name, "split") then
						var_627_3.gameObject:SetActive(true)
					else
						var_627_3.gameObject:SetActive(false)
					end
				end
			end

			local var_627_4 = 0.001

			if var_627_1 <= arg_624_1.time_ and arg_624_1.time_ < var_627_1 + var_627_4 then
				local var_627_5 = (arg_624_1.time_ - var_627_1) / var_627_4
				local var_627_6 = Vector3.New(-38.9, -360, -319.3)

				var_627_0.localPosition = Vector3.Lerp(arg_624_1.var_.moveOldPos1047, var_627_6, var_627_5)
			end

			if arg_624_1.time_ >= var_627_1 + var_627_4 and arg_624_1.time_ < var_627_1 + var_627_4 + arg_627_0 then
				var_627_0.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_627_7 = 0
			local var_627_8 = 0.5

			if var_627_7 < arg_624_1.time_ and arg_624_1.time_ <= var_627_7 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				local var_627_9 = arg_624_1:FormatText(StoryNameCfg[1296].name)

				arg_624_1.leftNameTxt_.text = var_627_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, false)
				arg_624_1.callingController_:SetSelectedState("normal")

				local var_627_10 = arg_624_1:GetWordFromCfg(423011040)
				local var_627_11 = arg_624_1:FormatText(var_627_10.content)

				arg_624_1.text_.text = var_627_11

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_12 = 20
				local var_627_13 = utf8.len(var_627_11)
				local var_627_14 = var_627_12 <= 0 and var_627_8 or var_627_8 * (var_627_13 / var_627_12)

				if var_627_14 > 0 and var_627_8 < var_627_14 then
					arg_624_1.talkMaxDuration = var_627_14

					if var_627_14 + var_627_7 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_14 + var_627_7
					end
				end

				arg_624_1.text_.text = var_627_11
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423011", "423011040", "story_v_out_423011.awb") ~= 0 then
					local var_627_15 = manager.audio:GetVoiceLength("story_v_out_423011", "423011040", "story_v_out_423011.awb") / 1000

					if var_627_15 + var_627_7 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_15 + var_627_7
					end

					if var_627_10.prefab_name ~= "" and arg_624_1.actors_[var_627_10.prefab_name] ~= nil then
						local var_627_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_10.prefab_name].transform, "story_v_out_423011", "423011040", "story_v_out_423011.awb")

						arg_624_1:RecordAudio("423011040", var_627_16)
						arg_624_1:RecordAudio("423011040", var_627_16)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_out_423011", "423011040", "story_v_out_423011.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_out_423011", "423011040", "story_v_out_423011.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_17 = math.max(var_627_8, arg_624_1.talkMaxDuration)

			if var_627_7 <= arg_624_1.time_ and arg_624_1.time_ < var_627_7 + var_627_17 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_7) / var_627_17

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_7 + var_627_17 and arg_624_1.time_ < var_627_7 + var_627_17 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_624_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I25g",
		"TextureConfig/Background/ST0111",
		"TextureConfig/Background/ST0113",
		"TextureConfig/Background/SS2301",
		"TextureConfig/Background/SS2301a",
		"TextureConfig/Background/I24f"
	},
	voices = {
		"story_v_out_423011.awb"
	}
}
