return {
	Play319891001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319891001
		arg_1_1.duration_ = 5

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319891002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 0.2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_6 = 0.233333333333333
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "music"

				arg_1_1:AudioAction(var_4_8, var_4_9, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_4_10 = ""
				local var_4_11 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if var_4_11 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			local var_4_12 = 0

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				local var_4_13 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_14 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_15 = var_4_13:GetComponent("Text")
				local var_4_16 = var_4_13:GetComponent("RectTransform")

				var_4_15.alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_16.offsetMin = Vector2.New(0, 0)
				var_4_16.offsetMax = Vector2.New(0, 0)
			end

			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_18 = arg_1_1:GetWordFromCfg(319891001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.fswt_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_20 = 0.633333333333333

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_21 = 9
			local var_4_22 = 0.6
			local var_4_23 = arg_1_1:GetWordFromCfg(319891001)
			local var_4_24 = arg_1_1:FormatText(var_4_23.content)
			local var_4_25, var_4_26 = arg_1_1:GetPercentByPara(var_4_24, 1)

			if var_4_20 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_27 = var_4_21 <= 0 and var_4_22 or var_4_22 * ((var_4_26 - arg_1_1.typewritterCharCountI18N) / var_4_21)

				if var_4_27 > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end
				end
			end

			local var_4_28 = 0.6
			local var_4_29 = math.max(var_4_28, arg_1_1.talkMaxDuration)

			if var_4_20 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_20) / var_4_29

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_25, var_4_30)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_29 and arg_1_1.time_ < var_4_20 + var_4_29 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_25

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_26
			end

			local var_4_31 = "STblack"

			if arg_1_1.bgs_[var_4_31] == nil then
				local var_4_32 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_32:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_31)
				var_4_32.name = var_4_31
				var_4_32.transform.parent = arg_1_1.stage_.transform
				var_4_32.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_31] = var_4_32
			end

			local var_4_33 = 0

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_34 = manager.ui.mainCamera.transform.localPosition
				local var_4_35 = Vector3.New(0, 0, 10) + Vector3.New(var_4_34.x, var_4_34.y, 0)
				local var_4_36 = arg_1_1.bgs_.STblack

				var_4_36.transform.localPosition = var_4_35
				var_4_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_37 = var_4_36:GetComponent("SpriteRenderer")

				if var_4_37 and var_4_37.sprite then
					local var_4_38 = (var_4_36.transform.localPosition - var_4_34).z
					local var_4_39 = manager.ui.mainCameraCom_
					local var_4_40 = 2 * var_4_38 * Mathf.Tan(var_4_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_41 = var_4_40 * var_4_39.aspect
					local var_4_42 = var_4_37.sprite.bounds.size.x
					local var_4_43 = var_4_37.sprite.bounds.size.y
					local var_4_44 = var_4_41 / var_4_42
					local var_4_45 = var_4_40 / var_4_43
					local var_4_46 = var_4_45 < var_4_44 and var_4_44 or var_4_45

					var_4_36.transform.localScale = Vector3.New(var_4_46, var_4_46, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_47 = 0.633333333333333
			local var_4_48 = 1.833
			local var_4_49 = manager.audio:GetVoiceLength("story_v_out_319891", "319891001", "story_v_out_319891.awb") / 1000

			if var_4_49 > 0 and var_4_48 < var_4_49 and var_4_49 + var_4_47 > arg_1_1.duration_ then
				local var_4_50 = var_4_49

				arg_1_1.duration_ = var_4_49 + var_4_47
			end

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "voice"

				arg_1_1:AudioAction(var_4_51, var_4_52, "story_v_out_319891", "319891001", "story_v_out_319891.awb")
			end

			local var_4_53 = 0

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_54 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_54.offsetMin = Vector2.New(410, 330)
				var_4_54.offsetMax = Vector2.New(-400, -180)

				local var_4_55 = arg_1_1:GetWordFromCfg(419064)
				local var_4_56 = arg_1_1:FormatText(var_4_55.content)

				arg_1_1.cswt_.text = var_4_56

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 173
				arg_1_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319891002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 319891002
		arg_7_1.duration_ = 6.23

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play319891003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = "ST15a"

			if arg_7_1.bgs_[var_10_0] == nil then
				local var_10_1 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_10_0)
				var_10_1.name = var_10_0
				var_10_1.transform.parent = arg_7_1.stage_.transform
				var_10_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_[var_10_0] = var_10_1
			end

			local var_10_2 = 0

			if var_10_2 < arg_7_1.time_ and arg_7_1.time_ <= var_10_2 + arg_10_0 then
				local var_10_3 = manager.ui.mainCamera.transform.localPosition
				local var_10_4 = Vector3.New(0, 0, 10) + Vector3.New(var_10_3.x, var_10_3.y, 0)
				local var_10_5 = arg_7_1.bgs_.ST15a

				var_10_5.transform.localPosition = var_10_4
				var_10_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_10_6 = var_10_5:GetComponent("SpriteRenderer")

				if var_10_6 and var_10_6.sprite then
					local var_10_7 = (var_10_5.transform.localPosition - var_10_3).z
					local var_10_8 = manager.ui.mainCameraCom_
					local var_10_9 = 2 * var_10_7 * Mathf.Tan(var_10_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_10_10 = var_10_9 * var_10_8.aspect
					local var_10_11 = var_10_6.sprite.bounds.size.x
					local var_10_12 = var_10_6.sprite.bounds.size.y
					local var_10_13 = var_10_10 / var_10_11
					local var_10_14 = var_10_9 / var_10_12
					local var_10_15 = var_10_14 < var_10_13 and var_10_13 or var_10_14

					var_10_5.transform.localScale = Vector3.New(var_10_15, var_10_15, 0)
				end

				for iter_10_0, iter_10_1 in pairs(arg_7_1.bgs_) do
					if iter_10_0 ~= "ST15a" then
						iter_10_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_10_16 = 0

			if var_10_16 < arg_7_1.time_ and arg_7_1.time_ <= var_10_16 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_17 = 1.4

			if var_10_16 <= arg_7_1.time_ and arg_7_1.time_ < var_10_16 + var_10_17 then
				local var_10_18 = (arg_7_1.time_ - var_10_16) / var_10_17
				local var_10_19 = Color.New(0, 0, 0)

				var_10_19.a = Mathf.Lerp(1, 0, var_10_18)
				arg_7_1.mask_.color = var_10_19
			end

			if arg_7_1.time_ >= var_10_16 + var_10_17 and arg_7_1.time_ < var_10_16 + var_10_17 + arg_10_0 then
				local var_10_20 = Color.New(0, 0, 0)
				local var_10_21 = 0

				arg_7_1.mask_.enabled = false
				var_10_20.a = var_10_21
				arg_7_1.mask_.color = var_10_20
			end

			local var_10_22 = "1084ui_story"

			if arg_7_1.actors_[var_10_22] == nil then
				local var_10_23 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_10_23) then
					local var_10_24 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_7_1.stage_.transform)

					var_10_24.name = var_10_22
					var_10_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_7_1.actors_[var_10_22] = var_10_24

					local var_10_25 = var_10_24:GetComponentInChildren(typeof(CharacterEffect))

					var_10_25.enabled = true

					local var_10_26 = GameObjectTools.GetOrAddComponent(var_10_24, typeof(DynamicBoneHelper))

					if var_10_26 then
						var_10_26:EnableDynamicBone(false)
					end

					arg_7_1:ShowWeapon(var_10_25.transform, false)

					arg_7_1.var_[var_10_22 .. "Animator"] = var_10_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_7_1.var_[var_10_22 .. "Animator"].applyRootMotion = true
					arg_7_1.var_[var_10_22 .. "LipSync"] = var_10_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_10_27 = arg_7_1.actors_["1084ui_story"]
			local var_10_28 = 0

			if var_10_28 < arg_7_1.time_ and arg_7_1.time_ <= var_10_28 + arg_10_0 and not isNil(var_10_27) and arg_7_1.var_.characterEffect1084ui_story == nil then
				arg_7_1.var_.characterEffect1084ui_story = var_10_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_29 = 0.200000002980232

			if var_10_28 <= arg_7_1.time_ and arg_7_1.time_ < var_10_28 + var_10_29 and not isNil(var_10_27) then
				local var_10_30 = (arg_7_1.time_ - var_10_28) / var_10_29

				if arg_7_1.var_.characterEffect1084ui_story and not isNil(var_10_27) then
					local var_10_31 = Mathf.Lerp(0, 0.5, var_10_30)

					arg_7_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1084ui_story.fillRatio = var_10_31
				end
			end

			if arg_7_1.time_ >= var_10_28 + var_10_29 and arg_7_1.time_ < var_10_28 + var_10_29 + arg_10_0 and not isNil(var_10_27) and arg_7_1.var_.characterEffect1084ui_story then
				local var_10_32 = 0.5

				arg_7_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1084ui_story.fillRatio = var_10_32
			end

			local var_10_33 = 0
			local var_10_34 = 1

			if var_10_33 < arg_7_1.time_ and arg_7_1.time_ <= var_10_33 + arg_10_0 then
				local var_10_35 = "play"
				local var_10_36 = "effect"

				arg_7_1:AudioAction(var_10_35, var_10_36, "se_story_130", "se_story_130_sea", "")
			end

			local var_10_37 = 0

			if var_10_37 < arg_7_1.time_ and arg_7_1.time_ <= var_10_37 + arg_10_0 then
				arg_7_1.fswbg_:SetActive(false)
				arg_7_1.dialog_:SetActive(false)
				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_38 = 0.1

			if var_10_38 < arg_7_1.time_ and arg_7_1.time_ <= var_10_38 + arg_10_0 then
				arg_7_1.fswbg_:SetActive(false)
				arg_7_1.dialog_:SetActive(false)
				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_39 = 0

			if var_10_39 < arg_7_1.time_ and arg_7_1.time_ <= var_10_39 + arg_10_0 then
				arg_7_1.cswbg_:SetActive(false)
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_40 = 1.23333333333333
			local var_10_41 = 1.475

			if var_10_40 < arg_7_1.time_ and arg_7_1.time_ <= var_10_40 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_42 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_42:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_43 = arg_7_1:GetWordFromCfg(319891002)
				local var_10_44 = arg_7_1:FormatText(var_10_43.content)

				arg_7_1.text_.text = var_10_44

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_45 = 59
				local var_10_46 = utf8.len(var_10_44)
				local var_10_47 = var_10_45 <= 0 and var_10_41 or var_10_41 * (var_10_46 / var_10_45)

				if var_10_47 > 0 and var_10_41 < var_10_47 then
					arg_7_1.talkMaxDuration = var_10_47
					var_10_40 = var_10_40 + 0.3

					if var_10_47 + var_10_40 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_47 + var_10_40
					end
				end

				arg_7_1.text_.text = var_10_44
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_48 = var_10_40 + 0.3
			local var_10_49 = math.max(var_10_41, arg_7_1.talkMaxDuration)

			if var_10_48 <= arg_7_1.time_ and arg_7_1.time_ < var_10_48 + var_10_49 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_48) / var_10_49

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_48 + var_10_49 and arg_7_1.time_ < var_10_48 + var_10_49 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play319891003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319891003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play319891004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.425

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(319891003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 57
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319891004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319891004
		arg_17_1.duration_ = 2.57

		local var_17_0 = {
			zh = 1.999999999999,
			ja = 2.566
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
				arg_17_0:Play319891005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1084ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1084ui_story = var_20_0.localPosition

				local var_20_2 = "1084ui_story"

				arg_17_1:ShowWeapon(arg_17_1.var_[var_20_2 .. "Animator"].transform, false)
			end

			local var_20_3 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_3 then
				local var_20_4 = (arg_17_1.time_ - var_20_1) / var_20_3
				local var_20_5 = Vector3.New(0, -0.97, -6)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1084ui_story, var_20_5, var_20_4)

				local var_20_6 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_6.x, var_20_6.y, var_20_6.z)

				local var_20_7 = var_20_0.localEulerAngles

				var_20_7.z = 0
				var_20_7.x = 0
				var_20_0.localEulerAngles = var_20_7
			end

			if arg_17_1.time_ >= var_20_1 + var_20_3 and arg_17_1.time_ < var_20_1 + var_20_3 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_20_8 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_8.x, var_20_8.y, var_20_8.z)

				local var_20_9 = var_20_0.localEulerAngles

				var_20_9.z = 0
				var_20_9.x = 0
				var_20_0.localEulerAngles = var_20_9
			end

			local var_20_10 = arg_17_1.actors_["1084ui_story"]
			local var_20_11 = 0

			if var_20_11 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = var_20_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_12 = 0.200000002980232

			if var_20_11 <= arg_17_1.time_ and arg_17_1.time_ < var_20_11 + var_20_12 and not isNil(var_20_10) then
				local var_20_13 = (arg_17_1.time_ - var_20_11) / var_20_12

				if arg_17_1.var_.characterEffect1084ui_story and not isNil(var_20_10) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_11 + var_20_12 and arg_17_1.time_ < var_20_11 + var_20_12 + arg_20_0 and not isNil(var_20_10) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_20_15 = 0

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_20_16 = 0
			local var_20_17 = 0.25

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_18 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_19 = arg_17_1:GetWordFromCfg(319891004)
				local var_20_20 = arg_17_1:FormatText(var_20_19.content)

				arg_17_1.text_.text = var_20_20

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_21 = 10
				local var_20_22 = utf8.len(var_20_20)
				local var_20_23 = var_20_21 <= 0 and var_20_17 or var_20_17 * (var_20_22 / var_20_21)

				if var_20_23 > 0 and var_20_17 < var_20_23 then
					arg_17_1.talkMaxDuration = var_20_23

					if var_20_23 + var_20_16 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_16
					end
				end

				arg_17_1.text_.text = var_20_20
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891004", "story_v_out_319891.awb") ~= 0 then
					local var_20_24 = manager.audio:GetVoiceLength("story_v_out_319891", "319891004", "story_v_out_319891.awb") / 1000

					if var_20_24 + var_20_16 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_24 + var_20_16
					end

					if var_20_19.prefab_name ~= "" and arg_17_1.actors_[var_20_19.prefab_name] ~= nil then
						local var_20_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_19.prefab_name].transform, "story_v_out_319891", "319891004", "story_v_out_319891.awb")

						arg_17_1:RecordAudio("319891004", var_20_25)
						arg_17_1:RecordAudio("319891004", var_20_25)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319891", "319891004", "story_v_out_319891.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319891", "319891004", "story_v_out_319891.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_26 = math.max(var_20_17, arg_17_1.talkMaxDuration)

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_26 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_16) / var_20_26

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_16 + var_20_26 and arg_17_1.time_ < var_20_16 + var_20_26 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play319891005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319891005
		arg_21_1.duration_ = 3

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play319891006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1084ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1084ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1084ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, 100, 0)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = 0

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				local var_24_10 = arg_21_1.fswbg_.transform:Find("textbox/adapt/content") or arg_21_1.fswbg_.transform:Find("textbox/content")
				local var_24_11 = arg_21_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_24_12 = var_24_10:GetComponent("Text")
				local var_24_13 = var_24_10:GetComponent("RectTransform")

				var_24_12.alignment = UnityEngine.TextAnchor.LowerCenter
				var_24_13.offsetMin = Vector2.New(0, 0)
				var_24_13.offsetMax = Vector2.New(0, 0)
			end

			local var_24_14 = 0

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1.fswbg_:SetActive(true)
				arg_21_1.dialog_:SetActive(false)

				arg_21_1.fswtw_.percent = 0

				local var_24_15 = arg_21_1:GetWordFromCfg(319891005)
				local var_24_16 = arg_21_1:FormatText(var_24_15.content)

				arg_21_1.fswt_.text = var_24_16

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.fswt_)

				arg_21_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_21_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_21_1.fswtw_:SetDirty()

				arg_21_1.typewritterCharCountI18N = 0

				SetActive(arg_21_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_21_1:ShowNextGo(false)
			end

			local var_24_17 = 0.666666666666667

			if var_24_17 < arg_21_1.time_ and arg_21_1.time_ <= var_24_17 + arg_24_0 then
				arg_21_1.var_.oldValueTypewriter = arg_21_1.fswtw_.percent

				SetActive(arg_21_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_21_1:ShowNextGo(false)
			end

			local var_24_18 = 6
			local var_24_19 = 0.4
			local var_24_20 = arg_21_1:GetWordFromCfg(319891005)
			local var_24_21 = arg_21_1:FormatText(var_24_20.content)
			local var_24_22, var_24_23 = arg_21_1:GetPercentByPara(var_24_21, 1)

			if var_24_17 < arg_21_1.time_ and arg_21_1.time_ <= var_24_17 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				local var_24_24 = var_24_18 <= 0 and var_24_19 or var_24_19 * ((var_24_23 - arg_21_1.typewritterCharCountI18N) / var_24_18)

				if var_24_24 > 0 and var_24_19 < var_24_24 then
					arg_21_1.talkMaxDuration = var_24_24

					if var_24_24 + var_24_17 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_24 + var_24_17
					end
				end
			end

			local var_24_25 = 0.4
			local var_24_26 = math.max(var_24_25, arg_21_1.talkMaxDuration)

			if var_24_17 <= arg_21_1.time_ and arg_21_1.time_ < var_24_17 + var_24_26 then
				local var_24_27 = (arg_21_1.time_ - var_24_17) / var_24_26

				arg_21_1.fswtw_.percent = Mathf.Lerp(arg_21_1.var_.oldValueTypewriter, var_24_22, var_24_27)
				arg_21_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_21_1.fswtw_:SetDirty()
			end

			if arg_21_1.time_ >= var_24_17 + var_24_26 and arg_21_1.time_ < var_24_17 + var_24_26 + arg_24_0 then
				arg_21_1.fswtw_.percent = var_24_22

				arg_21_1.fswtw_:SetDirty()
				arg_21_1:ShowNextGo(true)

				arg_21_1.typewritterCharCountI18N = var_24_23
			end

			local var_24_28 = 0

			if var_24_28 < arg_21_1.time_ and arg_21_1.time_ <= var_24_28 + arg_24_0 then
				local var_24_29 = manager.ui.mainCamera.transform.localPosition
				local var_24_30 = Vector3.New(0, 0, 10) + Vector3.New(var_24_29.x, var_24_29.y, 0)
				local var_24_31 = arg_21_1.bgs_.STblack

				var_24_31.transform.localPosition = var_24_30
				var_24_31.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_32 = var_24_31:GetComponent("SpriteRenderer")

				if var_24_32 and var_24_32.sprite then
					local var_24_33 = (var_24_31.transform.localPosition - var_24_29).z
					local var_24_34 = manager.ui.mainCameraCom_
					local var_24_35 = 2 * var_24_33 * Mathf.Tan(var_24_34.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_24_36 = var_24_35 * var_24_34.aspect
					local var_24_37 = var_24_32.sprite.bounds.size.x
					local var_24_38 = var_24_32.sprite.bounds.size.y
					local var_24_39 = var_24_36 / var_24_37
					local var_24_40 = var_24_35 / var_24_38
					local var_24_41 = var_24_40 < var_24_39 and var_24_39 or var_24_40

					var_24_31.transform.localScale = Vector3.New(var_24_41, var_24_41, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "STblack" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_42 = 0.666666666666667
			local var_24_43 = 1.366
			local var_24_44 = manager.audio:GetVoiceLength("story_v_out_319891", "319891005", "story_v_out_319891.awb") / 1000

			if var_24_44 > 0 and var_24_43 < var_24_44 and var_24_44 + var_24_42 > arg_21_1.duration_ then
				local var_24_45 = var_24_44

				arg_21_1.duration_ = var_24_44 + var_24_42
			end

			if var_24_42 < arg_21_1.time_ and arg_21_1.time_ <= var_24_42 + arg_24_0 then
				local var_24_46 = "play"
				local var_24_47 = "voice"

				arg_21_1:AudioAction(var_24_46, var_24_47, "story_v_out_319891", "319891005", "story_v_out_319891.awb")
			end

			local var_24_48 = 0

			if var_24_48 < arg_21_1.time_ and arg_21_1.time_ <= var_24_48 + arg_24_0 then
				arg_21_1.cswbg_:SetActive(true)

				local var_24_49 = arg_21_1.cswt_:GetComponent("RectTransform")

				arg_21_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_24_49.offsetMin = Vector2.New(410, 330)
				var_24_49.offsetMax = Vector2.New(-400, -180)

				local var_24_50 = arg_21_1:GetWordFromCfg(419065)
				local var_24_51 = arg_21_1:FormatText(var_24_50.content)

				arg_21_1.cswt_.text = var_24_51

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.cswt_)

				arg_21_1.cswt_.fontSize = 173
				arg_21_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_21_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_21_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play319891006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319891006
		arg_25_1.duration_ = 5.87

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play319891007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				local var_28_1 = manager.ui.mainCamera.transform.localPosition
				local var_28_2 = Vector3.New(0, 0, 10) + Vector3.New(var_28_1.x, var_28_1.y, 0)
				local var_28_3 = arg_25_1.bgs_.ST15a

				var_28_3.transform.localPosition = var_28_2
				var_28_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_4 = var_28_3:GetComponent("SpriteRenderer")

				if var_28_4 and var_28_4.sprite then
					local var_28_5 = (var_28_3.transform.localPosition - var_28_1).z
					local var_28_6 = manager.ui.mainCameraCom_
					local var_28_7 = 2 * var_28_5 * Mathf.Tan(var_28_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_28_8 = var_28_7 * var_28_6.aspect
					local var_28_9 = var_28_4.sprite.bounds.size.x
					local var_28_10 = var_28_4.sprite.bounds.size.y
					local var_28_11 = var_28_8 / var_28_9
					local var_28_12 = var_28_7 / var_28_10
					local var_28_13 = var_28_12 < var_28_11 and var_28_11 or var_28_12

					var_28_3.transform.localScale = Vector3.New(var_28_13, var_28_13, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "ST15a" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_14 = "1095ui_story"

			if arg_25_1.actors_[var_28_14] == nil then
				local var_28_15 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_28_15) then
					local var_28_16 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_25_1.stage_.transform)

					var_28_16.name = var_28_14
					var_28_16.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_14] = var_28_16

					local var_28_17 = var_28_16:GetComponentInChildren(typeof(CharacterEffect))

					var_28_17.enabled = true

					local var_28_18 = GameObjectTools.GetOrAddComponent(var_28_16, typeof(DynamicBoneHelper))

					if var_28_18 then
						var_28_18:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_17.transform, false)

					arg_25_1.var_[var_28_14 .. "Animator"] = var_28_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_14 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_14 .. "LipSync"] = var_28_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_19 = arg_25_1.actors_["1095ui_story"]
			local var_28_20 = 0

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 and not isNil(var_28_19) and arg_25_1.var_.characterEffect1095ui_story == nil then
				arg_25_1.var_.characterEffect1095ui_story = var_28_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_21 = 0.200000002980232

			if var_28_20 <= arg_25_1.time_ and arg_25_1.time_ < var_28_20 + var_28_21 and not isNil(var_28_19) then
				local var_28_22 = (arg_25_1.time_ - var_28_20) / var_28_21

				if arg_25_1.var_.characterEffect1095ui_story and not isNil(var_28_19) then
					local var_28_23 = Mathf.Lerp(0, 0.5, var_28_22)

					arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1095ui_story.fillRatio = var_28_23
				end
			end

			if arg_25_1.time_ >= var_28_20 + var_28_21 and arg_25_1.time_ < var_28_20 + var_28_21 + arg_28_0 and not isNil(var_28_19) and arg_25_1.var_.characterEffect1095ui_story then
				local var_28_24 = 0.5

				arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1095ui_story.fillRatio = var_28_24
			end

			local var_28_25 = 0

			if var_28_25 < arg_25_1.time_ and arg_25_1.time_ <= var_28_25 + arg_28_0 then
				arg_25_1.fswbg_:SetActive(false)
				arg_25_1.dialog_:SetActive(false)
				SetActive(arg_25_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_25_1:ShowNextGo(false)
			end

			local var_28_26 = 0.1

			if var_28_26 < arg_25_1.time_ and arg_25_1.time_ <= var_28_26 + arg_28_0 then
				arg_25_1.fswbg_:SetActive(false)
				arg_25_1.dialog_:SetActive(false)
				SetActive(arg_25_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_25_1:ShowNextGo(false)
			end

			local var_28_27 = 0

			if var_28_27 < arg_25_1.time_ and arg_25_1.time_ <= var_28_27 + arg_28_0 then
				arg_25_1.cswbg_:SetActive(false)
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_28 = 0.866666666666667
			local var_28_29 = 0.775

			if var_28_28 < arg_25_1.time_ and arg_25_1.time_ <= var_28_28 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_30 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_30:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_31 = arg_25_1:GetWordFromCfg(319891006)
				local var_28_32 = arg_25_1:FormatText(var_28_31.content)

				arg_25_1.text_.text = var_28_32

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_33 = 31
				local var_28_34 = utf8.len(var_28_32)
				local var_28_35 = var_28_33 <= 0 and var_28_29 or var_28_29 * (var_28_34 / var_28_33)

				if var_28_35 > 0 and var_28_29 < var_28_35 then
					arg_25_1.talkMaxDuration = var_28_35
					var_28_28 = var_28_28 + 0.3

					if var_28_35 + var_28_28 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_35 + var_28_28
					end
				end

				arg_25_1.text_.text = var_28_32
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_36 = var_28_28 + 0.3
			local var_28_37 = math.max(var_28_29, arg_25_1.talkMaxDuration)

			if var_28_36 <= arg_25_1.time_ and arg_25_1.time_ < var_28_36 + var_28_37 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_36) / var_28_37

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_36 + var_28_37 and arg_25_1.time_ < var_28_36 + var_28_37 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319891007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 319891007
		arg_31_1.duration_ = 9.63

		local var_31_0 = {
			zh = 6.5,
			ja = 9.633
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
				arg_31_0:Play319891008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1084ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1084ui_story = var_34_0.localPosition

				local var_34_2 = "1084ui_story"

				arg_31_1:ShowWeapon(arg_31_1.var_[var_34_2 .. "Animator"].transform, false)
			end

			local var_34_3 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_3 then
				local var_34_4 = (arg_31_1.time_ - var_34_1) / var_34_3
				local var_34_5 = Vector3.New(-0.7, -0.97, -6)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1084ui_story, var_34_5, var_34_4)

				local var_34_6 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_6.x, var_34_6.y, var_34_6.z)

				local var_34_7 = var_34_0.localEulerAngles

				var_34_7.z = 0
				var_34_7.x = 0
				var_34_0.localEulerAngles = var_34_7
			end

			if arg_31_1.time_ >= var_34_1 + var_34_3 and arg_31_1.time_ < var_34_1 + var_34_3 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_34_8 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_8.x, var_34_8.y, var_34_8.z)

				local var_34_9 = var_34_0.localEulerAngles

				var_34_9.z = 0
				var_34_9.x = 0
				var_34_0.localEulerAngles = var_34_9
			end

			local var_34_10 = arg_31_1.actors_["1084ui_story"]
			local var_34_11 = 0

			if var_34_11 < arg_31_1.time_ and arg_31_1.time_ <= var_34_11 + arg_34_0 and not isNil(var_34_10) and arg_31_1.var_.characterEffect1084ui_story == nil then
				arg_31_1.var_.characterEffect1084ui_story = var_34_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_12 = 0.200000002980232

			if var_34_11 <= arg_31_1.time_ and arg_31_1.time_ < var_34_11 + var_34_12 and not isNil(var_34_10) then
				local var_34_13 = (arg_31_1.time_ - var_34_11) / var_34_12

				if arg_31_1.var_.characterEffect1084ui_story and not isNil(var_34_10) then
					arg_31_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_11 + var_34_12 and arg_31_1.time_ < var_34_11 + var_34_12 + arg_34_0 and not isNil(var_34_10) and arg_31_1.var_.characterEffect1084ui_story then
				arg_31_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_34_14 = 0

			if var_34_14 < arg_31_1.time_ and arg_31_1.time_ <= var_34_14 + arg_34_0 then
				arg_31_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_34_15 = 0
			local var_34_16 = 0.65

			if var_34_15 < arg_31_1.time_ and arg_31_1.time_ <= var_34_15 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_17 = arg_31_1:FormatText(StoryNameCfg[6].name)

				arg_31_1.leftNameTxt_.text = var_34_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_18 = arg_31_1:GetWordFromCfg(319891007)
				local var_34_19 = arg_31_1:FormatText(var_34_18.content)

				arg_31_1.text_.text = var_34_19

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_20 = 26
				local var_34_21 = utf8.len(var_34_19)
				local var_34_22 = var_34_20 <= 0 and var_34_16 or var_34_16 * (var_34_21 / var_34_20)

				if var_34_22 > 0 and var_34_16 < var_34_22 then
					arg_31_1.talkMaxDuration = var_34_22

					if var_34_22 + var_34_15 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_22 + var_34_15
					end
				end

				arg_31_1.text_.text = var_34_19
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891007", "story_v_out_319891.awb") ~= 0 then
					local var_34_23 = manager.audio:GetVoiceLength("story_v_out_319891", "319891007", "story_v_out_319891.awb") / 1000

					if var_34_23 + var_34_15 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_23 + var_34_15
					end

					if var_34_18.prefab_name ~= "" and arg_31_1.actors_[var_34_18.prefab_name] ~= nil then
						local var_34_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_18.prefab_name].transform, "story_v_out_319891", "319891007", "story_v_out_319891.awb")

						arg_31_1:RecordAudio("319891007", var_34_24)
						arg_31_1:RecordAudio("319891007", var_34_24)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_319891", "319891007", "story_v_out_319891.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_319891", "319891007", "story_v_out_319891.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_25 = math.max(var_34_16, arg_31_1.talkMaxDuration)

			if var_34_15 <= arg_31_1.time_ and arg_31_1.time_ < var_34_15 + var_34_25 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_15) / var_34_25

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_15 + var_34_25 and arg_31_1.time_ < var_34_15 + var_34_25 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play319891008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 319891008
		arg_35_1.duration_ = 3.27

		local var_35_0 = {
			zh = 3.266,
			ja = 1.999999999999
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play319891009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1095ui_story"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos1095ui_story = var_38_0.localPosition

				local var_38_2 = "1095ui_story"

				arg_35_1:ShowWeapon(arg_35_1.var_[var_38_2 .. "Animator"].transform, false)
			end

			local var_38_3 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_3 then
				local var_38_4 = (arg_35_1.time_ - var_38_1) / var_38_3
				local var_38_5 = Vector3.New(0.7, -0.98, -6.1)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1095ui_story, var_38_5, var_38_4)

				local var_38_6 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_6.x, var_38_6.y, var_38_6.z)

				local var_38_7 = var_38_0.localEulerAngles

				var_38_7.z = 0
				var_38_7.x = 0
				var_38_0.localEulerAngles = var_38_7
			end

			if arg_35_1.time_ >= var_38_1 + var_38_3 and arg_35_1.time_ < var_38_1 + var_38_3 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_38_8 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_8.x, var_38_8.y, var_38_8.z)

				local var_38_9 = var_38_0.localEulerAngles

				var_38_9.z = 0
				var_38_9.x = 0
				var_38_0.localEulerAngles = var_38_9
			end

			local var_38_10 = arg_35_1.actors_["1095ui_story"]
			local var_38_11 = 0

			if var_38_11 < arg_35_1.time_ and arg_35_1.time_ <= var_38_11 + arg_38_0 and not isNil(var_38_10) and arg_35_1.var_.characterEffect1095ui_story == nil then
				arg_35_1.var_.characterEffect1095ui_story = var_38_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_12 = 0.200000002980232

			if var_38_11 <= arg_35_1.time_ and arg_35_1.time_ < var_38_11 + var_38_12 and not isNil(var_38_10) then
				local var_38_13 = (arg_35_1.time_ - var_38_11) / var_38_12

				if arg_35_1.var_.characterEffect1095ui_story and not isNil(var_38_10) then
					arg_35_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_11 + var_38_12 and arg_35_1.time_ < var_38_11 + var_38_12 + arg_38_0 and not isNil(var_38_10) and arg_35_1.var_.characterEffect1095ui_story then
				arg_35_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_38_14 = 0

			if var_38_14 < arg_35_1.time_ and arg_35_1.time_ <= var_38_14 + arg_38_0 then
				arg_35_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_38_15 = arg_35_1.actors_["1084ui_story"].transform
			local var_38_16 = 0

			if var_38_16 < arg_35_1.time_ and arg_35_1.time_ <= var_38_16 + arg_38_0 then
				arg_35_1.var_.moveOldPos1084ui_story = var_38_15.localPosition

				local var_38_17 = "1084ui_story"

				arg_35_1:ShowWeapon(arg_35_1.var_[var_38_17 .. "Animator"].transform, false)
			end

			local var_38_18 = 0.001

			if var_38_16 <= arg_35_1.time_ and arg_35_1.time_ < var_38_16 + var_38_18 then
				local var_38_19 = (arg_35_1.time_ - var_38_16) / var_38_18
				local var_38_20 = Vector3.New(-0.7, -0.97, -6)

				var_38_15.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1084ui_story, var_38_20, var_38_19)

				local var_38_21 = manager.ui.mainCamera.transform.position - var_38_15.position

				var_38_15.forward = Vector3.New(var_38_21.x, var_38_21.y, var_38_21.z)

				local var_38_22 = var_38_15.localEulerAngles

				var_38_22.z = 0
				var_38_22.x = 0
				var_38_15.localEulerAngles = var_38_22
			end

			if arg_35_1.time_ >= var_38_16 + var_38_18 and arg_35_1.time_ < var_38_16 + var_38_18 + arg_38_0 then
				var_38_15.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_38_23 = manager.ui.mainCamera.transform.position - var_38_15.position

				var_38_15.forward = Vector3.New(var_38_23.x, var_38_23.y, var_38_23.z)

				local var_38_24 = var_38_15.localEulerAngles

				var_38_24.z = 0
				var_38_24.x = 0
				var_38_15.localEulerAngles = var_38_24
			end

			local var_38_25 = arg_35_1.actors_["1084ui_story"]
			local var_38_26 = 0

			if var_38_26 < arg_35_1.time_ and arg_35_1.time_ <= var_38_26 + arg_38_0 and not isNil(var_38_25) and arg_35_1.var_.characterEffect1084ui_story == nil then
				arg_35_1.var_.characterEffect1084ui_story = var_38_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_27 = 0.200000002980232

			if var_38_26 <= arg_35_1.time_ and arg_35_1.time_ < var_38_26 + var_38_27 and not isNil(var_38_25) then
				local var_38_28 = (arg_35_1.time_ - var_38_26) / var_38_27

				if arg_35_1.var_.characterEffect1084ui_story and not isNil(var_38_25) then
					local var_38_29 = Mathf.Lerp(0, 0.5, var_38_28)

					arg_35_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1084ui_story.fillRatio = var_38_29
				end
			end

			if arg_35_1.time_ >= var_38_26 + var_38_27 and arg_35_1.time_ < var_38_26 + var_38_27 + arg_38_0 and not isNil(var_38_25) and arg_35_1.var_.characterEffect1084ui_story then
				local var_38_30 = 0.5

				arg_35_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1084ui_story.fillRatio = var_38_30
			end

			local var_38_31 = 0
			local var_38_32 = 0.3

			if var_38_31 < arg_35_1.time_ and arg_35_1.time_ <= var_38_31 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_33 = arg_35_1:FormatText(StoryNameCfg[471].name)

				arg_35_1.leftNameTxt_.text = var_38_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_34 = arg_35_1:GetWordFromCfg(319891008)
				local var_38_35 = arg_35_1:FormatText(var_38_34.content)

				arg_35_1.text_.text = var_38_35

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_36 = 12
				local var_38_37 = utf8.len(var_38_35)
				local var_38_38 = var_38_36 <= 0 and var_38_32 or var_38_32 * (var_38_37 / var_38_36)

				if var_38_38 > 0 and var_38_32 < var_38_38 then
					arg_35_1.talkMaxDuration = var_38_38

					if var_38_38 + var_38_31 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_38 + var_38_31
					end
				end

				arg_35_1.text_.text = var_38_35
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891008", "story_v_out_319891.awb") ~= 0 then
					local var_38_39 = manager.audio:GetVoiceLength("story_v_out_319891", "319891008", "story_v_out_319891.awb") / 1000

					if var_38_39 + var_38_31 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_39 + var_38_31
					end

					if var_38_34.prefab_name ~= "" and arg_35_1.actors_[var_38_34.prefab_name] ~= nil then
						local var_38_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_34.prefab_name].transform, "story_v_out_319891", "319891008", "story_v_out_319891.awb")

						arg_35_1:RecordAudio("319891008", var_38_40)
						arg_35_1:RecordAudio("319891008", var_38_40)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_319891", "319891008", "story_v_out_319891.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_319891", "319891008", "story_v_out_319891.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_41 = math.max(var_38_32, arg_35_1.talkMaxDuration)

			if var_38_31 <= arg_35_1.time_ and arg_35_1.time_ < var_38_31 + var_38_41 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_31) / var_38_41

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_31 + var_38_41 and arg_35_1.time_ < var_38_31 + var_38_41 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play319891009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319891009
		arg_39_1.duration_ = 2.9

		local var_39_0 = {
			zh = 1.666,
			ja = 2.9
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play319891010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1084ui_story"].transform
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.var_.moveOldPos1084ui_story = var_42_0.localPosition
			end

			local var_42_2 = 0.001

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2
				local var_42_4 = Vector3.New(-0.7, -0.97, -6)

				var_42_0.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1084ui_story, var_42_4, var_42_3)

				local var_42_5 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_5.x, var_42_5.y, var_42_5.z)

				local var_42_6 = var_42_0.localEulerAngles

				var_42_6.z = 0
				var_42_6.x = 0
				var_42_0.localEulerAngles = var_42_6
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 then
				var_42_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_42_7 = manager.ui.mainCamera.transform.position - var_42_0.position

				var_42_0.forward = Vector3.New(var_42_7.x, var_42_7.y, var_42_7.z)

				local var_42_8 = var_42_0.localEulerAngles

				var_42_8.z = 0
				var_42_8.x = 0
				var_42_0.localEulerAngles = var_42_8
			end

			local var_42_9 = arg_39_1.actors_["1084ui_story"]
			local var_42_10 = 0

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1084ui_story == nil then
				arg_39_1.var_.characterEffect1084ui_story = var_42_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_11 = 0.200000002980232

			if var_42_10 <= arg_39_1.time_ and arg_39_1.time_ < var_42_10 + var_42_11 and not isNil(var_42_9) then
				local var_42_12 = (arg_39_1.time_ - var_42_10) / var_42_11

				if arg_39_1.var_.characterEffect1084ui_story and not isNil(var_42_9) then
					arg_39_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_10 + var_42_11 and arg_39_1.time_ < var_42_10 + var_42_11 + arg_42_0 and not isNil(var_42_9) and arg_39_1.var_.characterEffect1084ui_story then
				arg_39_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_42_13 = arg_39_1.actors_["1095ui_story"].transform
			local var_42_14 = 0

			if var_42_14 < arg_39_1.time_ and arg_39_1.time_ <= var_42_14 + arg_42_0 then
				arg_39_1.var_.moveOldPos1095ui_story = var_42_13.localPosition
			end

			local var_42_15 = 0.001

			if var_42_14 <= arg_39_1.time_ and arg_39_1.time_ < var_42_14 + var_42_15 then
				local var_42_16 = (arg_39_1.time_ - var_42_14) / var_42_15
				local var_42_17 = Vector3.New(0.7, -0.98, -6.1)

				var_42_13.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1095ui_story, var_42_17, var_42_16)

				local var_42_18 = manager.ui.mainCamera.transform.position - var_42_13.position

				var_42_13.forward = Vector3.New(var_42_18.x, var_42_18.y, var_42_18.z)

				local var_42_19 = var_42_13.localEulerAngles

				var_42_19.z = 0
				var_42_19.x = 0
				var_42_13.localEulerAngles = var_42_19
			end

			if arg_39_1.time_ >= var_42_14 + var_42_15 and arg_39_1.time_ < var_42_14 + var_42_15 + arg_42_0 then
				var_42_13.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_42_20 = manager.ui.mainCamera.transform.position - var_42_13.position

				var_42_13.forward = Vector3.New(var_42_20.x, var_42_20.y, var_42_20.z)

				local var_42_21 = var_42_13.localEulerAngles

				var_42_21.z = 0
				var_42_21.x = 0
				var_42_13.localEulerAngles = var_42_21
			end

			local var_42_22 = arg_39_1.actors_["1095ui_story"]
			local var_42_23 = 0

			if var_42_23 < arg_39_1.time_ and arg_39_1.time_ <= var_42_23 + arg_42_0 and not isNil(var_42_22) and arg_39_1.var_.characterEffect1095ui_story == nil then
				arg_39_1.var_.characterEffect1095ui_story = var_42_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_24 = 0.200000002980232

			if var_42_23 <= arg_39_1.time_ and arg_39_1.time_ < var_42_23 + var_42_24 and not isNil(var_42_22) then
				local var_42_25 = (arg_39_1.time_ - var_42_23) / var_42_24

				if arg_39_1.var_.characterEffect1095ui_story and not isNil(var_42_22) then
					local var_42_26 = Mathf.Lerp(0, 0.5, var_42_25)

					arg_39_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1095ui_story.fillRatio = var_42_26
				end
			end

			if arg_39_1.time_ >= var_42_23 + var_42_24 and arg_39_1.time_ < var_42_23 + var_42_24 + arg_42_0 and not isNil(var_42_22) and arg_39_1.var_.characterEffect1095ui_story then
				local var_42_27 = 0.5

				arg_39_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1095ui_story.fillRatio = var_42_27
			end

			local var_42_28 = 0
			local var_42_29 = 0.1

			if var_42_28 < arg_39_1.time_ and arg_39_1.time_ <= var_42_28 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_30 = arg_39_1:FormatText(StoryNameCfg[6].name)

				arg_39_1.leftNameTxt_.text = var_42_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_31 = arg_39_1:GetWordFromCfg(319891009)
				local var_42_32 = arg_39_1:FormatText(var_42_31.content)

				arg_39_1.text_.text = var_42_32

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_33 = 4
				local var_42_34 = utf8.len(var_42_32)
				local var_42_35 = var_42_33 <= 0 and var_42_29 or var_42_29 * (var_42_34 / var_42_33)

				if var_42_35 > 0 and var_42_29 < var_42_35 then
					arg_39_1.talkMaxDuration = var_42_35

					if var_42_35 + var_42_28 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_35 + var_42_28
					end
				end

				arg_39_1.text_.text = var_42_32
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891009", "story_v_out_319891.awb") ~= 0 then
					local var_42_36 = manager.audio:GetVoiceLength("story_v_out_319891", "319891009", "story_v_out_319891.awb") / 1000

					if var_42_36 + var_42_28 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_36 + var_42_28
					end

					if var_42_31.prefab_name ~= "" and arg_39_1.actors_[var_42_31.prefab_name] ~= nil then
						local var_42_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_31.prefab_name].transform, "story_v_out_319891", "319891009", "story_v_out_319891.awb")

						arg_39_1:RecordAudio("319891009", var_42_37)
						arg_39_1:RecordAudio("319891009", var_42_37)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_319891", "319891009", "story_v_out_319891.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_319891", "319891009", "story_v_out_319891.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_38 = math.max(var_42_29, arg_39_1.talkMaxDuration)

			if var_42_28 <= arg_39_1.time_ and arg_39_1.time_ < var_42_28 + var_42_38 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_28) / var_42_38

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_28 + var_42_38 and arg_39_1.time_ < var_42_28 + var_42_38 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play319891010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 319891010
		arg_43_1.duration_ = 4.2

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play319891011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1084ui_story"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos1084ui_story = var_46_0.localPosition
			end

			local var_46_2 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2
				local var_46_4 = Vector3.New(0, 100, 0)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1084ui_story, var_46_4, var_46_3)

				local var_46_5 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_5.x, var_46_5.y, var_46_5.z)

				local var_46_6 = var_46_0.localEulerAngles

				var_46_6.z = 0
				var_46_6.x = 0
				var_46_0.localEulerAngles = var_46_6
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, 100, 0)

				local var_46_7 = manager.ui.mainCamera.transform.position - var_46_0.position

				var_46_0.forward = Vector3.New(var_46_7.x, var_46_7.y, var_46_7.z)

				local var_46_8 = var_46_0.localEulerAngles

				var_46_8.z = 0
				var_46_8.x = 0
				var_46_0.localEulerAngles = var_46_8
			end

			local var_46_9 = arg_43_1.actors_["1095ui_story"].transform
			local var_46_10 = 0

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 then
				arg_43_1.var_.moveOldPos1095ui_story = var_46_9.localPosition
			end

			local var_46_11 = 0.001

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_11 then
				local var_46_12 = (arg_43_1.time_ - var_46_10) / var_46_11
				local var_46_13 = Vector3.New(0, 100, 0)

				var_46_9.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1095ui_story, var_46_13, var_46_12)

				local var_46_14 = manager.ui.mainCamera.transform.position - var_46_9.position

				var_46_9.forward = Vector3.New(var_46_14.x, var_46_14.y, var_46_14.z)

				local var_46_15 = var_46_9.localEulerAngles

				var_46_15.z = 0
				var_46_15.x = 0
				var_46_9.localEulerAngles = var_46_15
			end

			if arg_43_1.time_ >= var_46_10 + var_46_11 and arg_43_1.time_ < var_46_10 + var_46_11 + arg_46_0 then
				var_46_9.localPosition = Vector3.New(0, 100, 0)

				local var_46_16 = manager.ui.mainCamera.transform.position - var_46_9.position

				var_46_9.forward = Vector3.New(var_46_16.x, var_46_16.y, var_46_16.z)

				local var_46_17 = var_46_9.localEulerAngles

				var_46_17.z = 0
				var_46_17.x = 0
				var_46_9.localEulerAngles = var_46_17
			end

			local var_46_18 = 0

			if var_46_18 < arg_43_1.time_ and arg_43_1.time_ <= var_46_18 + arg_46_0 then
				local var_46_19 = arg_43_1.fswbg_.transform:Find("textbox/adapt/content") or arg_43_1.fswbg_.transform:Find("textbox/content")
				local var_46_20 = arg_43_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_46_21 = var_46_19:GetComponent("Text")
				local var_46_22 = var_46_19:GetComponent("RectTransform")

				var_46_21.alignment = UnityEngine.TextAnchor.LowerCenter
				var_46_22.offsetMin = Vector2.New(0, 0)
				var_46_22.offsetMax = Vector2.New(0, 0)
			end

			local var_46_23 = 0

			if var_46_23 < arg_43_1.time_ and arg_43_1.time_ <= var_46_23 + arg_46_0 then
				arg_43_1.fswbg_:SetActive(true)
				arg_43_1.dialog_:SetActive(false)

				arg_43_1.fswtw_.percent = 0

				local var_46_24 = arg_43_1:GetWordFromCfg(319891010)
				local var_46_25 = arg_43_1:FormatText(var_46_24.content)

				arg_43_1.fswt_.text = var_46_25

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.fswt_)

				arg_43_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_43_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_43_1.fswtw_:SetDirty()

				arg_43_1.typewritterCharCountI18N = 0

				SetActive(arg_43_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_43_1:ShowNextGo(false)
			end

			local var_46_26 = 0.5

			if var_46_26 < arg_43_1.time_ and arg_43_1.time_ <= var_46_26 + arg_46_0 then
				arg_43_1.var_.oldValueTypewriter = arg_43_1.fswtw_.percent

				SetActive(arg_43_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_43_1:ShowNextGo(false)
			end

			local var_46_27 = 22
			local var_46_28 = 1.46666666666667
			local var_46_29 = arg_43_1:GetWordFromCfg(319891010)
			local var_46_30 = arg_43_1:FormatText(var_46_29.content)
			local var_46_31, var_46_32 = arg_43_1:GetPercentByPara(var_46_30, 1)

			if var_46_26 < arg_43_1.time_ and arg_43_1.time_ <= var_46_26 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				local var_46_33 = var_46_27 <= 0 and var_46_28 or var_46_28 * ((var_46_32 - arg_43_1.typewritterCharCountI18N) / var_46_27)

				if var_46_33 > 0 and var_46_28 < var_46_33 then
					arg_43_1.talkMaxDuration = var_46_33

					if var_46_33 + var_46_26 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_33 + var_46_26
					end
				end
			end

			local var_46_34 = 1.46666666666667
			local var_46_35 = math.max(var_46_34, arg_43_1.talkMaxDuration)

			if var_46_26 <= arg_43_1.time_ and arg_43_1.time_ < var_46_26 + var_46_35 then
				local var_46_36 = (arg_43_1.time_ - var_46_26) / var_46_35

				arg_43_1.fswtw_.percent = Mathf.Lerp(arg_43_1.var_.oldValueTypewriter, var_46_31, var_46_36)
				arg_43_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_43_1.fswtw_:SetDirty()
			end

			if arg_43_1.time_ >= var_46_26 + var_46_35 and arg_43_1.time_ < var_46_26 + var_46_35 + arg_46_0 then
				arg_43_1.fswtw_.percent = var_46_31

				arg_43_1.fswtw_:SetDirty()
				arg_43_1:ShowNextGo(true)

				arg_43_1.typewritterCharCountI18N = var_46_32
			end

			local var_46_37 = 0

			if var_46_37 < arg_43_1.time_ and arg_43_1.time_ <= var_46_37 + arg_46_0 then
				local var_46_38 = manager.ui.mainCamera.transform.localPosition
				local var_46_39 = Vector3.New(0, 0, 10) + Vector3.New(var_46_38.x, var_46_38.y, 0)
				local var_46_40 = arg_43_1.bgs_.STblack

				var_46_40.transform.localPosition = var_46_39
				var_46_40.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_41 = var_46_40:GetComponent("SpriteRenderer")

				if var_46_41 and var_46_41.sprite then
					local var_46_42 = (var_46_40.transform.localPosition - var_46_38).z
					local var_46_43 = manager.ui.mainCameraCom_
					local var_46_44 = 2 * var_46_42 * Mathf.Tan(var_46_43.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_46_45 = var_46_44 * var_46_43.aspect
					local var_46_46 = var_46_41.sprite.bounds.size.x
					local var_46_47 = var_46_41.sprite.bounds.size.y
					local var_46_48 = var_46_45 / var_46_46
					local var_46_49 = var_46_44 / var_46_47
					local var_46_50 = var_46_49 < var_46_48 and var_46_48 or var_46_49

					var_46_40.transform.localScale = Vector3.New(var_46_50, var_46_50, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "STblack" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_51 = 0.5
			local var_46_52 = 3.7
			local var_46_53 = manager.audio:GetVoiceLength("story_v_out_319891", "319891010", "story_v_out_319891.awb") / 1000

			if var_46_53 > 0 and var_46_52 < var_46_53 and var_46_53 + var_46_51 > arg_43_1.duration_ then
				local var_46_54 = var_46_53

				arg_43_1.duration_ = var_46_53 + var_46_51
			end

			if var_46_51 < arg_43_1.time_ and arg_43_1.time_ <= var_46_51 + arg_46_0 then
				local var_46_55 = "play"
				local var_46_56 = "voice"

				arg_43_1:AudioAction(var_46_55, var_46_56, "story_v_out_319891", "319891010", "story_v_out_319891.awb")
			end

			local var_46_57 = 0

			if var_46_57 < arg_43_1.time_ and arg_43_1.time_ <= var_46_57 + arg_46_0 then
				arg_43_1.cswbg_:SetActive(true)

				local var_46_58 = arg_43_1.cswt_:GetComponent("RectTransform")

				arg_43_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_46_58.offsetMin = Vector2.New(410, 330)
				var_46_58.offsetMax = Vector2.New(-400, -180)

				local var_46_59 = arg_43_1:GetWordFromCfg(419066)
				local var_46_60 = arg_43_1:FormatText(var_46_59.content)

				arg_43_1.cswt_.text = var_46_60

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.cswt_)

				arg_43_1.cswt_.fontSize = 177
				arg_43_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_43_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_43_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play319891011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319891011
		arg_47_1.duration_ = 5.45

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play319891012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				local var_50_1 = manager.ui.mainCamera.transform.localPosition
				local var_50_2 = Vector3.New(0, 0, 10) + Vector3.New(var_50_1.x, var_50_1.y, 0)
				local var_50_3 = arg_47_1.bgs_.ST15a

				var_50_3.transform.localPosition = var_50_2
				var_50_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_4 = var_50_3:GetComponent("SpriteRenderer")

				if var_50_4 and var_50_4.sprite then
					local var_50_5 = (var_50_3.transform.localPosition - var_50_1).z
					local var_50_6 = manager.ui.mainCameraCom_
					local var_50_7 = 2 * var_50_5 * Mathf.Tan(var_50_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_50_8 = var_50_7 * var_50_6.aspect
					local var_50_9 = var_50_4.sprite.bounds.size.x
					local var_50_10 = var_50_4.sprite.bounds.size.y
					local var_50_11 = var_50_8 / var_50_9
					local var_50_12 = var_50_7 / var_50_10
					local var_50_13 = var_50_12 < var_50_11 and var_50_11 or var_50_12

					var_50_3.transform.localScale = Vector3.New(var_50_13, var_50_13, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "ST15a" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_14 = 0

			if var_50_14 < arg_47_1.time_ and arg_47_1.time_ <= var_50_14 + arg_50_0 then
				arg_47_1.fswbg_:SetActive(false)
				arg_47_1.dialog_:SetActive(false)
				SetActive(arg_47_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_47_1:ShowNextGo(false)
			end

			local var_50_15 = 0.1

			if var_50_15 < arg_47_1.time_ and arg_47_1.time_ <= var_50_15 + arg_50_0 then
				arg_47_1.fswbg_:SetActive(false)
				arg_47_1.dialog_:SetActive(false)
				SetActive(arg_47_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_47_1:ShowNextGo(false)
			end

			local var_50_16 = 0

			if var_50_16 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 then
				arg_47_1.cswbg_:SetActive(false)
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_17 = 0.449999999999
			local var_50_18 = 0.55

			if var_50_17 < arg_47_1.time_ and arg_47_1.time_ <= var_50_17 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_19 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_19:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_20 = arg_47_1:GetWordFromCfg(319891011)
				local var_50_21 = arg_47_1:FormatText(var_50_20.content)

				arg_47_1.text_.text = var_50_21

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_22 = 22
				local var_50_23 = utf8.len(var_50_21)
				local var_50_24 = var_50_22 <= 0 and var_50_18 or var_50_18 * (var_50_23 / var_50_22)

				if var_50_24 > 0 and var_50_18 < var_50_24 then
					arg_47_1.talkMaxDuration = var_50_24
					var_50_17 = var_50_17 + 0.3

					if var_50_24 + var_50_17 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_24 + var_50_17
					end
				end

				arg_47_1.text_.text = var_50_21
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_25 = var_50_17 + 0.3
			local var_50_26 = math.max(var_50_18, arg_47_1.talkMaxDuration)

			if var_50_25 <= arg_47_1.time_ and arg_47_1.time_ < var_50_25 + var_50_26 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_25) / var_50_26

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_25 + var_50_26 and arg_47_1.time_ < var_50_25 + var_50_26 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play319891012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319891012
		arg_53_1.duration_ = 5.33

		local var_53_0 = {
			zh = 3.633,
			ja = 5.333
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
				arg_53_0:Play319891013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = "1029ui_story"

			if arg_53_1.actors_[var_56_0] == nil then
				local var_56_1 = Asset.Load("Char/" .. "1029ui_story")

				if not isNil(var_56_1) then
					local var_56_2 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_53_1.stage_.transform)

					var_56_2.name = var_56_0
					var_56_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_53_1.actors_[var_56_0] = var_56_2

					local var_56_3 = var_56_2:GetComponentInChildren(typeof(CharacterEffect))

					var_56_3.enabled = true

					local var_56_4 = GameObjectTools.GetOrAddComponent(var_56_2, typeof(DynamicBoneHelper))

					if var_56_4 then
						var_56_4:EnableDynamicBone(false)
					end

					arg_53_1:ShowWeapon(var_56_3.transform, false)

					arg_53_1.var_[var_56_0 .. "Animator"] = var_56_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_53_1.var_[var_56_0 .. "Animator"].applyRootMotion = true
					arg_53_1.var_[var_56_0 .. "LipSync"] = var_56_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_56_5 = arg_53_1.actors_["1029ui_story"].transform
			local var_56_6 = 0

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.var_.moveOldPos1029ui_story = var_56_5.localPosition

				local var_56_7 = "1029ui_story"

				arg_53_1:ShowWeapon(arg_53_1.var_[var_56_7 .. "Animator"].transform, false)
			end

			local var_56_8 = 0.001

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_8 then
				local var_56_9 = (arg_53_1.time_ - var_56_6) / var_56_8
				local var_56_10 = Vector3.New(0.7, -1.09, -6.2)

				var_56_5.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1029ui_story, var_56_10, var_56_9)

				local var_56_11 = manager.ui.mainCamera.transform.position - var_56_5.position

				var_56_5.forward = Vector3.New(var_56_11.x, var_56_11.y, var_56_11.z)

				local var_56_12 = var_56_5.localEulerAngles

				var_56_12.z = 0
				var_56_12.x = 0
				var_56_5.localEulerAngles = var_56_12
			end

			if arg_53_1.time_ >= var_56_6 + var_56_8 and arg_53_1.time_ < var_56_6 + var_56_8 + arg_56_0 then
				var_56_5.localPosition = Vector3.New(0.7, -1.09, -6.2)

				local var_56_13 = manager.ui.mainCamera.transform.position - var_56_5.position

				var_56_5.forward = Vector3.New(var_56_13.x, var_56_13.y, var_56_13.z)

				local var_56_14 = var_56_5.localEulerAngles

				var_56_14.z = 0
				var_56_14.x = 0
				var_56_5.localEulerAngles = var_56_14
			end

			local var_56_15 = arg_53_1.actors_["1029ui_story"]
			local var_56_16 = 0

			if var_56_16 < arg_53_1.time_ and arg_53_1.time_ <= var_56_16 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.characterEffect1029ui_story == nil then
				arg_53_1.var_.characterEffect1029ui_story = var_56_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_17 = 0.200000002980232

			if var_56_16 <= arg_53_1.time_ and arg_53_1.time_ < var_56_16 + var_56_17 and not isNil(var_56_15) then
				local var_56_18 = (arg_53_1.time_ - var_56_16) / var_56_17

				if arg_53_1.var_.characterEffect1029ui_story and not isNil(var_56_15) then
					arg_53_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_16 + var_56_17 and arg_53_1.time_ < var_56_16 + var_56_17 + arg_56_0 and not isNil(var_56_15) and arg_53_1.var_.characterEffect1029ui_story then
				arg_53_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_56_19 = 0

			if var_56_19 < arg_53_1.time_ and arg_53_1.time_ <= var_56_19 + arg_56_0 then
				arg_53_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			local var_56_20 = 0

			if var_56_20 < arg_53_1.time_ and arg_53_1.time_ <= var_56_20 + arg_56_0 then
				arg_53_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_56_21 = 0
			local var_56_22 = 0.475

			if var_56_21 < arg_53_1.time_ and arg_53_1.time_ <= var_56_21 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_23 = arg_53_1:FormatText(StoryNameCfg[319].name)

				arg_53_1.leftNameTxt_.text = var_56_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_24 = arg_53_1:GetWordFromCfg(319891012)
				local var_56_25 = arg_53_1:FormatText(var_56_24.content)

				arg_53_1.text_.text = var_56_25

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_26 = 19
				local var_56_27 = utf8.len(var_56_25)
				local var_56_28 = var_56_26 <= 0 and var_56_22 or var_56_22 * (var_56_27 / var_56_26)

				if var_56_28 > 0 and var_56_22 < var_56_28 then
					arg_53_1.talkMaxDuration = var_56_28

					if var_56_28 + var_56_21 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_28 + var_56_21
					end
				end

				arg_53_1.text_.text = var_56_25
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891012", "story_v_out_319891.awb") ~= 0 then
					local var_56_29 = manager.audio:GetVoiceLength("story_v_out_319891", "319891012", "story_v_out_319891.awb") / 1000

					if var_56_29 + var_56_21 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_29 + var_56_21
					end

					if var_56_24.prefab_name ~= "" and arg_53_1.actors_[var_56_24.prefab_name] ~= nil then
						local var_56_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_24.prefab_name].transform, "story_v_out_319891", "319891012", "story_v_out_319891.awb")

						arg_53_1:RecordAudio("319891012", var_56_30)
						arg_53_1:RecordAudio("319891012", var_56_30)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319891", "319891012", "story_v_out_319891.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319891", "319891012", "story_v_out_319891.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_31 = math.max(var_56_22, arg_53_1.talkMaxDuration)

			if var_56_21 <= arg_53_1.time_ and arg_53_1.time_ < var_56_21 + var_56_31 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_21) / var_56_31

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_21 + var_56_31 and arg_53_1.time_ < var_56_21 + var_56_31 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play319891013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319891013
		arg_57_1.duration_ = 8.5

		local var_57_0 = {
			zh = 5.36666666666667,
			ja = 8.49966666666667
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
				arg_57_0:Play319891014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1084ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1084ui_story = var_60_0.localPosition

				local var_60_2 = "1084ui_story"

				arg_57_1:ShowWeapon(arg_57_1.var_[var_60_2 .. "Animator"].transform, false)
			end

			local var_60_3 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_3 then
				local var_60_4 = (arg_57_1.time_ - var_60_1) / var_60_3
				local var_60_5 = Vector3.New(-0.7, -0.97, -6)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1084ui_story, var_60_5, var_60_4)

				local var_60_6 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_6.x, var_60_6.y, var_60_6.z)

				local var_60_7 = var_60_0.localEulerAngles

				var_60_7.z = 0
				var_60_7.x = 0
				var_60_0.localEulerAngles = var_60_7
			end

			if arg_57_1.time_ >= var_60_1 + var_60_3 and arg_57_1.time_ < var_60_1 + var_60_3 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_60_8 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_8.x, var_60_8.y, var_60_8.z)

				local var_60_9 = var_60_0.localEulerAngles

				var_60_9.z = 0
				var_60_9.x = 0
				var_60_0.localEulerAngles = var_60_9
			end

			local var_60_10 = arg_57_1.actors_["1084ui_story"]
			local var_60_11 = 0

			if var_60_11 < arg_57_1.time_ and arg_57_1.time_ <= var_60_11 + arg_60_0 and not isNil(var_60_10) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = var_60_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_12 = 0.200000002980232

			if var_60_11 <= arg_57_1.time_ and arg_57_1.time_ < var_60_11 + var_60_12 and not isNil(var_60_10) then
				local var_60_13 = (arg_57_1.time_ - var_60_11) / var_60_12

				if arg_57_1.var_.characterEffect1084ui_story and not isNil(var_60_10) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_11 + var_60_12 and arg_57_1.time_ < var_60_11 + var_60_12 + arg_60_0 and not isNil(var_60_10) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_60_15 = arg_57_1.actors_["1029ui_story"]
			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 and not isNil(var_60_15) and arg_57_1.var_.characterEffect1029ui_story == nil then
				arg_57_1.var_.characterEffect1029ui_story = var_60_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_17 = 0.200000002980232

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_17 and not isNil(var_60_15) then
				local var_60_18 = (arg_57_1.time_ - var_60_16) / var_60_17

				if arg_57_1.var_.characterEffect1029ui_story and not isNil(var_60_15) then
					local var_60_19 = Mathf.Lerp(0, 0.5, var_60_18)

					arg_57_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1029ui_story.fillRatio = var_60_19
				end
			end

			if arg_57_1.time_ >= var_60_16 + var_60_17 and arg_57_1.time_ < var_60_16 + var_60_17 + arg_60_0 and not isNil(var_60_15) and arg_57_1.var_.characterEffect1029ui_story then
				local var_60_20 = 0.5

				arg_57_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1029ui_story.fillRatio = var_60_20
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_21 = 0.666666666666667
			local var_60_22 = 0.625

			if var_60_21 < arg_57_1.time_ and arg_57_1.time_ <= var_60_21 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_23 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_23:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_24 = arg_57_1:FormatText(StoryNameCfg[6].name)

				arg_57_1.leftNameTxt_.text = var_60_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_25 = arg_57_1:GetWordFromCfg(319891013)
				local var_60_26 = arg_57_1:FormatText(var_60_25.content)

				arg_57_1.text_.text = var_60_26

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_27 = 25
				local var_60_28 = utf8.len(var_60_26)
				local var_60_29 = var_60_27 <= 0 and var_60_22 or var_60_22 * (var_60_28 / var_60_27)

				if var_60_29 > 0 and var_60_22 < var_60_29 then
					arg_57_1.talkMaxDuration = var_60_29
					var_60_21 = var_60_21 + 0.3

					if var_60_29 + var_60_21 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_29 + var_60_21
					end
				end

				arg_57_1.text_.text = var_60_26
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891013", "story_v_out_319891.awb") ~= 0 then
					local var_60_30 = manager.audio:GetVoiceLength("story_v_out_319891", "319891013", "story_v_out_319891.awb") / 1000

					if var_60_30 + var_60_21 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_30 + var_60_21
					end

					if var_60_25.prefab_name ~= "" and arg_57_1.actors_[var_60_25.prefab_name] ~= nil then
						local var_60_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_25.prefab_name].transform, "story_v_out_319891", "319891013", "story_v_out_319891.awb")

						arg_57_1:RecordAudio("319891013", var_60_31)
						arg_57_1:RecordAudio("319891013", var_60_31)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319891", "319891013", "story_v_out_319891.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319891", "319891013", "story_v_out_319891.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_32 = var_60_21 + 0.3
			local var_60_33 = math.max(var_60_22, arg_57_1.talkMaxDuration)

			if var_60_32 <= arg_57_1.time_ and arg_57_1.time_ < var_60_32 + var_60_33 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_32) / var_60_33

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_32 + var_60_33 and arg_57_1.time_ < var_60_32 + var_60_33 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play319891014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319891014
		arg_63_1.duration_ = 2.5

		local var_63_0 = {
			zh = 1.766,
			ja = 2.5
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play319891015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1029ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1029ui_story == nil then
				arg_63_1.var_.characterEffect1029ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1029ui_story and not isNil(var_66_0) then
					arg_63_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1029ui_story then
				arg_63_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_66_4 = arg_63_1.actors_["1084ui_story"]
			local var_66_5 = 0

			if var_66_5 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1084ui_story == nil then
				arg_63_1.var_.characterEffect1084ui_story = var_66_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_6 = 0.200000002980232

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_6 and not isNil(var_66_4) then
				local var_66_7 = (arg_63_1.time_ - var_66_5) / var_66_6

				if arg_63_1.var_.characterEffect1084ui_story and not isNil(var_66_4) then
					local var_66_8 = Mathf.Lerp(0, 0.5, var_66_7)

					arg_63_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1084ui_story.fillRatio = var_66_8
				end
			end

			if arg_63_1.time_ >= var_66_5 + var_66_6 and arg_63_1.time_ < var_66_5 + var_66_6 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1084ui_story then
				local var_66_9 = 0.5

				arg_63_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1084ui_story.fillRatio = var_66_9
			end

			local var_66_10 = 0
			local var_66_11 = 0.225

			if var_66_10 < arg_63_1.time_ and arg_63_1.time_ <= var_66_10 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_12 = arg_63_1:FormatText(StoryNameCfg[319].name)

				arg_63_1.leftNameTxt_.text = var_66_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_13 = arg_63_1:GetWordFromCfg(319891014)
				local var_66_14 = arg_63_1:FormatText(var_66_13.content)

				arg_63_1.text_.text = var_66_14

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_15 = 9
				local var_66_16 = utf8.len(var_66_14)
				local var_66_17 = var_66_15 <= 0 and var_66_11 or var_66_11 * (var_66_16 / var_66_15)

				if var_66_17 > 0 and var_66_11 < var_66_17 then
					arg_63_1.talkMaxDuration = var_66_17

					if var_66_17 + var_66_10 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_17 + var_66_10
					end
				end

				arg_63_1.text_.text = var_66_14
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891014", "story_v_out_319891.awb") ~= 0 then
					local var_66_18 = manager.audio:GetVoiceLength("story_v_out_319891", "319891014", "story_v_out_319891.awb") / 1000

					if var_66_18 + var_66_10 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_18 + var_66_10
					end

					if var_66_13.prefab_name ~= "" and arg_63_1.actors_[var_66_13.prefab_name] ~= nil then
						local var_66_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_13.prefab_name].transform, "story_v_out_319891", "319891014", "story_v_out_319891.awb")

						arg_63_1:RecordAudio("319891014", var_66_19)
						arg_63_1:RecordAudio("319891014", var_66_19)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_319891", "319891014", "story_v_out_319891.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_319891", "319891014", "story_v_out_319891.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_20 = math.max(var_66_11, arg_63_1.talkMaxDuration)

			if var_66_10 <= arg_63_1.time_ and arg_63_1.time_ < var_66_10 + var_66_20 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_10) / var_66_20

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_10 + var_66_20 and arg_63_1.time_ < var_66_10 + var_66_20 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play319891015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319891015
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play319891016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1029ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1029ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, 100, 0)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1029ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, 100, 0)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = arg_67_1.actors_["1029ui_story"]
			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1029ui_story == nil then
				arg_67_1.var_.characterEffect1029ui_story = var_70_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_11 = 0.200000002980232

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_11 and not isNil(var_70_9) then
				local var_70_12 = (arg_67_1.time_ - var_70_10) / var_70_11

				if arg_67_1.var_.characterEffect1029ui_story and not isNil(var_70_9) then
					local var_70_13 = Mathf.Lerp(0, 0.5, var_70_12)

					arg_67_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1029ui_story.fillRatio = var_70_13
				end
			end

			if arg_67_1.time_ >= var_70_10 + var_70_11 and arg_67_1.time_ < var_70_10 + var_70_11 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1029ui_story then
				local var_70_14 = 0.5

				arg_67_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1029ui_story.fillRatio = var_70_14
			end

			local var_70_15 = arg_67_1.actors_["1084ui_story"].transform
			local var_70_16 = 0

			if var_70_16 < arg_67_1.time_ and arg_67_1.time_ <= var_70_16 + arg_70_0 then
				arg_67_1.var_.moveOldPos1084ui_story = var_70_15.localPosition
			end

			local var_70_17 = 0.001

			if var_70_16 <= arg_67_1.time_ and arg_67_1.time_ < var_70_16 + var_70_17 then
				local var_70_18 = (arg_67_1.time_ - var_70_16) / var_70_17
				local var_70_19 = Vector3.New(0, 100, 0)

				var_70_15.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1084ui_story, var_70_19, var_70_18)

				local var_70_20 = manager.ui.mainCamera.transform.position - var_70_15.position

				var_70_15.forward = Vector3.New(var_70_20.x, var_70_20.y, var_70_20.z)

				local var_70_21 = var_70_15.localEulerAngles

				var_70_21.z = 0
				var_70_21.x = 0
				var_70_15.localEulerAngles = var_70_21
			end

			if arg_67_1.time_ >= var_70_16 + var_70_17 and arg_67_1.time_ < var_70_16 + var_70_17 + arg_70_0 then
				var_70_15.localPosition = Vector3.New(0, 100, 0)

				local var_70_22 = manager.ui.mainCamera.transform.position - var_70_15.position

				var_70_15.forward = Vector3.New(var_70_22.x, var_70_22.y, var_70_22.z)

				local var_70_23 = var_70_15.localEulerAngles

				var_70_23.z = 0
				var_70_23.x = 0
				var_70_15.localEulerAngles = var_70_23
			end

			local var_70_24 = arg_67_1.actors_["1084ui_story"]
			local var_70_25 = 0

			if var_70_25 < arg_67_1.time_ and arg_67_1.time_ <= var_70_25 + arg_70_0 and not isNil(var_70_24) and arg_67_1.var_.characterEffect1084ui_story == nil then
				arg_67_1.var_.characterEffect1084ui_story = var_70_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_26 = 0.200000002980232

			if var_70_25 <= arg_67_1.time_ and arg_67_1.time_ < var_70_25 + var_70_26 and not isNil(var_70_24) then
				local var_70_27 = (arg_67_1.time_ - var_70_25) / var_70_26

				if arg_67_1.var_.characterEffect1084ui_story and not isNil(var_70_24) then
					local var_70_28 = Mathf.Lerp(0, 0.5, var_70_27)

					arg_67_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1084ui_story.fillRatio = var_70_28
				end
			end

			if arg_67_1.time_ >= var_70_25 + var_70_26 and arg_67_1.time_ < var_70_25 + var_70_26 + arg_70_0 and not isNil(var_70_24) and arg_67_1.var_.characterEffect1084ui_story then
				local var_70_29 = 0.5

				arg_67_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1084ui_story.fillRatio = var_70_29
			end

			local var_70_30 = 0
			local var_70_31 = 1.175

			if var_70_30 < arg_67_1.time_ and arg_67_1.time_ <= var_70_30 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_32 = arg_67_1:GetWordFromCfg(319891015)
				local var_70_33 = arg_67_1:FormatText(var_70_32.content)

				arg_67_1.text_.text = var_70_33

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_34 = 47
				local var_70_35 = utf8.len(var_70_33)
				local var_70_36 = var_70_34 <= 0 and var_70_31 or var_70_31 * (var_70_35 / var_70_34)

				if var_70_36 > 0 and var_70_31 < var_70_36 then
					arg_67_1.talkMaxDuration = var_70_36

					if var_70_36 + var_70_30 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_36 + var_70_30
					end
				end

				arg_67_1.text_.text = var_70_33
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_37 = math.max(var_70_31, arg_67_1.talkMaxDuration)

			if var_70_30 <= arg_67_1.time_ and arg_67_1.time_ < var_70_30 + var_70_37 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_30) / var_70_37

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_30 + var_70_37 and arg_67_1.time_ < var_70_30 + var_70_37 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play319891016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319891016
		arg_71_1.duration_ = 3.53

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play319891017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1084ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1084ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, 100, 0)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1084ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, 100, 0)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = 0

			if var_74_9 < arg_71_1.time_ and arg_71_1.time_ <= var_74_9 + arg_74_0 then
				local var_74_10 = arg_71_1.fswbg_.transform:Find("textbox/adapt/content") or arg_71_1.fswbg_.transform:Find("textbox/content")
				local var_74_11 = arg_71_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_74_12 = var_74_10:GetComponent("Text")
				local var_74_13 = var_74_10:GetComponent("RectTransform")

				var_74_12.alignment = UnityEngine.TextAnchor.LowerCenter
				var_74_13.offsetMin = Vector2.New(0, 0)
				var_74_13.offsetMax = Vector2.New(0, 0)
			end

			local var_74_14 = 0

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1.fswbg_:SetActive(true)
				arg_71_1.dialog_:SetActive(false)

				arg_71_1.fswtw_.percent = 0

				local var_74_15 = arg_71_1:GetWordFromCfg(319891016)
				local var_74_16 = arg_71_1:FormatText(var_74_15.content)

				arg_71_1.fswt_.text = var_74_16

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.fswt_)

				arg_71_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_71_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_71_1.fswtw_:SetDirty()

				arg_71_1.typewritterCharCountI18N = 0

				SetActive(arg_71_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_71_1:ShowNextGo(false)
			end

			local var_74_17 = 1.3

			if var_74_17 < arg_71_1.time_ and arg_71_1.time_ <= var_74_17 + arg_74_0 then
				arg_71_1.var_.oldValueTypewriter = arg_71_1.fswtw_.percent

				SetActive(arg_71_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_71_1:ShowNextGo(false)
			end

			local var_74_18 = 9
			local var_74_19 = 0.6
			local var_74_20 = arg_71_1:GetWordFromCfg(319891016)
			local var_74_21 = arg_71_1:FormatText(var_74_20.content)
			local var_74_22, var_74_23 = arg_71_1:GetPercentByPara(var_74_21, 1)

			if var_74_17 < arg_71_1.time_ and arg_71_1.time_ <= var_74_17 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				local var_74_24 = var_74_18 <= 0 and var_74_19 or var_74_19 * ((var_74_23 - arg_71_1.typewritterCharCountI18N) / var_74_18)

				if var_74_24 > 0 and var_74_19 < var_74_24 then
					arg_71_1.talkMaxDuration = var_74_24

					if var_74_24 + var_74_17 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_24 + var_74_17
					end
				end
			end

			local var_74_25 = 0.6
			local var_74_26 = math.max(var_74_25, arg_71_1.talkMaxDuration)

			if var_74_17 <= arg_71_1.time_ and arg_71_1.time_ < var_74_17 + var_74_26 then
				local var_74_27 = (arg_71_1.time_ - var_74_17) / var_74_26

				arg_71_1.fswtw_.percent = Mathf.Lerp(arg_71_1.var_.oldValueTypewriter, var_74_22, var_74_27)
				arg_71_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_71_1.fswtw_:SetDirty()
			end

			if arg_71_1.time_ >= var_74_17 + var_74_26 and arg_71_1.time_ < var_74_17 + var_74_26 + arg_74_0 then
				arg_71_1.fswtw_.percent = var_74_22

				arg_71_1.fswtw_:SetDirty()
				arg_71_1:ShowNextGo(true)

				arg_71_1.typewritterCharCountI18N = var_74_23
			end

			local var_74_28 = 0

			if var_74_28 < arg_71_1.time_ and arg_71_1.time_ <= var_74_28 + arg_74_0 then
				local var_74_29 = manager.ui.mainCamera.transform.localPosition
				local var_74_30 = Vector3.New(0, 0, 10) + Vector3.New(var_74_29.x, var_74_29.y, 0)
				local var_74_31 = arg_71_1.bgs_.STblack

				var_74_31.transform.localPosition = var_74_30
				var_74_31.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_32 = var_74_31:GetComponent("SpriteRenderer")

				if var_74_32 and var_74_32.sprite then
					local var_74_33 = (var_74_31.transform.localPosition - var_74_29).z
					local var_74_34 = manager.ui.mainCameraCom_
					local var_74_35 = 2 * var_74_33 * Mathf.Tan(var_74_34.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_74_36 = var_74_35 * var_74_34.aspect
					local var_74_37 = var_74_32.sprite.bounds.size.x
					local var_74_38 = var_74_32.sprite.bounds.size.y
					local var_74_39 = var_74_36 / var_74_37
					local var_74_40 = var_74_35 / var_74_38
					local var_74_41 = var_74_40 < var_74_39 and var_74_39 or var_74_40

					var_74_31.transform.localScale = Vector3.New(var_74_41, var_74_41, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "STblack" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_42 = 1.3
			local var_74_43 = 2.233
			local var_74_44 = manager.audio:GetVoiceLength("story_v_out_319891", "319891016", "story_v_out_319891.awb") / 1000

			if var_74_44 > 0 and var_74_43 < var_74_44 and var_74_44 + var_74_42 > arg_71_1.duration_ then
				local var_74_45 = var_74_44

				arg_71_1.duration_ = var_74_44 + var_74_42
			end

			if var_74_42 < arg_71_1.time_ and arg_71_1.time_ <= var_74_42 + arg_74_0 then
				local var_74_46 = "play"
				local var_74_47 = "voice"

				arg_71_1:AudioAction(var_74_46, var_74_47, "story_v_out_319891", "319891016", "story_v_out_319891.awb")
			end

			local var_74_48 = 0

			if var_74_48 < arg_71_1.time_ and arg_71_1.time_ <= var_74_48 + arg_74_0 then
				arg_71_1.cswbg_:SetActive(true)

				local var_74_49 = arg_71_1.cswt_:GetComponent("RectTransform")

				arg_71_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_74_49.offsetMin = Vector2.New(410, 330)
				var_74_49.offsetMax = Vector2.New(-400, -180)

				local var_74_50 = arg_71_1:GetWordFromCfg(419067)
				local var_74_51 = arg_71_1:FormatText(var_74_50.content)

				arg_71_1.cswt_.text = var_74_51

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.cswt_)

				arg_71_1.cswt_.fontSize = 175
				arg_71_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_71_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_71_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play319891017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319891017
		arg_75_1.duration_ = 3.8

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play319891018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = "10050ui_story"

			if arg_75_1.actors_[var_78_0] == nil then
				local var_78_1 = Asset.Load("Char/" .. "10050ui_story")

				if not isNil(var_78_1) then
					local var_78_2 = Object.Instantiate(Asset.Load("Char/" .. "10050ui_story"), arg_75_1.stage_.transform)

					var_78_2.name = var_78_0
					var_78_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_75_1.actors_[var_78_0] = var_78_2

					local var_78_3 = var_78_2:GetComponentInChildren(typeof(CharacterEffect))

					var_78_3.enabled = true

					local var_78_4 = GameObjectTools.GetOrAddComponent(var_78_2, typeof(DynamicBoneHelper))

					if var_78_4 then
						var_78_4:EnableDynamicBone(false)
					end

					arg_75_1:ShowWeapon(var_78_3.transform, false)

					arg_75_1.var_[var_78_0 .. "Animator"] = var_78_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_75_1.var_[var_78_0 .. "Animator"].applyRootMotion = true
					arg_75_1.var_[var_78_0 .. "LipSync"] = var_78_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_78_5 = arg_75_1.actors_["10050ui_story"]
			local var_78_6 = 0

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect10050ui_story == nil then
				arg_75_1.var_.characterEffect10050ui_story = var_78_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_7 = 0.200000002980232

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_7 and not isNil(var_78_5) then
				local var_78_8 = (arg_75_1.time_ - var_78_6) / var_78_7

				if arg_75_1.var_.characterEffect10050ui_story and not isNil(var_78_5) then
					local var_78_9 = Mathf.Lerp(0, 0.5, var_78_8)

					arg_75_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10050ui_story.fillRatio = var_78_9
				end
			end

			if arg_75_1.time_ >= var_78_6 + var_78_7 and arg_75_1.time_ < var_78_6 + var_78_7 + arg_78_0 and not isNil(var_78_5) and arg_75_1.var_.characterEffect10050ui_story then
				local var_78_10 = 0.5

				arg_75_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10050ui_story.fillRatio = var_78_10
			end

			local var_78_11 = 0

			if var_78_11 < arg_75_1.time_ and arg_75_1.time_ <= var_78_11 + arg_78_0 then
				arg_75_1.fswbg_:SetActive(true)
				arg_75_1.dialog_:SetActive(false)

				arg_75_1.fswtw_.percent = 0

				local var_78_12 = arg_75_1:GetWordFromCfg(319891017)
				local var_78_13 = arg_75_1:FormatText(var_78_12.content)

				arg_75_1.fswt_.text = var_78_13

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.fswt_)

				arg_75_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_75_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_75_1.fswtw_:SetDirty()

				arg_75_1.typewritterCharCountI18N = 0

				SetActive(arg_75_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_75_1:ShowNextGo(false)
			end

			local var_78_14 = 0.200000002980232

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 then
				arg_75_1.var_.oldValueTypewriter = arg_75_1.fswtw_.percent

				SetActive(arg_75_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_75_1:ShowNextGo(false)
			end

			local var_78_15 = 16
			local var_78_16 = 1.06666666666667
			local var_78_17 = arg_75_1:GetWordFromCfg(319891017)
			local var_78_18 = arg_75_1:FormatText(var_78_17.content)
			local var_78_19, var_78_20 = arg_75_1:GetPercentByPara(var_78_18, 1)

			if var_78_14 < arg_75_1.time_ and arg_75_1.time_ <= var_78_14 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				local var_78_21 = var_78_15 <= 0 and var_78_16 or var_78_16 * ((var_78_20 - arg_75_1.typewritterCharCountI18N) / var_78_15)

				if var_78_21 > 0 and var_78_16 < var_78_21 then
					arg_75_1.talkMaxDuration = var_78_21

					if var_78_21 + var_78_14 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_21 + var_78_14
					end
				end
			end

			local var_78_22 = 1.06666666666667
			local var_78_23 = math.max(var_78_22, arg_75_1.talkMaxDuration)

			if var_78_14 <= arg_75_1.time_ and arg_75_1.time_ < var_78_14 + var_78_23 then
				local var_78_24 = (arg_75_1.time_ - var_78_14) / var_78_23

				arg_75_1.fswtw_.percent = Mathf.Lerp(arg_75_1.var_.oldValueTypewriter, var_78_19, var_78_24)
				arg_75_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_75_1.fswtw_:SetDirty()
			end

			if arg_75_1.time_ >= var_78_14 + var_78_23 and arg_75_1.time_ < var_78_14 + var_78_23 + arg_78_0 then
				arg_75_1.fswtw_.percent = var_78_19

				arg_75_1.fswtw_:SetDirty()
				arg_75_1:ShowNextGo(true)

				arg_75_1.typewritterCharCountI18N = var_78_20
			end

			local var_78_25 = 0.200000002980232
			local var_78_26 = 3.6
			local var_78_27 = manager.audio:GetVoiceLength("story_v_out_319891", "319891017", "story_v_out_319891.awb") / 1000

			if var_78_27 > 0 and var_78_26 < var_78_27 and var_78_27 + var_78_25 > arg_75_1.duration_ then
				local var_78_28 = var_78_27

				arg_75_1.duration_ = var_78_27 + var_78_25
			end

			if var_78_25 < arg_75_1.time_ and arg_75_1.time_ <= var_78_25 + arg_78_0 then
				local var_78_29 = "play"
				local var_78_30 = "voice"

				arg_75_1:AudioAction(var_78_29, var_78_30, "story_v_out_319891", "319891017", "story_v_out_319891.awb")
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play319891018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319891018
		arg_79_1.duration_ = 14.27

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play319891019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.fswbg_:SetActive(true)
				arg_79_1.dialog_:SetActive(false)

				arg_79_1.fswtw_.percent = 0

				local var_82_1 = arg_79_1:GetWordFromCfg(319891018)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.fswt_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.fswt_)

				arg_79_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_79_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_79_1.fswtw_:SetDirty()

				arg_79_1.typewritterCharCountI18N = 0

				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_79_1:ShowNextGo(false)
			end

			local var_82_3 = 0.7

			if var_82_3 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 then
				arg_79_1.var_.oldValueTypewriter = arg_79_1.fswtw_.percent

				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_79_1:ShowNextGo(false)
			end

			local var_82_4 = 48
			local var_82_5 = 3.2
			local var_82_6 = arg_79_1:GetWordFromCfg(319891018)
			local var_82_7 = arg_79_1:FormatText(var_82_6.content)
			local var_82_8, var_82_9 = arg_79_1:GetPercentByPara(var_82_7, 1)

			if var_82_3 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				local var_82_10 = var_82_4 <= 0 and var_82_5 or var_82_5 * ((var_82_9 - arg_79_1.typewritterCharCountI18N) / var_82_4)

				if var_82_10 > 0 and var_82_5 < var_82_10 then
					arg_79_1.talkMaxDuration = var_82_10

					if var_82_10 + var_82_3 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_3
					end
				end
			end

			local var_82_11 = 3.2
			local var_82_12 = math.max(var_82_11, arg_79_1.talkMaxDuration)

			if var_82_3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_3 + var_82_12 then
				local var_82_13 = (arg_79_1.time_ - var_82_3) / var_82_12

				arg_79_1.fswtw_.percent = Mathf.Lerp(arg_79_1.var_.oldValueTypewriter, var_82_8, var_82_13)
				arg_79_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_79_1.fswtw_:SetDirty()
			end

			if arg_79_1.time_ >= var_82_3 + var_82_12 and arg_79_1.time_ < var_82_3 + var_82_12 + arg_82_0 then
				arg_79_1.fswtw_.percent = var_82_8

				arg_79_1.fswtw_:SetDirty()
				arg_79_1:ShowNextGo(true)

				arg_79_1.typewritterCharCountI18N = var_82_9
			end

			local var_82_14 = 0.7
			local var_82_15 = 13.566
			local var_82_16 = manager.audio:GetVoiceLength("story_v_out_319891", "319891018", "story_v_out_319891.awb") / 1000

			if var_82_16 > 0 and var_82_15 < var_82_16 and var_82_16 + var_82_14 > arg_79_1.duration_ then
				local var_82_17 = var_82_16

				arg_79_1.duration_ = var_82_16 + var_82_14
			end

			if var_82_14 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				local var_82_18 = "play"
				local var_82_19 = "voice"

				arg_79_1:AudioAction(var_82_18, var_82_19, "story_v_out_319891", "319891018", "story_v_out_319891.awb")
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play319891019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319891019
		arg_83_1.duration_ = 7.47

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play319891020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.fswbg_:SetActive(true)
				arg_83_1.dialog_:SetActive(false)

				arg_83_1.fswtw_.percent = 0

				local var_86_1 = arg_83_1:GetWordFromCfg(319891019)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.fswt_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.fswt_)

				arg_83_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_83_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_83_1.fswtw_:SetDirty()

				arg_83_1.typewritterCharCountI18N = 0

				SetActive(arg_83_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_83_1:ShowNextGo(false)
			end

			local var_86_3 = 0.200000002980232

			if var_86_3 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 then
				arg_83_1.var_.oldValueTypewriter = arg_83_1.fswtw_.percent

				SetActive(arg_83_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_83_1:ShowNextGo(false)
			end

			local var_86_4 = 31
			local var_86_5 = 2.06666666666667
			local var_86_6 = arg_83_1:GetWordFromCfg(319891019)
			local var_86_7 = arg_83_1:FormatText(var_86_6.content)
			local var_86_8, var_86_9 = arg_83_1:GetPercentByPara(var_86_7, 1)

			if var_86_3 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				local var_86_10 = var_86_4 <= 0 and var_86_5 or var_86_5 * ((var_86_9 - arg_83_1.typewritterCharCountI18N) / var_86_4)

				if var_86_10 > 0 and var_86_5 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_3 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_3
					end
				end
			end

			local var_86_11 = 2.06666666666667
			local var_86_12 = math.max(var_86_11, arg_83_1.talkMaxDuration)

			if var_86_3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_3 + var_86_12 then
				local var_86_13 = (arg_83_1.time_ - var_86_3) / var_86_12

				arg_83_1.fswtw_.percent = Mathf.Lerp(arg_83_1.var_.oldValueTypewriter, var_86_8, var_86_13)
				arg_83_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_83_1.fswtw_:SetDirty()
			end

			if arg_83_1.time_ >= var_86_3 + var_86_12 and arg_83_1.time_ < var_86_3 + var_86_12 + arg_86_0 then
				arg_83_1.fswtw_.percent = var_86_8

				arg_83_1.fswtw_:SetDirty()
				arg_83_1:ShowNextGo(true)

				arg_83_1.typewritterCharCountI18N = var_86_9
			end

			local var_86_14 = 0.200000002980232
			local var_86_15 = 7.266
			local var_86_16 = manager.audio:GetVoiceLength("story_v_out_319891", "319891019", "story_v_out_319891.awb") / 1000

			if var_86_16 > 0 and var_86_15 < var_86_16 and var_86_16 + var_86_14 > arg_83_1.duration_ then
				local var_86_17 = var_86_16

				arg_83_1.duration_ = var_86_16 + var_86_14
			end

			if var_86_14 < arg_83_1.time_ and arg_83_1.time_ <= var_86_14 + arg_86_0 then
				local var_86_18 = "play"
				local var_86_19 = "voice"

				arg_83_1:AudioAction(var_86_18, var_86_19, "story_v_out_319891", "319891019", "story_v_out_319891.awb")
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play319891020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 319891020
		arg_87_1.duration_ = 4.27

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play319891021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.fswbg_:SetActive(true)
				arg_87_1.dialog_:SetActive(false)

				arg_87_1.fswtw_.percent = 0

				local var_90_1 = arg_87_1:GetWordFromCfg(319891020)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.fswt_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.fswt_)

				arg_87_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_87_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_87_1.fswtw_:SetDirty()

				arg_87_1.typewritterCharCountI18N = 0

				SetActive(arg_87_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_87_1:ShowNextGo(false)
			end

			local var_90_3 = 0.866666666666667

			if var_90_3 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.var_.oldValueTypewriter = arg_87_1.fswtw_.percent

				SetActive(arg_87_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_87_1:ShowNextGo(false)
			end

			local var_90_4 = 13
			local var_90_5 = 0.866666666666667
			local var_90_6 = arg_87_1:GetWordFromCfg(319891020)
			local var_90_7 = arg_87_1:FormatText(var_90_6.content)
			local var_90_8, var_90_9 = arg_87_1:GetPercentByPara(var_90_7, 1)

			if var_90_3 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				local var_90_10 = var_90_4 <= 0 and var_90_5 or var_90_5 * ((var_90_9 - arg_87_1.typewritterCharCountI18N) / var_90_4)

				if var_90_10 > 0 and var_90_5 < var_90_10 then
					arg_87_1.talkMaxDuration = var_90_10

					if var_90_10 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_3
					end
				end
			end

			local var_90_11 = 0.866666666666667
			local var_90_12 = math.max(var_90_11, arg_87_1.talkMaxDuration)

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_12 then
				local var_90_13 = (arg_87_1.time_ - var_90_3) / var_90_12

				arg_87_1.fswtw_.percent = Mathf.Lerp(arg_87_1.var_.oldValueTypewriter, var_90_8, var_90_13)
				arg_87_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_87_1.fswtw_:SetDirty()
			end

			if arg_87_1.time_ >= var_90_3 + var_90_12 and arg_87_1.time_ < var_90_3 + var_90_12 + arg_90_0 then
				arg_87_1.fswtw_.percent = var_90_8

				arg_87_1.fswtw_:SetDirty()
				arg_87_1:ShowNextGo(true)

				arg_87_1.typewritterCharCountI18N = var_90_9
			end

			local var_90_14 = 0.866666666666667
			local var_90_15 = 3.4
			local var_90_16 = manager.audio:GetVoiceLength("story_v_out_319891", "319891020", "story_v_out_319891.awb") / 1000

			if var_90_16 > 0 and var_90_15 < var_90_16 and var_90_16 + var_90_14 > arg_87_1.duration_ then
				local var_90_17 = var_90_16

				arg_87_1.duration_ = var_90_16 + var_90_14
			end

			if var_90_14 < arg_87_1.time_ and arg_87_1.time_ <= var_90_14 + arg_90_0 then
				local var_90_18 = "play"
				local var_90_19 = "voice"

				arg_87_1:AudioAction(var_90_18, var_90_19, "story_v_out_319891", "319891020", "story_v_out_319891.awb")
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play319891021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 319891021
		arg_91_1.duration_ = 7.13

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play319891022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				local var_94_1 = arg_91_1.fswbg_.transform:Find("textbox/adapt/content") or arg_91_1.fswbg_.transform:Find("textbox/content")
				local var_94_2 = arg_91_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_94_3 = var_94_1:GetComponent("Text")
				local var_94_4 = var_94_1:GetComponent("RectTransform")

				var_94_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_94_4.offsetMin = Vector2.New(0, 0)
				var_94_4.offsetMax = Vector2.New(0, 0)
			end

			local var_94_5 = 0

			if var_94_5 < arg_91_1.time_ and arg_91_1.time_ <= var_94_5 + arg_94_0 then
				arg_91_1.fswbg_:SetActive(true)
				arg_91_1.dialog_:SetActive(false)

				arg_91_1.fswtw_.percent = 0

				local var_94_6 = arg_91_1:GetWordFromCfg(319891021)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.fswt_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.fswt_)

				arg_91_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_91_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_91_1.fswtw_:SetDirty()

				arg_91_1.typewritterCharCountI18N = 0

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_8 = 1

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.var_.oldValueTypewriter = arg_91_1.fswtw_.percent

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_9 = 25
			local var_94_10 = 1.66666666666667
			local var_94_11 = arg_91_1:GetWordFromCfg(319891021)
			local var_94_12 = arg_91_1:FormatText(var_94_11.content)
			local var_94_13, var_94_14 = arg_91_1:GetPercentByPara(var_94_12, 1)

			if var_94_8 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				local var_94_15 = var_94_9 <= 0 and var_94_10 or var_94_10 * ((var_94_14 - arg_91_1.typewritterCharCountI18N) / var_94_9)

				if var_94_15 > 0 and var_94_10 < var_94_15 then
					arg_91_1.talkMaxDuration = var_94_15

					if var_94_15 + var_94_8 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_15 + var_94_8
					end
				end
			end

			local var_94_16 = 1.66666666666667
			local var_94_17 = math.max(var_94_16, arg_91_1.talkMaxDuration)

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_17 then
				local var_94_18 = (arg_91_1.time_ - var_94_8) / var_94_17

				arg_91_1.fswtw_.percent = Mathf.Lerp(arg_91_1.var_.oldValueTypewriter, var_94_13, var_94_18)
				arg_91_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_91_1.fswtw_:SetDirty()
			end

			if arg_91_1.time_ >= var_94_8 + var_94_17 and arg_91_1.time_ < var_94_8 + var_94_17 + arg_94_0 then
				arg_91_1.fswtw_.percent = var_94_13

				arg_91_1.fswtw_:SetDirty()
				arg_91_1:ShowNextGo(true)

				arg_91_1.typewritterCharCountI18N = var_94_14
			end

			local var_94_19 = 0

			if var_94_19 < arg_91_1.time_ and arg_91_1.time_ <= var_94_19 + arg_94_0 then
				local var_94_20 = manager.ui.mainCamera.transform.localPosition
				local var_94_21 = Vector3.New(0, 0, 10) + Vector3.New(var_94_20.x, var_94_20.y, 0)
				local var_94_22 = arg_91_1.bgs_.STblack

				var_94_22.transform.localPosition = var_94_21
				var_94_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_23 = var_94_22:GetComponent("SpriteRenderer")

				if var_94_23 and var_94_23.sprite then
					local var_94_24 = (var_94_22.transform.localPosition - var_94_20).z
					local var_94_25 = manager.ui.mainCameraCom_
					local var_94_26 = 2 * var_94_24 * Mathf.Tan(var_94_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_94_27 = var_94_26 * var_94_25.aspect
					local var_94_28 = var_94_23.sprite.bounds.size.x
					local var_94_29 = var_94_23.sprite.bounds.size.y
					local var_94_30 = var_94_27 / var_94_28
					local var_94_31 = var_94_26 / var_94_29
					local var_94_32 = var_94_31 < var_94_30 and var_94_30 or var_94_31

					var_94_22.transform.localScale = Vector3.New(var_94_32, var_94_32, 0)
				end

				for iter_94_0, iter_94_1 in pairs(arg_91_1.bgs_) do
					if iter_94_0 ~= "STblack" then
						iter_94_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_94_33 = 1
			local var_94_34 = 6.133
			local var_94_35 = manager.audio:GetVoiceLength("story_v_out_319891", "319891021", "story_v_out_319891.awb") / 1000

			if var_94_35 > 0 and var_94_34 < var_94_35 and var_94_35 + var_94_33 > arg_91_1.duration_ then
				local var_94_36 = var_94_35

				arg_91_1.duration_ = var_94_35 + var_94_33
			end

			if var_94_33 < arg_91_1.time_ and arg_91_1.time_ <= var_94_33 + arg_94_0 then
				local var_94_37 = "play"
				local var_94_38 = "voice"

				arg_91_1:AudioAction(var_94_37, var_94_38, "story_v_out_319891", "319891021", "story_v_out_319891.awb")
			end

			local var_94_39 = 0

			if var_94_39 < arg_91_1.time_ and arg_91_1.time_ <= var_94_39 + arg_94_0 then
				arg_91_1.cswbg_:SetActive(true)

				local var_94_40 = arg_91_1.cswt_:GetComponent("RectTransform")

				arg_91_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_94_40.offsetMin = Vector2.New(0, 0)
				var_94_40.offsetMax = Vector2.New(0, 0)

				local var_94_41 = arg_91_1:GetWordFromCfg(419068)
				local var_94_42 = arg_91_1:FormatText(var_94_41.content)

				arg_91_1.cswt_.text = var_94_42

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.cswt_)

				arg_91_1.cswt_.fontSize = 175
				arg_91_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_91_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_91_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play319891022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 319891022
		arg_95_1.duration_ = 2.73

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play319891023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.fswbg_:SetActive(true)
				arg_95_1.dialog_:SetActive(false)

				arg_95_1.fswtw_.percent = 0

				local var_98_1 = arg_95_1:GetWordFromCfg(319891022)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.fswt_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.fswt_)

				arg_95_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_95_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_95_1.fswtw_:SetDirty()

				arg_95_1.typewritterCharCountI18N = 0

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_3 = 0.200000002980232

			if var_98_3 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.var_.oldValueTypewriter = arg_95_1.fswtw_.percent

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_4 = 5
			local var_98_5 = 0.333333333333333
			local var_98_6 = arg_95_1:GetWordFromCfg(319891022)
			local var_98_7 = arg_95_1:FormatText(var_98_6.content)
			local var_98_8, var_98_9 = arg_95_1:GetPercentByPara(var_98_7, 1)

			if var_98_3 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				local var_98_10 = var_98_4 <= 0 and var_98_5 or var_98_5 * ((var_98_9 - arg_95_1.typewritterCharCountI18N) / var_98_4)

				if var_98_10 > 0 and var_98_5 < var_98_10 then
					arg_95_1.talkMaxDuration = var_98_10

					if var_98_10 + var_98_3 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_3
					end
				end
			end

			local var_98_11 = 0.333333333333333
			local var_98_12 = math.max(var_98_11, arg_95_1.talkMaxDuration)

			if var_98_3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_3 + var_98_12 then
				local var_98_13 = (arg_95_1.time_ - var_98_3) / var_98_12

				arg_95_1.fswtw_.percent = Mathf.Lerp(arg_95_1.var_.oldValueTypewriter, var_98_8, var_98_13)
				arg_95_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_95_1.fswtw_:SetDirty()
			end

			if arg_95_1.time_ >= var_98_3 + var_98_12 and arg_95_1.time_ < var_98_3 + var_98_12 + arg_98_0 then
				arg_95_1.fswtw_.percent = var_98_8

				arg_95_1.fswtw_:SetDirty()
				arg_95_1:ShowNextGo(true)

				arg_95_1.typewritterCharCountI18N = var_98_9
			end

			local var_98_14 = 0.200000002980232
			local var_98_15 = 2.533
			local var_98_16 = manager.audio:GetVoiceLength("story_v_out_319891", "319891022", "story_v_out_319891.awb") / 1000

			if var_98_16 > 0 and var_98_15 < var_98_16 and var_98_16 + var_98_14 > arg_95_1.duration_ then
				local var_98_17 = var_98_16

				arg_95_1.duration_ = var_98_16 + var_98_14
			end

			if var_98_14 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				local var_98_18 = "play"
				local var_98_19 = "voice"

				arg_95_1:AudioAction(var_98_18, var_98_19, "story_v_out_319891", "319891022", "story_v_out_319891.awb")
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play319891023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 319891023
		arg_99_1.duration_ = 5.7

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play319891024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.fswbg_:SetActive(true)
				arg_99_1.dialog_:SetActive(false)

				arg_99_1.fswtw_.percent = 0

				local var_102_1 = arg_99_1:GetWordFromCfg(319891023)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.fswt_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.fswt_)

				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_99_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_99_1.fswtw_:SetDirty()

				arg_99_1.typewritterCharCountI18N = 0

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_3 = 0.200000002980232

			if var_102_3 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.var_.oldValueTypewriter = arg_99_1.fswtw_.percent

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_4 = 17
			local var_102_5 = 1.13333333333333
			local var_102_6 = arg_99_1:GetWordFromCfg(319891023)
			local var_102_7 = arg_99_1:FormatText(var_102_6.content)
			local var_102_8, var_102_9 = arg_99_1:GetPercentByPara(var_102_7, 1)

			if var_102_3 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				local var_102_10 = var_102_4 <= 0 and var_102_5 or var_102_5 * ((var_102_9 - arg_99_1.typewritterCharCountI18N) / var_102_4)

				if var_102_10 > 0 and var_102_5 < var_102_10 then
					arg_99_1.talkMaxDuration = var_102_10

					if var_102_10 + var_102_3 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_3
					end
				end
			end

			local var_102_11 = 1.13333333333333
			local var_102_12 = math.max(var_102_11, arg_99_1.talkMaxDuration)

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_12 then
				local var_102_13 = (arg_99_1.time_ - var_102_3) / var_102_12

				arg_99_1.fswtw_.percent = Mathf.Lerp(arg_99_1.var_.oldValueTypewriter, var_102_8, var_102_13)
				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_99_1.fswtw_:SetDirty()
			end

			if arg_99_1.time_ >= var_102_3 + var_102_12 and arg_99_1.time_ < var_102_3 + var_102_12 + arg_102_0 then
				arg_99_1.fswtw_.percent = var_102_8

				arg_99_1.fswtw_:SetDirty()
				arg_99_1:ShowNextGo(true)

				arg_99_1.typewritterCharCountI18N = var_102_9
			end

			local var_102_14 = 0.200000002980232
			local var_102_15 = 5.5
			local var_102_16 = manager.audio:GetVoiceLength("story_v_out_319891", "319891023", "story_v_out_319891.awb") / 1000

			if var_102_16 > 0 and var_102_15 < var_102_16 and var_102_16 + var_102_14 > arg_99_1.duration_ then
				local var_102_17 = var_102_16

				arg_99_1.duration_ = var_102_16 + var_102_14
			end

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				local var_102_18 = "play"
				local var_102_19 = "voice"

				arg_99_1:AudioAction(var_102_18, var_102_19, "story_v_out_319891", "319891023", "story_v_out_319891.awb")
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play319891024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319891024
		arg_103_1.duration_ = 2.3

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play319891025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.fswbg_:SetActive(true)
				arg_103_1.dialog_:SetActive(false)

				arg_103_1.fswtw_.percent = 0

				local var_106_1 = arg_103_1:GetWordFromCfg(319891024)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.fswt_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.fswt_)

				arg_103_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_103_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_103_1.fswtw_:SetDirty()

				arg_103_1.typewritterCharCountI18N = 0

				SetActive(arg_103_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_103_1:ShowNextGo(false)
			end

			local var_106_3 = 0.200000002980232

			if var_106_3 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.var_.oldValueTypewriter = arg_103_1.fswtw_.percent

				SetActive(arg_103_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_103_1:ShowNextGo(false)
			end

			local var_106_4 = 11
			local var_106_5 = 0.733333333333333
			local var_106_6 = arg_103_1:GetWordFromCfg(319891024)
			local var_106_7 = arg_103_1:FormatText(var_106_6.content)
			local var_106_8, var_106_9 = arg_103_1:GetPercentByPara(var_106_7, 1)

			if var_106_3 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				local var_106_10 = var_106_4 <= 0 and var_106_5 or var_106_5 * ((var_106_9 - arg_103_1.typewritterCharCountI18N) / var_106_4)

				if var_106_10 > 0 and var_106_5 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_3 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_3
					end
				end
			end

			local var_106_11 = 0.733333333333333
			local var_106_12 = math.max(var_106_11, arg_103_1.talkMaxDuration)

			if var_106_3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_3 + var_106_12 then
				local var_106_13 = (arg_103_1.time_ - var_106_3) / var_106_12

				arg_103_1.fswtw_.percent = Mathf.Lerp(arg_103_1.var_.oldValueTypewriter, var_106_8, var_106_13)
				arg_103_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_103_1.fswtw_:SetDirty()
			end

			if arg_103_1.time_ >= var_106_3 + var_106_12 and arg_103_1.time_ < var_106_3 + var_106_12 + arg_106_0 then
				arg_103_1.fswtw_.percent = var_106_8

				arg_103_1.fswtw_:SetDirty()
				arg_103_1:ShowNextGo(true)

				arg_103_1.typewritterCharCountI18N = var_106_9
			end

			local var_106_14 = 0.200000002980232
			local var_106_15 = 2.1
			local var_106_16 = manager.audio:GetVoiceLength("story_v_out_319891", "319891024", "story_v_out_319891.awb") / 1000

			if var_106_16 > 0 and var_106_15 < var_106_16 and var_106_16 + var_106_14 > arg_103_1.duration_ then
				local var_106_17 = var_106_16

				arg_103_1.duration_ = var_106_16 + var_106_14
			end

			if var_106_14 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				local var_106_18 = "play"
				local var_106_19 = "voice"

				arg_103_1:AudioAction(var_106_18, var_106_19, "story_v_out_319891", "319891024", "story_v_out_319891.awb")
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play319891025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319891025
		arg_107_1.duration_ = 5.7

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play319891026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				local var_110_1 = arg_107_1.fswbg_.transform:Find("textbox/adapt/content") or arg_107_1.fswbg_.transform:Find("textbox/content")
				local var_110_2 = arg_107_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_110_3 = var_110_1:GetComponent("Text")
				local var_110_4 = var_110_1:GetComponent("RectTransform")

				var_110_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_110_4.offsetMin = Vector2.New(0, 0)
				var_110_4.offsetMax = Vector2.New(0, 0)
			end

			local var_110_5 = 0

			if var_110_5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1.fswbg_:SetActive(true)
				arg_107_1.dialog_:SetActive(false)

				arg_107_1.fswtw_.percent = 0

				local var_110_6 = arg_107_1:GetWordFromCfg(319891025)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.fswt_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.fswt_)

				arg_107_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_107_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_107_1.fswtw_:SetDirty()

				arg_107_1.typewritterCharCountI18N = 0

				SetActive(arg_107_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_107_1:ShowNextGo(false)
			end

			local var_110_8 = 0.866666666666667

			if var_110_8 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.var_.oldValueTypewriter = arg_107_1.fswtw_.percent

				SetActive(arg_107_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_107_1:ShowNextGo(false)
			end

			local var_110_9 = 16
			local var_110_10 = 1.06666666666667
			local var_110_11 = arg_107_1:GetWordFromCfg(319891025)
			local var_110_12 = arg_107_1:FormatText(var_110_11.content)
			local var_110_13, var_110_14 = arg_107_1:GetPercentByPara(var_110_12, 1)

			if var_110_8 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				local var_110_15 = var_110_9 <= 0 and var_110_10 or var_110_10 * ((var_110_14 - arg_107_1.typewritterCharCountI18N) / var_110_9)

				if var_110_15 > 0 and var_110_10 < var_110_15 then
					arg_107_1.talkMaxDuration = var_110_15

					if var_110_15 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_15 + var_110_8
					end
				end
			end

			local var_110_16 = 1.06666666666667
			local var_110_17 = math.max(var_110_16, arg_107_1.talkMaxDuration)

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_17 then
				local var_110_18 = (arg_107_1.time_ - var_110_8) / var_110_17

				arg_107_1.fswtw_.percent = Mathf.Lerp(arg_107_1.var_.oldValueTypewriter, var_110_13, var_110_18)
				arg_107_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_107_1.fswtw_:SetDirty()
			end

			if arg_107_1.time_ >= var_110_8 + var_110_17 and arg_107_1.time_ < var_110_8 + var_110_17 + arg_110_0 then
				arg_107_1.fswtw_.percent = var_110_13

				arg_107_1.fswtw_:SetDirty()
				arg_107_1:ShowNextGo(true)

				arg_107_1.typewritterCharCountI18N = var_110_14
			end

			local var_110_19 = 0

			if var_110_19 < arg_107_1.time_ and arg_107_1.time_ <= var_110_19 + arg_110_0 then
				local var_110_20 = manager.ui.mainCamera.transform.localPosition
				local var_110_21 = Vector3.New(0, 0, 10) + Vector3.New(var_110_20.x, var_110_20.y, 0)
				local var_110_22 = arg_107_1.bgs_.STblack

				var_110_22.transform.localPosition = var_110_21
				var_110_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_110_23 = var_110_22:GetComponent("SpriteRenderer")

				if var_110_23 and var_110_23.sprite then
					local var_110_24 = (var_110_22.transform.localPosition - var_110_20).z
					local var_110_25 = manager.ui.mainCameraCom_
					local var_110_26 = 2 * var_110_24 * Mathf.Tan(var_110_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_110_27 = var_110_26 * var_110_25.aspect
					local var_110_28 = var_110_23.sprite.bounds.size.x
					local var_110_29 = var_110_23.sprite.bounds.size.y
					local var_110_30 = var_110_27 / var_110_28
					local var_110_31 = var_110_26 / var_110_29
					local var_110_32 = var_110_31 < var_110_30 and var_110_30 or var_110_31

					var_110_22.transform.localScale = Vector3.New(var_110_32, var_110_32, 0)
				end

				for iter_110_0, iter_110_1 in pairs(arg_107_1.bgs_) do
					if iter_110_0 ~= "STblack" then
						iter_110_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_110_33 = 0.866666666666667
			local var_110_34 = 4.833
			local var_110_35 = manager.audio:GetVoiceLength("story_v_out_319891", "319891025", "story_v_out_319891.awb") / 1000

			if var_110_35 > 0 and var_110_34 < var_110_35 and var_110_35 + var_110_33 > arg_107_1.duration_ then
				local var_110_36 = var_110_35

				arg_107_1.duration_ = var_110_35 + var_110_33
			end

			if var_110_33 < arg_107_1.time_ and arg_107_1.time_ <= var_110_33 + arg_110_0 then
				local var_110_37 = "play"
				local var_110_38 = "voice"

				arg_107_1:AudioAction(var_110_37, var_110_38, "story_v_out_319891", "319891025", "story_v_out_319891.awb")
			end

			local var_110_39 = 0

			if var_110_39 < arg_107_1.time_ and arg_107_1.time_ <= var_110_39 + arg_110_0 then
				arg_107_1.cswbg_:SetActive(true)

				local var_110_40 = arg_107_1.cswt_:GetComponent("RectTransform")

				arg_107_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_110_40.offsetMin = Vector2.New(410, 330)
				var_110_40.offsetMax = Vector2.New(-400, -180)

				local var_110_41 = arg_107_1:GetWordFromCfg(419069)
				local var_110_42 = arg_107_1:FormatText(var_110_41.content)

				arg_107_1.cswt_.text = var_110_42

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.cswt_)

				arg_107_1.cswt_.fontSize = 175
				arg_107_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_107_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_107_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play319891026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319891026
		arg_111_1.duration_ = 1.07

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play319891027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.fswbg_:SetActive(true)
				arg_111_1.dialog_:SetActive(false)

				arg_111_1.fswtw_.percent = 0

				local var_114_1 = arg_111_1:GetWordFromCfg(319891026)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.fswt_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.fswt_)

				arg_111_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_111_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_111_1.fswtw_:SetDirty()

				arg_111_1.typewritterCharCountI18N = 0

				SetActive(arg_111_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_111_1:ShowNextGo(false)
			end

			local var_114_3 = 0.200000002980232

			if var_114_3 < arg_111_1.time_ and arg_111_1.time_ <= var_114_3 + arg_114_0 then
				arg_111_1.var_.oldValueTypewriter = arg_111_1.fswtw_.percent

				SetActive(arg_111_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_111_1:ShowNextGo(false)
			end

			local var_114_4 = 2
			local var_114_5 = 0.133333333333333
			local var_114_6 = arg_111_1:GetWordFromCfg(319891026)
			local var_114_7 = arg_111_1:FormatText(var_114_6.content)
			local var_114_8, var_114_9 = arg_111_1:GetPercentByPara(var_114_7, 1)

			if var_114_3 < arg_111_1.time_ and arg_111_1.time_ <= var_114_3 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				local var_114_10 = var_114_4 <= 0 and var_114_5 or var_114_5 * ((var_114_9 - arg_111_1.typewritterCharCountI18N) / var_114_4)

				if var_114_10 > 0 and var_114_5 < var_114_10 then
					arg_111_1.talkMaxDuration = var_114_10

					if var_114_10 + var_114_3 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_3
					end
				end
			end

			local var_114_11 = 0.133333333333333
			local var_114_12 = math.max(var_114_11, arg_111_1.talkMaxDuration)

			if var_114_3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_3 + var_114_12 then
				local var_114_13 = (arg_111_1.time_ - var_114_3) / var_114_12

				arg_111_1.fswtw_.percent = Mathf.Lerp(arg_111_1.var_.oldValueTypewriter, var_114_8, var_114_13)
				arg_111_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_111_1.fswtw_:SetDirty()
			end

			if arg_111_1.time_ >= var_114_3 + var_114_12 and arg_111_1.time_ < var_114_3 + var_114_12 + arg_114_0 then
				arg_111_1.fswtw_.percent = var_114_8

				arg_111_1.fswtw_:SetDirty()
				arg_111_1:ShowNextGo(true)

				arg_111_1.typewritterCharCountI18N = var_114_9
			end

			local var_114_14 = 0.200000002980232
			local var_114_15 = 0.866
			local var_114_16 = manager.audio:GetVoiceLength("story_v_out_319891", "319891026", "story_v_out_319891.awb") / 1000

			if var_114_16 > 0 and var_114_15 < var_114_16 and var_114_16 + var_114_14 > arg_111_1.duration_ then
				local var_114_17 = var_114_16

				arg_111_1.duration_ = var_114_16 + var_114_14
			end

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 then
				local var_114_18 = "play"
				local var_114_19 = "voice"

				arg_111_1:AudioAction(var_114_18, var_114_19, "story_v_out_319891", "319891026", "story_v_out_319891.awb")
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play319891027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319891027
		arg_115_1.duration_ = 12.87

		local var_115_0 = {
			zh = 9.3,
			ja = 12.866
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play319891028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				local var_118_1 = manager.ui.mainCamera.transform.localPosition
				local var_118_2 = Vector3.New(0, 0, 10) + Vector3.New(var_118_1.x, var_118_1.y, 0)
				local var_118_3 = arg_115_1.bgs_.ST15a

				var_118_3.transform.localPosition = var_118_2
				var_118_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_118_4 = var_118_3:GetComponent("SpriteRenderer")

				if var_118_4 and var_118_4.sprite then
					local var_118_5 = (var_118_3.transform.localPosition - var_118_1).z
					local var_118_6 = manager.ui.mainCameraCom_
					local var_118_7 = 2 * var_118_5 * Mathf.Tan(var_118_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_118_8 = var_118_7 * var_118_6.aspect
					local var_118_9 = var_118_4.sprite.bounds.size.x
					local var_118_10 = var_118_4.sprite.bounds.size.y
					local var_118_11 = var_118_8 / var_118_9
					local var_118_12 = var_118_7 / var_118_10
					local var_118_13 = var_118_12 < var_118_11 and var_118_11 or var_118_12

					var_118_3.transform.localScale = Vector3.New(var_118_13, var_118_13, 0)
				end

				for iter_118_0, iter_118_1 in pairs(arg_115_1.bgs_) do
					if iter_118_0 ~= "ST15a" then
						iter_118_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_118_14 = 0

			if var_118_14 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_15 = 2

			if var_118_14 <= arg_115_1.time_ and arg_115_1.time_ < var_118_14 + var_118_15 then
				local var_118_16 = (arg_115_1.time_ - var_118_14) / var_118_15
				local var_118_17 = Color.New(0, 0, 0)

				var_118_17.a = Mathf.Lerp(1, 0, var_118_16)
				arg_115_1.mask_.color = var_118_17
			end

			if arg_115_1.time_ >= var_118_14 + var_118_15 and arg_115_1.time_ < var_118_14 + var_118_15 + arg_118_0 then
				local var_118_18 = Color.New(0, 0, 0)
				local var_118_19 = 0

				arg_115_1.mask_.enabled = false
				var_118_18.a = var_118_19
				arg_115_1.mask_.color = var_118_18
			end

			local var_118_20 = arg_115_1.actors_["1084ui_story"]
			local var_118_21 = 0

			if var_118_21 < arg_115_1.time_ and arg_115_1.time_ <= var_118_21 + arg_118_0 and not isNil(var_118_20) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_22 = 0.200000002980232

			if var_118_21 <= arg_115_1.time_ and arg_115_1.time_ < var_118_21 + var_118_22 and not isNil(var_118_20) then
				local var_118_23 = (arg_115_1.time_ - var_118_21) / var_118_22

				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_20) then
					local var_118_24 = Mathf.Lerp(0, 0.5, var_118_23)

					arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1084ui_story.fillRatio = var_118_24
				end
			end

			if arg_115_1.time_ >= var_118_21 + var_118_22 and arg_115_1.time_ < var_118_21 + var_118_22 + arg_118_0 and not isNil(var_118_20) and arg_115_1.var_.characterEffect1084ui_story then
				local var_118_25 = 0.5

				arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1084ui_story.fillRatio = var_118_25
			end

			local var_118_26 = 0

			if var_118_26 < arg_115_1.time_ and arg_115_1.time_ <= var_118_26 + arg_118_0 then
				arg_115_1.fswbg_:SetActive(false)
				arg_115_1.dialog_:SetActive(false)
				SetActive(arg_115_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_115_1:ShowNextGo(false)
			end

			local var_118_27 = 0.1

			if var_118_27 < arg_115_1.time_ and arg_115_1.time_ <= var_118_27 + arg_118_0 then
				arg_115_1.fswbg_:SetActive(false)
				arg_115_1.dialog_:SetActive(false)
				SetActive(arg_115_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_115_1:ShowNextGo(false)
			end

			local var_118_28 = 0

			if var_118_28 < arg_115_1.time_ and arg_115_1.time_ <= var_118_28 + arg_118_0 then
				arg_115_1.cswbg_:SetActive(false)
			end

			local var_118_29 = "4037ui_story"

			if arg_115_1.actors_[var_118_29] == nil then
				local var_118_30 = Asset.Load("Char/" .. "4037ui_story")

				if not isNil(var_118_30) then
					local var_118_31 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_115_1.stage_.transform)

					var_118_31.name = var_118_29
					var_118_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_115_1.actors_[var_118_29] = var_118_31

					local var_118_32 = var_118_31:GetComponentInChildren(typeof(CharacterEffect))

					var_118_32.enabled = true

					local var_118_33 = GameObjectTools.GetOrAddComponent(var_118_31, typeof(DynamicBoneHelper))

					if var_118_33 then
						var_118_33:EnableDynamicBone(false)
					end

					arg_115_1:ShowWeapon(var_118_32.transform, false)

					arg_115_1.var_[var_118_29 .. "Animator"] = var_118_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_115_1.var_[var_118_29 .. "Animator"].applyRootMotion = true
					arg_115_1.var_[var_118_29 .. "LipSync"] = var_118_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_118_34 = arg_115_1.actors_["4037ui_story"].transform
			local var_118_35 = 1.86666666666667

			if var_118_35 < arg_115_1.time_ and arg_115_1.time_ <= var_118_35 + arg_118_0 then
				arg_115_1.var_.moveOldPos4037ui_story = var_118_34.localPosition
			end

			local var_118_36 = 0.001

			if var_118_35 <= arg_115_1.time_ and arg_115_1.time_ < var_118_35 + var_118_36 then
				local var_118_37 = (arg_115_1.time_ - var_118_35) / var_118_36
				local var_118_38 = Vector3.New(0, -1.12, -6.2)

				var_118_34.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos4037ui_story, var_118_38, var_118_37)

				local var_118_39 = manager.ui.mainCamera.transform.position - var_118_34.position

				var_118_34.forward = Vector3.New(var_118_39.x, var_118_39.y, var_118_39.z)

				local var_118_40 = var_118_34.localEulerAngles

				var_118_40.z = 0
				var_118_40.x = 0
				var_118_34.localEulerAngles = var_118_40
			end

			if arg_115_1.time_ >= var_118_35 + var_118_36 and arg_115_1.time_ < var_118_35 + var_118_36 + arg_118_0 then
				var_118_34.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_118_41 = manager.ui.mainCamera.transform.position - var_118_34.position

				var_118_34.forward = Vector3.New(var_118_41.x, var_118_41.y, var_118_41.z)

				local var_118_42 = var_118_34.localEulerAngles

				var_118_42.z = 0
				var_118_42.x = 0
				var_118_34.localEulerAngles = var_118_42
			end

			local var_118_43 = arg_115_1.actors_["4037ui_story"]
			local var_118_44 = 1.86666666666667

			if var_118_44 < arg_115_1.time_ and arg_115_1.time_ <= var_118_44 + arg_118_0 and not isNil(var_118_43) and arg_115_1.var_.characterEffect4037ui_story == nil then
				arg_115_1.var_.characterEffect4037ui_story = var_118_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_45 = 0.200000002980232

			if var_118_44 <= arg_115_1.time_ and arg_115_1.time_ < var_118_44 + var_118_45 and not isNil(var_118_43) then
				local var_118_46 = (arg_115_1.time_ - var_118_44) / var_118_45

				if arg_115_1.var_.characterEffect4037ui_story and not isNil(var_118_43) then
					arg_115_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_44 + var_118_45 and arg_115_1.time_ < var_118_44 + var_118_45 + arg_118_0 and not isNil(var_118_43) and arg_115_1.var_.characterEffect4037ui_story then
				arg_115_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_118_47 = 1.86666666666667

			if var_118_47 < arg_115_1.time_ and arg_115_1.time_ <= var_118_47 + arg_118_0 then
				arg_115_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_118_48 = 1.86666666666667

			if var_118_48 < arg_115_1.time_ and arg_115_1.time_ <= var_118_48 + arg_118_0 then
				arg_115_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_49 = 2
			local var_118_50 = 0.725

			if var_118_49 < arg_115_1.time_ and arg_115_1.time_ <= var_118_49 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_51 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_51:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_52 = arg_115_1:FormatText(StoryNameCfg[453].name)

				arg_115_1.leftNameTxt_.text = var_118_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_53 = arg_115_1:GetWordFromCfg(319891027)
				local var_118_54 = arg_115_1:FormatText(var_118_53.content)

				arg_115_1.text_.text = var_118_54

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_55 = 29
				local var_118_56 = utf8.len(var_118_54)
				local var_118_57 = var_118_55 <= 0 and var_118_50 or var_118_50 * (var_118_56 / var_118_55)

				if var_118_57 > 0 and var_118_50 < var_118_57 then
					arg_115_1.talkMaxDuration = var_118_57
					var_118_49 = var_118_49 + 0.3

					if var_118_57 + var_118_49 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_57 + var_118_49
					end
				end

				arg_115_1.text_.text = var_118_54
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891027", "story_v_out_319891.awb") ~= 0 then
					local var_118_58 = manager.audio:GetVoiceLength("story_v_out_319891", "319891027", "story_v_out_319891.awb") / 1000

					if var_118_58 + var_118_49 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_58 + var_118_49
					end

					if var_118_53.prefab_name ~= "" and arg_115_1.actors_[var_118_53.prefab_name] ~= nil then
						local var_118_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_53.prefab_name].transform, "story_v_out_319891", "319891027", "story_v_out_319891.awb")

						arg_115_1:RecordAudio("319891027", var_118_59)
						arg_115_1:RecordAudio("319891027", var_118_59)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319891", "319891027", "story_v_out_319891.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319891", "319891027", "story_v_out_319891.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_60 = var_118_49 + 0.3
			local var_118_61 = math.max(var_118_50, arg_115_1.talkMaxDuration)

			if var_118_60 <= arg_115_1.time_ and arg_115_1.time_ < var_118_60 + var_118_61 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_60) / var_118_61

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_60 + var_118_61 and arg_115_1.time_ < var_118_60 + var_118_61 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play319891028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319891028
		arg_121_1.duration_ = 11.37

		local var_121_0 = {
			zh = 11.366,
			ja = 7.033
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
				arg_121_0:Play319891029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_2 = 0
			local var_124_3 = 1.1

			if var_124_2 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_4 = arg_121_1:FormatText(StoryNameCfg[453].name)

				arg_121_1.leftNameTxt_.text = var_124_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_5 = arg_121_1:GetWordFromCfg(319891028)
				local var_124_6 = arg_121_1:FormatText(var_124_5.content)

				arg_121_1.text_.text = var_124_6

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_7 = 44
				local var_124_8 = utf8.len(var_124_6)
				local var_124_9 = var_124_7 <= 0 and var_124_3 or var_124_3 * (var_124_8 / var_124_7)

				if var_124_9 > 0 and var_124_3 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_6
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891028", "story_v_out_319891.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_319891", "319891028", "story_v_out_319891.awb") / 1000

					if var_124_10 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_2
					end

					if var_124_5.prefab_name ~= "" and arg_121_1.actors_[var_124_5.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_5.prefab_name].transform, "story_v_out_319891", "319891028", "story_v_out_319891.awb")

						arg_121_1:RecordAudio("319891028", var_124_11)
						arg_121_1:RecordAudio("319891028", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319891", "319891028", "story_v_out_319891.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319891", "319891028", "story_v_out_319891.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_2) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_2 + var_124_12 and arg_121_1.time_ < var_124_2 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play319891029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319891029
		arg_125_1.duration_ = 15.93

		local var_125_0 = {
			zh = 14.2,
			ja = 15.933
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
				arg_125_0:Play319891030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 1.3

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[453].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(319891029)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 52
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891029", "story_v_out_319891.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891029", "story_v_out_319891.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_319891", "319891029", "story_v_out_319891.awb")

						arg_125_1:RecordAudio("319891029", var_128_9)
						arg_125_1:RecordAudio("319891029", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319891", "319891029", "story_v_out_319891.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319891", "319891029", "story_v_out_319891.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_10 and arg_125_1.time_ < var_128_0 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play319891030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319891030
		arg_129_1.duration_ = 5.57

		local var_129_0 = {
			zh = 5.566,
			ja = 4.433
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
				arg_129_0:Play319891031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.375

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[453].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:GetWordFromCfg(319891030)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 15
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891030", "story_v_out_319891.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891030", "story_v_out_319891.awb") / 1000

					if var_132_8 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_0
					end

					if var_132_3.prefab_name ~= "" and arg_129_1.actors_[var_132_3.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_3.prefab_name].transform, "story_v_out_319891", "319891030", "story_v_out_319891.awb")

						arg_129_1:RecordAudio("319891030", var_132_9)
						arg_129_1:RecordAudio("319891030", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_319891", "319891030", "story_v_out_319891.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_319891", "319891030", "story_v_out_319891.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_10 and arg_129_1.time_ < var_132_0 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play319891031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319891031
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play319891032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 1

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				local var_136_2 = "play"
				local var_136_3 = "effect"

				arg_133_1:AudioAction(var_136_2, var_136_3, "se_story_128", "se_story_128_stab", "")
			end

			local var_136_4 = arg_133_1.actors_["4037ui_story"].transform
			local var_136_5 = 0

			if var_136_5 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.var_.moveOldPos4037ui_story = var_136_4.localPosition
			end

			local var_136_6 = 0.001

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_6 then
				local var_136_7 = (arg_133_1.time_ - var_136_5) / var_136_6
				local var_136_8 = Vector3.New(0, 100, 0)

				var_136_4.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos4037ui_story, var_136_8, var_136_7)

				local var_136_9 = manager.ui.mainCamera.transform.position - var_136_4.position

				var_136_4.forward = Vector3.New(var_136_9.x, var_136_9.y, var_136_9.z)

				local var_136_10 = var_136_4.localEulerAngles

				var_136_10.z = 0
				var_136_10.x = 0
				var_136_4.localEulerAngles = var_136_10
			end

			if arg_133_1.time_ >= var_136_5 + var_136_6 and arg_133_1.time_ < var_136_5 + var_136_6 + arg_136_0 then
				var_136_4.localPosition = Vector3.New(0, 100, 0)

				local var_136_11 = manager.ui.mainCamera.transform.position - var_136_4.position

				var_136_4.forward = Vector3.New(var_136_11.x, var_136_11.y, var_136_11.z)

				local var_136_12 = var_136_4.localEulerAngles

				var_136_12.z = 0
				var_136_12.x = 0
				var_136_4.localEulerAngles = var_136_12
			end

			local var_136_13 = 0
			local var_136_14 = 0.825

			if var_136_13 < arg_133_1.time_ and arg_133_1.time_ <= var_136_13 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_15 = arg_133_1:GetWordFromCfg(319891031)
				local var_136_16 = arg_133_1:FormatText(var_136_15.content)

				arg_133_1.text_.text = var_136_16

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_17 = 33
				local var_136_18 = utf8.len(var_136_16)
				local var_136_19 = var_136_17 <= 0 and var_136_14 or var_136_14 * (var_136_18 / var_136_17)

				if var_136_19 > 0 and var_136_14 < var_136_19 then
					arg_133_1.talkMaxDuration = var_136_19

					if var_136_19 + var_136_13 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_19 + var_136_13
					end
				end

				arg_133_1.text_.text = var_136_16
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_20 = math.max(var_136_14, arg_133_1.talkMaxDuration)

			if var_136_13 <= arg_133_1.time_ and arg_133_1.time_ < var_136_13 + var_136_20 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_13) / var_136_20

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_13 + var_136_20 and arg_133_1.time_ < var_136_13 + var_136_20 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play319891032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319891032
		arg_137_1.duration_ = 3

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play319891033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				local var_140_1 = arg_137_1.fswbg_.transform:Find("textbox/adapt/content") or arg_137_1.fswbg_.transform:Find("textbox/content")
				local var_140_2 = arg_137_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_140_3 = var_140_1:GetComponent("Text")
				local var_140_4 = var_140_1:GetComponent("RectTransform")

				var_140_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_140_4.offsetMin = Vector2.New(0, 0)
				var_140_4.offsetMax = Vector2.New(0, 0)
			end

			local var_140_5 = 0

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.fswbg_:SetActive(true)
				arg_137_1.dialog_:SetActive(false)

				arg_137_1.fswtw_.percent = 0

				local var_140_6 = arg_137_1:GetWordFromCfg(319891032)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.fswt_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.fswt_)

				arg_137_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_137_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_137_1.fswtw_:SetDirty()

				arg_137_1.typewritterCharCountI18N = 0

				SetActive(arg_137_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_137_1:ShowNextGo(false)
			end

			local var_140_8 = 1

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.var_.oldValueTypewriter = arg_137_1.fswtw_.percent

				SetActive(arg_137_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_137_1:ShowNextGo(false)
			end

			local var_140_9 = 7
			local var_140_10 = 0.466666666666667
			local var_140_11 = arg_137_1:GetWordFromCfg(319891032)
			local var_140_12 = arg_137_1:FormatText(var_140_11.content)
			local var_140_13, var_140_14 = arg_137_1:GetPercentByPara(var_140_12, 1)

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				local var_140_15 = var_140_9 <= 0 and var_140_10 or var_140_10 * ((var_140_14 - arg_137_1.typewritterCharCountI18N) / var_140_9)

				if var_140_15 > 0 and var_140_10 < var_140_15 then
					arg_137_1.talkMaxDuration = var_140_15

					if var_140_15 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_15 + var_140_8
					end
				end
			end

			local var_140_16 = 0.466666666666667
			local var_140_17 = math.max(var_140_16, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_17 then
				local var_140_18 = (arg_137_1.time_ - var_140_8) / var_140_17

				arg_137_1.fswtw_.percent = Mathf.Lerp(arg_137_1.var_.oldValueTypewriter, var_140_13, var_140_18)
				arg_137_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_137_1.fswtw_:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_17 and arg_137_1.time_ < var_140_8 + var_140_17 + arg_140_0 then
				arg_137_1.fswtw_.percent = var_140_13

				arg_137_1.fswtw_:SetDirty()
				arg_137_1:ShowNextGo(true)

				arg_137_1.typewritterCharCountI18N = var_140_14
			end

			local var_140_19 = 0

			if var_140_19 < arg_137_1.time_ and arg_137_1.time_ <= var_140_19 + arg_140_0 then
				local var_140_20 = manager.ui.mainCamera.transform.localPosition
				local var_140_21 = Vector3.New(0, 0, 10) + Vector3.New(var_140_20.x, var_140_20.y, 0)
				local var_140_22 = arg_137_1.bgs_.STblack

				var_140_22.transform.localPosition = var_140_21
				var_140_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_23 = var_140_22:GetComponent("SpriteRenderer")

				if var_140_23 and var_140_23.sprite then
					local var_140_24 = (var_140_22.transform.localPosition - var_140_20).z
					local var_140_25 = manager.ui.mainCameraCom_
					local var_140_26 = 2 * var_140_24 * Mathf.Tan(var_140_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_140_27 = var_140_26 * var_140_25.aspect
					local var_140_28 = var_140_23.sprite.bounds.size.x
					local var_140_29 = var_140_23.sprite.bounds.size.y
					local var_140_30 = var_140_27 / var_140_28
					local var_140_31 = var_140_26 / var_140_29
					local var_140_32 = var_140_31 < var_140_30 and var_140_30 or var_140_31

					var_140_22.transform.localScale = Vector3.New(var_140_32, var_140_32, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "STblack" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_33 = 1
			local var_140_34 = 1.966
			local var_140_35 = manager.audio:GetVoiceLength("story_v_out_319891", "319891032", "story_v_out_319891.awb") / 1000

			if var_140_35 > 0 and var_140_34 < var_140_35 and var_140_35 + var_140_33 > arg_137_1.duration_ then
				local var_140_36 = var_140_35

				arg_137_1.duration_ = var_140_35 + var_140_33
			end

			if var_140_33 < arg_137_1.time_ and arg_137_1.time_ <= var_140_33 + arg_140_0 then
				local var_140_37 = "play"
				local var_140_38 = "voice"

				arg_137_1:AudioAction(var_140_37, var_140_38, "story_v_out_319891", "319891032", "story_v_out_319891.awb")
			end

			local var_140_39 = 0

			if var_140_39 < arg_137_1.time_ and arg_137_1.time_ <= var_140_39 + arg_140_0 then
				arg_137_1.cswbg_:SetActive(true)

				local var_140_40 = arg_137_1.cswt_:GetComponent("RectTransform")

				arg_137_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_140_40.offsetMin = Vector2.New(410, 330)
				var_140_40.offsetMax = Vector2.New(-400, -180)

				local var_140_41 = arg_137_1:GetWordFromCfg(419070)
				local var_140_42 = arg_137_1:FormatText(var_140_41.content)

				arg_137_1.cswt_.text = var_140_42

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.cswt_)

				arg_137_1.cswt_.fontSize = 175
				arg_137_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_137_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_137_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play319891033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319891033
		arg_141_1.duration_ = 5.33

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play319891034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1084ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1084ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0, 100, 0)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1084ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, 100, 0)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["1084ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1084ui_story == nil then
				arg_141_1.var_.characterEffect1084ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect1084ui_story and not isNil(var_144_9) then
					local var_144_13 = Mathf.Lerp(0, 0.5, var_144_12)

					arg_141_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1084ui_story.fillRatio = var_144_13
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1084ui_story then
				local var_144_14 = 0.5

				arg_141_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1084ui_story.fillRatio = var_144_14
			end

			local var_144_15 = arg_141_1.actors_["4037ui_story"].transform
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 then
				arg_141_1.var_.moveOldPos4037ui_story = var_144_15.localPosition
			end

			local var_144_17 = 0.001

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_17 then
				local var_144_18 = (arg_141_1.time_ - var_144_16) / var_144_17
				local var_144_19 = Vector3.New(0, 100, 0)

				var_144_15.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos4037ui_story, var_144_19, var_144_18)

				local var_144_20 = manager.ui.mainCamera.transform.position - var_144_15.position

				var_144_15.forward = Vector3.New(var_144_20.x, var_144_20.y, var_144_20.z)

				local var_144_21 = var_144_15.localEulerAngles

				var_144_21.z = 0
				var_144_21.x = 0
				var_144_15.localEulerAngles = var_144_21
			end

			if arg_141_1.time_ >= var_144_16 + var_144_17 and arg_141_1.time_ < var_144_16 + var_144_17 + arg_144_0 then
				var_144_15.localPosition = Vector3.New(0, 100, 0)

				local var_144_22 = manager.ui.mainCamera.transform.position - var_144_15.position

				var_144_15.forward = Vector3.New(var_144_22.x, var_144_22.y, var_144_22.z)

				local var_144_23 = var_144_15.localEulerAngles

				var_144_23.z = 0
				var_144_23.x = 0
				var_144_15.localEulerAngles = var_144_23
			end

			local var_144_24 = arg_141_1.actors_["4037ui_story"]
			local var_144_25 = 0

			if var_144_25 < arg_141_1.time_ and arg_141_1.time_ <= var_144_25 + arg_144_0 and not isNil(var_144_24) and arg_141_1.var_.characterEffect4037ui_story == nil then
				arg_141_1.var_.characterEffect4037ui_story = var_144_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_26 = 0.200000002980232

			if var_144_25 <= arg_141_1.time_ and arg_141_1.time_ < var_144_25 + var_144_26 and not isNil(var_144_24) then
				local var_144_27 = (arg_141_1.time_ - var_144_25) / var_144_26

				if arg_141_1.var_.characterEffect4037ui_story and not isNil(var_144_24) then
					local var_144_28 = Mathf.Lerp(0, 0.5, var_144_27)

					arg_141_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_141_1.var_.characterEffect4037ui_story.fillRatio = var_144_28
				end
			end

			if arg_141_1.time_ >= var_144_25 + var_144_26 and arg_141_1.time_ < var_144_25 + var_144_26 + arg_144_0 and not isNil(var_144_24) and arg_141_1.var_.characterEffect4037ui_story then
				local var_144_29 = 0.5

				arg_141_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_141_1.var_.characterEffect4037ui_story.fillRatio = var_144_29
			end

			local var_144_30 = 0

			if var_144_30 < arg_141_1.time_ and arg_141_1.time_ <= var_144_30 + arg_144_0 then
				arg_141_1.fswbg_:SetActive(false)
				arg_141_1.dialog_:SetActive(false)
				SetActive(arg_141_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_141_1:ShowNextGo(false)
			end

			local var_144_31 = 0.1

			if var_144_31 < arg_141_1.time_ and arg_141_1.time_ <= var_144_31 + arg_144_0 then
				arg_141_1.fswbg_:SetActive(false)
				arg_141_1.dialog_:SetActive(false)
				SetActive(arg_141_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_141_1:ShowNextGo(false)
			end

			local var_144_32 = 0

			if var_144_32 < arg_141_1.time_ and arg_141_1.time_ <= var_144_32 + arg_144_0 then
				arg_141_1.cswbg_:SetActive(false)
			end

			local var_144_33 = 0

			if var_144_33 < arg_141_1.time_ and arg_141_1.time_ <= var_144_33 + arg_144_0 then
				local var_144_34 = manager.ui.mainCamera.transform.localPosition
				local var_144_35 = Vector3.New(0, 0, 10) + Vector3.New(var_144_34.x, var_144_34.y, 0)
				local var_144_36 = arg_141_1.bgs_.ST15a

				var_144_36.transform.localPosition = var_144_35
				var_144_36.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_37 = var_144_36:GetComponent("SpriteRenderer")

				if var_144_37 and var_144_37.sprite then
					local var_144_38 = (var_144_36.transform.localPosition - var_144_34).z
					local var_144_39 = manager.ui.mainCameraCom_
					local var_144_40 = 2 * var_144_38 * Mathf.Tan(var_144_39.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_144_41 = var_144_40 * var_144_39.aspect
					local var_144_42 = var_144_37.sprite.bounds.size.x
					local var_144_43 = var_144_37.sprite.bounds.size.y
					local var_144_44 = var_144_41 / var_144_42
					local var_144_45 = var_144_40 / var_144_43
					local var_144_46 = var_144_45 < var_144_44 and var_144_44 or var_144_45

					var_144_36.transform.localScale = Vector3.New(var_144_46, var_144_46, 0)
				end

				for iter_144_0, iter_144_1 in pairs(arg_141_1.bgs_) do
					if iter_144_0 ~= "ST15a" then
						iter_144_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_47 = 0.333333333333333
			local var_144_48 = 1.2

			if var_144_47 < arg_141_1.time_ and arg_141_1.time_ <= var_144_47 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_49 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_49:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_50 = arg_141_1:GetWordFromCfg(319891033)
				local var_144_51 = arg_141_1:FormatText(var_144_50.content)

				arg_141_1.text_.text = var_144_51

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_52 = 48
				local var_144_53 = utf8.len(var_144_51)
				local var_144_54 = var_144_52 <= 0 and var_144_48 or var_144_48 * (var_144_53 / var_144_52)

				if var_144_54 > 0 and var_144_48 < var_144_54 then
					arg_141_1.talkMaxDuration = var_144_54
					var_144_47 = var_144_47 + 0.3

					if var_144_54 + var_144_47 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_54 + var_144_47
					end
				end

				arg_141_1.text_.text = var_144_51
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_55 = var_144_47 + 0.3
			local var_144_56 = math.max(var_144_48, arg_141_1.talkMaxDuration)

			if var_144_55 <= arg_141_1.time_ and arg_141_1.time_ < var_144_55 + var_144_56 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_55) / var_144_56

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_55 + var_144_56 and arg_141_1.time_ < var_144_55 + var_144_56 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play319891034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319891034
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play319891035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 1.25

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_2 = arg_147_1:GetWordFromCfg(319891034)
				local var_150_3 = arg_147_1:FormatText(var_150_2.content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 50
				local var_150_5 = utf8.len(var_150_3)
				local var_150_6 = var_150_4 <= 0 and var_150_1 or var_150_1 * (var_150_5 / var_150_4)

				if var_150_6 > 0 and var_150_1 < var_150_6 then
					arg_147_1.talkMaxDuration = var_150_6

					if var_150_6 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_7 and arg_147_1.time_ < var_150_0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319891035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319891035
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play319891036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.725

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_2 = arg_151_1:GetWordFromCfg(319891035)
				local var_154_3 = arg_151_1:FormatText(var_154_2.content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 29
				local var_154_5 = utf8.len(var_154_3)
				local var_154_6 = var_154_4 <= 0 and var_154_1 or var_154_1 * (var_154_5 / var_154_4)

				if var_154_6 > 0 and var_154_1 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_7 and arg_151_1.time_ < var_154_0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319891036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319891036
		arg_155_1.duration_ = 2.5

		local var_155_0 = {
			zh = 2.2,
			ja = 2.5
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play319891037(arg_155_1)
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

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[724].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(319891036)
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

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891036", "story_v_out_319891.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891036", "story_v_out_319891.awb") / 1000

					if var_158_8 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_0
					end

					if var_158_3.prefab_name ~= "" and arg_155_1.actors_[var_158_3.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_3.prefab_name].transform, "story_v_out_319891", "319891036", "story_v_out_319891.awb")

						arg_155_1:RecordAudio("319891036", var_158_9)
						arg_155_1:RecordAudio("319891036", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319891", "319891036", "story_v_out_319891.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319891", "319891036", "story_v_out_319891.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_10 and arg_155_1.time_ < var_158_0 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play319891037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319891037
		arg_159_1.duration_ = 2.7

		local var_159_0 = {
			zh = 1.999999999999,
			ja = 2.7
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
				arg_159_0:Play319891038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1084ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1084ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0, -0.97, -6)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1084ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1084ui_story"]
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1084ui_story == nil then
				arg_159_1.var_.characterEffect1084ui_story = var_162_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_11 = 0.200000002980232

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 and not isNil(var_162_9) then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11

				if arg_159_1.var_.characterEffect1084ui_story and not isNil(var_162_9) then
					arg_159_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1084ui_story then
				arg_159_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_162_13 = 0

			if var_162_13 < arg_159_1.time_ and arg_159_1.time_ <= var_162_13 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_162_14 = 0

			if var_162_14 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_162_15 = 0
			local var_162_16 = 0.075

			if var_162_15 < arg_159_1.time_ and arg_159_1.time_ <= var_162_15 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_17 = arg_159_1:FormatText(StoryNameCfg[6].name)

				arg_159_1.leftNameTxt_.text = var_162_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_18 = arg_159_1:GetWordFromCfg(319891037)
				local var_162_19 = arg_159_1:FormatText(var_162_18.content)

				arg_159_1.text_.text = var_162_19

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_20 = 3
				local var_162_21 = utf8.len(var_162_19)
				local var_162_22 = var_162_20 <= 0 and var_162_16 or var_162_16 * (var_162_21 / var_162_20)

				if var_162_22 > 0 and var_162_16 < var_162_22 then
					arg_159_1.talkMaxDuration = var_162_22

					if var_162_22 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_22 + var_162_15
					end
				end

				arg_159_1.text_.text = var_162_19
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891037", "story_v_out_319891.awb") ~= 0 then
					local var_162_23 = manager.audio:GetVoiceLength("story_v_out_319891", "319891037", "story_v_out_319891.awb") / 1000

					if var_162_23 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_23 + var_162_15
					end

					if var_162_18.prefab_name ~= "" and arg_159_1.actors_[var_162_18.prefab_name] ~= nil then
						local var_162_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_18.prefab_name].transform, "story_v_out_319891", "319891037", "story_v_out_319891.awb")

						arg_159_1:RecordAudio("319891037", var_162_24)
						arg_159_1:RecordAudio("319891037", var_162_24)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_319891", "319891037", "story_v_out_319891.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_319891", "319891037", "story_v_out_319891.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_25 = math.max(var_162_16, arg_159_1.talkMaxDuration)

			if var_162_15 <= arg_159_1.time_ and arg_159_1.time_ < var_162_15 + var_162_25 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_15) / var_162_25

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_15 + var_162_25 and arg_159_1.time_ < var_162_15 + var_162_25 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play319891038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319891038
		arg_163_1.duration_ = 3.1

		local var_163_0 = {
			zh = 3.1,
			ja = 2.9
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play319891039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1084ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1084ui_story == nil then
				arg_163_1.var_.characterEffect1084ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1084ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1084ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1084ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1084ui_story.fillRatio = var_166_5
			end

			local var_166_6 = 0
			local var_166_7 = 0.15

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_8 = arg_163_1:FormatText(StoryNameCfg[724].name)

				arg_163_1.leftNameTxt_.text = var_166_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_9 = arg_163_1:GetWordFromCfg(319891038)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 6
				local var_166_12 = utf8.len(var_166_10)
				local var_166_13 = var_166_11 <= 0 and var_166_7 or var_166_7 * (var_166_12 / var_166_11)

				if var_166_13 > 0 and var_166_7 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_10
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891038", "story_v_out_319891.awb") ~= 0 then
					local var_166_14 = manager.audio:GetVoiceLength("story_v_out_319891", "319891038", "story_v_out_319891.awb") / 1000

					if var_166_14 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_14 + var_166_6
					end

					if var_166_9.prefab_name ~= "" and arg_163_1.actors_[var_166_9.prefab_name] ~= nil then
						local var_166_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_9.prefab_name].transform, "story_v_out_319891", "319891038", "story_v_out_319891.awb")

						arg_163_1:RecordAudio("319891038", var_166_15)
						arg_163_1:RecordAudio("319891038", var_166_15)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_319891", "319891038", "story_v_out_319891.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_319891", "319891038", "story_v_out_319891.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_16 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_16 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_16

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_16 and arg_163_1.time_ < var_166_6 + var_166_16 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play319891039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 319891039
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play319891040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1084ui_story"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos1084ui_story = var_170_0.localPosition
			end

			local var_170_2 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2
				local var_170_4 = Vector3.New(0, 100, 0)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1084ui_story, var_170_4, var_170_3)

				local var_170_5 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_5.x, var_170_5.y, var_170_5.z)

				local var_170_6 = var_170_0.localEulerAngles

				var_170_6.z = 0
				var_170_6.x = 0
				var_170_0.localEulerAngles = var_170_6
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(0, 100, 0)

				local var_170_7 = manager.ui.mainCamera.transform.position - var_170_0.position

				var_170_0.forward = Vector3.New(var_170_7.x, var_170_7.y, var_170_7.z)

				local var_170_8 = var_170_0.localEulerAngles

				var_170_8.z = 0
				var_170_8.x = 0
				var_170_0.localEulerAngles = var_170_8
			end

			local var_170_9 = 0
			local var_170_10 = 0.925

			if var_170_9 < arg_167_1.time_ and arg_167_1.time_ <= var_170_9 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_11 = arg_167_1:GetWordFromCfg(319891039)
				local var_170_12 = arg_167_1:FormatText(var_170_11.content)

				arg_167_1.text_.text = var_170_12

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_13 = 37
				local var_170_14 = utf8.len(var_170_12)
				local var_170_15 = var_170_13 <= 0 and var_170_10 or var_170_10 * (var_170_14 / var_170_13)

				if var_170_15 > 0 and var_170_10 < var_170_15 then
					arg_167_1.talkMaxDuration = var_170_15

					if var_170_15 + var_170_9 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_15 + var_170_9
					end
				end

				arg_167_1.text_.text = var_170_12
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_16 = math.max(var_170_10, arg_167_1.talkMaxDuration)

			if var_170_9 <= arg_167_1.time_ and arg_167_1.time_ < var_170_9 + var_170_16 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_9) / var_170_16

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_9 + var_170_16 and arg_167_1.time_ < var_170_9 + var_170_16 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play319891040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319891040
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play319891041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 1.225

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_2 = arg_171_1:GetWordFromCfg(319891040)
				local var_174_3 = arg_171_1:FormatText(var_174_2.content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 49
				local var_174_5 = utf8.len(var_174_3)
				local var_174_6 = var_174_4 <= 0 and var_174_1 or var_174_1 * (var_174_5 / var_174_4)

				if var_174_6 > 0 and var_174_1 < var_174_6 then
					arg_171_1.talkMaxDuration = var_174_6

					if var_174_6 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_7 and arg_171_1.time_ < var_174_0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play319891041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319891041
		arg_175_1.duration_ = 3

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play319891042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				local var_178_1 = arg_175_1.fswbg_.transform:Find("textbox/adapt/content") or arg_175_1.fswbg_.transform:Find("textbox/content")
				local var_178_2 = arg_175_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_178_3 = var_178_1:GetComponent("Text")
				local var_178_4 = var_178_1:GetComponent("RectTransform")

				var_178_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_178_4.offsetMin = Vector2.New(0, 0)
				var_178_4.offsetMax = Vector2.New(0, 0)
			end

			local var_178_5 = 0

			if var_178_5 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.fswbg_:SetActive(true)
				arg_175_1.dialog_:SetActive(false)

				arg_175_1.fswtw_.percent = 0

				local var_178_6 = arg_175_1:GetWordFromCfg(319891041)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.fswt_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.fswt_)

				arg_175_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_175_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_175_1.fswtw_:SetDirty()

				arg_175_1.typewritterCharCountI18N = 0

				SetActive(arg_175_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_175_1:ShowNextGo(false)
			end

			local var_178_8 = 1.36666666666667

			if var_178_8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.var_.oldValueTypewriter = arg_175_1.fswtw_.percent

				SetActive(arg_175_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_175_1:ShowNextGo(false)
			end

			local var_178_9 = 5
			local var_178_10 = 0.333333333333333
			local var_178_11 = arg_175_1:GetWordFromCfg(319891041)
			local var_178_12 = arg_175_1:FormatText(var_178_11.content)
			local var_178_13, var_178_14 = arg_175_1:GetPercentByPara(var_178_12, 1)

			if var_178_8 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				local var_178_15 = var_178_9 <= 0 and var_178_10 or var_178_10 * ((var_178_14 - arg_175_1.typewritterCharCountI18N) / var_178_9)

				if var_178_15 > 0 and var_178_10 < var_178_15 then
					arg_175_1.talkMaxDuration = var_178_15

					if var_178_15 + var_178_8 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_15 + var_178_8
					end
				end
			end

			local var_178_16 = 0.333333333333333
			local var_178_17 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_17 then
				local var_178_18 = (arg_175_1.time_ - var_178_8) / var_178_17

				arg_175_1.fswtw_.percent = Mathf.Lerp(arg_175_1.var_.oldValueTypewriter, var_178_13, var_178_18)
				arg_175_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_175_1.fswtw_:SetDirty()
			end

			if arg_175_1.time_ >= var_178_8 + var_178_17 and arg_175_1.time_ < var_178_8 + var_178_17 + arg_178_0 then
				arg_175_1.fswtw_.percent = var_178_13

				arg_175_1.fswtw_:SetDirty()
				arg_175_1:ShowNextGo(true)

				arg_175_1.typewritterCharCountI18N = var_178_14
			end

			local var_178_19 = 0

			if var_178_19 < arg_175_1.time_ and arg_175_1.time_ <= var_178_19 + arg_178_0 then
				local var_178_20 = manager.ui.mainCamera.transform.localPosition
				local var_178_21 = Vector3.New(0, 0, 10) + Vector3.New(var_178_20.x, var_178_20.y, 0)
				local var_178_22 = arg_175_1.bgs_.STblack

				var_178_22.transform.localPosition = var_178_21
				var_178_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_23 = var_178_22:GetComponent("SpriteRenderer")

				if var_178_23 and var_178_23.sprite then
					local var_178_24 = (var_178_22.transform.localPosition - var_178_20).z
					local var_178_25 = manager.ui.mainCameraCom_
					local var_178_26 = 2 * var_178_24 * Mathf.Tan(var_178_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_178_27 = var_178_26 * var_178_25.aspect
					local var_178_28 = var_178_23.sprite.bounds.size.x
					local var_178_29 = var_178_23.sprite.bounds.size.y
					local var_178_30 = var_178_27 / var_178_28
					local var_178_31 = var_178_26 / var_178_29
					local var_178_32 = var_178_31 < var_178_30 and var_178_30 or var_178_31

					var_178_22.transform.localScale = Vector3.New(var_178_32, var_178_32, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "STblack" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_33 = 1.36666666666667
			local var_178_34 = 1.633
			local var_178_35 = manager.audio:GetVoiceLength("story_v_out_319891", "319891041", "story_v_out_319891.awb") / 1000

			if var_178_35 > 0 and var_178_34 < var_178_35 and var_178_35 + var_178_33 > arg_175_1.duration_ then
				local var_178_36 = var_178_35

				arg_175_1.duration_ = var_178_35 + var_178_33
			end

			if var_178_33 < arg_175_1.time_ and arg_175_1.time_ <= var_178_33 + arg_178_0 then
				local var_178_37 = "play"
				local var_178_38 = "voice"

				arg_175_1:AudioAction(var_178_37, var_178_38, "story_v_out_319891", "319891041", "story_v_out_319891.awb")
			end

			local var_178_39 = 0

			if var_178_39 < arg_175_1.time_ and arg_175_1.time_ <= var_178_39 + arg_178_0 then
				arg_175_1.cswbg_:SetActive(true)

				local var_178_40 = arg_175_1.cswt_:GetComponent("RectTransform")

				arg_175_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_178_40.offsetMin = Vector2.New(410, 330)
				var_178_40.offsetMax = Vector2.New(-400, -175)

				local var_178_41 = arg_175_1:GetWordFromCfg(419071)
				local var_178_42 = arg_175_1:FormatText(var_178_41.content)

				arg_175_1.cswt_.text = var_178_42

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.cswt_)

				arg_175_1.cswt_.fontSize = 180
				arg_175_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_175_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_175_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play319891042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 319891042
		arg_179_1.duration_ = 5.33

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play319891043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1.fswbg_:SetActive(false)
				arg_179_1.dialog_:SetActive(false)
				SetActive(arg_179_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_179_1:ShowNextGo(false)
			end

			local var_182_1 = 0.1

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.fswbg_:SetActive(false)
				arg_179_1.dialog_:SetActive(false)
				SetActive(arg_179_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_179_1:ShowNextGo(false)
			end

			local var_182_2 = 0

			if var_182_2 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.cswbg_:SetActive(false)
			end

			local var_182_3 = 0

			if var_182_3 < arg_179_1.time_ and arg_179_1.time_ <= var_182_3 + arg_182_0 then
				local var_182_4 = manager.ui.mainCamera.transform.localPosition
				local var_182_5 = Vector3.New(0, 0, 10) + Vector3.New(var_182_4.x, var_182_4.y, 0)
				local var_182_6 = arg_179_1.bgs_.ST15a

				var_182_6.transform.localPosition = var_182_5
				var_182_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_182_7 = var_182_6:GetComponent("SpriteRenderer")

				if var_182_7 and var_182_7.sprite then
					local var_182_8 = (var_182_6.transform.localPosition - var_182_4).z
					local var_182_9 = manager.ui.mainCameraCom_
					local var_182_10 = 2 * var_182_8 * Mathf.Tan(var_182_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_182_11 = var_182_10 * var_182_9.aspect
					local var_182_12 = var_182_7.sprite.bounds.size.x
					local var_182_13 = var_182_7.sprite.bounds.size.y
					local var_182_14 = var_182_11 / var_182_12
					local var_182_15 = var_182_10 / var_182_13
					local var_182_16 = var_182_15 < var_182_14 and var_182_14 or var_182_15

					var_182_6.transform.localScale = Vector3.New(var_182_16, var_182_16, 0)
				end

				for iter_182_0, iter_182_1 in pairs(arg_179_1.bgs_) do
					if iter_182_0 ~= "ST15a" then
						iter_182_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_179_1.frameCnt_ <= 1 then
				arg_179_1.dialog_:SetActive(false)
			end

			local var_182_17 = 0.333333333333333
			local var_182_18 = 1.075

			if var_182_17 < arg_179_1.time_ and arg_179_1.time_ <= var_182_17 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_19 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_19:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_20 = arg_179_1:GetWordFromCfg(319891042)
				local var_182_21 = arg_179_1:FormatText(var_182_20.content)

				arg_179_1.text_.text = var_182_21

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_22 = 43
				local var_182_23 = utf8.len(var_182_21)
				local var_182_24 = var_182_22 <= 0 and var_182_18 or var_182_18 * (var_182_23 / var_182_22)

				if var_182_24 > 0 and var_182_18 < var_182_24 then
					arg_179_1.talkMaxDuration = var_182_24
					var_182_17 = var_182_17 + 0.3

					if var_182_24 + var_182_17 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_24 + var_182_17
					end
				end

				arg_179_1.text_.text = var_182_21
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_25 = var_182_17 + 0.3
			local var_182_26 = math.max(var_182_18, arg_179_1.talkMaxDuration)

			if var_182_25 <= arg_179_1.time_ and arg_179_1.time_ < var_182_25 + var_182_26 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_25) / var_182_26

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_25 + var_182_26 and arg_179_1.time_ < var_182_25 + var_182_26 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play319891043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319891043
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play319891044(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.85

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(319891043)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 34
				local var_188_5 = utf8.len(var_188_3)
				local var_188_6 = var_188_4 <= 0 and var_188_1 or var_188_1 * (var_188_5 / var_188_4)

				if var_188_6 > 0 and var_188_1 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_7 and arg_185_1.time_ < var_188_0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play319891044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319891044
		arg_189_1.duration_ = 5.67

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play319891045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = manager.ui.mainCamera.transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				local var_192_2 = arg_189_1.var_.effect191
				local var_192_3
				local var_192_4 = var_192_0

				if not var_192_2 then
					var_192_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_192_4)
					var_192_2.name = "191"
					arg_189_1.var_.effect191 = var_192_2
				else
					var_192_2.transform:SetParent(var_192_4)
				end

				var_192_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_192_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_192_5 = manager.ui.mainCamera.transform
			local var_192_6 = 1.13333333333333

			if var_192_6 < arg_189_1.time_ and arg_189_1.time_ <= var_192_6 + arg_192_0 then
				local var_192_7 = arg_189_1.var_.effect191

				if var_192_7 then
					Object.Destroy(var_192_7)

					arg_189_1.var_.effect191 = nil
				end
			end

			local var_192_8 = 0.666666666666667
			local var_192_9 = 1.675

			if var_192_8 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_10 = arg_189_1:GetWordFromCfg(319891044)
				local var_192_11 = arg_189_1:FormatText(var_192_10.content)

				arg_189_1.text_.text = var_192_11

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_12 = 67
				local var_192_13 = utf8.len(var_192_11)
				local var_192_14 = var_192_12 <= 0 and var_192_9 or var_192_9 * (var_192_13 / var_192_12)

				if var_192_14 > 0 and var_192_9 < var_192_14 then
					arg_189_1.talkMaxDuration = var_192_14

					if var_192_14 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_11
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_15 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_15 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_8) / var_192_15

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_8 + var_192_15 and arg_189_1.time_ < var_192_8 + var_192_15 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play319891045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319891045
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play319891046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.95

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_2 = arg_193_1:GetWordFromCfg(319891045)
				local var_196_3 = arg_193_1:FormatText(var_196_2.content)

				arg_193_1.text_.text = var_196_3

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 38
				local var_196_5 = utf8.len(var_196_3)
				local var_196_6 = var_196_4 <= 0 and var_196_1 or var_196_1 * (var_196_5 / var_196_4)

				if var_196_6 > 0 and var_196_1 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_3
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_7 and arg_193_1.time_ < var_196_0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play319891046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319891046
		arg_197_1.duration_ = 5.3

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play319891047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				local var_200_1 = arg_197_1.fswbg_.transform:Find("textbox/adapt/content") or arg_197_1.fswbg_.transform:Find("textbox/content")
				local var_200_2 = arg_197_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_200_3 = var_200_1:GetComponent("Text")
				local var_200_4 = var_200_1:GetComponent("RectTransform")

				var_200_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_200_4.offsetMin = Vector2.New(0, 0)
				var_200_4.offsetMax = Vector2.New(0, 0)
			end

			local var_200_5 = 0

			if var_200_5 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1.fswbg_:SetActive(true)
				arg_197_1.dialog_:SetActive(false)

				arg_197_1.fswtw_.percent = 0

				local var_200_6 = arg_197_1:GetWordFromCfg(319891046)
				local var_200_7 = arg_197_1:FormatText(var_200_6.content)

				arg_197_1.fswt_.text = var_200_7

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.fswt_)

				arg_197_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_197_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_197_1.fswtw_:SetDirty()

				arg_197_1.typewritterCharCountI18N = 0

				SetActive(arg_197_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_197_1:ShowNextGo(false)
			end

			local var_200_8 = 0.666666666666667

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.var_.oldValueTypewriter = arg_197_1.fswtw_.percent

				SetActive(arg_197_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_197_1:ShowNextGo(false)
			end

			local var_200_9 = 22
			local var_200_10 = 1.46666666666667
			local var_200_11 = arg_197_1:GetWordFromCfg(319891046)
			local var_200_12 = arg_197_1:FormatText(var_200_11.content)
			local var_200_13, var_200_14 = arg_197_1:GetPercentByPara(var_200_12, 1)

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				local var_200_15 = var_200_9 <= 0 and var_200_10 or var_200_10 * ((var_200_14 - arg_197_1.typewritterCharCountI18N) / var_200_9)

				if var_200_15 > 0 and var_200_10 < var_200_15 then
					arg_197_1.talkMaxDuration = var_200_15

					if var_200_15 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_15 + var_200_8
					end
				end
			end

			local var_200_16 = 1.46666666666667
			local var_200_17 = math.max(var_200_16, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_17 then
				local var_200_18 = (arg_197_1.time_ - var_200_8) / var_200_17

				arg_197_1.fswtw_.percent = Mathf.Lerp(arg_197_1.var_.oldValueTypewriter, var_200_13, var_200_18)
				arg_197_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_197_1.fswtw_:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_17 and arg_197_1.time_ < var_200_8 + var_200_17 + arg_200_0 then
				arg_197_1.fswtw_.percent = var_200_13

				arg_197_1.fswtw_:SetDirty()
				arg_197_1:ShowNextGo(true)

				arg_197_1.typewritterCharCountI18N = var_200_14
			end

			local var_200_19 = 0

			if var_200_19 < arg_197_1.time_ and arg_197_1.time_ <= var_200_19 + arg_200_0 then
				local var_200_20 = manager.ui.mainCamera.transform.localPosition
				local var_200_21 = Vector3.New(0, 0, 10) + Vector3.New(var_200_20.x, var_200_20.y, 0)
				local var_200_22 = arg_197_1.bgs_.STblack

				var_200_22.transform.localPosition = var_200_21
				var_200_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_23 = var_200_22:GetComponent("SpriteRenderer")

				if var_200_23 and var_200_23.sprite then
					local var_200_24 = (var_200_22.transform.localPosition - var_200_20).z
					local var_200_25 = manager.ui.mainCameraCom_
					local var_200_26 = 2 * var_200_24 * Mathf.Tan(var_200_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_200_27 = var_200_26 * var_200_25.aspect
					local var_200_28 = var_200_23.sprite.bounds.size.x
					local var_200_29 = var_200_23.sprite.bounds.size.y
					local var_200_30 = var_200_27 / var_200_28
					local var_200_31 = var_200_26 / var_200_29
					local var_200_32 = var_200_31 < var_200_30 and var_200_30 or var_200_31

					var_200_22.transform.localScale = Vector3.New(var_200_32, var_200_32, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "STblack" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_33 = manager.ui.mainCamera.transform
			local var_200_34 = 0

			if var_200_34 < arg_197_1.time_ and arg_197_1.time_ <= var_200_34 + arg_200_0 then
				local var_200_35 = arg_197_1.var_.effect191

				if var_200_35 then
					Object.Destroy(var_200_35)

					arg_197_1.var_.effect191 = nil
				end
			end

			local var_200_36 = 0.666666666666667
			local var_200_37 = 4.633
			local var_200_38 = manager.audio:GetVoiceLength("story_v_out_319891", "319891046", "story_v_out_319891.awb") / 1000

			if var_200_38 > 0 and var_200_37 < var_200_38 and var_200_38 + var_200_36 > arg_197_1.duration_ then
				local var_200_39 = var_200_38

				arg_197_1.duration_ = var_200_38 + var_200_36
			end

			if var_200_36 < arg_197_1.time_ and arg_197_1.time_ <= var_200_36 + arg_200_0 then
				local var_200_40 = "play"
				local var_200_41 = "voice"

				arg_197_1:AudioAction(var_200_40, var_200_41, "story_v_out_319891", "319891046", "story_v_out_319891.awb")
			end

			local var_200_42 = 0

			if var_200_42 < arg_197_1.time_ and arg_197_1.time_ <= var_200_42 + arg_200_0 then
				arg_197_1.cswbg_:SetActive(true)

				local var_200_43 = arg_197_1.cswt_:GetComponent("RectTransform")

				arg_197_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_200_43.offsetMin = Vector2.New(410, 330)
				var_200_43.offsetMax = Vector2.New(-400, -180)

				local var_200_44 = arg_197_1:GetWordFromCfg(419072)
				local var_200_45 = arg_197_1:FormatText(var_200_44.content)

				arg_197_1.cswt_.text = var_200_45

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.cswt_)

				arg_197_1.cswt_.fontSize = 175
				arg_197_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_197_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_197_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play319891047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 319891047
		arg_201_1.duration_ = 5.7

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play319891048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.fswbg_:SetActive(true)
				arg_201_1.dialog_:SetActive(false)

				arg_201_1.fswtw_.percent = 0

				local var_204_1 = arg_201_1:GetWordFromCfg(319891047)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.fswt_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.fswt_)

				arg_201_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_201_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_201_1.fswtw_:SetDirty()

				arg_201_1.typewritterCharCountI18N = 0

				SetActive(arg_201_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_201_1:ShowNextGo(false)
			end

			local var_204_3 = 0.333333333333333

			if var_204_3 < arg_201_1.time_ and arg_201_1.time_ <= var_204_3 + arg_204_0 then
				arg_201_1.var_.oldValueTypewriter = arg_201_1.fswtw_.percent

				SetActive(arg_201_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_201_1:ShowNextGo(false)
			end

			local var_204_4 = 23
			local var_204_5 = 1.53333333333333
			local var_204_6 = arg_201_1:GetWordFromCfg(319891047)
			local var_204_7 = arg_201_1:FormatText(var_204_6.content)
			local var_204_8, var_204_9 = arg_201_1:GetPercentByPara(var_204_7, 1)

			if var_204_3 < arg_201_1.time_ and arg_201_1.time_ <= var_204_3 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				local var_204_10 = var_204_4 <= 0 and var_204_5 or var_204_5 * ((var_204_9 - arg_201_1.typewritterCharCountI18N) / var_204_4)

				if var_204_10 > 0 and var_204_5 < var_204_10 then
					arg_201_1.talkMaxDuration = var_204_10

					if var_204_10 + var_204_3 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_3
					end
				end
			end

			local var_204_11 = 1.53333333333333
			local var_204_12 = math.max(var_204_11, arg_201_1.talkMaxDuration)

			if var_204_3 <= arg_201_1.time_ and arg_201_1.time_ < var_204_3 + var_204_12 then
				local var_204_13 = (arg_201_1.time_ - var_204_3) / var_204_12

				arg_201_1.fswtw_.percent = Mathf.Lerp(arg_201_1.var_.oldValueTypewriter, var_204_8, var_204_13)
				arg_201_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_201_1.fswtw_:SetDirty()
			end

			if arg_201_1.time_ >= var_204_3 + var_204_12 and arg_201_1.time_ < var_204_3 + var_204_12 + arg_204_0 then
				arg_201_1.fswtw_.percent = var_204_8

				arg_201_1.fswtw_:SetDirty()
				arg_201_1:ShowNextGo(true)

				arg_201_1.typewritterCharCountI18N = var_204_9
			end

			local var_204_14 = 0.333333333333333
			local var_204_15 = 5.366
			local var_204_16 = manager.audio:GetVoiceLength("story_v_out_319891", "319891047", "story_v_out_319891.awb") / 1000

			if var_204_16 > 0 and var_204_15 < var_204_16 and var_204_16 + var_204_14 > arg_201_1.duration_ then
				local var_204_17 = var_204_16

				arg_201_1.duration_ = var_204_16 + var_204_14
			end

			if var_204_14 < arg_201_1.time_ and arg_201_1.time_ <= var_204_14 + arg_204_0 then
				local var_204_18 = "play"
				local var_204_19 = "voice"

				arg_201_1:AudioAction(var_204_18, var_204_19, "story_v_out_319891", "319891047", "story_v_out_319891.awb")
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play319891048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 319891048
		arg_205_1.duration_ = 3.87

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play319891049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.fswbg_:SetActive(true)
				arg_205_1.dialog_:SetActive(false)

				arg_205_1.fswtw_.percent = 0

				local var_208_1 = arg_205_1:GetWordFromCfg(319891048)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.fswt_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.fswt_)

				arg_205_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_205_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_205_1.fswtw_:SetDirty()

				arg_205_1.typewritterCharCountI18N = 0

				SetActive(arg_205_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_205_1:ShowNextGo(false)
			end

			local var_208_3 = 0.566666666666667

			if var_208_3 < arg_205_1.time_ and arg_205_1.time_ <= var_208_3 + arg_208_0 then
				arg_205_1.var_.oldValueTypewriter = arg_205_1.fswtw_.percent

				SetActive(arg_205_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_205_1:ShowNextGo(false)
			end

			local var_208_4 = 13
			local var_208_5 = 0.866666666666667
			local var_208_6 = arg_205_1:GetWordFromCfg(319891048)
			local var_208_7 = arg_205_1:FormatText(var_208_6.content)
			local var_208_8, var_208_9 = arg_205_1:GetPercentByPara(var_208_7, 1)

			if var_208_3 < arg_205_1.time_ and arg_205_1.time_ <= var_208_3 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				local var_208_10 = var_208_4 <= 0 and var_208_5 or var_208_5 * ((var_208_9 - arg_205_1.typewritterCharCountI18N) / var_208_4)

				if var_208_10 > 0 and var_208_5 < var_208_10 then
					arg_205_1.talkMaxDuration = var_208_10

					if var_208_10 + var_208_3 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_3
					end
				end
			end

			local var_208_11 = 0.866666666666667
			local var_208_12 = math.max(var_208_11, arg_205_1.talkMaxDuration)

			if var_208_3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_3 + var_208_12 then
				local var_208_13 = (arg_205_1.time_ - var_208_3) / var_208_12

				arg_205_1.fswtw_.percent = Mathf.Lerp(arg_205_1.var_.oldValueTypewriter, var_208_8, var_208_13)
				arg_205_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_205_1.fswtw_:SetDirty()
			end

			if arg_205_1.time_ >= var_208_3 + var_208_12 and arg_205_1.time_ < var_208_3 + var_208_12 + arg_208_0 then
				arg_205_1.fswtw_.percent = var_208_8

				arg_205_1.fswtw_:SetDirty()
				arg_205_1:ShowNextGo(true)

				arg_205_1.typewritterCharCountI18N = var_208_9
			end

			local var_208_14 = 0.566666666666667
			local var_208_15 = 3.3
			local var_208_16 = manager.audio:GetVoiceLength("story_v_out_319891", "319891048", "story_v_out_319891.awb") / 1000

			if var_208_16 > 0 and var_208_15 < var_208_16 and var_208_16 + var_208_14 > arg_205_1.duration_ then
				local var_208_17 = var_208_16

				arg_205_1.duration_ = var_208_16 + var_208_14
			end

			if var_208_14 < arg_205_1.time_ and arg_205_1.time_ <= var_208_14 + arg_208_0 then
				local var_208_18 = "play"
				local var_208_19 = "voice"

				arg_205_1:AudioAction(var_208_18, var_208_19, "story_v_out_319891", "319891048", "story_v_out_319891.awb")
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play319891049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 319891049
		arg_209_1.duration_ = 4.73

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play319891050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.fswbg_:SetActive(true)
				arg_209_1.dialog_:SetActive(false)

				arg_209_1.fswtw_.percent = 0

				local var_212_1 = arg_209_1:GetWordFromCfg(319891049)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.fswt_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.fswt_)

				arg_209_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_209_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_209_1.fswtw_:SetDirty()

				arg_209_1.typewritterCharCountI18N = 0

				SetActive(arg_209_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_209_1:ShowNextGo(false)
			end

			local var_212_3 = 0.766666666666667

			if var_212_3 < arg_209_1.time_ and arg_209_1.time_ <= var_212_3 + arg_212_0 then
				arg_209_1.var_.oldValueTypewriter = arg_209_1.fswtw_.percent

				SetActive(arg_209_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_209_1:ShowNextGo(false)
			end

			local var_212_4 = 14
			local var_212_5 = 0.933333333333333
			local var_212_6 = arg_209_1:GetWordFromCfg(319891049)
			local var_212_7 = arg_209_1:FormatText(var_212_6.content)
			local var_212_8, var_212_9 = arg_209_1:GetPercentByPara(var_212_7, 1)

			if var_212_3 < arg_209_1.time_ and arg_209_1.time_ <= var_212_3 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				local var_212_10 = var_212_4 <= 0 and var_212_5 or var_212_5 * ((var_212_9 - arg_209_1.typewritterCharCountI18N) / var_212_4)

				if var_212_10 > 0 and var_212_5 < var_212_10 then
					arg_209_1.talkMaxDuration = var_212_10

					if var_212_10 + var_212_3 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_3
					end
				end
			end

			local var_212_11 = 0.933333333333333
			local var_212_12 = math.max(var_212_11, arg_209_1.talkMaxDuration)

			if var_212_3 <= arg_209_1.time_ and arg_209_1.time_ < var_212_3 + var_212_12 then
				local var_212_13 = (arg_209_1.time_ - var_212_3) / var_212_12

				arg_209_1.fswtw_.percent = Mathf.Lerp(arg_209_1.var_.oldValueTypewriter, var_212_8, var_212_13)
				arg_209_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_209_1.fswtw_:SetDirty()
			end

			if arg_209_1.time_ >= var_212_3 + var_212_12 and arg_209_1.time_ < var_212_3 + var_212_12 + arg_212_0 then
				arg_209_1.fswtw_.percent = var_212_8

				arg_209_1.fswtw_:SetDirty()
				arg_209_1:ShowNextGo(true)

				arg_209_1.typewritterCharCountI18N = var_212_9
			end

			local var_212_14 = 0.766666666666667
			local var_212_15 = 3.966
			local var_212_16 = manager.audio:GetVoiceLength("story_v_out_319891", "319891049", "story_v_out_319891.awb") / 1000

			if var_212_16 > 0 and var_212_15 < var_212_16 and var_212_16 + var_212_14 > arg_209_1.duration_ then
				local var_212_17 = var_212_16

				arg_209_1.duration_ = var_212_16 + var_212_14
			end

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				local var_212_18 = "play"
				local var_212_19 = "voice"

				arg_209_1:AudioAction(var_212_18, var_212_19, "story_v_out_319891", "319891049", "story_v_out_319891.awb")
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play319891050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 319891050
		arg_213_1.duration_ = 4.5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play319891051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 1

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				local var_216_2 = "play"
				local var_216_3 = "effect"

				arg_213_1:AudioAction(var_216_2, var_216_3, "se_story_130", "se_story_130_police", "")
			end

			local var_216_4 = 0

			if var_216_4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				local var_216_5 = arg_213_1.fswbg_.transform:Find("textbox/adapt/content") or arg_213_1.fswbg_.transform:Find("textbox/content")
				local var_216_6 = arg_213_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_216_7 = var_216_5:GetComponent("Text")
				local var_216_8 = var_216_5:GetComponent("RectTransform")

				var_216_7.alignment = UnityEngine.TextAnchor.LowerCenter
				var_216_8.offsetMin = Vector2.New(0, 0)
				var_216_8.offsetMax = Vector2.New(0, 0)
			end

			local var_216_9 = 0

			if var_216_9 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 then
				arg_213_1.fswbg_:SetActive(true)
				arg_213_1.dialog_:SetActive(false)

				arg_213_1.fswtw_.percent = 0

				local var_216_10 = arg_213_1:GetWordFromCfg(319891050)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.fswt_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.fswt_)

				arg_213_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_213_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_213_1.fswtw_:SetDirty()

				arg_213_1.typewritterCharCountI18N = 0

				SetActive(arg_213_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_213_1:ShowNextGo(false)
			end

			local var_216_12 = 1.16666666666667

			if var_216_12 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 then
				arg_213_1.var_.oldValueTypewriter = arg_213_1.fswtw_.percent

				SetActive(arg_213_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_213_1:ShowNextGo(false)
			end

			local var_216_13 = 50
			local var_216_14 = 3.33333333333333
			local var_216_15 = arg_213_1:GetWordFromCfg(319891050)
			local var_216_16 = arg_213_1:FormatText(var_216_15.content)
			local var_216_17, var_216_18 = arg_213_1:GetPercentByPara(var_216_16, 1)

			if var_216_12 < arg_213_1.time_ and arg_213_1.time_ <= var_216_12 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				local var_216_19 = var_216_13 <= 0 and var_216_14 or var_216_14 * ((var_216_18 - arg_213_1.typewritterCharCountI18N) / var_216_13)

				if var_216_19 > 0 and var_216_14 < var_216_19 then
					arg_213_1.talkMaxDuration = var_216_19

					if var_216_19 + var_216_12 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_19 + var_216_12
					end
				end
			end

			local var_216_20 = 3.33333333333333
			local var_216_21 = math.max(var_216_20, arg_213_1.talkMaxDuration)

			if var_216_12 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_21 then
				local var_216_22 = (arg_213_1.time_ - var_216_12) / var_216_21

				arg_213_1.fswtw_.percent = Mathf.Lerp(arg_213_1.var_.oldValueTypewriter, var_216_17, var_216_22)
				arg_213_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_213_1.fswtw_:SetDirty()
			end

			if arg_213_1.time_ >= var_216_12 + var_216_21 and arg_213_1.time_ < var_216_12 + var_216_21 + arg_216_0 then
				arg_213_1.fswtw_.percent = var_216_17

				arg_213_1.fswtw_:SetDirty()
				arg_213_1:ShowNextGo(true)

				arg_213_1.typewritterCharCountI18N = var_216_18
			end

			local var_216_23 = 0

			if var_216_23 < arg_213_1.time_ and arg_213_1.time_ <= var_216_23 + arg_216_0 then
				local var_216_24 = manager.ui.mainCamera.transform.localPosition
				local var_216_25 = Vector3.New(0, 0, 10) + Vector3.New(var_216_24.x, var_216_24.y, 0)
				local var_216_26 = arg_213_1.bgs_.STblack

				var_216_26.transform.localPosition = var_216_25
				var_216_26.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_216_27 = var_216_26:GetComponent("SpriteRenderer")

				if var_216_27 and var_216_27.sprite then
					local var_216_28 = (var_216_26.transform.localPosition - var_216_24).z
					local var_216_29 = manager.ui.mainCameraCom_
					local var_216_30 = 2 * var_216_28 * Mathf.Tan(var_216_29.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_216_31 = var_216_30 * var_216_29.aspect
					local var_216_32 = var_216_27.sprite.bounds.size.x
					local var_216_33 = var_216_27.sprite.bounds.size.y
					local var_216_34 = var_216_31 / var_216_32
					local var_216_35 = var_216_30 / var_216_33
					local var_216_36 = var_216_35 < var_216_34 and var_216_34 or var_216_35

					var_216_26.transform.localScale = Vector3.New(var_216_36, var_216_36, 0)
				end

				for iter_216_0, iter_216_1 in pairs(arg_213_1.bgs_) do
					if iter_216_0 ~= "STblack" then
						iter_216_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_216_37 = 0

			if var_216_37 < arg_213_1.time_ and arg_213_1.time_ <= var_216_37 + arg_216_0 then
				arg_213_1.cswbg_:SetActive(true)

				local var_216_38 = arg_213_1.cswt_:GetComponent("RectTransform")

				arg_213_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_216_38.offsetMin = Vector2.New(410, 330)
				var_216_38.offsetMax = Vector2.New(-400, -175)

				local var_216_39 = arg_213_1:GetWordFromCfg(419073)
				local var_216_40 = arg_213_1:FormatText(var_216_39.content)

				arg_213_1.cswt_.text = var_216_40

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.cswt_)

				arg_213_1.cswt_.fontSize = 180
				arg_213_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_213_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_213_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play319891051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 319891051
		arg_217_1.duration_ = 3.7

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play319891052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.fswbg_:SetActive(true)
				arg_217_1.dialog_:SetActive(false)

				arg_217_1.fswtw_.percent = 0

				local var_220_1 = arg_217_1:GetWordFromCfg(319891051)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.fswt_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.fswt_)

				arg_217_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_217_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_217_1.fswtw_:SetDirty()

				arg_217_1.typewritterCharCountI18N = 0

				SetActive(arg_217_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_217_1:ShowNextGo(false)
			end

			local var_220_3 = 0.366666666666667

			if var_220_3 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.var_.oldValueTypewriter = arg_217_1.fswtw_.percent

				SetActive(arg_217_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_217_1:ShowNextGo(false)
			end

			local var_220_4 = 50
			local var_220_5 = 3.33333333333333
			local var_220_6 = arg_217_1:GetWordFromCfg(319891051)
			local var_220_7 = arg_217_1:FormatText(var_220_6.content)
			local var_220_8, var_220_9 = arg_217_1:GetPercentByPara(var_220_7, 1)

			if var_220_3 < arg_217_1.time_ and arg_217_1.time_ <= var_220_3 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				local var_220_10 = var_220_4 <= 0 and var_220_5 or var_220_5 * ((var_220_9 - arg_217_1.typewritterCharCountI18N) / var_220_4)

				if var_220_10 > 0 and var_220_5 < var_220_10 then
					arg_217_1.talkMaxDuration = var_220_10

					if var_220_10 + var_220_3 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_3
					end
				end
			end

			local var_220_11 = 3.33333333333333
			local var_220_12 = math.max(var_220_11, arg_217_1.talkMaxDuration)

			if var_220_3 <= arg_217_1.time_ and arg_217_1.time_ < var_220_3 + var_220_12 then
				local var_220_13 = (arg_217_1.time_ - var_220_3) / var_220_12

				arg_217_1.fswtw_.percent = Mathf.Lerp(arg_217_1.var_.oldValueTypewriter, var_220_8, var_220_13)
				arg_217_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_217_1.fswtw_:SetDirty()
			end

			if arg_217_1.time_ >= var_220_3 + var_220_12 and arg_217_1.time_ < var_220_3 + var_220_12 + arg_220_0 then
				arg_217_1.fswtw_.percent = var_220_8

				arg_217_1.fswtw_:SetDirty()
				arg_217_1:ShowNextGo(true)

				arg_217_1.typewritterCharCountI18N = var_220_9
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play319891052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 319891052
		arg_221_1.duration_ = 4.71

		local var_221_0 = {
			zh = 3.333333333332,
			ja = 4.70833333631357
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
				arg_221_0:Play319891053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				local var_224_1 = manager.ui.mainCamera.transform.localPosition
				local var_224_2 = Vector3.New(0, 0, 10) + Vector3.New(var_224_1.x, var_224_1.y, 0)
				local var_224_3 = arg_221_1.bgs_.ST15a

				var_224_3.transform.localPosition = var_224_2
				var_224_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_224_4 = var_224_3:GetComponent("SpriteRenderer")

				if var_224_4 and var_224_4.sprite then
					local var_224_5 = (var_224_3.transform.localPosition - var_224_1).z
					local var_224_6 = manager.ui.mainCameraCom_
					local var_224_7 = 2 * var_224_5 * Mathf.Tan(var_224_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_224_8 = var_224_7 * var_224_6.aspect
					local var_224_9 = var_224_4.sprite.bounds.size.x
					local var_224_10 = var_224_4.sprite.bounds.size.y
					local var_224_11 = var_224_8 / var_224_9
					local var_224_12 = var_224_7 / var_224_10
					local var_224_13 = var_224_12 < var_224_11 and var_224_11 or var_224_12

					var_224_3.transform.localScale = Vector3.New(var_224_13, var_224_13, 0)
				end

				for iter_224_0, iter_224_1 in pairs(arg_221_1.bgs_) do
					if iter_224_0 ~= "ST15a" then
						iter_224_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_224_14 = 0

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1.allBtn_.enabled = false
			end

			local var_224_15 = 0.3

			if arg_221_1.time_ >= var_224_14 + var_224_15 and arg_221_1.time_ < var_224_14 + var_224_15 + arg_224_0 then
				arg_221_1.allBtn_.enabled = true
			end

			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_17 = 1.33333333333333

			if var_224_16 <= arg_221_1.time_ and arg_221_1.time_ < var_224_16 + var_224_17 then
				local var_224_18 = (arg_221_1.time_ - var_224_16) / var_224_17
				local var_224_19 = Color.New(0, 0, 0)

				var_224_19.a = Mathf.Lerp(1, 0, var_224_18)
				arg_221_1.mask_.color = var_224_19
			end

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 then
				local var_224_20 = Color.New(0, 0, 0)
				local var_224_21 = 0

				arg_221_1.mask_.enabled = false
				var_224_20.a = var_224_21
				arg_221_1.mask_.color = var_224_20
			end

			local var_224_22 = arg_221_1.actors_["1084ui_story"].transform
			local var_224_23 = 1.33333333333333

			if var_224_23 < arg_221_1.time_ and arg_221_1.time_ <= var_224_23 + arg_224_0 then
				arg_221_1.var_.moveOldPos1084ui_story = var_224_22.localPosition
			end

			local var_224_24 = 0.001

			if var_224_23 <= arg_221_1.time_ and arg_221_1.time_ < var_224_23 + var_224_24 then
				local var_224_25 = (arg_221_1.time_ - var_224_23) / var_224_24
				local var_224_26 = Vector3.New(0, -0.97, -6)

				var_224_22.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1084ui_story, var_224_26, var_224_25)

				local var_224_27 = manager.ui.mainCamera.transform.position - var_224_22.position

				var_224_22.forward = Vector3.New(var_224_27.x, var_224_27.y, var_224_27.z)

				local var_224_28 = var_224_22.localEulerAngles

				var_224_28.z = 0
				var_224_28.x = 0
				var_224_22.localEulerAngles = var_224_28
			end

			if arg_221_1.time_ >= var_224_23 + var_224_24 and arg_221_1.time_ < var_224_23 + var_224_24 + arg_224_0 then
				var_224_22.localPosition = Vector3.New(0, -0.97, -6)

				local var_224_29 = manager.ui.mainCamera.transform.position - var_224_22.position

				var_224_22.forward = Vector3.New(var_224_29.x, var_224_29.y, var_224_29.z)

				local var_224_30 = var_224_22.localEulerAngles

				var_224_30.z = 0
				var_224_30.x = 0
				var_224_22.localEulerAngles = var_224_30
			end

			local var_224_31 = arg_221_1.actors_["1084ui_story"]
			local var_224_32 = 1.33333333333333

			if var_224_32 < arg_221_1.time_ and arg_221_1.time_ <= var_224_32 + arg_224_0 and not isNil(var_224_31) and arg_221_1.var_.characterEffect1084ui_story == nil then
				arg_221_1.var_.characterEffect1084ui_story = var_224_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_33 = 0.200000002980232

			if var_224_32 <= arg_221_1.time_ and arg_221_1.time_ < var_224_32 + var_224_33 and not isNil(var_224_31) then
				local var_224_34 = (arg_221_1.time_ - var_224_32) / var_224_33

				if arg_221_1.var_.characterEffect1084ui_story and not isNil(var_224_31) then
					arg_221_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_32 + var_224_33 and arg_221_1.time_ < var_224_32 + var_224_33 + arg_224_0 and not isNil(var_224_31) and arg_221_1.var_.characterEffect1084ui_story then
				arg_221_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_224_35 = 1.33333333333333

			if var_224_35 < arg_221_1.time_ and arg_221_1.time_ <= var_224_35 + arg_224_0 then
				arg_221_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_224_36 = 1.33333333333333

			if var_224_36 < arg_221_1.time_ and arg_221_1.time_ <= var_224_36 + arg_224_0 then
				arg_221_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_224_37 = 0

			if var_224_37 < arg_221_1.time_ and arg_221_1.time_ <= var_224_37 + arg_224_0 then
				arg_221_1.fswbg_:SetActive(false)
				arg_221_1.dialog_:SetActive(false)
				SetActive(arg_221_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_221_1:ShowNextGo(false)
			end

			local var_224_38 = 0.1

			if var_224_38 < arg_221_1.time_ and arg_221_1.time_ <= var_224_38 + arg_224_0 then
				arg_221_1.fswbg_:SetActive(false)
				arg_221_1.dialog_:SetActive(false)
				SetActive(arg_221_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_221_1:ShowNextGo(false)
			end

			local var_224_39 = 0

			if var_224_39 < arg_221_1.time_ and arg_221_1.time_ <= var_224_39 + arg_224_0 then
				arg_221_1.cswbg_:SetActive(false)
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_40 = 1.40833333631357
			local var_224_41 = 0.125

			if var_224_40 < arg_221_1.time_ and arg_221_1.time_ <= var_224_40 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_42 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_42:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_43 = arg_221_1:FormatText(StoryNameCfg[6].name)

				arg_221_1.leftNameTxt_.text = var_224_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_44 = arg_221_1:GetWordFromCfg(319891052)
				local var_224_45 = arg_221_1:FormatText(var_224_44.content)

				arg_221_1.text_.text = var_224_45

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_46 = 5
				local var_224_47 = utf8.len(var_224_45)
				local var_224_48 = var_224_46 <= 0 and var_224_41 or var_224_41 * (var_224_47 / var_224_46)

				if var_224_48 > 0 and var_224_41 < var_224_48 then
					arg_221_1.talkMaxDuration = var_224_48
					var_224_40 = var_224_40 + 0.3

					if var_224_48 + var_224_40 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_48 + var_224_40
					end
				end

				arg_221_1.text_.text = var_224_45
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891052", "story_v_out_319891.awb") ~= 0 then
					local var_224_49 = manager.audio:GetVoiceLength("story_v_out_319891", "319891052", "story_v_out_319891.awb") / 1000

					if var_224_49 + var_224_40 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_49 + var_224_40
					end

					if var_224_44.prefab_name ~= "" and arg_221_1.actors_[var_224_44.prefab_name] ~= nil then
						local var_224_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_44.prefab_name].transform, "story_v_out_319891", "319891052", "story_v_out_319891.awb")

						arg_221_1:RecordAudio("319891052", var_224_50)
						arg_221_1:RecordAudio("319891052", var_224_50)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_319891", "319891052", "story_v_out_319891.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_319891", "319891052", "story_v_out_319891.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_51 = var_224_40 + 0.3
			local var_224_52 = math.max(var_224_41, arg_221_1.talkMaxDuration)

			if var_224_51 <= arg_221_1.time_ and arg_221_1.time_ < var_224_51 + var_224_52 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_51) / var_224_52

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_51 + var_224_52 and arg_221_1.time_ < var_224_51 + var_224_52 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.33333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play319891053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 319891053
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play319891054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1084ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1084ui_story == nil then
				arg_227_1.var_.characterEffect1084ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect1084ui_story and not isNil(var_230_0) then
					local var_230_4 = Mathf.Lerp(0, 0.5, var_230_3)

					arg_227_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1084ui_story.fillRatio = var_230_4
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1084ui_story then
				local var_230_5 = 0.5

				arg_227_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1084ui_story.fillRatio = var_230_5
			end

			local var_230_6 = arg_227_1.actors_["1084ui_story"].transform
			local var_230_7 = 0

			if var_230_7 < arg_227_1.time_ and arg_227_1.time_ <= var_230_7 + arg_230_0 then
				arg_227_1.var_.moveOldPos1084ui_story = var_230_6.localPosition
			end

			local var_230_8 = 0.001

			if var_230_7 <= arg_227_1.time_ and arg_227_1.time_ < var_230_7 + var_230_8 then
				local var_230_9 = (arg_227_1.time_ - var_230_7) / var_230_8
				local var_230_10 = Vector3.New(0, 100, 0)

				var_230_6.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1084ui_story, var_230_10, var_230_9)

				local var_230_11 = manager.ui.mainCamera.transform.position - var_230_6.position

				var_230_6.forward = Vector3.New(var_230_11.x, var_230_11.y, var_230_11.z)

				local var_230_12 = var_230_6.localEulerAngles

				var_230_12.z = 0
				var_230_12.x = 0
				var_230_6.localEulerAngles = var_230_12
			end

			if arg_227_1.time_ >= var_230_7 + var_230_8 and arg_227_1.time_ < var_230_7 + var_230_8 + arg_230_0 then
				var_230_6.localPosition = Vector3.New(0, 100, 0)

				local var_230_13 = manager.ui.mainCamera.transform.position - var_230_6.position

				var_230_6.forward = Vector3.New(var_230_13.x, var_230_13.y, var_230_13.z)

				local var_230_14 = var_230_6.localEulerAngles

				var_230_14.z = 0
				var_230_14.x = 0
				var_230_6.localEulerAngles = var_230_14
			end

			local var_230_15 = 0
			local var_230_16 = 0.975

			if var_230_15 < arg_227_1.time_ and arg_227_1.time_ <= var_230_15 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_17 = arg_227_1:GetWordFromCfg(319891053)
				local var_230_18 = arg_227_1:FormatText(var_230_17.content)

				arg_227_1.text_.text = var_230_18

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_19 = 39
				local var_230_20 = utf8.len(var_230_18)
				local var_230_21 = var_230_19 <= 0 and var_230_16 or var_230_16 * (var_230_20 / var_230_19)

				if var_230_21 > 0 and var_230_16 < var_230_21 then
					arg_227_1.talkMaxDuration = var_230_21

					if var_230_21 + var_230_15 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_21 + var_230_15
					end
				end

				arg_227_1.text_.text = var_230_18
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_22 = math.max(var_230_16, arg_227_1.talkMaxDuration)

			if var_230_15 <= arg_227_1.time_ and arg_227_1.time_ < var_230_15 + var_230_22 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_15) / var_230_22

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_15 + var_230_22 and arg_227_1.time_ < var_230_15 + var_230_22 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play319891054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 319891054
		arg_231_1.duration_ = 6.9

		local var_231_0 = {
			zh = 4.966,
			ja = 6.9
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
				arg_231_0:Play319891055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0
			local var_234_1 = 1

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				local var_234_2 = "stop"
				local var_234_3 = "effect"

				arg_231_1:AudioAction(var_234_2, var_234_3, "se_story_130", "se_story_130_police", "")
			end

			local var_234_4 = arg_231_1.actors_["1084ui_story"].transform
			local var_234_5 = 0

			if var_234_5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.var_.moveOldPos1084ui_story = var_234_4.localPosition
			end

			local var_234_6 = 0.001

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_6 then
				local var_234_7 = (arg_231_1.time_ - var_234_5) / var_234_6
				local var_234_8 = Vector3.New(0, -0.97, -6)

				var_234_4.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1084ui_story, var_234_8, var_234_7)

				local var_234_9 = manager.ui.mainCamera.transform.position - var_234_4.position

				var_234_4.forward = Vector3.New(var_234_9.x, var_234_9.y, var_234_9.z)

				local var_234_10 = var_234_4.localEulerAngles

				var_234_10.z = 0
				var_234_10.x = 0
				var_234_4.localEulerAngles = var_234_10
			end

			if arg_231_1.time_ >= var_234_5 + var_234_6 and arg_231_1.time_ < var_234_5 + var_234_6 + arg_234_0 then
				var_234_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_234_11 = manager.ui.mainCamera.transform.position - var_234_4.position

				var_234_4.forward = Vector3.New(var_234_11.x, var_234_11.y, var_234_11.z)

				local var_234_12 = var_234_4.localEulerAngles

				var_234_12.z = 0
				var_234_12.x = 0
				var_234_4.localEulerAngles = var_234_12
			end

			local var_234_13 = arg_231_1.actors_["1084ui_story"]
			local var_234_14 = 0

			if var_234_14 < arg_231_1.time_ and arg_231_1.time_ <= var_234_14 + arg_234_0 and not isNil(var_234_13) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = var_234_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_15 = 0.200000002980232

			if var_234_14 <= arg_231_1.time_ and arg_231_1.time_ < var_234_14 + var_234_15 and not isNil(var_234_13) then
				local var_234_16 = (arg_231_1.time_ - var_234_14) / var_234_15

				if arg_231_1.var_.characterEffect1084ui_story and not isNil(var_234_13) then
					arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_14 + var_234_15 and arg_231_1.time_ < var_234_14 + var_234_15 + arg_234_0 and not isNil(var_234_13) and arg_231_1.var_.characterEffect1084ui_story then
				arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_234_17 = 0

			if var_234_17 < arg_231_1.time_ and arg_231_1.time_ <= var_234_17 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_234_18 = 0

			if var_234_18 < arg_231_1.time_ and arg_231_1.time_ <= var_234_18 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_19 = 0
			local var_234_20 = 0.5

			if var_234_19 < arg_231_1.time_ and arg_231_1.time_ <= var_234_19 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_21 = arg_231_1:FormatText(StoryNameCfg[6].name)

				arg_231_1.leftNameTxt_.text = var_234_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_22 = arg_231_1:GetWordFromCfg(319891054)
				local var_234_23 = arg_231_1:FormatText(var_234_22.content)

				arg_231_1.text_.text = var_234_23

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_24 = 20
				local var_234_25 = utf8.len(var_234_23)
				local var_234_26 = var_234_24 <= 0 and var_234_20 or var_234_20 * (var_234_25 / var_234_24)

				if var_234_26 > 0 and var_234_20 < var_234_26 then
					arg_231_1.talkMaxDuration = var_234_26

					if var_234_26 + var_234_19 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_26 + var_234_19
					end
				end

				arg_231_1.text_.text = var_234_23
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891054", "story_v_out_319891.awb") ~= 0 then
					local var_234_27 = manager.audio:GetVoiceLength("story_v_out_319891", "319891054", "story_v_out_319891.awb") / 1000

					if var_234_27 + var_234_19 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_27 + var_234_19
					end

					if var_234_22.prefab_name ~= "" and arg_231_1.actors_[var_234_22.prefab_name] ~= nil then
						local var_234_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_22.prefab_name].transform, "story_v_out_319891", "319891054", "story_v_out_319891.awb")

						arg_231_1:RecordAudio("319891054", var_234_28)
						arg_231_1:RecordAudio("319891054", var_234_28)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_319891", "319891054", "story_v_out_319891.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_319891", "319891054", "story_v_out_319891.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_29 = math.max(var_234_20, arg_231_1.talkMaxDuration)

			if var_234_19 <= arg_231_1.time_ and arg_231_1.time_ < var_234_19 + var_234_29 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_19) / var_234_29

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_19 + var_234_29 and arg_231_1.time_ < var_234_19 + var_234_29 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play319891055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 319891055
		arg_235_1.duration_ = 8.83

		local var_235_0 = {
			zh = 7.566,
			ja = 8.833
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play319891056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1084ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1084ui_story == nil then
				arg_235_1.var_.characterEffect1084ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1084ui_story and not isNil(var_238_0) then
					local var_238_4 = Mathf.Lerp(0, 0.5, var_238_3)

					arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1084ui_story.fillRatio = var_238_4
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1084ui_story then
				local var_238_5 = 0.5

				arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1084ui_story.fillRatio = var_238_5
			end

			local var_238_6 = 0
			local var_238_7 = 0.925

			if var_238_6 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_8 = arg_235_1:FormatText(StoryNameCfg[694].name)

				arg_235_1.leftNameTxt_.text = var_238_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_9 = arg_235_1:GetWordFromCfg(319891055)
				local var_238_10 = arg_235_1:FormatText(var_238_9.content)

				arg_235_1.text_.text = var_238_10

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 37
				local var_238_12 = utf8.len(var_238_10)
				local var_238_13 = var_238_11 <= 0 and var_238_7 or var_238_7 * (var_238_12 / var_238_11)

				if var_238_13 > 0 and var_238_7 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_10
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891055", "story_v_out_319891.awb") ~= 0 then
					local var_238_14 = manager.audio:GetVoiceLength("story_v_out_319891", "319891055", "story_v_out_319891.awb") / 1000

					if var_238_14 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_6
					end

					if var_238_9.prefab_name ~= "" and arg_235_1.actors_[var_238_9.prefab_name] ~= nil then
						local var_238_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_9.prefab_name].transform, "story_v_out_319891", "319891055", "story_v_out_319891.awb")

						arg_235_1:RecordAudio("319891055", var_238_15)
						arg_235_1:RecordAudio("319891055", var_238_15)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_319891", "319891055", "story_v_out_319891.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_319891", "319891055", "story_v_out_319891.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_16 and arg_235_1.time_ < var_238_6 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play319891056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 319891056
		arg_239_1.duration_ = 3.47

		local var_239_0 = {
			zh = 1.733,
			ja = 3.466
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play319891057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 0.25

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[694].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_3 = arg_239_1:GetWordFromCfg(319891056)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 10
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891056", "story_v_out_319891.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891056", "story_v_out_319891.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_319891", "319891056", "story_v_out_319891.awb")

						arg_239_1:RecordAudio("319891056", var_242_9)
						arg_239_1:RecordAudio("319891056", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_319891", "319891056", "story_v_out_319891.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_319891", "319891056", "story_v_out_319891.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play319891057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 319891057
		arg_243_1.duration_ = 5.9

		local var_243_0 = {
			zh = 1.999999999999,
			ja = 5.9
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play319891058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1084ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1084ui_story == nil then
				arg_243_1.var_.characterEffect1084ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect1084ui_story and not isNil(var_246_0) then
					arg_243_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1084ui_story then
				arg_243_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_246_4 = 0

			if var_246_4 < arg_243_1.time_ and arg_243_1.time_ <= var_246_4 + arg_246_0 then
				arg_243_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_246_5 = 0

			if var_246_5 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 then
				arg_243_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_246_6 = 0
			local var_246_7 = 0.275

			if var_246_6 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_8 = arg_243_1:FormatText(StoryNameCfg[6].name)

				arg_243_1.leftNameTxt_.text = var_246_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_9 = arg_243_1:GetWordFromCfg(319891057)
				local var_246_10 = arg_243_1:FormatText(var_246_9.content)

				arg_243_1.text_.text = var_246_10

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 11
				local var_246_12 = utf8.len(var_246_10)
				local var_246_13 = var_246_11 <= 0 and var_246_7 or var_246_7 * (var_246_12 / var_246_11)

				if var_246_13 > 0 and var_246_7 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_10
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891057", "story_v_out_319891.awb") ~= 0 then
					local var_246_14 = manager.audio:GetVoiceLength("story_v_out_319891", "319891057", "story_v_out_319891.awb") / 1000

					if var_246_14 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_14 + var_246_6
					end

					if var_246_9.prefab_name ~= "" and arg_243_1.actors_[var_246_9.prefab_name] ~= nil then
						local var_246_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_9.prefab_name].transform, "story_v_out_319891", "319891057", "story_v_out_319891.awb")

						arg_243_1:RecordAudio("319891057", var_246_15)
						arg_243_1:RecordAudio("319891057", var_246_15)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_319891", "319891057", "story_v_out_319891.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_319891", "319891057", "story_v_out_319891.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_16 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_16 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_16

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_16 and arg_243_1.time_ < var_246_6 + var_246_16 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play319891058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 319891058
		arg_247_1.duration_ = 8.6

		local var_247_0 = {
			zh = 5.633,
			ja = 8.6
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play319891059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1084ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1084ui_story == nil then
				arg_247_1.var_.characterEffect1084ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1084ui_story and not isNil(var_250_0) then
					local var_250_4 = Mathf.Lerp(0, 0.5, var_250_3)

					arg_247_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1084ui_story.fillRatio = var_250_4
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1084ui_story then
				local var_250_5 = 0.5

				arg_247_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1084ui_story.fillRatio = var_250_5
			end

			local var_250_6 = 0
			local var_250_7 = 0.55

			if var_250_6 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_8 = arg_247_1:FormatText(StoryNameCfg[694].name)

				arg_247_1.leftNameTxt_.text = var_250_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_9 = arg_247_1:GetWordFromCfg(319891058)
				local var_250_10 = arg_247_1:FormatText(var_250_9.content)

				arg_247_1.text_.text = var_250_10

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_11 = 22
				local var_250_12 = utf8.len(var_250_10)
				local var_250_13 = var_250_11 <= 0 and var_250_7 or var_250_7 * (var_250_12 / var_250_11)

				if var_250_13 > 0 and var_250_7 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_6
					end
				end

				arg_247_1.text_.text = var_250_10
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891058", "story_v_out_319891.awb") ~= 0 then
					local var_250_14 = manager.audio:GetVoiceLength("story_v_out_319891", "319891058", "story_v_out_319891.awb") / 1000

					if var_250_14 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_14 + var_250_6
					end

					if var_250_9.prefab_name ~= "" and arg_247_1.actors_[var_250_9.prefab_name] ~= nil then
						local var_250_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_9.prefab_name].transform, "story_v_out_319891", "319891058", "story_v_out_319891.awb")

						arg_247_1:RecordAudio("319891058", var_250_15)
						arg_247_1:RecordAudio("319891058", var_250_15)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_319891", "319891058", "story_v_out_319891.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_319891", "319891058", "story_v_out_319891.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_7, arg_247_1.talkMaxDuration)

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_6) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_6 + var_250_16 and arg_247_1.time_ < var_250_6 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play319891059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 319891059
		arg_251_1.duration_ = 8.8

		local var_251_0 = {
			zh = 5.433,
			ja = 8.8
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play319891060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0
			local var_254_1 = 0.65

			if var_254_0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_2 = arg_251_1:FormatText(StoryNameCfg[694].name)

				arg_251_1.leftNameTxt_.text = var_254_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_3 = arg_251_1:GetWordFromCfg(319891059)
				local var_254_4 = arg_251_1:FormatText(var_254_3.content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 26
				local var_254_6 = utf8.len(var_254_4)
				local var_254_7 = var_254_5 <= 0 and var_254_1 or var_254_1 * (var_254_6 / var_254_5)

				if var_254_7 > 0 and var_254_1 < var_254_7 then
					arg_251_1.talkMaxDuration = var_254_7

					if var_254_7 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_7 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891059", "story_v_out_319891.awb") ~= 0 then
					local var_254_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891059", "story_v_out_319891.awb") / 1000

					if var_254_8 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_0
					end

					if var_254_3.prefab_name ~= "" and arg_251_1.actors_[var_254_3.prefab_name] ~= nil then
						local var_254_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_3.prefab_name].transform, "story_v_out_319891", "319891059", "story_v_out_319891.awb")

						arg_251_1:RecordAudio("319891059", var_254_9)
						arg_251_1:RecordAudio("319891059", var_254_9)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_319891", "319891059", "story_v_out_319891.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_319891", "319891059", "story_v_out_319891.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_10 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_10 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_10

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_10 and arg_251_1.time_ < var_254_0 + var_254_10 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play319891060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 319891060
		arg_255_1.duration_ = 14.5

		local var_255_0 = {
			zh = 6.1,
			ja = 14.5
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play319891061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_258_1 = 0
			local var_258_2 = 0.8

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_3 = arg_255_1:FormatText(StoryNameCfg[694].name)

				arg_255_1.leftNameTxt_.text = var_258_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10091")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_4 = arg_255_1:GetWordFromCfg(319891060)
				local var_258_5 = arg_255_1:FormatText(var_258_4.content)

				arg_255_1.text_.text = var_258_5

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_6 = 32
				local var_258_7 = utf8.len(var_258_5)
				local var_258_8 = var_258_6 <= 0 and var_258_2 or var_258_2 * (var_258_7 / var_258_6)

				if var_258_8 > 0 and var_258_2 < var_258_8 then
					arg_255_1.talkMaxDuration = var_258_8

					if var_258_8 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_8 + var_258_1
					end
				end

				arg_255_1.text_.text = var_258_5
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891060", "story_v_out_319891.awb") ~= 0 then
					local var_258_9 = manager.audio:GetVoiceLength("story_v_out_319891", "319891060", "story_v_out_319891.awb") / 1000

					if var_258_9 + var_258_1 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_9 + var_258_1
					end

					if var_258_4.prefab_name ~= "" and arg_255_1.actors_[var_258_4.prefab_name] ~= nil then
						local var_258_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_4.prefab_name].transform, "story_v_out_319891", "319891060", "story_v_out_319891.awb")

						arg_255_1:RecordAudio("319891060", var_258_10)
						arg_255_1:RecordAudio("319891060", var_258_10)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_319891", "319891060", "story_v_out_319891.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_319891", "319891060", "story_v_out_319891.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_11 = math.max(var_258_2, arg_255_1.talkMaxDuration)

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_11 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_1) / var_258_11

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_1 + var_258_11 and arg_255_1.time_ < var_258_1 + var_258_11 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play319891061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 319891061
		arg_259_1.duration_ = 8.9

		local var_259_0 = {
			zh = 6.83366666851441,
			ja = 8.90066666851441
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play319891062(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = "ST74a"

			if arg_259_1.bgs_[var_262_0] == nil then
				local var_262_1 = Object.Instantiate(arg_259_1.paintGo_)

				var_262_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_262_0)
				var_262_1.name = var_262_0
				var_262_1.transform.parent = arg_259_1.stage_.transform
				var_262_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.bgs_[var_262_0] = var_262_1
			end

			local var_262_2 = 2

			if var_262_2 < arg_259_1.time_ and arg_259_1.time_ <= var_262_2 + arg_262_0 then
				local var_262_3 = manager.ui.mainCamera.transform.localPosition
				local var_262_4 = Vector3.New(0, 0, 10) + Vector3.New(var_262_3.x, var_262_3.y, 0)
				local var_262_5 = arg_259_1.bgs_.ST74a

				var_262_5.transform.localPosition = var_262_4
				var_262_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_262_6 = var_262_5:GetComponent("SpriteRenderer")

				if var_262_6 and var_262_6.sprite then
					local var_262_7 = (var_262_5.transform.localPosition - var_262_3).z
					local var_262_8 = manager.ui.mainCameraCom_
					local var_262_9 = 2 * var_262_7 * Mathf.Tan(var_262_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_262_10 = var_262_9 * var_262_8.aspect
					local var_262_11 = var_262_6.sprite.bounds.size.x
					local var_262_12 = var_262_6.sprite.bounds.size.y
					local var_262_13 = var_262_10 / var_262_11
					local var_262_14 = var_262_9 / var_262_12
					local var_262_15 = var_262_14 < var_262_13 and var_262_13 or var_262_14

					var_262_5.transform.localScale = Vector3.New(var_262_15, var_262_15, 0)
				end

				for iter_262_0, iter_262_1 in pairs(arg_259_1.bgs_) do
					if iter_262_0 ~= "ST74a" then
						iter_262_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_262_16 = 0

			if var_262_16 < arg_259_1.time_ and arg_259_1.time_ <= var_262_16 + arg_262_0 then
				arg_259_1.allBtn_.enabled = false
			end

			local var_262_17 = 0.3

			if arg_259_1.time_ >= var_262_16 + var_262_17 and arg_259_1.time_ < var_262_16 + var_262_17 + arg_262_0 then
				arg_259_1.allBtn_.enabled = true
			end

			local var_262_18 = 0

			if var_262_18 < arg_259_1.time_ and arg_259_1.time_ <= var_262_18 + arg_262_0 then
				arg_259_1.mask_.enabled = true
				arg_259_1.mask_.raycastTarget = true

				arg_259_1:SetGaussion(false)
			end

			local var_262_19 = 2

			if var_262_18 <= arg_259_1.time_ and arg_259_1.time_ < var_262_18 + var_262_19 then
				local var_262_20 = (arg_259_1.time_ - var_262_18) / var_262_19
				local var_262_21 = Color.New(0, 0, 0)

				var_262_21.a = Mathf.Lerp(0, 1, var_262_20)
				arg_259_1.mask_.color = var_262_21
			end

			if arg_259_1.time_ >= var_262_18 + var_262_19 and arg_259_1.time_ < var_262_18 + var_262_19 + arg_262_0 then
				local var_262_22 = Color.New(0, 0, 0)

				var_262_22.a = 1
				arg_259_1.mask_.color = var_262_22
			end

			local var_262_23 = 2

			if var_262_23 < arg_259_1.time_ and arg_259_1.time_ <= var_262_23 + arg_262_0 then
				arg_259_1.mask_.enabled = true
				arg_259_1.mask_.raycastTarget = true

				arg_259_1:SetGaussion(false)
			end

			local var_262_24 = 2

			if var_262_23 <= arg_259_1.time_ and arg_259_1.time_ < var_262_23 + var_262_24 then
				local var_262_25 = (arg_259_1.time_ - var_262_23) / var_262_24
				local var_262_26 = Color.New(0, 0, 0)

				var_262_26.a = Mathf.Lerp(1, 0, var_262_25)
				arg_259_1.mask_.color = var_262_26
			end

			if arg_259_1.time_ >= var_262_23 + var_262_24 and arg_259_1.time_ < var_262_23 + var_262_24 + arg_262_0 then
				local var_262_27 = Color.New(0, 0, 0)
				local var_262_28 = 0

				arg_259_1.mask_.enabled = false
				var_262_27.a = var_262_28
				arg_259_1.mask_.color = var_262_27
			end

			local var_262_29 = "4040ui_story"

			if arg_259_1.actors_[var_262_29] == nil then
				local var_262_30 = Asset.Load("Char/" .. "4040ui_story")

				if not isNil(var_262_30) then
					local var_262_31 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_259_1.stage_.transform)

					var_262_31.name = var_262_29
					var_262_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_259_1.actors_[var_262_29] = var_262_31

					local var_262_32 = var_262_31:GetComponentInChildren(typeof(CharacterEffect))

					var_262_32.enabled = true

					local var_262_33 = GameObjectTools.GetOrAddComponent(var_262_31, typeof(DynamicBoneHelper))

					if var_262_33 then
						var_262_33:EnableDynamicBone(false)
					end

					arg_259_1:ShowWeapon(var_262_32.transform, false)

					arg_259_1.var_[var_262_29 .. "Animator"] = var_262_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_259_1.var_[var_262_29 .. "Animator"].applyRootMotion = true
					arg_259_1.var_[var_262_29 .. "LipSync"] = var_262_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_262_34 = arg_259_1.actors_["4040ui_story"].transform
			local var_262_35 = 3.86666666666667

			if var_262_35 < arg_259_1.time_ and arg_259_1.time_ <= var_262_35 + arg_262_0 then
				arg_259_1.var_.moveOldPos4040ui_story = var_262_34.localPosition
			end

			local var_262_36 = 0.001

			if var_262_35 <= arg_259_1.time_ and arg_259_1.time_ < var_262_35 + var_262_36 then
				local var_262_37 = (arg_259_1.time_ - var_262_35) / var_262_36
				local var_262_38 = Vector3.New(0, -1.55, -5.5)

				var_262_34.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos4040ui_story, var_262_38, var_262_37)

				local var_262_39 = manager.ui.mainCamera.transform.position - var_262_34.position

				var_262_34.forward = Vector3.New(var_262_39.x, var_262_39.y, var_262_39.z)

				local var_262_40 = var_262_34.localEulerAngles

				var_262_40.z = 0
				var_262_40.x = 0
				var_262_34.localEulerAngles = var_262_40
			end

			if arg_259_1.time_ >= var_262_35 + var_262_36 and arg_259_1.time_ < var_262_35 + var_262_36 + arg_262_0 then
				var_262_34.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_262_41 = manager.ui.mainCamera.transform.position - var_262_34.position

				var_262_34.forward = Vector3.New(var_262_41.x, var_262_41.y, var_262_41.z)

				local var_262_42 = var_262_34.localEulerAngles

				var_262_42.z = 0
				var_262_42.x = 0
				var_262_34.localEulerAngles = var_262_42
			end

			local var_262_43 = arg_259_1.actors_["4040ui_story"]
			local var_262_44 = 3.86666666666667

			if var_262_44 < arg_259_1.time_ and arg_259_1.time_ <= var_262_44 + arg_262_0 and not isNil(var_262_43) and arg_259_1.var_.characterEffect4040ui_story == nil then
				arg_259_1.var_.characterEffect4040ui_story = var_262_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_45 = 0.200000002980232

			if var_262_44 <= arg_259_1.time_ and arg_259_1.time_ < var_262_44 + var_262_45 and not isNil(var_262_43) then
				local var_262_46 = (arg_259_1.time_ - var_262_44) / var_262_45

				if arg_259_1.var_.characterEffect4040ui_story and not isNil(var_262_43) then
					arg_259_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_44 + var_262_45 and arg_259_1.time_ < var_262_44 + var_262_45 + arg_262_0 and not isNil(var_262_43) and arg_259_1.var_.characterEffect4040ui_story then
				arg_259_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_262_47 = 3.86666666666667

			if var_262_47 < arg_259_1.time_ and arg_259_1.time_ <= var_262_47 + arg_262_0 then
				arg_259_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_262_48 = 3.86666666666667

			if var_262_48 < arg_259_1.time_ and arg_259_1.time_ <= var_262_48 + arg_262_0 then
				arg_259_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_49 = arg_259_1.actors_["1084ui_story"].transform
			local var_262_50 = 2

			if var_262_50 < arg_259_1.time_ and arg_259_1.time_ <= var_262_50 + arg_262_0 then
				arg_259_1.var_.moveOldPos1084ui_story = var_262_49.localPosition
			end

			local var_262_51 = 0.001

			if var_262_50 <= arg_259_1.time_ and arg_259_1.time_ < var_262_50 + var_262_51 then
				local var_262_52 = (arg_259_1.time_ - var_262_50) / var_262_51
				local var_262_53 = Vector3.New(0, 100, 0)

				var_262_49.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1084ui_story, var_262_53, var_262_52)

				local var_262_54 = manager.ui.mainCamera.transform.position - var_262_49.position

				var_262_49.forward = Vector3.New(var_262_54.x, var_262_54.y, var_262_54.z)

				local var_262_55 = var_262_49.localEulerAngles

				var_262_55.z = 0
				var_262_55.x = 0
				var_262_49.localEulerAngles = var_262_55
			end

			if arg_259_1.time_ >= var_262_50 + var_262_51 and arg_259_1.time_ < var_262_50 + var_262_51 + arg_262_0 then
				var_262_49.localPosition = Vector3.New(0, 100, 0)

				local var_262_56 = manager.ui.mainCamera.transform.position - var_262_49.position

				var_262_49.forward = Vector3.New(var_262_56.x, var_262_56.y, var_262_56.z)

				local var_262_57 = var_262_49.localEulerAngles

				var_262_57.z = 0
				var_262_57.x = 0
				var_262_49.localEulerAngles = var_262_57
			end

			local var_262_58 = 0
			local var_262_59 = 1

			if var_262_58 < arg_259_1.time_ and arg_259_1.time_ <= var_262_58 + arg_262_0 then
				local var_262_60 = "stop"
				local var_262_61 = "effect"

				arg_259_1:AudioAction(var_262_60, var_262_61, "se_story_130", "se_story_130_sea", "")
			end

			if arg_259_1.frameCnt_ <= 1 then
				arg_259_1.dialog_:SetActive(false)
			end

			local var_262_62 = 3.90066666851441
			local var_262_63 = 0.325

			if var_262_62 < arg_259_1.time_ and arg_259_1.time_ <= var_262_62 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0

				arg_259_1.dialog_:SetActive(true)

				arg_259_1.dialogCg_.alpha = 0

				local var_262_64 = LeanTween.value(arg_259_1.dialog_, 0, 1, 0.3)

				var_262_64:setOnUpdate(LuaHelper.FloatAction(function(arg_263_0)
					arg_259_1.dialogCg_.alpha = arg_263_0
				end))
				var_262_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_259_1.dialog_)
					var_262_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_259_1.duration_ = arg_259_1.duration_ + 0.3

				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_65 = arg_259_1:FormatText(StoryNameCfg[668].name)

				arg_259_1.leftNameTxt_.text = var_262_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_66 = arg_259_1:GetWordFromCfg(319891061)
				local var_262_67 = arg_259_1:FormatText(var_262_66.content)

				arg_259_1.text_.text = var_262_67

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_68 = 13
				local var_262_69 = utf8.len(var_262_67)
				local var_262_70 = var_262_68 <= 0 and var_262_63 or var_262_63 * (var_262_69 / var_262_68)

				if var_262_70 > 0 and var_262_63 < var_262_70 then
					arg_259_1.talkMaxDuration = var_262_70
					var_262_62 = var_262_62 + 0.3

					if var_262_70 + var_262_62 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_70 + var_262_62
					end
				end

				arg_259_1.text_.text = var_262_67
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891061", "story_v_out_319891.awb") ~= 0 then
					local var_262_71 = manager.audio:GetVoiceLength("story_v_out_319891", "319891061", "story_v_out_319891.awb") / 1000

					if var_262_71 + var_262_62 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_71 + var_262_62
					end

					if var_262_66.prefab_name ~= "" and arg_259_1.actors_[var_262_66.prefab_name] ~= nil then
						local var_262_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_66.prefab_name].transform, "story_v_out_319891", "319891061", "story_v_out_319891.awb")

						arg_259_1:RecordAudio("319891061", var_262_72)
						arg_259_1:RecordAudio("319891061", var_262_72)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_319891", "319891061", "story_v_out_319891.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_319891", "319891061", "story_v_out_319891.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_73 = var_262_62 + 0.3
			local var_262_74 = math.max(var_262_63, arg_259_1.talkMaxDuration)

			if var_262_73 <= arg_259_1.time_ and arg_259_1.time_ < var_262_73 + var_262_74 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_73) / var_262_74

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_73 + var_262_74 and arg_259_1.time_ < var_262_73 + var_262_74 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.86666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play319891062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 319891062
		arg_265_1.duration_ = 2

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play319891063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["4040ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect4040ui_story == nil then
				arg_265_1.var_.characterEffect4040ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect4040ui_story and not isNil(var_268_0) then
					local var_268_4 = Mathf.Lerp(0, 0.5, var_268_3)

					arg_265_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_265_1.var_.characterEffect4040ui_story.fillRatio = var_268_4
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect4040ui_story then
				local var_268_5 = 0.5

				arg_265_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_265_1.var_.characterEffect4040ui_story.fillRatio = var_268_5
			end

			local var_268_6 = arg_265_1.actors_["1084ui_story"].transform
			local var_268_7 = 0

			if var_268_7 < arg_265_1.time_ and arg_265_1.time_ <= var_268_7 + arg_268_0 then
				arg_265_1.var_.moveOldPos1084ui_story = var_268_6.localPosition
			end

			local var_268_8 = 0.001

			if var_268_7 <= arg_265_1.time_ and arg_265_1.time_ < var_268_7 + var_268_8 then
				local var_268_9 = (arg_265_1.time_ - var_268_7) / var_268_8
				local var_268_10 = Vector3.New(-0.7, -0.97, -6)

				var_268_6.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1084ui_story, var_268_10, var_268_9)

				local var_268_11 = manager.ui.mainCamera.transform.position - var_268_6.position

				var_268_6.forward = Vector3.New(var_268_11.x, var_268_11.y, var_268_11.z)

				local var_268_12 = var_268_6.localEulerAngles

				var_268_12.z = 0
				var_268_12.x = 0
				var_268_6.localEulerAngles = var_268_12
			end

			if arg_265_1.time_ >= var_268_7 + var_268_8 and arg_265_1.time_ < var_268_7 + var_268_8 + arg_268_0 then
				var_268_6.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_268_13 = manager.ui.mainCamera.transform.position - var_268_6.position

				var_268_6.forward = Vector3.New(var_268_13.x, var_268_13.y, var_268_13.z)

				local var_268_14 = var_268_6.localEulerAngles

				var_268_14.z = 0
				var_268_14.x = 0
				var_268_6.localEulerAngles = var_268_14
			end

			local var_268_15 = arg_265_1.actors_["4040ui_story"].transform
			local var_268_16 = 0

			if var_268_16 < arg_265_1.time_ and arg_265_1.time_ <= var_268_16 + arg_268_0 then
				arg_265_1.var_.moveOldPos4040ui_story = var_268_15.localPosition
			end

			local var_268_17 = 0.001

			if var_268_16 <= arg_265_1.time_ and arg_265_1.time_ < var_268_16 + var_268_17 then
				local var_268_18 = (arg_265_1.time_ - var_268_16) / var_268_17
				local var_268_19 = Vector3.New(0.7, -1.55, -5.5)

				var_268_15.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos4040ui_story, var_268_19, var_268_18)

				local var_268_20 = manager.ui.mainCamera.transform.position - var_268_15.position

				var_268_15.forward = Vector3.New(var_268_20.x, var_268_20.y, var_268_20.z)

				local var_268_21 = var_268_15.localEulerAngles

				var_268_21.z = 0
				var_268_21.x = 0
				var_268_15.localEulerAngles = var_268_21
			end

			if arg_265_1.time_ >= var_268_16 + var_268_17 and arg_265_1.time_ < var_268_16 + var_268_17 + arg_268_0 then
				var_268_15.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_268_22 = manager.ui.mainCamera.transform.position - var_268_15.position

				var_268_15.forward = Vector3.New(var_268_22.x, var_268_22.y, var_268_22.z)

				local var_268_23 = var_268_15.localEulerAngles

				var_268_23.z = 0
				var_268_23.x = 0
				var_268_15.localEulerAngles = var_268_23
			end

			local var_268_24 = 0

			if var_268_24 < arg_265_1.time_ and arg_265_1.time_ <= var_268_24 + arg_268_0 then
				arg_265_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_268_25 = arg_265_1.actors_["1084ui_story"]
			local var_268_26 = 0

			if var_268_26 < arg_265_1.time_ and arg_265_1.time_ <= var_268_26 + arg_268_0 and not isNil(var_268_25) and arg_265_1.var_.characterEffect1084ui_story == nil then
				arg_265_1.var_.characterEffect1084ui_story = var_268_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_27 = 0.200000002980232

			if var_268_26 <= arg_265_1.time_ and arg_265_1.time_ < var_268_26 + var_268_27 and not isNil(var_268_25) then
				local var_268_28 = (arg_265_1.time_ - var_268_26) / var_268_27

				if arg_265_1.var_.characterEffect1084ui_story and not isNil(var_268_25) then
					arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_26 + var_268_27 and arg_265_1.time_ < var_268_26 + var_268_27 + arg_268_0 and not isNil(var_268_25) and arg_265_1.var_.characterEffect1084ui_story then
				arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_268_29 = 0
			local var_268_30 = 0.05

			if var_268_29 < arg_265_1.time_ and arg_265_1.time_ <= var_268_29 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_31 = arg_265_1:FormatText(StoryNameCfg[6].name)

				arg_265_1.leftNameTxt_.text = var_268_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_32 = arg_265_1:GetWordFromCfg(319891062)
				local var_268_33 = arg_265_1:FormatText(var_268_32.content)

				arg_265_1.text_.text = var_268_33

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_34 = 2
				local var_268_35 = utf8.len(var_268_33)
				local var_268_36 = var_268_34 <= 0 and var_268_30 or var_268_30 * (var_268_35 / var_268_34)

				if var_268_36 > 0 and var_268_30 < var_268_36 then
					arg_265_1.talkMaxDuration = var_268_36

					if var_268_36 + var_268_29 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_36 + var_268_29
					end
				end

				arg_265_1.text_.text = var_268_33
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891062", "story_v_out_319891.awb") ~= 0 then
					local var_268_37 = manager.audio:GetVoiceLength("story_v_out_319891", "319891062", "story_v_out_319891.awb") / 1000

					if var_268_37 + var_268_29 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_37 + var_268_29
					end

					if var_268_32.prefab_name ~= "" and arg_265_1.actors_[var_268_32.prefab_name] ~= nil then
						local var_268_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_32.prefab_name].transform, "story_v_out_319891", "319891062", "story_v_out_319891.awb")

						arg_265_1:RecordAudio("319891062", var_268_38)
						arg_265_1:RecordAudio("319891062", var_268_38)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_319891", "319891062", "story_v_out_319891.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_319891", "319891062", "story_v_out_319891.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_39 = math.max(var_268_30, arg_265_1.talkMaxDuration)

			if var_268_29 <= arg_265_1.time_ and arg_265_1.time_ < var_268_29 + var_268_39 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_29) / var_268_39

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_29 + var_268_39 and arg_265_1.time_ < var_268_29 + var_268_39 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319891063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 319891063
		arg_269_1.duration_ = 5.27

		local var_269_0 = {
			zh = 4.6,
			ja = 5.266
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
				arg_269_0:Play319891064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["4040ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect4040ui_story == nil then
				arg_269_1.var_.characterEffect4040ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect4040ui_story and not isNil(var_272_0) then
					arg_269_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect4040ui_story then
				arg_269_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_272_4 = 0

			if var_272_4 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_272_5 = 0

			if var_272_5 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_272_6 = arg_269_1.actors_["1084ui_story"]
			local var_272_7 = 0

			if var_272_7 < arg_269_1.time_ and arg_269_1.time_ <= var_272_7 + arg_272_0 and not isNil(var_272_6) and arg_269_1.var_.characterEffect1084ui_story == nil then
				arg_269_1.var_.characterEffect1084ui_story = var_272_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_8 = 0.200000002980232

			if var_272_7 <= arg_269_1.time_ and arg_269_1.time_ < var_272_7 + var_272_8 and not isNil(var_272_6) then
				local var_272_9 = (arg_269_1.time_ - var_272_7) / var_272_8

				if arg_269_1.var_.characterEffect1084ui_story and not isNil(var_272_6) then
					local var_272_10 = Mathf.Lerp(0, 0.5, var_272_9)

					arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1084ui_story.fillRatio = var_272_10
				end
			end

			if arg_269_1.time_ >= var_272_7 + var_272_8 and arg_269_1.time_ < var_272_7 + var_272_8 + arg_272_0 and not isNil(var_272_6) and arg_269_1.var_.characterEffect1084ui_story then
				local var_272_11 = 0.5

				arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1084ui_story.fillRatio = var_272_11
			end

			local var_272_12 = 0
			local var_272_13 = 0.525

			if var_272_12 < arg_269_1.time_ and arg_269_1.time_ <= var_272_12 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_14 = arg_269_1:FormatText(StoryNameCfg[668].name)

				arg_269_1.leftNameTxt_.text = var_272_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_15 = arg_269_1:GetWordFromCfg(319891063)
				local var_272_16 = arg_269_1:FormatText(var_272_15.content)

				arg_269_1.text_.text = var_272_16

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_17 = 21
				local var_272_18 = utf8.len(var_272_16)
				local var_272_19 = var_272_17 <= 0 and var_272_13 or var_272_13 * (var_272_18 / var_272_17)

				if var_272_19 > 0 and var_272_13 < var_272_19 then
					arg_269_1.talkMaxDuration = var_272_19

					if var_272_19 + var_272_12 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_19 + var_272_12
					end
				end

				arg_269_1.text_.text = var_272_16
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891063", "story_v_out_319891.awb") ~= 0 then
					local var_272_20 = manager.audio:GetVoiceLength("story_v_out_319891", "319891063", "story_v_out_319891.awb") / 1000

					if var_272_20 + var_272_12 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_20 + var_272_12
					end

					if var_272_15.prefab_name ~= "" and arg_269_1.actors_[var_272_15.prefab_name] ~= nil then
						local var_272_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_15.prefab_name].transform, "story_v_out_319891", "319891063", "story_v_out_319891.awb")

						arg_269_1:RecordAudio("319891063", var_272_21)
						arg_269_1:RecordAudio("319891063", var_272_21)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_319891", "319891063", "story_v_out_319891.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_319891", "319891063", "story_v_out_319891.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_22 = math.max(var_272_13, arg_269_1.talkMaxDuration)

			if var_272_12 <= arg_269_1.time_ and arg_269_1.time_ < var_272_12 + var_272_22 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_12) / var_272_22

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_12 + var_272_22 and arg_269_1.time_ < var_272_12 + var_272_22 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play319891064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 319891064
		arg_273_1.duration_ = 5.47

		local var_273_0 = {
			zh = 2.1,
			ja = 5.466
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
				arg_273_0:Play319891065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["4040ui_story"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos4040ui_story = var_276_0.localPosition
			end

			local var_276_2 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2
				local var_276_4 = Vector3.New(0.7, -1.55, -5.5)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos4040ui_story, var_276_4, var_276_3)

				local var_276_5 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_5.x, var_276_5.y, var_276_5.z)

				local var_276_6 = var_276_0.localEulerAngles

				var_276_6.z = 0
				var_276_6.x = 0
				var_276_0.localEulerAngles = var_276_6
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0.7, -1.55, -5.5)

				local var_276_7 = manager.ui.mainCamera.transform.position - var_276_0.position

				var_276_0.forward = Vector3.New(var_276_7.x, var_276_7.y, var_276_7.z)

				local var_276_8 = var_276_0.localEulerAngles

				var_276_8.z = 0
				var_276_8.x = 0
				var_276_0.localEulerAngles = var_276_8
			end

			local var_276_9 = 0
			local var_276_10 = 0.25

			if var_276_9 < arg_273_1.time_ and arg_273_1.time_ <= var_276_9 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_11 = arg_273_1:FormatText(StoryNameCfg[668].name)

				arg_273_1.leftNameTxt_.text = var_276_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_12 = arg_273_1:GetWordFromCfg(319891064)
				local var_276_13 = arg_273_1:FormatText(var_276_12.content)

				arg_273_1.text_.text = var_276_13

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_14 = 10
				local var_276_15 = utf8.len(var_276_13)
				local var_276_16 = var_276_14 <= 0 and var_276_10 or var_276_10 * (var_276_15 / var_276_14)

				if var_276_16 > 0 and var_276_10 < var_276_16 then
					arg_273_1.talkMaxDuration = var_276_16

					if var_276_16 + var_276_9 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_16 + var_276_9
					end
				end

				arg_273_1.text_.text = var_276_13
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891064", "story_v_out_319891.awb") ~= 0 then
					local var_276_17 = manager.audio:GetVoiceLength("story_v_out_319891", "319891064", "story_v_out_319891.awb") / 1000

					if var_276_17 + var_276_9 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_17 + var_276_9
					end

					if var_276_12.prefab_name ~= "" and arg_273_1.actors_[var_276_12.prefab_name] ~= nil then
						local var_276_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_12.prefab_name].transform, "story_v_out_319891", "319891064", "story_v_out_319891.awb")

						arg_273_1:RecordAudio("319891064", var_276_18)
						arg_273_1:RecordAudio("319891064", var_276_18)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_319891", "319891064", "story_v_out_319891.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_319891", "319891064", "story_v_out_319891.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_19 = math.max(var_276_10, arg_273_1.talkMaxDuration)

			if var_276_9 <= arg_273_1.time_ and arg_273_1.time_ < var_276_9 + var_276_19 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_9) / var_276_19

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_9 + var_276_19 and arg_273_1.time_ < var_276_9 + var_276_19 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319891065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 319891065
		arg_277_1.duration_ = 2.97

		local var_277_0 = {
			zh = 1,
			ja = 2.966
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
				arg_277_0:Play319891066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["4040ui_story"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect4040ui_story == nil then
				arg_277_1.var_.characterEffect4040ui_story = var_280_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.characterEffect4040ui_story and not isNil(var_280_0) then
					local var_280_4 = Mathf.Lerp(0, 0.5, var_280_3)

					arg_277_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_277_1.var_.characterEffect4040ui_story.fillRatio = var_280_4
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect4040ui_story then
				local var_280_5 = 0.5

				arg_277_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_277_1.var_.characterEffect4040ui_story.fillRatio = var_280_5
			end

			local var_280_6 = arg_277_1.actors_["1084ui_story"]
			local var_280_7 = 0

			if var_280_7 < arg_277_1.time_ and arg_277_1.time_ <= var_280_7 + arg_280_0 and not isNil(var_280_6) and arg_277_1.var_.characterEffect1084ui_story == nil then
				arg_277_1.var_.characterEffect1084ui_story = var_280_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_8 = 0.200000002980232

			if var_280_7 <= arg_277_1.time_ and arg_277_1.time_ < var_280_7 + var_280_8 and not isNil(var_280_6) then
				local var_280_9 = (arg_277_1.time_ - var_280_7) / var_280_8

				if arg_277_1.var_.characterEffect1084ui_story and not isNil(var_280_6) then
					arg_277_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_7 + var_280_8 and arg_277_1.time_ < var_280_7 + var_280_8 + arg_280_0 and not isNil(var_280_6) and arg_277_1.var_.characterEffect1084ui_story then
				arg_277_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_280_10 = 0
			local var_280_11 = 0.075

			if var_280_10 < arg_277_1.time_ and arg_277_1.time_ <= var_280_10 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_12 = arg_277_1:FormatText(StoryNameCfg[6].name)

				arg_277_1.leftNameTxt_.text = var_280_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_13 = arg_277_1:GetWordFromCfg(319891065)
				local var_280_14 = arg_277_1:FormatText(var_280_13.content)

				arg_277_1.text_.text = var_280_14

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_15 = 3
				local var_280_16 = utf8.len(var_280_14)
				local var_280_17 = var_280_15 <= 0 and var_280_11 or var_280_11 * (var_280_16 / var_280_15)

				if var_280_17 > 0 and var_280_11 < var_280_17 then
					arg_277_1.talkMaxDuration = var_280_17

					if var_280_17 + var_280_10 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_17 + var_280_10
					end
				end

				arg_277_1.text_.text = var_280_14
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891065", "story_v_out_319891.awb") ~= 0 then
					local var_280_18 = manager.audio:GetVoiceLength("story_v_out_319891", "319891065", "story_v_out_319891.awb") / 1000

					if var_280_18 + var_280_10 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_18 + var_280_10
					end

					if var_280_13.prefab_name ~= "" and arg_277_1.actors_[var_280_13.prefab_name] ~= nil then
						local var_280_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_13.prefab_name].transform, "story_v_out_319891", "319891065", "story_v_out_319891.awb")

						arg_277_1:RecordAudio("319891065", var_280_19)
						arg_277_1:RecordAudio("319891065", var_280_19)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_319891", "319891065", "story_v_out_319891.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_319891", "319891065", "story_v_out_319891.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_20 = math.max(var_280_11, arg_277_1.talkMaxDuration)

			if var_280_10 <= arg_277_1.time_ and arg_277_1.time_ < var_280_10 + var_280_20 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_10) / var_280_20

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_10 + var_280_20 and arg_277_1.time_ < var_280_10 + var_280_20 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play319891066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 319891066
		arg_281_1.duration_ = 6

		local var_281_0 = {
			zh = 2.733,
			ja = 6
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
				arg_281_0:Play319891067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_284_2 = 0
			local var_284_3 = 0.325

			if var_284_2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_4 = arg_281_1:FormatText(StoryNameCfg[6].name)

				arg_281_1.leftNameTxt_.text = var_284_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_5 = arg_281_1:GetWordFromCfg(319891066)
				local var_284_6 = arg_281_1:FormatText(var_284_5.content)

				arg_281_1.text_.text = var_284_6

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 13
				local var_284_8 = utf8.len(var_284_6)
				local var_284_9 = var_284_7 <= 0 and var_284_3 or var_284_3 * (var_284_8 / var_284_7)

				if var_284_9 > 0 and var_284_3 < var_284_9 then
					arg_281_1.talkMaxDuration = var_284_9

					if var_284_9 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_9 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_6
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891066", "story_v_out_319891.awb") ~= 0 then
					local var_284_10 = manager.audio:GetVoiceLength("story_v_out_319891", "319891066", "story_v_out_319891.awb") / 1000

					if var_284_10 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_2
					end

					if var_284_5.prefab_name ~= "" and arg_281_1.actors_[var_284_5.prefab_name] ~= nil then
						local var_284_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_5.prefab_name].transform, "story_v_out_319891", "319891066", "story_v_out_319891.awb")

						arg_281_1:RecordAudio("319891066", var_284_11)
						arg_281_1:RecordAudio("319891066", var_284_11)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_319891", "319891066", "story_v_out_319891.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_319891", "319891066", "story_v_out_319891.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_12 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_12 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_12

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_12 and arg_281_1.time_ < var_284_2 + var_284_12 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play319891067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 319891067
		arg_285_1.duration_ = 1.57

		local var_285_0 = {
			zh = 1.566,
			ja = 0.999999999999
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
				arg_285_0:Play319891068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["4040ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect4040ui_story == nil then
				arg_285_1.var_.characterEffect4040ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 and not isNil(var_288_0) then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect4040ui_story and not isNil(var_288_0) then
					arg_285_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and not isNil(var_288_0) and arg_285_1.var_.characterEffect4040ui_story then
				arg_285_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_288_4 = arg_285_1.actors_["1084ui_story"]
			local var_288_5 = 0

			if var_288_5 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect1084ui_story == nil then
				arg_285_1.var_.characterEffect1084ui_story = var_288_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_6 = 0.200000002980232

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_6 and not isNil(var_288_4) then
				local var_288_7 = (arg_285_1.time_ - var_288_5) / var_288_6

				if arg_285_1.var_.characterEffect1084ui_story and not isNil(var_288_4) then
					local var_288_8 = Mathf.Lerp(0, 0.5, var_288_7)

					arg_285_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1084ui_story.fillRatio = var_288_8
				end
			end

			if arg_285_1.time_ >= var_288_5 + var_288_6 and arg_285_1.time_ < var_288_5 + var_288_6 + arg_288_0 and not isNil(var_288_4) and arg_285_1.var_.characterEffect1084ui_story then
				local var_288_9 = 0.5

				arg_285_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1084ui_story.fillRatio = var_288_9
			end

			local var_288_10 = 0
			local var_288_11 = 0.05

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_12 = arg_285_1:FormatText(StoryNameCfg[668].name)

				arg_285_1.leftNameTxt_.text = var_288_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_13 = arg_285_1:GetWordFromCfg(319891067)
				local var_288_14 = arg_285_1:FormatText(var_288_13.content)

				arg_285_1.text_.text = var_288_14

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_15 = 2
				local var_288_16 = utf8.len(var_288_14)
				local var_288_17 = var_288_15 <= 0 and var_288_11 or var_288_11 * (var_288_16 / var_288_15)

				if var_288_17 > 0 and var_288_11 < var_288_17 then
					arg_285_1.talkMaxDuration = var_288_17

					if var_288_17 + var_288_10 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_17 + var_288_10
					end
				end

				arg_285_1.text_.text = var_288_14
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891067", "story_v_out_319891.awb") ~= 0 then
					local var_288_18 = manager.audio:GetVoiceLength("story_v_out_319891", "319891067", "story_v_out_319891.awb") / 1000

					if var_288_18 + var_288_10 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_18 + var_288_10
					end

					if var_288_13.prefab_name ~= "" and arg_285_1.actors_[var_288_13.prefab_name] ~= nil then
						local var_288_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_13.prefab_name].transform, "story_v_out_319891", "319891067", "story_v_out_319891.awb")

						arg_285_1:RecordAudio("319891067", var_288_19)
						arg_285_1:RecordAudio("319891067", var_288_19)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_319891", "319891067", "story_v_out_319891.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_319891", "319891067", "story_v_out_319891.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_20 = math.max(var_288_11, arg_285_1.talkMaxDuration)

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_20 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_10) / var_288_20

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_10 + var_288_20 and arg_285_1.time_ < var_288_10 + var_288_20 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play319891068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 319891068
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play319891069(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = arg_289_1.actors_["1084ui_story"].transform
			local var_292_1 = 0

			if var_292_1 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.var_.moveOldPos1084ui_story = var_292_0.localPosition
			end

			local var_292_2 = 0.001

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_2 then
				local var_292_3 = (arg_289_1.time_ - var_292_1) / var_292_2
				local var_292_4 = Vector3.New(0, 100, 0)

				var_292_0.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1084ui_story, var_292_4, var_292_3)

				local var_292_5 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_5.x, var_292_5.y, var_292_5.z)

				local var_292_6 = var_292_0.localEulerAngles

				var_292_6.z = 0
				var_292_6.x = 0
				var_292_0.localEulerAngles = var_292_6
			end

			if arg_289_1.time_ >= var_292_1 + var_292_2 and arg_289_1.time_ < var_292_1 + var_292_2 + arg_292_0 then
				var_292_0.localPosition = Vector3.New(0, 100, 0)

				local var_292_7 = manager.ui.mainCamera.transform.position - var_292_0.position

				var_292_0.forward = Vector3.New(var_292_7.x, var_292_7.y, var_292_7.z)

				local var_292_8 = var_292_0.localEulerAngles

				var_292_8.z = 0
				var_292_8.x = 0
				var_292_0.localEulerAngles = var_292_8
			end

			local var_292_9 = arg_289_1.actors_["4040ui_story"].transform
			local var_292_10 = 0

			if var_292_10 < arg_289_1.time_ and arg_289_1.time_ <= var_292_10 + arg_292_0 then
				arg_289_1.var_.moveOldPos4040ui_story = var_292_9.localPosition
			end

			local var_292_11 = 0.001

			if var_292_10 <= arg_289_1.time_ and arg_289_1.time_ < var_292_10 + var_292_11 then
				local var_292_12 = (arg_289_1.time_ - var_292_10) / var_292_11
				local var_292_13 = Vector3.New(0, 100, 0)

				var_292_9.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos4040ui_story, var_292_13, var_292_12)

				local var_292_14 = manager.ui.mainCamera.transform.position - var_292_9.position

				var_292_9.forward = Vector3.New(var_292_14.x, var_292_14.y, var_292_14.z)

				local var_292_15 = var_292_9.localEulerAngles

				var_292_15.z = 0
				var_292_15.x = 0
				var_292_9.localEulerAngles = var_292_15
			end

			if arg_289_1.time_ >= var_292_10 + var_292_11 and arg_289_1.time_ < var_292_10 + var_292_11 + arg_292_0 then
				var_292_9.localPosition = Vector3.New(0, 100, 0)

				local var_292_16 = manager.ui.mainCamera.transform.position - var_292_9.position

				var_292_9.forward = Vector3.New(var_292_16.x, var_292_16.y, var_292_16.z)

				local var_292_17 = var_292_9.localEulerAngles

				var_292_17.z = 0
				var_292_17.x = 0
				var_292_9.localEulerAngles = var_292_17
			end

			local var_292_18 = 0
			local var_292_19 = 1.075

			if var_292_18 < arg_289_1.time_ and arg_289_1.time_ <= var_292_18 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_20 = arg_289_1:GetWordFromCfg(319891068)
				local var_292_21 = arg_289_1:FormatText(var_292_20.content)

				arg_289_1.text_.text = var_292_21

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_22 = 43
				local var_292_23 = utf8.len(var_292_21)
				local var_292_24 = var_292_22 <= 0 and var_292_19 or var_292_19 * (var_292_23 / var_292_22)

				if var_292_24 > 0 and var_292_19 < var_292_24 then
					arg_289_1.talkMaxDuration = var_292_24

					if var_292_24 + var_292_18 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_24 + var_292_18
					end
				end

				arg_289_1.text_.text = var_292_21
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_25 = math.max(var_292_19, arg_289_1.talkMaxDuration)

			if var_292_18 <= arg_289_1.time_ and arg_289_1.time_ < var_292_18 + var_292_25 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_18) / var_292_25

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_18 + var_292_25 and arg_289_1.time_ < var_292_18 + var_292_25 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play319891069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 319891069
		arg_293_1.duration_ = 2

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play319891070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = arg_293_1.actors_["1095ui_story"].transform
			local var_296_1 = 0

			if var_296_1 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.var_.moveOldPos1095ui_story = var_296_0.localPosition
			end

			local var_296_2 = 0.001

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_2 then
				local var_296_3 = (arg_293_1.time_ - var_296_1) / var_296_2
				local var_296_4 = Vector3.New(0, -0.98, -6.1)

				var_296_0.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1095ui_story, var_296_4, var_296_3)

				local var_296_5 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_5.x, var_296_5.y, var_296_5.z)

				local var_296_6 = var_296_0.localEulerAngles

				var_296_6.z = 0
				var_296_6.x = 0
				var_296_0.localEulerAngles = var_296_6
			end

			if arg_293_1.time_ >= var_296_1 + var_296_2 and arg_293_1.time_ < var_296_1 + var_296_2 + arg_296_0 then
				var_296_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_296_7 = manager.ui.mainCamera.transform.position - var_296_0.position

				var_296_0.forward = Vector3.New(var_296_7.x, var_296_7.y, var_296_7.z)

				local var_296_8 = var_296_0.localEulerAngles

				var_296_8.z = 0
				var_296_8.x = 0
				var_296_0.localEulerAngles = var_296_8
			end

			local var_296_9 = arg_293_1.actors_["1095ui_story"]
			local var_296_10 = 0

			if var_296_10 < arg_293_1.time_ and arg_293_1.time_ <= var_296_10 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect1095ui_story == nil then
				arg_293_1.var_.characterEffect1095ui_story = var_296_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_11 = 0.200000002980232

			if var_296_10 <= arg_293_1.time_ and arg_293_1.time_ < var_296_10 + var_296_11 and not isNil(var_296_9) then
				local var_296_12 = (arg_293_1.time_ - var_296_10) / var_296_11

				if arg_293_1.var_.characterEffect1095ui_story and not isNil(var_296_9) then
					arg_293_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= var_296_10 + var_296_11 and arg_293_1.time_ < var_296_10 + var_296_11 + arg_296_0 and not isNil(var_296_9) and arg_293_1.var_.characterEffect1095ui_story then
				arg_293_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_296_13 = 0

			if var_296_13 < arg_293_1.time_ and arg_293_1.time_ <= var_296_13 + arg_296_0 then
				arg_293_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			local var_296_14 = 0

			if var_296_14 < arg_293_1.time_ and arg_293_1.time_ <= var_296_14 + arg_296_0 then
				arg_293_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_296_15 = arg_293_1.actors_["1084ui_story"].transform
			local var_296_16 = 0

			if var_296_16 < arg_293_1.time_ and arg_293_1.time_ <= var_296_16 + arg_296_0 then
				arg_293_1.var_.moveOldPos1084ui_story = var_296_15.localPosition
			end

			local var_296_17 = 0.001

			if var_296_16 <= arg_293_1.time_ and arg_293_1.time_ < var_296_16 + var_296_17 then
				local var_296_18 = (arg_293_1.time_ - var_296_16) / var_296_17
				local var_296_19 = Vector3.New(0, 100, 0)

				var_296_15.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1084ui_story, var_296_19, var_296_18)

				local var_296_20 = manager.ui.mainCamera.transform.position - var_296_15.position

				var_296_15.forward = Vector3.New(var_296_20.x, var_296_20.y, var_296_20.z)

				local var_296_21 = var_296_15.localEulerAngles

				var_296_21.z = 0
				var_296_21.x = 0
				var_296_15.localEulerAngles = var_296_21
			end

			if arg_293_1.time_ >= var_296_16 + var_296_17 and arg_293_1.time_ < var_296_16 + var_296_17 + arg_296_0 then
				var_296_15.localPosition = Vector3.New(0, 100, 0)

				local var_296_22 = manager.ui.mainCamera.transform.position - var_296_15.position

				var_296_15.forward = Vector3.New(var_296_22.x, var_296_22.y, var_296_22.z)

				local var_296_23 = var_296_15.localEulerAngles

				var_296_23.z = 0
				var_296_23.x = 0
				var_296_15.localEulerAngles = var_296_23
			end

			local var_296_24 = arg_293_1.actors_["1084ui_story"]
			local var_296_25 = 0

			if var_296_25 < arg_293_1.time_ and arg_293_1.time_ <= var_296_25 + arg_296_0 and not isNil(var_296_24) and arg_293_1.var_.characterEffect1084ui_story == nil then
				arg_293_1.var_.characterEffect1084ui_story = var_296_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_26 = 0.200000002980232

			if var_296_25 <= arg_293_1.time_ and arg_293_1.time_ < var_296_25 + var_296_26 and not isNil(var_296_24) then
				local var_296_27 = (arg_293_1.time_ - var_296_25) / var_296_26

				if arg_293_1.var_.characterEffect1084ui_story and not isNil(var_296_24) then
					local var_296_28 = Mathf.Lerp(0, 0.5, var_296_27)

					arg_293_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1084ui_story.fillRatio = var_296_28
				end
			end

			if arg_293_1.time_ >= var_296_25 + var_296_26 and arg_293_1.time_ < var_296_25 + var_296_26 + arg_296_0 and not isNil(var_296_24) and arg_293_1.var_.characterEffect1084ui_story then
				local var_296_29 = 0.5

				arg_293_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1084ui_story.fillRatio = var_296_29
			end

			local var_296_30 = arg_293_1.actors_["4040ui_story"].transform
			local var_296_31 = 0

			if var_296_31 < arg_293_1.time_ and arg_293_1.time_ <= var_296_31 + arg_296_0 then
				arg_293_1.var_.moveOldPos4040ui_story = var_296_30.localPosition
			end

			local var_296_32 = 0.001

			if var_296_31 <= arg_293_1.time_ and arg_293_1.time_ < var_296_31 + var_296_32 then
				local var_296_33 = (arg_293_1.time_ - var_296_31) / var_296_32
				local var_296_34 = Vector3.New(0, 100, 0)

				var_296_30.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos4040ui_story, var_296_34, var_296_33)

				local var_296_35 = manager.ui.mainCamera.transform.position - var_296_30.position

				var_296_30.forward = Vector3.New(var_296_35.x, var_296_35.y, var_296_35.z)

				local var_296_36 = var_296_30.localEulerAngles

				var_296_36.z = 0
				var_296_36.x = 0
				var_296_30.localEulerAngles = var_296_36
			end

			if arg_293_1.time_ >= var_296_31 + var_296_32 and arg_293_1.time_ < var_296_31 + var_296_32 + arg_296_0 then
				var_296_30.localPosition = Vector3.New(0, 100, 0)

				local var_296_37 = manager.ui.mainCamera.transform.position - var_296_30.position

				var_296_30.forward = Vector3.New(var_296_37.x, var_296_37.y, var_296_37.z)

				local var_296_38 = var_296_30.localEulerAngles

				var_296_38.z = 0
				var_296_38.x = 0
				var_296_30.localEulerAngles = var_296_38
			end

			local var_296_39 = arg_293_1.actors_["4040ui_story"]
			local var_296_40 = 0

			if var_296_40 < arg_293_1.time_ and arg_293_1.time_ <= var_296_40 + arg_296_0 and not isNil(var_296_39) and arg_293_1.var_.characterEffect4040ui_story == nil then
				arg_293_1.var_.characterEffect4040ui_story = var_296_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_41 = 0.200000002980232

			if var_296_40 <= arg_293_1.time_ and arg_293_1.time_ < var_296_40 + var_296_41 and not isNil(var_296_39) then
				local var_296_42 = (arg_293_1.time_ - var_296_40) / var_296_41

				if arg_293_1.var_.characterEffect4040ui_story and not isNil(var_296_39) then
					local var_296_43 = Mathf.Lerp(0, 0.5, var_296_42)

					arg_293_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_293_1.var_.characterEffect4040ui_story.fillRatio = var_296_43
				end
			end

			if arg_293_1.time_ >= var_296_40 + var_296_41 and arg_293_1.time_ < var_296_40 + var_296_41 + arg_296_0 and not isNil(var_296_39) and arg_293_1.var_.characterEffect4040ui_story then
				local var_296_44 = 0.5

				arg_293_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_293_1.var_.characterEffect4040ui_story.fillRatio = var_296_44
			end

			local var_296_45 = 0
			local var_296_46 = 0.05

			if var_296_45 < arg_293_1.time_ and arg_293_1.time_ <= var_296_45 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_47 = arg_293_1:FormatText(StoryNameCfg[471].name)

				arg_293_1.leftNameTxt_.text = var_296_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_48 = arg_293_1:GetWordFromCfg(319891069)
				local var_296_49 = arg_293_1:FormatText(var_296_48.content)

				arg_293_1.text_.text = var_296_49

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_50 = 2
				local var_296_51 = utf8.len(var_296_49)
				local var_296_52 = var_296_50 <= 0 and var_296_46 or var_296_46 * (var_296_51 / var_296_50)

				if var_296_52 > 0 and var_296_46 < var_296_52 then
					arg_293_1.talkMaxDuration = var_296_52

					if var_296_52 + var_296_45 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_52 + var_296_45
					end
				end

				arg_293_1.text_.text = var_296_49
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891069", "story_v_out_319891.awb") ~= 0 then
					local var_296_53 = manager.audio:GetVoiceLength("story_v_out_319891", "319891069", "story_v_out_319891.awb") / 1000

					if var_296_53 + var_296_45 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_53 + var_296_45
					end

					if var_296_48.prefab_name ~= "" and arg_293_1.actors_[var_296_48.prefab_name] ~= nil then
						local var_296_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_48.prefab_name].transform, "story_v_out_319891", "319891069", "story_v_out_319891.awb")

						arg_293_1:RecordAudio("319891069", var_296_54)
						arg_293_1:RecordAudio("319891069", var_296_54)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_319891", "319891069", "story_v_out_319891.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_319891", "319891069", "story_v_out_319891.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_55 = math.max(var_296_46, arg_293_1.talkMaxDuration)

			if var_296_45 <= arg_293_1.time_ and arg_293_1.time_ < var_296_45 + var_296_55 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_45) / var_296_55

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_45 + var_296_55 and arg_293_1.time_ < var_296_45 + var_296_55 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play319891070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 319891070
		arg_297_1.duration_ = 8.23

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play319891071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = "D02a"

			if arg_297_1.bgs_[var_300_0] == nil then
				local var_300_1 = Object.Instantiate(arg_297_1.paintGo_)

				var_300_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_300_0)
				var_300_1.name = var_300_0
				var_300_1.transform.parent = arg_297_1.stage_.transform
				var_300_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.bgs_[var_300_0] = var_300_1
			end

			local var_300_2 = 1.23333333333333

			if var_300_2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				local var_300_3 = manager.ui.mainCamera.transform.localPosition
				local var_300_4 = Vector3.New(0, 0, 10) + Vector3.New(var_300_3.x, var_300_3.y, 0)
				local var_300_5 = arg_297_1.bgs_.D02a

				var_300_5.transform.localPosition = var_300_4
				var_300_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_300_6 = var_300_5:GetComponent("SpriteRenderer")

				if var_300_6 and var_300_6.sprite then
					local var_300_7 = (var_300_5.transform.localPosition - var_300_3).z
					local var_300_8 = manager.ui.mainCameraCom_
					local var_300_9 = 2 * var_300_7 * Mathf.Tan(var_300_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_300_10 = var_300_9 * var_300_8.aspect
					local var_300_11 = var_300_6.sprite.bounds.size.x
					local var_300_12 = var_300_6.sprite.bounds.size.y
					local var_300_13 = var_300_10 / var_300_11
					local var_300_14 = var_300_9 / var_300_12
					local var_300_15 = var_300_14 < var_300_13 and var_300_13 or var_300_14

					var_300_5.transform.localScale = Vector3.New(var_300_15, var_300_15, 0)
				end

				for iter_300_0, iter_300_1 in pairs(arg_297_1.bgs_) do
					if iter_300_0 ~= "D02a" then
						iter_300_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_300_16 = 0

			if var_300_16 < arg_297_1.time_ and arg_297_1.time_ <= var_300_16 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_17 = 1.23333333333333

			if var_300_16 <= arg_297_1.time_ and arg_297_1.time_ < var_300_16 + var_300_17 then
				local var_300_18 = (arg_297_1.time_ - var_300_16) / var_300_17
				local var_300_19 = Color.New(0, 0, 0)

				var_300_19.a = Mathf.Lerp(0, 1, var_300_18)
				arg_297_1.mask_.color = var_300_19
			end

			if arg_297_1.time_ >= var_300_16 + var_300_17 and arg_297_1.time_ < var_300_16 + var_300_17 + arg_300_0 then
				local var_300_20 = Color.New(0, 0, 0)

				var_300_20.a = 1
				arg_297_1.mask_.color = var_300_20
			end

			local var_300_21 = 1.23333333333333

			if var_300_21 < arg_297_1.time_ and arg_297_1.time_ <= var_300_21 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_22 = 2

			if var_300_21 <= arg_297_1.time_ and arg_297_1.time_ < var_300_21 + var_300_22 then
				local var_300_23 = (arg_297_1.time_ - var_300_21) / var_300_22
				local var_300_24 = Color.New(0, 0, 0)

				var_300_24.a = Mathf.Lerp(1, 0, var_300_23)
				arg_297_1.mask_.color = var_300_24
			end

			if arg_297_1.time_ >= var_300_21 + var_300_22 and arg_297_1.time_ < var_300_21 + var_300_22 + arg_300_0 then
				local var_300_25 = Color.New(0, 0, 0)
				local var_300_26 = 0

				arg_297_1.mask_.enabled = false
				var_300_25.a = var_300_26
				arg_297_1.mask_.color = var_300_25
			end

			local var_300_27 = arg_297_1.actors_["1095ui_story"].transform
			local var_300_28 = 1.23333333333333

			if var_300_28 < arg_297_1.time_ and arg_297_1.time_ <= var_300_28 + arg_300_0 then
				arg_297_1.var_.moveOldPos1095ui_story = var_300_27.localPosition
			end

			local var_300_29 = 0.001

			if var_300_28 <= arg_297_1.time_ and arg_297_1.time_ < var_300_28 + var_300_29 then
				local var_300_30 = (arg_297_1.time_ - var_300_28) / var_300_29
				local var_300_31 = Vector3.New(0, 100, 0)

				var_300_27.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1095ui_story, var_300_31, var_300_30)

				local var_300_32 = manager.ui.mainCamera.transform.position - var_300_27.position

				var_300_27.forward = Vector3.New(var_300_32.x, var_300_32.y, var_300_32.z)

				local var_300_33 = var_300_27.localEulerAngles

				var_300_33.z = 0
				var_300_33.x = 0
				var_300_27.localEulerAngles = var_300_33
			end

			if arg_297_1.time_ >= var_300_28 + var_300_29 and arg_297_1.time_ < var_300_28 + var_300_29 + arg_300_0 then
				var_300_27.localPosition = Vector3.New(0, 100, 0)

				local var_300_34 = manager.ui.mainCamera.transform.position - var_300_27.position

				var_300_27.forward = Vector3.New(var_300_34.x, var_300_34.y, var_300_34.z)

				local var_300_35 = var_300_27.localEulerAngles

				var_300_35.z = 0
				var_300_35.x = 0
				var_300_27.localEulerAngles = var_300_35
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_36 = 3.23333333333333
			local var_300_37 = 0.875

			if var_300_36 < arg_297_1.time_ and arg_297_1.time_ <= var_300_36 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_38 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_38:setOnUpdate(LuaHelper.FloatAction(function(arg_301_0)
					arg_297_1.dialogCg_.alpha = arg_301_0
				end))
				var_300_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_39 = arg_297_1:GetWordFromCfg(319891070)
				local var_300_40 = arg_297_1:FormatText(var_300_39.content)

				arg_297_1.text_.text = var_300_40

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_41 = 35
				local var_300_42 = utf8.len(var_300_40)
				local var_300_43 = var_300_41 <= 0 and var_300_37 or var_300_37 * (var_300_42 / var_300_41)

				if var_300_43 > 0 and var_300_37 < var_300_43 then
					arg_297_1.talkMaxDuration = var_300_43
					var_300_36 = var_300_36 + 0.3

					if var_300_43 + var_300_36 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_43 + var_300_36
					end
				end

				arg_297_1.text_.text = var_300_40
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_44 = var_300_36 + 0.3
			local var_300_45 = math.max(var_300_37, arg_297_1.talkMaxDuration)

			if var_300_44 <= arg_297_1.time_ and arg_297_1.time_ < var_300_44 + var_300_45 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_44) / var_300_45

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_44 + var_300_45 and arg_297_1.time_ < var_300_44 + var_300_45 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.23333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play319891071 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 319891071
		arg_303_1.duration_ = 3.23

		local var_303_0 = {
			zh = 2.366,
			ja = 3.233
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play319891072(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1084ui_story"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos1084ui_story = var_306_0.localPosition
			end

			local var_306_2 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2
				local var_306_4 = Vector3.New(0, -0.97, -6)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1084ui_story, var_306_4, var_306_3)

				local var_306_5 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_5.x, var_306_5.y, var_306_5.z)

				local var_306_6 = var_306_0.localEulerAngles

				var_306_6.z = 0
				var_306_6.x = 0
				var_306_0.localEulerAngles = var_306_6
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_306_7 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_7.x, var_306_7.y, var_306_7.z)

				local var_306_8 = var_306_0.localEulerAngles

				var_306_8.z = 0
				var_306_8.x = 0
				var_306_0.localEulerAngles = var_306_8
			end

			local var_306_9 = arg_303_1.actors_["1084ui_story"]
			local var_306_10 = 0

			if var_306_10 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect1084ui_story == nil then
				arg_303_1.var_.characterEffect1084ui_story = var_306_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_11 = 0.200000002980232

			if var_306_10 <= arg_303_1.time_ and arg_303_1.time_ < var_306_10 + var_306_11 and not isNil(var_306_9) then
				local var_306_12 = (arg_303_1.time_ - var_306_10) / var_306_11

				if arg_303_1.var_.characterEffect1084ui_story and not isNil(var_306_9) then
					arg_303_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_10 + var_306_11 and arg_303_1.time_ < var_306_10 + var_306_11 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect1084ui_story then
				arg_303_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_306_13 = 0

			if var_306_13 < arg_303_1.time_ and arg_303_1.time_ <= var_306_13 + arg_306_0 then
				arg_303_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_306_14 = 0

			if var_306_14 < arg_303_1.time_ and arg_303_1.time_ <= var_306_14 + arg_306_0 then
				arg_303_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_306_15 = 0
			local var_306_16 = 0.35

			if var_306_15 < arg_303_1.time_ and arg_303_1.time_ <= var_306_15 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_17 = arg_303_1:FormatText(StoryNameCfg[6].name)

				arg_303_1.leftNameTxt_.text = var_306_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_18 = arg_303_1:GetWordFromCfg(319891071)
				local var_306_19 = arg_303_1:FormatText(var_306_18.content)

				arg_303_1.text_.text = var_306_19

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_20 = 14
				local var_306_21 = utf8.len(var_306_19)
				local var_306_22 = var_306_20 <= 0 and var_306_16 or var_306_16 * (var_306_21 / var_306_20)

				if var_306_22 > 0 and var_306_16 < var_306_22 then
					arg_303_1.talkMaxDuration = var_306_22

					if var_306_22 + var_306_15 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_22 + var_306_15
					end
				end

				arg_303_1.text_.text = var_306_19
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891071", "story_v_out_319891.awb") ~= 0 then
					local var_306_23 = manager.audio:GetVoiceLength("story_v_out_319891", "319891071", "story_v_out_319891.awb") / 1000

					if var_306_23 + var_306_15 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_23 + var_306_15
					end

					if var_306_18.prefab_name ~= "" and arg_303_1.actors_[var_306_18.prefab_name] ~= nil then
						local var_306_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_18.prefab_name].transform, "story_v_out_319891", "319891071", "story_v_out_319891.awb")

						arg_303_1:RecordAudio("319891071", var_306_24)
						arg_303_1:RecordAudio("319891071", var_306_24)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_319891", "319891071", "story_v_out_319891.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_319891", "319891071", "story_v_out_319891.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_25 = math.max(var_306_16, arg_303_1.talkMaxDuration)

			if var_306_15 <= arg_303_1.time_ and arg_303_1.time_ < var_306_15 + var_306_25 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_15) / var_306_25

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_15 + var_306_25 and arg_303_1.time_ < var_306_15 + var_306_25 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play319891072 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 319891072
		arg_307_1.duration_ = 3.3

		local var_307_0 = {
			zh = 1.7,
			ja = 3.3
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play319891073(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 0.225

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_2 = arg_307_1:FormatText(StoryNameCfg[6].name)

				arg_307_1.leftNameTxt_.text = var_310_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_3 = arg_307_1:GetWordFromCfg(319891072)
				local var_310_4 = arg_307_1:FormatText(var_310_3.content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 9
				local var_310_6 = utf8.len(var_310_4)
				local var_310_7 = var_310_5 <= 0 and var_310_1 or var_310_1 * (var_310_6 / var_310_5)

				if var_310_7 > 0 and var_310_1 < var_310_7 then
					arg_307_1.talkMaxDuration = var_310_7

					if var_310_7 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_7 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_4
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891072", "story_v_out_319891.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891072", "story_v_out_319891.awb") / 1000

					if var_310_8 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_0
					end

					if var_310_3.prefab_name ~= "" and arg_307_1.actors_[var_310_3.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_3.prefab_name].transform, "story_v_out_319891", "319891072", "story_v_out_319891.awb")

						arg_307_1:RecordAudio("319891072", var_310_9)
						arg_307_1:RecordAudio("319891072", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_319891", "319891072", "story_v_out_319891.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_319891", "319891072", "story_v_out_319891.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_10 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_10 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_10

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_10 and arg_307_1.time_ < var_310_0 + var_310_10 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play319891073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 319891073
		arg_311_1.duration_ = 5.6

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play319891074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1084ui_story"].transform
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.var_.moveOldPos1084ui_story = var_314_0.localPosition
			end

			local var_314_2 = 0.001

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2
				local var_314_4 = Vector3.New(0, 100, 0)

				var_314_0.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1084ui_story, var_314_4, var_314_3)

				local var_314_5 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_5.x, var_314_5.y, var_314_5.z)

				local var_314_6 = var_314_0.localEulerAngles

				var_314_6.z = 0
				var_314_6.x = 0
				var_314_0.localEulerAngles = var_314_6
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 then
				var_314_0.localPosition = Vector3.New(0, 100, 0)

				local var_314_7 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_7.x, var_314_7.y, var_314_7.z)

				local var_314_8 = var_314_0.localEulerAngles

				var_314_8.z = 0
				var_314_8.x = 0
				var_314_0.localEulerAngles = var_314_8
			end

			local var_314_9 = arg_311_1.actors_["1084ui_story"]
			local var_314_10 = 0

			if var_314_10 < arg_311_1.time_ and arg_311_1.time_ <= var_314_10 + arg_314_0 and not isNil(var_314_9) and arg_311_1.var_.characterEffect1084ui_story == nil then
				arg_311_1.var_.characterEffect1084ui_story = var_314_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_11 = 0.200000002980232

			if var_314_10 <= arg_311_1.time_ and arg_311_1.time_ < var_314_10 + var_314_11 and not isNil(var_314_9) then
				local var_314_12 = (arg_311_1.time_ - var_314_10) / var_314_11

				if arg_311_1.var_.characterEffect1084ui_story and not isNil(var_314_9) then
					arg_311_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_10 + var_314_11 and arg_311_1.time_ < var_314_10 + var_314_11 + arg_314_0 and not isNil(var_314_9) and arg_311_1.var_.characterEffect1084ui_story then
				arg_311_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if arg_311_1.frameCnt_ <= 1 then
				arg_311_1.dialog_:SetActive(false)
			end

			local var_314_13 = 0.6
			local var_314_14 = 0.5

			if var_314_13 < arg_311_1.time_ and arg_311_1.time_ <= var_314_13 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0

				arg_311_1.dialog_:SetActive(true)

				arg_311_1.dialogCg_.alpha = 0

				local var_314_15 = LeanTween.value(arg_311_1.dialog_, 0, 1, 0.3)

				var_314_15:setOnUpdate(LuaHelper.FloatAction(function(arg_315_0)
					arg_311_1.dialogCg_.alpha = arg_315_0
				end))
				var_314_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_311_1.dialog_)
					var_314_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_311_1.duration_ = arg_311_1.duration_ + 0.3

				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_16 = arg_311_1:GetWordFromCfg(319891073)
				local var_314_17 = arg_311_1:FormatText(var_314_16.content)

				arg_311_1.text_.text = var_314_17

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_18 = 20
				local var_314_19 = utf8.len(var_314_17)
				local var_314_20 = var_314_18 <= 0 and var_314_14 or var_314_14 * (var_314_19 / var_314_18)

				if var_314_20 > 0 and var_314_14 < var_314_20 then
					arg_311_1.talkMaxDuration = var_314_20
					var_314_13 = var_314_13 + 0.3

					if var_314_20 + var_314_13 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_20 + var_314_13
					end
				end

				arg_311_1.text_.text = var_314_17
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_21 = var_314_13 + 0.3
			local var_314_22 = math.max(var_314_14, arg_311_1.talkMaxDuration)

			if var_314_21 <= arg_311_1.time_ and arg_311_1.time_ < var_314_21 + var_314_22 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_21) / var_314_22

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_21 + var_314_22 and arg_311_1.time_ < var_314_21 + var_314_22 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play319891074 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 319891074
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play319891075(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 1.35

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_2 = arg_317_1:GetWordFromCfg(319891074)
				local var_320_3 = arg_317_1:FormatText(var_320_2.content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_4 = 54
				local var_320_5 = utf8.len(var_320_3)
				local var_320_6 = var_320_4 <= 0 and var_320_1 or var_320_1 * (var_320_5 / var_320_4)

				if var_320_6 > 0 and var_320_1 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_7 and arg_317_1.time_ < var_320_0 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play319891075 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 319891075
		arg_321_1.duration_ = 5.07

		local var_321_0 = {
			zh = 3.633,
			ja = 5.066
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
				arg_321_0:Play319891076(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1084ui_story"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos1084ui_story = var_324_0.localPosition

				local var_324_2 = "1084ui_story"

				arg_321_1:ShowWeapon(arg_321_1.var_[var_324_2 .. "Animator"].transform, true)
			end

			local var_324_3 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_3 then
				local var_324_4 = (arg_321_1.time_ - var_324_1) / var_324_3
				local var_324_5 = Vector3.New(0, -0.97, -6)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1084ui_story, var_324_5, var_324_4)

				local var_324_6 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_6.x, var_324_6.y, var_324_6.z)

				local var_324_7 = var_324_0.localEulerAngles

				var_324_7.z = 0
				var_324_7.x = 0
				var_324_0.localEulerAngles = var_324_7
			end

			if arg_321_1.time_ >= var_324_1 + var_324_3 and arg_321_1.time_ < var_324_1 + var_324_3 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_324_8 = manager.ui.mainCamera.transform.position - var_324_0.position

				var_324_0.forward = Vector3.New(var_324_8.x, var_324_8.y, var_324_8.z)

				local var_324_9 = var_324_0.localEulerAngles

				var_324_9.z = 0
				var_324_9.x = 0
				var_324_0.localEulerAngles = var_324_9
			end

			local var_324_10 = arg_321_1.actors_["1084ui_story"]
			local var_324_11 = 0

			if var_324_11 < arg_321_1.time_ and arg_321_1.time_ <= var_324_11 + arg_324_0 and not isNil(var_324_10) and arg_321_1.var_.characterEffect1084ui_story == nil then
				arg_321_1.var_.characterEffect1084ui_story = var_324_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_12 = 0.200000002980232

			if var_324_11 <= arg_321_1.time_ and arg_321_1.time_ < var_324_11 + var_324_12 and not isNil(var_324_10) then
				local var_324_13 = (arg_321_1.time_ - var_324_11) / var_324_12

				if arg_321_1.var_.characterEffect1084ui_story and not isNil(var_324_10) then
					arg_321_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= var_324_11 + var_324_12 and arg_321_1.time_ < var_324_11 + var_324_12 + arg_324_0 and not isNil(var_324_10) and arg_321_1.var_.characterEffect1084ui_story then
				arg_321_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_324_14 = 0

			if var_324_14 < arg_321_1.time_ and arg_321_1.time_ <= var_324_14 + arg_324_0 then
				arg_321_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_324_15 = 0

			if var_324_15 < arg_321_1.time_ and arg_321_1.time_ <= var_324_15 + arg_324_0 then
				arg_321_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if arg_321_1.frameCnt_ <= 1 then
				arg_321_1.dialog_:SetActive(false)
			end

			local var_324_16 = 0.9
			local var_324_17 = 0.25

			if var_324_16 < arg_321_1.time_ and arg_321_1.time_ <= var_324_16 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				arg_321_1.dialog_:SetActive(true)

				arg_321_1.dialogCg_.alpha = 0

				local var_324_18 = LeanTween.value(arg_321_1.dialog_, 0, 1, 0.3)

				var_324_18:setOnUpdate(LuaHelper.FloatAction(function(arg_325_0)
					arg_321_1.dialogCg_.alpha = arg_325_0
				end))
				var_324_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_321_1.dialog_)
					var_324_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_321_1.duration_ = arg_321_1.duration_ + 0.3

				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_19 = arg_321_1:FormatText(StoryNameCfg[6].name)

				arg_321_1.leftNameTxt_.text = var_324_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_20 = arg_321_1:GetWordFromCfg(319891075)
				local var_324_21 = arg_321_1:FormatText(var_324_20.content)

				arg_321_1.text_.text = var_324_21

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_22 = 10
				local var_324_23 = utf8.len(var_324_21)
				local var_324_24 = var_324_22 <= 0 and var_324_17 or var_324_17 * (var_324_23 / var_324_22)

				if var_324_24 > 0 and var_324_17 < var_324_24 then
					arg_321_1.talkMaxDuration = var_324_24
					var_324_16 = var_324_16 + 0.3

					if var_324_24 + var_324_16 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_24 + var_324_16
					end
				end

				arg_321_1.text_.text = var_324_21
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891075", "story_v_out_319891.awb") ~= 0 then
					local var_324_25 = manager.audio:GetVoiceLength("story_v_out_319891", "319891075", "story_v_out_319891.awb") / 1000

					if var_324_25 + var_324_16 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_25 + var_324_16
					end

					if var_324_20.prefab_name ~= "" and arg_321_1.actors_[var_324_20.prefab_name] ~= nil then
						local var_324_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_20.prefab_name].transform, "story_v_out_319891", "319891075", "story_v_out_319891.awb")

						arg_321_1:RecordAudio("319891075", var_324_26)
						arg_321_1:RecordAudio("319891075", var_324_26)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_319891", "319891075", "story_v_out_319891.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_319891", "319891075", "story_v_out_319891.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_27 = var_324_16 + 0.3
			local var_324_28 = math.max(var_324_17, arg_321_1.talkMaxDuration)

			if var_324_27 <= arg_321_1.time_ and arg_321_1.time_ < var_324_27 + var_324_28 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_27) / var_324_28

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_27 + var_324_28 and arg_321_1.time_ < var_324_27 + var_324_28 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play319891076 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 319891076
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play319891077(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1084ui_story"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1084ui_story == nil then
				arg_327_1.var_.characterEffect1084ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.characterEffect1084ui_story and not isNil(var_330_0) then
					local var_330_4 = Mathf.Lerp(0, 0.5, var_330_3)

					arg_327_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1084ui_story.fillRatio = var_330_4
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect1084ui_story then
				local var_330_5 = 0.5

				arg_327_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1084ui_story.fillRatio = var_330_5
			end

			local var_330_6 = 0
			local var_330_7 = 1.125

			if var_330_6 < arg_327_1.time_ and arg_327_1.time_ <= var_330_6 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_8 = arg_327_1:GetWordFromCfg(319891076)
				local var_330_9 = arg_327_1:FormatText(var_330_8.content)

				arg_327_1.text_.text = var_330_9

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_10 = 45
				local var_330_11 = utf8.len(var_330_9)
				local var_330_12 = var_330_10 <= 0 and var_330_7 or var_330_7 * (var_330_11 / var_330_10)

				if var_330_12 > 0 and var_330_7 < var_330_12 then
					arg_327_1.talkMaxDuration = var_330_12

					if var_330_12 + var_330_6 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_12 + var_330_6
					end
				end

				arg_327_1.text_.text = var_330_9
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_13 = math.max(var_330_7, arg_327_1.talkMaxDuration)

			if var_330_6 <= arg_327_1.time_ and arg_327_1.time_ < var_330_6 + var_330_13 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_6) / var_330_13

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_6 + var_330_13 and arg_327_1.time_ < var_330_6 + var_330_13 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play319891077 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 319891077
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play319891078(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1084ui_story"].transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.var_.moveOldPos1084ui_story = var_334_0.localPosition

				local var_334_2 = "1084ui_story"

				arg_331_1:ShowWeapon(arg_331_1.var_[var_334_2 .. "Animator"].transform, true)
			end

			local var_334_3 = 0.001

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_3 then
				local var_334_4 = (arg_331_1.time_ - var_334_1) / var_334_3
				local var_334_5 = Vector3.New(0, 100, 0)

				var_334_0.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1084ui_story, var_334_5, var_334_4)

				local var_334_6 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_6.x, var_334_6.y, var_334_6.z)

				local var_334_7 = var_334_0.localEulerAngles

				var_334_7.z = 0
				var_334_7.x = 0
				var_334_0.localEulerAngles = var_334_7
			end

			if arg_331_1.time_ >= var_334_1 + var_334_3 and arg_331_1.time_ < var_334_1 + var_334_3 + arg_334_0 then
				var_334_0.localPosition = Vector3.New(0, 100, 0)

				local var_334_8 = manager.ui.mainCamera.transform.position - var_334_0.position

				var_334_0.forward = Vector3.New(var_334_8.x, var_334_8.y, var_334_8.z)

				local var_334_9 = var_334_0.localEulerAngles

				var_334_9.z = 0
				var_334_9.x = 0
				var_334_0.localEulerAngles = var_334_9
			end

			local var_334_10 = 0
			local var_334_11 = 1.625

			if var_334_10 < arg_331_1.time_ and arg_331_1.time_ <= var_334_10 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_12 = arg_331_1:GetWordFromCfg(319891077)
				local var_334_13 = arg_331_1:FormatText(var_334_12.content)

				arg_331_1.text_.text = var_334_13

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_14 = 65
				local var_334_15 = utf8.len(var_334_13)
				local var_334_16 = var_334_14 <= 0 and var_334_11 or var_334_11 * (var_334_15 / var_334_14)

				if var_334_16 > 0 and var_334_11 < var_334_16 then
					arg_331_1.talkMaxDuration = var_334_16

					if var_334_16 + var_334_10 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_16 + var_334_10
					end
				end

				arg_331_1.text_.text = var_334_13
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_17 = math.max(var_334_11, arg_331_1.talkMaxDuration)

			if var_334_10 <= arg_331_1.time_ and arg_331_1.time_ < var_334_10 + var_334_17 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_10) / var_334_17

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_10 + var_334_17 and arg_331_1.time_ < var_334_10 + var_334_17 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play319891078 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 319891078
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play319891079(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 0.975

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_2 = arg_335_1:GetWordFromCfg(319891078)
				local var_338_3 = arg_335_1:FormatText(var_338_2.content)

				arg_335_1.text_.text = var_338_3

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_4 = 39
				local var_338_5 = utf8.len(var_338_3)
				local var_338_6 = var_338_4 <= 0 and var_338_1 or var_338_1 * (var_338_5 / var_338_4)

				if var_338_6 > 0 and var_338_1 < var_338_6 then
					arg_335_1.talkMaxDuration = var_338_6

					if var_338_6 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_6 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_3
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_7 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_7 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_7

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_7 and arg_335_1.time_ < var_338_0 + var_338_7 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play319891079 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 319891079
		arg_339_1.duration_ = 3.4

		local var_339_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play319891080(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1084ui_story"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos1084ui_story = var_342_0.localPosition
			end

			local var_342_2 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2
				local var_342_4 = Vector3.New(0, -0.97, -6)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1084ui_story, var_342_4, var_342_3)

				local var_342_5 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_5.x, var_342_5.y, var_342_5.z)

				local var_342_6 = var_342_0.localEulerAngles

				var_342_6.z = 0
				var_342_6.x = 0
				var_342_0.localEulerAngles = var_342_6
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_342_7 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_7.x, var_342_7.y, var_342_7.z)

				local var_342_8 = var_342_0.localEulerAngles

				var_342_8.z = 0
				var_342_8.x = 0
				var_342_0.localEulerAngles = var_342_8
			end

			local var_342_9 = arg_339_1.actors_["1084ui_story"]
			local var_342_10 = 0

			if var_342_10 < arg_339_1.time_ and arg_339_1.time_ <= var_342_10 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1084ui_story == nil then
				arg_339_1.var_.characterEffect1084ui_story = var_342_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_11 = 0.200000002980232

			if var_342_10 <= arg_339_1.time_ and arg_339_1.time_ < var_342_10 + var_342_11 and not isNil(var_342_9) then
				local var_342_12 = (arg_339_1.time_ - var_342_10) / var_342_11

				if arg_339_1.var_.characterEffect1084ui_story and not isNil(var_342_9) then
					arg_339_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_10 + var_342_11 and arg_339_1.time_ < var_342_10 + var_342_11 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1084ui_story then
				arg_339_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_342_13 = 0

			if var_342_13 < arg_339_1.time_ and arg_339_1.time_ <= var_342_13 + arg_342_0 then
				arg_339_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_342_14 = 0
			local var_342_15 = 0.125

			if var_342_14 < arg_339_1.time_ and arg_339_1.time_ <= var_342_14 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_16 = arg_339_1:FormatText(StoryNameCfg[6].name)

				arg_339_1.leftNameTxt_.text = var_342_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_17 = arg_339_1:GetWordFromCfg(319891079)
				local var_342_18 = arg_339_1:FormatText(var_342_17.content)

				arg_339_1.text_.text = var_342_18

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_19 = 5
				local var_342_20 = utf8.len(var_342_18)
				local var_342_21 = var_342_19 <= 0 and var_342_15 or var_342_15 * (var_342_20 / var_342_19)

				if var_342_21 > 0 and var_342_15 < var_342_21 then
					arg_339_1.talkMaxDuration = var_342_21

					if var_342_21 + var_342_14 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_21 + var_342_14
					end
				end

				arg_339_1.text_.text = var_342_18
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891079", "story_v_out_319891.awb") ~= 0 then
					local var_342_22 = manager.audio:GetVoiceLength("story_v_out_319891", "319891079", "story_v_out_319891.awb") / 1000

					if var_342_22 + var_342_14 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_22 + var_342_14
					end

					if var_342_17.prefab_name ~= "" and arg_339_1.actors_[var_342_17.prefab_name] ~= nil then
						local var_342_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_17.prefab_name].transform, "story_v_out_319891", "319891079", "story_v_out_319891.awb")

						arg_339_1:RecordAudio("319891079", var_342_23)
						arg_339_1:RecordAudio("319891079", var_342_23)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_319891", "319891079", "story_v_out_319891.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_319891", "319891079", "story_v_out_319891.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_24 = math.max(var_342_15, arg_339_1.talkMaxDuration)

			if var_342_14 <= arg_339_1.time_ and arg_339_1.time_ < var_342_14 + var_342_24 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_14) / var_342_24

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_14 + var_342_24 and arg_339_1.time_ < var_342_14 + var_342_24 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play319891080 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 319891080
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play319891081(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["1084ui_story"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1084ui_story == nil then
				arg_343_1.var_.characterEffect1084ui_story = var_346_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.200000002980232

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.characterEffect1084ui_story and not isNil(var_346_0) then
					local var_346_4 = Mathf.Lerp(0, 0.5, var_346_3)

					arg_343_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1084ui_story.fillRatio = var_346_4
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.characterEffect1084ui_story then
				local var_346_5 = 0.5

				arg_343_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1084ui_story.fillRatio = var_346_5
			end

			local var_346_6 = 0
			local var_346_7 = 0.85

			if var_346_6 < arg_343_1.time_ and arg_343_1.time_ <= var_346_6 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_8 = arg_343_1:GetWordFromCfg(319891080)
				local var_346_9 = arg_343_1:FormatText(var_346_8.content)

				arg_343_1.text_.text = var_346_9

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_10 = 34
				local var_346_11 = utf8.len(var_346_9)
				local var_346_12 = var_346_10 <= 0 and var_346_7 or var_346_7 * (var_346_11 / var_346_10)

				if var_346_12 > 0 and var_346_7 < var_346_12 then
					arg_343_1.talkMaxDuration = var_346_12

					if var_346_12 + var_346_6 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_12 + var_346_6
					end
				end

				arg_343_1.text_.text = var_346_9
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_13 = math.max(var_346_7, arg_343_1.talkMaxDuration)

			if var_346_6 <= arg_343_1.time_ and arg_343_1.time_ < var_346_6 + var_346_13 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_6) / var_346_13

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_6 + var_346_13 and arg_343_1.time_ < var_346_6 + var_346_13 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play319891081 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 319891081
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play319891082(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1084ui_story"].transform
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.var_.moveOldPos1084ui_story = var_350_0.localPosition
			end

			local var_350_2 = 0.001

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2
				local var_350_4 = Vector3.New(0, 100, 0)

				var_350_0.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1084ui_story, var_350_4, var_350_3)

				local var_350_5 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_5.x, var_350_5.y, var_350_5.z)

				local var_350_6 = var_350_0.localEulerAngles

				var_350_6.z = 0
				var_350_6.x = 0
				var_350_0.localEulerAngles = var_350_6
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 then
				var_350_0.localPosition = Vector3.New(0, 100, 0)

				local var_350_7 = manager.ui.mainCamera.transform.position - var_350_0.position

				var_350_0.forward = Vector3.New(var_350_7.x, var_350_7.y, var_350_7.z)

				local var_350_8 = var_350_0.localEulerAngles

				var_350_8.z = 0
				var_350_8.x = 0
				var_350_0.localEulerAngles = var_350_8
			end

			local var_350_9 = 0
			local var_350_10 = 1.175

			if var_350_9 < arg_347_1.time_ and arg_347_1.time_ <= var_350_9 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_11 = arg_347_1:GetWordFromCfg(319891081)
				local var_350_12 = arg_347_1:FormatText(var_350_11.content)

				arg_347_1.text_.text = var_350_12

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_13 = 47
				local var_350_14 = utf8.len(var_350_12)
				local var_350_15 = var_350_13 <= 0 and var_350_10 or var_350_10 * (var_350_14 / var_350_13)

				if var_350_15 > 0 and var_350_10 < var_350_15 then
					arg_347_1.talkMaxDuration = var_350_15

					if var_350_15 + var_350_9 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_15 + var_350_9
					end
				end

				arg_347_1.text_.text = var_350_12
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_16 = math.max(var_350_10, arg_347_1.talkMaxDuration)

			if var_350_9 <= arg_347_1.time_ and arg_347_1.time_ < var_350_9 + var_350_16 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_9) / var_350_16

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_9 + var_350_16 and arg_347_1.time_ < var_350_9 + var_350_16 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play319891082 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 319891082
		arg_351_1.duration_ = 5.53

		local var_351_0 = {
			zh = 3.066666663685,
			ja = 5.53266666666667
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play319891083(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1084ui_story"].transform
			local var_354_1 = 1.06666666368643

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 then
				arg_351_1.var_.moveOldPos1084ui_story = var_354_0.localPosition
			end

			local var_354_2 = 0.001

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2
				local var_354_4 = Vector3.New(0, -0.97, -6)

				var_354_0.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1084ui_story, var_354_4, var_354_3)

				local var_354_5 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_5.x, var_354_5.y, var_354_5.z)

				local var_354_6 = var_354_0.localEulerAngles

				var_354_6.z = 0
				var_354_6.x = 0
				var_354_0.localEulerAngles = var_354_6
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 then
				var_354_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_354_7 = manager.ui.mainCamera.transform.position - var_354_0.position

				var_354_0.forward = Vector3.New(var_354_7.x, var_354_7.y, var_354_7.z)

				local var_354_8 = var_354_0.localEulerAngles

				var_354_8.z = 0
				var_354_8.x = 0
				var_354_0.localEulerAngles = var_354_8
			end

			local var_354_9 = arg_351_1.actors_["1084ui_story"]
			local var_354_10 = 1.06666666368643

			if var_354_10 < arg_351_1.time_ and arg_351_1.time_ <= var_354_10 + arg_354_0 and not isNil(var_354_9) and arg_351_1.var_.characterEffect1084ui_story == nil then
				arg_351_1.var_.characterEffect1084ui_story = var_354_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_11 = 0.200000002980232

			if var_354_10 <= arg_351_1.time_ and arg_351_1.time_ < var_354_10 + var_354_11 and not isNil(var_354_9) then
				local var_354_12 = (arg_351_1.time_ - var_354_10) / var_354_11

				if arg_351_1.var_.characterEffect1084ui_story and not isNil(var_354_9) then
					arg_351_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_10 + var_354_11 and arg_351_1.time_ < var_354_10 + var_354_11 + arg_354_0 and not isNil(var_354_9) and arg_351_1.var_.characterEffect1084ui_story then
				arg_351_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_354_13 = manager.ui.mainCamera.transform
			local var_354_14 = 0

			if var_354_14 < arg_351_1.time_ and arg_351_1.time_ <= var_354_14 + arg_354_0 then
				local var_354_15 = arg_351_1.var_.effect1616
				local var_354_16
				local var_354_17 = var_354_13

				if not var_354_15 then
					var_354_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_354_17)
					var_354_15.name = "1616"
					arg_351_1.var_.effect1616 = var_354_15
				else
					var_354_15.transform:SetParent(var_354_17)
				end

				var_354_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_354_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_354_18 = 1.06666666368643

			if var_354_18 < arg_351_1.time_ and arg_351_1.time_ <= var_354_18 + arg_354_0 then
				arg_351_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if arg_351_1.frameCnt_ <= 1 then
				arg_351_1.dialog_:SetActive(false)
			end

			local var_354_19 = 1.26666666666667
			local var_354_20 = 0.2

			if var_354_19 < arg_351_1.time_ and arg_351_1.time_ <= var_354_19 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0

				arg_351_1.dialog_:SetActive(true)

				arg_351_1.dialogCg_.alpha = 0

				local var_354_21 = LeanTween.value(arg_351_1.dialog_, 0, 1, 0.3)

				var_354_21:setOnUpdate(LuaHelper.FloatAction(function(arg_355_0)
					arg_351_1.dialogCg_.alpha = arg_355_0
				end))
				var_354_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_351_1.dialog_)
					var_354_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_351_1.duration_ = arg_351_1.duration_ + 0.3

				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_22 = arg_351_1:FormatText(StoryNameCfg[6].name)

				arg_351_1.leftNameTxt_.text = var_354_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_23 = arg_351_1:GetWordFromCfg(319891082)
				local var_354_24 = arg_351_1:FormatText(var_354_23.content)

				arg_351_1.text_.text = var_354_24

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_25 = 8
				local var_354_26 = utf8.len(var_354_24)
				local var_354_27 = var_354_25 <= 0 and var_354_20 or var_354_20 * (var_354_26 / var_354_25)

				if var_354_27 > 0 and var_354_20 < var_354_27 then
					arg_351_1.talkMaxDuration = var_354_27
					var_354_19 = var_354_19 + 0.3

					if var_354_27 + var_354_19 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_27 + var_354_19
					end
				end

				arg_351_1.text_.text = var_354_24
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891082", "story_v_out_319891.awb") ~= 0 then
					local var_354_28 = manager.audio:GetVoiceLength("story_v_out_319891", "319891082", "story_v_out_319891.awb") / 1000

					if var_354_28 + var_354_19 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_28 + var_354_19
					end

					if var_354_23.prefab_name ~= "" and arg_351_1.actors_[var_354_23.prefab_name] ~= nil then
						local var_354_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_23.prefab_name].transform, "story_v_out_319891", "319891082", "story_v_out_319891.awb")

						arg_351_1:RecordAudio("319891082", var_354_29)
						arg_351_1:RecordAudio("319891082", var_354_29)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_319891", "319891082", "story_v_out_319891.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_319891", "319891082", "story_v_out_319891.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_30 = var_354_19 + 0.3
			local var_354_31 = math.max(var_354_20, arg_351_1.talkMaxDuration)

			if var_354_30 <= arg_351_1.time_ and arg_351_1.time_ < var_354_30 + var_354_31 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_30) / var_354_31

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_30 + var_354_31 and arg_351_1.time_ < var_354_30 + var_354_31 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.06666666368643,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play319891083 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 319891083
		arg_357_1.duration_ = 2.3

		local var_357_0 = {
			zh = 1.6,
			ja = 2.3
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play319891084(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0
			local var_360_1 = 0.175

			if var_360_0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				local var_360_2 = arg_357_1:FormatText(StoryNameCfg[6].name)

				arg_357_1.leftNameTxt_.text = var_360_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_3 = arg_357_1:GetWordFromCfg(319891083)
				local var_360_4 = arg_357_1:FormatText(var_360_3.content)

				arg_357_1.text_.text = var_360_4

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_5 = 7
				local var_360_6 = utf8.len(var_360_4)
				local var_360_7 = var_360_5 <= 0 and var_360_1 or var_360_1 * (var_360_6 / var_360_5)

				if var_360_7 > 0 and var_360_1 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_0
					end
				end

				arg_357_1.text_.text = var_360_4
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891083", "story_v_out_319891.awb") ~= 0 then
					local var_360_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891083", "story_v_out_319891.awb") / 1000

					if var_360_8 + var_360_0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_8 + var_360_0
					end

					if var_360_3.prefab_name ~= "" and arg_357_1.actors_[var_360_3.prefab_name] ~= nil then
						local var_360_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_3.prefab_name].transform, "story_v_out_319891", "319891083", "story_v_out_319891.awb")

						arg_357_1:RecordAudio("319891083", var_360_9)
						arg_357_1:RecordAudio("319891083", var_360_9)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_319891", "319891083", "story_v_out_319891.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_319891", "319891083", "story_v_out_319891.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_10 = math.max(var_360_1, arg_357_1.talkMaxDuration)

			if var_360_0 <= arg_357_1.time_ and arg_357_1.time_ < var_360_0 + var_360_10 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_0) / var_360_10

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_0 + var_360_10 and arg_357_1.time_ < var_360_0 + var_360_10 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play319891084 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 319891084
		arg_361_1.duration_ = 5.9

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play319891085(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = manager.ui.mainCamera.transform
			local var_364_1 = 0

			if var_364_1 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				local var_364_2 = arg_361_1.var_.effect1616

				if var_364_2 then
					Object.Destroy(var_364_2)

					arg_361_1.var_.effect1616 = nil
				end
			end

			local var_364_3 = 0

			if var_364_3 < arg_361_1.time_ and arg_361_1.time_ <= var_364_3 + arg_364_0 then
				arg_361_1.mask_.enabled = true
				arg_361_1.mask_.raycastTarget = false

				arg_361_1:SetGaussion(false)
			end

			local var_364_4 = 0.633333333333333

			if var_364_3 <= arg_361_1.time_ and arg_361_1.time_ < var_364_3 + var_364_4 then
				local var_364_5 = (arg_361_1.time_ - var_364_3) / var_364_4
				local var_364_6 = Color.New(0.7169812, 0.01690993, 0.01690993)

				var_364_6.a = Mathf.Lerp(1, 0, var_364_5)
				arg_361_1.mask_.color = var_364_6
			end

			if arg_361_1.time_ >= var_364_3 + var_364_4 and arg_361_1.time_ < var_364_3 + var_364_4 + arg_364_0 then
				local var_364_7 = Color.New(0.7169812, 0.01690993, 0.01690993)
				local var_364_8 = 0

				arg_361_1.mask_.enabled = false
				var_364_7.a = var_364_8
				arg_361_1.mask_.color = var_364_7
			end

			local var_364_9 = arg_361_1.actors_["1084ui_story"]
			local var_364_10 = 0

			if var_364_10 < arg_361_1.time_ and arg_361_1.time_ <= var_364_10 + arg_364_0 and not isNil(var_364_9) and arg_361_1.var_.characterEffect1084ui_story == nil then
				arg_361_1.var_.characterEffect1084ui_story = var_364_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_11 = 0.200000002980232

			if var_364_10 <= arg_361_1.time_ and arg_361_1.time_ < var_364_10 + var_364_11 and not isNil(var_364_9) then
				local var_364_12 = (arg_361_1.time_ - var_364_10) / var_364_11

				if arg_361_1.var_.characterEffect1084ui_story and not isNil(var_364_9) then
					arg_361_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= var_364_10 + var_364_11 and arg_361_1.time_ < var_364_10 + var_364_11 + arg_364_0 and not isNil(var_364_9) and arg_361_1.var_.characterEffect1084ui_story then
				arg_361_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_364_13 = 0
			local var_364_14 = 1

			if var_364_13 < arg_361_1.time_ and arg_361_1.time_ <= var_364_13 + arg_364_0 then
				local var_364_15 = "play"
				local var_364_16 = "effect"

				arg_361_1:AudioAction(var_364_15, var_364_16, "se_story_123_02", "se_story_123_02_fire", "")
			end

			local var_364_17 = arg_361_1.actors_["1084ui_story"].transform
			local var_364_18 = 0

			if var_364_18 < arg_361_1.time_ and arg_361_1.time_ <= var_364_18 + arg_364_0 then
				arg_361_1.var_.moveOldPos1084ui_story = var_364_17.localPosition
			end

			local var_364_19 = 0.001

			if var_364_18 <= arg_361_1.time_ and arg_361_1.time_ < var_364_18 + var_364_19 then
				local var_364_20 = (arg_361_1.time_ - var_364_18) / var_364_19
				local var_364_21 = Vector3.New(0, 100, 0)

				var_364_17.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1084ui_story, var_364_21, var_364_20)

				local var_364_22 = manager.ui.mainCamera.transform.position - var_364_17.position

				var_364_17.forward = Vector3.New(var_364_22.x, var_364_22.y, var_364_22.z)

				local var_364_23 = var_364_17.localEulerAngles

				var_364_23.z = 0
				var_364_23.x = 0
				var_364_17.localEulerAngles = var_364_23
			end

			if arg_361_1.time_ >= var_364_18 + var_364_19 and arg_361_1.time_ < var_364_18 + var_364_19 + arg_364_0 then
				var_364_17.localPosition = Vector3.New(0, 100, 0)

				local var_364_24 = manager.ui.mainCamera.transform.position - var_364_17.position

				var_364_17.forward = Vector3.New(var_364_24.x, var_364_24.y, var_364_24.z)

				local var_364_25 = var_364_17.localEulerAngles

				var_364_25.z = 0
				var_364_25.x = 0
				var_364_17.localEulerAngles = var_364_25
			end

			if arg_361_1.frameCnt_ <= 1 then
				arg_361_1.dialog_:SetActive(false)
			end

			local var_364_26 = 0.9
			local var_364_27 = 1.475

			if var_364_26 < arg_361_1.time_ and arg_361_1.time_ <= var_364_26 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0

				arg_361_1.dialog_:SetActive(true)

				arg_361_1.dialogCg_.alpha = 0

				local var_364_28 = LeanTween.value(arg_361_1.dialog_, 0, 1, 0.3)

				var_364_28:setOnUpdate(LuaHelper.FloatAction(function(arg_365_0)
					arg_361_1.dialogCg_.alpha = arg_365_0
				end))
				var_364_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_361_1.dialog_)
					var_364_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_361_1.duration_ = arg_361_1.duration_ + 0.3

				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_29 = arg_361_1:GetWordFromCfg(319891084)
				local var_364_30 = arg_361_1:FormatText(var_364_29.content)

				arg_361_1.text_.text = var_364_30

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_31 = 59
				local var_364_32 = utf8.len(var_364_30)
				local var_364_33 = var_364_31 <= 0 and var_364_27 or var_364_27 * (var_364_32 / var_364_31)

				if var_364_33 > 0 and var_364_27 < var_364_33 then
					arg_361_1.talkMaxDuration = var_364_33
					var_364_26 = var_364_26 + 0.3

					if var_364_33 + var_364_26 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_33 + var_364_26
					end
				end

				arg_361_1.text_.text = var_364_30
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_34 = var_364_26 + 0.3
			local var_364_35 = math.max(var_364_27, arg_361_1.talkMaxDuration)

			if var_364_34 <= arg_361_1.time_ and arg_361_1.time_ < var_364_34 + var_364_35 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_34) / var_364_35

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_34 + var_364_35 and arg_361_1.time_ < var_364_34 + var_364_35 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play319891085 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 319891085
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play319891086(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 1.025

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_2 = arg_367_1:GetWordFromCfg(319891085)
				local var_370_3 = arg_367_1:FormatText(var_370_2.content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 41
				local var_370_5 = utf8.len(var_370_3)
				local var_370_6 = var_370_4 <= 0 and var_370_1 or var_370_1 * (var_370_5 / var_370_4)

				if var_370_6 > 0 and var_370_1 < var_370_6 then
					arg_367_1.talkMaxDuration = var_370_6

					if var_370_6 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_6 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_7 and arg_367_1.time_ < var_370_0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play319891086 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 319891086
		arg_371_1.duration_ = 2

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play319891087(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1084ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos1084ui_story = var_374_0.localPosition

				local var_374_2 = "1084ui_story"

				arg_371_1:ShowWeapon(arg_371_1.var_[var_374_2 .. "Animator"].transform, true)
			end

			local var_374_3 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_3 then
				local var_374_4 = (arg_371_1.time_ - var_374_1) / var_374_3
				local var_374_5 = Vector3.New(0, -0.97, -6)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1084ui_story, var_374_5, var_374_4)

				local var_374_6 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_6.x, var_374_6.y, var_374_6.z)

				local var_374_7 = var_374_0.localEulerAngles

				var_374_7.z = 0
				var_374_7.x = 0
				var_374_0.localEulerAngles = var_374_7
			end

			if arg_371_1.time_ >= var_374_1 + var_374_3 and arg_371_1.time_ < var_374_1 + var_374_3 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_374_8 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_8.x, var_374_8.y, var_374_8.z)

				local var_374_9 = var_374_0.localEulerAngles

				var_374_9.z = 0
				var_374_9.x = 0
				var_374_0.localEulerAngles = var_374_9
			end

			local var_374_10 = arg_371_1.actors_["1084ui_story"]
			local var_374_11 = 0

			if var_374_11 < arg_371_1.time_ and arg_371_1.time_ <= var_374_11 + arg_374_0 and not isNil(var_374_10) and arg_371_1.var_.characterEffect1084ui_story == nil then
				arg_371_1.var_.characterEffect1084ui_story = var_374_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_12 = 0.200000002980232

			if var_374_11 <= arg_371_1.time_ and arg_371_1.time_ < var_374_11 + var_374_12 and not isNil(var_374_10) then
				local var_374_13 = (arg_371_1.time_ - var_374_11) / var_374_12

				if arg_371_1.var_.characterEffect1084ui_story and not isNil(var_374_10) then
					arg_371_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_11 + var_374_12 and arg_371_1.time_ < var_374_11 + var_374_12 + arg_374_0 and not isNil(var_374_10) and arg_371_1.var_.characterEffect1084ui_story then
				arg_371_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_374_14 = 0

			if var_374_14 < arg_371_1.time_ and arg_371_1.time_ <= var_374_14 + arg_374_0 then
				arg_371_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_374_15 = 0
			local var_374_16 = 0.075

			if var_374_15 < arg_371_1.time_ and arg_371_1.time_ <= var_374_15 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_17 = arg_371_1:FormatText(StoryNameCfg[6].name)

				arg_371_1.leftNameTxt_.text = var_374_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_18 = arg_371_1:GetWordFromCfg(319891086)
				local var_374_19 = arg_371_1:FormatText(var_374_18.content)

				arg_371_1.text_.text = var_374_19

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_20 = 3
				local var_374_21 = utf8.len(var_374_19)
				local var_374_22 = var_374_20 <= 0 and var_374_16 or var_374_16 * (var_374_21 / var_374_20)

				if var_374_22 > 0 and var_374_16 < var_374_22 then
					arg_371_1.talkMaxDuration = var_374_22

					if var_374_22 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_22 + var_374_15
					end
				end

				arg_371_1.text_.text = var_374_19
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891086", "story_v_out_319891.awb") ~= 0 then
					local var_374_23 = manager.audio:GetVoiceLength("story_v_out_319891", "319891086", "story_v_out_319891.awb") / 1000

					if var_374_23 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_23 + var_374_15
					end

					if var_374_18.prefab_name ~= "" and arg_371_1.actors_[var_374_18.prefab_name] ~= nil then
						local var_374_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_18.prefab_name].transform, "story_v_out_319891", "319891086", "story_v_out_319891.awb")

						arg_371_1:RecordAudio("319891086", var_374_24)
						arg_371_1:RecordAudio("319891086", var_374_24)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_319891", "319891086", "story_v_out_319891.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_319891", "319891086", "story_v_out_319891.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_25 = math.max(var_374_16, arg_371_1.talkMaxDuration)

			if var_374_15 <= arg_371_1.time_ and arg_371_1.time_ < var_374_15 + var_374_25 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_15) / var_374_25

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_15 + var_374_25 and arg_371_1.time_ < var_374_15 + var_374_25 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play319891087 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 319891087
		arg_375_1.duration_ = 5

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play319891088(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1084ui_story"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos1084ui_story = var_378_0.localPosition

				local var_378_2 = "1084ui_story"

				arg_375_1:ShowWeapon(arg_375_1.var_[var_378_2 .. "Animator"].transform, true)
			end

			local var_378_3 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_3 then
				local var_378_4 = (arg_375_1.time_ - var_378_1) / var_378_3
				local var_378_5 = Vector3.New(0, 100, 0)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1084ui_story, var_378_5, var_378_4)

				local var_378_6 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_6.x, var_378_6.y, var_378_6.z)

				local var_378_7 = var_378_0.localEulerAngles

				var_378_7.z = 0
				var_378_7.x = 0
				var_378_0.localEulerAngles = var_378_7
			end

			if arg_375_1.time_ >= var_378_1 + var_378_3 and arg_375_1.time_ < var_378_1 + var_378_3 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(0, 100, 0)

				local var_378_8 = manager.ui.mainCamera.transform.position - var_378_0.position

				var_378_0.forward = Vector3.New(var_378_8.x, var_378_8.y, var_378_8.z)

				local var_378_9 = var_378_0.localEulerAngles

				var_378_9.z = 0
				var_378_9.x = 0
				var_378_0.localEulerAngles = var_378_9
			end

			local var_378_10 = 0
			local var_378_11 = 1.175

			if var_378_10 < arg_375_1.time_ and arg_375_1.time_ <= var_378_10 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_12 = arg_375_1:GetWordFromCfg(319891087)
				local var_378_13 = arg_375_1:FormatText(var_378_12.content)

				arg_375_1.text_.text = var_378_13

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_14 = 47
				local var_378_15 = utf8.len(var_378_13)
				local var_378_16 = var_378_14 <= 0 and var_378_11 or var_378_11 * (var_378_15 / var_378_14)

				if var_378_16 > 0 and var_378_11 < var_378_16 then
					arg_375_1.talkMaxDuration = var_378_16

					if var_378_16 + var_378_10 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_16 + var_378_10
					end
				end

				arg_375_1.text_.text = var_378_13
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_17 = math.max(var_378_11, arg_375_1.talkMaxDuration)

			if var_378_10 <= arg_375_1.time_ and arg_375_1.time_ < var_378_10 + var_378_17 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_10) / var_378_17

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_10 + var_378_17 and arg_375_1.time_ < var_378_10 + var_378_17 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play319891088 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 319891088
		arg_379_1.duration_ = 5.87

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play319891089(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0
			local var_382_1 = 1

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				local var_382_2 = "play"
				local var_382_3 = "effect"

				arg_379_1:AudioAction(var_382_2, var_382_3, "se_story_side_1148", "se_story_1148_explosion", "")
			end

			local var_382_4 = manager.ui.mainCamera.transform
			local var_382_5 = 0

			if var_382_5 < arg_379_1.time_ and arg_379_1.time_ <= var_382_5 + arg_382_0 then
				arg_379_1.var_.shakeOldPos = var_382_4.localPosition
			end

			local var_382_6 = 0.766666666666667

			if var_382_5 <= arg_379_1.time_ and arg_379_1.time_ < var_382_5 + var_382_6 then
				local var_382_7 = (arg_379_1.time_ - var_382_5) / 0.066
				local var_382_8, var_382_9 = math.modf(var_382_7)

				var_382_4.localPosition = Vector3.New(var_382_9 * 0.13, var_382_9 * 0.13, var_382_9 * 0.13) + arg_379_1.var_.shakeOldPos
			end

			if arg_379_1.time_ >= var_382_5 + var_382_6 and arg_379_1.time_ < var_382_5 + var_382_6 + arg_382_0 then
				var_382_4.localPosition = arg_379_1.var_.shakeOldPos
			end

			if arg_379_1.frameCnt_ <= 1 then
				arg_379_1.dialog_:SetActive(false)
			end

			local var_382_10 = 0.866666666666667
			local var_382_11 = 1.45

			if var_382_10 < arg_379_1.time_ and arg_379_1.time_ <= var_382_10 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0

				arg_379_1.dialog_:SetActive(true)

				arg_379_1.dialogCg_.alpha = 0

				local var_382_12 = LeanTween.value(arg_379_1.dialog_, 0, 1, 0.3)

				var_382_12:setOnUpdate(LuaHelper.FloatAction(function(arg_383_0)
					arg_379_1.dialogCg_.alpha = arg_383_0
				end))
				var_382_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_379_1.dialog_)
					var_382_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_379_1.duration_ = arg_379_1.duration_ + 0.3

				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_13 = arg_379_1:GetWordFromCfg(319891088)
				local var_382_14 = arg_379_1:FormatText(var_382_13.content)

				arg_379_1.text_.text = var_382_14

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_15 = 58
				local var_382_16 = utf8.len(var_382_14)
				local var_382_17 = var_382_15 <= 0 and var_382_11 or var_382_11 * (var_382_16 / var_382_15)

				if var_382_17 > 0 and var_382_11 < var_382_17 then
					arg_379_1.talkMaxDuration = var_382_17
					var_382_10 = var_382_10 + 0.3

					if var_382_17 + var_382_10 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_17 + var_382_10
					end
				end

				arg_379_1.text_.text = var_382_14
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_18 = var_382_10 + 0.3
			local var_382_19 = math.max(var_382_11, arg_379_1.talkMaxDuration)

			if var_382_18 <= arg_379_1.time_ and arg_379_1.time_ < var_382_18 + var_382_19 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_18) / var_382_19

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_18 + var_382_19 and arg_379_1.time_ < var_382_18 + var_382_19 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play319891089 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 319891089
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play319891090(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0
			local var_388_1 = 1

			if var_388_0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_0 + arg_388_0 then
				local var_388_2 = "play"
				local var_388_3 = "effect"

				arg_385_1:AudioAction(var_388_2, var_388_3, "se_story_126_01", "se_story_126_01_noise", "")
			end

			local var_388_4 = manager.ui.mainCamera.transform
			local var_388_5 = 0

			if var_388_5 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 then
				arg_385_1.var_.shakeOldPos = var_388_4.localPosition
			end

			local var_388_6 = 0.766666666666667

			if var_388_5 <= arg_385_1.time_ and arg_385_1.time_ < var_388_5 + var_388_6 then
				local var_388_7 = (arg_385_1.time_ - var_388_5) / 0.066
				local var_388_8, var_388_9 = math.modf(var_388_7)

				var_388_4.localPosition = Vector3.New(var_388_9 * 0.13, var_388_9 * 0.13, var_388_9 * 0.13) + arg_385_1.var_.shakeOldPos
			end

			if arg_385_1.time_ >= var_388_5 + var_388_6 and arg_385_1.time_ < var_388_5 + var_388_6 + arg_388_0 then
				var_388_4.localPosition = arg_385_1.var_.shakeOldPos
			end

			local var_388_10 = manager.ui.mainCamera.transform
			local var_388_11 = 0

			if var_388_11 < arg_385_1.time_ and arg_385_1.time_ <= var_388_11 + arg_388_0 then
				local var_388_12 = arg_385_1.var_.effect1617
				local var_388_13
				local var_388_14 = var_388_10

				if not var_388_12 then
					var_388_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_388_14)
					var_388_12.name = "1617"
					arg_385_1.var_.effect1617 = var_388_12
				else
					var_388_12.transform:SetParent(var_388_14)
				end

				var_388_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_388_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_388_15 = 0
			local var_388_16 = 1.325

			if var_388_15 < arg_385_1.time_ and arg_385_1.time_ <= var_388_15 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_17 = arg_385_1:GetWordFromCfg(319891089)
				local var_388_18 = arg_385_1:FormatText(var_388_17.content)

				arg_385_1.text_.text = var_388_18

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_19 = 53
				local var_388_20 = utf8.len(var_388_18)
				local var_388_21 = var_388_19 <= 0 and var_388_16 or var_388_16 * (var_388_20 / var_388_19)

				if var_388_21 > 0 and var_388_16 < var_388_21 then
					arg_385_1.talkMaxDuration = var_388_21

					if var_388_21 + var_388_15 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_21 + var_388_15
					end
				end

				arg_385_1.text_.text = var_388_18
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_22 = math.max(var_388_16, arg_385_1.talkMaxDuration)

			if var_388_15 <= arg_385_1.time_ and arg_385_1.time_ < var_388_15 + var_388_22 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_15) / var_388_22

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_15 + var_388_22 and arg_385_1.time_ < var_388_15 + var_388_22 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play319891090 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 319891090
		arg_389_1.duration_ = 3.8

		local var_389_0 = {
			zh = 1.999999999999,
			ja = 3.8
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play319891091(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = arg_389_1.actors_["1084ui_story"].transform
			local var_392_1 = 0

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.var_.moveOldPos1084ui_story = var_392_0.localPosition

				local var_392_2 = "1084ui_story"

				arg_389_1:ShowWeapon(arg_389_1.var_[var_392_2 .. "Animator"].transform, false)
			end

			local var_392_3 = 0.001

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_3 then
				local var_392_4 = (arg_389_1.time_ - var_392_1) / var_392_3
				local var_392_5 = Vector3.New(0, -0.97, -6)

				var_392_0.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1084ui_story, var_392_5, var_392_4)

				local var_392_6 = manager.ui.mainCamera.transform.position - var_392_0.position

				var_392_0.forward = Vector3.New(var_392_6.x, var_392_6.y, var_392_6.z)

				local var_392_7 = var_392_0.localEulerAngles

				var_392_7.z = 0
				var_392_7.x = 0
				var_392_0.localEulerAngles = var_392_7
			end

			if arg_389_1.time_ >= var_392_1 + var_392_3 and arg_389_1.time_ < var_392_1 + var_392_3 + arg_392_0 then
				var_392_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_392_8 = manager.ui.mainCamera.transform.position - var_392_0.position

				var_392_0.forward = Vector3.New(var_392_8.x, var_392_8.y, var_392_8.z)

				local var_392_9 = var_392_0.localEulerAngles

				var_392_9.z = 0
				var_392_9.x = 0
				var_392_0.localEulerAngles = var_392_9
			end

			local var_392_10 = arg_389_1.actors_["1084ui_story"]
			local var_392_11 = 0

			if var_392_11 < arg_389_1.time_ and arg_389_1.time_ <= var_392_11 + arg_392_0 and not isNil(var_392_10) and arg_389_1.var_.characterEffect1084ui_story == nil then
				arg_389_1.var_.characterEffect1084ui_story = var_392_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_12 = 0.200000002980232

			if var_392_11 <= arg_389_1.time_ and arg_389_1.time_ < var_392_11 + var_392_12 and not isNil(var_392_10) then
				local var_392_13 = (arg_389_1.time_ - var_392_11) / var_392_12

				if arg_389_1.var_.characterEffect1084ui_story and not isNil(var_392_10) then
					arg_389_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= var_392_11 + var_392_12 and arg_389_1.time_ < var_392_11 + var_392_12 + arg_392_0 and not isNil(var_392_10) and arg_389_1.var_.characterEffect1084ui_story then
				arg_389_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_392_14 = 0

			if var_392_14 < arg_389_1.time_ and arg_389_1.time_ <= var_392_14 + arg_392_0 then
				arg_389_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_392_15 = manager.ui.mainCamera.transform
			local var_392_16 = 0

			if var_392_16 < arg_389_1.time_ and arg_389_1.time_ <= var_392_16 + arg_392_0 then
				local var_392_17 = arg_389_1.var_.effect1617

				if var_392_17 then
					Object.Destroy(var_392_17)

					arg_389_1.var_.effect1617 = nil
				end
			end

			local var_392_18 = 0

			if var_392_18 < arg_389_1.time_ and arg_389_1.time_ <= var_392_18 + arg_392_0 then
				arg_389_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_2")
			end

			local var_392_19 = 0
			local var_392_20 = 0.1

			if var_392_19 < arg_389_1.time_ and arg_389_1.time_ <= var_392_19 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_21 = arg_389_1:FormatText(StoryNameCfg[6].name)

				arg_389_1.leftNameTxt_.text = var_392_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_22 = arg_389_1:GetWordFromCfg(319891090)
				local var_392_23 = arg_389_1:FormatText(var_392_22.content)

				arg_389_1.text_.text = var_392_23

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_24 = 4
				local var_392_25 = utf8.len(var_392_23)
				local var_392_26 = var_392_24 <= 0 and var_392_20 or var_392_20 * (var_392_25 / var_392_24)

				if var_392_26 > 0 and var_392_20 < var_392_26 then
					arg_389_1.talkMaxDuration = var_392_26

					if var_392_26 + var_392_19 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_26 + var_392_19
					end
				end

				arg_389_1.text_.text = var_392_23
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891090", "story_v_out_319891.awb") ~= 0 then
					local var_392_27 = manager.audio:GetVoiceLength("story_v_out_319891", "319891090", "story_v_out_319891.awb") / 1000

					if var_392_27 + var_392_19 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_27 + var_392_19
					end

					if var_392_22.prefab_name ~= "" and arg_389_1.actors_[var_392_22.prefab_name] ~= nil then
						local var_392_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_22.prefab_name].transform, "story_v_out_319891", "319891090", "story_v_out_319891.awb")

						arg_389_1:RecordAudio("319891090", var_392_28)
						arg_389_1:RecordAudio("319891090", var_392_28)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_319891", "319891090", "story_v_out_319891.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_319891", "319891090", "story_v_out_319891.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_29 = math.max(var_392_20, arg_389_1.talkMaxDuration)

			if var_392_19 <= arg_389_1.time_ and arg_389_1.time_ < var_392_19 + var_392_29 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_19) / var_392_29

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_19 + var_392_29 and arg_389_1.time_ < var_392_19 + var_392_29 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play319891091 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 319891091
		arg_393_1.duration_ = 6.47

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play319891092(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				local var_396_1 = manager.ui.mainCamera.transform.localPosition
				local var_396_2 = Vector3.New(0, 0, 10) + Vector3.New(var_396_1.x, var_396_1.y, 0)
				local var_396_3 = arg_393_1.bgs_.STblack

				var_396_3.transform.localPosition = var_396_2
				var_396_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_396_4 = var_396_3:GetComponent("SpriteRenderer")

				if var_396_4 and var_396_4.sprite then
					local var_396_5 = (var_396_3.transform.localPosition - var_396_1).z
					local var_396_6 = manager.ui.mainCameraCom_
					local var_396_7 = 2 * var_396_5 * Mathf.Tan(var_396_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_396_8 = var_396_7 * var_396_6.aspect
					local var_396_9 = var_396_4.sprite.bounds.size.x
					local var_396_10 = var_396_4.sprite.bounds.size.y
					local var_396_11 = var_396_8 / var_396_9
					local var_396_12 = var_396_7 / var_396_10
					local var_396_13 = var_396_12 < var_396_11 and var_396_11 or var_396_12

					var_396_3.transform.localScale = Vector3.New(var_396_13, var_396_13, 0)
				end

				for iter_396_0, iter_396_1 in pairs(arg_393_1.bgs_) do
					if iter_396_0 ~= "STblack" then
						iter_396_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_396_14 = 0

			if var_396_14 < arg_393_1.time_ and arg_393_1.time_ <= var_396_14 + arg_396_0 then
				arg_393_1.allBtn_.enabled = false
			end

			local var_396_15 = 0.3

			if arg_393_1.time_ >= var_396_14 + var_396_15 and arg_393_1.time_ < var_396_14 + var_396_15 + arg_396_0 then
				arg_393_1.allBtn_.enabled = true
			end

			local var_396_16 = 0

			if var_396_16 < arg_393_1.time_ and arg_393_1.time_ <= var_396_16 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_17 = 2

			if var_396_16 <= arg_393_1.time_ and arg_393_1.time_ < var_396_16 + var_396_17 then
				local var_396_18 = (arg_393_1.time_ - var_396_16) / var_396_17
				local var_396_19 = Color.New(0, 0, 0)

				var_396_19.a = Mathf.Lerp(1, 0, var_396_18)
				arg_393_1.mask_.color = var_396_19
			end

			if arg_393_1.time_ >= var_396_16 + var_396_17 and arg_393_1.time_ < var_396_16 + var_396_17 + arg_396_0 then
				local var_396_20 = Color.New(0, 0, 0)
				local var_396_21 = 0

				arg_393_1.mask_.enabled = false
				var_396_20.a = var_396_21
				arg_393_1.mask_.color = var_396_20
			end

			local var_396_22 = arg_393_1.actors_["1084ui_story"].transform
			local var_396_23 = 0

			if var_396_23 < arg_393_1.time_ and arg_393_1.time_ <= var_396_23 + arg_396_0 then
				arg_393_1.var_.moveOldPos1084ui_story = var_396_22.localPosition
			end

			local var_396_24 = 0.001

			if var_396_23 <= arg_393_1.time_ and arg_393_1.time_ < var_396_23 + var_396_24 then
				local var_396_25 = (arg_393_1.time_ - var_396_23) / var_396_24
				local var_396_26 = Vector3.New(0, 100, 0)

				var_396_22.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1084ui_story, var_396_26, var_396_25)

				local var_396_27 = manager.ui.mainCamera.transform.position - var_396_22.position

				var_396_22.forward = Vector3.New(var_396_27.x, var_396_27.y, var_396_27.z)

				local var_396_28 = var_396_22.localEulerAngles

				var_396_28.z = 0
				var_396_28.x = 0
				var_396_22.localEulerAngles = var_396_28
			end

			if arg_393_1.time_ >= var_396_23 + var_396_24 and arg_393_1.time_ < var_396_23 + var_396_24 + arg_396_0 then
				var_396_22.localPosition = Vector3.New(0, 100, 0)

				local var_396_29 = manager.ui.mainCamera.transform.position - var_396_22.position

				var_396_22.forward = Vector3.New(var_396_29.x, var_396_29.y, var_396_29.z)

				local var_396_30 = var_396_22.localEulerAngles

				var_396_30.z = 0
				var_396_30.x = 0
				var_396_22.localEulerAngles = var_396_30
			end

			local var_396_31 = arg_393_1.actors_["1084ui_story"]
			local var_396_32 = 0

			if var_396_32 < arg_393_1.time_ and arg_393_1.time_ <= var_396_32 + arg_396_0 and not isNil(var_396_31) and arg_393_1.var_.characterEffect1084ui_story == nil then
				arg_393_1.var_.characterEffect1084ui_story = var_396_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_33 = 0.200000002980232

			if var_396_32 <= arg_393_1.time_ and arg_393_1.time_ < var_396_32 + var_396_33 and not isNil(var_396_31) then
				local var_396_34 = (arg_393_1.time_ - var_396_32) / var_396_33

				if arg_393_1.var_.characterEffect1084ui_story and not isNil(var_396_31) then
					local var_396_35 = Mathf.Lerp(0, 0.5, var_396_34)

					arg_393_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1084ui_story.fillRatio = var_396_35
				end
			end

			if arg_393_1.time_ >= var_396_32 + var_396_33 and arg_393_1.time_ < var_396_32 + var_396_33 + arg_396_0 and not isNil(var_396_31) and arg_393_1.var_.characterEffect1084ui_story then
				local var_396_36 = 0.5

				arg_393_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1084ui_story.fillRatio = var_396_36
			end

			if arg_393_1.frameCnt_ <= 1 then
				arg_393_1.dialog_:SetActive(false)
			end

			local var_396_37 = 1.46666666666667
			local var_396_38 = 1.225

			if var_396_37 < arg_393_1.time_ and arg_393_1.time_ <= var_396_37 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				arg_393_1.dialog_:SetActive(true)

				arg_393_1.dialogCg_.alpha = 0

				local var_396_39 = LeanTween.value(arg_393_1.dialog_, 0, 1, 0.3)

				var_396_39:setOnUpdate(LuaHelper.FloatAction(function(arg_397_0)
					arg_393_1.dialogCg_.alpha = arg_397_0
				end))
				var_396_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_393_1.dialog_)
					var_396_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_393_1.duration_ = arg_393_1.duration_ + 0.3

				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_40 = arg_393_1:GetWordFromCfg(319891091)
				local var_396_41 = arg_393_1:FormatText(var_396_40.content)

				arg_393_1.text_.text = var_396_41

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_42 = 49
				local var_396_43 = utf8.len(var_396_41)
				local var_396_44 = var_396_42 <= 0 and var_396_38 or var_396_38 * (var_396_43 / var_396_42)

				if var_396_44 > 0 and var_396_38 < var_396_44 then
					arg_393_1.talkMaxDuration = var_396_44
					var_396_37 = var_396_37 + 0.3

					if var_396_44 + var_396_37 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_44 + var_396_37
					end
				end

				arg_393_1.text_.text = var_396_41
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_45 = var_396_37 + 0.3
			local var_396_46 = math.max(var_396_38, arg_393_1.talkMaxDuration)

			if var_396_45 <= arg_393_1.time_ and arg_393_1.time_ < var_396_45 + var_396_46 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_45) / var_396_46

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_45 + var_396_46 and arg_393_1.time_ < var_396_45 + var_396_46 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play319891092 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 319891092
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
			arg_399_1.auto_ = false
		end

		function arg_399_1.playNext_(arg_401_0)
			arg_399_1.onStoryFinished_()
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0
			local var_402_1 = 1.15

			if var_402_0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_2 = arg_399_1:GetWordFromCfg(319891092)
				local var_402_3 = arg_399_1:FormatText(var_402_2.content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_4 = 46
				local var_402_5 = utf8.len(var_402_3)
				local var_402_6 = var_402_4 <= 0 and var_402_1 or var_402_1 * (var_402_5 / var_402_4)

				if var_402_6 > 0 and var_402_1 < var_402_6 then
					arg_399_1.talkMaxDuration = var_402_6

					if var_402_6 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_6 + var_402_0
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_7 = math.max(var_402_1, arg_399_1.talkMaxDuration)

			if var_402_0 <= arg_399_1.time_ and arg_399_1.time_ < var_402_0 + var_402_7 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_0) / var_402_7

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_0 + var_402_7 and arg_399_1.time_ < var_402_0 + var_402_7 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST15a",
		"TextureConfig/Background/ST74a",
		"TextureConfig/Background/D02a"
	},
	voices = {
		"story_v_out_319891.awb"
	}
}
