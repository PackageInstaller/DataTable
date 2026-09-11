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
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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

			if 0.233333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.233333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_4_5 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if "" ~= "" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_6 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_7 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_8 = var_4_6:GetComponent("RectTransform")

				var_4_6:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_8.offsetMin = Vector2.New(0, 0)
				var_4_8.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319891001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_9 = 0.633333333333333

			if 0.633333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_10 = 9
			local var_4_11 = 0.6
			local var_4_12, var_4_13 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319891001).content), 1)

			if var_4_9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_14 = var_4_10 <= 0 and var_4_11 or var_4_11 * ((var_4_13 - arg_1_1.typewritterCharCountI18N) / var_4_10)

				if (var_4_10 <= 0 and var_4_11 or var_4_11 * ((var_4_13 - arg_1_1.typewritterCharCountI18N) / var_4_10)) > 0 and var_4_11 < var_4_14 then
					arg_1_1.talkMaxDuration = var_4_14

					if var_4_14 + var_4_9 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_14 + var_4_9
					end
				end
			end

			local var_4_15 = math.max(0.6, arg_1_1.talkMaxDuration)

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_15 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_12, (arg_1_1.time_ - var_4_9) / var_4_15)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_9 + var_4_15 and arg_1_1.time_ < var_4_9 + var_4_15 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_12

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_13
			end

			local var_4_16 = "STblack"

			if arg_1_1.bgs_.STblack == nil then
				local var_4_17 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_17:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_16)
				var_4_17.name = var_4_16
				var_4_17.transform.parent = arg_1_1.stage_.transform
				var_4_17.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_16] = var_4_17
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_18 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_19 = var_4_18:GetComponent("SpriteRenderer")

				if var_4_19 and var_4_19.sprite then
					local var_4_20 = 2 * (var_4_18.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_18.transform.localScale = Vector3.New(var_4_20 / var_4_19.sprite.bounds.size.y < var_4_20 * manager.ui.mainCameraCom_.aspect / var_4_19.sprite.bounds.size.x and var_4_20 * manager.ui.mainCameraCom_.aspect / var_4_19.sprite.bounds.size.x or var_4_20 / var_4_19.sprite.bounds.size.y, var_4_20 / var_4_19.sprite.bounds.size.y < var_4_20 * manager.ui.mainCameraCom_.aspect / var_4_19.sprite.bounds.size.x and var_4_20 * manager.ui.mainCameraCom_.aspect / var_4_19.sprite.bounds.size.x or var_4_20 / var_4_19.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_21 = 0.633333333333333
			local var_4_22 = manager.audio:GetVoiceLength("story_v_out_319891", "319891001", "story_v_out_319891.awb") / 1000

			if var_4_22 > 0 and 1.833 < var_4_22 and var_4_22 + var_4_21 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_22 + var_4_21
			end

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_319891", "319891001", "story_v_out_319891.awb")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_24 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_24.offsetMin = Vector2.New(410, 330)
				var_4_24.offsetMax = Vector2.New(-400, -180)
				arg_1_1.cswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(419064).content)

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
			if arg_7_1.bgs_.ST15a == nil then
				local var_10_0 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15a")
				var_10_0.name = "ST15a"
				var_10_0.transform.parent = arg_7_1.stage_.transform
				var_10_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_.ST15a = var_10_0
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				local var_10_1 = arg_7_1.bgs_.ST15a

				arg_7_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_10_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_10_2 = var_10_1:GetComponent("SpriteRenderer")

				if var_10_2 and var_10_2.sprite then
					local var_10_3 = 2 * (var_10_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_10_1.transform.localScale = Vector3.New(var_10_3 / var_10_2.sprite.bounds.size.y < var_10_3 * manager.ui.mainCameraCom_.aspect / var_10_2.sprite.bounds.size.x and var_10_3 * manager.ui.mainCameraCom_.aspect / var_10_2.sprite.bounds.size.x or var_10_3 / var_10_2.sprite.bounds.size.y, var_10_3 / var_10_2.sprite.bounds.size.y < var_10_3 * manager.ui.mainCameraCom_.aspect / var_10_2.sprite.bounds.size.x and var_10_3 * manager.ui.mainCameraCom_.aspect / var_10_2.sprite.bounds.size.x or var_10_3 / var_10_2.sprite.bounds.size.y, 0)
				end

				for iter_10_0, iter_10_1 in pairs(arg_7_1.bgs_) do
					if iter_10_0 ~= "ST15a" then
						iter_10_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_10_4 = 0

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_4 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_5 = 1.4

			if var_10_4 <= arg_7_1.time_ and arg_7_1.time_ < var_10_4 + var_10_5 then
				local var_10_6 = Color.New(0, 0, 0)

				var_10_6.a = Mathf.Lerp(1, 0, (arg_7_1.time_ - var_10_4) / var_10_5)
				arg_7_1.mask_.color = var_10_6
			end

			if arg_7_1.time_ >= var_10_4 + var_10_5 and arg_7_1.time_ < var_10_4 + var_10_5 + arg_10_0 then
				local var_10_7 = Color.New(0, 0, 0)

				arg_7_1.mask_.enabled = false
				var_10_7.a = 0
				arg_7_1.mask_.color = var_10_7
			end

			local var_10_8 = "1084ui_story"

			if arg_7_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_10_9 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_7_1.stage_.transform)

				var_10_9.name = var_10_8
				var_10_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_[var_10_8] = var_10_9

				local var_10_10 = var_10_9:GetComponentInChildren(typeof(CharacterEffect))

				var_10_10.enabled = true

				local var_10_11 = GameObjectTools.GetOrAddComponent(var_10_9, typeof(DynamicBoneHelper))

				if var_10_11 then
					var_10_11:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_10.transform, false)

				arg_7_1.var_[var_10_8 .. "Animator"] = var_10_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_[var_10_8 .. "Animator"].applyRootMotion = true
				arg_7_1.var_[var_10_8 .. "LipSync"] = var_10_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_12 = arg_7_1.actors_["1084ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_12) and arg_7_1.var_.characterEffect1084ui_story == nil then
				arg_7_1.var_.characterEffect1084ui_story = var_10_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_13 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_13 and not isNil(var_10_12) then
				if arg_7_1.var_.characterEffect1084ui_story and not isNil(var_10_12) then
					arg_7_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_13)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_13 and arg_7_1.time_ < 0 + var_10_13 + arg_10_0 and not isNil(var_10_12) and arg_7_1.var_.characterEffect1084ui_story then
				arg_7_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:AudioAction("play", "effect", "se_story_130", "se_story_130_sea", "")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.fswbg_:SetActive(false)
				arg_7_1.dialog_:SetActive(false)
				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			if 0.1 < arg_7_1.time_ and arg_7_1.time_ <= 0.1 + arg_10_0 then
				arg_7_1.fswbg_:SetActive(false)
				arg_7_1.dialog_:SetActive(false)
				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.cswbg_:SetActive(false)
			end

			if arg_7_1.frameCnt_ <= 1 then
				arg_7_1.dialog_:SetActive(false)
			end

			local var_10_15 = 1.23333333333333
			local var_10_16 = 1.475

			if 1.23333333333333 < arg_7_1.time_ and arg_7_1.time_ <= var_10_15 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				arg_7_1.dialog_:SetActive(true)

				arg_7_1.dialogCg_.alpha = 0

				local var_10_17 = LeanTween.value(arg_7_1.dialog_, 0, 1, 0.3)

				var_10_17:setOnUpdate(LuaHelper.FloatAction(function(arg_11_0)
					arg_7_1.dialogCg_.alpha = arg_11_0
				end))
				var_10_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_7_1.dialog_)
					var_10_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_7_1.duration_ = arg_7_1.duration_ + 0.3

				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_18 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(319891002).content)

				arg_7_1.text_.text = var_10_18

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_20 = 59 <= 0 and var_10_16 or var_10_16 * (utf8.len(var_10_18) / 59)

				if (59 <= 0 and var_10_16 or var_10_16 * (utf8.len(var_10_18) / 59)) > 0 and var_10_16 < var_10_20 then
					arg_7_1.talkMaxDuration = var_10_20
					var_10_15 = var_10_15 + 0.3

					if var_10_20 + var_10_15 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_20 + var_10_15
					end
				end

				arg_7_1.text_.text = var_10_18
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_21 = var_10_15 + 0.3
			local var_10_22 = math.max(var_10_16, arg_7_1.talkMaxDuration)

			if var_10_15 + 0.3 <= arg_7_1.time_ and arg_7_1.time_ < var_10_21 + var_10_22 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_21) / var_10_22

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_21 + var_10_22 and arg_7_1.time_ < var_10_21 + var_10_22 + arg_10_0 then
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
			local var_16_0 = 1.425

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(319891003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 57 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 57)

				if (57 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 57)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
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
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1084ui_story = arg_17_1.actors_["1084ui_story"].transform.localPosition

				arg_17_1:ShowWeapon(arg_17_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1084ui_story"].transform.position).z)
				arg_17_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1084ui_story"].transform.localEulerAngles = arg_17_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_17_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1084ui_story"].transform.position).z)
				arg_17_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1084ui_story"].transform.localEulerAngles = arg_17_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1084ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1084ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_20_4 = 0
			local var_20_5 = 0.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(319891004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 10 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 10)

				if (10 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 10)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891004", "story_v_out_319891.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_319891", "319891004", "story_v_out_319891.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_319891", "319891004", "story_v_out_319891.awb")

						arg_17_1:RecordAudio("319891004", var_20_11)
						arg_17_1:RecordAudio("319891004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319891", "319891004", "story_v_out_319891.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319891", "319891004", "story_v_out_319891.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
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
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1084ui_story = arg_21_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).z)
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles = arg_21_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).z)
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles = arg_21_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_1 = arg_21_1.fswbg_.transform:Find("textbox/adapt/content") or arg_21_1.fswbg_.transform:Find("textbox/content")
				local var_24_2 = arg_21_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_24_3 = var_24_1:GetComponent("RectTransform")

				var_24_1:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_24_3.offsetMin = Vector2.New(0, 0)
				var_24_3.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.fswbg_:SetActive(true)
				arg_21_1.dialog_:SetActive(false)

				arg_21_1.fswtw_.percent = 0
				arg_21_1.fswt_.text = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(319891005).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.fswt_)

				arg_21_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_21_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_21_1.fswtw_:SetDirty()

				arg_21_1.typewritterCharCountI18N = 0

				SetActive(arg_21_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_21_1:ShowNextGo(false)
			end

			local var_24_4 = 0.666666666666667

			if 0.666666666666667 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.var_.oldValueTypewriter = arg_21_1.fswtw_.percent

				SetActive(arg_21_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_21_1:ShowNextGo(false)
			end

			local var_24_5 = 6
			local var_24_6 = 0.4
			local var_24_7, var_24_8 = arg_21_1:GetPercentByPara(arg_21_1:FormatText(arg_21_1:GetWordFromCfg(319891005).content), 1)

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				local var_24_9 = var_24_5 <= 0 and var_24_6 or var_24_6 * ((var_24_8 - arg_21_1.typewritterCharCountI18N) / var_24_5)

				if (var_24_5 <= 0 and var_24_6 or var_24_6 * ((var_24_8 - arg_21_1.typewritterCharCountI18N) / var_24_5)) > 0 and var_24_6 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end
			end

			local var_24_10 = math.max(0.4, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_10 then
				arg_21_1.fswtw_.percent = Mathf.Lerp(arg_21_1.var_.oldValueTypewriter, var_24_7, (arg_21_1.time_ - var_24_4) / var_24_10)
				arg_21_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_21_1.fswtw_:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_10 and arg_21_1.time_ < var_24_4 + var_24_10 + arg_24_0 then
				arg_21_1.fswtw_.percent = var_24_7

				arg_21_1.fswtw_:SetDirty()
				arg_21_1:ShowNextGo(true)

				arg_21_1.typewritterCharCountI18N = var_24_8
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_11 = arg_21_1.bgs_.STblack

				arg_21_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_24_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_24_12 = var_24_11:GetComponent("SpriteRenderer")

				if var_24_12 and var_24_12.sprite then
					local var_24_13 = 2 * (var_24_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_24_11.transform.localScale = Vector3.New(var_24_13 / var_24_12.sprite.bounds.size.y < var_24_13 * manager.ui.mainCameraCom_.aspect / var_24_12.sprite.bounds.size.x and var_24_13 * manager.ui.mainCameraCom_.aspect / var_24_12.sprite.bounds.size.x or var_24_13 / var_24_12.sprite.bounds.size.y, var_24_13 / var_24_12.sprite.bounds.size.y < var_24_13 * manager.ui.mainCameraCom_.aspect / var_24_12.sprite.bounds.size.x and var_24_13 * manager.ui.mainCameraCom_.aspect / var_24_12.sprite.bounds.size.x or var_24_13 / var_24_12.sprite.bounds.size.y, 0)
				end

				for iter_24_0, iter_24_1 in pairs(arg_21_1.bgs_) do
					if iter_24_0 ~= "STblack" then
						iter_24_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_24_14 = 0.666666666666667
			local var_24_15 = manager.audio:GetVoiceLength("story_v_out_319891", "319891005", "story_v_out_319891.awb") / 1000

			if var_24_15 > 0 and 1.366 < var_24_15 and var_24_15 + var_24_14 > arg_21_1.duration_ then
				arg_21_1.duration_ = var_24_15 + var_24_14
			end

			if var_24_14 < arg_21_1.time_ and arg_21_1.time_ <= var_24_14 + arg_24_0 then
				arg_21_1:AudioAction("play", "voice", "story_v_out_319891", "319891005", "story_v_out_319891.awb")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.cswbg_:SetActive(true)

				local var_24_17 = arg_21_1.cswt_:GetComponent("RectTransform")

				arg_21_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_24_17.offsetMin = Vector2.New(410, 330)
				var_24_17.offsetMax = Vector2.New(-400, -180)
				arg_21_1.cswt_.text = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(419065).content)

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
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				local var_28_0 = arg_25_1.bgs_.ST15a

				arg_25_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_28_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_28_1 = var_28_0:GetComponent("SpriteRenderer")

				if var_28_1 and var_28_1.sprite then
					local var_28_2 = 2 * (var_28_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_28_0.transform.localScale = Vector3.New(var_28_2 / var_28_1.sprite.bounds.size.y < var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x and var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x or var_28_2 / var_28_1.sprite.bounds.size.y, var_28_2 / var_28_1.sprite.bounds.size.y < var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x and var_28_2 * manager.ui.mainCameraCom_.aspect / var_28_1.sprite.bounds.size.x or var_28_2 / var_28_1.sprite.bounds.size.y, 0)
				end

				for iter_28_0, iter_28_1 in pairs(arg_25_1.bgs_) do
					if iter_28_0 ~= "ST15a" then
						iter_28_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_28_3 = "1095ui_story"

			if arg_25_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_28_4 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_25_1.stage_.transform)

				var_28_4.name = var_28_3
				var_28_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_[var_28_3] = var_28_4

				local var_28_5 = var_28_4:GetComponentInChildren(typeof(CharacterEffect))

				var_28_5.enabled = true

				local var_28_6 = GameObjectTools.GetOrAddComponent(var_28_4, typeof(DynamicBoneHelper))

				if var_28_6 then
					var_28_6:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_5.transform, false)

				arg_25_1.var_[var_28_3 .. "Animator"] = var_28_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_[var_28_3 .. "Animator"].applyRootMotion = true
				arg_25_1.var_[var_28_3 .. "LipSync"] = var_28_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_7 = arg_25_1.actors_["1095ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.characterEffect1095ui_story == nil then
				arg_25_1.var_.characterEffect1095ui_story = var_28_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_8 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_8 and not isNil(var_28_7) then
				if arg_25_1.var_.characterEffect1095ui_story and not isNil(var_28_7) then
					arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_8)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_8 and arg_25_1.time_ < 0 + var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.characterEffect1095ui_story then
				arg_25_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.fswbg_:SetActive(false)
				arg_25_1.dialog_:SetActive(false)
				SetActive(arg_25_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_25_1:ShowNextGo(false)
			end

			if 0.1 < arg_25_1.time_ and arg_25_1.time_ <= 0.1 + arg_28_0 then
				arg_25_1.fswbg_:SetActive(false)
				arg_25_1.dialog_:SetActive(false)
				SetActive(arg_25_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_25_1:ShowNextGo(false)
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.cswbg_:SetActive(false)
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_9 = 0.866666666666667
			local var_28_10 = 0.775

			if 0.866666666666667 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_11 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_11:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_12 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(319891006).content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_14 = 31 <= 0 and var_28_10 or var_28_10 * (utf8.len(var_28_12) / 31)

				if (31 <= 0 and var_28_10 or var_28_10 * (utf8.len(var_28_12) / 31)) > 0 and var_28_10 < var_28_14 then
					arg_25_1.talkMaxDuration = var_28_14
					var_28_9 = var_28_9 + 0.3

					if var_28_14 + var_28_9 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_9
					end
				end

				arg_25_1.text_.text = var_28_12
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_15 = var_28_9 + 0.3
			local var_28_16 = math.max(var_28_10, arg_25_1.talkMaxDuration)

			if var_28_9 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 then
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
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1084ui_story = arg_31_1.actors_["1084ui_story"].transform.localPosition

				arg_31_1:ShowWeapon(arg_31_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1084ui_story"].transform.position).z)
				arg_31_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1084ui_story"].transform.localEulerAngles = arg_31_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_31_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1084ui_story"].transform.position).z)
				arg_31_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1084ui_story"].transform.localEulerAngles = arg_31_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1084ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1084ui_story == nil then
				arg_31_1.var_.characterEffect1084ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1084ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1084ui_story then
				arg_31_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_34_4 = 0
			local var_34_5 = 0.65

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:GetWordFromCfg(319891007)
				local var_34_7 = arg_31_1:FormatText(var_34_6.content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 26 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 26)

				if (26 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 26)) > 0 and var_34_5 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9

					if var_34_9 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891007", "story_v_out_319891.awb") ~= 0 then
					local var_34_10 = manager.audio:GetVoiceLength("story_v_out_319891", "319891007", "story_v_out_319891.awb") / 1000

					if var_34_10 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_4
					end

					if var_34_6.prefab_name ~= "" and arg_31_1.actors_[var_34_6.prefab_name] ~= nil then
						local var_34_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_6.prefab_name].transform, "story_v_out_319891", "319891007", "story_v_out_319891.awb")

						arg_31_1:RecordAudio("319891007", var_34_11)
						arg_31_1:RecordAudio("319891007", var_34_11)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_319891", "319891007", "story_v_out_319891.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_319891", "319891007", "story_v_out_319891.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_12 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_12 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_12

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_12 and arg_31_1.time_ < var_34_4 + var_34_12 + arg_34_0 then
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
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1095ui_story = arg_35_1.actors_["1095ui_story"].transform.localPosition

				arg_35_1:ShowWeapon(arg_35_1.var_["1095ui_story" .. "Animator"].transform, false)
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1095ui_story"].transform.position).z)
				arg_35_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1095ui_story"].transform.localEulerAngles = arg_35_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_35_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1095ui_story"].transform.position).z)
				arg_35_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1095ui_story"].transform.localEulerAngles = arg_35_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1095ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1095ui_story == nil then
				arg_35_1.var_.characterEffect1095ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1095ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1095ui_story then
				arg_35_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_38_4 = arg_35_1.actors_["1084ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1084ui_story = var_38_4.localPosition

				arg_35_1:ShowWeapon(arg_35_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_38_5 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_5 then
				var_38_4.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_35_1.time_ - 0) / var_38_5)
				var_38_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_4.position).x, (manager.ui.mainCamera.transform.position - var_38_4.position).y, (manager.ui.mainCamera.transform.position - var_38_4.position).z)
				var_38_4.localEulerAngles.z = 0
				var_38_4.localEulerAngles.x = 0
				var_38_4.localEulerAngles = var_38_4.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_5 and arg_35_1.time_ < 0 + var_38_5 + arg_38_0 then
				var_38_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_38_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_4.position).x, (manager.ui.mainCamera.transform.position - var_38_4.position).y, (manager.ui.mainCamera.transform.position - var_38_4.position).z)
				var_38_4.localEulerAngles.z = 0
				var_38_4.localEulerAngles.x = 0
				var_38_4.localEulerAngles = var_38_4.localEulerAngles
			end

			local var_38_6 = arg_35_1.actors_["1084ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_6) and arg_35_1.var_.characterEffect1084ui_story == nil then
				arg_35_1.var_.characterEffect1084ui_story = var_38_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_7 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 and not isNil(var_38_6) then
				if arg_35_1.var_.characterEffect1084ui_story and not isNil(var_38_6) then
					arg_35_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_7)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 and not isNil(var_38_6) and arg_35_1.var_.characterEffect1084ui_story then
				arg_35_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_38_8 = 0
			local var_38_9 = 0.3

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_10 = arg_35_1:GetWordFromCfg(319891008)
				local var_38_11 = arg_35_1:FormatText(var_38_10.content)

				arg_35_1.text_.text = var_38_11

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_13 = 12 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 12)

				if (12 <= 0 and var_38_9 or var_38_9 * (utf8.len(var_38_11) / 12)) > 0 and var_38_9 < var_38_13 then
					arg_35_1.talkMaxDuration = var_38_13

					if var_38_13 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_13 + var_38_8
					end
				end

				arg_35_1.text_.text = var_38_11
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891008", "story_v_out_319891.awb") ~= 0 then
					local var_38_14 = manager.audio:GetVoiceLength("story_v_out_319891", "319891008", "story_v_out_319891.awb") / 1000

					if var_38_14 + var_38_8 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_14 + var_38_8
					end

					if var_38_10.prefab_name ~= "" and arg_35_1.actors_[var_38_10.prefab_name] ~= nil then
						local var_38_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_10.prefab_name].transform, "story_v_out_319891", "319891008", "story_v_out_319891.awb")

						arg_35_1:RecordAudio("319891008", var_38_15)
						arg_35_1:RecordAudio("319891008", var_38_15)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_319891", "319891008", "story_v_out_319891.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_319891", "319891008", "story_v_out_319891.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_16 = math.max(var_38_9, arg_35_1.talkMaxDuration)

			if var_38_8 <= arg_35_1.time_ and arg_35_1.time_ < var_38_8 + var_38_16 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_8) / var_38_16

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_8 + var_38_16 and arg_35_1.time_ < var_38_8 + var_38_16 + arg_38_0 then
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
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1084ui_story = arg_39_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1084ui_story"].transform.position).z)
				arg_39_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1084ui_story"].transform.localEulerAngles = arg_39_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_39_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1084ui_story"].transform.position).z)
				arg_39_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1084ui_story"].transform.localEulerAngles = arg_39_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_42_1 = arg_39_1.actors_["1084ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1084ui_story == nil then
				arg_39_1.var_.characterEffect1084ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1084ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1084ui_story then
				arg_39_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_42_4 = arg_39_1.actors_["1095ui_story"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1095ui_story = var_42_4.localPosition
			end

			local var_42_5 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_5 then
				var_42_4.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_39_1.time_ - 0) / var_42_5)
				var_42_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_4.position).x, (manager.ui.mainCamera.transform.position - var_42_4.position).y, (manager.ui.mainCamera.transform.position - var_42_4.position).z)
				var_42_4.localEulerAngles.z = 0
				var_42_4.localEulerAngles.x = 0
				var_42_4.localEulerAngles = var_42_4.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_5 and arg_39_1.time_ < 0 + var_42_5 + arg_42_0 then
				var_42_4.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_42_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_42_4.position).x, (manager.ui.mainCamera.transform.position - var_42_4.position).y, (manager.ui.mainCamera.transform.position - var_42_4.position).z)
				var_42_4.localEulerAngles.z = 0
				var_42_4.localEulerAngles.x = 0
				var_42_4.localEulerAngles = var_42_4.localEulerAngles
			end

			local var_42_6 = arg_39_1.actors_["1095ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_6) and arg_39_1.var_.characterEffect1095ui_story == nil then
				arg_39_1.var_.characterEffect1095ui_story = var_42_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_7 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 and not isNil(var_42_6) then
				if arg_39_1.var_.characterEffect1095ui_story and not isNil(var_42_6) then
					arg_39_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_7)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 and not isNil(var_42_6) and arg_39_1.var_.characterEffect1095ui_story then
				arg_39_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_42_8 = 0
			local var_42_9 = 0.1

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_10 = arg_39_1:GetWordFromCfg(319891009)
				local var_42_11 = arg_39_1:FormatText(var_42_10.content)

				arg_39_1.text_.text = var_42_11

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_13 = 4 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 4)

				if (4 <= 0 and var_42_9 or var_42_9 * (utf8.len(var_42_11) / 4)) > 0 and var_42_9 < var_42_13 then
					arg_39_1.talkMaxDuration = var_42_13

					if var_42_13 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_13 + var_42_8
					end
				end

				arg_39_1.text_.text = var_42_11
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891009", "story_v_out_319891.awb") ~= 0 then
					local var_42_14 = manager.audio:GetVoiceLength("story_v_out_319891", "319891009", "story_v_out_319891.awb") / 1000

					if var_42_14 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_14 + var_42_8
					end

					if var_42_10.prefab_name ~= "" and arg_39_1.actors_[var_42_10.prefab_name] ~= nil then
						local var_42_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_10.prefab_name].transform, "story_v_out_319891", "319891009", "story_v_out_319891.awb")

						arg_39_1:RecordAudio("319891009", var_42_15)
						arg_39_1:RecordAudio("319891009", var_42_15)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_319891", "319891009", "story_v_out_319891.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_319891", "319891009", "story_v_out_319891.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_16 = math.max(var_42_9, arg_39_1.talkMaxDuration)

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_16 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_8) / var_42_16

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_8 + var_42_16 and arg_39_1.time_ < var_42_8 + var_42_16 + arg_42_0 then
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
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1084ui_story = arg_43_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1084ui_story"].transform.position).z)
				arg_43_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1084ui_story"].transform.localEulerAngles = arg_43_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1084ui_story"].transform.position).z)
				arg_43_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1084ui_story"].transform.localEulerAngles = arg_43_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1095ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1095ui_story = var_46_1.localPosition
			end

			local var_46_2 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 then
				var_46_1.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_43_1.time_ - 0) / var_46_2)
				var_46_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_1.position).x, (manager.ui.mainCamera.transform.position - var_46_1.position).y, (manager.ui.mainCamera.transform.position - var_46_1.position).z)
				var_46_1.localEulerAngles.z = 0
				var_46_1.localEulerAngles.x = 0
				var_46_1.localEulerAngles = var_46_1.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 then
				var_46_1.localPosition = Vector3.New(0, 100, 0)
				var_46_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_1.position).x, (manager.ui.mainCamera.transform.position - var_46_1.position).y, (manager.ui.mainCamera.transform.position - var_46_1.position).z)
				var_46_1.localEulerAngles.z = 0
				var_46_1.localEulerAngles.x = 0
				var_46_1.localEulerAngles = var_46_1.localEulerAngles
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				local var_46_3 = arg_43_1.fswbg_.transform:Find("textbox/adapt/content") or arg_43_1.fswbg_.transform:Find("textbox/content")
				local var_46_4 = arg_43_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_46_5 = var_46_3:GetComponent("RectTransform")

				var_46_3:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_46_5.offsetMin = Vector2.New(0, 0)
				var_46_5.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.fswbg_:SetActive(true)
				arg_43_1.dialog_:SetActive(false)

				arg_43_1.fswtw_.percent = 0
				arg_43_1.fswt_.text = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(319891010).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.fswt_)

				arg_43_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_43_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_43_1.fswtw_:SetDirty()

				arg_43_1.typewritterCharCountI18N = 0

				SetActive(arg_43_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_43_1:ShowNextGo(false)
			end

			local var_46_6 = 0.5

			if 0.5 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1.var_.oldValueTypewriter = arg_43_1.fswtw_.percent

				SetActive(arg_43_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_43_1:ShowNextGo(false)
			end

			local var_46_7 = 22
			local var_46_8 = 1.46666666666667
			local var_46_9, var_46_10 = arg_43_1:GetPercentByPara(arg_43_1:FormatText(arg_43_1:GetWordFromCfg(319891010).content), 1)

			if var_46_6 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				local var_46_11 = var_46_7 <= 0 and var_46_8 or var_46_8 * ((var_46_10 - arg_43_1.typewritterCharCountI18N) / var_46_7)

				if (var_46_7 <= 0 and var_46_8 or var_46_8 * ((var_46_10 - arg_43_1.typewritterCharCountI18N) / var_46_7)) > 0 and var_46_8 < var_46_11 then
					arg_43_1.talkMaxDuration = var_46_11

					if var_46_11 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_11 + var_46_6
					end
				end
			end

			local var_46_12 = math.max(1.46666666666667, arg_43_1.talkMaxDuration)

			if var_46_6 <= arg_43_1.time_ and arg_43_1.time_ < var_46_6 + var_46_12 then
				arg_43_1.fswtw_.percent = Mathf.Lerp(arg_43_1.var_.oldValueTypewriter, var_46_9, (arg_43_1.time_ - var_46_6) / var_46_12)
				arg_43_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_43_1.fswtw_:SetDirty()
			end

			if arg_43_1.time_ >= var_46_6 + var_46_12 and arg_43_1.time_ < var_46_6 + var_46_12 + arg_46_0 then
				arg_43_1.fswtw_.percent = var_46_9

				arg_43_1.fswtw_:SetDirty()
				arg_43_1:ShowNextGo(true)

				arg_43_1.typewritterCharCountI18N = var_46_10
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				local var_46_13 = arg_43_1.bgs_.STblack

				arg_43_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_46_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_14 = var_46_13:GetComponent("SpriteRenderer")

				if var_46_14 and var_46_14.sprite then
					local var_46_15 = 2 * (var_46_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_46_13.transform.localScale = Vector3.New(var_46_15 / var_46_14.sprite.bounds.size.y < var_46_15 * manager.ui.mainCameraCom_.aspect / var_46_14.sprite.bounds.size.x and var_46_15 * manager.ui.mainCameraCom_.aspect / var_46_14.sprite.bounds.size.x or var_46_15 / var_46_14.sprite.bounds.size.y, var_46_15 / var_46_14.sprite.bounds.size.y < var_46_15 * manager.ui.mainCameraCom_.aspect / var_46_14.sprite.bounds.size.x and var_46_15 * manager.ui.mainCameraCom_.aspect / var_46_14.sprite.bounds.size.x or var_46_15 / var_46_14.sprite.bounds.size.y, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "STblack" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_16 = 0.5
			local var_46_17 = manager.audio:GetVoiceLength("story_v_out_319891", "319891010", "story_v_out_319891.awb") / 1000

			if var_46_17 > 0 and 3.7 < var_46_17 and var_46_17 + var_46_16 > arg_43_1.duration_ then
				arg_43_1.duration_ = var_46_17 + var_46_16
			end

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 then
				arg_43_1:AudioAction("play", "voice", "story_v_out_319891", "319891010", "story_v_out_319891.awb")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.cswbg_:SetActive(true)

				local var_46_19 = arg_43_1.cswt_:GetComponent("RectTransform")

				arg_43_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_46_19.offsetMin = Vector2.New(410, 330)
				var_46_19.offsetMax = Vector2.New(-400, -180)
				arg_43_1.cswt_.text = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(419066).content)

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
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				local var_50_0 = arg_47_1.bgs_.ST15a

				arg_47_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_50_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_1 = var_50_0:GetComponent("SpriteRenderer")

				if var_50_1 and var_50_1.sprite then
					local var_50_2 = 2 * (var_50_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_50_0.transform.localScale = Vector3.New(var_50_2 / var_50_1.sprite.bounds.size.y < var_50_2 * manager.ui.mainCameraCom_.aspect / var_50_1.sprite.bounds.size.x and var_50_2 * manager.ui.mainCameraCom_.aspect / var_50_1.sprite.bounds.size.x or var_50_2 / var_50_1.sprite.bounds.size.y, var_50_2 / var_50_1.sprite.bounds.size.y < var_50_2 * manager.ui.mainCameraCom_.aspect / var_50_1.sprite.bounds.size.x and var_50_2 * manager.ui.mainCameraCom_.aspect / var_50_1.sprite.bounds.size.x or var_50_2 / var_50_1.sprite.bounds.size.y, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "ST15a" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.fswbg_:SetActive(false)
				arg_47_1.dialog_:SetActive(false)
				SetActive(arg_47_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_47_1:ShowNextGo(false)
			end

			if 0.1 < arg_47_1.time_ and arg_47_1.time_ <= 0.1 + arg_50_0 then
				arg_47_1.fswbg_:SetActive(false)
				arg_47_1.dialog_:SetActive(false)
				SetActive(arg_47_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_47_1:ShowNextGo(false)
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.cswbg_:SetActive(false)
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_3 = 0.449999999999
			local var_50_4 = 0.55

			if 0.449999999999 < arg_47_1.time_ and arg_47_1.time_ <= var_50_3 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_5 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_5:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(319891011).content)

				arg_47_1.text_.text = var_50_6

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_8 = 22 <= 0 and var_50_4 or var_50_4 * (utf8.len(var_50_6) / 22)

				if (22 <= 0 and var_50_4 or var_50_4 * (utf8.len(var_50_6) / 22)) > 0 and var_50_4 < var_50_8 then
					arg_47_1.talkMaxDuration = var_50_8
					var_50_3 = var_50_3 + 0.3

					if var_50_8 + var_50_3 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_3
					end
				end

				arg_47_1.text_.text = var_50_6
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_9 = var_50_3 + 0.3
			local var_50_10 = math.max(var_50_4, arg_47_1.talkMaxDuration)

			if var_50_3 + 0.3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_9 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_9) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_9 + var_50_10 and arg_47_1.time_ < var_50_9 + var_50_10 + arg_50_0 then
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
			if arg_53_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_56_0 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_53_1.stage_.transform)

				var_56_0.name = "1029ui_story"
				var_56_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["1029ui_story"] = var_56_0

				local var_56_1 = var_56_0:GetComponentInChildren(typeof(CharacterEffect))

				var_56_1.enabled = true

				local var_56_2 = GameObjectTools.GetOrAddComponent(var_56_0, typeof(DynamicBoneHelper))

				if var_56_2 then
					var_56_2:EnableDynamicBone(false)
				end

				arg_53_1:ShowWeapon(var_56_1.transform, false)

				arg_53_1.var_["1029ui_story" .. "Animator"] = var_56_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_53_1.var_["1029ui_story" .. "Animator"].applyRootMotion = true
				arg_53_1.var_["1029ui_story" .. "LipSync"] = var_56_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_56_3 = arg_53_1.actors_["1029ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1029ui_story = var_56_3.localPosition

				arg_53_1:ShowWeapon(arg_53_1.var_["1029ui_story" .. "Animator"].transform, false)
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_3.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1029ui_story, Vector3.New(0.7, -1.09, -6.2), (arg_53_1.time_ - 0) / var_56_4)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_3.localPosition = Vector3.New(0.7, -1.09, -6.2)
				var_56_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_3.position).x, (manager.ui.mainCamera.transform.position - var_56_3.position).y, (manager.ui.mainCamera.transform.position - var_56_3.position).z)
				var_56_3.localEulerAngles.z = 0
				var_56_3.localEulerAngles.x = 0
				var_56_3.localEulerAngles = var_56_3.localEulerAngles
			end

			local var_56_5 = arg_53_1.actors_["1029ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect1029ui_story == nil then
				arg_53_1.var_.characterEffect1029ui_story = var_56_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_6 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_6 and not isNil(var_56_5) then
				if arg_53_1.var_.characterEffect1029ui_story and not isNil(var_56_5) then
					arg_53_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_6 and arg_53_1.time_ < 0 + var_56_6 + arg_56_0 and not isNil(var_56_5) and arg_53_1.var_.characterEffect1029ui_story then
				arg_53_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_56_8 = 0
			local var_56_9 = 0.475

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_10 = arg_53_1:GetWordFromCfg(319891012)
				local var_56_11 = arg_53_1:FormatText(var_56_10.content)

				arg_53_1.text_.text = var_56_11

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 19 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 19)

				if (19 <= 0 and var_56_9 or var_56_9 * (utf8.len(var_56_11) / 19)) > 0 and var_56_9 < var_56_13 then
					arg_53_1.talkMaxDuration = var_56_13

					if var_56_13 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_13 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_11
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891012", "story_v_out_319891.awb") ~= 0 then
					local var_56_14 = manager.audio:GetVoiceLength("story_v_out_319891", "319891012", "story_v_out_319891.awb") / 1000

					if var_56_14 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_14 + var_56_8
					end

					if var_56_10.prefab_name ~= "" and arg_53_1.actors_[var_56_10.prefab_name] ~= nil then
						local var_56_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_10.prefab_name].transform, "story_v_out_319891", "319891012", "story_v_out_319891.awb")

						arg_53_1:RecordAudio("319891012", var_56_15)
						arg_53_1:RecordAudio("319891012", var_56_15)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319891", "319891012", "story_v_out_319891.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319891", "319891012", "story_v_out_319891.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_16 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_16 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_16

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_16 and arg_53_1.time_ < var_56_8 + var_56_16 + arg_56_0 then
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
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1084ui_story = arg_57_1.actors_["1084ui_story"].transform.localPosition

				arg_57_1:ShowWeapon(arg_57_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).z)
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles = arg_57_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_57_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1084ui_story"].transform.position).z)
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1084ui_story"].transform.localEulerAngles = arg_57_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["1084ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect1084ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_60_4 = arg_57_1.actors_["1029ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1029ui_story == nil then
				arg_57_1.var_.characterEffect1029ui_story = var_60_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_5 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_5 and not isNil(var_60_4) then
				if arg_57_1.var_.characterEffect1029ui_story and not isNil(var_60_4) then
					arg_57_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_5)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_5 and arg_57_1.time_ < 0 + var_60_5 + arg_60_0 and not isNil(var_60_4) and arg_57_1.var_.characterEffect1029ui_story then
				arg_57_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_6 = 0.666666666666667
			local var_60_7 = 0.625

			if 0.666666666666667 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_8 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_8:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_9 = arg_57_1:GetWordFromCfg(319891013)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_12 = 25 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_10) / 25)

				if (25 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_10) / 25)) > 0 and var_60_7 < var_60_12 then
					arg_57_1.talkMaxDuration = var_60_12
					var_60_6 = var_60_6 + 0.3

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891013", "story_v_out_319891.awb") ~= 0 then
					local var_60_13 = manager.audio:GetVoiceLength("story_v_out_319891", "319891013", "story_v_out_319891.awb") / 1000

					if var_60_13 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_6
					end

					if var_60_9.prefab_name ~= "" and arg_57_1.actors_[var_60_9.prefab_name] ~= nil then
						local var_60_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_9.prefab_name].transform, "story_v_out_319891", "319891013", "story_v_out_319891.awb")

						arg_57_1:RecordAudio("319891013", var_60_14)
						arg_57_1:RecordAudio("319891013", var_60_14)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319891", "319891013", "story_v_out_319891.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319891", "319891013", "story_v_out_319891.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_15 = var_60_6 + 0.3
			local var_60_16 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_15 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_15) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_15 + var_60_16 and arg_57_1.time_ < var_60_15 + var_60_16 + arg_60_0 then
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
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1029ui_story"]) and arg_63_1.var_.characterEffect1029ui_story == nil then
				arg_63_1.var_.characterEffect1029ui_story = arg_63_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1029ui_story"]) then
				if arg_63_1.var_.characterEffect1029ui_story and not isNil(arg_63_1.actors_["1029ui_story"]) then
					arg_63_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1029ui_story"]) and arg_63_1.var_.characterEffect1029ui_story then
				arg_63_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_66_2 = arg_63_1.actors_["1084ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect1084ui_story == nil then
				arg_63_1.var_.characterEffect1084ui_story = var_66_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_3 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.characterEffect1084ui_story and not isNil(var_66_2) then
					arg_63_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_3)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect1084ui_story then
				arg_63_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_66_4 = 0
			local var_66_5 = 0.225

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(319891014)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 9 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 9)

				if (9 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 9)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891014", "story_v_out_319891.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_319891", "319891014", "story_v_out_319891.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_319891", "319891014", "story_v_out_319891.awb")

						arg_63_1:RecordAudio("319891014", var_66_11)
						arg_63_1:RecordAudio("319891014", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_319891", "319891014", "story_v_out_319891.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_319891", "319891014", "story_v_out_319891.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
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
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1029ui_story = arg_67_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1029ui_story"].transform.position).z)
				arg_67_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1029ui_story"].transform.localEulerAngles = arg_67_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1029ui_story"].transform.position).z)
				arg_67_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1029ui_story"].transform.localEulerAngles = arg_67_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1029ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1029ui_story == nil then
				arg_67_1.var_.characterEffect1029ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1029ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_2)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1029ui_story then
				arg_67_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_70_3 = arg_67_1.actors_["1084ui_story"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1084ui_story = var_70_3.localPosition
			end

			local var_70_4 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				var_70_3.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 0) / var_70_4)
				var_70_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_3.position).x, (manager.ui.mainCamera.transform.position - var_70_3.position).y, (manager.ui.mainCamera.transform.position - var_70_3.position).z)
				var_70_3.localEulerAngles.z = 0
				var_70_3.localEulerAngles.x = 0
				var_70_3.localEulerAngles = var_70_3.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				var_70_3.localPosition = Vector3.New(0, 100, 0)
				var_70_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_3.position).x, (manager.ui.mainCamera.transform.position - var_70_3.position).y, (manager.ui.mainCamera.transform.position - var_70_3.position).z)
				var_70_3.localEulerAngles.z = 0
				var_70_3.localEulerAngles.x = 0
				var_70_3.localEulerAngles = var_70_3.localEulerAngles
			end

			local var_70_5 = arg_67_1.actors_["1084ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect1084ui_story == nil then
				arg_67_1.var_.characterEffect1084ui_story = var_70_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_6 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_6 and not isNil(var_70_5) then
				if arg_67_1.var_.characterEffect1084ui_story and not isNil(var_70_5) then
					arg_67_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_6)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_6 and arg_67_1.time_ < 0 + var_70_6 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect1084ui_story then
				arg_67_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_70_7 = 0
			local var_70_8 = 1.175

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_7 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_9 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(319891015).content)

				arg_67_1.text_.text = var_70_9

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 47 <= 0 and var_70_8 or var_70_8 * (utf8.len(var_70_9) / 47)

				if (47 <= 0 and var_70_8 or var_70_8 * (utf8.len(var_70_9) / 47)) > 0 and var_70_8 < var_70_11 then
					arg_67_1.talkMaxDuration = var_70_11

					if var_70_11 + var_70_7 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_11 + var_70_7
					end
				end

				arg_67_1.text_.text = var_70_9
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_12 = math.max(var_70_8, arg_67_1.talkMaxDuration)

			if var_70_7 <= arg_67_1.time_ and arg_67_1.time_ < var_70_7 + var_70_12 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_7) / var_70_12

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_7 + var_70_12 and arg_67_1.time_ < var_70_7 + var_70_12 + arg_70_0 then
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
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1084ui_story = arg_71_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1084ui_story"].transform.position).z)
				arg_71_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1084ui_story"].transform.localEulerAngles = arg_71_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1084ui_story"].transform.position).z)
				arg_71_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1084ui_story"].transform.localEulerAngles = arg_71_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				local var_74_1 = arg_71_1.fswbg_.transform:Find("textbox/adapt/content") or arg_71_1.fswbg_.transform:Find("textbox/content")
				local var_74_2 = arg_71_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_74_3 = var_74_1:GetComponent("RectTransform")

				var_74_1:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_74_3.offsetMin = Vector2.New(0, 0)
				var_74_3.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.fswbg_:SetActive(true)
				arg_71_1.dialog_:SetActive(false)

				arg_71_1.fswtw_.percent = 0
				arg_71_1.fswt_.text = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(319891016).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.fswt_)

				arg_71_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_71_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_71_1.fswtw_:SetDirty()

				arg_71_1.typewritterCharCountI18N = 0

				SetActive(arg_71_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_71_1:ShowNextGo(false)
			end

			local var_74_4 = 1.3

			if 1.3 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.var_.oldValueTypewriter = arg_71_1.fswtw_.percent

				SetActive(arg_71_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_71_1:ShowNextGo(false)
			end

			local var_74_5 = 9
			local var_74_6 = 0.6
			local var_74_7, var_74_8 = arg_71_1:GetPercentByPara(arg_71_1:FormatText(arg_71_1:GetWordFromCfg(319891016).content), 1)

			if var_74_4 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				local var_74_9 = var_74_5 <= 0 and var_74_6 or var_74_6 * ((var_74_8 - arg_71_1.typewritterCharCountI18N) / var_74_5)

				if (var_74_5 <= 0 and var_74_6 or var_74_6 * ((var_74_8 - arg_71_1.typewritterCharCountI18N) / var_74_5)) > 0 and var_74_6 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end
			end

			local var_74_10 = math.max(0.6, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_10 then
				arg_71_1.fswtw_.percent = Mathf.Lerp(arg_71_1.var_.oldValueTypewriter, var_74_7, (arg_71_1.time_ - var_74_4) / var_74_10)
				arg_71_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_71_1.fswtw_:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_10 and arg_71_1.time_ < var_74_4 + var_74_10 + arg_74_0 then
				arg_71_1.fswtw_.percent = var_74_7

				arg_71_1.fswtw_:SetDirty()
				arg_71_1:ShowNextGo(true)

				arg_71_1.typewritterCharCountI18N = var_74_8
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				local var_74_11 = arg_71_1.bgs_.STblack

				arg_71_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_74_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_12 = var_74_11:GetComponent("SpriteRenderer")

				if var_74_12 and var_74_12.sprite then
					local var_74_13 = 2 * (var_74_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_74_11.transform.localScale = Vector3.New(var_74_13 / var_74_12.sprite.bounds.size.y < var_74_13 * manager.ui.mainCameraCom_.aspect / var_74_12.sprite.bounds.size.x and var_74_13 * manager.ui.mainCameraCom_.aspect / var_74_12.sprite.bounds.size.x or var_74_13 / var_74_12.sprite.bounds.size.y, var_74_13 / var_74_12.sprite.bounds.size.y < var_74_13 * manager.ui.mainCameraCom_.aspect / var_74_12.sprite.bounds.size.x and var_74_13 * manager.ui.mainCameraCom_.aspect / var_74_12.sprite.bounds.size.x or var_74_13 / var_74_12.sprite.bounds.size.y, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "STblack" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_14 = 1.3
			local var_74_15 = manager.audio:GetVoiceLength("story_v_out_319891", "319891016", "story_v_out_319891.awb") / 1000

			if var_74_15 > 0 and 2.233 < var_74_15 and var_74_15 + var_74_14 > arg_71_1.duration_ then
				arg_71_1.duration_ = var_74_15 + var_74_14
			end

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1:AudioAction("play", "voice", "story_v_out_319891", "319891016", "story_v_out_319891.awb")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.cswbg_:SetActive(true)

				local var_74_17 = arg_71_1.cswt_:GetComponent("RectTransform")

				arg_71_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_74_17.offsetMin = Vector2.New(410, 330)
				var_74_17.offsetMax = Vector2.New(-400, -180)
				arg_71_1.cswt_.text = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(419067).content)

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
			if arg_75_1.actors_["10050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10050ui_story"))) then
				local var_78_0 = Object.Instantiate(Asset.Load("Char/" .. "10050ui_story"), arg_75_1.stage_.transform)

				var_78_0.name = "10050ui_story"
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["10050ui_story"] = var_78_0

				local var_78_1 = var_78_0:GetComponentInChildren(typeof(CharacterEffect))

				var_78_1.enabled = true

				local var_78_2 = GameObjectTools.GetOrAddComponent(var_78_0, typeof(DynamicBoneHelper))

				if var_78_2 then
					var_78_2:EnableDynamicBone(false)
				end

				arg_75_1:ShowWeapon(var_78_1.transform, false)

				arg_75_1.var_["10050ui_story" .. "Animator"] = var_78_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_75_1.var_["10050ui_story" .. "Animator"].applyRootMotion = true
				arg_75_1.var_["10050ui_story" .. "LipSync"] = var_78_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_78_3 = arg_75_1.actors_["10050ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_3) and arg_75_1.var_.characterEffect10050ui_story == nil then
				arg_75_1.var_.characterEffect10050ui_story = var_78_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_4 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 and not isNil(var_78_3) then
				if arg_75_1.var_.characterEffect10050ui_story and not isNil(var_78_3) then
					arg_75_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_4)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 and not isNil(var_78_3) and arg_75_1.var_.characterEffect10050ui_story then
				arg_75_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.fswbg_:SetActive(true)
				arg_75_1.dialog_:SetActive(false)

				arg_75_1.fswtw_.percent = 0
				arg_75_1.fswt_.text = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(319891017).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.fswt_)

				arg_75_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_75_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_75_1.fswtw_:SetDirty()

				arg_75_1.typewritterCharCountI18N = 0

				SetActive(arg_75_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_75_1:ShowNextGo(false)
			end

			local var_78_5 = 0.200000002980232

			if 0.200000002980232 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.var_.oldValueTypewriter = arg_75_1.fswtw_.percent

				SetActive(arg_75_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_75_1:ShowNextGo(false)
			end

			local var_78_6 = 16
			local var_78_7 = 1.06666666666667
			local var_78_8, var_78_9 = arg_75_1:GetPercentByPara(arg_75_1:FormatText(arg_75_1:GetWordFromCfg(319891017).content), 1)

			if var_78_5 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				local var_78_10 = var_78_6 <= 0 and var_78_7 or var_78_7 * ((var_78_9 - arg_75_1.typewritterCharCountI18N) / var_78_6)

				if (var_78_6 <= 0 and var_78_7 or var_78_7 * ((var_78_9 - arg_75_1.typewritterCharCountI18N) / var_78_6)) > 0 and var_78_7 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_5
					end
				end
			end

			local var_78_11 = math.max(1.06666666666667, arg_75_1.talkMaxDuration)

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_11 then
				arg_75_1.fswtw_.percent = Mathf.Lerp(arg_75_1.var_.oldValueTypewriter, var_78_8, (arg_75_1.time_ - var_78_5) / var_78_11)
				arg_75_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_75_1.fswtw_:SetDirty()
			end

			if arg_75_1.time_ >= var_78_5 + var_78_11 and arg_75_1.time_ < var_78_5 + var_78_11 + arg_78_0 then
				arg_75_1.fswtw_.percent = var_78_8

				arg_75_1.fswtw_:SetDirty()
				arg_75_1:ShowNextGo(true)

				arg_75_1.typewritterCharCountI18N = var_78_9
			end

			local var_78_12 = 0.200000002980232
			local var_78_13 = manager.audio:GetVoiceLength("story_v_out_319891", "319891017", "story_v_out_319891.awb") / 1000

			if var_78_13 > 0 and 3.6 < var_78_13 and var_78_13 + var_78_12 > arg_75_1.duration_ then
				arg_75_1.duration_ = var_78_13 + var_78_12
			end

			if var_78_12 < arg_75_1.time_ and arg_75_1.time_ <= var_78_12 + arg_78_0 then
				arg_75_1:AudioAction("play", "voice", "story_v_out_319891", "319891017", "story_v_out_319891.awb")
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
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.fswbg_:SetActive(true)
				arg_79_1.dialog_:SetActive(false)

				arg_79_1.fswtw_.percent = 0
				arg_79_1.fswt_.text = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(319891018).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.fswt_)

				arg_79_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_79_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_79_1.fswtw_:SetDirty()

				arg_79_1.typewritterCharCountI18N = 0

				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_79_1:ShowNextGo(false)
			end

			local var_82_0 = 0.7

			if 0.7 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.var_.oldValueTypewriter = arg_79_1.fswtw_.percent

				SetActive(arg_79_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_79_1:ShowNextGo(false)
			end

			local var_82_1 = 48
			local var_82_2 = 3.2
			local var_82_3, var_82_4 = arg_79_1:GetPercentByPara(arg_79_1:FormatText(arg_79_1:GetWordFromCfg(319891018).content), 1)

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				local var_82_5 = var_82_1 <= 0 and var_82_2 or var_82_2 * ((var_82_4 - arg_79_1.typewritterCharCountI18N) / var_82_1)

				if (var_82_1 <= 0 and var_82_2 or var_82_2 * ((var_82_4 - arg_79_1.typewritterCharCountI18N) / var_82_1)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_0
					end
				end
			end

			local var_82_6 = math.max(3.2, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_6 then
				arg_79_1.fswtw_.percent = Mathf.Lerp(arg_79_1.var_.oldValueTypewriter, var_82_3, (arg_79_1.time_ - var_82_0) / var_82_6)
				arg_79_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_79_1.fswtw_:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_6 and arg_79_1.time_ < var_82_0 + var_82_6 + arg_82_0 then
				arg_79_1.fswtw_.percent = var_82_3

				arg_79_1.fswtw_:SetDirty()
				arg_79_1:ShowNextGo(true)

				arg_79_1.typewritterCharCountI18N = var_82_4
			end

			local var_82_7 = 0.7
			local var_82_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891018", "story_v_out_319891.awb") / 1000

			if var_82_8 > 0 and 13.566 < var_82_8 and var_82_8 + var_82_7 > arg_79_1.duration_ then
				arg_79_1.duration_ = var_82_8 + var_82_7
			end

			if var_82_7 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1:AudioAction("play", "voice", "story_v_out_319891", "319891018", "story_v_out_319891.awb")
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
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.fswbg_:SetActive(true)
				arg_83_1.dialog_:SetActive(false)

				arg_83_1.fswtw_.percent = 0
				arg_83_1.fswt_.text = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(319891019).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.fswt_)

				arg_83_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_83_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_83_1.fswtw_:SetDirty()

				arg_83_1.typewritterCharCountI18N = 0

				SetActive(arg_83_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_83_1:ShowNextGo(false)
			end

			local var_86_0 = 0.200000002980232

			if 0.200000002980232 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.var_.oldValueTypewriter = arg_83_1.fswtw_.percent

				SetActive(arg_83_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_83_1:ShowNextGo(false)
			end

			local var_86_1 = 31
			local var_86_2 = 2.06666666666667
			local var_86_3, var_86_4 = arg_83_1:GetPercentByPara(arg_83_1:FormatText(arg_83_1:GetWordFromCfg(319891019).content), 1)

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				local var_86_5 = var_86_1 <= 0 and var_86_2 or var_86_2 * ((var_86_4 - arg_83_1.typewritterCharCountI18N) / var_86_1)

				if (var_86_1 <= 0 and var_86_2 or var_86_2 * ((var_86_4 - arg_83_1.typewritterCharCountI18N) / var_86_1)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_0
					end
				end
			end

			local var_86_6 = math.max(2.06666666666667, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_6 then
				arg_83_1.fswtw_.percent = Mathf.Lerp(arg_83_1.var_.oldValueTypewriter, var_86_3, (arg_83_1.time_ - var_86_0) / var_86_6)
				arg_83_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_83_1.fswtw_:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_6 and arg_83_1.time_ < var_86_0 + var_86_6 + arg_86_0 then
				arg_83_1.fswtw_.percent = var_86_3

				arg_83_1.fswtw_:SetDirty()
				arg_83_1:ShowNextGo(true)

				arg_83_1.typewritterCharCountI18N = var_86_4
			end

			local var_86_7 = 0.200000002980232
			local var_86_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891019", "story_v_out_319891.awb") / 1000

			if var_86_8 > 0 and 7.266 < var_86_8 and var_86_8 + var_86_7 > arg_83_1.duration_ then
				arg_83_1.duration_ = var_86_8 + var_86_7
			end

			if var_86_7 < arg_83_1.time_ and arg_83_1.time_ <= var_86_7 + arg_86_0 then
				arg_83_1:AudioAction("play", "voice", "story_v_out_319891", "319891019", "story_v_out_319891.awb")
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
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.fswbg_:SetActive(true)
				arg_87_1.dialog_:SetActive(false)

				arg_87_1.fswtw_.percent = 0
				arg_87_1.fswt_.text = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(319891020).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.fswt_)

				arg_87_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_87_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_87_1.fswtw_:SetDirty()

				arg_87_1.typewritterCharCountI18N = 0

				SetActive(arg_87_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_87_1:ShowNextGo(false)
			end

			local var_90_0 = 0.866666666666667

			if 0.866666666666667 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.var_.oldValueTypewriter = arg_87_1.fswtw_.percent

				SetActive(arg_87_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_87_1:ShowNextGo(false)
			end

			local var_90_1 = 13
			local var_90_2 = 0.866666666666667
			local var_90_3, var_90_4 = arg_87_1:GetPercentByPara(arg_87_1:FormatText(arg_87_1:GetWordFromCfg(319891020).content), 1)

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				local var_90_5 = var_90_1 <= 0 and var_90_2 or var_90_2 * ((var_90_4 - arg_87_1.typewritterCharCountI18N) / var_90_1)

				if (var_90_1 <= 0 and var_90_2 or var_90_2 * ((var_90_4 - arg_87_1.typewritterCharCountI18N) / var_90_1)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_0
					end
				end
			end

			local var_90_6 = math.max(0.866666666666667, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_6 then
				arg_87_1.fswtw_.percent = Mathf.Lerp(arg_87_1.var_.oldValueTypewriter, var_90_3, (arg_87_1.time_ - var_90_0) / var_90_6)
				arg_87_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_87_1.fswtw_:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_6 and arg_87_1.time_ < var_90_0 + var_90_6 + arg_90_0 then
				arg_87_1.fswtw_.percent = var_90_3

				arg_87_1.fswtw_:SetDirty()
				arg_87_1:ShowNextGo(true)

				arg_87_1.typewritterCharCountI18N = var_90_4
			end

			local var_90_7 = 0.866666666666667
			local var_90_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891020", "story_v_out_319891.awb") / 1000

			if var_90_8 > 0 and 3.4 < var_90_8 and var_90_8 + var_90_7 > arg_87_1.duration_ then
				arg_87_1.duration_ = var_90_8 + var_90_7
			end

			if var_90_7 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 then
				arg_87_1:AudioAction("play", "voice", "story_v_out_319891", "319891020", "story_v_out_319891.awb")
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
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				local var_94_0 = arg_91_1.fswbg_.transform:Find("textbox/adapt/content") or arg_91_1.fswbg_.transform:Find("textbox/content")
				local var_94_1 = arg_91_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_94_2 = var_94_0:GetComponent("RectTransform")

				var_94_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_94_2.offsetMin = Vector2.New(0, 0)
				var_94_2.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.fswbg_:SetActive(true)
				arg_91_1.dialog_:SetActive(false)

				arg_91_1.fswtw_.percent = 0
				arg_91_1.fswt_.text = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(319891021).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.fswt_)

				arg_91_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_91_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_91_1.fswtw_:SetDirty()

				arg_91_1.typewritterCharCountI18N = 0

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_3 = 1

			if 1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_3 + arg_94_0 then
				arg_91_1.var_.oldValueTypewriter = arg_91_1.fswtw_.percent

				SetActive(arg_91_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_91_1:ShowNextGo(false)
			end

			local var_94_4 = 25
			local var_94_5 = 1.66666666666667
			local var_94_6, var_94_7 = arg_91_1:GetPercentByPara(arg_91_1:FormatText(arg_91_1:GetWordFromCfg(319891021).content), 1)

			if var_94_3 < arg_91_1.time_ and arg_91_1.time_ <= var_94_3 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				local var_94_8 = var_94_4 <= 0 and var_94_5 or var_94_5 * ((var_94_7 - arg_91_1.typewritterCharCountI18N) / var_94_4)

				if (var_94_4 <= 0 and var_94_5 or var_94_5 * ((var_94_7 - arg_91_1.typewritterCharCountI18N) / var_94_4)) > 0 and var_94_5 < var_94_8 then
					arg_91_1.talkMaxDuration = var_94_8

					if var_94_8 + var_94_3 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_3
					end
				end
			end

			local var_94_9 = math.max(1.66666666666667, arg_91_1.talkMaxDuration)

			if var_94_3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_3 + var_94_9 then
				arg_91_1.fswtw_.percent = Mathf.Lerp(arg_91_1.var_.oldValueTypewriter, var_94_6, (arg_91_1.time_ - var_94_3) / var_94_9)
				arg_91_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_91_1.fswtw_:SetDirty()
			end

			if arg_91_1.time_ >= var_94_3 + var_94_9 and arg_91_1.time_ < var_94_3 + var_94_9 + arg_94_0 then
				arg_91_1.fswtw_.percent = var_94_6

				arg_91_1.fswtw_:SetDirty()
				arg_91_1:ShowNextGo(true)

				arg_91_1.typewritterCharCountI18N = var_94_7
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				local var_94_10 = arg_91_1.bgs_.STblack

				arg_91_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_94_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_11 = var_94_10:GetComponent("SpriteRenderer")

				if var_94_11 and var_94_11.sprite then
					local var_94_12 = 2 * (var_94_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_94_10.transform.localScale = Vector3.New(var_94_12 / var_94_11.sprite.bounds.size.y < var_94_12 * manager.ui.mainCameraCom_.aspect / var_94_11.sprite.bounds.size.x and var_94_12 * manager.ui.mainCameraCom_.aspect / var_94_11.sprite.bounds.size.x or var_94_12 / var_94_11.sprite.bounds.size.y, var_94_12 / var_94_11.sprite.bounds.size.y < var_94_12 * manager.ui.mainCameraCom_.aspect / var_94_11.sprite.bounds.size.x and var_94_12 * manager.ui.mainCameraCom_.aspect / var_94_11.sprite.bounds.size.x or var_94_12 / var_94_11.sprite.bounds.size.y, 0)
				end

				for iter_94_0, iter_94_1 in pairs(arg_91_1.bgs_) do
					if iter_94_0 ~= "STblack" then
						iter_94_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_94_13 = 1
			local var_94_14 = manager.audio:GetVoiceLength("story_v_out_319891", "319891021", "story_v_out_319891.awb") / 1000

			if var_94_14 > 0 and 6.133 < var_94_14 and var_94_14 + var_94_13 > arg_91_1.duration_ then
				arg_91_1.duration_ = var_94_14 + var_94_13
			end

			if var_94_13 < arg_91_1.time_ and arg_91_1.time_ <= var_94_13 + arg_94_0 then
				arg_91_1:AudioAction("play", "voice", "story_v_out_319891", "319891021", "story_v_out_319891.awb")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.cswbg_:SetActive(true)

				local var_94_16 = arg_91_1.cswt_:GetComponent("RectTransform")

				arg_91_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_94_16.offsetMin = Vector2.New(0, 0)
				var_94_16.offsetMax = Vector2.New(0, 0)
				arg_91_1.cswt_.text = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(419068).content)

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
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.fswbg_:SetActive(true)
				arg_95_1.dialog_:SetActive(false)

				arg_95_1.fswtw_.percent = 0
				arg_95_1.fswt_.text = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(319891022).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.fswt_)

				arg_95_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_95_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_95_1.fswtw_:SetDirty()

				arg_95_1.typewritterCharCountI18N = 0

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_0 = 0.200000002980232

			if 0.200000002980232 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.var_.oldValueTypewriter = arg_95_1.fswtw_.percent

				SetActive(arg_95_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_95_1:ShowNextGo(false)
			end

			local var_98_1 = 5
			local var_98_2 = 0.333333333333333
			local var_98_3, var_98_4 = arg_95_1:GetPercentByPara(arg_95_1:FormatText(arg_95_1:GetWordFromCfg(319891022).content), 1)

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				local var_98_5 = var_98_1 <= 0 and var_98_2 or var_98_2 * ((var_98_4 - arg_95_1.typewritterCharCountI18N) / var_98_1)

				if (var_98_1 <= 0 and var_98_2 or var_98_2 * ((var_98_4 - arg_95_1.typewritterCharCountI18N) / var_98_1)) > 0 and var_98_2 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_0
					end
				end
			end

			local var_98_6 = math.max(0.333333333333333, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_6 then
				arg_95_1.fswtw_.percent = Mathf.Lerp(arg_95_1.var_.oldValueTypewriter, var_98_3, (arg_95_1.time_ - var_98_0) / var_98_6)
				arg_95_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_95_1.fswtw_:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_6 and arg_95_1.time_ < var_98_0 + var_98_6 + arg_98_0 then
				arg_95_1.fswtw_.percent = var_98_3

				arg_95_1.fswtw_:SetDirty()
				arg_95_1:ShowNextGo(true)

				arg_95_1.typewritterCharCountI18N = var_98_4
			end

			local var_98_7 = 0.200000002980232
			local var_98_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891022", "story_v_out_319891.awb") / 1000

			if var_98_8 > 0 and 2.533 < var_98_8 and var_98_8 + var_98_7 > arg_95_1.duration_ then
				arg_95_1.duration_ = var_98_8 + var_98_7
			end

			if var_98_7 < arg_95_1.time_ and arg_95_1.time_ <= var_98_7 + arg_98_0 then
				arg_95_1:AudioAction("play", "voice", "story_v_out_319891", "319891022", "story_v_out_319891.awb")
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
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.fswbg_:SetActive(true)
				arg_99_1.dialog_:SetActive(false)

				arg_99_1.fswtw_.percent = 0
				arg_99_1.fswt_.text = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(319891023).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.fswt_)

				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_99_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_99_1.fswtw_:SetDirty()

				arg_99_1.typewritterCharCountI18N = 0

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_0 = 0.200000002980232

			if 0.200000002980232 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.var_.oldValueTypewriter = arg_99_1.fswtw_.percent

				SetActive(arg_99_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_99_1:ShowNextGo(false)
			end

			local var_102_1 = 17
			local var_102_2 = 1.13333333333333
			local var_102_3, var_102_4 = arg_99_1:GetPercentByPara(arg_99_1:FormatText(arg_99_1:GetWordFromCfg(319891023).content), 1)

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				local var_102_5 = var_102_1 <= 0 and var_102_2 or var_102_2 * ((var_102_4 - arg_99_1.typewritterCharCountI18N) / var_102_1)

				if (var_102_1 <= 0 and var_102_2 or var_102_2 * ((var_102_4 - arg_99_1.typewritterCharCountI18N) / var_102_1)) > 0 and var_102_2 < var_102_5 then
					arg_99_1.talkMaxDuration = var_102_5

					if var_102_5 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + var_102_0
					end
				end
			end

			local var_102_6 = math.max(1.13333333333333, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_6 then
				arg_99_1.fswtw_.percent = Mathf.Lerp(arg_99_1.var_.oldValueTypewriter, var_102_3, (arg_99_1.time_ - var_102_0) / var_102_6)
				arg_99_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_99_1.fswtw_:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_6 and arg_99_1.time_ < var_102_0 + var_102_6 + arg_102_0 then
				arg_99_1.fswtw_.percent = var_102_3

				arg_99_1.fswtw_:SetDirty()
				arg_99_1:ShowNextGo(true)

				arg_99_1.typewritterCharCountI18N = var_102_4
			end

			local var_102_7 = 0.200000002980232
			local var_102_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891023", "story_v_out_319891.awb") / 1000

			if var_102_8 > 0 and 5.5 < var_102_8 and var_102_8 + var_102_7 > arg_99_1.duration_ then
				arg_99_1.duration_ = var_102_8 + var_102_7
			end

			if var_102_7 < arg_99_1.time_ and arg_99_1.time_ <= var_102_7 + arg_102_0 then
				arg_99_1:AudioAction("play", "voice", "story_v_out_319891", "319891023", "story_v_out_319891.awb")
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
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.fswbg_:SetActive(true)
				arg_103_1.dialog_:SetActive(false)

				arg_103_1.fswtw_.percent = 0
				arg_103_1.fswt_.text = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(319891024).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.fswt_)

				arg_103_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_103_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_103_1.fswtw_:SetDirty()

				arg_103_1.typewritterCharCountI18N = 0

				SetActive(arg_103_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_103_1:ShowNextGo(false)
			end

			local var_106_0 = 0.200000002980232

			if 0.200000002980232 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.var_.oldValueTypewriter = arg_103_1.fswtw_.percent

				SetActive(arg_103_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_103_1:ShowNextGo(false)
			end

			local var_106_1 = 11
			local var_106_2 = 0.733333333333333
			local var_106_3, var_106_4 = arg_103_1:GetPercentByPara(arg_103_1:FormatText(arg_103_1:GetWordFromCfg(319891024).content), 1)

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				local var_106_5 = var_106_1 <= 0 and var_106_2 or var_106_2 * ((var_106_4 - arg_103_1.typewritterCharCountI18N) / var_106_1)

				if (var_106_1 <= 0 and var_106_2 or var_106_2 * ((var_106_4 - arg_103_1.typewritterCharCountI18N) / var_106_1)) > 0 and var_106_2 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_0
					end
				end
			end

			local var_106_6 = math.max(0.733333333333333, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_6 then
				arg_103_1.fswtw_.percent = Mathf.Lerp(arg_103_1.var_.oldValueTypewriter, var_106_3, (arg_103_1.time_ - var_106_0) / var_106_6)
				arg_103_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_103_1.fswtw_:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_6 and arg_103_1.time_ < var_106_0 + var_106_6 + arg_106_0 then
				arg_103_1.fswtw_.percent = var_106_3

				arg_103_1.fswtw_:SetDirty()
				arg_103_1:ShowNextGo(true)

				arg_103_1.typewritterCharCountI18N = var_106_4
			end

			local var_106_7 = 0.200000002980232
			local var_106_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891024", "story_v_out_319891.awb") / 1000

			if var_106_8 > 0 and 2.1 < var_106_8 and var_106_8 + var_106_7 > arg_103_1.duration_ then
				arg_103_1.duration_ = var_106_8 + var_106_7
			end

			if var_106_7 < arg_103_1.time_ and arg_103_1.time_ <= var_106_7 + arg_106_0 then
				arg_103_1:AudioAction("play", "voice", "story_v_out_319891", "319891024", "story_v_out_319891.awb")
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
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				local var_110_0 = arg_107_1.fswbg_.transform:Find("textbox/adapt/content") or arg_107_1.fswbg_.transform:Find("textbox/content")
				local var_110_1 = arg_107_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_110_2 = var_110_0:GetComponent("RectTransform")

				var_110_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_110_2.offsetMin = Vector2.New(0, 0)
				var_110_2.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.fswbg_:SetActive(true)
				arg_107_1.dialog_:SetActive(false)

				arg_107_1.fswtw_.percent = 0
				arg_107_1.fswt_.text = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(319891025).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.fswt_)

				arg_107_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_107_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_107_1.fswtw_:SetDirty()

				arg_107_1.typewritterCharCountI18N = 0

				SetActive(arg_107_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_107_1:ShowNextGo(false)
			end

			local var_110_3 = 0.866666666666667

			if 0.866666666666667 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.var_.oldValueTypewriter = arg_107_1.fswtw_.percent

				SetActive(arg_107_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_107_1:ShowNextGo(false)
			end

			local var_110_4 = 16
			local var_110_5 = 1.06666666666667
			local var_110_6, var_110_7 = arg_107_1:GetPercentByPara(arg_107_1:FormatText(arg_107_1:GetWordFromCfg(319891025).content), 1)

			if var_110_3 < arg_107_1.time_ and arg_107_1.time_ <= var_110_3 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				local var_110_8 = var_110_4 <= 0 and var_110_5 or var_110_5 * ((var_110_7 - arg_107_1.typewritterCharCountI18N) / var_110_4)

				if (var_110_4 <= 0 and var_110_5 or var_110_5 * ((var_110_7 - arg_107_1.typewritterCharCountI18N) / var_110_4)) > 0 and var_110_5 < var_110_8 then
					arg_107_1.talkMaxDuration = var_110_8

					if var_110_8 + var_110_3 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_3
					end
				end
			end

			local var_110_9 = math.max(1.06666666666667, arg_107_1.talkMaxDuration)

			if var_110_3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_3 + var_110_9 then
				arg_107_1.fswtw_.percent = Mathf.Lerp(arg_107_1.var_.oldValueTypewriter, var_110_6, (arg_107_1.time_ - var_110_3) / var_110_9)
				arg_107_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_107_1.fswtw_:SetDirty()
			end

			if arg_107_1.time_ >= var_110_3 + var_110_9 and arg_107_1.time_ < var_110_3 + var_110_9 + arg_110_0 then
				arg_107_1.fswtw_.percent = var_110_6

				arg_107_1.fswtw_:SetDirty()
				arg_107_1:ShowNextGo(true)

				arg_107_1.typewritterCharCountI18N = var_110_7
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				local var_110_10 = arg_107_1.bgs_.STblack

				arg_107_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_110_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_110_11 = var_110_10:GetComponent("SpriteRenderer")

				if var_110_11 and var_110_11.sprite then
					local var_110_12 = 2 * (var_110_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_110_10.transform.localScale = Vector3.New(var_110_12 / var_110_11.sprite.bounds.size.y < var_110_12 * manager.ui.mainCameraCom_.aspect / var_110_11.sprite.bounds.size.x and var_110_12 * manager.ui.mainCameraCom_.aspect / var_110_11.sprite.bounds.size.x or var_110_12 / var_110_11.sprite.bounds.size.y, var_110_12 / var_110_11.sprite.bounds.size.y < var_110_12 * manager.ui.mainCameraCom_.aspect / var_110_11.sprite.bounds.size.x and var_110_12 * manager.ui.mainCameraCom_.aspect / var_110_11.sprite.bounds.size.x or var_110_12 / var_110_11.sprite.bounds.size.y, 0)
				end

				for iter_110_0, iter_110_1 in pairs(arg_107_1.bgs_) do
					if iter_110_0 ~= "STblack" then
						iter_110_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_110_13 = 0.866666666666667
			local var_110_14 = manager.audio:GetVoiceLength("story_v_out_319891", "319891025", "story_v_out_319891.awb") / 1000

			if var_110_14 > 0 and 4.833 < var_110_14 and var_110_14 + var_110_13 > arg_107_1.duration_ then
				arg_107_1.duration_ = var_110_14 + var_110_13
			end

			if var_110_13 < arg_107_1.time_ and arg_107_1.time_ <= var_110_13 + arg_110_0 then
				arg_107_1:AudioAction("play", "voice", "story_v_out_319891", "319891025", "story_v_out_319891.awb")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.cswbg_:SetActive(true)

				local var_110_16 = arg_107_1.cswt_:GetComponent("RectTransform")

				arg_107_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_110_16.offsetMin = Vector2.New(410, 330)
				var_110_16.offsetMax = Vector2.New(-400, -180)
				arg_107_1.cswt_.text = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(419069).content)

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
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.fswbg_:SetActive(true)
				arg_111_1.dialog_:SetActive(false)

				arg_111_1.fswtw_.percent = 0
				arg_111_1.fswt_.text = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(319891026).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.fswt_)

				arg_111_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_111_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_111_1.fswtw_:SetDirty()

				arg_111_1.typewritterCharCountI18N = 0

				SetActive(arg_111_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_111_1:ShowNextGo(false)
			end

			local var_114_0 = 0.200000002980232

			if 0.200000002980232 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.var_.oldValueTypewriter = arg_111_1.fswtw_.percent

				SetActive(arg_111_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_111_1:ShowNextGo(false)
			end

			local var_114_1 = 2
			local var_114_2 = 0.133333333333333
			local var_114_3, var_114_4 = arg_111_1:GetPercentByPara(arg_111_1:FormatText(arg_111_1:GetWordFromCfg(319891026).content), 1)

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				local var_114_5 = var_114_1 <= 0 and var_114_2 or var_114_2 * ((var_114_4 - arg_111_1.typewritterCharCountI18N) / var_114_1)

				if (var_114_1 <= 0 and var_114_2 or var_114_2 * ((var_114_4 - arg_111_1.typewritterCharCountI18N) / var_114_1)) > 0 and var_114_2 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_0
					end
				end
			end

			local var_114_6 = math.max(0.133333333333333, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_6 then
				arg_111_1.fswtw_.percent = Mathf.Lerp(arg_111_1.var_.oldValueTypewriter, var_114_3, (arg_111_1.time_ - var_114_0) / var_114_6)
				arg_111_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_111_1.fswtw_:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_6 and arg_111_1.time_ < var_114_0 + var_114_6 + arg_114_0 then
				arg_111_1.fswtw_.percent = var_114_3

				arg_111_1.fswtw_:SetDirty()
				arg_111_1:ShowNextGo(true)

				arg_111_1.typewritterCharCountI18N = var_114_4
			end

			local var_114_7 = 0.200000002980232
			local var_114_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891026", "story_v_out_319891.awb") / 1000

			if var_114_8 > 0 and 0.866 < var_114_8 and var_114_8 + var_114_7 > arg_111_1.duration_ then
				arg_111_1.duration_ = var_114_8 + var_114_7
			end

			if var_114_7 < arg_111_1.time_ and arg_111_1.time_ <= var_114_7 + arg_114_0 then
				arg_111_1:AudioAction("play", "voice", "story_v_out_319891", "319891026", "story_v_out_319891.awb")
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
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				local var_118_0 = arg_115_1.bgs_.ST15a

				arg_115_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_118_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_118_1 = var_118_0:GetComponent("SpriteRenderer")

				if var_118_1 and var_118_1.sprite then
					local var_118_2 = 2 * (var_118_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_118_0.transform.localScale = Vector3.New(var_118_2 / var_118_1.sprite.bounds.size.y < var_118_2 * manager.ui.mainCameraCom_.aspect / var_118_1.sprite.bounds.size.x and var_118_2 * manager.ui.mainCameraCom_.aspect / var_118_1.sprite.bounds.size.x or var_118_2 / var_118_1.sprite.bounds.size.y, var_118_2 / var_118_1.sprite.bounds.size.y < var_118_2 * manager.ui.mainCameraCom_.aspect / var_118_1.sprite.bounds.size.x and var_118_2 * manager.ui.mainCameraCom_.aspect / var_118_1.sprite.bounds.size.x or var_118_2 / var_118_1.sprite.bounds.size.y, 0)
				end

				for iter_118_0, iter_118_1 in pairs(arg_115_1.bgs_) do
					if iter_118_0 ~= "ST15a" then
						iter_118_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_118_3 = 0

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_3 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_4 = 2

			if var_118_3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_3 + var_118_4 then
				local var_118_5 = Color.New(0, 0, 0)

				var_118_5.a = Mathf.Lerp(1, 0, (arg_115_1.time_ - var_118_3) / var_118_4)
				arg_115_1.mask_.color = var_118_5
			end

			if arg_115_1.time_ >= var_118_3 + var_118_4 and arg_115_1.time_ < var_118_3 + var_118_4 + arg_118_0 then
				local var_118_6 = Color.New(0, 0, 0)

				arg_115_1.mask_.enabled = false
				var_118_6.a = 0
				arg_115_1.mask_.color = var_118_6
			end

			local var_118_7 = arg_115_1.actors_["1084ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_8 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_8 and not isNil(var_118_7) then
				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_7) then
					arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_8)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_8 and arg_115_1.time_ < 0 + var_118_8 + arg_118_0 and not isNil(var_118_7) and arg_115_1.var_.characterEffect1084ui_story then
				arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.fswbg_:SetActive(false)
				arg_115_1.dialog_:SetActive(false)
				SetActive(arg_115_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_115_1:ShowNextGo(false)
			end

			if 0.1 < arg_115_1.time_ and arg_115_1.time_ <= 0.1 + arg_118_0 then
				arg_115_1.fswbg_:SetActive(false)
				arg_115_1.dialog_:SetActive(false)
				SetActive(arg_115_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_115_1:ShowNextGo(false)
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.cswbg_:SetActive(false)
			end

			local var_118_9 = "4037ui_story"

			if arg_115_1.actors_["4037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4037ui_story"))) then
				local var_118_10 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_115_1.stage_.transform)

				var_118_10.name = var_118_9
				var_118_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.actors_[var_118_9] = var_118_10

				local var_118_11 = var_118_10:GetComponentInChildren(typeof(CharacterEffect))

				var_118_11.enabled = true

				local var_118_12 = GameObjectTools.GetOrAddComponent(var_118_10, typeof(DynamicBoneHelper))

				if var_118_12 then
					var_118_12:EnableDynamicBone(false)
				end

				arg_115_1:ShowWeapon(var_118_11.transform, false)

				arg_115_1.var_[var_118_9 .. "Animator"] = var_118_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_115_1.var_[var_118_9 .. "Animator"].applyRootMotion = true
				arg_115_1.var_[var_118_9 .. "LipSync"] = var_118_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_118_13 = arg_115_1.actors_["4037ui_story"].transform

			if 1.86666666666667 < arg_115_1.time_ and arg_115_1.time_ <= 1.86666666666667 + arg_118_0 then
				arg_115_1.var_.moveOldPos4037ui_story = var_118_13.localPosition
			end

			local var_118_14 = 0.001

			if 1.86666666666667 <= arg_115_1.time_ and arg_115_1.time_ < 1.86666666666667 + var_118_14 then
				var_118_13.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_115_1.time_ - 1.86666666666667) / var_118_14)
				var_118_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_13.position).x, (manager.ui.mainCamera.transform.position - var_118_13.position).y, (manager.ui.mainCamera.transform.position - var_118_13.position).z)
				var_118_13.localEulerAngles.z = 0
				var_118_13.localEulerAngles.x = 0
				var_118_13.localEulerAngles = var_118_13.localEulerAngles
			end

			if arg_115_1.time_ >= 1.86666666666667 + var_118_14 and arg_115_1.time_ < 1.86666666666667 + var_118_14 + arg_118_0 then
				var_118_13.localPosition = Vector3.New(0, -1.12, -6.2)
				var_118_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_13.position).x, (manager.ui.mainCamera.transform.position - var_118_13.position).y, (manager.ui.mainCamera.transform.position - var_118_13.position).z)
				var_118_13.localEulerAngles.z = 0
				var_118_13.localEulerAngles.x = 0
				var_118_13.localEulerAngles = var_118_13.localEulerAngles
			end

			local var_118_15 = arg_115_1.actors_["4037ui_story"]

			if 1.86666666666667 < arg_115_1.time_ and arg_115_1.time_ <= 1.86666666666667 + arg_118_0 and not isNil(var_118_15) and arg_115_1.var_.characterEffect4037ui_story == nil then
				arg_115_1.var_.characterEffect4037ui_story = var_118_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_16 = 0.200000002980232

			if 1.86666666666667 <= arg_115_1.time_ and arg_115_1.time_ < 1.86666666666667 + var_118_16 and not isNil(var_118_15) then
				if arg_115_1.var_.characterEffect4037ui_story and not isNil(var_118_15) then
					arg_115_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 1.86666666666667 + var_118_16 and arg_115_1.time_ < 1.86666666666667 + var_118_16 + arg_118_0 and not isNil(var_118_15) and arg_115_1.var_.characterEffect4037ui_story then
				arg_115_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 1.86666666666667 < arg_115_1.time_ and arg_115_1.time_ <= 1.86666666666667 + arg_118_0 then
				arg_115_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 1.86666666666667 < arg_115_1.time_ and arg_115_1.time_ <= 1.86666666666667 + arg_118_0 then
				arg_115_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_18 = 2
			local var_118_19 = 0.725

			if 2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_18 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_20 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_20:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_21 = arg_115_1:GetWordFromCfg(319891027)
				local var_118_22 = arg_115_1:FormatText(var_118_21.content)

				arg_115_1.text_.text = var_118_22

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_24 = 29 <= 0 and var_118_19 or var_118_19 * (utf8.len(var_118_22) / 29)

				if (29 <= 0 and var_118_19 or var_118_19 * (utf8.len(var_118_22) / 29)) > 0 and var_118_19 < var_118_24 then
					arg_115_1.talkMaxDuration = var_118_24
					var_118_18 = var_118_18 + 0.3

					if var_118_24 + var_118_18 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_24 + var_118_18
					end
				end

				arg_115_1.text_.text = var_118_22
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891027", "story_v_out_319891.awb") ~= 0 then
					local var_118_25 = manager.audio:GetVoiceLength("story_v_out_319891", "319891027", "story_v_out_319891.awb") / 1000

					if var_118_25 + var_118_18 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_25 + var_118_18
					end

					if var_118_21.prefab_name ~= "" and arg_115_1.actors_[var_118_21.prefab_name] ~= nil then
						local var_118_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_21.prefab_name].transform, "story_v_out_319891", "319891027", "story_v_out_319891.awb")

						arg_115_1:RecordAudio("319891027", var_118_26)
						arg_115_1:RecordAudio("319891027", var_118_26)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319891", "319891027", "story_v_out_319891.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319891", "319891027", "story_v_out_319891.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_27 = var_118_18 + 0.3
			local var_118_28 = math.max(var_118_19, arg_115_1.talkMaxDuration)

			if var_118_18 + 0.3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_27 + var_118_28 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_27) / var_118_28

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_27 + var_118_28 and arg_115_1.time_ < var_118_27 + var_118_28 + arg_118_0 then
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
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_0 = 0
			local var_124_1 = 1.1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_2 = arg_121_1:GetWordFromCfg(319891028)
				local var_124_3 = arg_121_1:FormatText(var_124_2.content)

				arg_121_1.text_.text = var_124_3

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 44 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_3) / 44)

				if (44 <= 0 and var_124_1 or var_124_1 * (utf8.len(var_124_3) / 44)) > 0 and var_124_1 < var_124_5 then
					arg_121_1.talkMaxDuration = var_124_5

					if var_124_5 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_3
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891028", "story_v_out_319891.awb") ~= 0 then
					local var_124_6 = manager.audio:GetVoiceLength("story_v_out_319891", "319891028", "story_v_out_319891.awb") / 1000

					if var_124_6 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_0
					end

					if var_124_2.prefab_name ~= "" and arg_121_1.actors_[var_124_2.prefab_name] ~= nil then
						local var_124_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_2.prefab_name].transform, "story_v_out_319891", "319891028", "story_v_out_319891.awb")

						arg_121_1:RecordAudio("319891028", var_124_7)
						arg_121_1:RecordAudio("319891028", var_124_7)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319891", "319891028", "story_v_out_319891.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319891", "319891028", "story_v_out_319891.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_8 and arg_121_1.time_ < var_124_0 + var_124_8 + arg_124_0 then
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
			local var_128_0 = 1.3

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(319891029)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 52 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 52)

				if (52 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 52)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891029", "story_v_out_319891.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_319891", "319891029", "story_v_out_319891.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_319891", "319891029", "story_v_out_319891.awb")

						arg_125_1:RecordAudio("319891029", var_128_6)
						arg_125_1:RecordAudio("319891029", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319891", "319891029", "story_v_out_319891.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319891", "319891029", "story_v_out_319891.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
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
			local var_132_0 = 0.375

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(319891030)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 15 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 15)

				if (15 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 15)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891030", "story_v_out_319891.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_319891", "319891030", "story_v_out_319891.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_319891", "319891030", "story_v_out_319891.awb")

						arg_129_1:RecordAudio("319891030", var_132_6)
						arg_129_1:RecordAudio("319891030", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_319891", "319891030", "story_v_out_319891.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_319891", "319891030", "story_v_out_319891.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
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
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:AudioAction("play", "effect", "se_story_128", "se_story_128_stab", "")
			end

			local var_136_1 = arg_133_1.actors_["4037ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos4037ui_story = var_136_1.localPosition
			end

			local var_136_2 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 then
				var_136_1.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_2)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 then
				var_136_1.localPosition = Vector3.New(0, 100, 0)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles
			end

			local var_136_3 = 0
			local var_136_4 = 0.825

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_5 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(319891031).content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 33 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 33)

				if (33 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 33)) > 0 and var_136_4 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_3
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_4, arg_133_1.talkMaxDuration)

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_3) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_3 + var_136_8 and arg_133_1.time_ < var_136_3 + var_136_8 + arg_136_0 then
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
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				local var_140_0 = arg_137_1.fswbg_.transform:Find("textbox/adapt/content") or arg_137_1.fswbg_.transform:Find("textbox/content")
				local var_140_1 = arg_137_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_140_2 = var_140_0:GetComponent("RectTransform")

				var_140_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_140_2.offsetMin = Vector2.New(0, 0)
				var_140_2.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.fswbg_:SetActive(true)
				arg_137_1.dialog_:SetActive(false)

				arg_137_1.fswtw_.percent = 0
				arg_137_1.fswt_.text = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(319891032).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.fswt_)

				arg_137_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_137_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_137_1.fswtw_:SetDirty()

				arg_137_1.typewritterCharCountI18N = 0

				SetActive(arg_137_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_137_1:ShowNextGo(false)
			end

			local var_140_3 = 1

			if 1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_3 + arg_140_0 then
				arg_137_1.var_.oldValueTypewriter = arg_137_1.fswtw_.percent

				SetActive(arg_137_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_137_1:ShowNextGo(false)
			end

			local var_140_4 = 7
			local var_140_5 = 0.466666666666667
			local var_140_6, var_140_7 = arg_137_1:GetPercentByPara(arg_137_1:FormatText(arg_137_1:GetWordFromCfg(319891032).content), 1)

			if var_140_3 < arg_137_1.time_ and arg_137_1.time_ <= var_140_3 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				local var_140_8 = var_140_4 <= 0 and var_140_5 or var_140_5 * ((var_140_7 - arg_137_1.typewritterCharCountI18N) / var_140_4)

				if (var_140_4 <= 0 and var_140_5 or var_140_5 * ((var_140_7 - arg_137_1.typewritterCharCountI18N) / var_140_4)) > 0 and var_140_5 < var_140_8 then
					arg_137_1.talkMaxDuration = var_140_8

					if var_140_8 + var_140_3 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_3
					end
				end
			end

			local var_140_9 = math.max(0.466666666666667, arg_137_1.talkMaxDuration)

			if var_140_3 <= arg_137_1.time_ and arg_137_1.time_ < var_140_3 + var_140_9 then
				arg_137_1.fswtw_.percent = Mathf.Lerp(arg_137_1.var_.oldValueTypewriter, var_140_6, (arg_137_1.time_ - var_140_3) / var_140_9)
				arg_137_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_137_1.fswtw_:SetDirty()
			end

			if arg_137_1.time_ >= var_140_3 + var_140_9 and arg_137_1.time_ < var_140_3 + var_140_9 + arg_140_0 then
				arg_137_1.fswtw_.percent = var_140_6

				arg_137_1.fswtw_:SetDirty()
				arg_137_1:ShowNextGo(true)

				arg_137_1.typewritterCharCountI18N = var_140_7
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				local var_140_10 = arg_137_1.bgs_.STblack

				arg_137_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_140_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_11 = var_140_10:GetComponent("SpriteRenderer")

				if var_140_11 and var_140_11.sprite then
					local var_140_12 = 2 * (var_140_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_140_10.transform.localScale = Vector3.New(var_140_12 / var_140_11.sprite.bounds.size.y < var_140_12 * manager.ui.mainCameraCom_.aspect / var_140_11.sprite.bounds.size.x and var_140_12 * manager.ui.mainCameraCom_.aspect / var_140_11.sprite.bounds.size.x or var_140_12 / var_140_11.sprite.bounds.size.y, var_140_12 / var_140_11.sprite.bounds.size.y < var_140_12 * manager.ui.mainCameraCom_.aspect / var_140_11.sprite.bounds.size.x and var_140_12 * manager.ui.mainCameraCom_.aspect / var_140_11.sprite.bounds.size.x or var_140_12 / var_140_11.sprite.bounds.size.y, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "STblack" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_13 = 1
			local var_140_14 = manager.audio:GetVoiceLength("story_v_out_319891", "319891032", "story_v_out_319891.awb") / 1000

			if var_140_14 > 0 and 1.966 < var_140_14 and var_140_14 + var_140_13 > arg_137_1.duration_ then
				arg_137_1.duration_ = var_140_14 + var_140_13
			end

			if var_140_13 < arg_137_1.time_ and arg_137_1.time_ <= var_140_13 + arg_140_0 then
				arg_137_1:AudioAction("play", "voice", "story_v_out_319891", "319891032", "story_v_out_319891.awb")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.cswbg_:SetActive(true)

				local var_140_16 = arg_137_1.cswt_:GetComponent("RectTransform")

				arg_137_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_140_16.offsetMin = Vector2.New(410, 330)
				var_140_16.offsetMax = Vector2.New(-400, -180)
				arg_137_1.cswt_.text = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(419070).content)

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
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1084ui_story = arg_141_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1084ui_story"].transform.position).z)
				arg_141_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1084ui_story"].transform.localEulerAngles = arg_141_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1084ui_story"].transform.position).z)
				arg_141_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1084ui_story"].transform.localEulerAngles = arg_141_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1084ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1084ui_story == nil then
				arg_141_1.var_.characterEffect1084ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1084ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_2)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1084ui_story then
				arg_141_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_144_3 = arg_141_1.actors_["4037ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos4037ui_story = var_144_3.localPosition
			end

			local var_144_4 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				var_144_3.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_4)
				var_144_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_3.position).x, (manager.ui.mainCamera.transform.position - var_144_3.position).y, (manager.ui.mainCamera.transform.position - var_144_3.position).z)
				var_144_3.localEulerAngles.z = 0
				var_144_3.localEulerAngles.x = 0
				var_144_3.localEulerAngles = var_144_3.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				var_144_3.localPosition = Vector3.New(0, 100, 0)
				var_144_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_3.position).x, (manager.ui.mainCamera.transform.position - var_144_3.position).y, (manager.ui.mainCamera.transform.position - var_144_3.position).z)
				var_144_3.localEulerAngles.z = 0
				var_144_3.localEulerAngles.x = 0
				var_144_3.localEulerAngles = var_144_3.localEulerAngles
			end

			local var_144_5 = arg_141_1.actors_["4037ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.characterEffect4037ui_story == nil then
				arg_141_1.var_.characterEffect4037ui_story = var_144_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_6 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_6 and not isNil(var_144_5) then
				if arg_141_1.var_.characterEffect4037ui_story and not isNil(var_144_5) then
					arg_141_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_141_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_6)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_6 and arg_141_1.time_ < 0 + var_144_6 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.characterEffect4037ui_story then
				arg_141_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_141_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.fswbg_:SetActive(false)
				arg_141_1.dialog_:SetActive(false)
				SetActive(arg_141_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_141_1:ShowNextGo(false)
			end

			if 0.1 < arg_141_1.time_ and arg_141_1.time_ <= 0.1 + arg_144_0 then
				arg_141_1.fswbg_:SetActive(false)
				arg_141_1.dialog_:SetActive(false)
				SetActive(arg_141_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_141_1:ShowNextGo(false)
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.cswbg_:SetActive(false)
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				local var_144_7 = arg_141_1.bgs_.ST15a

				arg_141_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_144_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_8 = var_144_7:GetComponent("SpriteRenderer")

				if var_144_8 and var_144_8.sprite then
					local var_144_9 = 2 * (var_144_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_144_7.transform.localScale = Vector3.New(var_144_9 / var_144_8.sprite.bounds.size.y < var_144_9 * manager.ui.mainCameraCom_.aspect / var_144_8.sprite.bounds.size.x and var_144_9 * manager.ui.mainCameraCom_.aspect / var_144_8.sprite.bounds.size.x or var_144_9 / var_144_8.sprite.bounds.size.y, var_144_9 / var_144_8.sprite.bounds.size.y < var_144_9 * manager.ui.mainCameraCom_.aspect / var_144_8.sprite.bounds.size.x and var_144_9 * manager.ui.mainCameraCom_.aspect / var_144_8.sprite.bounds.size.x or var_144_9 / var_144_8.sprite.bounds.size.y, 0)
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

			local var_144_10 = 0.333333333333333
			local var_144_11 = 1.2

			if 0.333333333333333 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_12 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_12:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_13 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(319891033).content)

				arg_141_1.text_.text = var_144_13

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_15 = 48 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_13) / 48)

				if (48 <= 0 and var_144_11 or var_144_11 * (utf8.len(var_144_13) / 48)) > 0 and var_144_11 < var_144_15 then
					arg_141_1.talkMaxDuration = var_144_15
					var_144_10 = var_144_10 + 0.3

					if var_144_15 + var_144_10 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_15 + var_144_10
					end
				end

				arg_141_1.text_.text = var_144_13
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = var_144_10 + 0.3
			local var_144_17 = math.max(var_144_11, arg_141_1.talkMaxDuration)

			if var_144_10 + 0.3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_17 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_16) / var_144_17

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_16 + var_144_17 and arg_141_1.time_ < var_144_16 + var_144_17 + arg_144_0 then
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
			local var_150_0 = 1.25

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(319891034).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 50 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 50)

				if (50 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 50)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
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
			local var_154_0 = 0.725

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(319891035).content)

				arg_151_1.text_.text = var_154_1

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_3 = 29 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 29)

				if (29 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_1) / 29)) > 0 and var_154_0 < var_154_3 then
					arg_151_1.talkMaxDuration = var_154_3

					if var_154_3 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_3 + 0
					end
				end

				arg_151_1.text_.text = var_154_1
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_4 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_4

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
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
			local var_158_0 = 0.15

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[724].name)

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

				local var_158_1 = arg_155_1:GetWordFromCfg(319891036)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 6 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 6)

				if (6 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 6)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891036", "story_v_out_319891.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_319891", "319891036", "story_v_out_319891.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_319891", "319891036", "story_v_out_319891.awb")

						arg_155_1:RecordAudio("319891036", var_158_6)
						arg_155_1:RecordAudio("319891036", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319891", "319891036", "story_v_out_319891.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319891", "319891036", "story_v_out_319891.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
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
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1084ui_story = arg_159_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1084ui_story"].transform.position).z)
				arg_159_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1084ui_story"].transform.localEulerAngles = arg_159_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_159_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1084ui_story"].transform.position).z)
				arg_159_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1084ui_story"].transform.localEulerAngles = arg_159_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1084ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1084ui_story == nil then
				arg_159_1.var_.characterEffect1084ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1084ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1084ui_story then
				arg_159_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_162_4 = 0
			local var_162_5 = 0.075

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:GetWordFromCfg(319891037)
				local var_162_7 = arg_159_1:FormatText(var_162_6.content)

				arg_159_1.text_.text = var_162_7

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_9 = 3 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 3)

				if (3 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_7) / 3)) > 0 and var_162_5 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_7
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891037", "story_v_out_319891.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_out_319891", "319891037", "story_v_out_319891.awb") / 1000

					if var_162_10 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_4
					end

					if var_162_6.prefab_name ~= "" and arg_159_1.actors_[var_162_6.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_6.prefab_name].transform, "story_v_out_319891", "319891037", "story_v_out_319891.awb")

						arg_159_1:RecordAudio("319891037", var_162_11)
						arg_159_1:RecordAudio("319891037", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_319891", "319891037", "story_v_out_319891.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_319891", "319891037", "story_v_out_319891.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_12 and arg_159_1.time_ < var_162_4 + var_162_12 + arg_162_0 then
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
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["1084ui_story"]) and arg_163_1.var_.characterEffect1084ui_story == nil then
				arg_163_1.var_.characterEffect1084ui_story = arg_163_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["1084ui_story"]) then
				if arg_163_1.var_.characterEffect1084ui_story and not isNil(arg_163_1.actors_["1084ui_story"]) then
					arg_163_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_0)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["1084ui_story"]) and arg_163_1.var_.characterEffect1084ui_story then
				arg_163_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_166_1 = 0
			local var_166_2 = 0.15

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[724].name)

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

				local var_166_3 = arg_163_1:GetWordFromCfg(319891038)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_6 = 6 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_4) / 6)

				if (6 <= 0 and var_166_2 or var_166_2 * (utf8.len(var_166_4) / 6)) > 0 and var_166_2 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_1
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891038", "story_v_out_319891.awb") ~= 0 then
					local var_166_7 = manager.audio:GetVoiceLength("story_v_out_319891", "319891038", "story_v_out_319891.awb") / 1000

					if var_166_7 + var_166_1 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_1
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_319891", "319891038", "story_v_out_319891.awb")

						arg_163_1:RecordAudio("319891038", var_166_8)
						arg_163_1:RecordAudio("319891038", var_166_8)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_319891", "319891038", "story_v_out_319891.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_319891", "319891038", "story_v_out_319891.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_9 = math.max(var_166_2, arg_163_1.talkMaxDuration)

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_9 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_1) / var_166_9

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_1 + var_166_9 and arg_163_1.time_ < var_166_1 + var_166_9 + arg_166_0 then
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
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1084ui_story = arg_167_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1084ui_story"].transform.position).z)
				arg_167_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1084ui_story"].transform.localEulerAngles = arg_167_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["1084ui_story"].transform.position).z)
				arg_167_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["1084ui_story"].transform.localEulerAngles = arg_167_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_170_1 = 0
			local var_170_2 = 0.925

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(319891039).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 37 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 37)

				if (37 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 37)) > 0 and var_170_2 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_6 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_6 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_6

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_6 and arg_167_1.time_ < var_170_1 + var_170_6 + arg_170_0 then
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
			local var_174_0 = 1.225

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(319891040).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 49 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 49)

				if (49 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 49)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
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
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				local var_178_0 = arg_175_1.fswbg_.transform:Find("textbox/adapt/content") or arg_175_1.fswbg_.transform:Find("textbox/content")
				local var_178_1 = arg_175_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_178_2 = var_178_0:GetComponent("RectTransform")

				var_178_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_178_2.offsetMin = Vector2.New(0, 0)
				var_178_2.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.fswbg_:SetActive(true)
				arg_175_1.dialog_:SetActive(false)

				arg_175_1.fswtw_.percent = 0
				arg_175_1.fswt_.text = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(319891041).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.fswt_)

				arg_175_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_175_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_175_1.fswtw_:SetDirty()

				arg_175_1.typewritterCharCountI18N = 0

				SetActive(arg_175_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_175_1:ShowNextGo(false)
			end

			local var_178_3 = 1.36666666666667

			if 1.36666666666667 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1.var_.oldValueTypewriter = arg_175_1.fswtw_.percent

				SetActive(arg_175_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_175_1:ShowNextGo(false)
			end

			local var_178_4 = 5
			local var_178_5 = 0.333333333333333
			local var_178_6, var_178_7 = arg_175_1:GetPercentByPara(arg_175_1:FormatText(arg_175_1:GetWordFromCfg(319891041).content), 1)

			if var_178_3 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				local var_178_8 = var_178_4 <= 0 and var_178_5 or var_178_5 * ((var_178_7 - arg_175_1.typewritterCharCountI18N) / var_178_4)

				if (var_178_4 <= 0 and var_178_5 or var_178_5 * ((var_178_7 - arg_175_1.typewritterCharCountI18N) / var_178_4)) > 0 and var_178_5 < var_178_8 then
					arg_175_1.talkMaxDuration = var_178_8

					if var_178_8 + var_178_3 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_3
					end
				end
			end

			local var_178_9 = math.max(0.333333333333333, arg_175_1.talkMaxDuration)

			if var_178_3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_3 + var_178_9 then
				arg_175_1.fswtw_.percent = Mathf.Lerp(arg_175_1.var_.oldValueTypewriter, var_178_6, (arg_175_1.time_ - var_178_3) / var_178_9)
				arg_175_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_175_1.fswtw_:SetDirty()
			end

			if arg_175_1.time_ >= var_178_3 + var_178_9 and arg_175_1.time_ < var_178_3 + var_178_9 + arg_178_0 then
				arg_175_1.fswtw_.percent = var_178_6

				arg_175_1.fswtw_:SetDirty()
				arg_175_1:ShowNextGo(true)

				arg_175_1.typewritterCharCountI18N = var_178_7
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				local var_178_10 = arg_175_1.bgs_.STblack

				arg_175_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_178_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_11 = var_178_10:GetComponent("SpriteRenderer")

				if var_178_11 and var_178_11.sprite then
					local var_178_12 = 2 * (var_178_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_178_10.transform.localScale = Vector3.New(var_178_12 / var_178_11.sprite.bounds.size.y < var_178_12 * manager.ui.mainCameraCom_.aspect / var_178_11.sprite.bounds.size.x and var_178_12 * manager.ui.mainCameraCom_.aspect / var_178_11.sprite.bounds.size.x or var_178_12 / var_178_11.sprite.bounds.size.y, var_178_12 / var_178_11.sprite.bounds.size.y < var_178_12 * manager.ui.mainCameraCom_.aspect / var_178_11.sprite.bounds.size.x and var_178_12 * manager.ui.mainCameraCom_.aspect / var_178_11.sprite.bounds.size.x or var_178_12 / var_178_11.sprite.bounds.size.y, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "STblack" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_13 = 1.36666666666667
			local var_178_14 = manager.audio:GetVoiceLength("story_v_out_319891", "319891041", "story_v_out_319891.awb") / 1000

			if var_178_14 > 0 and 1.633 < var_178_14 and var_178_14 + var_178_13 > arg_175_1.duration_ then
				arg_175_1.duration_ = var_178_14 + var_178_13
			end

			if var_178_13 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1:AudioAction("play", "voice", "story_v_out_319891", "319891041", "story_v_out_319891.awb")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.cswbg_:SetActive(true)

				local var_178_16 = arg_175_1.cswt_:GetComponent("RectTransform")

				arg_175_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_178_16.offsetMin = Vector2.New(410, 330)
				var_178_16.offsetMax = Vector2.New(-400, -175)
				arg_175_1.cswt_.text = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(419071).content)

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
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.fswbg_:SetActive(false)
				arg_179_1.dialog_:SetActive(false)
				SetActive(arg_179_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_179_1:ShowNextGo(false)
			end

			if 0.1 < arg_179_1.time_ and arg_179_1.time_ <= 0.1 + arg_182_0 then
				arg_179_1.fswbg_:SetActive(false)
				arg_179_1.dialog_:SetActive(false)
				SetActive(arg_179_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_179_1:ShowNextGo(false)
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.cswbg_:SetActive(false)
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				local var_182_0 = arg_179_1.bgs_.ST15a

				arg_179_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_182_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_182_1 = var_182_0:GetComponent("SpriteRenderer")

				if var_182_1 and var_182_1.sprite then
					local var_182_2 = 2 * (var_182_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_182_0.transform.localScale = Vector3.New(var_182_2 / var_182_1.sprite.bounds.size.y < var_182_2 * manager.ui.mainCameraCom_.aspect / var_182_1.sprite.bounds.size.x and var_182_2 * manager.ui.mainCameraCom_.aspect / var_182_1.sprite.bounds.size.x or var_182_2 / var_182_1.sprite.bounds.size.y, var_182_2 / var_182_1.sprite.bounds.size.y < var_182_2 * manager.ui.mainCameraCom_.aspect / var_182_1.sprite.bounds.size.x and var_182_2 * manager.ui.mainCameraCom_.aspect / var_182_1.sprite.bounds.size.x or var_182_2 / var_182_1.sprite.bounds.size.y, 0)
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

			local var_182_3 = 0.333333333333333
			local var_182_4 = 1.075

			if 0.333333333333333 < arg_179_1.time_ and arg_179_1.time_ <= var_182_3 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_5 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_5:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_6 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(319891042).content)

				arg_179_1.text_.text = var_182_6

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_8 = 43 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_6) / 43)

				if (43 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_6) / 43)) > 0 and var_182_4 < var_182_8 then
					arg_179_1.talkMaxDuration = var_182_8
					var_182_3 = var_182_3 + 0.3

					if var_182_8 + var_182_3 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_3
					end
				end

				arg_179_1.text_.text = var_182_6
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_9 = var_182_3 + 0.3
			local var_182_10 = math.max(var_182_4, arg_179_1.talkMaxDuration)

			if var_182_3 + 0.3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_9 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_9) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_9 + var_182_10 and arg_179_1.time_ < var_182_9 + var_182_10 + arg_182_0 then
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
			local var_188_0 = 0.85

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(319891043).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 34 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 34)

				if (34 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 34)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
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
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				local var_192_0 = arg_189_1.var_.effect191

				if not arg_189_1.var_.effect191 then
					var_192_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_192_0.name = "191"
					arg_189_1.var_.effect191 = var_192_0
				else
					var_192_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_192_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_192_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.13333333333333 < arg_189_1.time_ and arg_189_1.time_ <= 1.13333333333333 + arg_192_0 then
				if arg_189_1.var_.effect191 then
					Object.Destroy(arg_189_1.var_.effect191)

					arg_189_1.var_.effect191 = nil
				end
			end

			local var_192_3 = 0.666666666666667
			local var_192_4 = 1.675

			if 0.666666666666667 < arg_189_1.time_ and arg_189_1.time_ <= var_192_3 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_5 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(319891044).content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 67 <= 0 and var_192_4 or var_192_4 * (utf8.len(var_192_5) / 67)

				if (67 <= 0 and var_192_4 or var_192_4 * (utf8.len(var_192_5) / 67)) > 0 and var_192_4 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_3 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_3
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_4, arg_189_1.talkMaxDuration)

			if var_192_3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_3 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_3) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_3 + var_192_8 and arg_189_1.time_ < var_192_3 + var_192_8 + arg_192_0 then
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
			local var_196_0 = 0.95

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(319891045).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 38 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 38)

				if (38 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 38)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
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
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				local var_200_0 = arg_197_1.fswbg_.transform:Find("textbox/adapt/content") or arg_197_1.fswbg_.transform:Find("textbox/content")
				local var_200_1 = arg_197_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_200_2 = var_200_0:GetComponent("RectTransform")

				var_200_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_200_2.offsetMin = Vector2.New(0, 0)
				var_200_2.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.fswbg_:SetActive(true)
				arg_197_1.dialog_:SetActive(false)

				arg_197_1.fswtw_.percent = 0
				arg_197_1.fswt_.text = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(319891046).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.fswt_)

				arg_197_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_197_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_197_1.fswtw_:SetDirty()

				arg_197_1.typewritterCharCountI18N = 0

				SetActive(arg_197_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_197_1:ShowNextGo(false)
			end

			local var_200_3 = 0.666666666666667

			if 0.666666666666667 < arg_197_1.time_ and arg_197_1.time_ <= var_200_3 + arg_200_0 then
				arg_197_1.var_.oldValueTypewriter = arg_197_1.fswtw_.percent

				SetActive(arg_197_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_197_1:ShowNextGo(false)
			end

			local var_200_4 = 22
			local var_200_5 = 1.46666666666667
			local var_200_6, var_200_7 = arg_197_1:GetPercentByPara(arg_197_1:FormatText(arg_197_1:GetWordFromCfg(319891046).content), 1)

			if var_200_3 < arg_197_1.time_ and arg_197_1.time_ <= var_200_3 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				local var_200_8 = var_200_4 <= 0 and var_200_5 or var_200_5 * ((var_200_7 - arg_197_1.typewritterCharCountI18N) / var_200_4)

				if (var_200_4 <= 0 and var_200_5 or var_200_5 * ((var_200_7 - arg_197_1.typewritterCharCountI18N) / var_200_4)) > 0 and var_200_5 < var_200_8 then
					arg_197_1.talkMaxDuration = var_200_8

					if var_200_8 + var_200_3 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_3
					end
				end
			end

			local var_200_9 = math.max(1.46666666666667, arg_197_1.talkMaxDuration)

			if var_200_3 <= arg_197_1.time_ and arg_197_1.time_ < var_200_3 + var_200_9 then
				arg_197_1.fswtw_.percent = Mathf.Lerp(arg_197_1.var_.oldValueTypewriter, var_200_6, (arg_197_1.time_ - var_200_3) / var_200_9)
				arg_197_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_197_1.fswtw_:SetDirty()
			end

			if arg_197_1.time_ >= var_200_3 + var_200_9 and arg_197_1.time_ < var_200_3 + var_200_9 + arg_200_0 then
				arg_197_1.fswtw_.percent = var_200_6

				arg_197_1.fswtw_:SetDirty()
				arg_197_1:ShowNextGo(true)

				arg_197_1.typewritterCharCountI18N = var_200_7
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				local var_200_10 = arg_197_1.bgs_.STblack

				arg_197_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_200_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_11 = var_200_10:GetComponent("SpriteRenderer")

				if var_200_11 and var_200_11.sprite then
					local var_200_12 = 2 * (var_200_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_200_10.transform.localScale = Vector3.New(var_200_12 / var_200_11.sprite.bounds.size.y < var_200_12 * manager.ui.mainCameraCom_.aspect / var_200_11.sprite.bounds.size.x and var_200_12 * manager.ui.mainCameraCom_.aspect / var_200_11.sprite.bounds.size.x or var_200_12 / var_200_11.sprite.bounds.size.y, var_200_12 / var_200_11.sprite.bounds.size.y < var_200_12 * manager.ui.mainCameraCom_.aspect / var_200_11.sprite.bounds.size.x and var_200_12 * manager.ui.mainCameraCom_.aspect / var_200_11.sprite.bounds.size.x or var_200_12 / var_200_11.sprite.bounds.size.y, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "STblack" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				if arg_197_1.var_.effect191 then
					Object.Destroy(arg_197_1.var_.effect191)

					arg_197_1.var_.effect191 = nil
				end
			end

			local var_200_14 = 0.666666666666667
			local var_200_15 = manager.audio:GetVoiceLength("story_v_out_319891", "319891046", "story_v_out_319891.awb") / 1000

			if var_200_15 > 0 and 4.633 < var_200_15 and var_200_15 + var_200_14 > arg_197_1.duration_ then
				arg_197_1.duration_ = var_200_15 + var_200_14
			end

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 then
				arg_197_1:AudioAction("play", "voice", "story_v_out_319891", "319891046", "story_v_out_319891.awb")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.cswbg_:SetActive(true)

				local var_200_17 = arg_197_1.cswt_:GetComponent("RectTransform")

				arg_197_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_200_17.offsetMin = Vector2.New(410, 330)
				var_200_17.offsetMax = Vector2.New(-400, -180)
				arg_197_1.cswt_.text = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(419072).content)

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
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.fswbg_:SetActive(true)
				arg_201_1.dialog_:SetActive(false)

				arg_201_1.fswtw_.percent = 0
				arg_201_1.fswt_.text = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(319891047).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.fswt_)

				arg_201_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_201_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_201_1.fswtw_:SetDirty()

				arg_201_1.typewritterCharCountI18N = 0

				SetActive(arg_201_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_201_1:ShowNextGo(false)
			end

			local var_204_0 = 0.333333333333333

			if 0.333333333333333 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.var_.oldValueTypewriter = arg_201_1.fswtw_.percent

				SetActive(arg_201_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_201_1:ShowNextGo(false)
			end

			local var_204_1 = 23
			local var_204_2 = 1.53333333333333
			local var_204_3, var_204_4 = arg_201_1:GetPercentByPara(arg_201_1:FormatText(arg_201_1:GetWordFromCfg(319891047).content), 1)

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				local var_204_5 = var_204_1 <= 0 and var_204_2 or var_204_2 * ((var_204_4 - arg_201_1.typewritterCharCountI18N) / var_204_1)

				if (var_204_1 <= 0 and var_204_2 or var_204_2 * ((var_204_4 - arg_201_1.typewritterCharCountI18N) / var_204_1)) > 0 and var_204_2 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_0
					end
				end
			end

			local var_204_6 = math.max(1.53333333333333, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_6 then
				arg_201_1.fswtw_.percent = Mathf.Lerp(arg_201_1.var_.oldValueTypewriter, var_204_3, (arg_201_1.time_ - var_204_0) / var_204_6)
				arg_201_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_201_1.fswtw_:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_6 and arg_201_1.time_ < var_204_0 + var_204_6 + arg_204_0 then
				arg_201_1.fswtw_.percent = var_204_3

				arg_201_1.fswtw_:SetDirty()
				arg_201_1:ShowNextGo(true)

				arg_201_1.typewritterCharCountI18N = var_204_4
			end

			local var_204_7 = 0.333333333333333
			local var_204_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891047", "story_v_out_319891.awb") / 1000

			if var_204_8 > 0 and 5.366 < var_204_8 and var_204_8 + var_204_7 > arg_201_1.duration_ then
				arg_201_1.duration_ = var_204_8 + var_204_7
			end

			if var_204_7 < arg_201_1.time_ and arg_201_1.time_ <= var_204_7 + arg_204_0 then
				arg_201_1:AudioAction("play", "voice", "story_v_out_319891", "319891047", "story_v_out_319891.awb")
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
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.fswbg_:SetActive(true)
				arg_205_1.dialog_:SetActive(false)

				arg_205_1.fswtw_.percent = 0
				arg_205_1.fswt_.text = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(319891048).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.fswt_)

				arg_205_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_205_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_205_1.fswtw_:SetDirty()

				arg_205_1.typewritterCharCountI18N = 0

				SetActive(arg_205_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_205_1:ShowNextGo(false)
			end

			local var_208_0 = 0.566666666666667

			if 0.566666666666667 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.var_.oldValueTypewriter = arg_205_1.fswtw_.percent

				SetActive(arg_205_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_205_1:ShowNextGo(false)
			end

			local var_208_1 = 13
			local var_208_2 = 0.866666666666667
			local var_208_3, var_208_4 = arg_205_1:GetPercentByPara(arg_205_1:FormatText(arg_205_1:GetWordFromCfg(319891048).content), 1)

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				local var_208_5 = var_208_1 <= 0 and var_208_2 or var_208_2 * ((var_208_4 - arg_205_1.typewritterCharCountI18N) / var_208_1)

				if (var_208_1 <= 0 and var_208_2 or var_208_2 * ((var_208_4 - arg_205_1.typewritterCharCountI18N) / var_208_1)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_0
					end
				end
			end

			local var_208_6 = math.max(0.866666666666667, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_6 then
				arg_205_1.fswtw_.percent = Mathf.Lerp(arg_205_1.var_.oldValueTypewriter, var_208_3, (arg_205_1.time_ - var_208_0) / var_208_6)
				arg_205_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_205_1.fswtw_:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_6 and arg_205_1.time_ < var_208_0 + var_208_6 + arg_208_0 then
				arg_205_1.fswtw_.percent = var_208_3

				arg_205_1.fswtw_:SetDirty()
				arg_205_1:ShowNextGo(true)

				arg_205_1.typewritterCharCountI18N = var_208_4
			end

			local var_208_7 = 0.566666666666667
			local var_208_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891048", "story_v_out_319891.awb") / 1000

			if var_208_8 > 0 and 3.3 < var_208_8 and var_208_8 + var_208_7 > arg_205_1.duration_ then
				arg_205_1.duration_ = var_208_8 + var_208_7
			end

			if var_208_7 < arg_205_1.time_ and arg_205_1.time_ <= var_208_7 + arg_208_0 then
				arg_205_1:AudioAction("play", "voice", "story_v_out_319891", "319891048", "story_v_out_319891.awb")
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
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.fswbg_:SetActive(true)
				arg_209_1.dialog_:SetActive(false)

				arg_209_1.fswtw_.percent = 0
				arg_209_1.fswt_.text = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(319891049).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.fswt_)

				arg_209_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_209_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_209_1.fswtw_:SetDirty()

				arg_209_1.typewritterCharCountI18N = 0

				SetActive(arg_209_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_209_1:ShowNextGo(false)
			end

			local var_212_0 = 0.766666666666667

			if 0.766666666666667 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.var_.oldValueTypewriter = arg_209_1.fswtw_.percent

				SetActive(arg_209_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_209_1:ShowNextGo(false)
			end

			local var_212_1 = 14
			local var_212_2 = 0.933333333333333
			local var_212_3, var_212_4 = arg_209_1:GetPercentByPara(arg_209_1:FormatText(arg_209_1:GetWordFromCfg(319891049).content), 1)

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				local var_212_5 = var_212_1 <= 0 and var_212_2 or var_212_2 * ((var_212_4 - arg_209_1.typewritterCharCountI18N) / var_212_1)

				if (var_212_1 <= 0 and var_212_2 or var_212_2 * ((var_212_4 - arg_209_1.typewritterCharCountI18N) / var_212_1)) > 0 and var_212_2 < var_212_5 then
					arg_209_1.talkMaxDuration = var_212_5

					if var_212_5 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + var_212_0
					end
				end
			end

			local var_212_6 = math.max(0.933333333333333, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_6 then
				arg_209_1.fswtw_.percent = Mathf.Lerp(arg_209_1.var_.oldValueTypewriter, var_212_3, (arg_209_1.time_ - var_212_0) / var_212_6)
				arg_209_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_209_1.fswtw_:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_6 and arg_209_1.time_ < var_212_0 + var_212_6 + arg_212_0 then
				arg_209_1.fswtw_.percent = var_212_3

				arg_209_1.fswtw_:SetDirty()
				arg_209_1:ShowNextGo(true)

				arg_209_1.typewritterCharCountI18N = var_212_4
			end

			local var_212_7 = 0.766666666666667
			local var_212_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891049", "story_v_out_319891.awb") / 1000

			if var_212_8 > 0 and 3.966 < var_212_8 and var_212_8 + var_212_7 > arg_209_1.duration_ then
				arg_209_1.duration_ = var_212_8 + var_212_7
			end

			if var_212_7 < arg_209_1.time_ and arg_209_1.time_ <= var_212_7 + arg_212_0 then
				arg_209_1:AudioAction("play", "voice", "story_v_out_319891", "319891049", "story_v_out_319891.awb")
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
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:AudioAction("play", "effect", "se_story_130", "se_story_130_police", "")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				local var_216_1 = arg_213_1.fswbg_.transform:Find("textbox/adapt/content") or arg_213_1.fswbg_.transform:Find("textbox/content")
				local var_216_2 = arg_213_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_216_3 = var_216_1:GetComponent("RectTransform")

				var_216_1:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_216_3.offsetMin = Vector2.New(0, 0)
				var_216_3.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.fswbg_:SetActive(true)
				arg_213_1.dialog_:SetActive(false)

				arg_213_1.fswtw_.percent = 0
				arg_213_1.fswt_.text = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(319891050).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.fswt_)

				arg_213_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_213_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_213_1.fswtw_:SetDirty()

				arg_213_1.typewritterCharCountI18N = 0

				SetActive(arg_213_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_213_1:ShowNextGo(false)
			end

			local var_216_4 = 1.16666666666667

			if 1.16666666666667 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.var_.oldValueTypewriter = arg_213_1.fswtw_.percent

				SetActive(arg_213_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_213_1:ShowNextGo(false)
			end

			local var_216_5 = 50
			local var_216_6 = 3.33333333333333
			local var_216_7, var_216_8 = arg_213_1:GetPercentByPara(arg_213_1:FormatText(arg_213_1:GetWordFromCfg(319891050).content), 1)

			if var_216_4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				local var_216_9 = var_216_5 <= 0 and var_216_6 or var_216_6 * ((var_216_8 - arg_213_1.typewritterCharCountI18N) / var_216_5)

				if (var_216_5 <= 0 and var_216_6 or var_216_6 * ((var_216_8 - arg_213_1.typewritterCharCountI18N) / var_216_5)) > 0 and var_216_6 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end
			end

			local var_216_10 = math.max(3.33333333333333, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_10 then
				arg_213_1.fswtw_.percent = Mathf.Lerp(arg_213_1.var_.oldValueTypewriter, var_216_7, (arg_213_1.time_ - var_216_4) / var_216_10)
				arg_213_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_213_1.fswtw_:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_10 and arg_213_1.time_ < var_216_4 + var_216_10 + arg_216_0 then
				arg_213_1.fswtw_.percent = var_216_7

				arg_213_1.fswtw_:SetDirty()
				arg_213_1:ShowNextGo(true)

				arg_213_1.typewritterCharCountI18N = var_216_8
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				local var_216_11 = arg_213_1.bgs_.STblack

				arg_213_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_216_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_216_12 = var_216_11:GetComponent("SpriteRenderer")

				if var_216_12 and var_216_12.sprite then
					local var_216_13 = 2 * (var_216_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_216_11.transform.localScale = Vector3.New(var_216_13 / var_216_12.sprite.bounds.size.y < var_216_13 * manager.ui.mainCameraCom_.aspect / var_216_12.sprite.bounds.size.x and var_216_13 * manager.ui.mainCameraCom_.aspect / var_216_12.sprite.bounds.size.x or var_216_13 / var_216_12.sprite.bounds.size.y, var_216_13 / var_216_12.sprite.bounds.size.y < var_216_13 * manager.ui.mainCameraCom_.aspect / var_216_12.sprite.bounds.size.x and var_216_13 * manager.ui.mainCameraCom_.aspect / var_216_12.sprite.bounds.size.x or var_216_13 / var_216_12.sprite.bounds.size.y, 0)
				end

				for iter_216_0, iter_216_1 in pairs(arg_213_1.bgs_) do
					if iter_216_0 ~= "STblack" then
						iter_216_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.cswbg_:SetActive(true)

				local var_216_14 = arg_213_1.cswt_:GetComponent("RectTransform")

				arg_213_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_216_14.offsetMin = Vector2.New(410, 330)
				var_216_14.offsetMax = Vector2.New(-400, -175)
				arg_213_1.cswt_.text = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(419073).content)

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
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.fswbg_:SetActive(true)
				arg_217_1.dialog_:SetActive(false)

				arg_217_1.fswtw_.percent = 0
				arg_217_1.fswt_.text = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(319891051).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.fswt_)

				arg_217_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_217_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_217_1.fswtw_:SetDirty()

				arg_217_1.typewritterCharCountI18N = 0

				SetActive(arg_217_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_217_1:ShowNextGo(false)
			end

			local var_220_0 = 0.366666666666667

			if 0.366666666666667 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.var_.oldValueTypewriter = arg_217_1.fswtw_.percent

				SetActive(arg_217_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_217_1:ShowNextGo(false)
			end

			local var_220_1 = 50
			local var_220_2 = 3.33333333333333
			local var_220_3, var_220_4 = arg_217_1:GetPercentByPara(arg_217_1:FormatText(arg_217_1:GetWordFromCfg(319891051).content), 1)

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				local var_220_5 = var_220_1 <= 0 and var_220_2 or var_220_2 * ((var_220_4 - arg_217_1.typewritterCharCountI18N) / var_220_1)

				if (var_220_1 <= 0 and var_220_2 or var_220_2 * ((var_220_4 - arg_217_1.typewritterCharCountI18N) / var_220_1)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_0
					end
				end
			end

			local var_220_6 = math.max(3.33333333333333, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_6 then
				arg_217_1.fswtw_.percent = Mathf.Lerp(arg_217_1.var_.oldValueTypewriter, var_220_3, (arg_217_1.time_ - var_220_0) / var_220_6)
				arg_217_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_217_1.fswtw_:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_6 and arg_217_1.time_ < var_220_0 + var_220_6 + arg_220_0 then
				arg_217_1.fswtw_.percent = var_220_3

				arg_217_1.fswtw_:SetDirty()
				arg_217_1:ShowNextGo(true)

				arg_217_1.typewritterCharCountI18N = var_220_4
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
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				local var_224_0 = arg_221_1.bgs_.ST15a

				arg_221_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_224_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_224_1 = var_224_0:GetComponent("SpriteRenderer")

				if var_224_1 and var_224_1.sprite then
					local var_224_2 = 2 * (var_224_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_224_0.transform.localScale = Vector3.New(var_224_2 / var_224_1.sprite.bounds.size.y < var_224_2 * manager.ui.mainCameraCom_.aspect / var_224_1.sprite.bounds.size.x and var_224_2 * manager.ui.mainCameraCom_.aspect / var_224_1.sprite.bounds.size.x or var_224_2 / var_224_1.sprite.bounds.size.y, var_224_2 / var_224_1.sprite.bounds.size.y < var_224_2 * manager.ui.mainCameraCom_.aspect / var_224_1.sprite.bounds.size.x and var_224_2 * manager.ui.mainCameraCom_.aspect / var_224_1.sprite.bounds.size.x or var_224_2 / var_224_1.sprite.bounds.size.y, 0)
				end

				for iter_224_0, iter_224_1 in pairs(arg_221_1.bgs_) do
					if iter_224_0 ~= "ST15a" then
						iter_224_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_224_3 = 0

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 then
				arg_221_1.allBtn_.enabled = false
			end

			if arg_221_1.time_ >= var_224_3 + 0.3 and arg_221_1.time_ < var_224_3 + 0.3 + arg_224_0 then
				arg_221_1.allBtn_.enabled = true
			end

			local var_224_4 = 0

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_5 = 1.33333333333333

			if var_224_4 <= arg_221_1.time_ and arg_221_1.time_ < var_224_4 + var_224_5 then
				local var_224_6 = Color.New(0, 0, 0)

				var_224_6.a = Mathf.Lerp(1, 0, (arg_221_1.time_ - var_224_4) / var_224_5)
				arg_221_1.mask_.color = var_224_6
			end

			if arg_221_1.time_ >= var_224_4 + var_224_5 and arg_221_1.time_ < var_224_4 + var_224_5 + arg_224_0 then
				local var_224_7 = Color.New(0, 0, 0)

				arg_221_1.mask_.enabled = false
				var_224_7.a = 0
				arg_221_1.mask_.color = var_224_7
			end

			local var_224_8 = arg_221_1.actors_["1084ui_story"].transform

			if 1.33333333333333 < arg_221_1.time_ and arg_221_1.time_ <= 1.33333333333333 + arg_224_0 then
				arg_221_1.var_.moveOldPos1084ui_story = var_224_8.localPosition
			end

			local var_224_9 = 0.001

			if 1.33333333333333 <= arg_221_1.time_ and arg_221_1.time_ < 1.33333333333333 + var_224_9 then
				var_224_8.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_221_1.time_ - 1.33333333333333) / var_224_9)
				var_224_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_8.position).x, (manager.ui.mainCamera.transform.position - var_224_8.position).y, (manager.ui.mainCamera.transform.position - var_224_8.position).z)
				var_224_8.localEulerAngles.z = 0
				var_224_8.localEulerAngles.x = 0
				var_224_8.localEulerAngles = var_224_8.localEulerAngles
			end

			if arg_221_1.time_ >= 1.33333333333333 + var_224_9 and arg_221_1.time_ < 1.33333333333333 + var_224_9 + arg_224_0 then
				var_224_8.localPosition = Vector3.New(0, -0.97, -6)
				var_224_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_224_8.position).x, (manager.ui.mainCamera.transform.position - var_224_8.position).y, (manager.ui.mainCamera.transform.position - var_224_8.position).z)
				var_224_8.localEulerAngles.z = 0
				var_224_8.localEulerAngles.x = 0
				var_224_8.localEulerAngles = var_224_8.localEulerAngles
			end

			local var_224_10 = arg_221_1.actors_["1084ui_story"]

			if 1.33333333333333 < arg_221_1.time_ and arg_221_1.time_ <= 1.33333333333333 + arg_224_0 and not isNil(var_224_10) and arg_221_1.var_.characterEffect1084ui_story == nil then
				arg_221_1.var_.characterEffect1084ui_story = var_224_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.200000002980232

			if 1.33333333333333 <= arg_221_1.time_ and arg_221_1.time_ < 1.33333333333333 + var_224_11 and not isNil(var_224_10) then
				if arg_221_1.var_.characterEffect1084ui_story and not isNil(var_224_10) then
					arg_221_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 1.33333333333333 + var_224_11 and arg_221_1.time_ < 1.33333333333333 + var_224_11 + arg_224_0 and not isNil(var_224_10) and arg_221_1.var_.characterEffect1084ui_story then
				arg_221_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1.33333333333333 < arg_221_1.time_ and arg_221_1.time_ <= 1.33333333333333 + arg_224_0 then
				arg_221_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 1.33333333333333 < arg_221_1.time_ and arg_221_1.time_ <= 1.33333333333333 + arg_224_0 then
				arg_221_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.fswbg_:SetActive(false)
				arg_221_1.dialog_:SetActive(false)
				SetActive(arg_221_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_221_1:ShowNextGo(false)
			end

			if 0.1 < arg_221_1.time_ and arg_221_1.time_ <= 0.1 + arg_224_0 then
				arg_221_1.fswbg_:SetActive(false)
				arg_221_1.dialog_:SetActive(false)
				SetActive(arg_221_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_221_1:ShowNextGo(false)
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.cswbg_:SetActive(false)
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_13 = 1.40833333631357
			local var_224_14 = 0.125

			if 1.40833333631357 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_15 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_15:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_16 = arg_221_1:GetWordFromCfg(319891052)
				local var_224_17 = arg_221_1:FormatText(var_224_16.content)

				arg_221_1.text_.text = var_224_17

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_19 = 5 <= 0 and var_224_14 or var_224_14 * (utf8.len(var_224_17) / 5)

				if (5 <= 0 and var_224_14 or var_224_14 * (utf8.len(var_224_17) / 5)) > 0 and var_224_14 < var_224_19 then
					arg_221_1.talkMaxDuration = var_224_19
					var_224_13 = var_224_13 + 0.3

					if var_224_19 + var_224_13 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_19 + var_224_13
					end
				end

				arg_221_1.text_.text = var_224_17
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891052", "story_v_out_319891.awb") ~= 0 then
					local var_224_20 = manager.audio:GetVoiceLength("story_v_out_319891", "319891052", "story_v_out_319891.awb") / 1000

					if var_224_20 + var_224_13 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_20 + var_224_13
					end

					if var_224_16.prefab_name ~= "" and arg_221_1.actors_[var_224_16.prefab_name] ~= nil then
						local var_224_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_16.prefab_name].transform, "story_v_out_319891", "319891052", "story_v_out_319891.awb")

						arg_221_1:RecordAudio("319891052", var_224_21)
						arg_221_1:RecordAudio("319891052", var_224_21)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_319891", "319891052", "story_v_out_319891.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_319891", "319891052", "story_v_out_319891.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_22 = var_224_13 + 0.3
			local var_224_23 = math.max(var_224_14, arg_221_1.talkMaxDuration)

			if var_224_13 + 0.3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_22 + var_224_23 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_22) / var_224_23

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_22 + var_224_23 and arg_221_1.time_ < var_224_22 + var_224_23 + arg_224_0 then
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
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1084ui_story"]) and arg_227_1.var_.characterEffect1084ui_story == nil then
				arg_227_1.var_.characterEffect1084ui_story = arg_227_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1084ui_story"]) then
				if arg_227_1.var_.characterEffect1084ui_story and not isNil(arg_227_1.actors_["1084ui_story"]) then
					arg_227_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_227_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_0)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1084ui_story"]) and arg_227_1.var_.characterEffect1084ui_story then
				arg_227_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_227_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_230_1 = arg_227_1.actors_["1084ui_story"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1084ui_story = var_230_1.localPosition
			end

			local var_230_2 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 then
				var_230_1.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_2)
				var_230_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_1.position).x, (manager.ui.mainCamera.transform.position - var_230_1.position).y, (manager.ui.mainCamera.transform.position - var_230_1.position).z)
				var_230_1.localEulerAngles.z = 0
				var_230_1.localEulerAngles.x = 0
				var_230_1.localEulerAngles = var_230_1.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 then
				var_230_1.localPosition = Vector3.New(0, 100, 0)
				var_230_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_1.position).x, (manager.ui.mainCamera.transform.position - var_230_1.position).y, (manager.ui.mainCamera.transform.position - var_230_1.position).z)
				var_230_1.localEulerAngles.z = 0
				var_230_1.localEulerAngles.x = 0
				var_230_1.localEulerAngles = var_230_1.localEulerAngles
			end

			local var_230_3 = 0
			local var_230_4 = 0.975

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_3 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, false)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_5 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(319891053).content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 39 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 39)

				if (39 <= 0 and var_230_4 or var_230_4 * (utf8.len(var_230_5) / 39)) > 0 and var_230_4 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_3 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_3
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_8 = math.max(var_230_4, arg_227_1.talkMaxDuration)

			if var_230_3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_3 + var_230_8 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_3) / var_230_8

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_3 + var_230_8 and arg_227_1.time_ < var_230_3 + var_230_8 + arg_230_0 then
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
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:AudioAction("stop", "effect", "se_story_130", "se_story_130_police", "")
			end

			local var_234_1 = arg_231_1.actors_["1084ui_story"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1084ui_story = var_234_1.localPosition
			end

			local var_234_2 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 then
				var_234_1.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_231_1.time_ - 0) / var_234_2)
				var_234_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_1.position).x, (manager.ui.mainCamera.transform.position - var_234_1.position).y, (manager.ui.mainCamera.transform.position - var_234_1.position).z)
				var_234_1.localEulerAngles.z = 0
				var_234_1.localEulerAngles.x = 0
				var_234_1.localEulerAngles = var_234_1.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 then
				var_234_1.localPosition = Vector3.New(0, -0.97, -6)
				var_234_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_234_1.position).x, (manager.ui.mainCamera.transform.position - var_234_1.position).y, (manager.ui.mainCamera.transform.position - var_234_1.position).z)
				var_234_1.localEulerAngles.z = 0
				var_234_1.localEulerAngles.x = 0
				var_234_1.localEulerAngles = var_234_1.localEulerAngles
			end

			local var_234_3 = arg_231_1.actors_["1084ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_3) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = var_234_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_4 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_4 and not isNil(var_234_3) then
				if arg_231_1.var_.characterEffect1084ui_story and not isNil(var_234_3) then
					arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_4 and arg_231_1.time_ < 0 + var_234_4 + arg_234_0 and not isNil(var_234_3) and arg_231_1.var_.characterEffect1084ui_story then
				arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_6 = 0
			local var_234_7 = 0.5

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_8 = arg_231_1:GetWordFromCfg(319891054)
				local var_234_9 = arg_231_1:FormatText(var_234_8.content)

				arg_231_1.text_.text = var_234_9

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_11 = 20 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_9) / 20)

				if (20 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_9) / 20)) > 0 and var_234_7 < var_234_11 then
					arg_231_1.talkMaxDuration = var_234_11

					if var_234_11 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_6
					end
				end

				arg_231_1.text_.text = var_234_9
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891054", "story_v_out_319891.awb") ~= 0 then
					local var_234_12 = manager.audio:GetVoiceLength("story_v_out_319891", "319891054", "story_v_out_319891.awb") / 1000

					if var_234_12 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_12 + var_234_6
					end

					if var_234_8.prefab_name ~= "" and arg_231_1.actors_[var_234_8.prefab_name] ~= nil then
						local var_234_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_8.prefab_name].transform, "story_v_out_319891", "319891054", "story_v_out_319891.awb")

						arg_231_1:RecordAudio("319891054", var_234_13)
						arg_231_1:RecordAudio("319891054", var_234_13)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_319891", "319891054", "story_v_out_319891.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_319891", "319891054", "story_v_out_319891.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_14 = math.max(var_234_7, arg_231_1.talkMaxDuration)

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_14 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_6) / var_234_14

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_6 + var_234_14 and arg_231_1.time_ < var_234_6 + var_234_14 + arg_234_0 then
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
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1084ui_story"]) and arg_235_1.var_.characterEffect1084ui_story == nil then
				arg_235_1.var_.characterEffect1084ui_story = arg_235_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1084ui_story"]) then
				if arg_235_1.var_.characterEffect1084ui_story and not isNil(arg_235_1.actors_["1084ui_story"]) then
					arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_0)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1084ui_story"]) and arg_235_1.var_.characterEffect1084ui_story then
				arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_238_1 = 0
			local var_238_2 = 0.925

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[694].name)

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

				local var_238_3 = arg_235_1:GetWordFromCfg(319891055)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_6 = 37 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_4) / 37)

				if (37 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_4) / 37)) > 0 and var_238_2 < var_238_6 then
					arg_235_1.talkMaxDuration = var_238_6

					if var_238_6 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891055", "story_v_out_319891.awb") ~= 0 then
					local var_238_7 = manager.audio:GetVoiceLength("story_v_out_319891", "319891055", "story_v_out_319891.awb") / 1000

					if var_238_7 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_1
					end

					if var_238_3.prefab_name ~= "" and arg_235_1.actors_[var_238_3.prefab_name] ~= nil then
						local var_238_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_3.prefab_name].transform, "story_v_out_319891", "319891055", "story_v_out_319891.awb")

						arg_235_1:RecordAudio("319891055", var_238_8)
						arg_235_1:RecordAudio("319891055", var_238_8)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_319891", "319891055", "story_v_out_319891.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_319891", "319891055", "story_v_out_319891.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_9 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_9 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_9

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_9 and arg_235_1.time_ < var_238_1 + var_238_9 + arg_238_0 then
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
			local var_242_0 = 0.25

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[694].name)

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

				local var_242_1 = arg_239_1:GetWordFromCfg(319891056)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 10 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 10)

				if (10 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 10)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891056", "story_v_out_319891.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_319891", "319891056", "story_v_out_319891.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_319891", "319891056", "story_v_out_319891.awb")

						arg_239_1:RecordAudio("319891056", var_242_6)
						arg_239_1:RecordAudio("319891056", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_319891", "319891056", "story_v_out_319891.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_319891", "319891056", "story_v_out_319891.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
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
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) and arg_243_1.var_.characterEffect1084ui_story == nil then
				arg_243_1.var_.characterEffect1084ui_story = arg_243_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) then
				if arg_243_1.var_.characterEffect1084ui_story and not isNil(arg_243_1.actors_["1084ui_story"]) then
					arg_243_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) and arg_243_1.var_.characterEffect1084ui_story then
				arg_243_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_246_2 = 0
			local var_246_3 = 0.275

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_4 = arg_243_1:GetWordFromCfg(319891057)
				local var_246_5 = arg_243_1:FormatText(var_246_4.content)

				arg_243_1.text_.text = var_246_5

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 11 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 11)

				if (11 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 11)) > 0 and var_246_3 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_5
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891057", "story_v_out_319891.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_319891", "319891057", "story_v_out_319891.awb") / 1000

					if var_246_8 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_2
					end

					if var_246_4.prefab_name ~= "" and arg_243_1.actors_[var_246_4.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_4.prefab_name].transform, "story_v_out_319891", "319891057", "story_v_out_319891.awb")

						arg_243_1:RecordAudio("319891057", var_246_9)
						arg_243_1:RecordAudio("319891057", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_319891", "319891057", "story_v_out_319891.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_319891", "319891057", "story_v_out_319891.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_10 and arg_243_1.time_ < var_246_2 + var_246_10 + arg_246_0 then
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
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) and arg_247_1.var_.characterEffect1084ui_story == nil then
				arg_247_1.var_.characterEffect1084ui_story = arg_247_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_0 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) then
				if arg_247_1.var_.characterEffect1084ui_story and not isNil(arg_247_1.actors_["1084ui_story"]) then
					arg_247_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_0)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["1084ui_story"]) and arg_247_1.var_.characterEffect1084ui_story then
				arg_247_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_250_1 = 0
			local var_250_2 = 0.55

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[694].name)

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

				local var_250_3 = arg_247_1:GetWordFromCfg(319891058)
				local var_250_4 = arg_247_1:FormatText(var_250_3.content)

				arg_247_1.text_.text = var_250_4

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_6 = 22 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_4) / 22)

				if (22 <= 0 and var_250_2 or var_250_2 * (utf8.len(var_250_4) / 22)) > 0 and var_250_2 < var_250_6 then
					arg_247_1.talkMaxDuration = var_250_6

					if var_250_6 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_1
					end
				end

				arg_247_1.text_.text = var_250_4
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891058", "story_v_out_319891.awb") ~= 0 then
					local var_250_7 = manager.audio:GetVoiceLength("story_v_out_319891", "319891058", "story_v_out_319891.awb") / 1000

					if var_250_7 + var_250_1 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_7 + var_250_1
					end

					if var_250_3.prefab_name ~= "" and arg_247_1.actors_[var_250_3.prefab_name] ~= nil then
						local var_250_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_3.prefab_name].transform, "story_v_out_319891", "319891058", "story_v_out_319891.awb")

						arg_247_1:RecordAudio("319891058", var_250_8)
						arg_247_1:RecordAudio("319891058", var_250_8)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_319891", "319891058", "story_v_out_319891.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_319891", "319891058", "story_v_out_319891.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_9 = math.max(var_250_2, arg_247_1.talkMaxDuration)

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_9 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_1) / var_250_9

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_1 + var_250_9 and arg_247_1.time_ < var_250_1 + var_250_9 + arg_250_0 then
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
			local var_254_0 = 0.65

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[694].name)

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

				local var_254_1 = arg_251_1:GetWordFromCfg(319891059)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 26 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 26)

				if (26 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 26)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891059", "story_v_out_319891.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_319891", "319891059", "story_v_out_319891.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_319891", "319891059", "story_v_out_319891.awb")

						arg_251_1:RecordAudio("319891059", var_254_6)
						arg_251_1:RecordAudio("319891059", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_319891", "319891059", "story_v_out_319891.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_319891", "319891059", "story_v_out_319891.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
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
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_258_0 = 0
			local var_258_1 = 0.8

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[694].name)

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

				local var_258_2 = arg_255_1:GetWordFromCfg(319891060)
				local var_258_3 = arg_255_1:FormatText(var_258_2.content)

				arg_255_1.text_.text = var_258_3

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_5 = 32 <= 0 and var_258_1 or var_258_1 * (utf8.len(var_258_3) / 32)

				if (32 <= 0 and var_258_1 or var_258_1 * (utf8.len(var_258_3) / 32)) > 0 and var_258_1 < var_258_5 then
					arg_255_1.talkMaxDuration = var_258_5

					if var_258_5 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + var_258_0
					end
				end

				arg_255_1.text_.text = var_258_3
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891060", "story_v_out_319891.awb") ~= 0 then
					local var_258_6 = manager.audio:GetVoiceLength("story_v_out_319891", "319891060", "story_v_out_319891.awb") / 1000

					if var_258_6 + var_258_0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_6 + var_258_0
					end

					if var_258_2.prefab_name ~= "" and arg_255_1.actors_[var_258_2.prefab_name] ~= nil then
						local var_258_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_2.prefab_name].transform, "story_v_out_319891", "319891060", "story_v_out_319891.awb")

						arg_255_1:RecordAudio("319891060", var_258_7)
						arg_255_1:RecordAudio("319891060", var_258_7)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_319891", "319891060", "story_v_out_319891.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_319891", "319891060", "story_v_out_319891.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_8 = math.max(var_258_1, arg_255_1.talkMaxDuration)

			if var_258_0 <= arg_255_1.time_ and arg_255_1.time_ < var_258_0 + var_258_8 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_0) / var_258_8

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_0 + var_258_8 and arg_255_1.time_ < var_258_0 + var_258_8 + arg_258_0 then
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
			if arg_259_1.bgs_.ST74a == nil then
				local var_262_0 = Object.Instantiate(arg_259_1.paintGo_)

				var_262_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST74a")
				var_262_0.name = "ST74a"
				var_262_0.transform.parent = arg_259_1.stage_.transform
				var_262_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.bgs_.ST74a = var_262_0
			end

			if 2 < arg_259_1.time_ and arg_259_1.time_ <= 2 + arg_262_0 then
				local var_262_1 = arg_259_1.bgs_.ST74a

				arg_259_1.bgs_.ST74a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_262_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_262_2 = var_262_1:GetComponent("SpriteRenderer")

				if var_262_2 and var_262_2.sprite then
					local var_262_3 = 2 * (var_262_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_262_1.transform.localScale = Vector3.New(var_262_3 / var_262_2.sprite.bounds.size.y < var_262_3 * manager.ui.mainCameraCom_.aspect / var_262_2.sprite.bounds.size.x and var_262_3 * manager.ui.mainCameraCom_.aspect / var_262_2.sprite.bounds.size.x or var_262_3 / var_262_2.sprite.bounds.size.y, var_262_3 / var_262_2.sprite.bounds.size.y < var_262_3 * manager.ui.mainCameraCom_.aspect / var_262_2.sprite.bounds.size.x and var_262_3 * manager.ui.mainCameraCom_.aspect / var_262_2.sprite.bounds.size.x or var_262_3 / var_262_2.sprite.bounds.size.y, 0)
				end

				for iter_262_0, iter_262_1 in pairs(arg_259_1.bgs_) do
					if iter_262_0 ~= "ST74a" then
						iter_262_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_262_4 = 0

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1.allBtn_.enabled = false
			end

			if arg_259_1.time_ >= var_262_4 + 0.3 and arg_259_1.time_ < var_262_4 + 0.3 + arg_262_0 then
				arg_259_1.allBtn_.enabled = true
			end

			local var_262_5 = 0

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1.mask_.enabled = true
				arg_259_1.mask_.raycastTarget = true

				arg_259_1:SetGaussion(false)
			end

			local var_262_6 = 2

			if var_262_5 <= arg_259_1.time_ and arg_259_1.time_ < var_262_5 + var_262_6 then
				local var_262_7 = Color.New(0, 0, 0)

				var_262_7.a = Mathf.Lerp(0, 1, (arg_259_1.time_ - var_262_5) / var_262_6)
				arg_259_1.mask_.color = var_262_7
			end

			if arg_259_1.time_ >= var_262_5 + var_262_6 and arg_259_1.time_ < var_262_5 + var_262_6 + arg_262_0 then
				local var_262_8 = Color.New(0, 0, 0)

				var_262_8.a = 1
				arg_259_1.mask_.color = var_262_8
			end

			local var_262_9 = 2

			if 2 < arg_259_1.time_ and arg_259_1.time_ <= var_262_9 + arg_262_0 then
				arg_259_1.mask_.enabled = true
				arg_259_1.mask_.raycastTarget = true

				arg_259_1:SetGaussion(false)
			end

			local var_262_10 = 2

			if var_262_9 <= arg_259_1.time_ and arg_259_1.time_ < var_262_9 + var_262_10 then
				local var_262_11 = Color.New(0, 0, 0)

				var_262_11.a = Mathf.Lerp(1, 0, (arg_259_1.time_ - var_262_9) / var_262_10)
				arg_259_1.mask_.color = var_262_11
			end

			if arg_259_1.time_ >= var_262_9 + var_262_10 and arg_259_1.time_ < var_262_9 + var_262_10 + arg_262_0 then
				local var_262_12 = Color.New(0, 0, 0)

				arg_259_1.mask_.enabled = false
				var_262_12.a = 0
				arg_259_1.mask_.color = var_262_12
			end

			local var_262_13 = "4040ui_story"

			if arg_259_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_262_14 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_259_1.stage_.transform)

				var_262_14.name = var_262_13
				var_262_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_259_1.actors_[var_262_13] = var_262_14

				local var_262_15 = var_262_14:GetComponentInChildren(typeof(CharacterEffect))

				var_262_15.enabled = true

				local var_262_16 = GameObjectTools.GetOrAddComponent(var_262_14, typeof(DynamicBoneHelper))

				if var_262_16 then
					var_262_16:EnableDynamicBone(false)
				end

				arg_259_1:ShowWeapon(var_262_15.transform, false)

				arg_259_1.var_[var_262_13 .. "Animator"] = var_262_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_259_1.var_[var_262_13 .. "Animator"].applyRootMotion = true
				arg_259_1.var_[var_262_13 .. "LipSync"] = var_262_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_262_17 = arg_259_1.actors_["4040ui_story"].transform

			if 3.86666666666667 < arg_259_1.time_ and arg_259_1.time_ <= 3.86666666666667 + arg_262_0 then
				arg_259_1.var_.moveOldPos4040ui_story = var_262_17.localPosition
			end

			local var_262_18 = 0.001

			if 3.86666666666667 <= arg_259_1.time_ and arg_259_1.time_ < 3.86666666666667 + var_262_18 then
				var_262_17.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_259_1.time_ - 3.86666666666667) / var_262_18)
				var_262_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_17.position).x, (manager.ui.mainCamera.transform.position - var_262_17.position).y, (manager.ui.mainCamera.transform.position - var_262_17.position).z)
				var_262_17.localEulerAngles.z = 0
				var_262_17.localEulerAngles.x = 0
				var_262_17.localEulerAngles = var_262_17.localEulerAngles
			end

			if arg_259_1.time_ >= 3.86666666666667 + var_262_18 and arg_259_1.time_ < 3.86666666666667 + var_262_18 + arg_262_0 then
				var_262_17.localPosition = Vector3.New(0, -1.55, -5.5)
				var_262_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_17.position).x, (manager.ui.mainCamera.transform.position - var_262_17.position).y, (manager.ui.mainCamera.transform.position - var_262_17.position).z)
				var_262_17.localEulerAngles.z = 0
				var_262_17.localEulerAngles.x = 0
				var_262_17.localEulerAngles = var_262_17.localEulerAngles
			end

			local var_262_19 = arg_259_1.actors_["4040ui_story"]

			if 3.86666666666667 < arg_259_1.time_ and arg_259_1.time_ <= 3.86666666666667 + arg_262_0 and not isNil(var_262_19) and arg_259_1.var_.characterEffect4040ui_story == nil then
				arg_259_1.var_.characterEffect4040ui_story = var_262_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_20 = 0.200000002980232

			if 3.86666666666667 <= arg_259_1.time_ and arg_259_1.time_ < 3.86666666666667 + var_262_20 and not isNil(var_262_19) then
				if arg_259_1.var_.characterEffect4040ui_story and not isNil(var_262_19) then
					arg_259_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 3.86666666666667 + var_262_20 and arg_259_1.time_ < 3.86666666666667 + var_262_20 + arg_262_0 and not isNil(var_262_19) and arg_259_1.var_.characterEffect4040ui_story then
				arg_259_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 3.86666666666667 < arg_259_1.time_ and arg_259_1.time_ <= 3.86666666666667 + arg_262_0 then
				arg_259_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 3.86666666666667 < arg_259_1.time_ and arg_259_1.time_ <= 3.86666666666667 + arg_262_0 then
				arg_259_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_22 = arg_259_1.actors_["1084ui_story"].transform

			if 2 < arg_259_1.time_ and arg_259_1.time_ <= 2 + arg_262_0 then
				arg_259_1.var_.moveOldPos1084ui_story = var_262_22.localPosition
			end

			local var_262_23 = 0.001

			if 2 <= arg_259_1.time_ and arg_259_1.time_ < 2 + var_262_23 then
				var_262_22.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_259_1.time_ - 2) / var_262_23)
				var_262_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_22.position).x, (manager.ui.mainCamera.transform.position - var_262_22.position).y, (manager.ui.mainCamera.transform.position - var_262_22.position).z)
				var_262_22.localEulerAngles.z = 0
				var_262_22.localEulerAngles.x = 0
				var_262_22.localEulerAngles = var_262_22.localEulerAngles
			end

			if arg_259_1.time_ >= 2 + var_262_23 and arg_259_1.time_ < 2 + var_262_23 + arg_262_0 then
				var_262_22.localPosition = Vector3.New(0, 100, 0)
				var_262_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_22.position).x, (manager.ui.mainCamera.transform.position - var_262_22.position).y, (manager.ui.mainCamera.transform.position - var_262_22.position).z)
				var_262_22.localEulerAngles.z = 0
				var_262_22.localEulerAngles.x = 0
				var_262_22.localEulerAngles = var_262_22.localEulerAngles
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:AudioAction("stop", "effect", "se_story_130", "se_story_130_sea", "")
			end

			if arg_259_1.frameCnt_ <= 1 then
				arg_259_1.dialog_:SetActive(false)
			end

			local var_262_25 = 3.90066666851441
			local var_262_26 = 0.325

			if 3.90066666851441 < arg_259_1.time_ and arg_259_1.time_ <= var_262_25 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0

				arg_259_1.dialog_:SetActive(true)

				arg_259_1.dialogCg_.alpha = 0

				local var_262_27 = LeanTween.value(arg_259_1.dialog_, 0, 1, 0.3)

				var_262_27:setOnUpdate(LuaHelper.FloatAction(function(arg_263_0)
					arg_259_1.dialogCg_.alpha = arg_263_0
				end))
				var_262_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_259_1.dialog_)
					var_262_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_259_1.duration_ = arg_259_1.duration_ + 0.3

				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_28 = arg_259_1:GetWordFromCfg(319891061)
				local var_262_29 = arg_259_1:FormatText(var_262_28.content)

				arg_259_1.text_.text = var_262_29

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_31 = 13 <= 0 and var_262_26 or var_262_26 * (utf8.len(var_262_29) / 13)

				if (13 <= 0 and var_262_26 or var_262_26 * (utf8.len(var_262_29) / 13)) > 0 and var_262_26 < var_262_31 then
					arg_259_1.talkMaxDuration = var_262_31
					var_262_25 = var_262_25 + 0.3

					if var_262_31 + var_262_25 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_31 + var_262_25
					end
				end

				arg_259_1.text_.text = var_262_29
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891061", "story_v_out_319891.awb") ~= 0 then
					local var_262_32 = manager.audio:GetVoiceLength("story_v_out_319891", "319891061", "story_v_out_319891.awb") / 1000

					if var_262_32 + var_262_25 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_32 + var_262_25
					end

					if var_262_28.prefab_name ~= "" and arg_259_1.actors_[var_262_28.prefab_name] ~= nil then
						local var_262_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_28.prefab_name].transform, "story_v_out_319891", "319891061", "story_v_out_319891.awb")

						arg_259_1:RecordAudio("319891061", var_262_33)
						arg_259_1:RecordAudio("319891061", var_262_33)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_319891", "319891061", "story_v_out_319891.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_319891", "319891061", "story_v_out_319891.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_34 = var_262_25 + 0.3
			local var_262_35 = math.max(var_262_26, arg_259_1.talkMaxDuration)

			if var_262_25 + 0.3 <= arg_259_1.time_ and arg_259_1.time_ < var_262_34 + var_262_35 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_34) / var_262_35

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_34 + var_262_35 and arg_259_1.time_ < var_262_34 + var_262_35 + arg_262_0 then
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
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["4040ui_story"]) and arg_265_1.var_.characterEffect4040ui_story == nil then
				arg_265_1.var_.characterEffect4040ui_story = arg_265_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["4040ui_story"]) then
				if arg_265_1.var_.characterEffect4040ui_story and not isNil(arg_265_1.actors_["4040ui_story"]) then
					arg_265_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_265_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_0)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["4040ui_story"]) and arg_265_1.var_.characterEffect4040ui_story then
				arg_265_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_265_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_268_1 = arg_265_1.actors_["1084ui_story"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1084ui_story = var_268_1.localPosition
			end

			local var_268_2 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 then
				var_268_1.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_265_1.time_ - 0) / var_268_2)
				var_268_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_1.position).x, (manager.ui.mainCamera.transform.position - var_268_1.position).y, (manager.ui.mainCamera.transform.position - var_268_1.position).z)
				var_268_1.localEulerAngles.z = 0
				var_268_1.localEulerAngles.x = 0
				var_268_1.localEulerAngles = var_268_1.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 then
				var_268_1.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_268_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_1.position).x, (manager.ui.mainCamera.transform.position - var_268_1.position).y, (manager.ui.mainCamera.transform.position - var_268_1.position).z)
				var_268_1.localEulerAngles.z = 0
				var_268_1.localEulerAngles.x = 0
				var_268_1.localEulerAngles = var_268_1.localEulerAngles
			end

			local var_268_3 = arg_265_1.actors_["4040ui_story"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos4040ui_story = var_268_3.localPosition
			end

			local var_268_4 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				var_268_3.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_265_1.time_ - 0) / var_268_4)
				var_268_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_3.position).x, (manager.ui.mainCamera.transform.position - var_268_3.position).y, (manager.ui.mainCamera.transform.position - var_268_3.position).z)
				var_268_3.localEulerAngles.z = 0
				var_268_3.localEulerAngles.x = 0
				var_268_3.localEulerAngles = var_268_3.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				var_268_3.localPosition = Vector3.New(0.7, -1.55, -5.5)
				var_268_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_3.position).x, (manager.ui.mainCamera.transform.position - var_268_3.position).y, (manager.ui.mainCamera.transform.position - var_268_3.position).z)
				var_268_3.localEulerAngles.z = 0
				var_268_3.localEulerAngles.x = 0
				var_268_3.localEulerAngles = var_268_3.localEulerAngles
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_268_5 = arg_265_1.actors_["1084ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.characterEffect1084ui_story == nil then
				arg_265_1.var_.characterEffect1084ui_story = var_268_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_6 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_6 and not isNil(var_268_5) then
				if arg_265_1.var_.characterEffect1084ui_story and not isNil(var_268_5) then
					arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_6 and arg_265_1.time_ < 0 + var_268_6 + arg_268_0 and not isNil(var_268_5) and arg_265_1.var_.characterEffect1084ui_story then
				arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_268_8 = 0
			local var_268_9 = 0.05

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_10 = arg_265_1:GetWordFromCfg(319891062)
				local var_268_11 = arg_265_1:FormatText(var_268_10.content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_13 = 2 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 2)

				if (2 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 2)) > 0 and var_268_9 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891062", "story_v_out_319891.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_out_319891", "319891062", "story_v_out_319891.awb") / 1000

					if var_268_14 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_8
					end

					if var_268_10.prefab_name ~= "" and arg_265_1.actors_[var_268_10.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_10.prefab_name].transform, "story_v_out_319891", "319891062", "story_v_out_319891.awb")

						arg_265_1:RecordAudio("319891062", var_268_15)
						arg_265_1:RecordAudio("319891062", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_319891", "319891062", "story_v_out_319891.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_319891", "319891062", "story_v_out_319891.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_16 = math.max(var_268_9, arg_265_1.talkMaxDuration)

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_16 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_8) / var_268_16

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_8 + var_268_16 and arg_265_1.time_ < var_268_8 + var_268_16 + arg_268_0 then
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
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["4040ui_story"]) and arg_269_1.var_.characterEffect4040ui_story == nil then
				arg_269_1.var_.characterEffect4040ui_story = arg_269_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["4040ui_story"]) then
				if arg_269_1.var_.characterEffect4040ui_story and not isNil(arg_269_1.actors_["4040ui_story"]) then
					arg_269_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["4040ui_story"]) and arg_269_1.var_.characterEffect4040ui_story then
				arg_269_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_272_2 = arg_269_1.actors_["1084ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect1084ui_story == nil then
				arg_269_1.var_.characterEffect1084ui_story = var_272_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_3 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.characterEffect1084ui_story and not isNil(var_272_2) then
					arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_3)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect1084ui_story then
				arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_272_4 = 0
			local var_272_5 = 0.525

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(319891063)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 21 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 21)

				if (21 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 21)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891063", "story_v_out_319891.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_319891", "319891063", "story_v_out_319891.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_319891", "319891063", "story_v_out_319891.awb")

						arg_269_1:RecordAudio("319891063", var_272_11)
						arg_269_1:RecordAudio("319891063", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_319891", "319891063", "story_v_out_319891.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_319891", "319891063", "story_v_out_319891.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
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
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos4040ui_story = arg_273_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["4040ui_story"].transform.position).z)
				arg_273_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["4040ui_story"].transform.localEulerAngles = arg_273_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0.7, -1.55, -5.5)
				arg_273_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["4040ui_story"].transform.position).z)
				arg_273_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["4040ui_story"].transform.localEulerAngles = arg_273_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_276_1 = 0
			local var_276_2 = 0.25

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:GetWordFromCfg(319891064)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_6 = 10 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_4) / 10)

				if (10 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_4) / 10)) > 0 and var_276_2 < var_276_6 then
					arg_273_1.talkMaxDuration = var_276_6

					if var_276_6 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_6 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_4
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891064", "story_v_out_319891.awb") ~= 0 then
					local var_276_7 = manager.audio:GetVoiceLength("story_v_out_319891", "319891064", "story_v_out_319891.awb") / 1000

					if var_276_7 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_7 + var_276_1
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_319891", "319891064", "story_v_out_319891.awb")

						arg_273_1:RecordAudio("319891064", var_276_8)
						arg_273_1:RecordAudio("319891064", var_276_8)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_319891", "319891064", "story_v_out_319891.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_319891", "319891064", "story_v_out_319891.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_9 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_9 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_9

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_9 and arg_273_1.time_ < var_276_1 + var_276_9 + arg_276_0 then
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
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["4040ui_story"]) and arg_277_1.var_.characterEffect4040ui_story == nil then
				arg_277_1.var_.characterEffect4040ui_story = arg_277_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["4040ui_story"]) then
				if arg_277_1.var_.characterEffect4040ui_story and not isNil(arg_277_1.actors_["4040ui_story"]) then
					arg_277_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_277_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_0)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["4040ui_story"]) and arg_277_1.var_.characterEffect4040ui_story then
				arg_277_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_277_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_280_1 = arg_277_1.actors_["1084ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1084ui_story == nil then
				arg_277_1.var_.characterEffect1084ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect1084ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect1084ui_story then
				arg_277_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_280_4 = 0
			local var_280_5 = 0.075

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(319891065)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 3 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 3)

				if (3 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 3)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891065", "story_v_out_319891.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_319891", "319891065", "story_v_out_319891.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_319891", "319891065", "story_v_out_319891.awb")

						arg_277_1:RecordAudio("319891065", var_280_11)
						arg_277_1:RecordAudio("319891065", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_319891", "319891065", "story_v_out_319891.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_319891", "319891065", "story_v_out_319891.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
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
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_284_0 = 0
			local var_284_1 = 0.325

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(319891066)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 13 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 13)

				if (13 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 13)) > 0 and var_284_1 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891066", "story_v_out_319891.awb") ~= 0 then
					local var_284_6 = manager.audio:GetVoiceLength("story_v_out_319891", "319891066", "story_v_out_319891.awb") / 1000

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end

					if var_284_2.prefab_name ~= "" and arg_281_1.actors_[var_284_2.prefab_name] ~= nil then
						local var_284_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_2.prefab_name].transform, "story_v_out_319891", "319891066", "story_v_out_319891.awb")

						arg_281_1:RecordAudio("319891066", var_284_7)
						arg_281_1:RecordAudio("319891066", var_284_7)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_319891", "319891066", "story_v_out_319891.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_319891", "319891066", "story_v_out_319891.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_8 and arg_281_1.time_ < var_284_0 + var_284_8 + arg_284_0 then
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
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["4040ui_story"]) and arg_285_1.var_.characterEffect4040ui_story == nil then
				arg_285_1.var_.characterEffect4040ui_story = arg_285_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["4040ui_story"]) then
				if arg_285_1.var_.characterEffect4040ui_story and not isNil(arg_285_1.actors_["4040ui_story"]) then
					arg_285_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["4040ui_story"]) and arg_285_1.var_.characterEffect4040ui_story then
				arg_285_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_288_2 = arg_285_1.actors_["1084ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1084ui_story == nil then
				arg_285_1.var_.characterEffect1084ui_story = var_288_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_3 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.characterEffect1084ui_story and not isNil(var_288_2) then
					arg_285_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_3)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect1084ui_story then
				arg_285_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_288_4 = 0
			local var_288_5 = 0.05

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(319891067)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 2 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 2)

				if (2 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 2)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891067", "story_v_out_319891.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_319891", "319891067", "story_v_out_319891.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_319891", "319891067", "story_v_out_319891.awb")

						arg_285_1:RecordAudio("319891067", var_288_11)
						arg_285_1:RecordAudio("319891067", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_319891", "319891067", "story_v_out_319891.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_319891", "319891067", "story_v_out_319891.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
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
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1084ui_story = arg_289_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1084ui_story"].transform.position).z)
				arg_289_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1084ui_story"].transform.localEulerAngles = arg_289_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1084ui_story"].transform.position).z)
				arg_289_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1084ui_story"].transform.localEulerAngles = arg_289_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["4040ui_story"].transform

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos4040ui_story = var_292_1.localPosition
			end

			local var_292_2 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 then
				var_292_1.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 0) / var_292_2)
				var_292_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_1.position).x, (manager.ui.mainCamera.transform.position - var_292_1.position).y, (manager.ui.mainCamera.transform.position - var_292_1.position).z)
				var_292_1.localEulerAngles.z = 0
				var_292_1.localEulerAngles.x = 0
				var_292_1.localEulerAngles = var_292_1.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 then
				var_292_1.localPosition = Vector3.New(0, 100, 0)
				var_292_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_1.position).x, (manager.ui.mainCamera.transform.position - var_292_1.position).y, (manager.ui.mainCamera.transform.position - var_292_1.position).z)
				var_292_1.localEulerAngles.z = 0
				var_292_1.localEulerAngles.x = 0
				var_292_1.localEulerAngles = var_292_1.localEulerAngles
			end

			local var_292_3 = 0
			local var_292_4 = 1.075

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_3 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_5 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(319891068).content)

				arg_289_1.text_.text = var_292_5

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_7 = 43 <= 0 and var_292_4 or var_292_4 * (utf8.len(var_292_5) / 43)

				if (43 <= 0 and var_292_4 or var_292_4 * (utf8.len(var_292_5) / 43)) > 0 and var_292_4 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_3 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_3
					end
				end

				arg_289_1.text_.text = var_292_5
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_8 = math.max(var_292_4, arg_289_1.talkMaxDuration)

			if var_292_3 <= arg_289_1.time_ and arg_289_1.time_ < var_292_3 + var_292_8 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_3) / var_292_8

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_3 + var_292_8 and arg_289_1.time_ < var_292_3 + var_292_8 + arg_292_0 then
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
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1095ui_story = arg_293_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1095ui_story"].transform.position).z)
				arg_293_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1095ui_story"].transform.localEulerAngles = arg_293_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_293_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1095ui_story"].transform.position).z)
				arg_293_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1095ui_story"].transform.localEulerAngles = arg_293_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["1095ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1095ui_story == nil then
				arg_293_1.var_.characterEffect1095ui_story = var_296_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 and not isNil(var_296_1) then
				if arg_293_1.var_.characterEffect1095ui_story and not isNil(var_296_1) then
					arg_293_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1095ui_story then
				arg_293_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_296_4 = arg_293_1.actors_["1084ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1084ui_story = var_296_4.localPosition
			end

			local var_296_5 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_5 then
				var_296_4.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_5)
				var_296_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_4.position).x, (manager.ui.mainCamera.transform.position - var_296_4.position).y, (manager.ui.mainCamera.transform.position - var_296_4.position).z)
				var_296_4.localEulerAngles.z = 0
				var_296_4.localEulerAngles.x = 0
				var_296_4.localEulerAngles = var_296_4.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_5 and arg_293_1.time_ < 0 + var_296_5 + arg_296_0 then
				var_296_4.localPosition = Vector3.New(0, 100, 0)
				var_296_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_4.position).x, (manager.ui.mainCamera.transform.position - var_296_4.position).y, (manager.ui.mainCamera.transform.position - var_296_4.position).z)
				var_296_4.localEulerAngles.z = 0
				var_296_4.localEulerAngles.x = 0
				var_296_4.localEulerAngles = var_296_4.localEulerAngles
			end

			local var_296_6 = arg_293_1.actors_["1084ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect1084ui_story == nil then
				arg_293_1.var_.characterEffect1084ui_story = var_296_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_7 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 and not isNil(var_296_6) then
				if arg_293_1.var_.characterEffect1084ui_story and not isNil(var_296_6) then
					arg_293_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_7)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect1084ui_story then
				arg_293_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_296_8 = arg_293_1.actors_["4040ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos4040ui_story = var_296_8.localPosition
			end

			local var_296_9 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_9 then
				var_296_8.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_9)
				var_296_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_8.position).x, (manager.ui.mainCamera.transform.position - var_296_8.position).y, (manager.ui.mainCamera.transform.position - var_296_8.position).z)
				var_296_8.localEulerAngles.z = 0
				var_296_8.localEulerAngles.x = 0
				var_296_8.localEulerAngles = var_296_8.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_9 and arg_293_1.time_ < 0 + var_296_9 + arg_296_0 then
				var_296_8.localPosition = Vector3.New(0, 100, 0)
				var_296_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_8.position).x, (manager.ui.mainCamera.transform.position - var_296_8.position).y, (manager.ui.mainCamera.transform.position - var_296_8.position).z)
				var_296_8.localEulerAngles.z = 0
				var_296_8.localEulerAngles.x = 0
				var_296_8.localEulerAngles = var_296_8.localEulerAngles
			end

			local var_296_10 = arg_293_1.actors_["4040ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_10) and arg_293_1.var_.characterEffect4040ui_story == nil then
				arg_293_1.var_.characterEffect4040ui_story = var_296_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_11 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_11 and not isNil(var_296_10) then
				if arg_293_1.var_.characterEffect4040ui_story and not isNil(var_296_10) then
					arg_293_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_293_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_11)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_11 and arg_293_1.time_ < 0 + var_296_11 + arg_296_0 and not isNil(var_296_10) and arg_293_1.var_.characterEffect4040ui_story then
				arg_293_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_293_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_296_12 = 0
			local var_296_13 = 0.05

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_12 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_14 = arg_293_1:GetWordFromCfg(319891069)
				local var_296_15 = arg_293_1:FormatText(var_296_14.content)

				arg_293_1.text_.text = var_296_15

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_17 = 2 <= 0 and var_296_13 or var_296_13 * (utf8.len(var_296_15) / 2)

				if (2 <= 0 and var_296_13 or var_296_13 * (utf8.len(var_296_15) / 2)) > 0 and var_296_13 < var_296_17 then
					arg_293_1.talkMaxDuration = var_296_17

					if var_296_17 + var_296_12 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_17 + var_296_12
					end
				end

				arg_293_1.text_.text = var_296_15
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891069", "story_v_out_319891.awb") ~= 0 then
					local var_296_18 = manager.audio:GetVoiceLength("story_v_out_319891", "319891069", "story_v_out_319891.awb") / 1000

					if var_296_18 + var_296_12 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_18 + var_296_12
					end

					if var_296_14.prefab_name ~= "" and arg_293_1.actors_[var_296_14.prefab_name] ~= nil then
						local var_296_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_14.prefab_name].transform, "story_v_out_319891", "319891069", "story_v_out_319891.awb")

						arg_293_1:RecordAudio("319891069", var_296_19)
						arg_293_1:RecordAudio("319891069", var_296_19)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_319891", "319891069", "story_v_out_319891.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_319891", "319891069", "story_v_out_319891.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_20 = math.max(var_296_13, arg_293_1.talkMaxDuration)

			if var_296_12 <= arg_293_1.time_ and arg_293_1.time_ < var_296_12 + var_296_20 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_12) / var_296_20

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_12 + var_296_20 and arg_293_1.time_ < var_296_12 + var_296_20 + arg_296_0 then
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
			if arg_297_1.bgs_.D02a == nil then
				local var_300_0 = Object.Instantiate(arg_297_1.paintGo_)

				var_300_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D02a")
				var_300_0.name = "D02a"
				var_300_0.transform.parent = arg_297_1.stage_.transform
				var_300_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.bgs_.D02a = var_300_0
			end

			if 1.23333333333333 < arg_297_1.time_ and arg_297_1.time_ <= 1.23333333333333 + arg_300_0 then
				local var_300_1 = arg_297_1.bgs_.D02a

				arg_297_1.bgs_.D02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_300_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_300_2 = var_300_1:GetComponent("SpriteRenderer")

				if var_300_2 and var_300_2.sprite then
					local var_300_3 = 2 * (var_300_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_300_1.transform.localScale = Vector3.New(var_300_3 / var_300_2.sprite.bounds.size.y < var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x and var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x or var_300_3 / var_300_2.sprite.bounds.size.y, var_300_3 / var_300_2.sprite.bounds.size.y < var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x and var_300_3 * manager.ui.mainCameraCom_.aspect / var_300_2.sprite.bounds.size.x or var_300_3 / var_300_2.sprite.bounds.size.y, 0)
				end

				for iter_300_0, iter_300_1 in pairs(arg_297_1.bgs_) do
					if iter_300_0 ~= "D02a" then
						iter_300_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_300_4 = 0

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_5 = 1.23333333333333

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_5 then
				local var_300_6 = Color.New(0, 0, 0)

				var_300_6.a = Mathf.Lerp(0, 1, (arg_297_1.time_ - var_300_4) / var_300_5)
				arg_297_1.mask_.color = var_300_6
			end

			if arg_297_1.time_ >= var_300_4 + var_300_5 and arg_297_1.time_ < var_300_4 + var_300_5 + arg_300_0 then
				local var_300_7 = Color.New(0, 0, 0)

				var_300_7.a = 1
				arg_297_1.mask_.color = var_300_7
			end

			local var_300_8 = 1.23333333333333

			if 1.23333333333333 < arg_297_1.time_ and arg_297_1.time_ <= var_300_8 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_9 = 2

			if var_300_8 <= arg_297_1.time_ and arg_297_1.time_ < var_300_8 + var_300_9 then
				local var_300_10 = Color.New(0, 0, 0)

				var_300_10.a = Mathf.Lerp(1, 0, (arg_297_1.time_ - var_300_8) / var_300_9)
				arg_297_1.mask_.color = var_300_10
			end

			if arg_297_1.time_ >= var_300_8 + var_300_9 and arg_297_1.time_ < var_300_8 + var_300_9 + arg_300_0 then
				local var_300_11 = Color.New(0, 0, 0)

				arg_297_1.mask_.enabled = false
				var_300_11.a = 0
				arg_297_1.mask_.color = var_300_11
			end

			local var_300_12 = arg_297_1.actors_["1095ui_story"].transform

			if 1.23333333333333 < arg_297_1.time_ and arg_297_1.time_ <= 1.23333333333333 + arg_300_0 then
				arg_297_1.var_.moveOldPos1095ui_story = var_300_12.localPosition
			end

			local var_300_13 = 0.001

			if 1.23333333333333 <= arg_297_1.time_ and arg_297_1.time_ < 1.23333333333333 + var_300_13 then
				var_300_12.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 1.23333333333333) / var_300_13)
				var_300_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_12.position).x, (manager.ui.mainCamera.transform.position - var_300_12.position).y, (manager.ui.mainCamera.transform.position - var_300_12.position).z)
				var_300_12.localEulerAngles.z = 0
				var_300_12.localEulerAngles.x = 0
				var_300_12.localEulerAngles = var_300_12.localEulerAngles
			end

			if arg_297_1.time_ >= 1.23333333333333 + var_300_13 and arg_297_1.time_ < 1.23333333333333 + var_300_13 + arg_300_0 then
				var_300_12.localPosition = Vector3.New(0, 100, 0)
				var_300_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_12.position).x, (manager.ui.mainCamera.transform.position - var_300_12.position).y, (manager.ui.mainCamera.transform.position - var_300_12.position).z)
				var_300_12.localEulerAngles.z = 0
				var_300_12.localEulerAngles.x = 0
				var_300_12.localEulerAngles = var_300_12.localEulerAngles
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_14 = 3.23333333333333
			local var_300_15 = 0.875

			if 3.23333333333333 < arg_297_1.time_ and arg_297_1.time_ <= var_300_14 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_16 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_16:setOnUpdate(LuaHelper.FloatAction(function(arg_301_0)
					arg_297_1.dialogCg_.alpha = arg_301_0
				end))
				var_300_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_17 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(319891070).content)

				arg_297_1.text_.text = var_300_17

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_19 = 35 <= 0 and var_300_15 or var_300_15 * (utf8.len(var_300_17) / 35)

				if (35 <= 0 and var_300_15 or var_300_15 * (utf8.len(var_300_17) / 35)) > 0 and var_300_15 < var_300_19 then
					arg_297_1.talkMaxDuration = var_300_19
					var_300_14 = var_300_14 + 0.3

					if var_300_19 + var_300_14 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_19 + var_300_14
					end
				end

				arg_297_1.text_.text = var_300_17
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_20 = var_300_14 + 0.3
			local var_300_21 = math.max(var_300_15, arg_297_1.talkMaxDuration)

			if var_300_14 + 0.3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_20 + var_300_21 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_20) / var_300_21

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_20 + var_300_21 and arg_297_1.time_ < var_300_20 + var_300_21 + arg_300_0 then
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
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1084ui_story = arg_303_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1084ui_story"].transform.position).z)
				arg_303_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1084ui_story"].transform.localEulerAngles = arg_303_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_303_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1084ui_story"].transform.position).z)
				arg_303_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1084ui_story"].transform.localEulerAngles = arg_303_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_306_1 = arg_303_1.actors_["1084ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1084ui_story == nil then
				arg_303_1.var_.characterEffect1084ui_story = var_306_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_2 and not isNil(var_306_1) then
				if arg_303_1.var_.characterEffect1084ui_story and not isNil(var_306_1) then
					arg_303_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_2 and arg_303_1.time_ < 0 + var_306_2 + arg_306_0 and not isNil(var_306_1) and arg_303_1.var_.characterEffect1084ui_story then
				arg_303_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_306_4 = 0
			local var_306_5 = 0.35

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_4 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_6 = arg_303_1:GetWordFromCfg(319891071)
				local var_306_7 = arg_303_1:FormatText(var_306_6.content)

				arg_303_1.text_.text = var_306_7

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_9 = 14 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 14)

				if (14 <= 0 and var_306_5 or var_306_5 * (utf8.len(var_306_7) / 14)) > 0 and var_306_5 < var_306_9 then
					arg_303_1.talkMaxDuration = var_306_9

					if var_306_9 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_9 + var_306_4
					end
				end

				arg_303_1.text_.text = var_306_7
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891071", "story_v_out_319891.awb") ~= 0 then
					local var_306_10 = manager.audio:GetVoiceLength("story_v_out_319891", "319891071", "story_v_out_319891.awb") / 1000

					if var_306_10 + var_306_4 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_10 + var_306_4
					end

					if var_306_6.prefab_name ~= "" and arg_303_1.actors_[var_306_6.prefab_name] ~= nil then
						local var_306_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_6.prefab_name].transform, "story_v_out_319891", "319891071", "story_v_out_319891.awb")

						arg_303_1:RecordAudio("319891071", var_306_11)
						arg_303_1:RecordAudio("319891071", var_306_11)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_319891", "319891071", "story_v_out_319891.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_319891", "319891071", "story_v_out_319891.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_12 = math.max(var_306_5, arg_303_1.talkMaxDuration)

			if var_306_4 <= arg_303_1.time_ and arg_303_1.time_ < var_306_4 + var_306_12 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_4) / var_306_12

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_4 + var_306_12 and arg_303_1.time_ < var_306_4 + var_306_12 + arg_306_0 then
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
			local var_310_0 = 0.225

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:GetWordFromCfg(319891072)
				local var_310_2 = arg_307_1:FormatText(var_310_1.content)

				arg_307_1.text_.text = var_310_2

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 9 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 9)

				if (9 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_2) / 9)) > 0 and var_310_0 < var_310_4 then
					arg_307_1.talkMaxDuration = var_310_4

					if var_310_4 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_4 + 0
					end
				end

				arg_307_1.text_.text = var_310_2
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891072", "story_v_out_319891.awb") ~= 0 then
					local var_310_5 = manager.audio:GetVoiceLength("story_v_out_319891", "319891072", "story_v_out_319891.awb") / 1000

					if var_310_5 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + 0
					end

					if var_310_1.prefab_name ~= "" and arg_307_1.actors_[var_310_1.prefab_name] ~= nil then
						local var_310_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_1.prefab_name].transform, "story_v_out_319891", "319891072", "story_v_out_319891.awb")

						arg_307_1:RecordAudio("319891072", var_310_6)
						arg_307_1:RecordAudio("319891072", var_310_6)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_319891", "319891072", "story_v_out_319891.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_319891", "319891072", "story_v_out_319891.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_7 and arg_307_1.time_ < 0 + var_310_7 + arg_310_0 then
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
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1084ui_story = arg_311_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1084ui_story"].transform.position).z)
				arg_311_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1084ui_story"].transform.localEulerAngles = arg_311_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_311_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1084ui_story"].transform.position).z)
				arg_311_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1084ui_story"].transform.localEulerAngles = arg_311_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["1084ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1084ui_story == nil then
				arg_311_1.var_.characterEffect1084ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect1084ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1084ui_story then
				arg_311_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if arg_311_1.frameCnt_ <= 1 then
				arg_311_1.dialog_:SetActive(false)
			end

			local var_314_4 = 0.6
			local var_314_5 = 0.5

			if 0.6 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0

				arg_311_1.dialog_:SetActive(true)

				arg_311_1.dialogCg_.alpha = 0

				local var_314_6 = LeanTween.value(arg_311_1.dialog_, 0, 1, 0.3)

				var_314_6:setOnUpdate(LuaHelper.FloatAction(function(arg_315_0)
					arg_311_1.dialogCg_.alpha = arg_315_0
				end))
				var_314_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_311_1.dialog_)
					var_314_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_311_1.duration_ = arg_311_1.duration_ + 0.3

				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_7 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(319891073).content)

				arg_311_1.text_.text = var_314_7

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_9 = 20 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 20)

				if (20 <= 0 and var_314_5 or var_314_5 * (utf8.len(var_314_7) / 20)) > 0 and var_314_5 < var_314_9 then
					arg_311_1.talkMaxDuration = var_314_9
					var_314_4 = var_314_4 + 0.3

					if var_314_9 + var_314_4 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_9 + var_314_4
					end
				end

				arg_311_1.text_.text = var_314_7
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_10 = var_314_4 + 0.3
			local var_314_11 = math.max(var_314_5, arg_311_1.talkMaxDuration)

			if var_314_4 + 0.3 <= arg_311_1.time_ and arg_311_1.time_ < var_314_10 + var_314_11 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_10) / var_314_11

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_10 + var_314_11 and arg_311_1.time_ < var_314_10 + var_314_11 + arg_314_0 then
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
			local var_320_0 = 1.35

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(319891074).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 54 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 54)

				if (54 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 54)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
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
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1084ui_story = arg_321_1.actors_["1084ui_story"].transform.localPosition

				arg_321_1:ShowWeapon(arg_321_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1084ui_story"].transform.position).z)
				arg_321_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1084ui_story"].transform.localEulerAngles = arg_321_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_321_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1084ui_story"].transform.position).z)
				arg_321_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1084ui_story"].transform.localEulerAngles = arg_321_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["1084ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1084ui_story == nil then
				arg_321_1.var_.characterEffect1084ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect1084ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1084ui_story then
				arg_321_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if arg_321_1.frameCnt_ <= 1 then
				arg_321_1.dialog_:SetActive(false)
			end

			local var_324_4 = 0.9
			local var_324_5 = 0.25

			if 0.9 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0

				arg_321_1.dialog_:SetActive(true)

				arg_321_1.dialogCg_.alpha = 0

				local var_324_6 = LeanTween.value(arg_321_1.dialog_, 0, 1, 0.3)

				var_324_6:setOnUpdate(LuaHelper.FloatAction(function(arg_325_0)
					arg_321_1.dialogCg_.alpha = arg_325_0
				end))
				var_324_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_321_1.dialog_)
					var_324_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_321_1.duration_ = arg_321_1.duration_ + 0.3

				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_7 = arg_321_1:GetWordFromCfg(319891075)
				local var_324_8 = arg_321_1:FormatText(var_324_7.content)

				arg_321_1.text_.text = var_324_8

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_10 = 10 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_8) / 10)

				if (10 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_8) / 10)) > 0 and var_324_5 < var_324_10 then
					arg_321_1.talkMaxDuration = var_324_10
					var_324_4 = var_324_4 + 0.3

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_8
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891075", "story_v_out_319891.awb") ~= 0 then
					local var_324_11 = manager.audio:GetVoiceLength("story_v_out_319891", "319891075", "story_v_out_319891.awb") / 1000

					if var_324_11 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_11 + var_324_4
					end

					if var_324_7.prefab_name ~= "" and arg_321_1.actors_[var_324_7.prefab_name] ~= nil then
						local var_324_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_7.prefab_name].transform, "story_v_out_319891", "319891075", "story_v_out_319891.awb")

						arg_321_1:RecordAudio("319891075", var_324_12)
						arg_321_1:RecordAudio("319891075", var_324_12)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_319891", "319891075", "story_v_out_319891.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_319891", "319891075", "story_v_out_319891.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_13 = var_324_4 + 0.3
			local var_324_14 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 + 0.3 <= arg_321_1.time_ and arg_321_1.time_ < var_324_13 + var_324_14 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_13) / var_324_14

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_13 + var_324_14 and arg_321_1.time_ < var_324_13 + var_324_14 + arg_324_0 then
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
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1084ui_story"]) and arg_327_1.var_.characterEffect1084ui_story == nil then
				arg_327_1.var_.characterEffect1084ui_story = arg_327_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1084ui_story"]) then
				if arg_327_1.var_.characterEffect1084ui_story and not isNil(arg_327_1.actors_["1084ui_story"]) then
					arg_327_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1084ui_story"]) and arg_327_1.var_.characterEffect1084ui_story then
				arg_327_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_330_1 = 0
			local var_330_2 = 1.125

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_3 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(319891076).content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 45 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 45)

				if (45 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 45)) > 0 and var_330_2 < var_330_5 then
					arg_327_1.talkMaxDuration = var_330_5

					if var_330_5 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_6 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_6 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_6

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_6 and arg_327_1.time_ < var_330_1 + var_330_6 + arg_330_0 then
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
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1084ui_story = arg_331_1.actors_["1084ui_story"].transform.localPosition

				arg_331_1:ShowWeapon(arg_331_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_334_0 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 then
				arg_331_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_331_1.time_ - 0) / var_334_0)
				arg_331_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1084ui_story"].transform.position).z)
				arg_331_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1084ui_story"].transform.localEulerAngles = arg_331_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 then
				arg_331_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_331_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_331_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_331_1.actors_["1084ui_story"].transform.position).z)
				arg_331_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_331_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_331_1.actors_["1084ui_story"].transform.localEulerAngles = arg_331_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_334_1 = 0
			local var_334_2 = 1.625

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_3 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(319891077).content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 65 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 65)

				if (65 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 65)) > 0 and var_334_2 < var_334_5 then
					arg_331_1.talkMaxDuration = var_334_5

					if var_334_5 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + var_334_1
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_6 = math.max(var_334_2, arg_331_1.talkMaxDuration)

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_6 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_1) / var_334_6

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_1 + var_334_6 and arg_331_1.time_ < var_334_1 + var_334_6 + arg_334_0 then
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
			local var_338_0 = 0.975

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(319891078).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 39 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 39)

				if (39 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 39)) > 0 and var_338_0 < var_338_3 then
					arg_335_1.talkMaxDuration = var_338_3

					if var_338_3 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_3 + 0
					end
				end

				arg_335_1.text_.text = var_338_1
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_4 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_4

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
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
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1084ui_story = arg_339_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1084ui_story"].transform.position).z)
				arg_339_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1084ui_story"].transform.localEulerAngles = arg_339_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_339_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1084ui_story"].transform.position).z)
				arg_339_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1084ui_story"].transform.localEulerAngles = arg_339_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["1084ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1084ui_story == nil then
				arg_339_1.var_.characterEffect1084ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect1084ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1084ui_story then
				arg_339_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_342_4 = 0
			local var_342_5 = 0.125

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(319891079)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 5 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 5)

				if (5 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 5)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891079", "story_v_out_319891.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_out_319891", "319891079", "story_v_out_319891.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_out_319891", "319891079", "story_v_out_319891.awb")

						arg_339_1:RecordAudio("319891079", var_342_11)
						arg_339_1:RecordAudio("319891079", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_319891", "319891079", "story_v_out_319891.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_319891", "319891079", "story_v_out_319891.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_12 and arg_339_1.time_ < var_342_4 + var_342_12 + arg_342_0 then
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
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1084ui_story"]) and arg_343_1.var_.characterEffect1084ui_story == nil then
				arg_343_1.var_.characterEffect1084ui_story = arg_343_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_0 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1084ui_story"]) then
				if arg_343_1.var_.characterEffect1084ui_story and not isNil(arg_343_1.actors_["1084ui_story"]) then
					arg_343_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_343_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_343_1.time_ - 0) / var_346_0)
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1084ui_story"]) and arg_343_1.var_.characterEffect1084ui_story then
				arg_343_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_343_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_346_1 = 0
			local var_346_2 = 0.85

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(319891080).content)

				arg_343_1.text_.text = var_346_3

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 34 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 34)

				if (34 <= 0 and var_346_2 or var_346_2 * (utf8.len(var_346_3) / 34)) > 0 and var_346_2 < var_346_5 then
					arg_343_1.talkMaxDuration = var_346_5

					if var_346_5 + var_346_1 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + var_346_1
					end
				end

				arg_343_1.text_.text = var_346_3
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_6 = math.max(var_346_2, arg_343_1.talkMaxDuration)

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_6 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_1) / var_346_6

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_1 + var_346_6 and arg_343_1.time_ < var_346_1 + var_346_6 + arg_346_0 then
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
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos1084ui_story = arg_347_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_350_0 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 then
				arg_347_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_347_1.time_ - 0) / var_350_0)
				arg_347_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1084ui_story"].transform.position).z)
				arg_347_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["1084ui_story"].transform.localEulerAngles = arg_347_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 then
				arg_347_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_347_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1084ui_story"].transform.position).z)
				arg_347_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["1084ui_story"].transform.localEulerAngles = arg_347_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_350_1 = 0
			local var_350_2 = 1.175

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_3 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(319891081).content)

				arg_347_1.text_.text = var_350_3

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 47 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 47)

				if (47 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 47)) > 0 and var_350_2 < var_350_5 then
					arg_347_1.talkMaxDuration = var_350_5

					if var_350_5 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + var_350_1
					end
				end

				arg_347_1.text_.text = var_350_3
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_6 = math.max(var_350_2, arg_347_1.talkMaxDuration)

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_6 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_1) / var_350_6

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_1 + var_350_6 and arg_347_1.time_ < var_350_1 + var_350_6 + arg_350_0 then
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
			local var_354_9000

			if 1.06666666368643 < arg_351_1.time_ and arg_351_1.time_ <= 1.06666666368643 + arg_354_0 then
				arg_351_1.var_.moveOldPos1084ui_story = arg_351_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_354_0 = 0.001

			if 1.06666666368643 <= arg_351_1.time_ and arg_351_1.time_ < 1.06666666368643 + var_354_0 then
				arg_351_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_351_1.time_ - 1.06666666368643) / var_354_0)
				arg_351_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1084ui_story"].transform.position).z)
				arg_351_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1084ui_story"].transform.localEulerAngles = arg_351_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_351_1.time_ >= 1.06666666368643 + var_354_0 and arg_351_1.time_ < 1.06666666368643 + var_354_0 + arg_354_0 then
				arg_351_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_351_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["1084ui_story"].transform.position).z)
				arg_351_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["1084ui_story"].transform.localEulerAngles = arg_351_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_354_1 = arg_351_1.actors_["1084ui_story"]

			if 1.06666666368643 < arg_351_1.time_ and arg_351_1.time_ <= 1.06666666368643 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1084ui_story == nil then
				arg_351_1.var_.characterEffect1084ui_story = var_354_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if 1.06666666368643 <= arg_351_1.time_ and arg_351_1.time_ < 1.06666666368643 + var_354_2 and not isNil(var_354_1) then
				if arg_351_1.var_.characterEffect1084ui_story and not isNil(var_354_1) then
					arg_351_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 1.06666666368643 + var_354_2 and arg_351_1.time_ < 1.06666666368643 + var_354_2 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect1084ui_story then
				arg_351_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				local var_354_4 = arg_351_1.var_.effect1616

				if not arg_351_1.var_.effect1616 then
					var_354_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_354_4.name = "1616"
					arg_351_1.var_.effect1616 = var_354_4
				else
					var_354_4.transform:SetParent(var_354_9000)
				end

				var_354_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_354_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.06666666368643 < arg_351_1.time_ and arg_351_1.time_ <= 1.06666666368643 + arg_354_0 then
				arg_351_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if arg_351_1.frameCnt_ <= 1 then
				arg_351_1.dialog_:SetActive(false)
			end

			local var_354_6 = 1.26666666666667
			local var_354_7 = 0.2

			if 1.26666666666667 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0

				arg_351_1.dialog_:SetActive(true)

				arg_351_1.dialogCg_.alpha = 0

				local var_354_8 = LeanTween.value(arg_351_1.dialog_, 0, 1, 0.3)

				var_354_8:setOnUpdate(LuaHelper.FloatAction(function(arg_355_0)
					arg_351_1.dialogCg_.alpha = arg_355_0
				end))
				var_354_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_351_1.dialog_)
					var_354_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_351_1.duration_ = arg_351_1.duration_ + 0.3

				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_9 = arg_351_1:GetWordFromCfg(319891082)
				local var_354_10 = arg_351_1:FormatText(var_354_9.content)

				arg_351_1.text_.text = var_354_10

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_12 = 8 <= 0 and var_354_7 or var_354_7 * (utf8.len(var_354_10) / 8)

				if (8 <= 0 and var_354_7 or var_354_7 * (utf8.len(var_354_10) / 8)) > 0 and var_354_7 < var_354_12 then
					arg_351_1.talkMaxDuration = var_354_12
					var_354_6 = var_354_6 + 0.3

					if var_354_12 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_12 + var_354_6
					end
				end

				arg_351_1.text_.text = var_354_10
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891082", "story_v_out_319891.awb") ~= 0 then
					local var_354_13 = manager.audio:GetVoiceLength("story_v_out_319891", "319891082", "story_v_out_319891.awb") / 1000

					if var_354_13 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_13 + var_354_6
					end

					if var_354_9.prefab_name ~= "" and arg_351_1.actors_[var_354_9.prefab_name] ~= nil then
						local var_354_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_9.prefab_name].transform, "story_v_out_319891", "319891082", "story_v_out_319891.awb")

						arg_351_1:RecordAudio("319891082", var_354_14)
						arg_351_1:RecordAudio("319891082", var_354_14)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_319891", "319891082", "story_v_out_319891.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_319891", "319891082", "story_v_out_319891.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_15 = var_354_6 + 0.3
			local var_354_16 = math.max(var_354_7, arg_351_1.talkMaxDuration)

			if var_354_6 + 0.3 <= arg_351_1.time_ and arg_351_1.time_ < var_354_15 + var_354_16 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_15) / var_354_16

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_15 + var_354_16 and arg_351_1.time_ < var_354_15 + var_354_16 + arg_354_0 then
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
			local var_360_0 = 0.175

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_1 = arg_357_1:GetWordFromCfg(319891083)
				local var_360_2 = arg_357_1:FormatText(var_360_1.content)

				arg_357_1.text_.text = var_360_2

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 7 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 7)

				if (7 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 7)) > 0 and var_360_0 < var_360_4 then
					arg_357_1.talkMaxDuration = var_360_4

					if var_360_4 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_4 + 0
					end
				end

				arg_357_1.text_.text = var_360_2
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891083", "story_v_out_319891.awb") ~= 0 then
					local var_360_5 = manager.audio:GetVoiceLength("story_v_out_319891", "319891083", "story_v_out_319891.awb") / 1000

					if var_360_5 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + 0
					end

					if var_360_1.prefab_name ~= "" and arg_357_1.actors_[var_360_1.prefab_name] ~= nil then
						local var_360_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_1.prefab_name].transform, "story_v_out_319891", "319891083", "story_v_out_319891.awb")

						arg_357_1:RecordAudio("319891083", var_360_6)
						arg_357_1:RecordAudio("319891083", var_360_6)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_319891", "319891083", "story_v_out_319891.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_319891", "319891083", "story_v_out_319891.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_7 and arg_357_1.time_ < 0 + var_360_7 + arg_360_0 then
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
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				if arg_361_1.var_.effect1616 then
					Object.Destroy(arg_361_1.var_.effect1616)

					arg_361_1.var_.effect1616 = nil
				end
			end

			local var_364_1 = 0

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.mask_.enabled = true
				arg_361_1.mask_.raycastTarget = false

				arg_361_1:SetGaussion(false)
			end

			local var_364_2 = 0.633333333333333

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_2 then
				local var_364_3 = Color.New(0.7169812, 0.01690993, 0.01690993)

				var_364_3.a = Mathf.Lerp(1, 0, (arg_361_1.time_ - var_364_1) / var_364_2)
				arg_361_1.mask_.color = var_364_3
			end

			if arg_361_1.time_ >= var_364_1 + var_364_2 and arg_361_1.time_ < var_364_1 + var_364_2 + arg_364_0 then
				local var_364_4 = Color.New(0.7169812, 0.01690993, 0.01690993)

				arg_361_1.mask_.enabled = false
				var_364_4.a = 0
				arg_361_1.mask_.color = var_364_4
			end

			local var_364_5 = arg_361_1.actors_["1084ui_story"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_5) and arg_361_1.var_.characterEffect1084ui_story == nil then
				arg_361_1.var_.characterEffect1084ui_story = var_364_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_6 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_6 and not isNil(var_364_5) then
				if arg_361_1.var_.characterEffect1084ui_story and not isNil(var_364_5) then
					arg_361_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_361_1.time_ >= 0 + var_364_6 and arg_361_1.time_ < 0 + var_364_6 + arg_364_0 and not isNil(var_364_5) and arg_361_1.var_.characterEffect1084ui_story then
				arg_361_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:AudioAction("play", "effect", "se_story_123_02", "se_story_123_02_fire", "")
			end

			local var_364_9 = arg_361_1.actors_["1084ui_story"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos1084ui_story = var_364_9.localPosition
			end

			local var_364_10 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_10 then
				var_364_9.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_361_1.time_ - 0) / var_364_10)
				var_364_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_9.position).x, (manager.ui.mainCamera.transform.position - var_364_9.position).y, (manager.ui.mainCamera.transform.position - var_364_9.position).z)
				var_364_9.localEulerAngles.z = 0
				var_364_9.localEulerAngles.x = 0
				var_364_9.localEulerAngles = var_364_9.localEulerAngles
			end

			if arg_361_1.time_ >= 0 + var_364_10 and arg_361_1.time_ < 0 + var_364_10 + arg_364_0 then
				var_364_9.localPosition = Vector3.New(0, 100, 0)
				var_364_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_364_9.position).x, (manager.ui.mainCamera.transform.position - var_364_9.position).y, (manager.ui.mainCamera.transform.position - var_364_9.position).z)
				var_364_9.localEulerAngles.z = 0
				var_364_9.localEulerAngles.x = 0
				var_364_9.localEulerAngles = var_364_9.localEulerAngles
			end

			if arg_361_1.frameCnt_ <= 1 then
				arg_361_1.dialog_:SetActive(false)
			end

			local var_364_11 = 0.9
			local var_364_12 = 1.475

			if 0.9 < arg_361_1.time_ and arg_361_1.time_ <= var_364_11 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0

				arg_361_1.dialog_:SetActive(true)

				arg_361_1.dialogCg_.alpha = 0

				local var_364_13 = LeanTween.value(arg_361_1.dialog_, 0, 1, 0.3)

				var_364_13:setOnUpdate(LuaHelper.FloatAction(function(arg_365_0)
					arg_361_1.dialogCg_.alpha = arg_365_0
				end))
				var_364_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_361_1.dialog_)
					var_364_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_361_1.duration_ = arg_361_1.duration_ + 0.3

				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_14 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(319891084).content)

				arg_361_1.text_.text = var_364_14

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_16 = 59 <= 0 and var_364_12 or var_364_12 * (utf8.len(var_364_14) / 59)

				if (59 <= 0 and var_364_12 or var_364_12 * (utf8.len(var_364_14) / 59)) > 0 and var_364_12 < var_364_16 then
					arg_361_1.talkMaxDuration = var_364_16
					var_364_11 = var_364_11 + 0.3

					if var_364_16 + var_364_11 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_16 + var_364_11
					end
				end

				arg_361_1.text_.text = var_364_14
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_17 = var_364_11 + 0.3
			local var_364_18 = math.max(var_364_12, arg_361_1.talkMaxDuration)

			if var_364_11 + 0.3 <= arg_361_1.time_ and arg_361_1.time_ < var_364_17 + var_364_18 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_17) / var_364_18

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_17 + var_364_18 and arg_361_1.time_ < var_364_17 + var_364_18 + arg_364_0 then
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
			local var_370_0 = 1.025

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(319891085).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 41 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 41)

				if (41 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 41)) > 0 and var_370_0 < var_370_3 then
					arg_367_1.talkMaxDuration = var_370_3

					if var_370_3 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_3 + 0
					end
				end

				arg_367_1.text_.text = var_370_1
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_4 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_4

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
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
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos1084ui_story = arg_371_1.actors_["1084ui_story"].transform.localPosition

				arg_371_1:ShowWeapon(arg_371_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_374_0 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 then
				arg_371_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_371_1.time_ - 0) / var_374_0)
				arg_371_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1084ui_story"].transform.position).z)
				arg_371_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1084ui_story"].transform.localEulerAngles = arg_371_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 then
				arg_371_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_371_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_371_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_371_1.actors_["1084ui_story"].transform.position).z)
				arg_371_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_371_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_371_1.actors_["1084ui_story"].transform.localEulerAngles = arg_371_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_374_1 = arg_371_1.actors_["1084ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1084ui_story == nil then
				arg_371_1.var_.characterEffect1084ui_story = var_374_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_2 and not isNil(var_374_1) then
				if arg_371_1.var_.characterEffect1084ui_story and not isNil(var_374_1) then
					arg_371_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_2 and arg_371_1.time_ < 0 + var_374_2 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect1084ui_story then
				arg_371_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_374_4 = 0
			local var_374_5 = 0.075

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_6 = arg_371_1:GetWordFromCfg(319891086)
				local var_374_7 = arg_371_1:FormatText(var_374_6.content)

				arg_371_1.text_.text = var_374_7

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_9 = 3 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 3)

				if (3 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 3)) > 0 and var_374_5 < var_374_9 then
					arg_371_1.talkMaxDuration = var_374_9

					if var_374_9 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_9 + var_374_4
					end
				end

				arg_371_1.text_.text = var_374_7
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891086", "story_v_out_319891.awb") ~= 0 then
					local var_374_10 = manager.audio:GetVoiceLength("story_v_out_319891", "319891086", "story_v_out_319891.awb") / 1000

					if var_374_10 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_10 + var_374_4
					end

					if var_374_6.prefab_name ~= "" and arg_371_1.actors_[var_374_6.prefab_name] ~= nil then
						local var_374_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_6.prefab_name].transform, "story_v_out_319891", "319891086", "story_v_out_319891.awb")

						arg_371_1:RecordAudio("319891086", var_374_11)
						arg_371_1:RecordAudio("319891086", var_374_11)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_319891", "319891086", "story_v_out_319891.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_319891", "319891086", "story_v_out_319891.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_12 = math.max(var_374_5, arg_371_1.talkMaxDuration)

			if var_374_4 <= arg_371_1.time_ and arg_371_1.time_ < var_374_4 + var_374_12 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_4) / var_374_12

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_4 + var_374_12 and arg_371_1.time_ < var_374_4 + var_374_12 + arg_374_0 then
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
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1084ui_story = arg_375_1.actors_["1084ui_story"].transform.localPosition

				arg_375_1:ShowWeapon(arg_375_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_375_1.time_ - 0) / var_378_0)
				arg_375_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1084ui_story"].transform.position).z)
				arg_375_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1084ui_story"].transform.localEulerAngles = arg_375_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_375_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_375_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_375_1.actors_["1084ui_story"].transform.position).z)
				arg_375_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_375_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_375_1.actors_["1084ui_story"].transform.localEulerAngles = arg_375_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_378_1 = 0
			local var_378_2 = 1.175

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_3 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(319891087).content)

				arg_375_1.text_.text = var_378_3

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_5 = 47 <= 0 and var_378_2 or var_378_2 * (utf8.len(var_378_3) / 47)

				if (47 <= 0 and var_378_2 or var_378_2 * (utf8.len(var_378_3) / 47)) > 0 and var_378_2 < var_378_5 then
					arg_375_1.talkMaxDuration = var_378_5

					if var_378_5 + var_378_1 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + var_378_1
					end
				end

				arg_375_1.text_.text = var_378_3
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_6 = math.max(var_378_2, arg_375_1.talkMaxDuration)

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_6 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_1) / var_378_6

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_1 + var_378_6 and arg_375_1.time_ < var_378_1 + var_378_6 + arg_378_0 then
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
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_explosion", "")
			end

			local var_382_1 = manager.ui.mainCamera.transform

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.shakeOldPos = var_382_1.localPosition
			end

			local var_382_2 = 0.766666666666667

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_2 then
				local var_382_3, var_382_4 = math.modf((arg_379_1.time_ - 0) / 0.066)

				var_382_1.localPosition = Vector3.New(var_382_4 * 0.13, var_382_4 * 0.13, var_382_4 * 0.13) + arg_379_1.var_.shakeOldPos
			end

			if arg_379_1.time_ >= 0 + var_382_2 and arg_379_1.time_ < 0 + var_382_2 + arg_382_0 then
				var_382_1.localPosition = arg_379_1.var_.shakeOldPos
			end

			if arg_379_1.frameCnt_ <= 1 then
				arg_379_1.dialog_:SetActive(false)
			end

			local var_382_5 = 0.866666666666667
			local var_382_6 = 1.45

			if 0.866666666666667 < arg_379_1.time_ and arg_379_1.time_ <= var_382_5 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0

				arg_379_1.dialog_:SetActive(true)

				arg_379_1.dialogCg_.alpha = 0

				local var_382_7 = LeanTween.value(arg_379_1.dialog_, 0, 1, 0.3)

				var_382_7:setOnUpdate(LuaHelper.FloatAction(function(arg_383_0)
					arg_379_1.dialogCg_.alpha = arg_383_0
				end))
				var_382_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_379_1.dialog_)
					var_382_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_379_1.duration_ = arg_379_1.duration_ + 0.3

				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_8 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(319891088).content)

				arg_379_1.text_.text = var_382_8

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_10 = 58 <= 0 and var_382_6 or var_382_6 * (utf8.len(var_382_8) / 58)

				if (58 <= 0 and var_382_6 or var_382_6 * (utf8.len(var_382_8) / 58)) > 0 and var_382_6 < var_382_10 then
					arg_379_1.talkMaxDuration = var_382_10
					var_382_5 = var_382_5 + 0.3

					if var_382_10 + var_382_5 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_10 + var_382_5
					end
				end

				arg_379_1.text_.text = var_382_8
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_11 = var_382_5 + 0.3
			local var_382_12 = math.max(var_382_6, arg_379_1.talkMaxDuration)

			if var_382_5 + 0.3 <= arg_379_1.time_ and arg_379_1.time_ < var_382_11 + var_382_12 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_11) / var_382_12

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_11 + var_382_12 and arg_379_1.time_ < var_382_11 + var_382_12 + arg_382_0 then
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
			local var_388_9000

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_noise", "")
			end

			local var_388_1 = manager.ui.mainCamera.transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.shakeOldPos = var_388_1.localPosition
			end

			local var_388_2 = 0.766666666666667

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_2 then
				local var_388_3, var_388_4 = math.modf((arg_385_1.time_ - 0) / 0.066)

				var_388_1.localPosition = Vector3.New(var_388_4 * 0.13, var_388_4 * 0.13, var_388_4 * 0.13) + arg_385_1.var_.shakeOldPos
			end

			if arg_385_1.time_ >= 0 + var_388_2 and arg_385_1.time_ < 0 + var_388_2 + arg_388_0 then
				var_388_1.localPosition = arg_385_1.var_.shakeOldPos
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				local var_388_5 = arg_385_1.var_.effect1617

				if not arg_385_1.var_.effect1617 then
					var_388_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_388_5.name = "1617"
					arg_385_1.var_.effect1617 = var_388_5
				else
					var_388_5.transform:SetParent(var_388_9000)
				end

				var_388_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_388_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_388_7 = 0
			local var_388_8 = 1.325

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_7 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_9 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(319891089).content)

				arg_385_1.text_.text = var_388_9

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_11 = 53 <= 0 and var_388_8 or var_388_8 * (utf8.len(var_388_9) / 53)

				if (53 <= 0 and var_388_8 or var_388_8 * (utf8.len(var_388_9) / 53)) > 0 and var_388_8 < var_388_11 then
					arg_385_1.talkMaxDuration = var_388_11

					if var_388_11 + var_388_7 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_11 + var_388_7
					end
				end

				arg_385_1.text_.text = var_388_9
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_12 = math.max(var_388_8, arg_385_1.talkMaxDuration)

			if var_388_7 <= arg_385_1.time_ and arg_385_1.time_ < var_388_7 + var_388_12 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_7) / var_388_12

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_7 + var_388_12 and arg_385_1.time_ < var_388_7 + var_388_12 + arg_388_0 then
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
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1084ui_story = arg_389_1.actors_["1084ui_story"].transform.localPosition

				arg_389_1:ShowWeapon(arg_389_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_392_0 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 then
				arg_389_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_389_1.time_ - 0) / var_392_0)
				arg_389_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1084ui_story"].transform.position).z)
				arg_389_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1084ui_story"].transform.localEulerAngles = arg_389_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 then
				arg_389_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_389_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1084ui_story"].transform.position).z)
				arg_389_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1084ui_story"].transform.localEulerAngles = arg_389_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_392_1 = arg_389_1.actors_["1084ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1084ui_story == nil then
				arg_389_1.var_.characterEffect1084ui_story = var_392_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_2 and not isNil(var_392_1) then
				if arg_389_1.var_.characterEffect1084ui_story and not isNil(var_392_1) then
					arg_389_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_2 and arg_389_1.time_ < 0 + var_392_2 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1084ui_story then
				arg_389_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				if arg_389_1.var_.effect1617 then
					Object.Destroy(arg_389_1.var_.effect1617)

					arg_389_1.var_.effect1617 = nil
				end
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_2")
			end

			local var_392_5 = 0
			local var_392_6 = 0.1

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_5 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_7 = arg_389_1:GetWordFromCfg(319891090)
				local var_392_8 = arg_389_1:FormatText(var_392_7.content)

				arg_389_1.text_.text = var_392_8

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_10 = 4 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_8) / 4)

				if (4 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_8) / 4)) > 0 and var_392_6 < var_392_10 then
					arg_389_1.talkMaxDuration = var_392_10

					if var_392_10 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_10 + var_392_5
					end
				end

				arg_389_1.text_.text = var_392_8
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319891", "319891090", "story_v_out_319891.awb") ~= 0 then
					local var_392_11 = manager.audio:GetVoiceLength("story_v_out_319891", "319891090", "story_v_out_319891.awb") / 1000

					if var_392_11 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_11 + var_392_5
					end

					if var_392_7.prefab_name ~= "" and arg_389_1.actors_[var_392_7.prefab_name] ~= nil then
						local var_392_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_7.prefab_name].transform, "story_v_out_319891", "319891090", "story_v_out_319891.awb")

						arg_389_1:RecordAudio("319891090", var_392_12)
						arg_389_1:RecordAudio("319891090", var_392_12)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_319891", "319891090", "story_v_out_319891.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_319891", "319891090", "story_v_out_319891.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_13 = math.max(var_392_6, arg_389_1.talkMaxDuration)

			if var_392_5 <= arg_389_1.time_ and arg_389_1.time_ < var_392_5 + var_392_13 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_5) / var_392_13

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_5 + var_392_13 and arg_389_1.time_ < var_392_5 + var_392_13 + arg_392_0 then
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
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				local var_396_0 = arg_393_1.bgs_.STblack

				arg_393_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_396_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_396_1 = var_396_0:GetComponent("SpriteRenderer")

				if var_396_1 and var_396_1.sprite then
					local var_396_2 = 2 * (var_396_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_396_0.transform.localScale = Vector3.New(var_396_2 / var_396_1.sprite.bounds.size.y < var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x and var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x or var_396_2 / var_396_1.sprite.bounds.size.y, var_396_2 / var_396_1.sprite.bounds.size.y < var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x and var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x or var_396_2 / var_396_1.sprite.bounds.size.y, 0)
				end

				for iter_396_0, iter_396_1 in pairs(arg_393_1.bgs_) do
					if iter_396_0 ~= "STblack" then
						iter_396_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_396_3 = 0

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_3 + arg_396_0 then
				arg_393_1.allBtn_.enabled = false
			end

			if arg_393_1.time_ >= var_396_3 + 0.3 and arg_393_1.time_ < var_396_3 + 0.3 + arg_396_0 then
				arg_393_1.allBtn_.enabled = true
			end

			local var_396_4 = 0

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_4 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_5 = 2

			if var_396_4 <= arg_393_1.time_ and arg_393_1.time_ < var_396_4 + var_396_5 then
				local var_396_6 = Color.New(0, 0, 0)

				var_396_6.a = Mathf.Lerp(1, 0, (arg_393_1.time_ - var_396_4) / var_396_5)
				arg_393_1.mask_.color = var_396_6
			end

			if arg_393_1.time_ >= var_396_4 + var_396_5 and arg_393_1.time_ < var_396_4 + var_396_5 + arg_396_0 then
				local var_396_7 = Color.New(0, 0, 0)

				arg_393_1.mask_.enabled = false
				var_396_7.a = 0
				arg_393_1.mask_.color = var_396_7
			end

			local var_396_8 = arg_393_1.actors_["1084ui_story"].transform

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos1084ui_story = var_396_8.localPosition
			end

			local var_396_9 = 0.001

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_9 then
				var_396_8.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_393_1.time_ - 0) / var_396_9)
				var_396_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_396_8.position).x, (manager.ui.mainCamera.transform.position - var_396_8.position).y, (manager.ui.mainCamera.transform.position - var_396_8.position).z)
				var_396_8.localEulerAngles.z = 0
				var_396_8.localEulerAngles.x = 0
				var_396_8.localEulerAngles = var_396_8.localEulerAngles
			end

			if arg_393_1.time_ >= 0 + var_396_9 and arg_393_1.time_ < 0 + var_396_9 + arg_396_0 then
				var_396_8.localPosition = Vector3.New(0, 100, 0)
				var_396_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_396_8.position).x, (manager.ui.mainCamera.transform.position - var_396_8.position).y, (manager.ui.mainCamera.transform.position - var_396_8.position).z)
				var_396_8.localEulerAngles.z = 0
				var_396_8.localEulerAngles.x = 0
				var_396_8.localEulerAngles = var_396_8.localEulerAngles
			end

			local var_396_10 = arg_393_1.actors_["1084ui_story"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_10) and arg_393_1.var_.characterEffect1084ui_story == nil then
				arg_393_1.var_.characterEffect1084ui_story = var_396_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_11 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_11 and not isNil(var_396_10) then
				if arg_393_1.var_.characterEffect1084ui_story and not isNil(var_396_10) then
					arg_393_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_11)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_11 and arg_393_1.time_ < 0 + var_396_11 + arg_396_0 and not isNil(var_396_10) and arg_393_1.var_.characterEffect1084ui_story then
				arg_393_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if arg_393_1.frameCnt_ <= 1 then
				arg_393_1.dialog_:SetActive(false)
			end

			local var_396_12 = 1.46666666666667
			local var_396_13 = 1.225

			if 1.46666666666667 < arg_393_1.time_ and arg_393_1.time_ <= var_396_12 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				arg_393_1.dialog_:SetActive(true)

				arg_393_1.dialogCg_.alpha = 0

				local var_396_14 = LeanTween.value(arg_393_1.dialog_, 0, 1, 0.3)

				var_396_14:setOnUpdate(LuaHelper.FloatAction(function(arg_397_0)
					arg_393_1.dialogCg_.alpha = arg_397_0
				end))
				var_396_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_393_1.dialog_)
					var_396_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_393_1.duration_ = arg_393_1.duration_ + 0.3

				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_15 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(319891091).content)

				arg_393_1.text_.text = var_396_15

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_17 = 49 <= 0 and var_396_13 or var_396_13 * (utf8.len(var_396_15) / 49)

				if (49 <= 0 and var_396_13 or var_396_13 * (utf8.len(var_396_15) / 49)) > 0 and var_396_13 < var_396_17 then
					arg_393_1.talkMaxDuration = var_396_17
					var_396_12 = var_396_12 + 0.3

					if var_396_17 + var_396_12 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_17 + var_396_12
					end
				end

				arg_393_1.text_.text = var_396_15
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_18 = var_396_12 + 0.3
			local var_396_19 = math.max(var_396_13, arg_393_1.talkMaxDuration)

			if var_396_12 + 0.3 <= arg_393_1.time_ and arg_393_1.time_ < var_396_18 + var_396_19 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_18) / var_396_19

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_18 + var_396_19 and arg_393_1.time_ < var_396_18 + var_396_19 + arg_396_0 then
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
			local var_402_0 = 1.15

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_1 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(319891092).content)

				arg_399_1.text_.text = var_402_1

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_3 = 46 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 46)

				if (46 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_1) / 46)) > 0 and var_402_0 < var_402_3 then
					arg_399_1.talkMaxDuration = var_402_3

					if var_402_3 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_3 + 0
					end
				end

				arg_399_1.text_.text = var_402_1
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_4 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_4 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_4

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_4 and arg_399_1.time_ < 0 + var_402_4 + arg_402_0 then
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
