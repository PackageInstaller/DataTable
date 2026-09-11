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
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_0 = 2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_0 then
				local var_4_1 = Color.New(0, 0, 0)

				var_4_1.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - 0) / var_4_0)
				arg_1_1.mask_.color = var_4_1
			end

			if arg_1_1.time_ >= 0 + var_4_0 and arg_1_1.time_ < 0 + var_4_0 + arg_4_0 then
				local var_4_2 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_2.a = 0
				arg_1_1.mask_.color = var_4_2
			end

			local var_4_3 = "STwhite"

			if arg_1_1.bgs_.STwhite == nil then
				local var_4_4 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_3)
				var_4_4.name = var_4_3
				var_4_4.transform.parent = arg_1_1.stage_.transform
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_3] = var_4_4
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_5 = arg_1_1.bgs_.STwhite

				arg_1_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = 2 * (var_4_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_5.transform.localScale = Vector3.New(var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, var_4_7 / var_4_6.sprite.bounds.size.y < var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x and var_4_7 * manager.ui.mainCameraCom_.aspect / var_4_6.sprite.bounds.size.x or var_4_7 / var_4_6.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STwhite" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_11 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_11.offsetMin = Vector2.New(0, 0)
				var_4_11.offsetMax = Vector2.New(0, 130)
				arg_1_1.cswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(419159).content)

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
			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(true)
				arg_6_1.dialog_:SetActive(false)

				arg_6_1.fswtw_.percent = 0
				arg_6_1.fswt_.text = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(420161002).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.fswt_)

				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_6_1.fswtw_:SetDirty()

				arg_6_1.typewritterCharCountI18N = 0

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_1 = 2
			local var_9_2 = 0.2
			local var_9_3, var_9_4 = arg_6_1:GetPercentByPara(arg_6_1:FormatText(arg_6_1:GetWordFromCfg(420161002).content), 1)

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_5 = var_9_1 <= 0 and var_9_2 or var_9_2 * ((var_9_4 - arg_6_1.typewritterCharCountI18N) / var_9_1)

				if (var_9_1 <= 0 and var_9_2 or var_9_2 * ((var_9_4 - arg_6_1.typewritterCharCountI18N) / var_9_1)) > 0 and var_9_2 < var_9_5 then
					arg_6_1.talkMaxDuration = var_9_5

					if var_9_5 + var_9_0 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_5 + var_9_0
					end
				end
			end

			local var_9_6 = math.max(0.2, arg_6_1.talkMaxDuration)

			if var_9_0 <= arg_6_1.time_ and arg_6_1.time_ < var_9_0 + var_9_6 then
				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_3, (arg_6_1.time_ - var_9_0) / var_9_6)
				arg_6_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_0 + var_9_6 and arg_6_1.time_ < var_9_0 + var_9_6 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_3

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_4
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				local var_9_7 = arg_6_1.fswbg_.transform:Find("textbox/adapt/content") or arg_6_1.fswbg_.transform:Find("textbox/content")
				local var_9_8 = arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_9_9 = var_9_7:GetComponent("RectTransform")

				var_9_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_9_9.offsetMin = Vector2.New(0, -70)
				var_9_9.offsetMax = Vector2.New(0, 0)
			end

			local var_9_10 = 0

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_10 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			if arg_6_1.time_ >= var_9_10 + 0.15 and arg_6_1.time_ < var_9_10 + 0.15 + arg_9_0 then
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
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.fswbg_:SetActive(true)
				arg_10_1.dialog_:SetActive(false)

				arg_10_1.fswtw_.percent = 0
				arg_10_1.fswt_.text = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(420161003).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.fswt_)

				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_10_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_10_1.fswtw_:SetDirty()

				arg_10_1.typewritterCharCountI18N = 0

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_1 = 8
			local var_13_2 = 0.533333333333333
			local var_13_3, var_13_4 = arg_10_1:GetPercentByPara(arg_10_1:FormatText(arg_10_1:GetWordFromCfg(420161003).content), 1)

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_5 = var_13_1 <= 0 and var_13_2 or var_13_2 * ((var_13_4 - arg_10_1.typewritterCharCountI18N) / var_13_1)

				if (var_13_1 <= 0 and var_13_2 or var_13_2 * ((var_13_4 - arg_10_1.typewritterCharCountI18N) / var_13_1)) > 0 and var_13_2 < var_13_5 then
					arg_10_1.talkMaxDuration = var_13_5

					if var_13_5 + var_13_0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_5 + var_13_0
					end
				end
			end

			local var_13_6 = math.max(0.533333333333333, arg_10_1.talkMaxDuration)

			if var_13_0 <= arg_10_1.time_ and arg_10_1.time_ < var_13_0 + var_13_6 then
				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_3, (arg_10_1.time_ - var_13_0) / var_13_6)
				arg_10_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= var_13_0 + var_13_6 and arg_10_1.time_ < var_13_0 + var_13_6 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_3

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_4
			end

			local var_13_7 = 0
			local var_13_8 = manager.audio:GetVoiceLength("story_v_out_420161", "420161003", "story_v_out_420161.awb") / 1000

			if var_13_8 > 0 and 3.9 < var_13_8 and var_13_8 + var_13_7 > arg_10_1.duration_ then
				arg_10_1.duration_ = var_13_8 + var_13_7
			end

			if var_13_7 < arg_10_1.time_ and arg_10_1.time_ <= var_13_7 + arg_13_0 then
				arg_10_1:AudioAction("play", "voice", "story_v_out_420161", "420161003", "story_v_out_420161.awb")
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
			if arg_14_1.bgs_.ST0505 == nil then
				local var_17_0 = Object.Instantiate(arg_14_1.paintGo_)

				var_17_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0505")
				var_17_0.name = "ST0505"
				var_17_0.transform.parent = arg_14_1.stage_.transform
				var_17_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_14_1.bgs_.ST0505 = var_17_0
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				local var_17_1 = arg_14_1.bgs_.ST0505

				arg_14_1.bgs_.ST0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_17_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_17_2 = var_17_1:GetComponent("SpriteRenderer")

				if var_17_2 and var_17_2.sprite then
					local var_17_3 = 2 * (var_17_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_17_1.transform.localScale = Vector3.New(var_17_3 / var_17_2.sprite.bounds.size.y < var_17_3 * manager.ui.mainCameraCom_.aspect / var_17_2.sprite.bounds.size.x and var_17_3 * manager.ui.mainCameraCom_.aspect / var_17_2.sprite.bounds.size.x or var_17_3 / var_17_2.sprite.bounds.size.y, var_17_3 / var_17_2.sprite.bounds.size.y < var_17_3 * manager.ui.mainCameraCom_.aspect / var_17_2.sprite.bounds.size.x and var_17_3 * manager.ui.mainCameraCom_.aspect / var_17_2.sprite.bounds.size.x or var_17_3 / var_17_2.sprite.bounds.size.y, 0)
				end

				for iter_17_0, iter_17_1 in pairs(arg_14_1.bgs_) do
					if iter_17_0 ~= "ST0505" then
						iter_17_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_17_4 = 0

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_4 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_5 = 2

			if var_17_4 <= arg_14_1.time_ and arg_14_1.time_ < var_17_4 + var_17_5 then
				local var_17_6 = Color.New(1, 1, 1)

				var_17_6.a = Mathf.Lerp(1, 0, (arg_14_1.time_ - var_17_4) / var_17_5)
				arg_14_1.mask_.color = var_17_6
			end

			if arg_14_1.time_ >= var_17_4 + var_17_5 and arg_14_1.time_ < var_17_4 + var_17_5 + arg_17_0 then
				local var_17_7 = Color.New(1, 1, 1)

				arg_14_1.mask_.enabled = false
				var_17_7.a = 0
				arg_14_1.mask_.color = var_17_7
			end

			local var_17_8 = 2

			if 2 < arg_14_1.time_ and arg_14_1.time_ <= var_17_8 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			if arg_14_1.time_ >= var_17_8 + 0.666666666666667 and arg_14_1.time_ < var_17_8 + 0.666666666666667 + arg_17_0 then
				arg_14_1.allBtn_.enabled = true
			end

			local var_17_9 = "1085ui_story"

			if arg_14_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_17_10 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_14_1.stage_.transform)

				var_17_10.name = var_17_9
				var_17_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_14_1.actors_[var_17_9] = var_17_10

				local var_17_11 = var_17_10:GetComponentInChildren(typeof(CharacterEffect))

				var_17_11.enabled = true

				local var_17_12 = GameObjectTools.GetOrAddComponent(var_17_10, typeof(DynamicBoneHelper))

				if var_17_12 then
					var_17_12:EnableDynamicBone(false)
				end

				arg_14_1:ShowWeapon(var_17_11.transform, false)

				arg_14_1.var_[var_17_9 .. "Animator"] = var_17_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_14_1.var_[var_17_9 .. "Animator"].applyRootMotion = true
				arg_14_1.var_[var_17_9 .. "LipSync"] = var_17_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_17_13 = arg_14_1.actors_["1085ui_story"].transform

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos1085ui_story = var_17_13.localPosition
			end

			local var_17_14 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_14 then
				var_17_13.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_14_1.time_ - 0) / var_17_14)
				var_17_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_17_13.position).x, (manager.ui.mainCamera.transform.position - var_17_13.position).y, (manager.ui.mainCamera.transform.position - var_17_13.position).z)
				var_17_13.localEulerAngles.z = 0
				var_17_13.localEulerAngles.x = 0
				var_17_13.localEulerAngles = var_17_13.localEulerAngles
			end

			if arg_14_1.time_ >= 0 + var_17_14 and arg_14_1.time_ < 0 + var_17_14 + arg_17_0 then
				var_17_13.localPosition = Vector3.New(0, 100, 0)
				var_17_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_17_13.position).x, (manager.ui.mainCamera.transform.position - var_17_13.position).y, (manager.ui.mainCamera.transform.position - var_17_13.position).z)
				var_17_13.localEulerAngles.z = 0
				var_17_13.localEulerAngles.x = 0
				var_17_13.localEulerAngles = var_17_13.localEulerAngles
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if 3.16666666666667 < arg_14_1.time_ and arg_14_1.time_ <= 3.16666666666667 + arg_17_0 then
				arg_14_1:AudioAction("play", "effect", "se_story_140", "se_story_140_transparent01", "")
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(false)
				arg_14_1.dialog_:SetActive(false)
				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.cswbg_:SetActive(false)
			end

			if arg_14_1.frameCnt_ <= 1 then
				arg_14_1.dialog_:SetActive(false)
			end

			local var_17_17 = 2
			local var_17_18 = 1.4

			if 2 < arg_14_1.time_ and arg_14_1.time_ <= var_17_17 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				arg_14_1.dialog_:SetActive(true)

				arg_14_1.dialogCg_.alpha = 0

				local var_17_19 = LeanTween.value(arg_14_1.dialog_, 0, 1, 0.3)

				var_17_19:setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
					arg_14_1.dialogCg_.alpha = arg_18_0
				end))
				var_17_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_14_1.dialog_)
					var_17_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_14_1.duration_ = arg_14_1.duration_ + 0.3

				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_20 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(420161004).content)

				arg_14_1.text_.text = var_17_20

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_22 = 56 <= 0 and var_17_18 or var_17_18 * (utf8.len(var_17_20) / 56)

				if (56 <= 0 and var_17_18 or var_17_18 * (utf8.len(var_17_20) / 56)) > 0 and var_17_18 < var_17_22 then
					arg_14_1.talkMaxDuration = var_17_22
					var_17_17 = var_17_17 + 0.3

					if var_17_22 + var_17_17 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_22 + var_17_17
					end
				end

				arg_14_1.text_.text = var_17_20
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_23 = var_17_17 + 0.3
			local var_17_24 = math.max(var_17_18, arg_14_1.talkMaxDuration)

			if var_17_17 + 0.3 <= arg_14_1.time_ and arg_14_1.time_ < var_17_23 + var_17_24 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_23) / var_17_24

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_23 + var_17_24 and arg_14_1.time_ < var_17_23 + var_17_24 + arg_17_0 then
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
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1085ui_story = arg_20_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_23_0 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 then
				arg_20_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_20_1.time_ - 0) / var_23_0)
				arg_20_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1085ui_story"].transform.position).z)
				arg_20_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1085ui_story"].transform.localEulerAngles = arg_20_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 then
				arg_20_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_20_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1085ui_story"].transform.position).z)
				arg_20_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1085ui_story"].transform.localEulerAngles = arg_20_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_23_1 = arg_20_1.actors_["1085ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_1) and arg_20_1.var_.characterEffect1085ui_story == nil then
				arg_20_1.var_.characterEffect1085ui_story = var_23_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_2 and not isNil(var_23_1) then
				if arg_20_1.var_.characterEffect1085ui_story and not isNil(var_23_1) then
					arg_20_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_2 and arg_20_1.time_ < 0 + var_23_2 + arg_23_0 and not isNil(var_23_1) and arg_20_1.var_.characterEffect1085ui_story then
				arg_20_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_23_4 = 0
			local var_23_5 = 0.0329999998211861

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_6 = arg_20_1:GetWordFromCfg(420161005)
				local var_23_7 = arg_20_1:FormatText(var_23_6.content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 1 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 1)

				if (1 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 1)) > 0 and var_23_5 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161005", "story_v_out_420161.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_420161", "420161005", "story_v_out_420161.awb") / 1000

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end

					if var_23_6.prefab_name ~= "" and arg_20_1.actors_[var_23_6.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_6.prefab_name].transform, "story_v_out_420161", "420161005", "story_v_out_420161.awb")

						arg_20_1:RecordAudio("420161005", var_23_11)
						arg_20_1:RecordAudio("420161005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_420161", "420161005", "story_v_out_420161.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_420161", "420161005", "story_v_out_420161.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_5, arg_20_1.talkMaxDuration)

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_4) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_4 + var_23_12 and arg_20_1.time_ < var_23_4 + var_23_12 + arg_23_0 then
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
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1085ui_story = arg_24_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_27_0 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 then
				arg_24_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_0)
				arg_24_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1085ui_story"].transform.position).z)
				arg_24_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1085ui_story"].transform.localEulerAngles = arg_24_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 then
				arg_24_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1085ui_story"].transform.position).z)
				arg_24_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1085ui_story"].transform.localEulerAngles = arg_24_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if 0.05 < arg_24_1.time_ and arg_24_1.time_ <= 0.05 + arg_27_0 then
				arg_24_1:AudioAction("play", "effect", "se_story_140", "se_story_140_transparent04", "")
			end

			local var_27_2 = 0
			local var_27_3 = 0.575

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(420161006).content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 22 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 22)

				if (22 <= 0 and var_27_3 or var_27_3 * (utf8.len(var_27_4) / 22)) > 0 and var_27_3 < var_27_6 then
					arg_24_1.talkMaxDuration = var_27_6

					if var_27_6 + var_27_2 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_6 + var_27_2
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_3, arg_24_1.talkMaxDuration)

			if var_27_2 <= arg_24_1.time_ and arg_24_1.time_ < var_27_2 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_2) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_2 + var_27_7 and arg_24_1.time_ < var_27_2 + var_27_7 + arg_27_0 then
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
			local var_31_0 = 1.3

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(420161007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 52 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 52)

				if (52 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 52)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
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
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1085ui_story = arg_32_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1085ui_story"].transform.position).z)
				arg_32_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1085ui_story"].transform.localEulerAngles = arg_32_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_32_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1085ui_story"].transform.position).z)
				arg_32_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1085ui_story"].transform.localEulerAngles = arg_32_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_35_1 = arg_32_1.actors_["1085ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1085ui_story == nil then
				arg_32_1.var_.characterEffect1085ui_story = var_35_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_2 and not isNil(var_35_1) then
				if arg_32_1.var_.characterEffect1085ui_story and not isNil(var_35_1) then
					arg_32_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_2 and arg_32_1.time_ < 0 + var_35_2 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1085ui_story then
				arg_32_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_35_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_6 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_6

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_6
						arg_32_1.bgmTxt2_.text = var_35_6
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

			if 0.333333333333333 < arg_32_1.time_ and arg_32_1.time_ <= 0.333333333333333 + arg_35_0 then
				arg_32_1:AudioAction("play", "music", "bgm_activity_4_0_story_sad", "bgm_activity_4_0_story_sad", "bgm_activity_4_0_story_sad.awb")

				local var_35_9 = manager.audio:GetAudioName("bgm_activity_4_0_story_sad", "bgm_activity_4_0_story_sad")

				if "" ~= "" then
					if arg_32_1.bgmTxt_.text ~= var_35_9 and arg_32_1.bgmTxt_.text ~= "" then
						if arg_32_1.bgmTxt2_.text ~= "" then
							arg_32_1.bgmTxt_.text = arg_32_1.bgmTxt2_.text
						end

						arg_32_1.bgmTxt2_.text = var_35_9

						arg_32_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_32_1.bgmTxt_.text = var_35_9
						arg_32_1.bgmTxt2_.text = var_35_9
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

			local var_35_10 = 0
			local var_35_11 = 0.45

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_12 = arg_32_1:GetWordFromCfg(420161008)
				local var_35_13 = arg_32_1:FormatText(var_35_12.content)

				arg_32_1.text_.text = var_35_13

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 18 <= 0 and var_35_11 or var_35_11 * (utf8.len(var_35_13) / 18)

				if (18 <= 0 and var_35_11 or var_35_11 * (utf8.len(var_35_13) / 18)) > 0 and var_35_11 < var_35_15 then
					arg_32_1.talkMaxDuration = var_35_15

					if var_35_15 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_15 + var_35_10
					end
				end

				arg_32_1.text_.text = var_35_13
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161008", "story_v_out_420161.awb") ~= 0 then
					local var_35_16 = manager.audio:GetVoiceLength("story_v_out_420161", "420161008", "story_v_out_420161.awb") / 1000

					if var_35_16 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_16 + var_35_10
					end

					if var_35_12.prefab_name ~= "" and arg_32_1.actors_[var_35_12.prefab_name] ~= nil then
						local var_35_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_12.prefab_name].transform, "story_v_out_420161", "420161008", "story_v_out_420161.awb")

						arg_32_1:RecordAudio("420161008", var_35_17)
						arg_32_1:RecordAudio("420161008", var_35_17)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_420161", "420161008", "story_v_out_420161.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_420161", "420161008", "story_v_out_420161.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_18 = math.max(var_35_11, arg_32_1.talkMaxDuration)

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_18 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_10) / var_35_18

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_10 + var_35_18 and arg_32_1.time_ < var_35_10 + var_35_18 + arg_35_0 then
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
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos1085ui_story = arg_38_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_41_0 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 then
				arg_38_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_38_1.time_ - 0) / var_41_0)
				arg_38_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1085ui_story"].transform.position).z)
				arg_38_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["1085ui_story"].transform.localEulerAngles = arg_38_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 then
				arg_38_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_38_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["1085ui_story"].transform.position).z)
				arg_38_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["1085ui_story"].transform.localEulerAngles = arg_38_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_41_1 = 0
			local var_41_2 = 1.05

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_3 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(420161009).content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 42 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 42)

				if (42 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 42)) > 0 and var_41_2 < var_41_5 then
					arg_38_1.talkMaxDuration = var_41_5

					if var_41_5 + var_41_1 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + var_41_1
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_6 = math.max(var_41_2, arg_38_1.talkMaxDuration)

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_6 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_1) / var_41_6

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_1 + var_41_6 and arg_38_1.time_ < var_41_1 + var_41_6 + arg_41_0 then
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
			if 0.05 < arg_42_1.time_ and arg_42_1.time_ <= 0.05 + arg_45_0 then
				arg_42_1:AudioAction("play", "effect", "se_story_140", "se_story_140_transparent02", "")
			end

			local var_45_1 = 0
			local var_45_2 = 1.05

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_3 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(420161010).content)

				arg_42_1.text_.text = var_45_3

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 42 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 42)

				if (42 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 42)) > 0 and var_45_2 < var_45_5 then
					arg_42_1.talkMaxDuration = var_45_5

					if var_45_5 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + var_45_1
					end
				end

				arg_42_1.text_.text = var_45_3
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_6 = math.max(var_45_2, arg_42_1.talkMaxDuration)

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_6 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_1) / var_45_6

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_1 + var_45_6 and arg_42_1.time_ < var_45_1 + var_45_6 + arg_45_0 then
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
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.mask_.enabled = true
				arg_46_1.mask_.raycastTarget = true

				arg_46_1:SetGaussion(false)
			end

			local var_49_0 = 1

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 then
				local var_49_1 = Color.New(0, 0, 0)

				var_49_1.a = Mathf.Lerp(0, 1, (arg_46_1.time_ - 0) / var_49_0)
				arg_46_1.mask_.color = var_49_1
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 then
				local var_49_2 = Color.New(0, 0, 0)

				var_49_2.a = 1
				arg_46_1.mask_.color = var_49_2
			end

			local var_49_3 = 1

			if 1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_3 + arg_49_0 then
				arg_46_1.mask_.enabled = true
				arg_46_1.mask_.raycastTarget = true

				arg_46_1:SetGaussion(false)
			end

			local var_49_4 = 1

			if var_49_3 <= arg_46_1.time_ and arg_46_1.time_ < var_49_3 + var_49_4 then
				local var_49_5 = Color.New(0, 0, 0)

				var_49_5.a = Mathf.Lerp(1, 0, (arg_46_1.time_ - var_49_3) / var_49_4)
				arg_46_1.mask_.color = var_49_5
			end

			if arg_46_1.time_ >= var_49_3 + var_49_4 and arg_46_1.time_ < var_49_3 + var_49_4 + arg_49_0 then
				local var_49_6 = Color.New(0, 0, 0)

				arg_46_1.mask_.enabled = false
				var_49_6.a = 0
				arg_46_1.mask_.color = var_49_6
			end

			local var_49_7 = "ST0504"

			if arg_46_1.bgs_.ST0504 == nil then
				local var_49_8 = Object.Instantiate(arg_46_1.paintGo_)

				var_49_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_49_7)
				var_49_8.name = var_49_7
				var_49_8.transform.parent = arg_46_1.stage_.transform
				var_49_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.bgs_[var_49_7] = var_49_8
			end

			if 1 < arg_46_1.time_ and arg_46_1.time_ <= 1 + arg_49_0 then
				local var_49_9 = arg_46_1.bgs_.ST0504

				arg_46_1.bgs_.ST0504.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_49_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_49_10 = var_49_9:GetComponent("SpriteRenderer")

				if var_49_10 and var_49_10.sprite then
					local var_49_11 = 2 * (var_49_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_49_9.transform.localScale = Vector3.New(var_49_11 / var_49_10.sprite.bounds.size.y < var_49_11 * manager.ui.mainCameraCom_.aspect / var_49_10.sprite.bounds.size.x and var_49_11 * manager.ui.mainCameraCom_.aspect / var_49_10.sprite.bounds.size.x or var_49_11 / var_49_10.sprite.bounds.size.y, var_49_11 / var_49_10.sprite.bounds.size.y < var_49_11 * manager.ui.mainCameraCom_.aspect / var_49_10.sprite.bounds.size.x and var_49_11 * manager.ui.mainCameraCom_.aspect / var_49_10.sprite.bounds.size.x or var_49_11 / var_49_10.sprite.bounds.size.y, 0)
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

			local var_49_12 = 2
			local var_49_13 = 1.1

			if 2 < arg_46_1.time_ and arg_46_1.time_ <= var_49_12 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				arg_46_1.dialog_:SetActive(true)

				arg_46_1.dialogCg_.alpha = 0

				local var_49_14 = LeanTween.value(arg_46_1.dialog_, 0, 1, 0.3)

				var_49_14:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_46_1.dialogCg_.alpha = arg_50_0
				end))
				var_49_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_46_1.dialog_)
					var_49_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_46_1.duration_ = arg_46_1.duration_ + 0.3

				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_15 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(420161011).content)

				arg_46_1.text_.text = var_49_15

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_17 = 44 <= 0 and var_49_13 or var_49_13 * (utf8.len(var_49_15) / 44)

				if (44 <= 0 and var_49_13 or var_49_13 * (utf8.len(var_49_15) / 44)) > 0 and var_49_13 < var_49_17 then
					arg_46_1.talkMaxDuration = var_49_17
					var_49_12 = var_49_12 + 0.3

					if var_49_17 + var_49_12 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_17 + var_49_12
					end
				end

				arg_46_1.text_.text = var_49_15
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_18 = var_49_12 + 0.3
			local var_49_19 = math.max(var_49_13, arg_46_1.talkMaxDuration)

			if var_49_12 + 0.3 <= arg_46_1.time_ and arg_46_1.time_ < var_49_18 + var_49_19 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_18) / var_49_19

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_18 + var_49_19 and arg_46_1.time_ < var_49_18 + var_49_19 + arg_49_0 then
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
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1085ui_story = arg_52_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1085ui_story"].transform.position).z)
				arg_52_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1085ui_story"].transform.localEulerAngles = arg_52_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_52_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1085ui_story"].transform.position).z)
				arg_52_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1085ui_story"].transform.localEulerAngles = arg_52_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_55_1 = arg_52_1.actors_["1085ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1085ui_story == nil then
				arg_52_1.var_.characterEffect1085ui_story = var_55_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 and not isNil(var_55_1) then
				if arg_52_1.var_.characterEffect1085ui_story and not isNil(var_55_1) then
					arg_52_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 and not isNil(var_55_1) and arg_52_1.var_.characterEffect1085ui_story then
				arg_52_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_55_4 = 0
			local var_55_5 = 0.4

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(420161012)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 16 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 16)

				if (16 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 16)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161012", "story_v_out_420161.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_420161", "420161012", "story_v_out_420161.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_420161", "420161012", "story_v_out_420161.awb")

						arg_52_1:RecordAudio("420161012", var_55_11)
						arg_52_1:RecordAudio("420161012", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_420161", "420161012", "story_v_out_420161.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_420161", "420161012", "story_v_out_420161.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
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
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1085ui_story = arg_56_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1085ui_story"].transform.position).z)
				arg_56_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1085ui_story"].transform.localEulerAngles = arg_56_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1085ui_story"].transform.position).z)
				arg_56_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1085ui_story"].transform.localEulerAngles = arg_56_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_59_1 = arg_56_1.actors_["1085ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1085ui_story == nil then
				arg_56_1.var_.characterEffect1085ui_story = var_59_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 and not isNil(var_59_1) then
				if arg_56_1.var_.characterEffect1085ui_story and not isNil(var_59_1) then
					arg_56_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_2)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1085ui_story then
				arg_56_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_59_3 = "404001ui_story"

			if arg_56_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_59_4 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_56_1.stage_.transform)

				var_59_4.name = var_59_3
				var_59_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_[var_59_3] = var_59_4

				local var_59_5 = var_59_4:GetComponentInChildren(typeof(CharacterEffect))

				var_59_5.enabled = true

				local var_59_6 = GameObjectTools.GetOrAddComponent(var_59_4, typeof(DynamicBoneHelper))

				if var_59_6 then
					var_59_6:EnableDynamicBone(false)
				end

				arg_56_1:ShowWeapon(var_59_5.transform, false)

				arg_56_1.var_[var_59_3 .. "Animator"] = var_59_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_56_1.var_[var_59_3 .. "Animator"].applyRootMotion = true
				arg_56_1.var_[var_59_3 .. "LipSync"] = var_59_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_59_7 = arg_56_1.actors_["404001ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos404001ui_story = var_59_7.localPosition
			end

			local var_59_8 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_8 then
				var_59_7.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_56_1.time_ - 0) / var_59_8)
				var_59_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_7.position).x, (manager.ui.mainCamera.transform.position - var_59_7.position).y, (manager.ui.mainCamera.transform.position - var_59_7.position).z)
				var_59_7.localEulerAngles.z = 0
				var_59_7.localEulerAngles.x = 0
				var_59_7.localEulerAngles = var_59_7.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_8 and arg_56_1.time_ < 0 + var_59_8 + arg_59_0 then
				var_59_7.localPosition = Vector3.New(0, -1.55, -5.5)
				var_59_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_7.position).x, (manager.ui.mainCamera.transform.position - var_59_7.position).y, (manager.ui.mainCamera.transform.position - var_59_7.position).z)
				var_59_7.localEulerAngles.z = 0
				var_59_7.localEulerAngles.x = 0
				var_59_7.localEulerAngles = var_59_7.localEulerAngles
			end

			local var_59_9 = arg_56_1.actors_["404001ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect404001ui_story == nil then
				arg_56_1.var_.characterEffect404001ui_story = var_59_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_10 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_10 and not isNil(var_59_9) then
				if arg_56_1.var_.characterEffect404001ui_story and not isNil(var_59_9) then
					arg_56_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_10 and arg_56_1.time_ < 0 + var_59_10 + arg_59_0 and not isNil(var_59_9) and arg_56_1.var_.characterEffect404001ui_story then
				arg_56_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_59_12 = 0
			local var_59_13 = 1.1

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_12 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_14 = arg_56_1:GetWordFromCfg(420161013)
				local var_59_15 = arg_56_1:FormatText(var_59_14.content)

				arg_56_1.text_.text = var_59_15

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_17 = 44 <= 0 and var_59_13 or var_59_13 * (utf8.len(var_59_15) / 44)

				if (44 <= 0 and var_59_13 or var_59_13 * (utf8.len(var_59_15) / 44)) > 0 and var_59_13 < var_59_17 then
					arg_56_1.talkMaxDuration = var_59_17

					if var_59_17 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_17 + var_59_12
					end
				end

				arg_56_1.text_.text = var_59_15
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161013", "story_v_out_420161.awb") ~= 0 then
					local var_59_18 = manager.audio:GetVoiceLength("story_v_out_420161", "420161013", "story_v_out_420161.awb") / 1000

					if var_59_18 + var_59_12 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_18 + var_59_12
					end

					if var_59_14.prefab_name ~= "" and arg_56_1.actors_[var_59_14.prefab_name] ~= nil then
						local var_59_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_14.prefab_name].transform, "story_v_out_420161", "420161013", "story_v_out_420161.awb")

						arg_56_1:RecordAudio("420161013", var_59_19)
						arg_56_1:RecordAudio("420161013", var_59_19)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_420161", "420161013", "story_v_out_420161.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_420161", "420161013", "story_v_out_420161.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_20 = math.max(var_59_13, arg_56_1.talkMaxDuration)

			if var_59_12 <= arg_56_1.time_ and arg_56_1.time_ < var_59_12 + var_59_20 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_12) / var_59_20

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_12 + var_59_20 and arg_56_1.time_ < var_59_12 + var_59_20 + arg_59_0 then
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
			local var_63_0 = 0.85

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:GetWordFromCfg(420161014)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 34 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 34)

				if (34 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 34)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161014", "story_v_out_420161.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_420161", "420161014", "story_v_out_420161.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_420161", "420161014", "story_v_out_420161.awb")

						arg_60_1:RecordAudio("420161014", var_63_6)
						arg_60_1:RecordAudio("420161014", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_420161", "420161014", "story_v_out_420161.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_420161", "420161014", "story_v_out_420161.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
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
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos404001ui_story = arg_64_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_67_0 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 then
				arg_64_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_0)
				arg_64_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["404001ui_story"].transform.position).z)
				arg_64_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["404001ui_story"].transform.localEulerAngles = arg_64_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 then
				arg_64_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["404001ui_story"].transform.position).z)
				arg_64_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["404001ui_story"].transform.localEulerAngles = arg_64_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if 0.9 < arg_64_1.time_ and arg_64_1.time_ <= 0.9 + arg_67_0 then
				arg_64_1:AudioAction("play", "effect", "se_story_140", "se_story_140_transparent03", "")
			end

			local var_67_2 = 0
			local var_67_3 = 1.3

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_4 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(420161015).content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_6 = 52 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_4) / 52)

				if (52 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_4) / 52)) > 0 and var_67_3 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_2
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_3, arg_64_1.talkMaxDuration)

			if var_67_2 <= arg_64_1.time_ and arg_64_1.time_ < var_67_2 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_2) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_2 + var_67_7 and arg_64_1.time_ < var_67_2 + var_67_7 + arg_67_0 then
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
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1085ui_story = arg_68_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_71_0 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 then
				arg_68_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_68_1.time_ - 0) / var_71_0)
				arg_68_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1085ui_story"].transform.position).z)
				arg_68_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1085ui_story"].transform.localEulerAngles = arg_68_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 then
				arg_68_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_68_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1085ui_story"].transform.position).z)
				arg_68_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1085ui_story"].transform.localEulerAngles = arg_68_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_71_1 = arg_68_1.actors_["1085ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect1085ui_story == nil then
				arg_68_1.var_.characterEffect1085ui_story = var_71_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_2 and not isNil(var_71_1) then
				if arg_68_1.var_.characterEffect1085ui_story and not isNil(var_71_1) then
					arg_68_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_2 and arg_68_1.time_ < 0 + var_71_2 + arg_71_0 and not isNil(var_71_1) and arg_68_1.var_.characterEffect1085ui_story then
				arg_68_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_71_4 = 0
			local var_71_5 = 0.225

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(420161016)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 9 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 9)

				if (9 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 9)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161016", "story_v_out_420161.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_420161", "420161016", "story_v_out_420161.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_420161", "420161016", "story_v_out_420161.awb")

						arg_68_1:RecordAudio("420161016", var_71_11)
						arg_68_1:RecordAudio("420161016", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_420161", "420161016", "story_v_out_420161.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_420161", "420161016", "story_v_out_420161.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_12 and arg_68_1.time_ < var_71_4 + var_71_12 + arg_71_0 then
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
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_2")
			end

			local var_75_0 = 0

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			if arg_72_1.time_ >= var_75_0 + 0.666666666666667 and arg_72_1.time_ < var_75_0 + 0.666666666666667 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			local var_75_1 = 0
			local var_75_2 = 0.125

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:GetWordFromCfg(420161017)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_6 = 5 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_4) / 5)

				if (5 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_4) / 5)) > 0 and var_75_2 < var_75_6 then
					arg_72_1.talkMaxDuration = var_75_6

					if var_75_6 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161017", "story_v_out_420161.awb") ~= 0 then
					local var_75_7 = manager.audio:GetVoiceLength("story_v_out_420161", "420161017", "story_v_out_420161.awb") / 1000

					if var_75_7 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_1
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_420161", "420161017", "story_v_out_420161.awb")

						arg_72_1:RecordAudio("420161017", var_75_8)
						arg_72_1:RecordAudio("420161017", var_75_8)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_420161", "420161017", "story_v_out_420161.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_420161", "420161017", "story_v_out_420161.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_9 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_9 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_9

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_9 and arg_72_1.time_ < var_75_1 + var_75_9 + arg_75_0 then
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
			if 4 < arg_76_1.time_ and arg_76_1.time_ <= 4 + arg_79_0 then
				arg_76_1.allBtn_.enabled = false
			end

			if arg_76_1.time_ >= 4 + 0.733333333333333 and arg_76_1.time_ < 4 + 0.733333333333333 + arg_79_0 then
				arg_76_1.allBtn_.enabled = true
			end

			local var_79_0 = "ST61"

			if arg_76_1.bgs_.ST61 == nil then
				local var_79_1 = Object.Instantiate(arg_76_1.paintGo_)

				var_79_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_79_0)
				var_79_1.name = var_79_0
				var_79_1.transform.parent = arg_76_1.stage_.transform
				var_79_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.bgs_[var_79_0] = var_79_1
			end

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= 2 + arg_79_0 then
				local var_79_2 = arg_76_1.bgs_.ST61

				arg_76_1.bgs_.ST61.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_79_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_3 = var_79_2:GetComponent("SpriteRenderer")

				if var_79_3 and var_79_3.sprite then
					local var_79_4 = 2 * (var_79_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_79_2.transform.localScale = Vector3.New(var_79_4 / var_79_3.sprite.bounds.size.y < var_79_4 * manager.ui.mainCameraCom_.aspect / var_79_3.sprite.bounds.size.x and var_79_4 * manager.ui.mainCameraCom_.aspect / var_79_3.sprite.bounds.size.x or var_79_4 / var_79_3.sprite.bounds.size.y, var_79_4 / var_79_3.sprite.bounds.size.y < var_79_4 * manager.ui.mainCameraCom_.aspect / var_79_3.sprite.bounds.size.x and var_79_4 * manager.ui.mainCameraCom_.aspect / var_79_3.sprite.bounds.size.x or var_79_4 / var_79_3.sprite.bounds.size.y, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "ST61" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_79_5 = 0

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_6 = 2

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 then
				local var_79_7 = Color.New(0, 0, 0)

				var_79_7.a = Mathf.Lerp(0, 1, (arg_76_1.time_ - var_79_5) / var_79_6)
				arg_76_1.mask_.color = var_79_7
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 then
				local var_79_8 = Color.New(0, 0, 0)

				var_79_8.a = 1
				arg_76_1.mask_.color = var_79_8
			end

			local var_79_9 = 2

			if 2 < arg_76_1.time_ and arg_76_1.time_ <= var_79_9 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_10 = 2

			if var_79_9 <= arg_76_1.time_ and arg_76_1.time_ < var_79_9 + var_79_10 then
				local var_79_11 = Color.New(0, 0, 0)

				var_79_11.a = Mathf.Lerp(1, 0, (arg_76_1.time_ - var_79_9) / var_79_10)
				arg_76_1.mask_.color = var_79_11
			end

			if arg_76_1.time_ >= var_79_9 + var_79_10 and arg_76_1.time_ < var_79_9 + var_79_10 + arg_79_0 then
				local var_79_12 = Color.New(0, 0, 0)

				arg_76_1.mask_.enabled = false
				var_79_12.a = 0
				arg_76_1.mask_.color = var_79_12
			end

			local var_79_13 = arg_76_1.actors_["1085ui_story"].transform

			if 1.96599999815226 < arg_76_1.time_ and arg_76_1.time_ <= 1.96599999815226 + arg_79_0 then
				arg_76_1.var_.moveOldPos1085ui_story = var_79_13.localPosition
			end

			local var_79_14 = 0.001

			if 1.96599999815226 <= arg_76_1.time_ and arg_76_1.time_ < 1.96599999815226 + var_79_14 then
				var_79_13.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 1.96599999815226) / var_79_14)
				var_79_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_13.position).x, (manager.ui.mainCamera.transform.position - var_79_13.position).y, (manager.ui.mainCamera.transform.position - var_79_13.position).z)
				var_79_13.localEulerAngles.z = 0
				var_79_13.localEulerAngles.x = 0
				var_79_13.localEulerAngles = var_79_13.localEulerAngles
			end

			if arg_76_1.time_ >= 1.96599999815226 + var_79_14 and arg_76_1.time_ < 1.96599999815226 + var_79_14 + arg_79_0 then
				var_79_13.localPosition = Vector3.New(0, 100, 0)
				var_79_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_13.position).x, (manager.ui.mainCamera.transform.position - var_79_13.position).y, (manager.ui.mainCamera.transform.position - var_79_13.position).z)
				var_79_13.localEulerAngles.z = 0
				var_79_13.localEulerAngles.x = 0
				var_79_13.localEulerAngles = var_79_13.localEulerAngles
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_15 = 4
			local var_79_16 = 1.25

			if 4 < arg_76_1.time_ and arg_76_1.time_ <= var_79_15 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_17 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_17:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_18 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(420161018).content)

				arg_76_1.text_.text = var_79_18

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_20 = 50 <= 0 and var_79_16 or var_79_16 * (utf8.len(var_79_18) / 50)

				if (50 <= 0 and var_79_16 or var_79_16 * (utf8.len(var_79_18) / 50)) > 0 and var_79_16 < var_79_20 then
					arg_76_1.talkMaxDuration = var_79_20
					var_79_15 = var_79_15 + 0.3

					if var_79_20 + var_79_15 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_20 + var_79_15
					end
				end

				arg_76_1.text_.text = var_79_18
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_21 = var_79_15 + 0.3
			local var_79_22 = math.max(var_79_16, arg_76_1.talkMaxDuration)

			if var_79_15 + 0.3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_21 + var_79_22 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_21) / var_79_22

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_21 + var_79_22 and arg_76_1.time_ < var_79_21 + var_79_22 + arg_79_0 then
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
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos1085ui_story = arg_82_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_85_0 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 then
				arg_82_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_82_1.time_ - 0) / var_85_0)
				arg_82_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1085ui_story"].transform.position).z)
				arg_82_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1085ui_story"].transform.localEulerAngles = arg_82_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 then
				arg_82_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_82_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["1085ui_story"].transform.position).z)
				arg_82_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["1085ui_story"].transform.localEulerAngles = arg_82_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_85_1 = arg_82_1.actors_["1085ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_1) and arg_82_1.var_.characterEffect1085ui_story == nil then
				arg_82_1.var_.characterEffect1085ui_story = var_85_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_2 and not isNil(var_85_1) then
				if arg_82_1.var_.characterEffect1085ui_story and not isNil(var_85_1) then
					arg_82_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_2 and arg_82_1.time_ < 0 + var_85_2 + arg_85_0 and not isNil(var_85_1) and arg_82_1.var_.characterEffect1085ui_story then
				arg_82_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_85_4 = 0
			local var_85_5 = 0.3

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_6 = arg_82_1:GetWordFromCfg(420161019)
				local var_85_7 = arg_82_1:FormatText(var_85_6.content)

				arg_82_1.text_.text = var_85_7

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_9 = 12 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 12)

				if (12 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 12)) > 0 and var_85_5 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9

					if var_85_9 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_4
					end
				end

				arg_82_1.text_.text = var_85_7
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161019", "story_v_out_420161.awb") ~= 0 then
					local var_85_10 = manager.audio:GetVoiceLength("story_v_out_420161", "420161019", "story_v_out_420161.awb") / 1000

					if var_85_10 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_4
					end

					if var_85_6.prefab_name ~= "" and arg_82_1.actors_[var_85_6.prefab_name] ~= nil then
						local var_85_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_6.prefab_name].transform, "story_v_out_420161", "420161019", "story_v_out_420161.awb")

						arg_82_1:RecordAudio("420161019", var_85_11)
						arg_82_1:RecordAudio("420161019", var_85_11)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_420161", "420161019", "story_v_out_420161.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_420161", "420161019", "story_v_out_420161.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_12 = math.max(var_85_5, arg_82_1.talkMaxDuration)

			if var_85_4 <= arg_82_1.time_ and arg_82_1.time_ < var_85_4 + var_85_12 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_4) / var_85_12

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_4 + var_85_12 and arg_82_1.time_ < var_85_4 + var_85_12 + arg_85_0 then
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
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1085ui_story = arg_86_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1085ui_story, Vector3.New(-0.75, -1.01, -5.83), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1085ui_story"].transform.position).z)
				arg_86_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1085ui_story"].transform.localEulerAngles = arg_86_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(-0.75, -1.01, -5.83)
				arg_86_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1085ui_story"].transform.position).z)
				arg_86_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1085ui_story"].transform.localEulerAngles = arg_86_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_89_1 = arg_86_1.actors_["1085ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect1085ui_story == nil then
				arg_86_1.var_.characterEffect1085ui_story = var_89_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 and not isNil(var_89_1) then
				if arg_86_1.var_.characterEffect1085ui_story and not isNil(var_89_1) then
					arg_86_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_2)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect1085ui_story then
				arg_86_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_89_3 = "1089ui_story"

			if arg_86_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_89_4 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_86_1.stage_.transform)

				var_89_4.name = var_89_3
				var_89_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_[var_89_3] = var_89_4

				local var_89_5 = var_89_4:GetComponentInChildren(typeof(CharacterEffect))

				var_89_5.enabled = true

				local var_89_6 = GameObjectTools.GetOrAddComponent(var_89_4, typeof(DynamicBoneHelper))

				if var_89_6 then
					var_89_6:EnableDynamicBone(false)
				end

				arg_86_1:ShowWeapon(var_89_5.transform, false)

				arg_86_1.var_[var_89_3 .. "Animator"] = var_89_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_86_1.var_[var_89_3 .. "Animator"].applyRootMotion = true
				arg_86_1.var_[var_89_3 .. "LipSync"] = var_89_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_89_7 = arg_86_1.actors_["1089ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1089ui_story = var_89_7.localPosition

				arg_86_1:ShowWeapon(arg_86_1.var_["1089ui_story" .. "Animator"].transform, false)
			end

			local var_89_8 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_8 then
				var_89_7.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_86_1.time_ - 0) / var_89_8)
				var_89_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_7.position).x, (manager.ui.mainCamera.transform.position - var_89_7.position).y, (manager.ui.mainCamera.transform.position - var_89_7.position).z)
				var_89_7.localEulerAngles.z = 0
				var_89_7.localEulerAngles.x = 0
				var_89_7.localEulerAngles = var_89_7.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_8 and arg_86_1.time_ < 0 + var_89_8 + arg_89_0 then
				var_89_7.localPosition = Vector3.New(0.7, -1.1, -6.17)
				var_89_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_7.position).x, (manager.ui.mainCamera.transform.position - var_89_7.position).y, (manager.ui.mainCamera.transform.position - var_89_7.position).z)
				var_89_7.localEulerAngles.z = 0
				var_89_7.localEulerAngles.x = 0
				var_89_7.localEulerAngles = var_89_7.localEulerAngles
			end

			local var_89_9 = arg_86_1.actors_["1089ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect1089ui_story == nil then
				arg_86_1.var_.characterEffect1089ui_story = var_89_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_10 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_10 and not isNil(var_89_9) then
				if arg_86_1.var_.characterEffect1089ui_story and not isNil(var_89_9) then
					arg_86_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_10 and arg_86_1.time_ < 0 + var_89_10 + arg_89_0 and not isNil(var_89_9) and arg_86_1.var_.characterEffect1089ui_story then
				arg_86_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_89_12 = 0
			local var_89_13 = 0.625

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_14 = arg_86_1:GetWordFromCfg(420161020)
				local var_89_15 = arg_86_1:FormatText(var_89_14.content)

				arg_86_1.text_.text = var_89_15

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_17 = 25 <= 0 and var_89_13 or var_89_13 * (utf8.len(var_89_15) / 25)

				if (25 <= 0 and var_89_13 or var_89_13 * (utf8.len(var_89_15) / 25)) > 0 and var_89_13 < var_89_17 then
					arg_86_1.talkMaxDuration = var_89_17

					if var_89_17 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_17 + var_89_12
					end
				end

				arg_86_1.text_.text = var_89_15
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161020", "story_v_out_420161.awb") ~= 0 then
					local var_89_18 = manager.audio:GetVoiceLength("story_v_out_420161", "420161020", "story_v_out_420161.awb") / 1000

					if var_89_18 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_18 + var_89_12
					end

					if var_89_14.prefab_name ~= "" and arg_86_1.actors_[var_89_14.prefab_name] ~= nil then
						local var_89_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_14.prefab_name].transform, "story_v_out_420161", "420161020", "story_v_out_420161.awb")

						arg_86_1:RecordAudio("420161020", var_89_19)
						arg_86_1:RecordAudio("420161020", var_89_19)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_420161", "420161020", "story_v_out_420161.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_420161", "420161020", "story_v_out_420161.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_20 = math.max(var_89_13, arg_86_1.talkMaxDuration)

			if var_89_12 <= arg_86_1.time_ and arg_86_1.time_ < var_89_12 + var_89_20 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_12) / var_89_20

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_12 + var_89_20 and arg_86_1.time_ < var_89_12 + var_89_20 + arg_89_0 then
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
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1089ui_story"]) and arg_90_1.var_.characterEffect1089ui_story == nil then
				arg_90_1.var_.characterEffect1089ui_story = arg_90_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1089ui_story"]) then
				if arg_90_1.var_.characterEffect1089ui_story and not isNil(arg_90_1.actors_["1089ui_story"]) then
					arg_90_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1089ui_story"]) and arg_90_1.var_.characterEffect1089ui_story then
				arg_90_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_93_1 = arg_90_1.actors_["1085ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_1) and arg_90_1.var_.characterEffect1085ui_story == nil then
				arg_90_1.var_.characterEffect1085ui_story = var_93_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_2 and not isNil(var_93_1) then
				if arg_90_1.var_.characterEffect1085ui_story and not isNil(var_93_1) then
					arg_90_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_2)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_2 and arg_90_1.time_ < 0 + var_93_2 + arg_93_0 and not isNil(var_93_1) and arg_90_1.var_.characterEffect1085ui_story then
				arg_90_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_93_3 = 0
			local var_93_4 = 0.625

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_3 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

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

				local var_93_5 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(420161021).content)

				arg_90_1.text_.text = var_93_5

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_7 = 25 <= 0 and var_93_4 or var_93_4 * (utf8.len(var_93_5) / 25)

				if (25 <= 0 and var_93_4 or var_93_4 * (utf8.len(var_93_5) / 25)) > 0 and var_93_4 < var_93_7 then
					arg_90_1.talkMaxDuration = var_93_7

					if var_93_7 + var_93_3 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_7 + var_93_3
					end
				end

				arg_90_1.text_.text = var_93_5
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_8 = math.max(var_93_4, arg_90_1.talkMaxDuration)

			if var_93_3 <= arg_90_1.time_ and arg_90_1.time_ < var_93_3 + var_93_8 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_3) / var_93_8

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_3 + var_93_8 and arg_90_1.time_ < var_93_3 + var_93_8 + arg_93_0 then
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
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1089ui_story"]) and arg_94_1.var_.characterEffect1089ui_story == nil then
				arg_94_1.var_.characterEffect1089ui_story = arg_94_1.actors_["1089ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1089ui_story"]) then
				if arg_94_1.var_.characterEffect1089ui_story and not isNil(arg_94_1.actors_["1089ui_story"]) then
					arg_94_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1089ui_story"]) and arg_94_1.var_.characterEffect1089ui_story then
				arg_94_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_97_2 = 0
			local var_97_3 = 0.5

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_4 = arg_94_1:GetWordFromCfg(420161022)
				local var_97_5 = arg_94_1:FormatText(var_97_4.content)

				arg_94_1.text_.text = var_97_5

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_7 = 20 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 20)

				if (20 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 20)) > 0 and var_97_3 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_2
					end
				end

				arg_94_1.text_.text = var_97_5
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161022", "story_v_out_420161.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_out_420161", "420161022", "story_v_out_420161.awb") / 1000

					if var_97_8 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_2
					end

					if var_97_4.prefab_name ~= "" and arg_94_1.actors_[var_97_4.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_4.prefab_name].transform, "story_v_out_420161", "420161022", "story_v_out_420161.awb")

						arg_94_1:RecordAudio("420161022", var_97_9)
						arg_94_1:RecordAudio("420161022", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_420161", "420161022", "story_v_out_420161.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_420161", "420161022", "story_v_out_420161.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_3, arg_94_1.talkMaxDuration)

			if var_97_2 <= arg_94_1.time_ and arg_94_1.time_ < var_97_2 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_2) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_2 + var_97_10 and arg_94_1.time_ < var_97_2 + var_97_10 + arg_97_0 then
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
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1085ui_story"]) and arg_98_1.var_.characterEffect1085ui_story == nil then
				arg_98_1.var_.characterEffect1085ui_story = arg_98_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1085ui_story"]) then
				if arg_98_1.var_.characterEffect1085ui_story and not isNil(arg_98_1.actors_["1085ui_story"]) then
					arg_98_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1085ui_story"]) and arg_98_1.var_.characterEffect1085ui_story then
				arg_98_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_101_2 = arg_98_1.actors_["1089ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1089ui_story == nil then
				arg_98_1.var_.characterEffect1089ui_story = var_101_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_3 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 and not isNil(var_101_2) then
				if arg_98_1.var_.characterEffect1089ui_story and not isNil(var_101_2) then
					arg_98_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_3)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect1089ui_story then
				arg_98_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_101_4 = 0
			local var_101_5 = 0.375

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:GetWordFromCfg(420161023)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 15 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 15)

				if (15 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 15)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161023", "story_v_out_420161.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_420161", "420161023", "story_v_out_420161.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_420161", "420161023", "story_v_out_420161.awb")

						arg_98_1:RecordAudio("420161023", var_101_11)
						arg_98_1:RecordAudio("420161023", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_420161", "420161023", "story_v_out_420161.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_420161", "420161023", "story_v_out_420161.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_12 and arg_98_1.time_ < var_101_4 + var_101_12 + arg_101_0 then
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
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1085ui_story = arg_102_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1085ui_story"].transform.position).z)
				arg_102_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1085ui_story"].transform.localEulerAngles = arg_102_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_102_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1085ui_story"].transform.position).z)
				arg_102_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1085ui_story"].transform.localEulerAngles = arg_102_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_105_1 = arg_102_1.actors_["1089ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1089ui_story = var_105_1.localPosition
			end

			local var_105_2 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 then
				var_105_1.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_2)
				var_105_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_1.position).x, (manager.ui.mainCamera.transform.position - var_105_1.position).y, (manager.ui.mainCamera.transform.position - var_105_1.position).z)
				var_105_1.localEulerAngles.z = 0
				var_105_1.localEulerAngles.x = 0
				var_105_1.localEulerAngles = var_105_1.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 then
				var_105_1.localPosition = Vector3.New(0, 100, 0)
				var_105_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_1.position).x, (manager.ui.mainCamera.transform.position - var_105_1.position).y, (manager.ui.mainCamera.transform.position - var_105_1.position).z)
				var_105_1.localEulerAngles.z = 0
				var_105_1.localEulerAngles.x = 0
				var_105_1.localEulerAngles = var_105_1.localEulerAngles
			end

			if 0.05 < arg_102_1.time_ and arg_102_1.time_ <= 0.05 + arg_105_0 then
				arg_102_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run04", "")
			end

			if 1.56666666666667 < arg_102_1.time_ and arg_102_1.time_ <= 1.56666666666667 + arg_105_0 then
				arg_102_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run05", "")
			end

			local var_105_5 = 0
			local var_105_6 = 1.175

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_7 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(420161024).content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 47 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_7) / 47)

				if (47 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_7) / 47)) > 0 and var_105_6 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_5
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_6, arg_102_1.talkMaxDuration)

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_5) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_5 + var_105_10 and arg_102_1.time_ < var_105_5 + var_105_10 + arg_105_0 then
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
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1085ui_story = arg_106_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_106_1.time_ - 0) / var_109_0)
				arg_106_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1085ui_story"].transform.position).z)
				arg_106_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1085ui_story"].transform.localEulerAngles = arg_106_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_106_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1085ui_story"].transform.position).z)
				arg_106_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1085ui_story"].transform.localEulerAngles = arg_106_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_109_1 = arg_106_1.actors_["1085ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect1085ui_story == nil then
				arg_106_1.var_.characterEffect1085ui_story = var_109_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_2 and not isNil(var_109_1) then
				if arg_106_1.var_.characterEffect1085ui_story and not isNil(var_109_1) then
					arg_106_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_2 and arg_106_1.time_ < 0 + var_109_2 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect1085ui_story then
				arg_106_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0.3 < arg_106_1.time_ and arg_106_1.time_ <= 0.3 + arg_109_0 then
				arg_106_1:AudioAction("play", "effect", "se_story_140", "se_story_140_transparent04", "")
			end

			if arg_106_1.frameCnt_ <= 1 then
				arg_106_1.dialog_:SetActive(false)
			end

			local var_109_5 = 0.200000002980232
			local var_109_6 = 0.075

			if 0.200000002980232 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0

				arg_106_1.dialog_:SetActive(true)

				arg_106_1.dialogCg_.alpha = 0

				local var_109_7 = LeanTween.value(arg_106_1.dialog_, 0, 1, 0.3)

				var_109_7:setOnUpdate(LuaHelper.FloatAction(function(arg_110_0)
					arg_106_1.dialogCg_.alpha = arg_110_0
				end))
				var_109_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_106_1.dialog_)
					var_109_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_106_1.duration_ = arg_106_1.duration_ + 0.3

				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_8 = arg_106_1:GetWordFromCfg(420161025)
				local var_109_9 = arg_106_1:FormatText(var_109_8.content)

				arg_106_1.text_.text = var_109_9

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 3 <= 0 and var_109_6 or var_109_6 * (utf8.len(var_109_9) / 3)

				if (3 <= 0 and var_109_6 or var_109_6 * (utf8.len(var_109_9) / 3)) > 0 and var_109_6 < var_109_11 then
					arg_106_1.talkMaxDuration = var_109_11
					var_109_5 = var_109_5 + 0.3

					if var_109_11 + var_109_5 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_11 + var_109_5
					end
				end

				arg_106_1.text_.text = var_109_9
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161025", "story_v_out_420161.awb") ~= 0 then
					local var_109_12 = manager.audio:GetVoiceLength("story_v_out_420161", "420161025", "story_v_out_420161.awb") / 1000

					if var_109_12 + var_109_5 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_5
					end

					if var_109_8.prefab_name ~= "" and arg_106_1.actors_[var_109_8.prefab_name] ~= nil then
						local var_109_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_8.prefab_name].transform, "story_v_out_420161", "420161025", "story_v_out_420161.awb")

						arg_106_1:RecordAudio("420161025", var_109_13)
						arg_106_1:RecordAudio("420161025", var_109_13)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_420161", "420161025", "story_v_out_420161.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_420161", "420161025", "story_v_out_420161.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = var_109_5 + 0.3
			local var_109_15 = math.max(var_109_6, arg_106_1.talkMaxDuration)

			if var_109_5 + 0.3 <= arg_106_1.time_ and arg_106_1.time_ < var_109_14 + var_109_15 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_14) / var_109_15

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_14 + var_109_15 and arg_106_1.time_ < var_109_14 + var_109_15 + arg_109_0 then
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
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1085ui_story = arg_112_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1085ui_story"].transform.position).z)
				arg_112_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1085ui_story"].transform.localEulerAngles = arg_112_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1085ui_story"].transform.position).z)
				arg_112_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1085ui_story"].transform.localEulerAngles = arg_112_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_115_1 = 0
			local var_115_2 = 0.45

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_3 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(420161026).content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 18 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_3) / 18)

				if (18 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_3) / 18)) > 0 and var_115_2 < var_115_5 then
					arg_112_1.talkMaxDuration = var_115_5

					if var_115_5 + var_115_1 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + var_115_1
					end
				end

				arg_112_1.text_.text = var_115_3
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_6 = math.max(var_115_2, arg_112_1.talkMaxDuration)

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_6 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_1) / var_115_6

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_1 + var_115_6 and arg_112_1.time_ < var_115_1 + var_115_6 + arg_115_0 then
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
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1085ui_story = arg_116_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1085ui_story"].transform.position).z)
				arg_116_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1085ui_story"].transform.localEulerAngles = arg_116_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_116_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1085ui_story"].transform.position).z)
				arg_116_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1085ui_story"].transform.localEulerAngles = arg_116_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_119_1 = arg_116_1.actors_["1085ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1085ui_story == nil then
				arg_116_1.var_.characterEffect1085ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 and not isNil(var_119_1) then
				if arg_116_1.var_.characterEffect1085ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect1085ui_story then
				arg_116_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action7_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_119_4 = 0
			local var_119_5 = 0.425

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(420161027)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 17 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 17)

				if (17 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 17)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161027", "story_v_out_420161.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_420161", "420161027", "story_v_out_420161.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_420161", "420161027", "story_v_out_420161.awb")

						arg_116_1:RecordAudio("420161027", var_119_11)
						arg_116_1:RecordAudio("420161027", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_420161", "420161027", "story_v_out_420161.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_420161", "420161027", "story_v_out_420161.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
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
			local var_123_0 = 0.65

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:GetWordFromCfg(420161028)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 26 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 26)

				if (26 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 26)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161028", "story_v_out_420161.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_420161", "420161028", "story_v_out_420161.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_420161", "420161028", "story_v_out_420161.awb")

						arg_120_1:RecordAudio("420161028", var_123_6)
						arg_120_1:RecordAudio("420161028", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_420161", "420161028", "story_v_out_420161.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_420161", "420161028", "story_v_out_420161.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
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
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action478")
			end

			local var_127_0 = 0
			local var_127_1 = 0.625

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_2 = arg_124_1:GetWordFromCfg(420161029)
				local var_127_3 = arg_124_1:FormatText(var_127_2.content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 25 <= 0 and var_127_1 or var_127_1 * (utf8.len(var_127_3) / 25)

				if (25 <= 0 and var_127_1 or var_127_1 * (utf8.len(var_127_3) / 25)) > 0 and var_127_1 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161029", "story_v_out_420161.awb") ~= 0 then
					local var_127_6 = manager.audio:GetVoiceLength("story_v_out_420161", "420161029", "story_v_out_420161.awb") / 1000

					if var_127_6 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_0
					end

					if var_127_2.prefab_name ~= "" and arg_124_1.actors_[var_127_2.prefab_name] ~= nil then
						local var_127_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_2.prefab_name].transform, "story_v_out_420161", "420161029", "story_v_out_420161.awb")

						arg_124_1:RecordAudio("420161029", var_127_7)
						arg_124_1:RecordAudio("420161029", var_127_7)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_420161", "420161029", "story_v_out_420161.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_420161", "420161029", "story_v_out_420161.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_8 and arg_124_1.time_ < var_127_0 + var_127_8 + arg_127_0 then
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
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1085ui_story = arg_128_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1085ui_story"].transform.position).z)
				arg_128_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1085ui_story"].transform.localEulerAngles = arg_128_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1085ui_story"].transform.position).z)
				arg_128_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1085ui_story"].transform.localEulerAngles = arg_128_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_131_1 = 0
			local var_131_2 = 1.075

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_3 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(420161030).content)

				arg_128_1.text_.text = var_131_3

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_5 = 43 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_3) / 43)

				if (43 <= 0 and var_131_2 or var_131_2 * (utf8.len(var_131_3) / 43)) > 0 and var_131_2 < var_131_5 then
					arg_128_1.talkMaxDuration = var_131_5

					if var_131_5 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + var_131_1
					end
				end

				arg_128_1.text_.text = var_131_3
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_6 = math.max(var_131_2, arg_128_1.talkMaxDuration)

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_6 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_1) / var_131_6

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_1 + var_131_6 and arg_128_1.time_ < var_131_1 + var_131_6 + arg_131_0 then
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
			local var_135_0 = 1.425

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(420161031).content)

				arg_132_1.text_.text = var_135_1

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_3 = 57 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 57)

				if (57 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 57)) > 0 and var_135_0 < var_135_3 then
					arg_132_1.talkMaxDuration = var_135_3

					if var_135_3 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_3 + 0
					end
				end

				arg_132_1.text_.text = var_135_1
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_4 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_4

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 then
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
			if arg_136_1.bgs_.L16f == nil then
				local var_139_0 = Object.Instantiate(arg_136_1.paintGo_)

				var_139_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L16f")
				var_139_0.name = "L16f"
				var_139_0.transform.parent = arg_136_1.stage_.transform
				var_139_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.bgs_.L16f = var_139_0
			end

			if 2 < arg_136_1.time_ and arg_136_1.time_ <= 2 + arg_139_0 then
				local var_139_1 = arg_136_1.bgs_.L16f

				arg_136_1.bgs_.L16f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_139_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_139_2 = var_139_1:GetComponent("SpriteRenderer")

				if var_139_2 and var_139_2.sprite then
					local var_139_3 = 2 * (var_139_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_139_1.transform.localScale = Vector3.New(var_139_3 / var_139_2.sprite.bounds.size.y < var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x and var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x or var_139_3 / var_139_2.sprite.bounds.size.y, var_139_3 / var_139_2.sprite.bounds.size.y < var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x and var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x or var_139_3 / var_139_2.sprite.bounds.size.y, 0)
				end

				for iter_139_0, iter_139_1 in pairs(arg_136_1.bgs_) do
					if iter_139_0 ~= "L16f" then
						iter_139_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_139_4 = 4

			if 4 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.allBtn_.enabled = false
			end

			if arg_136_1.time_ >= var_139_4 + 0.3 and arg_136_1.time_ < var_139_4 + 0.3 + arg_139_0 then
				arg_136_1.allBtn_.enabled = true
			end

			local var_139_5 = 0

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_6 = 2

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 then
				local var_139_7 = Color.New(0, 0, 0)

				var_139_7.a = Mathf.Lerp(0, 1, (arg_136_1.time_ - var_139_5) / var_139_6)
				arg_136_1.mask_.color = var_139_7
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 then
				local var_139_8 = Color.New(0, 0, 0)

				var_139_8.a = 1
				arg_136_1.mask_.color = var_139_8
			end

			local var_139_9 = 2

			if 2 < arg_136_1.time_ and arg_136_1.time_ <= var_139_9 + arg_139_0 then
				arg_136_1.mask_.enabled = true
				arg_136_1.mask_.raycastTarget = true

				arg_136_1:SetGaussion(false)
			end

			local var_139_10 = 2

			if var_139_9 <= arg_136_1.time_ and arg_136_1.time_ < var_139_9 + var_139_10 then
				local var_139_11 = Color.New(0, 0, 0)

				var_139_11.a = Mathf.Lerp(1, 0, (arg_136_1.time_ - var_139_9) / var_139_10)
				arg_136_1.mask_.color = var_139_11
			end

			if arg_136_1.time_ >= var_139_9 + var_139_10 and arg_136_1.time_ < var_139_9 + var_139_10 + arg_139_0 then
				local var_139_12 = Color.New(0, 0, 0)

				arg_136_1.mask_.enabled = false
				var_139_12.a = 0
				arg_136_1.mask_.color = var_139_12
			end

			if 4 < arg_136_1.time_ and arg_136_1.time_ <= 4 + arg_139_0 then
				arg_136_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car_hit", "")
			end

			local var_139_14 = manager.ui.mainCamera.transform

			if 4 < arg_136_1.time_ and arg_136_1.time_ <= 4 + arg_139_0 then
				arg_136_1.var_.shakeOldPos = var_139_14.localPosition
			end

			local var_139_15 = 0.3

			if 4 <= arg_136_1.time_ and arg_136_1.time_ < 4 + var_139_15 then
				local var_139_16, var_139_17 = math.modf((arg_136_1.time_ - 4) / 0.066)

				var_139_14.localPosition = Vector3.New(var_139_17 * 0.13, var_139_17 * 0.13, var_139_17 * 0.13) + arg_136_1.var_.shakeOldPos
			end

			if arg_136_1.time_ >= 4 + var_139_15 and arg_136_1.time_ < 4 + var_139_15 + arg_139_0 then
				var_139_14.localPosition = arg_136_1.var_.shakeOldPos
			end

			if arg_136_1.frameCnt_ <= 1 then
				arg_136_1.dialog_:SetActive(false)
			end

			local var_139_18 = 4
			local var_139_19 = 0.725

			if 4 < arg_136_1.time_ and arg_136_1.time_ <= var_139_18 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0

				arg_136_1.dialog_:SetActive(true)

				arg_136_1.dialogCg_.alpha = 0

				local var_139_20 = LeanTween.value(arg_136_1.dialog_, 0, 1, 0.3)

				var_139_20:setOnUpdate(LuaHelper.FloatAction(function(arg_140_0)
					arg_136_1.dialogCg_.alpha = arg_140_0
				end))
				var_139_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_136_1.dialog_)
					var_139_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_136_1.duration_ = arg_136_1.duration_ + 0.3

				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_21 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(420161032).content)

				arg_136_1.text_.text = var_139_21

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_23 = 29 <= 0 and var_139_19 or var_139_19 * (utf8.len(var_139_21) / 29)

				if (29 <= 0 and var_139_19 or var_139_19 * (utf8.len(var_139_21) / 29)) > 0 and var_139_19 < var_139_23 then
					arg_136_1.talkMaxDuration = var_139_23
					var_139_18 = var_139_18 + 0.3

					if var_139_23 + var_139_18 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_23 + var_139_18
					end
				end

				arg_136_1.text_.text = var_139_21
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_24 = var_139_18 + 0.3
			local var_139_25 = math.max(var_139_19, arg_136_1.talkMaxDuration)

			if var_139_18 + 0.3 <= arg_136_1.time_ and arg_136_1.time_ < var_139_24 + var_139_25 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_24) / var_139_25

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_24 + var_139_25 and arg_136_1.time_ < var_139_24 + var_139_25 + arg_139_0 then
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
			if 0.2 < arg_142_1.time_ and arg_142_1.time_ <= 0.2 + arg_145_0 then
				arg_142_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car_door", "")
			end

			local var_145_1 = 0
			local var_145_2 = 1.05

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_3 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(420161033).content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 42 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 42)

				if (42 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 42)) > 0 and var_145_2 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_1
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_6 = math.max(var_145_2, arg_142_1.talkMaxDuration)

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_6 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_1) / var_145_6

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_1 + var_145_6 and arg_142_1.time_ < var_145_1 + var_145_6 + arg_145_0 then
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
			if 1 < arg_146_1.time_ and arg_146_1.time_ <= 1 + arg_149_0 then
				arg_146_1:AudioAction("play", "effect", "se_story_140", "se_story_140_car02", "")
			end

			local var_149_1 = 0
			local var_149_2 = 0.75

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_3 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(420161034).content)

				arg_146_1.text_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 30 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_3) / 30)

				if (30 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_3) / 30)) > 0 and var_149_2 < var_149_5 then
					arg_146_1.talkMaxDuration = var_149_5

					if var_149_5 + var_149_1 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + var_149_1
					end
				end

				arg_146_1.text_.text = var_149_3
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_6 = math.max(var_149_2, arg_146_1.talkMaxDuration)

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_6 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_1) / var_149_6

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_1 + var_149_6 and arg_146_1.time_ < var_149_1 + var_149_6 + arg_149_0 then
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
			local var_153_0 = 0.325

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[1159].name)

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

				local var_153_1 = arg_150_1:GetWordFromCfg(420161035)
				local var_153_2 = arg_150_1:FormatText(var_153_1.content)

				arg_150_1.text_.text = var_153_2

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 13 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 13)

				if (13 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 13)) > 0 and var_153_0 < var_153_4 then
					arg_150_1.talkMaxDuration = var_153_4

					if var_153_4 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_4 + 0
					end
				end

				arg_150_1.text_.text = var_153_2
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161035", "story_v_out_420161.awb") ~= 0 then
					local var_153_5 = manager.audio:GetVoiceLength("story_v_out_420161", "420161035", "story_v_out_420161.awb") / 1000

					if var_153_5 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + 0
					end

					if var_153_1.prefab_name ~= "" and arg_150_1.actors_[var_153_1.prefab_name] ~= nil then
						local var_153_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_1.prefab_name].transform, "story_v_out_420161", "420161035", "story_v_out_420161.awb")

						arg_150_1:RecordAudio("420161035", var_153_6)
						arg_150_1:RecordAudio("420161035", var_153_6)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_420161", "420161035", "story_v_out_420161.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_420161", "420161035", "story_v_out_420161.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
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
			if arg_154_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_157_0 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_154_1.stage_.transform)

				var_157_0.name = "1056ui_story"
				var_157_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.actors_["1056ui_story"] = var_157_0

				local var_157_1 = var_157_0:GetComponentInChildren(typeof(CharacterEffect))

				var_157_1.enabled = true

				local var_157_2 = GameObjectTools.GetOrAddComponent(var_157_0, typeof(DynamicBoneHelper))

				if var_157_2 then
					var_157_2:EnableDynamicBone(false)
				end

				arg_154_1:ShowWeapon(var_157_1.transform, false)

				arg_154_1.var_["1056ui_story" .. "Animator"] = var_157_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_154_1.var_["1056ui_story" .. "Animator"].applyRootMotion = true
				arg_154_1.var_["1056ui_story" .. "LipSync"] = var_157_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_157_3 = arg_154_1.actors_["1056ui_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1056ui_story = var_157_3.localPosition

				arg_154_1:ShowWeapon(arg_154_1.var_["1056ui_story" .. "Animator"].transform, false)
			end

			local var_157_4 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				var_157_3.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_154_1.time_ - 0) / var_157_4)
				var_157_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_3.position).x, (manager.ui.mainCamera.transform.position - var_157_3.position).y, (manager.ui.mainCamera.transform.position - var_157_3.position).z)
				var_157_3.localEulerAngles.z = 0
				var_157_3.localEulerAngles.x = 0
				var_157_3.localEulerAngles = var_157_3.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				var_157_3.localPosition = Vector3.New(0, -1, -5.75)
				var_157_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_3.position).x, (manager.ui.mainCamera.transform.position - var_157_3.position).y, (manager.ui.mainCamera.transform.position - var_157_3.position).z)
				var_157_3.localEulerAngles.z = 0
				var_157_3.localEulerAngles.x = 0
				var_157_3.localEulerAngles = var_157_3.localEulerAngles
			end

			local var_157_5 = arg_154_1.actors_["1056ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_5) and arg_154_1.var_.characterEffect1056ui_story == nil then
				arg_154_1.var_.characterEffect1056ui_story = var_157_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_6 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_6 and not isNil(var_157_5) then
				if arg_154_1.var_.characterEffect1056ui_story and not isNil(var_157_5) then
					arg_154_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_6 and arg_154_1.time_ < 0 + var_157_6 + arg_157_0 and not isNil(var_157_5) and arg_154_1.var_.characterEffect1056ui_story then
				arg_154_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action8_1")
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_157_8 = 0

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_8 + arg_157_0 then
				arg_154_1.allBtn_.enabled = false
			end

			if arg_154_1.time_ >= var_157_8 + 0.833333333333333 and arg_154_1.time_ < var_157_8 + 0.833333333333333 + arg_157_0 then
				arg_154_1.allBtn_.enabled = true
			end

			if arg_154_1.frameCnt_ <= 1 then
				arg_154_1.dialog_:SetActive(false)
			end

			local var_157_9 = 0.333333333333333
			local var_157_10 = 0.225

			if 0.333333333333333 < arg_154_1.time_ and arg_154_1.time_ <= var_157_9 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0

				arg_154_1.dialog_:SetActive(true)

				arg_154_1.dialogCg_.alpha = 0

				local var_157_11 = LeanTween.value(arg_154_1.dialog_, 0, 1, 0.3)

				var_157_11:setOnUpdate(LuaHelper.FloatAction(function(arg_158_0)
					arg_154_1.dialogCg_.alpha = arg_158_0
				end))
				var_157_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_154_1.dialog_)
					var_157_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_154_1.duration_ = arg_154_1.duration_ + 0.3

				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_12 = arg_154_1:GetWordFromCfg(420161036)
				local var_157_13 = arg_154_1:FormatText(var_157_12.content)

				arg_154_1.text_.text = var_157_13

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_15 = 9 <= 0 and var_157_10 or var_157_10 * (utf8.len(var_157_13) / 9)

				if (9 <= 0 and var_157_10 or var_157_10 * (utf8.len(var_157_13) / 9)) > 0 and var_157_10 < var_157_15 then
					arg_154_1.talkMaxDuration = var_157_15
					var_157_9 = var_157_9 + 0.3

					if var_157_15 + var_157_9 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_15 + var_157_9
					end
				end

				arg_154_1.text_.text = var_157_13
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161036", "story_v_out_420161.awb") ~= 0 then
					local var_157_16 = manager.audio:GetVoiceLength("story_v_out_420161", "420161036", "story_v_out_420161.awb") / 1000

					if var_157_16 + var_157_9 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_16 + var_157_9
					end

					if var_157_12.prefab_name ~= "" and arg_154_1.actors_[var_157_12.prefab_name] ~= nil then
						local var_157_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_12.prefab_name].transform, "story_v_out_420161", "420161036", "story_v_out_420161.awb")

						arg_154_1:RecordAudio("420161036", var_157_17)
						arg_154_1:RecordAudio("420161036", var_157_17)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_420161", "420161036", "story_v_out_420161.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_420161", "420161036", "story_v_out_420161.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_18 = var_157_9 + 0.3
			local var_157_19 = math.max(var_157_10, arg_154_1.talkMaxDuration)

			if var_157_9 + 0.3 <= arg_154_1.time_ and arg_154_1.time_ < var_157_18 + var_157_19 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_18) / var_157_19

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_18 + var_157_19 and arg_154_1.time_ < var_157_18 + var_157_19 + arg_157_0 then
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
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1056ui_story"]) and arg_160_1.var_.characterEffect1056ui_story == nil then
				arg_160_1.var_.characterEffect1056ui_story = arg_160_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1056ui_story"]) then
				if arg_160_1.var_.characterEffect1056ui_story and not isNil(arg_160_1.actors_["1056ui_story"]) then
					arg_160_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_0)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1056ui_story"]) and arg_160_1.var_.characterEffect1056ui_story then
				arg_160_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_163_1 = 0
			local var_163_2 = 0.4

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1159].name)

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

				local var_163_3 = arg_160_1:GetWordFromCfg(420161037)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_6 = 16 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_4) / 16)

				if (16 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_4) / 16)) > 0 and var_163_2 < var_163_6 then
					arg_160_1.talkMaxDuration = var_163_6

					if var_163_6 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_6 + var_163_1
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161037", "story_v_out_420161.awb") ~= 0 then
					local var_163_7 = manager.audio:GetVoiceLength("story_v_out_420161", "420161037", "story_v_out_420161.awb") / 1000

					if var_163_7 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_1
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_420161", "420161037", "story_v_out_420161.awb")

						arg_160_1:RecordAudio("420161037", var_163_8)
						arg_160_1:RecordAudio("420161037", var_163_8)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_420161", "420161037", "story_v_out_420161.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_420161", "420161037", "story_v_out_420161.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_9 = math.max(var_163_2, arg_160_1.talkMaxDuration)

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_9 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_1) / var_163_9

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_1 + var_163_9 and arg_160_1.time_ < var_163_1 + var_163_9 + arg_163_0 then
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
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1056ui_story"]) and arg_164_1.var_.characterEffect1056ui_story == nil then
				arg_164_1.var_.characterEffect1056ui_story = arg_164_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1056ui_story"]) then
				if arg_164_1.var_.characterEffect1056ui_story and not isNil(arg_164_1.actors_["1056ui_story"]) then
					arg_164_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1056ui_story"]) and arg_164_1.var_.characterEffect1056ui_story then
				arg_164_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_167_2 = 0
			local var_167_3 = 0.325

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_2 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_4 = arg_164_1:GetWordFromCfg(420161038)
				local var_167_5 = arg_164_1:FormatText(var_167_4.content)

				arg_164_1.text_.text = var_167_5

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_7 = 13 <= 0 and var_167_3 or var_167_3 * (utf8.len(var_167_5) / 13)

				if (13 <= 0 and var_167_3 or var_167_3 * (utf8.len(var_167_5) / 13)) > 0 and var_167_3 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_2 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_2
					end
				end

				arg_164_1.text_.text = var_167_5
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420161", "420161038", "story_v_out_420161.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_420161", "420161038", "story_v_out_420161.awb") / 1000

					if var_167_8 + var_167_2 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_2
					end

					if var_167_4.prefab_name ~= "" and arg_164_1.actors_[var_167_4.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_4.prefab_name].transform, "story_v_out_420161", "420161038", "story_v_out_420161.awb")

						arg_164_1:RecordAudio("420161038", var_167_9)
						arg_164_1:RecordAudio("420161038", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_420161", "420161038", "story_v_out_420161.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_420161", "420161038", "story_v_out_420161.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_3, arg_164_1.talkMaxDuration)

			if var_167_2 <= arg_164_1.time_ and arg_164_1.time_ < var_167_2 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_2) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_2 + var_167_10 and arg_164_1.time_ < var_167_2 + var_167_10 + arg_167_0 then
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
