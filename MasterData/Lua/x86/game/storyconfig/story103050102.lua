return {
	Play305012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 305012001
		arg_1_1.duration_ = 6.67

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play305012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.S0408 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0408")
				var_4_0.name = "S0408"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.S0408 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.S0408

				arg_1_1.bgs_.S0408.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0408" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 1.83333333333333

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0.990566, 0.990566, 0.990566)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0.990566, 0.990566, 0.990566)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 1.674999999999
			local var_4_15 = 0.325

			if 1.674999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(305012001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 13 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 13)

				if (13 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 13)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play305012002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 305012002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play305012003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 1 < arg_8_1.time_ and arg_8_1.time_ <= 1 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun05", "")
			end

			local var_11_1 = 0
			local var_11_2 = 1.375

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(305012002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 55 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 55)

				if (55 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 55)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play305012003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 305012003
		arg_12_1.duration_ = 4.36

		local var_12_0 = {
			zh = 4.358,
			ja = 4.291
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play305012004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_9001
			local var_15_9000

			if arg_12_1.bgs_.S0408a == nil then
				local var_15_0 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0408a")
				var_15_0.name = "S0408a"
				var_15_0.transform.parent = arg_12_1.stage_.transform
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_.S0408a = var_15_0
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				local var_15_1 = arg_12_1.bgs_.S0408a

				arg_12_1.bgs_.S0408a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_15_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_2 = var_15_1:GetComponent("SpriteRenderer")

				if var_15_2 and var_15_2.sprite then
					local var_15_3 = 2 * (var_15_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_15_1.transform.localScale = Vector3.New(var_15_3 / var_15_2.sprite.bounds.size.y < var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x and var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x or var_15_3 / var_15_2.sprite.bounds.size.y, var_15_3 / var_15_2.sprite.bounds.size.y < var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x and var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x or var_15_3 / var_15_2.sprite.bounds.size.y, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "S0408a" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_4 = 0

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			if arg_12_1.time_ >= var_15_4 + 0.3 and arg_12_1.time_ < var_15_4 + 0.3 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_5 = 0

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_6 = 1

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 then
				local var_15_7 = Color.New(0, 0, 0)

				var_15_7.a = Mathf.Lerp(1, 0, (arg_12_1.time_ - var_15_5) / var_15_6)
				arg_12_1.mask_.color = var_15_7
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 then
				local var_15_8 = Color.New(0, 0, 0)

				arg_12_1.mask_.enabled = false
				var_15_8.a = 0
				arg_12_1.mask_.color = var_15_8
			end

			local var_15_9 = arg_12_1.actors_["2069ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect2069ui_story == nil then
				arg_12_1.var_.characterEffect2069ui_story = var_15_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_10 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_10 and not isNil(var_15_9) then
				if arg_12_1.var_.characterEffect2069ui_story and not isNil(var_15_9) then
					arg_12_1.var_.characterEffect2069ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_10 and arg_12_1.time_ < 0 + var_15_10 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect2069ui_story then
				arg_12_1.var_.characterEffect2069ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				local var_15_12 = arg_12_1.var_.effectQWE

				if not arg_12_1.var_.effectQWE then
					var_15_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_15_12.name = "QWE"
					arg_12_1.var_.effectQWE = var_15_12
				else
					var_15_12.transform:SetParent(var_15_9001)
				end

				var_15_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_15_12.transform.localScale = Vector3.New(var_15_12.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_15_12.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_15_12.transform.localScale.z)
			end

			if 1.75 < arg_12_1.time_ and arg_12_1.time_ <= 1.75 + arg_15_0 then
				if arg_12_1.var_.effectQWE then
					Object.Destroy(arg_12_1.var_.effectQWE)

					arg_12_1.var_.effectQWE = nil
				end
			end

			if 0.633333333333333 < arg_12_1.time_ and arg_12_1.time_ <= 0.633333333333333 + arg_15_0 then
				local var_15_15 = arg_12_1.var_.effectQWE1

				if not arg_12_1.var_.effectQWE1 then
					var_15_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_15_15.name = "QWE1"
					arg_12_1.var_.effectQWE1 = var_15_15
				else
					var_15_15.transform:SetParent(var_15_9000)
				end

				var_15_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_15_15.transform.localScale = Vector3.New(var_15_15.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_15_15.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_15_15.transform.localScale.z)
			end

			if 2.38333333333333 < arg_12_1.time_ and arg_12_1.time_ <= 2.38333333333333 + arg_15_0 then
				if arg_12_1.var_.effectQWE1 then
					Object.Destroy(arg_12_1.var_.effectQWE1)

					arg_12_1.var_.effectQWE1 = nil
				end
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_18 = 0.825
			local var_15_19 = 0.175

			if 0.825 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_20 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_20:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[60].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_21 = arg_12_1:GetWordFromCfg(305012003)
				local var_15_22 = arg_12_1:FormatText(var_15_21.content)

				arg_12_1.text_.text = var_15_22

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_24 = 7 <= 0 and var_15_19 or var_15_19 * (utf8.len(var_15_22) / 7)

				if (7 <= 0 and var_15_19 or var_15_19 * (utf8.len(var_15_22) / 7)) > 0 and var_15_19 < var_15_24 then
					arg_12_1.talkMaxDuration = var_15_24
					var_15_18 = var_15_18 + 0.3

					if var_15_24 + var_15_18 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_24 + var_15_18
					end
				end

				arg_12_1.text_.text = var_15_22
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012003", "story_v_out_305012.awb") ~= 0 then
					local var_15_25 = manager.audio:GetVoiceLength("story_v_out_305012", "305012003", "story_v_out_305012.awb") / 1000

					if var_15_25 + var_15_18 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_25 + var_15_18
					end

					if var_15_21.prefab_name ~= "" and arg_12_1.actors_[var_15_21.prefab_name] ~= nil then
						local var_15_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_21.prefab_name].transform, "story_v_out_305012", "305012003", "story_v_out_305012.awb")

						arg_12_1:RecordAudio("305012003", var_15_26)
						arg_12_1:RecordAudio("305012003", var_15_26)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_305012", "305012003", "story_v_out_305012.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_305012", "305012003", "story_v_out_305012.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_27 = var_15_18 + 0.3
			local var_15_28 = math.max(var_15_19, arg_12_1.talkMaxDuration)

			if var_15_18 + 0.3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_27 + var_15_28 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_27) / var_15_28

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_27 + var_15_28 and arg_12_1.time_ < var_15_27 + var_15_28 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play305012004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 305012004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play305012005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(arg_18_1.actors_["2069ui_story"]) and arg_18_1.var_.characterEffect2069ui_story == nil then
				arg_18_1.var_.characterEffect2069ui_story = arg_18_1.actors_["2069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_0 = 0.200000002980232

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 and not isNil(arg_18_1.actors_["2069ui_story"]) then
				if arg_18_1.var_.characterEffect2069ui_story and not isNil(arg_18_1.actors_["2069ui_story"]) then
					arg_18_1.var_.characterEffect2069ui_story.fillFlat = true
					arg_18_1.var_.characterEffect2069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_18_1.time_ - 0) / var_21_0)
				end
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 and not isNil(arg_18_1.actors_["2069ui_story"]) and arg_18_1.var_.characterEffect2069ui_story then
				arg_18_1.var_.characterEffect2069ui_story.fillFlat = true
				arg_18_1.var_.characterEffect2069ui_story.fillRatio = 0.5
			end

			local var_21_1 = 0
			local var_21_2 = 1.4

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_3 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(305012004).content)

				arg_18_1.text_.text = var_21_3

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 56 <= 0 and var_21_2 or var_21_2 * (utf8.len(var_21_3) / 56)

				if (56 <= 0 and var_21_2 or var_21_2 * (utf8.len(var_21_3) / 56)) > 0 and var_21_2 < var_21_5 then
					arg_18_1.talkMaxDuration = var_21_5

					if var_21_5 + var_21_1 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + var_21_1
					end
				end

				arg_18_1.text_.text = var_21_3
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_6 = math.max(var_21_2, arg_18_1.talkMaxDuration)

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_6 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_1) / var_21_6

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_1 + var_21_6 and arg_18_1.time_ < var_21_1 + var_21_6 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play305012005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 305012005
		arg_22_1.duration_ = 7.24

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play305012006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if arg_22_1.bgs_.B13a == nil then
				local var_25_0 = Object.Instantiate(arg_22_1.paintGo_)

				var_25_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13a")
				var_25_0.name = "B13a"
				var_25_0.transform.parent = arg_22_1.stage_.transform
				var_25_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_.B13a = var_25_0
			end

			if 1 < arg_22_1.time_ and arg_22_1.time_ <= 1 + arg_25_0 then
				local var_25_1 = arg_22_1.bgs_.B13a

				arg_22_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_25_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_2 = var_25_1:GetComponent("SpriteRenderer")

				if var_25_2 and var_25_2.sprite then
					local var_25_3 = 2 * (var_25_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_25_1.transform.localScale = Vector3.New(var_25_3 / var_25_2.sprite.bounds.size.y < var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x and var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x or var_25_3 / var_25_2.sprite.bounds.size.y, var_25_3 / var_25_2.sprite.bounds.size.y < var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x and var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x or var_25_3 / var_25_2.sprite.bounds.size.y, 0)
				end

				for iter_25_0, iter_25_1 in pairs(arg_22_1.bgs_) do
					if iter_25_0 ~= "B13a" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_4 = 0

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_4 + arg_25_0 then
				arg_22_1.allBtn_.enabled = false
			end

			if arg_22_1.time_ >= var_25_4 + 0.3 and arg_22_1.time_ < var_25_4 + 0.3 + arg_25_0 then
				arg_22_1.allBtn_.enabled = true
			end

			local var_25_5 = 0

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_6 = 1

			if var_25_5 <= arg_22_1.time_ and arg_22_1.time_ < var_25_5 + var_25_6 then
				local var_25_7 = Color.New(0, 0, 0)

				var_25_7.a = Mathf.Lerp(0, 1, (arg_22_1.time_ - var_25_5) / var_25_6)
				arg_22_1.mask_.color = var_25_7
			end

			if arg_22_1.time_ >= var_25_5 + var_25_6 and arg_22_1.time_ < var_25_5 + var_25_6 + arg_25_0 then
				local var_25_8 = Color.New(0, 0, 0)

				var_25_8.a = 1
				arg_22_1.mask_.color = var_25_8
			end

			local var_25_9 = 1

			if 1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_9 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_10 = 1.46666666666667

			if var_25_9 <= arg_22_1.time_ and arg_22_1.time_ < var_25_9 + var_25_10 then
				local var_25_11 = Color.New(0, 0, 0)

				var_25_11.a = Mathf.Lerp(1, 0, (arg_22_1.time_ - var_25_9) / var_25_10)
				arg_22_1.mask_.color = var_25_11
			end

			if arg_22_1.time_ >= var_25_9 + var_25_10 and arg_22_1.time_ < var_25_9 + var_25_10 + arg_25_0 then
				local var_25_12 = Color.New(0, 0, 0)

				arg_22_1.mask_.enabled = false
				var_25_12.a = 0
				arg_22_1.mask_.color = var_25_12
			end

			if 1.2 < arg_22_1.time_ and arg_22_1.time_ <= 1.2 + arg_25_0 then
				arg_22_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 0.2 < arg_22_1.time_ and arg_22_1.time_ <= 0.2 + arg_25_0 then
				arg_22_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_15 = 2.24166666666667
			local var_25_16 = 0.225

			if 2.24166666666667 < arg_22_1.time_ and arg_22_1.time_ <= var_25_15 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_17 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_17:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_22_1.dialogCg_.alpha = arg_26_0
				end))
				var_25_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_18 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(305012005).content)

				arg_22_1.text_.text = var_25_18

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_20 = 9 <= 0 and var_25_16 or var_25_16 * (utf8.len(var_25_18) / 9)

				if (9 <= 0 and var_25_16 or var_25_16 * (utf8.len(var_25_18) / 9)) > 0 and var_25_16 < var_25_20 then
					arg_22_1.talkMaxDuration = var_25_20
					var_25_15 = var_25_15 + 0.3

					if var_25_20 + var_25_15 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_20 + var_25_15
					end
				end

				arg_22_1.text_.text = var_25_18
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_21 = var_25_15 + 0.3
			local var_25_22 = math.max(var_25_16, arg_22_1.talkMaxDuration)

			if var_25_15 + 0.3 <= arg_22_1.time_ and arg_22_1.time_ < var_25_21 + var_25_22 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_21) / var_25_22

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_21 + var_25_22 and arg_22_1.time_ < var_25_21 + var_25_22 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play305012006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 305012006
		arg_28_1.duration_ = 8.9

		local var_28_0 = {
			zh = 3.2,
			ja = 8.9
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play305012007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "1033ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1033ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["1033ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["1033ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["1033ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["1033ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1033ui_story = var_31_3.localPosition
			end

			local var_31_4 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				var_31_3.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_28_1.time_ - 0) / var_31_4)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				var_31_3.localPosition = Vector3.New(0, -1.01, -6.13)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			local var_31_5 = arg_28_1.actors_["1033ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1033ui_story == nil then
				arg_28_1.var_.characterEffect1033ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_6 and not isNil(var_31_5) then
				if arg_28_1.var_.characterEffect1033ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_6 and arg_28_1.time_ < 0 + var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1033ui_story then
				arg_28_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_31_8 = 0
			local var_31_9 = 0.375

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_10 = arg_28_1:GetWordFromCfg(305012006)
				local var_31_11 = arg_28_1:FormatText(var_31_10.content)

				arg_28_1.text_.text = var_31_11

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_13 = 15 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 15)

				if (15 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 15)) > 0 and var_31_9 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_8
					end
				end

				arg_28_1.text_.text = var_31_11
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012006", "story_v_out_305012.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_305012", "305012006", "story_v_out_305012.awb") / 1000

					if var_31_14 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_8
					end

					if var_31_10.prefab_name ~= "" and arg_28_1.actors_[var_31_10.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_10.prefab_name].transform, "story_v_out_305012", "305012006", "story_v_out_305012.awb")

						arg_28_1:RecordAudio("305012006", var_31_15)
						arg_28_1:RecordAudio("305012006", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_305012", "305012006", "story_v_out_305012.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_305012", "305012006", "story_v_out_305012.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_9, arg_28_1.talkMaxDuration)

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_8) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_8 + var_31_16 and arg_28_1.time_ < var_31_8 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play305012007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 305012007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play305012008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1033ui_story"]) and arg_32_1.var_.characterEffect1033ui_story == nil then
				arg_32_1.var_.characterEffect1033ui_story = arg_32_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1033ui_story"]) then
				if arg_32_1.var_.characterEffect1033ui_story and not isNil(arg_32_1.actors_["1033ui_story"]) then
					arg_32_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1033ui_story"]) and arg_32_1.var_.characterEffect1033ui_story then
				arg_32_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_35_1 = 0
			local var_35_2 = 0.4

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(305012007).content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 16 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 16)

				if (16 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 16)) > 0 and var_35_2 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_6 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_6 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_6

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_6 and arg_32_1.time_ < var_35_1 + var_35_6 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play305012008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 305012008
		arg_36_1.duration_ = 10.73

		local var_36_0 = {
			zh = 4.066,
			ja = 10.733
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play305012009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1033ui_story"]) and arg_36_1.var_.characterEffect1033ui_story == nil then
				arg_36_1.var_.characterEffect1033ui_story = arg_36_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1033ui_story"]) then
				if arg_36_1.var_.characterEffect1033ui_story and not isNil(arg_36_1.actors_["1033ui_story"]) then
					arg_36_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1033ui_story"]) and arg_36_1.var_.characterEffect1033ui_story then
				arg_36_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action438")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_39_2 = 0
			local var_39_3 = 0.575

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:GetWordFromCfg(305012008)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 23 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 23)

				if (23 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 23)) > 0 and var_39_3 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012008", "story_v_out_305012.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_305012", "305012008", "story_v_out_305012.awb") / 1000

					if var_39_8 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_2
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_out_305012", "305012008", "story_v_out_305012.awb")

						arg_36_1:RecordAudio("305012008", var_39_9)
						arg_36_1:RecordAudio("305012008", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_305012", "305012008", "story_v_out_305012.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_305012", "305012008", "story_v_out_305012.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_10 and arg_36_1.time_ < var_39_2 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play305012009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 305012009
		arg_40_1.duration_ = 4.73

		local var_40_0 = {
			zh = 4.733,
			ja = 1.999999999999
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play305012010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if arg_40_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_43_0 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_40_1.stage_.transform)

				var_43_0.name = "1066ui_story"
				var_43_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1066ui_story"] = var_43_0

				local var_43_1 = var_43_0:GetComponentInChildren(typeof(CharacterEffect))

				var_43_1.enabled = true

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_1.transform, false)

				arg_40_1.var_["1066ui_story" .. "Animator"] = var_43_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_["1066ui_story" .. "Animator"].applyRootMotion = true
				arg_40_1.var_["1066ui_story" .. "LipSync"] = var_43_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_43_3 = arg_40_1.actors_["1066ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1066ui_story = var_43_3.localPosition
			end

			local var_43_4 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				var_43_3.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_40_1.time_ - 0) / var_43_4)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				var_43_3.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			local var_43_5 = arg_40_1.actors_["1033ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1033ui_story = var_43_5.localPosition
			end

			local var_43_6 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_6 then
				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_40_1.time_ - 0) / var_43_6)
				var_43_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_5.position).x, (manager.ui.mainCamera.transform.position - var_43_5.position).y, (manager.ui.mainCamera.transform.position - var_43_5.position).z)
				var_43_5.localEulerAngles.z = 0
				var_43_5.localEulerAngles.x = 0
				var_43_5.localEulerAngles = var_43_5.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_6 and arg_40_1.time_ < 0 + var_43_6 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(0.7, -1.01, -6.13)
				var_43_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_5.position).x, (manager.ui.mainCamera.transform.position - var_43_5.position).y, (manager.ui.mainCamera.transform.position - var_43_5.position).z)
				var_43_5.localEulerAngles.z = 0
				var_43_5.localEulerAngles.x = 0
				var_43_5.localEulerAngles = var_43_5.localEulerAngles
			end

			local var_43_7 = arg_40_1.actors_["1066ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1066ui_story == nil then
				arg_40_1.var_.characterEffect1066ui_story = var_43_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_8 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_8 and not isNil(var_43_7) then
				if arg_40_1.var_.characterEffect1066ui_story and not isNil(var_43_7) then
					arg_40_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_8 and arg_40_1.time_ < 0 + var_43_8 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1066ui_story then
				arg_40_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_43_10 = arg_40_1.actors_["1033ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_10) and arg_40_1.var_.characterEffect1033ui_story == nil then
				arg_40_1.var_.characterEffect1033ui_story = var_43_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_11 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_11 and not isNil(var_43_10) then
				if arg_40_1.var_.characterEffect1033ui_story and not isNil(var_43_10) then
					arg_40_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_11)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_11 and arg_40_1.time_ < 0 + var_43_11 + arg_43_0 and not isNil(var_43_10) and arg_40_1.var_.characterEffect1033ui_story then
				arg_40_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action6_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_12 = 0
			local var_43_13 = 0.6

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_14 = arg_40_1:GetWordFromCfg(305012009)
				local var_43_15 = arg_40_1:FormatText(var_43_14.content)

				arg_40_1.text_.text = var_43_15

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 24 <= 0 and var_43_13 or var_43_13 * (utf8.len(var_43_15) / 24)

				if (24 <= 0 and var_43_13 or var_43_13 * (utf8.len(var_43_15) / 24)) > 0 and var_43_13 < var_43_17 then
					arg_40_1.talkMaxDuration = var_43_17

					if var_43_17 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_17 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_15
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012009", "story_v_out_305012.awb") ~= 0 then
					local var_43_18 = manager.audio:GetVoiceLength("story_v_out_305012", "305012009", "story_v_out_305012.awb") / 1000

					if var_43_18 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_18 + var_43_12
					end

					if var_43_14.prefab_name ~= "" and arg_40_1.actors_[var_43_14.prefab_name] ~= nil then
						local var_43_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_14.prefab_name].transform, "story_v_out_305012", "305012009", "story_v_out_305012.awb")

						arg_40_1:RecordAudio("305012009", var_43_19)
						arg_40_1:RecordAudio("305012009", var_43_19)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_305012", "305012009", "story_v_out_305012.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_305012", "305012009", "story_v_out_305012.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_20 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_20 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_20

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_20 and arg_40_1.time_ < var_43_12 + var_43_20 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play305012010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 305012010
		arg_44_1.duration_ = 11.9

		local var_44_0 = {
			zh = 5.3,
			ja = 11.9
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play305012011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1033ui_story"]) and arg_44_1.var_.characterEffect1033ui_story == nil then
				arg_44_1.var_.characterEffect1033ui_story = arg_44_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1033ui_story"]) then
				if arg_44_1.var_.characterEffect1033ui_story and not isNil(arg_44_1.actors_["1033ui_story"]) then
					arg_44_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1033ui_story"]) and arg_44_1.var_.characterEffect1033ui_story then
				arg_44_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1066ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1066ui_story == nil then
				arg_44_1.var_.characterEffect1066ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1066ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1066ui_story then
				arg_44_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033actionlink/1033action482")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_47_4 = 0
			local var_47_5 = 0.75

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(305012010)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 30 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 30)

				if (30 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 30)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012010", "story_v_out_305012.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_305012", "305012010", "story_v_out_305012.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_305012", "305012010", "story_v_out_305012.awb")

						arg_44_1:RecordAudio("305012010", var_47_11)
						arg_44_1:RecordAudio("305012010", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_305012", "305012010", "story_v_out_305012.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_305012", "305012010", "story_v_out_305012.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play305012011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 305012011
		arg_48_1.duration_ = 5.8

		local var_48_0 = {
			zh = 5.8,
			ja = 1.999999999999
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
				arg_48_0:Play305012012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1066ui_story"]) and arg_48_1.var_.characterEffect1066ui_story == nil then
				arg_48_1.var_.characterEffect1066ui_story = arg_48_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1066ui_story"]) then
				if arg_48_1.var_.characterEffect1066ui_story and not isNil(arg_48_1.actors_["1066ui_story"]) then
					arg_48_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1066ui_story"]) and arg_48_1.var_.characterEffect1066ui_story then
				arg_48_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1033ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1033ui_story == nil then
				arg_48_1.var_.characterEffect1033ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1033ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1033ui_story then
				arg_48_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action6_2")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_4 = 0
			local var_51_5 = 0.7

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(305012011)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 28 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 28)

				if (28 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 28)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012011", "story_v_out_305012.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_305012", "305012011", "story_v_out_305012.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_305012", "305012011", "story_v_out_305012.awb")

						arg_48_1:RecordAudio("305012011", var_51_11)
						arg_48_1:RecordAudio("305012011", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_305012", "305012011", "story_v_out_305012.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_305012", "305012011", "story_v_out_305012.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play305012012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 305012012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play305012013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1066ui_story"]) and arg_52_1.var_.characterEffect1066ui_story == nil then
				arg_52_1.var_.characterEffect1066ui_story = arg_52_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1066ui_story"]) then
				if arg_52_1.var_.characterEffect1066ui_story and not isNil(arg_52_1.actors_["1066ui_story"]) then
					arg_52_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1066ui_story"]) and arg_52_1.var_.characterEffect1066ui_story then
				arg_52_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_55_1 = 0
			local var_55_2 = 0.9

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(305012012).content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 36 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 36)

				if (36 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 36)) > 0 and var_55_2 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_6 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_6 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_6

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_6 and arg_52_1.time_ < var_55_1 + var_55_6 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play305012013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 305012013
		arg_56_1.duration_ = 2.9

		local var_56_0 = {
			zh = 2.3,
			ja = 2.9
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
				arg_56_0:Play305012014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1066ui_story = arg_56_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_59_0 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1066ui_story"].transform.position).z)
				arg_56_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1066ui_story"].transform.localEulerAngles = arg_56_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1066ui_story"].transform.position).z)
				arg_56_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1066ui_story"].transform.localEulerAngles = arg_56_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_59_1 = arg_56_1.actors_["1033ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1033ui_story = var_59_1.localPosition
			end

			local var_59_2 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 then
				var_59_1.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_2)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 then
				var_59_1.localPosition = Vector3.New(0, 100, 0)
				var_59_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_1.position).x, (manager.ui.mainCamera.transform.position - var_59_1.position).y, (manager.ui.mainCamera.transform.position - var_59_1.position).z)
				var_59_1.localEulerAngles.z = 0
				var_59_1.localEulerAngles.x = 0
				var_59_1.localEulerAngles = var_59_1.localEulerAngles
			end

			local var_59_3 = "10045ui_story"

			if arg_56_1.actors_["10045ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10045ui_story"))) then
				local var_59_4 = Object.Instantiate(Asset.Load("Char/" .. "10045ui_story"), arg_56_1.stage_.transform)

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

			local var_59_7 = arg_56_1.actors_["10045ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_7) and arg_56_1.var_.characterEffect10045ui_story == nil then
				arg_56_1.var_.characterEffect10045ui_story = var_59_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_8 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_8 and not isNil(var_59_7) then
				if arg_56_1.var_.characterEffect10045ui_story and not isNil(var_59_7) then
					arg_56_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_8 and arg_56_1.time_ < 0 + var_59_8 + arg_59_0 and not isNil(var_59_7) and arg_56_1.var_.characterEffect10045ui_story then
				arg_56_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_59_10 = 0
			local var_59_11 = 0.25

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_10 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_12 = arg_56_1:GetWordFromCfg(305012013)
				local var_59_13 = arg_56_1:FormatText(var_59_12.content)

				arg_56_1.text_.text = var_59_13

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 10 <= 0 and var_59_11 or var_59_11 * (utf8.len(var_59_13) / 10)

				if (10 <= 0 and var_59_11 or var_59_11 * (utf8.len(var_59_13) / 10)) > 0 and var_59_11 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15

					if var_59_15 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_10
					end
				end

				arg_56_1.text_.text = var_59_13
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012013", "story_v_out_305012.awb") ~= 0 then
					local var_59_16 = manager.audio:GetVoiceLength("story_v_out_305012", "305012013", "story_v_out_305012.awb") / 1000

					if var_59_16 + var_59_10 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_16 + var_59_10
					end

					if var_59_12.prefab_name ~= "" and arg_56_1.actors_[var_59_12.prefab_name] ~= nil then
						local var_59_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_12.prefab_name].transform, "story_v_out_305012", "305012013", "story_v_out_305012.awb")

						arg_56_1:RecordAudio("305012013", var_59_17)
						arg_56_1:RecordAudio("305012013", var_59_17)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_305012", "305012013", "story_v_out_305012.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_305012", "305012013", "story_v_out_305012.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_18 = math.max(var_59_11, arg_56_1.talkMaxDuration)

			if var_59_10 <= arg_56_1.time_ and arg_56_1.time_ < var_59_10 + var_59_18 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_10) / var_59_18

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_10 + var_59_18 and arg_56_1.time_ < var_59_10 + var_59_18 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
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
	Play305012014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 305012014
		arg_60_1.duration_ = 6.73

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play305012015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if arg_60_1.bgs_.S0405 == nil then
				local var_63_0 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0405")
				var_63_0.name = "S0405"
				var_63_0.transform.parent = arg_60_1.stage_.transform
				var_63_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_.S0405 = var_63_0
			end

			if 0.34623639928177 < arg_60_1.time_ and arg_60_1.time_ <= 0.34623639928177 + arg_63_0 then
				local var_63_1 = arg_60_1.bgs_.S0405

				arg_60_1.bgs_.S0405.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_63_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_2 = var_63_1:GetComponent("SpriteRenderer")

				if var_63_2 and var_63_2.sprite then
					local var_63_3 = 2 * (var_63_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_63_1.transform.localScale = Vector3.New(var_63_3 / var_63_2.sprite.bounds.size.y < var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x and var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x or var_63_3 / var_63_2.sprite.bounds.size.y, var_63_3 / var_63_2.sprite.bounds.size.y < var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x and var_63_3 * manager.ui.mainCameraCom_.aspect / var_63_2.sprite.bounds.size.x or var_63_3 / var_63_2.sprite.bounds.size.y, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "S0405" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_4 = 0.34623639928177

			if 0.34623639928177 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			if arg_60_1.time_ >= var_63_4 + 0.3 and arg_60_1.time_ < var_63_4 + 0.3 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			local var_63_5 = 0

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_6 = 0.34623639928177

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 then
				local var_63_7 = Color.New(1, 1, 1)

				var_63_7.a = Mathf.Lerp(0, 1, (arg_60_1.time_ - var_63_5) / var_63_6)
				arg_60_1.mask_.color = var_63_7
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 then
				local var_63_8 = Color.New(1, 1, 1)

				var_63_8.a = 1
				arg_60_1.mask_.color = var_63_8
			end

			local var_63_9 = 0.34623639928177

			if 0.34623639928177 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_10 = 1.58709693405156

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_10 then
				local var_63_11 = Color.New(1, 1, 1)

				var_63_11.a = Mathf.Lerp(1, 0, (arg_60_1.time_ - var_63_9) / var_63_10)
				arg_60_1.mask_.color = var_63_11
			end

			if arg_60_1.time_ >= var_63_9 + var_63_10 and arg_60_1.time_ < var_63_9 + var_63_10 + arg_63_0 then
				local var_63_12 = Color.New(1, 1, 1)

				arg_60_1.mask_.enabled = false
				var_63_12.a = 0
				arg_60_1.mask_.color = var_63_12
			end

			local var_63_13 = arg_60_1.actors_["10045ui_story"]

			if 0.34623639928177 < arg_60_1.time_ and arg_60_1.time_ <= 0.34623639928177 + arg_63_0 and not isNil(var_63_13) and arg_60_1.var_.characterEffect10045ui_story == nil then
				arg_60_1.var_.characterEffect10045ui_story = var_63_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_14 = 0.200000002980232

			if 0.34623639928177 <= arg_60_1.time_ and arg_60_1.time_ < 0.34623639928177 + var_63_14 and not isNil(var_63_13) then
				if arg_60_1.var_.characterEffect10045ui_story and not isNil(var_63_13) then
					arg_60_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0.34623639928177) / var_63_14)
				end
			end

			if arg_60_1.time_ >= 0.34623639928177 + var_63_14 and arg_60_1.time_ < 0.34623639928177 + var_63_14 + arg_63_0 and not isNil(var_63_13) and arg_60_1.var_.characterEffect10045ui_story then
				arg_60_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			if 0.2 < arg_60_1.time_ and arg_60_1.time_ <= 0.2 + arg_63_0 then
				arg_60_1:AudioAction("play", "effect", "se_story_148", "se_story_148_sword08", "")
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_16 = 1.73333333333333
			local var_63_17 = 1.125

			if 1.73333333333333 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_18 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_18:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_19 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(305012014).content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_21 = 43 <= 0 and var_63_17 or var_63_17 * (utf8.len(var_63_19) / 43)

				if (43 <= 0 and var_63_17 or var_63_17 * (utf8.len(var_63_19) / 43)) > 0 and var_63_17 < var_63_21 then
					arg_60_1.talkMaxDuration = var_63_21
					var_63_16 = var_63_16 + 0.3

					if var_63_21 + var_63_16 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_21 + var_63_16
					end
				end

				arg_60_1.text_.text = var_63_19
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_22 = var_63_16 + 0.3
			local var_63_23 = math.max(var_63_17, arg_60_1.talkMaxDuration)

			if var_63_16 + 0.3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_22 + var_63_23 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_22) / var_63_23

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_22 + var_63_23 and arg_60_1.time_ < var_63_22 + var_63_23 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.1,
				amplitudeGain = 0.3,
				startTime = 0.733333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play305012015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 305012015
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play305012016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 1.2

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(305012015).content)

				arg_66_1.text_.text = var_69_1

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_3 = 48 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 48)

				if (48 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 48)) > 0 and var_69_0 < var_69_3 then
					arg_66_1.talkMaxDuration = var_69_3

					if var_69_3 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_3 + 0
					end
				end

				arg_66_1.text_.text = var_69_1
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_4 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_4

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play305012016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 305012016
		arg_70_1.duration_ = 6.93

		local var_70_0 = {
			zh = 5.2,
			ja = 6.933
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play305012017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["10045ui_story"]) and arg_70_1.var_.characterEffect10045ui_story == nil then
				arg_70_1.var_.characterEffect10045ui_story = arg_70_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["10045ui_story"]) then
				if arg_70_1.var_.characterEffect10045ui_story and not isNil(arg_70_1.actors_["10045ui_story"]) then
					arg_70_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["10045ui_story"]) and arg_70_1.var_.characterEffect10045ui_story then
				arg_70_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			local var_73_2 = 0
			local var_73_3 = 0.6

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_2 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_4 = arg_70_1:GetWordFromCfg(305012016)
				local var_73_5 = arg_70_1:FormatText(var_73_4.content)

				arg_70_1.text_.text = var_73_5

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_7 = 24 <= 0 and var_73_3 or var_73_3 * (utf8.len(var_73_5) / 24)

				if (24 <= 0 and var_73_3 or var_73_3 * (utf8.len(var_73_5) / 24)) > 0 and var_73_3 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_2 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_2
					end
				end

				arg_70_1.text_.text = var_73_5
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012016", "story_v_out_305012.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_305012", "305012016", "story_v_out_305012.awb") / 1000

					if var_73_8 + var_73_2 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_2
					end

					if var_73_4.prefab_name ~= "" and arg_70_1.actors_[var_73_4.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_4.prefab_name].transform, "story_v_out_305012", "305012016", "story_v_out_305012.awb")

						arg_70_1:RecordAudio("305012016", var_73_9)
						arg_70_1:RecordAudio("305012016", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_305012", "305012016", "story_v_out_305012.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_305012", "305012016", "story_v_out_305012.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_3, arg_70_1.talkMaxDuration)

			if var_73_2 <= arg_70_1.time_ and arg_70_1.time_ < var_73_2 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_2) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_2 + var_73_10 and arg_70_1.time_ < var_73_2 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play305012017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 305012017
		arg_74_1.duration_ = 6.1

		local var_74_0 = {
			zh = 6.1,
			ja = 5.166
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play305012018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.775

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:GetWordFromCfg(305012017)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 31 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 31)

				if (31 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 31)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012017", "story_v_out_305012.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_305012", "305012017", "story_v_out_305012.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_305012", "305012017", "story_v_out_305012.awb")

						arg_74_1:RecordAudio("305012017", var_77_6)
						arg_74_1:RecordAudio("305012017", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_305012", "305012017", "story_v_out_305012.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_305012", "305012017", "story_v_out_305012.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play305012018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 305012018
		arg_78_1.duration_ = 8.63

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play305012019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 2 < arg_78_1.time_ and arg_78_1.time_ <= 2 + arg_81_0 then
				local var_81_0 = arg_78_1.bgs_.B13a

				arg_78_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_81_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_81_1 = var_81_0:GetComponent("SpriteRenderer")

				if var_81_1 and var_81_1.sprite then
					local var_81_2 = 2 * (var_81_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_81_0.transform.localScale = Vector3.New(var_81_2 / var_81_1.sprite.bounds.size.y < var_81_2 * manager.ui.mainCameraCom_.aspect / var_81_1.sprite.bounds.size.x and var_81_2 * manager.ui.mainCameraCom_.aspect / var_81_1.sprite.bounds.size.x or var_81_2 / var_81_1.sprite.bounds.size.y, var_81_2 / var_81_1.sprite.bounds.size.y < var_81_2 * manager.ui.mainCameraCom_.aspect / var_81_1.sprite.bounds.size.x and var_81_2 * manager.ui.mainCameraCom_.aspect / var_81_1.sprite.bounds.size.x or var_81_2 / var_81_1.sprite.bounds.size.y, 0)
				end

				for iter_81_0, iter_81_1 in pairs(arg_78_1.bgs_) do
					if iter_81_0 ~= "B13a" then
						iter_81_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_81_3 = 0

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_3 + arg_81_0 then
				arg_78_1.allBtn_.enabled = false
			end

			if arg_78_1.time_ >= var_81_3 + 0.3 and arg_78_1.time_ < var_81_3 + 0.3 + arg_81_0 then
				arg_78_1.allBtn_.enabled = true
			end

			local var_81_4 = 0

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_5 = 2

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_5 then
				local var_81_6 = Color.New(0, 0, 0)

				var_81_6.a = Mathf.Lerp(0, 1, (arg_78_1.time_ - var_81_4) / var_81_5)
				arg_78_1.mask_.color = var_81_6
			end

			if arg_78_1.time_ >= var_81_4 + var_81_5 and arg_78_1.time_ < var_81_4 + var_81_5 + arg_81_0 then
				local var_81_7 = Color.New(0, 0, 0)

				var_81_7.a = 1
				arg_78_1.mask_.color = var_81_7
			end

			local var_81_8 = 2

			if 2 < arg_78_1.time_ and arg_78_1.time_ <= var_81_8 + arg_81_0 then
				arg_78_1.mask_.enabled = true
				arg_78_1.mask_.raycastTarget = true

				arg_78_1:SetGaussion(false)
			end

			local var_81_9 = 2

			if var_81_8 <= arg_78_1.time_ and arg_78_1.time_ < var_81_8 + var_81_9 then
				local var_81_10 = Color.New(0, 0, 0)

				var_81_10.a = Mathf.Lerp(1, 0, (arg_78_1.time_ - var_81_8) / var_81_9)
				arg_78_1.mask_.color = var_81_10
			end

			if arg_78_1.time_ >= var_81_8 + var_81_9 and arg_78_1.time_ < var_81_8 + var_81_9 + arg_81_0 then
				local var_81_11 = Color.New(0, 0, 0)

				arg_78_1.mask_.enabled = false
				var_81_11.a = 0
				arg_78_1.mask_.color = var_81_11
			end

			local var_81_12 = arg_78_1.actors_["10045ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_12) and arg_78_1.var_.characterEffect10045ui_story == nil then
				arg_78_1.var_.characterEffect10045ui_story = var_81_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_13 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_13 and not isNil(var_81_12) then
				if arg_78_1.var_.characterEffect10045ui_story and not isNil(var_81_12) then
					arg_78_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_13)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_13 and arg_78_1.time_ < 0 + var_81_13 + arg_81_0 and not isNil(var_81_12) and arg_78_1.var_.characterEffect10045ui_story then
				arg_78_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			if arg_78_1.frameCnt_ <= 1 then
				arg_78_1.dialog_:SetActive(false)
			end

			local var_81_14 = 3.63333333333333
			local var_81_15 = 0.125

			if 3.63333333333333 < arg_78_1.time_ and arg_78_1.time_ <= var_81_14 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0

				arg_78_1.dialog_:SetActive(true)

				arg_78_1.dialogCg_.alpha = 0

				local var_81_16 = LeanTween.value(arg_78_1.dialog_, 0, 1, 0.3)

				var_81_16:setOnUpdate(LuaHelper.FloatAction(function(arg_82_0)
					arg_78_1.dialogCg_.alpha = arg_82_0
				end))
				var_81_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_78_1.dialog_)
					var_81_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_78_1.duration_ = arg_78_1.duration_ + 0.3

				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_17 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(305012018).content)

				arg_78_1.text_.text = var_81_17

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_19 = 5 <= 0 and var_81_15 or var_81_15 * (utf8.len(var_81_17) / 5)

				if (5 <= 0 and var_81_15 or var_81_15 * (utf8.len(var_81_17) / 5)) > 0 and var_81_15 < var_81_19 then
					arg_78_1.talkMaxDuration = var_81_19
					var_81_14 = var_81_14 + 0.3

					if var_81_19 + var_81_14 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_19 + var_81_14
					end
				end

				arg_78_1.text_.text = var_81_17
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_20 = var_81_14 + 0.3
			local var_81_21 = math.max(var_81_15, arg_78_1.talkMaxDuration)

			if var_81_14 + 0.3 <= arg_78_1.time_ and arg_78_1.time_ < var_81_20 + var_81_21 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_20) / var_81_21

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_20 + var_81_21 and arg_78_1.time_ < var_81_20 + var_81_21 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play305012019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 305012019
		arg_84_1.duration_ = 5.13

		local var_84_0 = {
			zh = 5.133,
			ja = 1.999999999999
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
				arg_84_0:Play305012020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if arg_84_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_87_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_84_1.stage_.transform)

				var_87_0.name = "1037ui_story"
				var_87_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_["1037ui_story"] = var_87_0

				local var_87_1 = var_87_0:GetComponentInChildren(typeof(CharacterEffect))

				var_87_1.enabled = true

				local var_87_2 = GameObjectTools.GetOrAddComponent(var_87_0, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(false)
				end

				arg_84_1:ShowWeapon(var_87_1.transform, false)

				arg_84_1.var_["1037ui_story" .. "Animator"] = var_87_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_84_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_84_1.var_["1037ui_story" .. "LipSync"] = var_87_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_87_3 = arg_84_1.actors_["1037ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1037ui_story = var_87_3.localPosition
			end

			local var_87_4 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				var_87_3.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_84_1.time_ - 0) / var_87_4)
				var_87_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_3.position).x, (manager.ui.mainCamera.transform.position - var_87_3.position).y, (manager.ui.mainCamera.transform.position - var_87_3.position).z)
				var_87_3.localEulerAngles.z = 0
				var_87_3.localEulerAngles.x = 0
				var_87_3.localEulerAngles = var_87_3.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				var_87_3.localPosition = Vector3.New(0, -1.09, -5.81)
				var_87_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_3.position).x, (manager.ui.mainCamera.transform.position - var_87_3.position).y, (manager.ui.mainCamera.transform.position - var_87_3.position).z)
				var_87_3.localEulerAngles.z = 0
				var_87_3.localEulerAngles.x = 0
				var_87_3.localEulerAngles = var_87_3.localEulerAngles
			end

			local var_87_5 = arg_84_1.actors_["1037ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect1037ui_story == nil then
				arg_84_1.var_.characterEffect1037ui_story = var_87_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_6 and not isNil(var_87_5) then
				if arg_84_1.var_.characterEffect1037ui_story and not isNil(var_87_5) then
					arg_84_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_6 and arg_84_1.time_ < 0 + var_87_6 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect1037ui_story then
				arg_84_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_87_8 = 0
			local var_87_9 = 0.525

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_8 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_10 = arg_84_1:GetWordFromCfg(305012019)
				local var_87_11 = arg_84_1:FormatText(var_87_10.content)

				arg_84_1.text_.text = var_87_11

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_13 = 21 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_11) / 21)

				if (21 <= 0 and var_87_9 or var_87_9 * (utf8.len(var_87_11) / 21)) > 0 and var_87_9 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_8
					end
				end

				arg_84_1.text_.text = var_87_11
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012019", "story_v_out_305012.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_305012", "305012019", "story_v_out_305012.awb") / 1000

					if var_87_14 + var_87_8 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_8
					end

					if var_87_10.prefab_name ~= "" and arg_84_1.actors_[var_87_10.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_10.prefab_name].transform, "story_v_out_305012", "305012019", "story_v_out_305012.awb")

						arg_84_1:RecordAudio("305012019", var_87_15)
						arg_84_1:RecordAudio("305012019", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_305012", "305012019", "story_v_out_305012.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_305012", "305012019", "story_v_out_305012.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = math.max(var_87_9, arg_84_1.talkMaxDuration)

			if var_87_8 <= arg_84_1.time_ and arg_84_1.time_ < var_87_8 + var_87_16 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_8) / var_87_16

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_8 + var_87_16 and arg_84_1.time_ < var_87_8 + var_87_16 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play305012020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 305012020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play305012021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1037ui_story"]) and arg_88_1.var_.characterEffect1037ui_story == nil then
				arg_88_1.var_.characterEffect1037ui_story = arg_88_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1037ui_story"]) then
				if arg_88_1.var_.characterEffect1037ui_story and not isNil(arg_88_1.actors_["1037ui_story"]) then
					arg_88_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_0)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1037ui_story"]) and arg_88_1.var_.characterEffect1037ui_story then
				arg_88_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_91_1 = 0
			local var_91_2 = 0.55

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("normal")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_3 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(305012020).content)

				arg_88_1.text_.text = var_91_3

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_5 = 22 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 22)

				if (22 <= 0 and var_91_2 or var_91_2 * (utf8.len(var_91_3) / 22)) > 0 and var_91_2 < var_91_5 then
					arg_88_1.talkMaxDuration = var_91_5

					if var_91_5 + var_91_1 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + var_91_1
					end
				end

				arg_88_1.text_.text = var_91_3
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_6 = math.max(var_91_2, arg_88_1.talkMaxDuration)

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_6 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_1) / var_91_6

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_1 + var_91_6 and arg_88_1.time_ < var_91_1 + var_91_6 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play305012021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 305012021
		arg_92_1.duration_ = 8.5

		local var_92_0 = {
			zh = 8.5,
			ja = 1.999999999999
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play305012022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1037ui_story"]) and arg_92_1.var_.characterEffect1037ui_story == nil then
				arg_92_1.var_.characterEffect1037ui_story = arg_92_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1037ui_story"]) then
				if arg_92_1.var_.characterEffect1037ui_story and not isNil(arg_92_1.actors_["1037ui_story"]) then
					arg_92_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1037ui_story"]) and arg_92_1.var_.characterEffect1037ui_story then
				arg_92_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_95_2 = 0
			local var_95_3 = 1.05

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_4 = arg_92_1:GetWordFromCfg(305012021)
				local var_95_5 = arg_92_1:FormatText(var_95_4.content)

				arg_92_1.text_.text = var_95_5

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_7 = 42 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 42)

				if (42 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 42)) > 0 and var_95_3 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_5
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012021", "story_v_out_305012.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_305012", "305012021", "story_v_out_305012.awb") / 1000

					if var_95_8 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_2
					end

					if var_95_4.prefab_name ~= "" and arg_92_1.actors_[var_95_4.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_4.prefab_name].transform, "story_v_out_305012", "305012021", "story_v_out_305012.awb")

						arg_92_1:RecordAudio("305012021", var_95_9)
						arg_92_1:RecordAudio("305012021", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_305012", "305012021", "story_v_out_305012.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_305012", "305012021", "story_v_out_305012.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_3, arg_92_1.talkMaxDuration)

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_2) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_2 + var_95_10 and arg_92_1.time_ < var_95_2 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play305012022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 305012022
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play305012023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1037ui_story"]) and arg_96_1.var_.characterEffect1037ui_story == nil then
				arg_96_1.var_.characterEffect1037ui_story = arg_96_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1037ui_story"]) then
				if arg_96_1.var_.characterEffect1037ui_story and not isNil(arg_96_1.actors_["1037ui_story"]) then
					arg_96_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1037ui_story"]) and arg_96_1.var_.characterEffect1037ui_story then
				arg_96_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_99_1 = 0
			local var_99_2 = 0.825

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(305012022).content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 33 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 33)

				if (33 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 33)) > 0 and var_99_2 < var_99_5 then
					arg_96_1.talkMaxDuration = var_99_5

					if var_99_5 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + var_99_1
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_6 = math.max(var_99_2, arg_96_1.talkMaxDuration)

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_6 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_1) / var_99_6

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_1 + var_99_6 and arg_96_1.time_ < var_99_1 + var_99_6 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play305012023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 305012023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play305012024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.4

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(305012023).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 16 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 16)

				if (16 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 16)) > 0 and var_103_0 < var_103_3 then
					arg_100_1.talkMaxDuration = var_103_3

					if var_103_3 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_3 + 0
					end
				end

				arg_100_1.text_.text = var_103_1
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_4 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_4

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play305012024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 305012024
		arg_104_1.duration_ = 5

		local var_104_0 = {
			zh = 3.766,
			ja = 5
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
				arg_104_0:Play305012025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if arg_104_1.actors_["1032ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1032ui_story"))) then
				local var_107_0 = Object.Instantiate(Asset.Load("Char/" .. "1032ui_story"), arg_104_1.stage_.transform)

				var_107_0.name = "1032ui_story"
				var_107_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_104_1.actors_["1032ui_story"] = var_107_0

				local var_107_1 = var_107_0:GetComponentInChildren(typeof(CharacterEffect))

				var_107_1.enabled = true

				local var_107_2 = GameObjectTools.GetOrAddComponent(var_107_0, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(false)
				end

				arg_104_1:ShowWeapon(var_107_1.transform, false)

				arg_104_1.var_["1032ui_story" .. "Animator"] = var_107_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_104_1.var_["1032ui_story" .. "Animator"].applyRootMotion = true
				arg_104_1.var_["1032ui_story" .. "LipSync"] = var_107_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_107_3 = arg_104_1.actors_["1032ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1032ui_story = var_107_3.localPosition
			end

			local var_107_4 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				var_107_3.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1032ui_story, Vector3.New(0, -1.05, -6.2), (arg_104_1.time_ - 0) / var_107_4)
				var_107_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_3.position).x, (manager.ui.mainCamera.transform.position - var_107_3.position).y, (manager.ui.mainCamera.transform.position - var_107_3.position).z)
				var_107_3.localEulerAngles.z = 0
				var_107_3.localEulerAngles.x = 0
				var_107_3.localEulerAngles = var_107_3.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				var_107_3.localPosition = Vector3.New(0, -1.05, -6.2)
				var_107_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_3.position).x, (manager.ui.mainCamera.transform.position - var_107_3.position).y, (manager.ui.mainCamera.transform.position - var_107_3.position).z)
				var_107_3.localEulerAngles.z = 0
				var_107_3.localEulerAngles.x = 0
				var_107_3.localEulerAngles = var_107_3.localEulerAngles
			end

			local var_107_5 = arg_104_1.actors_["1037ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1037ui_story = var_107_5.localPosition
			end

			local var_107_6 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_6 then
				var_107_5.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_104_1.time_ - 0) / var_107_6)
				var_107_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_5.position).x, (manager.ui.mainCamera.transform.position - var_107_5.position).y, (manager.ui.mainCamera.transform.position - var_107_5.position).z)
				var_107_5.localEulerAngles.z = 0
				var_107_5.localEulerAngles.x = 0
				var_107_5.localEulerAngles = var_107_5.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_6 and arg_104_1.time_ < 0 + var_107_6 + arg_107_0 then
				var_107_5.localPosition = Vector3.New(0, 100, 0)
				var_107_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_5.position).x, (manager.ui.mainCamera.transform.position - var_107_5.position).y, (manager.ui.mainCamera.transform.position - var_107_5.position).z)
				var_107_5.localEulerAngles.z = 0
				var_107_5.localEulerAngles.x = 0
				var_107_5.localEulerAngles = var_107_5.localEulerAngles
			end

			local var_107_7 = arg_104_1.actors_["1032ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_7) and arg_104_1.var_.characterEffect1032ui_story == nil then
				arg_104_1.var_.characterEffect1032ui_story = var_107_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_8 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_8 and not isNil(var_107_7) then
				if arg_104_1.var_.characterEffect1032ui_story and not isNil(var_107_7) then
					arg_104_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_8 and arg_104_1.time_ < 0 + var_107_8 + arg_107_0 and not isNil(var_107_7) and arg_104_1.var_.characterEffect1032ui_story then
				arg_104_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032action/1032action4_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_107_10 = 0
			local var_107_11 = 0.325

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_10 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_12 = arg_104_1:GetWordFromCfg(305012024)
				local var_107_13 = arg_104_1:FormatText(var_107_12.content)

				arg_104_1.text_.text = var_107_13

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_15 = 13 <= 0 and var_107_11 or var_107_11 * (utf8.len(var_107_13) / 13)

				if (13 <= 0 and var_107_11 or var_107_11 * (utf8.len(var_107_13) / 13)) > 0 and var_107_11 < var_107_15 then
					arg_104_1.talkMaxDuration = var_107_15

					if var_107_15 + var_107_10 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_15 + var_107_10
					end
				end

				arg_104_1.text_.text = var_107_13
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012024", "story_v_out_305012.awb") ~= 0 then
					local var_107_16 = manager.audio:GetVoiceLength("story_v_out_305012", "305012024", "story_v_out_305012.awb") / 1000

					if var_107_16 + var_107_10 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_16 + var_107_10
					end

					if var_107_12.prefab_name ~= "" and arg_104_1.actors_[var_107_12.prefab_name] ~= nil then
						local var_107_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_12.prefab_name].transform, "story_v_out_305012", "305012024", "story_v_out_305012.awb")

						arg_104_1:RecordAudio("305012024", var_107_17)
						arg_104_1:RecordAudio("305012024", var_107_17)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_305012", "305012024", "story_v_out_305012.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_305012", "305012024", "story_v_out_305012.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_18 = math.max(var_107_11, arg_104_1.talkMaxDuration)

			if var_107_10 <= arg_104_1.time_ and arg_104_1.time_ < var_107_10 + var_107_18 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_10) / var_107_18

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_10 + var_107_18 and arg_104_1.time_ < var_107_10 + var_107_18 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play305012025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 305012025
		arg_108_1.duration_ = 9.27

		local var_108_0 = {
			zh = 6.066,
			ja = 9.266
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
				arg_108_0:Play305012026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.75

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:GetWordFromCfg(305012025)
				local var_111_2 = arg_108_1:FormatText(var_111_1.content)

				arg_108_1.text_.text = var_111_2

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 30 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 30)

				if (30 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 30)) > 0 and var_111_0 < var_111_4 then
					arg_108_1.talkMaxDuration = var_111_4

					if var_111_4 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_4 + 0
					end
				end

				arg_108_1.text_.text = var_111_2
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012025", "story_v_out_305012.awb") ~= 0 then
					local var_111_5 = manager.audio:GetVoiceLength("story_v_out_305012", "305012025", "story_v_out_305012.awb") / 1000

					if var_111_5 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + 0
					end

					if var_111_1.prefab_name ~= "" and arg_108_1.actors_[var_111_1.prefab_name] ~= nil then
						local var_111_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_1.prefab_name].transform, "story_v_out_305012", "305012025", "story_v_out_305012.awb")

						arg_108_1:RecordAudio("305012025", var_111_6)
						arg_108_1:RecordAudio("305012025", var_111_6)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_305012", "305012025", "story_v_out_305012.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_305012", "305012025", "story_v_out_305012.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play305012026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 305012026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play305012027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1032ui_story"]) and arg_112_1.var_.characterEffect1032ui_story == nil then
				arg_112_1.var_.characterEffect1032ui_story = arg_112_1.actors_["1032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1032ui_story"]) then
				if arg_112_1.var_.characterEffect1032ui_story and not isNil(arg_112_1.actors_["1032ui_story"]) then
					arg_112_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_0)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1032ui_story"]) and arg_112_1.var_.characterEffect1032ui_story then
				arg_112_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1032ui_story.fillRatio = 0.5
			end

			local var_115_1 = 0
			local var_115_2 = 0.225

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_3 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(305012026).content)

				arg_112_1.text_.text = var_115_3

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_5 = 9 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_3) / 9)

				if (9 <= 0 and var_115_2 or var_115_2 * (utf8.len(var_115_3) / 9)) > 0 and var_115_2 < var_115_5 then
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

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play305012027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 305012027
		arg_116_1.duration_ = 5.37

		local var_116_0 = {
			zh = 4.1,
			ja = 5.366
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
				arg_116_0:Play305012028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1032ui_story"]) and arg_116_1.var_.characterEffect1032ui_story == nil then
				arg_116_1.var_.characterEffect1032ui_story = arg_116_1.actors_["1032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1032ui_story"]) then
				if arg_116_1.var_.characterEffect1032ui_story and not isNil(arg_116_1.actors_["1032ui_story"]) then
					arg_116_1.var_.characterEffect1032ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1032ui_story"]) and arg_116_1.var_.characterEffect1032ui_story then
				arg_116_1.var_.characterEffect1032ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1032ui_story", "StoryTimeline/CharAction/story1032/story1032actionlink/1032action446")
			end

			local var_119_2 = 0
			local var_119_3 = 0.375

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_2 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_4 = arg_116_1:GetWordFromCfg(305012027)
				local var_119_5 = arg_116_1:FormatText(var_119_4.content)

				arg_116_1.text_.text = var_119_5

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_7 = 15 <= 0 and var_119_3 or var_119_3 * (utf8.len(var_119_5) / 15)

				if (15 <= 0 and var_119_3 or var_119_3 * (utf8.len(var_119_5) / 15)) > 0 and var_119_3 < var_119_7 then
					arg_116_1.talkMaxDuration = var_119_7

					if var_119_7 + var_119_2 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_7 + var_119_2
					end
				end

				arg_116_1.text_.text = var_119_5
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012027", "story_v_out_305012.awb") ~= 0 then
					local var_119_8 = manager.audio:GetVoiceLength("story_v_out_305012", "305012027", "story_v_out_305012.awb") / 1000

					if var_119_8 + var_119_2 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_2
					end

					if var_119_4.prefab_name ~= "" and arg_116_1.actors_[var_119_4.prefab_name] ~= nil then
						local var_119_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_4.prefab_name].transform, "story_v_out_305012", "305012027", "story_v_out_305012.awb")

						arg_116_1:RecordAudio("305012027", var_119_9)
						arg_116_1:RecordAudio("305012027", var_119_9)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_305012", "305012027", "story_v_out_305012.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_305012", "305012027", "story_v_out_305012.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_10 = math.max(var_119_3, arg_116_1.talkMaxDuration)

			if var_119_2 <= arg_116_1.time_ and arg_116_1.time_ < var_119_2 + var_119_10 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_2) / var_119_10

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_2 + var_119_10 and arg_116_1.time_ < var_119_2 + var_119_10 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play305012028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 305012028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play305012029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1032ui_story"]) and arg_120_1.var_.characterEffect1032ui_story == nil then
				arg_120_1.var_.characterEffect1032ui_story = arg_120_1.actors_["1032ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1032ui_story"]) then
				if arg_120_1.var_.characterEffect1032ui_story and not isNil(arg_120_1.actors_["1032ui_story"]) then
					arg_120_1.var_.characterEffect1032ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1032ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1032ui_story"]) and arg_120_1.var_.characterEffect1032ui_story then
				arg_120_1.var_.characterEffect1032ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1032ui_story.fillRatio = 0.5
			end

			local var_123_1 = 0
			local var_123_2 = 0.25

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(305012028).content)

				arg_120_1.text_.text = var_123_3

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 10 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 10)

				if (10 <= 0 and var_123_2 or var_123_2 * (utf8.len(var_123_3) / 10)) > 0 and var_123_2 < var_123_5 then
					arg_120_1.talkMaxDuration = var_123_5

					if var_123_5 + var_123_1 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + var_123_1
					end
				end

				arg_120_1.text_.text = var_123_3
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_6 = math.max(var_123_2, arg_120_1.talkMaxDuration)

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_6 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_1) / var_123_6

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_1 + var_123_6 and arg_120_1.time_ < var_123_1 + var_123_6 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play305012029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 305012029
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play305012030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1032ui_story = arg_124_1.actors_["1032ui_story"].transform.localPosition
			end

			local var_127_0 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 then
				arg_124_1.actors_["1032ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1032ui_story, Vector3.New(0, 100, 0), (arg_124_1.time_ - 0) / var_127_0)
				arg_124_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1032ui_story"].transform.position).z)
				arg_124_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1032ui_story"].transform.localEulerAngles = arg_124_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 then
				arg_124_1.actors_["1032ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_124_1.actors_["1032ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["1032ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1032ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["1032ui_story"].transform.position).z)
				arg_124_1.actors_["1032ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["1032ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["1032ui_story"].transform.localEulerAngles = arg_124_1.actors_["1032ui_story"].transform.localEulerAngles
			end

			local var_127_1 = 0
			local var_127_2 = 0.8

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(305012029).content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 32 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 32)

				if (32 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 32)) > 0 and var_127_2 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_1
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_6 = math.max(var_127_2, arg_124_1.talkMaxDuration)

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_6 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_1) / var_127_6

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_1 + var_127_6 and arg_124_1.time_ < var_127_1 + var_127_6 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play305012030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 305012030
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play305012031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.5

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_1 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(305012030).content)

				arg_128_1.text_.text = var_131_1

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_3 = 20 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 20)

				if (20 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_1) / 20)) > 0 and var_131_0 < var_131_3 then
					arg_128_1.talkMaxDuration = var_131_3

					if var_131_3 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_3 + 0
					end
				end

				arg_128_1.text_.text = var_131_1
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_4 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_4

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play305012031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 305012031
		arg_132_1.duration_ = 9.2

		local var_132_0 = {
			zh = 4.866,
			ja = 9.2
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
				arg_132_0:Play305012032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1033ui_story = arg_132_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1033ui_story, Vector3.New(0, -1.01, -6.13), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1033ui_story"].transform.position).z)
				arg_132_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1033ui_story"].transform.localEulerAngles = arg_132_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.13)
				arg_132_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1033ui_story"].transform.position).z)
				arg_132_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1033ui_story"].transform.localEulerAngles = arg_132_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_135_1 = arg_132_1.actors_["1032ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1032ui_story = var_135_1.localPosition
			end

			local var_135_2 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 then
				var_135_1.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1032ui_story, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_2)
				var_135_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_1.position).x, (manager.ui.mainCamera.transform.position - var_135_1.position).y, (manager.ui.mainCamera.transform.position - var_135_1.position).z)
				var_135_1.localEulerAngles.z = 0
				var_135_1.localEulerAngles.x = 0
				var_135_1.localEulerAngles = var_135_1.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 then
				var_135_1.localPosition = Vector3.New(0, 100, 0)
				var_135_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_1.position).x, (manager.ui.mainCamera.transform.position - var_135_1.position).y, (manager.ui.mainCamera.transform.position - var_135_1.position).z)
				var_135_1.localEulerAngles.z = 0
				var_135_1.localEulerAngles.x = 0
				var_135_1.localEulerAngles = var_135_1.localEulerAngles
			end

			local var_135_3 = arg_132_1.actors_["1033ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_3) and arg_132_1.var_.characterEffect1033ui_story == nil then
				arg_132_1.var_.characterEffect1033ui_story = var_135_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_4 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 and not isNil(var_135_3) then
				if arg_132_1.var_.characterEffect1033ui_story and not isNil(var_135_3) then
					arg_132_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 and not isNil(var_135_3) and arg_132_1.var_.characterEffect1033ui_story then
				arg_132_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action2_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_135_6 = 0
			local var_135_7 = 0.625

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_8 = arg_132_1:GetWordFromCfg(305012031)
				local var_135_9 = arg_132_1:FormatText(var_135_8.content)

				arg_132_1.text_.text = var_135_9

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 25 <= 0 and var_135_7 or var_135_7 * (utf8.len(var_135_9) / 25)

				if (25 <= 0 and var_135_7 or var_135_7 * (utf8.len(var_135_9) / 25)) > 0 and var_135_7 < var_135_11 then
					arg_132_1.talkMaxDuration = var_135_11

					if var_135_11 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_11 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_9
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012031", "story_v_out_305012.awb") ~= 0 then
					local var_135_12 = manager.audio:GetVoiceLength("story_v_out_305012", "305012031", "story_v_out_305012.awb") / 1000

					if var_135_12 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_12 + var_135_6
					end

					if var_135_8.prefab_name ~= "" and arg_132_1.actors_[var_135_8.prefab_name] ~= nil then
						local var_135_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_8.prefab_name].transform, "story_v_out_305012", "305012031", "story_v_out_305012.awb")

						arg_132_1:RecordAudio("305012031", var_135_13)
						arg_132_1:RecordAudio("305012031", var_135_13)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_305012", "305012031", "story_v_out_305012.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_305012", "305012031", "story_v_out_305012.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_14 and arg_132_1.time_ < var_135_6 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1032ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play305012032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 305012032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play305012033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1033ui_story"]) and arg_136_1.var_.characterEffect1033ui_story == nil then
				arg_136_1.var_.characterEffect1033ui_story = arg_136_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1033ui_story"]) then
				if arg_136_1.var_.characterEffect1033ui_story and not isNil(arg_136_1.actors_["1033ui_story"]) then
					arg_136_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_0)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1033ui_story"]) and arg_136_1.var_.characterEffect1033ui_story then
				arg_136_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_139_1 = 0
			local var_139_2 = 0.2

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_3 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(305012032).content)

				arg_136_1.text_.text = var_139_3

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_5 = 8 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 8)

				if (8 <= 0 and var_139_2 or var_139_2 * (utf8.len(var_139_3) / 8)) > 0 and var_139_2 < var_139_5 then
					arg_136_1.talkMaxDuration = var_139_5

					if var_139_5 + var_139_1 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + var_139_1
					end
				end

				arg_136_1.text_.text = var_139_3
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_6 = math.max(var_139_2, arg_136_1.talkMaxDuration)

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_6 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_1) / var_139_6

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_1 + var_139_6 and arg_136_1.time_ < var_139_1 + var_139_6 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play305012033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 305012033
		arg_140_1.duration_ = 6.4

		local var_140_0 = {
			zh = 6.4,
			ja = 1.333
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play305012034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1037ui_story = arg_140_1.actors_["1037ui_story"].transform.localPosition
			end

			local var_143_0 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				arg_140_1.actors_["1037ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1037ui_story"].transform.position).z)
				arg_140_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1037ui_story"].transform.localEulerAngles = arg_140_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				arg_140_1.actors_["1037ui_story"].transform.localPosition = Vector3.New(0, -1.09, -5.81)
				arg_140_1.actors_["1037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1037ui_story"].transform.position).z)
				arg_140_1.actors_["1037ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1037ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1037ui_story"].transform.localEulerAngles = arg_140_1.actors_["1037ui_story"].transform.localEulerAngles
			end

			local var_143_1 = arg_140_1.actors_["1033ui_story"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1033ui_story = var_143_1.localPosition
			end

			local var_143_2 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_2 then
				var_143_1.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 0) / var_143_2)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_2 and arg_140_1.time_ < 0 + var_143_2 + arg_143_0 then
				var_143_1.localPosition = Vector3.New(0, 100, 0)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			local var_143_3 = arg_140_1.actors_["1037ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect1037ui_story == nil then
				arg_140_1.var_.characterEffect1037ui_story = var_143_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_4 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 and not isNil(var_143_3) then
				if arg_140_1.var_.characterEffect1037ui_story and not isNil(var_143_3) then
					arg_140_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect1037ui_story then
				arg_140_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_143_6 = 0
			local var_143_7 = 0.775

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_8 = arg_140_1:GetWordFromCfg(305012033)
				local var_143_9 = arg_140_1:FormatText(var_143_8.content)

				arg_140_1.text_.text = var_143_9

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 30 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_9) / 30)

				if (30 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_9) / 30)) > 0 and var_143_7 < var_143_11 then
					arg_140_1.talkMaxDuration = var_143_11

					if var_143_11 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_11 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_9
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012033", "story_v_out_305012.awb") ~= 0 then
					local var_143_12 = manager.audio:GetVoiceLength("story_v_out_305012", "305012033", "story_v_out_305012.awb") / 1000

					if var_143_12 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_6
					end

					if var_143_8.prefab_name ~= "" and arg_140_1.actors_[var_143_8.prefab_name] ~= nil then
						local var_143_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_8.prefab_name].transform, "story_v_out_305012", "305012033", "story_v_out_305012.awb")

						arg_140_1:RecordAudio("305012033", var_143_13)
						arg_140_1:RecordAudio("305012033", var_143_13)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_305012", "305012033", "story_v_out_305012.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_305012", "305012033", "story_v_out_305012.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_14 and arg_140_1.time_ < var_143_6 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
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
	Play305012034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 305012034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play305012035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1037ui_story"]) and arg_144_1.var_.characterEffect1037ui_story == nil then
				arg_144_1.var_.characterEffect1037ui_story = arg_144_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1037ui_story"]) then
				if arg_144_1.var_.characterEffect1037ui_story and not isNil(arg_144_1.actors_["1037ui_story"]) then
					arg_144_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1037ui_story"]) and arg_144_1.var_.characterEffect1037ui_story then
				arg_144_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_147_1 = 0
			local var_147_2 = 0.475

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(305012034).content)

				arg_144_1.text_.text = var_147_3

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 19 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_3) / 19)

				if (19 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_3) / 19)) > 0 and var_147_2 < var_147_5 then
					arg_144_1.talkMaxDuration = var_147_5

					if var_147_5 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + var_147_1
					end
				end

				arg_144_1.text_.text = var_147_3
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_6 = math.max(var_147_2, arg_144_1.talkMaxDuration)

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_6 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_1) / var_147_6

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_1 + var_147_6 and arg_144_1.time_ < var_147_1 + var_147_6 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play305012035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 305012035
		arg_148_1.duration_ = 5.8

		local var_148_0 = {
			zh = 5.8,
			ja = 1.999999999999
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
				arg_148_0:Play305012036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1037ui_story"]) and arg_148_1.var_.characterEffect1037ui_story == nil then
				arg_148_1.var_.characterEffect1037ui_story = arg_148_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1037ui_story"]) then
				if arg_148_1.var_.characterEffect1037ui_story and not isNil(arg_148_1.actors_["1037ui_story"]) then
					arg_148_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1037ui_story"]) and arg_148_1.var_.characterEffect1037ui_story then
				arg_148_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_151_2 = 0
			local var_151_3 = 0.675

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_2 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_4 = arg_148_1:GetWordFromCfg(305012035)
				local var_151_5 = arg_148_1:FormatText(var_151_4.content)

				arg_148_1.text_.text = var_151_5

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_7 = 26 <= 0 and var_151_3 or var_151_3 * (utf8.len(var_151_5) / 26)

				if (26 <= 0 and var_151_3 or var_151_3 * (utf8.len(var_151_5) / 26)) > 0 and var_151_3 < var_151_7 then
					arg_148_1.talkMaxDuration = var_151_7

					if var_151_7 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_7 + var_151_2
					end
				end

				arg_148_1.text_.text = var_151_5
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012035", "story_v_out_305012.awb") ~= 0 then
					local var_151_8 = manager.audio:GetVoiceLength("story_v_out_305012", "305012035", "story_v_out_305012.awb") / 1000

					if var_151_8 + var_151_2 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_2
					end

					if var_151_4.prefab_name ~= "" and arg_148_1.actors_[var_151_4.prefab_name] ~= nil then
						local var_151_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_4.prefab_name].transform, "story_v_out_305012", "305012035", "story_v_out_305012.awb")

						arg_148_1:RecordAudio("305012035", var_151_9)
						arg_148_1:RecordAudio("305012035", var_151_9)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_305012", "305012035", "story_v_out_305012.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_305012", "305012035", "story_v_out_305012.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_3, arg_148_1.talkMaxDuration)

			if var_151_2 <= arg_148_1.time_ and arg_148_1.time_ < var_151_2 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_2) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_2 + var_151_10 and arg_148_1.time_ < var_151_2 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play305012036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 305012036
		arg_152_1.duration_ = 5.2

		local var_152_0 = {
			zh = 5.2,
			ja = 1.999999999999
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
				arg_152_0:Play305012037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action445")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_155_0 = 0
			local var_155_1 = 0.7

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_2 = arg_152_1:GetWordFromCfg(305012036)
				local var_155_3 = arg_152_1:FormatText(var_155_2.content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 28 <= 0 and var_155_1 or var_155_1 * (utf8.len(var_155_3) / 28)

				if (28 <= 0 and var_155_1 or var_155_1 * (utf8.len(var_155_3) / 28)) > 0 and var_155_1 < var_155_5 then
					arg_152_1.talkMaxDuration = var_155_5

					if var_155_5 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305012", "305012036", "story_v_out_305012.awb") ~= 0 then
					local var_155_6 = manager.audio:GetVoiceLength("story_v_out_305012", "305012036", "story_v_out_305012.awb") / 1000

					if var_155_6 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_6 + var_155_0
					end

					if var_155_2.prefab_name ~= "" and arg_152_1.actors_[var_155_2.prefab_name] ~= nil then
						local var_155_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_2.prefab_name].transform, "story_v_out_305012", "305012036", "story_v_out_305012.awb")

						arg_152_1:RecordAudio("305012036", var_155_7)
						arg_152_1:RecordAudio("305012036", var_155_7)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_305012", "305012036", "story_v_out_305012.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_305012", "305012036", "story_v_out_305012.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_8 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_8 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_8

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_8 and arg_152_1.time_ < var_155_0 + var_155_8 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play305012037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 305012037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
			arg_156_1.auto_ = false
		end

		function arg_156_1.playNext_(arg_158_0)
			arg_156_1.onStoryFinished_()
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1037ui_story"]) and arg_156_1.var_.characterEffect1037ui_story == nil then
				arg_156_1.var_.characterEffect1037ui_story = arg_156_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1037ui_story"]) then
				if arg_156_1.var_.characterEffect1037ui_story and not isNil(arg_156_1.actors_["1037ui_story"]) then
					arg_156_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1037ui_story"]) and arg_156_1.var_.characterEffect1037ui_story then
				arg_156_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_159_1 = 0
			local var_159_2 = 0.125

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_3 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(305012037).content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 5 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 5)

				if (5 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 5)) > 0 and var_159_2 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_6 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_6 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_6

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_6 and arg_156_1.time_ < var_159_1 + var_159_6 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0408",
		"TextureConfig/Background/S0408a",
		"TextureConfig/Background/B13a",
		"TextureConfig/Background/S0405"
	},
	voices = {
		"story_v_out_305012.awb"
	}
}
