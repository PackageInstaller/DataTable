return {
	Play417011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417011001
		arg_1_1.duration_ = 32.43

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417011006(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
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

			local var_4_11 = 0.433333333333333

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				SetActive(arg_1_1.dialog_, false)
				SetActive(arg_1_1.allBtn_.gameObject, true)
				arg_1_1.hideBtnsController_:SetSelectedIndex(1)
				arg_1_1:StopAllVoice()
				arg_1_1:PlayOnlyBgm()

				arg_1_1.marker = "104170101stop"

				manager.video:Play("SofdecAsset/story/story_1041701.usm", function(arg_6_0)
					if arg_1_1.state_ == "playing" then
						arg_1_1:JumpToEnd()
					end

					if arg_1_1.playNext_ and not arg_1_1.auto_ then
						arg_1_1.playNext_(1)
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_7_0)
					arg_1_1.state_ = arg_7_0 and "pause" or "playing"
				end, 1041701)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_4_12 = 32

			if var_4_11 <= arg_1_1.time_ and arg_1_1.time_ < var_4_11 + var_4_12 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_11 + var_4_12 and arg_1_1.time_ < var_4_11 + var_4_12 + arg_4_0 then
				arg_1_1.marker = ""
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(false)
				arg_1_1.dialog_:SetActive(false)
				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417011006 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 417011006
		arg_8_1.duration_ = 5.07

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play417011007(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				local var_11_0 = arg_8_1.bgs_.STblack

				arg_8_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_11_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_11_1 = var_11_0:GetComponent("SpriteRenderer")

				if var_11_1 and var_11_1.sprite then
					local var_11_2 = 2 * (var_11_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_11_0.transform.localScale = Vector3.New(var_11_2 / var_11_1.sprite.bounds.size.y < var_11_2 * manager.ui.mainCameraCom_.aspect / var_11_1.sprite.bounds.size.x and var_11_2 * manager.ui.mainCameraCom_.aspect / var_11_1.sprite.bounds.size.x or var_11_2 / var_11_1.sprite.bounds.size.y, var_11_2 / var_11_1.sprite.bounds.size.y < var_11_2 * manager.ui.mainCameraCom_.aspect / var_11_1.sprite.bounds.size.x and var_11_2 * manager.ui.mainCameraCom_.aspect / var_11_1.sprite.bounds.size.x or var_11_2 / var_11_1.sprite.bounds.size.y, 0)
				end

				for iter_11_0, iter_11_1 in pairs(arg_8_1.bgs_) do
					if iter_11_0 ~= "STblack" then
						iter_11_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_11_3 = 0

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_3 + arg_11_0 then
				arg_8_1.allBtn_.enabled = false
			end

			if arg_8_1.time_ >= var_11_3 + 0.3 and arg_8_1.time_ < var_11_3 + 0.3 + arg_11_0 then
				arg_8_1.allBtn_.enabled = true
			end

			local var_11_4 = 0

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_4 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_5 = 1.8

			if var_11_4 <= arg_8_1.time_ and arg_8_1.time_ < var_11_4 + var_11_5 then
				local var_11_6 = Color.New(0, 0, 0)

				var_11_6.a = Mathf.Lerp(1, 0, (arg_8_1.time_ - var_11_4) / var_11_5)
				arg_8_1.mask_.color = var_11_6
			end

			if arg_8_1.time_ >= var_11_4 + var_11_5 and arg_8_1.time_ < var_11_4 + var_11_5 + arg_11_0 then
				local var_11_7 = Color.New(0, 0, 0)

				arg_8_1.mask_.enabled = false
				var_11_7.a = 0
				arg_8_1.mask_.color = var_11_7
			end

			if 0.516666666666667 < arg_8_1.time_ and arg_8_1.time_ <= 0.516666666666667 + arg_11_0 then
				arg_8_1.fswbg_:SetActive(true)
				arg_8_1.dialog_:SetActive(false)

				arg_8_1.fswtw_.percent = 0
				arg_8_1.fswt_.text = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(417011006).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.fswt_)

				arg_8_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_8_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_8_1.fswtw_:SetDirty()

				arg_8_1.typewritterCharCountI18N = 0

				SetActive(arg_8_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_8_1:ShowNextGo(false)
			end

			local var_11_8 = 1.2

			if 1.2 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.var_.oldValueTypewriter = arg_8_1.fswtw_.percent

				SetActive(arg_8_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_8_1:ShowNextGo(false)
			end

			local var_11_9 = 9
			local var_11_10 = 0.6
			local var_11_11, var_11_12 = arg_8_1:GetPercentByPara(arg_8_1:FormatText(arg_8_1:GetWordFromCfg(417011006).content), 1)

			if var_11_8 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				local var_11_13 = var_11_9 <= 0 and var_11_10 or var_11_10 * ((var_11_12 - arg_8_1.typewritterCharCountI18N) / var_11_9)

				if (var_11_9 <= 0 and var_11_10 or var_11_10 * ((var_11_12 - arg_8_1.typewritterCharCountI18N) / var_11_9)) > 0 and var_11_10 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end
			end

			local var_11_14 = math.max(0.6, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_14 then
				arg_8_1.fswtw_.percent = Mathf.Lerp(arg_8_1.var_.oldValueTypewriter, var_11_11, (arg_8_1.time_ - var_11_8) / var_11_14)
				arg_8_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_8_1.fswtw_:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_14 and arg_8_1.time_ < var_11_8 + var_11_14 + arg_11_0 then
				arg_8_1.fswtw_.percent = var_11_11

				arg_8_1.fswtw_:SetDirty()
				arg_8_1:ShowNextGo(true)

				arg_8_1.typewritterCharCountI18N = var_11_12
			end

			if 0.0166666666666666 < arg_8_1.time_ and arg_8_1.time_ <= 0.0166666666666666 + arg_11_0 then
				local var_11_15 = arg_8_1.fswbg_.transform:Find("textbox/adapt/content") or arg_8_1.fswbg_.transform:Find("textbox/content")
				local var_11_16 = arg_8_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_11_17 = var_11_15:GetComponent("RectTransform")

				var_11_15:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_11_17.offsetMin = Vector2.New(0, 0)
				var_11_17.offsetMax = Vector2.New(0, 0)
			end

			local var_11_18 = 2
			local var_11_19 = manager.audio:GetVoiceLength("story_v_out_417011", "417011006", "story_v_out_417011.awb") / 1000

			if var_11_19 > 0 and 3.066 < var_11_19 and var_11_19 + var_11_18 > arg_8_1.duration_ then
				arg_8_1.duration_ = var_11_19 + var_11_18
			end

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1:AudioAction("play", "voice", "story_v_out_417011", "417011006", "story_v_out_417011.awb")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.fswbg_:SetActive(false)
				arg_8_1.dialog_:SetActive(false)
				SetActive(arg_8_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_8_1:ShowNextGo(false)
			end

			local var_11_21 = 0

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_21 + arg_11_0 then
				SetActive(arg_8_1.dialog_, true)
				SetActive(arg_8_1.allBtn_.gameObject, true)
				arg_8_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_8_1.isInLoopVideo = false
			end

			local var_11_22 = 0.2

			if var_11_21 <= arg_8_1.time_ and arg_8_1.time_ < var_11_21 + var_11_22 then
				-- block empty
			end

			if arg_8_1.time_ >= var_11_21 + var_11_22 and arg_8_1.time_ < var_11_21 + var_11_22 + arg_11_0 then
				arg_8_1.marker = ""
			end

			if 0.01 < arg_8_1.time_ and arg_8_1.time_ <= 0.01 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_thunderloop", "")
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play417011007 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 417011007
		arg_12_1.duration_ = 10.1

		local var_12_0 = {
			zh = 9.533,
			ja = 10.1
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
				arg_12_0:Play417011008(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.bgs_.SS1701 == nil then
				local var_15_0 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1701")
				var_15_0.name = "SS1701"
				var_15_0.transform.parent = arg_12_1.stage_.transform
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_.SS1701 = var_15_0
			end

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= 2 + arg_15_0 then
				local var_15_1 = arg_12_1.bgs_.SS1701

				arg_12_1.bgs_.SS1701.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_15_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_2 = var_15_1:GetComponent("SpriteRenderer")

				if var_15_2 and var_15_2.sprite then
					local var_15_3 = 2 * (var_15_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_15_1.transform.localScale = Vector3.New(var_15_3 / var_15_2.sprite.bounds.size.y < var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x and var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x or var_15_3 / var_15_2.sprite.bounds.size.y, var_15_3 / var_15_2.sprite.bounds.size.y < var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x and var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x or var_15_3 / var_15_2.sprite.bounds.size.y, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "SS1701" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_4 = 0

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_5 = 2

			if var_15_4 <= arg_12_1.time_ and arg_12_1.time_ < var_15_4 + var_15_5 then
				local var_15_6 = Color.New(0, 0, 0)

				var_15_6.a = Mathf.Lerp(0, 1, (arg_12_1.time_ - var_15_4) / var_15_5)
				arg_12_1.mask_.color = var_15_6
			end

			if arg_12_1.time_ >= var_15_4 + var_15_5 and arg_12_1.time_ < var_15_4 + var_15_5 + arg_15_0 then
				local var_15_7 = Color.New(0, 0, 0)

				var_15_7.a = 1
				arg_12_1.mask_.color = var_15_7
			end

			local var_15_8 = 2

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_9 = 2.06666666666667

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_9 then
				local var_15_10 = Color.New(0, 0, 0)

				var_15_10.a = Mathf.Lerp(1, 0, (arg_12_1.time_ - var_15_8) / var_15_9)
				arg_12_1.mask_.color = var_15_10
			end

			if arg_12_1.time_ >= var_15_8 + var_15_9 and arg_12_1.time_ < var_15_8 + var_15_9 + arg_15_0 then
				local var_15_11 = Color.New(0, 0, 0)

				arg_12_1.mask_.enabled = false
				var_15_11.a = 0
				arg_12_1.mask_.color = var_15_11
			end

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= 2 + arg_15_0 then
				arg_12_1.fswbg_:SetActive(false)
				arg_12_1.dialog_:SetActive(false)
				SetActive(arg_12_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_12_1:ShowNextGo(false)
			end

			if 2.01666666666667 < arg_12_1.time_ and arg_12_1.time_ <= 2.01666666666667 + arg_15_0 then
				arg_12_1.fswbg_:SetActive(false)
				arg_12_1.dialog_:SetActive(false)
				SetActive(arg_12_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_12_1:ShowNextGo(false)
			end

			if 2.01666666666667 < arg_12_1.time_ and arg_12_1.time_ <= 2.01666666666667 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep01", "")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_15_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_15 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_15

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_15
						arg_12_1.bgmTxt2_.text = var_15_15
					end

					if arg_12_1.bgmTimer then
						arg_12_1.bgmTimer:Stop()

						arg_12_1.bgmTimer = nil
					end

					if arg_12_1.settingData.show_music_name == 1 then
						arg_12_1.musicController:SetSelectedState("show")
						arg_12_1.musicAnimator_:Play("open", 0, 0)

						if arg_12_1.settingData.music_time ~= 0 then
							arg_12_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_12_1.settingData.music_time), function()
								if arg_12_1 == nil or isNil(arg_12_1.bgmTxt_) then
									return
								end

								arg_12_1.musicController:SetSelectedState("hide")
								arg_12_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= 2 + arg_15_0 then
				arg_12_1:AudioAction("play", "music", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard.awb")

				local var_15_18 = manager.audio:GetAudioName("bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard")

				if "" ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_18 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_18

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_18
						arg_12_1.bgmTxt2_.text = var_15_18
					end

					if arg_12_1.bgmTimer then
						arg_12_1.bgmTimer:Stop()

						arg_12_1.bgmTimer = nil
					end

					if arg_12_1.settingData.show_music_name == 1 then
						arg_12_1.musicController:SetSelectedState("show")
						arg_12_1.musicAnimator_:Play("open", 0, 0)

						if arg_12_1.settingData.music_time ~= 0 then
							arg_12_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_12_1.settingData.music_time), function()
								if arg_12_1 == nil or isNil(arg_12_1.bgmTxt_) then
									return
								end

								arg_12_1.musicController:SetSelectedState("hide")
								arg_12_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_15_19 = 2

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1.timestampController_:SetSelectedState("show")
				arg_12_1.timestampAni_:Play("in")

				arg_12_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1701")

				arg_12_1.timestampColorController_:SetSelectedState("hot")
				arg_12_1.timeColdImg_:SetAlpha(0.031)

				arg_12_1.text_timeText_.text = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(501001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_timeText_)

				arg_12_1.text_siteText_.text = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(501002).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_siteText_)
			end

			if arg_12_1.time_ >= var_15_19 + 3 and arg_12_1.time_ < var_15_19 + 3 + arg_15_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_12_1.timestampAni_, "out", function()
					arg_12_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_15_20 = 5

			if 5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_20 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_21 = 1.2

			if var_15_20 <= arg_12_1.time_ and arg_12_1.time_ < var_15_20 + var_15_21 then
				local var_15_22 = Color.New(0, 0, 0)

				var_15_22.a = Mathf.Lerp(0, 1, (arg_12_1.time_ - var_15_20) / var_15_21)
				arg_12_1.mask_.color = var_15_22
			end

			if arg_12_1.time_ >= var_15_20 + var_15_21 and arg_12_1.time_ < var_15_20 + var_15_21 + arg_15_0 then
				local var_15_23 = Color.New(0, 0, 0)

				var_15_23.a = 1
				arg_12_1.mask_.color = var_15_23
			end

			local var_15_24 = 6.2

			if 6.2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_24 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_25 = 1.4

			if var_15_24 <= arg_12_1.time_ and arg_12_1.time_ < var_15_24 + var_15_25 then
				local var_15_26 = Color.New(0, 0, 0)

				var_15_26.a = Mathf.Lerp(1, 0, (arg_12_1.time_ - var_15_24) / var_15_25)
				arg_12_1.mask_.color = var_15_26
			end

			if arg_12_1.time_ >= var_15_24 + var_15_25 and arg_12_1.time_ < var_15_24 + var_15_25 + arg_15_0 then
				local var_15_27 = Color.New(0, 0, 0)

				arg_12_1.mask_.enabled = false
				var_15_27.a = 0
				arg_12_1.mask_.color = var_15_27
			end

			local var_15_28 = 2.01666666666667

			if 2.01666666666667 < arg_12_1.time_ and arg_12_1.time_ <= var_15_28 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			if arg_12_1.time_ >= var_15_28 + 2.98333333333333 and arg_12_1.time_ < var_15_28 + 2.98333333333333 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_29 = 7.6
			local var_15_30 = 0.15

			if 7.6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_29 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_31 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_31:setOnUpdate(LuaHelper.FloatAction(function(arg_19_0)
					arg_12_1.dialogCg_.alpha = arg_19_0
				end))
				var_15_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_32 = arg_12_1:GetWordFromCfg(417011007)
				local var_15_33 = arg_12_1:FormatText(var_15_32.content)

				arg_12_1.text_.text = var_15_33

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_35 = 6 <= 0 and var_15_30 or var_15_30 * (utf8.len(var_15_33) / 6)

				if (6 <= 0 and var_15_30 or var_15_30 * (utf8.len(var_15_33) / 6)) > 0 and var_15_30 < var_15_35 then
					arg_12_1.talkMaxDuration = var_15_35
					var_15_29 = var_15_29 + 0.3

					if var_15_35 + var_15_29 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_35 + var_15_29
					end
				end

				arg_12_1.text_.text = var_15_33
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011007", "story_v_out_417011.awb") ~= 0 then
					local var_15_36 = manager.audio:GetVoiceLength("story_v_out_417011", "417011007", "story_v_out_417011.awb") / 1000

					if var_15_36 + var_15_29 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_36 + var_15_29
					end

					if var_15_32.prefab_name ~= "" and arg_12_1.actors_[var_15_32.prefab_name] ~= nil then
						local var_15_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_32.prefab_name].transform, "story_v_out_417011", "417011007", "story_v_out_417011.awb")

						arg_12_1:RecordAudio("417011007", var_15_37)
						arg_12_1:RecordAudio("417011007", var_15_37)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_417011", "417011007", "story_v_out_417011.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_417011", "417011007", "story_v_out_417011.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_38 = var_15_29 + 0.3
			local var_15_39 = math.max(var_15_30, arg_12_1.talkMaxDuration)

			if var_15_29 + 0.3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_38 + var_15_39 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_38) / var_15_39

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_38 + var_15_39 and arg_12_1.time_ < var_15_38 + var_15_39 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play417011008 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 417011008
		arg_21_1.duration_ = 4.07

		local var_21_0 = {
			zh = 3.033,
			ja = 4.066
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
				arg_21_0:Play417011009(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.3

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(417011008)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 12 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 12)

				if (12 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 12)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011008", "story_v_out_417011.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_417011", "417011008", "story_v_out_417011.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_417011", "417011008", "story_v_out_417011.awb")

						arg_21_1:RecordAudio("417011008", var_24_6)
						arg_21_1:RecordAudio("417011008", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_417011", "417011008", "story_v_out_417011.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_417011", "417011008", "story_v_out_417011.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play417011009 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 417011009
		arg_25_1.duration_ = 4.67

		local var_25_0 = {
			zh = 4.666,
			ja = 3.833
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
				arg_25_0:Play417011010(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.325

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(417011009)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 13 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 13)

				if (13 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 13)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011009", "story_v_out_417011.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_417011", "417011009", "story_v_out_417011.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_417011", "417011009", "story_v_out_417011.awb")

						arg_25_1:RecordAudio("417011009", var_28_6)
						arg_25_1:RecordAudio("417011009", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_417011", "417011009", "story_v_out_417011.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_417011", "417011009", "story_v_out_417011.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play417011010 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 417011010
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play417011011(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.15

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(417011010).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 46 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 46)

				if (46 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 46)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play417011011 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 417011011
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play417011012(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.25

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(417011011).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 50 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 50)

				if (50 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 50)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play417011012 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 417011012
		arg_37_1.duration_ = 3.1

		local var_37_0 = {
			zh = 2.2,
			ja = 3.1
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
				arg_37_0:Play417011013(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.2

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(417011012)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 8 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 8)

				if (8 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 8)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011012", "story_v_out_417011.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_417011", "417011012", "story_v_out_417011.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_417011", "417011012", "story_v_out_417011.awb")

						arg_37_1:RecordAudio("417011012", var_40_6)
						arg_37_1:RecordAudio("417011012", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_417011", "417011012", "story_v_out_417011.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_417011", "417011012", "story_v_out_417011.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play417011013 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 417011013
		arg_41_1.duration_ = 6.13

		local var_41_0 = {
			zh = 5.733,
			ja = 6.133
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
				arg_41_0:Play417011014(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.35

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(417011013)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 14 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 14)

				if (14 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 14)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011013", "story_v_out_417011.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_417011", "417011013", "story_v_out_417011.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_417011", "417011013", "story_v_out_417011.awb")

						arg_41_1:RecordAudio("417011013", var_44_6)
						arg_41_1:RecordAudio("417011013", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_417011", "417011013", "story_v_out_417011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_417011", "417011013", "story_v_out_417011.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play417011014 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 417011014
		arg_45_1.duration_ = 10.8

		local var_45_0 = {
			zh = 6.933,
			ja = 10.8
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
				arg_45_0:Play417011015(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.625

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(417011014)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 25 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 25)

				if (25 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 25)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011014", "story_v_out_417011.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_417011", "417011014", "story_v_out_417011.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_417011", "417011014", "story_v_out_417011.awb")

						arg_45_1:RecordAudio("417011014", var_48_6)
						arg_45_1:RecordAudio("417011014", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_417011", "417011014", "story_v_out_417011.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_417011", "417011014", "story_v_out_417011.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play417011015 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 417011015
		arg_49_1.duration_ = 10

		local var_49_0 = {
			zh = 6.233,
			ja = 10
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
				arg_49_0:Play417011016(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.575

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(417011015)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 23 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 23)

				if (23 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 23)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011015", "story_v_out_417011.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_417011", "417011015", "story_v_out_417011.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_417011", "417011015", "story_v_out_417011.awb")

						arg_49_1:RecordAudio("417011015", var_52_6)
						arg_49_1:RecordAudio("417011015", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_417011", "417011015", "story_v_out_417011.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_417011", "417011015", "story_v_out_417011.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play417011016 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 417011016
		arg_53_1.duration_ = 13.63

		local var_53_0 = {
			zh = 13.633,
			ja = 10
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
				arg_53_0:Play417011017(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.575

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(417011016)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 23 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 23)

				if (23 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 23)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011016", "story_v_out_417011.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_417011", "417011016", "story_v_out_417011.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_417011", "417011016", "story_v_out_417011.awb")

						arg_53_1:RecordAudio("417011016", var_56_6)
						arg_53_1:RecordAudio("417011016", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_417011", "417011016", "story_v_out_417011.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_417011", "417011016", "story_v_out_417011.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play417011017 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 417011017
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play417011018(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0.05 < arg_57_1.time_ and arg_57_1.time_ <= 0.05 + arg_60_0 then
				arg_57_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_fish", "")
			end

			local var_60_1 = 0
			local var_60_2 = 1.125

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(417011017).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 45 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 45)

				if (45 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 45)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play417011018 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 417011018
		arg_61_1.duration_ = 9.07

		local var_61_0 = {
			zh = 7.16666666666667,
			ja = 9.06666666666667
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
				arg_61_0:Play417011019(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPosSS1701 = arg_61_1.bgs_.SS1701.transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.bgs_.SS1701.transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPosSS1701, Vector3.New(0, 1, 10), (arg_61_1.time_ - 0) / var_64_0)
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.bgs_.SS1701.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_64_1 = arg_61_1.bgs_.SS1701.transform

			if 0.034 < arg_61_1.time_ and arg_61_1.time_ <= 0.034 + arg_64_0 then
				arg_61_1.var_.moveOldPosSS1701 = var_64_1.localPosition
			end

			local var_64_2 = 2.08266666666667

			if 0.034 <= arg_61_1.time_ and arg_61_1.time_ < 0.034 + var_64_2 then
				var_64_1.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPosSS1701, Vector3.New(0, 1, 9), (arg_61_1.time_ - 0.034) / var_64_2)
			end

			if arg_61_1.time_ >= 0.034 + var_64_2 and arg_61_1.time_ < 0.034 + var_64_2 + arg_64_0 then
				var_64_1.localPosition = Vector3.New(0, 1, 9)
			end

			local var_64_3 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			if arg_61_1.time_ >= var_64_3 + 2.11666666666667 and arg_61_1.time_ < var_64_3 + 2.11666666666667 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_4 = 1.76666666666667
			local var_64_5 = 0.35

			if 1.76666666666667 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_6 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_6:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_7 = arg_61_1:GetWordFromCfg(417011018)
				local var_64_8 = arg_61_1:FormatText(var_64_7.content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 14 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_8) / 14)

				if (14 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_8) / 14)) > 0 and var_64_5 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10
					var_64_4 = var_64_4 + 0.3

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011018", "story_v_out_417011.awb") ~= 0 then
					local var_64_11 = manager.audio:GetVoiceLength("story_v_out_417011", "417011018", "story_v_out_417011.awb") / 1000

					if var_64_11 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_4
					end

					if var_64_7.prefab_name ~= "" and arg_61_1.actors_[var_64_7.prefab_name] ~= nil then
						local var_64_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_7.prefab_name].transform, "story_v_out_417011", "417011018", "story_v_out_417011.awb")

						arg_61_1:RecordAudio("417011018", var_64_12)
						arg_61_1:RecordAudio("417011018", var_64_12)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_417011", "417011018", "story_v_out_417011.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_417011", "417011018", "story_v_out_417011.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_13 = var_64_4 + 0.3
			local var_64_14 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_13 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_13) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_13 + var_64_14 and arg_61_1.time_ < var_64_13 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.08266666666667,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play417011019 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 417011019
		arg_67_1.duration_ = 5.87

		local var_67_0 = {
			zh = 5.866,
			ja = 4.9
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play417011020(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.5

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(417011019)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 20 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 20)

				if (20 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 20)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011019", "story_v_out_417011.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_417011", "417011019", "story_v_out_417011.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_417011", "417011019", "story_v_out_417011.awb")

						arg_67_1:RecordAudio("417011019", var_70_6)
						arg_67_1:RecordAudio("417011019", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_417011", "417011019", "story_v_out_417011.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_417011", "417011019", "story_v_out_417011.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_7 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_7 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_7

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_7 and arg_67_1.time_ < 0 + var_70_7 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play417011020 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 417011020
		arg_71_1.duration_ = 12.43

		local var_71_0 = {
			zh = 3.766,
			ja = 12.433
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play417011021(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.3

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:GetWordFromCfg(417011020)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 12 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 12)

				if (12 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 12)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011020", "story_v_out_417011.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_417011", "417011020", "story_v_out_417011.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_417011", "417011020", "story_v_out_417011.awb")

						arg_71_1:RecordAudio("417011020", var_74_6)
						arg_71_1:RecordAudio("417011020", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_417011", "417011020", "story_v_out_417011.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_417011", "417011020", "story_v_out_417011.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_7 = math.max(var_74_0, arg_71_1.talkMaxDuration)

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_7 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - 0) / var_74_7

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= 0 + var_74_7 and arg_71_1.time_ < 0 + var_74_7 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play417011021 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 417011021
		arg_75_1.duration_ = 10.4

		local var_75_0 = {
			zh = 10.4,
			ja = 9.5
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play417011022(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.675

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(417011021)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 27 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 27)

				if (27 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 27)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011021", "story_v_out_417011.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_417011", "417011021", "story_v_out_417011.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_417011", "417011021", "story_v_out_417011.awb")

						arg_75_1:RecordAudio("417011021", var_78_6)
						arg_75_1:RecordAudio("417011021", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_417011", "417011021", "story_v_out_417011.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_417011", "417011021", "story_v_out_417011.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play417011022 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 417011022
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play417011023(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0.1 < arg_79_1.time_ and arg_79_1.time_ <= 0.1 + arg_82_0 then
				arg_79_1:AudioAction("play", "effect", "se_story_16", "se_story_16_thunder02", "")
			end

			local var_82_1 = 0
			local var_82_2 = 1.025

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(417011022).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 41 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 41)

				if (41 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 41)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_6 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_6

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_6 and arg_79_1.time_ < var_82_1 + var_82_6 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play417011023 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 417011023
		arg_83_1.duration_ = 13.87

		local var_83_0 = {
			zh = 9.99966666666667,
			ja = 13.8666666666667
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play417011024(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPosSS1701 = arg_83_1.bgs_.SS1701.transform.localPosition
			end

			local var_86_0 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.bgs_.SS1701.transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPosSS1701, Vector3.New(0, 1, 9), (arg_83_1.time_ - 0) / var_86_0)
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.bgs_.SS1701.transform.localPosition = Vector3.New(0, 1, 9)
			end

			local var_86_1 = arg_83_1.bgs_.SS1701.transform

			if 0.034 < arg_83_1.time_ and arg_83_1.time_ <= 0.034 + arg_86_0 then
				arg_83_1.var_.moveOldPosSS1701 = var_86_1.localPosition
			end

			local var_86_2 = 2.566

			if 0.034 <= arg_83_1.time_ and arg_83_1.time_ < 0.034 + var_86_2 then
				var_86_1.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPosSS1701, Vector3.New(0, 0.73, 7), (arg_83_1.time_ - 0.034) / var_86_2)
			end

			if arg_83_1.time_ >= 0.034 + var_86_2 and arg_83_1.time_ < 0.034 + var_86_2 + arg_86_0 then
				var_86_1.localPosition = Vector3.New(0, 0.73, 7)
			end

			local var_86_3 = 0

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 then
				arg_83_1.allBtn_.enabled = false
			end

			if arg_83_1.time_ >= var_86_3 + 2.4 and arg_83_1.time_ < var_86_3 + 2.4 + arg_86_0 then
				arg_83_1.allBtn_.enabled = true
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_4 = 1.46666666666667
			local var_86_5 = 0.525

			if 1.46666666666667 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_6 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_6:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:GetWordFromCfg(417011023)
				local var_86_8 = arg_83_1:FormatText(var_86_7.content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 21 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_8) / 21)

				if (21 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_8) / 21)) > 0 and var_86_5 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10
					var_86_4 = var_86_4 + 0.3

					if var_86_10 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011023", "story_v_out_417011.awb") ~= 0 then
					local var_86_11 = manager.audio:GetVoiceLength("story_v_out_417011", "417011023", "story_v_out_417011.awb") / 1000

					if var_86_11 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_4
					end

					if var_86_7.prefab_name ~= "" and arg_83_1.actors_[var_86_7.prefab_name] ~= nil then
						local var_86_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_7.prefab_name].transform, "story_v_out_417011", "417011023", "story_v_out_417011.awb")

						arg_83_1:RecordAudio("417011023", var_86_12)
						arg_83_1:RecordAudio("417011023", var_86_12)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_417011", "417011023", "story_v_out_417011.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_417011", "417011023", "story_v_out_417011.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_13 = var_86_4 + 0.3
			local var_86_14 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 + 0.3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_13 + var_86_14 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_13) / var_86_14

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_13 + var_86_14 and arg_83_1.time_ < var_86_13 + var_86_14 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.566,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play417011024 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 417011024
		arg_89_1.duration_ = 7.87

		local var_89_0 = {
			zh = 5.833,
			ja = 7.866
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
			arg_89_1.auto_ = false
		end

		function arg_89_1.playNext_(arg_91_0)
			arg_89_1.onStoryFinished_()
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.45

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(417011024)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 18 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 18)

				if (18 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 18)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417011", "417011024", "story_v_out_417011.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_417011", "417011024", "story_v_out_417011.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_417011", "417011024", "story_v_out_417011.awb")

						arg_89_1:RecordAudio("417011024", var_92_6)
						arg_89_1:RecordAudio("417011024", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_417011", "417011024", "story_v_out_417011.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_417011", "417011024", "story_v_out_417011.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"SofdecAsset/story/story_1041701.usm",
		"TextureConfig/Background/SS1701"
	},
	voices = {
		"story_v_out_417011.awb"
	},
	skipMarkers = {
		417011001
	}
}
