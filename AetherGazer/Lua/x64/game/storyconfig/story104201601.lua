return {
	Play420161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420161001
		arg_1_1.duration_ = 2

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play420161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_1 = 2

			if var_4_0 <= arg_1_1.time_ and arg_1_1.time_ < var_4_0 + var_4_1 then
				local var_4_2 = (arg_1_1.time_ - var_4_0) / var_4_1
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = Mathf.Lerp(1, 0, var_4_2)
				arg_1_1.mask_.color = var_4_3
			end

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				local var_4_4 = Color.New(0, 0, 0)
				local var_4_5 = 0

				arg_1_1.mask_.enabled = false
				var_4_4.a = var_4_5
				arg_1_1.mask_.color = var_4_4
			end

			local var_4_6 = "STwhite"

			if arg_1_1.bgs_[var_4_6] == nil then
				local var_4_7 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_7:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_6)
				var_4_7.name = var_4_6
				var_4_7.transform.parent = arg_1_1.stage_.transform
				var_4_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_6] = var_4_7
			end

			local var_4_8 = 0

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				local var_4_9 = manager.ui.mainCamera.transform.localPosition
				local var_4_10 = Vector3.New(0, 0, 10) + Vector3.New(var_4_9.x, var_4_9.y, 0)
				local var_4_11 = arg_1_1.bgs_.STwhite

				var_4_11.transform.localPosition = var_4_10
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = (var_4_11.transform.localPosition - var_4_9).z
					local var_4_14 = manager.ui.mainCameraCom_
					local var_4_15 = 2 * var_4_13 * Mathf.Tan(var_4_14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_16 = var_4_15 * var_4_14.aspect
					local var_4_17 = var_4_12.sprite.bounds.size.x
					local var_4_18 = var_4_12.sprite.bounds.size.y
					local var_4_19 = var_4_16 / var_4_17
					local var_4_20 = var_4_15 / var_4_18
					local var_4_21 = var_4_20 < var_4_19 and var_4_19 or var_4_20

					var_4_11.transform.localScale = Vector3.New(var_4_21, var_4_21, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STwhite" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_22 = 0
			local var_4_23 = 0.2

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 0

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_29 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_29.offsetMin = Vector2.New(0, 0)
				var_4_29.offsetMax = Vector2.New(0, 130)

				local var_4_30 = arg_1_1:GetWordFromCfg(419159)
				local var_4_31 = arg_1_1:FormatText(var_4_30.content)

				arg_1_1.cswt_.text = var_4_31

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 120
				arg_1_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play420161002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 420161002
		arg_6_1.duration_ = 1.03

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play420161003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = 0

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(true)
				arg_6_1.dialog_:SetActive(false)

				arg_6_1.fswtw_.percent = 0

				local var_9_1 = arg_6_1:GetWordFromCfg(420161002)
				local var_9_2 = arg_6_1:FormatText(var_9_1.content)

				arg_6_1.fswt_.text = var_9_2

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.fswt_)

				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_6_1.fswtw_:SetDirty()

				arg_6_1.typewritterCharCountI18N = 0

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_3 = 0.0166666666666667

			if var_9_3 < arg_6_1.time_ and arg_6_1.time_ <= var_9_3 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_4 = 2
			local var_9_5 = 0.2
			local var_9_6 = arg_6_1:GetWordFromCfg(420161002)
			local var_9_7 = arg_6_1:FormatText(var_9_6.content)
			local var_9_8, var_9_9 = arg_6_1:GetPercentByPara(var_9_7, 1)

			if var_9_3 < arg_6_1.time_ and arg_6_1.time_ <= var_9_3 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_10 = var_9_4 <= 0 and var_9_5 or var_9_5 * ((var_9_9 - arg_6_1.typewritterCharCountI18N) / var_9_4)

				if var_9_10 > 0 and var_9_5 < var_9_10 then
					arg_6_1.talkMaxDuration = var_9_10

					if var_9_10 + var_9_3 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_10 + var_9_3
					end
				end
			end

			local var_9_11 = 0.2
			local var_9_12 = math.max(var_9_11, arg_6_1.talkMaxDuration)

			if var_9_3 <= arg_6_1.time_ and arg_6_1.time_ < var_9_3 + var_9_12 then
				local var_9_13 = (arg_6_1.time_ - var_9_3) / var_9_12

				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_8, var_9_13)
				arg_6_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_3 + var_9_12 and arg_6_1.time_ < var_9_3 + var_9_12 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_8

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_9
			end

			local var_9_14 = 0

			if var_9_14 < arg_6_1.time_ and arg_6_1.time_ <= var_9_14 + arg_9_0 then
				local var_9_15 = arg_6_1.fswbg_.transform:Find("textbox/adapt/content") or arg_6_1.fswbg_.transform:Find("textbox/content")
				local var_9_16 = arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_9_17 = var_9_15:GetComponent("Text")
				local var_9_18 = var_9_15:GetComponent("RectTransform")

				var_9_17.alignment = UnityEngine.TextAnchor.LowerCenter
				var_9_18.offsetMin = Vector2.New(0, -70)
				var_9_18.offsetMax = Vector2.New(0, 0)
			end

			local var_9_19 = 0

			if var_9_19 < arg_6_1.time_ and arg_6_1.time_ <= var_9_19 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			local var_9_20 = 0.15

			if arg_6_1.time_ >= var_9_19 + var_9_20 and arg_6_1.time_ < var_9_19 + var_9_20 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play420161003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 420161003
		arg_10_1.duration_ = 3.9

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play420161004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.fswbg_:SetActive(true)
				arg_10_1.dialog_:SetActive(false)

				arg_10_1.fswtw_.percent = 0

				local var_13_1 = arg_10_1:GetWordFromCfg(420161003)
				local var_13_2 = arg_10_1:FormatText(var_13_1.content)

				arg_10_1.fswt_.text = var_13_2

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.fswt_)

				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_10_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_10_1.fswtw_:SetDirty()

				arg_10_1.typewritterCharCountI18N = 0

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_3 = 0.0166666666666667

			if var_13_3 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_4 = 8
			local var_13_5 = 0.533333333333333
			local var_13_6 = arg_10_1:GetWordFromCfg(420161003)
			local var_13_7 = arg_10_1:FormatText(var_13_6.content)
			local var_13_8, var_13_9 = arg_10_1:GetPercentByPara(var_13_7, 1)

			if var_13_3 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_10 = var_13_4 <= 0 and var_13_5 or var_13_5 * ((var_13_9 - arg_10_1.typewritterCharCountI18N) / var_13_4)

				if var_13_10 > 0 and var_13_5 < var_13_10 then
					arg_10_1.talkMaxDuration = var_13_10

					if var_13_10 + var_13_3 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_10 + var_13_3
					end
				end
			end

			local var_13_11 = 0.533333333333333
			local var_13_12 = math.max(var_13_11, arg_10_1.talkMaxDuration)

			if var_13_3 <= arg_10_1.time_ and arg_10_1.time_ < var_13_3 + var_13_12 then
				local var_13_13 = (arg_10_1.time_ - var_13_3) / var_13_12

				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_8, var_13_13)
				arg_10_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= var_13_3 + var_13_12 and arg_10_1.time_ < var_13_3 + var_13_12 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_8

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_9
			end

			local var_13_14 = 0
			local var_13_15 = 3.9
			local var_13_16 = manager.audio:GetVoiceLength("story_v_out_420161", "420161003", "story_v_out_420161.awb") / 1000

			if var_13_16 > 0 and var_13_15 < var_13_16 and var_13_16 + var_13_14 > arg_10_1.duration_ then
				local var_13_17 = var_13_16

				arg_10_1.duration_ = var_13_16 + var_13_14
			end

			if var_13_14 < arg_10_1.time_ and arg_10_1.time_ <= var_13_14 + arg_13_0 then
				local var_13_18 = "play"
				local var_13_19 = "voice"

				arg_10_1:AudioAction(var_13_18, var_13_19, "story_v_out_420161", "420161003", "story_v_out_420161.awb")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play420161004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 420161004
		arg_14_1.duration_ = 7

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play420161005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = "ST0505"

			if arg_14_1.bgs_[var_17_0] == nil then
				local var_17_1 = Object.Instantiate(arg_14_1.paintGo_)

				var_17_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_17_0)
				var_17_1.name = var_17_0
				var_17_1.transform.parent = arg_14_1.stage_.transform
				var_17_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_14_1.bgs_[var_17_0] = var_17_1
			end

			local var_17_2 = 0

			if var_17_2 < arg_14_1.time_ and arg_14_1.time_ <= var_17_2 + arg_17_0 then
				local var_17_3 = manager.ui.mainCamera.transform.localPosition
				local var_17_4 = Vector3.New(0, 0, 10) + Vector3.New(var_17_3.x, var_17_3.y, 0)
				local var_17_5 = arg_14_1.bgs_.ST0505

				var_17_5.transform.localPosition = var_17_4
				var_17_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_17_6 = var_17_5:GetComponent("SpriteRenderer")

				if var_17_6 and var_17_6.sprite then
					local var_17_7 = (var_17_5.transform.localPosition - var_17_3).z
					local var_17_8 = manager.ui.mainCameraCom_
					local var_17_9 = 2 * var_17_7 * Mathf.Tan(var_17_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_17_10 = var_17_9 * var_17_8.aspect
					local var_17_11 = var_17_6.sprite.bounds.size.x
					local var_17_12 = var_17_6.sprite.bounds.size.y
					local var_17_13 = var_17_10 / var_17_11
					local var_17_14 = var_17_9 / var_17_12
					local var_17_15 = var_17_14 < var_17_13 and var_17_13 or var_17_14

					var_17_5.transform.localScale = Vector3.New(var_17_15, var_17_15, 0)
				end

				for iter_17_0, iter_17_1 in pairs(arg_14_1.bgs_) do
					if iter_17_0 ~= "ST0505" then
						iter_17_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_17_16 = 0

			if var_17_16 < arg_14_1.time_ and arg_14_1.time_ <= var_17_16 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_17 = 2

			if var_17_16 <= arg_14_1.time_ and arg_14_1.time_ < var_17_16 + var_17_17 then
				local var_17_18 = (arg_14_1.time_ - var_17_16) / var_17_17
				local var_17_19 = Color.New(1, 1, 1)

				var_17_19.a = Mathf.Lerp(1, 0, var_17_18)
				arg_14_1.mask_.color = var_17_19
			end

			if arg_14_1.time_ >= var_17_16 + var_17_17 and arg_14_1.time_ < var_17_16 + var_17_17 + arg_17_0 then
				local var_17_20 = Color.New(1, 1, 1)
				local var_17_21 = 0

				arg_14_1.mask_.enabled = false
				var_17_20.a = var_17_21
				arg_14_1.mask_.color = var_17_20
			end

			local var_17_22 = 2

			if var_17_22 < arg_14_1.time_ and arg_14_1.time_ <= var_17_22 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			local var_17_23 = 0.666666666666667

			if arg_14_1.time_ >= var_17_22 + var_17_23 and arg_14_1.time_ < var_17_22 + var_17_23 + arg_17_0 then
				arg_14_1.allBtn_.enabled = true
			end

			local var_17_24 = "1085ui_story"

			if arg_14_1.actors_[var_17_24] == nil then
				local var_17_25 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_17_25) then
					local var_17_26 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_14_1.stage_.transform)

					var_17_26.name = var_17_24
					var_17_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_14_1.actors_[var_17_24] = var_17_26

					local var_17_27 = var_17_26:GetComponentInChildren(typeof(CharacterEffect))

					var_17_27.enabled = true

					local var_17_28 = GameObjectTools.GetOrAddComponent(var_17_26, typeof(DynamicBoneHelper))

					if var_17_28 then
						var_17_28:EnableDynamicBone(false)
					end

					arg_14_1:ShowWeapon(var_17_27.transform, false)

					arg_14_1.var_[var_17_24 .. "Animator"] = var_17_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_14_1.var_[var_17_24 .. "Animator"].applyRootMotion = true
					arg_14_1.var_[var_17_24 .. "LipSync"] = var_17_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_17_29 = arg_14_1.actors_["1085ui_story"].transform
			local var_17_30 = 0

			if var_17_30 < arg_14_1.time_ and arg_14_1.time_ <= var_17_30 + arg_17_0 then
				arg_14_1.var_.moveOldPos1085ui_story = var_17_29.localPosition
			end

			local var_17_31 = 0.001

			if var_17_30 <= arg_14_1.time_ and arg_14_1.time_ < var_17_30 + var_17_31 then
				local var_17_32 = (arg_14_1.time_ - var_17_30) / var_17_31
				local var_17_33 = Vector3.New(0, 100, 0)

				var_17_29.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1085ui_story, var_17_33, var_17_32)

				local var_17_34 = manager.ui.mainCamera.transform.position - var_17_29.position

				var_17_29.forward = Vector3.New(var_17_34.x, var_17_34.y, var_17_34.z)

				local var_17_35 = var_17_29.localEulerAngles

				var_17_35.z = 0
				var_17_35.x = 0
				var_17_29.localEulerAngles = var_17_35
			end

			if arg_14_1.time_ >= var_17_30 + var_17_31 and arg_14_1.time_ < var_17_30 + var_17_31 + arg_17_0 then
				var_17_29.localPosition = Vector3.New(0, 100, 0)

				local var_17_36 = manager.ui.mainCamera.transform.position - var_17_29.position

				var_17_29.forward = Vector3.New(var_17_36.x, var_17_36.y, var_17_36.z)

				local var_17_37 = var_17_29.localEulerAngles

				var_17_37.z = 0
				var_17_37.x = 0
				var_17_29.localEulerAngles = var_17_37
			end

			local var_17_38 = 0
			local var_17_39 = 1

			if var_17_38 < arg_14_1.time_ and arg_14_1.time_ <= var_17_38 + arg_17_0 then
				local var_17_40 = "play"
				local var_17_41 = "effect"

				arg_14_1:AudioAction(var_17_40, var_17_41, "se_story_140", "se_story_140_amb_room01", "")
			end

			local var_17_42 = 3.16666666666667
			local var_17_43 = 1

			if var_17_42 < arg_14_1.time_ and arg_14_1.time_ <= var_17_42 + arg_17_0 then
				local var_17_44 = "play"
				local var_17_45 = "effect"

				arg_14_1:AudioAction(var_17_44, var_17_45, "se_story_140", "se_story_140_transparent01", "")
			end

			local var_17_46 = 0

			if var_17_46 < arg_14_1.time_ and arg_14_1.time_ <= var_17_46 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(false)
				arg_14_1.dialog_:SetActive(false)
				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_47 = 0

			if var_17_47 < arg_14_1.time_ and arg_14_1.time_ <= var_17_47 + arg_17_0 then
				arg_14_1.cswbg_:SetActive(false)
			end

			if arg_14_1.frameCnt_ <= 1 then
				arg_14_1.dialog_:SetActive(false)
			end

			local var_17_48 = 2
			local var_17_49 = 1.4

			if var_17_48 < arg_14_1.time_ and arg_14_1.time_ <= var_17_48 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				arg_14_1.dialog_:SetActive(true)

				arg_14_1.dialogCg_.alpha = 0

				local var_17_50 = LeanTween.value(arg_14_1.dialog_, 0, 1, 0.3)

				var_17_50:setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
					arg_14_1.dialogCg_.alpha = arg_18_0
				end))
				var_17_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_14_1.dialog_)
					var_17_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_14_1.duration_ = arg_14_1.duration_ + 0.3

				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_51 = arg_14_1:GetWordFromCfg(420161004)
				local var_17_52 = arg_14_1:FormatText(var_17_51.content)

				arg_14_1.text_.text = var_17_52

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_53 = 56
				local var_17_54 = utf8.len(var_17_52)
				local var_17_55 = var_17_53 <= 0 and var_17_49 or var_17_49 * (var_17_54 / var_17_53)

				if var_17_55 > 0 and var_17_49 < var_17_55 then
					arg_14_1.talkMaxDuration = var_17_55
					var_17_48 = var_17_48 + 0.3

					if var_17_55 + var_17_48 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_55 + var_17_48
					end
				end

				arg_14_1.text_.text = var_17_52
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_56 = var_17_48 + 0.3
			local var_17_57 = math.max(var_17_49, arg_14_1.talkMaxDuration)

			if var_17_56 <= arg_14_1.time_ and arg_14_1.time_ < var_17_56 + var_17_57 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_56) / var_17_57

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_56 + var_17_57 and arg_14_1.time_ < var_17_56 + var_17_57 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420161005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 420161005
		arg_20_1.duration_ = 2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play420161006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1085ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1085ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(0, -1.01, -5.83)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1085ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_23_7 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_7.x, var_23_7.y, var_23_7.z)

				local var_23_8 = var_23_0.localEulerAngles

				var_23_8.z = 0
				var_23_8.x = 0
				var_23_0.localEulerAngles = var_23_8
			end

			local var_23_9 = arg_20_1.actors_["1085ui_story"]
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1085ui_story == nil then
				arg_20_1.var_.characterEffect1085ui_story = var_23_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.200000002980232

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 and not isNil(var_23_9) then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11

				if arg_20_1.var_.characterEffect1085ui_story and not isNil(var_23_9) then
					arg_20_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1085ui_story then
				arg_20_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_23_13 = 0

			if var_23_13 < arg_20_1.time_ and arg_20_1.time_ <= var_23_13 + arg_23_0 then
				arg_20_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_23_14 = 0

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_23_15 = 0
			local var_23_16 = 0.0329999998211861

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_17 = arg_20_1:FormatText(StoryNameCfg[328].name)

				arg_20_1.leftNameTxt_.text = var_23_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_18 = arg_20_1:GetWordFromCfg(420161005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_20 = 1
				local var_23_21 = utf8.len(var_23_19)
				local var_23_22 = var_23_20 <= 0 and var_23_16 or var_23_16 * (var_23_21 / var_23_20)

				if var_23_22 > 0 and var_23_16 < var_23_22 then
					arg_20_1.talkMaxDuration = var_23_22

					if var_23_22 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_15
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161005", "story_v_out_420161.awb") ~= 0 then
					local var_23_23 = manager.audio:GetVoiceLength("story_v_out_420161", "420161005", "story_v_out_420161.awb") / 1000

					if var_23_23 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_15
					end

					if var_23_18.prefab_name ~= "" and arg_20_1.actors_[var_23_18.prefab_name] ~= nil then
						local var_23_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_18.prefab_name].transform, "story_v_out_420161", "420161005", "story_v_out_420161.awb")

						arg_20_1:RecordAudio("420161005", var_23_24)
						arg_20_1:RecordAudio("420161005", var_23_24)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_420161", "420161005", "story_v_out_420161.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_420161", "420161005", "story_v_out_420161.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_25 = math.max(var_23_16, arg_20_1.talkMaxDuration)

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_25 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_15) / var_23_25

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_15 + var_23_25 and arg_20_1.time_ < var_23_15 + var_23_25 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play420161006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 420161006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play420161007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1085ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos1085ui_story = var_27_0.localPosition
			end

			local var_27_2 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2
				local var_27_4 = Vector3.New(0, 100, 0)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1085ui_story, var_27_4, var_27_3)

				local var_27_5 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_5.x, var_27_5.y, var_27_5.z)

				local var_27_6 = var_27_0.localEulerAngles

				var_27_6.z = 0
				var_27_6.x = 0
				var_27_0.localEulerAngles = var_27_6
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(0, 100, 0)

				local var_27_7 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_7.x, var_27_7.y, var_27_7.z)

				local var_27_8 = var_27_0.localEulerAngles

				var_27_8.z = 0
				var_27_8.x = 0
				var_27_0.localEulerAngles = var_27_8
			end

			local var_27_9 = 0.05
			local var_27_10 = 1

			if var_27_9 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				local var_27_11 = "play"
				local var_27_12 = "effect"

				arg_24_1:AudioAction(var_27_11, var_27_12, "se_story_140", "se_story_140_transparent04", "")
			end

			local var_27_13 = 0
			local var_27_14 = 0.575

			if var_27_13 < arg_24_1.time_ and arg_24_1.time_ <= var_27_13 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_15 = arg_24_1:GetWordFromCfg(420161006)
				local var_27_16 = arg_24_1:FormatText(var_27_15.content)

				arg_24_1.text_.text = var_27_16

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_17 = 22
				local var_27_18 = utf8.len(var_27_16)
				local var_27_19 = var_27_17 <= 0 and var_27_14 or var_27_14 * (var_27_18 / var_27_17)

				if var_27_19 > 0 and var_27_14 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_13 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_13
					end
				end

				arg_24_1.text_.text = var_27_16
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_20 = math.max(var_27_14, arg_24_1.talkMaxDuration)

			if var_27_13 <= arg_24_1.time_ and arg_24_1.time_ < var_27_13 + var_27_20 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_13) / var_27_20

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_13 + var_27_20 and arg_24_1.time_ < var_27_13 + var_27_20 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play420161007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 420161007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play420161008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0
			local var_31_1 = 1.3

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:GetWordFromCfg(420161007)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 52
				local var_31_5 = utf8.len(var_31_3)
				local var_31_6 = var_31_4 <= 0 and var_31_1 or var_31_1 * (var_31_5 / var_31_4)

				if var_31_6 > 0 and var_31_1 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_7 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_7 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_7

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_7 and arg_28_1.time_ < var_31_0 + var_31_7 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play420161008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 420161008
		arg_32_1.duration_ = 6.5

		local var_32_0 = {
			zh = 5.7,
			ja = 6.5
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play420161009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1085ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos1085ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0, -1.01, -5.83)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1085ui_story, var_35_4, var_35_3)

				local var_35_5 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_5.x, var_35_5.y, var_35_5.z)

				local var_35_6 = var_35_0.localEulerAngles

				var_35_6.z = 0
				var_35_6.x = 0
				var_35_0.localEulerAngles = var_35_6
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_35_7 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_7.x, var_35_7.y, var_35_7.z)

				local var_35_8 = var_35_0.localEulerAngles

				var_35_8.z = 0
				var_35_8.x = 0
				var_35_0.localEulerAngles = var_35_8
			end

			local var_35_9 = arg_32_1.actors_["1085ui_story"]
			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1085ui_story == nil then
				arg_32_1.var_.characterEffect1085ui_story = var_35_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.200000002980232

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_11 and not isNil(var_35_9) then
				local var_35_12 = (arg_32_1.time_ - var_35_10) / var_35_11

				if arg_32_1.var_.characterEffect1085ui_story and not isNil(var_35_9) then
					arg_32_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_10 + var_35_11 and arg_32_1.time_ < var_35_10 + var_35_11 + arg_35_0 and not isNil(var_35_9) and arg_32_1.var_.characterEffect1085ui_story then
				arg_32_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_35_13 = 0
			local var_35_14 = 0.2

			if var_35_13 < arg_32_1.time_ and arg_32_1.time_ <= var_35_13 + arg_35_0 then
				local var_35_15 = "play"
				local var_35_16 = "music"

				arg_32_1:AudioAction(var_35_15, var_35_16, "ui_battle", "ui_battle_stopbgm", "")

				local var_35_17 = ""
				local var_35_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_35_18 ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_18 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_18

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_18
						arg_32_1.bgmTxt2_.text = var_35_18
					end

					if arg_32_1.bgmTimer then
						arg_32_1.bgmTimer:Stop()

						arg_32_1.bgmTimer = nil
					end

					if arg_32_1.settingData.show_music_name == 1 then
						arg_32_1.musicController:SetSelectedState("show")
						arg_32_1.musicAnimator_:Play("open", 0, 0)

						if arg_32_1.settingData.music_time ~= 0 then
							arg_32_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_32_1.settingData.music_time), function()
								if arg_32_1 == nil or isNil(arg_32_1.bgmTxt_) then
									return
								end

								arg_32_1.musicController:SetSelectedState("hide")
								arg_32_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_35_19 = 0.333333333333333
			local var_35_20 = 1

			if var_35_19 < arg_32_1.time_ and arg_32_1.time_ <= var_35_19 + arg_35_0 then
				local var_35_21 = "play"
				local var_35_22 = "music"

				arg_32_1:AudioAction(var_35_21, var_35_22, "bgm_activity_4_0_story_sad", "bgm_activity_4_0_story_sad", "bgm_activity_4_0_story_sad.awb")

				local var_35_23 = ""
				local var_35_24 = manager.audio:GetAudioName("bgm_activity_4_0_story_sad", "bgm_activity_4_0_story_sad")

				if var_35_24 ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_24 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_24

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_24
						arg_32_1.bgmTxt2_.text = var_35_24
					end

					if arg_32_1.bgmTimer then
						arg_32_1.bgmTimer:Stop()

						arg_32_1.bgmTimer = nil
					end

					if arg_32_1.settingData.show_music_name == 1 then
						arg_32_1.musicController:SetSelectedState("show")
						arg_32_1.musicAnimator_:Play("open", 0, 0)

						if arg_32_1.settingData.music_time ~= 0 then
							arg_32_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_32_1.settingData.music_time), function()
								if arg_32_1 == nil or isNil(arg_32_1.bgmTxt_) then
									return
								end

								arg_32_1.musicController:SetSelectedState("hide")
								arg_32_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_35_25 = 0
			local var_35_26 = 0.45

			if var_35_25 < arg_32_1.time_ and arg_32_1.time_ <= var_35_25 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_27 = arg_32_1:FormatText(StoryNameCfg[328].name)

				arg_32_1.leftNameTxt_.text = var_35_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_28 = arg_32_1:GetWordFromCfg(420161008)
				local var_35_29 = arg_32_1:FormatText(var_35_28.content)

				arg_32_1.text_.text = var_35_29

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_30 = 18
				local var_35_31 = utf8.len(var_35_29)
				local var_35_32 = var_35_30 <= 0 and var_35_26 or var_35_26 * (var_35_31 / var_35_30)

				if var_35_32 > 0 and var_35_26 < var_35_32 then
					arg_32_1.talkMaxDuration = var_35_32

					if var_35_32 + var_35_25 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_32 + var_35_25
					end
				end

				arg_32_1.text_.text = var_35_29
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161008", "story_v_out_420161.awb") ~= 0 then
					local var_35_33 = manager.audio:GetVoiceLength("story_v_out_420161", "420161008", "story_v_out_420161.awb") / 1000

					if var_35_33 + var_35_25 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_33 + var_35_25
					end

					if var_35_28.prefab_name ~= "" and arg_32_1.actors_[var_35_28.prefab_name] ~= nil then
						local var_35_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_28.prefab_name].transform, "story_v_out_420161", "420161008", "story_v_out_420161.awb")

						arg_32_1:RecordAudio("420161008", var_35_34)
						arg_32_1:RecordAudio("420161008", var_35_34)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_420161", "420161008", "story_v_out_420161.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_420161", "420161008", "story_v_out_420161.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_35 = math.max(var_35_26, arg_32_1.talkMaxDuration)

			if var_35_25 <= arg_32_1.time_ and arg_32_1.time_ < var_35_25 + var_35_35 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_25) / var_35_35

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_25 + var_35_35 and arg_32_1.time_ < var_35_25 + var_35_35 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play420161009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 420161009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play420161010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1085ui_story"].transform
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.var_.moveOldPos1085ui_story = var_41_0.localPosition
			end

			local var_41_2 = 0.001

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2
				local var_41_4 = Vector3.New(0, 100, 0)

				var_41_0.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1085ui_story, var_41_4, var_41_3)

				local var_41_5 = manager.ui.mainCamera.transform.position - var_41_0.position

				var_41_0.forward = Vector3.New(var_41_5.x, var_41_5.y, var_41_5.z)

				local var_41_6 = var_41_0.localEulerAngles

				var_41_6.z = 0
				var_41_6.x = 0
				var_41_0.localEulerAngles = var_41_6
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 then
				var_41_0.localPosition = Vector3.New(0, 100, 0)

				local var_41_7 = manager.ui.mainCamera.transform.position - var_41_0.position

				var_41_0.forward = Vector3.New(var_41_7.x, var_41_7.y, var_41_7.z)

				local var_41_8 = var_41_0.localEulerAngles

				var_41_8.z = 0
				var_41_8.x = 0
				var_41_0.localEulerAngles = var_41_8
			end

			local var_41_9 = 0
			local var_41_10 = 1.05

			if var_41_9 < arg_38_1.time_ and arg_38_1.time_ <= var_41_9 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_11 = arg_38_1:GetWordFromCfg(420161009)
				local var_41_12 = arg_38_1:FormatText(var_41_11.content)

				arg_38_1.text_.text = var_41_12

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_13 = 42
				local var_41_14 = utf8.len(var_41_12)
				local var_41_15 = var_41_13 <= 0 and var_41_10 or var_41_10 * (var_41_14 / var_41_13)

				if var_41_15 > 0 and var_41_10 < var_41_15 then
					arg_38_1.talkMaxDuration = var_41_15

					if var_41_15 + var_41_9 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_15 + var_41_9
					end
				end

				arg_38_1.text_.text = var_41_12
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_16 = math.max(var_41_10, arg_38_1.talkMaxDuration)

			if var_41_9 <= arg_38_1.time_ and arg_38_1.time_ < var_41_9 + var_41_16 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_9) / var_41_16

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_9 + var_41_16 and arg_38_1.time_ < var_41_9 + var_41_16 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420161010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 420161010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play420161011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.05
			local var_45_1 = 1

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				local var_45_2 = "play"
				local var_45_3 = "effect"

				arg_42_1:AudioAction(var_45_2, var_45_3, "se_story_140", "se_story_140_transparent02", "")
			end

			local var_45_4 = 0
			local var_45_5 = 1.05

			if var_45_4 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_6 = arg_42_1:GetWordFromCfg(420161010)
				local var_45_7 = arg_42_1:FormatText(var_45_6.content)

				arg_42_1.text_.text = var_45_7

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_8 = 42
				local var_45_9 = utf8.len(var_45_7)
				local var_45_10 = var_45_8 <= 0 and var_45_5 or var_45_5 * (var_45_9 / var_45_8)

				if var_45_10 > 0 and var_45_5 < var_45_10 then
					arg_42_1.talkMaxDuration = var_45_10

					if var_45_10 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_4
					end
				end

				arg_42_1.text_.text = var_45_7
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_11 = math.max(var_45_5, arg_42_1.talkMaxDuration)

			if var_45_4 <= arg_42_1.time_ and arg_42_1.time_ < var_45_4 + var_45_11 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_4) / var_45_11

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_4 + var_45_11 and arg_42_1.time_ < var_45_4 + var_45_11 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play420161011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 420161011
		arg_46_1.duration_ = 7

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play420161012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.mask_.enabled = true
				arg_46_1.mask_.raycastTarget = true

				arg_46_1:SetGaussion(false)
			end

			local var_49_1 = 1

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_1 then
				local var_49_2 = (arg_46_1.time_ - var_49_0) / var_49_1
				local var_49_3 = Color.New(0, 0, 0)

				var_49_3.a = Mathf.Lerp(0, 1, var_49_2)
				arg_46_1.mask_.color = var_49_3
			end

			if arg_46_1.time_ >= var_49_0 + var_49_1 and arg_46_1.time_ < var_49_0 + var_49_1 + arg_49_0 then
				local var_49_4 = Color.New(0, 0, 0)

				var_49_4.a = 1
				arg_46_1.mask_.color = var_49_4
			end

			local var_49_5 = 1

			if var_49_5 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.mask_.enabled = true
				arg_46_1.mask_.raycastTarget = true

				arg_46_1:SetGaussion(false)
			end

			local var_49_6 = 1

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_6 then
				local var_49_7 = (arg_46_1.time_ - var_49_5) / var_49_6
				local var_49_8 = Color.New(0, 0, 0)

				var_49_8.a = Mathf.Lerp(1, 0, var_49_7)
				arg_46_1.mask_.color = var_49_8
			end

			if arg_46_1.time_ >= var_49_5 + var_49_6 and arg_46_1.time_ < var_49_5 + var_49_6 + arg_49_0 then
				local var_49_9 = Color.New(0, 0, 0)
				local var_49_10 = 0

				arg_46_1.mask_.enabled = false
				var_49_9.a = var_49_10
				arg_46_1.mask_.color = var_49_9
			end

			local var_49_11 = "ST0504"

			if arg_46_1.bgs_[var_49_11] == nil then
				local var_49_12 = Object.Instantiate(arg_46_1.paintGo_)

				var_49_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_49_11)
				var_49_12.name = var_49_11
				var_49_12.transform.parent = arg_46_1.stage_.transform
				var_49_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.bgs_[var_49_11] = var_49_12
			end

			local var_49_13 = 1

			if var_49_13 < arg_46_1.time_ and arg_46_1.time_ <= var_49_13 + arg_49_0 then
				local var_49_14 = manager.ui.mainCamera.transform.localPosition
				local var_49_15 = Vector3.New(0, 0, 10) + Vector3.New(var_49_14.x, var_49_14.y, 0)
				local var_49_16 = arg_46_1.bgs_.ST0504

				var_49_16.transform.localPosition = var_49_15
				var_49_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_49_17 = var_49_16:GetComponent("SpriteRenderer")

				if var_49_17 and var_49_17.sprite then
					local var_49_18 = (var_49_16.transform.localPosition - var_49_14).z
					local var_49_19 = manager.ui.mainCameraCom_
					local var_49_20 = 2 * var_49_18 * Mathf.Tan(var_49_19.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_49_21 = var_49_20 * var_49_19.aspect
					local var_49_22 = var_49_17.sprite.bounds.size.x
					local var_49_23 = var_49_17.sprite.bounds.size.y
					local var_49_24 = var_49_21 / var_49_22
					local var_49_25 = var_49_20 / var_49_23
					local var_49_26 = var_49_25 < var_49_24 and var_49_24 or var_49_25

					var_49_16.transform.localScale = Vector3.New(var_49_26, var_49_26, 0)
				end

				for iter_49_0, iter_49_1 in pairs(arg_46_1.bgs_) do
					if iter_49_0 ~= "ST0504" then
						iter_49_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_46_1.frameCnt_ <= 1 then
				arg_46_1.dialog_:SetActive(false)
			end

			local var_49_27 = 2
			local var_49_28 = 1.1

			if var_49_27 < arg_46_1.time_ and arg_46_1.time_ <= var_49_27 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				arg_46_1.dialog_:SetActive(true)

				arg_46_1.dialogCg_.alpha = 0

				local var_49_29 = LeanTween.value(arg_46_1.dialog_, 0, 1, 0.3)

				var_49_29:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_46_1.dialogCg_.alpha = arg_50_0
				end))
				var_49_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_46_1.dialog_)
					var_49_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_46_1.duration_ = arg_46_1.duration_ + 0.3

				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_30 = arg_46_1:GetWordFromCfg(420161011)
				local var_49_31 = arg_46_1:FormatText(var_49_30.content)

				arg_46_1.text_.text = var_49_31

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_32 = 44
				local var_49_33 = utf8.len(var_49_31)
				local var_49_34 = var_49_32 <= 0 and var_49_28 or var_49_28 * (var_49_33 / var_49_32)

				if var_49_34 > 0 and var_49_28 < var_49_34 then
					arg_46_1.talkMaxDuration = var_49_34
					var_49_27 = var_49_27 + 0.3

					if var_49_34 + var_49_27 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_34 + var_49_27
					end
				end

				arg_46_1.text_.text = var_49_31
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_35 = var_49_27 + 0.3
			local var_49_36 = math.max(var_49_28, arg_46_1.talkMaxDuration)

			if var_49_35 <= arg_46_1.time_ and arg_46_1.time_ < var_49_35 + var_49_36 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_35) / var_49_36

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_35 + var_49_36 and arg_46_1.time_ < var_49_35 + var_49_36 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play420161012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 420161012
		arg_52_1.duration_ = 5.13

		local var_52_0 = {
			zh = 5.133,
			ja = 5
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play420161013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1085ui_story"].transform
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.var_.moveOldPos1085ui_story = var_55_0.localPosition
			end

			local var_55_2 = 0.001

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2
				local var_55_4 = Vector3.New(0, -1.01, -5.83)

				var_55_0.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1085ui_story, var_55_4, var_55_3)

				local var_55_5 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_5.x, var_55_5.y, var_55_5.z)

				local var_55_6 = var_55_0.localEulerAngles

				var_55_6.z = 0
				var_55_6.x = 0
				var_55_0.localEulerAngles = var_55_6
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 then
				var_55_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_55_7 = manager.ui.mainCamera.transform.position - var_55_0.position

				var_55_0.forward = Vector3.New(var_55_7.x, var_55_7.y, var_55_7.z)

				local var_55_8 = var_55_0.localEulerAngles

				var_55_8.z = 0
				var_55_8.x = 0
				var_55_0.localEulerAngles = var_55_8
			end

			local var_55_9 = arg_52_1.actors_["1085ui_story"]
			local var_55_10 = 0

			if var_55_10 < arg_52_1.time_ and arg_52_1.time_ <= var_55_10 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1085ui_story == nil then
				arg_52_1.var_.characterEffect1085ui_story = var_55_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_11 = 0.200000002980232

			if var_55_10 <= arg_52_1.time_ and arg_52_1.time_ < var_55_10 + var_55_11 and not isNil(var_55_9) then
				local var_55_12 = (arg_52_1.time_ - var_55_10) / var_55_11

				if arg_52_1.var_.characterEffect1085ui_story and not isNil(var_55_9) then
					arg_52_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_10 + var_55_11 and arg_52_1.time_ < var_55_10 + var_55_11 + arg_55_0 and not isNil(var_55_9) and arg_52_1.var_.characterEffect1085ui_story then
				arg_52_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_55_13 = 0

			if var_55_13 < arg_52_1.time_ and arg_52_1.time_ <= var_55_13 + arg_55_0 then
				arg_52_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_1")
			end

			local var_55_14 = 0

			if var_55_14 < arg_52_1.time_ and arg_52_1.time_ <= var_55_14 + arg_55_0 then
				arg_52_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_55_15 = 0
			local var_55_16 = 0.4

			if var_55_15 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_17 = arg_52_1:FormatText(StoryNameCfg[328].name)

				arg_52_1.leftNameTxt_.text = var_55_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_18 = arg_52_1:GetWordFromCfg(420161012)
				local var_55_19 = arg_52_1:FormatText(var_55_18.content)

				arg_52_1.text_.text = var_55_19

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_20 = 16
				local var_55_21 = utf8.len(var_55_19)
				local var_55_22 = var_55_20 <= 0 and var_55_16 or var_55_16 * (var_55_21 / var_55_20)

				if var_55_22 > 0 and var_55_16 < var_55_22 then
					arg_52_1.talkMaxDuration = var_55_22

					if var_55_22 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_22 + var_55_15
					end
				end

				arg_52_1.text_.text = var_55_19
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161012", "story_v_out_420161.awb") ~= 0 then
					local var_55_23 = manager.audio:GetVoiceLength("story_v_out_420161", "420161012", "story_v_out_420161.awb") / 1000

					if var_55_23 + var_55_15 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_23 + var_55_15
					end

					if var_55_18.prefab_name ~= "" and arg_52_1.actors_[var_55_18.prefab_name] ~= nil then
						local var_55_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_18.prefab_name].transform, "story_v_out_420161", "420161012", "story_v_out_420161.awb")

						arg_52_1:RecordAudio("420161012", var_55_24)
						arg_52_1:RecordAudio("420161012", var_55_24)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_420161", "420161012", "story_v_out_420161.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_420161", "420161012", "story_v_out_420161.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_25 = math.max(var_55_16, arg_52_1.talkMaxDuration)

			if var_55_15 <= arg_52_1.time_ and arg_52_1.time_ < var_55_15 + var_55_25 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_15) / var_55_25

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_15 + var_55_25 and arg_52_1.time_ < var_55_15 + var_55_25 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play420161013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 420161013
		arg_56_1.duration_ = 11.77

		local var_56_0 = {
			zh = 9.633,
			ja = 11.766
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
				arg_56_0:Play420161014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1085ui_story"].transform
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.var_.moveOldPos1085ui_story = var_59_0.localPosition
			end

			local var_59_2 = 0.001

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2
				local var_59_4 = Vector3.New(0, 100, 0)

				var_59_0.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1085ui_story, var_59_4, var_59_3)

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

			local var_59_9 = arg_56_1.actors_["1085ui_story"]
			local var_59_10 = 0

			if var_59_10 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1085ui_story == nil then
				arg_56_1.var_.characterEffect1085ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_11 = 0.200000002980232

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_11 and not isNil(var_59_9) then
				local var_59_12 = (arg_56_1.time_ - var_59_10) / var_59_11

				if arg_56_1.var_.characterEffect1085ui_story and not isNil(var_59_9) then
					local var_59_13 = Mathf.Lerp(0, 0.5, var_59_12)

					arg_56_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1085ui_story.fillRatio = var_59_13
				end
			end

			if arg_56_1.time_ >= var_59_10 + var_59_11 and arg_56_1.time_ < var_59_10 + var_59_11 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect1085ui_story then
				local var_59_14 = 0.5

				arg_56_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1085ui_story.fillRatio = var_59_14
			end

			local var_59_15 = "404001ui_story"

			if arg_56_1.actors_[var_59_15] == nil then
				local var_59_16 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_59_16) then
					local var_59_17 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_56_1.stage_.transform)

					var_59_17.name = var_59_15
					var_59_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_56_1.actors_[var_59_15] = var_59_17

					local var_59_18 = var_59_17:GetComponentInChildren(typeof(CharacterEffect))

					var_59_18.enabled = true

					local var_59_19 = GameObjectTools.GetOrAddComponent(var_59_17, typeof(DynamicBoneHelper))

					if var_59_19 then
						var_59_19:EnableDynamicBone(false)
					end

					arg_56_1:ShowWeapon(var_59_18.transform, false)

					arg_56_1.var_[var_59_15 .. "Animator"] = var_59_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_56_1.var_[var_59_15 .. "Animator"].applyRootMotion = true
					arg_56_1.var_[var_59_15 .. "LipSync"] = var_59_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_59_20 = arg_56_1.actors_["404001ui_story"].transform
			local var_59_21 = 0

			if var_59_21 < arg_56_1.time_ and arg_56_1.time_ <= var_59_21 + arg_59_0 then
				arg_56_1.var_.moveOldPos404001ui_story = var_59_20.localPosition
			end

			local var_59_22 = 0.001

			if var_59_21 <= arg_56_1.time_ and arg_56_1.time_ < var_59_21 + var_59_22 then
				local var_59_23 = (arg_56_1.time_ - var_59_21) / var_59_22
				local var_59_24 = Vector3.New(0, -1.55, -5.5)

				var_59_20.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos404001ui_story, var_59_24, var_59_23)

				local var_59_25 = manager.ui.mainCamera.transform.position - var_59_20.position

				var_59_20.forward = Vector3.New(var_59_25.x, var_59_25.y, var_59_25.z)

				local var_59_26 = var_59_20.localEulerAngles

				var_59_26.z = 0
				var_59_26.x = 0
				var_59_20.localEulerAngles = var_59_26
			end

			if arg_56_1.time_ >= var_59_21 + var_59_22 and arg_56_1.time_ < var_59_21 + var_59_22 + arg_59_0 then
				var_59_20.localPosition = Vector3.New(0, -1.55, -5.5)

				local var_59_27 = manager.ui.mainCamera.transform.position - var_59_20.position

				var_59_20.forward = Vector3.New(var_59_27.x, var_59_27.y, var_59_27.z)

				local var_59_28 = var_59_20.localEulerAngles

				var_59_28.z = 0
				var_59_28.x = 0
				var_59_20.localEulerAngles = var_59_28
			end

			local var_59_29 = arg_56_1.actors_["404001ui_story"]
			local var_59_30 = 0

			if var_59_30 < arg_56_1.time_ and arg_56_1.time_ <= var_59_30 + arg_59_0 and not isNil(var_59_29) and arg_56_1.var_.characterEffect404001ui_story == nil then
				arg_56_1.var_.characterEffect404001ui_story = var_59_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_31 = 0.200000002980232

			if var_59_30 <= arg_56_1.time_ and arg_56_1.time_ < var_59_30 + var_59_31 and not isNil(var_59_29) then
				local var_59_32 = (arg_56_1.time_ - var_59_30) / var_59_31

				if arg_56_1.var_.characterEffect404001ui_story and not isNil(var_59_29) then
					arg_56_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_30 + var_59_31 and arg_56_1.time_ < var_59_30 + var_59_31 + arg_59_0 and not isNil(var_59_29) and arg_56_1.var_.characterEffect404001ui_story then
				arg_56_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_59_33 = 0

			if var_59_33 < arg_56_1.time_ and arg_56_1.time_ <= var_59_33 + arg_59_0 then
				arg_56_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_59_34 = 0

			if var_59_34 < arg_56_1.time_ and arg_56_1.time_ <= var_59_34 + arg_59_0 then
				arg_56_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_35 = 0
			local var_59_36 = 1.1

			if var_59_35 < arg_56_1.time_ and arg_56_1.time_ <= var_59_35 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_37 = arg_56_1:FormatText(StoryNameCfg[668].name)

				arg_56_1.leftNameTxt_.text = var_59_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_38 = arg_56_1:GetWordFromCfg(420161013)
				local var_59_39 = arg_56_1:FormatText(var_59_38.content)

				arg_56_1.text_.text = var_59_39

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_40 = 44
				local var_59_41 = utf8.len(var_59_39)
				local var_59_42 = var_59_40 <= 0 and var_59_36 or var_59_36 * (var_59_41 / var_59_40)

				if var_59_42 > 0 and var_59_36 < var_59_42 then
					arg_56_1.talkMaxDuration = var_59_42

					if var_59_42 + var_59_35 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_42 + var_59_35
					end
				end

				arg_56_1.text_.text = var_59_39
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161013", "story_v_out_420161.awb") ~= 0 then
					local var_59_43 = manager.audio:GetVoiceLength("story_v_out_420161", "420161013", "story_v_out_420161.awb") / 1000

					if var_59_43 + var_59_35 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_43 + var_59_35
					end

					if var_59_38.prefab_name ~= "" and arg_56_1.actors_[var_59_38.prefab_name] ~= nil then
						local var_59_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_38.prefab_name].transform, "story_v_out_420161", "420161013", "story_v_out_420161.awb")

						arg_56_1:RecordAudio("420161013", var_59_44)
						arg_56_1:RecordAudio("420161013", var_59_44)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_420161", "420161013", "story_v_out_420161.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_420161", "420161013", "story_v_out_420161.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_45 = math.max(var_59_36, arg_56_1.talkMaxDuration)

			if var_59_35 <= arg_56_1.time_ and arg_56_1.time_ < var_59_35 + var_59_45 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_35) / var_59_45

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_35 + var_59_45 and arg_56_1.time_ < var_59_35 + var_59_45 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
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
	Play420161014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 420161014
		arg_60_1.duration_ = 9.23

		local var_60_0 = {
			zh = 9.233,
			ja = 8.833
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play420161015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.85

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[668].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:GetWordFromCfg(420161014)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 34
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161014", "story_v_out_420161.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_420161", "420161014", "story_v_out_420161.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_420161", "420161014", "story_v_out_420161.awb")

						arg_60_1:RecordAudio("420161014", var_63_9)
						arg_60_1:RecordAudio("420161014", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_420161", "420161014", "story_v_out_420161.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_420161", "420161014", "story_v_out_420161.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_10 and arg_60_1.time_ < var_63_0 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play420161015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 420161015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play420161016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["404001ui_story"].transform
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.var_.moveOldPos404001ui_story = var_67_0.localPosition
			end

			local var_67_2 = 0.001

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2
				local var_67_4 = Vector3.New(0, 100, 0)

				var_67_0.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos404001ui_story, var_67_4, var_67_3)

				local var_67_5 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_5.x, var_67_5.y, var_67_5.z)

				local var_67_6 = var_67_0.localEulerAngles

				var_67_6.z = 0
				var_67_6.x = 0
				var_67_0.localEulerAngles = var_67_6
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 then
				var_67_0.localPosition = Vector3.New(0, 100, 0)

				local var_67_7 = manager.ui.mainCamera.transform.position - var_67_0.position

				var_67_0.forward = Vector3.New(var_67_7.x, var_67_7.y, var_67_7.z)

				local var_67_8 = var_67_0.localEulerAngles

				var_67_8.z = 0
				var_67_8.x = 0
				var_67_0.localEulerAngles = var_67_8
			end

			local var_67_9 = 0.9
			local var_67_10 = 1

			if var_67_9 < arg_64_1.time_ and arg_64_1.time_ <= var_67_9 + arg_67_0 then
				local var_67_11 = "play"
				local var_67_12 = "effect"

				arg_64_1:AudioAction(var_67_11, var_67_12, "se_story_140", "se_story_140_transparent03", "")
			end

			local var_67_13 = 0
			local var_67_14 = 1.3

			if var_67_13 < arg_64_1.time_ and arg_64_1.time_ <= var_67_13 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_15 = arg_64_1:GetWordFromCfg(420161015)
				local var_67_16 = arg_64_1:FormatText(var_67_15.content)

				arg_64_1.text_.text = var_67_16

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_17 = 52
				local var_67_18 = utf8.len(var_67_16)
				local var_67_19 = var_67_17 <= 0 and var_67_14 or var_67_14 * (var_67_18 / var_67_17)

				if var_67_19 > 0 and var_67_14 < var_67_19 then
					arg_64_1.talkMaxDuration = var_67_19

					if var_67_19 + var_67_13 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_19 + var_67_13
					end
				end

				arg_64_1.text_.text = var_67_16
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_20 = math.max(var_67_14, arg_64_1.talkMaxDuration)

			if var_67_13 <= arg_64_1.time_ and arg_64_1.time_ < var_67_13 + var_67_20 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_13) / var_67_20

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_13 + var_67_20 and arg_64_1.time_ < var_67_13 + var_67_20 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play420161016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 420161016
		arg_68_1.duration_ = 5.1

		local var_68_0 = {
			zh = 1.9,
			ja = 5.1
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play420161017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["1085ui_story"].transform
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.var_.moveOldPos1085ui_story = var_71_0.localPosition
			end

			local var_71_2 = 0.001

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2
				local var_71_4 = Vector3.New(0, -1.01, -5.83)

				var_71_0.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1085ui_story, var_71_4, var_71_3)

				local var_71_5 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_5.x, var_71_5.y, var_71_5.z)

				local var_71_6 = var_71_0.localEulerAngles

				var_71_6.z = 0
				var_71_6.x = 0
				var_71_0.localEulerAngles = var_71_6
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 then
				var_71_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_71_7 = manager.ui.mainCamera.transform.position - var_71_0.position

				var_71_0.forward = Vector3.New(var_71_7.x, var_71_7.y, var_71_7.z)

				local var_71_8 = var_71_0.localEulerAngles

				var_71_8.z = 0
				var_71_8.x = 0
				var_71_0.localEulerAngles = var_71_8
			end

			local var_71_9 = arg_68_1.actors_["1085ui_story"]
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1085ui_story == nil then
				arg_68_1.var_.characterEffect1085ui_story = var_71_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_11 = 0.200000002980232

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 and not isNil(var_71_9) then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11

				if arg_68_1.var_.characterEffect1085ui_story and not isNil(var_71_9) then
					arg_68_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 and not isNil(var_71_9) and arg_68_1.var_.characterEffect1085ui_story then
				arg_68_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_71_13 = 0
			local var_71_14 = 0.225

			if var_71_13 < arg_68_1.time_ and arg_68_1.time_ <= var_71_13 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_15 = arg_68_1:FormatText(StoryNameCfg[328].name)

				arg_68_1.leftNameTxt_.text = var_71_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_16 = arg_68_1:GetWordFromCfg(420161016)
				local var_71_17 = arg_68_1:FormatText(var_71_16.content)

				arg_68_1.text_.text = var_71_17

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_18 = 9
				local var_71_19 = utf8.len(var_71_17)
				local var_71_20 = var_71_18 <= 0 and var_71_14 or var_71_14 * (var_71_19 / var_71_18)

				if var_71_20 > 0 and var_71_14 < var_71_20 then
					arg_68_1.talkMaxDuration = var_71_20

					if var_71_20 + var_71_13 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_20 + var_71_13
					end
				end

				arg_68_1.text_.text = var_71_17
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161016", "story_v_out_420161.awb") ~= 0 then
					local var_71_21 = manager.audio:GetVoiceLength("story_v_out_420161", "420161016", "story_v_out_420161.awb") / 1000

					if var_71_21 + var_71_13 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_21 + var_71_13
					end

					if var_71_16.prefab_name ~= "" and arg_68_1.actors_[var_71_16.prefab_name] ~= nil then
						local var_71_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_16.prefab_name].transform, "story_v_out_420161", "420161016", "story_v_out_420161.awb")

						arg_68_1:RecordAudio("420161016", var_71_22)
						arg_68_1:RecordAudio("420161016", var_71_22)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_420161", "420161016", "story_v_out_420161.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_420161", "420161016", "story_v_out_420161.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_23 = math.max(var_71_14, arg_68_1.talkMaxDuration)

			if var_71_13 <= arg_68_1.time_ and arg_68_1.time_ < var_71_13 + var_71_23 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_13) / var_71_23

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_13 + var_71_23 and arg_68_1.time_ < var_71_13 + var_71_23 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play420161017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 420161017
		arg_72_1.duration_ = 5.43

		local var_72_0 = {
			zh = 2,
			ja = 5.433
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play420161018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_2")
			end

			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			local var_75_2 = 0.666666666666667

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			local var_75_3 = 0
			local var_75_4 = 0.125

			if var_75_3 < arg_72_1.time_ and arg_72_1.time_ <= var_75_3 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_5 = arg_72_1:FormatText(StoryNameCfg[328].name)

				arg_72_1.leftNameTxt_.text = var_75_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_6 = arg_72_1:GetWordFromCfg(420161017)
				local var_75_7 = arg_72_1:FormatText(var_75_6.content)

				arg_72_1.text_.text = var_75_7

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_8 = 5
				local var_75_9 = utf8.len(var_75_7)
				local var_75_10 = var_75_8 <= 0 and var_75_4 or var_75_4 * (var_75_9 / var_75_8)

				if var_75_10 > 0 and var_75_4 < var_75_10 then
					arg_72_1.talkMaxDuration = var_75_10

					if var_75_10 + var_75_3 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_3
					end
				end

				arg_72_1.text_.text = var_75_7
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161017", "story_v_out_420161.awb") ~= 0 then
					local var_75_11 = manager.audio:GetVoiceLength("story_v_out_420161", "420161017", "story_v_out_420161.awb") / 1000

					if var_75_11 + var_75_3 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_3
					end

					if var_75_6.prefab_name ~= "" and arg_72_1.actors_[var_75_6.prefab_name] ~= nil then
						local var_75_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_6.prefab_name].transform, "story_v_out_420161", "420161017", "story_v_out_420161.awb")

						arg_72_1:RecordAudio("420161017", var_75_12)
						arg_72_1:RecordAudio("420161017", var_75_12)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_420161", "420161017", "story_v_out_420161.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_420161", "420161017", "story_v_out_420161.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_13 = math.max(var_75_4, arg_72_1.talkMaxDuration)

			if var_75_3 <= arg_72_1.time_ and arg_72_1.time_ < var_75_3 + var_75_13 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_3) / var_75_13

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_3 + var_75_13 and arg_72_1.time_ < var_75_3 + var_75_13 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play420161018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 420161018
		arg_76_1.duration_ = 9

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play420161019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 4

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.allBtn_.enabled = false
			end

			local var_79_1 = 0.733333333333333

			if arg_76_1.time_ >= var_79_0 + var_79_1 and arg_76_1.time_ < var_79_0 + var_79_1 + arg_79_0 then
				arg_76_1.allBtn_.enabled = true
			end

			local var_79_2 = "ST61"

			if arg_76_1.bgs_[var_79_2] == nil then
				local var_79_3 = Object.Instantiate(arg_76_1.paintGo_)

				var_79_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_79_2)
				var_79_3.name = var_79_2
				var_79_3.transform.parent = arg_76_1.stage_.transform
				var_79_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.bgs_[var_79_2] = var_79_3
			end

			local var_79_4 = 2

			if var_79_4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				local var_79_5 = manager.ui.mainCamera.transform.localPosition
				local var_79_6 = Vector3.New(0, 0, 10) + Vector3.New(var_79_5.x, var_79_5.y, 0)
				local var_79_7 = arg_76_1.bgs_.ST61

				var_79_7.transform.localPosition = var_79_6
				var_79_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_8 = var_79_7:GetComponent("SpriteRenderer")

				if var_79_8 and var_79_8.sprite then
					local var_79_9 = (var_79_7.transform.localPosition - var_79_5).z
					local var_79_10 = manager.ui.mainCameraCom_
					local var_79_11 = 2 * var_79_9 * Mathf.Tan(var_79_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_79_12 = var_79_11 * var_79_10.aspect
					local var_79_13 = var_79_8.sprite.bounds.size.x
					local var_79_14 = var_79_8.sprite.bounds.size.y
					local var_79_15 = var_79_12 / var_79_13
					local var_79_16 = var_79_11 / var_79_14
					local var_79_17 = var_79_16 < var_79_15 and var_79_15 or var_79_16

					var_79_7.transform.localScale = Vector3.New(var_79_17, var_79_17, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "ST61" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_79_18 = 0

			if var_79_18 < arg_76_1.time_ and arg_76_1.time_ <= var_79_18 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_19 = 2

			if var_79_18 <= arg_76_1.time_ and arg_76_1.time_ < var_79_18 + var_79_19 then
				local var_79_20 = (arg_76_1.time_ - var_79_18) / var_79_19
				local var_79_21 = Color.New(0, 0, 0)

				var_79_21.a = Mathf.Lerp(0, 1, var_79_20)
				arg_76_1.mask_.color = var_79_21
			end

			if arg_76_1.time_ >= var_79_18 + var_79_19 and arg_76_1.time_ < var_79_18 + var_79_19 + arg_79_0 then
				local var_79_22 = Color.New(0, 0, 0)

				var_79_22.a = 1
				arg_76_1.mask_.color = var_79_22
			end

			local var_79_23 = 2

			if var_79_23 < arg_76_1.time_ and arg_76_1.time_ <= var_79_23 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_24 = 2

			if var_79_23 <= arg_76_1.time_ and arg_76_1.time_ < var_79_23 + var_79_24 then
				local var_79_25 = (arg_76_1.time_ - var_79_23) / var_79_24
				local var_79_26 = Color.New(0, 0, 0)

				var_79_26.a = Mathf.Lerp(1, 0, var_79_25)
				arg_76_1.mask_.color = var_79_26
			end

			if arg_76_1.time_ >= var_79_23 + var_79_24 and arg_76_1.time_ < var_79_23 + var_79_24 + arg_79_0 then
				local var_79_27 = Color.New(0, 0, 0)
				local var_79_28 = 0

				arg_76_1.mask_.enabled = false
				var_79_27.a = var_79_28
				arg_76_1.mask_.color = var_79_27
			end

			local var_79_29 = arg_76_1.actors_["1085ui_story"].transform
			local var_79_30 = 1.96599999815226

			if var_79_30 < arg_76_1.time_ and arg_76_1.time_ <= var_79_30 + arg_79_0 then
				arg_76_1.var_.moveOldPos1085ui_story = var_79_29.localPosition
			end

			local var_79_31 = 0.001

			if var_79_30 <= arg_76_1.time_ and arg_76_1.time_ < var_79_30 + var_79_31 then
				local var_79_32 = (arg_76_1.time_ - var_79_30) / var_79_31
				local var_79_33 = Vector3.New(0, 100, 0)

				var_79_29.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1085ui_story, var_79_33, var_79_32)

				local var_79_34 = manager.ui.mainCamera.transform.position - var_79_29.position

				var_79_29.forward = Vector3.New(var_79_34.x, var_79_34.y, var_79_34.z)

				local var_79_35 = var_79_29.localEulerAngles

				var_79_35.z = 0
				var_79_35.x = 0
				var_79_29.localEulerAngles = var_79_35
			end

			if arg_76_1.time_ >= var_79_30 + var_79_31 and arg_76_1.time_ < var_79_30 + var_79_31 + arg_79_0 then
				var_79_29.localPosition = Vector3.New(0, 100, 0)

				local var_79_36 = manager.ui.mainCamera.transform.position - var_79_29.position

				var_79_29.forward = Vector3.New(var_79_36.x, var_79_36.y, var_79_36.z)

				local var_79_37 = var_79_29.localEulerAngles

				var_79_37.z = 0
				var_79_37.x = 0
				var_79_29.localEulerAngles = var_79_37
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_38 = 4
			local var_79_39 = 1.25

			if var_79_38 < arg_76_1.time_ and arg_76_1.time_ <= var_79_38 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_40 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_40:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_40:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_40:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_41 = arg_76_1:GetWordFromCfg(420161018)
				local var_79_42 = arg_76_1:FormatText(var_79_41.content)

				arg_76_1.text_.text = var_79_42

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_43 = 50
				local var_79_44 = utf8.len(var_79_42)
				local var_79_45 = var_79_43 <= 0 and var_79_39 or var_79_39 * (var_79_44 / var_79_43)

				if var_79_45 > 0 and var_79_39 < var_79_45 then
					arg_76_1.talkMaxDuration = var_79_45
					var_79_38 = var_79_38 + 0.3

					if var_79_45 + var_79_38 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_45 + var_79_38
					end
				end

				arg_76_1.text_.text = var_79_42
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_46 = var_79_38 + 0.3
			local var_79_47 = math.max(var_79_39, arg_76_1.talkMaxDuration)

			if var_79_46 <= arg_76_1.time_ and arg_76_1.time_ < var_79_46 + var_79_47 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_46) / var_79_47

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_46 + var_79_47 and arg_76_1.time_ < var_79_46 + var_79_47 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play420161019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 420161019
		arg_82_1.duration_ = 5.53

		local var_82_0 = {
			zh = 3.566,
			ja = 5.533
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
				arg_82_0:Play420161020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["1085ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos1085ui_story = var_85_0.localPosition
			end

			local var_85_2 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2
				local var_85_4 = Vector3.New(0, -1.01, -5.83)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1085ui_story, var_85_4, var_85_3)

				local var_85_5 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_5.x, var_85_5.y, var_85_5.z)

				local var_85_6 = var_85_0.localEulerAngles

				var_85_6.z = 0
				var_85_6.x = 0
				var_85_0.localEulerAngles = var_85_6
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_85_7 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_7.x, var_85_7.y, var_85_7.z)

				local var_85_8 = var_85_0.localEulerAngles

				var_85_8.z = 0
				var_85_8.x = 0
				var_85_0.localEulerAngles = var_85_8
			end

			local var_85_9 = arg_82_1.actors_["1085ui_story"]
			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect1085ui_story == nil then
				arg_82_1.var_.characterEffect1085ui_story = var_85_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_11 = 0.200000002980232

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_11 and not isNil(var_85_9) then
				local var_85_12 = (arg_82_1.time_ - var_85_10) / var_85_11

				if arg_82_1.var_.characterEffect1085ui_story and not isNil(var_85_9) then
					arg_82_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_10 + var_85_11 and arg_82_1.time_ < var_85_10 + var_85_11 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect1085ui_story then
				arg_82_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_85_13 = 0

			if var_85_13 < arg_82_1.time_ and arg_82_1.time_ <= var_85_13 + arg_85_0 then
				arg_82_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_85_14 = 0
			local var_85_15 = 0.3

			if var_85_14 < arg_82_1.time_ and arg_82_1.time_ <= var_85_14 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_16 = arg_82_1:FormatText(StoryNameCfg[328].name)

				arg_82_1.leftNameTxt_.text = var_85_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_17 = arg_82_1:GetWordFromCfg(420161019)
				local var_85_18 = arg_82_1:FormatText(var_85_17.content)

				arg_82_1.text_.text = var_85_18

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_19 = 12
				local var_85_20 = utf8.len(var_85_18)
				local var_85_21 = var_85_19 <= 0 and var_85_15 or var_85_15 * (var_85_20 / var_85_19)

				if var_85_21 > 0 and var_85_15 < var_85_21 then
					arg_82_1.talkMaxDuration = var_85_21

					if var_85_21 + var_85_14 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_21 + var_85_14
					end
				end

				arg_82_1.text_.text = var_85_18
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161019", "story_v_out_420161.awb") ~= 0 then
					local var_85_22 = manager.audio:GetVoiceLength("story_v_out_420161", "420161019", "story_v_out_420161.awb") / 1000

					if var_85_22 + var_85_14 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_22 + var_85_14
					end

					if var_85_17.prefab_name ~= "" and arg_82_1.actors_[var_85_17.prefab_name] ~= nil then
						local var_85_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_17.prefab_name].transform, "story_v_out_420161", "420161019", "story_v_out_420161.awb")

						arg_82_1:RecordAudio("420161019", var_85_23)
						arg_82_1:RecordAudio("420161019", var_85_23)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_420161", "420161019", "story_v_out_420161.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_420161", "420161019", "story_v_out_420161.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_24 = math.max(var_85_15, arg_82_1.talkMaxDuration)

			if var_85_14 <= arg_82_1.time_ and arg_82_1.time_ < var_85_14 + var_85_24 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_14) / var_85_24

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_14 + var_85_24 and arg_82_1.time_ < var_85_14 + var_85_24 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play420161020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 420161020
		arg_86_1.duration_ = 10.17

		local var_86_0 = {
			zh = 6.466,
			ja = 10.166
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
				arg_86_0:Play420161021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1085ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1085ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(-0.75, -1.01, -5.83)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1085ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(-0.75, -1.01, -5.83)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = arg_86_1.actors_["1085ui_story"]
			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect1085ui_story == nil then
				arg_86_1.var_.characterEffect1085ui_story = var_89_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_11 = 0.200000002980232

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_11 and not isNil(var_89_9) then
				local var_89_12 = (arg_86_1.time_ - var_89_10) / var_89_11

				if arg_86_1.var_.characterEffect1085ui_story and not isNil(var_89_9) then
					local var_89_13 = Mathf.Lerp(0, 0.5, var_89_12)

					arg_86_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1085ui_story.fillRatio = var_89_13
				end
			end

			if arg_86_1.time_ >= var_89_10 + var_89_11 and arg_86_1.time_ < var_89_10 + var_89_11 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect1085ui_story then
				local var_89_14 = 0.5

				arg_86_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1085ui_story.fillRatio = var_89_14
			end

			local var_89_15 = "1089ui_story"

			if arg_86_1.actors_[var_89_15] == nil then
				local var_89_16 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_89_16) then
					local var_89_17 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_86_1.stage_.transform)

					var_89_17.name = var_89_15
					var_89_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_86_1.actors_[var_89_15] = var_89_17

					local var_89_18 = var_89_17:GetComponentInChildren(typeof(CharacterEffect))

					var_89_18.enabled = true

					local var_89_19 = GameObjectTools.GetOrAddComponent(var_89_17, typeof(DynamicBoneHelper))

					if var_89_19 then
						var_89_19:EnableDynamicBone(false)
					end

					arg_86_1:ShowWeapon(var_89_18.transform, false)

					arg_86_1.var_[var_89_15 .. "Animator"] = var_89_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_86_1.var_[var_89_15 .. "Animator"].applyRootMotion = true
					arg_86_1.var_[var_89_15 .. "LipSync"] = var_89_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_89_20 = arg_86_1.actors_["1089ui_story"].transform
			local var_89_21 = 0

			if var_89_21 < arg_86_1.time_ and arg_86_1.time_ <= var_89_21 + arg_89_0 then
				arg_86_1.var_.moveOldPos1089ui_story = var_89_20.localPosition

				local var_89_22 = "1089ui_story"

				arg_86_1:ShowWeapon(arg_86_1.var_[var_89_22 .. "Animator"].transform, false)
			end

			local var_89_23 = 0.001

			if var_89_21 <= arg_86_1.time_ and arg_86_1.time_ < var_89_21 + var_89_23 then
				local var_89_24 = (arg_86_1.time_ - var_89_21) / var_89_23
				local var_89_25 = Vector3.New(0.7, -1.1, -6.17)

				var_89_20.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1089ui_story, var_89_25, var_89_24)

				local var_89_26 = manager.ui.mainCamera.transform.position - var_89_20.position

				var_89_20.forward = Vector3.New(var_89_26.x, var_89_26.y, var_89_26.z)

				local var_89_27 = var_89_20.localEulerAngles

				var_89_27.z = 0
				var_89_27.x = 0
				var_89_20.localEulerAngles = var_89_27
			end

			if arg_86_1.time_ >= var_89_21 + var_89_23 and arg_86_1.time_ < var_89_21 + var_89_23 + arg_89_0 then
				var_89_20.localPosition = Vector3.New(0.7, -1.1, -6.17)

				local var_89_28 = manager.ui.mainCamera.transform.position - var_89_20.position

				var_89_20.forward = Vector3.New(var_89_28.x, var_89_28.y, var_89_28.z)

				local var_89_29 = var_89_20.localEulerAngles

				var_89_29.z = 0
				var_89_29.x = 0
				var_89_20.localEulerAngles = var_89_29
			end

			local var_89_30 = arg_86_1.actors_["1089ui_story"]
			local var_89_31 = 0

			if var_89_31 < arg_86_1.time_ and arg_86_1.time_ <= var_89_31 + arg_89_0 and not isNil(var_89_30) and arg_86_1.var_.characterEffect1089ui_story == nil then
				arg_86_1.var_.characterEffect1089ui_story = var_89_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_32 = 0.200000002980232

			if var_89_31 <= arg_86_1.time_ and arg_86_1.time_ < var_89_31 + var_89_32 and not isNil(var_89_30) then
				local var_89_33 = (arg_86_1.time_ - var_89_31) / var_89_32

				if arg_86_1.var_.characterEffect1089ui_story and not isNil(var_89_30) then
					arg_86_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_31 + var_89_32 and arg_86_1.time_ < var_89_31 + var_89_32 + arg_89_0 and not isNil(var_89_30) and arg_86_1.var_.characterEffect1089ui_story then
				arg_86_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_89_34 = 0

			if var_89_34 < arg_86_1.time_ and arg_86_1.time_ <= var_89_34 + arg_89_0 then
				arg_86_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_89_35 = 0

			if var_89_35 < arg_86_1.time_ and arg_86_1.time_ <= var_89_35 + arg_89_0 then
				arg_86_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_89_36 = 0
			local var_89_37 = 0.625

			if var_89_36 < arg_86_1.time_ and arg_86_1.time_ <= var_89_36 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_38 = arg_86_1:FormatText(StoryNameCfg[1031].name)

				arg_86_1.leftNameTxt_.text = var_89_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_39 = arg_86_1:GetWordFromCfg(420161020)
				local var_89_40 = arg_86_1:FormatText(var_89_39.content)

				arg_86_1.text_.text = var_89_40

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_41 = 25
				local var_89_42 = utf8.len(var_89_40)
				local var_89_43 = var_89_41 <= 0 and var_89_37 or var_89_37 * (var_89_42 / var_89_41)

				if var_89_43 > 0 and var_89_37 < var_89_43 then
					arg_86_1.talkMaxDuration = var_89_43

					if var_89_43 + var_89_36 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_43 + var_89_36
					end
				end

				arg_86_1.text_.text = var_89_40
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161020", "story_v_out_420161.awb") ~= 0 then
					local var_89_44 = manager.audio:GetVoiceLength("story_v_out_420161", "420161020", "story_v_out_420161.awb") / 1000

					if var_89_44 + var_89_36 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_44 + var_89_36
					end

					if var_89_39.prefab_name ~= "" and arg_86_1.actors_[var_89_39.prefab_name] ~= nil then
						local var_89_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_39.prefab_name].transform, "story_v_out_420161", "420161020", "story_v_out_420161.awb")

						arg_86_1:RecordAudio("420161020", var_89_45)
						arg_86_1:RecordAudio("420161020", var_89_45)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_420161", "420161020", "story_v_out_420161.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_420161", "420161020", "story_v_out_420161.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_46 = math.max(var_89_37, arg_86_1.talkMaxDuration)

			if var_89_36 <= arg_86_1.time_ and arg_86_1.time_ < var_89_36 + var_89_46 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_36) / var_89_46

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_36 + var_89_46 and arg_86_1.time_ < var_89_36 + var_89_46 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play420161021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 420161021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play420161022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1089ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1089ui_story == nil then
				arg_90_1.var_.characterEffect1089ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1089ui_story and not isNil(var_93_0) then
					local var_93_4 = Mathf.Lerp(0, 0.5, var_93_3)

					arg_90_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1089ui_story.fillRatio = var_93_4
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1089ui_story then
				local var_93_5 = 0.5

				arg_90_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1089ui_story.fillRatio = var_93_5
			end

			local var_93_6 = arg_90_1.actors_["1085ui_story"]
			local var_93_7 = 0

			if var_93_7 < arg_90_1.time_ and arg_90_1.time_ <= var_93_7 + arg_93_0 and not isNil(var_93_6) and arg_90_1.var_.characterEffect1085ui_story == nil then
				arg_90_1.var_.characterEffect1085ui_story = var_93_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_8 = 0.200000002980232

			if var_93_7 <= arg_90_1.time_ and arg_90_1.time_ < var_93_7 + var_93_8 and not isNil(var_93_6) then
				local var_93_9 = (arg_90_1.time_ - var_93_7) / var_93_8

				if arg_90_1.var_.characterEffect1085ui_story and not isNil(var_93_6) then
					local var_93_10 = Mathf.Lerp(0, 0.5, var_93_9)

					arg_90_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1085ui_story.fillRatio = var_93_10
				end
			end

			if arg_90_1.time_ >= var_93_7 + var_93_8 and arg_90_1.time_ < var_93_7 + var_93_8 + arg_93_0 and not isNil(var_93_6) and arg_90_1.var_.characterEffect1085ui_story then
				local var_93_11 = 0.5

				arg_90_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1085ui_story.fillRatio = var_93_11
			end

			local var_93_12 = 0
			local var_93_13 = 0.625

			if var_93_12 < arg_90_1.time_ and arg_90_1.time_ <= var_93_12 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_14 = arg_90_1:FormatText(StoryNameCfg[7].name)

				arg_90_1.leftNameTxt_.text = var_93_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_15 = arg_90_1:GetWordFromCfg(420161021)
				local var_93_16 = arg_90_1:FormatText(var_93_15.content)

				arg_90_1.text_.text = var_93_16

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_17 = 25
				local var_93_18 = utf8.len(var_93_16)
				local var_93_19 = var_93_17 <= 0 and var_93_13 or var_93_13 * (var_93_18 / var_93_17)

				if var_93_19 > 0 and var_93_13 < var_93_19 then
					arg_90_1.talkMaxDuration = var_93_19

					if var_93_19 + var_93_12 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_19 + var_93_12
					end
				end

				arg_90_1.text_.text = var_93_16
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_20 = math.max(var_93_13, arg_90_1.talkMaxDuration)

			if var_93_12 <= arg_90_1.time_ and arg_90_1.time_ < var_93_12 + var_93_20 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_12) / var_93_20

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_12 + var_93_20 and arg_90_1.time_ < var_93_12 + var_93_20 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play420161022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 420161022
		arg_94_1.duration_ = 6.83

		local var_94_0 = {
			zh = 5.433,
			ja = 6.833
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
				arg_94_0:Play420161023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1089ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1089ui_story == nil then
				arg_94_1.var_.characterEffect1089ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect1089ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect1089ui_story then
				arg_94_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_97_4 = 0

			if var_97_4 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_97_6 = 0
			local var_97_7 = 0.5

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_8 = arg_94_1:FormatText(StoryNameCfg[1031].name)

				arg_94_1.leftNameTxt_.text = var_97_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_9 = arg_94_1:GetWordFromCfg(420161022)
				local var_97_10 = arg_94_1:FormatText(var_97_9.content)

				arg_94_1.text_.text = var_97_10

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 20
				local var_97_12 = utf8.len(var_97_10)
				local var_97_13 = var_97_11 <= 0 and var_97_7 or var_97_7 * (var_97_12 / var_97_11)

				if var_97_13 > 0 and var_97_7 < var_97_13 then
					arg_94_1.talkMaxDuration = var_97_13

					if var_97_13 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_13 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_10
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161022", "story_v_out_420161.awb") ~= 0 then
					local var_97_14 = manager.audio:GetVoiceLength("story_v_out_420161", "420161022", "story_v_out_420161.awb") / 1000

					if var_97_14 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_14 + var_97_6
					end

					if var_97_9.prefab_name ~= "" and arg_94_1.actors_[var_97_9.prefab_name] ~= nil then
						local var_97_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_9.prefab_name].transform, "story_v_out_420161", "420161022", "story_v_out_420161.awb")

						arg_94_1:RecordAudio("420161022", var_97_15)
						arg_94_1:RecordAudio("420161022", var_97_15)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_420161", "420161022", "story_v_out_420161.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_420161", "420161022", "story_v_out_420161.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_16 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_16 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_16

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_16 and arg_94_1.time_ < var_97_6 + var_97_16 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play420161023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 420161023
		arg_98_1.duration_ = 5.97

		local var_98_0 = {
			zh = 3.8,
			ja = 5.966
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
				arg_98_0:Play420161024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1085ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1085ui_story == nil then
				arg_98_1.var_.characterEffect1085ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1085ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1085ui_story then
				arg_98_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["1089ui_story"]
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1089ui_story == nil then
				arg_98_1.var_.characterEffect1089ui_story = var_101_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.200000002980232

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 and not isNil(var_101_4) then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6

				if arg_98_1.var_.characterEffect1089ui_story and not isNil(var_101_4) then
					local var_101_8 = Mathf.Lerp(0, 0.5, var_101_7)

					arg_98_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1089ui_story.fillRatio = var_101_8
				end
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect1089ui_story then
				local var_101_9 = 0.5

				arg_98_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1089ui_story.fillRatio = var_101_9
			end

			local var_101_10 = 0
			local var_101_11 = 0.375

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_12 = arg_98_1:FormatText(StoryNameCfg[328].name)

				arg_98_1.leftNameTxt_.text = var_101_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_13 = arg_98_1:GetWordFromCfg(420161023)
				local var_101_14 = arg_98_1:FormatText(var_101_13.content)

				arg_98_1.text_.text = var_101_14

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_15 = 15
				local var_101_16 = utf8.len(var_101_14)
				local var_101_17 = var_101_15 <= 0 and var_101_11 or var_101_11 * (var_101_16 / var_101_15)

				if var_101_17 > 0 and var_101_11 < var_101_17 then
					arg_98_1.talkMaxDuration = var_101_17

					if var_101_17 + var_101_10 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_17 + var_101_10
					end
				end

				arg_98_1.text_.text = var_101_14
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161023", "story_v_out_420161.awb") ~= 0 then
					local var_101_18 = manager.audio:GetVoiceLength("story_v_out_420161", "420161023", "story_v_out_420161.awb") / 1000

					if var_101_18 + var_101_10 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_18 + var_101_10
					end

					if var_101_13.prefab_name ~= "" and arg_98_1.actors_[var_101_13.prefab_name] ~= nil then
						local var_101_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_13.prefab_name].transform, "story_v_out_420161", "420161023", "story_v_out_420161.awb")

						arg_98_1:RecordAudio("420161023", var_101_19)
						arg_98_1:RecordAudio("420161023", var_101_19)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_420161", "420161023", "story_v_out_420161.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_420161", "420161023", "story_v_out_420161.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_20 = math.max(var_101_11, arg_98_1.talkMaxDuration)

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_20 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_10) / var_101_20

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_10 + var_101_20 and arg_98_1.time_ < var_101_10 + var_101_20 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play420161024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 420161024
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play420161025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1085ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos1085ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(0, 100, 0)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1085ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0, 100, 0)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = arg_102_1.actors_["1089ui_story"].transform
			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1.var_.moveOldPos1089ui_story = var_105_9.localPosition
			end

			local var_105_11 = 0.001

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_11 then
				local var_105_12 = (arg_102_1.time_ - var_105_10) / var_105_11
				local var_105_13 = Vector3.New(0, 100, 0)

				var_105_9.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1089ui_story, var_105_13, var_105_12)

				local var_105_14 = manager.ui.mainCamera.transform.position - var_105_9.position

				var_105_9.forward = Vector3.New(var_105_14.x, var_105_14.y, var_105_14.z)

				local var_105_15 = var_105_9.localEulerAngles

				var_105_15.z = 0
				var_105_15.x = 0
				var_105_9.localEulerAngles = var_105_15
			end

			if arg_102_1.time_ >= var_105_10 + var_105_11 and arg_102_1.time_ < var_105_10 + var_105_11 + arg_105_0 then
				var_105_9.localPosition = Vector3.New(0, 100, 0)

				local var_105_16 = manager.ui.mainCamera.transform.position - var_105_9.position

				var_105_9.forward = Vector3.New(var_105_16.x, var_105_16.y, var_105_16.z)

				local var_105_17 = var_105_9.localEulerAngles

				var_105_17.z = 0
				var_105_17.x = 0
				var_105_9.localEulerAngles = var_105_17
			end

			local var_105_18 = 0.05
			local var_105_19 = 1

			if var_105_18 < arg_102_1.time_ and arg_102_1.time_ <= var_105_18 + arg_105_0 then
				local var_105_20 = "play"
				local var_105_21 = "effect"

				arg_102_1:AudioAction(var_105_20, var_105_21, "se_story_140", "se_story_140_footstep_run04", "")
			end

			local var_105_22 = 1.56666666666667
			local var_105_23 = 1

			if var_105_22 < arg_102_1.time_ and arg_102_1.time_ <= var_105_22 + arg_105_0 then
				local var_105_24 = "play"
				local var_105_25 = "effect"

				arg_102_1:AudioAction(var_105_24, var_105_25, "se_story_140", "se_story_140_footstep_run05", "")
			end

			local var_105_26 = 0
			local var_105_27 = 1.175

			if var_105_26 < arg_102_1.time_ and arg_102_1.time_ <= var_105_26 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_28 = arg_102_1:GetWordFromCfg(420161024)
				local var_105_29 = arg_102_1:FormatText(var_105_28.content)

				arg_102_1.text_.text = var_105_29

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_30 = 47
				local var_105_31 = utf8.len(var_105_29)
				local var_105_32 = var_105_30 <= 0 and var_105_27 or var_105_27 * (var_105_31 / var_105_30)

				if var_105_32 > 0 and var_105_27 < var_105_32 then
					arg_102_1.talkMaxDuration = var_105_32

					if var_105_32 + var_105_26 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_32 + var_105_26
					end
				end

				arg_102_1.text_.text = var_105_29
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_33 = math.max(var_105_27, arg_102_1.talkMaxDuration)

			if var_105_26 <= arg_102_1.time_ and arg_102_1.time_ < var_105_26 + var_105_33 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_26) / var_105_33

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_26 + var_105_33 and arg_102_1.time_ < var_105_26 + var_105_33 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play420161025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 420161025
		arg_106_1.duration_ = 1.53

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play420161026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1085ui_story"].transform
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.var_.moveOldPos1085ui_story = var_109_0.localPosition
			end

			local var_109_2 = 0.001

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2
				local var_109_4 = Vector3.New(0, -1.01, -5.83)

				var_109_0.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1085ui_story, var_109_4, var_109_3)

				local var_109_5 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_5.x, var_109_5.y, var_109_5.z)

				local var_109_6 = var_109_0.localEulerAngles

				var_109_6.z = 0
				var_109_6.x = 0
				var_109_0.localEulerAngles = var_109_6
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 then
				var_109_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_109_7 = manager.ui.mainCamera.transform.position - var_109_0.position

				var_109_0.forward = Vector3.New(var_109_7.x, var_109_7.y, var_109_7.z)

				local var_109_8 = var_109_0.localEulerAngles

				var_109_8.z = 0
				var_109_8.x = 0
				var_109_0.localEulerAngles = var_109_8
			end

			local var_109_9 = arg_106_1.actors_["1085ui_story"]
			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1085ui_story == nil then
				arg_106_1.var_.characterEffect1085ui_story = var_109_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_11 = 0.200000002980232

			if var_109_10 <= arg_106_1.time_ and arg_106_1.time_ < var_109_10 + var_109_11 and not isNil(var_109_9) then
				local var_109_12 = (arg_106_1.time_ - var_109_10) / var_109_11

				if arg_106_1.var_.characterEffect1085ui_story and not isNil(var_109_9) then
					arg_106_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_10 + var_109_11 and arg_106_1.time_ < var_109_10 + var_109_11 + arg_109_0 and not isNil(var_109_9) and arg_106_1.var_.characterEffect1085ui_story then
				arg_106_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_109_13 = 0.3
			local var_109_14 = 1

			if var_109_13 < arg_106_1.time_ and arg_106_1.time_ <= var_109_13 + arg_109_0 then
				local var_109_15 = "play"
				local var_109_16 = "effect"

				arg_106_1:AudioAction(var_109_15, var_109_16, "se_story_140", "se_story_140_transparent04", "")
			end

			if arg_106_1.frameCnt_ <= 1 then
				arg_106_1.dialog_:SetActive(false)
			end

			local var_109_17 = 0.200000002980232
			local var_109_18 = 0.075

			if var_109_17 < arg_106_1.time_ and arg_106_1.time_ <= var_109_17 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0

				arg_106_1.dialog_:SetActive(true)

				arg_106_1.dialogCg_.alpha = 0

				local var_109_19 = LeanTween.value(arg_106_1.dialog_, 0, 1, 0.3)

				var_109_19:setOnUpdate(LuaHelper.FloatAction(function(arg_110_0)
					arg_106_1.dialogCg_.alpha = arg_110_0
				end))
				var_109_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_106_1.dialog_)
					var_109_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_106_1.duration_ = arg_106_1.duration_ + 0.3

				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_20 = arg_106_1:FormatText(StoryNameCfg[328].name)

				arg_106_1.leftNameTxt_.text = var_109_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_21 = arg_106_1:GetWordFromCfg(420161025)
				local var_109_22 = arg_106_1:FormatText(var_109_21.content)

				arg_106_1.text_.text = var_109_22

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_23 = 3
				local var_109_24 = utf8.len(var_109_22)
				local var_109_25 = var_109_23 <= 0 and var_109_18 or var_109_18 * (var_109_24 / var_109_23)

				if var_109_25 > 0 and var_109_18 < var_109_25 then
					arg_106_1.talkMaxDuration = var_109_25
					var_109_17 = var_109_17 + 0.3

					if var_109_25 + var_109_17 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_25 + var_109_17
					end
				end

				arg_106_1.text_.text = var_109_22
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161025", "story_v_out_420161.awb") ~= 0 then
					local var_109_26 = manager.audio:GetVoiceLength("story_v_out_420161", "420161025", "story_v_out_420161.awb") / 1000

					if var_109_26 + var_109_17 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_26 + var_109_17
					end

					if var_109_21.prefab_name ~= "" and arg_106_1.actors_[var_109_21.prefab_name] ~= nil then
						local var_109_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_21.prefab_name].transform, "story_v_out_420161", "420161025", "story_v_out_420161.awb")

						arg_106_1:RecordAudio("420161025", var_109_27)
						arg_106_1:RecordAudio("420161025", var_109_27)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_420161", "420161025", "story_v_out_420161.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_420161", "420161025", "story_v_out_420161.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_28 = var_109_17 + 0.3
			local var_109_29 = math.max(var_109_18, arg_106_1.talkMaxDuration)

			if var_109_28 <= arg_106_1.time_ and arg_106_1.time_ < var_109_28 + var_109_29 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_28) / var_109_29

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_28 + var_109_29 and arg_106_1.time_ < var_109_28 + var_109_29 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play420161026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 420161026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play420161027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1085ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos1085ui_story = var_115_0.localPosition
			end

			local var_115_2 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2
				local var_115_4 = Vector3.New(0, 100, 0)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1085ui_story, var_115_4, var_115_3)

				local var_115_5 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_5.x, var_115_5.y, var_115_5.z)

				local var_115_6 = var_115_0.localEulerAngles

				var_115_6.z = 0
				var_115_6.x = 0
				var_115_0.localEulerAngles = var_115_6
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0, 100, 0)

				local var_115_7 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_7.x, var_115_7.y, var_115_7.z)

				local var_115_8 = var_115_0.localEulerAngles

				var_115_8.z = 0
				var_115_8.x = 0
				var_115_0.localEulerAngles = var_115_8
			end

			local var_115_9 = 0
			local var_115_10 = 0.45

			if var_115_9 < arg_112_1.time_ and arg_112_1.time_ <= var_115_9 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_11 = arg_112_1:GetWordFromCfg(420161026)
				local var_115_12 = arg_112_1:FormatText(var_115_11.content)

				arg_112_1.text_.text = var_115_12

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_13 = 18
				local var_115_14 = utf8.len(var_115_12)
				local var_115_15 = var_115_13 <= 0 and var_115_10 or var_115_10 * (var_115_14 / var_115_13)

				if var_115_15 > 0 and var_115_10 < var_115_15 then
					arg_112_1.talkMaxDuration = var_115_15

					if var_115_15 + var_115_9 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_15 + var_115_9
					end
				end

				arg_112_1.text_.text = var_115_12
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_10, arg_112_1.talkMaxDuration)

			if var_115_9 <= arg_112_1.time_ and arg_112_1.time_ < var_115_9 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_9) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_9 + var_115_16 and arg_112_1.time_ < var_115_9 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play420161027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 420161027
		arg_116_1.duration_ = 3.97

		local var_116_0 = {
			zh = 3.966,
			ja = 3.8
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
				arg_116_0:Play420161028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["1085ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos1085ui_story = var_119_0.localPosition
			end

			local var_119_2 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2
				local var_119_4 = Vector3.New(0, -1.01, -5.83)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1085ui_story, var_119_4, var_119_3)

				local var_119_5 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_5.x, var_119_5.y, var_119_5.z)

				local var_119_6 = var_119_0.localEulerAngles

				var_119_6.z = 0
				var_119_6.x = 0
				var_119_0.localEulerAngles = var_119_6
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_119_7 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_7.x, var_119_7.y, var_119_7.z)

				local var_119_8 = var_119_0.localEulerAngles

				var_119_8.z = 0
				var_119_8.x = 0
				var_119_0.localEulerAngles = var_119_8
			end

			local var_119_9 = arg_116_1.actors_["1085ui_story"]
			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1085ui_story == nil then
				arg_116_1.var_.characterEffect1085ui_story = var_119_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_11 = 0.200000002980232

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_11 and not isNil(var_119_9) then
				local var_119_12 = (arg_116_1.time_ - var_119_10) / var_119_11

				if arg_116_1.var_.characterEffect1085ui_story and not isNil(var_119_9) then
					arg_116_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_10 + var_119_11 and arg_116_1.time_ < var_119_10 + var_119_11 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect1085ui_story then
				arg_116_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_119_13 = 0

			if var_119_13 < arg_116_1.time_ and arg_116_1.time_ <= var_119_13 + arg_119_0 then
				arg_116_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_1")
			end

			local var_119_14 = 0

			if var_119_14 < arg_116_1.time_ and arg_116_1.time_ <= var_119_14 + arg_119_0 then
				arg_116_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_119_15 = 0
			local var_119_16 = 0.425

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_17 = arg_116_1:FormatText(StoryNameCfg[328].name)

				arg_116_1.leftNameTxt_.text = var_119_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_18 = arg_116_1:GetWordFromCfg(420161027)
				local var_119_19 = arg_116_1:FormatText(var_119_18.content)

				arg_116_1.text_.text = var_119_19

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_20 = 17
				local var_119_21 = utf8.len(var_119_19)
				local var_119_22 = var_119_20 <= 0 and var_119_16 or var_119_16 * (var_119_21 / var_119_20)

				if var_119_22 > 0 and var_119_16 < var_119_22 then
					arg_116_1.talkMaxDuration = var_119_22

					if var_119_22 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_22 + var_119_15
					end
				end

				arg_116_1.text_.text = var_119_19
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161027", "story_v_out_420161.awb") ~= 0 then
					local var_119_23 = manager.audio:GetVoiceLength("story_v_out_420161", "420161027", "story_v_out_420161.awb") / 1000

					if var_119_23 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_23 + var_119_15
					end

					if var_119_18.prefab_name ~= "" and arg_116_1.actors_[var_119_18.prefab_name] ~= nil then
						local var_119_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_18.prefab_name].transform, "story_v_out_420161", "420161027", "story_v_out_420161.awb")

						arg_116_1:RecordAudio("420161027", var_119_24)
						arg_116_1:RecordAudio("420161027", var_119_24)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_420161", "420161027", "story_v_out_420161.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_420161", "420161027", "story_v_out_420161.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_25 = math.max(var_119_16, arg_116_1.talkMaxDuration)

			if var_119_15 <= arg_116_1.time_ and arg_116_1.time_ < var_119_15 + var_119_25 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_15) / var_119_25

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_15 + var_119_25 and arg_116_1.time_ < var_119_15 + var_119_25 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play420161028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 420161028
		arg_120_1.duration_ = 7.43

		local var_120_0 = {
			zh = 6.933,
			ja = 7.433
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
				arg_120_0:Play420161029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.65

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[328].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_3 = arg_120_1:GetWordFromCfg(420161028)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161028", "story_v_out_420161.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_420161", "420161028", "story_v_out_420161.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_420161", "420161028", "story_v_out_420161.awb")

						arg_120_1:RecordAudio("420161028", var_123_9)
						arg_120_1:RecordAudio("420161028", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_420161", "420161028", "story_v_out_420161.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_420161", "420161028", "story_v_out_420161.awb")
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
	Play420161029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 420161029
		arg_124_1.duration_ = 8.83

		local var_124_0 = {
			zh = 7.966,
			ja = 8.833
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play420161030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action478")
			end

			local var_127_1 = 0
			local var_127_2 = 0.625

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_3 = arg_124_1:FormatText(StoryNameCfg[328].name)

				arg_124_1.leftNameTxt_.text = var_127_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_4 = arg_124_1:GetWordFromCfg(420161029)
				local var_127_5 = arg_124_1:FormatText(var_127_4.content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_6 = 25
				local var_127_7 = utf8.len(var_127_5)
				local var_127_8 = var_127_6 <= 0 and var_127_2 or var_127_2 * (var_127_7 / var_127_6)

				if var_127_8 > 0 and var_127_2 < var_127_8 then
					arg_124_1.talkMaxDuration = var_127_8

					if var_127_8 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_1
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161029", "story_v_out_420161.awb") ~= 0 then
					local var_127_9 = manager.audio:GetVoiceLength("story_v_out_420161", "420161029", "story_v_out_420161.awb") / 1000

					if var_127_9 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_1
					end

					if var_127_4.prefab_name ~= "" and arg_124_1.actors_[var_127_4.prefab_name] ~= nil then
						local var_127_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_4.prefab_name].transform, "story_v_out_420161", "420161029", "story_v_out_420161.awb")

						arg_124_1:RecordAudio("420161029", var_127_10)
						arg_124_1:RecordAudio("420161029", var_127_10)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_420161", "420161029", "story_v_out_420161.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_420161", "420161029", "story_v_out_420161.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_11 = math.max(var_127_2, arg_124_1.talkMaxDuration)

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_11 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_1) / var_127_11

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_1 + var_127_11 and arg_124_1.time_ < var_127_1 + var_127_11 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play420161030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 420161030
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play420161031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1085ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1085ui_story = var_131_0.localPosition
			end

			local var_131_2 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2
				local var_131_4 = Vector3.New(0, 100, 0)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1085ui_story, var_131_4, var_131_3)

				local var_131_5 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_5.x, var_131_5.y, var_131_5.z)

				local var_131_6 = var_131_0.localEulerAngles

				var_131_6.z = 0
				var_131_6.x = 0
				var_131_0.localEulerAngles = var_131_6
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, 100, 0)

				local var_131_7 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_7.x, var_131_7.y, var_131_7.z)

				local var_131_8 = var_131_0.localEulerAngles

				var_131_8.z = 0
				var_131_8.x = 0
				var_131_0.localEulerAngles = var_131_8
			end

			local var_131_9 = 0
			local var_131_10 = 1.075

			if var_131_9 < arg_128_1.time_ and arg_128_1.time_ <= var_131_9 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_11 = arg_128_1:GetWordFromCfg(420161030)
				local var_131_12 = arg_128_1:FormatText(var_131_11.content)

				arg_128_1.text_.text = var_131_12

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_13 = 43
				local var_131_14 = utf8.len(var_131_12)
				local var_131_15 = var_131_13 <= 0 and var_131_10 or var_131_10 * (var_131_14 / var_131_13)

				if var_131_15 > 0 and var_131_10 < var_131_15 then
					arg_128_1.talkMaxDuration = var_131_15

					if var_131_15 + var_131_9 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_15 + var_131_9
					end
				end

				arg_128_1.text_.text = var_131_12
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_16 = math.max(var_131_10, arg_128_1.talkMaxDuration)

			if var_131_9 <= arg_128_1.time_ and arg_128_1.time_ < var_131_9 + var_131_16 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_9) / var_131_16

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_9 + var_131_16 and arg_128_1.time_ < var_131_9 + var_131_16 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play420161031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 420161031
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play420161032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 1.425

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_2 = arg_132_1:GetWordFromCfg(420161031)
				local var_135_3 = arg_132_1:FormatText(var_135_2.content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 57
				local var_135_5 = utf8.len(var_135_3)
				local var_135_6 = var_135_4 <= 0 and var_135_1 or var_135_1 * (var_135_5 / var_135_4)

				if var_135_6 > 0 and var_135_1 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_7 and arg_132_1.time_ < var_135_0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play420161032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 420161032
		arg_136_1.duration_ = 9

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play420161033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = "L16f"

			if arg_136_1.bgs_[var_139_0] == nil then
				local var_139_1 = Object.Instantiate(arg_136_1.paintGo_)

				var_139_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_139_0)
				var_139_1.name = var_139_0
				var_139_1.transform.parent = arg_136_1.stage_.transform
				var_139_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.bgs_[var_139_0] = var_139_1
			end

			local var_139_2 = 2

			if var_139_2 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				local var_139_3 = manager.ui.mainCamera.transform.localPosition
				local var_139_4 = Vector3.New(0, 0, 10) + Vector3.New(var_139_3.x, var_139_3.y, 0)
				local var_139_5 = arg_136_1.bgs_.L16f

				var_139_5.transform.localPosition = var_139_4
				var_139_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_139_6 = var_139_5:GetComponent("SpriteRenderer")

				if var_139_6 and var_139_6.sprite then
					local var_139_7 = (var_139_5.transform.localPosition - var_139_3).z
					local var_139_8 = manager.ui.mainCameraCom_
					local var_139_9 = 2 * var_139_7 * Mathf.Tan(var_139_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_139_10 = var_139_9 * var_139_8.aspect
					local var_139_11 = var_139_6.sprite.bounds.size.x
					local var_139_12 = var_139_6.sprite.bounds.size.y
					local var_139_13 = var_139_10 / var_139_11
					local var_139_14 = var_139_9 / var_139_12
					local var_139_15 = var_139_14 < var_139_13 and var_139_13 or var_139_14

					var_139_5.transform.localScale = Vector3.New(var_139_15, var_139_15, 0)
				end

				for iter_139_0, iter_139_1 in pairs(arg_136_1.bgs_) do
					if iter_139_0 ~= "L16f" then
						iter_139_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_139_16 = 4

			if var_139_16 < arg_136_1.time_ and arg_136_1.time_ <= var_139_16 + arg_139_0 then
				arg_136_1.allBtn_.enabled = false
			end

			local var_139_17 = 0.3

			if arg_136_1.time_ >= var_139_16 + var_139_17 and arg_136_1.time_ < var_139_16 + var_139_17 + arg_139_0 then
				arg_136_1.allBtn_.enabled = true
			end

			local var_139_18 = 0

			if var_139_18 < arg_136_1.time_ and arg_136_1.time_ <= var_139_18 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_19 = 2

			if var_139_18 <= arg_136_1.time_ and arg_136_1.time_ < var_139_18 + var_139_19 then
				local var_139_20 = (arg_136_1.time_ - var_139_18) / var_139_19
				local var_139_21 = Color.New(0, 0, 0)

				var_139_21.a = Mathf.Lerp(0, 1, var_139_20)
				arg_136_1.mask_.color = var_139_21
			end

			if arg_136_1.time_ >= var_139_18 + var_139_19 and arg_136_1.time_ < var_139_18 + var_139_19 + arg_139_0 then
				local var_139_22 = Color.New(0, 0, 0)

				var_139_22.a = 1
				arg_136_1.mask_.color = var_139_22
			end

			local var_139_23 = 2

			if var_139_23 < arg_136_1.time_ and arg_136_1.time_ <= var_139_23 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_24 = 2

			if var_139_23 <= arg_136_1.time_ and arg_136_1.time_ < var_139_23 + var_139_24 then
				local var_139_25 = (arg_136_1.time_ - var_139_23) / var_139_24
				local var_139_26 = Color.New(0, 0, 0)

				var_139_26.a = Mathf.Lerp(1, 0, var_139_25)
				arg_136_1.mask_.color = var_139_26
			end

			if arg_136_1.time_ >= var_139_23 + var_139_24 and arg_136_1.time_ < var_139_23 + var_139_24 + arg_139_0 then
				local var_139_27 = Color.New(0, 0, 0)
				local var_139_28 = 0

				arg_136_1.mask_.enabled = false
				var_139_27.a = var_139_28
				arg_136_1.mask_.color = var_139_27
			end

			local var_139_29 = 4
			local var_139_30 = 1

			if var_139_29 < arg_136_1.time_ and arg_136_1.time_ <= var_139_29 + arg_139_0 then
				local var_139_31 = "play"
				local var_139_32 = "effect"

				arg_136_1:AudioAction(var_139_31, var_139_32, "se_story_140", "se_story_140_car_hit", "")
			end

			local var_139_33 = manager.ui.mainCamera.transform
			local var_139_34 = 4

			if var_139_34 < arg_136_1.time_ and arg_136_1.time_ <= var_139_34 + arg_139_0 then
				arg_136_1.var_.shakeOldPos = var_139_33.localPosition
			end

			local var_139_35 = 0.3

			if var_139_34 <= arg_136_1.time_ and arg_136_1.time_ < var_139_34 + var_139_35 then
				local var_139_36 = (arg_136_1.time_ - var_139_34) / 0.066
				local var_139_37, var_139_38 = math.modf(var_139_36)

				var_139_33.localPosition = Vector3.New(var_139_38 * 0.13, var_139_38 * 0.13, var_139_38 * 0.13) + arg_136_1.var_.shakeOldPos
			end

			if arg_136_1.time_ >= var_139_34 + var_139_35 and arg_136_1.time_ < var_139_34 + var_139_35 + arg_139_0 then
				var_139_33.localPosition = arg_136_1.var_.shakeOldPos
			end

			if arg_136_1.frameCnt_ <= 1 then
				arg_136_1.dialog_:SetActive(false)
			end

			local var_139_39 = 4
			local var_139_40 = 0.725

			if var_139_39 < arg_136_1.time_ and arg_136_1.time_ <= var_139_39 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0

				arg_136_1.dialog_:SetActive(true)

				arg_136_1.dialogCg_.alpha = 0

				local var_139_41 = LeanTween.value(arg_136_1.dialog_, 0, 1, 0.3)

				var_139_41:setOnUpdate(LuaHelper.FloatAction(function(arg_140_0)
					arg_136_1.dialogCg_.alpha = arg_140_0
				end))
				var_139_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_136_1.dialog_)
					var_139_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_136_1.duration_ = arg_136_1.duration_ + 0.3

				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_42 = arg_136_1:GetWordFromCfg(420161032)
				local var_139_43 = arg_136_1:FormatText(var_139_42.content)

				arg_136_1.text_.text = var_139_43

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_44 = 29
				local var_139_45 = utf8.len(var_139_43)
				local var_139_46 = var_139_44 <= 0 and var_139_40 or var_139_40 * (var_139_45 / var_139_44)

				if var_139_46 > 0 and var_139_40 < var_139_46 then
					arg_136_1.talkMaxDuration = var_139_46
					var_139_39 = var_139_39 + 0.3

					if var_139_46 + var_139_39 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_46 + var_139_39
					end
				end

				arg_136_1.text_.text = var_139_43
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_47 = var_139_39 + 0.3
			local var_139_48 = math.max(var_139_40, arg_136_1.talkMaxDuration)

			if var_139_47 <= arg_136_1.time_ and arg_136_1.time_ < var_139_47 + var_139_48 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_47) / var_139_48

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_47 + var_139_48 and arg_136_1.time_ < var_139_47 + var_139_48 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play420161033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 420161033
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play420161034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0.2
			local var_145_1 = 1

			if var_145_0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				local var_145_2 = "play"
				local var_145_3 = "effect"

				arg_142_1:AudioAction(var_145_2, var_145_3, "se_story_140", "se_story_140_car_door", "")
			end

			local var_145_4 = 0
			local var_145_5 = 1.05

			if var_145_4 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_6 = arg_142_1:GetWordFromCfg(420161033)
				local var_145_7 = arg_142_1:FormatText(var_145_6.content)

				arg_142_1.text_.text = var_145_7

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_8 = 42
				local var_145_9 = utf8.len(var_145_7)
				local var_145_10 = var_145_8 <= 0 and var_145_5 or var_145_5 * (var_145_9 / var_145_8)

				if var_145_10 > 0 and var_145_5 < var_145_10 then
					arg_142_1.talkMaxDuration = var_145_10

					if var_145_10 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_4
					end
				end

				arg_142_1.text_.text = var_145_7
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_11 = math.max(var_145_5, arg_142_1.talkMaxDuration)

			if var_145_4 <= arg_142_1.time_ and arg_142_1.time_ < var_145_4 + var_145_11 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_4) / var_145_11

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_4 + var_145_11 and arg_142_1.time_ < var_145_4 + var_145_11 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play420161034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 420161034
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play420161035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 1
			local var_149_1 = 1

			if var_149_0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_0 + arg_149_0 then
				local var_149_2 = "play"
				local var_149_3 = "effect"

				arg_146_1:AudioAction(var_149_2, var_149_3, "se_story_140", "se_story_140_car02", "")
			end

			local var_149_4 = 0
			local var_149_5 = 0.75

			if var_149_4 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_6 = arg_146_1:GetWordFromCfg(420161034)
				local var_149_7 = arg_146_1:FormatText(var_149_6.content)

				arg_146_1.text_.text = var_149_7

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_8 = 30
				local var_149_9 = utf8.len(var_149_7)
				local var_149_10 = var_149_8 <= 0 and var_149_5 or var_149_5 * (var_149_9 / var_149_8)

				if var_149_10 > 0 and var_149_5 < var_149_10 then
					arg_146_1.talkMaxDuration = var_149_10

					if var_149_10 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_4
					end
				end

				arg_146_1.text_.text = var_149_7
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_11 = math.max(var_149_5, arg_146_1.talkMaxDuration)

			if var_149_4 <= arg_146_1.time_ and arg_146_1.time_ < var_149_4 + var_149_11 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_4) / var_149_11

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_4 + var_149_11 and arg_146_1.time_ < var_149_4 + var_149_11 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play420161035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 420161035
		arg_150_1.duration_ = 5.47

		local var_150_0 = {
			zh = 3.266,
			ja = 5.466
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
				arg_150_0:Play420161036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0
			local var_153_1 = 0.325

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_2 = arg_150_1:FormatText(StoryNameCfg[1159].name)

				arg_150_1.leftNameTxt_.text = var_153_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:GetWordFromCfg(420161035)
				local var_153_4 = arg_150_1:FormatText(var_153_3.content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 13
				local var_153_6 = utf8.len(var_153_4)
				local var_153_7 = var_153_5 <= 0 and var_153_1 or var_153_1 * (var_153_6 / var_153_5)

				if var_153_7 > 0 and var_153_1 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_0
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161035", "story_v_out_420161.awb") ~= 0 then
					local var_153_8 = manager.audio:GetVoiceLength("story_v_out_420161", "420161035", "story_v_out_420161.awb") / 1000

					if var_153_8 + var_153_0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_0
					end

					if var_153_3.prefab_name ~= "" and arg_150_1.actors_[var_153_3.prefab_name] ~= nil then
						local var_153_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_3.prefab_name].transform, "story_v_out_420161", "420161035", "story_v_out_420161.awb")

						arg_150_1:RecordAudio("420161035", var_153_9)
						arg_150_1:RecordAudio("420161035", var_153_9)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_420161", "420161035", "story_v_out_420161.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_420161", "420161035", "story_v_out_420161.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_10 = math.max(var_153_1, arg_150_1.talkMaxDuration)

			if var_153_0 <= arg_150_1.time_ and arg_150_1.time_ < var_153_0 + var_153_10 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_0) / var_153_10

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_0 + var_153_10 and arg_150_1.time_ < var_153_0 + var_153_10 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play420161036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 420161036
		arg_154_1.duration_ = 3.83

		local var_154_0 = {
			zh = 2.96633333333333,
			ja = 3.83333333333333
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play420161037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = "1056ui_story"

			if arg_154_1.actors_[var_157_0] == nil then
				local var_157_1 = Asset.Load("Char/" .. "1056ui_story")

				if not isNil(var_157_1) then
					local var_157_2 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_154_1.stage_.transform)

					var_157_2.name = var_157_0
					var_157_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_154_1.actors_[var_157_0] = var_157_2

					local var_157_3 = var_157_2:GetComponentInChildren(typeof(CharacterEffect))

					var_157_3.enabled = true

					local var_157_4 = GameObjectTools.GetOrAddComponent(var_157_2, typeof(DynamicBoneHelper))

					if var_157_4 then
						var_157_4:EnableDynamicBone(false)
					end

					arg_154_1:ShowWeapon(var_157_3.transform, false)

					arg_154_1.var_[var_157_0 .. "Animator"] = var_157_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_154_1.var_[var_157_0 .. "Animator"].applyRootMotion = true
					arg_154_1.var_[var_157_0 .. "LipSync"] = var_157_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_157_5 = arg_154_1.actors_["1056ui_story"].transform
			local var_157_6 = 0

			if var_157_6 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.var_.moveOldPos1056ui_story = var_157_5.localPosition

				local var_157_7 = "1056ui_story"

				arg_154_1:ShowWeapon(arg_154_1.var_[var_157_7 .. "Animator"].transform, false)
			end

			local var_157_8 = 0.001

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_8 then
				local var_157_9 = (arg_154_1.time_ - var_157_6) / var_157_8
				local var_157_10 = Vector3.New(0, -1, -5.75)

				var_157_5.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1056ui_story, var_157_10, var_157_9)

				local var_157_11 = manager.ui.mainCamera.transform.position - var_157_5.position

				var_157_5.forward = Vector3.New(var_157_11.x, var_157_11.y, var_157_11.z)

				local var_157_12 = var_157_5.localEulerAngles

				var_157_12.z = 0
				var_157_12.x = 0
				var_157_5.localEulerAngles = var_157_12
			end

			if arg_154_1.time_ >= var_157_6 + var_157_8 and arg_154_1.time_ < var_157_6 + var_157_8 + arg_157_0 then
				var_157_5.localPosition = Vector3.New(0, -1, -5.75)

				local var_157_13 = manager.ui.mainCamera.transform.position - var_157_5.position

				var_157_5.forward = Vector3.New(var_157_13.x, var_157_13.y, var_157_13.z)

				local var_157_14 = var_157_5.localEulerAngles

				var_157_14.z = 0
				var_157_14.x = 0
				var_157_5.localEulerAngles = var_157_14
			end

			local var_157_15 = arg_154_1.actors_["1056ui_story"]
			local var_157_16 = 0

			if var_157_16 < arg_154_1.time_ and arg_154_1.time_ <= var_157_16 + arg_157_0 and not isNil(var_157_15) and arg_154_1.var_.characterEffect1056ui_story == nil then
				arg_154_1.var_.characterEffect1056ui_story = var_157_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_17 = 0.200000002980232

			if var_157_16 <= arg_154_1.time_ and arg_154_1.time_ < var_157_16 + var_157_17 and not isNil(var_157_15) then
				local var_157_18 = (arg_154_1.time_ - var_157_16) / var_157_17

				if arg_154_1.var_.characterEffect1056ui_story and not isNil(var_157_15) then
					arg_154_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_16 + var_157_17 and arg_154_1.time_ < var_157_16 + var_157_17 + arg_157_0 and not isNil(var_157_15) and arg_154_1.var_.characterEffect1056ui_story then
				arg_154_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_157_19 = 0

			if var_157_19 < arg_154_1.time_ and arg_154_1.time_ <= var_157_19 + arg_157_0 then
				arg_154_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action8_1")
			end

			local var_157_20 = 0

			if var_157_20 < arg_154_1.time_ and arg_154_1.time_ <= var_157_20 + arg_157_0 then
				arg_154_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_157_21 = 0

			if var_157_21 < arg_154_1.time_ and arg_154_1.time_ <= var_157_21 + arg_157_0 then
				arg_154_1.allBtn_.enabled = false
			end

			local var_157_22 = 0.833333333333333

			if arg_154_1.time_ >= var_157_21 + var_157_22 and arg_154_1.time_ < var_157_21 + var_157_22 + arg_157_0 then
				arg_154_1.allBtn_.enabled = true
			end

			if arg_154_1.frameCnt_ <= 1 then
				arg_154_1.dialog_:SetActive(false)
			end

			local var_157_23 = 0.333333333333333
			local var_157_24 = 0.225

			if var_157_23 < arg_154_1.time_ and arg_154_1.time_ <= var_157_23 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0

				arg_154_1.dialog_:SetActive(true)

				arg_154_1.dialogCg_.alpha = 0

				local var_157_25 = LeanTween.value(arg_154_1.dialog_, 0, 1, 0.3)

				var_157_25:setOnUpdate(LuaHelper.FloatAction(function(arg_158_0)
					arg_154_1.dialogCg_.alpha = arg_158_0
				end))
				var_157_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_154_1.dialog_)
					var_157_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_154_1.duration_ = arg_154_1.duration_ + 0.3

				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_26 = arg_154_1:FormatText(StoryNameCfg[605].name)

				arg_154_1.leftNameTxt_.text = var_157_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_27 = arg_154_1:GetWordFromCfg(420161036)
				local var_157_28 = arg_154_1:FormatText(var_157_27.content)

				arg_154_1.text_.text = var_157_28

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_29 = 9
				local var_157_30 = utf8.len(var_157_28)
				local var_157_31 = var_157_29 <= 0 and var_157_24 or var_157_24 * (var_157_30 / var_157_29)

				if var_157_31 > 0 and var_157_24 < var_157_31 then
					arg_154_1.talkMaxDuration = var_157_31
					var_157_23 = var_157_23 + 0.3

					if var_157_31 + var_157_23 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_31 + var_157_23
					end
				end

				arg_154_1.text_.text = var_157_28
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161036", "story_v_out_420161.awb") ~= 0 then
					local var_157_32 = manager.audio:GetVoiceLength("story_v_out_420161", "420161036", "story_v_out_420161.awb") / 1000

					if var_157_32 + var_157_23 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_32 + var_157_23
					end

					if var_157_27.prefab_name ~= "" and arg_154_1.actors_[var_157_27.prefab_name] ~= nil then
						local var_157_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_27.prefab_name].transform, "story_v_out_420161", "420161036", "story_v_out_420161.awb")

						arg_154_1:RecordAudio("420161036", var_157_33)
						arg_154_1:RecordAudio("420161036", var_157_33)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_420161", "420161036", "story_v_out_420161.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_420161", "420161036", "story_v_out_420161.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_34 = var_157_23 + 0.3
			local var_157_35 = math.max(var_157_24, arg_154_1.talkMaxDuration)

			if var_157_34 <= arg_154_1.time_ and arg_154_1.time_ < var_157_34 + var_157_35 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_34) / var_157_35

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_34 + var_157_35 and arg_154_1.time_ < var_157_34 + var_157_35 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play420161037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 420161037
		arg_160_1.duration_ = 7.53

		local var_160_0 = {
			zh = 4.233,
			ja = 7.533
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
				arg_160_0:Play420161038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["1056ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1056ui_story == nil then
				arg_160_1.var_.characterEffect1056ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect1056ui_story and not isNil(var_163_0) then
					local var_163_4 = Mathf.Lerp(0, 0.5, var_163_3)

					arg_160_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1056ui_story.fillRatio = var_163_4
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect1056ui_story then
				local var_163_5 = 0.5

				arg_160_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1056ui_story.fillRatio = var_163_5
			end

			local var_163_6 = 0
			local var_163_7 = 0.4

			if var_163_6 < arg_160_1.time_ and arg_160_1.time_ <= var_163_6 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_8 = arg_160_1:FormatText(StoryNameCfg[1159].name)

				arg_160_1.leftNameTxt_.text = var_163_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2124")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_9 = arg_160_1:GetWordFromCfg(420161037)
				local var_163_10 = arg_160_1:FormatText(var_163_9.content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_11 = 16
				local var_163_12 = utf8.len(var_163_10)
				local var_163_13 = var_163_11 <= 0 and var_163_7 or var_163_7 * (var_163_12 / var_163_11)

				if var_163_13 > 0 and var_163_7 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_6
					end
				end

				arg_160_1.text_.text = var_163_10
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161037", "story_v_out_420161.awb") ~= 0 then
					local var_163_14 = manager.audio:GetVoiceLength("story_v_out_420161", "420161037", "story_v_out_420161.awb") / 1000

					if var_163_14 + var_163_6 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_14 + var_163_6
					end

					if var_163_9.prefab_name ~= "" and arg_160_1.actors_[var_163_9.prefab_name] ~= nil then
						local var_163_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_9.prefab_name].transform, "story_v_out_420161", "420161037", "story_v_out_420161.awb")

						arg_160_1:RecordAudio("420161037", var_163_15)
						arg_160_1:RecordAudio("420161037", var_163_15)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_420161", "420161037", "story_v_out_420161.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_420161", "420161037", "story_v_out_420161.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_16 = math.max(var_163_7, arg_160_1.talkMaxDuration)

			if var_163_6 <= arg_160_1.time_ and arg_160_1.time_ < var_163_6 + var_163_16 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_6) / var_163_16

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_6 + var_163_16 and arg_160_1.time_ < var_163_6 + var_163_16 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play420161038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 420161038
		arg_164_1.duration_ = 2.9

		local var_164_0 = {
			zh = 2.166,
			ja = 2.9
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
			arg_164_1.auto_ = false
		end

		function arg_164_1.playNext_(arg_166_0)
			arg_164_1.onStoryFinished_()
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["1056ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1056ui_story == nil then
				arg_164_1.var_.characterEffect1056ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect1056ui_story and not isNil(var_167_0) then
					arg_164_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect1056ui_story then
				arg_164_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			local var_167_4 = 0

			if var_167_4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_167_5 = 0
			local var_167_6 = 0.325

			if var_167_5 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_7 = arg_164_1:FormatText(StoryNameCfg[605].name)

				arg_164_1.leftNameTxt_.text = var_167_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_8 = arg_164_1:GetWordFromCfg(420161038)
				local var_167_9 = arg_164_1:FormatText(var_167_8.content)

				arg_164_1.text_.text = var_167_9

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_10 = 13
				local var_167_11 = utf8.len(var_167_9)
				local var_167_12 = var_167_10 <= 0 and var_167_6 or var_167_6 * (var_167_11 / var_167_10)

				if var_167_12 > 0 and var_167_6 < var_167_12 then
					arg_164_1.talkMaxDuration = var_167_12

					if var_167_12 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_12 + var_167_5
					end
				end

				arg_164_1.text_.text = var_167_9
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161038", "story_v_out_420161.awb") ~= 0 then
					local var_167_13 = manager.audio:GetVoiceLength("story_v_out_420161", "420161038", "story_v_out_420161.awb") / 1000

					if var_167_13 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_13 + var_167_5
					end

					if var_167_8.prefab_name ~= "" and arg_164_1.actors_[var_167_8.prefab_name] ~= nil then
						local var_167_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_8.prefab_name].transform, "story_v_out_420161", "420161038", "story_v_out_420161.awb")

						arg_164_1:RecordAudio("420161038", var_167_14)
						arg_164_1:RecordAudio("420161038", var_167_14)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_420161", "420161038", "story_v_out_420161.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_420161", "420161038", "story_v_out_420161.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_15 = math.max(var_167_6, arg_164_1.talkMaxDuration)

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_15 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_5) / var_167_15

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_5 + var_167_15 and arg_164_1.time_ < var_167_5 + var_167_15 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/ST0505",
		"TextureConfig/Background/ST0504",
		"TextureConfig/Background/ST61",
		"TextureConfig/Background/L16f"
	},
	voices = {
		"story_v_out_420161.awb"
	}
}
