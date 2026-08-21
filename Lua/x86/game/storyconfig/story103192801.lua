return {
	Play319281001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319281001
		arg_1_1.duration_ = 6

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319281002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0.833333333333333

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_1 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_2 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_3 = var_4_1:GetComponent("Text")
				local var_4_4 = var_4_1:GetComponent("RectTransform")

				var_4_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_4.offsetMin = Vector2.New(0, 0)
				var_4_4.offsetMax = Vector2.New(0, 0)
			end

			local var_4_5 = 0

			if var_4_5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_6 = arg_1_1:GetWordFromCfg(319281001)
				local var_4_7 = arg_1_1:FormatText(var_4_6.content)

				arg_1_1.fswt_.text = var_4_7

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_8 = 2

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_9 = 4
			local var_4_10 = 0.266666666666667
			local var_4_11 = arg_1_1:GetWordFromCfg(319281001)
			local var_4_12 = arg_1_1:FormatText(var_4_11.content)
			local var_4_13, var_4_14 = arg_1_1:GetPercentByPara(var_4_12, 1)

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_15 = var_4_9 <= 0 and var_4_10 or var_4_10 * ((var_4_14 - arg_1_1.typewritterCharCountI18N) / var_4_9)

				if var_4_15 > 0 and var_4_10 < var_4_15 then
					arg_1_1.talkMaxDuration = var_4_15

					if var_4_15 + var_4_8 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_15 + var_4_8
					end
				end
			end

			local var_4_16 = 0.266666666666667
			local var_4_17 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_8 <= arg_1_1.time_ and arg_1_1.time_ < var_4_8 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_8) / var_4_17

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_13, var_4_18)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_8 + var_4_17 and arg_1_1.time_ < var_4_8 + var_4_17 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_13

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_14
			end

			local var_4_19 = "STblack"

			if arg_1_1.bgs_[var_4_19] == nil then
				local var_4_20 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_19)
				var_4_20.name = var_4_19
				var_4_20.transform.parent = arg_1_1.stage_.transform
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_19] = var_4_20
			end

			local var_4_21 = 0

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				local var_4_22 = manager.ui.mainCamera.transform.localPosition
				local var_4_23 = Vector3.New(0, 0, 10) + Vector3.New(var_4_22.x, var_4_22.y, 0)
				local var_4_24 = arg_1_1.bgs_.STblack

				var_4_24.transform.localPosition = var_4_23
				var_4_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_25 = var_4_24:GetComponent("SpriteRenderer")

				if var_4_25 and var_4_25.sprite then
					local var_4_26 = (var_4_24.transform.localPosition - var_4_22).z
					local var_4_27 = manager.ui.mainCameraCom_
					local var_4_28 = 2 * var_4_26 * Mathf.Tan(var_4_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_29 = var_4_28 * var_4_27.aspect
					local var_4_30 = var_4_25.sprite.bounds.size.x
					local var_4_31 = var_4_25.sprite.bounds.size.y
					local var_4_32 = var_4_29 / var_4_30
					local var_4_33 = var_4_28 / var_4_31
					local var_4_34 = var_4_33 < var_4_32 and var_4_32 or var_4_33

					var_4_24.transform.localScale = Vector3.New(var_4_34, var_4_34, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_35 = 0

			if var_4_35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_36 = 2

			if var_4_35 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				local var_4_37 = (arg_1_1.time_ - var_4_35) / var_4_36
				local var_4_38 = Color.New(0, 0, 0)

				var_4_38.a = Mathf.Lerp(1, 0, var_4_37)
				arg_1_1.mask_.color = var_4_38
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				local var_4_39 = Color.New(0, 0, 0)
				local var_4_40 = 0

				arg_1_1.mask_.enabled = false
				var_4_39.a = var_4_40
				arg_1_1.mask_.color = var_4_39
			end

			local var_4_41 = 2
			local var_4_42 = 1.3
			local var_4_43 = manager.audio:GetVoiceLength("story_v_out_319281", "319281001", "story_v_out_319281.awb") / 1000

			if var_4_43 > 0 and var_4_42 < var_4_43 and var_4_43 + var_4_41 > arg_1_1.duration_ then
				local var_4_44 = var_4_43

				arg_1_1.duration_ = var_4_43 + var_4_41
			end

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "voice"

				arg_1_1:AudioAction(var_4_45, var_4_46, "story_v_out_319281", "319281001", "story_v_out_319281.awb")
			end

			local var_4_47 = 0
			local var_4_48 = 0.9

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "music"

				arg_1_1:AudioAction(var_4_49, var_4_50, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_51 = ""
				local var_4_52 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_52 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_52 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_52

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_52
						arg_1_1.bgmTxt2_.text = var_4_52
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

			local var_4_53 = 1

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(false)

				local var_4_54 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_54.offsetMin = Vector2.New(400, 105)
				var_4_54.offsetMax = Vector2.New(-400, -200)

				local var_4_55 = arg_1_1:GetWordFromCfg(419002)
				local var_4_56 = arg_1_1:FormatText(var_4_55.content)

				arg_1_1.cswt_.text = var_4_56

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 108
				arg_1_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswbg_:SetActive(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319281002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 319281002
		arg_6_1.duration_ = 7.53

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play319281003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				local var_9_1 = manager.ui.mainCamera.transform.localPosition
				local var_9_2 = Vector3.New(0, 0, 10) + Vector3.New(var_9_1.x, var_9_1.y, 0)
				local var_9_3 = arg_6_1.bgs_.STblack

				var_9_3.transform.localPosition = var_9_2
				var_9_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_4 = var_9_3:GetComponent("SpriteRenderer")

				if var_9_4 and var_9_4.sprite then
					local var_9_5 = (var_9_3.transform.localPosition - var_9_1).z
					local var_9_6 = manager.ui.mainCameraCom_
					local var_9_7 = 2 * var_9_5 * Mathf.Tan(var_9_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_9_8 = var_9_7 * var_9_6.aspect
					local var_9_9 = var_9_4.sprite.bounds.size.x
					local var_9_10 = var_9_4.sprite.bounds.size.y
					local var_9_11 = var_9_8 / var_9_9
					local var_9_12 = var_9_7 / var_9_10
					local var_9_13 = var_9_12 < var_9_11 and var_9_11 or var_9_12

					var_9_3.transform.localScale = Vector3.New(var_9_13, var_9_13, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "STblack" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_14 = 1.63333333333333

			if var_9_14 < arg_6_1.time_ and arg_6_1.time_ <= var_9_14 + arg_9_0 then
				local var_9_15 = manager.ui.mainCamera.transform.localPosition
				local var_9_16 = Vector3.New(0, 0, 10) + Vector3.New(var_9_15.x, var_9_15.y, 0)
				local var_9_17 = arg_6_1.bgs_.STblack

				var_9_17.transform.localPosition = var_9_16
				var_9_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_18 = var_9_17:GetComponent("SpriteRenderer")

				if var_9_18 and var_9_18.sprite then
					local var_9_19 = (var_9_17.transform.localPosition - var_9_15).z
					local var_9_20 = manager.ui.mainCameraCom_
					local var_9_21 = 2 * var_9_19 * Mathf.Tan(var_9_20.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_9_22 = var_9_21 * var_9_20.aspect
					local var_9_23 = var_9_18.sprite.bounds.size.x
					local var_9_24 = var_9_18.sprite.bounds.size.y
					local var_9_25 = var_9_22 / var_9_23
					local var_9_26 = var_9_21 / var_9_24
					local var_9_27 = var_9_26 < var_9_25 and var_9_25 or var_9_26

					var_9_17.transform.localScale = Vector3.New(var_9_27, var_9_27, 0)
				end

				for iter_9_2, iter_9_3 in pairs(arg_6_1.bgs_) do
					if iter_9_2 ~= "STblack" then
						iter_9_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_28 = 0

			if var_9_28 < arg_6_1.time_ and arg_6_1.time_ <= var_9_28 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_29 = 1.63333333333333

			if var_9_28 <= arg_6_1.time_ and arg_6_1.time_ < var_9_28 + var_9_29 then
				local var_9_30 = (arg_6_1.time_ - var_9_28) / var_9_29
				local var_9_31 = Color.New(0, 0, 0)

				var_9_31.a = Mathf.Lerp(0, 1, var_9_30)
				arg_6_1.mask_.color = var_9_31
			end

			if arg_6_1.time_ >= var_9_28 + var_9_29 and arg_6_1.time_ < var_9_28 + var_9_29 + arg_9_0 then
				local var_9_32 = Color.New(0, 0, 0)

				var_9_32.a = 1
				arg_6_1.mask_.color = var_9_32
			end

			local var_9_33 = 1.63333333333333

			if var_9_33 < arg_6_1.time_ and arg_6_1.time_ <= var_9_33 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_34 = 0.9

			if var_9_33 <= arg_6_1.time_ and arg_6_1.time_ < var_9_33 + var_9_34 then
				local var_9_35 = (arg_6_1.time_ - var_9_33) / var_9_34
				local var_9_36 = Color.New(0, 0, 0)

				var_9_36.a = Mathf.Lerp(1, 0, var_9_35)
				arg_6_1.mask_.color = var_9_36
			end

			if arg_6_1.time_ >= var_9_33 + var_9_34 and arg_6_1.time_ < var_9_33 + var_9_34 + arg_9_0 then
				local var_9_37 = Color.New(0, 0, 0)
				local var_9_38 = 0

				arg_6_1.mask_.enabled = false
				var_9_37.a = var_9_38
				arg_6_1.mask_.color = var_9_37
			end

			local var_9_39 = "1184ui_story"

			if arg_6_1.actors_[var_9_39] == nil then
				local var_9_40 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_9_40) then
					local var_9_41 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_6_1.stage_.transform)

					var_9_41.name = var_9_39
					var_9_41.transform.localPosition = Vector3.New(0, 100, 0)
					arg_6_1.actors_[var_9_39] = var_9_41

					local var_9_42 = var_9_41:GetComponentInChildren(typeof(CharacterEffect))

					var_9_42.enabled = true

					local var_9_43 = GameObjectTools.GetOrAddComponent(var_9_41, typeof(DynamicBoneHelper))

					if var_9_43 then
						var_9_43:EnableDynamicBone(false)
					end

					arg_6_1:ShowWeapon(var_9_42.transform, false)

					arg_6_1.var_[var_9_39 .. "Animator"] = var_9_42.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_6_1.var_[var_9_39 .. "Animator"].applyRootMotion = true
					arg_6_1.var_[var_9_39 .. "LipSync"] = var_9_42.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_9_44 = arg_6_1.actors_["1184ui_story"]
			local var_9_45 = 0

			if var_9_45 < arg_6_1.time_ and arg_6_1.time_ <= var_9_45 + arg_9_0 and not isNil(var_9_44) and arg_6_1.var_.characterEffect1184ui_story == nil then
				arg_6_1.var_.characterEffect1184ui_story = var_9_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_9_46 = 0.200000002980232

			if var_9_45 <= arg_6_1.time_ and arg_6_1.time_ < var_9_45 + var_9_46 and not isNil(var_9_44) then
				local var_9_47 = (arg_6_1.time_ - var_9_45) / var_9_46

				if arg_6_1.var_.characterEffect1184ui_story and not isNil(var_9_44) then
					local var_9_48 = Mathf.Lerp(0, 0.5, var_9_47)

					arg_6_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_6_1.var_.characterEffect1184ui_story.fillRatio = var_9_48
				end
			end

			if arg_6_1.time_ >= var_9_45 + var_9_46 and arg_6_1.time_ < var_9_45 + var_9_46 + arg_9_0 and not isNil(var_9_44) and arg_6_1.var_.characterEffect1184ui_story then
				local var_9_49 = 0.5

				arg_6_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_6_1.var_.characterEffect1184ui_story.fillRatio = var_9_49
			end

			local var_9_50 = 0
			local var_9_51 = 0.1

			if var_9_50 < arg_6_1.time_ and arg_6_1.time_ <= var_9_50 + arg_9_0 then
				local var_9_52 = "play"
				local var_9_53 = "music"

				arg_6_1:AudioAction(var_9_52, var_9_53, "ui_battle", "ui_battle_stopbgm", "")

				local var_9_54 = ""
				local var_9_55 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_9_55 ~= "" then
					if arg_6_1.bgmTxt_.text ~= var_9_55 and arg_6_1.bgmTxt_.text ~= "" then
						if arg_6_1.bgmTxt2_.text ~= "" then
							arg_6_1.bgmTxt_.text = arg_6_1.bgmTxt2_.text
						end

						arg_6_1.bgmTxt2_.text = var_9_55

						arg_6_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_6_1.bgmTxt_.text = var_9_55
						arg_6_1.bgmTxt2_.text = var_9_55
					end

					if arg_6_1.bgmTimer then
						arg_6_1.bgmTimer:Stop()

						arg_6_1.bgmTimer = nil
					end

					if arg_6_1.settingData.show_music_name == 1 then
						arg_6_1.musicController:SetSelectedState("show")
						arg_6_1.musicAnimator_:Play("open", 0, 0)

						if arg_6_1.settingData.music_time ~= 0 then
							arg_6_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_6_1.settingData.music_time), function()
								if arg_6_1 == nil or isNil(arg_6_1.bgmTxt_) then
									return
								end

								arg_6_1.musicController:SetSelectedState("hide")
								arg_6_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_9_56 = 0.133333333333333
			local var_9_57 = 1

			if var_9_56 < arg_6_1.time_ and arg_6_1.time_ <= var_9_56 + arg_9_0 then
				local var_9_58 = "play"
				local var_9_59 = "music"

				arg_6_1:AudioAction(var_9_58, var_9_59, "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space.awb")

				local var_9_60 = ""
				local var_9_61 = manager.audio:GetAudioName("bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space")

				if var_9_61 ~= "" then
					if arg_6_1.bgmTxt_.text ~= var_9_61 and arg_6_1.bgmTxt_.text ~= "" then
						if arg_6_1.bgmTxt2_.text ~= "" then
							arg_6_1.bgmTxt_.text = arg_6_1.bgmTxt2_.text
						end

						arg_6_1.bgmTxt2_.text = var_9_61

						arg_6_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_6_1.bgmTxt_.text = var_9_61
						arg_6_1.bgmTxt2_.text = var_9_61
					end

					if arg_6_1.bgmTimer then
						arg_6_1.bgmTimer:Stop()

						arg_6_1.bgmTimer = nil
					end

					if arg_6_1.settingData.show_music_name == 1 then
						arg_6_1.musicController:SetSelectedState("show")
						arg_6_1.musicAnimator_:Play("open", 0, 0)

						if arg_6_1.settingData.music_time ~= 0 then
							arg_6_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_6_1.settingData.music_time), function()
								if arg_6_1 == nil or isNil(arg_6_1.bgmTxt_) then
									return
								end

								arg_6_1.musicController:SetSelectedState("hide")
								arg_6_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_9_62 = 1.63333333333333

			if var_9_62 < arg_6_1.time_ and arg_6_1.time_ <= var_9_62 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(false)
				arg_6_1.dialog_:SetActive(false)
				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_63 = 1.8

			if var_9_63 < arg_6_1.time_ and arg_6_1.time_ <= var_9_63 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(false)
				arg_6_1.dialog_:SetActive(false)
				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_64 = 1.63333333333333

			if var_9_64 < arg_6_1.time_ and arg_6_1.time_ <= var_9_64 + arg_9_0 then
				arg_6_1.cswbg_:SetActive(false)
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_65 = 2.53333333333333
			local var_9_66 = 0.9

			if var_9_65 < arg_6_1.time_ and arg_6_1.time_ <= var_9_65 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_67 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_67:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
					arg_6_1.dialogCg_.alpha = arg_12_0
				end))
				var_9_67:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_67:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, false)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_68 = arg_6_1:GetWordFromCfg(319281002)
				local var_9_69 = arg_6_1:FormatText(var_9_68.content)

				arg_6_1.text_.text = var_9_69

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_70 = 36
				local var_9_71 = utf8.len(var_9_69)
				local var_9_72 = var_9_70 <= 0 and var_9_66 or var_9_66 * (var_9_71 / var_9_70)

				if var_9_72 > 0 and var_9_66 < var_9_72 then
					arg_6_1.talkMaxDuration = var_9_72
					var_9_65 = var_9_65 + 0.3

					if var_9_72 + var_9_65 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_72 + var_9_65
					end
				end

				arg_6_1.text_.text = var_9_69
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)
				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_73 = var_9_65 + 0.3
			local var_9_74 = math.max(var_9_66, arg_6_1.talkMaxDuration)

			if var_9_73 <= arg_6_1.time_ and arg_6_1.time_ < var_9_73 + var_9_74 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_73) / var_9_74

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_73 + var_9_74 and arg_6_1.time_ < var_9_73 + var_9_74 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play319281003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 319281003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play319281004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0
			local var_17_1 = 1.525

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_2 = arg_14_1:GetWordFromCfg(319281003)
				local var_17_3 = arg_14_1:FormatText(var_17_2.content)

				arg_14_1.text_.text = var_17_3

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 61
				local var_17_5 = utf8.len(var_17_3)
				local var_17_6 = var_17_4 <= 0 and var_17_1 or var_17_1 * (var_17_5 / var_17_4)

				if var_17_6 > 0 and var_17_1 < var_17_6 then
					arg_14_1.talkMaxDuration = var_17_6

					if var_17_6 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_6 + var_17_0
					end
				end

				arg_14_1.text_.text = var_17_3
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_1, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_0) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_7 and arg_14_1.time_ < var_17_0 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play319281004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 319281004
		arg_18_1.duration_ = 3.4

		local var_18_0 = {
			zh = 2.433,
			ja = 3.4
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
				arg_18_0:Play319281005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 0.175

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_2 = arg_18_1:FormatText(StoryNameCfg[6].name)

				arg_18_1.leftNameTxt_.text = var_21_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_3 = arg_18_1:GetWordFromCfg(319281004)
				local var_21_4 = arg_18_1:FormatText(var_21_3.content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281004", "story_v_out_319281.awb") ~= 0 then
					local var_21_8 = manager.audio:GetVoiceLength("story_v_out_319281", "319281004", "story_v_out_319281.awb") / 1000

					if var_21_8 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_8 + var_21_0
					end

					if var_21_3.prefab_name ~= "" and arg_18_1.actors_[var_21_3.prefab_name] ~= nil then
						local var_21_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_3.prefab_name].transform, "story_v_out_319281", "319281004", "story_v_out_319281.awb")

						arg_18_1:RecordAudio("319281004", var_21_9)
						arg_18_1:RecordAudio("319281004", var_21_9)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_319281", "319281004", "story_v_out_319281.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_319281", "319281004", "story_v_out_319281.awb")
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
	Play319281005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 319281005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play319281006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0
			local var_25_1 = 1

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_2 = arg_22_1:GetWordFromCfg(319281005)
				local var_25_3 = arg_22_1:FormatText(var_25_2.content)

				arg_22_1.text_.text = var_25_3

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 40
				local var_25_5 = utf8.len(var_25_3)
				local var_25_6 = var_25_4 <= 0 and var_25_1 or var_25_1 * (var_25_5 / var_25_4)

				if var_25_6 > 0 and var_25_1 < var_25_6 then
					arg_22_1.talkMaxDuration = var_25_6

					if var_25_6 + var_25_0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_6 + var_25_0
					end
				end

				arg_22_1.text_.text = var_25_3
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_7 = math.max(var_25_1, arg_22_1.talkMaxDuration)

			if var_25_0 <= arg_22_1.time_ and arg_22_1.time_ < var_25_0 + var_25_7 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_0) / var_25_7

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_0 + var_25_7 and arg_22_1.time_ < var_25_0 + var_25_7 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play319281006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 319281006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play319281007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 1.2

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_2 = arg_26_1:GetWordFromCfg(319281006)
				local var_29_3 = arg_26_1:FormatText(var_29_2.content)

				arg_26_1.text_.text = var_29_3

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 48
				local var_29_5 = utf8.len(var_29_3)
				local var_29_6 = var_29_4 <= 0 and var_29_1 or var_29_1 * (var_29_5 / var_29_4)

				if var_29_6 > 0 and var_29_1 < var_29_6 then
					arg_26_1.talkMaxDuration = var_29_6

					if var_29_6 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_6 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_3
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_7 and arg_26_1.time_ < var_29_0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play319281007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 319281007
		arg_30_1.duration_ = 1

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play319281008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			return
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play319281008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 319281008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play319281009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = "1284ui_story"

			if arg_34_1.actors_[var_37_0] == nil then
				local var_37_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_37_1) then
					local var_37_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_34_1.stage_.transform)

					var_37_2.name = var_37_0
					var_37_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_34_1.actors_[var_37_0] = var_37_2

					local var_37_3 = var_37_2:GetComponentInChildren(typeof(CharacterEffect))

					var_37_3.enabled = true

					local var_37_4 = GameObjectTools.GetOrAddComponent(var_37_2, typeof(DynamicBoneHelper))

					if var_37_4 then
						var_37_4:EnableDynamicBone(false)
					end

					arg_34_1:ShowWeapon(var_37_3.transform, false)

					arg_34_1.var_[var_37_0 .. "Animator"] = var_37_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_34_1.var_[var_37_0 .. "Animator"].applyRootMotion = true
					arg_34_1.var_[var_37_0 .. "LipSync"] = var_37_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_37_5 = arg_34_1.actors_["1284ui_story"].transform
			local var_37_6 = 0

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.var_.moveOldPos1284ui_story = var_37_5.localPosition
			end

			local var_37_7 = 0.001

			if var_37_6 <= arg_34_1.time_ and arg_34_1.time_ < var_37_6 + var_37_7 then
				local var_37_8 = (arg_34_1.time_ - var_37_6) / var_37_7
				local var_37_9 = Vector3.New(0, 100, 0)

				var_37_5.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1284ui_story, var_37_9, var_37_8)

				local var_37_10 = manager.ui.mainCamera.transform.position - var_37_5.position

				var_37_5.forward = Vector3.New(var_37_10.x, var_37_10.y, var_37_10.z)

				local var_37_11 = var_37_5.localEulerAngles

				var_37_11.z = 0
				var_37_11.x = 0
				var_37_5.localEulerAngles = var_37_11
			end

			if arg_34_1.time_ >= var_37_6 + var_37_7 and arg_34_1.time_ < var_37_6 + var_37_7 + arg_37_0 then
				var_37_5.localPosition = Vector3.New(0, 100, 0)

				local var_37_12 = manager.ui.mainCamera.transform.position - var_37_5.position

				var_37_5.forward = Vector3.New(var_37_12.x, var_37_12.y, var_37_12.z)

				local var_37_13 = var_37_5.localEulerAngles

				var_37_13.z = 0
				var_37_13.x = 0
				var_37_5.localEulerAngles = var_37_13
			end

			local var_37_14 = 0

			if var_37_14 < arg_34_1.time_ and arg_34_1.time_ <= var_37_14 + arg_37_0 then
				local var_37_15 = arg_34_1.fswbg_.transform:Find("textbox/adapt/content") or arg_34_1.fswbg_.transform:Find("textbox/content")
				local var_37_16 = arg_34_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_37_17 = var_37_15:GetComponent("Text")
				local var_37_18 = var_37_15:GetComponent("RectTransform")

				var_37_17.alignment = UnityEngine.TextAnchor.LowerCenter
				var_37_18.offsetMin = Vector2.New(0, 0)
				var_37_18.offsetMax = Vector2.New(0, 0)
			end

			local var_37_19 = 0

			if var_37_19 < arg_34_1.time_ and arg_34_1.time_ <= var_37_19 + arg_37_0 then
				arg_34_1.fswbg_:SetActive(true)
				arg_34_1.dialog_:SetActive(false)

				arg_34_1.fswtw_.percent = 0

				local var_37_20 = arg_34_1:GetWordFromCfg(319281008)
				local var_37_21 = arg_34_1:FormatText(var_37_20.content)

				arg_34_1.fswt_.text = var_37_21

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.fswt_)

				arg_34_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_34_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_34_1.fswtw_:SetDirty()

				arg_34_1.typewritterCharCountI18N = 0

				SetActive(arg_34_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_34_1:ShowNextGo(false)
			end

			local var_37_22 = 0.5

			if var_37_22 < arg_34_1.time_ and arg_34_1.time_ <= var_37_22 + arg_37_0 then
				arg_34_1.var_.oldValueTypewriter = arg_34_1.fswtw_.percent

				SetActive(arg_34_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_34_1:ShowNextGo(false)
			end

			local var_37_23 = 5
			local var_37_24 = 0.266666666666667
			local var_37_25 = arg_34_1:GetWordFromCfg(319281008)
			local var_37_26 = arg_34_1:FormatText(var_37_25.content)
			local var_37_27, var_37_28 = arg_34_1:GetPercentByPara(var_37_26, 1)

			if var_37_22 < arg_34_1.time_ and arg_34_1.time_ <= var_37_22 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				local var_37_29 = var_37_23 <= 0 and var_37_24 or var_37_24 * ((var_37_28 - arg_34_1.typewritterCharCountI18N) / var_37_23)

				if var_37_29 > 0 and var_37_24 < var_37_29 then
					arg_34_1.talkMaxDuration = var_37_29

					if var_37_29 + var_37_22 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_29 + var_37_22
					end
				end
			end

			local var_37_30 = 0.266666666666667
			local var_37_31 = math.max(var_37_30, arg_34_1.talkMaxDuration)

			if var_37_22 <= arg_34_1.time_ and arg_34_1.time_ < var_37_22 + var_37_31 then
				local var_37_32 = (arg_34_1.time_ - var_37_22) / var_37_31

				arg_34_1.fswtw_.percent = Mathf.Lerp(arg_34_1.var_.oldValueTypewriter, var_37_27, var_37_32)
				arg_34_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_34_1.fswtw_:SetDirty()
			end

			if arg_34_1.time_ >= var_37_22 + var_37_31 and arg_34_1.time_ < var_37_22 + var_37_31 + arg_37_0 then
				arg_34_1.fswtw_.percent = var_37_27

				arg_34_1.fswtw_:SetDirty()
				arg_34_1:ShowNextGo(true)

				arg_34_1.typewritterCharCountI18N = var_37_28
			end

			local var_37_33 = 0

			if var_37_33 < arg_34_1.time_ and arg_34_1.time_ <= var_37_33 + arg_37_0 then
				local var_37_34 = manager.ui.mainCamera.transform.localPosition
				local var_37_35 = Vector3.New(0, 0, 10) + Vector3.New(var_37_34.x, var_37_34.y, 0)
				local var_37_36 = arg_34_1.bgs_.STblack

				var_37_36.transform.localPosition = var_37_35
				var_37_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_37_37 = var_37_36:GetComponent("SpriteRenderer")

				if var_37_37 and var_37_37.sprite then
					local var_37_38 = (var_37_36.transform.localPosition - var_37_34).z
					local var_37_39 = manager.ui.mainCameraCom_
					local var_37_40 = 2 * var_37_38 * Mathf.Tan(var_37_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_37_41 = var_37_40 * var_37_39.aspect
					local var_37_42 = var_37_37.sprite.bounds.size.x
					local var_37_43 = var_37_37.sprite.bounds.size.y
					local var_37_44 = var_37_41 / var_37_42
					local var_37_45 = var_37_40 / var_37_43
					local var_37_46 = var_37_45 < var_37_44 and var_37_44 or var_37_45

					var_37_36.transform.localScale = Vector3.New(var_37_46, var_37_46, 0)
				end

				for iter_37_0, iter_37_1 in pairs(arg_34_1.bgs_) do
					if iter_37_0 ~= "STblack" then
						iter_37_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_37_47 = 0

			if var_37_47 < arg_34_1.time_ and arg_34_1.time_ <= var_37_47 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_48 = 0.9

			if var_37_47 <= arg_34_1.time_ and arg_34_1.time_ < var_37_47 + var_37_48 then
				local var_37_49 = (arg_34_1.time_ - var_37_47) / var_37_48
				local var_37_50 = Color.New(0, 0, 0)

				var_37_50.a = Mathf.Lerp(1, 0, var_37_49)
				arg_34_1.mask_.color = var_37_50
			end

			if arg_34_1.time_ >= var_37_47 + var_37_48 and arg_34_1.time_ < var_37_47 + var_37_48 + arg_37_0 then
				local var_37_51 = Color.New(0, 0, 0)
				local var_37_52 = 0

				arg_34_1.mask_.enabled = false
				var_37_51.a = var_37_52
				arg_34_1.mask_.color = var_37_51
			end

			local var_37_53 = 0.5
			local var_37_54 = 2.033
			local var_37_55 = manager.audio:GetVoiceLength("story_v_out_319281", "319281008", "story_v_out_319281.awb") / 1000

			if var_37_55 > 0 and var_37_54 < var_37_55 and var_37_55 + var_37_53 > arg_34_1.duration_ then
				local var_37_56 = var_37_55

				arg_34_1.duration_ = var_37_55 + var_37_53
			end

			if var_37_53 < arg_34_1.time_ and arg_34_1.time_ <= var_37_53 + arg_37_0 then
				local var_37_57 = "play"
				local var_37_58 = "voice"

				arg_34_1:AudioAction(var_37_57, var_37_58, "story_v_out_319281", "319281008", "story_v_out_319281.awb")
			end

			local var_37_59 = 0

			if var_37_59 < arg_34_1.time_ and arg_34_1.time_ <= var_37_59 + arg_37_0 then
				arg_34_1.cswbg_:SetActive(false)

				local var_37_60 = arg_34_1.cswt_:GetComponent("RectTransform")

				arg_34_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_37_60.offsetMin = Vector2.New(400, 105)
				var_37_60.offsetMax = Vector2.New(-400, -200)

				local var_37_61 = arg_34_1:GetWordFromCfg(419003)
				local var_37_62 = arg_34_1:FormatText(var_37_61.content)

				arg_34_1.cswt_.text = var_37_62

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.cswt_)

				arg_34_1.cswt_.fontSize = 108
				arg_34_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_34_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_34_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_34_1.cswbg_:SetActive(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play319281009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 319281009
		arg_38_1.duration_ = 7.03

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play319281010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 1

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1.fswbg_:SetActive(false)
				arg_38_1.dialog_:SetActive(false)
				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_1 = 1.1

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.fswbg_:SetActive(false)
				arg_38_1.dialog_:SetActive(false)
				SetActive(arg_38_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_38_1:ShowNextGo(false)
			end

			local var_41_2 = 1

			if var_41_2 < arg_38_1.time_ and arg_38_1.time_ <= var_41_2 + arg_41_0 then
				arg_38_1.cswbg_:SetActive(false)
			end

			local var_41_3 = 0

			if var_41_3 < arg_38_1.time_ and arg_38_1.time_ <= var_41_3 + arg_41_0 then
				local var_41_4 = manager.ui.mainCamera.transform.localPosition
				local var_41_5 = Vector3.New(0, 0, 10) + Vector3.New(var_41_4.x, var_41_4.y, 0)
				local var_41_6 = arg_38_1.bgs_.STblack

				var_41_6.transform.localPosition = var_41_5
				var_41_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_41_7 = var_41_6:GetComponent("SpriteRenderer")

				if var_41_7 and var_41_7.sprite then
					local var_41_8 = (var_41_6.transform.localPosition - var_41_4).z
					local var_41_9 = manager.ui.mainCameraCom_
					local var_41_10 = 2 * var_41_8 * Mathf.Tan(var_41_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_41_11 = var_41_10 * var_41_9.aspect
					local var_41_12 = var_41_7.sprite.bounds.size.x
					local var_41_13 = var_41_7.sprite.bounds.size.y
					local var_41_14 = var_41_11 / var_41_12
					local var_41_15 = var_41_10 / var_41_13
					local var_41_16 = var_41_15 < var_41_14 and var_41_14 or var_41_15

					var_41_6.transform.localScale = Vector3.New(var_41_16, var_41_16, 0)
				end

				for iter_41_0, iter_41_1 in pairs(arg_38_1.bgs_) do
					if iter_41_0 ~= "STblack" then
						iter_41_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_41_17 = 1

			if var_41_17 < arg_38_1.time_ and arg_38_1.time_ <= var_41_17 + arg_41_0 then
				local var_41_18 = manager.ui.mainCamera.transform.localPosition
				local var_41_19 = Vector3.New(0, 0, 10) + Vector3.New(var_41_18.x, var_41_18.y, 0)
				local var_41_20 = arg_38_1.bgs_.STblack

				var_41_20.transform.localPosition = var_41_19
				var_41_20.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_41_21 = var_41_20:GetComponent("SpriteRenderer")

				if var_41_21 and var_41_21.sprite then
					local var_41_22 = (var_41_20.transform.localPosition - var_41_18).z
					local var_41_23 = manager.ui.mainCameraCom_
					local var_41_24 = 2 * var_41_22 * Mathf.Tan(var_41_23.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_41_25 = var_41_24 * var_41_23.aspect
					local var_41_26 = var_41_21.sprite.bounds.size.x
					local var_41_27 = var_41_21.sprite.bounds.size.y
					local var_41_28 = var_41_25 / var_41_26
					local var_41_29 = var_41_24 / var_41_27
					local var_41_30 = var_41_29 < var_41_28 and var_41_28 or var_41_29

					var_41_20.transform.localScale = Vector3.New(var_41_30, var_41_30, 0)
				end

				for iter_41_2, iter_41_3 in pairs(arg_38_1.bgs_) do
					if iter_41_2 ~= "STblack" then
						iter_41_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_41_31 = 0

			if var_41_31 < arg_38_1.time_ and arg_38_1.time_ <= var_41_31 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_32 = 1

			if var_41_31 <= arg_38_1.time_ and arg_38_1.time_ < var_41_31 + var_41_32 then
				local var_41_33 = (arg_38_1.time_ - var_41_31) / var_41_32
				local var_41_34 = Color.New(0, 0, 0)

				var_41_34.a = Mathf.Lerp(0, 1, var_41_33)
				arg_38_1.mask_.color = var_41_34
			end

			if arg_38_1.time_ >= var_41_31 + var_41_32 and arg_38_1.time_ < var_41_31 + var_41_32 + arg_41_0 then
				local var_41_35 = Color.New(0, 0, 0)

				var_41_35.a = 1
				arg_38_1.mask_.color = var_41_35
			end

			local var_41_36 = 1

			if var_41_36 < arg_38_1.time_ and arg_38_1.time_ <= var_41_36 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_37 = 1.33333333333333

			if var_41_36 <= arg_38_1.time_ and arg_38_1.time_ < var_41_36 + var_41_37 then
				local var_41_38 = (arg_38_1.time_ - var_41_36) / var_41_37
				local var_41_39 = Color.New(0, 0, 0)

				var_41_39.a = Mathf.Lerp(1, 0, var_41_38)
				arg_38_1.mask_.color = var_41_39
			end

			if arg_38_1.time_ >= var_41_36 + var_41_37 and arg_38_1.time_ < var_41_36 + var_41_37 + arg_41_0 then
				local var_41_40 = Color.New(0, 0, 0)
				local var_41_41 = 0

				arg_38_1.mask_.enabled = false
				var_41_40.a = var_41_41
				arg_38_1.mask_.color = var_41_40
			end

			if arg_38_1.frameCnt_ <= 1 then
				arg_38_1.dialog_:SetActive(false)
			end

			local var_41_42 = 2.03333333333333
			local var_41_43 = 0.9

			if var_41_42 < arg_38_1.time_ and arg_38_1.time_ <= var_41_42 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				arg_38_1.dialog_:SetActive(true)

				arg_38_1.dialogCg_.alpha = 0

				local var_41_44 = LeanTween.value(arg_38_1.dialog_, 0, 1, 0.3)

				var_41_44:setOnUpdate(LuaHelper.FloatAction(function(arg_42_0)
					arg_38_1.dialogCg_.alpha = arg_42_0
				end))
				var_41_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_38_1.dialog_)
					var_41_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_38_1.duration_ = arg_38_1.duration_ + 0.3

				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_45 = arg_38_1:GetWordFromCfg(319281009)
				local var_41_46 = arg_38_1:FormatText(var_41_45.content)

				arg_38_1.text_.text = var_41_46

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_47 = 36
				local var_41_48 = utf8.len(var_41_46)
				local var_41_49 = var_41_47 <= 0 and var_41_43 or var_41_43 * (var_41_48 / var_41_47)

				if var_41_49 > 0 and var_41_43 < var_41_49 then
					arg_38_1.talkMaxDuration = var_41_49
					var_41_42 = var_41_42 + 0.3

					if var_41_49 + var_41_42 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_49 + var_41_42
					end
				end

				arg_38_1.text_.text = var_41_46
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_50 = var_41_42 + 0.3
			local var_41_51 = math.max(var_41_43, arg_38_1.talkMaxDuration)

			if var_41_50 <= arg_38_1.time_ and arg_38_1.time_ < var_41_50 + var_41_51 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_50) / var_41_51

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_50 + var_41_51 and arg_38_1.time_ < var_41_50 + var_41_51 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play319281010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 319281010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play319281011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1.625

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(319281010)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 65
				local var_47_5 = utf8.len(var_47_3)
				local var_47_6 = var_47_4 <= 0 and var_47_1 or var_47_1 * (var_47_5 / var_47_4)

				if var_47_6 > 0 and var_47_1 < var_47_6 then
					arg_44_1.talkMaxDuration = var_47_6

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_7 and arg_44_1.time_ < var_47_0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play319281011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319281011
		arg_48_1.duration_ = 10.3

		local var_48_0 = {
			zh = 6.332999999999,
			ja = 10.299999999999
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
				arg_48_0:Play319281012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = "I10f"

			if arg_48_1.bgs_[var_51_0] == nil then
				local var_51_1 = Object.Instantiate(arg_48_1.paintGo_)

				var_51_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_51_0)
				var_51_1.name = var_51_0
				var_51_1.transform.parent = arg_48_1.stage_.transform
				var_51_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.bgs_[var_51_0] = var_51_1
			end

			local var_51_2 = 1.3

			if var_51_2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				local var_51_3 = manager.ui.mainCamera.transform.localPosition
				local var_51_4 = Vector3.New(0, 0, 10) + Vector3.New(var_51_3.x, var_51_3.y, 0)
				local var_51_5 = arg_48_1.bgs_.I10f

				var_51_5.transform.localPosition = var_51_4
				var_51_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_51_6 = var_51_5:GetComponent("SpriteRenderer")

				if var_51_6 and var_51_6.sprite then
					local var_51_7 = (var_51_5.transform.localPosition - var_51_3).z
					local var_51_8 = manager.ui.mainCameraCom_
					local var_51_9 = 2 * var_51_7 * Mathf.Tan(var_51_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_51_10 = var_51_9 * var_51_8.aspect
					local var_51_11 = var_51_6.sprite.bounds.size.x
					local var_51_12 = var_51_6.sprite.bounds.size.y
					local var_51_13 = var_51_10 / var_51_11
					local var_51_14 = var_51_9 / var_51_12
					local var_51_15 = var_51_14 < var_51_13 and var_51_13 or var_51_14

					var_51_5.transform.localScale = Vector3.New(var_51_15, var_51_15, 0)
				end

				for iter_51_0, iter_51_1 in pairs(arg_48_1.bgs_) do
					if iter_51_0 ~= "I10f" then
						iter_51_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_51_16 = 0

			if var_51_16 < arg_48_1.time_ and arg_48_1.time_ <= var_51_16 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_17 = 1.3

			if var_51_16 <= arg_48_1.time_ and arg_48_1.time_ < var_51_16 + var_51_17 then
				local var_51_18 = (arg_48_1.time_ - var_51_16) / var_51_17
				local var_51_19 = Color.New(0, 0, 0)

				var_51_19.a = Mathf.Lerp(0, 1, var_51_18)
				arg_48_1.mask_.color = var_51_19
			end

			if arg_48_1.time_ >= var_51_16 + var_51_17 and arg_48_1.time_ < var_51_16 + var_51_17 + arg_51_0 then
				local var_51_20 = Color.New(0, 0, 0)

				var_51_20.a = 1
				arg_48_1.mask_.color = var_51_20
			end

			local var_51_21 = 1.3

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_22 = 2

			if var_51_21 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_22 then
				local var_51_23 = (arg_48_1.time_ - var_51_21) / var_51_22
				local var_51_24 = Color.New(0, 0, 0)

				var_51_24.a = Mathf.Lerp(1, 0, var_51_23)
				arg_48_1.mask_.color = var_51_24
			end

			if arg_48_1.time_ >= var_51_21 + var_51_22 and arg_48_1.time_ < var_51_21 + var_51_22 + arg_51_0 then
				local var_51_25 = Color.New(0, 0, 0)
				local var_51_26 = 0

				arg_48_1.mask_.enabled = false
				var_51_25.a = var_51_26
				arg_48_1.mask_.color = var_51_25
			end

			if arg_48_1.frameCnt_ <= 1 then
				arg_48_1.dialog_:SetActive(false)
			end

			local var_51_27 = 3.299999999999
			local var_51_28 = 0.05

			if var_51_27 < arg_48_1.time_ and arg_48_1.time_ <= var_51_27 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0

				arg_48_1.dialog_:SetActive(true)

				arg_48_1.dialogCg_.alpha = 0

				local var_51_29 = LeanTween.value(arg_48_1.dialog_, 0, 1, 0.3)

				var_51_29:setOnUpdate(LuaHelper.FloatAction(function(arg_52_0)
					arg_48_1.dialogCg_.alpha = arg_52_0
				end))
				var_51_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_48_1.dialog_)
					var_51_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_48_1.duration_ = arg_48_1.duration_ + 0.3

				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_30 = arg_48_1:FormatText(StoryNameCfg[6].name)

				arg_48_1.leftNameTxt_.text = var_51_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_31 = arg_48_1:GetWordFromCfg(319281011)
				local var_51_32 = arg_48_1:FormatText(var_51_31.content)

				arg_48_1.text_.text = var_51_32

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_33 = 2
				local var_51_34 = utf8.len(var_51_32)
				local var_51_35 = var_51_33 <= 0 and var_51_28 or var_51_28 * (var_51_34 / var_51_33)

				if var_51_35 > 0 and var_51_28 < var_51_35 then
					arg_48_1.talkMaxDuration = var_51_35
					var_51_27 = var_51_27 + 0.3

					if var_51_35 + var_51_27 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_35 + var_51_27
					end
				end

				arg_48_1.text_.text = var_51_32
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281011", "story_v_out_319281.awb") ~= 0 then
					local var_51_36 = manager.audio:GetVoiceLength("story_v_out_319281", "319281011", "story_v_out_319281.awb") / 1000

					if var_51_36 + var_51_27 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_36 + var_51_27
					end

					if var_51_31.prefab_name ~= "" and arg_48_1.actors_[var_51_31.prefab_name] ~= nil then
						local var_51_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_31.prefab_name].transform, "story_v_out_319281", "319281011", "story_v_out_319281.awb")

						arg_48_1:RecordAudio("319281011", var_51_37)
						arg_48_1:RecordAudio("319281011", var_51_37)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_319281", "319281011", "story_v_out_319281.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_319281", "319281011", "story_v_out_319281.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_38 = var_51_27 + 0.3
			local var_51_39 = math.max(var_51_28, arg_48_1.talkMaxDuration)

			if var_51_38 <= arg_48_1.time_ and arg_48_1.time_ < var_51_38 + var_51_39 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_38) / var_51_39

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_38 + var_51_39 and arg_48_1.time_ < var_51_38 + var_51_39 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play319281012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 319281012
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play319281013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0
			local var_57_1 = 1.1

			if var_57_0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_2 = arg_54_1:GetWordFromCfg(319281012)
				local var_57_3 = arg_54_1:FormatText(var_57_2.content)

				arg_54_1.text_.text = var_57_3

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 44
				local var_57_5 = utf8.len(var_57_3)
				local var_57_6 = var_57_4 <= 0 and var_57_1 or var_57_1 * (var_57_5 / var_57_4)

				if var_57_6 > 0 and var_57_1 < var_57_6 then
					arg_54_1.talkMaxDuration = var_57_6

					if var_57_6 + var_57_0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_6 + var_57_0
					end
				end

				arg_54_1.text_.text = var_57_3
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_1, arg_54_1.talkMaxDuration)

			if var_57_0 <= arg_54_1.time_ and arg_54_1.time_ < var_57_0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_0 + var_57_7 and arg_54_1.time_ < var_57_0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play319281013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 319281013
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play319281014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0
			local var_61_1 = 1.475

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_2 = arg_58_1:GetWordFromCfg(319281013)
				local var_61_3 = arg_58_1:FormatText(var_61_2.content)

				arg_58_1.text_.text = var_61_3

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 59
				local var_61_5 = utf8.len(var_61_3)
				local var_61_6 = var_61_4 <= 0 and var_61_1 or var_61_1 * (var_61_5 / var_61_4)

				if var_61_6 > 0 and var_61_1 < var_61_6 then
					arg_58_1.talkMaxDuration = var_61_6

					if var_61_6 + var_61_0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_6 + var_61_0
					end
				end

				arg_58_1.text_.text = var_61_3
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_1, arg_58_1.talkMaxDuration)

			if var_61_0 <= arg_58_1.time_ and arg_58_1.time_ < var_61_0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_0 + var_61_7 and arg_58_1.time_ < var_61_0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play319281014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 319281014
		arg_62_1.duration_ = 6.77

		local var_62_0 = {
			zh = 2.2,
			ja = 6.766
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
				arg_62_0:Play319281015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 0.225

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_2 = arg_62_1:FormatText(StoryNameCfg[6].name)

				arg_62_1.leftNameTxt_.text = var_65_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_3 = arg_62_1:GetWordFromCfg(319281014)
				local var_65_4 = arg_62_1:FormatText(var_65_3.content)

				arg_62_1.text_.text = var_65_4

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_5 = 9
				local var_65_6 = utf8.len(var_65_4)
				local var_65_7 = var_65_5 <= 0 and var_65_1 or var_65_1 * (var_65_6 / var_65_5)

				if var_65_7 > 0 and var_65_1 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_4
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281014", "story_v_out_319281.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_319281", "319281014", "story_v_out_319281.awb") / 1000

					if var_65_8 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_0
					end

					if var_65_3.prefab_name ~= "" and arg_62_1.actors_[var_65_3.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_3.prefab_name].transform, "story_v_out_319281", "319281014", "story_v_out_319281.awb")

						arg_62_1:RecordAudio("319281014", var_65_9)
						arg_62_1:RecordAudio("319281014", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_319281", "319281014", "story_v_out_319281.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_319281", "319281014", "story_v_out_319281.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_10 and arg_62_1.time_ < var_65_0 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play319281015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 319281015
		arg_66_1.duration_ = 4.3

		local var_66_0 = {
			zh = 4.3,
			ja = 3.2
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
				arg_66_0:Play319281016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = "10079ui_story"

			if arg_66_1.actors_[var_69_0] == nil then
				local var_69_1 = Asset.Load("Char/" .. "10079ui_story")

				if not isNil(var_69_1) then
					local var_69_2 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_66_1.stage_.transform)

					var_69_2.name = var_69_0
					var_69_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_66_1.actors_[var_69_0] = var_69_2

					local var_69_3 = var_69_2:GetComponentInChildren(typeof(CharacterEffect))

					var_69_3.enabled = true

					local var_69_4 = GameObjectTools.GetOrAddComponent(var_69_2, typeof(DynamicBoneHelper))

					if var_69_4 then
						var_69_4:EnableDynamicBone(false)
					end

					arg_66_1:ShowWeapon(var_69_3.transform, false)

					arg_66_1.var_[var_69_0 .. "Animator"] = var_69_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_66_1.var_[var_69_0 .. "Animator"].applyRootMotion = true
					arg_66_1.var_[var_69_0 .. "LipSync"] = var_69_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_69_6 = 0

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_69_7 = arg_66_1.actors_["1184ui_story"]
			local var_69_8 = 0

			if var_69_8 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 and not isNil(var_69_7) and arg_66_1.var_.characterEffect1184ui_story == nil then
				arg_66_1.var_.characterEffect1184ui_story = var_69_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_9 = 0.200000002980232

			if var_69_8 <= arg_66_1.time_ and arg_66_1.time_ < var_69_8 + var_69_9 and not isNil(var_69_7) then
				local var_69_10 = (arg_66_1.time_ - var_69_8) / var_69_9

				if arg_66_1.var_.characterEffect1184ui_story and not isNil(var_69_7) then
					arg_66_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_8 + var_69_9 and arg_66_1.time_ < var_69_8 + var_69_9 + arg_69_0 and not isNil(var_69_7) and arg_66_1.var_.characterEffect1184ui_story then
				arg_66_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_69_11 = arg_66_1.actors_["10079ui_story"].transform
			local var_69_12 = 0

			if var_69_12 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 then
				arg_66_1.var_.moveOldPos10079ui_story = var_69_11.localPosition

				local var_69_13 = "10079ui_story"

				arg_66_1:ShowWeapon(arg_66_1.var_[var_69_13 .. "Animator"].transform, false)
			end

			local var_69_14 = 0.001

			if var_69_12 <= arg_66_1.time_ and arg_66_1.time_ < var_69_12 + var_69_14 then
				local var_69_15 = (arg_66_1.time_ - var_69_12) / var_69_14
				local var_69_16 = Vector3.New(0, -0.95, -6.05)

				var_69_11.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10079ui_story, var_69_16, var_69_15)

				local var_69_17 = manager.ui.mainCamera.transform.position - var_69_11.position

				var_69_11.forward = Vector3.New(var_69_17.x, var_69_17.y, var_69_17.z)

				local var_69_18 = var_69_11.localEulerAngles

				var_69_18.z = 0
				var_69_18.x = 0
				var_69_11.localEulerAngles = var_69_18
			end

			if arg_66_1.time_ >= var_69_12 + var_69_14 and arg_66_1.time_ < var_69_12 + var_69_14 + arg_69_0 then
				var_69_11.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_69_19 = manager.ui.mainCamera.transform.position - var_69_11.position

				var_69_11.forward = Vector3.New(var_69_19.x, var_69_19.y, var_69_19.z)

				local var_69_20 = var_69_11.localEulerAngles

				var_69_20.z = 0
				var_69_20.x = 0
				var_69_11.localEulerAngles = var_69_20
			end

			local var_69_21 = 0
			local var_69_22 = 0.35

			if var_69_21 < arg_66_1.time_ and arg_66_1.time_ <= var_69_21 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_23 = arg_66_1:FormatText(StoryNameCfg[6].name)

				arg_66_1.leftNameTxt_.text = var_69_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_24 = arg_66_1:GetWordFromCfg(319281015)
				local var_69_25 = arg_66_1:FormatText(var_69_24.content)

				arg_66_1.text_.text = var_69_25

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_26 = 14
				local var_69_27 = utf8.len(var_69_25)
				local var_69_28 = var_69_26 <= 0 and var_69_22 or var_69_22 * (var_69_27 / var_69_26)

				if var_69_28 > 0 and var_69_22 < var_69_28 then
					arg_66_1.talkMaxDuration = var_69_28

					if var_69_28 + var_69_21 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_28 + var_69_21
					end
				end

				arg_66_1.text_.text = var_69_25
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281015", "story_v_out_319281.awb") ~= 0 then
					local var_69_29 = manager.audio:GetVoiceLength("story_v_out_319281", "319281015", "story_v_out_319281.awb") / 1000

					if var_69_29 + var_69_21 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_29 + var_69_21
					end

					if var_69_24.prefab_name ~= "" and arg_66_1.actors_[var_69_24.prefab_name] ~= nil then
						local var_69_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_24.prefab_name].transform, "story_v_out_319281", "319281015", "story_v_out_319281.awb")

						arg_66_1:RecordAudio("319281015", var_69_30)
						arg_66_1:RecordAudio("319281015", var_69_30)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_319281", "319281015", "story_v_out_319281.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_319281", "319281015", "story_v_out_319281.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_31 = math.max(var_69_22, arg_66_1.talkMaxDuration)

			if var_69_21 <= arg_66_1.time_ and arg_66_1.time_ < var_69_21 + var_69_31 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_21) / var_69_31

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_21 + var_69_31 and arg_66_1.time_ < var_69_21 + var_69_31 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play319281016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 319281016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play319281017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10079ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10079ui_story == nil then
				arg_70_1.var_.characterEffect10079ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect10079ui_story and not isNil(var_73_0) then
					local var_73_4 = Mathf.Lerp(0, 0.5, var_73_3)

					arg_70_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10079ui_story.fillRatio = var_73_4
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect10079ui_story then
				local var_73_5 = 0.5

				arg_70_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10079ui_story.fillRatio = var_73_5
			end

			local var_73_6 = 0
			local var_73_7 = 1.525

			if var_73_6 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_8 = arg_70_1:GetWordFromCfg(319281016)
				local var_73_9 = arg_70_1:FormatText(var_73_8.content)

				arg_70_1.text_.text = var_73_9

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_10 = 61
				local var_73_11 = utf8.len(var_73_9)
				local var_73_12 = var_73_10 <= 0 and var_73_7 or var_73_7 * (var_73_11 / var_73_10)

				if var_73_12 > 0 and var_73_7 < var_73_12 then
					arg_70_1.talkMaxDuration = var_73_12

					if var_73_12 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_12 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_9
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_13 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_13 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_13

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_13 and arg_70_1.time_ < var_73_6 + var_73_13 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play319281017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 319281017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play319281018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 1.525

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_2 = arg_74_1:GetWordFromCfg(319281017)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 61
				local var_77_5 = utf8.len(var_77_3)
				local var_77_6 = var_77_4 <= 0 and var_77_1 or var_77_1 * (var_77_5 / var_77_4)

				if var_77_6 > 0 and var_77_1 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_7 and arg_74_1.time_ < var_77_0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play319281018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 319281018
		arg_78_1.duration_ = 7.6

		local var_78_0 = {
			zh = 5.5,
			ja = 7.6
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
				arg_78_0:Play319281019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["10079ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10079ui_story == nil then
				arg_78_1.var_.characterEffect10079ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.200000002980232

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect10079ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect10079ui_story then
				arg_78_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_81_4 = 0
			local var_81_5 = 0.5

			if var_81_4 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_6 = arg_78_1:FormatText(StoryNameCfg[6].name)

				arg_78_1.leftNameTxt_.text = var_81_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_7 = arg_78_1:GetWordFromCfg(319281018)
				local var_81_8 = arg_78_1:FormatText(var_81_7.content)

				arg_78_1.text_.text = var_81_8

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281018", "story_v_out_319281.awb") ~= 0 then
					local var_81_12 = manager.audio:GetVoiceLength("story_v_out_319281", "319281018", "story_v_out_319281.awb") / 1000

					if var_81_12 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_12 + var_81_4
					end

					if var_81_7.prefab_name ~= "" and arg_78_1.actors_[var_81_7.prefab_name] ~= nil then
						local var_81_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_7.prefab_name].transform, "story_v_out_319281", "319281018", "story_v_out_319281.awb")

						arg_78_1:RecordAudio("319281018", var_81_13)
						arg_78_1:RecordAudio("319281018", var_81_13)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_319281", "319281018", "story_v_out_319281.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_319281", "319281018", "story_v_out_319281.awb")
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
	Play319281019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 319281019
		arg_82_1.duration_ = 4.1

		local var_82_0 = {
			zh = 4.1,
			ja = 3.633
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
				arg_82_0:Play319281020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_85_2 = 0
			local var_85_3 = 0.225

			if var_85_2 < arg_82_1.time_ and arg_82_1.time_ <= var_85_2 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_4 = arg_82_1:FormatText(StoryNameCfg[6].name)

				arg_82_1.leftNameTxt_.text = var_85_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_5 = arg_82_1:GetWordFromCfg(319281019)
				local var_85_6 = arg_82_1:FormatText(var_85_5.content)

				arg_82_1.text_.text = var_85_6

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_7 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281019", "story_v_out_319281.awb") ~= 0 then
					local var_85_10 = manager.audio:GetVoiceLength("story_v_out_319281", "319281019", "story_v_out_319281.awb") / 1000

					if var_85_10 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_2
					end

					if var_85_5.prefab_name ~= "" and arg_82_1.actors_[var_85_5.prefab_name] ~= nil then
						local var_85_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_5.prefab_name].transform, "story_v_out_319281", "319281019", "story_v_out_319281.awb")

						arg_82_1:RecordAudio("319281019", var_85_11)
						arg_82_1:RecordAudio("319281019", var_85_11)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_319281", "319281019", "story_v_out_319281.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_319281", "319281019", "story_v_out_319281.awb")
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
	Play319281020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 319281020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play319281021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10079ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10079ui_story == nil then
				arg_86_1.var_.characterEffect10079ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect10079ui_story and not isNil(var_89_0) then
					local var_89_4 = Mathf.Lerp(0, 0.5, var_89_3)

					arg_86_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10079ui_story.fillRatio = var_89_4
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10079ui_story then
				local var_89_5 = 0.5

				arg_86_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10079ui_story.fillRatio = var_89_5
			end

			local var_89_6 = 0
			local var_89_7 = 1.225

			if var_89_6 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_8 = arg_86_1:GetWordFromCfg(319281020)
				local var_89_9 = arg_86_1:FormatText(var_89_8.content)

				arg_86_1.text_.text = var_89_9

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_10 = 49
				local var_89_11 = utf8.len(var_89_9)
				local var_89_12 = var_89_10 <= 0 and var_89_7 or var_89_7 * (var_89_11 / var_89_10)

				if var_89_12 > 0 and var_89_7 < var_89_12 then
					arg_86_1.talkMaxDuration = var_89_12

					if var_89_12 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_12 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_9
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_13 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_13 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_13

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_13 and arg_86_1.time_ < var_89_6 + var_89_13 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play319281021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 319281021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play319281022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0
			local var_93_1 = 1.15

			if var_93_0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_2 = arg_90_1:GetWordFromCfg(319281021)
				local var_93_3 = arg_90_1:FormatText(var_93_2.content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 46
				local var_93_5 = utf8.len(var_93_3)
				local var_93_6 = var_93_4 <= 0 and var_93_1 or var_93_1 * (var_93_5 / var_93_4)

				if var_93_6 > 0 and var_93_1 < var_93_6 then
					arg_90_1.talkMaxDuration = var_93_6

					if var_93_6 + var_93_0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_6 + var_93_0
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_1, arg_90_1.talkMaxDuration)

			if var_93_0 <= arg_90_1.time_ and arg_90_1.time_ < var_93_0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_0 + var_93_7 and arg_90_1.time_ < var_93_0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play319281022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 319281022
		arg_94_1.duration_ = 8.73

		local var_94_0 = {
			zh = 6.766,
			ja = 8.733
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
				arg_94_0:Play319281023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["10079ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10079ui_story == nil then
				arg_94_1.var_.characterEffect10079ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect10079ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10079ui_story then
				arg_94_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_97_4 = 0
			local var_97_5 = 0.575

			if var_97_4 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_6 = arg_94_1:FormatText(StoryNameCfg[6].name)

				arg_94_1.leftNameTxt_.text = var_97_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_7 = arg_94_1:GetWordFromCfg(319281022)
				local var_97_8 = arg_94_1:FormatText(var_97_7.content)

				arg_94_1.text_.text = var_97_8

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 23
				local var_97_10 = utf8.len(var_97_8)
				local var_97_11 = var_97_9 <= 0 and var_97_5 or var_97_5 * (var_97_10 / var_97_9)

				if var_97_11 > 0 and var_97_5 < var_97_11 then
					arg_94_1.talkMaxDuration = var_97_11

					if var_97_11 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_11 + var_97_4
					end
				end

				arg_94_1.text_.text = var_97_8
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281022", "story_v_out_319281.awb") ~= 0 then
					local var_97_12 = manager.audio:GetVoiceLength("story_v_out_319281", "319281022", "story_v_out_319281.awb") / 1000

					if var_97_12 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_12 + var_97_4
					end

					if var_97_7.prefab_name ~= "" and arg_94_1.actors_[var_97_7.prefab_name] ~= nil then
						local var_97_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_7.prefab_name].transform, "story_v_out_319281", "319281022", "story_v_out_319281.awb")

						arg_94_1:RecordAudio("319281022", var_97_13)
						arg_94_1:RecordAudio("319281022", var_97_13)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_319281", "319281022", "story_v_out_319281.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_319281", "319281022", "story_v_out_319281.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_14 = math.max(var_97_5, arg_94_1.talkMaxDuration)

			if var_97_4 <= arg_94_1.time_ and arg_94_1.time_ < var_97_4 + var_97_14 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_4) / var_97_14

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_4 + var_97_14 and arg_94_1.time_ < var_97_4 + var_97_14 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play319281023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 319281023
		arg_98_1.duration_ = 2

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play319281024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["10079ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos10079ui_story = var_101_0.localPosition
			end

			local var_101_2 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2
				local var_101_4 = Vector3.New(0, 100, 0)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10079ui_story, var_101_4, var_101_3)

				local var_101_5 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_5.x, var_101_5.y, var_101_5.z)

				local var_101_6 = var_101_0.localEulerAngles

				var_101_6.z = 0
				var_101_6.x = 0
				var_101_0.localEulerAngles = var_101_6
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0, 100, 0)

				local var_101_7 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_7.x, var_101_7.y, var_101_7.z)

				local var_101_8 = var_101_0.localEulerAngles

				var_101_8.z = 0
				var_101_8.x = 0
				var_101_0.localEulerAngles = var_101_8
			end

			local var_101_9 = 0

			if var_101_9 < arg_98_1.time_ and arg_98_1.time_ <= var_101_9 + arg_101_0 then
				local var_101_10 = arg_98_1.fswbg_.transform:Find("textbox/adapt/content") or arg_98_1.fswbg_.transform:Find("textbox/content")
				local var_101_11 = arg_98_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_101_12 = var_101_10:GetComponent("Text")
				local var_101_13 = var_101_10:GetComponent("RectTransform")

				var_101_12.alignment = UnityEngine.TextAnchor.LowerCenter
				var_101_13.offsetMin = Vector2.New(0, 0)
				var_101_13.offsetMax = Vector2.New(0, 0)
			end

			local var_101_14 = 0

			if var_101_14 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				arg_98_1.fswbg_:SetActive(true)
				arg_98_1.dialog_:SetActive(false)

				arg_98_1.fswtw_.percent = 0

				local var_101_15 = arg_98_1:GetWordFromCfg(319281023)
				local var_101_16 = arg_98_1:FormatText(var_101_15.content)

				arg_98_1.fswt_.text = var_101_16

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.fswt_)

				arg_98_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_98_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_98_1.fswtw_:SetDirty()

				arg_98_1.typewritterCharCountI18N = 0

				SetActive(arg_98_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_98_1:ShowNextGo(false)
			end

			local var_101_17 = 0.3

			if var_101_17 < arg_98_1.time_ and arg_98_1.time_ <= var_101_17 + arg_101_0 then
				arg_98_1.var_.oldValueTypewriter = arg_98_1.fswtw_.percent

				SetActive(arg_98_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_98_1:ShowNextGo(false)
			end

			local var_101_18 = 4
			local var_101_19 = 0.266666666666667
			local var_101_20 = arg_98_1:GetWordFromCfg(319281023)
			local var_101_21 = arg_98_1:FormatText(var_101_20.content)
			local var_101_22, var_101_23 = arg_98_1:GetPercentByPara(var_101_21, 1)

			if var_101_17 < arg_98_1.time_ and arg_98_1.time_ <= var_101_17 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				local var_101_24 = var_101_18 <= 0 and var_101_19 or var_101_19 * ((var_101_23 - arg_98_1.typewritterCharCountI18N) / var_101_18)

				if var_101_24 > 0 and var_101_19 < var_101_24 then
					arg_98_1.talkMaxDuration = var_101_24

					if var_101_24 + var_101_17 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_24 + var_101_17
					end
				end
			end

			local var_101_25 = 0.266666666666667
			local var_101_26 = math.max(var_101_25, arg_98_1.talkMaxDuration)

			if var_101_17 <= arg_98_1.time_ and arg_98_1.time_ < var_101_17 + var_101_26 then
				local var_101_27 = (arg_98_1.time_ - var_101_17) / var_101_26

				arg_98_1.fswtw_.percent = Mathf.Lerp(arg_98_1.var_.oldValueTypewriter, var_101_22, var_101_27)
				arg_98_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_98_1.fswtw_:SetDirty()
			end

			if arg_98_1.time_ >= var_101_17 + var_101_26 and arg_98_1.time_ < var_101_17 + var_101_26 + arg_101_0 then
				arg_98_1.fswtw_.percent = var_101_22

				arg_98_1.fswtw_:SetDirty()
				arg_98_1:ShowNextGo(true)

				arg_98_1.typewritterCharCountI18N = var_101_23
			end

			local var_101_28 = 0

			if var_101_28 < arg_98_1.time_ and arg_98_1.time_ <= var_101_28 + arg_101_0 then
				local var_101_29 = manager.ui.mainCamera.transform.localPosition
				local var_101_30 = Vector3.New(0, 0, 10) + Vector3.New(var_101_29.x, var_101_29.y, 0)
				local var_101_31 = arg_98_1.bgs_.STblack

				var_101_31.transform.localPosition = var_101_30
				var_101_31.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_32 = var_101_31:GetComponent("SpriteRenderer")

				if var_101_32 and var_101_32.sprite then
					local var_101_33 = (var_101_31.transform.localPosition - var_101_29).z
					local var_101_34 = manager.ui.mainCameraCom_
					local var_101_35 = 2 * var_101_33 * Mathf.Tan(var_101_34.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_101_36 = var_101_35 * var_101_34.aspect
					local var_101_37 = var_101_32.sprite.bounds.size.x
					local var_101_38 = var_101_32.sprite.bounds.size.y
					local var_101_39 = var_101_36 / var_101_37
					local var_101_40 = var_101_35 / var_101_38
					local var_101_41 = var_101_40 < var_101_39 and var_101_39 or var_101_40

					var_101_31.transform.localScale = Vector3.New(var_101_41, var_101_41, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "STblack" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_101_42 = 0.3
			local var_101_43 = 1.466
			local var_101_44 = manager.audio:GetVoiceLength("story_v_out_319281", "319281023", "story_v_out_319281.awb") / 1000

			if var_101_44 > 0 and var_101_43 < var_101_44 and var_101_44 + var_101_42 > arg_98_1.duration_ then
				local var_101_45 = var_101_44

				arg_98_1.duration_ = var_101_44 + var_101_42
			end

			if var_101_42 < arg_98_1.time_ and arg_98_1.time_ <= var_101_42 + arg_101_0 then
				local var_101_46 = "play"
				local var_101_47 = "voice"

				arg_98_1:AudioAction(var_101_46, var_101_47, "story_v_out_319281", "319281023", "story_v_out_319281.awb")
			end

			local var_101_48 = 0

			if var_101_48 < arg_98_1.time_ and arg_98_1.time_ <= var_101_48 + arg_101_0 then
				arg_98_1.cswbg_:SetActive(false)

				local var_101_49 = arg_98_1.cswt_:GetComponent("RectTransform")

				arg_98_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_101_49.offsetMin = Vector2.New(400, 105)
				var_101_49.offsetMax = Vector2.New(-400, -200)

				local var_101_50 = arg_98_1:GetWordFromCfg(419004)
				local var_101_51 = arg_98_1:FormatText(var_101_50.content)

				arg_98_1.cswt_.text = var_101_51

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.cswt_)

				arg_98_1.cswt_.fontSize = 108
				arg_98_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_98_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_98_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_98_1.cswbg_:SetActive(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play319281024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 319281024
		arg_102_1.duration_ = 6.33

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play319281025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 1.33333333333333

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				local var_105_1 = arg_102_1.fswbg_.transform:Find("textbox/adapt/content") or arg_102_1.fswbg_.transform:Find("textbox/content")
				local var_105_2 = arg_102_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_105_3 = var_105_1:GetComponent("Text")
				local var_105_4 = var_105_1:GetComponent("RectTransform")

				var_105_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_105_4.offsetMin = Vector2.New(0, 0)
				var_105_4.offsetMax = Vector2.New(0, 0)
			end

			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1.fswbg_:SetActive(true)
				arg_102_1.dialog_:SetActive(false)

				arg_102_1.fswtw_.percent = 0

				local var_105_6 = arg_102_1:GetWordFromCfg(319281024)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.fswt_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.fswt_)

				arg_102_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_102_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_102_1.fswtw_:SetDirty()

				arg_102_1.typewritterCharCountI18N = 0

				SetActive(arg_102_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_102_1:ShowNextGo(false)
			end

			local var_105_8 = 0.3

			if var_105_8 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.var_.oldValueTypewriter = arg_102_1.fswtw_.percent

				SetActive(arg_102_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_102_1:ShowNextGo(false)
			end

			local var_105_9 = 9
			local var_105_10 = 0.6
			local var_105_11 = arg_102_1:GetWordFromCfg(319281024)
			local var_105_12 = arg_102_1:FormatText(var_105_11.content)
			local var_105_13, var_105_14 = arg_102_1:GetPercentByPara(var_105_12, 1)

			if var_105_8 < arg_102_1.time_ and arg_102_1.time_ <= var_105_8 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				local var_105_15 = var_105_9 <= 0 and var_105_10 or var_105_10 * ((var_105_14 - arg_102_1.typewritterCharCountI18N) / var_105_9)

				if var_105_15 > 0 and var_105_10 < var_105_15 then
					arg_102_1.talkMaxDuration = var_105_15

					if var_105_15 + var_105_8 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_15 + var_105_8
					end
				end
			end

			local var_105_16 = 0.6
			local var_105_17 = math.max(var_105_16, arg_102_1.talkMaxDuration)

			if var_105_8 <= arg_102_1.time_ and arg_102_1.time_ < var_105_8 + var_105_17 then
				local var_105_18 = (arg_102_1.time_ - var_105_8) / var_105_17

				arg_102_1.fswtw_.percent = Mathf.Lerp(arg_102_1.var_.oldValueTypewriter, var_105_13, var_105_18)
				arg_102_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_102_1.fswtw_:SetDirty()
			end

			if arg_102_1.time_ >= var_105_8 + var_105_17 and arg_102_1.time_ < var_105_8 + var_105_17 + arg_105_0 then
				arg_102_1.fswtw_.percent = var_105_13

				arg_102_1.fswtw_:SetDirty()
				arg_102_1:ShowNextGo(true)

				arg_102_1.typewritterCharCountI18N = var_105_14
			end

			local var_105_19 = 0

			if var_105_19 < arg_102_1.time_ and arg_102_1.time_ <= var_105_19 + arg_105_0 then
				arg_102_1.cswbg_:SetActive(false)

				local var_105_20 = arg_102_1.cswt_:GetComponent("RectTransform")

				arg_102_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_105_20.offsetMin = Vector2.New(410, 330)
				var_105_20.offsetMax = Vector2.New(-400, -175)

				local var_105_21 = arg_102_1:GetWordFromCfg(419005)
				local var_105_22 = arg_102_1:FormatText(var_105_21.content)

				arg_102_1.cswt_.text = var_105_22

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.cswt_)

				arg_102_1.cswt_.fontSize = 180
				arg_102_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_102_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_102_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_102_1.cswbg_:SetActive(true)
			end

			local var_105_23 = 0

			if var_105_23 < arg_102_1.time_ and arg_102_1.time_ <= var_105_23 + arg_105_0 then
				local var_105_24 = manager.ui.mainCamera.transform.localPosition
				local var_105_25 = Vector3.New(0, 0, 10) + Vector3.New(var_105_24.x, var_105_24.y, 0)
				local var_105_26 = arg_102_1.bgs_.STblack

				var_105_26.transform.localPosition = var_105_25
				var_105_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_105_27 = var_105_26:GetComponent("SpriteRenderer")

				if var_105_27 and var_105_27.sprite then
					local var_105_28 = (var_105_26.transform.localPosition - var_105_24).z
					local var_105_29 = manager.ui.mainCameraCom_
					local var_105_30 = 2 * var_105_28 * Mathf.Tan(var_105_29.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_105_31 = var_105_30 * var_105_29.aspect
					local var_105_32 = var_105_27.sprite.bounds.size.x
					local var_105_33 = var_105_27.sprite.bounds.size.y
					local var_105_34 = var_105_31 / var_105_32
					local var_105_35 = var_105_30 / var_105_33
					local var_105_36 = var_105_35 < var_105_34 and var_105_34 or var_105_35

					var_105_26.transform.localScale = Vector3.New(var_105_36, var_105_36, 0)
				end

				for iter_105_0, iter_105_1 in pairs(arg_102_1.bgs_) do
					if iter_105_0 ~= "STblack" then
						iter_105_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_105_37 = 0.3
			local var_105_38 = 1.7
			local var_105_39 = manager.audio:GetVoiceLength("story_v_out_319281", "319281024", "story_v_out_319281.awb") / 1000

			if var_105_39 > 0 and var_105_38 < var_105_39 and var_105_39 + var_105_37 > arg_102_1.duration_ then
				local var_105_40 = var_105_39

				arg_102_1.duration_ = var_105_39 + var_105_37
			end

			if var_105_37 < arg_102_1.time_ and arg_102_1.time_ <= var_105_37 + arg_105_0 then
				local var_105_41 = "play"
				local var_105_42 = "voice"

				arg_102_1:AudioAction(var_105_41, var_105_42, "story_v_out_319281", "319281024", "story_v_out_319281.awb")
			end

			local var_105_43 = 0

			if var_105_43 < arg_102_1.time_ and arg_102_1.time_ <= var_105_43 + arg_105_0 then
				arg_102_1.cswbg_:SetActive(false)

				local var_105_44 = arg_102_1.cswt_:GetComponent("RectTransform")

				arg_102_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_105_44.offsetMin = Vector2.New(400, 105)
				var_105_44.offsetMax = Vector2.New(-400, -200)

				local var_105_45 = arg_102_1:GetWordFromCfg(419005)
				local var_105_46 = arg_102_1:FormatText(var_105_45.content)

				arg_102_1.cswt_.text = var_105_46

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.cswt_)

				arg_102_1.cswt_.fontSize = 108
				arg_102_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_102_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_102_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_102_1.cswbg_:SetActive(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play319281025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 319281025
		arg_106_1.duration_ = 5.28

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play319281026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.fswbg_:SetActive(false)
				arg_106_1.dialog_:SetActive(false)
				SetActive(arg_106_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_106_1:ShowNextGo(false)
			end

			local var_109_1 = 0.166666666666667

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.fswbg_:SetActive(false)
				arg_106_1.dialog_:SetActive(false)
				SetActive(arg_106_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_106_1:ShowNextGo(false)
			end

			local var_109_2 = 0

			if var_109_2 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.cswbg_:SetActive(false)
			end

			local var_109_3 = 0

			if var_109_3 < arg_106_1.time_ and arg_106_1.time_ <= var_109_3 + arg_109_0 then
				local var_109_4 = manager.ui.mainCamera.transform.localPosition
				local var_109_5 = Vector3.New(0, 0, 10) + Vector3.New(var_109_4.x, var_109_4.y, 0)
				local var_109_6 = arg_106_1.bgs_.STblack

				var_109_6.transform.localPosition = var_109_5
				var_109_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_109_7 = var_109_6:GetComponent("SpriteRenderer")

				if var_109_7 and var_109_7.sprite then
					local var_109_8 = (var_109_6.transform.localPosition - var_109_4).z
					local var_109_9 = manager.ui.mainCameraCom_
					local var_109_10 = 2 * var_109_8 * Mathf.Tan(var_109_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_109_11 = var_109_10 * var_109_9.aspect
					local var_109_12 = var_109_7.sprite.bounds.size.x
					local var_109_13 = var_109_7.sprite.bounds.size.y
					local var_109_14 = var_109_11 / var_109_12
					local var_109_15 = var_109_10 / var_109_13
					local var_109_16 = var_109_15 < var_109_14 and var_109_14 or var_109_15

					var_109_6.transform.localScale = Vector3.New(var_109_16, var_109_16, 0)
				end

				for iter_109_0, iter_109_1 in pairs(arg_106_1.bgs_) do
					if iter_109_0 ~= "STblack" then
						iter_109_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_109_17 = 0

			if var_109_17 < arg_106_1.time_ and arg_106_1.time_ <= var_109_17 + arg_109_0 then
				arg_106_1.mask_.enabled = true
				arg_106_1.mask_.raycastTarget = true

				arg_106_1:SetGaussion(false)
			end

			local var_109_18 = 1

			if var_109_17 <= arg_106_1.time_ and arg_106_1.time_ < var_109_17 + var_109_18 then
				local var_109_19 = (arg_106_1.time_ - var_109_17) / var_109_18
				local var_109_20 = Color.New(0, 0, 0)

				var_109_20.a = Mathf.Lerp(1, 0, var_109_19)
				arg_106_1.mask_.color = var_109_20
			end

			if arg_106_1.time_ >= var_109_17 + var_109_18 and arg_106_1.time_ < var_109_17 + var_109_18 + arg_109_0 then
				local var_109_21 = Color.New(0, 0, 0)
				local var_109_22 = 0

				arg_106_1.mask_.enabled = false
				var_109_21.a = var_109_22
				arg_106_1.mask_.color = var_109_21
			end

			if arg_106_1.frameCnt_ <= 1 then
				arg_106_1.dialog_:SetActive(false)
			end

			local var_109_23 = 0.275
			local var_109_24 = 0.725

			if var_109_23 < arg_106_1.time_ and arg_106_1.time_ <= var_109_23 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0

				arg_106_1.dialog_:SetActive(true)

				arg_106_1.dialogCg_.alpha = 0

				local var_109_25 = LeanTween.value(arg_106_1.dialog_, 0, 1, 0.3)

				var_109_25:setOnUpdate(LuaHelper.FloatAction(function(arg_110_0)
					arg_106_1.dialogCg_.alpha = arg_110_0
				end))
				var_109_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_106_1.dialog_)
					var_109_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_106_1.duration_ = arg_106_1.duration_ + 0.3

				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_26 = arg_106_1:GetWordFromCfg(319281025)
				local var_109_27 = arg_106_1:FormatText(var_109_26.content)

				arg_106_1.text_.text = var_109_27

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_28 = 29
				local var_109_29 = utf8.len(var_109_27)
				local var_109_30 = var_109_28 <= 0 and var_109_24 or var_109_24 * (var_109_29 / var_109_28)

				if var_109_30 > 0 and var_109_24 < var_109_30 then
					arg_106_1.talkMaxDuration = var_109_30
					var_109_23 = var_109_23 + 0.3

					if var_109_30 + var_109_23 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_30 + var_109_23
					end
				end

				arg_106_1.text_.text = var_109_27
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_31 = var_109_23 + 0.3
			local var_109_32 = math.max(var_109_24, arg_106_1.talkMaxDuration)

			if var_109_31 <= arg_106_1.time_ and arg_106_1.time_ < var_109_31 + var_109_32 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_31) / var_109_32

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_31 + var_109_32 and arg_106_1.time_ < var_109_31 + var_109_32 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play319281026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319281026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play319281027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0
			local var_115_1 = 0.575

			if var_115_0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_2 = arg_112_1:GetWordFromCfg(319281026)
				local var_115_3 = arg_112_1:FormatText(var_115_2.content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 23
				local var_115_5 = utf8.len(var_115_3)
				local var_115_6 = var_115_4 <= 0 and var_115_1 or var_115_1 * (var_115_5 / var_115_4)

				if var_115_6 > 0 and var_115_1 < var_115_6 then
					arg_112_1.talkMaxDuration = var_115_6

					if var_115_6 + var_115_0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_6 + var_115_0
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_1, arg_112_1.talkMaxDuration)

			if var_115_0 <= arg_112_1.time_ and arg_112_1.time_ < var_115_0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_0 + var_115_7 and arg_112_1.time_ < var_115_0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play319281027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 319281027
		arg_116_1.duration_ = 5.63

		local var_116_0 = {
			zh = 4.166,
			ja = 5.633
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
				arg_116_0:Play319281028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10079ui_story"]
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10079ui_story == nil then
				arg_116_1.var_.characterEffect10079ui_story = var_119_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 and not isNil(var_119_0) then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2

				if arg_116_1.var_.characterEffect10079ui_story and not isNil(var_119_0) then
					arg_116_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 and not isNil(var_119_0) and arg_116_1.var_.characterEffect10079ui_story then
				arg_116_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_119_4 = 0
			local var_119_5 = 0.45

			if var_119_4 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_6 = arg_116_1:FormatText(StoryNameCfg[6].name)

				arg_116_1.leftNameTxt_.text = var_119_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_7 = arg_116_1:GetWordFromCfg(319281027)
				local var_119_8 = arg_116_1:FormatText(var_119_7.content)

				arg_116_1.text_.text = var_119_8

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 18
				local var_119_10 = utf8.len(var_119_8)
				local var_119_11 = var_119_9 <= 0 and var_119_5 or var_119_5 * (var_119_10 / var_119_9)

				if var_119_11 > 0 and var_119_5 < var_119_11 then
					arg_116_1.talkMaxDuration = var_119_11

					if var_119_11 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_11 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_8
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281027", "story_v_out_319281.awb") ~= 0 then
					local var_119_12 = manager.audio:GetVoiceLength("story_v_out_319281", "319281027", "story_v_out_319281.awb") / 1000

					if var_119_12 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_12 + var_119_4
					end

					if var_119_7.prefab_name ~= "" and arg_116_1.actors_[var_119_7.prefab_name] ~= nil then
						local var_119_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_7.prefab_name].transform, "story_v_out_319281", "319281027", "story_v_out_319281.awb")

						arg_116_1:RecordAudio("319281027", var_119_13)
						arg_116_1:RecordAudio("319281027", var_119_13)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_319281", "319281027", "story_v_out_319281.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_319281", "319281027", "story_v_out_319281.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_14 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_14 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_14

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_14 and arg_116_1.time_ < var_119_4 + var_119_14 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play319281028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319281028
		arg_120_1.duration_ = 13.37

		local var_120_0 = {
			zh = 7.566,
			ja = 13.366
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
				arg_120_0:Play319281029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 1.05

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[6].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(319281028)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 42
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281028", "story_v_out_319281.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_319281", "319281028", "story_v_out_319281.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_319281", "319281028", "story_v_out_319281.awb")

						arg_120_1:RecordAudio("319281028", var_123_9)
						arg_120_1:RecordAudio("319281028", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_319281", "319281028", "story_v_out_319281.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_319281", "319281028", "story_v_out_319281.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play319281029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 319281029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play319281030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10079ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10079ui_story == nil then
				arg_124_1.var_.characterEffect10079ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect10079ui_story and not isNil(var_127_0) then
					local var_127_4 = Mathf.Lerp(0, 0.5, var_127_3)

					arg_124_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10079ui_story.fillRatio = var_127_4
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10079ui_story then
				local var_127_5 = 0.5

				arg_124_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10079ui_story.fillRatio = var_127_5
			end

			local var_127_6 = 0
			local var_127_7 = 0.175

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_8 = arg_124_1:GetWordFromCfg(319281029)
				local var_127_9 = arg_124_1:FormatText(var_127_8.content)

				arg_124_1.text_.text = var_127_9

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_10 = 7
				local var_127_11 = utf8.len(var_127_9)
				local var_127_12 = var_127_10 <= 0 and var_127_7 or var_127_7 * (var_127_11 / var_127_10)

				if var_127_12 > 0 and var_127_7 < var_127_12 then
					arg_124_1.talkMaxDuration = var_127_12

					if var_127_12 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_9
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_13 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_13 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_13

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_13 and arg_124_1.time_ < var_127_6 + var_127_13 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play319281030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 319281030
		arg_128_1.duration_ = 8

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play319281031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 1

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				local var_131_1 = manager.ui.mainCamera.transform.localPosition
				local var_131_2 = Vector3.New(0, 0, 10) + Vector3.New(var_131_1.x, var_131_1.y, 0)
				local var_131_3 = arg_128_1.bgs_.I10f

				var_131_3.transform.localPosition = var_131_2
				var_131_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_131_4 = var_131_3:GetComponent("SpriteRenderer")

				if var_131_4 and var_131_4.sprite then
					local var_131_5 = (var_131_3.transform.localPosition - var_131_1).z
					local var_131_6 = manager.ui.mainCameraCom_
					local var_131_7 = 2 * var_131_5 * Mathf.Tan(var_131_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_131_8 = var_131_7 * var_131_6.aspect
					local var_131_9 = var_131_4.sprite.bounds.size.x
					local var_131_10 = var_131_4.sprite.bounds.size.y
					local var_131_11 = var_131_8 / var_131_9
					local var_131_12 = var_131_7 / var_131_10
					local var_131_13 = var_131_12 < var_131_11 and var_131_11 or var_131_12

					var_131_3.transform.localScale = Vector3.New(var_131_13, var_131_13, 0)
				end

				for iter_131_0, iter_131_1 in pairs(arg_128_1.bgs_) do
					if iter_131_0 ~= "I10f" then
						iter_131_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_131_14 = 0

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_15 = 1

			if var_131_14 <= arg_128_1.time_ and arg_128_1.time_ < var_131_14 + var_131_15 then
				local var_131_16 = (arg_128_1.time_ - var_131_14) / var_131_15
				local var_131_17 = Color.New(0, 0, 0)

				var_131_17.a = Mathf.Lerp(0, 1, var_131_16)
				arg_128_1.mask_.color = var_131_17
			end

			if arg_128_1.time_ >= var_131_14 + var_131_15 and arg_128_1.time_ < var_131_14 + var_131_15 + arg_131_0 then
				local var_131_18 = Color.New(0, 0, 0)

				var_131_18.a = 1
				arg_128_1.mask_.color = var_131_18
			end

			local var_131_19 = 1

			if var_131_19 < arg_128_1.time_ and arg_128_1.time_ <= var_131_19 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_20 = 2

			if var_131_19 <= arg_128_1.time_ and arg_128_1.time_ < var_131_19 + var_131_20 then
				local var_131_21 = (arg_128_1.time_ - var_131_19) / var_131_20
				local var_131_22 = Color.New(0, 0, 0)

				var_131_22.a = Mathf.Lerp(1, 0, var_131_21)
				arg_128_1.mask_.color = var_131_22
			end

			if arg_128_1.time_ >= var_131_19 + var_131_20 and arg_128_1.time_ < var_131_19 + var_131_20 + arg_131_0 then
				local var_131_23 = Color.New(0, 0, 0)
				local var_131_24 = 0

				arg_128_1.mask_.enabled = false
				var_131_23.a = var_131_24
				arg_128_1.mask_.color = var_131_23
			end

			if arg_128_1.frameCnt_ <= 1 then
				arg_128_1.dialog_:SetActive(false)
			end

			local var_131_25 = 3
			local var_131_26 = 0.675

			if var_131_25 < arg_128_1.time_ and arg_128_1.time_ <= var_131_25 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0

				arg_128_1.dialog_:SetActive(true)

				arg_128_1.dialogCg_.alpha = 0

				local var_131_27 = LeanTween.value(arg_128_1.dialog_, 0, 1, 0.3)

				var_131_27:setOnUpdate(LuaHelper.FloatAction(function(arg_132_0)
					arg_128_1.dialogCg_.alpha = arg_132_0
				end))
				var_131_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_128_1.dialog_)
					var_131_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_128_1.duration_ = arg_128_1.duration_ + 0.3

				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_28 = arg_128_1:GetWordFromCfg(319281030)
				local var_131_29 = arg_128_1:FormatText(var_131_28.content)

				arg_128_1.text_.text = var_131_29

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_30 = 27
				local var_131_31 = utf8.len(var_131_29)
				local var_131_32 = var_131_30 <= 0 and var_131_26 or var_131_26 * (var_131_31 / var_131_30)

				if var_131_32 > 0 and var_131_26 < var_131_32 then
					arg_128_1.talkMaxDuration = var_131_32
					var_131_25 = var_131_25 + 0.3

					if var_131_32 + var_131_25 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_32 + var_131_25
					end
				end

				arg_128_1.text_.text = var_131_29
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_33 = var_131_25 + 0.3
			local var_131_34 = math.max(var_131_26, arg_128_1.talkMaxDuration)

			if var_131_33 <= arg_128_1.time_ and arg_128_1.time_ < var_131_33 + var_131_34 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_33) / var_131_34

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_33 + var_131_34 and arg_128_1.time_ < var_131_33 + var_131_34 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play319281031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 319281031
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play319281032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0
			local var_137_1 = 1.55

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_2 = arg_134_1:GetWordFromCfg(319281031)
				local var_137_3 = arg_134_1:FormatText(var_137_2.content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 62
				local var_137_5 = utf8.len(var_137_3)
				local var_137_6 = var_137_4 <= 0 and var_137_1 or var_137_1 * (var_137_5 / var_137_4)

				if var_137_6 > 0 and var_137_1 < var_137_6 then
					arg_134_1.talkMaxDuration = var_137_6

					if var_137_6 + var_137_0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_6 + var_137_0
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_1, arg_134_1.talkMaxDuration)

			if var_137_0 <= arg_134_1.time_ and arg_134_1.time_ < var_137_0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_0 + var_137_7 and arg_134_1.time_ < var_137_0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play319281032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 319281032
		arg_138_1.duration_ = 5.57

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play319281033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = manager.ui.mainCamera.transform
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				local var_141_2 = arg_138_1.var_.effect123123
				local var_141_3
				local var_141_4 = var_141_0

				if not var_141_2 then
					var_141_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_141_4)
					var_141_2.name = "123123"
					arg_138_1.var_.effect123123 = var_141_2
				else
					var_141_2.transform:SetParent(var_141_4)
				end

				var_141_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_141_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_141_5 = 0
			local var_141_6 = 1

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				local var_141_7 = "play"
				local var_141_8 = "effect"

				arg_138_1:AudioAction(var_141_7, var_141_8, "se_story_130", "se_story_130_noise", "")
			end

			local var_141_9 = 0.566666666666667
			local var_141_10 = 0.65

			if var_141_9 < arg_138_1.time_ and arg_138_1.time_ <= var_141_9 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_11 = arg_138_1:GetWordFromCfg(319281032)
				local var_141_12 = arg_138_1:FormatText(var_141_11.content)

				arg_138_1.text_.text = var_141_12

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_13 = 26
				local var_141_14 = utf8.len(var_141_12)
				local var_141_15 = var_141_13 <= 0 and var_141_10 or var_141_10 * (var_141_14 / var_141_13)

				if var_141_15 > 0 and var_141_10 < var_141_15 then
					arg_138_1.talkMaxDuration = var_141_15

					if var_141_15 + var_141_9 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_15 + var_141_9
					end
				end

				arg_138_1.text_.text = var_141_12
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_16 = math.max(var_141_10, arg_138_1.talkMaxDuration)

			if var_141_9 <= arg_138_1.time_ and arg_138_1.time_ < var_141_9 + var_141_16 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_9) / var_141_16

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_9 + var_141_16 and arg_138_1.time_ < var_141_9 + var_141_16 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play319281033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 319281033
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play319281034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0
			local var_145_1 = 0.55

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

				local var_145_2 = arg_142_1:GetWordFromCfg(319281033)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 22
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
	Play319281034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 319281034
		arg_146_1.duration_ = 4.53

		local var_146_0 = {
			zh = 1.999999999999,
			ja = 4.533
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
				arg_146_0:Play319281035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["10079ui_story"].transform
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.var_.moveOldPos10079ui_story = var_149_0.localPosition

				local var_149_2 = "10079ui_story"

				arg_146_1:ShowWeapon(arg_146_1.var_[var_149_2 .. "Animator"].transform, false)
			end

			local var_149_3 = 0.001

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_3 then
				local var_149_4 = (arg_146_1.time_ - var_149_1) / var_149_3
				local var_149_5 = Vector3.New(0, -0.95, -6.05)

				var_149_0.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10079ui_story, var_149_5, var_149_4)

				local var_149_6 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_6.x, var_149_6.y, var_149_6.z)

				local var_149_7 = var_149_0.localEulerAngles

				var_149_7.z = 0
				var_149_7.x = 0
				var_149_0.localEulerAngles = var_149_7
			end

			if arg_146_1.time_ >= var_149_1 + var_149_3 and arg_146_1.time_ < var_149_1 + var_149_3 + arg_149_0 then
				var_149_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_149_8 = manager.ui.mainCamera.transform.position - var_149_0.position

				var_149_0.forward = Vector3.New(var_149_8.x, var_149_8.y, var_149_8.z)

				local var_149_9 = var_149_0.localEulerAngles

				var_149_9.z = 0
				var_149_9.x = 0
				var_149_0.localEulerAngles = var_149_9
			end

			local var_149_10 = arg_146_1.actors_["10079ui_story"]
			local var_149_11 = 0

			if var_149_11 < arg_146_1.time_ and arg_146_1.time_ <= var_149_11 + arg_149_0 and not isNil(var_149_10) and arg_146_1.var_.characterEffect10079ui_story == nil then
				arg_146_1.var_.characterEffect10079ui_story = var_149_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_12 = 0.200000002980232

			if var_149_11 <= arg_146_1.time_ and arg_146_1.time_ < var_149_11 + var_149_12 and not isNil(var_149_10) then
				local var_149_13 = (arg_146_1.time_ - var_149_11) / var_149_12

				if arg_146_1.var_.characterEffect10079ui_story and not isNil(var_149_10) then
					arg_146_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_11 + var_149_12 and arg_146_1.time_ < var_149_11 + var_149_12 + arg_149_0 and not isNil(var_149_10) and arg_146_1.var_.characterEffect10079ui_story then
				arg_146_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_149_14 = 0

			if var_149_14 < arg_146_1.time_ and arg_146_1.time_ <= var_149_14 + arg_149_0 then
				arg_146_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_149_15 = manager.ui.mainCamera.transform
			local var_149_16 = 0

			if var_149_16 < arg_146_1.time_ and arg_146_1.time_ <= var_149_16 + arg_149_0 then
				local var_149_17 = arg_146_1.var_.effect123123

				if var_149_17 then
					Object.Destroy(var_149_17)

					arg_146_1.var_.effect123123 = nil
				end
			end

			local var_149_18 = 0
			local var_149_19 = 0.125

			if var_149_18 < arg_146_1.time_ and arg_146_1.time_ <= var_149_18 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_20 = arg_146_1:FormatText(StoryNameCfg[6].name)

				arg_146_1.leftNameTxt_.text = var_149_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_21 = arg_146_1:GetWordFromCfg(319281034)
				local var_149_22 = arg_146_1:FormatText(var_149_21.content)

				arg_146_1.text_.text = var_149_22

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_23 = 5
				local var_149_24 = utf8.len(var_149_22)
				local var_149_25 = var_149_23 <= 0 and var_149_19 or var_149_19 * (var_149_24 / var_149_23)

				if var_149_25 > 0 and var_149_19 < var_149_25 then
					arg_146_1.talkMaxDuration = var_149_25

					if var_149_25 + var_149_18 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_25 + var_149_18
					end
				end

				arg_146_1.text_.text = var_149_22
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281034", "story_v_out_319281.awb") ~= 0 then
					local var_149_26 = manager.audio:GetVoiceLength("story_v_out_319281", "319281034", "story_v_out_319281.awb") / 1000

					if var_149_26 + var_149_18 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_26 + var_149_18
					end

					if var_149_21.prefab_name ~= "" and arg_146_1.actors_[var_149_21.prefab_name] ~= nil then
						local var_149_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_21.prefab_name].transform, "story_v_out_319281", "319281034", "story_v_out_319281.awb")

						arg_146_1:RecordAudio("319281034", var_149_27)
						arg_146_1:RecordAudio("319281034", var_149_27)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_319281", "319281034", "story_v_out_319281.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_319281", "319281034", "story_v_out_319281.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_28 = math.max(var_149_19, arg_146_1.talkMaxDuration)

			if var_149_18 <= arg_146_1.time_ and arg_146_1.time_ < var_149_18 + var_149_28 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_18) / var_149_28

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_18 + var_149_28 and arg_146_1.time_ < var_149_18 + var_149_28 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play319281035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 319281035
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play319281036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["10079ui_story"].transform
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.var_.moveOldPos10079ui_story = var_153_0.localPosition

				local var_153_2 = "10079ui_story"

				arg_150_1:ShowWeapon(arg_150_1.var_[var_153_2 .. "Animator"].transform, false)
			end

			local var_153_3 = 0.001

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_3 then
				local var_153_4 = (arg_150_1.time_ - var_153_1) / var_153_3
				local var_153_5 = Vector3.New(0, 100, 0)

				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos10079ui_story, var_153_5, var_153_4)

				local var_153_6 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_6.x, var_153_6.y, var_153_6.z)

				local var_153_7 = var_153_0.localEulerAngles

				var_153_7.z = 0
				var_153_7.x = 0
				var_153_0.localEulerAngles = var_153_7
			end

			if arg_150_1.time_ >= var_153_1 + var_153_3 and arg_150_1.time_ < var_153_1 + var_153_3 + arg_153_0 then
				var_153_0.localPosition = Vector3.New(0, 100, 0)

				local var_153_8 = manager.ui.mainCamera.transform.position - var_153_0.position

				var_153_0.forward = Vector3.New(var_153_8.x, var_153_8.y, var_153_8.z)

				local var_153_9 = var_153_0.localEulerAngles

				var_153_9.z = 0
				var_153_9.x = 0
				var_153_0.localEulerAngles = var_153_9
			end

			local var_153_10 = 0
			local var_153_11 = 1.175

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_12 = arg_150_1:GetWordFromCfg(319281035)
				local var_153_13 = arg_150_1:FormatText(var_153_12.content)

				arg_150_1.text_.text = var_153_13

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_14 = 47
				local var_153_15 = utf8.len(var_153_13)
				local var_153_16 = var_153_14 <= 0 and var_153_11 or var_153_11 * (var_153_15 / var_153_14)

				if var_153_16 > 0 and var_153_11 < var_153_16 then
					arg_150_1.talkMaxDuration = var_153_16

					if var_153_16 + var_153_10 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_16 + var_153_10
					end
				end

				arg_150_1.text_.text = var_153_13
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_17 = math.max(var_153_11, arg_150_1.talkMaxDuration)

			if var_153_10 <= arg_150_1.time_ and arg_150_1.time_ < var_153_10 + var_153_17 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_10) / var_153_17

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_10 + var_153_17 and arg_150_1.time_ < var_153_10 + var_153_17 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play319281036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 319281036
		arg_154_1.duration_ = 7.63

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play319281037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 1

			if var_157_0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_0 + arg_157_0 then
				local var_157_1 = manager.ui.mainCamera.transform.localPosition
				local var_157_2 = Vector3.New(0, 0, 10) + Vector3.New(var_157_1.x, var_157_1.y, 0)
				local var_157_3 = arg_154_1.bgs_.I10f

				var_157_3.transform.localPosition = var_157_2
				var_157_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_157_4 = var_157_3:GetComponent("SpriteRenderer")

				if var_157_4 and var_157_4.sprite then
					local var_157_5 = (var_157_3.transform.localPosition - var_157_1).z
					local var_157_6 = manager.ui.mainCameraCom_
					local var_157_7 = 2 * var_157_5 * Mathf.Tan(var_157_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_157_8 = var_157_7 * var_157_6.aspect
					local var_157_9 = var_157_4.sprite.bounds.size.x
					local var_157_10 = var_157_4.sprite.bounds.size.y
					local var_157_11 = var_157_8 / var_157_9
					local var_157_12 = var_157_7 / var_157_10
					local var_157_13 = var_157_12 < var_157_11 and var_157_11 or var_157_12

					var_157_3.transform.localScale = Vector3.New(var_157_13, var_157_13, 0)
				end

				for iter_157_0, iter_157_1 in pairs(arg_154_1.bgs_) do
					if iter_157_0 ~= "I10f" then
						iter_157_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_157_14 = 0

			if var_157_14 < arg_154_1.time_ and arg_154_1.time_ <= var_157_14 + arg_157_0 then
				arg_154_1.mask_.enabled = true
				arg_154_1.mask_.raycastTarget = true

				arg_154_1:SetGaussion(false)
			end

			local var_157_15 = 1

			if var_157_14 <= arg_154_1.time_ and arg_154_1.time_ < var_157_14 + var_157_15 then
				local var_157_16 = (arg_154_1.time_ - var_157_14) / var_157_15
				local var_157_17 = Color.New(0, 0, 0)

				var_157_17.a = Mathf.Lerp(0, 1, var_157_16)
				arg_154_1.mask_.color = var_157_17
			end

			if arg_154_1.time_ >= var_157_14 + var_157_15 and arg_154_1.time_ < var_157_14 + var_157_15 + arg_157_0 then
				local var_157_18 = Color.New(0, 0, 0)

				var_157_18.a = 1
				arg_154_1.mask_.color = var_157_18
			end

			local var_157_19 = 1

			if var_157_19 < arg_154_1.time_ and arg_154_1.time_ <= var_157_19 + arg_157_0 then
				arg_154_1.mask_.enabled = true
				arg_154_1.mask_.raycastTarget = true

				arg_154_1:SetGaussion(false)
			end

			local var_157_20 = 2

			if var_157_19 <= arg_154_1.time_ and arg_154_1.time_ < var_157_19 + var_157_20 then
				local var_157_21 = (arg_154_1.time_ - var_157_19) / var_157_20
				local var_157_22 = Color.New(0, 0, 0)

				var_157_22.a = Mathf.Lerp(1, 0, var_157_21)
				arg_154_1.mask_.color = var_157_22
			end

			if arg_154_1.time_ >= var_157_19 + var_157_20 and arg_154_1.time_ < var_157_19 + var_157_20 + arg_157_0 then
				local var_157_23 = Color.New(0, 0, 0)
				local var_157_24 = 0

				arg_154_1.mask_.enabled = false
				var_157_23.a = var_157_24
				arg_154_1.mask_.color = var_157_23
			end

			if arg_154_1.frameCnt_ <= 1 then
				arg_154_1.dialog_:SetActive(false)
			end

			local var_157_25 = 2.63333333333333
			local var_157_26 = 1.325

			if var_157_25 < arg_154_1.time_ and arg_154_1.time_ <= var_157_25 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0

				arg_154_1.dialog_:SetActive(true)

				arg_154_1.dialogCg_.alpha = 0

				local var_157_27 = LeanTween.value(arg_154_1.dialog_, 0, 1, 0.3)

				var_157_27:setOnUpdate(LuaHelper.FloatAction(function(arg_158_0)
					arg_154_1.dialogCg_.alpha = arg_158_0
				end))
				var_157_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_154_1.dialog_)
					var_157_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_154_1.duration_ = arg_154_1.duration_ + 0.3

				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_28 = arg_154_1:GetWordFromCfg(319281036)
				local var_157_29 = arg_154_1:FormatText(var_157_28.content)

				arg_154_1.text_.text = var_157_29

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_30 = 53
				local var_157_31 = utf8.len(var_157_29)
				local var_157_32 = var_157_30 <= 0 and var_157_26 or var_157_26 * (var_157_31 / var_157_30)

				if var_157_32 > 0 and var_157_26 < var_157_32 then
					arg_154_1.talkMaxDuration = var_157_32
					var_157_25 = var_157_25 + 0.3

					if var_157_32 + var_157_25 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_32 + var_157_25
					end
				end

				arg_154_1.text_.text = var_157_29
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_33 = var_157_25 + 0.3
			local var_157_34 = math.max(var_157_26, arg_154_1.talkMaxDuration)

			if var_157_33 <= arg_154_1.time_ and arg_154_1.time_ < var_157_33 + var_157_34 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_33) / var_157_34

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_33 + var_157_34 and arg_154_1.time_ < var_157_33 + var_157_34 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play319281037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 319281037
		arg_160_1.duration_ = 5.53

		local var_160_0 = {
			zh = 3.7,
			ja = 5.533
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play319281038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10079ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10079ui_story == nil then
				arg_160_1.var_.characterEffect10079ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect10079ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10079ui_story then
				arg_160_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_163_4 = arg_160_1.actors_["10079ui_story"].transform
			local var_163_5 = 0

			if var_163_5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 then
				arg_160_1.var_.moveOldPos10079ui_story = var_163_4.localPosition

				local var_163_6 = "10079ui_story"

				arg_160_1:ShowWeapon(arg_160_1.var_[var_163_6 .. "Animator"].transform, false)
			end

			local var_163_7 = 0.001

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_7 then
				local var_163_8 = (arg_160_1.time_ - var_163_5) / var_163_7
				local var_163_9 = Vector3.New(0, -0.95, -6.05)

				var_163_4.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10079ui_story, var_163_9, var_163_8)

				local var_163_10 = manager.ui.mainCamera.transform.position - var_163_4.position

				var_163_4.forward = Vector3.New(var_163_10.x, var_163_10.y, var_163_10.z)

				local var_163_11 = var_163_4.localEulerAngles

				var_163_11.z = 0
				var_163_11.x = 0
				var_163_4.localEulerAngles = var_163_11
			end

			if arg_160_1.time_ >= var_163_5 + var_163_7 and arg_160_1.time_ < var_163_5 + var_163_7 + arg_163_0 then
				var_163_4.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_163_12 = manager.ui.mainCamera.transform.position - var_163_4.position

				var_163_4.forward = Vector3.New(var_163_12.x, var_163_12.y, var_163_12.z)

				local var_163_13 = var_163_4.localEulerAngles

				var_163_13.z = 0
				var_163_13.x = 0
				var_163_4.localEulerAngles = var_163_13
			end

			local var_163_14 = 0

			if var_163_14 < arg_160_1.time_ and arg_160_1.time_ <= var_163_14 + arg_163_0 then
				arg_160_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4134")
			end

			local var_163_15 = 0

			if var_163_15 < arg_160_1.time_ and arg_160_1.time_ <= var_163_15 + arg_163_0 then
				arg_160_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_163_16 = 1
			local var_163_17 = 0.225

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_18 = arg_160_1:FormatText(StoryNameCfg[6].name)

				arg_160_1.leftNameTxt_.text = var_163_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_19 = arg_160_1:GetWordFromCfg(319281037)
				local var_163_20 = arg_160_1:FormatText(var_163_19.content)

				arg_160_1.text_.text = var_163_20

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_21 = 9
				local var_163_22 = utf8.len(var_163_20)
				local var_163_23 = var_163_21 <= 0 and var_163_17 or var_163_17 * (var_163_22 / var_163_21)

				if var_163_23 > 0 and var_163_17 < var_163_23 then
					arg_160_1.talkMaxDuration = var_163_23

					if var_163_23 + var_163_16 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_23 + var_163_16
					end
				end

				arg_160_1.text_.text = var_163_20
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281037", "story_v_out_319281.awb") ~= 0 then
					local var_163_24 = manager.audio:GetVoiceLength("story_v_out_319281", "319281037", "story_v_out_319281.awb") / 1000

					if var_163_24 + var_163_16 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_24 + var_163_16
					end

					if var_163_19.prefab_name ~= "" and arg_160_1.actors_[var_163_19.prefab_name] ~= nil then
						local var_163_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_19.prefab_name].transform, "story_v_out_319281", "319281037", "story_v_out_319281.awb")

						arg_160_1:RecordAudio("319281037", var_163_25)
						arg_160_1:RecordAudio("319281037", var_163_25)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_319281", "319281037", "story_v_out_319281.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_319281", "319281037", "story_v_out_319281.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_26 = math.max(var_163_17, arg_160_1.talkMaxDuration)

			if var_163_16 <= arg_160_1.time_ and arg_160_1.time_ < var_163_16 + var_163_26 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_16) / var_163_26

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_16 + var_163_26 and arg_160_1.time_ < var_163_16 + var_163_26 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319281038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 319281038
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play319281039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["10079ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect10079ui_story == nil then
				arg_164_1.var_.characterEffect10079ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect10079ui_story and not isNil(var_167_0) then
					local var_167_4 = Mathf.Lerp(0, 0.5, var_167_3)

					arg_164_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_164_1.var_.characterEffect10079ui_story.fillRatio = var_167_4
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect10079ui_story then
				local var_167_5 = 0.5

				arg_164_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_164_1.var_.characterEffect10079ui_story.fillRatio = var_167_5
			end

			local var_167_6 = 0
			local var_167_7 = 1.075

			if var_167_6 < arg_164_1.time_ and arg_164_1.time_ <= var_167_6 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_8 = arg_164_1:GetWordFromCfg(319281038)
				local var_167_9 = arg_164_1:FormatText(var_167_8.content)

				arg_164_1.text_.text = var_167_9

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_10 = 43
				local var_167_11 = utf8.len(var_167_9)
				local var_167_12 = var_167_10 <= 0 and var_167_7 or var_167_7 * (var_167_11 / var_167_10)

				if var_167_12 > 0 and var_167_7 < var_167_12 then
					arg_164_1.talkMaxDuration = var_167_12

					if var_167_12 + var_167_6 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_12 + var_167_6
					end
				end

				arg_164_1.text_.text = var_167_9
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_13 = math.max(var_167_7, arg_164_1.talkMaxDuration)

			if var_167_6 <= arg_164_1.time_ and arg_164_1.time_ < var_167_6 + var_167_13 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_6) / var_167_13

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_6 + var_167_13 and arg_164_1.time_ < var_167_6 + var_167_13 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play319281039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 319281039
		arg_168_1.duration_ = 3.97

		local var_168_0 = {
			zh = 3.233,
			ja = 3.966
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
				arg_168_0:Play319281040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10079ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10079ui_story == nil then
				arg_168_1.var_.characterEffect10079ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect10079ui_story and not isNil(var_171_0) then
					arg_168_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10079ui_story then
				arg_168_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_171_4 = 0

			if var_171_4 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_171_5 = 0
			local var_171_6 = 0.275

			if var_171_5 < arg_168_1.time_ and arg_168_1.time_ <= var_171_5 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_7 = arg_168_1:FormatText(StoryNameCfg[6].name)

				arg_168_1.leftNameTxt_.text = var_171_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_8 = arg_168_1:GetWordFromCfg(319281039)
				local var_171_9 = arg_168_1:FormatText(var_171_8.content)

				arg_168_1.text_.text = var_171_9

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_10 = 11
				local var_171_11 = utf8.len(var_171_9)
				local var_171_12 = var_171_10 <= 0 and var_171_6 or var_171_6 * (var_171_11 / var_171_10)

				if var_171_12 > 0 and var_171_6 < var_171_12 then
					arg_168_1.talkMaxDuration = var_171_12

					if var_171_12 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_12 + var_171_5
					end
				end

				arg_168_1.text_.text = var_171_9
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281039", "story_v_out_319281.awb") ~= 0 then
					local var_171_13 = manager.audio:GetVoiceLength("story_v_out_319281", "319281039", "story_v_out_319281.awb") / 1000

					if var_171_13 + var_171_5 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_13 + var_171_5
					end

					if var_171_8.prefab_name ~= "" and arg_168_1.actors_[var_171_8.prefab_name] ~= nil then
						local var_171_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_8.prefab_name].transform, "story_v_out_319281", "319281039", "story_v_out_319281.awb")

						arg_168_1:RecordAudio("319281039", var_171_14)
						arg_168_1:RecordAudio("319281039", var_171_14)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_319281", "319281039", "story_v_out_319281.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_319281", "319281039", "story_v_out_319281.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_15 = math.max(var_171_6, arg_168_1.talkMaxDuration)

			if var_171_5 <= arg_168_1.time_ and arg_168_1.time_ < var_171_5 + var_171_15 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_5) / var_171_15

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_5 + var_171_15 and arg_168_1.time_ < var_171_5 + var_171_15 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play319281040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 319281040
		arg_172_1.duration_ = 9.8

		local var_172_0 = {
			zh = 6.4,
			ja = 9.8
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
				arg_172_0:Play319281041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10079ui_story"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos10079ui_story = var_175_0.localPosition
			end

			local var_175_2 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2
				local var_175_4 = Vector3.New(0, -0.95, -6.05)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10079ui_story, var_175_4, var_175_3)

				local var_175_5 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_5.x, var_175_5.y, var_175_5.z)

				local var_175_6 = var_175_0.localEulerAngles

				var_175_6.z = 0
				var_175_6.x = 0
				var_175_0.localEulerAngles = var_175_6
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_175_7 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_7.x, var_175_7.y, var_175_7.z)

				local var_175_8 = var_175_0.localEulerAngles

				var_175_8.z = 0
				var_175_8.x = 0
				var_175_0.localEulerAngles = var_175_8
			end

			local var_175_9 = arg_172_1.actors_["10079ui_story"]
			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect10079ui_story == nil then
				arg_172_1.var_.characterEffect10079ui_story = var_175_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_11 = 0.200000002980232

			if var_175_10 <= arg_172_1.time_ and arg_172_1.time_ < var_175_10 + var_175_11 and not isNil(var_175_9) then
				local var_175_12 = (arg_172_1.time_ - var_175_10) / var_175_11

				if arg_172_1.var_.characterEffect10079ui_story and not isNil(var_175_9) then
					arg_172_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_10 + var_175_11 and arg_172_1.time_ < var_175_10 + var_175_11 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect10079ui_story then
				arg_172_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_175_13 = 0

			if var_175_13 < arg_172_1.time_ and arg_172_1.time_ <= var_175_13 + arg_175_0 then
				arg_172_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_175_14 = 0
			local var_175_15 = 0.625

			if var_175_14 < arg_172_1.time_ and arg_172_1.time_ <= var_175_14 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_16 = arg_172_1:FormatText(StoryNameCfg[6].name)

				arg_172_1.leftNameTxt_.text = var_175_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_17 = arg_172_1:GetWordFromCfg(319281040)
				local var_175_18 = arg_172_1:FormatText(var_175_17.content)

				arg_172_1.text_.text = var_175_18

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_19 = 25
				local var_175_20 = utf8.len(var_175_18)
				local var_175_21 = var_175_19 <= 0 and var_175_15 or var_175_15 * (var_175_20 / var_175_19)

				if var_175_21 > 0 and var_175_15 < var_175_21 then
					arg_172_1.talkMaxDuration = var_175_21

					if var_175_21 + var_175_14 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_21 + var_175_14
					end
				end

				arg_172_1.text_.text = var_175_18
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281040", "story_v_out_319281.awb") ~= 0 then
					local var_175_22 = manager.audio:GetVoiceLength("story_v_out_319281", "319281040", "story_v_out_319281.awb") / 1000

					if var_175_22 + var_175_14 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_22 + var_175_14
					end

					if var_175_17.prefab_name ~= "" and arg_172_1.actors_[var_175_17.prefab_name] ~= nil then
						local var_175_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_17.prefab_name].transform, "story_v_out_319281", "319281040", "story_v_out_319281.awb")

						arg_172_1:RecordAudio("319281040", var_175_23)
						arg_172_1:RecordAudio("319281040", var_175_23)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_319281", "319281040", "story_v_out_319281.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_319281", "319281040", "story_v_out_319281.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_24 = math.max(var_175_15, arg_172_1.talkMaxDuration)

			if var_175_14 <= arg_172_1.time_ and arg_172_1.time_ < var_175_14 + var_175_24 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_14) / var_175_24

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_14 + var_175_24 and arg_172_1.time_ < var_175_14 + var_175_24 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play319281041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 319281041
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play319281042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10079ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10079ui_story == nil then
				arg_176_1.var_.characterEffect10079ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect10079ui_story and not isNil(var_179_0) then
					local var_179_4 = Mathf.Lerp(0, 0.5, var_179_3)

					arg_176_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_176_1.var_.characterEffect10079ui_story.fillRatio = var_179_4
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect10079ui_story then
				local var_179_5 = 0.5

				arg_176_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_176_1.var_.characterEffect10079ui_story.fillRatio = var_179_5
			end

			local var_179_6 = 0
			local var_179_7 = 0.825

			if var_179_6 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_8 = arg_176_1:GetWordFromCfg(319281041)
				local var_179_9 = arg_176_1:FormatText(var_179_8.content)

				arg_176_1.text_.text = var_179_9

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_10 = 33
				local var_179_11 = utf8.len(var_179_9)
				local var_179_12 = var_179_10 <= 0 and var_179_7 or var_179_7 * (var_179_11 / var_179_10)

				if var_179_12 > 0 and var_179_7 < var_179_12 then
					arg_176_1.talkMaxDuration = var_179_12

					if var_179_12 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_12 + var_179_6
					end
				end

				arg_176_1.text_.text = var_179_9
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_13 = math.max(var_179_7, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_13 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_6) / var_179_13

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_13 and arg_176_1.time_ < var_179_6 + var_179_13 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play319281042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 319281042
		arg_180_1.duration_ = 6.13

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play319281043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10079ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos10079ui_story = var_183_0.localPosition

				local var_183_2 = "10079ui_story"

				arg_180_1:ShowWeapon(arg_180_1.var_[var_183_2 .. "Animator"].transform, false)
			end

			local var_183_3 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_3 then
				local var_183_4 = (arg_180_1.time_ - var_183_1) / var_183_3
				local var_183_5 = Vector3.New(0, 100, 0)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10079ui_story, var_183_5, var_183_4)

				local var_183_6 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_6.x, var_183_6.y, var_183_6.z)

				local var_183_7 = var_183_0.localEulerAngles

				var_183_7.z = 0
				var_183_7.x = 0
				var_183_0.localEulerAngles = var_183_7
			end

			if arg_180_1.time_ >= var_183_1 + var_183_3 and arg_180_1.time_ < var_183_1 + var_183_3 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(0, 100, 0)

				local var_183_8 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_8.x, var_183_8.y, var_183_8.z)

				local var_183_9 = var_183_0.localEulerAngles

				var_183_9.z = 0
				var_183_9.x = 0
				var_183_0.localEulerAngles = var_183_9
			end

			local var_183_10 = manager.ui.mainCamera.transform
			local var_183_11 = 0.2

			if var_183_11 < arg_180_1.time_ and arg_180_1.time_ <= var_183_11 + arg_183_0 then
				arg_180_1.var_.shakeOldPos = var_183_10.localPosition
			end

			local var_183_12 = 0.4

			if var_183_11 <= arg_180_1.time_ and arg_180_1.time_ < var_183_11 + var_183_12 then
				local var_183_13 = (arg_180_1.time_ - var_183_11) / 0.066
				local var_183_14, var_183_15 = math.modf(var_183_13)

				var_183_10.localPosition = Vector3.New(var_183_15 * 0.13, var_183_15 * 0.13, var_183_15 * 0.13) + arg_180_1.var_.shakeOldPos
			end

			if arg_180_1.time_ >= var_183_11 + var_183_12 and arg_180_1.time_ < var_183_11 + var_183_12 + arg_183_0 then
				var_183_10.localPosition = arg_180_1.var_.shakeOldPos
			end

			local var_183_16 = 0

			if var_183_16 < arg_180_1.time_ and arg_180_1.time_ <= var_183_16 + arg_183_0 then
				arg_180_1.mask_.enabled = true
				arg_180_1.mask_.raycastTarget = false

				arg_180_1:SetGaussion(false)
			end

			local var_183_17 = 0.3

			if var_183_16 <= arg_180_1.time_ and arg_180_1.time_ < var_183_16 + var_183_17 then
				local var_183_18 = (arg_180_1.time_ - var_183_16) / var_183_17
				local var_183_19 = Color.New(1, 1, 1)

				var_183_19.a = Mathf.Lerp(1, 0, var_183_18)
				arg_180_1.mask_.color = var_183_19
			end

			if arg_180_1.time_ >= var_183_16 + var_183_17 and arg_180_1.time_ < var_183_16 + var_183_17 + arg_183_0 then
				local var_183_20 = Color.New(1, 1, 1)
				local var_183_21 = 0

				arg_180_1.mask_.enabled = false
				var_183_20.a = var_183_21
				arg_180_1.mask_.color = var_183_20
			end

			local var_183_22 = 1.13333333333333
			local var_183_23 = 1.35

			if var_183_22 < arg_180_1.time_ and arg_180_1.time_ <= var_183_22 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_24 = arg_180_1:GetWordFromCfg(319281042)
				local var_183_25 = arg_180_1:FormatText(var_183_24.content)

				arg_180_1.text_.text = var_183_25

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_26 = 54
				local var_183_27 = utf8.len(var_183_25)
				local var_183_28 = var_183_26 <= 0 and var_183_23 or var_183_23 * (var_183_27 / var_183_26)

				if var_183_28 > 0 and var_183_23 < var_183_28 then
					arg_180_1.talkMaxDuration = var_183_28

					if var_183_28 + var_183_22 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_28 + var_183_22
					end
				end

				arg_180_1.text_.text = var_183_25
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_29 = math.max(var_183_23, arg_180_1.talkMaxDuration)

			if var_183_22 <= arg_180_1.time_ and arg_180_1.time_ < var_183_22 + var_183_29 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_22) / var_183_29

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_22 + var_183_29 and arg_180_1.time_ < var_183_22 + var_183_29 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play319281043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 319281043
		arg_184_1.duration_ = 8.3

		local var_184_0 = {
			zh = 2.733,
			ja = 8.3
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
				arg_184_0:Play319281044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10079ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10079ui_story == nil then
				arg_184_1.var_.characterEffect10079ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect10079ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10079ui_story then
				arg_184_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_187_4 = arg_184_1.actors_["10079ui_story"].transform
			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1.var_.moveOldPos10079ui_story = var_187_4.localPosition

				local var_187_6 = "10079ui_story"

				arg_184_1:ShowWeapon(arg_184_1.var_[var_187_6 .. "Animator"].transform, false)
			end

			local var_187_7 = 0.001

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_7 then
				local var_187_8 = (arg_184_1.time_ - var_187_5) / var_187_7
				local var_187_9 = Vector3.New(0, -0.95, -6.05)

				var_187_4.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10079ui_story, var_187_9, var_187_8)

				local var_187_10 = manager.ui.mainCamera.transform.position - var_187_4.position

				var_187_4.forward = Vector3.New(var_187_10.x, var_187_10.y, var_187_10.z)

				local var_187_11 = var_187_4.localEulerAngles

				var_187_11.z = 0
				var_187_11.x = 0
				var_187_4.localEulerAngles = var_187_11
			end

			if arg_184_1.time_ >= var_187_5 + var_187_7 and arg_184_1.time_ < var_187_5 + var_187_7 + arg_187_0 then
				var_187_4.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_187_12 = manager.ui.mainCamera.transform.position - var_187_4.position

				var_187_4.forward = Vector3.New(var_187_12.x, var_187_12.y, var_187_12.z)

				local var_187_13 = var_187_4.localEulerAngles

				var_187_13.z = 0
				var_187_13.x = 0
				var_187_4.localEulerAngles = var_187_13
			end

			local var_187_14 = 0

			if var_187_14 < arg_184_1.time_ and arg_184_1.time_ <= var_187_14 + arg_187_0 then
				arg_184_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_187_15 = 0

			if var_187_15 < arg_184_1.time_ and arg_184_1.time_ <= var_187_15 + arg_187_0 then
				arg_184_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_187_16 = 0
			local var_187_17 = 0.15

			if var_187_16 < arg_184_1.time_ and arg_184_1.time_ <= var_187_16 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_18 = arg_184_1:FormatText(StoryNameCfg[6].name)

				arg_184_1.leftNameTxt_.text = var_187_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_19 = arg_184_1:GetWordFromCfg(319281043)
				local var_187_20 = arg_184_1:FormatText(var_187_19.content)

				arg_184_1.text_.text = var_187_20

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_21 = 6
				local var_187_22 = utf8.len(var_187_20)
				local var_187_23 = var_187_21 <= 0 and var_187_17 or var_187_17 * (var_187_22 / var_187_21)

				if var_187_23 > 0 and var_187_17 < var_187_23 then
					arg_184_1.talkMaxDuration = var_187_23

					if var_187_23 + var_187_16 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_23 + var_187_16
					end
				end

				arg_184_1.text_.text = var_187_20
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281043", "story_v_out_319281.awb") ~= 0 then
					local var_187_24 = manager.audio:GetVoiceLength("story_v_out_319281", "319281043", "story_v_out_319281.awb") / 1000

					if var_187_24 + var_187_16 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_24 + var_187_16
					end

					if var_187_19.prefab_name ~= "" and arg_184_1.actors_[var_187_19.prefab_name] ~= nil then
						local var_187_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_19.prefab_name].transform, "story_v_out_319281", "319281043", "story_v_out_319281.awb")

						arg_184_1:RecordAudio("319281043", var_187_25)
						arg_184_1:RecordAudio("319281043", var_187_25)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_319281", "319281043", "story_v_out_319281.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_319281", "319281043", "story_v_out_319281.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_26 = math.max(var_187_17, arg_184_1.talkMaxDuration)

			if var_187_16 <= arg_184_1.time_ and arg_184_1.time_ < var_187_16 + var_187_26 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_16) / var_187_26

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_16 + var_187_26 and arg_184_1.time_ < var_187_16 + var_187_26 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play319281044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 319281044
		arg_188_1.duration_ = 3.33

		local var_188_0 = {
			zh = 1.966,
			ja = 3.333
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
				arg_188_0:Play319281045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0
			local var_191_1 = 0.225

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_2 = arg_188_1:FormatText(StoryNameCfg[6].name)

				arg_188_1.leftNameTxt_.text = var_191_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_3 = arg_188_1:GetWordFromCfg(319281044)
				local var_191_4 = arg_188_1:FormatText(var_191_3.content)

				arg_188_1.text_.text = var_191_4

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_5 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_319281", "319281044", "story_v_out_319281.awb") ~= 0 then
					local var_191_8 = manager.audio:GetVoiceLength("story_v_out_319281", "319281044", "story_v_out_319281.awb") / 1000

					if var_191_8 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_0
					end

					if var_191_3.prefab_name ~= "" and arg_188_1.actors_[var_191_3.prefab_name] ~= nil then
						local var_191_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_3.prefab_name].transform, "story_v_out_319281", "319281044", "story_v_out_319281.awb")

						arg_188_1:RecordAudio("319281044", var_191_9)
						arg_188_1:RecordAudio("319281044", var_191_9)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_319281", "319281044", "story_v_out_319281.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_319281", "319281044", "story_v_out_319281.awb")
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
	Play319281045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 319281045
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play319281046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0
			local var_195_1 = 1

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				local var_195_2 = "play"
				local var_195_3 = "effect"

				arg_192_1:AudioAction(var_195_2, var_195_3, "se_story_9", "se_story_9_monster03", "")
			end

			local var_195_4 = arg_192_1.actors_["10079ui_story"]
			local var_195_5 = 0

			if var_195_5 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect10079ui_story == nil then
				arg_192_1.var_.characterEffect10079ui_story = var_195_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_6 = 0.200000002980232

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_6 and not isNil(var_195_4) then
				local var_195_7 = (arg_192_1.time_ - var_195_5) / var_195_6

				if arg_192_1.var_.characterEffect10079ui_story and not isNil(var_195_4) then
					local var_195_8 = Mathf.Lerp(0, 0.5, var_195_7)

					arg_192_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_192_1.var_.characterEffect10079ui_story.fillRatio = var_195_8
				end
			end

			if arg_192_1.time_ >= var_195_5 + var_195_6 and arg_192_1.time_ < var_195_5 + var_195_6 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect10079ui_story then
				local var_195_9 = 0.5

				arg_192_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_192_1.var_.characterEffect10079ui_story.fillRatio = var_195_9
			end

			local var_195_10 = 0
			local var_195_11 = 0.1

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_12 = arg_192_1:FormatText(StoryNameCfg[68].name)

				arg_192_1.leftNameTxt_.text = var_195_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2037")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_13 = arg_192_1:GetWordFromCfg(319281045)
				local var_195_14 = arg_192_1:FormatText(var_195_13.content)

				arg_192_1.text_.text = var_195_14

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_15 = 4
				local var_195_16 = utf8.len(var_195_14)
				local var_195_17 = var_195_15 <= 0 and var_195_11 or var_195_11 * (var_195_16 / var_195_15)

				if var_195_17 > 0 and var_195_11 < var_195_17 then
					arg_192_1.talkMaxDuration = var_195_17

					if var_195_17 + var_195_10 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_17 + var_195_10
					end
				end

				arg_192_1.text_.text = var_195_14
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_18 = math.max(var_195_11, arg_192_1.talkMaxDuration)

			if var_195_10 <= arg_192_1.time_ and arg_192_1.time_ < var_195_10 + var_195_18 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_10) / var_195_18

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_10 + var_195_18 and arg_192_1.time_ < var_195_10 + var_195_18 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play319281046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 319281046
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play319281047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10079ui_story"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos10079ui_story = var_199_0.localPosition

				local var_199_2 = "10079ui_story"

				arg_196_1:ShowWeapon(arg_196_1.var_[var_199_2 .. "Animator"].transform, false)
			end

			local var_199_3 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_3 then
				local var_199_4 = (arg_196_1.time_ - var_199_1) / var_199_3
				local var_199_5 = Vector3.New(0, 100, 0)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10079ui_story, var_199_5, var_199_4)

				local var_199_6 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_6.x, var_199_6.y, var_199_6.z)

				local var_199_7 = var_199_0.localEulerAngles

				var_199_7.z = 0
				var_199_7.x = 0
				var_199_0.localEulerAngles = var_199_7
			end

			if arg_196_1.time_ >= var_199_1 + var_199_3 and arg_196_1.time_ < var_199_1 + var_199_3 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(0, 100, 0)

				local var_199_8 = manager.ui.mainCamera.transform.position - var_199_0.position

				var_199_0.forward = Vector3.New(var_199_8.x, var_199_8.y, var_199_8.z)

				local var_199_9 = var_199_0.localEulerAngles

				var_199_9.z = 0
				var_199_9.x = 0
				var_199_0.localEulerAngles = var_199_9
			end

			local var_199_10 = 0
			local var_199_11 = 0.7

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_12 = arg_196_1:GetWordFromCfg(319281046)
				local var_199_13 = arg_196_1:FormatText(var_199_12.content)

				arg_196_1.text_.text = var_199_13

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_14 = 28
				local var_199_15 = utf8.len(var_199_13)
				local var_199_16 = var_199_14 <= 0 and var_199_11 or var_199_11 * (var_199_15 / var_199_14)

				if var_199_16 > 0 and var_199_11 < var_199_16 then
					arg_196_1.talkMaxDuration = var_199_16

					if var_199_16 + var_199_10 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_16 + var_199_10
					end
				end

				arg_196_1.text_.text = var_199_13
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_17 = math.max(var_199_11, arg_196_1.talkMaxDuration)

			if var_199_10 <= arg_196_1.time_ and arg_196_1.time_ < var_199_10 + var_199_17 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_10) / var_199_17

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_10 + var_199_17 and arg_196_1.time_ < var_199_10 + var_199_17 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play319281047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 319281047
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
			arg_200_1.auto_ = false
		end

		function arg_200_1.playNext_(arg_202_0)
			arg_200_1.onStoryFinished_()
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 0.75

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_2 = arg_200_1:GetWordFromCfg(319281047)
				local var_203_3 = arg_200_1:FormatText(var_203_2.content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 30
				local var_203_5 = utf8.len(var_203_3)
				local var_203_6 = var_203_4 <= 0 and var_203_1 or var_203_1 * (var_203_5 / var_203_4)

				if var_203_6 > 0 and var_203_1 < var_203_6 then
					arg_200_1.talkMaxDuration = var_203_6

					if var_203_6 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_7 and arg_200_1.time_ < var_203_0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I10f"
	},
	voices = {
		"story_v_out_319281.awb"
	}
}
