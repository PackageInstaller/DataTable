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

			if 112.3 < arg_1_1.time_ and arg_1_1.time_ <= 112.3 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_5 = var_4_4:GetComponent("SpriteRenderer")

				if var_4_5 and var_4_5.sprite then
					local var_4_6 = 2 * (var_4_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_4.transform.localScale = Vector3.New(var_4_6 / var_4_5.sprite.bounds.size.y < var_4_6 * manager.ui.mainCameraCom_.aspect / var_4_5.sprite.bounds.size.x and var_4_6 * manager.ui.mainCameraCom_.aspect / var_4_5.sprite.bounds.size.x or var_4_6 / var_4_5.sprite.bounds.size.y, var_4_6 / var_4_5.sprite.bounds.size.y < var_4_6 * manager.ui.mainCameraCom_.aspect / var_4_5.sprite.bounds.size.x and var_4_6 * manager.ui.mainCameraCom_.aspect / var_4_5.sprite.bounds.size.x or var_4_6 / var_4_5.sprite.bounds.size.y, 0)
				end

				for iter_4_2, iter_4_3 in pairs(arg_1_1.bgs_) do
					if iter_4_2 ~= "STblack" then
						iter_4_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_7 = 112.3

			if 112.3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_7 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_7 + 0.3 and arg_1_1.time_ < var_4_7 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_8 = 110.3

			if 110.3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_9 = 2

			if var_4_8 <= arg_1_1.time_ and arg_1_1.time_ < var_4_8 + var_4_9 then
				local var_4_10 = Color.New(0, 0, 0)

				var_4_10.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_8) / var_4_9)
				arg_1_1.mask_.color = var_4_10
			end

			if arg_1_1.time_ >= var_4_8 + var_4_9 and arg_1_1.time_ < var_4_8 + var_4_9 + arg_4_0 then
				local var_4_11 = Color.New(0, 0, 0)

				var_4_11.a = 1
				arg_1_1.mask_.color = var_4_11
			end

			local var_4_12 = 112.3

			if 112.3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_13 = 2

			if var_4_12 <= arg_1_1.time_ and arg_1_1.time_ < var_4_12 + var_4_13 then
				local var_4_14 = Color.New(0, 0, 0)

				var_4_14.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_12) / var_4_13)
				arg_1_1.mask_.color = var_4_14
			end

			if arg_1_1.time_ >= var_4_12 + var_4_13 and arg_1_1.time_ < var_4_12 + var_4_13 + arg_4_0 then
				local var_4_15 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_15.a = 0
				arg_1_1.mask_.color = var_4_15
			end

			if 110.3 < arg_1_1.time_ and arg_1_1.time_ <= 110.3 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			if 112.3 < arg_1_1.time_ and arg_1_1.time_ <= 112.3 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			if 112.316666666667 < arg_1_1.time_ and arg_1_1.time_ <= 112.316666666667 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_16 = 113.65

			if 113.65 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_17 = 0
			local var_4_18 = 0.650000000000006
			local var_4_19, var_4_20 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(102).content), 1)

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_21 = var_4_17 <= 0 and var_4_18 or var_4_18 * ((var_4_20 - arg_1_1.typewritterCharCountI18N) / var_4_17)

				if (var_4_17 <= 0 and var_4_18 or var_4_18 * ((var_4_20 - arg_1_1.typewritterCharCountI18N) / var_4_17)) > 0 and var_4_18 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end
			end

			local var_4_22 = math.max(0.650000000000006, arg_1_1.talkMaxDuration)

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_22 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_19, (arg_1_1.time_ - var_4_16) / var_4_22)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_16 + var_4_22 and arg_1_1.time_ < var_4_16 + var_4_22 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_19

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_20
			end

			local var_4_23 = 112.3

			if 112.3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_23 + 7.3 and arg_1_1.time_ < var_4_23 + 7.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_26 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_26

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_26
						arg_1_1.bgmTxt2_.text = var_4_26
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

			if 110.3 < arg_1_1.time_ and arg_1_1.time_ <= 110.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			if 113.033333333333 < arg_1_1.time_ and arg_1_1.time_ <= 113.033333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_cloth_wear", "")
			end

			local var_4_31 = 112.3
			local var_4_32 = manager.audio:GetVoiceLength("story_v_out_323011", "323011001", "0") / 1000

			if var_4_32 > 0 and 10.1 < var_4_32 and var_4_32 + var_4_31 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_32 + var_4_31
			end

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_323011", "323011001", "0")
			end

			local var_4_34 = 0.3

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				SetActive(arg_1_1.dialog_, false)
				SetActive(arg_1_1.allBtn_.gameObject, false)
				arg_1_1.hideBtnsController_:SetSelectedIndex(1)
				arg_1_1:StopAllVoice()
				arg_1_1:PlayOnlyBgm()
				manager.video:Play("SofdecAsset/story/story_103230101.usm", function(arg_7_0)
					arg_1_1.time_ = var_4_34 + 109.990000000224

					if arg_1_1.state_ == "pause" then
						arg_1_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_8_0)
					arg_1_1.state_ = arg_8_0 and "pause" or "playing"
				end, 10323011)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_4_35 = 110

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				-- block empty
			end

			local var_4_36 = 110.3

			if 110.3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				SetActive(arg_1_1.dialog_, true)
				SetActive(arg_1_1.allBtn_.gameObject, true)
				arg_1_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_1_1.isInLoopVideo = false
			end

			local var_4_37 = 1.38333333333333

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				-- block empty
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
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
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_0 = arg_9_1.bgs_.STblack

				arg_9_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_12_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_12_1 = var_12_0:GetComponent("SpriteRenderer")

				if var_12_1 and var_12_1.sprite then
					local var_12_2 = 2 * (var_12_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_12_0.transform.localScale = Vector3.New(var_12_2 / var_12_1.sprite.bounds.size.y < var_12_2 * manager.ui.mainCameraCom_.aspect / var_12_1.sprite.bounds.size.x and var_12_2 * manager.ui.mainCameraCom_.aspect / var_12_1.sprite.bounds.size.x or var_12_2 / var_12_1.sprite.bounds.size.y, var_12_2 / var_12_1.sprite.bounds.size.y < var_12_2 * manager.ui.mainCameraCom_.aspect / var_12_1.sprite.bounds.size.x and var_12_2 * manager.ui.mainCameraCom_.aspect / var_12_1.sprite.bounds.size.x or var_12_2 / var_12_1.sprite.bounds.size.y, 0)
				end

				for iter_12_0, iter_12_1 in pairs(arg_9_1.bgs_) do
					if iter_12_0 ~= "STblack" then
						iter_12_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_12_3 = "ST2015"

			if arg_9_1.bgs_.ST2015 == nil then
				local var_12_4 = Object.Instantiate(arg_9_1.paintGo_)

				var_12_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_12_3)
				var_12_4.name = var_12_3
				var_12_4.transform.parent = arg_9_1.stage_.transform
				var_12_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.bgs_[var_12_3] = var_12_4
			end

			if 0.9 < arg_9_1.time_ and arg_9_1.time_ <= 0.9 + arg_12_0 then
				local var_12_5 = arg_9_1.bgs_.ST2015

				arg_9_1.bgs_.ST2015.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_12_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_12_6 = var_12_5:GetComponent("SpriteRenderer")

				if var_12_6 and var_12_6.sprite then
					local var_12_7 = 2 * (var_12_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_12_5.transform.localScale = Vector3.New(var_12_7 / var_12_6.sprite.bounds.size.y < var_12_7 * manager.ui.mainCameraCom_.aspect / var_12_6.sprite.bounds.size.x and var_12_7 * manager.ui.mainCameraCom_.aspect / var_12_6.sprite.bounds.size.x or var_12_7 / var_12_6.sprite.bounds.size.y, var_12_7 / var_12_6.sprite.bounds.size.y < var_12_7 * manager.ui.mainCameraCom_.aspect / var_12_6.sprite.bounds.size.x and var_12_7 * manager.ui.mainCameraCom_.aspect / var_12_6.sprite.bounds.size.x or var_12_7 / var_12_6.sprite.bounds.size.y, 0)
				end

				for iter_12_2, iter_12_3 in pairs(arg_9_1.bgs_) do
					if iter_12_2 ~= "ST2015" then
						iter_12_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_12_8 = 0

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			if arg_9_1.time_ >= var_12_8 + 0.3 and arg_9_1.time_ < var_12_8 + 0.3 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			local var_12_9 = 0.9

			if 0.9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				arg_9_1.mask_.enabled = true
				arg_9_1.mask_.raycastTarget = true

				arg_9_1:SetGaussion(false)
			end

			local var_12_10 = 2

			if var_12_9 <= arg_9_1.time_ and arg_9_1.time_ < var_12_9 + var_12_10 then
				local var_12_11 = Color.New(0, 0, 0)

				var_12_11.a = Mathf.Lerp(1, 0, (arg_9_1.time_ - var_12_9) / var_12_10)
				arg_9_1.mask_.color = var_12_11
			end

			if arg_9_1.time_ >= var_12_9 + var_12_10 and arg_9_1.time_ < var_12_9 + var_12_10 + arg_12_0 then
				local var_12_12 = Color.New(0, 0, 0)

				arg_9_1.mask_.enabled = false
				var_12_12.a = 0
				arg_9_1.mask_.color = var_12_12
			end

			if 0.633333333333333 < arg_9_1.time_ and arg_9_1.time_ <= 0.633333333333333 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_town", "")
			end

			if 2.3 < arg_9_1.time_ and arg_9_1.time_ <= 2.3 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_131", "se_story_131__opendoor", "")
			end

			local var_12_15 = 1.43333333333333
			local var_12_16 = manager.audio:GetVoiceLength("story_v_out_323011", "323011002", "0") / 1000

			if var_12_16 > 0 and 13.166 < var_12_16 and var_12_16 + var_12_15 > arg_9_1.duration_ then
				arg_9_1.duration_ = var_12_16 + var_12_15
			end

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1:AudioAction("play", "voice", "story_v_out_323011", "323011002", "0")
			end

			local var_12_18 = 0

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			if arg_9_1.time_ >= var_12_18 + 3.83333333333333 and arg_9_1.time_ < var_12_18 + 3.83333333333333 + arg_12_0 then
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
			if arg_13_1.actors_["1024ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1024ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1024ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1024ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1024ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1024ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1024ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1024ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_3) and arg_13_1.var_.characterEffect1024ui_story == nil then
				arg_13_1.var_.characterEffect1024ui_story = var_16_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_4 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 and not isNil(var_16_3) then
				if arg_13_1.var_.characterEffect1024ui_story and not isNil(var_16_3) then
					arg_13_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 and not isNil(var_16_3) and arg_13_1.var_.characterEffect1024ui_story then
				arg_13_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.fswbg_:SetActive(false)
				arg_13_1.dialog_:SetActive(false)
				SetActive(arg_13_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_13_1:ShowNextGo(false)
			end

			if 0.0166666666666667 < arg_13_1.time_ and arg_13_1.time_ <= 0.0166666666666667 + arg_16_0 then
				arg_13_1.fswbg_:SetActive(false)
				arg_13_1.dialog_:SetActive(false)
				SetActive(arg_13_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_13_1:ShowNextGo(false)
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_6 = 0.0666666666666667
			local var_16_7 = 0.05

			if 0.0666666666666667 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_8 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_8:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1444].name)

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

				local var_16_9 = arg_13_1:GetWordFromCfg(323011003)
				local var_16_10 = arg_13_1:FormatText(var_16_9.content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_12 = 2 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_10) / 2)

				if (2 <= 0 and var_16_7 or var_16_7 * (utf8.len(var_16_10) / 2)) > 0 and var_16_7 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12
					var_16_6 = var_16_6 + 0.3

					if var_16_12 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011003", "story_v_out_323011.awb") ~= 0 then
					local var_16_13 = manager.audio:GetVoiceLength("story_v_out_323011", "323011003", "story_v_out_323011.awb") / 1000

					if var_16_13 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_6
					end

					if var_16_9.prefab_name ~= "" and arg_13_1.actors_[var_16_9.prefab_name] ~= nil then
						local var_16_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_9.prefab_name].transform, "story_v_out_323011", "323011003", "story_v_out_323011.awb")

						arg_13_1:RecordAudio("323011003", var_16_14)
						arg_13_1:RecordAudio("323011003", var_16_14)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_323011", "323011003", "story_v_out_323011.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_323011", "323011003", "story_v_out_323011.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_15 = var_16_6 + 0.3
			local var_16_16 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_15 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_15) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_15 + var_16_16 and arg_13_1.time_ < var_16_15 + var_16_16 + arg_16_0 then
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
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1024ui_story"]) and arg_19_1.var_.characterEffect1024ui_story == nil then
				arg_19_1.var_.characterEffect1024ui_story = arg_19_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_0 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["1024ui_story"]) then
				if arg_19_1.var_.characterEffect1024ui_story and not isNil(arg_19_1.actors_["1024ui_story"]) then
					arg_19_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_0)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["1024ui_story"]) and arg_19_1.var_.characterEffect1024ui_story then
				arg_19_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_19_1.time_ and arg_19_1.time_ <= 0.1 + arg_22_0 then
				arg_19_1:AudioAction("play", "effect", "se_story_148", "se_story_148_cloth", "")
			end

			local var_22_2 = 0
			local var_22_3 = 1.425

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_2 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_4 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(323011004).content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_6 = 57 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_4) / 57)

				if (57 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_4) / 57)) > 0 and var_22_3 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6

					if var_22_6 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_2
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_7 = math.max(var_22_3, arg_19_1.talkMaxDuration)

			if var_22_2 <= arg_19_1.time_ and arg_19_1.time_ < var_22_2 + var_22_7 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_2) / var_22_7

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_2 + var_22_7 and arg_19_1.time_ < var_22_2 + var_22_7 + arg_22_0 then
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
			local var_26_0 = 1.725

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(323011005).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 69 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 69)

				if (69 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 69)) > 0 and var_26_0 < var_26_3 then
					arg_23_1.talkMaxDuration = var_26_3

					if var_26_3 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_3 + 0
					end
				end

				arg_23_1.text_.text = var_26_1
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_4 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_4

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
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
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_30_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_27_1.bgmTxt_.text ~= var_30_2 and arg_27_1.bgmTxt_.text ~= "" then
						if arg_27_1.bgmTxt2_.text ~= "" then
							arg_27_1.bgmTxt_.text = arg_27_1.bgmTxt2_.text
						end

						arg_27_1.bgmTxt2_.text = var_30_2

						arg_27_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_27_1.bgmTxt_.text = var_30_2
						arg_27_1.bgmTxt2_.text = var_30_2
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

			if 0.433333333333333 < arg_27_1.time_ and arg_27_1.time_ <= 0.433333333333333 + arg_30_0 then
				arg_27_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily.awb")

				local var_30_5 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_daily", "bgm_activity_4_8_story_dahuang_daily")

				if "" ~= "" then
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

			local var_30_6 = 0
			local var_30_7 = 0.15

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[1445].name)

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

				local var_30_8 = arg_27_1:GetWordFromCfg(323011006)
				local var_30_9 = arg_27_1:FormatText(var_30_8.content)

				arg_27_1.text_.text = var_30_9

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_11 = 6 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_9) / 6)

				if (6 <= 0 and var_30_7 or var_30_7 * (utf8.len(var_30_9) / 6)) > 0 and var_30_7 < var_30_11 then
					arg_27_1.talkMaxDuration = var_30_11

					if var_30_11 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_11 + var_30_6
					end
				end

				arg_27_1.text_.text = var_30_9
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011006", "story_v_out_323011.awb") ~= 0 then
					local var_30_12 = manager.audio:GetVoiceLength("story_v_out_323011", "323011006", "story_v_out_323011.awb") / 1000

					if var_30_12 + var_30_6 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_12 + var_30_6
					end

					if var_30_8.prefab_name ~= "" and arg_27_1.actors_[var_30_8.prefab_name] ~= nil then
						local var_30_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_8.prefab_name].transform, "story_v_out_323011", "323011006", "story_v_out_323011.awb")

						arg_27_1:RecordAudio("323011006", var_30_13)
						arg_27_1:RecordAudio("323011006", var_30_13)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_323011", "323011006", "story_v_out_323011.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_323011", "323011006", "story_v_out_323011.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_14 = math.max(var_30_7, arg_27_1.talkMaxDuration)

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_14 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_6) / var_30_14

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_6 + var_30_14 and arg_27_1.time_ < var_30_6 + var_30_14 + arg_30_0 then
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
			if arg_33_1.actors_["10163ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10163ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "10163ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "10163ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["10163ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["10163ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["10163ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["10163ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["10163ui_story"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10163ui_story = var_36_3.localPosition

				local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_3.gameObject, typeof(DynamicBoneHelper))

				if var_36_4 then
					var_36_4:EnableDynamicBone(false)
				end
			end

			local var_36_5 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 then
				var_36_3.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10163ui_story, Vector3.New(0, -1.08, -5.83), (arg_33_1.time_ - 0) / var_36_5)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 then
				var_36_3.localPosition = Vector3.New(0, -1.08, -5.83)
				var_36_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_36_3.position).x, (manager.ui.mainCamera.transform.position - var_36_3.position).y, (manager.ui.mainCamera.transform.position - var_36_3.position).z)
				var_36_3.localEulerAngles.z = 0
				var_36_3.localEulerAngles.x = 0
				var_36_3.localEulerAngles = var_36_3.localEulerAngles

				local var_36_6 = GameObjectTools.GetOrAddComponent(var_36_3.gameObject, typeof(DynamicBoneHelper))

				if var_36_6 then
					var_36_6:EnableDynamicBone(true)
				end
			end

			local var_36_7 = arg_33_1.actors_["10163ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.characterEffect10163ui_story == nil then
				arg_33_1.var_.characterEffect10163ui_story = var_36_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_8 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_8 and not isNil(var_36_7) then
				if arg_33_1.var_.characterEffect10163ui_story and not isNil(var_36_7) then
					arg_33_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_8 and arg_33_1.time_ < 0 + var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.characterEffect10163ui_story then
				arg_33_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_36_10 = 0
			local var_36_11 = 0.425

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_12 = arg_33_1:GetWordFromCfg(323011007)
				local var_36_13 = arg_33_1:FormatText(var_36_12.content)

				arg_33_1.text_.text = var_36_13

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_15 = 17 <= 0 and var_36_11 or var_36_11 * (utf8.len(var_36_13) / 17)

				if (17 <= 0 and var_36_11 or var_36_11 * (utf8.len(var_36_13) / 17)) > 0 and var_36_11 < var_36_15 then
					arg_33_1.talkMaxDuration = var_36_15

					if var_36_15 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_10
					end
				end

				arg_33_1.text_.text = var_36_13
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011007", "story_v_out_323011.awb") ~= 0 then
					local var_36_16 = manager.audio:GetVoiceLength("story_v_out_323011", "323011007", "story_v_out_323011.awb") / 1000

					if var_36_16 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_10
					end

					if var_36_12.prefab_name ~= "" and arg_33_1.actors_[var_36_12.prefab_name] ~= nil then
						local var_36_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_12.prefab_name].transform, "story_v_out_323011", "323011007", "story_v_out_323011.awb")

						arg_33_1:RecordAudio("323011007", var_36_17)
						arg_33_1:RecordAudio("323011007", var_36_17)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_323011", "323011007", "story_v_out_323011.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_323011", "323011007", "story_v_out_323011.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_18 = math.max(var_36_11, arg_33_1.talkMaxDuration)

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_18 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_10) / var_36_18

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_10 + var_36_18 and arg_33_1.time_ < var_36_10 + var_36_18 + arg_36_0 then
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
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10163ui_story"]) and arg_37_1.var_.characterEffect10163ui_story == nil then
				arg_37_1.var_.characterEffect10163ui_story = arg_37_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10163ui_story"]) then
				if arg_37_1.var_.characterEffect10163ui_story and not isNil(arg_37_1.actors_["10163ui_story"]) then
					arg_37_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10163ui_story"]) and arg_37_1.var_.characterEffect10163ui_story then
				arg_37_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 0.475

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1445].name)

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

				local var_40_3 = arg_37_1:GetWordFromCfg(323011008)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 19 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 19)

				if (19 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 19)) > 0 and var_40_2 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011008", "story_v_out_323011.awb") ~= 0 then
					local var_40_7 = manager.audio:GetVoiceLength("story_v_out_323011", "323011008", "story_v_out_323011.awb") / 1000

					if var_40_7 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_1
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_323011", "323011008", "story_v_out_323011.awb")

						arg_37_1:RecordAudio("323011008", var_40_8)
						arg_37_1:RecordAudio("323011008", var_40_8)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_323011", "323011008", "story_v_out_323011.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_323011", "323011008", "story_v_out_323011.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_9 and arg_37_1.time_ < var_40_1 + var_40_9 + arg_40_0 then
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
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10163ui_story"]) and arg_41_1.var_.characterEffect10163ui_story == nil then
				arg_41_1.var_.characterEffect10163ui_story = arg_41_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10163ui_story"]) then
				if arg_41_1.var_.characterEffect10163ui_story and not isNil(arg_41_1.actors_["10163ui_story"]) then
					arg_41_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10163ui_story"]) and arg_41_1.var_.characterEffect10163ui_story then
				arg_41_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_44_2 = 0
			local var_44_3 = 0.325

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(323011009)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 13 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 13)

				if (13 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 13)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011009", "story_v_out_323011.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011009", "story_v_out_323011.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_323011", "323011009", "story_v_out_323011.awb")

						arg_41_1:RecordAudio("323011009", var_44_9)
						arg_41_1:RecordAudio("323011009", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_323011", "323011009", "story_v_out_323011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_323011", "323011009", "story_v_out_323011.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
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
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10163ui_story"]) and arg_45_1.var_.characterEffect10163ui_story == nil then
				arg_45_1.var_.characterEffect10163ui_story = arg_45_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10163ui_story"]) then
				if arg_45_1.var_.characterEffect10163ui_story and not isNil(arg_45_1.actors_["10163ui_story"]) then
					arg_45_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10163ui_story"]) and arg_45_1.var_.characterEffect10163ui_story then
				arg_45_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.7

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(323011010).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 28 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 28)

				if (28 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 28)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
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
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10163ui_story"]) and arg_49_1.var_.characterEffect10163ui_story == nil then
				arg_49_1.var_.characterEffect10163ui_story = arg_49_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10163ui_story"]) then
				if arg_49_1.var_.characterEffect10163ui_story and not isNil(arg_49_1.actors_["10163ui_story"]) then
					arg_49_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10163ui_story"]) and arg_49_1.var_.characterEffect10163ui_story then
				arg_49_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action8_2")
			end

			local var_52_2 = 0
			local var_52_3 = 0.25

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(323011011)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 10 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 10)

				if (10 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 10)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011011", "story_v_out_323011.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011011", "story_v_out_323011.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_323011", "323011011", "story_v_out_323011.awb")

						arg_49_1:RecordAudio("323011011", var_52_9)
						arg_49_1:RecordAudio("323011011", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_323011", "323011011", "story_v_out_323011.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_323011", "323011011", "story_v_out_323011.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
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
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["10163ui_story"]) and arg_53_1.var_.characterEffect10163ui_story == nil then
				arg_53_1.var_.characterEffect10163ui_story = arg_53_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["10163ui_story"]) then
				if arg_53_1.var_.characterEffect10163ui_story and not isNil(arg_53_1.actors_["10163ui_story"]) then
					arg_53_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["10163ui_story"]) and arg_53_1.var_.characterEffect10163ui_story then
				arg_53_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.125

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1445].name)

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

				local var_56_3 = arg_53_1:GetWordFromCfg(323011012)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_6 = 5 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 5)

				if (5 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_4) / 5)) > 0 and var_56_2 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011012", "story_v_out_323011.awb") ~= 0 then
					local var_56_7 = manager.audio:GetVoiceLength("story_v_out_323011", "323011012", "story_v_out_323011.awb") / 1000

					if var_56_7 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_1
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_323011", "323011012", "story_v_out_323011.awb")

						arg_53_1:RecordAudio("323011012", var_56_8)
						arg_53_1:RecordAudio("323011012", var_56_8)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_323011", "323011012", "story_v_out_323011.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_323011", "323011012", "story_v_out_323011.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_9 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_9 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_9

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_9 and arg_53_1.time_ < var_56_1 + var_56_9 + arg_56_0 then
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
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10163ui_story"]) and arg_57_1.var_.characterEffect10163ui_story == nil then
				arg_57_1.var_.characterEffect10163ui_story = arg_57_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10163ui_story"]) then
				if arg_57_1.var_.characterEffect10163ui_story and not isNil(arg_57_1.actors_["10163ui_story"]) then
					arg_57_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10163ui_story"]) and arg_57_1.var_.characterEffect10163ui_story then
				arg_57_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_60_2 = 0
			local var_60_3 = 0.2

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(323011013)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 7 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 7)

				if (7 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_5) / 7)) > 0 and var_60_3 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011013", "story_v_out_323011.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011013", "story_v_out_323011.awb") / 1000

					if var_60_8 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_2
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_323011", "323011013", "story_v_out_323011.awb")

						arg_57_1:RecordAudio("323011013", var_60_9)
						arg_57_1:RecordAudio("323011013", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_323011", "323011013", "story_v_out_323011.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_323011", "323011013", "story_v_out_323011.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_10 and arg_57_1.time_ < var_60_2 + var_60_10 + arg_60_0 then
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
			local var_64_0 = 0.15

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(323011014)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 6 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 6)

				if (6 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 6)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011014", "story_v_out_323011.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_323011", "323011014", "story_v_out_323011.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_323011", "323011014", "story_v_out_323011.awb")

						arg_61_1:RecordAudio("323011014", var_64_6)
						arg_61_1:RecordAudio("323011014", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_323011", "323011014", "story_v_out_323011.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_323011", "323011014", "story_v_out_323011.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
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
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10163ui_story = arg_65_1.actors_["10163ui_story"].transform.localPosition

				local var_68_0 = GameObjectTools.GetOrAddComponent(arg_65_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_68_0 then
					var_68_0:EnableDynamicBone(false)
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["10163ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10163ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_1)
				arg_65_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10163ui_story"].transform.position).z)
				arg_65_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10163ui_story"].transform.localEulerAngles = arg_65_1.actors_["10163ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["10163ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_65_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10163ui_story"].transform.position).z)
				arg_65_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10163ui_story"].transform.localEulerAngles = arg_65_1.actors_["10163ui_story"].transform.localEulerAngles

				local var_68_2 = GameObjectTools.GetOrAddComponent(arg_65_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(true)
				end
			end

			local var_68_3 = arg_65_1.actors_["10163ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect10163ui_story == nil then
				arg_65_1.var_.characterEffect10163ui_story = var_68_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_4 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 and not isNil(var_68_3) then
				if arg_65_1.var_.characterEffect10163ui_story and not isNil(var_68_3) then
					arg_65_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_4)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect10163ui_story then
				arg_65_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			local var_68_5 = 0
			local var_68_6 = 1.6

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(323011015).content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 64 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_7) / 64)

				if (64 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_7) / 64)) > 0 and var_68_6 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_10 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_10 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_10

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_10 and arg_65_1.time_ < var_68_5 + var_68_10 + arg_68_0 then
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
			local var_72_0 = 1.475

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(323011016).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 59 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 59)

				if (59 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 59)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
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
			if arg_73_1.actors_["10165ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10165ui_story"))) then
				local var_76_0 = Object.Instantiate(Asset.Load("Char/" .. "10165ui_story"), arg_73_1.stage_.transform)

				var_76_0.name = "10165ui_story"
				var_76_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["10165ui_story"] = var_76_0

				local var_76_1 = var_76_0:GetComponentInChildren(typeof(CharacterEffect))

				var_76_1.enabled = true

				local var_76_2 = GameObjectTools.GetOrAddComponent(var_76_0, typeof(DynamicBoneHelper))

				if var_76_2 then
					var_76_2:EnableDynamicBone(false)
				end

				arg_73_1:ShowWeapon(var_76_1.transform, false)

				arg_73_1.var_["10165ui_story" .. "Animator"] = var_76_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_73_1.var_["10165ui_story" .. "Animator"].applyRootMotion = true
				arg_73_1.var_["10165ui_story" .. "LipSync"] = var_76_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_76_3 = arg_73_1.actors_["10165ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10165ui_story = var_76_3.localPosition

				local var_76_4 = GameObjectTools.GetOrAddComponent(var_76_3.gameObject, typeof(DynamicBoneHelper))

				if var_76_4 then
					var_76_4:EnableDynamicBone(false)
				end
			end

			local var_76_5 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 then
				var_76_3.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10165ui_story, Vector3.New(0, -1.08, -5.83), (arg_73_1.time_ - 0) / var_76_5)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 then
				var_76_3.localPosition = Vector3.New(0, -1.08, -5.83)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles

				local var_76_6 = GameObjectTools.GetOrAddComponent(var_76_3.gameObject, typeof(DynamicBoneHelper))

				if var_76_6 then
					var_76_6:EnableDynamicBone(true)
				end
			end

			local var_76_7 = arg_73_1.actors_["10165ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.characterEffect10165ui_story == nil then
				arg_73_1.var_.characterEffect10165ui_story = var_76_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_8 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_8 and not isNil(var_76_7) then
				if arg_73_1.var_.characterEffect10165ui_story and not isNil(var_76_7) then
					arg_73_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_8 and arg_73_1.time_ < 0 + var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.characterEffect10165ui_story then
				arg_73_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 1.05 < arg_73_1.time_ and arg_73_1.time_ <= 1.05 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_down", "")
			end

			local var_76_11 = 0
			local var_76_12 = 0.25

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_13 = arg_73_1:GetWordFromCfg(323011017)
				local var_76_14 = arg_73_1:FormatText(var_76_13.content)

				arg_73_1.text_.text = var_76_14

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 10 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 10)

				if (10 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 10)) > 0 and var_76_12 < var_76_16 then
					arg_73_1.talkMaxDuration = var_76_16

					if var_76_16 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_14
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011017", "story_v_out_323011.awb") ~= 0 then
					local var_76_17 = manager.audio:GetVoiceLength("story_v_out_323011", "323011017", "story_v_out_323011.awb") / 1000

					if var_76_17 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_17 + var_76_11
					end

					if var_76_13.prefab_name ~= "" and arg_73_1.actors_[var_76_13.prefab_name] ~= nil then
						local var_76_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_13.prefab_name].transform, "story_v_out_323011", "323011017", "story_v_out_323011.awb")

						arg_73_1:RecordAudio("323011017", var_76_18)
						arg_73_1:RecordAudio("323011017", var_76_18)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_323011", "323011017", "story_v_out_323011.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_323011", "323011017", "story_v_out_323011.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_19 = math.max(var_76_12, arg_73_1.talkMaxDuration)

			if var_76_11 <= arg_73_1.time_ and arg_73_1.time_ < var_76_11 + var_76_19 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_11) / var_76_19

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_11 + var_76_19 and arg_73_1.time_ < var_76_11 + var_76_19 + arg_76_0 then
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
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10163ui_story = arg_77_1.actors_["10163ui_story"].transform.localPosition

				local var_80_0 = GameObjectTools.GetOrAddComponent(arg_77_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_80_0 then
					var_80_0:EnableDynamicBone(false)
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10163ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10163ui_story, Vector3.New(-0.74, -1.08, -5.83), (arg_77_1.time_ - 0) / var_80_1)
				arg_77_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10163ui_story"].transform.position).z)
				arg_77_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10163ui_story"].transform.localEulerAngles = arg_77_1.actors_["10163ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10163ui_story"].transform.localPosition = Vector3.New(-0.74, -1.08, -5.83)
				arg_77_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["10163ui_story"].transform.position).z)
				arg_77_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["10163ui_story"].transform.localEulerAngles = arg_77_1.actors_["10163ui_story"].transform.localEulerAngles

				local var_80_2 = GameObjectTools.GetOrAddComponent(arg_77_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_80_2 then
					var_80_2:EnableDynamicBone(true)
				end
			end

			local var_80_3 = arg_77_1.actors_["10163ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect10163ui_story == nil then
				arg_77_1.var_.characterEffect10163ui_story = var_80_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_4 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 and not isNil(var_80_3) then
				if arg_77_1.var_.characterEffect10163ui_story and not isNil(var_80_3) then
					arg_77_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 and not isNil(var_80_3) and arg_77_1.var_.characterEffect10163ui_story then
				arg_77_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_80_6 = arg_77_1.actors_["10165ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect10165ui_story == nil then
				arg_77_1.var_.characterEffect10165ui_story = var_80_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_7 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 and not isNil(var_80_6) then
				if arg_77_1.var_.characterEffect10165ui_story and not isNil(var_80_6) then
					arg_77_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_77_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_7)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect10165ui_story then
				arg_77_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_77_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_2")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_80_8 = arg_77_1.actors_["10165ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10165ui_story = var_80_8.localPosition

				local var_80_9 = GameObjectTools.GetOrAddComponent(var_80_8.gameObject, typeof(DynamicBoneHelper))

				if var_80_9 then
					var_80_9:EnableDynamicBone(false)
				end
			end

			local var_80_10 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_10 then
				var_80_8.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10165ui_story, Vector3.New(0.7, -1.08, -5.83), (arg_77_1.time_ - 0) / var_80_10)
				var_80_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_8.position).x, (manager.ui.mainCamera.transform.position - var_80_8.position).y, (manager.ui.mainCamera.transform.position - var_80_8.position).z)
				var_80_8.localEulerAngles.z = 0
				var_80_8.localEulerAngles.x = 0
				var_80_8.localEulerAngles = var_80_8.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_10 and arg_77_1.time_ < 0 + var_80_10 + arg_80_0 then
				var_80_8.localPosition = Vector3.New(0.7, -1.08, -5.83)
				var_80_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_8.position).x, (manager.ui.mainCamera.transform.position - var_80_8.position).y, (manager.ui.mainCamera.transform.position - var_80_8.position).z)
				var_80_8.localEulerAngles.z = 0
				var_80_8.localEulerAngles.x = 0
				var_80_8.localEulerAngles = var_80_8.localEulerAngles

				local var_80_11 = GameObjectTools.GetOrAddComponent(var_80_8.gameObject, typeof(DynamicBoneHelper))

				if var_80_11 then
					var_80_11:EnableDynamicBone(true)
				end
			end

			local var_80_12 = 0
			local var_80_13 = 0.2

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_12 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_14 = arg_77_1:GetWordFromCfg(323011018)
				local var_80_15 = arg_77_1:FormatText(var_80_14.content)

				arg_77_1.text_.text = var_80_15

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_17 = 8 <= 0 and var_80_13 or var_80_13 * (utf8.len(var_80_15) / 8)

				if (8 <= 0 and var_80_13 or var_80_13 * (utf8.len(var_80_15) / 8)) > 0 and var_80_13 < var_80_17 then
					arg_77_1.talkMaxDuration = var_80_17

					if var_80_17 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_12
					end
				end

				arg_77_1.text_.text = var_80_15
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011018", "story_v_out_323011.awb") ~= 0 then
					local var_80_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011018", "story_v_out_323011.awb") / 1000

					if var_80_18 + var_80_12 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_12
					end

					if var_80_14.prefab_name ~= "" and arg_77_1.actors_[var_80_14.prefab_name] ~= nil then
						local var_80_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_14.prefab_name].transform, "story_v_out_323011", "323011018", "story_v_out_323011.awb")

						arg_77_1:RecordAudio("323011018", var_80_19)
						arg_77_1:RecordAudio("323011018", var_80_19)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_323011", "323011018", "story_v_out_323011.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_323011", "323011018", "story_v_out_323011.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_20 = math.max(var_80_13, arg_77_1.talkMaxDuration)

			if var_80_12 <= arg_77_1.time_ and arg_77_1.time_ < var_80_12 + var_80_20 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_12) / var_80_20

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_12 + var_80_20 and arg_77_1.time_ < var_80_12 + var_80_20 + arg_80_0 then
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
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10165ui_story"]) and arg_81_1.var_.characterEffect10165ui_story == nil then
				arg_81_1.var_.characterEffect10165ui_story = arg_81_1.actors_["10165ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10165ui_story"]) then
				if arg_81_1.var_.characterEffect10165ui_story and not isNil(arg_81_1.actors_["10165ui_story"]) then
					arg_81_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10165ui_story"]) and arg_81_1.var_.characterEffect10165ui_story then
				arg_81_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_84_2 = arg_81_1.actors_["10163ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect10163ui_story == nil then
				arg_81_1.var_.characterEffect10163ui_story = var_84_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_3 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.characterEffect10163ui_story and not isNil(var_84_2) then
					arg_81_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_3)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.characterEffect10163ui_story then
				arg_81_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_2")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_84_4 = 0
			local var_84_5 = 0.55

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(323011019)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 22 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 22)

				if (22 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 22)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011019", "story_v_out_323011.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011019", "story_v_out_323011.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_323011", "323011019", "story_v_out_323011.awb")

						arg_81_1:RecordAudio("323011019", var_84_11)
						arg_81_1:RecordAudio("323011019", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_323011", "323011019", "story_v_out_323011.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_323011", "323011019", "story_v_out_323011.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
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
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10163ui_story"]) and arg_85_1.var_.characterEffect10163ui_story == nil then
				arg_85_1.var_.characterEffect10163ui_story = arg_85_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10163ui_story"]) then
				if arg_85_1.var_.characterEffect10163ui_story and not isNil(arg_85_1.actors_["10163ui_story"]) then
					arg_85_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10163ui_story"]) and arg_85_1.var_.characterEffect10163ui_story then
				arg_85_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_88_2 = arg_85_1.actors_["10165ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect10165ui_story == nil then
				arg_85_1.var_.characterEffect10165ui_story = var_88_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_3 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.characterEffect10165ui_story and not isNil(var_88_2) then
					arg_85_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_85_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_3)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.characterEffect10165ui_story then
				arg_85_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_85_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			local var_88_4 = 0
			local var_88_5 = 0.625

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(323011020)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 25 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 25)

				if (25 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 25)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011020", "story_v_out_323011.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011020", "story_v_out_323011.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_323011", "323011020", "story_v_out_323011.awb")

						arg_85_1:RecordAudio("323011020", var_88_11)
						arg_85_1:RecordAudio("323011020", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_323011", "323011020", "story_v_out_323011.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_323011", "323011020", "story_v_out_323011.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
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
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["10165ui_story"]) and arg_89_1.var_.characterEffect10165ui_story == nil then
				arg_89_1.var_.characterEffect10165ui_story = arg_89_1.actors_["10165ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["10165ui_story"]) then
				if arg_89_1.var_.characterEffect10165ui_story and not isNil(arg_89_1.actors_["10165ui_story"]) then
					arg_89_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["10165ui_story"]) and arg_89_1.var_.characterEffect10165ui_story then
				arg_89_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_92_2 = arg_89_1.actors_["10163ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect10163ui_story == nil then
				arg_89_1.var_.characterEffect10163ui_story = var_92_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_3 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_3 and not isNil(var_92_2) then
				if arg_89_1.var_.characterEffect10163ui_story and not isNil(var_92_2) then
					arg_89_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_3)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_3 and arg_89_1.time_ < 0 + var_92_3 + arg_92_0 and not isNil(var_92_2) and arg_89_1.var_.characterEffect10163ui_story then
				arg_89_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_92_4 = 0
			local var_92_5 = 0.075

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:GetWordFromCfg(323011021)
				local var_92_7 = arg_89_1:FormatText(var_92_6.content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 3 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 3)

				if (3 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_7) / 3)) > 0 and var_92_5 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011021", "story_v_out_323011.awb") ~= 0 then
					local var_92_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011021", "story_v_out_323011.awb") / 1000

					if var_92_10 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_4
					end

					if var_92_6.prefab_name ~= "" and arg_89_1.actors_[var_92_6.prefab_name] ~= nil then
						local var_92_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_6.prefab_name].transform, "story_v_out_323011", "323011021", "story_v_out_323011.awb")

						arg_89_1:RecordAudio("323011021", var_92_11)
						arg_89_1:RecordAudio("323011021", var_92_11)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_323011", "323011021", "story_v_out_323011.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_323011", "323011021", "story_v_out_323011.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_12 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_12 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_12

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_12 and arg_89_1.time_ < var_92_4 + var_92_12 + arg_92_0 then
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
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10163ui_story"]) and arg_93_1.var_.characterEffect10163ui_story == nil then
				arg_93_1.var_.characterEffect10163ui_story = arg_93_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10163ui_story"]) then
				if arg_93_1.var_.characterEffect10163ui_story and not isNil(arg_93_1.actors_["10163ui_story"]) then
					arg_93_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10163ui_story"]) and arg_93_1.var_.characterEffect10163ui_story then
				arg_93_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_96_2 = arg_93_1.actors_["10165ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect10165ui_story == nil then
				arg_93_1.var_.characterEffect10165ui_story = var_96_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_3 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_3 and not isNil(var_96_2) then
				if arg_93_1.var_.characterEffect10165ui_story and not isNil(var_96_2) then
					arg_93_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_3)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_3 and arg_93_1.time_ < 0 + var_96_3 + arg_96_0 and not isNil(var_96_2) and arg_93_1.var_.characterEffect10165ui_story then
				arg_93_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_1")
			end

			local var_96_4 = 0
			local var_96_5 = 0.375

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(323011022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 15 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 15)

				if (15 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 15)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011022", "story_v_out_323011.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011022", "story_v_out_323011.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_323011", "323011022", "story_v_out_323011.awb")

						arg_93_1:RecordAudio("323011022", var_96_11)
						arg_93_1:RecordAudio("323011022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_323011", "323011022", "story_v_out_323011.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_323011", "323011022", "story_v_out_323011.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
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
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10165ui_story"]) and arg_97_1.var_.characterEffect10165ui_story == nil then
				arg_97_1.var_.characterEffect10165ui_story = arg_97_1.actors_["10165ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10165ui_story"]) then
				if arg_97_1.var_.characterEffect10165ui_story and not isNil(arg_97_1.actors_["10165ui_story"]) then
					arg_97_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10165ui_story"]) and arg_97_1.var_.characterEffect10165ui_story then
				arg_97_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_100_2 = arg_97_1.actors_["10163ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect10163ui_story == nil then
				arg_97_1.var_.characterEffect10163ui_story = var_100_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_3 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.characterEffect10163ui_story and not isNil(var_100_2) then
					arg_97_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_3)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.characterEffect10163ui_story then
				arg_97_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			local var_100_4 = 0
			local var_100_5 = 0.775

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(323011023)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 32 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 32)

				if (32 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 32)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011023", "story_v_out_323011.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011023", "story_v_out_323011.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_323011", "323011023", "story_v_out_323011.awb")

						arg_97_1:RecordAudio("323011023", var_100_11)
						arg_97_1:RecordAudio("323011023", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_323011", "323011023", "story_v_out_323011.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_323011", "323011023", "story_v_out_323011.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
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
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10163ui_story"]) and arg_101_1.var_.characterEffect10163ui_story == nil then
				arg_101_1.var_.characterEffect10163ui_story = arg_101_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10163ui_story"]) then
				if arg_101_1.var_.characterEffect10163ui_story and not isNil(arg_101_1.actors_["10163ui_story"]) then
					arg_101_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10163ui_story"]) and arg_101_1.var_.characterEffect10163ui_story then
				arg_101_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_104_2 = arg_101_1.actors_["10165ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect10165ui_story == nil then
				arg_101_1.var_.characterEffect10165ui_story = var_104_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_3 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.characterEffect10165ui_story and not isNil(var_104_2) then
					arg_101_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_3)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect10165ui_story then
				arg_101_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			local var_104_4 = 0
			local var_104_5 = 0.7

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(323011024)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 28 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 28)

				if (28 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 28)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011024", "story_v_out_323011.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011024", "story_v_out_323011.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_323011", "323011024", "story_v_out_323011.awb")

						arg_101_1:RecordAudio("323011024", var_104_11)
						arg_101_1:RecordAudio("323011024", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_323011", "323011024", "story_v_out_323011.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_323011", "323011024", "story_v_out_323011.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
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
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10165ui_story"]) and arg_105_1.var_.characterEffect10165ui_story == nil then
				arg_105_1.var_.characterEffect10165ui_story = arg_105_1.actors_["10165ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10165ui_story"]) then
				if arg_105_1.var_.characterEffect10165ui_story and not isNil(arg_105_1.actors_["10165ui_story"]) then
					arg_105_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10165ui_story"]) and arg_105_1.var_.characterEffect10165ui_story then
				arg_105_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_108_2 = arg_105_1.actors_["10163ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect10163ui_story == nil then
				arg_105_1.var_.characterEffect10163ui_story = var_108_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_3 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.characterEffect10163ui_story and not isNil(var_108_2) then
					arg_105_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_3)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.characterEffect10163ui_story then
				arg_105_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_108_4 = 0
			local var_108_5 = 0.075

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_6 = arg_105_1:GetWordFromCfg(323011025)
				local var_108_7 = arg_105_1:FormatText(var_108_6.content)

				arg_105_1.text_.text = var_108_7

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_9 = 3 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 3)

				if (3 <= 0 and var_108_5 or var_108_5 * (utf8.len(var_108_7) / 3)) > 0 and var_108_5 < var_108_9 then
					arg_105_1.talkMaxDuration = var_108_9

					if var_108_9 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_9 + var_108_4
					end
				end

				arg_105_1.text_.text = var_108_7
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011025", "story_v_out_323011.awb") ~= 0 then
					local var_108_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011025", "story_v_out_323011.awb") / 1000

					if var_108_10 + var_108_4 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_4
					end

					if var_108_6.prefab_name ~= "" and arg_105_1.actors_[var_108_6.prefab_name] ~= nil then
						local var_108_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_6.prefab_name].transform, "story_v_out_323011", "323011025", "story_v_out_323011.awb")

						arg_105_1:RecordAudio("323011025", var_108_11)
						arg_105_1:RecordAudio("323011025", var_108_11)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_323011", "323011025", "story_v_out_323011.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_323011", "323011025", "story_v_out_323011.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_12 = math.max(var_108_5, arg_105_1.talkMaxDuration)

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_12 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_4) / var_108_12

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_4 + var_108_12 and arg_105_1.time_ < var_108_4 + var_108_12 + arg_108_0 then
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
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10165ui_story"]) and arg_109_1.var_.characterEffect10165ui_story == nil then
				arg_109_1.var_.characterEffect10165ui_story = arg_109_1.actors_["10165ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10165ui_story"]) then
				if arg_109_1.var_.characterEffect10165ui_story and not isNil(arg_109_1.actors_["10165ui_story"]) then
					arg_109_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10165ui_story"]) and arg_109_1.var_.characterEffect10165ui_story then
				arg_109_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			local var_112_1 = arg_109_1.actors_["10163ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10163ui_story = var_112_1.localPosition

				local var_112_2 = GameObjectTools.GetOrAddComponent(var_112_1.gameObject, typeof(DynamicBoneHelper))

				if var_112_2 then
					var_112_2:EnableDynamicBone(false)
				end
			end

			local var_112_3 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 then
				var_112_1.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10163ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_3)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 then
				var_112_1.localPosition = Vector3.New(0, 100, 0)
				var_112_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_1.position).x, (manager.ui.mainCamera.transform.position - var_112_1.position).y, (manager.ui.mainCamera.transform.position - var_112_1.position).z)
				var_112_1.localEulerAngles.z = 0
				var_112_1.localEulerAngles.x = 0
				var_112_1.localEulerAngles = var_112_1.localEulerAngles

				local var_112_4 = GameObjectTools.GetOrAddComponent(var_112_1.gameObject, typeof(DynamicBoneHelper))

				if var_112_4 then
					var_112_4:EnableDynamicBone(true)
				end
			end

			local var_112_5 = arg_109_1.actors_["10165ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10165ui_story = var_112_5.localPosition

				local var_112_6 = GameObjectTools.GetOrAddComponent(var_112_5.gameObject, typeof(DynamicBoneHelper))

				if var_112_6 then
					var_112_6:EnableDynamicBone(false)
				end
			end

			local var_112_7 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_7 then
				var_112_5.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10165ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_7)
				var_112_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_5.position).x, (manager.ui.mainCamera.transform.position - var_112_5.position).y, (manager.ui.mainCamera.transform.position - var_112_5.position).z)
				var_112_5.localEulerAngles.z = 0
				var_112_5.localEulerAngles.x = 0
				var_112_5.localEulerAngles = var_112_5.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_7 and arg_109_1.time_ < 0 + var_112_7 + arg_112_0 then
				var_112_5.localPosition = Vector3.New(0, 100, 0)
				var_112_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_5.position).x, (manager.ui.mainCamera.transform.position - var_112_5.position).y, (manager.ui.mainCamera.transform.position - var_112_5.position).z)
				var_112_5.localEulerAngles.z = 0
				var_112_5.localEulerAngles.x = 0
				var_112_5.localEulerAngles = var_112_5.localEulerAngles

				local var_112_8 = GameObjectTools.GetOrAddComponent(var_112_5.gameObject, typeof(DynamicBoneHelper))

				if var_112_8 then
					var_112_8:EnableDynamicBone(true)
				end
			end

			if 0.166666666666667 < arg_109_1.time_ and arg_109_1.time_ <= 0.166666666666667 + arg_112_0 then
				arg_109_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_clap", "")
			end

			local var_112_10 = 0
			local var_112_11 = 1.3

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_12 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(323011026).content)

				arg_109_1.text_.text = var_112_12

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_14 = 52 <= 0 and var_112_11 or var_112_11 * (utf8.len(var_112_12) / 52)

				if (52 <= 0 and var_112_11 or var_112_11 * (utf8.len(var_112_12) / 52)) > 0 and var_112_11 < var_112_14 then
					arg_109_1.talkMaxDuration = var_112_14

					if var_112_14 + var_112_10 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_10
					end
				end

				arg_109_1.text_.text = var_112_12
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_15 = math.max(var_112_11, arg_109_1.talkMaxDuration)

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_15 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_10) / var_112_15

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_10 + var_112_15 and arg_109_1.time_ < var_112_10 + var_112_15 + arg_112_0 then
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
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10163ui_story"]) and arg_113_1.var_.characterEffect10163ui_story == nil then
				arg_113_1.var_.characterEffect10163ui_story = arg_113_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10163ui_story"]) then
				if arg_113_1.var_.characterEffect10163ui_story and not isNil(arg_113_1.actors_["10163ui_story"]) then
					arg_113_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10163ui_story"]) and arg_113_1.var_.characterEffect10163ui_story then
				arg_113_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_2")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_116_2 = arg_113_1.actors_["10163ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10163ui_story = var_116_2.localPosition

				local var_116_3 = GameObjectTools.GetOrAddComponent(var_116_2.gameObject, typeof(DynamicBoneHelper))

				if var_116_3 then
					var_116_3:EnableDynamicBone(false)
				end
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_2.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10163ui_story, Vector3.New(0, -1.08, -5.83), (arg_113_1.time_ - 0) / var_116_4)
				var_116_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_2.position).x, (manager.ui.mainCamera.transform.position - var_116_2.position).y, (manager.ui.mainCamera.transform.position - var_116_2.position).z)
				var_116_2.localEulerAngles.z = 0
				var_116_2.localEulerAngles.x = 0
				var_116_2.localEulerAngles = var_116_2.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_2.localPosition = Vector3.New(0, -1.08, -5.83)
				var_116_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_2.position).x, (manager.ui.mainCamera.transform.position - var_116_2.position).y, (manager.ui.mainCamera.transform.position - var_116_2.position).z)
				var_116_2.localEulerAngles.z = 0
				var_116_2.localEulerAngles.x = 0
				var_116_2.localEulerAngles = var_116_2.localEulerAngles

				local var_116_5 = GameObjectTools.GetOrAddComponent(var_116_2.gameObject, typeof(DynamicBoneHelper))

				if var_116_5 then
					var_116_5:EnableDynamicBone(true)
				end
			end

			local var_116_6 = 0
			local var_116_7 = 0.325

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:GetWordFromCfg(323011027)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 13 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 13)

				if (13 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 13)) > 0 and var_116_7 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011027", "story_v_out_323011.awb") ~= 0 then
					local var_116_12 = manager.audio:GetVoiceLength("story_v_out_323011", "323011027", "story_v_out_323011.awb") / 1000

					if var_116_12 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_6
					end

					if var_116_8.prefab_name ~= "" and arg_113_1.actors_[var_116_8.prefab_name] ~= nil then
						local var_116_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_8.prefab_name].transform, "story_v_out_323011", "323011027", "story_v_out_323011.awb")

						arg_113_1:RecordAudio("323011027", var_116_13)
						arg_113_1:RecordAudio("323011027", var_116_13)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_323011", "323011027", "story_v_out_323011.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_323011", "323011027", "story_v_out_323011.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
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
			local var_120_0 = 0.525

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(323011028)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 21 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 21)

				if (21 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 21)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011028", "story_v_out_323011.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_323011", "323011028", "story_v_out_323011.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_323011", "323011028", "story_v_out_323011.awb")

						arg_117_1:RecordAudio("323011028", var_120_6)
						arg_117_1:RecordAudio("323011028", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_323011", "323011028", "story_v_out_323011.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_323011", "323011028", "story_v_out_323011.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
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
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["10165ui_story"]) and arg_121_1.var_.characterEffect10165ui_story == nil then
				arg_121_1.var_.characterEffect10165ui_story = arg_121_1.actors_["10165ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["10165ui_story"]) then
				if arg_121_1.var_.characterEffect10165ui_story and not isNil(arg_121_1.actors_["10165ui_story"]) then
					arg_121_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["10165ui_story"]) and arg_121_1.var_.characterEffect10165ui_story then
				arg_121_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_124_2 = arg_121_1.actors_["10163ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect10163ui_story == nil then
				arg_121_1.var_.characterEffect10163ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.characterEffect10163ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_3)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect10163ui_story then
				arg_121_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			local var_124_4 = arg_121_1.actors_["10163ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10163ui_story = var_124_4.localPosition

				local var_124_5 = GameObjectTools.GetOrAddComponent(var_124_4.gameObject, typeof(DynamicBoneHelper))

				if var_124_5 then
					var_124_5:EnableDynamicBone(false)
				end
			end

			local var_124_6 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 then
				var_124_4.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10163ui_story, Vector3.New(-0.74, -1.08, -5.83), (arg_121_1.time_ - 0) / var_124_6)
				var_124_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_4.position).x, (manager.ui.mainCamera.transform.position - var_124_4.position).y, (manager.ui.mainCamera.transform.position - var_124_4.position).z)
				var_124_4.localEulerAngles.z = 0
				var_124_4.localEulerAngles.x = 0
				var_124_4.localEulerAngles = var_124_4.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 then
				var_124_4.localPosition = Vector3.New(-0.74, -1.08, -5.83)
				var_124_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_4.position).x, (manager.ui.mainCamera.transform.position - var_124_4.position).y, (manager.ui.mainCamera.transform.position - var_124_4.position).z)
				var_124_4.localEulerAngles.z = 0
				var_124_4.localEulerAngles.x = 0
				var_124_4.localEulerAngles = var_124_4.localEulerAngles

				local var_124_7 = GameObjectTools.GetOrAddComponent(var_124_4.gameObject, typeof(DynamicBoneHelper))

				if var_124_7 then
					var_124_7:EnableDynamicBone(true)
				end
			end

			local var_124_8 = arg_121_1.actors_["10165ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10165ui_story = var_124_8.localPosition

				local var_124_9 = GameObjectTools.GetOrAddComponent(var_124_8.gameObject, typeof(DynamicBoneHelper))

				if var_124_9 then
					var_124_9:EnableDynamicBone(false)
				end
			end

			local var_124_10 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_10 then
				var_124_8.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10165ui_story, Vector3.New(0.7, -1.08, -5.83), (arg_121_1.time_ - 0) / var_124_10)
				var_124_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_8.position).x, (manager.ui.mainCamera.transform.position - var_124_8.position).y, (manager.ui.mainCamera.transform.position - var_124_8.position).z)
				var_124_8.localEulerAngles.z = 0
				var_124_8.localEulerAngles.x = 0
				var_124_8.localEulerAngles = var_124_8.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_10 and arg_121_1.time_ < 0 + var_124_10 + arg_124_0 then
				var_124_8.localPosition = Vector3.New(0.7, -1.08, -5.83)
				var_124_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_8.position).x, (manager.ui.mainCamera.transform.position - var_124_8.position).y, (manager.ui.mainCamera.transform.position - var_124_8.position).z)
				var_124_8.localEulerAngles.z = 0
				var_124_8.localEulerAngles.x = 0
				var_124_8.localEulerAngles = var_124_8.localEulerAngles

				local var_124_11 = GameObjectTools.GetOrAddComponent(var_124_8.gameObject, typeof(DynamicBoneHelper))

				if var_124_11 then
					var_124_11:EnableDynamicBone(true)
				end
			end

			local var_124_12 = 0
			local var_124_13 = 0.325

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_14 = arg_121_1:GetWordFromCfg(323011029)
				local var_124_15 = arg_121_1:FormatText(var_124_14.content)

				arg_121_1.text_.text = var_124_15

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_17 = 13 <= 0 and var_124_13 or var_124_13 * (utf8.len(var_124_15) / 13)

				if (13 <= 0 and var_124_13 or var_124_13 * (utf8.len(var_124_15) / 13)) > 0 and var_124_13 < var_124_17 then
					arg_121_1.talkMaxDuration = var_124_17

					if var_124_17 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_17 + var_124_12
					end
				end

				arg_121_1.text_.text = var_124_15
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011029", "story_v_out_323011.awb") ~= 0 then
					local var_124_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011029", "story_v_out_323011.awb") / 1000

					if var_124_18 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_18 + var_124_12
					end

					if var_124_14.prefab_name ~= "" and arg_121_1.actors_[var_124_14.prefab_name] ~= nil then
						local var_124_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_14.prefab_name].transform, "story_v_out_323011", "323011029", "story_v_out_323011.awb")

						arg_121_1:RecordAudio("323011029", var_124_19)
						arg_121_1:RecordAudio("323011029", var_124_19)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_323011", "323011029", "story_v_out_323011.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_323011", "323011029", "story_v_out_323011.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_20 = math.max(var_124_13, arg_121_1.talkMaxDuration)

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_20 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_12) / var_124_20

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_12 + var_124_20 and arg_121_1.time_ < var_124_12 + var_124_20 + arg_124_0 then
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
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10163ui_story"]) and arg_125_1.var_.characterEffect10163ui_story == nil then
				arg_125_1.var_.characterEffect10163ui_story = arg_125_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10163ui_story"]) then
				if arg_125_1.var_.characterEffect10163ui_story and not isNil(arg_125_1.actors_["10163ui_story"]) then
					arg_125_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10163ui_story"]) and arg_125_1.var_.characterEffect10163ui_story then
				arg_125_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_128_2 = arg_125_1.actors_["10165ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect10165ui_story == nil then
				arg_125_1.var_.characterEffect10165ui_story = var_128_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_3 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_3 and not isNil(var_128_2) then
				if arg_125_1.var_.characterEffect10165ui_story and not isNil(var_128_2) then
					arg_125_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_125_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_3)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_3 and arg_125_1.time_ < 0 + var_128_3 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.characterEffect10165ui_story then
				arg_125_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_125_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_128_4 = 0
			local var_128_5 = 0.35

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(323011030)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 14 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 14)

				if (14 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 14)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011030", "story_v_out_323011.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011030", "story_v_out_323011.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_323011", "323011030", "story_v_out_323011.awb")

						arg_125_1:RecordAudio("323011030", var_128_11)
						arg_125_1:RecordAudio("323011030", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_323011", "323011030", "story_v_out_323011.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_323011", "323011030", "story_v_out_323011.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
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
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10165ui_story"]) and arg_129_1.var_.characterEffect10165ui_story == nil then
				arg_129_1.var_.characterEffect10165ui_story = arg_129_1.actors_["10165ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10165ui_story"]) then
				if arg_129_1.var_.characterEffect10165ui_story and not isNil(arg_129_1.actors_["10165ui_story"]) then
					arg_129_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10165ui_story"]) and arg_129_1.var_.characterEffect10165ui_story then
				arg_129_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_132_2 = arg_129_1.actors_["10163ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect10163ui_story == nil then
				arg_129_1.var_.characterEffect10163ui_story = var_132_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_3 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_3 and not isNil(var_132_2) then
				if arg_129_1.var_.characterEffect10163ui_story and not isNil(var_132_2) then
					arg_129_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_3)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_3 and arg_129_1.time_ < 0 + var_132_3 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.characterEffect10163ui_story then
				arg_129_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_2")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_132_4 = 0
			local var_132_5 = 0.525

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(323011031)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 22 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 22)

				if (22 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 22)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011031", "story_v_out_323011.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011031", "story_v_out_323011.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_out_323011", "323011031", "story_v_out_323011.awb")

						arg_129_1:RecordAudio("323011031", var_132_11)
						arg_129_1:RecordAudio("323011031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_323011", "323011031", "story_v_out_323011.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_323011", "323011031", "story_v_out_323011.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
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
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10163ui_story"]) and arg_133_1.var_.characterEffect10163ui_story == nil then
				arg_133_1.var_.characterEffect10163ui_story = arg_133_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10163ui_story"]) then
				if arg_133_1.var_.characterEffect10163ui_story and not isNil(arg_133_1.actors_["10163ui_story"]) then
					arg_133_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10163ui_story"]) and arg_133_1.var_.characterEffect10163ui_story then
				arg_133_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_136_2 = arg_133_1.actors_["10165ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect10165ui_story == nil then
				arg_133_1.var_.characterEffect10165ui_story = var_136_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_3 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.characterEffect10165ui_story and not isNil(var_136_2) then
					arg_133_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_133_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_3)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.characterEffect10165ui_story then
				arg_133_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_133_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			local var_136_4 = 0
			local var_136_5 = 0.875

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(323011032)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 35 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 35)

				if (35 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 35)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011032", "story_v_out_323011.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011032", "story_v_out_323011.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_323011", "323011032", "story_v_out_323011.awb")

						arg_133_1:RecordAudio("323011032", var_136_11)
						arg_133_1:RecordAudio("323011032", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_323011", "323011032", "story_v_out_323011.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_323011", "323011032", "story_v_out_323011.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
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
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["10165ui_story"]) and arg_137_1.var_.characterEffect10165ui_story == nil then
				arg_137_1.var_.characterEffect10165ui_story = arg_137_1.actors_["10165ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["10165ui_story"]) then
				if arg_137_1.var_.characterEffect10165ui_story and not isNil(arg_137_1.actors_["10165ui_story"]) then
					arg_137_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["10165ui_story"]) and arg_137_1.var_.characterEffect10165ui_story then
				arg_137_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_140_2 = arg_137_1.actors_["10163ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect10163ui_story == nil then
				arg_137_1.var_.characterEffect10163ui_story = var_140_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_3 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.characterEffect10163ui_story and not isNil(var_140_2) then
					arg_137_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_3)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.characterEffect10163ui_story then
				arg_137_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			local var_140_4 = 0
			local var_140_5 = 0.9

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(323011033)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 38 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 38)

				if (38 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 38)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011033", "story_v_out_323011.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011033", "story_v_out_323011.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_323011", "323011033", "story_v_out_323011.awb")

						arg_137_1:RecordAudio("323011033", var_140_11)
						arg_137_1:RecordAudio("323011033", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_323011", "323011033", "story_v_out_323011.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_323011", "323011033", "story_v_out_323011.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
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
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10163ui_story"]) and arg_141_1.var_.characterEffect10163ui_story == nil then
				arg_141_1.var_.characterEffect10163ui_story = arg_141_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10163ui_story"]) then
				if arg_141_1.var_.characterEffect10163ui_story and not isNil(arg_141_1.actors_["10163ui_story"]) then
					arg_141_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10163ui_story"]) and arg_141_1.var_.characterEffect10163ui_story then
				arg_141_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_144_2 = arg_141_1.actors_["10165ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect10165ui_story == nil then
				arg_141_1.var_.characterEffect10165ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.characterEffect10165ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_3)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect10165ui_story then
				arg_141_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_2")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_144_4 = 0
			local var_144_5 = 1.225

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(323011034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 48 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 48)

				if (48 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 48)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011034", "story_v_out_323011.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011034", "story_v_out_323011.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_out_323011", "323011034", "story_v_out_323011.awb")

						arg_141_1:RecordAudio("323011034", var_144_11)
						arg_141_1:RecordAudio("323011034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_323011", "323011034", "story_v_out_323011.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_323011", "323011034", "story_v_out_323011.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
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
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["10165ui_story"]) and arg_145_1.var_.characterEffect10165ui_story == nil then
				arg_145_1.var_.characterEffect10165ui_story = arg_145_1.actors_["10165ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["10165ui_story"]) then
				if arg_145_1.var_.characterEffect10165ui_story and not isNil(arg_145_1.actors_["10165ui_story"]) then
					arg_145_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["10165ui_story"]) and arg_145_1.var_.characterEffect10165ui_story then
				arg_145_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_148_2 = arg_145_1.actors_["10163ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect10163ui_story == nil then
				arg_145_1.var_.characterEffect10163ui_story = var_148_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_3 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.characterEffect10163ui_story and not isNil(var_148_2) then
					arg_145_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_3)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect10163ui_story then
				arg_145_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_148_4 = 0
			local var_148_5 = 0.225

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(323011035)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 9 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 9)

				if (9 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 9)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011035", "story_v_out_323011.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011035", "story_v_out_323011.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_out_323011", "323011035", "story_v_out_323011.awb")

						arg_145_1:RecordAudio("323011035", var_148_11)
						arg_145_1:RecordAudio("323011035", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_323011", "323011035", "story_v_out_323011.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_323011", "323011035", "story_v_out_323011.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
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
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10163ui_story"]) and arg_149_1.var_.characterEffect10163ui_story == nil then
				arg_149_1.var_.characterEffect10163ui_story = arg_149_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10163ui_story"]) then
				if arg_149_1.var_.characterEffect10163ui_story and not isNil(arg_149_1.actors_["10163ui_story"]) then
					arg_149_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10163ui_story"]) and arg_149_1.var_.characterEffect10163ui_story then
				arg_149_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_152_2 = arg_149_1.actors_["10165ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect10165ui_story == nil then
				arg_149_1.var_.characterEffect10165ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect10165ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect10165ui_story then
				arg_149_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_152_4 = 0
			local var_152_5 = 0.1

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(323011036)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 4 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 4)

				if (4 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 4)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011036", "story_v_out_323011.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011036", "story_v_out_323011.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_323011", "323011036", "story_v_out_323011.awb")

						arg_149_1:RecordAudio("323011036", var_152_11)
						arg_149_1:RecordAudio("323011036", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_323011", "323011036", "story_v_out_323011.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_323011", "323011036", "story_v_out_323011.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
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
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10165ui_story"]) and arg_153_1.var_.characterEffect10165ui_story == nil then
				arg_153_1.var_.characterEffect10165ui_story = arg_153_1.actors_["10165ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10165ui_story"]) then
				if arg_153_1.var_.characterEffect10165ui_story and not isNil(arg_153_1.actors_["10165ui_story"]) then
					arg_153_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10165ui_story"]) and arg_153_1.var_.characterEffect10165ui_story then
				arg_153_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_156_2 = arg_153_1.actors_["10163ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect10163ui_story == nil then
				arg_153_1.var_.characterEffect10163ui_story = var_156_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_3 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.characterEffect10163ui_story and not isNil(var_156_2) then
					arg_153_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_3)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.characterEffect10163ui_story then
				arg_153_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_156_4 = 0
			local var_156_5 = 0.675

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(323011037)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 27 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 27)

				if (27 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 27)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011037", "story_v_out_323011.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011037", "story_v_out_323011.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_323011", "323011037", "story_v_out_323011.awb")

						arg_153_1:RecordAudio("323011037", var_156_11)
						arg_153_1:RecordAudio("323011037", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_323011", "323011037", "story_v_out_323011.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_323011", "323011037", "story_v_out_323011.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
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
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10163ui_story = arg_157_1.actors_["10163ui_story"].transform.localPosition

				local var_160_0 = GameObjectTools.GetOrAddComponent(arg_157_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_160_0 then
					var_160_0:EnableDynamicBone(false)
				end
			end

			local var_160_1 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_1 then
				arg_157_1.actors_["10163ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10163ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_1)
				arg_157_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10163ui_story"].transform.position).z)
				arg_157_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10163ui_story"].transform.localEulerAngles = arg_157_1.actors_["10163ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 then
				arg_157_1.actors_["10163ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["10163ui_story"].transform.position).z)
				arg_157_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["10163ui_story"].transform.localEulerAngles = arg_157_1.actors_["10163ui_story"].transform.localEulerAngles

				local var_160_2 = GameObjectTools.GetOrAddComponent(arg_157_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_160_2 then
					var_160_2:EnableDynamicBone(true)
				end
			end

			local var_160_3 = arg_157_1.actors_["10165ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10165ui_story = var_160_3.localPosition

				local var_160_4 = GameObjectTools.GetOrAddComponent(var_160_3.gameObject, typeof(DynamicBoneHelper))

				if var_160_4 then
					var_160_4:EnableDynamicBone(false)
				end
			end

			local var_160_5 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 then
				var_160_3.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10165ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_5)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 then
				var_160_3.localPosition = Vector3.New(0, 100, 0)
				var_160_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_3.position).x, (manager.ui.mainCamera.transform.position - var_160_3.position).y, (manager.ui.mainCamera.transform.position - var_160_3.position).z)
				var_160_3.localEulerAngles.z = 0
				var_160_3.localEulerAngles.x = 0
				var_160_3.localEulerAngles = var_160_3.localEulerAngles

				local var_160_6 = GameObjectTools.GetOrAddComponent(var_160_3.gameObject, typeof(DynamicBoneHelper))

				if var_160_6 then
					var_160_6:EnableDynamicBone(true)
				end
			end

			local var_160_7 = arg_157_1.actors_["10165ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.characterEffect10165ui_story == nil then
				arg_157_1.var_.characterEffect10165ui_story = var_160_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_8 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_8 and not isNil(var_160_7) then
				if arg_157_1.var_.characterEffect10165ui_story and not isNil(var_160_7) then
					arg_157_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_157_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_8)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_8 and arg_157_1.time_ < 0 + var_160_8 + arg_160_0 and not isNil(var_160_7) and arg_157_1.var_.characterEffect10165ui_story then
				arg_157_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_157_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			if 0.366666666666667 < arg_157_1.time_ and arg_157_1.time_ <= 0.366666666666667 + arg_160_0 then
				arg_157_1:AudioAction("play", "effect", "se_story_148", "se_story_148_helmet_hit", "")
			end

			local var_160_10 = 0
			local var_160_11 = 0.925

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_12 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(323011038).content)

				arg_157_1.text_.text = var_160_12

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_14 = 37 <= 0 and var_160_11 or var_160_11 * (utf8.len(var_160_12) / 37)

				if (37 <= 0 and var_160_11 or var_160_11 * (utf8.len(var_160_12) / 37)) > 0 and var_160_11 < var_160_14 then
					arg_157_1.talkMaxDuration = var_160_14

					if var_160_14 + var_160_10 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_10
					end
				end

				arg_157_1.text_.text = var_160_12
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_15 = math.max(var_160_11, arg_157_1.talkMaxDuration)

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_15 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_10) / var_160_15

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_10 + var_160_15 and arg_157_1.time_ < var_160_10 + var_160_15 + arg_160_0 then
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
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10163ui_story = arg_161_1.actors_["10163ui_story"].transform.localPosition

				local var_164_0 = GameObjectTools.GetOrAddComponent(arg_161_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_164_0 then
					var_164_0:EnableDynamicBone(false)
				end
			end

			local var_164_1 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 then
				arg_161_1.actors_["10163ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10163ui_story, Vector3.New(0, -1.08, -5.83), (arg_161_1.time_ - 0) / var_164_1)
				arg_161_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10163ui_story"].transform.position).z)
				arg_161_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10163ui_story"].transform.localEulerAngles = arg_161_1.actors_["10163ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 then
				arg_161_1.actors_["10163ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.83)
				arg_161_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["10163ui_story"].transform.position).z)
				arg_161_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["10163ui_story"].transform.localEulerAngles = arg_161_1.actors_["10163ui_story"].transform.localEulerAngles

				local var_164_2 = GameObjectTools.GetOrAddComponent(arg_161_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_164_2 then
					var_164_2:EnableDynamicBone(true)
				end
			end

			local var_164_3 = arg_161_1.actors_["10163ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_3) and arg_161_1.var_.characterEffect10163ui_story == nil then
				arg_161_1.var_.characterEffect10163ui_story = var_164_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_4 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 and not isNil(var_164_3) then
				if arg_161_1.var_.characterEffect10163ui_story and not isNil(var_164_3) then
					arg_161_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 and not isNil(var_164_3) and arg_161_1.var_.characterEffect10163ui_story then
				arg_161_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_164_6 = 0
			local var_164_7 = 1.1

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_6 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_8 = arg_161_1:GetWordFromCfg(323011039)
				local var_164_9 = arg_161_1:FormatText(var_164_8.content)

				arg_161_1.text_.text = var_164_9

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_11 = 45 <= 0 and var_164_7 or var_164_7 * (utf8.len(var_164_9) / 45)

				if (45 <= 0 and var_164_7 or var_164_7 * (utf8.len(var_164_9) / 45)) > 0 and var_164_7 < var_164_11 then
					arg_161_1.talkMaxDuration = var_164_11

					if var_164_11 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_6
					end
				end

				arg_161_1.text_.text = var_164_9
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011039", "story_v_out_323011.awb") ~= 0 then
					local var_164_12 = manager.audio:GetVoiceLength("story_v_out_323011", "323011039", "story_v_out_323011.awb") / 1000

					if var_164_12 + var_164_6 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_12 + var_164_6
					end

					if var_164_8.prefab_name ~= "" and arg_161_1.actors_[var_164_8.prefab_name] ~= nil then
						local var_164_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_8.prefab_name].transform, "story_v_out_323011", "323011039", "story_v_out_323011.awb")

						arg_161_1:RecordAudio("323011039", var_164_13)
						arg_161_1:RecordAudio("323011039", var_164_13)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_323011", "323011039", "story_v_out_323011.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_323011", "323011039", "story_v_out_323011.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_14 = math.max(var_164_7, arg_161_1.talkMaxDuration)

			if var_164_6 <= arg_161_1.time_ and arg_161_1.time_ < var_164_6 + var_164_14 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_6) / var_164_14

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_6 + var_164_14 and arg_161_1.time_ < var_164_6 + var_164_14 + arg_164_0 then
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
			local var_168_0 = 0.475

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(323011040)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 19 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 19)

				if (19 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 19)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011040", "story_v_out_323011.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_323011", "323011040", "story_v_out_323011.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_323011", "323011040", "story_v_out_323011.awb")

						arg_165_1:RecordAudio("323011040", var_168_6)
						arg_165_1:RecordAudio("323011040", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_323011", "323011040", "story_v_out_323011.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_323011", "323011040", "story_v_out_323011.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
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
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10165ui_story = arg_169_1.actors_["10165ui_story"].transform.localPosition

				local var_172_0 = GameObjectTools.GetOrAddComponent(arg_169_1.actors_["10165ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_172_0 then
					var_172_0:EnableDynamicBone(false)
				end
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				arg_169_1.actors_["10165ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10165ui_story, Vector3.New(0.7, -1.08, -5.83), (arg_169_1.time_ - 0) / var_172_1)
				arg_169_1.actors_["10165ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10165ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10165ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10165ui_story"].transform.position).z)
				arg_169_1.actors_["10165ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10165ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10165ui_story"].transform.localEulerAngles = arg_169_1.actors_["10165ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["10165ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.83)
				arg_169_1.actors_["10165ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10165ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10165ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10165ui_story"].transform.position).z)
				arg_169_1.actors_["10165ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10165ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10165ui_story"].transform.localEulerAngles = arg_169_1.actors_["10165ui_story"].transform.localEulerAngles

				local var_172_2 = GameObjectTools.GetOrAddComponent(arg_169_1.actors_["10165ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_172_2 then
					var_172_2:EnableDynamicBone(true)
				end
			end

			local var_172_3 = arg_169_1.actors_["10163ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10163ui_story = var_172_3.localPosition

				local var_172_4 = GameObjectTools.GetOrAddComponent(var_172_3.gameObject, typeof(DynamicBoneHelper))

				if var_172_4 then
					var_172_4:EnableDynamicBone(false)
				end
			end

			local var_172_5 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_5 then
				var_172_3.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10163ui_story, Vector3.New(-0.74, -1.08, -5.83), (arg_169_1.time_ - 0) / var_172_5)
				var_172_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_3.position).x, (manager.ui.mainCamera.transform.position - var_172_3.position).y, (manager.ui.mainCamera.transform.position - var_172_3.position).z)
				var_172_3.localEulerAngles.z = 0
				var_172_3.localEulerAngles.x = 0
				var_172_3.localEulerAngles = var_172_3.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_5 and arg_169_1.time_ < 0 + var_172_5 + arg_172_0 then
				var_172_3.localPosition = Vector3.New(-0.74, -1.08, -5.83)
				var_172_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_3.position).x, (manager.ui.mainCamera.transform.position - var_172_3.position).y, (manager.ui.mainCamera.transform.position - var_172_3.position).z)
				var_172_3.localEulerAngles.z = 0
				var_172_3.localEulerAngles.x = 0
				var_172_3.localEulerAngles = var_172_3.localEulerAngles

				local var_172_6 = GameObjectTools.GetOrAddComponent(var_172_3.gameObject, typeof(DynamicBoneHelper))

				if var_172_6 then
					var_172_6:EnableDynamicBone(true)
				end
			end

			local var_172_7 = arg_169_1.actors_["10165ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.characterEffect10165ui_story == nil then
				arg_169_1.var_.characterEffect10165ui_story = var_172_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_8 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_8 and not isNil(var_172_7) then
				if arg_169_1.var_.characterEffect10165ui_story and not isNil(var_172_7) then
					arg_169_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_8 and arg_169_1.time_ < 0 + var_172_8 + arg_172_0 and not isNil(var_172_7) and arg_169_1.var_.characterEffect10165ui_story then
				arg_169_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_172_10 = arg_169_1.actors_["10163ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_10) and arg_169_1.var_.characterEffect10163ui_story == nil then
				arg_169_1.var_.characterEffect10163ui_story = var_172_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_11 and not isNil(var_172_10) then
				if arg_169_1.var_.characterEffect10163ui_story and not isNil(var_172_10) then
					arg_169_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_169_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_11)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_11 and arg_169_1.time_ < 0 + var_172_11 + arg_172_0 and not isNil(var_172_10) and arg_169_1.var_.characterEffect10163ui_story then
				arg_169_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_169_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_172_12 = 0
			local var_172_13 = 0.7

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_12 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_14 = arg_169_1:GetWordFromCfg(323011041)
				local var_172_15 = arg_169_1:FormatText(var_172_14.content)

				arg_169_1.text_.text = var_172_15

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_17 = 28 <= 0 and var_172_13 or var_172_13 * (utf8.len(var_172_15) / 28)

				if (28 <= 0 and var_172_13 or var_172_13 * (utf8.len(var_172_15) / 28)) > 0 and var_172_13 < var_172_17 then
					arg_169_1.talkMaxDuration = var_172_17

					if var_172_17 + var_172_12 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_17 + var_172_12
					end
				end

				arg_169_1.text_.text = var_172_15
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011041", "story_v_out_323011.awb") ~= 0 then
					local var_172_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011041", "story_v_out_323011.awb") / 1000

					if var_172_18 + var_172_12 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_18 + var_172_12
					end

					if var_172_14.prefab_name ~= "" and arg_169_1.actors_[var_172_14.prefab_name] ~= nil then
						local var_172_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_14.prefab_name].transform, "story_v_out_323011", "323011041", "story_v_out_323011.awb")

						arg_169_1:RecordAudio("323011041", var_172_19)
						arg_169_1:RecordAudio("323011041", var_172_19)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_323011", "323011041", "story_v_out_323011.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_323011", "323011041", "story_v_out_323011.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_20 = math.max(var_172_13, arg_169_1.talkMaxDuration)

			if var_172_12 <= arg_169_1.time_ and arg_169_1.time_ < var_172_12 + var_172_20 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_12) / var_172_20

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_12 + var_172_20 and arg_169_1.time_ < var_172_12 + var_172_20 + arg_172_0 then
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
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10163ui_story = arg_173_1.actors_["10163ui_story"].transform.localPosition

				local var_176_0 = GameObjectTools.GetOrAddComponent(arg_173_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_176_0 then
					var_176_0:EnableDynamicBone(false)
				end
			end

			local var_176_1 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["10163ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10163ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_1)
				arg_173_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10163ui_story"].transform.position).z)
				arg_173_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10163ui_story"].transform.localEulerAngles = arg_173_1.actors_["10163ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["10163ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10163ui_story"].transform.position).z)
				arg_173_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10163ui_story"].transform.localEulerAngles = arg_173_1.actors_["10163ui_story"].transform.localEulerAngles

				local var_176_2 = GameObjectTools.GetOrAddComponent(arg_173_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_176_2 then
					var_176_2:EnableDynamicBone(true)
				end
			end

			local var_176_3 = arg_173_1.actors_["10165ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10165ui_story = var_176_3.localPosition

				local var_176_4 = GameObjectTools.GetOrAddComponent(var_176_3.gameObject, typeof(DynamicBoneHelper))

				if var_176_4 then
					var_176_4:EnableDynamicBone(false)
				end
			end

			local var_176_5 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 then
				var_176_3.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10165ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_5)
				var_176_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_3.position).x, (manager.ui.mainCamera.transform.position - var_176_3.position).y, (manager.ui.mainCamera.transform.position - var_176_3.position).z)
				var_176_3.localEulerAngles.z = 0
				var_176_3.localEulerAngles.x = 0
				var_176_3.localEulerAngles = var_176_3.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 then
				var_176_3.localPosition = Vector3.New(0, 100, 0)
				var_176_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_3.position).x, (manager.ui.mainCamera.transform.position - var_176_3.position).y, (manager.ui.mainCamera.transform.position - var_176_3.position).z)
				var_176_3.localEulerAngles.z = 0
				var_176_3.localEulerAngles.x = 0
				var_176_3.localEulerAngles = var_176_3.localEulerAngles

				local var_176_6 = GameObjectTools.GetOrAddComponent(var_176_3.gameObject, typeof(DynamicBoneHelper))

				if var_176_6 then
					var_176_6:EnableDynamicBone(true)
				end
			end

			local var_176_7 = arg_173_1.actors_["10165ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.characterEffect10165ui_story == nil then
				arg_173_1.var_.characterEffect10165ui_story = var_176_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_8 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_8 and not isNil(var_176_7) then
				if arg_173_1.var_.characterEffect10165ui_story and not isNil(var_176_7) then
					arg_173_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_8)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_8 and arg_173_1.time_ < 0 + var_176_8 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.characterEffect10165ui_story then
				arg_173_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			local var_176_9 = 0
			local var_176_10 = 1.1

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_9 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_11 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(323011042).content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 44 <= 0 and var_176_10 or var_176_10 * (utf8.len(var_176_11) / 44)

				if (44 <= 0 and var_176_10 or var_176_10 * (utf8.len(var_176_11) / 44)) > 0 and var_176_10 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_9 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_9
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_10, arg_173_1.talkMaxDuration)

			if var_176_9 <= arg_173_1.time_ and arg_173_1.time_ < var_176_9 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_9) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_9 + var_176_14 and arg_173_1.time_ < var_176_9 + var_176_14 + arg_176_0 then
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
			if 1.4 < arg_177_1.time_ and arg_177_1.time_ <= 1.4 + arg_180_0 then
				local var_180_0 = arg_177_1.bgs_.STblack

				arg_177_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_180_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_180_1 = var_180_0:GetComponent("SpriteRenderer")

				if var_180_1 and var_180_1.sprite then
					local var_180_2 = 2 * (var_180_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_180_0.transform.localScale = Vector3.New(var_180_2 / var_180_1.sprite.bounds.size.y < var_180_2 * manager.ui.mainCameraCom_.aspect / var_180_1.sprite.bounds.size.x and var_180_2 * manager.ui.mainCameraCom_.aspect / var_180_1.sprite.bounds.size.x or var_180_2 / var_180_1.sprite.bounds.size.y, var_180_2 / var_180_1.sprite.bounds.size.y < var_180_2 * manager.ui.mainCameraCom_.aspect / var_180_1.sprite.bounds.size.x and var_180_2 * manager.ui.mainCameraCom_.aspect / var_180_1.sprite.bounds.size.x or var_180_2 / var_180_1.sprite.bounds.size.y, 0)
				end

				for iter_180_0, iter_180_1 in pairs(arg_177_1.bgs_) do
					if iter_180_0 ~= "STblack" then
						iter_180_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_180_3 = 1.4

			if 1.4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_3 + arg_180_0 then
				arg_177_1.allBtn_.enabled = false
			end

			if arg_177_1.time_ >= var_180_3 + 0.3 and arg_177_1.time_ < var_180_3 + 0.3 + arg_180_0 then
				arg_177_1.allBtn_.enabled = true
			end

			local var_180_4 = 0

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_5 = 1.41666666666667

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_5 then
				local var_180_6 = Color.New(0, 0, 0)

				var_180_6.a = Mathf.Lerp(0, 1, (arg_177_1.time_ - var_180_4) / var_180_5)
				arg_177_1.mask_.color = var_180_6
			end

			if arg_177_1.time_ >= var_180_4 + var_180_5 and arg_177_1.time_ < var_180_4 + var_180_5 + arg_180_0 then
				local var_180_7 = Color.New(0, 0, 0)

				var_180_7.a = 1
				arg_177_1.mask_.color = var_180_7
			end

			local var_180_8 = 1.4

			if 1.4 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.mask_.enabled = true
				arg_177_1.mask_.raycastTarget = true

				arg_177_1:SetGaussion(false)
			end

			local var_180_9 = 2

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_9 then
				local var_180_10 = Color.New(0, 0, 0)

				var_180_10.a = Mathf.Lerp(1, 0, (arg_177_1.time_ - var_180_8) / var_180_9)
				arg_177_1.mask_.color = var_180_10
			end

			if arg_177_1.time_ >= var_180_8 + var_180_9 and arg_177_1.time_ < var_180_8 + var_180_9 + arg_180_0 then
				local var_180_11 = Color.New(0, 0, 0)

				arg_177_1.mask_.enabled = false
				var_180_11.a = 0
				arg_177_1.mask_.color = var_180_11
			end

			if 1.4 < arg_177_1.time_ and arg_177_1.time_ <= 1.4 + arg_180_0 then
				arg_177_1.cswbg_:SetActive(true)

				local var_180_12 = arg_177_1.cswt_:GetComponent("RectTransform")

				arg_177_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_180_12.offsetMin = Vector2.New(400, -200)
				var_180_12.offsetMax = Vector2.New(-400, -262.5)
				arg_177_1.cswt_.text = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(419175).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.cswt_)

				arg_177_1.cswt_.fontSize = 108
				arg_177_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_177_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_177_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1.4 < arg_177_1.time_ and arg_177_1.time_ <= 1.4 + arg_180_0 then
				arg_177_1.fswbg_:SetActive(true)
				arg_177_1.dialog_:SetActive(false)

				arg_177_1.fswtw_.percent = 0
				arg_177_1.fswt_.text = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.fswt_)

				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_177_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_177_1.fswtw_:SetDirty()

				arg_177_1.typewritterCharCountI18N = 0

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_13 = 2.75

			if 2.75 < arg_177_1.time_ and arg_177_1.time_ <= var_180_13 + arg_180_0 then
				arg_177_1.var_.oldValueTypewriter = arg_177_1.fswtw_.percent

				SetActive(arg_177_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_177_1:ShowNextGo(false)
			end

			local var_180_14 = 0
			local var_180_15 = 0.65
			local var_180_16, var_180_17 = arg_177_1:GetPercentByPara(arg_177_1:FormatText(arg_177_1:GetWordFromCfg(102).content), 1)

			if var_180_13 < arg_177_1.time_ and arg_177_1.time_ <= var_180_13 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0

				local var_180_18 = var_180_14 <= 0 and var_180_15 or var_180_15 * ((var_180_17 - arg_177_1.typewritterCharCountI18N) / var_180_14)

				if (var_180_14 <= 0 and var_180_15 or var_180_15 * ((var_180_17 - arg_177_1.typewritterCharCountI18N) / var_180_14)) > 0 and var_180_15 < var_180_18 then
					arg_177_1.talkMaxDuration = var_180_18

					if var_180_18 + var_180_13 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_18 + var_180_13
					end
				end
			end

			local var_180_19 = math.max(0.65, arg_177_1.talkMaxDuration)

			if var_180_13 <= arg_177_1.time_ and arg_177_1.time_ < var_180_13 + var_180_19 then
				arg_177_1.fswtw_.percent = Mathf.Lerp(arg_177_1.var_.oldValueTypewriter, var_180_16, (arg_177_1.time_ - var_180_13) / var_180_19)
				arg_177_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_177_1.fswtw_:SetDirty()
			end

			if arg_177_1.time_ >= var_180_13 + var_180_19 and arg_177_1.time_ < var_180_13 + var_180_19 + arg_180_0 then
				arg_177_1.fswtw_.percent = var_180_16

				arg_177_1.fswtw_:SetDirty()
				arg_177_1:ShowNextGo(true)

				arg_177_1.typewritterCharCountI18N = var_180_17
			end

			if 1.41666666666667 < arg_177_1.time_ and arg_177_1.time_ <= 1.41666666666667 + arg_180_0 then
				arg_177_1:AudioAction("play", "effect", "se_story_148", "se_story_148_bell_temple_china01", "")
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
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				local var_184_0 = arg_181_1.fswbg_.transform:Find("textbox/adapt/content") or arg_181_1.fswbg_.transform:Find("textbox/content")
				local var_184_1 = arg_181_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_184_2 = var_184_0:GetComponent("RectTransform")

				var_184_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_184_2.offsetMin = Vector2.New(0, 0)
				var_184_2.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.fswbg_:SetActive(true)
				arg_181_1.dialog_:SetActive(false)

				arg_181_1.fswtw_.percent = 0
				arg_181_1.fswt_.text = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(323011044).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.fswt_)

				arg_181_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_181_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_181_1.fswtw_:SetDirty()

				arg_181_1.typewritterCharCountI18N = 0

				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_181_1:ShowNextGo(false)
			end

			local var_184_3 = 0.433333333333333

			if 0.433333333333333 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
				arg_181_1.var_.oldValueTypewriter = arg_181_1.fswtw_.percent

				SetActive(arg_181_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_181_1:ShowNextGo(false)
			end

			local var_184_4 = 2
			local var_184_5 = 0.133333333333333
			local var_184_6, var_184_7 = arg_181_1:GetPercentByPara(arg_181_1:FormatText(arg_181_1:GetWordFromCfg(323011044).content), 1)

			if var_184_3 < arg_181_1.time_ and arg_181_1.time_ <= var_184_3 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				local var_184_8 = var_184_4 <= 0 and var_184_5 or var_184_5 * ((var_184_7 - arg_181_1.typewritterCharCountI18N) / var_184_4)

				if (var_184_4 <= 0 and var_184_5 or var_184_5 * ((var_184_7 - arg_181_1.typewritterCharCountI18N) / var_184_4)) > 0 and var_184_5 < var_184_8 then
					arg_181_1.talkMaxDuration = var_184_8

					if var_184_8 + var_184_3 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_3
					end
				end
			end

			local var_184_9 = math.max(0.133333333333333, arg_181_1.talkMaxDuration)

			if var_184_3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_3 + var_184_9 then
				arg_181_1.fswtw_.percent = Mathf.Lerp(arg_181_1.var_.oldValueTypewriter, var_184_6, (arg_181_1.time_ - var_184_3) / var_184_9)
				arg_181_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_181_1.fswtw_:SetDirty()
			end

			if arg_181_1.time_ >= var_184_3 + var_184_9 and arg_181_1.time_ < var_184_3 + var_184_9 + arg_184_0 then
				arg_181_1.fswtw_.percent = var_184_6

				arg_181_1.fswtw_:SetDirty()
				arg_181_1:ShowNextGo(true)

				arg_181_1.typewritterCharCountI18N = var_184_7
			end

			local var_184_10 = 0.433333333333333
			local var_184_11 = manager.audio:GetVoiceLength("story_v_out_323011", "323011044", "0") / 1000

			if var_184_11 > 0 and 1 < var_184_11 and var_184_11 + var_184_10 > arg_181_1.duration_ then
				arg_181_1.duration_ = var_184_11 + var_184_10
			end

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1:AudioAction("play", "voice", "story_v_out_323011", "323011044", "0")
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
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.fswbg_:SetActive(true)
				arg_185_1.dialog_:SetActive(false)

				arg_185_1.fswtw_.percent = 0
				arg_185_1.fswt_.text = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(323011045).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.fswt_)

				arg_185_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_185_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_185_1.fswtw_:SetDirty()

				arg_185_1.typewritterCharCountI18N = 0

				SetActive(arg_185_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_185_1:ShowNextGo(false)
			end

			local var_188_0 = 0.433333333333333

			if 0.433333333333333 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.var_.oldValueTypewriter = arg_185_1.fswtw_.percent

				SetActive(arg_185_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_185_1:ShowNextGo(false)
			end

			local var_188_1 = 5
			local var_188_2 = 0.333333333333333
			local var_188_3, var_188_4 = arg_185_1:GetPercentByPara(arg_185_1:FormatText(arg_185_1:GetWordFromCfg(323011045).content), 1)

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				local var_188_5 = var_188_1 <= 0 and var_188_2 or var_188_2 * ((var_188_4 - arg_185_1.typewritterCharCountI18N) / var_188_1)

				if (var_188_1 <= 0 and var_188_2 or var_188_2 * ((var_188_4 - arg_185_1.typewritterCharCountI18N) / var_188_1)) > 0 and var_188_2 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_0
					end
				end
			end

			local var_188_6 = math.max(0.333333333333333, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_6 then
				arg_185_1.fswtw_.percent = Mathf.Lerp(arg_185_1.var_.oldValueTypewriter, var_188_3, (arg_185_1.time_ - var_188_0) / var_188_6)
				arg_185_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_185_1.fswtw_:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_6 and arg_185_1.time_ < var_188_0 + var_188_6 + arg_188_0 then
				arg_185_1.fswtw_.percent = var_188_3

				arg_185_1.fswtw_:SetDirty()
				arg_185_1:ShowNextGo(true)

				arg_185_1.typewritterCharCountI18N = var_188_4
			end

			local var_188_7 = 0.433333333333333
			local var_188_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011045", "0") / 1000

			if var_188_8 > 0 and 1 < var_188_8 and var_188_8 + var_188_7 > arg_185_1.duration_ then
				arg_185_1.duration_ = var_188_8 + var_188_7
			end

			if var_188_7 < arg_185_1.time_ and arg_185_1.time_ <= var_188_7 + arg_188_0 then
				arg_185_1:AudioAction("play", "voice", "story_v_out_323011", "323011045", "0")
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
			if 1 < arg_189_1.time_ and arg_189_1.time_ <= 1 + arg_192_0 then
				local var_192_0 = arg_189_1.bgs_.ST2015

				arg_189_1.bgs_.ST2015.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_192_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_192_1 = var_192_0:GetComponent("SpriteRenderer")

				if var_192_1 and var_192_1.sprite then
					local var_192_2 = 2 * (var_192_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_192_0.transform.localScale = Vector3.New(var_192_2 / var_192_1.sprite.bounds.size.y < var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x and var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x or var_192_2 / var_192_1.sprite.bounds.size.y, var_192_2 / var_192_1.sprite.bounds.size.y < var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x and var_192_2 * manager.ui.mainCameraCom_.aspect / var_192_1.sprite.bounds.size.x or var_192_2 / var_192_1.sprite.bounds.size.y, 0)
				end

				for iter_192_0, iter_192_1 in pairs(arg_189_1.bgs_) do
					if iter_192_0 ~= "ST2015" then
						iter_192_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_192_3 = 1

			if 1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_3 + arg_192_0 then
				arg_189_1.allBtn_.enabled = false
			end

			if arg_189_1.time_ >= var_192_3 + 0.3 and arg_189_1.time_ < var_192_3 + 0.3 + arg_192_0 then
				arg_189_1.allBtn_.enabled = true
			end

			local var_192_4 = 0

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_5 = 1.01666666666667

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_5 then
				local var_192_6 = Color.New(0, 0, 0)

				var_192_6.a = Mathf.Lerp(0, 1, (arg_189_1.time_ - var_192_4) / var_192_5)
				arg_189_1.mask_.color = var_192_6
			end

			if arg_189_1.time_ >= var_192_4 + var_192_5 and arg_189_1.time_ < var_192_4 + var_192_5 + arg_192_0 then
				local var_192_7 = Color.New(0, 0, 0)

				var_192_7.a = 1
				arg_189_1.mask_.color = var_192_7
			end

			local var_192_8 = 1

			if 1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.mask_.enabled = true
				arg_189_1.mask_.raycastTarget = true

				arg_189_1:SetGaussion(false)
			end

			local var_192_9 = 2

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_9 then
				local var_192_10 = Color.New(0, 0, 0)

				var_192_10.a = Mathf.Lerp(1, 0, (arg_189_1.time_ - var_192_8) / var_192_9)
				arg_189_1.mask_.color = var_192_10
			end

			if arg_189_1.time_ >= var_192_8 + var_192_9 and arg_189_1.time_ < var_192_8 + var_192_9 + arg_192_0 then
				local var_192_11 = Color.New(0, 0, 0)

				arg_189_1.mask_.enabled = false
				var_192_11.a = 0
				arg_189_1.mask_.color = var_192_11
			end

			if 1 < arg_189_1.time_ and arg_189_1.time_ <= 1 + arg_192_0 then
				arg_189_1.cswbg_:SetActive(false)
			end

			if 1 < arg_189_1.time_ and arg_189_1.time_ <= 1 + arg_192_0 then
				arg_189_1.fswbg_:SetActive(false)
				arg_189_1.dialog_:SetActive(false)
				SetActive(arg_189_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_189_1:ShowNextGo(false)
			end

			if 1.01666666666667 < arg_189_1.time_ and arg_189_1.time_ <= 1.01666666666667 + arg_192_0 then
				arg_189_1.fswbg_:SetActive(false)
				arg_189_1.dialog_:SetActive(false)
				SetActive(arg_189_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_189_1:ShowNextGo(false)
			end

			if arg_189_1.frameCnt_ <= 1 then
				arg_189_1.dialog_:SetActive(false)
			end

			local var_192_12 = 1.86666666666667
			local var_192_13 = 1.65

			if 1.86666666666667 < arg_189_1.time_ and arg_189_1.time_ <= var_192_12 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0

				arg_189_1.dialog_:SetActive(true)

				arg_189_1.dialogCg_.alpha = 0

				local var_192_14 = LeanTween.value(arg_189_1.dialog_, 0, 1, 0.3)

				var_192_14:setOnUpdate(LuaHelper.FloatAction(function(arg_193_0)
					arg_189_1.dialogCg_.alpha = arg_193_0
				end))
				var_192_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_189_1.dialog_)
					var_192_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_189_1.duration_ = arg_189_1.duration_ + 0.3

				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[1444].name)

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

				local var_192_15 = arg_189_1:GetWordFromCfg(323011046)
				local var_192_16 = arg_189_1:FormatText(var_192_15.content)

				arg_189_1.text_.text = var_192_16

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_18 = 29 <= 0 and var_192_13 or var_192_13 * (utf8.len(var_192_16) / 29)

				if (29 <= 0 and var_192_13 or var_192_13 * (utf8.len(var_192_16) / 29)) > 0 and var_192_13 < var_192_18 then
					arg_189_1.talkMaxDuration = var_192_18
					var_192_12 = var_192_12 + 0.3

					if var_192_18 + var_192_12 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_18 + var_192_12
					end
				end

				arg_189_1.text_.text = var_192_16
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011046", "story_v_out_323011.awb") ~= 0 then
					local var_192_19 = manager.audio:GetVoiceLength("story_v_out_323011", "323011046", "story_v_out_323011.awb") / 1000

					if var_192_19 + var_192_12 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_19 + var_192_12
					end

					if var_192_15.prefab_name ~= "" and arg_189_1.actors_[var_192_15.prefab_name] ~= nil then
						local var_192_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_15.prefab_name].transform, "story_v_out_323011", "323011046", "story_v_out_323011.awb")

						arg_189_1:RecordAudio("323011046", var_192_20)
						arg_189_1:RecordAudio("323011046", var_192_20)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_323011", "323011046", "story_v_out_323011.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_323011", "323011046", "story_v_out_323011.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_21 = var_192_12 + 0.3
			local var_192_22 = math.max(var_192_13, arg_189_1.talkMaxDuration)

			if var_192_12 + 0.3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_21 + var_192_22 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_21) / var_192_22

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_21 + var_192_22 and arg_189_1.time_ < var_192_21 + var_192_22 + arg_192_0 then
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

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
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

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(323011047).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 66 <= 0 and var_198_1 or var_198_1 * (utf8.len(var_198_3) / 66)

				if (66 <= 0 and var_198_1 or var_198_1 * (utf8.len(var_198_3) / 66)) > 0 and var_198_1 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5
					var_198_0 = var_198_0 + 0.3

					if var_198_5 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = var_198_0 + 0.3
			local var_198_7 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 + 0.3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_7 and arg_195_1.time_ < var_198_6 + var_198_7 + arg_198_0 then
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
			local var_204_0 = 1.35

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(323011048).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 54 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 54)

				if (54 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 54)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
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
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10163ui_story = arg_205_1.actors_["10163ui_story"].transform.localPosition

				local var_208_0 = GameObjectTools.GetOrAddComponent(arg_205_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_208_0 then
					var_208_0:EnableDynamicBone(false)
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["10163ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10163ui_story, Vector3.New(-0.74, -1.08, -5.83), (arg_205_1.time_ - 0) / var_208_1)
				arg_205_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10163ui_story"].transform.position).z)
				arg_205_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["10163ui_story"].transform.localEulerAngles = arg_205_1.actors_["10163ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["10163ui_story"].transform.localPosition = Vector3.New(-0.74, -1.08, -5.83)
				arg_205_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10163ui_story"].transform.position).z)
				arg_205_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["10163ui_story"].transform.localEulerAngles = arg_205_1.actors_["10163ui_story"].transform.localEulerAngles

				local var_208_2 = GameObjectTools.GetOrAddComponent(arg_205_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_208_2 then
					var_208_2:EnableDynamicBone(true)
				end
			end

			local var_208_3 = arg_205_1.actors_["10163ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_3) and arg_205_1.var_.characterEffect10163ui_story == nil then
				arg_205_1.var_.characterEffect10163ui_story = var_208_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_4 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 and not isNil(var_208_3) then
				if arg_205_1.var_.characterEffect10163ui_story and not isNil(var_208_3) then
					arg_205_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 and not isNil(var_208_3) and arg_205_1.var_.characterEffect10163ui_story then
				arg_205_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action1_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_208_6 = 0
			local var_208_7 = 0.375

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_8 = arg_205_1:GetWordFromCfg(323011049)
				local var_208_9 = arg_205_1:FormatText(var_208_8.content)

				arg_205_1.text_.text = var_208_9

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_11 = 15 <= 0 and var_208_7 or var_208_7 * (utf8.len(var_208_9) / 15)

				if (15 <= 0 and var_208_7 or var_208_7 * (utf8.len(var_208_9) / 15)) > 0 and var_208_7 < var_208_11 then
					arg_205_1.talkMaxDuration = var_208_11

					if var_208_11 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_11 + var_208_6
					end
				end

				arg_205_1.text_.text = var_208_9
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011049", "story_v_out_323011.awb") ~= 0 then
					local var_208_12 = manager.audio:GetVoiceLength("story_v_out_323011", "323011049", "story_v_out_323011.awb") / 1000

					if var_208_12 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_12 + var_208_6
					end

					if var_208_8.prefab_name ~= "" and arg_205_1.actors_[var_208_8.prefab_name] ~= nil then
						local var_208_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_8.prefab_name].transform, "story_v_out_323011", "323011049", "story_v_out_323011.awb")

						arg_205_1:RecordAudio("323011049", var_208_13)
						arg_205_1:RecordAudio("323011049", var_208_13)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_323011", "323011049", "story_v_out_323011.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_323011", "323011049", "story_v_out_323011.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_14 = math.max(var_208_7, arg_205_1.talkMaxDuration)

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_14 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_6) / var_208_14

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_6 + var_208_14 and arg_205_1.time_ < var_208_6 + var_208_14 + arg_208_0 then
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
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10165ui_story = arg_209_1.actors_["10165ui_story"].transform.localPosition

				local var_212_0 = GameObjectTools.GetOrAddComponent(arg_209_1.actors_["10165ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_212_0 then
					var_212_0:EnableDynamicBone(false)
				end
			end

			local var_212_1 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 then
				arg_209_1.actors_["10165ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10165ui_story, Vector3.New(0.7, -1.08, -5.83), (arg_209_1.time_ - 0) / var_212_1)
				arg_209_1.actors_["10165ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["10165ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["10165ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["10165ui_story"].transform.position).z)
				arg_209_1.actors_["10165ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["10165ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["10165ui_story"].transform.localEulerAngles = arg_209_1.actors_["10165ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 then
				arg_209_1.actors_["10165ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.83)
				arg_209_1.actors_["10165ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["10165ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["10165ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["10165ui_story"].transform.position).z)
				arg_209_1.actors_["10165ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["10165ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["10165ui_story"].transform.localEulerAngles = arg_209_1.actors_["10165ui_story"].transform.localEulerAngles

				local var_212_2 = GameObjectTools.GetOrAddComponent(arg_209_1.actors_["10165ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_212_2 then
					var_212_2:EnableDynamicBone(true)
				end
			end

			local var_212_3 = arg_209_1.actors_["10165ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_3) and arg_209_1.var_.characterEffect10165ui_story == nil then
				arg_209_1.var_.characterEffect10165ui_story = var_212_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_4 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 and not isNil(var_212_3) then
				if arg_209_1.var_.characterEffect10165ui_story and not isNil(var_212_3) then
					arg_209_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 and not isNil(var_212_3) and arg_209_1.var_.characterEffect10165ui_story then
				arg_209_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_212_6 = arg_209_1.actors_["10163ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_6) and arg_209_1.var_.characterEffect10163ui_story == nil then
				arg_209_1.var_.characterEffect10163ui_story = var_212_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_7 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 and not isNil(var_212_6) then
				if arg_209_1.var_.characterEffect10163ui_story and not isNil(var_212_6) then
					arg_209_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_209_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_7)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 and not isNil(var_212_6) and arg_209_1.var_.characterEffect10163ui_story then
				arg_209_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_209_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action12_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_212_8 = 0
			local var_212_9 = 0.55

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(323011050)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 25 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 25)

				if (25 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 25)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011050", "story_v_out_323011.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_out_323011", "323011050", "story_v_out_323011.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_out_323011", "323011050", "story_v_out_323011.awb")

						arg_209_1:RecordAudio("323011050", var_212_15)
						arg_209_1:RecordAudio("323011050", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_323011", "323011050", "story_v_out_323011.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_323011", "323011050", "story_v_out_323011.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_16 and arg_209_1.time_ < var_212_8 + var_212_16 + arg_212_0 then
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
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10163ui_story = arg_213_1.actors_["10163ui_story"].transform.localPosition

				local var_216_0 = GameObjectTools.GetOrAddComponent(arg_213_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_216_0 then
					var_216_0:EnableDynamicBone(false)
				end
			end

			local var_216_1 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_1 then
				arg_213_1.actors_["10163ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10163ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 0) / var_216_1)
				arg_213_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10163ui_story"].transform.position).z)
				arg_213_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["10163ui_story"].transform.localEulerAngles = arg_213_1.actors_["10163ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_1 and arg_213_1.time_ < 0 + var_216_1 + arg_216_0 then
				arg_213_1.actors_["10163ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["10163ui_story"].transform.position).z)
				arg_213_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["10163ui_story"].transform.localEulerAngles = arg_213_1.actors_["10163ui_story"].transform.localEulerAngles

				local var_216_2 = GameObjectTools.GetOrAddComponent(arg_213_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_216_2 then
					var_216_2:EnableDynamicBone(true)
				end
			end

			local var_216_3 = arg_213_1.actors_["10165ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10165ui_story = var_216_3.localPosition

				local var_216_4 = GameObjectTools.GetOrAddComponent(var_216_3.gameObject, typeof(DynamicBoneHelper))

				if var_216_4 then
					var_216_4:EnableDynamicBone(false)
				end
			end

			local var_216_5 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_5 then
				var_216_3.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10165ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 0) / var_216_5)
				var_216_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_3.position).x, (manager.ui.mainCamera.transform.position - var_216_3.position).y, (manager.ui.mainCamera.transform.position - var_216_3.position).z)
				var_216_3.localEulerAngles.z = 0
				var_216_3.localEulerAngles.x = 0
				var_216_3.localEulerAngles = var_216_3.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_5 and arg_213_1.time_ < 0 + var_216_5 + arg_216_0 then
				var_216_3.localPosition = Vector3.New(0, 100, 0)
				var_216_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_3.position).x, (manager.ui.mainCamera.transform.position - var_216_3.position).y, (manager.ui.mainCamera.transform.position - var_216_3.position).z)
				var_216_3.localEulerAngles.z = 0
				var_216_3.localEulerAngles.x = 0
				var_216_3.localEulerAngles = var_216_3.localEulerAngles

				local var_216_6 = GameObjectTools.GetOrAddComponent(var_216_3.gameObject, typeof(DynamicBoneHelper))

				if var_216_6 then
					var_216_6:EnableDynamicBone(true)
				end
			end

			local var_216_7 = arg_213_1.actors_["10165ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_7) and arg_213_1.var_.characterEffect10165ui_story == nil then
				arg_213_1.var_.characterEffect10165ui_story = var_216_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_8 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_8 and not isNil(var_216_7) then
				if arg_213_1.var_.characterEffect10165ui_story and not isNil(var_216_7) then
					arg_213_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_213_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_8)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_8 and arg_213_1.time_ < 0 + var_216_8 + arg_216_0 and not isNil(var_216_7) and arg_213_1.var_.characterEffect10165ui_story then
				arg_213_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_213_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			if 0.05 < arg_213_1.time_ and arg_213_1.time_ <= 0.05 + arg_216_0 then
				arg_213_1:AudioAction("play", "effect", "se_story_148", "se_story_148_cloth", "")
			end

			local var_216_10 = 0
			local var_216_11 = 1.05

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_12 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(323011051).content)

				arg_213_1.text_.text = var_216_12

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_14 = 42 <= 0 and var_216_11 or var_216_11 * (utf8.len(var_216_12) / 42)

				if (42 <= 0 and var_216_11 or var_216_11 * (utf8.len(var_216_12) / 42)) > 0 and var_216_11 < var_216_14 then
					arg_213_1.talkMaxDuration = var_216_14

					if var_216_14 + var_216_10 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_10
					end
				end

				arg_213_1.text_.text = var_216_12
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_15 = math.max(var_216_11, arg_213_1.talkMaxDuration)

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_15 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_10) / var_216_15

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_10 + var_216_15 and arg_213_1.time_ < var_216_10 + var_216_15 + arg_216_0 then
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
			local var_220_0 = 0.25

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1445].name)

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

				local var_220_1 = arg_217_1:GetWordFromCfg(323011052)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 10 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 10)

				if (10 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 10)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011052", "story_v_out_323011.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_323011", "323011052", "story_v_out_323011.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_323011", "323011052", "story_v_out_323011.awb")

						arg_217_1:RecordAudio("323011052", var_220_6)
						arg_217_1:RecordAudio("323011052", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_323011", "323011052", "story_v_out_323011.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_323011", "323011052", "story_v_out_323011.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
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
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10163ui_story = arg_221_1.actors_["10163ui_story"].transform.localPosition

				local var_224_0 = GameObjectTools.GetOrAddComponent(arg_221_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_224_0 then
					var_224_0:EnableDynamicBone(false)
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["10163ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10163ui_story, Vector3.New(0, -1.08, -5.83), (arg_221_1.time_ - 0) / var_224_1)
				arg_221_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10163ui_story"].transform.position).z)
				arg_221_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["10163ui_story"].transform.localEulerAngles = arg_221_1.actors_["10163ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["10163ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.83)
				arg_221_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10163ui_story"].transform.position).z)
				arg_221_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["10163ui_story"].transform.localEulerAngles = arg_221_1.actors_["10163ui_story"].transform.localEulerAngles

				local var_224_2 = GameObjectTools.GetOrAddComponent(arg_221_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_224_2 then
					var_224_2:EnableDynamicBone(true)
				end
			end

			local var_224_3 = arg_221_1.actors_["10163ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_3) and arg_221_1.var_.characterEffect10163ui_story == nil then
				arg_221_1.var_.characterEffect10163ui_story = var_224_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_4 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 and not isNil(var_224_3) then
				if arg_221_1.var_.characterEffect10163ui_story and not isNil(var_224_3) then
					arg_221_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 and not isNil(var_224_3) and arg_221_1.var_.characterEffect10163ui_story then
				arg_221_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_224_6 = 0
			local var_224_7 = 0.25

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_8 = arg_221_1:GetWordFromCfg(323011053)
				local var_224_9 = arg_221_1:FormatText(var_224_8.content)

				arg_221_1.text_.text = var_224_9

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_11 = 10 <= 0 and var_224_7 or var_224_7 * (utf8.len(var_224_9) / 10)

				if (10 <= 0 and var_224_7 or var_224_7 * (utf8.len(var_224_9) / 10)) > 0 and var_224_7 < var_224_11 then
					arg_221_1.talkMaxDuration = var_224_11

					if var_224_11 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_11 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_9
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011053", "story_v_out_323011.awb") ~= 0 then
					local var_224_12 = manager.audio:GetVoiceLength("story_v_out_323011", "323011053", "story_v_out_323011.awb") / 1000

					if var_224_12 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_12 + var_224_6
					end

					if var_224_8.prefab_name ~= "" and arg_221_1.actors_[var_224_8.prefab_name] ~= nil then
						local var_224_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_8.prefab_name].transform, "story_v_out_323011", "323011053", "story_v_out_323011.awb")

						arg_221_1:RecordAudio("323011053", var_224_13)
						arg_221_1:RecordAudio("323011053", var_224_13)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_323011", "323011053", "story_v_out_323011.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_323011", "323011053", "story_v_out_323011.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_14 = math.max(var_224_7, arg_221_1.talkMaxDuration)

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_14 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_6) / var_224_14

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_6 + var_224_14 and arg_221_1.time_ < var_224_6 + var_224_14 + arg_224_0 then
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
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10163ui_story = arg_225_1.actors_["10163ui_story"].transform.localPosition

				local var_228_0 = GameObjectTools.GetOrAddComponent(arg_225_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_228_0 then
					var_228_0:EnableDynamicBone(false)
				end
			end

			local var_228_1 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_1 then
				arg_225_1.actors_["10163ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10163ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 0) / var_228_1)
				arg_225_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10163ui_story"].transform.position).z)
				arg_225_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["10163ui_story"].transform.localEulerAngles = arg_225_1.actors_["10163ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_1 and arg_225_1.time_ < 0 + var_228_1 + arg_228_0 then
				arg_225_1.actors_["10163ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_225_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10163ui_story"].transform.position).z)
				arg_225_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["10163ui_story"].transform.localEulerAngles = arg_225_1.actors_["10163ui_story"].transform.localEulerAngles

				local var_228_2 = GameObjectTools.GetOrAddComponent(arg_225_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_228_2 then
					var_228_2:EnableDynamicBone(true)
				end
			end

			local var_228_3 = arg_225_1.actors_["10163ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_3) and arg_225_1.var_.characterEffect10163ui_story == nil then
				arg_225_1.var_.characterEffect10163ui_story = var_228_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_4 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 and not isNil(var_228_3) then
				if arg_225_1.var_.characterEffect10163ui_story and not isNil(var_228_3) then
					arg_225_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_4)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 and not isNil(var_228_3) and arg_225_1.var_.characterEffect10163ui_story then
				arg_225_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_225_1.time_ and arg_225_1.time_ <= 0.034000001847744 + arg_228_0 then
				arg_225_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_paperbag01", "")
			end

			local var_228_6 = 0
			local var_228_7 = 1.25

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_8 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(323011054).content)

				arg_225_1.text_.text = var_228_8

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_10 = 50 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_8) / 50)

				if (50 <= 0 and var_228_7 or var_228_7 * (utf8.len(var_228_8) / 50)) > 0 and var_228_7 < var_228_10 then
					arg_225_1.talkMaxDuration = var_228_10

					if var_228_10 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_8
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_11 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_11 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_11

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_11 and arg_225_1.time_ < var_228_6 + var_228_11 + arg_228_0 then
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
			local var_232_0 = 1.125

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(323011055).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 45 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 45)

				if (45 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 45)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
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
			local var_236_9000

			if arg_233_1.bgs_.J21h == nil then
				local var_236_0 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21h")
				var_236_0.name = "J21h"
				var_236_0.transform.parent = arg_233_1.stage_.transform
				var_236_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_.J21h = var_236_0
			end

			if 1.56666666666667 < arg_233_1.time_ and arg_233_1.time_ <= 1.56666666666667 + arg_236_0 then
				local var_236_1 = arg_233_1.bgs_.J21h

				arg_233_1.bgs_.J21h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_236_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_2 = var_236_1:GetComponent("SpriteRenderer")

				if var_236_2 and var_236_2.sprite then
					local var_236_3 = 2 * (var_236_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_236_1.transform.localScale = Vector3.New(var_236_3 / var_236_2.sprite.bounds.size.y < var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x and var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x or var_236_3 / var_236_2.sprite.bounds.size.y, var_236_3 / var_236_2.sprite.bounds.size.y < var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x and var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x or var_236_3 / var_236_2.sprite.bounds.size.y, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "J21h" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_4 = 0

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			if arg_233_1.time_ >= var_236_4 + 0.3 and arg_233_1.time_ < var_236_4 + 0.3 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			local var_236_5 = 0

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_6 = 1.56666666666667

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_6 then
				local var_236_7 = Color.New(0, 0, 0)

				var_236_7.a = Mathf.Lerp(0, 1, (arg_233_1.time_ - var_236_5) / var_236_6)
				arg_233_1.mask_.color = var_236_7
			end

			if arg_233_1.time_ >= var_236_5 + var_236_6 and arg_233_1.time_ < var_236_5 + var_236_6 + arg_236_0 then
				local var_236_8 = Color.New(0, 0, 0)

				var_236_8.a = 1
				arg_233_1.mask_.color = var_236_8
			end

			local var_236_9 = 1.56666666666667

			if 1.56666666666667 < arg_233_1.time_ and arg_233_1.time_ <= var_236_9 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_10 = 2

			if var_236_9 <= arg_233_1.time_ and arg_233_1.time_ < var_236_9 + var_236_10 then
				local var_236_11 = Color.New(0, 0, 0)

				var_236_11.a = Mathf.Lerp(1, 0, (arg_233_1.time_ - var_236_9) / var_236_10)
				arg_233_1.mask_.color = var_236_11
			end

			if arg_233_1.time_ >= var_236_9 + var_236_10 and arg_233_1.time_ < var_236_9 + var_236_10 + arg_236_0 then
				local var_236_12 = Color.New(0, 0, 0)

				arg_233_1.mask_.enabled = false
				var_236_12.a = 0
				arg_233_1.mask_.color = var_236_12
			end

			if 1.56666666666667 < arg_233_1.time_ and arg_233_1.time_ <= 1.56666666666667 + arg_236_0 then
				local var_236_13 = arg_233_1.var_.effect2323

				if not arg_233_1.var_.effect2323 then
					var_236_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_out"), manager.ui.mainCamera.transform)
					var_236_13.name = "2323"
					arg_233_1.var_.effect2323 = var_236_13
				else
					var_236_13.transform:SetParent(var_236_9000)
				end

				var_236_13.transform.localPosition = Vector3.New(0, 0, -1.6)
				var_236_13.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_236_15 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_236_13.transform.localScale = Vector3.New(var_236_13.transform.localScale.x * var_236_15, var_236_13.transform.localScale.y * var_236_15, var_236_13.transform.localScale.z * var_236_15)
			end

			if 0.166666666666667 < arg_233_1.time_ and arg_233_1.time_ <= 0.166666666666667 + arg_236_0 then
				arg_233_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_town", "")
			end

			if 1.16666666666667 < arg_233_1.time_ and arg_233_1.time_ <= 1.16666666666667 + arg_236_0 then
				arg_233_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 3.33333333333333 < arg_233_1.time_ and arg_233_1.time_ <= 3.33333333333333 + arg_236_0 then
				arg_233_1:AudioAction("play", "effect", "se_story_148", "se_story_148_bell_temple_china02", "")
			end

			if 0.166666666666667 < arg_233_1.time_ and arg_233_1.time_ <= 0.166666666666667 + arg_236_0 then
				arg_233_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_236_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_233_1.bgmTxt_.text ~= var_236_21 and arg_233_1.bgmTxt_.text ~= "" then
						if arg_233_1.bgmTxt2_.text ~= "" then
							arg_233_1.bgmTxt_.text = arg_233_1.bgmTxt2_.text
						end

						arg_233_1.bgmTxt2_.text = var_236_21

						arg_233_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_233_1.bgmTxt_.text = var_236_21
						arg_233_1.bgmTxt2_.text = var_236_21
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

			if 1.16666666666667 < arg_233_1.time_ and arg_233_1.time_ <= 1.16666666666667 + arg_236_0 then
				arg_233_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_236_24 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "bgm_activity_4_8_story_dahuang_jianmenguan")

				if "" ~= "" then
					if arg_233_1.bgmTxt_.text ~= var_236_24 and arg_233_1.bgmTxt_.text ~= "" then
						if arg_233_1.bgmTxt2_.text ~= "" then
							arg_233_1.bgmTxt_.text = arg_233_1.bgmTxt2_.text
						end

						arg_233_1.bgmTxt2_.text = var_236_24

						arg_233_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_233_1.bgmTxt_.text = var_236_24
						arg_233_1.bgmTxt2_.text = var_236_24
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

			local var_236_25 = 3.0096003908664
			local var_236_26 = 1.575

			if 3.0096003908664 < arg_233_1.time_ and arg_233_1.time_ <= var_236_25 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_27 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_27:setOnUpdate(LuaHelper.FloatAction(function(arg_239_0)
					arg_233_1.dialogCg_.alpha = arg_239_0
				end))
				var_236_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_28 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(323011056).content)

				arg_233_1.text_.text = var_236_28

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_30 = 63 <= 0 and var_236_26 or var_236_26 * (utf8.len(var_236_28) / 63)

				if (63 <= 0 and var_236_26 or var_236_26 * (utf8.len(var_236_28) / 63)) > 0 and var_236_26 < var_236_30 then
					arg_233_1.talkMaxDuration = var_236_30
					var_236_25 = var_236_25 + 0.3

					if var_236_30 + var_236_25 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_30 + var_236_25
					end
				end

				arg_233_1.text_.text = var_236_28
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_31 = var_236_25 + 0.3
			local var_236_32 = math.max(var_236_26, arg_233_1.talkMaxDuration)

			if var_236_25 + 0.3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_31 + var_236_32 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_31) / var_236_32

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_31 + var_236_32 and arg_233_1.time_ < var_236_31 + var_236_32 + arg_236_0 then
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
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				if arg_241_1.var_.effect2323 then
					Object.Destroy(arg_241_1.var_.effect2323)

					arg_241_1.var_.effect2323 = nil
				end
			end

			local var_244_1 = 0
			local var_244_2 = 0.95

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(323011057).content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 38 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 38)

				if (38 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_3) / 38)) > 0 and var_244_2 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_6 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_6 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_6

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_6 and arg_241_1.time_ < var_244_1 + var_244_6 + arg_244_0 then
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
			if arg_245_1.actors_["10167ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10167ui_story"))) then
				local var_248_0 = Object.Instantiate(Asset.Load("Char/" .. "10167ui_story"), arg_245_1.stage_.transform)

				var_248_0.name = "10167ui_story"
				var_248_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_245_1.actors_["10167ui_story"] = var_248_0

				local var_248_1 = var_248_0:GetComponentInChildren(typeof(CharacterEffect))

				var_248_1.enabled = true

				local var_248_2 = GameObjectTools.GetOrAddComponent(var_248_0, typeof(DynamicBoneHelper))

				if var_248_2 then
					var_248_2:EnableDynamicBone(false)
				end

				arg_245_1:ShowWeapon(var_248_1.transform, false)

				arg_245_1.var_["10167ui_story" .. "Animator"] = var_248_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_245_1.var_["10167ui_story" .. "Animator"].applyRootMotion = true
				arg_245_1.var_["10167ui_story" .. "LipSync"] = var_248_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_248_3 = arg_245_1.actors_["10167ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos10167ui_story = var_248_3.localPosition

				local var_248_4 = GameObjectTools.GetOrAddComponent(var_248_3.gameObject, typeof(DynamicBoneHelper))

				if var_248_4 then
					var_248_4:EnableDynamicBone(false)
				end
			end

			local var_248_5 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_5 then
				var_248_3.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10167ui_story, Vector3.New(0, -1.28, -5.73), (arg_245_1.time_ - 0) / var_248_5)
				var_248_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_3.position).x, (manager.ui.mainCamera.transform.position - var_248_3.position).y, (manager.ui.mainCamera.transform.position - var_248_3.position).z)
				var_248_3.localEulerAngles.z = 0
				var_248_3.localEulerAngles.x = 0
				var_248_3.localEulerAngles = var_248_3.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_5 and arg_245_1.time_ < 0 + var_248_5 + arg_248_0 then
				var_248_3.localPosition = Vector3.New(0, -1.28, -5.73)
				var_248_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_3.position).x, (manager.ui.mainCamera.transform.position - var_248_3.position).y, (manager.ui.mainCamera.transform.position - var_248_3.position).z)
				var_248_3.localEulerAngles.z = 0
				var_248_3.localEulerAngles.x = 0
				var_248_3.localEulerAngles = var_248_3.localEulerAngles

				local var_248_6 = GameObjectTools.GetOrAddComponent(var_248_3.gameObject, typeof(DynamicBoneHelper))

				if var_248_6 then
					var_248_6:EnableDynamicBone(true)
				end
			end

			local var_248_7 = arg_245_1.actors_["10167ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_7) and arg_245_1.var_.characterEffect10167ui_story == nil then
				arg_245_1.var_.characterEffect10167ui_story = var_248_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_8 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_8 and not isNil(var_248_7) then
				if arg_245_1.var_.characterEffect10167ui_story and not isNil(var_248_7) then
					arg_245_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_8 and arg_245_1.time_ < 0 + var_248_8 + arg_248_0 and not isNil(var_248_7) and arg_245_1.var_.characterEffect10167ui_story then
				arg_245_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_248_10 = 0
			local var_248_11 = 0.1

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_12 = arg_245_1:GetWordFromCfg(323011058)
				local var_248_13 = arg_245_1:FormatText(var_248_12.content)

				arg_245_1.text_.text = var_248_13

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_15 = 4 <= 0 and var_248_11 or var_248_11 * (utf8.len(var_248_13) / 4)

				if (4 <= 0 and var_248_11 or var_248_11 * (utf8.len(var_248_13) / 4)) > 0 and var_248_11 < var_248_15 then
					arg_245_1.talkMaxDuration = var_248_15

					if var_248_15 + var_248_10 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_15 + var_248_10
					end
				end

				arg_245_1.text_.text = var_248_13
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011058", "story_v_out_323011.awb") ~= 0 then
					local var_248_16 = manager.audio:GetVoiceLength("story_v_out_323011", "323011058", "story_v_out_323011.awb") / 1000

					if var_248_16 + var_248_10 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_16 + var_248_10
					end

					if var_248_12.prefab_name ~= "" and arg_245_1.actors_[var_248_12.prefab_name] ~= nil then
						local var_248_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_12.prefab_name].transform, "story_v_out_323011", "323011058", "story_v_out_323011.awb")

						arg_245_1:RecordAudio("323011058", var_248_17)
						arg_245_1:RecordAudio("323011058", var_248_17)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_323011", "323011058", "story_v_out_323011.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_323011", "323011058", "story_v_out_323011.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_18 = math.max(var_248_11, arg_245_1.talkMaxDuration)

			if var_248_10 <= arg_245_1.time_ and arg_245_1.time_ < var_248_10 + var_248_18 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_10) / var_248_18

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_10 + var_248_18 and arg_245_1.time_ < var_248_10 + var_248_18 + arg_248_0 then
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
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10167ui_story = arg_249_1.actors_["10167ui_story"].transform.localPosition

				local var_252_0 = GameObjectTools.GetOrAddComponent(arg_249_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_252_0 then
					var_252_0:EnableDynamicBone(false)
				end
			end

			local var_252_1 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 then
				arg_249_1.actors_["10167ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10167ui_story, Vector3.New(0, 100, 0), (arg_249_1.time_ - 0) / var_252_1)
				arg_249_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10167ui_story"].transform.position).z)
				arg_249_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10167ui_story"].transform.localEulerAngles = arg_249_1.actors_["10167ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 then
				arg_249_1.actors_["10167ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_249_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10167ui_story"].transform.position).z)
				arg_249_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10167ui_story"].transform.localEulerAngles = arg_249_1.actors_["10167ui_story"].transform.localEulerAngles

				local var_252_2 = GameObjectTools.GetOrAddComponent(arg_249_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_252_2 then
					var_252_2:EnableDynamicBone(true)
				end
			end

			local var_252_3 = arg_249_1.actors_["10167ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_3) and arg_249_1.var_.characterEffect10167ui_story == nil then
				arg_249_1.var_.characterEffect10167ui_story = var_252_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_4 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 and not isNil(var_252_3) then
				if arg_249_1.var_.characterEffect10167ui_story and not isNil(var_252_3) then
					arg_249_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_4)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 and not isNil(var_252_3) and arg_249_1.var_.characterEffect10167ui_story then
				arg_249_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			local var_252_5 = 0
			local var_252_6 = 1.45

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_7 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(323011059).content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 58 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_7) / 58)

				if (58 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_7) / 58)) > 0 and var_252_6 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_5
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_10 = math.max(var_252_6, arg_249_1.talkMaxDuration)

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_10 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_5) / var_252_10

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_5 + var_252_10 and arg_249_1.time_ < var_252_5 + var_252_10 + arg_252_0 then
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
			local var_256_0 = 1.425

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, false)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(323011060).content)

				arg_253_1.text_.text = var_256_1

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_3 = 57 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 57)

				if (57 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_1) / 57)) > 0 and var_256_0 < var_256_3 then
					arg_253_1.talkMaxDuration = var_256_3

					if var_256_3 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_3 + 0
					end
				end

				arg_253_1.text_.text = var_256_1
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_4 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_4 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_4

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_4 and arg_253_1.time_ < 0 + var_256_4 + arg_256_0 then
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
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos10165ui_story = arg_257_1.actors_["10165ui_story"].transform.localPosition

				local var_260_0 = GameObjectTools.GetOrAddComponent(arg_257_1.actors_["10165ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_260_0 then
					var_260_0:EnableDynamicBone(false)
				end
			end

			local var_260_1 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_1 then
				arg_257_1.actors_["10165ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10165ui_story, Vector3.New(0, -1.08, -5.83), (arg_257_1.time_ - 0) / var_260_1)
				arg_257_1.actors_["10165ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["10165ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10165ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10165ui_story"].transform.position).z)
				arg_257_1.actors_["10165ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["10165ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["10165ui_story"].transform.localEulerAngles = arg_257_1.actors_["10165ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_1 and arg_257_1.time_ < 0 + var_260_1 + arg_260_0 then
				arg_257_1.actors_["10165ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.83)
				arg_257_1.actors_["10165ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["10165ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10165ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10165ui_story"].transform.position).z)
				arg_257_1.actors_["10165ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["10165ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["10165ui_story"].transform.localEulerAngles = arg_257_1.actors_["10165ui_story"].transform.localEulerAngles

				local var_260_2 = GameObjectTools.GetOrAddComponent(arg_257_1.actors_["10165ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_260_2 then
					var_260_2:EnableDynamicBone(true)
				end
			end

			local var_260_3 = arg_257_1.actors_["10165ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_3) and arg_257_1.var_.characterEffect10165ui_story == nil then
				arg_257_1.var_.characterEffect10165ui_story = var_260_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_4 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 and not isNil(var_260_3) then
				if arg_257_1.var_.characterEffect10165ui_story and not isNil(var_260_3) then
					arg_257_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 and not isNil(var_260_3) and arg_257_1.var_.characterEffect10165ui_story then
				arg_257_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_260_6 = 0
			local var_260_7 = 0.125

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_6 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_8 = arg_257_1:GetWordFromCfg(323011061)
				local var_260_9 = arg_257_1:FormatText(var_260_8.content)

				arg_257_1.text_.text = var_260_9

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_11 = 5 <= 0 and var_260_7 or var_260_7 * (utf8.len(var_260_9) / 5)

				if (5 <= 0 and var_260_7 or var_260_7 * (utf8.len(var_260_9) / 5)) > 0 and var_260_7 < var_260_11 then
					arg_257_1.talkMaxDuration = var_260_11

					if var_260_11 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_11 + var_260_6
					end
				end

				arg_257_1.text_.text = var_260_9
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011061", "story_v_out_323011.awb") ~= 0 then
					local var_260_12 = manager.audio:GetVoiceLength("story_v_out_323011", "323011061", "story_v_out_323011.awb") / 1000

					if var_260_12 + var_260_6 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_12 + var_260_6
					end

					if var_260_8.prefab_name ~= "" and arg_257_1.actors_[var_260_8.prefab_name] ~= nil then
						local var_260_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_8.prefab_name].transform, "story_v_out_323011", "323011061", "story_v_out_323011.awb")

						arg_257_1:RecordAudio("323011061", var_260_13)
						arg_257_1:RecordAudio("323011061", var_260_13)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_323011", "323011061", "story_v_out_323011.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_323011", "323011061", "story_v_out_323011.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_14 = math.max(var_260_7, arg_257_1.talkMaxDuration)

			if var_260_6 <= arg_257_1.time_ and arg_257_1.time_ < var_260_6 + var_260_14 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_6) / var_260_14

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_6 + var_260_14 and arg_257_1.time_ < var_260_6 + var_260_14 + arg_260_0 then
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
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10165ui_story = arg_261_1.actors_["10165ui_story"].transform.localPosition

				local var_264_0 = GameObjectTools.GetOrAddComponent(arg_261_1.actors_["10165ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_264_0 then
					var_264_0:EnableDynamicBone(false)
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["10165ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10165ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 0) / var_264_1)
				arg_261_1.actors_["10165ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["10165ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10165ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10165ui_story"].transform.position).z)
				arg_261_1.actors_["10165ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["10165ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["10165ui_story"].transform.localEulerAngles = arg_261_1.actors_["10165ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["10165ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.actors_["10165ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["10165ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10165ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10165ui_story"].transform.position).z)
				arg_261_1.actors_["10165ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["10165ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["10165ui_story"].transform.localEulerAngles = arg_261_1.actors_["10165ui_story"].transform.localEulerAngles

				local var_264_2 = GameObjectTools.GetOrAddComponent(arg_261_1.actors_["10165ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_264_2 then
					var_264_2:EnableDynamicBone(true)
				end
			end

			local var_264_3 = arg_261_1.actors_["10167ui_story"].transform

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10167ui_story = var_264_3.localPosition

				local var_264_4 = GameObjectTools.GetOrAddComponent(var_264_3.gameObject, typeof(DynamicBoneHelper))

				if var_264_4 then
					var_264_4:EnableDynamicBone(false)
				end
			end

			local var_264_5 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_5 then
				var_264_3.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10167ui_story, Vector3.New(-0.96, -1.28, -5.73), (arg_261_1.time_ - 0) / var_264_5)
				var_264_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_3.position).x, (manager.ui.mainCamera.transform.position - var_264_3.position).y, (manager.ui.mainCamera.transform.position - var_264_3.position).z)
				var_264_3.localEulerAngles.z = 0
				var_264_3.localEulerAngles.x = 0
				var_264_3.localEulerAngles = var_264_3.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_5 and arg_261_1.time_ < 0 + var_264_5 + arg_264_0 then
				var_264_3.localPosition = Vector3.New(-0.96, -1.28, -5.73)
				var_264_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_264_3.position).x, (manager.ui.mainCamera.transform.position - var_264_3.position).y, (manager.ui.mainCamera.transform.position - var_264_3.position).z)
				var_264_3.localEulerAngles.z = 0
				var_264_3.localEulerAngles.x = 0
				var_264_3.localEulerAngles = var_264_3.localEulerAngles

				local var_264_6 = GameObjectTools.GetOrAddComponent(var_264_3.gameObject, typeof(DynamicBoneHelper))

				if var_264_6 then
					var_264_6:EnableDynamicBone(true)
				end
			end

			local var_264_7 = arg_261_1.actors_["10167ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.characterEffect10167ui_story == nil then
				arg_261_1.var_.characterEffect10167ui_story = var_264_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_8 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_8 and not isNil(var_264_7) then
				if arg_261_1.var_.characterEffect10167ui_story and not isNil(var_264_7) then
					arg_261_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= 0 + var_264_8 and arg_261_1.time_ < 0 + var_264_8 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.characterEffect10167ui_story then
				arg_261_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_264_10 = arg_261_1.actors_["10165ui_story"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_10) and arg_261_1.var_.characterEffect10165ui_story == nil then
				arg_261_1.var_.characterEffect10165ui_story = var_264_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_11 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_11 and not isNil(var_264_10) then
				if arg_261_1.var_.characterEffect10165ui_story and not isNil(var_264_10) then
					arg_261_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_261_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_11)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_11 and arg_261_1.time_ < 0 + var_264_11 + arg_264_0 and not isNil(var_264_10) and arg_261_1.var_.characterEffect10165ui_story then
				arg_261_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_261_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_1")
			end

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_264_12 = 0
			local var_264_13 = 0.325

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_12 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_14 = arg_261_1:GetWordFromCfg(323011062)
				local var_264_15 = arg_261_1:FormatText(var_264_14.content)

				arg_261_1.text_.text = var_264_15

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_17 = 13 <= 0 and var_264_13 or var_264_13 * (utf8.len(var_264_15) / 13)

				if (13 <= 0 and var_264_13 or var_264_13 * (utf8.len(var_264_15) / 13)) > 0 and var_264_13 < var_264_17 then
					arg_261_1.talkMaxDuration = var_264_17

					if var_264_17 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_17 + var_264_12
					end
				end

				arg_261_1.text_.text = var_264_15
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011062", "story_v_out_323011.awb") ~= 0 then
					local var_264_18 = manager.audio:GetVoiceLength("story_v_out_323011", "323011062", "story_v_out_323011.awb") / 1000

					if var_264_18 + var_264_12 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_18 + var_264_12
					end

					if var_264_14.prefab_name ~= "" and arg_261_1.actors_[var_264_14.prefab_name] ~= nil then
						local var_264_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_14.prefab_name].transform, "story_v_out_323011", "323011062", "story_v_out_323011.awb")

						arg_261_1:RecordAudio("323011062", var_264_19)
						arg_261_1:RecordAudio("323011062", var_264_19)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_323011", "323011062", "story_v_out_323011.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_323011", "323011062", "story_v_out_323011.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_20 = math.max(var_264_13, arg_261_1.talkMaxDuration)

			if var_264_12 <= arg_261_1.time_ and arg_261_1.time_ < var_264_12 + var_264_20 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_12) / var_264_20

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_12 + var_264_20 and arg_261_1.time_ < var_264_12 + var_264_20 + arg_264_0 then
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
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10163ui_story = arg_265_1.actors_["10163ui_story"].transform.localPosition

				local var_268_0 = GameObjectTools.GetOrAddComponent(arg_265_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_268_0 then
					var_268_0:EnableDynamicBone(false)
				end
			end

			local var_268_1 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_1 then
				arg_265_1.actors_["10163ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10163ui_story, Vector3.New(0.7, -1.08, -5.83), (arg_265_1.time_ - 0) / var_268_1)
				arg_265_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10163ui_story"].transform.position).z)
				arg_265_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["10163ui_story"].transform.localEulerAngles = arg_265_1.actors_["10163ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_1 and arg_265_1.time_ < 0 + var_268_1 + arg_268_0 then
				arg_265_1.actors_["10163ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.83)
				arg_265_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10163ui_story"].transform.position).z)
				arg_265_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["10163ui_story"].transform.localEulerAngles = arg_265_1.actors_["10163ui_story"].transform.localEulerAngles

				local var_268_2 = GameObjectTools.GetOrAddComponent(arg_265_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_268_2 then
					var_268_2:EnableDynamicBone(true)
				end
			end

			local var_268_3 = arg_265_1.actors_["10163ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_3) and arg_265_1.var_.characterEffect10163ui_story == nil then
				arg_265_1.var_.characterEffect10163ui_story = var_268_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_4 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 and not isNil(var_268_3) then
				if arg_265_1.var_.characterEffect10163ui_story and not isNil(var_268_3) then
					arg_265_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 and not isNil(var_268_3) and arg_265_1.var_.characterEffect10163ui_story then
				arg_265_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_268_6 = arg_265_1.actors_["10167ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_6) and arg_265_1.var_.characterEffect10167ui_story == nil then
				arg_265_1.var_.characterEffect10167ui_story = var_268_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_7 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 and not isNil(var_268_6) then
				if arg_265_1.var_.characterEffect10167ui_story and not isNil(var_268_6) then
					arg_265_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_265_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_7)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 and not isNil(var_268_6) and arg_265_1.var_.characterEffect10167ui_story then
				arg_265_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_265_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_1")
			end

			if 0.034000001847744 < arg_265_1.time_ and arg_265_1.time_ <= 0.034000001847744 + arg_268_0 then
				arg_265_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_268_8 = 0
			local var_268_9 = 0.275

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_10 = arg_265_1:GetWordFromCfg(323011063)
				local var_268_11 = arg_265_1:FormatText(var_268_10.content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_13 = 11 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 11)

				if (11 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 11)) > 0 and var_268_9 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011063", "story_v_out_323011.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_out_323011", "323011063", "story_v_out_323011.awb") / 1000

					if var_268_14 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_8
					end

					if var_268_10.prefab_name ~= "" and arg_265_1.actors_[var_268_10.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_10.prefab_name].transform, "story_v_out_323011", "323011063", "story_v_out_323011.awb")

						arg_265_1:RecordAudio("323011063", var_268_15)
						arg_265_1:RecordAudio("323011063", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_323011", "323011063", "story_v_out_323011.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_323011", "323011063", "story_v_out_323011.awb")
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
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["10167ui_story"]) and arg_269_1.var_.characterEffect10167ui_story == nil then
				arg_269_1.var_.characterEffect10167ui_story = arg_269_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["10167ui_story"]) then
				if arg_269_1.var_.characterEffect10167ui_story and not isNil(arg_269_1.actors_["10167ui_story"]) then
					arg_269_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["10167ui_story"]) and arg_269_1.var_.characterEffect10167ui_story then
				arg_269_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_272_2 = arg_269_1.actors_["10163ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect10163ui_story == nil then
				arg_269_1.var_.characterEffect10163ui_story = var_272_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_3 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.characterEffect10163ui_story and not isNil(var_272_2) then
					arg_269_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_269_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_3)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.characterEffect10163ui_story then
				arg_269_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_269_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			local var_272_4 = 0
			local var_272_5 = 0.15

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(323011064)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 6 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 6)

				if (6 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 6)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011064", "story_v_out_323011.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011064", "story_v_out_323011.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_out_323011", "323011064", "story_v_out_323011.awb")

						arg_269_1:RecordAudio("323011064", var_272_11)
						arg_269_1:RecordAudio("323011064", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_323011", "323011064", "story_v_out_323011.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_323011", "323011064", "story_v_out_323011.awb")
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
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10167ui_story = arg_273_1.actors_["10167ui_story"].transform.localPosition

				local var_276_0 = GameObjectTools.GetOrAddComponent(arg_273_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_276_0 then
					var_276_0:EnableDynamicBone(false)
				end
			end

			local var_276_1 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_1 then
				arg_273_1.actors_["10167ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10167ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_1)
				arg_273_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10167ui_story"].transform.position).z)
				arg_273_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10167ui_story"].transform.localEulerAngles = arg_273_1.actors_["10167ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_1 and arg_273_1.time_ < 0 + var_276_1 + arg_276_0 then
				arg_273_1.actors_["10167ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10167ui_story"].transform.position).z)
				arg_273_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10167ui_story"].transform.localEulerAngles = arg_273_1.actors_["10167ui_story"].transform.localEulerAngles

				local var_276_2 = GameObjectTools.GetOrAddComponent(arg_273_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_276_2 then
					var_276_2:EnableDynamicBone(true)
				end
			end

			local var_276_3 = arg_273_1.actors_["10163ui_story"].transform

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10163ui_story = var_276_3.localPosition

				local var_276_4 = GameObjectTools.GetOrAddComponent(var_276_3.gameObject, typeof(DynamicBoneHelper))

				if var_276_4 then
					var_276_4:EnableDynamicBone(false)
				end
			end

			local var_276_5 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_5 then
				var_276_3.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10163ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_5)
				var_276_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_3.position).x, (manager.ui.mainCamera.transform.position - var_276_3.position).y, (manager.ui.mainCamera.transform.position - var_276_3.position).z)
				var_276_3.localEulerAngles.z = 0
				var_276_3.localEulerAngles.x = 0
				var_276_3.localEulerAngles = var_276_3.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_5 and arg_273_1.time_ < 0 + var_276_5 + arg_276_0 then
				var_276_3.localPosition = Vector3.New(0, 100, 0)
				var_276_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_276_3.position).x, (manager.ui.mainCamera.transform.position - var_276_3.position).y, (manager.ui.mainCamera.transform.position - var_276_3.position).z)
				var_276_3.localEulerAngles.z = 0
				var_276_3.localEulerAngles.x = 0
				var_276_3.localEulerAngles = var_276_3.localEulerAngles

				local var_276_6 = GameObjectTools.GetOrAddComponent(var_276_3.gameObject, typeof(DynamicBoneHelper))

				if var_276_6 then
					var_276_6:EnableDynamicBone(true)
				end
			end

			local var_276_7 = arg_273_1.actors_["10167ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.characterEffect10167ui_story == nil then
				arg_273_1.var_.characterEffect10167ui_story = var_276_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_8 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_8 and not isNil(var_276_7) then
				if arg_273_1.var_.characterEffect10167ui_story and not isNil(var_276_7) then
					arg_273_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_273_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_8)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_8 and arg_273_1.time_ < 0 + var_276_8 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.characterEffect10167ui_story then
				arg_273_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_273_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			local var_276_9 = 0
			local var_276_10 = 1.025

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_9 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_11 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(323011065).content)

				arg_273_1.text_.text = var_276_11

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_13 = 41 <= 0 and var_276_10 or var_276_10 * (utf8.len(var_276_11) / 41)

				if (41 <= 0 and var_276_10 or var_276_10 * (utf8.len(var_276_11) / 41)) > 0 and var_276_10 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_9 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_9
					end
				end

				arg_273_1.text_.text = var_276_11
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_10, arg_273_1.talkMaxDuration)

			if var_276_9 <= arg_273_1.time_ and arg_273_1.time_ < var_276_9 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_9) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_9 + var_276_14 and arg_273_1.time_ < var_276_9 + var_276_14 + arg_276_0 then
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
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10163ui_story = arg_277_1.actors_["10163ui_story"].transform.localPosition

				local var_280_0 = GameObjectTools.GetOrAddComponent(arg_277_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_280_0 then
					var_280_0:EnableDynamicBone(false)
				end
			end

			local var_280_1 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_1 then
				arg_277_1.actors_["10163ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10163ui_story, Vector3.New(0.7, -1.08, -5.83), (arg_277_1.time_ - 0) / var_280_1)
				arg_277_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10163ui_story"].transform.position).z)
				arg_277_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10163ui_story"].transform.localEulerAngles = arg_277_1.actors_["10163ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_1 and arg_277_1.time_ < 0 + var_280_1 + arg_280_0 then
				arg_277_1.actors_["10163ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.83)
				arg_277_1.actors_["10163ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10163ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10163ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10163ui_story"].transform.position).z)
				arg_277_1.actors_["10163ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10163ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10163ui_story"].transform.localEulerAngles = arg_277_1.actors_["10163ui_story"].transform.localEulerAngles

				local var_280_2 = GameObjectTools.GetOrAddComponent(arg_277_1.actors_["10163ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_280_2 then
					var_280_2:EnableDynamicBone(true)
				end
			end

			local var_280_3 = arg_277_1.actors_["10163ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_3) and arg_277_1.var_.characterEffect10163ui_story == nil then
				arg_277_1.var_.characterEffect10163ui_story = var_280_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_4 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 and not isNil(var_280_3) then
				if arg_277_1.var_.characterEffect10163ui_story and not isNil(var_280_3) then
					arg_277_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 and not isNil(var_280_3) and arg_277_1.var_.characterEffect10163ui_story then
				arg_277_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action16_2")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_280_6 = 0
			local var_280_7 = 0.225

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_8 = arg_277_1:GetWordFromCfg(323011066)
				local var_280_9 = arg_277_1:FormatText(var_280_8.content)

				arg_277_1.text_.text = var_280_9

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 9 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 9)

				if (9 <= 0 and var_280_7 or var_280_7 * (utf8.len(var_280_9) / 9)) > 0 and var_280_7 < var_280_11 then
					arg_277_1.talkMaxDuration = var_280_11

					if var_280_11 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_9
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011066", "story_v_out_323011.awb") ~= 0 then
					local var_280_12 = manager.audio:GetVoiceLength("story_v_out_323011", "323011066", "story_v_out_323011.awb") / 1000

					if var_280_12 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_12 + var_280_6
					end

					if var_280_8.prefab_name ~= "" and arg_277_1.actors_[var_280_8.prefab_name] ~= nil then
						local var_280_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_8.prefab_name].transform, "story_v_out_323011", "323011066", "story_v_out_323011.awb")

						arg_277_1:RecordAudio("323011066", var_280_13)
						arg_277_1:RecordAudio("323011066", var_280_13)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_323011", "323011066", "story_v_out_323011.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_323011", "323011066", "story_v_out_323011.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_14 = math.max(var_280_7, arg_277_1.talkMaxDuration)

			if var_280_6 <= arg_277_1.time_ and arg_277_1.time_ < var_280_6 + var_280_14 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_6) / var_280_14

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_6 + var_280_14 and arg_277_1.time_ < var_280_6 + var_280_14 + arg_280_0 then
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
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10167ui_story = arg_281_1.actors_["10167ui_story"].transform.localPosition

				local var_284_0 = GameObjectTools.GetOrAddComponent(arg_281_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_284_0 then
					var_284_0:EnableDynamicBone(false)
				end
			end

			local var_284_1 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 then
				arg_281_1.actors_["10167ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10167ui_story, Vector3.New(-0.96, -1.28, -5.73), (arg_281_1.time_ - 0) / var_284_1)
				arg_281_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10167ui_story"].transform.position).z)
				arg_281_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10167ui_story"].transform.localEulerAngles = arg_281_1.actors_["10167ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 then
				arg_281_1.actors_["10167ui_story"].transform.localPosition = Vector3.New(-0.96, -1.28, -5.73)
				arg_281_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10167ui_story"].transform.position).z)
				arg_281_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10167ui_story"].transform.localEulerAngles = arg_281_1.actors_["10167ui_story"].transform.localEulerAngles

				local var_284_2 = GameObjectTools.GetOrAddComponent(arg_281_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_284_2 then
					var_284_2:EnableDynamicBone(true)
				end
			end

			local var_284_3 = arg_281_1.actors_["10167ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_3) and arg_281_1.var_.characterEffect10167ui_story == nil then
				arg_281_1.var_.characterEffect10167ui_story = var_284_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_4 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 and not isNil(var_284_3) then
				if arg_281_1.var_.characterEffect10167ui_story and not isNil(var_284_3) then
					arg_281_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 and not isNil(var_284_3) and arg_281_1.var_.characterEffect10167ui_story then
				arg_281_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_284_6 = arg_281_1.actors_["10163ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_6) and arg_281_1.var_.characterEffect10163ui_story == nil then
				arg_281_1.var_.characterEffect10163ui_story = var_284_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_7 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 and not isNil(var_284_6) then
				if arg_281_1.var_.characterEffect10163ui_story and not isNil(var_284_6) then
					arg_281_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_281_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_7)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 and not isNil(var_284_6) and arg_281_1.var_.characterEffect10163ui_story then
				arg_281_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_281_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_2")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_284_8 = 0
			local var_284_9 = 0.5

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_10 = arg_281_1:GetWordFromCfg(323011067)
				local var_284_11 = arg_281_1:FormatText(var_284_10.content)

				arg_281_1.text_.text = var_284_11

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_13 = 20 <= 0 and var_284_9 or var_284_9 * (utf8.len(var_284_11) / 20)

				if (20 <= 0 and var_284_9 or var_284_9 * (utf8.len(var_284_11) / 20)) > 0 and var_284_9 < var_284_13 then
					arg_281_1.talkMaxDuration = var_284_13

					if var_284_13 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_13 + var_284_8
					end
				end

				arg_281_1.text_.text = var_284_11
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011067", "story_v_out_323011.awb") ~= 0 then
					local var_284_14 = manager.audio:GetVoiceLength("story_v_out_323011", "323011067", "story_v_out_323011.awb") / 1000

					if var_284_14 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_14 + var_284_8
					end

					if var_284_10.prefab_name ~= "" and arg_281_1.actors_[var_284_10.prefab_name] ~= nil then
						local var_284_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_10.prefab_name].transform, "story_v_out_323011", "323011067", "story_v_out_323011.awb")

						arg_281_1:RecordAudio("323011067", var_284_15)
						arg_281_1:RecordAudio("323011067", var_284_15)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_323011", "323011067", "story_v_out_323011.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_323011", "323011067", "story_v_out_323011.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_16 = math.max(var_284_9, arg_281_1.talkMaxDuration)

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_16 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_8) / var_284_16

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_8 + var_284_16 and arg_281_1.time_ < var_284_8 + var_284_16 + arg_284_0 then
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
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["10163ui_story"]) and arg_285_1.var_.characterEffect10163ui_story == nil then
				arg_285_1.var_.characterEffect10163ui_story = arg_285_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["10163ui_story"]) then
				if arg_285_1.var_.characterEffect10163ui_story and not isNil(arg_285_1.actors_["10163ui_story"]) then
					arg_285_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["10163ui_story"]) and arg_285_1.var_.characterEffect10163ui_story then
				arg_285_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_288_2 = arg_285_1.actors_["10167ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect10167ui_story == nil then
				arg_285_1.var_.characterEffect10167ui_story = var_288_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_3 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.characterEffect10167ui_story and not isNil(var_288_2) then
					arg_285_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_285_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_3)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect10167ui_story then
				arg_285_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_285_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_288_4 = 0
			local var_288_5 = 0.575

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(323011068)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 23 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 23)

				if (23 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 23)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011068", "story_v_out_323011.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011068", "story_v_out_323011.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_323011", "323011068", "story_v_out_323011.awb")

						arg_285_1:RecordAudio("323011068", var_288_11)
						arg_285_1:RecordAudio("323011068", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_323011", "323011068", "story_v_out_323011.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_323011", "323011068", "story_v_out_323011.awb")
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
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["10167ui_story"]) and arg_289_1.var_.characterEffect10167ui_story == nil then
				arg_289_1.var_.characterEffect10167ui_story = arg_289_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["10167ui_story"]) then
				if arg_289_1.var_.characterEffect10167ui_story and not isNil(arg_289_1.actors_["10167ui_story"]) then
					arg_289_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["10167ui_story"]) and arg_289_1.var_.characterEffect10167ui_story then
				arg_289_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_292_2 = arg_289_1.actors_["10163ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect10163ui_story == nil then
				arg_289_1.var_.characterEffect10163ui_story = var_292_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_3 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.characterEffect10163ui_story and not isNil(var_292_2) then
					arg_289_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_289_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_3)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect10163ui_story then
				arg_289_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_289_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			local var_292_4 = 0
			local var_292_5 = 0.375

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(323011069)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 15 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 15)

				if (15 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 15)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011069", "story_v_out_323011.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011069", "story_v_out_323011.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_323011", "323011069", "story_v_out_323011.awb")

						arg_289_1:RecordAudio("323011069", var_292_11)
						arg_289_1:RecordAudio("323011069", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_323011", "323011069", "story_v_out_323011.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_323011", "323011069", "story_v_out_323011.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_12 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_12 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_12

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_12 and arg_289_1.time_ < var_292_4 + var_292_12 + arg_292_0 then
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
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action29_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_296_0 = 0
			local var_296_1 = 0.975

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_2 = arg_293_1:GetWordFromCfg(323011070)
				local var_296_3 = arg_293_1:FormatText(var_296_2.content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 39 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_3) / 39)

				if (39 <= 0 and var_296_1 or var_296_1 * (utf8.len(var_296_3) / 39)) > 0 and var_296_1 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011070", "story_v_out_323011.awb") ~= 0 then
					local var_296_6 = manager.audio:GetVoiceLength("story_v_out_323011", "323011070", "story_v_out_323011.awb") / 1000

					if var_296_6 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_0
					end

					if var_296_2.prefab_name ~= "" and arg_293_1.actors_[var_296_2.prefab_name] ~= nil then
						local var_296_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_2.prefab_name].transform, "story_v_out_323011", "323011070", "story_v_out_323011.awb")

						arg_293_1:RecordAudio("323011070", var_296_7)
						arg_293_1:RecordAudio("323011070", var_296_7)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_323011", "323011070", "story_v_out_323011.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_323011", "323011070", "story_v_out_323011.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_8 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_8 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_8

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_8 and arg_293_1.time_ < var_296_0 + var_296_8 + arg_296_0 then
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
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["10163ui_story"]) and arg_297_1.var_.characterEffect10163ui_story == nil then
				arg_297_1.var_.characterEffect10163ui_story = arg_297_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["10163ui_story"]) then
				if arg_297_1.var_.characterEffect10163ui_story and not isNil(arg_297_1.actors_["10163ui_story"]) then
					arg_297_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["10163ui_story"]) and arg_297_1.var_.characterEffect10163ui_story then
				arg_297_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_300_2 = arg_297_1.actors_["10167ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.characterEffect10167ui_story == nil then
				arg_297_1.var_.characterEffect10167ui_story = var_300_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_3 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 and not isNil(var_300_2) then
				if arg_297_1.var_.characterEffect10167ui_story and not isNil(var_300_2) then
					arg_297_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_297_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_3)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.characterEffect10167ui_story then
				arg_297_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_297_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_300_4 = 0
			local var_300_5 = 0.3

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_6 = arg_297_1:GetWordFromCfg(323011071)
				local var_300_7 = arg_297_1:FormatText(var_300_6.content)

				arg_297_1.text_.text = var_300_7

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_9 = 12 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 12)

				if (12 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_7) / 12)) > 0 and var_300_5 < var_300_9 then
					arg_297_1.talkMaxDuration = var_300_9

					if var_300_9 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_7
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011071", "story_v_out_323011.awb") ~= 0 then
					local var_300_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011071", "story_v_out_323011.awb") / 1000

					if var_300_10 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_10 + var_300_4
					end

					if var_300_6.prefab_name ~= "" and arg_297_1.actors_[var_300_6.prefab_name] ~= nil then
						local var_300_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_6.prefab_name].transform, "story_v_out_323011", "323011071", "story_v_out_323011.awb")

						arg_297_1:RecordAudio("323011071", var_300_11)
						arg_297_1:RecordAudio("323011071", var_300_11)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_323011", "323011071", "story_v_out_323011.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_323011", "323011071", "story_v_out_323011.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_12 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_12 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_12

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_12 and arg_297_1.time_ < var_300_4 + var_300_12 + arg_300_0 then
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
			local var_304_0 = 0.675

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:GetWordFromCfg(323011072)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 27 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 27)

				if (27 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 27)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011072", "story_v_out_323011.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_out_323011", "323011072", "story_v_out_323011.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_out_323011", "323011072", "story_v_out_323011.awb")

						arg_301_1:RecordAudio("323011072", var_304_6)
						arg_301_1:RecordAudio("323011072", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_323011", "323011072", "story_v_out_323011.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_323011", "323011072", "story_v_out_323011.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 then
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
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["10167ui_story"]) and arg_305_1.var_.characterEffect10167ui_story == nil then
				arg_305_1.var_.characterEffect10167ui_story = arg_305_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["10167ui_story"]) then
				if arg_305_1.var_.characterEffect10167ui_story and not isNil(arg_305_1.actors_["10167ui_story"]) then
					arg_305_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["10167ui_story"]) and arg_305_1.var_.characterEffect10167ui_story then
				arg_305_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_308_2 = arg_305_1.actors_["10163ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.characterEffect10163ui_story == nil then
				arg_305_1.var_.characterEffect10163ui_story = var_308_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_3 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_3 and not isNil(var_308_2) then
				if arg_305_1.var_.characterEffect10163ui_story and not isNil(var_308_2) then
					arg_305_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_305_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_3)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_3 and arg_305_1.time_ < 0 + var_308_3 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.characterEffect10163ui_story then
				arg_305_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_305_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166actionlink/10166action42915")
			end

			local var_308_4 = 0
			local var_308_5 = 0.7

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_6 = arg_305_1:GetWordFromCfg(323011073)
				local var_308_7 = arg_305_1:FormatText(var_308_6.content)

				arg_305_1.text_.text = var_308_7

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_9 = 28 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 28)

				if (28 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 28)) > 0 and var_308_5 < var_308_9 then
					arg_305_1.talkMaxDuration = var_308_9

					if var_308_9 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_4
					end
				end

				arg_305_1.text_.text = var_308_7
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011073", "story_v_out_323011.awb") ~= 0 then
					local var_308_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011073", "story_v_out_323011.awb") / 1000

					if var_308_10 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_4
					end

					if var_308_6.prefab_name ~= "" and arg_305_1.actors_[var_308_6.prefab_name] ~= nil then
						local var_308_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_6.prefab_name].transform, "story_v_out_323011", "323011073", "story_v_out_323011.awb")

						arg_305_1:RecordAudio("323011073", var_308_11)
						arg_305_1:RecordAudio("323011073", var_308_11)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_323011", "323011073", "story_v_out_323011.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_323011", "323011073", "story_v_out_323011.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_12 = math.max(var_308_5, arg_305_1.talkMaxDuration)

			if var_308_4 <= arg_305_1.time_ and arg_305_1.time_ < var_308_4 + var_308_12 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_4) / var_308_12

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_4 + var_308_12 and arg_305_1.time_ < var_308_4 + var_308_12 + arg_308_0 then
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
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["10167ui_story"]) and arg_309_1.var_.characterEffect10167ui_story == nil then
				arg_309_1.var_.characterEffect10167ui_story = arg_309_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["10167ui_story"]) then
				if arg_309_1.var_.characterEffect10167ui_story and not isNil(arg_309_1.actors_["10167ui_story"]) then
					arg_309_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_309_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_0)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["10167ui_story"]) and arg_309_1.var_.characterEffect10167ui_story then
				arg_309_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_309_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			local var_312_1 = 0
			local var_312_2 = 1.425

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_1 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_3 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(323011074).content)

				arg_309_1.text_.text = var_312_3

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 57 <= 0 and var_312_2 or var_312_2 * (utf8.len(var_312_3) / 57)

				if (57 <= 0 and var_312_2 or var_312_2 * (utf8.len(var_312_3) / 57)) > 0 and var_312_2 < var_312_5 then
					arg_309_1.talkMaxDuration = var_312_5

					if var_312_5 + var_312_1 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_5 + var_312_1
					end
				end

				arg_309_1.text_.text = var_312_3
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_6 = math.max(var_312_2, arg_309_1.talkMaxDuration)

			if var_312_1 <= arg_309_1.time_ and arg_309_1.time_ < var_312_1 + var_312_6 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_1) / var_312_6

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_1 + var_312_6 and arg_309_1.time_ < var_312_1 + var_312_6 + arg_312_0 then
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
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["10167ui_story"]) and arg_313_1.var_.characterEffect10167ui_story == nil then
				arg_313_1.var_.characterEffect10167ui_story = arg_313_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["10167ui_story"]) then
				if arg_313_1.var_.characterEffect10167ui_story and not isNil(arg_313_1.actors_["10167ui_story"]) then
					arg_313_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["10167ui_story"]) and arg_313_1.var_.characterEffect10167ui_story then
				arg_313_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166actionlink/10166action4158")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuA", "EmotionTimelineAnimator")
			end

			local var_316_2 = 0
			local var_316_3 = 0.525

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_4 = arg_313_1:GetWordFromCfg(323011075)
				local var_316_5 = arg_313_1:FormatText(var_316_4.content)

				arg_313_1.text_.text = var_316_5

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_7 = 21 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 21)

				if (21 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_5) / 21)) > 0 and var_316_3 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_2
					end
				end

				arg_313_1.text_.text = var_316_5
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011075", "story_v_out_323011.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011075", "story_v_out_323011.awb") / 1000

					if var_316_8 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_2
					end

					if var_316_4.prefab_name ~= "" and arg_313_1.actors_[var_316_4.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_4.prefab_name].transform, "story_v_out_323011", "323011075", "story_v_out_323011.awb")

						arg_313_1:RecordAudio("323011075", var_316_9)
						arg_313_1:RecordAudio("323011075", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_323011", "323011075", "story_v_out_323011.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_323011", "323011075", "story_v_out_323011.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_3, arg_313_1.talkMaxDuration)

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_2) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_2 + var_316_10 and arg_313_1.time_ < var_316_2 + var_316_10 + arg_316_0 then
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
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["10163ui_story"]) and arg_317_1.var_.characterEffect10163ui_story == nil then
				arg_317_1.var_.characterEffect10163ui_story = arg_317_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["10163ui_story"]) then
				if arg_317_1.var_.characterEffect10163ui_story and not isNil(arg_317_1.actors_["10163ui_story"]) then
					arg_317_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["10163ui_story"]) and arg_317_1.var_.characterEffect10163ui_story then
				arg_317_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_320_2 = arg_317_1.actors_["10167ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.characterEffect10167ui_story == nil then
				arg_317_1.var_.characterEffect10167ui_story = var_320_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_3 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_3 and not isNil(var_320_2) then
				if arg_317_1.var_.characterEffect10167ui_story and not isNil(var_320_2) then
					arg_317_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_317_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_3)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_3 and arg_317_1.time_ < 0 + var_320_3 + arg_320_0 and not isNil(var_320_2) and arg_317_1.var_.characterEffect10167ui_story then
				arg_317_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_317_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_1")
			end

			local var_320_4 = 0
			local var_320_5 = 0.25

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_6 = arg_317_1:GetWordFromCfg(323011076)
				local var_320_7 = arg_317_1:FormatText(var_320_6.content)

				arg_317_1.text_.text = var_320_7

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_9 = 10 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 10)

				if (10 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 10)) > 0 and var_320_5 < var_320_9 then
					arg_317_1.talkMaxDuration = var_320_9

					if var_320_9 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_9 + var_320_4
					end
				end

				arg_317_1.text_.text = var_320_7
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011076", "story_v_out_323011.awb") ~= 0 then
					local var_320_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011076", "story_v_out_323011.awb") / 1000

					if var_320_10 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_4
					end

					if var_320_6.prefab_name ~= "" and arg_317_1.actors_[var_320_6.prefab_name] ~= nil then
						local var_320_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_6.prefab_name].transform, "story_v_out_323011", "323011076", "story_v_out_323011.awb")

						arg_317_1:RecordAudio("323011076", var_320_11)
						arg_317_1:RecordAudio("323011076", var_320_11)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_323011", "323011076", "story_v_out_323011.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_323011", "323011076", "story_v_out_323011.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_12 = math.max(var_320_5, arg_317_1.talkMaxDuration)

			if var_320_4 <= arg_317_1.time_ and arg_317_1.time_ < var_320_4 + var_320_12 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_4) / var_320_12

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_4 + var_320_12 and arg_317_1.time_ < var_320_4 + var_320_12 + arg_320_0 then
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
			local var_324_0 = 0.575

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:GetWordFromCfg(323011077)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 23 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 23)

				if (23 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 23)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011077", "story_v_out_323011.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_323011", "323011077", "story_v_out_323011.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_323011", "323011077", "story_v_out_323011.awb")

						arg_321_1:RecordAudio("323011077", var_324_6)
						arg_321_1:RecordAudio("323011077", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_323011", "323011077", "story_v_out_323011.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_323011", "323011077", "story_v_out_323011.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 then
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
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["10167ui_story"]) and arg_325_1.var_.characterEffect10167ui_story == nil then
				arg_325_1.var_.characterEffect10167ui_story = arg_325_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_0 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["10167ui_story"]) then
				if arg_325_1.var_.characterEffect10167ui_story and not isNil(arg_325_1.actors_["10167ui_story"]) then
					arg_325_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["10167ui_story"]) and arg_325_1.var_.characterEffect10167ui_story then
				arg_325_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_328_2 = arg_325_1.actors_["10163ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.characterEffect10163ui_story == nil then
				arg_325_1.var_.characterEffect10163ui_story = var_328_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_3 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_3 and not isNil(var_328_2) then
				if arg_325_1.var_.characterEffect10163ui_story and not isNil(var_328_2) then
					arg_325_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_325_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_3)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_3 and arg_325_1.time_ < 0 + var_328_3 + arg_328_0 and not isNil(var_328_2) and arg_325_1.var_.characterEffect10163ui_story then
				arg_325_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_325_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_328_4 = 0
			local var_328_5 = 0.05

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_6 = arg_325_1:GetWordFromCfg(323011078)
				local var_328_7 = arg_325_1:FormatText(var_328_6.content)

				arg_325_1.text_.text = var_328_7

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_9 = 2 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 2)

				if (2 <= 0 and var_328_5 or var_328_5 * (utf8.len(var_328_7) / 2)) > 0 and var_328_5 < var_328_9 then
					arg_325_1.talkMaxDuration = var_328_9

					if var_328_9 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_9 + var_328_4
					end
				end

				arg_325_1.text_.text = var_328_7
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011078", "story_v_out_323011.awb") ~= 0 then
					local var_328_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011078", "story_v_out_323011.awb") / 1000

					if var_328_10 + var_328_4 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_10 + var_328_4
					end

					if var_328_6.prefab_name ~= "" and arg_325_1.actors_[var_328_6.prefab_name] ~= nil then
						local var_328_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_6.prefab_name].transform, "story_v_out_323011", "323011078", "story_v_out_323011.awb")

						arg_325_1:RecordAudio("323011078", var_328_11)
						arg_325_1:RecordAudio("323011078", var_328_11)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_323011", "323011078", "story_v_out_323011.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_323011", "323011078", "story_v_out_323011.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_12 = math.max(var_328_5, arg_325_1.talkMaxDuration)

			if var_328_4 <= arg_325_1.time_ and arg_325_1.time_ < var_328_4 + var_328_12 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_4) / var_328_12

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_4 + var_328_12 and arg_325_1.time_ < var_328_4 + var_328_12 + arg_328_0 then
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
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["10163ui_story"]) and arg_329_1.var_.characterEffect10163ui_story == nil then
				arg_329_1.var_.characterEffect10163ui_story = arg_329_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["10163ui_story"]) then
				if arg_329_1.var_.characterEffect10163ui_story and not isNil(arg_329_1.actors_["10163ui_story"]) then
					arg_329_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["10163ui_story"]) and arg_329_1.var_.characterEffect10163ui_story then
				arg_329_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_332_2 = arg_329_1.actors_["10167ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.characterEffect10167ui_story == nil then
				arg_329_1.var_.characterEffect10167ui_story = var_332_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_3 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_3 and not isNil(var_332_2) then
				if arg_329_1.var_.characterEffect10167ui_story and not isNil(var_332_2) then
					arg_329_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_329_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_3)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_3 and arg_329_1.time_ < 0 + var_332_3 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.characterEffect10167ui_story then
				arg_329_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_329_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action3_2")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("10163ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_332_4 = 0
			local var_332_5 = 0.3

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:GetWordFromCfg(323011079)
				local var_332_7 = arg_329_1:FormatText(var_332_6.content)

				arg_329_1.text_.text = var_332_7

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_9 = 12 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 12)

				if (12 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 12)) > 0 and var_332_5 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_4
					end
				end

				arg_329_1.text_.text = var_332_7
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011079", "story_v_out_323011.awb") ~= 0 then
					local var_332_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011079", "story_v_out_323011.awb") / 1000

					if var_332_10 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_4
					end

					if var_332_6.prefab_name ~= "" and arg_329_1.actors_[var_332_6.prefab_name] ~= nil then
						local var_332_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_6.prefab_name].transform, "story_v_out_323011", "323011079", "story_v_out_323011.awb")

						arg_329_1:RecordAudio("323011079", var_332_11)
						arg_329_1:RecordAudio("323011079", var_332_11)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_323011", "323011079", "story_v_out_323011.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_323011", "323011079", "story_v_out_323011.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_12 = math.max(var_332_5, arg_329_1.talkMaxDuration)

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_12 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_4) / var_332_12

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_4 + var_332_12 and arg_329_1.time_ < var_332_4 + var_332_12 + arg_332_0 then
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
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["10167ui_story"]) and arg_333_1.var_.characterEffect10167ui_story == nil then
				arg_333_1.var_.characterEffect10167ui_story = arg_333_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["10167ui_story"]) then
				if arg_333_1.var_.characterEffect10167ui_story and not isNil(arg_333_1.actors_["10167ui_story"]) then
					arg_333_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["10167ui_story"]) and arg_333_1.var_.characterEffect10167ui_story then
				arg_333_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_336_2 = arg_333_1.actors_["10163ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect10163ui_story == nil then
				arg_333_1.var_.characterEffect10163ui_story = var_336_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_3 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_3 and not isNil(var_336_2) then
				if arg_333_1.var_.characterEffect10163ui_story and not isNil(var_336_2) then
					arg_333_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_333_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_3)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_3 and arg_333_1.time_ < 0 + var_336_3 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect10163ui_story then
				arg_333_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_333_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action8_2")
			end

			local var_336_4 = 0
			local var_336_5 = 0.225

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:GetWordFromCfg(323011080)
				local var_336_7 = arg_333_1:FormatText(var_336_6.content)

				arg_333_1.text_.text = var_336_7

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_9 = 9 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 9)

				if (9 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 9)) > 0 and var_336_5 < var_336_9 then
					arg_333_1.talkMaxDuration = var_336_9

					if var_336_9 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_9 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_7
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011080", "story_v_out_323011.awb") ~= 0 then
					local var_336_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011080", "story_v_out_323011.awb") / 1000

					if var_336_10 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_4
					end

					if var_336_6.prefab_name ~= "" and arg_333_1.actors_[var_336_6.prefab_name] ~= nil then
						local var_336_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_6.prefab_name].transform, "story_v_out_323011", "323011080", "story_v_out_323011.awb")

						arg_333_1:RecordAudio("323011080", var_336_11)
						arg_333_1:RecordAudio("323011080", var_336_11)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_323011", "323011080", "story_v_out_323011.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_323011", "323011080", "story_v_out_323011.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_12 = math.max(var_336_5, arg_333_1.talkMaxDuration)

			if var_336_4 <= arg_333_1.time_ and arg_333_1.time_ < var_336_4 + var_336_12 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_4) / var_336_12

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_4 + var_336_12 and arg_333_1.time_ < var_336_4 + var_336_12 + arg_336_0 then
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
			local var_340_0 = 0.3

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:GetWordFromCfg(323011081)
				local var_340_2 = arg_337_1:FormatText(var_340_1.content)

				arg_337_1.text_.text = var_340_2

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_4 = 12 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 12)

				if (12 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_2) / 12)) > 0 and var_340_0 < var_340_4 then
					arg_337_1.talkMaxDuration = var_340_4

					if var_340_4 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_4 + 0
					end
				end

				arg_337_1.text_.text = var_340_2
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011081", "story_v_out_323011.awb") ~= 0 then
					local var_340_5 = manager.audio:GetVoiceLength("story_v_out_323011", "323011081", "story_v_out_323011.awb") / 1000

					if var_340_5 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + 0
					end

					if var_340_1.prefab_name ~= "" and arg_337_1.actors_[var_340_1.prefab_name] ~= nil then
						local var_340_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_1.prefab_name].transform, "story_v_out_323011", "323011081", "story_v_out_323011.awb")

						arg_337_1:RecordAudio("323011081", var_340_6)
						arg_337_1:RecordAudio("323011081", var_340_6)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_323011", "323011081", "story_v_out_323011.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_323011", "323011081", "story_v_out_323011.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_7 and arg_337_1.time_ < 0 + var_340_7 + arg_340_0 then
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
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["10163ui_story"]) and arg_341_1.var_.characterEffect10163ui_story == nil then
				arg_341_1.var_.characterEffect10163ui_story = arg_341_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["10163ui_story"]) then
				if arg_341_1.var_.characterEffect10163ui_story and not isNil(arg_341_1.actors_["10163ui_story"]) then
					arg_341_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["10163ui_story"]) and arg_341_1.var_.characterEffect10163ui_story then
				arg_341_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_344_2 = arg_341_1.actors_["10167ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.characterEffect10167ui_story == nil then
				arg_341_1.var_.characterEffect10167ui_story = var_344_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_3 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_3 and not isNil(var_344_2) then
				if arg_341_1.var_.characterEffect10167ui_story and not isNil(var_344_2) then
					arg_341_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_341_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_3)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_3 and arg_341_1.time_ < 0 + var_344_3 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.characterEffect10167ui_story then
				arg_341_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_341_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			local var_344_4 = 0
			local var_344_5 = 0.175

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(323011082)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 7 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 7)

				if (7 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 7)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011082", "story_v_out_323011.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011082", "story_v_out_323011.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_out_323011", "323011082", "story_v_out_323011.awb")

						arg_341_1:RecordAudio("323011082", var_344_11)
						arg_341_1:RecordAudio("323011082", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_323011", "323011082", "story_v_out_323011.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_323011", "323011082", "story_v_out_323011.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
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
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["10167ui_story"]) and arg_345_1.var_.characterEffect10167ui_story == nil then
				arg_345_1.var_.characterEffect10167ui_story = arg_345_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["10167ui_story"]) then
				if arg_345_1.var_.characterEffect10167ui_story and not isNil(arg_345_1.actors_["10167ui_story"]) then
					arg_345_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["10167ui_story"]) and arg_345_1.var_.characterEffect10167ui_story then
				arg_345_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_348_2 = arg_345_1.actors_["10163ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.characterEffect10163ui_story == nil then
				arg_345_1.var_.characterEffect10163ui_story = var_348_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_3 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_3 and not isNil(var_348_2) then
				if arg_345_1.var_.characterEffect10163ui_story and not isNil(var_348_2) then
					arg_345_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_345_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_3)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_3 and arg_345_1.time_ < 0 + var_348_3 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.characterEffect10163ui_story then
				arg_345_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_345_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			local var_348_4 = 0
			local var_348_5 = 0.55

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_4 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_6 = arg_345_1:GetWordFromCfg(323011083)
				local var_348_7 = arg_345_1:FormatText(var_348_6.content)

				arg_345_1.text_.text = var_348_7

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_9 = 22 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 22)

				if (22 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 22)) > 0 and var_348_5 < var_348_9 then
					arg_345_1.talkMaxDuration = var_348_9

					if var_348_9 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_9 + var_348_4
					end
				end

				arg_345_1.text_.text = var_348_7
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011083", "story_v_out_323011.awb") ~= 0 then
					local var_348_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011083", "story_v_out_323011.awb") / 1000

					if var_348_10 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_4
					end

					if var_348_6.prefab_name ~= "" and arg_345_1.actors_[var_348_6.prefab_name] ~= nil then
						local var_348_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_6.prefab_name].transform, "story_v_out_323011", "323011083", "story_v_out_323011.awb")

						arg_345_1:RecordAudio("323011083", var_348_11)
						arg_345_1:RecordAudio("323011083", var_348_11)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_323011", "323011083", "story_v_out_323011.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_323011", "323011083", "story_v_out_323011.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_12 = math.max(var_348_5, arg_345_1.talkMaxDuration)

			if var_348_4 <= arg_345_1.time_ and arg_345_1.time_ < var_348_4 + var_348_12 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_4) / var_348_12

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_4 + var_348_12 and arg_345_1.time_ < var_348_4 + var_348_12 + arg_348_0 then
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
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["10163ui_story"]) and arg_349_1.var_.characterEffect10163ui_story == nil then
				arg_349_1.var_.characterEffect10163ui_story = arg_349_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["10163ui_story"]) then
				if arg_349_1.var_.characterEffect10163ui_story and not isNil(arg_349_1.actors_["10163ui_story"]) then
					arg_349_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["10163ui_story"]) and arg_349_1.var_.characterEffect10163ui_story then
				arg_349_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_352_2 = arg_349_1.actors_["10167ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.characterEffect10167ui_story == nil then
				arg_349_1.var_.characterEffect10167ui_story = var_352_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_3 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_3 and not isNil(var_352_2) then
				if arg_349_1.var_.characterEffect10167ui_story and not isNil(var_352_2) then
					arg_349_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_349_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_3)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_3 and arg_349_1.time_ < 0 + var_352_3 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.characterEffect10167ui_story then
				arg_349_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_349_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			local var_352_4 = 0
			local var_352_5 = 0.275

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[1444].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_6 = arg_349_1:GetWordFromCfg(323011084)
				local var_352_7 = arg_349_1:FormatText(var_352_6.content)

				arg_349_1.text_.text = var_352_7

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_9 = 11 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 11)

				if (11 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 11)) > 0 and var_352_5 < var_352_9 then
					arg_349_1.talkMaxDuration = var_352_9

					if var_352_9 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_9 + var_352_4
					end
				end

				arg_349_1.text_.text = var_352_7
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011084", "story_v_out_323011.awb") ~= 0 then
					local var_352_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011084", "story_v_out_323011.awb") / 1000

					if var_352_10 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_4
					end

					if var_352_6.prefab_name ~= "" and arg_349_1.actors_[var_352_6.prefab_name] ~= nil then
						local var_352_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_6.prefab_name].transform, "story_v_out_323011", "323011084", "story_v_out_323011.awb")

						arg_349_1:RecordAudio("323011084", var_352_11)
						arg_349_1:RecordAudio("323011084", var_352_11)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_323011", "323011084", "story_v_out_323011.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_323011", "323011084", "story_v_out_323011.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_12 = math.max(var_352_5, arg_349_1.talkMaxDuration)

			if var_352_4 <= arg_349_1.time_ and arg_349_1.time_ < var_352_4 + var_352_12 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_4) / var_352_12

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_4 + var_352_12 and arg_349_1.time_ < var_352_4 + var_352_12 + arg_352_0 then
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
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["10167ui_story"]) and arg_353_1.var_.characterEffect10167ui_story == nil then
				arg_353_1.var_.characterEffect10167ui_story = arg_353_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_0 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["10167ui_story"]) then
				if arg_353_1.var_.characterEffect10167ui_story and not isNil(arg_353_1.actors_["10167ui_story"]) then
					arg_353_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["10167ui_story"]) and arg_353_1.var_.characterEffect10167ui_story then
				arg_353_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			local var_356_2 = arg_353_1.actors_["10163ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.characterEffect10163ui_story == nil then
				arg_353_1.var_.characterEffect10163ui_story = var_356_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_3 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_3 and not isNil(var_356_2) then
				if arg_353_1.var_.characterEffect10163ui_story and not isNil(var_356_2) then
					arg_353_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_353_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_3)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_3 and arg_353_1.time_ < 0 + var_356_3 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.characterEffect10163ui_story then
				arg_353_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_353_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("10167ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action12_1")
			end

			local var_356_4 = 0
			local var_356_5 = 0.75

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[1447].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_6 = arg_353_1:GetWordFromCfg(323011085)
				local var_356_7 = arg_353_1:FormatText(var_356_6.content)

				arg_353_1.text_.text = var_356_7

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_9 = 30 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 30)

				if (30 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 30)) > 0 and var_356_5 < var_356_9 then
					arg_353_1.talkMaxDuration = var_356_9

					if var_356_9 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_9 + var_356_4
					end
				end

				arg_353_1.text_.text = var_356_7
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011085", "story_v_out_323011.awb") ~= 0 then
					local var_356_10 = manager.audio:GetVoiceLength("story_v_out_323011", "323011085", "story_v_out_323011.awb") / 1000

					if var_356_10 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_4
					end

					if var_356_6.prefab_name ~= "" and arg_353_1.actors_[var_356_6.prefab_name] ~= nil then
						local var_356_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_6.prefab_name].transform, "story_v_out_323011", "323011085", "story_v_out_323011.awb")

						arg_353_1:RecordAudio("323011085", var_356_11)
						arg_353_1:RecordAudio("323011085", var_356_11)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_323011", "323011085", "story_v_out_323011.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_323011", "323011085", "story_v_out_323011.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_12 = math.max(var_356_5, arg_353_1.talkMaxDuration)

			if var_356_4 <= arg_353_1.time_ and arg_353_1.time_ < var_356_4 + var_356_12 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_4) / var_356_12

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_4 + var_356_12 and arg_353_1.time_ < var_356_4 + var_356_12 + arg_356_0 then
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
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos10167ui_story = arg_357_1.actors_["10167ui_story"].transform.localPosition

				local var_360_0 = GameObjectTools.GetOrAddComponent(arg_357_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_360_0 then
					var_360_0:EnableDynamicBone(false)
				end
			end

			local var_360_1 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_1 then
				arg_357_1.actors_["10167ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10167ui_story, Vector3.New(0, 100, 0), (arg_357_1.time_ - 0) / var_360_1)
				arg_357_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["10167ui_story"].transform.position).z)
				arg_357_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["10167ui_story"].transform.localEulerAngles = arg_357_1.actors_["10167ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_1 and arg_357_1.time_ < 0 + var_360_1 + arg_360_0 then
				arg_357_1.actors_["10167ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_357_1.actors_["10167ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["10167ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["10167ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["10167ui_story"].transform.position).z)
				arg_357_1.actors_["10167ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["10167ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["10167ui_story"].transform.localEulerAngles = arg_357_1.actors_["10167ui_story"].transform.localEulerAngles

				local var_360_2 = GameObjectTools.GetOrAddComponent(arg_357_1.actors_["10167ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_360_2 then
					var_360_2:EnableDynamicBone(true)
				end
			end

			local var_360_3 = arg_357_1.actors_["10163ui_story"].transform

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos10163ui_story = var_360_3.localPosition

				local var_360_4 = GameObjectTools.GetOrAddComponent(var_360_3.gameObject, typeof(DynamicBoneHelper))

				if var_360_4 then
					var_360_4:EnableDynamicBone(false)
				end
			end

			local var_360_5 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_5 then
				var_360_3.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos10163ui_story, Vector3.New(0, 100, 0), (arg_357_1.time_ - 0) / var_360_5)
				var_360_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_3.position).x, (manager.ui.mainCamera.transform.position - var_360_3.position).y, (manager.ui.mainCamera.transform.position - var_360_3.position).z)
				var_360_3.localEulerAngles.z = 0
				var_360_3.localEulerAngles.x = 0
				var_360_3.localEulerAngles = var_360_3.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_5 and arg_357_1.time_ < 0 + var_360_5 + arg_360_0 then
				var_360_3.localPosition = Vector3.New(0, 100, 0)
				var_360_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_3.position).x, (manager.ui.mainCamera.transform.position - var_360_3.position).y, (manager.ui.mainCamera.transform.position - var_360_3.position).z)
				var_360_3.localEulerAngles.z = 0
				var_360_3.localEulerAngles.x = 0
				var_360_3.localEulerAngles = var_360_3.localEulerAngles

				local var_360_6 = GameObjectTools.GetOrAddComponent(var_360_3.gameObject, typeof(DynamicBoneHelper))

				if var_360_6 then
					var_360_6:EnableDynamicBone(true)
				end
			end

			local var_360_7 = arg_357_1.actors_["10167ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_7) and arg_357_1.var_.characterEffect10167ui_story == nil then
				arg_357_1.var_.characterEffect10167ui_story = var_360_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_8 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_8 and not isNil(var_360_7) then
				if arg_357_1.var_.characterEffect10167ui_story and not isNil(var_360_7) then
					arg_357_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_357_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_8)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_8 and arg_357_1.time_ < 0 + var_360_8 + arg_360_0 and not isNil(var_360_7) and arg_357_1.var_.characterEffect10167ui_story then
				arg_357_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_357_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			local var_360_9 = 0
			local var_360_10 = 0.75

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_9 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_11 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(323011086).content)

				arg_357_1.text_.text = var_360_11

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_13 = 30 <= 0 and var_360_10 or var_360_10 * (utf8.len(var_360_11) / 30)

				if (30 <= 0 and var_360_10 or var_360_10 * (utf8.len(var_360_11) / 30)) > 0 and var_360_10 < var_360_13 then
					arg_357_1.talkMaxDuration = var_360_13

					if var_360_13 + var_360_9 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_13 + var_360_9
					end
				end

				arg_357_1.text_.text = var_360_11
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_14 = math.max(var_360_10, arg_357_1.talkMaxDuration)

			if var_360_9 <= arg_357_1.time_ and arg_357_1.time_ < var_360_9 + var_360_14 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_9) / var_360_14

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_9 + var_360_14 and arg_357_1.time_ < var_360_9 + var_360_14 + arg_360_0 then
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
			if 1.43333333333333 < arg_361_1.time_ and arg_361_1.time_ <= 1.43333333333333 + arg_364_0 then
				local var_364_0 = arg_361_1.bgs_.STblack

				arg_361_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_364_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_364_1 = var_364_0:GetComponent("SpriteRenderer")

				if var_364_1 and var_364_1.sprite then
					local var_364_2 = 2 * (var_364_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_364_0.transform.localScale = Vector3.New(var_364_2 / var_364_1.sprite.bounds.size.y < var_364_2 * manager.ui.mainCameraCom_.aspect / var_364_1.sprite.bounds.size.x and var_364_2 * manager.ui.mainCameraCom_.aspect / var_364_1.sprite.bounds.size.x or var_364_2 / var_364_1.sprite.bounds.size.y, var_364_2 / var_364_1.sprite.bounds.size.y < var_364_2 * manager.ui.mainCameraCom_.aspect / var_364_1.sprite.bounds.size.x and var_364_2 * manager.ui.mainCameraCom_.aspect / var_364_1.sprite.bounds.size.x or var_364_2 / var_364_1.sprite.bounds.size.y, 0)
				end

				for iter_364_0, iter_364_1 in pairs(arg_361_1.bgs_) do
					if iter_364_0 ~= "STblack" then
						iter_364_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_364_3 = 1.43333333333333

			if 1.43333333333333 < arg_361_1.time_ and arg_361_1.time_ <= var_364_3 + arg_364_0 then
				arg_361_1.allBtn_.enabled = false
			end

			if arg_361_1.time_ >= var_364_3 + 0.3 and arg_361_1.time_ < var_364_3 + 0.3 + arg_364_0 then
				arg_361_1.allBtn_.enabled = true
			end

			local var_364_4 = 0

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_4 + arg_364_0 then
				arg_361_1.mask_.enabled = true
				arg_361_1.mask_.raycastTarget = true

				arg_361_1:SetGaussion(false)
			end

			local var_364_5 = 1.45

			if var_364_4 <= arg_361_1.time_ and arg_361_1.time_ < var_364_4 + var_364_5 then
				local var_364_6 = Color.New(0, 0, 0)

				var_364_6.a = Mathf.Lerp(0, 1, (arg_361_1.time_ - var_364_4) / var_364_5)
				arg_361_1.mask_.color = var_364_6
			end

			if arg_361_1.time_ >= var_364_4 + var_364_5 and arg_361_1.time_ < var_364_4 + var_364_5 + arg_364_0 then
				local var_364_7 = Color.New(0, 0, 0)

				var_364_7.a = 1
				arg_361_1.mask_.color = var_364_7
			end

			local var_364_8 = 1.43333333333333

			if 1.43333333333333 < arg_361_1.time_ and arg_361_1.time_ <= var_364_8 + arg_364_0 then
				arg_361_1.mask_.enabled = true
				arg_361_1.mask_.raycastTarget = true

				arg_361_1:SetGaussion(false)
			end

			local var_364_9 = 2

			if var_364_8 <= arg_361_1.time_ and arg_361_1.time_ < var_364_8 + var_364_9 then
				local var_364_10 = Color.New(0, 0, 0)

				var_364_10.a = Mathf.Lerp(1, 0, (arg_361_1.time_ - var_364_8) / var_364_9)
				arg_361_1.mask_.color = var_364_10
			end

			if arg_361_1.time_ >= var_364_8 + var_364_9 and arg_361_1.time_ < var_364_8 + var_364_9 + arg_364_0 then
				local var_364_11 = Color.New(0, 0, 0)

				arg_361_1.mask_.enabled = false
				var_364_11.a = 0
				arg_361_1.mask_.color = var_364_11
			end

			if 1.43333333333333 < arg_361_1.time_ and arg_361_1.time_ <= 1.43333333333333 + arg_364_0 then
				arg_361_1.cswbg_:SetActive(true)

				local var_364_12 = arg_361_1.cswt_:GetComponent("RectTransform")

				arg_361_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_364_12.offsetMin = Vector2.New(400, -200)
				var_364_12.offsetMax = Vector2.New(-400, -262.5)
				arg_361_1.cswt_.text = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(419176).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.cswt_)

				arg_361_1.cswt_.fontSize = 108
				arg_361_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_361_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_361_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1.43333333333333 < arg_361_1.time_ and arg_361_1.time_ <= 1.43333333333333 + arg_364_0 then
				arg_361_1.fswbg_:SetActive(true)
				arg_361_1.dialog_:SetActive(false)

				arg_361_1.fswtw_.percent = 0
				arg_361_1.fswt_.text = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.fswt_)

				arg_361_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_361_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_361_1.fswtw_:SetDirty()

				arg_361_1.typewritterCharCountI18N = 0

				SetActive(arg_361_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_361_1:ShowNextGo(false)
			end

			local var_364_13 = 2.78333333333333

			if 2.78333333333333 < arg_361_1.time_ and arg_361_1.time_ <= var_364_13 + arg_364_0 then
				arg_361_1.var_.oldValueTypewriter = arg_361_1.fswtw_.percent

				SetActive(arg_361_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_361_1:ShowNextGo(false)
			end

			local var_364_14 = 0
			local var_364_15 = 0.65
			local var_364_16, var_364_17 = arg_361_1:GetPercentByPara(arg_361_1:FormatText(arg_361_1:GetWordFromCfg(102).content), 1)

			if var_364_13 < arg_361_1.time_ and arg_361_1.time_ <= var_364_13 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0

				local var_364_18 = var_364_14 <= 0 and var_364_15 or var_364_15 * ((var_364_17 - arg_361_1.typewritterCharCountI18N) / var_364_14)

				if (var_364_14 <= 0 and var_364_15 or var_364_15 * ((var_364_17 - arg_361_1.typewritterCharCountI18N) / var_364_14)) > 0 and var_364_15 < var_364_18 then
					arg_361_1.talkMaxDuration = var_364_18

					if var_364_18 + var_364_13 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_18 + var_364_13
					end
				end
			end

			local var_364_19 = math.max(0.65, arg_361_1.talkMaxDuration)

			if var_364_13 <= arg_361_1.time_ and arg_361_1.time_ < var_364_13 + var_364_19 then
				arg_361_1.fswtw_.percent = Mathf.Lerp(arg_361_1.var_.oldValueTypewriter, var_364_16, (arg_361_1.time_ - var_364_13) / var_364_19)
				arg_361_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_361_1.fswtw_:SetDirty()
			end

			if arg_361_1.time_ >= var_364_13 + var_364_19 and arg_361_1.time_ < var_364_13 + var_364_19 + arg_364_0 then
				arg_361_1.fswtw_.percent = var_364_16

				arg_361_1.fswtw_:SetDirty()
				arg_361_1:ShowNextGo(true)

				arg_361_1.typewritterCharCountI18N = var_364_17
			end

			if 1.43333333333333 < arg_361_1.time_ and arg_361_1.time_ <= 1.43333333333333 + arg_364_0 then
				arg_361_1:AudioAction("play", "effect", "se_story_148", "se_story_148_bell_temple_china01", "")
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
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["10167ui_story"]) and arg_365_1.var_.characterEffect10167ui_story == nil then
				arg_365_1.var_.characterEffect10167ui_story = arg_365_1.actors_["10167ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["10167ui_story"]) then
				if arg_365_1.var_.characterEffect10167ui_story and not isNil(arg_365_1.actors_["10167ui_story"]) then
					arg_365_1.var_.characterEffect10167ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["10167ui_story"]) and arg_365_1.var_.characterEffect10167ui_story then
				arg_365_1.var_.characterEffect10167ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.fswbg_:SetActive(true)
				arg_365_1.dialog_:SetActive(false)

				arg_365_1.fswtw_.percent = 0
				arg_365_1.fswt_.text = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(323011088).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.fswt_)

				arg_365_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_365_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_365_1.fswtw_:SetDirty()

				arg_365_1.typewritterCharCountI18N = 0

				SetActive(arg_365_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_365_1:ShowNextGo(false)
			end

			local var_368_2 = 1.1

			if 1.1 < arg_365_1.time_ and arg_365_1.time_ <= var_368_2 + arg_368_0 then
				arg_365_1.var_.oldValueTypewriter = arg_365_1.fswtw_.percent

				SetActive(arg_365_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_365_1:ShowNextGo(false)
			end

			local var_368_3 = 3
			local var_368_4 = 0.2
			local var_368_5, var_368_6 = arg_365_1:GetPercentByPara(arg_365_1:FormatText(arg_365_1:GetWordFromCfg(323011088).content), 1)

			if var_368_2 < arg_365_1.time_ and arg_365_1.time_ <= var_368_2 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0

				local var_368_7 = var_368_3 <= 0 and var_368_4 or var_368_4 * ((var_368_6 - arg_365_1.typewritterCharCountI18N) / var_368_3)

				if (var_368_3 <= 0 and var_368_4 or var_368_4 * ((var_368_6 - arg_365_1.typewritterCharCountI18N) / var_368_3)) > 0 and var_368_4 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_2
					end
				end
			end

			local var_368_8 = math.max(0.2, arg_365_1.talkMaxDuration)

			if var_368_2 <= arg_365_1.time_ and arg_365_1.time_ < var_368_2 + var_368_8 then
				arg_365_1.fswtw_.percent = Mathf.Lerp(arg_365_1.var_.oldValueTypewriter, var_368_5, (arg_365_1.time_ - var_368_2) / var_368_8)
				arg_365_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_365_1.fswtw_:SetDirty()
			end

			if arg_365_1.time_ >= var_368_2 + var_368_8 and arg_365_1.time_ < var_368_2 + var_368_8 + arg_368_0 then
				arg_365_1.fswtw_.percent = var_368_5

				arg_365_1.fswtw_:SetDirty()
				arg_365_1:ShowNextGo(true)

				arg_365_1.typewritterCharCountI18N = var_368_6
			end

			local var_368_9 = 0

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_9 + arg_368_0 then
				arg_365_1.allBtn_.enabled = false
			end

			if arg_365_1.time_ >= var_368_9 + 1.3 and arg_365_1.time_ < var_368_9 + 1.3 + arg_368_0 then
				arg_365_1.allBtn_.enabled = true
			end

			local var_368_10 = 1
			local var_368_11 = manager.audio:GetVoiceLength("story_v_out_323011", "323011088", "0") / 1000

			if var_368_11 > 0 and 1 < var_368_11 and var_368_11 + var_368_10 > arg_365_1.duration_ then
				arg_365_1.duration_ = var_368_11 + var_368_10
			end

			if var_368_10 < arg_365_1.time_ and arg_365_1.time_ <= var_368_10 + arg_368_0 then
				arg_365_1:AudioAction("play", "voice", "story_v_out_323011", "323011088", "0")
			end

			if 1 < arg_365_1.time_ and arg_365_1.time_ <= 1 + arg_368_0 then
				arg_365_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_jianmenguan", "battle", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_368_15 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "battle")

				if "" ~= "" then
					if arg_365_1.bgmTxt_.text ~= var_368_15 and arg_365_1.bgmTxt_.text ~= "" then
						if arg_365_1.bgmTxt2_.text ~= "" then
							arg_365_1.bgmTxt_.text = arg_365_1.bgmTxt2_.text
						end

						arg_365_1.bgmTxt2_.text = var_368_15

						arg_365_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_365_1.bgmTxt_.text = var_368_15
						arg_365_1.bgmTxt2_.text = var_368_15
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
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["10165ui_story"]) and arg_370_1.var_.characterEffect10165ui_story == nil then
				arg_370_1.var_.characterEffect10165ui_story = arg_370_1.actors_["10165ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["10165ui_story"]) then
				if arg_370_1.var_.characterEffect10165ui_story and not isNil(arg_370_1.actors_["10165ui_story"]) then
					arg_370_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["10165ui_story"]) and arg_370_1.var_.characterEffect10165ui_story then
				arg_370_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_373_2 = arg_370_1.actors_["10167ui_story"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.characterEffect10167ui_story == nil then
				arg_370_1.var_.characterEffect10167ui_story = var_373_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_3 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_3 and not isNil(var_373_2) then
				if arg_370_1.var_.characterEffect10167ui_story and not isNil(var_373_2) then
					arg_370_1.var_.characterEffect10167ui_story.fillFlat = true
					arg_370_1.var_.characterEffect10167ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_3)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_3 and arg_370_1.time_ < 0 + var_373_3 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.characterEffect10167ui_story then
				arg_370_1.var_.characterEffect10167ui_story.fillFlat = true
				arg_370_1.var_.characterEffect10167ui_story.fillRatio = 0.5
			end

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.fswbg_:SetActive(true)
				arg_370_1.dialog_:SetActive(false)

				arg_370_1.fswtw_.percent = 0
				arg_370_1.fswt_.text = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(323011089).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.fswt_)

				arg_370_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_370_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_370_1.fswtw_:SetDirty()

				arg_370_1.typewritterCharCountI18N = 0

				SetActive(arg_370_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_370_1:ShowNextGo(false)
			end

			local var_373_4 = 0.433333333333333

			if 0.433333333333333 < arg_370_1.time_ and arg_370_1.time_ <= var_373_4 + arg_373_0 then
				arg_370_1.var_.oldValueTypewriter = arg_370_1.fswtw_.percent

				SetActive(arg_370_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_370_1:ShowNextGo(false)
			end

			local var_373_5 = 10
			local var_373_6 = 0.666666666666667
			local var_373_7, var_373_8 = arg_370_1:GetPercentByPara(arg_370_1:FormatText(arg_370_1:GetWordFromCfg(323011089).content), 1)

			if var_373_4 < arg_370_1.time_ and arg_370_1.time_ <= var_373_4 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0

				local var_373_9 = var_373_5 <= 0 and var_373_6 or var_373_6 * ((var_373_8 - arg_370_1.typewritterCharCountI18N) / var_373_5)

				if (var_373_5 <= 0 and var_373_6 or var_373_6 * ((var_373_8 - arg_370_1.typewritterCharCountI18N) / var_373_5)) > 0 and var_373_6 < var_373_9 then
					arg_370_1.talkMaxDuration = var_373_9

					if var_373_9 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_9 + var_373_4
					end
				end
			end

			local var_373_10 = math.max(0.666666666666667, arg_370_1.talkMaxDuration)

			if var_373_4 <= arg_370_1.time_ and arg_370_1.time_ < var_373_4 + var_373_10 then
				arg_370_1.fswtw_.percent = Mathf.Lerp(arg_370_1.var_.oldValueTypewriter, var_373_7, (arg_370_1.time_ - var_373_4) / var_373_10)
				arg_370_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_370_1.fswtw_:SetDirty()
			end

			if arg_370_1.time_ >= var_373_4 + var_373_10 and arg_370_1.time_ < var_373_4 + var_373_10 + arg_373_0 then
				arg_370_1.fswtw_.percent = var_373_7

				arg_370_1.fswtw_:SetDirty()
				arg_370_1:ShowNextGo(true)

				arg_370_1.typewritterCharCountI18N = var_373_8
			end

			local var_373_11 = 0.3
			local var_373_12 = manager.audio:GetVoiceLength("story_v_out_323011", "323011089", "0") / 1000

			if var_373_12 > 0 and 1 < var_373_12 and var_373_12 + var_373_11 > arg_370_1.duration_ then
				arg_370_1.duration_ = var_373_12 + var_373_11
			end

			if var_373_11 < arg_370_1.time_ and arg_370_1.time_ <= var_373_11 + arg_373_0 then
				arg_370_1:AudioAction("play", "voice", "story_v_out_323011", "323011089", "0")
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
			if arg_374_1.bgs_.J21f == nil then
				local var_377_0 = Object.Instantiate(arg_374_1.paintGo_)

				var_377_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21f")
				var_377_0.name = "J21f"
				var_377_0.transform.parent = arg_374_1.stage_.transform
				var_377_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_374_1.bgs_.J21f = var_377_0
			end

			if 1 < arg_374_1.time_ and arg_374_1.time_ <= 1 + arg_377_0 then
				local var_377_1 = arg_374_1.bgs_.J21f

				arg_374_1.bgs_.J21f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_377_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_377_2 = var_377_1:GetComponent("SpriteRenderer")

				if var_377_2 and var_377_2.sprite then
					local var_377_3 = 2 * (var_377_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_377_1.transform.localScale = Vector3.New(var_377_3 / var_377_2.sprite.bounds.size.y < var_377_3 * manager.ui.mainCameraCom_.aspect / var_377_2.sprite.bounds.size.x and var_377_3 * manager.ui.mainCameraCom_.aspect / var_377_2.sprite.bounds.size.x or var_377_3 / var_377_2.sprite.bounds.size.y, var_377_3 / var_377_2.sprite.bounds.size.y < var_377_3 * manager.ui.mainCameraCom_.aspect / var_377_2.sprite.bounds.size.x and var_377_3 * manager.ui.mainCameraCom_.aspect / var_377_2.sprite.bounds.size.x or var_377_3 / var_377_2.sprite.bounds.size.y, 0)
				end

				for iter_377_0, iter_377_1 in pairs(arg_374_1.bgs_) do
					if iter_377_0 ~= "J21f" then
						iter_377_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_377_4 = 1

			if 1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_4 + arg_377_0 then
				arg_374_1.allBtn_.enabled = false
			end

			if arg_374_1.time_ >= var_377_4 + 0.3 and arg_374_1.time_ < var_377_4 + 0.3 + arg_377_0 then
				arg_374_1.allBtn_.enabled = true
			end

			local var_377_5 = 0

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_5 + arg_377_0 then
				arg_374_1.mask_.enabled = true
				arg_374_1.mask_.raycastTarget = true

				arg_374_1:SetGaussion(false)
			end

			local var_377_6 = 1

			if var_377_5 <= arg_374_1.time_ and arg_374_1.time_ < var_377_5 + var_377_6 then
				local var_377_7 = Color.New(1, 1, 1)

				var_377_7.a = Mathf.Lerp(0, 1, (arg_374_1.time_ - var_377_5) / var_377_6)
				arg_374_1.mask_.color = var_377_7
			end

			if arg_374_1.time_ >= var_377_5 + var_377_6 and arg_374_1.time_ < var_377_5 + var_377_6 + arg_377_0 then
				local var_377_8 = Color.New(1, 1, 1)

				var_377_8.a = 1
				arg_374_1.mask_.color = var_377_8
			end

			local var_377_9 = 1

			if 1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_9 + arg_377_0 then
				arg_374_1.mask_.enabled = true
				arg_374_1.mask_.raycastTarget = true

				arg_374_1:SetGaussion(false)
			end

			local var_377_10 = 2

			if var_377_9 <= arg_374_1.time_ and arg_374_1.time_ < var_377_9 + var_377_10 then
				local var_377_11 = Color.New(1, 1, 1)

				var_377_11.a = Mathf.Lerp(1, 0, (arg_374_1.time_ - var_377_9) / var_377_10)
				arg_374_1.mask_.color = var_377_11
			end

			if arg_374_1.time_ >= var_377_9 + var_377_10 and arg_374_1.time_ < var_377_9 + var_377_10 + arg_377_0 then
				local var_377_12 = Color.New(1, 1, 1)

				arg_374_1.mask_.enabled = false
				var_377_12.a = 0
				arg_374_1.mask_.color = var_377_12
			end

			local var_377_13 = arg_374_1.actors_["10165ui_story"]

			if 1 < arg_374_1.time_ and arg_374_1.time_ <= 1 + arg_377_0 and not isNil(var_377_13) and arg_374_1.var_.characterEffect10165ui_story == nil then
				arg_374_1.var_.characterEffect10165ui_story = var_377_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_14 = 0.200000002980232

			if 1 <= arg_374_1.time_ and arg_374_1.time_ < 1 + var_377_14 and not isNil(var_377_13) then
				if arg_374_1.var_.characterEffect10165ui_story and not isNil(var_377_13) then
					arg_374_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_374_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_374_1.time_ - 1) / var_377_14)
				end
			end

			if arg_374_1.time_ >= 1 + var_377_14 and arg_374_1.time_ < 1 + var_377_14 + arg_377_0 and not isNil(var_377_13) and arg_374_1.var_.characterEffect10165ui_story then
				arg_374_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_374_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			if 1 < arg_374_1.time_ and arg_374_1.time_ <= 1 + arg_377_0 then
				arg_374_1.fswbg_:SetActive(false)
				arg_374_1.dialog_:SetActive(false)
				SetActive(arg_374_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_374_1:ShowNextGo(false)
			end

			if 1.01666666666667 < arg_374_1.time_ and arg_374_1.time_ <= 1.01666666666667 + arg_377_0 then
				arg_374_1.fswbg_:SetActive(false)
				arg_374_1.dialog_:SetActive(false)
				SetActive(arg_374_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_374_1:ShowNextGo(false)
			end

			if 1 < arg_374_1.time_ and arg_374_1.time_ <= 1 + arg_377_0 then
				arg_374_1.cswbg_:SetActive(false)
			end

			if 2.93333333333333 < arg_374_1.time_ and arg_374_1.time_ <= 2.93333333333333 + arg_377_0 then
				arg_374_1:AudioAction("play", "effect", "se_story_148", "se_story_148_door_huge", "")
			end

			if arg_374_1.frameCnt_ <= 1 then
				arg_374_1.dialog_:SetActive(false)
			end

			local var_377_16 = 2.76666666666667
			local var_377_17 = 1.375

			if 2.76666666666667 < arg_374_1.time_ and arg_374_1.time_ <= var_377_16 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0

				arg_374_1.dialog_:SetActive(true)

				arg_374_1.dialogCg_.alpha = 0

				local var_377_18 = LeanTween.value(arg_374_1.dialog_, 0, 1, 0.3)

				var_377_18:setOnUpdate(LuaHelper.FloatAction(function(arg_378_0)
					arg_374_1.dialogCg_.alpha = arg_378_0
				end))
				var_377_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_374_1.dialog_)
					var_377_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_374_1.duration_ = arg_374_1.duration_ + 0.3

				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_19 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(323011090).content)

				arg_374_1.text_.text = var_377_19

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_21 = 55 <= 0 and var_377_17 or var_377_17 * (utf8.len(var_377_19) / 55)

				if (55 <= 0 and var_377_17 or var_377_17 * (utf8.len(var_377_19) / 55)) > 0 and var_377_17 < var_377_21 then
					arg_374_1.talkMaxDuration = var_377_21
					var_377_16 = var_377_16 + 0.3

					if var_377_21 + var_377_16 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_21 + var_377_16
					end
				end

				arg_374_1.text_.text = var_377_19
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_22 = var_377_16 + 0.3
			local var_377_23 = math.max(var_377_17, arg_374_1.talkMaxDuration)

			if var_377_16 + 0.3 <= arg_374_1.time_ and arg_374_1.time_ < var_377_22 + var_377_23 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_22) / var_377_23

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_22 + var_377_23 and arg_374_1.time_ < var_377_22 + var_377_23 + arg_377_0 then
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
			local var_383_0 = 1.35

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_1 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(323011091).content)

				arg_380_1.text_.text = var_383_1

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_3 = 54 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 54)

				if (54 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 54)) > 0 and var_383_0 < var_383_3 then
					arg_380_1.talkMaxDuration = var_383_3

					if var_383_3 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_3 + 0
					end
				end

				arg_380_1.text_.text = var_383_1
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_4 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_4 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_4

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_4 and arg_380_1.time_ < 0 + var_383_4 + arg_383_0 then
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
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(arg_384_1.actors_["10165ui_story"]) and arg_384_1.var_.characterEffect10165ui_story == nil then
				arg_384_1.var_.characterEffect10165ui_story = arg_384_1.actors_["10165ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_0 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 and not isNil(arg_384_1.actors_["10165ui_story"]) then
				if arg_384_1.var_.characterEffect10165ui_story and not isNil(arg_384_1.actors_["10165ui_story"]) then
					arg_384_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 and not isNil(arg_384_1.actors_["10165ui_story"]) and arg_384_1.var_.characterEffect10165ui_story then
				arg_384_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			local var_387_2 = 0
			local var_387_3 = 0.2

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_2 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[1446].name)

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

				local var_387_4 = arg_384_1:GetWordFromCfg(323011092)
				local var_387_5 = arg_384_1:FormatText(var_387_4.content)

				arg_384_1.text_.text = var_387_5

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_7 = 8 <= 0 and var_387_3 or var_387_3 * (utf8.len(var_387_5) / 8)

				if (8 <= 0 and var_387_3 or var_387_3 * (utf8.len(var_387_5) / 8)) > 0 and var_387_3 < var_387_7 then
					arg_384_1.talkMaxDuration = var_387_7

					if var_387_7 + var_387_2 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_7 + var_387_2
					end
				end

				arg_384_1.text_.text = var_387_5
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011092", "story_v_out_323011.awb") ~= 0 then
					local var_387_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011092", "story_v_out_323011.awb") / 1000

					if var_387_8 + var_387_2 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_8 + var_387_2
					end

					if var_387_4.prefab_name ~= "" and arg_384_1.actors_[var_387_4.prefab_name] ~= nil then
						local var_387_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_4.prefab_name].transform, "story_v_out_323011", "323011092", "story_v_out_323011.awb")

						arg_384_1:RecordAudio("323011092", var_387_9)
						arg_384_1:RecordAudio("323011092", var_387_9)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_323011", "323011092", "story_v_out_323011.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_323011", "323011092", "story_v_out_323011.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_10 = math.max(var_387_3, arg_384_1.talkMaxDuration)

			if var_387_2 <= arg_384_1.time_ and arg_384_1.time_ < var_387_2 + var_387_10 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_2) / var_387_10

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_2 + var_387_10 and arg_384_1.time_ < var_387_2 + var_387_10 + arg_387_0 then
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
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["10163ui_story"]) and arg_388_1.var_.characterEffect10163ui_story == nil then
				arg_388_1.var_.characterEffect10163ui_story = arg_388_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_0 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["10163ui_story"]) then
				if arg_388_1.var_.characterEffect10163ui_story and not isNil(arg_388_1.actors_["10163ui_story"]) then
					arg_388_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["10163ui_story"]) and arg_388_1.var_.characterEffect10163ui_story then
				arg_388_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			local var_391_2 = arg_388_1.actors_["10165ui_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.characterEffect10165ui_story == nil then
				arg_388_1.var_.characterEffect10165ui_story = var_391_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_3 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_3 and not isNil(var_391_2) then
				if arg_388_1.var_.characterEffect10165ui_story and not isNil(var_391_2) then
					arg_388_1.var_.characterEffect10165ui_story.fillFlat = true
					arg_388_1.var_.characterEffect10165ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_388_1.time_ - 0) / var_391_3)
				end
			end

			if arg_388_1.time_ >= 0 + var_391_3 and arg_388_1.time_ < 0 + var_391_3 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.characterEffect10165ui_story then
				arg_388_1.var_.characterEffect10165ui_story.fillFlat = true
				arg_388_1.var_.characterEffect10165ui_story.fillRatio = 0.5
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_jianmenguan", "battle", "bgm_activity_4_8_story_dahuang_jianmenguan.awb")

				local var_391_6 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_jianmenguan", "battle")

				if "" ~= "" then
					if arg_388_1.bgmTxt_.text ~= var_391_6 and arg_388_1.bgmTxt_.text ~= "" then
						if arg_388_1.bgmTxt2_.text ~= "" then
							arg_388_1.bgmTxt_.text = arg_388_1.bgmTxt2_.text
						end

						arg_388_1.bgmTxt2_.text = var_391_6

						arg_388_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_388_1.bgmTxt_.text = var_391_6
						arg_388_1.bgmTxt2_.text = var_391_6
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

			local var_391_7 = 0
			local var_391_8 = 0.075

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_7 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[1444].name)

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

				local var_391_9 = arg_388_1:GetWordFromCfg(323011093)
				local var_391_10 = arg_388_1:FormatText(var_391_9.content)

				arg_388_1.text_.text = var_391_10

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_12 = 3 <= 0 and var_391_8 or var_391_8 * (utf8.len(var_391_10) / 3)

				if (3 <= 0 and var_391_8 or var_391_8 * (utf8.len(var_391_10) / 3)) > 0 and var_391_8 < var_391_12 then
					arg_388_1.talkMaxDuration = var_391_12

					if var_391_12 + var_391_7 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_12 + var_391_7
					end
				end

				arg_388_1.text_.text = var_391_10
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011093", "story_v_out_323011.awb") ~= 0 then
					local var_391_13 = manager.audio:GetVoiceLength("story_v_out_323011", "323011093", "story_v_out_323011.awb") / 1000

					if var_391_13 + var_391_7 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_13 + var_391_7
					end

					if var_391_9.prefab_name ~= "" and arg_388_1.actors_[var_391_9.prefab_name] ~= nil then
						local var_391_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_9.prefab_name].transform, "story_v_out_323011", "323011093", "story_v_out_323011.awb")

						arg_388_1:RecordAudio("323011093", var_391_14)
						arg_388_1:RecordAudio("323011093", var_391_14)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_323011", "323011093", "story_v_out_323011.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_323011", "323011093", "story_v_out_323011.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_15 = math.max(var_391_8, arg_388_1.talkMaxDuration)

			if var_391_7 <= arg_388_1.time_ and arg_388_1.time_ < var_391_7 + var_391_15 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_7) / var_391_15

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_7 + var_391_15 and arg_388_1.time_ < var_391_7 + var_391_15 + arg_391_0 then
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
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["10163ui_story"]) and arg_393_1.var_.characterEffect10163ui_story == nil then
				arg_393_1.var_.characterEffect10163ui_story = arg_393_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["10163ui_story"]) then
				if arg_393_1.var_.characterEffect10163ui_story and not isNil(arg_393_1.actors_["10163ui_story"]) then
					arg_393_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_393_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_0)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["10163ui_story"]) and arg_393_1.var_.characterEffect10163ui_story then
				arg_393_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_393_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			local var_396_1 = 0
			local var_396_2 = 0.925

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_3 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(323011094).content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 37 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 37)

				if (37 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 37)) > 0 and var_396_2 < var_396_5 then
					arg_393_1.talkMaxDuration = var_396_5

					if var_396_5 + var_396_1 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + var_396_1
					end
				end

				arg_393_1.text_.text = var_396_3
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_6 = math.max(var_396_2, arg_393_1.talkMaxDuration)

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_6 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_1) / var_396_6

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_1 + var_396_6 and arg_393_1.time_ < var_396_1 + var_396_6 + arg_396_0 then
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
			local var_400_0 = 0.9

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_1 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(323011095).content)

				arg_397_1.text_.text = var_400_1

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_3 = 36 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 36)

				if (36 <= 0 and var_400_0 or var_400_0 * (utf8.len(var_400_1) / 36)) > 0 and var_400_0 < var_400_3 then
					arg_397_1.talkMaxDuration = var_400_3

					if var_400_3 + 0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_3 + 0
					end
				end

				arg_397_1.text_.text = var_400_1
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_4 = math.max(var_400_0, arg_397_1.talkMaxDuration)

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - 0) / var_400_4

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
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
			local var_404_0 = 0.9

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(323011096).content)

				arg_401_1.text_.text = var_404_1

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_3 = 36 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 36)

				if (36 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_1) / 36)) > 0 and var_404_0 < var_404_3 then
					arg_401_1.talkMaxDuration = var_404_3

					if var_404_3 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_3 + 0
					end
				end

				arg_401_1.text_.text = var_404_1
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_4 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_4 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_4

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_4 and arg_401_1.time_ < 0 + var_404_4 + arg_404_0 then
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
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(arg_405_1.actors_["10163ui_story"]) and arg_405_1.var_.characterEffect10163ui_story == nil then
				arg_405_1.var_.characterEffect10163ui_story = arg_405_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_0 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 and not isNil(arg_405_1.actors_["10163ui_story"]) then
				if arg_405_1.var_.characterEffect10163ui_story and not isNil(arg_405_1.actors_["10163ui_story"]) then
					arg_405_1.var_.characterEffect10163ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 and not isNil(arg_405_1.actors_["10163ui_story"]) and arg_405_1.var_.characterEffect10163ui_story then
				arg_405_1.var_.characterEffect10163ui_story.fillFlat = false
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.cswbg_:SetActive(true)

				local var_408_2 = arg_405_1.cswt_:GetComponent("RectTransform")

				arg_405_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_408_2.offsetMin = Vector2.New(400, -200)
				var_408_2.offsetMax = Vector2.New(-400, -262.5)
				arg_405_1.cswt_.text = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(419177).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.cswt_)

				arg_405_1.cswt_.fontSize = 108
				arg_405_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_405_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_405_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.fswbg_:SetActive(true)
				arg_405_1.dialog_:SetActive(false)

				arg_405_1.fswtw_.percent = 0
				arg_405_1.fswt_.text = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(323011097).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.fswt_)

				arg_405_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_405_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_405_1.fswtw_:SetDirty()

				arg_405_1.typewritterCharCountI18N = 0

				SetActive(arg_405_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_405_1:ShowNextGo(false)
			end

			local var_408_3 = 0.766666666666667

			if 0.766666666666667 < arg_405_1.time_ and arg_405_1.time_ <= var_408_3 + arg_408_0 then
				arg_405_1.var_.oldValueTypewriter = arg_405_1.fswtw_.percent

				SetActive(arg_405_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_405_1:ShowNextGo(false)
			end

			local var_408_4 = 5
			local var_408_5 = 0.333333333333333
			local var_408_6, var_408_7 = arg_405_1:GetPercentByPara(arg_405_1:FormatText(arg_405_1:GetWordFromCfg(323011097).content), 1)

			if var_408_3 < arg_405_1.time_ and arg_405_1.time_ <= var_408_3 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0

				local var_408_8 = var_408_4 <= 0 and var_408_5 or var_408_5 * ((var_408_7 - arg_405_1.typewritterCharCountI18N) / var_408_4)

				if (var_408_4 <= 0 and var_408_5 or var_408_5 * ((var_408_7 - arg_405_1.typewritterCharCountI18N) / var_408_4)) > 0 and var_408_5 < var_408_8 then
					arg_405_1.talkMaxDuration = var_408_8

					if var_408_8 + var_408_3 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_8 + var_408_3
					end
				end
			end

			local var_408_9 = math.max(0.333333333333333, arg_405_1.talkMaxDuration)

			if var_408_3 <= arg_405_1.time_ and arg_405_1.time_ < var_408_3 + var_408_9 then
				arg_405_1.fswtw_.percent = Mathf.Lerp(arg_405_1.var_.oldValueTypewriter, var_408_6, (arg_405_1.time_ - var_408_3) / var_408_9)
				arg_405_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_405_1.fswtw_:SetDirty()
			end

			if arg_405_1.time_ >= var_408_3 + var_408_9 and arg_405_1.time_ < var_408_3 + var_408_9 + arg_408_0 then
				arg_405_1.fswtw_.percent = var_408_6

				arg_405_1.fswtw_:SetDirty()
				arg_405_1:ShowNextGo(true)

				arg_405_1.typewritterCharCountI18N = var_408_7
			end

			if 0.682114500552416 < arg_405_1.time_ and arg_405_1.time_ <= 0.682114500552416 + arg_408_0 then
				arg_405_1:AudioAction("play", "effect", "se_story_148", "se_story_148_bell_temple_china02", "")
			end

			local var_408_11 = 0.766666666666667
			local var_408_12 = manager.audio:GetVoiceLength("story_v_out_323011", "323011097", "0") / 1000

			if var_408_12 > 0 and 1 < var_408_12 and var_408_12 + var_408_11 > arg_405_1.duration_ then
				arg_405_1.duration_ = var_408_12 + var_408_11
			end

			if var_408_11 < arg_405_1.time_ and arg_405_1.time_ <= var_408_11 + arg_408_0 then
				arg_405_1:AudioAction("play", "voice", "story_v_out_323011", "323011097", "0")
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
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["10163ui_story"]) and arg_409_1.var_.characterEffect10163ui_story == nil then
				arg_409_1.var_.characterEffect10163ui_story = arg_409_1.actors_["10163ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["10163ui_story"]) then
				if arg_409_1.var_.characterEffect10163ui_story and not isNil(arg_409_1.actors_["10163ui_story"]) then
					arg_409_1.var_.characterEffect10163ui_story.fillFlat = true
					arg_409_1.var_.characterEffect10163ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_0)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["10163ui_story"]) and arg_409_1.var_.characterEffect10163ui_story then
				arg_409_1.var_.characterEffect10163ui_story.fillFlat = true
				arg_409_1.var_.characterEffect10163ui_story.fillRatio = 0.5
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.fswbg_:SetActive(false)
				arg_409_1.dialog_:SetActive(false)
				SetActive(arg_409_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_409_1:ShowNextGo(false)
			end

			if 0.0166666666666667 < arg_409_1.time_ and arg_409_1.time_ <= 0.0166666666666667 + arg_412_0 then
				arg_409_1.fswbg_:SetActive(false)
				arg_409_1.dialog_:SetActive(false)
				SetActive(arg_409_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_409_1:ShowNextGo(false)
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.cswbg_:SetActive(false)
			end

			if arg_409_1.frameCnt_ <= 1 then
				arg_409_1.dialog_:SetActive(false)
			end

			local var_412_1 = 0.200000002980232
			local var_412_2 = 0.95

			if 0.200000002980232 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0

				arg_409_1.dialog_:SetActive(true)

				arg_409_1.dialogCg_.alpha = 0

				local var_412_3 = LeanTween.value(arg_409_1.dialog_, 0, 1, 0.3)

				var_412_3:setOnUpdate(LuaHelper.FloatAction(function(arg_413_0)
					arg_409_1.dialogCg_.alpha = arg_413_0
				end))
				var_412_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_409_1.dialog_)
					var_412_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_409_1.duration_ = arg_409_1.duration_ + 0.3

				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_4 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(323011098).content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_6 = 38 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_4) / 38)

				if (38 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_4) / 38)) > 0 and var_412_2 < var_412_6 then
					arg_409_1.talkMaxDuration = var_412_6
					var_412_1 = var_412_1 + 0.3

					if var_412_6 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_6 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_7 = var_412_1 + 0.3
			local var_412_8 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 + 0.3 <= arg_409_1.time_ and arg_409_1.time_ < var_412_7 + var_412_8 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_7) / var_412_8

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_7 + var_412_8 and arg_409_1.time_ < var_412_7 + var_412_8 + arg_412_0 then
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
			if 1.36666666666667 < arg_415_1.time_ and arg_415_1.time_ <= 1.36666666666667 + arg_418_0 then
				local var_418_0 = arg_415_1.bgs_.STblack

				arg_415_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_418_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_418_1 = var_418_0:GetComponent("SpriteRenderer")

				if var_418_1 and var_418_1.sprite then
					local var_418_2 = 2 * (var_418_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_418_0.transform.localScale = Vector3.New(var_418_2 / var_418_1.sprite.bounds.size.y < var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x and var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x or var_418_2 / var_418_1.sprite.bounds.size.y, var_418_2 / var_418_1.sprite.bounds.size.y < var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x and var_418_2 * manager.ui.mainCameraCom_.aspect / var_418_1.sprite.bounds.size.x or var_418_2 / var_418_1.sprite.bounds.size.y, 0)
				end

				for iter_418_0, iter_418_1 in pairs(arg_415_1.bgs_) do
					if iter_418_0 ~= "STblack" then
						iter_418_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_418_3 = 0

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_3 + arg_418_0 then
				arg_415_1.allBtn_.enabled = false
			end

			if arg_415_1.time_ >= var_418_3 + 0.3 and arg_415_1.time_ < var_418_3 + 0.3 + arg_418_0 then
				arg_415_1.allBtn_.enabled = true
			end

			local var_418_4 = 0

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_5 = 1.36666666666667

			if var_418_4 <= arg_415_1.time_ and arg_415_1.time_ < var_418_4 + var_418_5 then
				local var_418_6 = Color.New(0, 0, 0)

				var_418_6.a = Mathf.Lerp(0, 1, (arg_415_1.time_ - var_418_4) / var_418_5)
				arg_415_1.mask_.color = var_418_6
			end

			if arg_415_1.time_ >= var_418_4 + var_418_5 and arg_415_1.time_ < var_418_4 + var_418_5 + arg_418_0 then
				local var_418_7 = Color.New(0, 0, 0)

				var_418_7.a = 1
				arg_415_1.mask_.color = var_418_7
			end

			local var_418_8 = 1.36666666666667

			if 1.36666666666667 < arg_415_1.time_ and arg_415_1.time_ <= var_418_8 + arg_418_0 then
				arg_415_1.mask_.enabled = true
				arg_415_1.mask_.raycastTarget = true

				arg_415_1:SetGaussion(false)
			end

			local var_418_9 = 1.5

			if var_418_8 <= arg_415_1.time_ and arg_415_1.time_ < var_418_8 + var_418_9 then
				local var_418_10 = Color.New(0, 0, 0)

				var_418_10.a = Mathf.Lerp(1, 0, (arg_415_1.time_ - var_418_8) / var_418_9)
				arg_415_1.mask_.color = var_418_10
			end

			if arg_415_1.time_ >= var_418_8 + var_418_9 and arg_415_1.time_ < var_418_8 + var_418_9 + arg_418_0 then
				local var_418_11 = Color.New(0, 0, 0)

				arg_415_1.mask_.enabled = false
				var_418_11.a = 0
				arg_415_1.mask_.color = var_418_11
			end

			if 0.3 < arg_415_1.time_ and arg_415_1.time_ <= 0.3 + arg_418_0 then
				arg_415_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_418_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_415_1.bgmTxt_.text ~= var_418_14 and arg_415_1.bgmTxt_.text ~= "" then
						if arg_415_1.bgmTxt2_.text ~= "" then
							arg_415_1.bgmTxt_.text = arg_415_1.bgmTxt2_.text
						end

						arg_415_1.bgmTxt2_.text = var_418_14

						arg_415_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_415_1.bgmTxt_.text = var_418_14
						arg_415_1.bgmTxt2_.text = var_418_14
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

			local var_418_15 = 2.5
			local var_418_16 = 0.1

			if 2.5 < arg_415_1.time_ and arg_415_1.time_ <= var_418_15 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0

				arg_415_1.dialog_:SetActive(true)

				arg_415_1.dialogCg_.alpha = 0

				local var_418_17 = LeanTween.value(arg_415_1.dialog_, 0, 1, 0.3)

				var_418_17:setOnUpdate(LuaHelper.FloatAction(function(arg_420_0)
					arg_415_1.dialogCg_.alpha = arg_420_0
				end))
				var_418_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_415_1.dialog_)
					var_418_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_415_1.duration_ = arg_415_1.duration_ + 0.3

				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[7].name)

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

				local var_418_18 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(323011099).content)

				arg_415_1.text_.text = var_418_18

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_20 = 2 <= 0 and var_418_16 or var_418_16 * (utf8.len(var_418_18) / 2)

				if (2 <= 0 and var_418_16 or var_418_16 * (utf8.len(var_418_18) / 2)) > 0 and var_418_16 < var_418_20 then
					arg_415_1.talkMaxDuration = var_418_20
					var_418_15 = var_418_15 + 0.3

					if var_418_20 + var_418_15 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_20 + var_418_15
					end
				end

				arg_415_1.text_.text = var_418_18
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_21 = var_418_15 + 0.3
			local var_418_22 = math.max(var_418_16, arg_415_1.talkMaxDuration)

			if var_418_15 + 0.3 <= arg_415_1.time_ and arg_415_1.time_ < var_418_21 + var_418_22 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_21) / var_418_22

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_21 + var_418_22 and arg_415_1.time_ < var_418_21 + var_418_22 + arg_418_0 then
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
			if arg_422_1.actors_["1071ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1071ui_story"))) then
				local var_425_0 = Object.Instantiate(Asset.Load("Char/" .. "1071ui_story"), arg_422_1.stage_.transform)

				var_425_0.name = "1071ui_story"
				var_425_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_422_1.actors_["1071ui_story"] = var_425_0

				local var_425_1 = var_425_0:GetComponentInChildren(typeof(CharacterEffect))

				var_425_1.enabled = true

				local var_425_2 = GameObjectTools.GetOrAddComponent(var_425_0, typeof(DynamicBoneHelper))

				if var_425_2 then
					var_425_2:EnableDynamicBone(false)
				end

				arg_422_1:ShowWeapon(var_425_1.transform, false)

				arg_422_1.var_["1071ui_story" .. "Animator"] = var_425_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_422_1.var_["1071ui_story" .. "Animator"].applyRootMotion = true
				arg_422_1.var_["1071ui_story" .. "LipSync"] = var_425_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_425_3 = arg_422_1.actors_["1071ui_story"]

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(var_425_3) and arg_422_1.var_.characterEffect1071ui_story == nil then
				arg_422_1.var_.characterEffect1071ui_story = var_425_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_4 = 0.200000002980232

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_4 and not isNil(var_425_3) then
				if arg_422_1.var_.characterEffect1071ui_story and not isNil(var_425_3) then
					arg_422_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_422_1.time_ >= 0 + var_425_4 and arg_422_1.time_ < 0 + var_425_4 + arg_425_0 and not isNil(var_425_3) and arg_422_1.var_.characterEffect1071ui_story then
				arg_422_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_425_6 = 0
			local var_425_7 = 0.225

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_6 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[384].name)

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

				local var_425_8 = arg_422_1:GetWordFromCfg(323011100)
				local var_425_9 = arg_422_1:FormatText(var_425_8.content)

				arg_422_1.text_.text = var_425_9

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_11 = 9 <= 0 and var_425_7 or var_425_7 * (utf8.len(var_425_9) / 9)

				if (9 <= 0 and var_425_7 or var_425_7 * (utf8.len(var_425_9) / 9)) > 0 and var_425_7 < var_425_11 then
					arg_422_1.talkMaxDuration = var_425_11

					if var_425_11 + var_425_6 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_11 + var_425_6
					end
				end

				arg_422_1.text_.text = var_425_9
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011100", "story_v_out_323011.awb") ~= 0 then
					local var_425_12 = manager.audio:GetVoiceLength("story_v_out_323011", "323011100", "story_v_out_323011.awb") / 1000

					if var_425_12 + var_425_6 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_12 + var_425_6
					end

					if var_425_8.prefab_name ~= "" and arg_422_1.actors_[var_425_8.prefab_name] ~= nil then
						local var_425_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_8.prefab_name].transform, "story_v_out_323011", "323011100", "story_v_out_323011.awb")

						arg_422_1:RecordAudio("323011100", var_425_13)
						arg_422_1:RecordAudio("323011100", var_425_13)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_323011", "323011100", "story_v_out_323011.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_323011", "323011100", "story_v_out_323011.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_14 = math.max(var_425_7, arg_422_1.talkMaxDuration)

			if var_425_6 <= arg_422_1.time_ and arg_422_1.time_ < var_425_6 + var_425_14 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_6) / var_425_14

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_6 + var_425_14 and arg_422_1.time_ < var_425_6 + var_425_14 + arg_425_0 then
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
			if arg_426_1.bgs_.J13f == nil then
				local var_429_0 = Object.Instantiate(arg_426_1.paintGo_)

				var_429_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J13f")
				var_429_0.name = "J13f"
				var_429_0.transform.parent = arg_426_1.stage_.transform
				var_429_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_426_1.bgs_.J13f = var_429_0
			end

			if 1 < arg_426_1.time_ and arg_426_1.time_ <= 1 + arg_429_0 then
				local var_429_1 = arg_426_1.bgs_.J13f

				arg_426_1.bgs_.J13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_429_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_429_2 = var_429_1:GetComponent("SpriteRenderer")

				if var_429_2 and var_429_2.sprite then
					local var_429_3 = 2 * (var_429_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_429_1.transform.localScale = Vector3.New(var_429_3 / var_429_2.sprite.bounds.size.y < var_429_3 * manager.ui.mainCameraCom_.aspect / var_429_2.sprite.bounds.size.x and var_429_3 * manager.ui.mainCameraCom_.aspect / var_429_2.sprite.bounds.size.x or var_429_3 / var_429_2.sprite.bounds.size.y, var_429_3 / var_429_2.sprite.bounds.size.y < var_429_3 * manager.ui.mainCameraCom_.aspect / var_429_2.sprite.bounds.size.x and var_429_3 * manager.ui.mainCameraCom_.aspect / var_429_2.sprite.bounds.size.x or var_429_3 / var_429_2.sprite.bounds.size.y, 0)
				end

				for iter_429_0, iter_429_1 in pairs(arg_426_1.bgs_) do
					if iter_429_0 ~= "J13f" then
						iter_429_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_429_4 = 0

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_4 + arg_429_0 then
				arg_426_1.allBtn_.enabled = false
			end

			if arg_426_1.time_ >= var_429_4 + 0.3 and arg_426_1.time_ < var_429_4 + 0.3 + arg_429_0 then
				arg_426_1.allBtn_.enabled = true
			end

			local var_429_5 = 0

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_5 + arg_429_0 then
				arg_426_1.mask_.enabled = true
				arg_426_1.mask_.raycastTarget = true

				arg_426_1:SetGaussion(false)
			end

			local var_429_6 = 1

			if var_429_5 <= arg_426_1.time_ and arg_426_1.time_ < var_429_5 + var_429_6 then
				local var_429_7 = Color.New(0, 0, 0)

				var_429_7.a = Mathf.Lerp(0, 1, (arg_426_1.time_ - var_429_5) / var_429_6)
				arg_426_1.mask_.color = var_429_7
			end

			if arg_426_1.time_ >= var_429_5 + var_429_6 and arg_426_1.time_ < var_429_5 + var_429_6 + arg_429_0 then
				local var_429_8 = Color.New(0, 0, 0)

				var_429_8.a = 1
				arg_426_1.mask_.color = var_429_8
			end

			local var_429_9 = 0.975

			if 0.975 < arg_426_1.time_ and arg_426_1.time_ <= var_429_9 + arg_429_0 then
				arg_426_1.mask_.enabled = true
				arg_426_1.mask_.raycastTarget = true

				arg_426_1:SetGaussion(false)
			end

			local var_429_10 = 1.96666666666667

			if var_429_9 <= arg_426_1.time_ and arg_426_1.time_ < var_429_9 + var_429_10 then
				local var_429_11 = Color.New(0, 0, 0)

				var_429_11.a = Mathf.Lerp(1, 0, (arg_426_1.time_ - var_429_9) / var_429_10)
				arg_426_1.mask_.color = var_429_11
			end

			if arg_426_1.time_ >= var_429_9 + var_429_10 and arg_426_1.time_ < var_429_9 + var_429_10 + arg_429_0 then
				local var_429_12 = Color.New(0, 0, 0)

				arg_426_1.mask_.enabled = false
				var_429_12.a = 0
				arg_426_1.mask_.color = var_429_12
			end

			local var_429_13 = arg_426_1.actors_["1071ui_story"]

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(var_429_13) and arg_426_1.var_.characterEffect1071ui_story == nil then
				arg_426_1.var_.characterEffect1071ui_story = var_429_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_14 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_14 and not isNil(var_429_13) then
				if arg_426_1.var_.characterEffect1071ui_story and not isNil(var_429_13) then
					arg_426_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_426_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_426_1.time_ - 0) / var_429_14)
				end
			end

			if arg_426_1.time_ >= 0 + var_429_14 and arg_426_1.time_ < 0 + var_429_14 + arg_429_0 and not isNil(var_429_13) and arg_426_1.var_.characterEffect1071ui_story then
				arg_426_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_426_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_426_1.time_ and arg_426_1.time_ <= 0.1 + arg_429_0 then
				arg_426_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 0.7 < arg_426_1.time_ and arg_426_1.time_ <= 0.7 + arg_429_0 then
				arg_426_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind", "")
			end

			if arg_426_1.frameCnt_ <= 1 then
				arg_426_1.dialog_:SetActive(false)
			end

			local var_429_17 = 2.66666666666667
			local var_429_18 = 0.975

			if 2.66666666666667 < arg_426_1.time_ and arg_426_1.time_ <= var_429_17 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0

				arg_426_1.dialog_:SetActive(true)

				arg_426_1.dialogCg_.alpha = 0

				local var_429_19 = LeanTween.value(arg_426_1.dialog_, 0, 1, 0.3)

				var_429_19:setOnUpdate(LuaHelper.FloatAction(function(arg_430_0)
					arg_426_1.dialogCg_.alpha = arg_430_0
				end))
				var_429_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_426_1.dialog_)
					var_429_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_426_1.duration_ = arg_426_1.duration_ + 0.3

				SetActive(arg_426_1.leftNameGo_, false)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_20 = arg_426_1:FormatText(arg_426_1:GetWordFromCfg(323011101).content)

				arg_426_1.text_.text = var_429_20

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_22 = 39 <= 0 and var_429_18 or var_429_18 * (utf8.len(var_429_20) / 39)

				if (39 <= 0 and var_429_18 or var_429_18 * (utf8.len(var_429_20) / 39)) > 0 and var_429_18 < var_429_22 then
					arg_426_1.talkMaxDuration = var_429_22
					var_429_17 = var_429_17 + 0.3

					if var_429_22 + var_429_17 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_22 + var_429_17
					end
				end

				arg_426_1.text_.text = var_429_20
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)
				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_23 = var_429_17 + 0.3
			local var_429_24 = math.max(var_429_18, arg_426_1.talkMaxDuration)

			if var_429_17 + 0.3 <= arg_426_1.time_ and arg_426_1.time_ < var_429_23 + var_429_24 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_23) / var_429_24

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_23 + var_429_24 and arg_426_1.time_ < var_429_23 + var_429_24 + arg_429_0 then
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
			local var_435_0 = 1.45

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_1 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(323011102).content)

				arg_432_1.text_.text = var_435_1

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_3 = 58 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 58)

				if (58 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 58)) > 0 and var_435_0 < var_435_3 then
					arg_432_1.talkMaxDuration = var_435_3

					if var_435_3 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_3 + 0
					end
				end

				arg_432_1.text_.text = var_435_1
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_4 = math.max(var_435_0, arg_432_1.talkMaxDuration)

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_4 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - 0) / var_435_4

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= 0 + var_435_4 and arg_432_1.time_ < 0 + var_435_4 + arg_435_0 then
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
			local var_439_0 = 0.45

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_1 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(323011103).content)

				arg_436_1.text_.text = var_439_1

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_3 = 18 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_1) / 18)

				if (18 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_1) / 18)) > 0 and var_439_0 < var_439_3 then
					arg_436_1.talkMaxDuration = var_439_3

					if var_439_3 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_3 + 0
					end
				end

				arg_436_1.text_.text = var_439_1
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_4 = math.max(var_439_0, arg_436_1.talkMaxDuration)

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_4 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - 0) / var_439_4

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= 0 + var_439_4 and arg_436_1.time_ < 0 + var_439_4 + arg_439_0 then
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
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(arg_440_1.actors_["1071ui_story"]) and arg_440_1.var_.characterEffect1071ui_story == nil then
				arg_440_1.var_.characterEffect1071ui_story = arg_440_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_0 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 and not isNil(arg_440_1.actors_["1071ui_story"]) then
				if arg_440_1.var_.characterEffect1071ui_story and not isNil(arg_440_1.actors_["1071ui_story"]) then
					arg_440_1.var_.characterEffect1071ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 and not isNil(arg_440_1.actors_["1071ui_story"]) and arg_440_1.var_.characterEffect1071ui_story then
				arg_440_1.var_.characterEffect1071ui_story.fillFlat = false
			end

			local var_443_2 = 0
			local var_443_3 = 0.1

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_2 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[384].name)

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

				local var_443_4 = arg_440_1:GetWordFromCfg(323011104)
				local var_443_5 = arg_440_1:FormatText(var_443_4.content)

				arg_440_1.text_.text = var_443_5

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_7 = 4 <= 0 and var_443_3 or var_443_3 * (utf8.len(var_443_5) / 4)

				if (4 <= 0 and var_443_3 or var_443_3 * (utf8.len(var_443_5) / 4)) > 0 and var_443_3 < var_443_7 then
					arg_440_1.talkMaxDuration = var_443_7

					if var_443_7 + var_443_2 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_7 + var_443_2
					end
				end

				arg_440_1.text_.text = var_443_5
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323011", "323011104", "story_v_out_323011.awb") ~= 0 then
					local var_443_8 = manager.audio:GetVoiceLength("story_v_out_323011", "323011104", "story_v_out_323011.awb") / 1000

					if var_443_8 + var_443_2 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_8 + var_443_2
					end

					if var_443_4.prefab_name ~= "" and arg_440_1.actors_[var_443_4.prefab_name] ~= nil then
						local var_443_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_4.prefab_name].transform, "story_v_out_323011", "323011104", "story_v_out_323011.awb")

						arg_440_1:RecordAudio("323011104", var_443_9)
						arg_440_1:RecordAudio("323011104", var_443_9)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_323011", "323011104", "story_v_out_323011.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_323011", "323011104", "story_v_out_323011.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_10 = math.max(var_443_3, arg_440_1.talkMaxDuration)

			if var_443_2 <= arg_440_1.time_ and arg_440_1.time_ < var_443_2 + var_443_10 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_2) / var_443_10

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_2 + var_443_10 and arg_440_1.time_ < var_443_2 + var_443_10 + arg_443_0 then
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
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(arg_444_1.actors_["1071ui_story"]) and arg_444_1.var_.characterEffect1071ui_story == nil then
				arg_444_1.var_.characterEffect1071ui_story = arg_444_1.actors_["1071ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_0 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 and not isNil(arg_444_1.actors_["1071ui_story"]) then
				if arg_444_1.var_.characterEffect1071ui_story and not isNil(arg_444_1.actors_["1071ui_story"]) then
					arg_444_1.var_.characterEffect1071ui_story.fillFlat = true
					arg_444_1.var_.characterEffect1071ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_444_1.time_ - 0) / var_447_0)
				end
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 and not isNil(arg_444_1.actors_["1071ui_story"]) and arg_444_1.var_.characterEffect1071ui_story then
				arg_444_1.var_.characterEffect1071ui_story.fillFlat = true
				arg_444_1.var_.characterEffect1071ui_story.fillRatio = 0.5
			end

			local var_447_1 = 0
			local var_447_2 = 0.2

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[7].name)

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

				local var_447_3 = arg_444_1:FormatText(arg_444_1:GetWordFromCfg(323011105).content)

				arg_444_1.text_.text = var_447_3

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_5 = 8 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_3) / 8)

				if (8 <= 0 and var_447_2 or var_447_2 * (utf8.len(var_447_3) / 8)) > 0 and var_447_2 < var_447_5 then
					arg_444_1.talkMaxDuration = var_447_5

					if var_447_5 + var_447_1 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_5 + var_447_1
					end
				end

				arg_444_1.text_.text = var_447_3
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_6 = math.max(var_447_2, arg_444_1.talkMaxDuration)

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_6 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_1) / var_447_6

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_1 + var_447_6 and arg_444_1.time_ < var_447_1 + var_447_6 + arg_447_0 then
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
			local var_451_0 = 0.8

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, false)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_1 = arg_448_1:FormatText(arg_448_1:GetWordFromCfg(323011106).content)

				arg_448_1.text_.text = var_451_1

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_3 = 32 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_1) / 32)

				if (32 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_1) / 32)) > 0 and var_451_0 < var_451_3 then
					arg_448_1.talkMaxDuration = var_451_3

					if var_451_3 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_3 + 0
					end
				end

				arg_448_1.text_.text = var_451_1
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)
				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_4 = math.max(var_451_0, arg_448_1.talkMaxDuration)

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_4 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - 0) / var_451_4

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= 0 + var_451_4 and arg_448_1.time_ < 0 + var_451_4 + arg_451_0 then
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
