return {
	Play323501001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323501001
		arg_1_1.duration_ = 2.3

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play323501002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

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

			local var_4_9 = 1.35

			if 1.35 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_10 = 0
			local var_4_11 = 0.65
			local var_4_12, var_4_13 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(102).content), 1)

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

			local var_4_15 = math.max(0.65, arg_1_1.talkMaxDuration)

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_16 = arg_1_1.var_.effect444212

				if not arg_1_1.var_.effect444212 then
					var_4_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_starheart"), manager.ui.mainCamera.transform)
					var_4_16.name = "444212"
					arg_1_1.var_.effect444212 = var_4_16
				else
					var_4_16.transform:SetParent(var_4_9000)
				end

				var_4_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_breath01", "")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323501002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 323501002
		arg_6_1.duration_ = 7

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play323501003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if arg_6_1.bgs_.ST03 == nil then
				local var_9_0 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST03")
				var_9_0.name = "ST03"
				var_9_0.transform.parent = arg_6_1.stage_.transform
				var_9_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_.ST03 = var_9_0
			end

			if 0.533333333333333 < arg_6_1.time_ and arg_6_1.time_ <= 0.533333333333333 + arg_9_0 then
				local var_9_1 = arg_6_1.bgs_.ST03

				arg_6_1.bgs_.ST03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_9_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_2 = var_9_1:GetComponent("SpriteRenderer")

				if var_9_2 and var_9_2.sprite then
					local var_9_3 = 2 * (var_9_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_9_1.transform.localScale = Vector3.New(var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "ST03" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_4 = 0

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_4 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			if arg_6_1.time_ >= var_9_4 + 0.3 and arg_6_1.time_ < var_9_4 + 0.3 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end

			local var_9_5 = 0

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_5 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_6 = 0.533333333333333

			if var_9_5 <= arg_6_1.time_ and arg_6_1.time_ < var_9_5 + var_9_6 then
				local var_9_7 = Color.New(0, 0, 0)

				var_9_7.a = Mathf.Lerp(0, 1, (arg_6_1.time_ - var_9_5) / var_9_6)
				arg_6_1.mask_.color = var_9_7
			end

			if arg_6_1.time_ >= var_9_5 + var_9_6 and arg_6_1.time_ < var_9_5 + var_9_6 + arg_9_0 then
				local var_9_8 = Color.New(0, 0, 0)

				var_9_8.a = 1
				arg_6_1.mask_.color = var_9_8
			end

			local var_9_9 = 0.533333333333333

			if 0.533333333333333 < arg_6_1.time_ and arg_6_1.time_ <= var_9_9 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_10 = 1.46666666666567

			if var_9_9 <= arg_6_1.time_ and arg_6_1.time_ < var_9_9 + var_9_10 then
				local var_9_11 = Color.New(0, 0, 0)

				var_9_11.a = Mathf.Lerp(1, 0, (arg_6_1.time_ - var_9_9) / var_9_10)
				arg_6_1.mask_.color = var_9_11
			end

			if arg_6_1.time_ >= var_9_9 + var_9_10 and arg_6_1.time_ < var_9_9 + var_9_10 + arg_9_0 then
				local var_9_12 = Color.New(0, 0, 0)

				arg_6_1.mask_.enabled = false
				var_9_12.a = 0
				arg_6_1.mask_.color = var_9_12
			end

			if 0.533333333333333 < arg_6_1.time_ and arg_6_1.time_ <= 0.533333333333333 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(false)
				arg_6_1.dialog_:SetActive(false)
				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			if 0.55 < arg_6_1.time_ and arg_6_1.time_ <= 0.55 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(false)
				arg_6_1.dialog_:SetActive(false)
				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_13 = 0.533333333333333

			arg_6_1.isInRecall_ = false

			if var_9_13 < arg_6_1.time_ and arg_6_1.time_ <= var_9_13 + arg_9_0 then
				arg_6_1.screenFilterGo_:SetActive(true)

				arg_6_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")

				for iter_9_2, iter_9_3 in pairs(arg_6_1.actors_) do
					for iter_9_4, iter_9_5 in ipairs((iter_9_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_9_5.color = iter_9_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_9_14 = 0.666666666666667

			if var_9_13 <= arg_6_1.time_ and arg_6_1.time_ < var_9_13 + var_9_14 then
				arg_6_1.screenFilterEffect_.weight = Mathf.Lerp(0, 0.432, (arg_6_1.time_ - var_9_13) / var_9_14)
			end

			if arg_6_1.time_ >= var_9_13 + var_9_14 and arg_6_1.time_ < var_9_13 + var_9_14 + arg_9_0 then
				arg_6_1.screenFilterEffect_.weight = 0.432
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_15 = 1.999999999999
			local var_9_16 = 0.3

			if 1.999999999999 < arg_6_1.time_ and arg_6_1.time_ <= var_9_15 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_17 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_17:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, false)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_18 = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(323501002).content)

				arg_6_1.text_.text = var_9_18

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_20 = 12 <= 0 and var_9_16 or var_9_16 * (utf8.len(var_9_18) / 12)

				if (12 <= 0 and var_9_16 or var_9_16 * (utf8.len(var_9_18) / 12)) > 0 and var_9_16 < var_9_20 then
					arg_6_1.talkMaxDuration = var_9_20
					var_9_15 = var_9_15 + 0.3

					if var_9_20 + var_9_15 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_20 + var_9_15
					end
				end

				arg_6_1.text_.text = var_9_18
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)
				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_21 = var_9_15 + 0.3
			local var_9_22 = math.max(var_9_16, arg_6_1.talkMaxDuration)

			if var_9_15 + 0.3 <= arg_6_1.time_ and arg_6_1.time_ < var_9_21 + var_9_22 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_21) / var_9_22

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_21 + var_9_22 and arg_6_1.time_ < var_9_21 + var_9_22 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play323501003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 323501003
		arg_12_1.duration_ = 6.77

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play323501004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.bgs_.ST22 == nil then
				local var_15_0 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22")
				var_15_0.name = "ST22"
				var_15_0.transform.parent = arg_12_1.stage_.transform
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_.ST22 = var_15_0
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				local var_15_1 = arg_12_1.bgs_.ST22

				arg_12_1.bgs_.ST22.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_15_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_2 = var_15_1:GetComponent("SpriteRenderer")

				if var_15_2 and var_15_2.sprite then
					local var_15_3 = 2 * (var_15_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_15_1.transform.localScale = Vector3.New(var_15_3 / var_15_2.sprite.bounds.size.y < var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x and var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x or var_15_3 / var_15_2.sprite.bounds.size.y, var_15_3 / var_15_2.sprite.bounds.size.y < var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x and var_15_3 * manager.ui.mainCameraCom_.aspect / var_15_2.sprite.bounds.size.x or var_15_3 / var_15_2.sprite.bounds.size.y, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "ST22" then
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

			local var_15_6 = 2

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

			if 0.166666666666667 < arg_12_1.time_ and arg_12_1.time_ <= 0.166666666666667 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_breath02", "")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_breath01", "")
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_11 = 1.76666666666667
			local var_15_12 = 0.65

			if 1.76666666666667 < arg_12_1.time_ and arg_12_1.time_ <= var_15_11 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_13 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_13:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_14 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(323501003).content)

				arg_12_1.text_.text = var_15_14

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_16 = 26 <= 0 and var_15_12 or var_15_12 * (utf8.len(var_15_14) / 26)

				if (26 <= 0 and var_15_12 or var_15_12 * (utf8.len(var_15_14) / 26)) > 0 and var_15_12 < var_15_16 then
					arg_12_1.talkMaxDuration = var_15_16
					var_15_11 = var_15_11 + 0.3

					if var_15_16 + var_15_11 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_11
					end
				end

				arg_12_1.text_.text = var_15_14
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_17 = var_15_11 + 0.3
			local var_15_18 = math.max(var_15_12, arg_12_1.talkMaxDuration)

			if var_15_11 + 0.3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_17 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_17) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_17 + var_15_18 and arg_12_1.time_ < var_15_17 + var_15_18 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play323501004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 323501004
		arg_18_1.duration_ = 6.5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play323501005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if arg_18_1.bgs_.ST59 == nil then
				local var_21_0 = Object.Instantiate(arg_18_1.paintGo_)

				var_21_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST59")
				var_21_0.name = "ST59"
				var_21_0.transform.parent = arg_18_1.stage_.transform
				var_21_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.bgs_.ST59 = var_21_0
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				local var_21_1 = arg_18_1.bgs_.ST59

				arg_18_1.bgs_.ST59.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_21_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_21_2 = var_21_1:GetComponent("SpriteRenderer")

				if var_21_2 and var_21_2.sprite then
					local var_21_3 = 2 * (var_21_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_21_1.transform.localScale = Vector3.New(var_21_3 / var_21_2.sprite.bounds.size.y < var_21_3 * manager.ui.mainCameraCom_.aspect / var_21_2.sprite.bounds.size.x and var_21_3 * manager.ui.mainCameraCom_.aspect / var_21_2.sprite.bounds.size.x or var_21_3 / var_21_2.sprite.bounds.size.y, var_21_3 / var_21_2.sprite.bounds.size.y < var_21_3 * manager.ui.mainCameraCom_.aspect / var_21_2.sprite.bounds.size.x and var_21_3 * manager.ui.mainCameraCom_.aspect / var_21_2.sprite.bounds.size.x or var_21_3 / var_21_2.sprite.bounds.size.y, 0)
				end

				for iter_21_0, iter_21_1 in pairs(arg_18_1.bgs_) do
					if iter_21_0 ~= "ST59" then
						iter_21_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_21_4 = 0

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_4 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			if arg_18_1.time_ >= var_21_4 + 0.3 and arg_18_1.time_ < var_21_4 + 0.3 + arg_21_0 then
				arg_18_1.allBtn_.enabled = true
			end

			local var_21_5 = 0

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_5 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_6 = 2

			if var_21_5 <= arg_18_1.time_ and arg_18_1.time_ < var_21_5 + var_21_6 then
				local var_21_7 = Color.New(0, 0, 0)

				var_21_7.a = Mathf.Lerp(1, 0, (arg_18_1.time_ - var_21_5) / var_21_6)
				arg_18_1.mask_.color = var_21_7
			end

			if arg_18_1.time_ >= var_21_5 + var_21_6 and arg_18_1.time_ < var_21_5 + var_21_6 + arg_21_0 then
				local var_21_8 = Color.New(0, 0, 0)

				arg_18_1.mask_.enabled = false
				var_21_8.a = 0
				arg_18_1.mask_.color = var_21_8
			end

			if arg_18_1.frameCnt_ <= 1 then
				arg_18_1.dialog_:SetActive(false)
			end

			local var_21_9 = 1.5
			local var_21_10 = 0.7

			if 1.5 < arg_18_1.time_ and arg_18_1.time_ <= var_21_9 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				arg_18_1.dialog_:SetActive(true)

				arg_18_1.dialogCg_.alpha = 0

				local var_21_11 = LeanTween.value(arg_18_1.dialog_, 0, 1, 0.3)

				var_21_11:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_18_1.dialogCg_.alpha = arg_22_0
				end))
				var_21_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_18_1.dialog_)
					var_21_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_18_1.duration_ = arg_18_1.duration_ + 0.3

				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_12 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(323501004).content)

				arg_18_1.text_.text = var_21_12

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_14 = 28 <= 0 and var_21_10 or var_21_10 * (utf8.len(var_21_12) / 28)

				if (28 <= 0 and var_21_10 or var_21_10 * (utf8.len(var_21_12) / 28)) > 0 and var_21_10 < var_21_14 then
					arg_18_1.talkMaxDuration = var_21_14
					var_21_9 = var_21_9 + 0.3

					if var_21_14 + var_21_9 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_14 + var_21_9
					end
				end

				arg_18_1.text_.text = var_21_12
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_15 = var_21_9 + 0.3
			local var_21_16 = math.max(var_21_10, arg_18_1.talkMaxDuration)

			if var_21_9 + 0.3 <= arg_18_1.time_ and arg_18_1.time_ < var_21_15 + var_21_16 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_15) / var_21_16

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_15 + var_21_16 and arg_18_1.time_ < var_21_15 + var_21_16 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play323501005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 323501005
		arg_24_1.duration_ = 6.45

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play323501006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.bgs_.ST47 == nil then
				local var_27_0 = Object.Instantiate(arg_24_1.paintGo_)

				var_27_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST47")
				var_27_0.name = "ST47"
				var_27_0.transform.parent = arg_24_1.stage_.transform
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.bgs_.ST47 = var_27_0
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				local var_27_1 = arg_24_1.bgs_.ST47

				arg_24_1.bgs_.ST47.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_27_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_2 = var_27_1:GetComponent("SpriteRenderer")

				if var_27_2 and var_27_2.sprite then
					local var_27_3 = 2 * (var_27_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_27_1.transform.localScale = Vector3.New(var_27_3 / var_27_2.sprite.bounds.size.y < var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x and var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x or var_27_3 / var_27_2.sprite.bounds.size.y, var_27_3 / var_27_2.sprite.bounds.size.y < var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x and var_27_3 * manager.ui.mainCameraCom_.aspect / var_27_2.sprite.bounds.size.x or var_27_3 / var_27_2.sprite.bounds.size.y, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "ST47" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_4 = 0

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			if arg_24_1.time_ >= var_27_4 + 0.3 and arg_24_1.time_ < var_27_4 + 0.3 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end

			local var_27_5 = 0

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_6 = 2

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 then
				local var_27_7 = Color.New(0, 0, 0)

				var_27_7.a = Mathf.Lerp(1, 0, (arg_24_1.time_ - var_27_5) / var_27_6)
				arg_24_1.mask_.color = var_27_7
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 then
				local var_27_8 = Color.New(0, 0, 0)

				arg_24_1.mask_.enabled = false
				var_27_8.a = 0
				arg_24_1.mask_.color = var_27_8
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_9 = 1.44592430489138
			local var_27_10 = 0.5

			if 1.44592430489138 < arg_24_1.time_ and arg_24_1.time_ <= var_27_9 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_11 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_11:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_24_1.dialogCg_.alpha = arg_28_0
				end))
				var_27_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_12 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(323501005).content)

				arg_24_1.text_.text = var_27_12

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_14 = 20 <= 0 and var_27_10 or var_27_10 * (utf8.len(var_27_12) / 20)

				if (20 <= 0 and var_27_10 or var_27_10 * (utf8.len(var_27_12) / 20)) > 0 and var_27_10 < var_27_14 then
					arg_24_1.talkMaxDuration = var_27_14
					var_27_9 = var_27_9 + 0.3

					if var_27_14 + var_27_9 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_9
					end
				end

				arg_24_1.text_.text = var_27_12
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_15 = var_27_9 + 0.3
			local var_27_16 = math.max(var_27_10, arg_24_1.talkMaxDuration)

			if var_27_9 + 0.3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_15 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_15) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_15 + var_27_16 and arg_24_1.time_ < var_27_15 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play323501006 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 323501006
		arg_30_1.duration_ = 6.87

		local var_30_0 = {
			zh = 6.76666666666667,
			ja = 6.86666666666667
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play323501007(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if arg_30_1.bgs_.J21f == nil then
				local var_33_0 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21f")
				var_33_0.name = "J21f"
				var_33_0.transform.parent = arg_30_1.stage_.transform
				var_33_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_.J21f = var_33_0
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				local var_33_1 = arg_30_1.bgs_.J21f

				arg_30_1.bgs_.J21f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_33_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_2 = var_33_1:GetComponent("SpriteRenderer")

				if var_33_2 and var_33_2.sprite then
					local var_33_3 = 2 * (var_33_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_33_1.transform.localScale = Vector3.New(var_33_3 / var_33_2.sprite.bounds.size.y < var_33_3 * manager.ui.mainCameraCom_.aspect / var_33_2.sprite.bounds.size.x and var_33_3 * manager.ui.mainCameraCom_.aspect / var_33_2.sprite.bounds.size.x or var_33_3 / var_33_2.sprite.bounds.size.y, var_33_3 / var_33_2.sprite.bounds.size.y < var_33_3 * manager.ui.mainCameraCom_.aspect / var_33_2.sprite.bounds.size.x and var_33_3 * manager.ui.mainCameraCom_.aspect / var_33_2.sprite.bounds.size.x or var_33_3 / var_33_2.sprite.bounds.size.y, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "J21f" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_33_4 = 0

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			if arg_30_1.time_ >= var_33_4 + 0.3 and arg_30_1.time_ < var_33_4 + 0.3 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			local var_33_5 = 0

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_6 = 1.699999999999

			if var_33_5 <= arg_30_1.time_ and arg_30_1.time_ < var_33_5 + var_33_6 then
				local var_33_7 = Color.New(1, 1, 1)

				var_33_7.a = Mathf.Lerp(1, 0, (arg_30_1.time_ - var_33_5) / var_33_6)
				arg_30_1.mask_.color = var_33_7
			end

			if arg_30_1.time_ >= var_33_5 + var_33_6 and arg_30_1.time_ < var_33_5 + var_33_6 + arg_33_0 then
				local var_33_8 = Color.New(1, 1, 1)

				arg_30_1.mask_.enabled = false
				var_33_8.a = 0
				arg_30_1.mask_.color = var_33_8
			end

			local var_33_9 = "1067ui_story"

			if arg_30_1.actors_["1067ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1067ui_story"))) then
				local var_33_10 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_30_1.stage_.transform)

				var_33_10.name = var_33_9
				var_33_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.actors_[var_33_9] = var_33_10

				local var_33_11 = var_33_10:GetComponentInChildren(typeof(CharacterEffect))

				var_33_11.enabled = true

				local var_33_12 = GameObjectTools.GetOrAddComponent(var_33_10, typeof(DynamicBoneHelper))

				if var_33_12 then
					var_33_12:EnableDynamicBone(false)
				end

				arg_30_1:ShowWeapon(var_33_11.transform, false)

				arg_30_1.var_[var_33_9 .. "Animator"] = var_33_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_30_1.var_[var_33_9 .. "Animator"].applyRootMotion = true
				arg_30_1.var_[var_33_9 .. "LipSync"] = var_33_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_33_13 = arg_30_1.actors_["1067ui_story"]

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(var_33_13) and arg_30_1.var_.characterEffect1067ui_story == nil then
				arg_30_1.var_.characterEffect1067ui_story = var_33_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_14 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_14 and not isNil(var_33_13) then
				if arg_30_1.var_.characterEffect1067ui_story and not isNil(var_33_13) then
					arg_30_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= 0 + var_33_14 and arg_30_1.time_ < 0 + var_33_14 + arg_33_0 and not isNil(var_33_13) and arg_30_1.var_.characterEffect1067ui_story then
				arg_30_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				if arg_30_1.var_.effect444212 then
					Object.Destroy(arg_30_1.var_.effect444212)

					arg_30_1.var_.effect444212 = nil
				end
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_breath03", "")
			end

			if 1.55326400073245 < arg_30_1.time_ and arg_30_1.time_ <= 1.55326400073245 + arg_33_0 then
				arg_30_1:AudioAction("play", "effect", "se_story_148", "se_story_148_motorcycle", "")
			end

			if 0.866666666666667 < arg_30_1.time_ and arg_30_1.time_ <= 0.866666666666667 + arg_33_0 then
				arg_30_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_33_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_30_1.bgmTxt_.text ~= var_33_22 and arg_30_1.bgmTxt_.text ~= "" then
						if arg_30_1.bgmTxt2_.text ~= "" then
							arg_30_1.bgmTxt_.text = arg_30_1.bgmTxt2_.text
						end

						arg_30_1.bgmTxt2_.text = var_33_22

						arg_30_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_30_1.bgmTxt_.text = var_33_22
						arg_30_1.bgmTxt2_.text = var_33_22
					end

					if arg_30_1.bgmTimer then
						arg_30_1.bgmTimer:Stop()

						arg_30_1.bgmTimer = nil
					end

					if arg_30_1.settingData.show_music_name == 1 then
						arg_30_1.musicController:SetSelectedState("show")
						arg_30_1.musicAnimator_:Play("open", 0, 0)

						if arg_30_1.settingData.music_time ~= 0 then
							arg_30_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_30_1.settingData.music_time), function()
								if arg_30_1 == nil or isNil(arg_30_1.bgmTxt_) then
									return
								end

								arg_30_1.musicController:SetSelectedState("hide")
								arg_30_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.433333333333333 < arg_30_1.time_ and arg_30_1.time_ <= 0.433333333333333 + arg_33_0 then
				arg_30_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan.awb")

				local var_33_25 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan")

				if "" ~= "" then
					if arg_30_1.bgmTxt_.text ~= var_33_25 and arg_30_1.bgmTxt_.text ~= "" then
						if arg_30_1.bgmTxt2_.text ~= "" then
							arg_30_1.bgmTxt_.text = arg_30_1.bgmTxt2_.text
						end

						arg_30_1.bgmTxt2_.text = var_33_25

						arg_30_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_30_1.bgmTxt_.text = var_33_25
						arg_30_1.bgmTxt2_.text = var_33_25
					end

					if arg_30_1.bgmTimer then
						arg_30_1.bgmTimer:Stop()

						arg_30_1.bgmTimer = nil
					end

					if arg_30_1.settingData.show_music_name == 1 then
						arg_30_1.musicController:SetSelectedState("show")
						arg_30_1.musicAnimator_:Play("open", 0, 0)

						if arg_30_1.settingData.music_time ~= 0 then
							arg_30_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_30_1.settingData.music_time), function()
								if arg_30_1 == nil or isNil(arg_30_1.bgmTxt_) then
									return
								end

								arg_30_1.musicController:SetSelectedState("hide")
								arg_30_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.466666666666667 < arg_30_1.time_ and arg_30_1.time_ <= 0.466666666666667 + arg_33_0 then
				arg_30_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_pingyuan", "init_battle", "bgm_activity_4_8_story_dahuang_pingyuan.awb")

				local var_33_28 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_pingyuan", "init_battle")

				if "" ~= "" then
					if arg_30_1.bgmTxt_.text ~= var_33_28 and arg_30_1.bgmTxt_.text ~= "" then
						if arg_30_1.bgmTxt2_.text ~= "" then
							arg_30_1.bgmTxt_.text = arg_30_1.bgmTxt2_.text
						end

						arg_30_1.bgmTxt2_.text = var_33_28

						arg_30_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_30_1.bgmTxt_.text = var_33_28
						arg_30_1.bgmTxt2_.text = var_33_28
					end

					if arg_30_1.bgmTimer then
						arg_30_1.bgmTimer:Stop()

						arg_30_1.bgmTimer = nil
					end

					if arg_30_1.settingData.show_music_name == 1 then
						arg_30_1.musicController:SetSelectedState("show")
						arg_30_1.musicAnimator_:Play("open", 0, 0)

						if arg_30_1.settingData.music_time ~= 0 then
							arg_30_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_30_1.settingData.music_time), function()
								if arg_30_1 == nil or isNil(arg_30_1.bgmTxt_) then
									return
								end

								arg_30_1.musicController:SetSelectedState("hide")
								arg_30_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_33_29 = 0

			arg_30_1.isInRecall_ = false

			if var_33_29 < arg_30_1.time_ and arg_30_1.time_ <= var_33_29 + arg_33_0 then
				arg_30_1.screenFilterGo_:SetActive(false)

				for iter_33_2, iter_33_3 in pairs(arg_30_1.actors_) do
					for iter_33_4, iter_33_5 in ipairs((iter_33_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_33_5.color = iter_33_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_33_30 = 0.0166666666666667

			if var_33_29 <= arg_30_1.time_ and arg_30_1.time_ < var_33_29 + var_33_30 then
				arg_30_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_30_1.time_ - var_33_29) / var_33_30)
			end

			if arg_30_1.time_ >= var_33_29 + var_33_30 and arg_30_1.time_ < var_33_29 + var_33_30 + arg_33_0 then
				arg_30_1.screenFilterEffect_.weight = 0
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_31 = 1.86666666666667
			local var_33_32 = 0.575

			if 1.86666666666667 < arg_30_1.time_ and arg_30_1.time_ <= var_33_31 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_33 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_33:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_30_1.dialogCg_.alpha = arg_37_0
				end))
				var_33_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1459].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_34 = arg_30_1:GetWordFromCfg(323501006)
				local var_33_35 = arg_30_1:FormatText(var_33_34.content)

				arg_30_1.text_.text = var_33_35

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_37 = 23 <= 0 and var_33_32 or var_33_32 * (utf8.len(var_33_35) / 23)

				if (23 <= 0 and var_33_32 or var_33_32 * (utf8.len(var_33_35) / 23)) > 0 and var_33_32 < var_33_37 then
					arg_30_1.talkMaxDuration = var_33_37
					var_33_31 = var_33_31 + 0.3

					if var_33_37 + var_33_31 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_37 + var_33_31
					end
				end

				arg_30_1.text_.text = var_33_35
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501006", "story_v_out_323501.awb") ~= 0 then
					local var_33_38 = manager.audio:GetVoiceLength("story_v_out_323501", "323501006", "story_v_out_323501.awb") / 1000

					if var_33_38 + var_33_31 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_38 + var_33_31
					end

					if var_33_34.prefab_name ~= "" and arg_30_1.actors_[var_33_34.prefab_name] ~= nil then
						local var_33_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_34.prefab_name].transform, "story_v_out_323501", "323501006", "story_v_out_323501.awb")

						arg_30_1:RecordAudio("323501006", var_33_39)
						arg_30_1:RecordAudio("323501006", var_33_39)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_323501", "323501006", "story_v_out_323501.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_323501", "323501006", "story_v_out_323501.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_40 = var_33_31 + 0.3
			local var_33_41 = math.max(var_33_32, arg_30_1.talkMaxDuration)

			if var_33_31 + 0.3 <= arg_30_1.time_ and arg_30_1.time_ < var_33_40 + var_33_41 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_40) / var_33_41

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_40 + var_33_41 and arg_30_1.time_ < var_33_40 + var_33_41 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play323501007 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 323501007
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play323501008(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1067ui_story"]) and arg_39_1.var_.characterEffect1067ui_story == nil then
				arg_39_1.var_.characterEffect1067ui_story = arg_39_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1067ui_story"]) then
				if arg_39_1.var_.characterEffect1067ui_story and not isNil(arg_39_1.actors_["1067ui_story"]) then
					arg_39_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1067ui_story"]) and arg_39_1.var_.characterEffect1067ui_story then
				arg_39_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 1.25

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(323501007).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 50 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 50)

				if (50 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 50)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play323501008 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 323501008
		arg_43_1.duration_ = 5.63

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play323501009(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_9001
			local var_46_9000

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				local var_46_0 = arg_43_1.var_.effect444233

				if not arg_43_1.var_.effect444233 then
					var_46_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_46_0.name = "444233"
					arg_43_1.var_.effect444233 = var_46_0
				else
					var_46_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_46_0.transform.localPosition = Vector3.New(-1.41, -0.06, -0.09)
				var_46_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.2 < arg_43_1.time_ and arg_43_1.time_ <= 0.2 + arg_46_0 then
				local var_46_2 = arg_43_1.var_.effect444234

				if not arg_43_1.var_.effect444234 then
					var_46_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_46_2.name = "444234"
					arg_43_1.var_.effect444234 = var_46_2
				else
					var_46_2.transform:SetParent(var_46_9001)
				end

				var_46_2.transform.localPosition = Vector3.New(-0.25, -0.28, 0)
				var_46_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.433333333333334 < arg_43_1.time_ and arg_43_1.time_ <= 0.433333333333334 + arg_46_0 then
				local var_46_4 = arg_43_1.var_.effect444235

				if not arg_43_1.var_.effect444235 then
					var_46_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_46_4.name = "444235"
					arg_43_1.var_.effect444235 = var_46_4
				else
					var_46_4.transform:SetParent(var_46_9000)
				end

				var_46_4.transform.localPosition = Vector3.New(0.63, -0.34, -1.1)
				var_46_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.433333333333333 < arg_43_1.time_ and arg_43_1.time_ <= 0.433333333333333 + arg_46_0 then
				if arg_43_1.var_.effect444233 then
					Object.Destroy(arg_43_1.var_.effect444233)

					arg_43_1.var_.effect444233 = nil
				end
			end

			if 0.633333333333333 < arg_43_1.time_ and arg_43_1.time_ <= 0.633333333333333 + arg_46_0 then
				if arg_43_1.var_.effect444234 then
					Object.Destroy(arg_43_1.var_.effect444234)

					arg_43_1.var_.effect444234 = nil
				end
			end

			if 0.866666666666667 < arg_43_1.time_ and arg_43_1.time_ <= 0.866666666666667 + arg_46_0 then
				if arg_43_1.var_.effect444235 then
					Object.Destroy(arg_43_1.var_.effect444235)

					arg_43_1.var_.effect444235 = nil
				end
			end

			local var_46_9 = 0

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_9 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			if arg_43_1.time_ >= var_46_9 + 1.33333333333333 and arg_43_1.time_ < var_46_9 + 1.33333333333333 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:AudioAction("play", "effect", "se_story_136", "se_story_136_gun", "")
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_11 = 0.633333333333333
			local var_46_12 = 0.875

			if 0.633333333333333 < arg_43_1.time_ and arg_43_1.time_ <= var_46_11 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_13 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_13:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_14 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(323501008).content)

				arg_43_1.text_.text = var_46_14

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_16 = 35 <= 0 and var_46_12 or var_46_12 * (utf8.len(var_46_14) / 35)

				if (35 <= 0 and var_46_12 or var_46_12 * (utf8.len(var_46_14) / 35)) > 0 and var_46_12 < var_46_16 then
					arg_43_1.talkMaxDuration = var_46_16
					var_46_11 = var_46_11 + 0.3

					if var_46_16 + var_46_11 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_16 + var_46_11
					end
				end

				arg_43_1.text_.text = var_46_14
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_17 = var_46_11 + 0.3
			local var_46_18 = math.max(var_46_12, arg_43_1.talkMaxDuration)

			if var_46_11 + 0.3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_17 + var_46_18 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_17) / var_46_18

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_17 + var_46_18 and arg_43_1.time_ < var_46_17 + var_46_18 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play323501009 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 323501009
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play323501010(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.45

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(323501009).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 58 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 58)

				if (58 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 58)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play323501010 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 323501010
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play323501011(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0.1 < arg_53_1.time_ and arg_53_1.time_ <= 0.1 + arg_56_0 then
				arg_53_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun_battle", "")
			end

			local var_56_1 = 0
			local var_56_2 = 1.5

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(323501010).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 60 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 60)

				if (60 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 60)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play323501011 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 323501011
		arg_57_1.duration_ = 2.93

		local var_57_0 = {
			zh = 1.9,
			ja = 2.933
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
				arg_57_0:Play323501012(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if arg_57_1.actors_["1069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1069ui_story"))) then
				local var_60_0 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_57_1.stage_.transform)

				var_60_0.name = "1069ui_story"
				var_60_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1069ui_story"] = var_60_0

				local var_60_1 = var_60_0:GetComponentInChildren(typeof(CharacterEffect))

				var_60_1.enabled = true

				local var_60_2 = GameObjectTools.GetOrAddComponent(var_60_0, typeof(DynamicBoneHelper))

				if var_60_2 then
					var_60_2:EnableDynamicBone(false)
				end

				arg_57_1:ShowWeapon(var_60_1.transform, false)

				arg_57_1.var_["1069ui_story" .. "Animator"] = var_60_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_57_1.var_["1069ui_story" .. "Animator"].applyRootMotion = true
				arg_57_1.var_["1069ui_story" .. "LipSync"] = var_60_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_60_3 = arg_57_1.actors_["1069ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1069ui_story == nil then
				arg_57_1.var_.characterEffect1069ui_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect1069ui_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1069ui_story then
				arg_57_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_60_6 = 0
			local var_60_7 = 0.225

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1460].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_8 = arg_57_1:GetWordFromCfg(323501011)
				local var_60_9 = arg_57_1:FormatText(var_60_8.content)

				arg_57_1.text_.text = var_60_9

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 9 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 9)

				if (9 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_9) / 9)) > 0 and var_60_7 < var_60_11 then
					arg_57_1.talkMaxDuration = var_60_11

					if var_60_11 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_9
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501011", "story_v_out_323501.awb") ~= 0 then
					local var_60_12 = manager.audio:GetVoiceLength("story_v_out_323501", "323501011", "story_v_out_323501.awb") / 1000

					if var_60_12 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_6
					end

					if var_60_8.prefab_name ~= "" and arg_57_1.actors_[var_60_8.prefab_name] ~= nil then
						local var_60_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_8.prefab_name].transform, "story_v_out_323501", "323501011", "story_v_out_323501.awb")

						arg_57_1:RecordAudio("323501011", var_60_13)
						arg_57_1:RecordAudio("323501011", var_60_13)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_323501", "323501011", "story_v_out_323501.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_323501", "323501011", "story_v_out_323501.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_14 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_14 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_14

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_14 and arg_57_1.time_ < var_60_6 + var_60_14 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play323501012 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 323501012
		arg_61_1.duration_ = 4.87

		local var_61_0 = {
			zh = 3.9,
			ja = 4.866
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
				arg_61_0:Play323501013(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1067ui_story"]) and arg_61_1.var_.characterEffect1067ui_story == nil then
				arg_61_1.var_.characterEffect1067ui_story = arg_61_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1067ui_story"]) then
				if arg_61_1.var_.characterEffect1067ui_story and not isNil(arg_61_1.actors_["1067ui_story"]) then
					arg_61_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1067ui_story"]) and arg_61_1.var_.characterEffect1067ui_story then
				arg_61_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_64_2 = arg_61_1.actors_["1069ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1069ui_story == nil then
				arg_61_1.var_.characterEffect1069ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect1069ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1069ui_story then
				arg_61_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1069ui_story.fillRatio = 0.5
			end

			local var_64_4 = 0
			local var_64_5 = 0.425

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1459].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_6 = arg_61_1:GetWordFromCfg(323501012)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 17 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 17)

				if (17 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 17)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501012", "story_v_out_323501.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_323501", "323501012", "story_v_out_323501.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_323501", "323501012", "story_v_out_323501.awb")

						arg_61_1:RecordAudio("323501012", var_64_11)
						arg_61_1:RecordAudio("323501012", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_323501", "323501012", "story_v_out_323501.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_323501", "323501012", "story_v_out_323501.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play323501013 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 323501013
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play323501014(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1067ui_story"]) and arg_65_1.var_.characterEffect1067ui_story == nil then
				arg_65_1.var_.characterEffect1067ui_story = arg_65_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1067ui_story"]) then
				if arg_65_1.var_.characterEffect1067ui_story and not isNil(arg_65_1.actors_["1067ui_story"]) then
					arg_65_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1067ui_story"]) and arg_65_1.var_.characterEffect1067ui_story then
				arg_65_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 1.175

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(323501013).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 47 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 47)

				if (47 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 47)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play323501014 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 323501014
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play323501015(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0.575 < arg_69_1.time_ and arg_69_1.time_ <= 0.575 + arg_72_0 then
				arg_69_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun_battle02", "")
			end

			local var_72_1 = 0
			local var_72_2 = 1.575

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(323501014).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 63 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 63)

				if (63 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 63)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play323501015 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 323501015
		arg_73_1.duration_ = 6.33

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play323501016(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				local var_76_0 = arg_73_1.var_.effectQWE

				if not arg_73_1.var_.effectQWE then
					var_76_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rockfall"), manager.ui.mainCamera.transform)
					var_76_0.name = "QWE"
					arg_73_1.var_.effectQWE = var_76_0
				else
					var_76_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_76_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_76_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_76_0.transform.localScale = Vector3.New(var_76_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_76_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_76_0.transform.localScale.z)
			end

			local var_76_2 = 0

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			if arg_73_1.time_ >= var_76_2 + 1.33333333333333 and arg_73_1.time_ < var_76_2 + 1.33333333333333 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end

			if 0.200000002980232 < arg_73_1.time_ and arg_73_1.time_ <= 0.200000002980232 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_144", "se_story_144_metal", "")
			end

			if 1.23333333333333 < arg_73_1.time_ and arg_73_1.time_ <= 1.23333333333333 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_down", "")
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_5 = 1.33333333333333
			local var_76_6 = 1.65

			if 1.33333333333333 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_7 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_7:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_8 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(323501015).content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 66 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 66)

				if (66 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 66)) > 0 and var_76_6 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10
					var_76_5 = var_76_5 + 0.3

					if var_76_10 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = var_76_5 + 0.3
			local var_76_12 = math.max(var_76_6, arg_73_1.talkMaxDuration)

			if var_76_5 + 0.3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_11 + var_76_12 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_11) / var_76_12

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_11 + var_76_12 and arg_73_1.time_ < var_76_11 + var_76_12 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.799999997019768,
				amplitudeGain = 1,
				startTime = 0.200000002980232,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play323501016 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 323501016
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play323501017(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 1.4

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(323501016).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 56 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 56)

				if (56 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 56)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play323501017 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 323501017
		arg_83_1.duration_ = 6.62

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play323501018(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				if arg_83_1.var_.effectQWE then
					Object.Destroy(arg_83_1.var_.effectQWE)

					arg_83_1.var_.effectQWE = nil
				end
			end

			local var_86_1 = 0

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_2 = 2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = Color.New(0, 0, 0)

				var_86_3.a = Mathf.Lerp(1, 0, (arg_83_1.time_ - var_86_1) / var_86_2)
				arg_83_1.mask_.color = var_86_3
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				local var_86_4 = Color.New(0, 0, 0)

				arg_83_1.mask_.enabled = false
				var_86_4.a = 0
				arg_83_1.mask_.color = var_86_4
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_5 = 1.625
			local var_86_6 = 1.075

			if 1.625 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_7 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_7:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_8 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(323501017).content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 43 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 43)

				if (43 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 43)) > 0 and var_86_6 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10
					var_86_5 = var_86_5 + 0.3

					if var_86_10 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_11 = var_86_5 + 0.3
			local var_86_12 = math.max(var_86_6, arg_83_1.talkMaxDuration)

			if var_86_5 + 0.3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_11 + var_86_12 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_11) / var_86_12

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_11 + var_86_12 and arg_83_1.time_ < var_86_11 + var_86_12 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play323501018 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 323501018
		arg_89_1.duration_ = 1.37

		local var_89_0 = {
			zh = 0.999999999999,
			ja = 1.366
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
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play323501019(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if arg_89_1.actors_["10162ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10162ui_story"))) then
				local var_92_0 = Object.Instantiate(Asset.Load("Char/" .. "10162ui_story"), arg_89_1.stage_.transform)

				var_92_0.name = "10162ui_story"
				var_92_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["10162ui_story"] = var_92_0

				local var_92_1 = var_92_0:GetComponentInChildren(typeof(CharacterEffect))

				var_92_1.enabled = true

				local var_92_2 = GameObjectTools.GetOrAddComponent(var_92_0, typeof(DynamicBoneHelper))

				if var_92_2 then
					var_92_2:EnableDynamicBone(false)
				end

				arg_89_1:ShowWeapon(var_92_1.transform, false)

				arg_89_1.var_["10162ui_story" .. "Animator"] = var_92_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_89_1.var_["10162ui_story" .. "Animator"].applyRootMotion = true
				arg_89_1.var_["10162ui_story" .. "LipSync"] = var_92_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_92_3 = arg_89_1.actors_["10162ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_3) and arg_89_1.var_.characterEffect10162ui_story == nil then
				arg_89_1.var_.characterEffect10162ui_story = var_92_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_4 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 and not isNil(var_92_3) then
				if arg_89_1.var_.characterEffect10162ui_story and not isNil(var_92_3) then
					arg_89_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 and not isNil(var_92_3) and arg_89_1.var_.characterEffect10162ui_story then
				arg_89_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_92_6 = 0
			local var_92_7 = 0.1

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1460].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_8 = arg_89_1:GetWordFromCfg(323501018)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 4 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 4)

				if (4 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 4)) > 0 and var_92_7 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501018", "story_v_out_323501.awb") ~= 0 then
					local var_92_12 = manager.audio:GetVoiceLength("story_v_out_323501", "323501018", "story_v_out_323501.awb") / 1000

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end

					if var_92_8.prefab_name ~= "" and arg_89_1.actors_[var_92_8.prefab_name] ~= nil then
						local var_92_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_8.prefab_name].transform, "story_v_out_323501", "323501018", "story_v_out_323501.awb")

						arg_89_1:RecordAudio("323501018", var_92_13)
						arg_89_1:RecordAudio("323501018", var_92_13)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_323501", "323501018", "story_v_out_323501.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_323501", "323501018", "story_v_out_323501.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play323501019 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 323501019
		arg_93_1.duration_ = 2.3

		local var_93_0 = {
			zh = 2.033,
			ja = 2.3
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
				arg_93_0:Play323501020(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10162ui_story = arg_93_1.actors_["10162ui_story"].transform.localPosition

				local var_96_0 = GameObjectTools.GetOrAddComponent(arg_93_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_96_0 then
					var_96_0:EnableDynamicBone(false)
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["10162ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10162ui_story, Vector3.New(-0.74, -1.08, -5.83), (arg_93_1.time_ - 0) / var_96_1)
				arg_93_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10162ui_story"].transform.position).z)
				arg_93_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10162ui_story"].transform.localEulerAngles = arg_93_1.actors_["10162ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["10162ui_story"].transform.localPosition = Vector3.New(-0.74, -1.08, -5.83)
				arg_93_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["10162ui_story"].transform.position).z)
				arg_93_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["10162ui_story"].transform.localEulerAngles = arg_93_1.actors_["10162ui_story"].transform.localEulerAngles

				local var_96_2 = GameObjectTools.GetOrAddComponent(arg_93_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(true)
				end
			end

			local var_96_3 = "10166ui_story"

			if arg_93_1.actors_["10166ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10166ui_story"))) then
				local var_96_4 = Object.Instantiate(Asset.Load("Char/" .. "10166ui_story"), arg_93_1.stage_.transform)

				var_96_4.name = var_96_3
				var_96_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_[var_96_3] = var_96_4

				local var_96_5 = var_96_4:GetComponentInChildren(typeof(CharacterEffect))

				var_96_5.enabled = true

				local var_96_6 = GameObjectTools.GetOrAddComponent(var_96_4, typeof(DynamicBoneHelper))

				if var_96_6 then
					var_96_6:EnableDynamicBone(false)
				end

				arg_93_1:ShowWeapon(var_96_5.transform, false)

				arg_93_1.var_[var_96_3 .. "Animator"] = var_96_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_93_1.var_[var_96_3 .. "Animator"].applyRootMotion = true
				arg_93_1.var_[var_96_3 .. "LipSync"] = var_96_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_96_7 = arg_93_1.actors_["10166ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.characterEffect10166ui_story == nil then
				arg_93_1.var_.characterEffect10166ui_story = var_96_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_8 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_8 and not isNil(var_96_7) then
				if arg_93_1.var_.characterEffect10166ui_story and not isNil(var_96_7) then
					arg_93_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_8)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_8 and arg_93_1.time_ < 0 + var_96_8 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.characterEffect10166ui_story then
				arg_93_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10166ui_story.fillRatio = 0.5
			end

			local var_96_9 = arg_93_1.actors_["10162ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect10162ui_story == nil then
				arg_93_1.var_.characterEffect10162ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_10 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_10 and not isNil(var_96_9) then
				if arg_93_1.var_.characterEffect10162ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_10 and arg_93_1.time_ < 0 + var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect10162ui_story then
				arg_93_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_96_12 = 0
			local var_96_13 = 0.2

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1459].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_14 = arg_93_1:GetWordFromCfg(323501019)
				local var_96_15 = arg_93_1:FormatText(var_96_14.content)

				arg_93_1.text_.text = var_96_15

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_17 = 8 <= 0 and var_96_13 or var_96_13 * (utf8.len(var_96_15) / 8)

				if (8 <= 0 and var_96_13 or var_96_13 * (utf8.len(var_96_15) / 8)) > 0 and var_96_13 < var_96_17 then
					arg_93_1.talkMaxDuration = var_96_17

					if var_96_17 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_12
					end
				end

				arg_93_1.text_.text = var_96_15
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501019", "story_v_out_323501.awb") ~= 0 then
					local var_96_18 = manager.audio:GetVoiceLength("story_v_out_323501", "323501019", "story_v_out_323501.awb") / 1000

					if var_96_18 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_12
					end

					if var_96_14.prefab_name ~= "" and arg_93_1.actors_[var_96_14.prefab_name] ~= nil then
						local var_96_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_14.prefab_name].transform, "story_v_out_323501", "323501019", "story_v_out_323501.awb")

						arg_93_1:RecordAudio("323501019", var_96_19)
						arg_93_1:RecordAudio("323501019", var_96_19)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_323501", "323501019", "story_v_out_323501.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_323501", "323501019", "story_v_out_323501.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_20 = math.max(var_96_13, arg_93_1.talkMaxDuration)

			if var_96_12 <= arg_93_1.time_ and arg_93_1.time_ < var_96_12 + var_96_20 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_12) / var_96_20

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_12 + var_96_20 and arg_93_1.time_ < var_96_12 + var_96_20 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play323501020 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 323501020
		arg_97_1.duration_ = 2.7

		local var_97_0 = {
			zh = 1.999999999999,
			ja = 2.7
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
				arg_97_0:Play323501021(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10166ui_story = arg_97_1.actors_["10166ui_story"].transform.localPosition

				local var_100_0 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_0 then
					var_100_0:EnableDynamicBone(false)
				end
			end

			local var_100_1 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_1 then
				arg_97_1.actors_["10166ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10166ui_story, Vector3.New(0.7, -1.28, -5.73), (arg_97_1.time_ - 0) / var_100_1)
				arg_97_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10166ui_story"].transform.position).z)
				arg_97_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10166ui_story"].transform.localEulerAngles = arg_97_1.actors_["10166ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_1 and arg_97_1.time_ < 0 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["10166ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.73)
				arg_97_1.actors_["10166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10166ui_story"].transform.position).z)
				arg_97_1.actors_["10166ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10166ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10166ui_story"].transform.localEulerAngles = arg_97_1.actors_["10166ui_story"].transform.localEulerAngles

				local var_100_2 = GameObjectTools.GetOrAddComponent(arg_97_1.actors_["10166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(true)
				end
			end

			local var_100_3 = arg_97_1.actors_["10162ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect10162ui_story == nil then
				arg_97_1.var_.characterEffect10162ui_story = var_100_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_4 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 and not isNil(var_100_3) then
				if arg_97_1.var_.characterEffect10162ui_story and not isNil(var_100_3) then
					arg_97_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_4)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 and not isNil(var_100_3) and arg_97_1.var_.characterEffect10162ui_story then
				arg_97_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			local var_100_5 = arg_97_1.actors_["10166ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect10166ui_story == nil then
				arg_97_1.var_.characterEffect10166ui_story = var_100_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_6 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_6 and not isNil(var_100_5) then
				if arg_97_1.var_.characterEffect10166ui_story and not isNil(var_100_5) then
					arg_97_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_6 and arg_97_1.time_ < 0 + var_100_6 + arg_100_0 and not isNil(var_100_5) and arg_97_1.var_.characterEffect10166ui_story then
				arg_97_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_100_8 = 0
			local var_100_9 = 0.125

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1460].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_10 = arg_97_1:GetWordFromCfg(323501020)
				local var_100_11 = arg_97_1:FormatText(var_100_10.content)

				arg_97_1.text_.text = var_100_11

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 5 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 5)

				if (5 <= 0 and var_100_9 or var_100_9 * (utf8.len(var_100_11) / 5)) > 0 and var_100_9 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_8
					end
				end

				arg_97_1.text_.text = var_100_11
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501020", "story_v_out_323501.awb") ~= 0 then
					local var_100_14 = manager.audio:GetVoiceLength("story_v_out_323501", "323501020", "story_v_out_323501.awb") / 1000

					if var_100_14 + var_100_8 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_14 + var_100_8
					end

					if var_100_10.prefab_name ~= "" and arg_97_1.actors_[var_100_10.prefab_name] ~= nil then
						local var_100_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_10.prefab_name].transform, "story_v_out_323501", "323501020", "story_v_out_323501.awb")

						arg_97_1:RecordAudio("323501020", var_100_15)
						arg_97_1:RecordAudio("323501020", var_100_15)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_323501", "323501020", "story_v_out_323501.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_323501", "323501020", "story_v_out_323501.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_9, arg_97_1.talkMaxDuration)

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_8) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_8 + var_100_16 and arg_97_1.time_ < var_100_8 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play323501021 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 323501021
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play323501022(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10162ui_story"]) and arg_101_1.var_.characterEffect10162ui_story == nil then
				arg_101_1.var_.characterEffect10162ui_story = arg_101_1.actors_["10162ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10162ui_story"]) then
				if arg_101_1.var_.characterEffect10162ui_story and not isNil(arg_101_1.actors_["10162ui_story"]) then
					arg_101_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10162ui_story"]) and arg_101_1.var_.characterEffect10162ui_story then
				arg_101_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			local var_104_1 = arg_101_1.actors_["10162ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10162ui_story = var_104_1.localPosition

				local var_104_2 = GameObjectTools.GetOrAddComponent(var_104_1.gameObject, typeof(DynamicBoneHelper))

				if var_104_2 then
					var_104_2:EnableDynamicBone(false)
				end
			end

			local var_104_3 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 then
				var_104_1.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10162ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_3)
				var_104_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_1.position).x, (manager.ui.mainCamera.transform.position - var_104_1.position).y, (manager.ui.mainCamera.transform.position - var_104_1.position).z)
				var_104_1.localEulerAngles.z = 0
				var_104_1.localEulerAngles.x = 0
				var_104_1.localEulerAngles = var_104_1.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 then
				var_104_1.localPosition = Vector3.New(0, 100, 0)
				var_104_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_1.position).x, (manager.ui.mainCamera.transform.position - var_104_1.position).y, (manager.ui.mainCamera.transform.position - var_104_1.position).z)
				var_104_1.localEulerAngles.z = 0
				var_104_1.localEulerAngles.x = 0
				var_104_1.localEulerAngles = var_104_1.localEulerAngles

				local var_104_4 = GameObjectTools.GetOrAddComponent(var_104_1.gameObject, typeof(DynamicBoneHelper))

				if var_104_4 then
					var_104_4:EnableDynamicBone(true)
				end
			end

			local var_104_5 = arg_101_1.actors_["10166ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10166ui_story = var_104_5.localPosition

				local var_104_6 = GameObjectTools.GetOrAddComponent(var_104_5.gameObject, typeof(DynamicBoneHelper))

				if var_104_6 then
					var_104_6:EnableDynamicBone(false)
				end
			end

			local var_104_7 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				var_104_5.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10166ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_7)
				var_104_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_5.position).x, (manager.ui.mainCamera.transform.position - var_104_5.position).y, (manager.ui.mainCamera.transform.position - var_104_5.position).z)
				var_104_5.localEulerAngles.z = 0
				var_104_5.localEulerAngles.x = 0
				var_104_5.localEulerAngles = var_104_5.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				var_104_5.localPosition = Vector3.New(0, 100, 0)
				var_104_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_5.position).x, (manager.ui.mainCamera.transform.position - var_104_5.position).y, (manager.ui.mainCamera.transform.position - var_104_5.position).z)
				var_104_5.localEulerAngles.z = 0
				var_104_5.localEulerAngles.x = 0
				var_104_5.localEulerAngles = var_104_5.localEulerAngles

				local var_104_8 = GameObjectTools.GetOrAddComponent(var_104_5.gameObject, typeof(DynamicBoneHelper))

				if var_104_8 then
					var_104_8:EnableDynamicBone(true)
				end
			end

			local var_104_9 = 0
			local var_104_10 = 0.85

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_11 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(323501021).content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 34 <= 0 and var_104_10 or var_104_10 * (utf8.len(var_104_11) / 34)

				if (34 <= 0 and var_104_10 or var_104_10 * (utf8.len(var_104_11) / 34)) > 0 and var_104_10 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_9 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_9
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_10, arg_101_1.talkMaxDuration)

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_9) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_9 + var_104_14 and arg_101_1.time_ < var_104_9 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play323501022 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 323501022
		arg_105_1.duration_ = 5.7

		local var_105_0 = {
			zh = 4.8,
			ja = 5.7
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
				arg_105_0:Play323501023(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["10162ui_story"]) and arg_105_1.var_.characterEffect10162ui_story == nil then
				arg_105_1.var_.characterEffect10162ui_story = arg_105_1.actors_["10162ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["10162ui_story"]) then
				if arg_105_1.var_.characterEffect10162ui_story and not isNil(arg_105_1.actors_["10162ui_story"]) then
					arg_105_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["10162ui_story"]) and arg_105_1.var_.characterEffect10162ui_story then
				arg_105_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_2")
			end

			local var_108_2 = arg_105_1.actors_["10162ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10162ui_story = var_108_2.localPosition

				local var_108_3 = GameObjectTools.GetOrAddComponent(var_108_2.gameObject, typeof(DynamicBoneHelper))

				if var_108_3 then
					var_108_3:EnableDynamicBone(false)
				end
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_2.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10162ui_story, Vector3.New(0, -1.08, -5.83), (arg_105_1.time_ - 0) / var_108_4)
				var_108_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_2.position).x, (manager.ui.mainCamera.transform.position - var_108_2.position).y, (manager.ui.mainCamera.transform.position - var_108_2.position).z)
				var_108_2.localEulerAngles.z = 0
				var_108_2.localEulerAngles.x = 0
				var_108_2.localEulerAngles = var_108_2.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_2.localPosition = Vector3.New(0, -1.08, -5.83)
				var_108_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_2.position).x, (manager.ui.mainCamera.transform.position - var_108_2.position).y, (manager.ui.mainCamera.transform.position - var_108_2.position).z)
				var_108_2.localEulerAngles.z = 0
				var_108_2.localEulerAngles.x = 0
				var_108_2.localEulerAngles = var_108_2.localEulerAngles

				local var_108_5 = GameObjectTools.GetOrAddComponent(var_108_2.gameObject, typeof(DynamicBoneHelper))

				if var_108_5 then
					var_108_5:EnableDynamicBone(true)
				end
			end

			local var_108_6 = 0
			local var_108_7 = 0.65

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1459].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:GetWordFromCfg(323501022)
				local var_108_9 = arg_105_1:FormatText(var_108_8.content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 26 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 26)

				if (26 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 26)) > 0 and var_108_7 < var_108_11 then
					arg_105_1.talkMaxDuration = var_108_11

					if var_108_11 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501022", "story_v_out_323501.awb") ~= 0 then
					local var_108_12 = manager.audio:GetVoiceLength("story_v_out_323501", "323501022", "story_v_out_323501.awb") / 1000

					if var_108_12 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_6
					end

					if var_108_8.prefab_name ~= "" and arg_105_1.actors_[var_108_8.prefab_name] ~= nil then
						local var_108_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_8.prefab_name].transform, "story_v_out_323501", "323501022", "story_v_out_323501.awb")

						arg_105_1:RecordAudio("323501022", var_108_13)
						arg_105_1:RecordAudio("323501022", var_108_13)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_323501", "323501022", "story_v_out_323501.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_323501", "323501022", "story_v_out_323501.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play323501023 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 323501023
		arg_109_1.duration_ = 2.9

		local var_109_0 = {
			zh = 2.166,
			ja = 2.9
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play323501024(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10162ui_story"]) and arg_109_1.var_.characterEffect10162ui_story == nil then
				arg_109_1.var_.characterEffect10162ui_story = arg_109_1.actors_["10162ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10162ui_story"]) then
				if arg_109_1.var_.characterEffect10162ui_story and not isNil(arg_109_1.actors_["10162ui_story"]) then
					arg_109_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10162ui_story"]) and arg_109_1.var_.characterEffect10162ui_story then
				arg_109_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.275

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1461].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:GetWordFromCfg(323501023)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 11 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 11)

				if (11 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 11)) > 0 and var_112_2 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501023", "story_v_out_323501.awb") ~= 0 then
					local var_112_7 = manager.audio:GetVoiceLength("story_v_out_323501", "323501023", "story_v_out_323501.awb") / 1000

					if var_112_7 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_1
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_323501", "323501023", "story_v_out_323501.awb")

						arg_109_1:RecordAudio("323501023", var_112_8)
						arg_109_1:RecordAudio("323501023", var_112_8)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_323501", "323501023", "story_v_out_323501.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_323501", "323501023", "story_v_out_323501.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_9 and arg_109_1.time_ < var_112_1 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play323501024 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 323501024
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play323501025(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10162ui_story = arg_113_1.actors_["10162ui_story"].transform.localPosition

				local var_116_0 = GameObjectTools.GetOrAddComponent(arg_113_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_116_0 then
					var_116_0:EnableDynamicBone(false)
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["10162ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10162ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_1)
				arg_113_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10162ui_story"].transform.position).z)
				arg_113_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10162ui_story"].transform.localEulerAngles = arg_113_1.actors_["10162ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["10162ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10162ui_story"].transform.position).z)
				arg_113_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10162ui_story"].transform.localEulerAngles = arg_113_1.actors_["10162ui_story"].transform.localEulerAngles

				local var_116_2 = GameObjectTools.GetOrAddComponent(arg_113_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(true)
				end
			end

			local var_116_3 = arg_113_1.actors_["10166ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10166ui_story = var_116_3.localPosition

				local var_116_4 = GameObjectTools.GetOrAddComponent(var_116_3.gameObject, typeof(DynamicBoneHelper))

				if var_116_4 then
					var_116_4:EnableDynamicBone(false)
				end
			end

			local var_116_5 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 then
				var_116_3.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10166ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_5)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 then
				var_116_3.localPosition = Vector3.New(0, 100, 0)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles

				local var_116_6 = GameObjectTools.GetOrAddComponent(var_116_3.gameObject, typeof(DynamicBoneHelper))

				if var_116_6 then
					var_116_6:EnableDynamicBone(true)
				end
			end

			local var_116_7 = "1158ui_story"

			if arg_113_1.actors_["1158ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1158ui_story"))) then
				local var_116_8 = Object.Instantiate(Asset.Load("Char/" .. "1158ui_story"), arg_113_1.stage_.transform)

				var_116_8.name = var_116_7
				var_116_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_[var_116_7] = var_116_8

				local var_116_9 = var_116_8:GetComponentInChildren(typeof(CharacterEffect))

				var_116_9.enabled = true

				local var_116_10 = GameObjectTools.GetOrAddComponent(var_116_8, typeof(DynamicBoneHelper))

				if var_116_10 then
					var_116_10:EnableDynamicBone(false)
				end

				arg_113_1:ShowWeapon(var_116_9.transform, false)

				arg_113_1.var_[var_116_7 .. "Animator"] = var_116_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_113_1.var_[var_116_7 .. "Animator"].applyRootMotion = true
				arg_113_1.var_[var_116_7 .. "LipSync"] = var_116_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_116_11 = arg_113_1.actors_["1158ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.characterEffect1158ui_story == nil then
				arg_113_1.var_.characterEffect1158ui_story = var_116_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_12 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_12 and not isNil(var_116_11) then
				if arg_113_1.var_.characterEffect1158ui_story and not isNil(var_116_11) then
					arg_113_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1158ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_12)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_12 and arg_113_1.time_ < 0 + var_116_12 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.characterEffect1158ui_story then
				arg_113_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1158ui_story.fillRatio = 0.5
			end

			local var_116_13 = 0
			local var_116_14 = 1.65

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_15 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(323501024).content)

				arg_113_1.text_.text = var_116_15

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_17 = 66 <= 0 and var_116_14 or var_116_14 * (utf8.len(var_116_15) / 66)

				if (66 <= 0 and var_116_14 or var_116_14 * (utf8.len(var_116_15) / 66)) > 0 and var_116_14 < var_116_17 then
					arg_113_1.talkMaxDuration = var_116_17

					if var_116_17 + var_116_13 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_17 + var_116_13
					end
				end

				arg_113_1.text_.text = var_116_15
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_18 = math.max(var_116_14, arg_113_1.talkMaxDuration)

			if var_116_13 <= arg_113_1.time_ and arg_113_1.time_ < var_116_13 + var_116_18 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_13) / var_116_18

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_13 + var_116_18 and arg_113_1.time_ < var_116_13 + var_116_18 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10166ui_story",
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
	Play323501025 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 323501025
		arg_117_1.duration_ = 6.23

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play323501026(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0.233333333333333 < arg_117_1.time_ and arg_117_1.time_ <= 0.233333333333333 + arg_120_0 then
				local var_120_0 = arg_117_1.var_.effect334

				if not arg_117_1.var_.effect334 then
					var_120_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xdaoguang"), manager.ui.mainCamera.transform)
					var_120_0.name = "334"
					arg_117_1.var_.effect334 = var_120_0
				else
					var_120_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_120_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_120_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_120_0.transform.localScale = Vector3.New(var_120_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_120_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_120_0.transform.localScale.z)
			end

			local var_120_2 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			if arg_117_1.time_ >= var_120_2 + 1.7 and arg_117_1.time_ < var_120_2 + 1.7 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_swordlight", "")
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_4 = 1.233333333332
			local var_120_5 = 1.175

			if 1.233333333332 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_6 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_6:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_7 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(323501025).content)

				arg_117_1.text_.text = var_120_7

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 47 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 47)

				if (47 <= 0 and var_120_5 or var_120_5 * (utf8.len(var_120_7) / 47)) > 0 and var_120_5 < var_120_9 then
					arg_117_1.talkMaxDuration = var_120_9
					var_120_4 = var_120_4 + 0.3

					if var_120_9 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_9 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_7
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = var_120_4 + 0.3
			local var_120_11 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_10) / var_120_11

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play323501026 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 323501026
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play323501027(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0.466666666666667 < arg_123_1.time_ and arg_123_1.time_ <= 0.466666666666667 + arg_126_0 then
				arg_123_1:AudioAction("play", "effect", "se_story_148", "se_story_148_monster_roll", "")
			end

			local var_126_1 = 0
			local var_126_2 = 1.275

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(323501026).content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 51 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 51)

				if (51 <= 0 and var_126_2 or var_126_2 * (utf8.len(var_126_3) / 51)) > 0 and var_126_2 < var_126_5 then
					arg_123_1.talkMaxDuration = var_126_5

					if var_126_5 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_6 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_6 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_6

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_6 and arg_123_1.time_ < var_126_1 + var_126_6 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play323501027 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 323501027
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play323501028(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.9

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(323501027).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 36 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 36)

				if (36 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 36)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play323501028 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 323501028
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play323501029(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.4

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(323501028).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 16 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 16)

				if (16 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 16)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play323501029 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 323501029
		arg_135_1.duration_ = 3.77

		local var_135_0 = {
			zh = 3.766,
			ja = 1.999999999999
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
				arg_135_0:Play323501030(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if arg_135_1.actors_["10170ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10170ui_story"))) then
				local var_138_0 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_135_1.stage_.transform)

				var_138_0.name = "10170ui_story"
				var_138_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.actors_["10170ui_story"] = var_138_0

				local var_138_1 = var_138_0:GetComponentInChildren(typeof(CharacterEffect))

				var_138_1.enabled = true

				local var_138_2 = GameObjectTools.GetOrAddComponent(var_138_0, typeof(DynamicBoneHelper))

				if var_138_2 then
					var_138_2:EnableDynamicBone(false)
				end

				arg_135_1:ShowWeapon(var_138_1.transform, false)

				arg_135_1.var_["10170ui_story" .. "Animator"] = var_138_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_135_1.var_["10170ui_story" .. "Animator"].applyRootMotion = true
				arg_135_1.var_["10170ui_story" .. "LipSync"] = var_138_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_138_3 = arg_135_1.actors_["10170ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10170ui_story = var_138_3.localPosition

				local var_138_4 = GameObjectTools.GetOrAddComponent(var_138_3.gameObject, typeof(DynamicBoneHelper))

				if var_138_4 then
					var_138_4:EnableDynamicBone(false)
				end
			end

			local var_138_5 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_5 then
				var_138_3.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_135_1.time_ - 0) / var_138_5)
				var_138_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_3.position).x, (manager.ui.mainCamera.transform.position - var_138_3.position).y, (manager.ui.mainCamera.transform.position - var_138_3.position).z)
				var_138_3.localEulerAngles.z = 0
				var_138_3.localEulerAngles.x = 0
				var_138_3.localEulerAngles = var_138_3.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_5 and arg_135_1.time_ < 0 + var_138_5 + arg_138_0 then
				var_138_3.localPosition = Vector3.New(0, -1.03, -6.05)
				var_138_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_3.position).x, (manager.ui.mainCamera.transform.position - var_138_3.position).y, (manager.ui.mainCamera.transform.position - var_138_3.position).z)
				var_138_3.localEulerAngles.z = 0
				var_138_3.localEulerAngles.x = 0
				var_138_3.localEulerAngles = var_138_3.localEulerAngles

				local var_138_6 = GameObjectTools.GetOrAddComponent(var_138_3.gameObject, typeof(DynamicBoneHelper))

				if var_138_6 then
					var_138_6:EnableDynamicBone(true)
				end
			end

			local var_138_7 = arg_135_1.actors_["10170ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.characterEffect10170ui_story == nil then
				arg_135_1.var_.characterEffect10170ui_story = var_138_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_8 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_8 and not isNil(var_138_7) then
				if arg_135_1.var_.characterEffect10170ui_story and not isNil(var_138_7) then
					arg_135_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_8 and arg_135_1.time_ < 0 + var_138_8 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.characterEffect10170ui_story then
				arg_135_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action30_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_138_10 = 0
			local var_138_11 = 0.475

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_12 = arg_135_1:GetWordFromCfg(323501029)
				local var_138_13 = arg_135_1:FormatText(var_138_12.content)

				arg_135_1.text_.text = var_138_13

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_15 = 19 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 19)

				if (19 <= 0 and var_138_11 or var_138_11 * (utf8.len(var_138_13) / 19)) > 0 and var_138_11 < var_138_15 then
					arg_135_1.talkMaxDuration = var_138_15

					if var_138_15 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_15 + var_138_10
					end
				end

				arg_135_1.text_.text = var_138_13
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501029", "story_v_out_323501.awb") ~= 0 then
					local var_138_16 = manager.audio:GetVoiceLength("story_v_out_323501", "323501029", "story_v_out_323501.awb") / 1000

					if var_138_16 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_16 + var_138_10
					end

					if var_138_12.prefab_name ~= "" and arg_135_1.actors_[var_138_12.prefab_name] ~= nil then
						local var_138_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_12.prefab_name].transform, "story_v_out_323501", "323501029", "story_v_out_323501.awb")

						arg_135_1:RecordAudio("323501029", var_138_17)
						arg_135_1:RecordAudio("323501029", var_138_17)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_323501", "323501029", "story_v_out_323501.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_323501", "323501029", "story_v_out_323501.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_18 = math.max(var_138_11, arg_135_1.talkMaxDuration)

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_18 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_10) / var_138_18

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_10 + var_138_18 and arg_135_1.time_ < var_138_10 + var_138_18 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play323501030 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 323501030
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
			arg_139_1.auto_ = false
		end

		function arg_139_1.playNext_(arg_141_0)
			arg_139_1.onStoryFinished_()
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if arg_139_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_142_0 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_139_1.stage_.transform)

				var_142_0.name = "1033ui_story"
				var_142_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["1033ui_story"] = var_142_0

				local var_142_1 = var_142_0:GetComponentInChildren(typeof(CharacterEffect))

				var_142_1.enabled = true

				local var_142_2 = GameObjectTools.GetOrAddComponent(var_142_0, typeof(DynamicBoneHelper))

				if var_142_2 then
					var_142_2:EnableDynamicBone(false)
				end

				arg_139_1:ShowWeapon(var_142_1.transform, false)

				arg_139_1.var_["1033ui_story" .. "Animator"] = var_142_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_139_1.var_["1033ui_story" .. "Animator"].applyRootMotion = true
				arg_139_1.var_["1033ui_story" .. "LipSync"] = var_142_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_142_3 = arg_139_1.actors_["1033ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_3) and arg_139_1.var_.characterEffect1033ui_story == nil then
				arg_139_1.var_.characterEffect1033ui_story = var_142_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_4 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 and not isNil(var_142_3) then
				if arg_139_1.var_.characterEffect1033ui_story and not isNil(var_142_3) then
					arg_139_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_4)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 and not isNil(var_142_3) and arg_139_1.var_.characterEffect1033ui_story then
				arg_139_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_142_5 = 0
			local var_142_6 = 0.55

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_7 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(323501030).content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 22 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_7) / 22)

				if (22 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_7) / 22)) > 0 and var_142_6 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_5
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_6, arg_139_1.talkMaxDuration)

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_5) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_5 + var_142_10 and arg_139_1.time_ < var_142_5 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/ST59",
		"TextureConfig/Background/ST47",
		"TextureConfig/Background/J21f"
	},
	voices = {
		"story_v_out_323501.awb"
	}
}
