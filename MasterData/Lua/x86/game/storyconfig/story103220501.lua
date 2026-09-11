return {
	Play322051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9002
			local var_4_9001
			local var_4_9000

			if arg_1_1.bgs_.L10b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10b")
				var_4_0.name = "L10b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L10b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L10b

				arg_1_1.bgs_.L10b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L10b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 1.2 and arg_1_1.time_ < var_4_4 + 1.2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
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

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_4_14 = 0

			arg_1_1.isInRecall_ = false

			if var_4_14 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_blue.asset")

				for iter_4_2, iter_4_3 in pairs(arg_1_1.actors_) do
					for iter_4_4, iter_4_5 in ipairs((iter_4_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_4_5.color = iter_4_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_4_15 = 0.0166666666666667

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_14) / var_4_15)
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_16 = arg_1_1.var_.effect1021

				if not arg_1_1.var_.effect1021 then
					var_4_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), manager.ui.mainCamera.transform)
					var_4_16.name = "1021"
					arg_1_1.var_.effect1021 = var_4_16
				else
					var_4_16.transform:SetParent(var_4_9002)
				end

				var_4_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_16.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_18 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_4_19 = var_4_16.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_4_6, iter_4_7 in ipairs((var_4_19:ToTable())) do
					iter_4_7.transform.localScale = Vector3.New(iter_4_7.transform.localScale.x / var_4_18 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_4_19 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_4_7.transform.localScale.y / var_4_18, iter_4_7.transform.localScale.z)
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_21 = arg_1_1.var_.effect10012

				if not arg_1_1.var_.effect10012 then
					var_4_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_monitor"), manager.ui.mainCamera.transform)
					var_4_21.name = "10012"
					arg_1_1.var_.effect10012 = var_4_21
				else
					var_4_21.transform:SetParent(var_4_9001)
				end

				var_4_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_21.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_23 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_4_24 = var_4_21.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_4_8, iter_4_9 in ipairs((var_4_24:ToTable())) do
					iter_4_9.transform.localScale = Vector3.New(iter_4_9.transform.localScale.x / var_4_23 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_4_24 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_4_9.transform.localScale.y / var_4_23, iter_4_9.transform.localScale.z)
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_26 = arg_1_1.var_.effect10013

				if not arg_1_1.var_.effect10013 then
					var_4_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), manager.ui.mainCamera.transform)
					var_4_26.name = "10013"
					arg_1_1.var_.effect10013 = var_4_26
				else
					var_4_26.transform:SetParent(var_4_9000)
				end

				var_4_26.transform.localPosition = Vector3.New(0, 0, -1.17)
				var_4_26.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_28 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_4_29 = var_4_26.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_4_10, iter_4_11 in ipairs((var_4_29:ToTable())) do
					iter_4_11.transform.localScale = Vector3.New(iter_4_11.transform.localScale.x / var_4_28 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_4_29 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_4_11.transform.localScale.y / var_4_28, iter_4_11.transform.localScale.z)
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire04_loop", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_32 = 2
			local var_4_33 = 1.45

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_34 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_34:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_35 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(322051001).content)

				arg_1_1.text_.text = var_4_35

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_37 = 58 <= 0 and var_4_33 or var_4_33 * (utf8.len(var_4_35) / 58)

				if (58 <= 0 and var_4_33 or var_4_33 * (utf8.len(var_4_35) / 58)) > 0 and var_4_33 < var_4_37 then
					arg_1_1.talkMaxDuration = var_4_37
					var_4_32 = var_4_32 + 0.3

					if var_4_37 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_32
					end
				end

				arg_1_1.text_.text = var_4_35
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_38 = var_4_32 + 0.3
			local var_4_39 = math.max(var_4_33, arg_1_1.talkMaxDuration)

			if var_4_32 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_39 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_38) / var_4_39

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play322051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 322051002
		arg_8_1.duration_ = 6.99

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play322051003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_0 = 1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 then
				local var_11_1 = Color.New(0, 0, 0)

				var_11_1.a = Mathf.Lerp(0, 1, (arg_8_1.time_ - 0) / var_11_0)
				arg_8_1.mask_.color = var_11_1
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 then
				local var_11_2 = Color.New(0, 0, 0)

				var_11_2.a = 1
				arg_8_1.mask_.color = var_11_2
			end

			local var_11_3 = 1

			if 1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_3 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_4 = 0.991666666666667

			if var_11_3 <= arg_8_1.time_ and arg_8_1.time_ < var_11_3 + var_11_4 then
				local var_11_5 = Color.New(0, 0, 0)

				var_11_5.a = Mathf.Lerp(1, 0, (arg_8_1.time_ - var_11_3) / var_11_4)
				arg_8_1.mask_.color = var_11_5
			end

			if arg_8_1.time_ >= var_11_3 + var_11_4 and arg_8_1.time_ < var_11_3 + var_11_4 + arg_11_0 then
				local var_11_6 = Color.New(0, 0, 0)

				arg_8_1.mask_.enabled = false
				var_11_6.a = 0
				arg_8_1.mask_.color = var_11_6
			end

			local var_11_7 = "ST2102a"

			if arg_8_1.bgs_.ST2102a == nil then
				local var_11_8 = Object.Instantiate(arg_8_1.paintGo_)

				var_11_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_11_7)
				var_11_8.name = var_11_7
				var_11_8.transform.parent = arg_8_1.stage_.transform
				var_11_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.bgs_[var_11_7] = var_11_8
			end

			if 1 < arg_8_1.time_ and arg_8_1.time_ <= 1 + arg_11_0 then
				local var_11_9 = arg_8_1.bgs_.ST2102a

				arg_8_1.bgs_.ST2102a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_11_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_11_10 = var_11_9:GetComponent("SpriteRenderer")

				if var_11_10 and var_11_10.sprite then
					local var_11_11 = 2 * (var_11_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_11_9.transform.localScale = Vector3.New(var_11_11 / var_11_10.sprite.bounds.size.y < var_11_11 * manager.ui.mainCameraCom_.aspect / var_11_10.sprite.bounds.size.x and var_11_11 * manager.ui.mainCameraCom_.aspect / var_11_10.sprite.bounds.size.x or var_11_11 / var_11_10.sprite.bounds.size.y, var_11_11 / var_11_10.sprite.bounds.size.y < var_11_11 * manager.ui.mainCameraCom_.aspect / var_11_10.sprite.bounds.size.x and var_11_11 * manager.ui.mainCameraCom_.aspect / var_11_10.sprite.bounds.size.x or var_11_11 / var_11_10.sprite.bounds.size.y, 0)
				end

				for iter_11_0, iter_11_1 in pairs(arg_8_1.bgs_) do
					if iter_11_0 ~= "ST2102a" then
						iter_11_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_11_12 = 1

			arg_8_1.isInRecall_ = false

			if var_11_12 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 then
				arg_8_1.screenFilterGo_:SetActive(false)

				for iter_11_2, iter_11_3 in pairs(arg_8_1.actors_) do
					for iter_11_4, iter_11_5 in ipairs((iter_11_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_11_5.color = iter_11_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_11_13 = 0.0166666666666667

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_13 then
				arg_8_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_8_1.time_ - var_11_12) / var_11_13)
			end

			if arg_8_1.time_ >= var_11_12 + var_11_13 and arg_8_1.time_ < var_11_12 + var_11_13 + arg_11_0 then
				arg_8_1.screenFilterEffect_.weight = 0
			end

			if 1 < arg_8_1.time_ and arg_8_1.time_ <= 1 + arg_11_0 then
				if arg_8_1.var_.effect1021 then
					Object.Destroy(arg_8_1.var_.effect1021)

					arg_8_1.var_.effect1021 = nil
				end
			end

			if 1 < arg_8_1.time_ and arg_8_1.time_ <= 1 + arg_11_0 then
				if arg_8_1.var_.effect10012 then
					Object.Destroy(arg_8_1.var_.effect10012)

					arg_8_1.var_.effect10012 = nil
				end
			end

			if 1 < arg_8_1.time_ and arg_8_1.time_ <= 1 + arg_11_0 then
				if arg_8_1.var_.effect10013 then
					Object.Destroy(arg_8_1.var_.effect10013)

					arg_8_1.var_.effect10013 = nil
				end
			end

			if 0.0166666666666665 < arg_8_1.time_ and arg_8_1.time_ <= 0.0166666666666665 + arg_11_0 then
				arg_8_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_fire04_loop", "")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_11_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_20 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_20

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_20
						arg_8_1.bgmTxt2_.text = var_11_20
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.7 < arg_8_1.time_ and arg_8_1.time_ <= 0.7 + arg_11_0 then
				arg_8_1:AudioAction("play", "music", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard.awb")

				local var_11_23 = manager.audio:GetAudioName("bgm_activity_3_10_story_yard", "bgm_activity_3_10_story_yard")

				if "" ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_23 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_23

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_23
						arg_8_1.bgmTxt2_.text = var_11_23
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_8_1.frameCnt_ <= 1 then
				arg_8_1.dialog_:SetActive(false)
			end

			local var_11_24 = 1.99166666666667
			local var_11_25 = 1.325

			if 1.99166666666667 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				arg_8_1.dialog_:SetActive(true)

				arg_8_1.dialogCg_.alpha = 0

				local var_11_26 = LeanTween.value(arg_8_1.dialog_, 0, 1, 0.3)

				var_11_26:setOnUpdate(LuaHelper.FloatAction(function(arg_14_0)
					arg_8_1.dialogCg_.alpha = arg_14_0
				end))
				var_11_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_8_1.dialog_)
					var_11_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_8_1.duration_ = arg_8_1.duration_ + 0.3

				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_27 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(322051002).content)

				arg_8_1.text_.text = var_11_27

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_29 = 53 <= 0 and var_11_25 or var_11_25 * (utf8.len(var_11_27) / 53)

				if (53 <= 0 and var_11_25 or var_11_25 * (utf8.len(var_11_27) / 53)) > 0 and var_11_25 < var_11_29 then
					arg_8_1.talkMaxDuration = var_11_29
					var_11_24 = var_11_24 + 0.3

					if var_11_29 + var_11_24 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_29 + var_11_24
					end
				end

				arg_8_1.text_.text = var_11_27
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_30 = var_11_24 + 0.3
			local var_11_31 = math.max(var_11_25, arg_8_1.talkMaxDuration)

			if var_11_24 + 0.3 <= arg_8_1.time_ and arg_8_1.time_ < var_11_30 + var_11_31 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_30) / var_11_31

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_30 + var_11_31 and arg_8_1.time_ < var_11_30 + var_11_31 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play322051003 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 322051003
		arg_16_1.duration_ = 1.5

		local var_16_0 = {
			zh = 1.033,
			ja = 1.5
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play322051004(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.1

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(322051003)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 4 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 4)

				if (4 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 4)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051003", "story_v_out_322051.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_322051", "322051003", "story_v_out_322051.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_322051", "322051003", "story_v_out_322051.awb")

						arg_16_1:RecordAudio("322051003", var_19_6)
						arg_16_1:RecordAudio("322051003", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_322051", "322051003", "story_v_out_322051.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_322051", "322051003", "story_v_out_322051.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play322051004 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 322051004
		arg_20_1.duration_ = 2

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play322051005(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["10049ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10049ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "10049ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "10049ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["10049ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["10049ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["10049ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["10049ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["10049ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos10049ui_story = var_23_3.localPosition

				local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_4 then
					var_23_4:EnableDynamicBone(false)
				end
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10049ui_story, Vector3.New(0, -1.13, -6), (arg_20_1.time_ - 0) / var_23_5)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(0, -1.13, -6)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles

				local var_23_6 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_6 then
					var_23_6:EnableDynamicBone(true)
				end
			end

			local var_23_7 = arg_20_1.actors_["10049ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect10049ui_story == nil then
				arg_20_1.var_.characterEffect10049ui_story = var_23_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_8 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 and not isNil(var_23_7) then
				if arg_20_1.var_.characterEffect10049ui_story and not isNil(var_23_7) then
					arg_20_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect10049ui_story then
				arg_20_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action1_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				if not isNil(arg_20_1.actors_["10049ui_story"]) then
					local var_23_10 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_23_10 then
						var_23_10:EnableDynamicBone(true)
					end
				end
			end

			local var_23_11 = 0
			local var_23_12 = 0.075

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_13 = arg_20_1:GetWordFromCfg(322051004)
				local var_23_14 = arg_20_1:FormatText(var_23_13.content)

				arg_20_1.text_.text = var_23_14

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_16 = 3 <= 0 and var_23_12 or var_23_12 * (utf8.len(var_23_14) / 3)

				if (3 <= 0 and var_23_12 or var_23_12 * (utf8.len(var_23_14) / 3)) > 0 and var_23_12 < var_23_16 then
					arg_20_1.talkMaxDuration = var_23_16

					if var_23_16 + var_23_11 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_11
					end
				end

				arg_20_1.text_.text = var_23_14
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051004", "story_v_out_322051.awb") ~= 0 then
					local var_23_17 = manager.audio:GetVoiceLength("story_v_out_322051", "322051004", "story_v_out_322051.awb") / 1000

					if var_23_17 + var_23_11 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_11
					end

					if var_23_13.prefab_name ~= "" and arg_20_1.actors_[var_23_13.prefab_name] ~= nil then
						local var_23_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_13.prefab_name].transform, "story_v_out_322051", "322051004", "story_v_out_322051.awb")

						arg_20_1:RecordAudio("322051004", var_23_18)
						arg_20_1:RecordAudio("322051004", var_23_18)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_322051", "322051004", "story_v_out_322051.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_322051", "322051004", "story_v_out_322051.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_19 = math.max(var_23_12, arg_20_1.talkMaxDuration)

			if var_23_11 <= arg_20_1.time_ and arg_20_1.time_ < var_23_11 + var_23_19 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_11) / var_23_19

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_11 + var_23_19 and arg_20_1.time_ < var_23_11 + var_23_19 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
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
	Play322051005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 322051005
		arg_24_1.duration_ = 10.9

		local var_24_0 = {
			zh = 9.366,
			ja = 10.9
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play322051006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.825

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:GetWordFromCfg(322051005)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 33 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 33)

				if (33 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 33)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051005", "story_v_out_322051.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_322051", "322051005", "story_v_out_322051.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_322051", "322051005", "story_v_out_322051.awb")

						arg_24_1:RecordAudio("322051005", var_27_6)
						arg_24_1:RecordAudio("322051005", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_322051", "322051005", "story_v_out_322051.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_322051", "322051005", "story_v_out_322051.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play322051006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 322051006
		arg_28_1.duration_ = 3.83

		local var_28_0 = {
			zh = 3.833,
			ja = 3.333
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
				arg_28_0:Play322051007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["10049ui_story"]) and arg_28_1.var_.characterEffect10049ui_story == nil then
				arg_28_1.var_.characterEffect10049ui_story = arg_28_1.actors_["10049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["10049ui_story"]) then
				if arg_28_1.var_.characterEffect10049ui_story and not isNil(arg_28_1.actors_["10049ui_story"]) then
					arg_28_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["10049ui_story"]) and arg_28_1.var_.characterEffect10049ui_story then
				arg_28_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10049ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.525

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:GetWordFromCfg(322051006)
				local var_31_4 = arg_28_1:FormatText(var_31_3.content)

				arg_28_1.text_.text = var_31_4

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_6 = 21 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_4) / 21)

				if (21 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_4) / 21)) > 0 and var_31_2 < var_31_6 then
					arg_28_1.talkMaxDuration = var_31_6

					if var_31_6 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_4
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051006", "story_v_out_322051.awb") ~= 0 then
					local var_31_7 = manager.audio:GetVoiceLength("story_v_out_322051", "322051006", "story_v_out_322051.awb") / 1000

					if var_31_7 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_1
					end

					if var_31_3.prefab_name ~= "" and arg_28_1.actors_[var_31_3.prefab_name] ~= nil then
						local var_31_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_3.prefab_name].transform, "story_v_out_322051", "322051006", "story_v_out_322051.awb")

						arg_28_1:RecordAudio("322051006", var_31_8)
						arg_28_1:RecordAudio("322051006", var_31_8)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_322051", "322051006", "story_v_out_322051.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_322051", "322051006", "story_v_out_322051.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_9 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_9 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_9

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_9 and arg_28_1.time_ < var_31_1 + var_31_9 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play322051007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 322051007
		arg_32_1.duration_ = 15.07

		local var_32_0 = {
			zh = 15.066,
			ja = 12.6
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
				arg_32_0:Play322051008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["10049ui_story"]) and arg_32_1.var_.characterEffect10049ui_story == nil then
				arg_32_1.var_.characterEffect10049ui_story = arg_32_1.actors_["10049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["10049ui_story"]) then
				if arg_32_1.var_.characterEffect10049ui_story and not isNil(arg_32_1.actors_["10049ui_story"]) then
					arg_32_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["10049ui_story"]) and arg_32_1.var_.characterEffect10049ui_story then
				arg_32_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action3_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				if not isNil(arg_32_1.actors_["10049ui_story"]) then
					local var_35_2 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_35_2 then
						var_35_2:EnableDynamicBone(true)
					end
				end
			end

			local var_35_3 = 0
			local var_35_4 = 1.225

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_3 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_5 = arg_32_1:GetWordFromCfg(322051007)
				local var_35_6 = arg_32_1:FormatText(var_35_5.content)

				arg_32_1.text_.text = var_35_6

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_8 = 49 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_6) / 49)

				if (49 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_6) / 49)) > 0 and var_35_4 < var_35_8 then
					arg_32_1.talkMaxDuration = var_35_8

					if var_35_8 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_3
					end
				end

				arg_32_1.text_.text = var_35_6
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051007", "story_v_out_322051.awb") ~= 0 then
					local var_35_9 = manager.audio:GetVoiceLength("story_v_out_322051", "322051007", "story_v_out_322051.awb") / 1000

					if var_35_9 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_3
					end

					if var_35_5.prefab_name ~= "" and arg_32_1.actors_[var_35_5.prefab_name] ~= nil then
						local var_35_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_5.prefab_name].transform, "story_v_out_322051", "322051007", "story_v_out_322051.awb")

						arg_32_1:RecordAudio("322051007", var_35_10)
						arg_32_1:RecordAudio("322051007", var_35_10)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_322051", "322051007", "story_v_out_322051.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_322051", "322051007", "story_v_out_322051.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_11 = math.max(var_35_4, arg_32_1.talkMaxDuration)

			if var_35_3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_3 + var_35_11 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_3) / var_35_11

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_3 + var_35_11 and arg_32_1.time_ < var_35_3 + var_35_11 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play322051008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 322051008
		arg_36_1.duration_ = 13.23

		local var_36_0 = {
			zh = 9.2,
			ja = 13.233
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
				arg_36_0:Play322051009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.9

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:GetWordFromCfg(322051008)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 36 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 36)

				if (36 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 36)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051008", "story_v_out_322051.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_322051", "322051008", "story_v_out_322051.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_322051", "322051008", "story_v_out_322051.awb")

						arg_36_1:RecordAudio("322051008", var_39_6)
						arg_36_1:RecordAudio("322051008", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_322051", "322051008", "story_v_out_322051.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_322051", "322051008", "story_v_out_322051.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play322051009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 322051009
		arg_40_1.duration_ = 6.2

		local var_40_0 = {
			zh = 3.733,
			ja = 6.2
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
				arg_40_0:Play322051010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["10049ui_story"]) and arg_40_1.var_.characterEffect10049ui_story == nil then
				arg_40_1.var_.characterEffect10049ui_story = arg_40_1.actors_["10049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["10049ui_story"]) then
				if arg_40_1.var_.characterEffect10049ui_story and not isNil(arg_40_1.actors_["10049ui_story"]) then
					arg_40_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["10049ui_story"]) and arg_40_1.var_.characterEffect10049ui_story then
				arg_40_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10049ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0
			local var_43_2 = 0.425

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(322051009)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_6 = 17 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 17)

				if (17 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 17)) > 0 and var_43_2 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051009", "story_v_out_322051.awb") ~= 0 then
					local var_43_7 = manager.audio:GetVoiceLength("story_v_out_322051", "322051009", "story_v_out_322051.awb") / 1000

					if var_43_7 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_1
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_322051", "322051009", "story_v_out_322051.awb")

						arg_40_1:RecordAudio("322051009", var_43_8)
						arg_40_1:RecordAudio("322051009", var_43_8)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_322051", "322051009", "story_v_out_322051.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_322051", "322051009", "story_v_out_322051.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_9 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_9 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_9

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_9 and arg_40_1.time_ < var_43_1 + var_43_9 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play322051010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 322051010
		arg_44_1.duration_ = 7.8

		local var_44_0 = {
			zh = 6.066,
			ja = 7.8
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
				arg_44_0:Play322051011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["10049ui_story"]) and arg_44_1.var_.characterEffect10049ui_story == nil then
				arg_44_1.var_.characterEffect10049ui_story = arg_44_1.actors_["10049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["10049ui_story"]) then
				if arg_44_1.var_.characterEffect10049ui_story and not isNil(arg_44_1.actors_["10049ui_story"]) then
					arg_44_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["10049ui_story"]) and arg_44_1.var_.characterEffect10049ui_story then
				arg_44_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action3_2")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				if not isNil(arg_44_1.actors_["10049ui_story"]) then
					local var_47_2 = GameObjectTools.GetOrAddComponent(arg_44_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_47_2 then
						var_47_2:EnableDynamicBone(true)
					end
				end
			end

			local var_47_3 = 0
			local var_47_4 = 0.625

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_3 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_5 = arg_44_1:GetWordFromCfg(322051010)
				local var_47_6 = arg_44_1:FormatText(var_47_5.content)

				arg_44_1.text_.text = var_47_6

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_8 = 25 <= 0 and var_47_4 or var_47_4 * (utf8.len(var_47_6) / 25)

				if (25 <= 0 and var_47_4 or var_47_4 * (utf8.len(var_47_6) / 25)) > 0 and var_47_4 < var_47_8 then
					arg_44_1.talkMaxDuration = var_47_8

					if var_47_8 + var_47_3 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_3
					end
				end

				arg_44_1.text_.text = var_47_6
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051010", "story_v_out_322051.awb") ~= 0 then
					local var_47_9 = manager.audio:GetVoiceLength("story_v_out_322051", "322051010", "story_v_out_322051.awb") / 1000

					if var_47_9 + var_47_3 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_3
					end

					if var_47_5.prefab_name ~= "" and arg_44_1.actors_[var_47_5.prefab_name] ~= nil then
						local var_47_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_5.prefab_name].transform, "story_v_out_322051", "322051010", "story_v_out_322051.awb")

						arg_44_1:RecordAudio("322051010", var_47_10)
						arg_44_1:RecordAudio("322051010", var_47_10)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_322051", "322051010", "story_v_out_322051.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_322051", "322051010", "story_v_out_322051.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_11 = math.max(var_47_4, arg_44_1.talkMaxDuration)

			if var_47_3 <= arg_44_1.time_ and arg_44_1.time_ < var_47_3 + var_47_11 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_3) / var_47_11

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_3 + var_47_11 and arg_44_1.time_ < var_47_3 + var_47_11 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play322051011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 322051011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play322051012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["10049ui_story"]) and arg_48_1.var_.characterEffect10049ui_story == nil then
				arg_48_1.var_.characterEffect10049ui_story = arg_48_1.actors_["10049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["10049ui_story"]) then
				if arg_48_1.var_.characterEffect10049ui_story and not isNil(arg_48_1.actors_["10049ui_story"]) then
					arg_48_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["10049ui_story"]) and arg_48_1.var_.characterEffect10049ui_story then
				arg_48_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10049ui_story.fillRatio = 0.5
			end

			local var_51_1 = 0
			local var_51_2 = 0.75

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(322051011).content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 30 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 30)

				if (30 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 30)) > 0 and var_51_2 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_6 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_6 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_6

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_6 and arg_48_1.time_ < var_51_1 + var_51_6 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play322051012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 322051012
		arg_52_1.duration_ = 6.73

		local var_52_0 = {
			zh = 3.933,
			ja = 6.733
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
				arg_52_0:Play322051013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["10049ui_story"]) and arg_52_1.var_.characterEffect10049ui_story == nil then
				arg_52_1.var_.characterEffect10049ui_story = arg_52_1.actors_["10049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["10049ui_story"]) then
				if arg_52_1.var_.characterEffect10049ui_story and not isNil(arg_52_1.actors_["10049ui_story"]) then
					arg_52_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["10049ui_story"]) and arg_52_1.var_.characterEffect10049ui_story then
				arg_52_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action1_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva", "EmotionTimelineAnimator")
			end

			local var_55_2 = 0
			local var_55_3 = 0.325

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_4 = arg_52_1:GetWordFromCfg(322051012)
				local var_55_5 = arg_52_1:FormatText(var_55_4.content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_7 = 13 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 13)

				if (13 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 13)) > 0 and var_55_3 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051012", "story_v_out_322051.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_322051", "322051012", "story_v_out_322051.awb") / 1000

					if var_55_8 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_2
					end

					if var_55_4.prefab_name ~= "" and arg_52_1.actors_[var_55_4.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_4.prefab_name].transform, "story_v_out_322051", "322051012", "story_v_out_322051.awb")

						arg_52_1:RecordAudio("322051012", var_55_9)
						arg_52_1:RecordAudio("322051012", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_322051", "322051012", "story_v_out_322051.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_322051", "322051012", "story_v_out_322051.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_3, arg_52_1.talkMaxDuration)

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_2) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_2 + var_55_10 and arg_52_1.time_ < var_55_2 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play322051013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 322051013
		arg_56_1.duration_ = 6.67

		local var_56_0 = {
			zh = 6.666,
			ja = 5.5
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
				arg_56_0:Play322051014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.6

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:GetWordFromCfg(322051013)
				local var_59_2 = arg_56_1:FormatText(var_59_1.content)

				arg_56_1.text_.text = var_59_2

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 24 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 24)

				if (24 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 24)) > 0 and var_59_0 < var_59_4 then
					arg_56_1.talkMaxDuration = var_59_4

					if var_59_4 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_4 + 0
					end
				end

				arg_56_1.text_.text = var_59_2
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051013", "story_v_out_322051.awb") ~= 0 then
					local var_59_5 = manager.audio:GetVoiceLength("story_v_out_322051", "322051013", "story_v_out_322051.awb") / 1000

					if var_59_5 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + 0
					end

					if var_59_1.prefab_name ~= "" and arg_56_1.actors_[var_59_1.prefab_name] ~= nil then
						local var_59_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_1.prefab_name].transform, "story_v_out_322051", "322051013", "story_v_out_322051.awb")

						arg_56_1:RecordAudio("322051013", var_59_6)
						arg_56_1:RecordAudio("322051013", var_59_6)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_322051", "322051013", "story_v_out_322051.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_322051", "322051013", "story_v_out_322051.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play322051014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 322051014
		arg_60_1.duration_ = 9

		local var_60_0 = {
			zh = 5.166,
			ja = 9
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
				arg_60_0:Play322051015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["10049ui_story"]) and arg_60_1.var_.characterEffect10049ui_story == nil then
				arg_60_1.var_.characterEffect10049ui_story = arg_60_1.actors_["10049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["10049ui_story"]) then
				if arg_60_1.var_.characterEffect10049ui_story and not isNil(arg_60_1.actors_["10049ui_story"]) then
					arg_60_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["10049ui_story"]) and arg_60_1.var_.characterEffect10049ui_story then
				arg_60_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10049ui_story.fillRatio = 0.5
			end

			local var_63_1 = 0
			local var_63_2 = 0.775

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(322051014)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_6 = 31 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_4) / 31)

				if (31 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_4) / 31)) > 0 and var_63_2 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6

					if var_63_6 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051014", "story_v_out_322051.awb") ~= 0 then
					local var_63_7 = manager.audio:GetVoiceLength("story_v_out_322051", "322051014", "story_v_out_322051.awb") / 1000

					if var_63_7 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_1
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_322051", "322051014", "story_v_out_322051.awb")

						arg_60_1:RecordAudio("322051014", var_63_8)
						arg_60_1:RecordAudio("322051014", var_63_8)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_322051", "322051014", "story_v_out_322051.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_322051", "322051014", "story_v_out_322051.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_9 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_9 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_9

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_9 and arg_60_1.time_ < var_63_1 + var_63_9 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play322051015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 322051015
		arg_64_1.duration_ = 9.2

		local var_64_0 = {
			zh = 6.433,
			ja = 9.2
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play322051016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.8

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1137].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:GetWordFromCfg(322051015)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 32 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 32)

				if (32 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 32)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051015", "story_v_out_322051.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_322051", "322051015", "story_v_out_322051.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_322051", "322051015", "story_v_out_322051.awb")

						arg_64_1:RecordAudio("322051015", var_67_6)
						arg_64_1:RecordAudio("322051015", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_322051", "322051015", "story_v_out_322051.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_322051", "322051015", "story_v_out_322051.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play322051016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 322051016
		arg_68_1.duration_ = 2.4

		local var_68_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_68_0:Play322051017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["10049ui_story"]) and arg_68_1.var_.characterEffect10049ui_story == nil then
				arg_68_1.var_.characterEffect10049ui_story = arg_68_1.actors_["10049ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["10049ui_story"]) then
				if arg_68_1.var_.characterEffect10049ui_story and not isNil(arg_68_1.actors_["10049ui_story"]) then
					arg_68_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["10049ui_story"]) and arg_68_1.var_.characterEffect10049ui_story then
				arg_68_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action4_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				if not isNil(arg_68_1.actors_["10049ui_story"]) then
					local var_71_2 = GameObjectTools.GetOrAddComponent(arg_68_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_71_2 then
						var_71_2:EnableDynamicBone(true)
					end
				end
			end

			local var_71_3 = 0
			local var_71_4 = 0.05

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_3 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_5 = arg_68_1:GetWordFromCfg(322051016)
				local var_71_6 = arg_68_1:FormatText(var_71_5.content)

				arg_68_1.text_.text = var_71_6

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_8 = 2 <= 0 and var_71_4 or var_71_4 * (utf8.len(var_71_6) / 2)

				if (2 <= 0 and var_71_4 or var_71_4 * (utf8.len(var_71_6) / 2)) > 0 and var_71_4 < var_71_8 then
					arg_68_1.talkMaxDuration = var_71_8

					if var_71_8 + var_71_3 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_3
					end
				end

				arg_68_1.text_.text = var_71_6
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051016", "story_v_out_322051.awb") ~= 0 then
					local var_71_9 = manager.audio:GetVoiceLength("story_v_out_322051", "322051016", "story_v_out_322051.awb") / 1000

					if var_71_9 + var_71_3 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_3
					end

					if var_71_5.prefab_name ~= "" and arg_68_1.actors_[var_71_5.prefab_name] ~= nil then
						local var_71_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_5.prefab_name].transform, "story_v_out_322051", "322051016", "story_v_out_322051.awb")

						arg_68_1:RecordAudio("322051016", var_71_10)
						arg_68_1:RecordAudio("322051016", var_71_10)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_322051", "322051016", "story_v_out_322051.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_322051", "322051016", "story_v_out_322051.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_11 = math.max(var_71_4, arg_68_1.talkMaxDuration)

			if var_71_3 <= arg_68_1.time_ and arg_68_1.time_ < var_71_3 + var_71_11 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_3) / var_71_11

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_3 + var_71_11 and arg_68_1.time_ < var_71_3 + var_71_11 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play322051017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 322051017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play322051018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos10049ui_story = arg_72_1.actors_["10049ui_story"].transform.localPosition

				local var_75_0 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_0 then
					var_75_0:EnableDynamicBone(false)
				end
			end

			local var_75_1 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_1 then
				arg_72_1.actors_["10049ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10049ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_1)
				arg_72_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10049ui_story"].transform.position).z)
				arg_72_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["10049ui_story"].transform.localEulerAngles = arg_72_1.actors_["10049ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_1 and arg_72_1.time_ < 0 + var_75_1 + arg_75_0 then
				arg_72_1.actors_["10049ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["10049ui_story"].transform.position).z)
				arg_72_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["10049ui_story"].transform.localEulerAngles = arg_72_1.actors_["10049ui_story"].transform.localEulerAngles

				local var_75_2 = GameObjectTools.GetOrAddComponent(arg_72_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(true)
				end
			end

			local var_75_3 = 0
			local var_75_4 = 0.9

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_3 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_5 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(322051017).content)

				arg_72_1.text_.text = var_75_5

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 36 <= 0 and var_75_4 or var_75_4 * (utf8.len(var_75_5) / 36)

				if (36 <= 0 and var_75_4 or var_75_4 * (utf8.len(var_75_5) / 36)) > 0 and var_75_4 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_3 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_3
					end
				end

				arg_72_1.text_.text = var_75_5
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_4, arg_72_1.talkMaxDuration)

			if var_75_3 <= arg_72_1.time_ and arg_72_1.time_ < var_75_3 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_3) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_3 + var_75_8 and arg_72_1.time_ < var_75_3 + var_75_8 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play322051018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 322051018
		arg_76_1.duration_ = 3.7

		local var_76_0 = {
			zh = 3.7,
			ja = 3.366
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play322051019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10049ui_story = arg_76_1.actors_["10049ui_story"].transform.localPosition

				local var_79_0 = GameObjectTools.GetOrAddComponent(arg_76_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_79_0 then
					var_79_0:EnableDynamicBone(false)
				end
			end

			local var_79_1 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_1 then
				arg_76_1.actors_["10049ui_story"].transform.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10049ui_story, Vector3.New(0, -1.13, -6), (arg_76_1.time_ - 0) / var_79_1)
				arg_76_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10049ui_story"].transform.position).z)
				arg_76_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["10049ui_story"].transform.localEulerAngles = arg_76_1.actors_["10049ui_story"].transform.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_1 and arg_76_1.time_ < 0 + var_79_1 + arg_79_0 then
				arg_76_1.actors_["10049ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6)
				arg_76_1.actors_["10049ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_76_1.actors_["10049ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10049ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_76_1.actors_["10049ui_story"].transform.position).z)
				arg_76_1.actors_["10049ui_story"].transform.localEulerAngles.z = 0
				arg_76_1.actors_["10049ui_story"].transform.localEulerAngles.x = 0
				arg_76_1.actors_["10049ui_story"].transform.localEulerAngles = arg_76_1.actors_["10049ui_story"].transform.localEulerAngles

				local var_79_2 = GameObjectTools.GetOrAddComponent(arg_76_1.actors_["10049ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(true)
				end
			end

			local var_79_3 = arg_76_1.actors_["10049ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_3) and arg_76_1.var_.characterEffect10049ui_story == nil then
				arg_76_1.var_.characterEffect10049ui_story = var_79_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_4 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 and not isNil(var_79_3) then
				if arg_76_1.var_.characterEffect10049ui_story and not isNil(var_79_3) then
					arg_76_1.var_.characterEffect10049ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 and not isNil(var_79_3) and arg_76_1.var_.characterEffect10049ui_story then
				arg_76_1.var_.characterEffect10049ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action4_2")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				if not isNil(arg_76_1.actors_["10049ui_story"]) then
					local var_79_6 = GameObjectTools.GetOrAddComponent(arg_76_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_79_6 then
						var_79_6:EnableDynamicBone(true)
					end
				end
			end

			local var_79_7 = 0
			local var_79_8 = 0.225

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_7 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_9 = arg_76_1:GetWordFromCfg(322051018)
				local var_79_10 = arg_76_1:FormatText(var_79_9.content)

				arg_76_1.text_.text = var_79_10

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_12 = 9 <= 0 and var_79_8 or var_79_8 * (utf8.len(var_79_10) / 9)

				if (9 <= 0 and var_79_8 or var_79_8 * (utf8.len(var_79_10) / 9)) > 0 and var_79_8 < var_79_12 then
					arg_76_1.talkMaxDuration = var_79_12

					if var_79_12 + var_79_7 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_7
					end
				end

				arg_76_1.text_.text = var_79_10
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051018", "story_v_out_322051.awb") ~= 0 then
					local var_79_13 = manager.audio:GetVoiceLength("story_v_out_322051", "322051018", "story_v_out_322051.awb") / 1000

					if var_79_13 + var_79_7 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_7
					end

					if var_79_9.prefab_name ~= "" and arg_76_1.actors_[var_79_9.prefab_name] ~= nil then
						local var_79_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_9.prefab_name].transform, "story_v_out_322051", "322051018", "story_v_out_322051.awb")

						arg_76_1:RecordAudio("322051018", var_79_14)
						arg_76_1:RecordAudio("322051018", var_79_14)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_322051", "322051018", "story_v_out_322051.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_322051", "322051018", "story_v_out_322051.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_15 = math.max(var_79_8, arg_76_1.talkMaxDuration)

			if var_79_7 <= arg_76_1.time_ and arg_76_1.time_ < var_79_7 + var_79_15 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_7) / var_79_15

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_7 + var_79_15 and arg_76_1.time_ < var_79_7 + var_79_15 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play322051019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 322051019
		arg_80_1.duration_ = 8.1

		local var_80_0 = {
			zh = 8.1,
			ja = 7.166
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play322051020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/story10049/story10049action/10049action1_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("10049ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				if not isNil(arg_80_1.actors_["10049ui_story"]) then
					local var_83_0 = GameObjectTools.GetOrAddComponent(arg_80_1.actors_["10049ui_story"], typeof(DynamicBoneHelper))

					if var_83_0 then
						var_83_0:EnableDynamicBone(true)
					end
				end
			end

			local var_83_1 = 0
			local var_83_2 = 0.525

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:GetWordFromCfg(322051019)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_6 = 21 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 21)

				if (21 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 21)) > 0 and var_83_2 < var_83_6 then
					arg_80_1.talkMaxDuration = var_83_6

					if var_83_6 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051019", "story_v_out_322051.awb") ~= 0 then
					local var_83_7 = manager.audio:GetVoiceLength("story_v_out_322051", "322051019", "story_v_out_322051.awb") / 1000

					if var_83_7 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_1
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_322051", "322051019", "story_v_out_322051.awb")

						arg_80_1:RecordAudio("322051019", var_83_8)
						arg_80_1:RecordAudio("322051019", var_83_8)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_322051", "322051019", "story_v_out_322051.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_322051", "322051019", "story_v_out_322051.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_9 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_9 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_9

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_9 and arg_80_1.time_ < var_83_1 + var_83_9 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play322051020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 322051020
		arg_84_1.duration_ = 9

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play322051021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if arg_84_1.bgs_.L15f == nil then
				local var_87_0 = Object.Instantiate(arg_84_1.paintGo_)

				var_87_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L15f")
				var_87_0.name = "L15f"
				var_87_0.transform.parent = arg_84_1.stage_.transform
				var_87_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.bgs_.L15f = var_87_0
			end

			if 2 < arg_84_1.time_ and arg_84_1.time_ <= 2 + arg_87_0 then
				local var_87_1 = arg_84_1.bgs_.L15f

				arg_84_1.bgs_.L15f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_87_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_87_2 = var_87_1:GetComponent("SpriteRenderer")

				if var_87_2 and var_87_2.sprite then
					local var_87_3 = 2 * (var_87_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_87_1.transform.localScale = Vector3.New(var_87_3 / var_87_2.sprite.bounds.size.y < var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x and var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x or var_87_3 / var_87_2.sprite.bounds.size.y, var_87_3 / var_87_2.sprite.bounds.size.y < var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x and var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x or var_87_3 / var_87_2.sprite.bounds.size.y, 0)
				end

				for iter_87_0, iter_87_1 in pairs(arg_84_1.bgs_) do
					if iter_87_0 ~= "L15f" then
						iter_87_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_87_4 = 4

			if 4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.allBtn_.enabled = false
			end

			if arg_84_1.time_ >= var_87_4 + 0.3 and arg_84_1.time_ < var_87_4 + 0.3 + arg_87_0 then
				arg_84_1.allBtn_.enabled = true
			end

			local var_87_5 = 0

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_6 = 2

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 then
				local var_87_7 = Color.New(0, 0, 0)

				var_87_7.a = Mathf.Lerp(0, 1, (arg_84_1.time_ - var_87_5) / var_87_6)
				arg_84_1.mask_.color = var_87_7
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 then
				local var_87_8 = Color.New(0, 0, 0)

				var_87_8.a = 1
				arg_84_1.mask_.color = var_87_8
			end

			local var_87_9 = 2

			if 2 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_10 = 2

			if var_87_9 <= arg_84_1.time_ and arg_84_1.time_ < var_87_9 + var_87_10 then
				local var_87_11 = Color.New(0, 0, 0)

				var_87_11.a = Mathf.Lerp(1, 0, (arg_84_1.time_ - var_87_9) / var_87_10)
				arg_84_1.mask_.color = var_87_11
			end

			if arg_84_1.time_ >= var_87_9 + var_87_10 and arg_84_1.time_ < var_87_9 + var_87_10 + arg_87_0 then
				local var_87_12 = Color.New(0, 0, 0)

				arg_84_1.mask_.enabled = false
				var_87_12.a = 0
				arg_84_1.mask_.color = var_87_12
			end

			local var_87_13 = arg_84_1.actors_["10049ui_story"]

			if 4 < arg_84_1.time_ and arg_84_1.time_ <= 4 + arg_87_0 and not isNil(var_87_13) and arg_84_1.var_.characterEffect10049ui_story == nil then
				arg_84_1.var_.characterEffect10049ui_story = var_87_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_14 = 0.200000002980232

			if 4 <= arg_84_1.time_ and arg_84_1.time_ < 4 + var_87_14 and not isNil(var_87_13) then
				if arg_84_1.var_.characterEffect10049ui_story and not isNil(var_87_13) then
					arg_84_1.var_.characterEffect10049ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10049ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 4) / var_87_14)
				end
			end

			if arg_84_1.time_ >= 4 + var_87_14 and arg_84_1.time_ < 4 + var_87_14 + arg_87_0 and not isNil(var_87_13) and arg_84_1.var_.characterEffect10049ui_story then
				arg_84_1.var_.characterEffect10049ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10049ui_story.fillRatio = 0.5
			end

			local var_87_15 = arg_84_1.actors_["10049ui_story"].transform

			if 1.96599999815226 < arg_84_1.time_ and arg_84_1.time_ <= 1.96599999815226 + arg_87_0 then
				arg_84_1.var_.moveOldPos10049ui_story = var_87_15.localPosition

				local var_87_16 = GameObjectTools.GetOrAddComponent(var_87_15.gameObject, typeof(DynamicBoneHelper))

				if var_87_16 then
					var_87_16:EnableDynamicBone(false)
				end
			end

			local var_87_17 = 0.001

			if 1.96599999815226 <= arg_84_1.time_ and arg_84_1.time_ < 1.96599999815226 + var_87_17 then
				var_87_15.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10049ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 1.96599999815226) / var_87_17)
				var_87_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_15.position).x, (manager.ui.mainCamera.transform.position - var_87_15.position).y, (manager.ui.mainCamera.transform.position - var_87_15.position).z)
				var_87_15.localEulerAngles.z = 0
				var_87_15.localEulerAngles.x = 0
				var_87_15.localEulerAngles = var_87_15.localEulerAngles
			end

			if arg_84_1.time_ >= 1.96599999815226 + var_87_17 and arg_84_1.time_ < 1.96599999815226 + var_87_17 + arg_87_0 then
				var_87_15.localPosition = Vector3.New(0, 100, 0)
				var_87_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_15.position).x, (manager.ui.mainCamera.transform.position - var_87_15.position).y, (manager.ui.mainCamera.transform.position - var_87_15.position).z)
				var_87_15.localEulerAngles.z = 0
				var_87_15.localEulerAngles.x = 0
				var_87_15.localEulerAngles = var_87_15.localEulerAngles

				local var_87_18 = GameObjectTools.GetOrAddComponent(var_87_15.gameObject, typeof(DynamicBoneHelper))

				if var_87_18 then
					var_87_18:EnableDynamicBone(true)
				end
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_87_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_84_1.bgmTxt_.text ~= var_87_21 and arg_84_1.bgmTxt_.text ~= "" then
						if arg_84_1.bgmTxt2_.text ~= "" then
							arg_84_1.bgmTxt_.text = arg_84_1.bgmTxt2_.text
						end

						arg_84_1.bgmTxt2_.text = var_87_21

						arg_84_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_84_1.bgmTxt_.text = var_87_21
						arg_84_1.bgmTxt2_.text = var_87_21
					end

					if arg_84_1.bgmTimer then
						arg_84_1.bgmTimer:Stop()

						arg_84_1.bgmTimer = nil
					end

					if arg_84_1.settingData.show_music_name == 1 then
						arg_84_1.musicController:SetSelectedState("show")
						arg_84_1.musicAnimator_:Play("open", 0, 0)

						if arg_84_1.settingData.music_time ~= 0 then
							arg_84_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_84_1.settingData.music_time), function()
								if arg_84_1 == nil or isNil(arg_84_1.bgmTxt_) then
									return
								end

								arg_84_1.musicController:SetSelectedState("hide")
								arg_84_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_84_1.time_ and arg_84_1.time_ <= 2 + arg_87_0 then
				arg_84_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_87_24 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

				if "" ~= "" then
					if arg_84_1.bgmTxt_.text ~= var_87_24 and arg_84_1.bgmTxt_.text ~= "" then
						if arg_84_1.bgmTxt2_.text ~= "" then
							arg_84_1.bgmTxt_.text = arg_84_1.bgmTxt2_.text
						end

						arg_84_1.bgmTxt2_.text = var_87_24

						arg_84_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_84_1.bgmTxt_.text = var_87_24
						arg_84_1.bgmTxt2_.text = var_87_24
					end

					if arg_84_1.bgmTimer then
						arg_84_1.bgmTimer:Stop()

						arg_84_1.bgmTimer = nil
					end

					if arg_84_1.settingData.show_music_name == 1 then
						arg_84_1.musicController:SetSelectedState("show")
						arg_84_1.musicAnimator_:Play("open", 0, 0)

						if arg_84_1.settingData.music_time ~= 0 then
							arg_84_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_84_1.settingData.music_time), function()
								if arg_84_1 == nil or isNil(arg_84_1.bgmTxt_) then
									return
								end

								arg_84_1.musicController:SetSelectedState("hide")
								arg_84_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_84_1.time_ and arg_84_1.time_ <= 2 + arg_87_0 then
				arg_84_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 0.1 < arg_84_1.time_ and arg_84_1.time_ <= 0.1 + arg_87_0 then
				arg_84_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0.1 < arg_84_1.time_ and arg_84_1.time_ <= 0.1 + arg_87_0 then
				arg_84_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_28 = 4
			local var_87_29 = 1.025

			if 4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_28 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_30 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_30:setOnUpdate(LuaHelper.FloatAction(function(arg_90_0)
					arg_84_1.dialogCg_.alpha = arg_90_0
				end))
				var_87_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_31 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(322051020).content)

				arg_84_1.text_.text = var_87_31

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_33 = 41 <= 0 and var_87_29 or var_87_29 * (utf8.len(var_87_31) / 41)

				if (41 <= 0 and var_87_29 or var_87_29 * (utf8.len(var_87_31) / 41)) > 0 and var_87_29 < var_87_33 then
					arg_84_1.talkMaxDuration = var_87_33
					var_87_28 = var_87_28 + 0.3

					if var_87_33 + var_87_28 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_33 + var_87_28
					end
				end

				arg_84_1.text_.text = var_87_31
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_34 = var_87_28 + 0.3
			local var_87_35 = math.max(var_87_29, arg_84_1.talkMaxDuration)

			if var_87_28 + 0.3 <= arg_84_1.time_ and arg_84_1.time_ < var_87_34 + var_87_35 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_34) / var_87_35

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_34 + var_87_35 and arg_84_1.time_ < var_87_34 + var_87_35 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10049ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play322051021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 322051021
		arg_92_1.duration_ = 3.2

		local var_92_0 = {
			zh = 2,
			ja = 3.2
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
				arg_92_0:Play322051022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if arg_92_1.actors_["1156ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1156ui_story"))) then
				local var_95_0 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_92_1.stage_.transform)

				var_95_0.name = "1156ui_story"
				var_95_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["1156ui_story"] = var_95_0

				local var_95_1 = var_95_0:GetComponentInChildren(typeof(CharacterEffect))

				var_95_1.enabled = true

				local var_95_2 = GameObjectTools.GetOrAddComponent(var_95_0, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(false)
				end

				arg_92_1:ShowWeapon(var_95_1.transform, false)

				arg_92_1.var_["1156ui_story" .. "Animator"] = var_95_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_92_1.var_["1156ui_story" .. "Animator"].applyRootMotion = true
				arg_92_1.var_["1156ui_story" .. "LipSync"] = var_95_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_95_3 = arg_92_1.actors_["1156ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1156ui_story = var_95_3.localPosition
			end

			local var_95_4 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				var_95_3.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_92_1.time_ - 0) / var_95_4)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				var_95_3.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				var_95_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_3.position).x, (manager.ui.mainCamera.transform.position - var_95_3.position).y, (manager.ui.mainCamera.transform.position - var_95_3.position).z)
				var_95_3.localEulerAngles.z = 0
				var_95_3.localEulerAngles.x = 0
				var_95_3.localEulerAngles = var_95_3.localEulerAngles
			end

			local var_95_5 = arg_92_1.actors_["1156ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect1156ui_story == nil then
				arg_92_1.var_.characterEffect1156ui_story = var_95_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_6 and not isNil(var_95_5) then
				if arg_92_1.var_.characterEffect1156ui_story and not isNil(var_95_5) then
					arg_92_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_6 and arg_92_1.time_ < 0 + var_95_6 + arg_95_0 and not isNil(var_95_5) and arg_92_1.var_.characterEffect1156ui_story then
				arg_92_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_95_8 = 0
			local var_95_9 = 0.275

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_10 = arg_92_1:GetWordFromCfg(322051021)
				local var_95_11 = arg_92_1:FormatText(var_95_10.content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 11 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 11)

				if (11 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 11)) > 0 and var_95_9 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051021", "story_v_out_322051.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_322051", "322051021", "story_v_out_322051.awb") / 1000

					if var_95_14 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_8
					end

					if var_95_10.prefab_name ~= "" and arg_92_1.actors_[var_95_10.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_10.prefab_name].transform, "story_v_out_322051", "322051021", "story_v_out_322051.awb")

						arg_92_1:RecordAudio("322051021", var_95_15)
						arg_92_1:RecordAudio("322051021", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_322051", "322051021", "story_v_out_322051.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_322051", "322051021", "story_v_out_322051.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_9, arg_92_1.talkMaxDuration)

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_8) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_8 + var_95_16 and arg_92_1.time_ < var_95_8 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play322051022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 322051022
		arg_96_1.duration_ = 12.07

		local var_96_0 = {
			zh = 8.466,
			ja = 12.066
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play322051023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if arg_96_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_99_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_96_1.stage_.transform)

				var_99_0.name = "1284ui_story"
				var_99_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.actors_["1284ui_story"] = var_99_0

				local var_99_1 = var_99_0:GetComponentInChildren(typeof(CharacterEffect))

				var_99_1.enabled = true

				local var_99_2 = GameObjectTools.GetOrAddComponent(var_99_0, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(false)
				end

				arg_96_1:ShowWeapon(var_99_1.transform, false)

				arg_96_1.var_["1284ui_story" .. "Animator"] = var_99_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_96_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_96_1.var_["1284ui_story" .. "LipSync"] = var_99_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_99_3 = arg_96_1.actors_["1284ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1284ui_story = var_99_3.localPosition

				arg_96_1:ShowWeapon(arg_96_1.var_["1284ui_story" .. "Animator"].transform, false)
			end

			local var_99_4 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 then
				var_99_3.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_96_1.time_ - 0) / var_99_4)
				var_99_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_3.position).x, (manager.ui.mainCamera.transform.position - var_99_3.position).y, (manager.ui.mainCamera.transform.position - var_99_3.position).z)
				var_99_3.localEulerAngles.z = 0
				var_99_3.localEulerAngles.x = 0
				var_99_3.localEulerAngles = var_99_3.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 then
				var_99_3.localPosition = Vector3.New(0.7, -0.985, -6.22)
				var_99_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_3.position).x, (manager.ui.mainCamera.transform.position - var_99_3.position).y, (manager.ui.mainCamera.transform.position - var_99_3.position).z)
				var_99_3.localEulerAngles.z = 0
				var_99_3.localEulerAngles.x = 0
				var_99_3.localEulerAngles = var_99_3.localEulerAngles
			end

			local var_99_5 = arg_96_1.actors_["1284ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_5) and arg_96_1.var_.characterEffect1284ui_story == nil then
				arg_96_1.var_.characterEffect1284ui_story = var_99_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_6 and not isNil(var_99_5) then
				if arg_96_1.var_.characterEffect1284ui_story and not isNil(var_99_5) then
					arg_96_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_6 and arg_96_1.time_ < 0 + var_99_6 + arg_99_0 and not isNil(var_99_5) and arg_96_1.var_.characterEffect1284ui_story then
				arg_96_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_99_8 = arg_96_1.actors_["1156ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_8) and arg_96_1.var_.characterEffect1156ui_story == nil then
				arg_96_1.var_.characterEffect1156ui_story = var_99_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_9 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_9 and not isNil(var_99_8) then
				if arg_96_1.var_.characterEffect1156ui_story and not isNil(var_99_8) then
					arg_96_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_9)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_9 and arg_96_1.time_ < 0 + var_99_9 + arg_99_0 and not isNil(var_99_8) and arg_96_1.var_.characterEffect1156ui_story then
				arg_96_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_99_10 = 0
			local var_99_11 = 1.125

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_12 = arg_96_1:GetWordFromCfg(322051022)
				local var_99_13 = arg_96_1:FormatText(var_99_12.content)

				arg_96_1.text_.text = var_99_13

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_15 = 45 <= 0 and var_99_11 or var_99_11 * (utf8.len(var_99_13) / 45)

				if (45 <= 0 and var_99_11 or var_99_11 * (utf8.len(var_99_13) / 45)) > 0 and var_99_11 < var_99_15 then
					arg_96_1.talkMaxDuration = var_99_15

					if var_99_15 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_15 + var_99_10
					end
				end

				arg_96_1.text_.text = var_99_13
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051022", "story_v_out_322051.awb") ~= 0 then
					local var_99_16 = manager.audio:GetVoiceLength("story_v_out_322051", "322051022", "story_v_out_322051.awb") / 1000

					if var_99_16 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_16 + var_99_10
					end

					if var_99_12.prefab_name ~= "" and arg_96_1.actors_[var_99_12.prefab_name] ~= nil then
						local var_99_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_12.prefab_name].transform, "story_v_out_322051", "322051022", "story_v_out_322051.awb")

						arg_96_1:RecordAudio("322051022", var_99_17)
						arg_96_1:RecordAudio("322051022", var_99_17)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_322051", "322051022", "story_v_out_322051.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_322051", "322051022", "story_v_out_322051.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_18 = math.max(var_99_11, arg_96_1.talkMaxDuration)

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_18 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_10) / var_99_18

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_10 + var_99_18 and arg_96_1.time_ < var_99_10 + var_99_18 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play322051023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 322051023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play322051024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1284ui_story = arg_100_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_103_0 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 then
				arg_100_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_0)
				arg_100_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1284ui_story"].transform.position).z)
				arg_100_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1284ui_story"].transform.localEulerAngles = arg_100_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 then
				arg_100_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["1284ui_story"].transform.position).z)
				arg_100_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["1284ui_story"].transform.localEulerAngles = arg_100_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_103_1 = arg_100_1.actors_["1156ui_story"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1156ui_story = var_103_1.localPosition
			end

			local var_103_2 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_2 then
				var_103_1.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_2)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_2 and arg_100_1.time_ < 0 + var_103_2 + arg_103_0 then
				var_103_1.localPosition = Vector3.New(0, 100, 0)
				var_103_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_1.position).x, (manager.ui.mainCamera.transform.position - var_103_1.position).y, (manager.ui.mainCamera.transform.position - var_103_1.position).z)
				var_103_1.localEulerAngles.z = 0
				var_103_1.localEulerAngles.x = 0
				var_103_1.localEulerAngles = var_103_1.localEulerAngles
			end

			if 0.1 < arg_100_1.time_ and arg_100_1.time_ <= 0.1 + arg_103_0 then
				arg_100_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run01", "")
			end

			local var_103_4 = 0
			local var_103_5 = 1.1

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(322051023).content)

				arg_100_1.text_.text = var_103_6

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_8 = 44 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_6) / 44)

				if (44 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_6) / 44)) > 0 and var_103_5 < var_103_8 then
					arg_100_1.talkMaxDuration = var_103_8

					if var_103_8 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_6
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_9 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_9 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_9

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_9 and arg_100_1.time_ < var_103_4 + var_103_9 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play322051024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 322051024
		arg_104_1.duration_ = 2

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play322051025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1156ui_story = arg_104_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_107_0 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 then
				arg_104_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_104_1.time_ - 0) / var_107_0)
				arg_104_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1156ui_story"].transform.position).z)
				arg_104_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1156ui_story"].transform.localEulerAngles = arg_104_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 then
				arg_104_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				arg_104_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["1156ui_story"].transform.position).z)
				arg_104_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["1156ui_story"].transform.localEulerAngles = arg_104_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_107_1 = arg_104_1.actors_["1156ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect1156ui_story == nil then
				arg_104_1.var_.characterEffect1156ui_story = var_107_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_2 and not isNil(var_107_1) then
				if arg_104_1.var_.characterEffect1156ui_story and not isNil(var_107_1) then
					arg_104_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_2 and arg_104_1.time_ < 0 + var_107_2 + arg_107_0 and not isNil(var_107_1) and arg_104_1.var_.characterEffect1156ui_story then
				arg_104_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_107_4 = 0
			local var_107_5 = 0.15

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_6 = arg_104_1:GetWordFromCfg(322051024)
				local var_107_7 = arg_104_1:FormatText(var_107_6.content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 6 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 6)

				if (6 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 6)) > 0 and var_107_5 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051024", "story_v_out_322051.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051024", "story_v_out_322051.awb") / 1000

					if var_107_10 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_4
					end

					if var_107_6.prefab_name ~= "" and arg_104_1.actors_[var_107_6.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_6.prefab_name].transform, "story_v_out_322051", "322051024", "story_v_out_322051.awb")

						arg_104_1:RecordAudio("322051024", var_107_11)
						arg_104_1:RecordAudio("322051024", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_322051", "322051024", "story_v_out_322051.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_322051", "322051024", "story_v_out_322051.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_5, arg_104_1.talkMaxDuration)

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_4) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_4 + var_107_12 and arg_104_1.time_ < var_107_4 + var_107_12 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play322051025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 322051025
		arg_108_1.duration_ = 3.07

		local var_108_0 = {
			zh = 2.033,
			ja = 3.066
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
				arg_108_0:Play322051026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1284ui_story = arg_108_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1284ui_story"].transform.position).z)
				arg_108_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1284ui_story"].transform.localEulerAngles = arg_108_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_108_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1284ui_story"].transform.position).z)
				arg_108_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1284ui_story"].transform.localEulerAngles = arg_108_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_111_1 = arg_108_1.actors_["1284ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1284ui_story == nil then
				arg_108_1.var_.characterEffect1284ui_story = var_111_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 and not isNil(var_111_1) then
				if arg_108_1.var_.characterEffect1284ui_story and not isNil(var_111_1) then
					arg_108_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1284ui_story then
				arg_108_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_111_4 = arg_108_1.actors_["1156ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1156ui_story == nil then
				arg_108_1.var_.characterEffect1156ui_story = var_111_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_5 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_5 and not isNil(var_111_4) then
				if arg_108_1.var_.characterEffect1156ui_story and not isNil(var_111_4) then
					arg_108_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_5)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_5 and arg_108_1.time_ < 0 + var_111_5 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1156ui_story then
				arg_108_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_111_6 = 0
			local var_111_7 = 0.2

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_8 = arg_108_1:GetWordFromCfg(322051025)
				local var_111_9 = arg_108_1:FormatText(var_111_8.content)

				arg_108_1.text_.text = var_111_9

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 8 <= 0 and var_111_7 or var_111_7 * (utf8.len(var_111_9) / 8)

				if (8 <= 0 and var_111_7 or var_111_7 * (utf8.len(var_111_9) / 8)) > 0 and var_111_7 < var_111_11 then
					arg_108_1.talkMaxDuration = var_111_11

					if var_111_11 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_11 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_9
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051025", "story_v_out_322051.awb") ~= 0 then
					local var_111_12 = manager.audio:GetVoiceLength("story_v_out_322051", "322051025", "story_v_out_322051.awb") / 1000

					if var_111_12 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_12 + var_111_6
					end

					if var_111_8.prefab_name ~= "" and arg_108_1.actors_[var_111_8.prefab_name] ~= nil then
						local var_111_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_8.prefab_name].transform, "story_v_out_322051", "322051025", "story_v_out_322051.awb")

						arg_108_1:RecordAudio("322051025", var_111_13)
						arg_108_1:RecordAudio("322051025", var_111_13)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_322051", "322051025", "story_v_out_322051.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_322051", "322051025", "story_v_out_322051.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_14 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_14 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_14

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_14 and arg_108_1.time_ < var_111_6 + var_111_14 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play322051026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 322051026
		arg_112_1.duration_ = 7.93

		local var_112_0 = {
			zh = 4.633,
			ja = 7.933
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play322051027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1156ui_story = arg_112_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1156ui_story, Vector3.New(-0.9, -1.1, -6.18), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1156ui_story"].transform.position).z)
				arg_112_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1156ui_story"].transform.localEulerAngles = arg_112_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(-0.9, -1.1, -6.18)
				arg_112_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1156ui_story"].transform.position).z)
				arg_112_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1156ui_story"].transform.localEulerAngles = arg_112_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_115_1 = arg_112_1.actors_["1156ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1156ui_story == nil then
				arg_112_1.var_.characterEffect1156ui_story = var_115_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 and not isNil(var_115_1) then
				if arg_112_1.var_.characterEffect1156ui_story and not isNil(var_115_1) then
					arg_112_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1156ui_story then
				arg_112_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_115_4 = arg_112_1.actors_["1284ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect1284ui_story == nil then
				arg_112_1.var_.characterEffect1284ui_story = var_115_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_5 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_5 and not isNil(var_115_4) then
				if arg_112_1.var_.characterEffect1284ui_story and not isNil(var_115_4) then
					arg_112_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_5)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_5 and arg_112_1.time_ < 0 + var_115_5 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect1284ui_story then
				arg_112_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_2")
			end

			local var_115_6 = 0
			local var_115_7 = 0.65

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_8 = arg_112_1:GetWordFromCfg(322051026)
				local var_115_9 = arg_112_1:FormatText(var_115_8.content)

				arg_112_1.text_.text = var_115_9

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_11 = 26 <= 0 and var_115_7 or var_115_7 * (utf8.len(var_115_9) / 26)

				if (26 <= 0 and var_115_7 or var_115_7 * (utf8.len(var_115_9) / 26)) > 0 and var_115_7 < var_115_11 then
					arg_112_1.talkMaxDuration = var_115_11

					if var_115_11 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_11 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_9
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051026", "story_v_out_322051.awb") ~= 0 then
					local var_115_12 = manager.audio:GetVoiceLength("story_v_out_322051", "322051026", "story_v_out_322051.awb") / 1000

					if var_115_12 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_12 + var_115_6
					end

					if var_115_8.prefab_name ~= "" and arg_112_1.actors_[var_115_8.prefab_name] ~= nil then
						local var_115_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_8.prefab_name].transform, "story_v_out_322051", "322051026", "story_v_out_322051.awb")

						arg_112_1:RecordAudio("322051026", var_115_13)
						arg_112_1:RecordAudio("322051026", var_115_13)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_322051", "322051026", "story_v_out_322051.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_322051", "322051026", "story_v_out_322051.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_14 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_14 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_14

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_14 and arg_112_1.time_ < var_115_6 + var_115_14 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play322051027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 322051027
		arg_116_1.duration_ = 13.63

		local var_116_0 = {
			zh = 7.066,
			ja = 13.633
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
				arg_116_0:Play322051028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1284ui_story"]) and arg_116_1.var_.characterEffect1284ui_story == nil then
				arg_116_1.var_.characterEffect1284ui_story = arg_116_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1284ui_story"]) then
				if arg_116_1.var_.characterEffect1284ui_story and not isNil(arg_116_1.actors_["1284ui_story"]) then
					arg_116_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1284ui_story"]) and arg_116_1.var_.characterEffect1284ui_story then
				arg_116_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_119_2 = arg_116_1.actors_["1156ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect1156ui_story == nil then
				arg_116_1.var_.characterEffect1156ui_story = var_119_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_3 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 and not isNil(var_119_2) then
				if arg_116_1.var_.characterEffect1156ui_story and not isNil(var_119_2) then
					arg_116_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_3)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect1156ui_story then
				arg_116_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action6_1")
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_119_4 = 0
			local var_119_5 = 0.95

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(322051027)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 38 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 38)

				if (38 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 38)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051027", "story_v_out_322051.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051027", "story_v_out_322051.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_322051", "322051027", "story_v_out_322051.awb")

						arg_116_1:RecordAudio("322051027", var_119_11)
						arg_116_1:RecordAudio("322051027", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_322051", "322051027", "story_v_out_322051.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_322051", "322051027", "story_v_out_322051.awb")
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

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play322051028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 322051028
		arg_120_1.duration_ = 7.93

		local var_120_0 = {
			zh = 6,
			ja = 7.933
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
				arg_120_0:Play322051029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.7

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:GetWordFromCfg(322051028)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 28 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 28)

				if (28 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 28)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051028", "story_v_out_322051.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_322051", "322051028", "story_v_out_322051.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_322051", "322051028", "story_v_out_322051.awb")

						arg_120_1:RecordAudio("322051028", var_123_6)
						arg_120_1:RecordAudio("322051028", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_322051", "322051028", "story_v_out_322051.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_322051", "322051028", "story_v_out_322051.awb")
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
	Play322051029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 322051029
		arg_124_1.duration_ = 19.2

		local var_124_0 = {
			zh = 13.2,
			ja = 19.2
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
				arg_124_0:Play322051030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action6_2")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_127_0 = 0
			local var_127_1 = 1.65

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_2 = arg_124_1:GetWordFromCfg(322051029)
				local var_127_3 = arg_124_1:FormatText(var_127_2.content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 66 <= 0 and var_127_1 or var_127_1 * (utf8.len(var_127_3) / 66)

				if (66 <= 0 and var_127_1 or var_127_1 * (utf8.len(var_127_3) / 66)) > 0 and var_127_1 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051029", "story_v_out_322051.awb") ~= 0 then
					local var_127_6 = manager.audio:GetVoiceLength("story_v_out_322051", "322051029", "story_v_out_322051.awb") / 1000

					if var_127_6 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_0
					end

					if var_127_2.prefab_name ~= "" and arg_124_1.actors_[var_127_2.prefab_name] ~= nil then
						local var_127_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_2.prefab_name].transform, "story_v_out_322051", "322051029", "story_v_out_322051.awb")

						arg_124_1:RecordAudio("322051029", var_127_7)
						arg_124_1:RecordAudio("322051029", var_127_7)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_322051", "322051029", "story_v_out_322051.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_322051", "322051029", "story_v_out_322051.awb")
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
	Play322051030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 322051030
		arg_128_1.duration_ = 4.87

		local var_128_0 = {
			zh = 4.766,
			ja = 4.866
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play322051031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1156ui_story"]) and arg_128_1.var_.characterEffect1156ui_story == nil then
				arg_128_1.var_.characterEffect1156ui_story = arg_128_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1156ui_story"]) then
				if arg_128_1.var_.characterEffect1156ui_story and not isNil(arg_128_1.actors_["1156ui_story"]) then
					arg_128_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1156ui_story"]) and arg_128_1.var_.characterEffect1156ui_story then
				arg_128_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_131_2 = arg_128_1.actors_["1284ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1284ui_story == nil then
				arg_128_1.var_.characterEffect1284ui_story = var_131_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_3 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.characterEffect1284ui_story and not isNil(var_131_2) then
					arg_128_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_3)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1284ui_story then
				arg_128_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_131_4 = 0
			local var_131_5 = 0.575

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(322051030)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 23 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 23)

				if (23 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 23)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051030", "story_v_out_322051.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051030", "story_v_out_322051.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_322051", "322051030", "story_v_out_322051.awb")

						arg_128_1:RecordAudio("322051030", var_131_11)
						arg_128_1:RecordAudio("322051030", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_322051", "322051030", "story_v_out_322051.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_322051", "322051030", "story_v_out_322051.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play322051031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 322051031
		arg_132_1.duration_ = 3

		local var_132_0 = {
			zh = 1.999999999999,
			ja = 3
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
				arg_132_0:Play322051032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1284ui_story"]) and arg_132_1.var_.characterEffect1284ui_story == nil then
				arg_132_1.var_.characterEffect1284ui_story = arg_132_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1284ui_story"]) then
				if arg_132_1.var_.characterEffect1284ui_story and not isNil(arg_132_1.actors_["1284ui_story"]) then
					arg_132_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1284ui_story"]) and arg_132_1.var_.characterEffect1284ui_story then
				arg_132_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_135_2 = arg_132_1.actors_["1156ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1156ui_story == nil then
				arg_132_1.var_.characterEffect1156ui_story = var_135_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_3 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 and not isNil(var_135_2) then
				if arg_132_1.var_.characterEffect1156ui_story and not isNil(var_135_2) then
					arg_132_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_3)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1156ui_story then
				arg_132_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_135_4 = 0
			local var_135_5 = 0.125

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(322051031)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 5 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 5)

				if (5 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 5)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051031", "story_v_out_322051.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051031", "story_v_out_322051.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_322051", "322051031", "story_v_out_322051.awb")

						arg_132_1:RecordAudio("322051031", var_135_11)
						arg_132_1:RecordAudio("322051031", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_322051", "322051031", "story_v_out_322051.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_322051", "322051031", "story_v_out_322051.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_12 and arg_132_1.time_ < var_135_4 + var_135_12 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play322051032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 322051032
		arg_136_1.duration_ = 11.83

		local var_136_0 = {
			zh = 11.833,
			ja = 11.266
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play322051033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1156ui_story"]) and arg_136_1.var_.characterEffect1156ui_story == nil then
				arg_136_1.var_.characterEffect1156ui_story = arg_136_1.actors_["1156ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1156ui_story"]) then
				if arg_136_1.var_.characterEffect1156ui_story and not isNil(arg_136_1.actors_["1156ui_story"]) then
					arg_136_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1156ui_story"]) and arg_136_1.var_.characterEffect1156ui_story then
				arg_136_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_139_2 = arg_136_1.actors_["1284ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1284ui_story == nil then
				arg_136_1.var_.characterEffect1284ui_story = var_139_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_3 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.characterEffect1284ui_story and not isNil(var_139_2) then
					arg_136_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_3)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1284ui_story then
				arg_136_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_139_4 = 0
			local var_139_5 = 1.825

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_6 = arg_136_1:GetWordFromCfg(322051032)
				local var_139_7 = arg_136_1:FormatText(var_139_6.content)

				arg_136_1.text_.text = var_139_7

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 73 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 73)

				if (73 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 73)) > 0 and var_139_5 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_7
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051032", "story_v_out_322051.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051032", "story_v_out_322051.awb") / 1000

					if var_139_10 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_4
					end

					if var_139_6.prefab_name ~= "" and arg_136_1.actors_[var_139_6.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_6.prefab_name].transform, "story_v_out_322051", "322051032", "story_v_out_322051.awb")

						arg_136_1:RecordAudio("322051032", var_139_11)
						arg_136_1:RecordAudio("322051032", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_322051", "322051032", "story_v_out_322051.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_322051", "322051032", "story_v_out_322051.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_12 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_12 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_12

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_12 and arg_136_1.time_ < var_139_4 + var_139_12 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play322051033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 322051033
		arg_140_1.duration_ = 9.67

		local var_140_0 = {
			zh = 6.5,
			ja = 9.666
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
				arg_140_0:Play322051034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0.925

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_1 = arg_140_1:GetWordFromCfg(322051033)
				local var_143_2 = arg_140_1:FormatText(var_143_1.content)

				arg_140_1.text_.text = var_143_2

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 37 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 37)

				if (37 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 37)) > 0 and var_143_0 < var_143_4 then
					arg_140_1.talkMaxDuration = var_143_4

					if var_143_4 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_4 + 0
					end
				end

				arg_140_1.text_.text = var_143_2
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051033", "story_v_out_322051.awb") ~= 0 then
					local var_143_5 = manager.audio:GetVoiceLength("story_v_out_322051", "322051033", "story_v_out_322051.awb") / 1000

					if var_143_5 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + 0
					end

					if var_143_1.prefab_name ~= "" and arg_140_1.actors_[var_143_1.prefab_name] ~= nil then
						local var_143_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_1.prefab_name].transform, "story_v_out_322051", "322051033", "story_v_out_322051.awb")

						arg_140_1:RecordAudio("322051033", var_143_6)
						arg_140_1:RecordAudio("322051033", var_143_6)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_322051", "322051033", "story_v_out_322051.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_322051", "322051033", "story_v_out_322051.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play322051034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 322051034
		arg_144_1.duration_ = 12.4

		local var_144_0 = {
			zh = 9.033,
			ja = 12.4
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play322051035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 1.25

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:GetWordFromCfg(322051034)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 50 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 50)

				if (50 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 50)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051034", "story_v_out_322051.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_322051", "322051034", "story_v_out_322051.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_322051", "322051034", "story_v_out_322051.awb")

						arg_144_1:RecordAudio("322051034", var_147_6)
						arg_144_1:RecordAudio("322051034", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_322051", "322051034", "story_v_out_322051.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_322051", "322051034", "story_v_out_322051.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play322051035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 322051035
		arg_148_1.duration_ = 14.2

		local var_148_0 = {
			zh = 7.566,
			ja = 14.2
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
				arg_148_0:Play322051036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_2")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_151_0 = 0
			local var_151_1 = 1.15

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_2 = arg_148_1:GetWordFromCfg(322051035)
				local var_151_3 = arg_148_1:FormatText(var_151_2.content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 46 <= 0 and var_151_1 or var_151_1 * (utf8.len(var_151_3) / 46)

				if (46 <= 0 and var_151_1 or var_151_1 * (utf8.len(var_151_3) / 46)) > 0 and var_151_1 < var_151_5 then
					arg_148_1.talkMaxDuration = var_151_5

					if var_151_5 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051035", "story_v_out_322051.awb") ~= 0 then
					local var_151_6 = manager.audio:GetVoiceLength("story_v_out_322051", "322051035", "story_v_out_322051.awb") / 1000

					if var_151_6 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_0
					end

					if var_151_2.prefab_name ~= "" and arg_148_1.actors_[var_151_2.prefab_name] ~= nil then
						local var_151_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_2.prefab_name].transform, "story_v_out_322051", "322051035", "story_v_out_322051.awb")

						arg_148_1:RecordAudio("322051035", var_151_7)
						arg_148_1:RecordAudio("322051035", var_151_7)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_322051", "322051035", "story_v_out_322051.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_322051", "322051035", "story_v_out_322051.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_8 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_8 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_8

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_8 and arg_148_1.time_ < var_151_0 + var_151_8 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play322051036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 322051036
		arg_152_1.duration_ = 4.5

		local var_152_0 = {
			zh = 4.5,
			ja = 4.2
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
				arg_152_0:Play322051037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.6

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:GetWordFromCfg(322051036)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 24 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 24)

				if (24 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 24)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051036", "story_v_out_322051.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_322051", "322051036", "story_v_out_322051.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_322051", "322051036", "story_v_out_322051.awb")

						arg_152_1:RecordAudio("322051036", var_155_6)
						arg_152_1:RecordAudio("322051036", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_322051", "322051036", "story_v_out_322051.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_322051", "322051036", "story_v_out_322051.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play322051037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 322051037
		arg_156_1.duration_ = 7.23

		local var_156_0 = {
			zh = 5.433,
			ja = 7.233
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play322051038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1284ui_story"]) and arg_156_1.var_.characterEffect1284ui_story == nil then
				arg_156_1.var_.characterEffect1284ui_story = arg_156_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1284ui_story"]) then
				if arg_156_1.var_.characterEffect1284ui_story and not isNil(arg_156_1.actors_["1284ui_story"]) then
					arg_156_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1284ui_story"]) and arg_156_1.var_.characterEffect1284ui_story then
				arg_156_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_159_2 = arg_156_1.actors_["1156ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.characterEffect1156ui_story == nil then
				arg_156_1.var_.characterEffect1156ui_story = var_159_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_3 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_3 and not isNil(var_159_2) then
				if arg_156_1.var_.characterEffect1156ui_story and not isNil(var_159_2) then
					arg_156_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_3)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_3 and arg_156_1.time_ < 0 + var_159_3 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.characterEffect1156ui_story then
				arg_156_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_159_4 = 0
			local var_159_5 = 0.65

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_4 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_6 = arg_156_1:GetWordFromCfg(322051037)
				local var_159_7 = arg_156_1:FormatText(var_159_6.content)

				arg_156_1.text_.text = var_159_7

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_9 = 26 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 26)

				if (26 <= 0 and var_159_5 or var_159_5 * (utf8.len(var_159_7) / 26)) > 0 and var_159_5 < var_159_9 then
					arg_156_1.talkMaxDuration = var_159_9

					if var_159_9 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_9 + var_159_4
					end
				end

				arg_156_1.text_.text = var_159_7
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051037", "story_v_out_322051.awb") ~= 0 then
					local var_159_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051037", "story_v_out_322051.awb") / 1000

					if var_159_10 + var_159_4 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_4
					end

					if var_159_6.prefab_name ~= "" and arg_156_1.actors_[var_159_6.prefab_name] ~= nil then
						local var_159_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_6.prefab_name].transform, "story_v_out_322051", "322051037", "story_v_out_322051.awb")

						arg_156_1:RecordAudio("322051037", var_159_11)
						arg_156_1:RecordAudio("322051037", var_159_11)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_322051", "322051037", "story_v_out_322051.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_322051", "322051037", "story_v_out_322051.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_12 = math.max(var_159_5, arg_156_1.talkMaxDuration)

			if var_159_4 <= arg_156_1.time_ and arg_156_1.time_ < var_159_4 + var_159_12 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_4) / var_159_12

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_4 + var_159_12 and arg_156_1.time_ < var_159_4 + var_159_12 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play322051038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 322051038
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play322051039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1284ui_story = arg_160_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_163_0 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 then
				arg_160_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_0)
				arg_160_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1284ui_story"].transform.position).z)
				arg_160_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1284ui_story"].transform.localEulerAngles = arg_160_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 then
				arg_160_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1284ui_story"].transform.position).z)
				arg_160_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1284ui_story"].transform.localEulerAngles = arg_160_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_163_1 = arg_160_1.actors_["1156ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1156ui_story = var_163_1.localPosition
			end

			local var_163_2 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_2 then
				var_163_1.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_2)
				var_163_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_1.position).x, (manager.ui.mainCamera.transform.position - var_163_1.position).y, (manager.ui.mainCamera.transform.position - var_163_1.position).z)
				var_163_1.localEulerAngles.z = 0
				var_163_1.localEulerAngles.x = 0
				var_163_1.localEulerAngles = var_163_1.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_2 and arg_160_1.time_ < 0 + var_163_2 + arg_163_0 then
				var_163_1.localPosition = Vector3.New(0, 100, 0)
				var_163_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_1.position).x, (manager.ui.mainCamera.transform.position - var_163_1.position).y, (manager.ui.mainCamera.transform.position - var_163_1.position).z)
				var_163_1.localEulerAngles.z = 0
				var_163_1.localEulerAngles.x = 0
				var_163_1.localEulerAngles = var_163_1.localEulerAngles
			end

			if 0.7 < arg_160_1.time_ and arg_160_1.time_ <= 0.7 + arg_163_0 then
				arg_160_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_hold", "")
			end

			local var_163_4 = 0
			local var_163_5 = 1.15

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_6 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(322051038).content)

				arg_160_1.text_.text = var_163_6

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_8 = 46 <= 0 and var_163_5 or var_163_5 * (utf8.len(var_163_6) / 46)

				if (46 <= 0 and var_163_5 or var_163_5 * (utf8.len(var_163_6) / 46)) > 0 and var_163_5 < var_163_8 then
					arg_160_1.talkMaxDuration = var_163_8

					if var_163_8 + var_163_4 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_4
					end
				end

				arg_160_1.text_.text = var_163_6
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_9 = math.max(var_163_5, arg_160_1.talkMaxDuration)

			if var_163_4 <= arg_160_1.time_ and arg_160_1.time_ < var_163_4 + var_163_9 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_4) / var_163_9

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_4 + var_163_9 and arg_160_1.time_ < var_163_4 + var_163_9 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play322051039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 322051039
		arg_164_1.duration_ = 9

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play322051040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if arg_164_1.bgs_.L10h == nil then
				local var_167_0 = Object.Instantiate(arg_164_1.paintGo_)

				var_167_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L10h")
				var_167_0.name = "L10h"
				var_167_0.transform.parent = arg_164_1.stage_.transform
				var_167_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.bgs_.L10h = var_167_0
			end

			if 2 < arg_164_1.time_ and arg_164_1.time_ <= 2 + arg_167_0 then
				local var_167_1 = arg_164_1.bgs_.L10h

				arg_164_1.bgs_.L10h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_167_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_2 = var_167_1:GetComponent("SpriteRenderer")

				if var_167_2 and var_167_2.sprite then
					local var_167_3 = 2 * (var_167_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_167_1.transform.localScale = Vector3.New(var_167_3 / var_167_2.sprite.bounds.size.y < var_167_3 * manager.ui.mainCameraCom_.aspect / var_167_2.sprite.bounds.size.x and var_167_3 * manager.ui.mainCameraCom_.aspect / var_167_2.sprite.bounds.size.x or var_167_3 / var_167_2.sprite.bounds.size.y, var_167_3 / var_167_2.sprite.bounds.size.y < var_167_3 * manager.ui.mainCameraCom_.aspect / var_167_2.sprite.bounds.size.x and var_167_3 * manager.ui.mainCameraCom_.aspect / var_167_2.sprite.bounds.size.x or var_167_3 / var_167_2.sprite.bounds.size.y, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "L10h" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_167_4 = 4

			if 4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1.allBtn_.enabled = false
			end

			if arg_164_1.time_ >= var_167_4 + 0.3 and arg_164_1.time_ < var_167_4 + 0.3 + arg_167_0 then
				arg_164_1.allBtn_.enabled = true
			end

			local var_167_5 = 0

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_6 = 2

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_6 then
				local var_167_7 = Color.New(0, 0, 0)

				var_167_7.a = Mathf.Lerp(0, 1, (arg_164_1.time_ - var_167_5) / var_167_6)
				arg_164_1.mask_.color = var_167_7
			end

			if arg_164_1.time_ >= var_167_5 + var_167_6 and arg_164_1.time_ < var_167_5 + var_167_6 + arg_167_0 then
				local var_167_8 = Color.New(0, 0, 0)

				var_167_8.a = 1
				arg_164_1.mask_.color = var_167_8
			end

			local var_167_9 = 2

			if 2 < arg_164_1.time_ and arg_164_1.time_ <= var_167_9 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_10 = 2

			if var_167_9 <= arg_164_1.time_ and arg_164_1.time_ < var_167_9 + var_167_10 then
				local var_167_11 = Color.New(0, 0, 0)

				var_167_11.a = Mathf.Lerp(1, 0, (arg_164_1.time_ - var_167_9) / var_167_10)
				arg_164_1.mask_.color = var_167_11
			end

			if arg_164_1.time_ >= var_167_9 + var_167_10 and arg_164_1.time_ < var_167_9 + var_167_10 + arg_167_0 then
				local var_167_12 = Color.New(0, 0, 0)

				arg_164_1.mask_.enabled = false
				var_167_12.a = 0
				arg_164_1.mask_.color = var_167_12
			end

			local var_167_13 = manager.ui.mainCamera.transform

			if 4 < arg_164_1.time_ and arg_164_1.time_ <= 4 + arg_167_0 then
				arg_164_1.var_.shakeOldPos = var_167_13.localPosition
			end

			local var_167_14 = 0.3

			if 4 <= arg_164_1.time_ and arg_164_1.time_ < 4 + var_167_14 then
				local var_167_15, var_167_16 = math.modf((arg_164_1.time_ - 4) / 0.066)

				var_167_13.localPosition = Vector3.New(var_167_16 * 0.13, var_167_16 * 0.13, var_167_16 * 0.13) + arg_164_1.var_.shakeOldPos
			end

			if arg_164_1.time_ >= 4 + var_167_14 and arg_164_1.time_ < 4 + var_167_14 + arg_167_0 then
				var_167_13.localPosition = arg_164_1.var_.shakeOldPos
			end

			if 4 < arg_164_1.time_ and arg_164_1.time_ <= 4 + arg_167_0 then
				arg_164_1:AudioAction("play", "effect", "se_story_6", "se_story_6_monster", "")
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_18 = 4
			local var_167_19 = 0.1

			if 4 < arg_164_1.time_ and arg_164_1.time_ <= var_167_18 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_20 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_20:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2142")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_21 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(322051039).content)

				arg_164_1.text_.text = var_167_21

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_23 = 4 <= 0 and var_167_19 or var_167_19 * (utf8.len(var_167_21) / 4)

				if (4 <= 0 and var_167_19 or var_167_19 * (utf8.len(var_167_21) / 4)) > 0 and var_167_19 < var_167_23 then
					arg_164_1.talkMaxDuration = var_167_23
					var_167_18 = var_167_18 + 0.3

					if var_167_23 + var_167_18 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_23 + var_167_18
					end
				end

				arg_164_1.text_.text = var_167_21
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_24 = var_167_18 + 0.3
			local var_167_25 = math.max(var_167_19, arg_164_1.talkMaxDuration)

			if var_167_18 + 0.3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_24 + var_167_25 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_24) / var_167_25

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_24 + var_167_25 and arg_164_1.time_ < var_167_24 + var_167_25 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play322051040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 322051040
		arg_170_1.duration_ = 3.43

		local var_170_0 = {
			zh = 2.933,
			ja = 3.433
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play322051041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if arg_170_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_173_0 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_170_1.stage_.transform)

				var_173_0.name = "404001ui_story"
				var_173_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.actors_["404001ui_story"] = var_173_0

				local var_173_1 = var_173_0:GetComponentInChildren(typeof(CharacterEffect))

				var_173_1.enabled = true

				local var_173_2 = GameObjectTools.GetOrAddComponent(var_173_0, typeof(DynamicBoneHelper))

				if var_173_2 then
					var_173_2:EnableDynamicBone(false)
				end

				arg_170_1:ShowWeapon(var_173_1.transform, false)

				arg_170_1.var_["404001ui_story" .. "Animator"] = var_173_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_170_1.var_["404001ui_story" .. "Animator"].applyRootMotion = true
				arg_170_1.var_["404001ui_story" .. "LipSync"] = var_173_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_173_3 = arg_170_1.actors_["404001ui_story"].transform

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos404001ui_story = var_173_3.localPosition
			end

			local var_173_4 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				var_173_3.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_170_1.time_ - 0) / var_173_4)
				var_173_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_3.position).x, (manager.ui.mainCamera.transform.position - var_173_3.position).y, (manager.ui.mainCamera.transform.position - var_173_3.position).z)
				var_173_3.localEulerAngles.z = 0
				var_173_3.localEulerAngles.x = 0
				var_173_3.localEulerAngles = var_173_3.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				var_173_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_173_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_3.position).x, (manager.ui.mainCamera.transform.position - var_173_3.position).y, (manager.ui.mainCamera.transform.position - var_173_3.position).z)
				var_173_3.localEulerAngles.z = 0
				var_173_3.localEulerAngles.x = 0
				var_173_3.localEulerAngles = var_173_3.localEulerAngles
			end

			local var_173_5 = arg_170_1.actors_["404001ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_5) and arg_170_1.var_.characterEffect404001ui_story == nil then
				arg_170_1.var_.characterEffect404001ui_story = var_173_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_6 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_6 and not isNil(var_173_5) then
				if arg_170_1.var_.characterEffect404001ui_story and not isNil(var_173_5) then
					arg_170_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_6 and arg_170_1.time_ < 0 + var_173_6 + arg_173_0 and not isNil(var_173_5) and arg_170_1.var_.characterEffect404001ui_story then
				arg_170_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_173_8 = 0
			local var_173_9 = 0.25

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_8 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_10 = arg_170_1:GetWordFromCfg(322051040)
				local var_173_11 = arg_170_1:FormatText(var_173_10.content)

				arg_170_1.text_.text = var_173_11

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_13 = 10 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_11) / 10)

				if (10 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_11) / 10)) > 0 and var_173_9 < var_173_13 then
					arg_170_1.talkMaxDuration = var_173_13

					if var_173_13 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_8
					end
				end

				arg_170_1.text_.text = var_173_11
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051040", "story_v_out_322051.awb") ~= 0 then
					local var_173_14 = manager.audio:GetVoiceLength("story_v_out_322051", "322051040", "story_v_out_322051.awb") / 1000

					if var_173_14 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_14 + var_173_8
					end

					if var_173_10.prefab_name ~= "" and arg_170_1.actors_[var_173_10.prefab_name] ~= nil then
						local var_173_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_10.prefab_name].transform, "story_v_out_322051", "322051040", "story_v_out_322051.awb")

						arg_170_1:RecordAudio("322051040", var_173_15)
						arg_170_1:RecordAudio("322051040", var_173_15)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_322051", "322051040", "story_v_out_322051.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_322051", "322051040", "story_v_out_322051.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_16 = math.max(var_173_9, arg_170_1.talkMaxDuration)

			if var_173_8 <= arg_170_1.time_ and arg_170_1.time_ < var_173_8 + var_173_16 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_8) / var_173_16

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_8 + var_173_16 and arg_170_1.time_ < var_173_8 + var_173_16 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
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

		arg_170_1:InitPlayNodeList()
	end,
	Play322051041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 322051041
		arg_174_1.duration_ = 9.47

		local var_174_0 = {
			zh = 6.8,
			ja = 9.466
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play322051042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["404001ui_story"]) and arg_174_1.var_.characterEffect404001ui_story == nil then
				arg_174_1.var_.characterEffect404001ui_story = arg_174_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["404001ui_story"]) then
				if arg_174_1.var_.characterEffect404001ui_story and not isNil(arg_174_1.actors_["404001ui_story"]) then
					arg_174_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_174_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_0)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["404001ui_story"]) and arg_174_1.var_.characterEffect404001ui_story then
				arg_174_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_174_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_177_1 = 0
			local var_177_2 = 0.825

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1182].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_3 = arg_174_1:GetWordFromCfg(322051041)
				local var_177_4 = arg_174_1:FormatText(var_177_3.content)

				arg_174_1.text_.text = var_177_4

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_6 = 33 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_4) / 33)

				if (33 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_4) / 33)) > 0 and var_177_2 < var_177_6 then
					arg_174_1.talkMaxDuration = var_177_6

					if var_177_6 + var_177_1 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_6 + var_177_1
					end
				end

				arg_174_1.text_.text = var_177_4
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051041", "story_v_out_322051.awb") ~= 0 then
					local var_177_7 = manager.audio:GetVoiceLength("story_v_out_322051", "322051041", "story_v_out_322051.awb") / 1000

					if var_177_7 + var_177_1 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_1
					end

					if var_177_3.prefab_name ~= "" and arg_174_1.actors_[var_177_3.prefab_name] ~= nil then
						local var_177_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_3.prefab_name].transform, "story_v_out_322051", "322051041", "story_v_out_322051.awb")

						arg_174_1:RecordAudio("322051041", var_177_8)
						arg_174_1:RecordAudio("322051041", var_177_8)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_322051", "322051041", "story_v_out_322051.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_322051", "322051041", "story_v_out_322051.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_9 = math.max(var_177_2, arg_174_1.talkMaxDuration)

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_9 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_1) / var_177_9

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_1 + var_177_9 and arg_174_1.time_ < var_177_1 + var_177_9 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play322051042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 322051042
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play322051043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0.166666666666667 < arg_178_1.time_ and arg_178_1.time_ <= 0.166666666666667 + arg_181_0 then
				arg_178_1:AudioAction("play", "effect", "se_story_9", "se_story_9_monster", "")
			end

			local var_181_1 = arg_178_1.actors_["404001ui_story"].transform

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos404001ui_story = var_181_1.localPosition
			end

			local var_181_2 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 then
				var_181_1.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_178_1.time_ - 0) / var_181_2)
				var_181_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_1.position).x, (manager.ui.mainCamera.transform.position - var_181_1.position).y, (manager.ui.mainCamera.transform.position - var_181_1.position).z)
				var_181_1.localEulerAngles.z = 0
				var_181_1.localEulerAngles.x = 0
				var_181_1.localEulerAngles = var_181_1.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 then
				var_181_1.localPosition = Vector3.New(0, 100, 0)
				var_181_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_181_1.position).x, (manager.ui.mainCamera.transform.position - var_181_1.position).y, (manager.ui.mainCamera.transform.position - var_181_1.position).z)
				var_181_1.localEulerAngles.z = 0
				var_181_1.localEulerAngles.x = 0
				var_181_1.localEulerAngles = var_181_1.localEulerAngles
			end

			local var_181_3 = 0
			local var_181_4 = 1.275

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_3 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_5 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(322051042).content)

				arg_178_1.text_.text = var_181_5

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_7 = 51 <= 0 and var_181_4 or var_181_4 * (utf8.len(var_181_5) / 51)

				if (51 <= 0 and var_181_4 or var_181_4 * (utf8.len(var_181_5) / 51)) > 0 and var_181_4 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_3 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_3
					end
				end

				arg_178_1.text_.text = var_181_5
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_8 = math.max(var_181_4, arg_178_1.talkMaxDuration)

			if var_181_3 <= arg_178_1.time_ and arg_178_1.time_ < var_181_3 + var_181_8 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_3) / var_181_8

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_3 + var_181_8 and arg_178_1.time_ < var_181_3 + var_181_8 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
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

		arg_178_1:InitPlayNodeList()
	end,
	Play322051043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 322051043
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play322051044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 1

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(322051043).content)

				arg_182_1.text_.text = var_185_1

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_3 = 40 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 40)

				if (40 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_1) / 40)) > 0 and var_185_0 < var_185_3 then
					arg_182_1.talkMaxDuration = var_185_3

					if var_185_3 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_3 + 0
					end
				end

				arg_182_1.text_.text = var_185_1
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_4 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_4 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_4

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_4 and arg_182_1.time_ < 0 + var_185_4 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play322051044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 322051044
		arg_186_1.duration_ = 6.33

		local var_186_0 = {
			zh = 4.866,
			ja = 6.333
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play322051045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos404001ui_story = arg_186_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_189_0 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 then
				arg_186_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_186_1.time_ - 0) / var_189_0)
				arg_186_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["404001ui_story"].transform.position).z)
				arg_186_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["404001ui_story"].transform.localEulerAngles = arg_186_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 then
				arg_186_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_186_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["404001ui_story"].transform.position).z)
				arg_186_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["404001ui_story"].transform.localEulerAngles = arg_186_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_189_1 = arg_186_1.actors_["404001ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect404001ui_story == nil then
				arg_186_1.var_.characterEffect404001ui_story = var_189_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_2 and not isNil(var_189_1) then
				if arg_186_1.var_.characterEffect404001ui_story and not isNil(var_189_1) then
					arg_186_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_2 and arg_186_1.time_ < 0 + var_189_2 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect404001ui_story then
				arg_186_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_189_4 = 0
			local var_189_5 = 0.55

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_6 = arg_186_1:GetWordFromCfg(322051044)
				local var_189_7 = arg_186_1:FormatText(var_189_6.content)

				arg_186_1.text_.text = var_189_7

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_9 = 22 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 22)

				if (22 <= 0 and var_189_5 or var_189_5 * (utf8.len(var_189_7) / 22)) > 0 and var_189_5 < var_189_9 then
					arg_186_1.talkMaxDuration = var_189_9

					if var_189_9 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_9 + var_189_4
					end
				end

				arg_186_1.text_.text = var_189_7
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051044", "story_v_out_322051.awb") ~= 0 then
					local var_189_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051044", "story_v_out_322051.awb") / 1000

					if var_189_10 + var_189_4 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_4
					end

					if var_189_6.prefab_name ~= "" and arg_186_1.actors_[var_189_6.prefab_name] ~= nil then
						local var_189_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_6.prefab_name].transform, "story_v_out_322051", "322051044", "story_v_out_322051.awb")

						arg_186_1:RecordAudio("322051044", var_189_11)
						arg_186_1:RecordAudio("322051044", var_189_11)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_322051", "322051044", "story_v_out_322051.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_322051", "322051044", "story_v_out_322051.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_12 = math.max(var_189_5, arg_186_1.talkMaxDuration)

			if var_189_4 <= arg_186_1.time_ and arg_186_1.time_ < var_189_4 + var_189_12 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_4) / var_189_12

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_4 + var_189_12 and arg_186_1.time_ < var_189_4 + var_189_12 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
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

		arg_186_1:InitPlayNodeList()
	end,
	Play322051045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 322051045
		arg_190_1.duration_ = 1.3

		local var_190_0 = {
			zh = 1.299999999999,
			ja = 1.3
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play322051046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["404001ui_story"]) and arg_190_1.var_.characterEffect404001ui_story == nil then
				arg_190_1.var_.characterEffect404001ui_story = arg_190_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["404001ui_story"]) then
				if arg_190_1.var_.characterEffect404001ui_story and not isNil(arg_190_1.actors_["404001ui_story"]) then
					arg_190_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_190_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["404001ui_story"]) and arg_190_1.var_.characterEffect404001ui_story then
				arg_190_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_190_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0.3 < arg_190_1.time_ and arg_190_1.time_ <= 0.3 + arg_193_0 then
				arg_190_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_battle_phone", "")
			end

			local var_193_2 = 0
			local var_193_3 = 0.125

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_2 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_190_1.callingController_:SetSelectedState("calling")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_4 = arg_190_1:GetWordFromCfg(322051045)
				local var_193_5 = arg_190_1:FormatText(var_193_4.content)

				arg_190_1.text_.text = var_193_5

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_7 = 5 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 5)

				if (5 <= 0 and var_193_3 or var_193_3 * (utf8.len(var_193_5) / 5)) > 0 and var_193_3 < var_193_7 then
					arg_190_1.talkMaxDuration = var_193_7

					if var_193_7 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_7 + var_193_2
					end
				end

				arg_190_1.text_.text = var_193_5
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051045", "story_v_out_322051.awb") ~= 0 then
					local var_193_8 = manager.audio:GetVoiceLength("story_v_out_322051", "322051045", "story_v_out_322051.awb") / 1000

					if var_193_8 + var_193_2 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_8 + var_193_2
					end

					if var_193_4.prefab_name ~= "" and arg_190_1.actors_[var_193_4.prefab_name] ~= nil then
						local var_193_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_4.prefab_name].transform, "story_v_out_322051", "322051045", "story_v_out_322051.awb")

						arg_190_1:RecordAudio("322051045", var_193_9)
						arg_190_1:RecordAudio("322051045", var_193_9)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_322051", "322051045", "story_v_out_322051.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_322051", "322051045", "story_v_out_322051.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_10 = math.max(var_193_3, arg_190_1.talkMaxDuration)

			if var_193_2 <= arg_190_1.time_ and arg_190_1.time_ < var_193_2 + var_193_10 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_2) / var_193_10

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_2 + var_193_10 and arg_190_1.time_ < var_193_2 + var_193_10 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play322051046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 322051046
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play322051047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos404001ui_story = arg_194_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_197_0 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 then
				arg_194_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_194_1.time_ - 0) / var_197_0)
				arg_194_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["404001ui_story"].transform.position).z)
				arg_194_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["404001ui_story"].transform.localEulerAngles = arg_194_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 then
				arg_194_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_194_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["404001ui_story"].transform.position).z)
				arg_194_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["404001ui_story"].transform.localEulerAngles = arg_194_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if 0.233333333333333 < arg_194_1.time_ and arg_194_1.time_ <= 0.233333333333333 + arg_197_0 then
				arg_194_1:AudioAction("play", "effect", "se_story_145", "se_story_145_phone_down", "")
			end

			local var_197_2 = 0
			local var_197_3 = 1.375

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_4 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(322051046).content)

				arg_194_1.text_.text = var_197_4

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_6 = 55 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_4) / 55)

				if (55 <= 0 and var_197_3 or var_197_3 * (utf8.len(var_197_4) / 55)) > 0 and var_197_3 < var_197_6 then
					arg_194_1.talkMaxDuration = var_197_6

					if var_197_6 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_6 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_4
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_3, arg_194_1.talkMaxDuration)

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_2) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_2 + var_197_7 and arg_194_1.time_ < var_197_2 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
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

		arg_194_1:InitPlayNodeList()
	end,
	Play322051047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 322051047
		arg_198_1.duration_ = 2.63

		local var_198_0 = {
			zh = 2.366,
			ja = 2.633
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play322051048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos404001ui_story = arg_198_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["404001ui_story"].transform.position).z)
				arg_198_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["404001ui_story"].transform.localEulerAngles = arg_198_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_198_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["404001ui_story"].transform.position).z)
				arg_198_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["404001ui_story"].transform.localEulerAngles = arg_198_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_201_1 = arg_198_1.actors_["404001ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect404001ui_story == nil then
				arg_198_1.var_.characterEffect404001ui_story = var_201_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_2 and not isNil(var_201_1) then
				if arg_198_1.var_.characterEffect404001ui_story and not isNil(var_201_1) then
					arg_198_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_2 and arg_198_1.time_ < 0 + var_201_2 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect404001ui_story then
				arg_198_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_201_4 = 0
			local var_201_5 = 0.275

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_6 = arg_198_1:GetWordFromCfg(322051047)
				local var_201_7 = arg_198_1:FormatText(var_201_6.content)

				arg_198_1.text_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 11 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 11)

				if (11 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 11)) > 0 and var_201_5 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_4
					end
				end

				arg_198_1.text_.text = var_201_7
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051047", "story_v_out_322051.awb") ~= 0 then
					local var_201_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051047", "story_v_out_322051.awb") / 1000

					if var_201_10 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_4
					end

					if var_201_6.prefab_name ~= "" and arg_198_1.actors_[var_201_6.prefab_name] ~= nil then
						local var_201_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_6.prefab_name].transform, "story_v_out_322051", "322051047", "story_v_out_322051.awb")

						arg_198_1:RecordAudio("322051047", var_201_11)
						arg_198_1:RecordAudio("322051047", var_201_11)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_322051", "322051047", "story_v_out_322051.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_322051", "322051047", "story_v_out_322051.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_12 = math.max(var_201_5, arg_198_1.talkMaxDuration)

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_12 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_4) / var_201_12

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_4 + var_201_12 and arg_198_1.time_ < var_201_4 + var_201_12 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
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

		arg_198_1:InitPlayNodeList()
	end,
	Play322051048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 322051048
		arg_202_1.duration_ = 6.47

		local var_202_0 = {
			zh = 4,
			ja = 6.466
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play322051049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["404001ui_story"]) and arg_202_1.var_.characterEffect404001ui_story == nil then
				arg_202_1.var_.characterEffect404001ui_story = arg_202_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["404001ui_story"]) then
				if arg_202_1.var_.characterEffect404001ui_story and not isNil(arg_202_1.actors_["404001ui_story"]) then
					arg_202_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_202_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["404001ui_story"]) and arg_202_1.var_.characterEffect404001ui_story then
				arg_202_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_202_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0.9 < arg_202_1.time_ and arg_202_1.time_ <= 0.9 + arg_205_0 then
				arg_202_1:AudioAction("play", "effect", "se_story_145", "se_story_145_ui01", "")
			end

			if 0.9 < arg_202_1.time_ and arg_202_1.time_ <= 0.9 + arg_205_0 then
				arg_202_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_battle_phone", "")
			end

			local var_205_3 = 0
			local var_205_4 = 0.575

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_202_1.callingController_:SetSelectedState("calling")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_5 = arg_202_1:GetWordFromCfg(322051048)
				local var_205_6 = arg_202_1:FormatText(var_205_5.content)

				arg_202_1.text_.text = var_205_6

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_8 = 23 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_6) / 23)

				if (23 <= 0 and var_205_4 or var_205_4 * (utf8.len(var_205_6) / 23)) > 0 and var_205_4 < var_205_8 then
					arg_202_1.talkMaxDuration = var_205_8

					if var_205_8 + var_205_3 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_3
					end
				end

				arg_202_1.text_.text = var_205_6
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051048", "story_v_out_322051.awb") ~= 0 then
					local var_205_9 = manager.audio:GetVoiceLength("story_v_out_322051", "322051048", "story_v_out_322051.awb") / 1000

					if var_205_9 + var_205_3 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_9 + var_205_3
					end

					if var_205_5.prefab_name ~= "" and arg_202_1.actors_[var_205_5.prefab_name] ~= nil then
						local var_205_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_5.prefab_name].transform, "story_v_out_322051", "322051048", "story_v_out_322051.awb")

						arg_202_1:RecordAudio("322051048", var_205_10)
						arg_202_1:RecordAudio("322051048", var_205_10)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_322051", "322051048", "story_v_out_322051.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_322051", "322051048", "story_v_out_322051.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_11 = math.max(var_205_4, arg_202_1.talkMaxDuration)

			if var_205_3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_3 + var_205_11 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_3) / var_205_11

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_3 + var_205_11 and arg_202_1.time_ < var_205_3 + var_205_11 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play322051049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 322051049
		arg_206_1.duration_ = 4.47

		local var_206_0 = {
			zh = 3.8,
			ja = 4.466
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play322051050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["404001ui_story"]) and arg_206_1.var_.characterEffect404001ui_story == nil then
				arg_206_1.var_.characterEffect404001ui_story = arg_206_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_0 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["404001ui_story"]) then
				if arg_206_1.var_.characterEffect404001ui_story and not isNil(arg_206_1.actors_["404001ui_story"]) then
					arg_206_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["404001ui_story"]) and arg_206_1.var_.characterEffect404001ui_story then
				arg_206_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_209_2 = 0
			local var_209_3 = 0.35

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_2 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_4 = arg_206_1:GetWordFromCfg(322051049)
				local var_209_5 = arg_206_1:FormatText(var_209_4.content)

				arg_206_1.text_.text = var_209_5

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_7 = 14 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 14)

				if (14 <= 0 and var_209_3 or var_209_3 * (utf8.len(var_209_5) / 14)) > 0 and var_209_3 < var_209_7 then
					arg_206_1.talkMaxDuration = var_209_7

					if var_209_7 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_7 + var_209_2
					end
				end

				arg_206_1.text_.text = var_209_5
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051049", "story_v_out_322051.awb") ~= 0 then
					local var_209_8 = manager.audio:GetVoiceLength("story_v_out_322051", "322051049", "story_v_out_322051.awb") / 1000

					if var_209_8 + var_209_2 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_2
					end

					if var_209_4.prefab_name ~= "" and arg_206_1.actors_[var_209_4.prefab_name] ~= nil then
						local var_209_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_4.prefab_name].transform, "story_v_out_322051", "322051049", "story_v_out_322051.awb")

						arg_206_1:RecordAudio("322051049", var_209_9)
						arg_206_1:RecordAudio("322051049", var_209_9)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_322051", "322051049", "story_v_out_322051.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_322051", "322051049", "story_v_out_322051.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_10 = math.max(var_209_3, arg_206_1.talkMaxDuration)

			if var_209_2 <= arg_206_1.time_ and arg_206_1.time_ < var_209_2 + var_209_10 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_2) / var_209_10

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_2 + var_209_10 and arg_206_1.time_ < var_209_2 + var_209_10 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play322051050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 322051050
		arg_210_1.duration_ = 3.97

		local var_210_0 = {
			zh = 2.533,
			ja = 3.966
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play322051051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos404001ui_story = arg_210_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["404001ui_story"].transform.position).z)
				arg_210_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["404001ui_story"].transform.localEulerAngles = arg_210_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_210_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["404001ui_story"].transform.position).z)
				arg_210_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["404001ui_story"].transform.localEulerAngles = arg_210_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_213_1 = 0
			local var_213_2 = 0.275

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1182].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_3 = arg_210_1:GetWordFromCfg(322051050)
				local var_213_4 = arg_210_1:FormatText(var_213_3.content)

				arg_210_1.text_.text = var_213_4

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_6 = 11 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_4) / 11)

				if (11 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_4) / 11)) > 0 and var_213_2 < var_213_6 then
					arg_210_1.talkMaxDuration = var_213_6

					if var_213_6 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_6 + var_213_1
					end
				end

				arg_210_1.text_.text = var_213_4
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051050", "story_v_out_322051.awb") ~= 0 then
					local var_213_7 = manager.audio:GetVoiceLength("story_v_out_322051", "322051050", "story_v_out_322051.awb") / 1000

					if var_213_7 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_1
					end

					if var_213_3.prefab_name ~= "" and arg_210_1.actors_[var_213_3.prefab_name] ~= nil then
						local var_213_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_3.prefab_name].transform, "story_v_out_322051", "322051050", "story_v_out_322051.awb")

						arg_210_1:RecordAudio("322051050", var_213_8)
						arg_210_1:RecordAudio("322051050", var_213_8)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_322051", "322051050", "story_v_out_322051.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_322051", "322051050", "story_v_out_322051.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_9 = math.max(var_213_2, arg_210_1.talkMaxDuration)

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_9 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_1) / var_213_9

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_1 + var_213_9 and arg_210_1.time_ < var_213_1 + var_213_9 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
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

		arg_210_1:InitPlayNodeList()
	end,
	Play322051051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 322051051
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play322051052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 1.075

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_1 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(322051051).content)

				arg_214_1.text_.text = var_217_1

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_3 = 43 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 43)

				if (43 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_1) / 43)) > 0 and var_217_0 < var_217_3 then
					arg_214_1.talkMaxDuration = var_217_3

					if var_217_3 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_3 + 0
					end
				end

				arg_214_1.text_.text = var_217_1
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_4 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_4

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play322051052 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 322051052
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play322051053(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0.1 < arg_218_1.time_ and arg_218_1.time_ <= 0.1 + arg_221_0 then
				arg_218_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire02", "")
			end

			local var_221_1 = manager.ui.mainCamera.transform

			if 0.1 < arg_218_1.time_ and arg_218_1.time_ <= 0.1 + arg_221_0 then
				arg_218_1.var_.shakeOldPos = var_221_1.localPosition
			end

			local var_221_2 = 0.533333333333333

			if 0.1 <= arg_218_1.time_ and arg_218_1.time_ < 0.1 + var_221_2 then
				local var_221_3, var_221_4 = math.modf((arg_218_1.time_ - 0.1) / 0.066)

				var_221_1.localPosition = Vector3.New(var_221_4 * 0.13, var_221_4 * 0.13, var_221_4 * 0.13) + arg_218_1.var_.shakeOldPos
			end

			if arg_218_1.time_ >= 0.1 + var_221_2 and arg_218_1.time_ < 0.1 + var_221_2 + arg_221_0 then
				var_221_1.localPosition = arg_218_1.var_.shakeOldPos
			end

			local var_221_5 = 0
			local var_221_6 = 1.025

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_7 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(322051052).content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 41 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_7) / 41)

				if (41 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_7) / 41)) > 0 and var_221_6 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_5 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_5
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_6, arg_218_1.talkMaxDuration)

			if var_221_5 <= arg_218_1.time_ and arg_218_1.time_ < var_221_5 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_5) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_5 + var_221_10 and arg_218_1.time_ < var_221_5 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play322051053 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 322051053
		arg_222_1.duration_ = 5.4

		local var_222_0 = {
			zh = 4.766,
			ja = 5.4
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play322051054(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos404001ui_story = arg_222_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_225_0 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 then
				arg_222_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_222_1.time_ - 0) / var_225_0)
				arg_222_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["404001ui_story"].transform.position).z)
				arg_222_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["404001ui_story"].transform.localEulerAngles = arg_222_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 then
				arg_222_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_222_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["404001ui_story"].transform.position).z)
				arg_222_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["404001ui_story"].transform.localEulerAngles = arg_222_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_225_1 = arg_222_1.actors_["404001ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect404001ui_story == nil then
				arg_222_1.var_.characterEffect404001ui_story = var_225_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_2 and not isNil(var_225_1) then
				if arg_222_1.var_.characterEffect404001ui_story and not isNil(var_225_1) then
					arg_222_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_2 and arg_222_1.time_ < 0 + var_225_2 + arg_225_0 and not isNil(var_225_1) and arg_222_1.var_.characterEffect404001ui_story then
				arg_222_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_225_4 = 0
			local var_225_5 = 0.5

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_4 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_6 = arg_222_1:GetWordFromCfg(322051053)
				local var_225_7 = arg_222_1:FormatText(var_225_6.content)

				arg_222_1.text_.text = var_225_7

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_9 = 20 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 20)

				if (20 <= 0 and var_225_5 or var_225_5 * (utf8.len(var_225_7) / 20)) > 0 and var_225_5 < var_225_9 then
					arg_222_1.talkMaxDuration = var_225_9

					if var_225_9 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_9 + var_225_4
					end
				end

				arg_222_1.text_.text = var_225_7
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051053", "story_v_out_322051.awb") ~= 0 then
					local var_225_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051053", "story_v_out_322051.awb") / 1000

					if var_225_10 + var_225_4 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_4
					end

					if var_225_6.prefab_name ~= "" and arg_222_1.actors_[var_225_6.prefab_name] ~= nil then
						local var_225_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_6.prefab_name].transform, "story_v_out_322051", "322051053", "story_v_out_322051.awb")

						arg_222_1:RecordAudio("322051053", var_225_11)
						arg_222_1:RecordAudio("322051053", var_225_11)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_322051", "322051053", "story_v_out_322051.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_322051", "322051053", "story_v_out_322051.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_12 = math.max(var_225_5, arg_222_1.talkMaxDuration)

			if var_225_4 <= arg_222_1.time_ and arg_222_1.time_ < var_225_4 + var_225_12 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_4) / var_225_12

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_4 + var_225_12 and arg_222_1.time_ < var_225_4 + var_225_12 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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

		arg_222_1:InitPlayNodeList()
	end,
	Play322051054 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 322051054
		arg_226_1.duration_ = 4.83

		local var_226_0 = {
			zh = 3.3,
			ja = 4.833
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play322051055(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if arg_226_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_229_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_226_1.stage_.transform)

				var_229_0.name = "10104ui_story"
				var_229_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_226_1.actors_["10104ui_story"] = var_229_0

				local var_229_1 = var_229_0:GetComponentInChildren(typeof(CharacterEffect))

				var_229_1.enabled = true

				local var_229_2 = GameObjectTools.GetOrAddComponent(var_229_0, typeof(DynamicBoneHelper))

				if var_229_2 then
					var_229_2:EnableDynamicBone(false)
				end

				arg_226_1:ShowWeapon(var_229_1.transform, false)

				arg_226_1.var_["10104ui_story" .. "Animator"] = var_229_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_226_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_226_1.var_["10104ui_story" .. "LipSync"] = var_229_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_229_3 = arg_226_1.actors_["10104ui_story"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos10104ui_story = var_229_3.localPosition
			end

			local var_229_4 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				var_229_3.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_226_1.time_ - 0) / var_229_4)
				var_229_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_3.position).x, (manager.ui.mainCamera.transform.position - var_229_3.position).y, (manager.ui.mainCamera.transform.position - var_229_3.position).z)
				var_229_3.localEulerAngles.z = 0
				var_229_3.localEulerAngles.x = 0
				var_229_3.localEulerAngles = var_229_3.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				var_229_3.localPosition = Vector3.New(0.99, -1.12, -5.99)
				var_229_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_3.position).x, (manager.ui.mainCamera.transform.position - var_229_3.position).y, (manager.ui.mainCamera.transform.position - var_229_3.position).z)
				var_229_3.localEulerAngles.z = 0
				var_229_3.localEulerAngles.x = 0
				var_229_3.localEulerAngles = var_229_3.localEulerAngles
			end

			local var_229_5 = arg_226_1.actors_["10104ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_5) and arg_226_1.var_.characterEffect10104ui_story == nil then
				arg_226_1.var_.characterEffect10104ui_story = var_229_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_6 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_6 and not isNil(var_229_5) then
				if arg_226_1.var_.characterEffect10104ui_story and not isNil(var_229_5) then
					arg_226_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_6 and arg_226_1.time_ < 0 + var_229_6 + arg_229_0 and not isNil(var_229_5) and arg_226_1.var_.characterEffect10104ui_story then
				arg_226_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_229_8 = arg_226_1.actors_["404001ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_8) and arg_226_1.var_.characterEffect404001ui_story == nil then
				arg_226_1.var_.characterEffect404001ui_story = var_229_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_9 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_9 and not isNil(var_229_8) then
				if arg_226_1.var_.characterEffect404001ui_story and not isNil(var_229_8) then
					arg_226_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_226_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_9)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_9 and arg_226_1.time_ < 0 + var_229_9 + arg_229_0 and not isNil(var_229_8) and arg_226_1.var_.characterEffect404001ui_story then
				arg_226_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_226_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				if arg_226_1.var_.characterEffect10104ui_story == nil then
					arg_226_1.var_.characterEffect10104ui_story = arg_226_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_229_10 = arg_226_1.var_.characterEffect10104ui_story

				arg_226_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_229_10.interferenceEffect.enabled = true
				var_229_10.interferenceEffect.noise = 0.001
				var_229_10.interferenceEffect.simTimeScale = 1
				var_229_10.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				if arg_226_1.var_.characterEffect10104ui_story == nil then
					arg_226_1.var_.characterEffect10104ui_story = arg_226_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_226_1.var_.characterEffect10104ui_story.imageEffect:turnOn(false)
			end

			local var_229_12 = 0
			local var_229_13 = 0.375

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_12 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_14 = arg_226_1:GetWordFromCfg(322051054)
				local var_229_15 = arg_226_1:FormatText(var_229_14.content)

				arg_226_1.text_.text = var_229_15

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_17 = 15 <= 0 and var_229_13 or var_229_13 * (utf8.len(var_229_15) / 15)

				if (15 <= 0 and var_229_13 or var_229_13 * (utf8.len(var_229_15) / 15)) > 0 and var_229_13 < var_229_17 then
					arg_226_1.talkMaxDuration = var_229_17

					if var_229_17 + var_229_12 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_17 + var_229_12
					end
				end

				arg_226_1.text_.text = var_229_15
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051054", "story_v_out_322051.awb") ~= 0 then
					local var_229_18 = manager.audio:GetVoiceLength("story_v_out_322051", "322051054", "story_v_out_322051.awb") / 1000

					if var_229_18 + var_229_12 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_18 + var_229_12
					end

					if var_229_14.prefab_name ~= "" and arg_226_1.actors_[var_229_14.prefab_name] ~= nil then
						local var_229_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_14.prefab_name].transform, "story_v_out_322051", "322051054", "story_v_out_322051.awb")

						arg_226_1:RecordAudio("322051054", var_229_19)
						arg_226_1:RecordAudio("322051054", var_229_19)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_322051", "322051054", "story_v_out_322051.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_322051", "322051054", "story_v_out_322051.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_20 = math.max(var_229_13, arg_226_1.talkMaxDuration)

			if var_229_12 <= arg_226_1.time_ and arg_226_1.time_ < var_229_12 + var_229_20 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_12) / var_229_20

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_12 + var_229_20 and arg_226_1.time_ < var_229_12 + var_229_20 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play322051055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 322051055
		arg_230_1.duration_ = 2

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play322051056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos404001ui_story = arg_230_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["404001ui_story"].transform.position).z)
				arg_230_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["404001ui_story"].transform.localEulerAngles = arg_230_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				arg_230_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["404001ui_story"].transform.position).z)
				arg_230_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["404001ui_story"].transform.localEulerAngles = arg_230_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_233_1 = arg_230_1.actors_["404001ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect404001ui_story == nil then
				arg_230_1.var_.characterEffect404001ui_story = var_233_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_2 and not isNil(var_233_1) then
				if arg_230_1.var_.characterEffect404001ui_story and not isNil(var_233_1) then
					arg_230_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_2 and arg_230_1.time_ < 0 + var_233_2 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect404001ui_story then
				arg_230_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_233_4 = arg_230_1.actors_["10104ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_4) and arg_230_1.var_.characterEffect10104ui_story == nil then
				arg_230_1.var_.characterEffect10104ui_story = var_233_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_5 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_5 and not isNil(var_233_4) then
				if arg_230_1.var_.characterEffect10104ui_story and not isNil(var_233_4) then
					arg_230_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_230_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_5)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_5 and arg_230_1.time_ < 0 + var_233_5 + arg_233_0 and not isNil(var_233_4) and arg_230_1.var_.characterEffect10104ui_story then
				arg_230_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_230_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_233_6 = 0
			local var_233_7 = 0.05

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_6 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_8 = arg_230_1:GetWordFromCfg(322051055)
				local var_233_9 = arg_230_1:FormatText(var_233_8.content)

				arg_230_1.text_.text = var_233_9

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_11 = 2 <= 0 and var_233_7 or var_233_7 * (utf8.len(var_233_9) / 2)

				if (2 <= 0 and var_233_7 or var_233_7 * (utf8.len(var_233_9) / 2)) > 0 and var_233_7 < var_233_11 then
					arg_230_1.talkMaxDuration = var_233_11

					if var_233_11 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_11 + var_233_6
					end
				end

				arg_230_1.text_.text = var_233_9
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051055", "story_v_out_322051.awb") ~= 0 then
					local var_233_12 = manager.audio:GetVoiceLength("story_v_out_322051", "322051055", "story_v_out_322051.awb") / 1000

					if var_233_12 + var_233_6 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_12 + var_233_6
					end

					if var_233_8.prefab_name ~= "" and arg_230_1.actors_[var_233_8.prefab_name] ~= nil then
						local var_233_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_8.prefab_name].transform, "story_v_out_322051", "322051055", "story_v_out_322051.awb")

						arg_230_1:RecordAudio("322051055", var_233_13)
						arg_230_1:RecordAudio("322051055", var_233_13)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_322051", "322051055", "story_v_out_322051.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_322051", "322051055", "story_v_out_322051.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_14 = math.max(var_233_7, arg_230_1.talkMaxDuration)

			if var_233_6 <= arg_230_1.time_ and arg_230_1.time_ < var_233_6 + var_233_14 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_6) / var_233_14

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_6 + var_233_14 and arg_230_1.time_ < var_233_6 + var_233_14 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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

		arg_230_1:InitPlayNodeList()
	end,
	Play322051056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 322051056
		arg_234_1.duration_ = 9.87

		local var_234_0 = {
			zh = 5.366,
			ja = 9.866
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play322051057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10104ui_story = arg_234_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_237_0 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 then
				arg_234_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10104ui_story, Vector3.New(0.99, -1.12, -5.99), (arg_234_1.time_ - 0) / var_237_0)
				arg_234_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10104ui_story"].transform.position).z)
				arg_234_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["10104ui_story"].transform.localEulerAngles = arg_234_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 then
				arg_234_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.99, -1.12, -5.99)
				arg_234_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10104ui_story"].transform.position).z)
				arg_234_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["10104ui_story"].transform.localEulerAngles = arg_234_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_237_1 = arg_234_1.actors_["10104ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect10104ui_story == nil then
				arg_234_1.var_.characterEffect10104ui_story = var_237_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_2 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_2 and not isNil(var_237_1) then
				if arg_234_1.var_.characterEffect10104ui_story and not isNil(var_237_1) then
					arg_234_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_2 and arg_234_1.time_ < 0 + var_237_2 + arg_237_0 and not isNil(var_237_1) and arg_234_1.var_.characterEffect10104ui_story then
				arg_234_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_237_4 = arg_234_1.actors_["404001ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_4) and arg_234_1.var_.characterEffect404001ui_story == nil then
				arg_234_1.var_.characterEffect404001ui_story = var_237_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_5 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_5 and not isNil(var_237_4) then
				if arg_234_1.var_.characterEffect404001ui_story and not isNil(var_237_4) then
					arg_234_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_234_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_5)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_5 and arg_234_1.time_ < 0 + var_237_5 + arg_237_0 and not isNil(var_237_4) and arg_234_1.var_.characterEffect404001ui_story then
				arg_234_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_234_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_2")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_237_6 = 0
			local var_237_7 = 0.575

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_8 = arg_234_1:GetWordFromCfg(322051056)
				local var_237_9 = arg_234_1:FormatText(var_237_8.content)

				arg_234_1.text_.text = var_237_9

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_11 = 23 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_9) / 23)

				if (23 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_9) / 23)) > 0 and var_237_7 < var_237_11 then
					arg_234_1.talkMaxDuration = var_237_11

					if var_237_11 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_11 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_9
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051056", "story_v_out_322051.awb") ~= 0 then
					local var_237_12 = manager.audio:GetVoiceLength("story_v_out_322051", "322051056", "story_v_out_322051.awb") / 1000

					if var_237_12 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_12 + var_237_6
					end

					if var_237_8.prefab_name ~= "" and arg_234_1.actors_[var_237_8.prefab_name] ~= nil then
						local var_237_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_8.prefab_name].transform, "story_v_out_322051", "322051056", "story_v_out_322051.awb")

						arg_234_1:RecordAudio("322051056", var_237_13)
						arg_234_1:RecordAudio("322051056", var_237_13)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_322051", "322051056", "story_v_out_322051.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_322051", "322051056", "story_v_out_322051.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_14 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_14 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_14

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_14 and arg_234_1.time_ < var_237_6 + var_237_14 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play322051057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 322051057
		arg_238_1.duration_ = 5.8

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play322051058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if arg_238_1.bgs_.L15h == nil then
				local var_241_0 = Object.Instantiate(arg_238_1.paintGo_)

				var_241_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L15h")
				var_241_0.name = "L15h"
				var_241_0.transform.parent = arg_238_1.stage_.transform
				var_241_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_238_1.bgs_.L15h = var_241_0
			end

			if 2.00000000298023 < arg_238_1.time_ and arg_238_1.time_ <= 2.00000000298023 + arg_241_0 then
				local var_241_1 = arg_238_1.bgs_.L15h

				arg_238_1.bgs_.L15h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_241_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_241_2 = var_241_1:GetComponent("SpriteRenderer")

				if var_241_2 and var_241_2.sprite then
					local var_241_3 = 2 * (var_241_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_241_1.transform.localScale = Vector3.New(var_241_3 / var_241_2.sprite.bounds.size.y < var_241_3 * manager.ui.mainCameraCom_.aspect / var_241_2.sprite.bounds.size.x and var_241_3 * manager.ui.mainCameraCom_.aspect / var_241_2.sprite.bounds.size.x or var_241_3 / var_241_2.sprite.bounds.size.y, var_241_3 / var_241_2.sprite.bounds.size.y < var_241_3 * manager.ui.mainCameraCom_.aspect / var_241_2.sprite.bounds.size.x and var_241_3 * manager.ui.mainCameraCom_.aspect / var_241_2.sprite.bounds.size.x or var_241_3 / var_241_2.sprite.bounds.size.y, 0)
				end

				for iter_241_0, iter_241_1 in pairs(arg_238_1.bgs_) do
					if iter_241_0 ~= "L15h" then
						iter_241_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_241_4 = 4

			if 4 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
				arg_238_1.allBtn_.enabled = false
			end

			if arg_238_1.time_ >= var_241_4 + 0.3 and arg_238_1.time_ < var_241_4 + 0.3 + arg_241_0 then
				arg_238_1.allBtn_.enabled = true
			end

			local var_241_5 = 0

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_5 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_6 = 2

			if var_241_5 <= arg_238_1.time_ and arg_238_1.time_ < var_241_5 + var_241_6 then
				local var_241_7 = Color.New(0, 0, 0)

				var_241_7.a = Mathf.Lerp(0, 1, (arg_238_1.time_ - var_241_5) / var_241_6)
				arg_238_1.mask_.color = var_241_7
			end

			if arg_238_1.time_ >= var_241_5 + var_241_6 and arg_238_1.time_ < var_241_5 + var_241_6 + arg_241_0 then
				local var_241_8 = Color.New(0, 0, 0)

				var_241_8.a = 1
				arg_238_1.mask_.color = var_241_8
			end

			local var_241_9 = 2

			if 2 < arg_238_1.time_ and arg_238_1.time_ <= var_241_9 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_10 = 2

			if var_241_9 <= arg_238_1.time_ and arg_238_1.time_ < var_241_9 + var_241_10 then
				local var_241_11 = Color.New(0, 0, 0)

				var_241_11.a = Mathf.Lerp(1, 0, (arg_238_1.time_ - var_241_9) / var_241_10)
				arg_238_1.mask_.color = var_241_11
			end

			if arg_238_1.time_ >= var_241_9 + var_241_10 and arg_238_1.time_ < var_241_9 + var_241_10 + arg_241_0 then
				local var_241_12 = Color.New(0, 0, 0)

				arg_238_1.mask_.enabled = false
				var_241_12.a = 0
				arg_238_1.mask_.color = var_241_12
			end

			local var_241_13 = arg_238_1.actors_["1284ui_story"].transform

			if 3.8 < arg_238_1.time_ and arg_238_1.time_ <= 3.8 + arg_241_0 then
				arg_238_1.var_.moveOldPos1284ui_story = var_241_13.localPosition
			end

			local var_241_14 = 0.001

			if 3.8 <= arg_238_1.time_ and arg_238_1.time_ < 3.8 + var_241_14 then
				var_241_13.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_238_1.time_ - 3.8) / var_241_14)
				var_241_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_13.position).x, (manager.ui.mainCamera.transform.position - var_241_13.position).y, (manager.ui.mainCamera.transform.position - var_241_13.position).z)
				var_241_13.localEulerAngles.z = 0
				var_241_13.localEulerAngles.x = 0
				var_241_13.localEulerAngles = var_241_13.localEulerAngles
			end

			if arg_238_1.time_ >= 3.8 + var_241_14 and arg_238_1.time_ < 3.8 + var_241_14 + arg_241_0 then
				var_241_13.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_241_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_13.position).x, (manager.ui.mainCamera.transform.position - var_241_13.position).y, (manager.ui.mainCamera.transform.position - var_241_13.position).z)
				var_241_13.localEulerAngles.z = 0
				var_241_13.localEulerAngles.x = 0
				var_241_13.localEulerAngles = var_241_13.localEulerAngles
			end

			local var_241_15 = arg_238_1.actors_["1284ui_story"]

			if 3.8 < arg_238_1.time_ and arg_238_1.time_ <= 3.8 + arg_241_0 and not isNil(var_241_15) and arg_238_1.var_.characterEffect1284ui_story == nil then
				arg_238_1.var_.characterEffect1284ui_story = var_241_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_16 = 0.200000002980232

			if 3.8 <= arg_238_1.time_ and arg_238_1.time_ < 3.8 + var_241_16 and not isNil(var_241_15) then
				if arg_238_1.var_.characterEffect1284ui_story and not isNil(var_241_15) then
					arg_238_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 3.8 + var_241_16 and arg_238_1.time_ < 3.8 + var_241_16 + arg_241_0 and not isNil(var_241_15) and arg_238_1.var_.characterEffect1284ui_story then
				arg_238_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 3.8 < arg_238_1.time_ and arg_238_1.time_ <= 3.8 + arg_241_0 then
				arg_238_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 3.8 < arg_238_1.time_ and arg_238_1.time_ <= 3.8 + arg_241_0 then
				arg_238_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_241_18 = arg_238_1.actors_["10104ui_story"].transform

			if 1.96599999815226 < arg_238_1.time_ and arg_238_1.time_ <= 1.96599999815226 + arg_241_0 then
				arg_238_1.var_.moveOldPos10104ui_story = var_241_18.localPosition
			end

			local var_241_19 = 0.001

			if 1.96599999815226 <= arg_238_1.time_ and arg_238_1.time_ < 1.96599999815226 + var_241_19 then
				var_241_18.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 1.96599999815226) / var_241_19)
				var_241_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_18.position).x, (manager.ui.mainCamera.transform.position - var_241_18.position).y, (manager.ui.mainCamera.transform.position - var_241_18.position).z)
				var_241_18.localEulerAngles.z = 0
				var_241_18.localEulerAngles.x = 0
				var_241_18.localEulerAngles = var_241_18.localEulerAngles
			end

			if arg_238_1.time_ >= 1.96599999815226 + var_241_19 and arg_238_1.time_ < 1.96599999815226 + var_241_19 + arg_241_0 then
				var_241_18.localPosition = Vector3.New(0, 100, 0)
				var_241_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_18.position).x, (manager.ui.mainCamera.transform.position - var_241_18.position).y, (manager.ui.mainCamera.transform.position - var_241_18.position).z)
				var_241_18.localEulerAngles.z = 0
				var_241_18.localEulerAngles.x = 0
				var_241_18.localEulerAngles = var_241_18.localEulerAngles
			end

			local var_241_20 = arg_238_1.actors_["404001ui_story"].transform

			if 1.96599999815226 < arg_238_1.time_ and arg_238_1.time_ <= 1.96599999815226 + arg_241_0 then
				arg_238_1.var_.moveOldPos404001ui_story = var_241_20.localPosition
			end

			local var_241_21 = 0.001

			if 1.96599999815226 <= arg_238_1.time_ and arg_238_1.time_ < 1.96599999815226 + var_241_21 then
				var_241_20.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 1.96599999815226) / var_241_21)
				var_241_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_20.position).x, (manager.ui.mainCamera.transform.position - var_241_20.position).y, (manager.ui.mainCamera.transform.position - var_241_20.position).z)
				var_241_20.localEulerAngles.z = 0
				var_241_20.localEulerAngles.x = 0
				var_241_20.localEulerAngles = var_241_20.localEulerAngles
			end

			if arg_238_1.time_ >= 1.96599999815226 + var_241_21 and arg_238_1.time_ < 1.96599999815226 + var_241_21 + arg_241_0 then
				var_241_20.localPosition = Vector3.New(0, 100, 0)
				var_241_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_20.position).x, (manager.ui.mainCamera.transform.position - var_241_20.position).y, (manager.ui.mainCamera.transform.position - var_241_20.position).z)
				var_241_20.localEulerAngles.z = 0
				var_241_20.localEulerAngles.x = 0
				var_241_20.localEulerAngles = var_241_20.localEulerAngles
			end

			local var_241_22 = arg_238_1.actors_["1156ui_story"].transform

			if 1.96599999815226 < arg_238_1.time_ and arg_238_1.time_ <= 1.96599999815226 + arg_241_0 then
				arg_238_1.var_.moveOldPos1156ui_story = var_241_22.localPosition
			end

			local var_241_23 = 0.001

			if 1.96599999815226 <= arg_238_1.time_ and arg_238_1.time_ < 1.96599999815226 + var_241_23 then
				var_241_22.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 1.96599999815226) / var_241_23)
				var_241_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_22.position).x, (manager.ui.mainCamera.transform.position - var_241_22.position).y, (manager.ui.mainCamera.transform.position - var_241_22.position).z)
				var_241_22.localEulerAngles.z = 0
				var_241_22.localEulerAngles.x = 0
				var_241_22.localEulerAngles = var_241_22.localEulerAngles
			end

			if arg_238_1.time_ >= 1.96599999815226 + var_241_23 and arg_238_1.time_ < 1.96599999815226 + var_241_23 + arg_241_0 then
				var_241_22.localPosition = Vector3.New(0, 100, 0)
				var_241_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_22.position).x, (manager.ui.mainCamera.transform.position - var_241_22.position).y, (manager.ui.mainCamera.transform.position - var_241_22.position).z)
				var_241_22.localEulerAngles.z = 0
				var_241_22.localEulerAngles.x = 0
				var_241_22.localEulerAngles = var_241_22.localEulerAngles
			end

			if 2.00000000298023 < arg_238_1.time_ and arg_238_1.time_ <= 2.00000000298023 + arg_241_0 then
				if arg_238_1.var_.characterEffect10104ui_story == nil then
					arg_238_1.var_.characterEffect10104ui_story = arg_238_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_241_24 = arg_238_1.var_.characterEffect10104ui_story

				arg_238_1.var_.characterEffect10104ui_story.imageEffect:turnOff()

				var_241_24.interferenceEffect.enabled = false
				var_241_24.interferenceEffect.noise = 0.001
				var_241_24.interferenceEffect.simTimeScale = 1
				var_241_24.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 2.00000000298023 < arg_238_1.time_ and arg_238_1.time_ <= 2.00000000298023 + arg_241_0 then
				if arg_238_1.var_.characterEffect10104ui_story == nil then
					arg_238_1.var_.characterEffect10104ui_story = arg_238_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_238_1.var_.characterEffect10104ui_story.imageEffect:turnOff()
			end

			if arg_238_1.frameCnt_ <= 1 then
				arg_238_1.dialog_:SetActive(false)
			end

			local var_241_26 = 4
			local var_241_27 = 0.15

			if 4 < arg_238_1.time_ and arg_238_1.time_ <= var_241_26 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0

				arg_238_1.dialog_:SetActive(true)

				arg_238_1.dialogCg_.alpha = 0

				local var_241_28 = LeanTween.value(arg_238_1.dialog_, 0, 1, 0.3)

				var_241_28:setOnUpdate(LuaHelper.FloatAction(function(arg_242_0)
					arg_238_1.dialogCg_.alpha = arg_242_0
				end))
				var_241_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_238_1.dialog_)
					var_241_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_238_1.duration_ = arg_238_1.duration_ + 0.3

				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_29 = arg_238_1:GetWordFromCfg(322051057)
				local var_241_30 = arg_238_1:FormatText(var_241_29.content)

				arg_238_1.text_.text = var_241_30

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_32 = 6 <= 0 and var_241_27 or var_241_27 * (utf8.len(var_241_30) / 6)

				if (6 <= 0 and var_241_27 or var_241_27 * (utf8.len(var_241_30) / 6)) > 0 and var_241_27 < var_241_32 then
					arg_238_1.talkMaxDuration = var_241_32
					var_241_26 = var_241_26 + 0.3

					if var_241_32 + var_241_26 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_32 + var_241_26
					end
				end

				arg_238_1.text_.text = var_241_30
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051057", "story_v_out_322051.awb") ~= 0 then
					local var_241_33 = manager.audio:GetVoiceLength("story_v_out_322051", "322051057", "story_v_out_322051.awb") / 1000

					if var_241_33 + var_241_26 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_33 + var_241_26
					end

					if var_241_29.prefab_name ~= "" and arg_238_1.actors_[var_241_29.prefab_name] ~= nil then
						local var_241_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_29.prefab_name].transform, "story_v_out_322051", "322051057", "story_v_out_322051.awb")

						arg_238_1:RecordAudio("322051057", var_241_34)
						arg_238_1:RecordAudio("322051057", var_241_34)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_322051", "322051057", "story_v_out_322051.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_322051", "322051057", "story_v_out_322051.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_35 = var_241_26 + 0.3
			local var_241_36 = math.max(var_241_27, arg_238_1.talkMaxDuration)

			if var_241_26 + 0.3 <= arg_238_1.time_ and arg_238_1.time_ < var_241_35 + var_241_36 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_35) / var_241_36

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_35 + var_241_36 and arg_238_1.time_ < var_241_35 + var_241_36 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play322051058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 322051058
		arg_244_1.duration_ = 2.87

		local var_244_0 = {
			zh = 1.999999999999,
			ja = 2.866
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play322051059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1156ui_story = arg_244_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1156ui_story, Vector3.New(0.9, -1.1, -6.18), (arg_244_1.time_ - 0) / var_247_0)
				arg_244_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1156ui_story"].transform.position).z)
				arg_244_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1156ui_story"].transform.localEulerAngles = arg_244_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0.9, -1.1, -6.18)
				arg_244_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1156ui_story"].transform.position).z)
				arg_244_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1156ui_story"].transform.localEulerAngles = arg_244_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_247_1 = arg_244_1.actors_["1156ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1156ui_story == nil then
				arg_244_1.var_.characterEffect1156ui_story = var_247_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 and not isNil(var_247_1) then
				if arg_244_1.var_.characterEffect1156ui_story and not isNil(var_247_1) then
					arg_244_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1156ui_story then
				arg_244_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_247_4 = arg_244_1.actors_["1284ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_4) and arg_244_1.var_.characterEffect1284ui_story == nil then
				arg_244_1.var_.characterEffect1284ui_story = var_247_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_5 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_5 and not isNil(var_247_4) then
				if arg_244_1.var_.characterEffect1284ui_story and not isNil(var_247_4) then
					arg_244_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_5)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_5 and arg_244_1.time_ < 0 + var_247_5 + arg_247_0 and not isNil(var_247_4) and arg_244_1.var_.characterEffect1284ui_story then
				arg_244_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_247_6 = 0
			local var_247_7 = 0.175

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_6 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_8 = arg_244_1:GetWordFromCfg(322051058)
				local var_247_9 = arg_244_1:FormatText(var_247_8.content)

				arg_244_1.text_.text = var_247_9

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_11 = 7 <= 0 and var_247_7 or var_247_7 * (utf8.len(var_247_9) / 7)

				if (7 <= 0 and var_247_7 or var_247_7 * (utf8.len(var_247_9) / 7)) > 0 and var_247_7 < var_247_11 then
					arg_244_1.talkMaxDuration = var_247_11

					if var_247_11 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_11 + var_247_6
					end
				end

				arg_244_1.text_.text = var_247_9
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051058", "story_v_out_322051.awb") ~= 0 then
					local var_247_12 = manager.audio:GetVoiceLength("story_v_out_322051", "322051058", "story_v_out_322051.awb") / 1000

					if var_247_12 + var_247_6 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_12 + var_247_6
					end

					if var_247_8.prefab_name ~= "" and arg_244_1.actors_[var_247_8.prefab_name] ~= nil then
						local var_247_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_8.prefab_name].transform, "story_v_out_322051", "322051058", "story_v_out_322051.awb")

						arg_244_1:RecordAudio("322051058", var_247_13)
						arg_244_1:RecordAudio("322051058", var_247_13)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_322051", "322051058", "story_v_out_322051.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_322051", "322051058", "story_v_out_322051.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_14 = math.max(var_247_7, arg_244_1.talkMaxDuration)

			if var_247_6 <= arg_244_1.time_ and arg_244_1.time_ < var_247_6 + var_247_14 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_6) / var_247_14

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_6 + var_247_14 and arg_244_1.time_ < var_247_6 + var_247_14 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play322051059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 322051059
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play322051060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1156ui_story = arg_248_1.actors_["1156ui_story"].transform.localPosition
			end

			local var_251_0 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				arg_248_1.actors_["1156ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1156ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1156ui_story"].transform.position).z)
				arg_248_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1156ui_story"].transform.localEulerAngles = arg_248_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				arg_248_1.actors_["1156ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_248_1.actors_["1156ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1156ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1156ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1156ui_story"].transform.position).z)
				arg_248_1.actors_["1156ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1156ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1156ui_story"].transform.localEulerAngles = arg_248_1.actors_["1156ui_story"].transform.localEulerAngles
			end

			local var_251_1 = arg_248_1.actors_["1284ui_story"].transform

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1284ui_story = var_251_1.localPosition
			end

			local var_251_2 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_2 then
				var_251_1.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_2)
				var_251_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_1.position).x, (manager.ui.mainCamera.transform.position - var_251_1.position).y, (manager.ui.mainCamera.transform.position - var_251_1.position).z)
				var_251_1.localEulerAngles.z = 0
				var_251_1.localEulerAngles.x = 0
				var_251_1.localEulerAngles = var_251_1.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_2 and arg_248_1.time_ < 0 + var_251_2 + arg_251_0 then
				var_251_1.localPosition = Vector3.New(0, 100, 0)
				var_251_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_1.position).x, (manager.ui.mainCamera.transform.position - var_251_1.position).y, (manager.ui.mainCamera.transform.position - var_251_1.position).z)
				var_251_1.localEulerAngles.z = 0
				var_251_1.localEulerAngles.x = 0
				var_251_1.localEulerAngles = var_251_1.localEulerAngles
			end

			local var_251_3 = arg_248_1.actors_["1156ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_3) and arg_248_1.var_.characterEffect1156ui_story == nil then
				arg_248_1.var_.characterEffect1156ui_story = var_251_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_4 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 and not isNil(var_251_3) then
				if arg_248_1.var_.characterEffect1156ui_story and not isNil(var_251_3) then
					arg_248_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_248_1.var_.characterEffect1156ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_248_1.time_ - 0) / var_251_4)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 and not isNil(var_251_3) and arg_248_1.var_.characterEffect1156ui_story then
				arg_248_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_248_1.var_.characterEffect1156ui_story.fillRatio = 0.5
			end

			local var_251_5 = 0
			local var_251_6 = 1.1

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_5 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_7 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(322051059).content)

				arg_248_1.text_.text = var_251_7

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_9 = 44 <= 0 and var_251_6 or var_251_6 * (utf8.len(var_251_7) / 44)

				if (44 <= 0 and var_251_6 or var_251_6 * (utf8.len(var_251_7) / 44)) > 0 and var_251_6 < var_251_9 then
					arg_248_1.talkMaxDuration = var_251_9

					if var_251_9 + var_251_5 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_9 + var_251_5
					end
				end

				arg_248_1.text_.text = var_251_7
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_6, arg_248_1.talkMaxDuration)

			if var_251_5 <= arg_248_1.time_ and arg_248_1.time_ < var_251_5 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_5) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_5 + var_251_10 and arg_248_1.time_ < var_251_5 + var_251_10 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_248_1:InitPlayNodeList()
	end,
	Play322051060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 322051060
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play322051061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 1

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_1 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(322051060).content)

				arg_252_1.text_.text = var_255_1

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_3 = 40 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 40)

				if (40 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 40)) > 0 and var_255_0 < var_255_3 then
					arg_252_1.talkMaxDuration = var_255_3

					if var_255_3 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_3 + 0
					end
				end

				arg_252_1.text_.text = var_255_1
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_4 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_4

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play322051061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 322051061
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play322051062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0.466666666666667 < arg_256_1.time_ and arg_256_1.time_ <= 0.466666666666667 + arg_259_0 then
				arg_256_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire02", "")
			end

			local var_259_1 = 0
			local var_259_2 = 0.975

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_3 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(322051061).content)

				arg_256_1.text_.text = var_259_3

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 39 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 39)

				if (39 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 39)) > 0 and var_259_2 < var_259_5 then
					arg_256_1.talkMaxDuration = var_259_5

					if var_259_5 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + var_259_1
					end
				end

				arg_256_1.text_.text = var_259_3
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_6 = math.max(var_259_2, arg_256_1.talkMaxDuration)

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_6 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_1) / var_259_6

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_1 + var_259_6 and arg_256_1.time_ < var_259_1 + var_259_6 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play322051062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 322051062
		arg_260_1.duration_ = 2.37

		local var_260_0 = {
			zh = 1.999999999999,
			ja = 2.366
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play322051063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos1284ui_story = arg_260_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_263_0 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 then
				arg_260_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_260_1.time_ - 0) / var_263_0)
				arg_260_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1284ui_story"].transform.position).z)
				arg_260_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1284ui_story"].transform.localEulerAngles = arg_260_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 then
				arg_260_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_260_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["1284ui_story"].transform.position).z)
				arg_260_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["1284ui_story"].transform.localEulerAngles = arg_260_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_263_1 = arg_260_1.actors_["1284ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect1284ui_story == nil then
				arg_260_1.var_.characterEffect1284ui_story = var_263_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_2 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_2 and not isNil(var_263_1) then
				if arg_260_1.var_.characterEffect1284ui_story and not isNil(var_263_1) then
					arg_260_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_2 and arg_260_1.time_ < 0 + var_263_2 + arg_263_0 and not isNil(var_263_1) and arg_260_1.var_.characterEffect1284ui_story then
				arg_260_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_263_4 = 0
			local var_263_5 = 0.3

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_6 = arg_260_1:GetWordFromCfg(322051062)
				local var_263_7 = arg_260_1:FormatText(var_263_6.content)

				arg_260_1.text_.text = var_263_7

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_9 = 12 <= 0 and var_263_5 or var_263_5 * (utf8.len(var_263_7) / 12)

				if (12 <= 0 and var_263_5 or var_263_5 * (utf8.len(var_263_7) / 12)) > 0 and var_263_5 < var_263_9 then
					arg_260_1.talkMaxDuration = var_263_9

					if var_263_9 + var_263_4 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_9 + var_263_4
					end
				end

				arg_260_1.text_.text = var_263_7
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051062", "story_v_out_322051.awb") ~= 0 then
					local var_263_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051062", "story_v_out_322051.awb") / 1000

					if var_263_10 + var_263_4 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_10 + var_263_4
					end

					if var_263_6.prefab_name ~= "" and arg_260_1.actors_[var_263_6.prefab_name] ~= nil then
						local var_263_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_6.prefab_name].transform, "story_v_out_322051", "322051062", "story_v_out_322051.awb")

						arg_260_1:RecordAudio("322051062", var_263_11)
						arg_260_1:RecordAudio("322051062", var_263_11)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_322051", "322051062", "story_v_out_322051.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_322051", "322051062", "story_v_out_322051.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_12 = math.max(var_263_5, arg_260_1.talkMaxDuration)

			if var_263_4 <= arg_260_1.time_ and arg_260_1.time_ < var_263_4 + var_263_12 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_4) / var_263_12

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_4 + var_263_12 and arg_260_1.time_ < var_263_4 + var_263_12 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
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

		arg_260_1:InitPlayNodeList()
	end,
	Play322051063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 322051063
		arg_264_1.duration_ = 5.67

		local var_264_0 = {
			zh = 3.6,
			ja = 5.666
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play322051064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos404001ui_story = arg_264_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_267_0 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 then
				arg_264_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos404001ui_story, Vector3.New(0.8, -1.55, -5.5), (arg_264_1.time_ - 0) / var_267_0)
				arg_264_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["404001ui_story"].transform.position).z)
				arg_264_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["404001ui_story"].transform.localEulerAngles = arg_264_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 then
				arg_264_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0.8, -1.55, -5.5)
				arg_264_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["404001ui_story"].transform.position).z)
				arg_264_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["404001ui_story"].transform.localEulerAngles = arg_264_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_267_1 = arg_264_1.actors_["404001ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_1) and arg_264_1.var_.characterEffect404001ui_story == nil then
				arg_264_1.var_.characterEffect404001ui_story = var_267_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_2 and not isNil(var_267_1) then
				if arg_264_1.var_.characterEffect404001ui_story and not isNil(var_267_1) then
					arg_264_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_2 and arg_264_1.time_ < 0 + var_267_2 + arg_267_0 and not isNil(var_267_1) and arg_264_1.var_.characterEffect404001ui_story then
				arg_264_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_267_4 = arg_264_1.actors_["1284ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_4) and arg_264_1.var_.characterEffect1284ui_story == nil then
				arg_264_1.var_.characterEffect1284ui_story = var_267_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_5 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_5 and not isNil(var_267_4) then
				if arg_264_1.var_.characterEffect1284ui_story and not isNil(var_267_4) then
					arg_264_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_264_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_264_1.time_ - 0) / var_267_5)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_5 and arg_264_1.time_ < 0 + var_267_5 + arg_267_0 and not isNil(var_267_4) and arg_264_1.var_.characterEffect1284ui_story then
				arg_264_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_264_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_267_6 = 0
			local var_267_7 = 0.4

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_6 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_8 = arg_264_1:GetWordFromCfg(322051063)
				local var_267_9 = arg_264_1:FormatText(var_267_8.content)

				arg_264_1.text_.text = var_267_9

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_11 = 16 <= 0 and var_267_7 or var_267_7 * (utf8.len(var_267_9) / 16)

				if (16 <= 0 and var_267_7 or var_267_7 * (utf8.len(var_267_9) / 16)) > 0 and var_267_7 < var_267_11 then
					arg_264_1.talkMaxDuration = var_267_11

					if var_267_11 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_11 + var_267_6
					end
				end

				arg_264_1.text_.text = var_267_9
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051063", "story_v_out_322051.awb") ~= 0 then
					local var_267_12 = manager.audio:GetVoiceLength("story_v_out_322051", "322051063", "story_v_out_322051.awb") / 1000

					if var_267_12 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_12 + var_267_6
					end

					if var_267_8.prefab_name ~= "" and arg_264_1.actors_[var_267_8.prefab_name] ~= nil then
						local var_267_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_8.prefab_name].transform, "story_v_out_322051", "322051063", "story_v_out_322051.awb")

						arg_264_1:RecordAudio("322051063", var_267_13)
						arg_264_1:RecordAudio("322051063", var_267_13)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_322051", "322051063", "story_v_out_322051.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_322051", "322051063", "story_v_out_322051.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_14 = math.max(var_267_7, arg_264_1.talkMaxDuration)

			if var_267_6 <= arg_264_1.time_ and arg_264_1.time_ < var_267_6 + var_267_14 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_6) / var_267_14

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_6 + var_267_14 and arg_264_1.time_ < var_267_6 + var_267_14 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
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

		arg_264_1:InitPlayNodeList()
	end,
	Play322051064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 322051064
		arg_268_1.duration_ = 6.3

		local var_268_0 = {
			zh = 3.066,
			ja = 6.3
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play322051065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1284ui_story"]) and arg_268_1.var_.characterEffect1284ui_story == nil then
				arg_268_1.var_.characterEffect1284ui_story = arg_268_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1284ui_story"]) then
				if arg_268_1.var_.characterEffect1284ui_story and not isNil(arg_268_1.actors_["1284ui_story"]) then
					arg_268_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1284ui_story"]) and arg_268_1.var_.characterEffect1284ui_story then
				arg_268_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_271_2 = arg_268_1.actors_["404001ui_story"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_2) and arg_268_1.var_.characterEffect404001ui_story == nil then
				arg_268_1.var_.characterEffect404001ui_story = var_271_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_3 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_3 and not isNil(var_271_2) then
				if arg_268_1.var_.characterEffect404001ui_story and not isNil(var_271_2) then
					arg_268_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_268_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_268_1.time_ - 0) / var_271_3)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_3 and arg_268_1.time_ < 0 + var_271_3 + arg_271_0 and not isNil(var_271_2) and arg_268_1.var_.characterEffect404001ui_story then
				arg_268_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_268_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_2")
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_271_4 = 0
			local var_271_5 = 0.425

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_4 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_6 = arg_268_1:GetWordFromCfg(322051064)
				local var_271_7 = arg_268_1:FormatText(var_271_6.content)

				arg_268_1.text_.text = var_271_7

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_9 = 17 <= 0 and var_271_5 or var_271_5 * (utf8.len(var_271_7) / 17)

				if (17 <= 0 and var_271_5 or var_271_5 * (utf8.len(var_271_7) / 17)) > 0 and var_271_5 < var_271_9 then
					arg_268_1.talkMaxDuration = var_271_9

					if var_271_9 + var_271_4 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_9 + var_271_4
					end
				end

				arg_268_1.text_.text = var_271_7
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051064", "story_v_out_322051.awb") ~= 0 then
					local var_271_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051064", "story_v_out_322051.awb") / 1000

					if var_271_10 + var_271_4 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_10 + var_271_4
					end

					if var_271_6.prefab_name ~= "" and arg_268_1.actors_[var_271_6.prefab_name] ~= nil then
						local var_271_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_6.prefab_name].transform, "story_v_out_322051", "322051064", "story_v_out_322051.awb")

						arg_268_1:RecordAudio("322051064", var_271_11)
						arg_268_1:RecordAudio("322051064", var_271_11)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_322051", "322051064", "story_v_out_322051.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_322051", "322051064", "story_v_out_322051.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_12 = math.max(var_271_5, arg_268_1.talkMaxDuration)

			if var_271_4 <= arg_268_1.time_ and arg_268_1.time_ < var_271_4 + var_271_12 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_4) / var_271_12

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_4 + var_271_12 and arg_268_1.time_ < var_271_4 + var_271_12 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play322051065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 322051065
		arg_272_1.duration_ = 5.33

		local var_272_0 = {
			zh = 5.333,
			ja = 4.166
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play322051066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["404001ui_story"]) and arg_272_1.var_.characterEffect404001ui_story == nil then
				arg_272_1.var_.characterEffect404001ui_story = arg_272_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_0 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["404001ui_story"]) then
				if arg_272_1.var_.characterEffect404001ui_story and not isNil(arg_272_1.actors_["404001ui_story"]) then
					arg_272_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["404001ui_story"]) and arg_272_1.var_.characterEffect404001ui_story then
				arg_272_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_275_2 = arg_272_1.actors_["1284ui_story"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_2) and arg_272_1.var_.characterEffect1284ui_story == nil then
				arg_272_1.var_.characterEffect1284ui_story = var_275_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_3 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_3 and not isNil(var_275_2) then
				if arg_272_1.var_.characterEffect1284ui_story and not isNil(var_275_2) then
					arg_272_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_272_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_272_1.time_ - 0) / var_275_3)
				end
			end

			if arg_272_1.time_ >= 0 + var_275_3 and arg_272_1.time_ < 0 + var_275_3 + arg_275_0 and not isNil(var_275_2) and arg_272_1.var_.characterEffect1284ui_story then
				arg_272_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_272_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_275_4 = 0
			local var_275_5 = 0.675

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_4 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_6 = arg_272_1:GetWordFromCfg(322051065)
				local var_275_7 = arg_272_1:FormatText(var_275_6.content)

				arg_272_1.text_.text = var_275_7

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_9 = 27 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 27)

				if (27 <= 0 and var_275_5 or var_275_5 * (utf8.len(var_275_7) / 27)) > 0 and var_275_5 < var_275_9 then
					arg_272_1.talkMaxDuration = var_275_9

					if var_275_9 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_9 + var_275_4
					end
				end

				arg_272_1.text_.text = var_275_7
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051065", "story_v_out_322051.awb") ~= 0 then
					local var_275_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051065", "story_v_out_322051.awb") / 1000

					if var_275_10 + var_275_4 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_10 + var_275_4
					end

					if var_275_6.prefab_name ~= "" and arg_272_1.actors_[var_275_6.prefab_name] ~= nil then
						local var_275_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_6.prefab_name].transform, "story_v_out_322051", "322051065", "story_v_out_322051.awb")

						arg_272_1:RecordAudio("322051065", var_275_11)
						arg_272_1:RecordAudio("322051065", var_275_11)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_322051", "322051065", "story_v_out_322051.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_322051", "322051065", "story_v_out_322051.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_12 = math.max(var_275_5, arg_272_1.talkMaxDuration)

			if var_275_4 <= arg_272_1.time_ and arg_272_1.time_ < var_275_4 + var_275_12 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_4) / var_275_12

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_4 + var_275_12 and arg_272_1.time_ < var_275_4 + var_275_12 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play322051066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 322051066
		arg_276_1.duration_ = 11.07

		local var_276_0 = {
			zh = 10.633,
			ja = 11.066
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play322051067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_279_0 = 0
			local var_279_1 = 1.35

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_2 = arg_276_1:GetWordFromCfg(322051066)
				local var_279_3 = arg_276_1:FormatText(var_279_2.content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 54 <= 0 and var_279_1 or var_279_1 * (utf8.len(var_279_3) / 54)

				if (54 <= 0 and var_279_1 or var_279_1 * (utf8.len(var_279_3) / 54)) > 0 and var_279_1 < var_279_5 then
					arg_276_1.talkMaxDuration = var_279_5

					if var_279_5 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + var_279_0
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051066", "story_v_out_322051.awb") ~= 0 then
					local var_279_6 = manager.audio:GetVoiceLength("story_v_out_322051", "322051066", "story_v_out_322051.awb") / 1000

					if var_279_6 + var_279_0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_6 + var_279_0
					end

					if var_279_2.prefab_name ~= "" and arg_276_1.actors_[var_279_2.prefab_name] ~= nil then
						local var_279_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_2.prefab_name].transform, "story_v_out_322051", "322051066", "story_v_out_322051.awb")

						arg_276_1:RecordAudio("322051066", var_279_7)
						arg_276_1:RecordAudio("322051066", var_279_7)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_322051", "322051066", "story_v_out_322051.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_322051", "322051066", "story_v_out_322051.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_8 = math.max(var_279_1, arg_276_1.talkMaxDuration)

			if var_279_0 <= arg_276_1.time_ and arg_276_1.time_ < var_279_0 + var_279_8 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_0) / var_279_8

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_0 + var_279_8 and arg_276_1.time_ < var_279_0 + var_279_8 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play322051067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 322051067
		arg_280_1.duration_ = 6.7

		local var_280_0 = {
			zh = 6.2,
			ja = 6.7
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play322051068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1284ui_story"]) and arg_280_1.var_.characterEffect1284ui_story == nil then
				arg_280_1.var_.characterEffect1284ui_story = arg_280_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1284ui_story"]) then
				if arg_280_1.var_.characterEffect1284ui_story and not isNil(arg_280_1.actors_["1284ui_story"]) then
					arg_280_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1284ui_story"]) and arg_280_1.var_.characterEffect1284ui_story then
				arg_280_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_283_2 = arg_280_1.actors_["404001ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_2) and arg_280_1.var_.characterEffect404001ui_story == nil then
				arg_280_1.var_.characterEffect404001ui_story = var_283_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_3 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_3 and not isNil(var_283_2) then
				if arg_280_1.var_.characterEffect404001ui_story and not isNil(var_283_2) then
					arg_280_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_280_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_3)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_3 and arg_280_1.time_ < 0 + var_283_3 + arg_283_0 and not isNil(var_283_2) and arg_280_1.var_.characterEffect404001ui_story then
				arg_280_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_280_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_283_4 = 0
			local var_283_5 = 0.65

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_6 = arg_280_1:GetWordFromCfg(322051067)
				local var_283_7 = arg_280_1:FormatText(var_283_6.content)

				arg_280_1.text_.text = var_283_7

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_9 = 26 <= 0 and var_283_5 or var_283_5 * (utf8.len(var_283_7) / 26)

				if (26 <= 0 and var_283_5 or var_283_5 * (utf8.len(var_283_7) / 26)) > 0 and var_283_5 < var_283_9 then
					arg_280_1.talkMaxDuration = var_283_9

					if var_283_9 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_9 + var_283_4
					end
				end

				arg_280_1.text_.text = var_283_7
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051067", "story_v_out_322051.awb") ~= 0 then
					local var_283_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051067", "story_v_out_322051.awb") / 1000

					if var_283_10 + var_283_4 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_10 + var_283_4
					end

					if var_283_6.prefab_name ~= "" and arg_280_1.actors_[var_283_6.prefab_name] ~= nil then
						local var_283_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_6.prefab_name].transform, "story_v_out_322051", "322051067", "story_v_out_322051.awb")

						arg_280_1:RecordAudio("322051067", var_283_11)
						arg_280_1:RecordAudio("322051067", var_283_11)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_322051", "322051067", "story_v_out_322051.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_322051", "322051067", "story_v_out_322051.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_12 = math.max(var_283_5, arg_280_1.talkMaxDuration)

			if var_283_4 <= arg_280_1.time_ and arg_280_1.time_ < var_283_4 + var_283_12 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_4) / var_283_12

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_4 + var_283_12 and arg_280_1.time_ < var_283_4 + var_283_12 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play322051068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 322051068
		arg_284_1.duration_ = 15.3

		local var_284_0 = {
			zh = 9.6,
			ja = 15.3
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play322051069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_2")
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_287_0 = 0
			local var_287_1 = 1.2

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_2 = arg_284_1:GetWordFromCfg(322051068)
				local var_287_3 = arg_284_1:FormatText(var_287_2.content)

				arg_284_1.text_.text = var_287_3

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 49 <= 0 and var_287_1 or var_287_1 * (utf8.len(var_287_3) / 49)

				if (49 <= 0 and var_287_1 or var_287_1 * (utf8.len(var_287_3) / 49)) > 0 and var_287_1 < var_287_5 then
					arg_284_1.talkMaxDuration = var_287_5

					if var_287_5 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + var_287_0
					end
				end

				arg_284_1.text_.text = var_287_3
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051068", "story_v_out_322051.awb") ~= 0 then
					local var_287_6 = manager.audio:GetVoiceLength("story_v_out_322051", "322051068", "story_v_out_322051.awb") / 1000

					if var_287_6 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_6 + var_287_0
					end

					if var_287_2.prefab_name ~= "" and arg_284_1.actors_[var_287_2.prefab_name] ~= nil then
						local var_287_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_2.prefab_name].transform, "story_v_out_322051", "322051068", "story_v_out_322051.awb")

						arg_284_1:RecordAudio("322051068", var_287_7)
						arg_284_1:RecordAudio("322051068", var_287_7)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_322051", "322051068", "story_v_out_322051.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_322051", "322051068", "story_v_out_322051.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_8 = math.max(var_287_1, arg_284_1.talkMaxDuration)

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_8 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_0) / var_287_8

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_0 + var_287_8 and arg_284_1.time_ < var_287_0 + var_287_8 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play322051069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 322051069
		arg_288_1.duration_ = 3.57

		local var_288_0 = {
			zh = 3.566,
			ja = 3.3
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play322051070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(arg_288_1.actors_["404001ui_story"]) and arg_288_1.var_.characterEffect404001ui_story == nil then
				arg_288_1.var_.characterEffect404001ui_story = arg_288_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_0 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 and not isNil(arg_288_1.actors_["404001ui_story"]) then
				if arg_288_1.var_.characterEffect404001ui_story and not isNil(arg_288_1.actors_["404001ui_story"]) then
					arg_288_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 and not isNil(arg_288_1.actors_["404001ui_story"]) and arg_288_1.var_.characterEffect404001ui_story then
				arg_288_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_291_2 = arg_288_1.actors_["1284ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_2) and arg_288_1.var_.characterEffect1284ui_story == nil then
				arg_288_1.var_.characterEffect1284ui_story = var_291_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_3 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_3 and not isNil(var_291_2) then
				if arg_288_1.var_.characterEffect1284ui_story and not isNil(var_291_2) then
					arg_288_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_288_1.time_ - 0) / var_291_3)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_3 and arg_288_1.time_ < 0 + var_291_3 + arg_291_0 and not isNil(var_291_2) and arg_288_1.var_.characterEffect1284ui_story then
				arg_288_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_2")
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_291_4 = 0
			local var_291_5 = 0.35

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_6 = arg_288_1:GetWordFromCfg(322051069)
				local var_291_7 = arg_288_1:FormatText(var_291_6.content)

				arg_288_1.text_.text = var_291_7

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_9 = 14 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 14)

				if (14 <= 0 and var_291_5 or var_291_5 * (utf8.len(var_291_7) / 14)) > 0 and var_291_5 < var_291_9 then
					arg_288_1.talkMaxDuration = var_291_9

					if var_291_9 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_9 + var_291_4
					end
				end

				arg_288_1.text_.text = var_291_7
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051069", "story_v_out_322051.awb") ~= 0 then
					local var_291_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051069", "story_v_out_322051.awb") / 1000

					if var_291_10 + var_291_4 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_10 + var_291_4
					end

					if var_291_6.prefab_name ~= "" and arg_288_1.actors_[var_291_6.prefab_name] ~= nil then
						local var_291_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_6.prefab_name].transform, "story_v_out_322051", "322051069", "story_v_out_322051.awb")

						arg_288_1:RecordAudio("322051069", var_291_11)
						arg_288_1:RecordAudio("322051069", var_291_11)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_322051", "322051069", "story_v_out_322051.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_322051", "322051069", "story_v_out_322051.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_12 = math.max(var_291_5, arg_288_1.talkMaxDuration)

			if var_291_4 <= arg_288_1.time_ and arg_288_1.time_ < var_291_4 + var_291_12 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_4) / var_291_12

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_4 + var_291_12 and arg_288_1.time_ < var_291_4 + var_291_12 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play322051070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 322051070
		arg_292_1.duration_ = 8.77

		local var_292_0 = {
			zh = 7.133,
			ja = 8.766
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play322051071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["1284ui_story"]) and arg_292_1.var_.characterEffect1284ui_story == nil then
				arg_292_1.var_.characterEffect1284ui_story = arg_292_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_0 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["1284ui_story"]) then
				if arg_292_1.var_.characterEffect1284ui_story and not isNil(arg_292_1.actors_["1284ui_story"]) then
					arg_292_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["1284ui_story"]) and arg_292_1.var_.characterEffect1284ui_story then
				arg_292_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_295_2 = arg_292_1.actors_["404001ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_2) and arg_292_1.var_.characterEffect404001ui_story == nil then
				arg_292_1.var_.characterEffect404001ui_story = var_295_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_3 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_3 and not isNil(var_295_2) then
				if arg_292_1.var_.characterEffect404001ui_story and not isNil(var_295_2) then
					arg_292_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_292_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_3)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_3 and arg_292_1.time_ < 0 + var_295_3 + arg_295_0 and not isNil(var_295_2) and arg_292_1.var_.characterEffect404001ui_story then
				arg_292_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_292_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_295_4 = 0
			local var_295_5 = 0.875

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_4 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_6 = arg_292_1:GetWordFromCfg(322051070)
				local var_295_7 = arg_292_1:FormatText(var_295_6.content)

				arg_292_1.text_.text = var_295_7

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_9 = 35 <= 0 and var_295_5 or var_295_5 * (utf8.len(var_295_7) / 35)

				if (35 <= 0 and var_295_5 or var_295_5 * (utf8.len(var_295_7) / 35)) > 0 and var_295_5 < var_295_9 then
					arg_292_1.talkMaxDuration = var_295_9

					if var_295_9 + var_295_4 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_9 + var_295_4
					end
				end

				arg_292_1.text_.text = var_295_7
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051070", "story_v_out_322051.awb") ~= 0 then
					local var_295_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051070", "story_v_out_322051.awb") / 1000

					if var_295_10 + var_295_4 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_10 + var_295_4
					end

					if var_295_6.prefab_name ~= "" and arg_292_1.actors_[var_295_6.prefab_name] ~= nil then
						local var_295_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_6.prefab_name].transform, "story_v_out_322051", "322051070", "story_v_out_322051.awb")

						arg_292_1:RecordAudio("322051070", var_295_11)
						arg_292_1:RecordAudio("322051070", var_295_11)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_322051", "322051070", "story_v_out_322051.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_322051", "322051070", "story_v_out_322051.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_12 = math.max(var_295_5, arg_292_1.talkMaxDuration)

			if var_295_4 <= arg_292_1.time_ and arg_292_1.time_ < var_295_4 + var_295_12 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_4) / var_295_12

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_4 + var_295_12 and arg_292_1.time_ < var_295_4 + var_295_12 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play322051071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 322051071
		arg_296_1.duration_ = 5.23

		local var_296_0 = {
			zh = 3.533,
			ja = 5.233
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play322051072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["404001ui_story"]) and arg_296_1.var_.characterEffect404001ui_story == nil then
				arg_296_1.var_.characterEffect404001ui_story = arg_296_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_0 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["404001ui_story"]) then
				if arg_296_1.var_.characterEffect404001ui_story and not isNil(arg_296_1.actors_["404001ui_story"]) then
					arg_296_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["404001ui_story"]) and arg_296_1.var_.characterEffect404001ui_story then
				arg_296_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_299_2 = arg_296_1.actors_["1284ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.characterEffect1284ui_story == nil then
				arg_296_1.var_.characterEffect1284ui_story = var_299_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_3 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_3 and not isNil(var_299_2) then
				if arg_296_1.var_.characterEffect1284ui_story and not isNil(var_299_2) then
					arg_296_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 0) / var_299_3)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_3 and arg_296_1.time_ < 0 + var_299_3 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.characterEffect1284ui_story then
				arg_296_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_299_4 = 0
			local var_299_5 = 0.425

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_6 = arg_296_1:GetWordFromCfg(322051071)
				local var_299_7 = arg_296_1:FormatText(var_299_6.content)

				arg_296_1.text_.text = var_299_7

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_9 = 17 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 17)

				if (17 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 17)) > 0 and var_299_5 < var_299_9 then
					arg_296_1.talkMaxDuration = var_299_9

					if var_299_9 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_9 + var_299_4
					end
				end

				arg_296_1.text_.text = var_299_7
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051071", "story_v_out_322051.awb") ~= 0 then
					local var_299_10 = manager.audio:GetVoiceLength("story_v_out_322051", "322051071", "story_v_out_322051.awb") / 1000

					if var_299_10 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_4
					end

					if var_299_6.prefab_name ~= "" and arg_296_1.actors_[var_299_6.prefab_name] ~= nil then
						local var_299_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_6.prefab_name].transform, "story_v_out_322051", "322051071", "story_v_out_322051.awb")

						arg_296_1:RecordAudio("322051071", var_299_11)
						arg_296_1:RecordAudio("322051071", var_299_11)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_322051", "322051071", "story_v_out_322051.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_322051", "322051071", "story_v_out_322051.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_12 = math.max(var_299_5, arg_296_1.talkMaxDuration)

			if var_299_4 <= arg_296_1.time_ and arg_296_1.time_ < var_299_4 + var_299_12 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_4) / var_299_12

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_4 + var_299_12 and arg_296_1.time_ < var_299_4 + var_299_12 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play322051072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 322051072
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play322051073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos404001ui_story = arg_300_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_303_0 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 then
				arg_300_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_300_1.time_ - 0) / var_303_0)
				arg_300_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["404001ui_story"].transform.position).z)
				arg_300_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["404001ui_story"].transform.localEulerAngles = arg_300_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 then
				arg_300_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_300_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_300_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_300_1.actors_["404001ui_story"].transform.position).z)
				arg_300_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_300_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_300_1.actors_["404001ui_story"].transform.localEulerAngles = arg_300_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_303_1 = arg_300_1.actors_["1284ui_story"].transform

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1284ui_story = var_303_1.localPosition
			end

			local var_303_2 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_2 then
				var_303_1.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_300_1.time_ - 0) / var_303_2)
				var_303_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_1.position).x, (manager.ui.mainCamera.transform.position - var_303_1.position).y, (manager.ui.mainCamera.transform.position - var_303_1.position).z)
				var_303_1.localEulerAngles.z = 0
				var_303_1.localEulerAngles.x = 0
				var_303_1.localEulerAngles = var_303_1.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_2 and arg_300_1.time_ < 0 + var_303_2 + arg_303_0 then
				var_303_1.localPosition = Vector3.New(0, 100, 0)
				var_303_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_1.position).x, (manager.ui.mainCamera.transform.position - var_303_1.position).y, (manager.ui.mainCamera.transform.position - var_303_1.position).z)
				var_303_1.localEulerAngles.z = 0
				var_303_1.localEulerAngles.x = 0
				var_303_1.localEulerAngles = var_303_1.localEulerAngles
			end

			if 0.034000001847744 < arg_300_1.time_ and arg_300_1.time_ <= 0.034000001847744 + arg_303_0 then
				arg_300_1:AudioAction("play", "effect", "se_story_140", "se_story_140_tentacle1", "")
			end

			local var_303_4 = 0
			local var_303_5 = 1.475

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, false)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_6 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(322051072).content)

				arg_300_1.text_.text = var_303_6

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_8 = 59 <= 0 and var_303_5 or var_303_5 * (utf8.len(var_303_6) / 59)

				if (59 <= 0 and var_303_5 or var_303_5 * (utf8.len(var_303_6) / 59)) > 0 and var_303_5 < var_303_8 then
					arg_300_1.talkMaxDuration = var_303_8

					if var_303_8 + var_303_4 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_8 + var_303_4
					end
				end

				arg_300_1.text_.text = var_303_6
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_9 = math.max(var_303_5, arg_300_1.talkMaxDuration)

			if var_303_4 <= arg_300_1.time_ and arg_300_1.time_ < var_303_4 + var_303_9 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_4) / var_303_9

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_4 + var_303_9 and arg_300_1.time_ < var_303_4 + var_303_9 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_300_1:InitPlayNodeList()
	end,
	Play322051073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 322051073
		arg_304_1.duration_ = 5

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play322051074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0.7 < arg_304_1.time_ and arg_304_1.time_ <= 0.7 + arg_307_0 then
				arg_304_1:AudioAction("play", "effect", "se_story_145", "se_story_145_put_down", "")
			end

			local var_307_1 = 0
			local var_307_2 = 1.875

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_3 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(322051073).content)

				arg_304_1.text_.text = var_307_3

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_5 = 75 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 75)

				if (75 <= 0 and var_307_2 or var_307_2 * (utf8.len(var_307_3) / 75)) > 0 and var_307_2 < var_307_5 then
					arg_304_1.talkMaxDuration = var_307_5

					if var_307_5 + var_307_1 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + var_307_1
					end
				end

				arg_304_1.text_.text = var_307_3
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_6 = math.max(var_307_2, arg_304_1.talkMaxDuration)

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_6 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_1) / var_307_6

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_1 + var_307_6 and arg_304_1.time_ < var_307_1 + var_307_6 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play322051074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 322051074
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play322051075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0.05

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_1 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(322051074).content)

				arg_308_1.text_.text = var_311_1

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_3 = 2 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 2)

				if (2 <= 0 and var_311_0 or var_311_0 * (utf8.len(var_311_1) / 2)) > 0 and var_311_0 < var_311_3 then
					arg_308_1.talkMaxDuration = var_311_3

					if var_311_3 + 0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_3 + 0
					end
				end

				arg_308_1.text_.text = var_311_1
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_4 = math.max(var_311_0, arg_308_1.talkMaxDuration)

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - 0) / var_311_4

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play322051075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 322051075
		arg_312_1.duration_ = 7

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play322051076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_9001
			local var_315_9000

			if 4.06666666666667 < arg_312_1.time_ and arg_312_1.time_ <= 4.06666666666667 + arg_315_0 then
				arg_312_1:AudioAction("play", "effect", "se_story_143", "se_story_143_magic_fire", "")
			end

			if 2.1 < arg_312_1.time_ and arg_312_1.time_ <= 2.1 + arg_315_0 then
				local var_315_1 = arg_312_1.var_.effect1075

				if not arg_312_1.var_.effect1075 then
					var_315_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), manager.ui.mainCamera.transform)
					var_315_1.name = "1075"
					arg_312_1.var_.effect1075 = var_315_1
				else
					var_315_1.transform:SetParent(var_315_9001)
				end

				var_315_1.transform.localPosition = Vector3.New(0, 0, -2)
				var_315_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_315_1.transform.localScale = Vector3.New(var_315_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_315_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_315_1.transform.localScale.z)
			end

			local var_315_3 = 0

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_3 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_4 = 2

			if var_315_3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_3 + var_315_4 then
				local var_315_5 = Color.New(0, 0, 0)

				var_315_5.a = Mathf.Lerp(0, 1, (arg_312_1.time_ - var_315_3) / var_315_4)
				arg_312_1.mask_.color = var_315_5
			end

			if arg_312_1.time_ >= var_315_3 + var_315_4 and arg_312_1.time_ < var_315_3 + var_315_4 + arg_315_0 then
				local var_315_6 = Color.New(0, 0, 0)

				var_315_6.a = 1
				arg_312_1.mask_.color = var_315_6
			end

			local var_315_7 = 2

			if 2 < arg_312_1.time_ and arg_312_1.time_ <= var_315_7 + arg_315_0 then
				arg_312_1.mask_.enabled = true
				arg_312_1.mask_.raycastTarget = true

				arg_312_1:SetGaussion(false)
			end

			local var_315_8 = 2

			if var_315_7 <= arg_312_1.time_ and arg_312_1.time_ < var_315_7 + var_315_8 then
				local var_315_9 = Color.New(0, 0, 0)

				var_315_9.a = Mathf.Lerp(1, 0, (arg_312_1.time_ - var_315_7) / var_315_8)
				arg_312_1.mask_.color = var_315_9
			end

			if arg_312_1.time_ >= var_315_7 + var_315_8 and arg_312_1.time_ < var_315_7 + var_315_8 + arg_315_0 then
				local var_315_10 = Color.New(0, 0, 0)

				arg_312_1.mask_.enabled = false
				var_315_10.a = 0
				arg_312_1.mask_.color = var_315_10
			end

			if 2.2 < arg_312_1.time_ and arg_312_1.time_ <= 2.2 + arg_315_0 then
				arg_312_1:AudioAction("play", "effect", "se_story_side_1068", "se_story_1068_footstep", "")
			end

			if 2.1 < arg_312_1.time_ and arg_312_1.time_ <= 2.1 + arg_315_0 then
				local var_315_12 = arg_312_1.var_.effect1076

				if not arg_312_1.var_.effect1076 then
					var_315_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_wasteland_in_keep"), manager.ui.mainCamera.transform)
					var_315_12.name = "1076"
					arg_312_1.var_.effect1076 = var_315_12
				else
					var_315_12.transform:SetParent(var_315_9000)
				end

				var_315_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_315_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_312_1.time_ and arg_312_1.time_ <= 2 + arg_315_0 then
				arg_312_1:AudioAction("play", "effect", "se_story_145", "se_story_145_fire04_loop", "")
			end

			if arg_312_1.frameCnt_ <= 1 then
				arg_312_1.dialog_:SetActive(false)
			end

			local var_315_15 = 2
			local var_315_16 = 1.425

			if 2 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0

				arg_312_1.dialog_:SetActive(true)

				arg_312_1.dialogCg_.alpha = 0

				local var_315_17 = LeanTween.value(arg_312_1.dialog_, 0, 1, 0.3)

				var_315_17:setOnUpdate(LuaHelper.FloatAction(function(arg_316_0)
					arg_312_1.dialogCg_.alpha = arg_316_0
				end))
				var_315_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_312_1.dialog_)
					var_315_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_312_1.duration_ = arg_312_1.duration_ + 0.3

				SetActive(arg_312_1.leftNameGo_, false)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_18 = arg_312_1:FormatText(arg_312_1:GetWordFromCfg(322051075).content)

				arg_312_1.text_.text = var_315_18

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_20 = 57 <= 0 and var_315_16 or var_315_16 * (utf8.len(var_315_18) / 57)

				if (57 <= 0 and var_315_16 or var_315_16 * (utf8.len(var_315_18) / 57)) > 0 and var_315_16 < var_315_20 then
					arg_312_1.talkMaxDuration = var_315_20
					var_315_15 = var_315_15 + 0.3

					if var_315_20 + var_315_15 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_20 + var_315_15
					end
				end

				arg_312_1.text_.text = var_315_18
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_21 = var_315_15 + 0.3
			local var_315_22 = math.max(var_315_16, arg_312_1.talkMaxDuration)

			if var_315_15 + 0.3 <= arg_312_1.time_ and arg_312_1.time_ < var_315_21 + var_315_22 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_21) / var_315_22

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_21 + var_315_22 and arg_312_1.time_ < var_315_21 + var_315_22 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play322051076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 322051076
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play322051077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 1.525

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_1 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(322051076).content)

				arg_318_1.text_.text = var_321_1

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_3 = 61 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 61)

				if (61 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 61)) > 0 and var_321_0 < var_321_3 then
					arg_318_1.talkMaxDuration = var_321_3

					if var_321_3 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_3 + 0
					end
				end

				arg_318_1.text_.text = var_321_1
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_4 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_4

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play322051077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 322051077
		arg_322_1.duration_ = 6.73

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
			arg_322_1.auto_ = false
		end

		function arg_322_1.playNext_(arg_324_0)
			arg_322_1.onStoryFinished_()
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_fire04_loop", "")
			end

			local var_325_1 = 0
			local var_325_2 = 0.525

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0

				arg_322_1.dialog_:SetActive(true)

				arg_322_1.dialogCg_.alpha = 0

				local var_325_3 = LeanTween.value(arg_322_1.dialog_, 0, 1, 0.3)

				var_325_3:setOnUpdate(LuaHelper.FloatAction(function(arg_326_0)
					arg_322_1.dialogCg_.alpha = arg_326_0
				end))
				var_325_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_322_1.dialog_)
					var_325_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_322_1.duration_ = arg_322_1.duration_ + 0.3

				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, true)
				arg_322_1.iconController_:SetSelectedState("hero")

				arg_322_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_322_1.callingController_:SetSelectedState("normal")

				arg_322_1.keyicon_.color = Color.New(1, 1, 1)
				arg_322_1.icon_.color = Color.New(1, 1, 1)

				local var_325_4 = arg_322_1:GetWordFromCfg(322051077)
				local var_325_5 = arg_322_1:FormatText(var_325_4.content)

				arg_322_1.text_.text = var_325_5

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_7 = 21 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_5) / 21)

				if (21 <= 0 and var_325_2 or var_325_2 * (utf8.len(var_325_5) / 21)) > 0 and var_325_2 < var_325_7 then
					arg_322_1.talkMaxDuration = var_325_7
					var_325_1 = var_325_1 + 0.3

					if var_325_7 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_7 + var_325_1
					end
				end

				arg_322_1.text_.text = var_325_5
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322051", "322051077", "story_v_out_322051.awb") ~= 0 then
					local var_325_8 = manager.audio:GetVoiceLength("story_v_out_322051", "322051077", "story_v_out_322051.awb") / 1000

					if var_325_8 + var_325_1 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_8 + var_325_1
					end

					if var_325_4.prefab_name ~= "" and arg_322_1.actors_[var_325_4.prefab_name] ~= nil then
						local var_325_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_4.prefab_name].transform, "story_v_out_322051", "322051077", "story_v_out_322051.awb")

						arg_322_1:RecordAudio("322051077", var_325_9)
						arg_322_1:RecordAudio("322051077", var_325_9)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_322051", "322051077", "story_v_out_322051.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_322051", "322051077", "story_v_out_322051.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = var_325_1 + 0.3
			local var_325_11 = math.max(var_325_2, arg_322_1.talkMaxDuration)

			if var_325_1 + 0.3 <= arg_322_1.time_ and arg_322_1.time_ < var_325_10 + var_325_11 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_10) / var_325_11

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_10 + var_325_11 and arg_322_1.time_ < var_325_10 + var_325_11 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L10b",
		"TextureConfig/Background/ST2102a",
		"TextureConfig/Background/L15f",
		"TextureConfig/Background/L10h",
		"TextureConfig/Background/L15h"
	},
	voices = {
		"story_v_out_322051.awb"
	}
}
