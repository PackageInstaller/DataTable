return {
	Play420191001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 420191001
		arg_1_1.duration_ = 7.17

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play420191002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.SS2005 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2005")
				var_4_0.name = "SS2005"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.SS2005 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.SS2005

				arg_1_1.bgs_.SS2005.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "SS2005" then
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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_found", "bgm_activity_4_0_story_found", "bgm_activity_4_0_story_found.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_4_0_story_found", "bgm_activity_4_0_story_found")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = arg_1_1.bgs_.SS2005.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosSS2005 = var_4_14.localPosition
			end

			local var_4_15 = 0.1

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_15 then
				var_4_14.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosSS2005, Vector3.New(0, 1, 9), (arg_1_1.time_ - 0) / var_4_15)
			end

			if arg_1_1.time_ >= 0 + var_4_15 and arg_1_1.time_ < 0 + var_4_15 + arg_4_0 then
				var_4_14.localPosition = Vector3.New(0, 1, 9)
			end

			local var_4_16 = arg_1_1.bgs_.SS2005.transform

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1.var_.moveOldPosSS2005 = var_4_16.localPosition
			end

			local var_4_17 = 1.966666666666

			if 0.2 <= arg_1_1.time_ and arg_1_1.time_ < 0.2 + var_4_17 then
				var_4_16.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosSS2005, Vector3.New(0, 1, 10), (arg_1_1.time_ - 0.2) / var_4_17)
			end

			if arg_1_1.time_ >= 0.2 + var_4_17 and arg_1_1.time_ < 0.2 + var_4_17 + arg_4_0 then
				var_4_16.localPosition = Vector3.New(0, 1, 10)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_18 = arg_1_1.var_.effect1001

				if not arg_1_1.var_.effect1001 then
					var_4_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_piaosan"), manager.ui.mainCamera.transform)
					var_4_18.name = "1001"
					arg_1_1.var_.effect1001 = var_4_18
				else
					var_4_18.transform:SetParent(var_4_9000)
				end

				var_4_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_20 = 2.166666666666
			local var_4_21 = 0.05

			if 2.166666666666 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
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

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_23 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(420191001).content)

				arg_1_1.text_.text = var_4_23

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 2 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_23) / 2)

				if (2 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_23) / 2)) > 0 and var_4_21 < var_4_25 then
					arg_1_1.talkMaxDuration = var_4_25
					var_4_20 = var_4_20 + 0.3

					if var_4_25 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_23
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_26 = var_4_20 + 0.3
			local var_4_27 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_26) / var_4_27

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2005",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2005",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.966666666666,
				className = "StoryMoveNode",
				startTime = 0.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play420191002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 420191002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play420191003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.7

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(420191002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 28 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 28)

				if (28 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 28)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play420191003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 420191003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play420191004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.2

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(420191003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 48 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 48)

				if (48 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 48)) > 0 and var_16_0 < var_16_3 then
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
	Play420191004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 420191004
		arg_17_1.duration_ = 7

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play420191005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.bgs_.ST76 == nil then
				local var_20_0 = Object.Instantiate(arg_17_1.paintGo_)

				var_20_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST76")
				var_20_0.name = "ST76"
				var_20_0.transform.parent = arg_17_1.stage_.transform
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.bgs_.ST76 = var_20_0
			end

			if 1 < arg_17_1.time_ and arg_17_1.time_ <= 1 + arg_20_0 then
				local var_20_1 = arg_17_1.bgs_.ST76

				arg_17_1.bgs_.ST76.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_20_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_2 = var_20_1:GetComponent("SpriteRenderer")

				if var_20_2 and var_20_2.sprite then
					local var_20_3 = 2 * (var_20_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_20_1.transform.localScale = Vector3.New(var_20_3 / var_20_2.sprite.bounds.size.y < var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x and var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x or var_20_3 / var_20_2.sprite.bounds.size.y, var_20_3 / var_20_2.sprite.bounds.size.y < var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x and var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x or var_20_3 / var_20_2.sprite.bounds.size.y, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "ST76" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_4 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_5 = 1

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_5 then
				local var_20_6 = Color.New(0, 0, 0)

				var_20_6.a = Mathf.Lerp(0, 1, (arg_17_1.time_ - var_20_4) / var_20_5)
				arg_17_1.mask_.color = var_20_6
			end

			if arg_17_1.time_ >= var_20_4 + var_20_5 and arg_17_1.time_ < var_20_4 + var_20_5 + arg_20_0 then
				local var_20_7 = Color.New(0, 0, 0)

				var_20_7.a = 1
				arg_17_1.mask_.color = var_20_7
			end

			local var_20_8 = 1

			if 1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_9 = 1

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_9 then
				local var_20_10 = Color.New(0, 0, 0)

				var_20_10.a = Mathf.Lerp(1, 0, (arg_17_1.time_ - var_20_8) / var_20_9)
				arg_17_1.mask_.color = var_20_10
			end

			if arg_17_1.time_ >= var_20_8 + var_20_9 and arg_17_1.time_ < var_20_8 + var_20_9 + arg_20_0 then
				local var_20_11 = Color.New(0, 0, 0)

				arg_17_1.mask_.enabled = false
				var_20_11.a = 0
				arg_17_1.mask_.color = var_20_11
			end

			if 0.983333333333333 < arg_17_1.time_ and arg_17_1.time_ <= 0.983333333333333 + arg_20_0 then
				if arg_17_1.var_.effect1001 then
					Object.Destroy(arg_17_1.var_.effect1001)

					arg_17_1.var_.effect1001 = nil
				end
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_13 = 2
			local var_20_14 = 0.175

			if 2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_15 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_15:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_16 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(420191004).content)

				arg_17_1.text_.text = var_20_16

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_18 = 7 <= 0 and var_20_14 or var_20_14 * (utf8.len(var_20_16) / 7)

				if (7 <= 0 and var_20_14 or var_20_14 * (utf8.len(var_20_16) / 7)) > 0 and var_20_14 < var_20_18 then
					arg_17_1.talkMaxDuration = var_20_18
					var_20_13 = var_20_13 + 0.3

					if var_20_18 + var_20_13 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_13
					end
				end

				arg_17_1.text_.text = var_20_16
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_19 = var_20_13 + 0.3
			local var_20_20 = math.max(var_20_14, arg_17_1.talkMaxDuration)

			if var_20_13 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_19 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_19) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_19 + var_20_20 and arg_17_1.time_ < var_20_19 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play420191005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 420191005
		arg_23_1.duration_ = 14.77

		local var_23_0 = {
			zh = 8.133,
			ja = 14.766
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play420191006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if arg_23_1.actors_["1085ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1085ui_story"))) then
				local var_26_0 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_23_1.stage_.transform)

				var_26_0.name = "1085ui_story"
				var_26_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["1085ui_story"] = var_26_0

				local var_26_1 = var_26_0:GetComponentInChildren(typeof(CharacterEffect))

				var_26_1.enabled = true

				local var_26_2 = GameObjectTools.GetOrAddComponent(var_26_0, typeof(DynamicBoneHelper))

				if var_26_2 then
					var_26_2:EnableDynamicBone(false)
				end

				arg_23_1:ShowWeapon(var_26_1.transform, false)

				arg_23_1.var_["1085ui_story" .. "Animator"] = var_26_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_23_1.var_["1085ui_story" .. "Animator"].applyRootMotion = true
				arg_23_1.var_["1085ui_story" .. "LipSync"] = var_26_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_26_3 = arg_23_1.actors_["1085ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1085ui_story = var_26_3.localPosition
			end

			local var_26_4 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_3.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_23_1.time_ - 0) / var_26_4)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_3.localPosition = Vector3.New(0, -1.01, -5.83)
				var_26_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_3.position).x, (manager.ui.mainCamera.transform.position - var_26_3.position).y, (manager.ui.mainCamera.transform.position - var_26_3.position).z)
				var_26_3.localEulerAngles.z = 0
				var_26_3.localEulerAngles.x = 0
				var_26_3.localEulerAngles = var_26_3.localEulerAngles
			end

			local var_26_5 = arg_23_1.actors_["1085ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1085ui_story == nil then
				arg_23_1.var_.characterEffect1085ui_story = var_26_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_6 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 and not isNil(var_26_5) then
				if arg_23_1.var_.characterEffect1085ui_story and not isNil(var_26_5) then
					arg_23_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 and not isNil(var_26_5) and arg_23_1.var_.characterEffect1085ui_story then
				arg_23_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_26_8 = 0
			local var_26_9 = 0.7

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_10 = arg_23_1:GetWordFromCfg(420191005)
				local var_26_11 = arg_23_1:FormatText(var_26_10.content)

				arg_23_1.text_.text = var_26_11

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 28 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 28)

				if (28 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 28)) > 0 and var_26_9 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13

					if var_26_13 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_11
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191005", "story_v_out_420191.awb") ~= 0 then
					local var_26_14 = manager.audio:GetVoiceLength("story_v_out_420191", "420191005", "story_v_out_420191.awb") / 1000

					if var_26_14 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_14 + var_26_8
					end

					if var_26_10.prefab_name ~= "" and arg_23_1.actors_[var_26_10.prefab_name] ~= nil then
						local var_26_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_10.prefab_name].transform, "story_v_out_420191", "420191005", "story_v_out_420191.awb")

						arg_23_1:RecordAudio("420191005", var_26_15)
						arg_23_1:RecordAudio("420191005", var_26_15)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_420191", "420191005", "story_v_out_420191.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_420191", "420191005", "story_v_out_420191.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_16 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_16 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_16

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_16 and arg_23_1.time_ < var_26_8 + var_26_16 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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

		arg_23_1:InitPlayNodeList()
	end,
	Play420191006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 420191006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play420191007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1085ui_story"]) and arg_27_1.var_.characterEffect1085ui_story == nil then
				arg_27_1.var_.characterEffect1085ui_story = arg_27_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_0 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1085ui_story"]) then
				if arg_27_1.var_.characterEffect1085ui_story and not isNil(arg_27_1.actors_["1085ui_story"]) then
					arg_27_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_0)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1085ui_story"]) and arg_27_1.var_.characterEffect1085ui_story then
				arg_27_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_30_1 = 0
			local var_30_2 = 0.2

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_3 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(420191006).content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 8 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 8)

				if (8 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 8)) > 0 and var_30_2 < var_30_5 then
					arg_27_1.talkMaxDuration = var_30_5

					if var_30_5 + var_30_1 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + var_30_1
					end
				end

				arg_27_1.text_.text = var_30_3
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_6 = math.max(var_30_2, arg_27_1.talkMaxDuration)

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_6 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_1) / var_30_6

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_1 + var_30_6 and arg_27_1.time_ < var_30_1 + var_30_6 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play420191007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 420191007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play420191008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.55

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(420191007).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 22 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 22)

				if (22 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 22)) > 0 and var_34_0 < var_34_3 then
					arg_31_1.talkMaxDuration = var_34_3

					if var_34_3 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_3 + 0
					end
				end

				arg_31_1.text_.text = var_34_1
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_4 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_4

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play420191008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 420191008
		arg_35_1.duration_ = 11.1

		local var_35_0 = {
			zh = 8.2,
			ja = 11.1
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
				arg_35_0:Play420191009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1085ui_story"]) and arg_35_1.var_.characterEffect1085ui_story == nil then
				arg_35_1.var_.characterEffect1085ui_story = arg_35_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1085ui_story"]) then
				if arg_35_1.var_.characterEffect1085ui_story and not isNil(arg_35_1.actors_["1085ui_story"]) then
					arg_35_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1085ui_story"]) and arg_35_1.var_.characterEffect1085ui_story then
				arg_35_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_38_2 = 0
			local var_38_3 = 0.725

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_4 = arg_35_1:GetWordFromCfg(420191008)
				local var_38_5 = arg_35_1:FormatText(var_38_4.content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 29 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_5) / 29)

				if (29 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_5) / 29)) > 0 and var_38_3 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_2
					end
				end

				arg_35_1.text_.text = var_38_5
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191008", "story_v_out_420191.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191008", "story_v_out_420191.awb") / 1000

					if var_38_8 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_2
					end

					if var_38_4.prefab_name ~= "" and arg_35_1.actors_[var_38_4.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_4.prefab_name].transform, "story_v_out_420191", "420191008", "story_v_out_420191.awb")

						arg_35_1:RecordAudio("420191008", var_38_9)
						arg_35_1:RecordAudio("420191008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_420191", "420191008", "story_v_out_420191.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_420191", "420191008", "story_v_out_420191.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_3, arg_35_1.talkMaxDuration)

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_2) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_2 + var_38_10 and arg_35_1.time_ < var_38_2 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play420191009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 420191009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play420191010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1085ui_story"]) and arg_39_1.var_.characterEffect1085ui_story == nil then
				arg_39_1.var_.characterEffect1085ui_story = arg_39_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.200000002980232

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1085ui_story"]) then
				if arg_39_1.var_.characterEffect1085ui_story and not isNil(arg_39_1.actors_["1085ui_story"]) then
					arg_39_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1085ui_story"]) and arg_39_1.var_.characterEffect1085ui_story then
				arg_39_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_42_1 = 0
			local var_42_2 = 0.325

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(420191009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 13 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 13)

				if (13 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 13)) > 0 and var_42_2 < var_42_5 then
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
	Play420191010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 420191010
		arg_43_1.duration_ = 13

		local var_43_0 = {
			zh = 12.833,
			ja = 13
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play420191011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1085ui_story"]) and arg_43_1.var_.characterEffect1085ui_story == nil then
				arg_43_1.var_.characterEffect1085ui_story = arg_43_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1085ui_story"]) then
				if arg_43_1.var_.characterEffect1085ui_story and not isNil(arg_43_1.actors_["1085ui_story"]) then
					arg_43_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1085ui_story"]) and arg_43_1.var_.characterEffect1085ui_story then
				arg_43_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_46_2 = 0
			local var_46_3 = 1.15

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_4 = arg_43_1:GetWordFromCfg(420191010)
				local var_46_5 = arg_43_1:FormatText(var_46_4.content)

				arg_43_1.text_.text = var_46_5

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_7 = 46 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_5) / 46)

				if (46 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_5) / 46)) > 0 and var_46_3 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_2
					end
				end

				arg_43_1.text_.text = var_46_5
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191010", "story_v_out_420191.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191010", "story_v_out_420191.awb") / 1000

					if var_46_8 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_2
					end

					if var_46_4.prefab_name ~= "" and arg_43_1.actors_[var_46_4.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_4.prefab_name].transform, "story_v_out_420191", "420191010", "story_v_out_420191.awb")

						arg_43_1:RecordAudio("420191010", var_46_9)
						arg_43_1:RecordAudio("420191010", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_420191", "420191010", "story_v_out_420191.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_420191", "420191010", "story_v_out_420191.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_3, arg_43_1.talkMaxDuration)

			if var_46_2 <= arg_43_1.time_ and arg_43_1.time_ < var_46_2 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_2) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_2 + var_46_10 and arg_43_1.time_ < var_46_2 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play420191011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 420191011
		arg_47_1.duration_ = 13.7

		local var_47_0 = {
			zh = 9.8,
			ja = 13.7
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play420191012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.875

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:GetWordFromCfg(420191011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 35 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 35)

				if (35 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 35)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191011", "story_v_out_420191.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191011", "story_v_out_420191.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_420191", "420191011", "story_v_out_420191.awb")

						arg_47_1:RecordAudio("420191011", var_50_6)
						arg_47_1:RecordAudio("420191011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_420191", "420191011", "story_v_out_420191.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_420191", "420191011", "story_v_out_420191.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play420191012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 420191012
		arg_51_1.duration_ = 5.87

		local var_51_0 = {
			zh = 3.433,
			ja = 5.866
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play420191013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_1")
			end

			local var_54_0 = 0
			local var_54_1 = 0.45

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_2 = arg_51_1:GetWordFromCfg(420191012)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 18 <= 0 and var_54_1 or var_54_1 * (utf8.len(var_54_3) / 18)

				if (18 <= 0 and var_54_1 or var_54_1 * (utf8.len(var_54_3) / 18)) > 0 and var_54_1 < var_54_5 then
					arg_51_1.talkMaxDuration = var_54_5

					if var_54_5 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191012", "story_v_out_420191.awb") ~= 0 then
					local var_54_6 = manager.audio:GetVoiceLength("story_v_out_420191", "420191012", "story_v_out_420191.awb") / 1000

					if var_54_6 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_0
					end

					if var_54_2.prefab_name ~= "" and arg_51_1.actors_[var_54_2.prefab_name] ~= nil then
						local var_54_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_2.prefab_name].transform, "story_v_out_420191", "420191012", "story_v_out_420191.awb")

						arg_51_1:RecordAudio("420191012", var_54_7)
						arg_51_1:RecordAudio("420191012", var_54_7)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_420191", "420191012", "story_v_out_420191.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_420191", "420191012", "story_v_out_420191.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_8 and arg_51_1.time_ < var_54_0 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play420191013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 420191013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play420191014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1085ui_story = arg_55_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1085ui_story"].transform.position).z)
				arg_55_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1085ui_story"].transform.localEulerAngles = arg_55_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1085ui_story"].transform.position).z)
				arg_55_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1085ui_story"].transform.localEulerAngles = arg_55_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_58_1 = 0
			local var_58_2 = 1.05

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_3 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(420191013).content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 42 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 42)

				if (42 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 42)) > 0 and var_58_2 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_1
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_6 = math.max(var_58_2, arg_55_1.talkMaxDuration)

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_6 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_1) / var_58_6

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_1 + var_58_6 and arg_55_1.time_ < var_58_1 + var_58_6 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play420191014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 420191014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play420191015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.925

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(420191014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 37 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 37)

				if (37 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 37)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play420191015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 420191015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play420191016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.25

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(420191015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 10 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 10)

				if (10 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 10)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play420191016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 420191016
		arg_67_1.duration_ = 6.13

		local var_67_0 = {
			zh = 5.8,
			ja = 6.133
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
				arg_67_0:Play420191017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1085ui_story = arg_67_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1085ui_story"].transform.position).z)
				arg_67_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1085ui_story"].transform.localEulerAngles = arg_67_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_67_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1085ui_story"].transform.position).z)
				arg_67_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1085ui_story"].transform.localEulerAngles = arg_67_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1085ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1085ui_story == nil then
				arg_67_1.var_.characterEffect1085ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1085ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1085ui_story then
				arg_67_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_2")
			end

			local var_70_4 = 0
			local var_70_5 = 0.375

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:GetWordFromCfg(420191016)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 15 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 15)

				if (15 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 15)) > 0 and var_70_5 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191016", "story_v_out_420191.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_out_420191", "420191016", "story_v_out_420191.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_out_420191", "420191016", "story_v_out_420191.awb")

						arg_67_1:RecordAudio("420191016", var_70_11)
						arg_67_1:RecordAudio("420191016", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_420191", "420191016", "story_v_out_420191.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_420191", "420191016", "story_v_out_420191.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_12 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_12 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_12

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_12 and arg_67_1.time_ < var_70_4 + var_70_12 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play420191017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 420191017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play420191018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1085ui_story"]) and arg_71_1.var_.characterEffect1085ui_story == nil then
				arg_71_1.var_.characterEffect1085ui_story = arg_71_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1085ui_story"]) then
				if arg_71_1.var_.characterEffect1085ui_story and not isNil(arg_71_1.actors_["1085ui_story"]) then
					arg_71_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1085ui_story"]) and arg_71_1.var_.characterEffect1085ui_story then
				arg_71_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_74_1 = 0
			local var_74_2 = 0.925

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(420191017).content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 37 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 37)

				if (37 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 37)) > 0 and var_74_2 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_6 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_6 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_6

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_6 and arg_71_1.time_ < var_74_1 + var_74_6 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play420191018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 420191018
		arg_75_1.duration_ = 7.7

		local var_75_0 = {
			zh = 7.7,
			ja = 7.366
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
				arg_75_0:Play420191019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1085ui_story"]) and arg_75_1.var_.characterEffect1085ui_story == nil then
				arg_75_1.var_.characterEffect1085ui_story = arg_75_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1085ui_story"]) then
				if arg_75_1.var_.characterEffect1085ui_story and not isNil(arg_75_1.actors_["1085ui_story"]) then
					arg_75_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1085ui_story"]) and arg_75_1.var_.characterEffect1085ui_story then
				arg_75_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_78_2 = 0
			local var_78_3 = 0.9

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_4 = arg_75_1:GetWordFromCfg(420191018)
				local var_78_5 = arg_75_1:FormatText(var_78_4.content)

				arg_75_1.text_.text = var_78_5

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 31 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 31)

				if (31 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 31)) > 0 and var_78_3 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_2
					end
				end

				arg_75_1.text_.text = var_78_5
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191018", "story_v_out_420191.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191018", "story_v_out_420191.awb") / 1000

					if var_78_8 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_2
					end

					if var_78_4.prefab_name ~= "" and arg_75_1.actors_[var_78_4.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_4.prefab_name].transform, "story_v_out_420191", "420191018", "story_v_out_420191.awb")

						arg_75_1:RecordAudio("420191018", var_78_9)
						arg_75_1:RecordAudio("420191018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_420191", "420191018", "story_v_out_420191.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_420191", "420191018", "story_v_out_420191.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_3, arg_75_1.talkMaxDuration)

			if var_78_2 <= arg_75_1.time_ and arg_75_1.time_ < var_78_2 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_2) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_2 + var_78_10 and arg_75_1.time_ < var_78_2 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play420191019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 420191019
		arg_79_1.duration_ = 12.13

		local var_79_0 = {
			zh = 6.566,
			ja = 12.133
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play420191020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_82_0 = 0
			local var_82_1 = 0.725

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(420191019)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 29 <= 0 and var_82_1 or var_82_1 * (utf8.len(var_82_3) / 29)

				if (29 <= 0 and var_82_1 or var_82_1 * (utf8.len(var_82_3) / 29)) > 0 and var_82_1 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191019", "story_v_out_420191.awb") ~= 0 then
					local var_82_6 = manager.audio:GetVoiceLength("story_v_out_420191", "420191019", "story_v_out_420191.awb") / 1000

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end

					if var_82_2.prefab_name ~= "" and arg_79_1.actors_[var_82_2.prefab_name] ~= nil then
						local var_82_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_2.prefab_name].transform, "story_v_out_420191", "420191019", "story_v_out_420191.awb")

						arg_79_1:RecordAudio("420191019", var_82_7)
						arg_79_1:RecordAudio("420191019", var_82_7)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_420191", "420191019", "story_v_out_420191.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_420191", "420191019", "story_v_out_420191.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_8 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_8

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_8 and arg_79_1.time_ < var_82_0 + var_82_8 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play420191020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 420191020
		arg_83_1.duration_ = 14.83

		local var_83_0 = {
			zh = 9.833,
			ja = 14.833
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
				arg_83_0:Play420191021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.9

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:GetWordFromCfg(420191020)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 36 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 36)

				if (36 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 36)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191020", "story_v_out_420191.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191020", "story_v_out_420191.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_420191", "420191020", "story_v_out_420191.awb")

						arg_83_1:RecordAudio("420191020", var_86_6)
						arg_83_1:RecordAudio("420191020", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_420191", "420191020", "story_v_out_420191.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_420191", "420191020", "story_v_out_420191.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play420191021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 420191021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play420191022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1085ui_story"]) and arg_87_1.var_.characterEffect1085ui_story == nil then
				arg_87_1.var_.characterEffect1085ui_story = arg_87_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1085ui_story"]) then
				if arg_87_1.var_.characterEffect1085ui_story and not isNil(arg_87_1.actors_["1085ui_story"]) then
					arg_87_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1085ui_story"]) and arg_87_1.var_.characterEffect1085ui_story then
				arg_87_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_90_1 = 0
			local var_90_2 = 0.225

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(420191021).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 9 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 9)

				if (9 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 9)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play420191022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 420191022
		arg_91_1.duration_ = 1

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"

			SetActive(arg_91_1.choicesGo_, true)

			for iter_92_0, iter_92_1 in ipairs(arg_91_1.choices_) do
				SetActive(iter_92_1.go, iter_92_0 <= 1)
			end

			arg_91_1.choices_[1].txt.text = arg_91_1:FormatText(StoryChoiceCfg[1238].name)
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play420191023(arg_91_1)
			end

			arg_91_1:RecordChoiceLog(420191022, 1238)
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			return
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play420191023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 420191023
		arg_95_1.duration_ = 10.63

		local var_95_0 = {
			zh = 10.632999999999,
			ja = 10.032999999999
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play420191024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if arg_95_1.bgs_.ST67 == nil then
				local var_98_0 = Object.Instantiate(arg_95_1.paintGo_)

				var_98_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST67")
				var_98_0.name = "ST67"
				var_98_0.transform.parent = arg_95_1.stage_.transform
				var_98_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.bgs_.ST67 = var_98_0
			end

			if 1.999999999999 < arg_95_1.time_ and arg_95_1.time_ <= 1.999999999999 + arg_98_0 then
				local var_98_1 = arg_95_1.bgs_.ST67

				arg_95_1.bgs_.ST67.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_98_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_2 = var_98_1:GetComponent("SpriteRenderer")

				if var_98_2 and var_98_2.sprite then
					local var_98_3 = 2 * (var_98_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_98_1.transform.localScale = Vector3.New(var_98_3 / var_98_2.sprite.bounds.size.y < var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x and var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x or var_98_3 / var_98_2.sprite.bounds.size.y, var_98_3 / var_98_2.sprite.bounds.size.y < var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x and var_98_3 * manager.ui.mainCameraCom_.aspect / var_98_2.sprite.bounds.size.x or var_98_3 / var_98_2.sprite.bounds.size.y, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "ST67" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_4 = 4

			if 4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.allBtn_.enabled = false
			end

			if arg_95_1.time_ >= var_98_4 + 0.3 and arg_95_1.time_ < var_98_4 + 0.3 + arg_98_0 then
				arg_95_1.allBtn_.enabled = true
			end

			local var_98_5 = 0

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_6 = 2

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_6 then
				local var_98_7 = Color.New(0, 0, 0)

				var_98_7.a = Mathf.Lerp(0, 1, (arg_95_1.time_ - var_98_5) / var_98_6)
				arg_95_1.mask_.color = var_98_7
			end

			if arg_95_1.time_ >= var_98_5 + var_98_6 and arg_95_1.time_ < var_98_5 + var_98_6 + arg_98_0 then
				local var_98_8 = Color.New(0, 0, 0)

				var_98_8.a = 1
				arg_95_1.mask_.color = var_98_8
			end

			local var_98_9 = 2

			if 2 < arg_95_1.time_ and arg_95_1.time_ <= var_98_9 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_10 = 2

			if var_98_9 <= arg_95_1.time_ and arg_95_1.time_ < var_98_9 + var_98_10 then
				local var_98_11 = Color.New(0, 0, 0)

				var_98_11.a = Mathf.Lerp(1, 0, (arg_95_1.time_ - var_98_9) / var_98_10)
				arg_95_1.mask_.color = var_98_11
			end

			if arg_95_1.time_ >= var_98_9 + var_98_10 and arg_95_1.time_ < var_98_9 + var_98_10 + arg_98_0 then
				local var_98_12 = Color.New(0, 0, 0)

				arg_95_1.mask_.enabled = false
				var_98_12.a = 0
				arg_95_1.mask_.color = var_98_12
			end

			if 1.76666666666667 < arg_95_1.time_ and arg_95_1.time_ <= 1.76666666666667 + arg_98_0 then
				arg_95_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_98_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_95_1.bgmTxt_.text ~= var_98_16 and arg_95_1.bgmTxt_.text ~= "" then
						if arg_95_1.bgmTxt2_.text ~= "" then
							arg_95_1.bgmTxt_.text = arg_95_1.bgmTxt2_.text
						end

						arg_95_1.bgmTxt2_.text = var_98_16

						arg_95_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_95_1.bgmTxt_.text = var_98_16
						arg_95_1.bgmTxt2_.text = var_98_16
					end

					if arg_95_1.bgmTimer then
						arg_95_1.bgmTimer:Stop()

						arg_95_1.bgmTimer = nil
					end

					if arg_95_1.settingData.show_music_name == 1 then
						arg_95_1.musicController:SetSelectedState("show")
						arg_95_1.musicAnimator_:Play("open", 0, 0)

						if arg_95_1.settingData.music_time ~= 0 then
							arg_95_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_95_1.settingData.music_time), function()
								if arg_95_1 == nil or isNil(arg_95_1.bgmTxt_) then
									return
								end

								arg_95_1.musicController:SetSelectedState("hide")
								arg_95_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.98333333333233 < arg_95_1.time_ and arg_95_1.time_ <= 1.98333333333233 + arg_98_0 then
				if arg_95_1.var_.effect1001 then
					Object.Destroy(arg_95_1.var_.effect1001)

					arg_95_1.var_.effect1001 = nil
				end
			end

			local var_98_18 = arg_95_1.actors_["1085ui_story"].transform

			if 1.96599999815126 < arg_95_1.time_ and arg_95_1.time_ <= 1.96599999815126 + arg_98_0 then
				arg_95_1.var_.moveOldPos1085ui_story = var_98_18.localPosition
			end

			local var_98_19 = 0.001

			if 1.96599999815126 <= arg_95_1.time_ and arg_95_1.time_ < 1.96599999815126 + var_98_19 then
				var_98_18.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_95_1.time_ - 1.96599999815126) / var_98_19)
				var_98_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_18.position).x, (manager.ui.mainCamera.transform.position - var_98_18.position).y, (manager.ui.mainCamera.transform.position - var_98_18.position).z)
				var_98_18.localEulerAngles.z = 0
				var_98_18.localEulerAngles.x = 0
				var_98_18.localEulerAngles = var_98_18.localEulerAngles
			end

			if arg_95_1.time_ >= 1.96599999815126 + var_98_19 and arg_95_1.time_ < 1.96599999815126 + var_98_19 + arg_98_0 then
				var_98_18.localPosition = Vector3.New(0, 100, 0)
				var_98_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_18.position).x, (manager.ui.mainCamera.transform.position - var_98_18.position).y, (manager.ui.mainCamera.transform.position - var_98_18.position).z)
				var_98_18.localEulerAngles.z = 0
				var_98_18.localEulerAngles.x = 0
				var_98_18.localEulerAngles = var_98_18.localEulerAngles
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_20 = 3.999999999999
			local var_98_21 = 0.45

			if 3.999999999999 < arg_95_1.time_ and arg_95_1.time_ <= var_98_20 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_22 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_22:setOnUpdate(LuaHelper.FloatAction(function(arg_100_0)
					arg_95_1.dialogCg_.alpha = arg_100_0
				end))
				var_98_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_23 = arg_95_1:GetWordFromCfg(420191023)
				local var_98_24 = arg_95_1:FormatText(var_98_23.content)

				arg_95_1.text_.text = var_98_24

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_26 = 18 <= 0 and var_98_21 or var_98_21 * (utf8.len(var_98_24) / 18)

				if (18 <= 0 and var_98_21 or var_98_21 * (utf8.len(var_98_24) / 18)) > 0 and var_98_21 < var_98_26 then
					arg_95_1.talkMaxDuration = var_98_26
					var_98_20 = var_98_20 + 0.3

					if var_98_26 + var_98_20 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_26 + var_98_20
					end
				end

				arg_95_1.text_.text = var_98_24
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191023", "story_v_out_420191.awb") ~= 0 then
					local var_98_27 = manager.audio:GetVoiceLength("story_v_out_420191", "420191023", "story_v_out_420191.awb") / 1000

					if var_98_27 + var_98_20 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_27 + var_98_20
					end

					if var_98_23.prefab_name ~= "" and arg_95_1.actors_[var_98_23.prefab_name] ~= nil then
						local var_98_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_23.prefab_name].transform, "story_v_out_420191", "420191023", "story_v_out_420191.awb")

						arg_95_1:RecordAudio("420191023", var_98_28)
						arg_95_1:RecordAudio("420191023", var_98_28)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_420191", "420191023", "story_v_out_420191.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_420191", "420191023", "story_v_out_420191.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_29 = var_98_20 + 0.3
			local var_98_30 = math.max(var_98_21, arg_95_1.talkMaxDuration)

			if var_98_20 + 0.3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_29 + var_98_30 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_29) / var_98_30

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_29 + var_98_30 and arg_95_1.time_ < var_98_29 + var_98_30 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815126,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play420191024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 420191024
		arg_102_1.duration_ = 7.43

		local var_102_0 = {
			zh = 6,
			ja = 7.433
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play420191025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0.375

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:GetWordFromCfg(420191024)
				local var_105_2 = arg_102_1:FormatText(var_105_1.content)

				arg_102_1.text_.text = var_105_2

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 15 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 15)

				if (15 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_2) / 15)) > 0 and var_105_0 < var_105_4 then
					arg_102_1.talkMaxDuration = var_105_4

					if var_105_4 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_4 + 0
					end
				end

				arg_102_1.text_.text = var_105_2
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191024", "story_v_out_420191.awb") ~= 0 then
					local var_105_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191024", "story_v_out_420191.awb") / 1000

					if var_105_5 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + 0
					end

					if var_105_1.prefab_name ~= "" and arg_102_1.actors_[var_105_1.prefab_name] ~= nil then
						local var_105_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_1.prefab_name].transform, "story_v_out_420191", "420191024", "story_v_out_420191.awb")

						arg_102_1:RecordAudio("420191024", var_105_6)
						arg_102_1:RecordAudio("420191024", var_105_6)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_420191", "420191024", "story_v_out_420191.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_420191", "420191024", "story_v_out_420191.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_7 and arg_102_1.time_ < 0 + var_105_7 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play420191025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 420191025
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play420191026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.875

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_1 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(420191025).content)

				arg_106_1.text_.text = var_109_1

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_3 = 35 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 35)

				if (35 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 35)) > 0 and var_109_0 < var_109_3 then
					arg_106_1.talkMaxDuration = var_109_3

					if var_109_3 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_3 + 0
					end
				end

				arg_106_1.text_.text = var_109_1
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_4 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_4

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play420191026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 420191026
		arg_110_1.duration_ = 14.9

		local var_110_0 = {
			zh = 12.533,
			ja = 14.9
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play420191027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:AudioAction("play", "effect", "se_story_140", "se_story_140_data03", "")
			end

			local var_113_1 = 0
			local var_113_2 = 1

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_3 = arg_110_1:GetWordFromCfg(420191026)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_6 = 40 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_4) / 40)

				if (40 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_4) / 40)) > 0 and var_113_2 < var_113_6 then
					arg_110_1.talkMaxDuration = var_113_6

					if var_113_6 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_6 + var_113_1
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191026", "story_v_out_420191.awb") ~= 0 then
					local var_113_7 = manager.audio:GetVoiceLength("story_v_out_420191", "420191026", "story_v_out_420191.awb") / 1000

					if var_113_7 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_1
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_420191", "420191026", "story_v_out_420191.awb")

						arg_110_1:RecordAudio("420191026", var_113_8)
						arg_110_1:RecordAudio("420191026", var_113_8)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_420191", "420191026", "story_v_out_420191.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_420191", "420191026", "story_v_out_420191.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_9 = math.max(var_113_2, arg_110_1.talkMaxDuration)

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_9 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_1) / var_113_9

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_1 + var_113_9 and arg_110_1.time_ < var_113_1 + var_113_9 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play420191027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 420191027
		arg_114_1.duration_ = 2.27

		local var_114_0 = {
			zh = 1.999999999999,
			ja = 2.266
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play420191028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if arg_114_1.actors_["1061ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1061ui_story"))) then
				local var_117_0 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_114_1.stage_.transform)

				var_117_0.name = "1061ui_story"
				var_117_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.actors_["1061ui_story"] = var_117_0

				local var_117_1 = var_117_0:GetComponentInChildren(typeof(CharacterEffect))

				var_117_1.enabled = true

				local var_117_2 = GameObjectTools.GetOrAddComponent(var_117_0, typeof(DynamicBoneHelper))

				if var_117_2 then
					var_117_2:EnableDynamicBone(false)
				end

				arg_114_1:ShowWeapon(var_117_1.transform, false)

				arg_114_1.var_["1061ui_story" .. "Animator"] = var_117_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_114_1.var_["1061ui_story" .. "Animator"].applyRootMotion = true
				arg_114_1.var_["1061ui_story" .. "LipSync"] = var_117_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_117_3 = arg_114_1.actors_["1061ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1061ui_story = var_117_3.localPosition
			end

			local var_117_4 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				var_117_3.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1061ui_story, Vector3.New(0, -1.18, -6.15), (arg_114_1.time_ - 0) / var_117_4)
				var_117_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_3.position).x, (manager.ui.mainCamera.transform.position - var_117_3.position).y, (manager.ui.mainCamera.transform.position - var_117_3.position).z)
				var_117_3.localEulerAngles.z = 0
				var_117_3.localEulerAngles.x = 0
				var_117_3.localEulerAngles = var_117_3.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				var_117_3.localPosition = Vector3.New(0, -1.18, -6.15)
				var_117_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_3.position).x, (manager.ui.mainCamera.transform.position - var_117_3.position).y, (manager.ui.mainCamera.transform.position - var_117_3.position).z)
				var_117_3.localEulerAngles.z = 0
				var_117_3.localEulerAngles.x = 0
				var_117_3.localEulerAngles = var_117_3.localEulerAngles
			end

			local var_117_5 = arg_114_1.actors_["1061ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_5) and arg_114_1.var_.characterEffect1061ui_story == nil then
				arg_114_1.var_.characterEffect1061ui_story = var_117_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_6 and not isNil(var_117_5) then
				if arg_114_1.var_.characterEffect1061ui_story and not isNil(var_117_5) then
					arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_6 and arg_114_1.time_ < 0 + var_117_6 + arg_117_0 and not isNil(var_117_5) and arg_114_1.var_.characterEffect1061ui_story then
				arg_114_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_117_8 = 0
			local var_117_9 = 0.275

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_8 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_10 = arg_114_1:GetWordFromCfg(420191027)
				local var_117_11 = arg_114_1:FormatText(var_117_10.content)

				arg_114_1.text_.text = var_117_11

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_13 = 11 <= 0 and var_117_9 or var_117_9 * (utf8.len(var_117_11) / 11)

				if (11 <= 0 and var_117_9 or var_117_9 * (utf8.len(var_117_11) / 11)) > 0 and var_117_9 < var_117_13 then
					arg_114_1.talkMaxDuration = var_117_13

					if var_117_13 + var_117_8 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_13 + var_117_8
					end
				end

				arg_114_1.text_.text = var_117_11
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191027", "story_v_out_420191.awb") ~= 0 then
					local var_117_14 = manager.audio:GetVoiceLength("story_v_out_420191", "420191027", "story_v_out_420191.awb") / 1000

					if var_117_14 + var_117_8 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_14 + var_117_8
					end

					if var_117_10.prefab_name ~= "" and arg_114_1.actors_[var_117_10.prefab_name] ~= nil then
						local var_117_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_10.prefab_name].transform, "story_v_out_420191", "420191027", "story_v_out_420191.awb")

						arg_114_1:RecordAudio("420191027", var_117_15)
						arg_114_1:RecordAudio("420191027", var_117_15)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_420191", "420191027", "story_v_out_420191.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_420191", "420191027", "story_v_out_420191.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_16 = math.max(var_117_9, arg_114_1.talkMaxDuration)

			if var_117_8 <= arg_114_1.time_ and arg_114_1.time_ < var_117_8 + var_117_16 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_8) / var_117_16

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_8 + var_117_16 and arg_114_1.time_ < var_117_8 + var_117_16 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play420191028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 420191028
		arg_118_1.duration_ = 8.9

		local var_118_0 = {
			zh = 5.233,
			ja = 8.9
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play420191029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.65

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:GetWordFromCfg(420191028)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 26 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 26)

				if (26 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 26)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191028", "story_v_out_420191.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191028", "story_v_out_420191.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_420191", "420191028", "story_v_out_420191.awb")

						arg_118_1:RecordAudio("420191028", var_121_6)
						arg_118_1:RecordAudio("420191028", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_420191", "420191028", "story_v_out_420191.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_420191", "420191028", "story_v_out_420191.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play420191029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 420191029
		arg_122_1.duration_ = 6.07

		local var_122_0 = {
			zh = 5.5,
			ja = 6.066
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play420191030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.575

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_1 = arg_122_1:GetWordFromCfg(420191029)
				local var_125_2 = arg_122_1:FormatText(var_125_1.content)

				arg_122_1.text_.text = var_125_2

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 23 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 23)

				if (23 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 23)) > 0 and var_125_0 < var_125_4 then
					arg_122_1.talkMaxDuration = var_125_4

					if var_125_4 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_4 + 0
					end
				end

				arg_122_1.text_.text = var_125_2
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191029", "story_v_out_420191.awb") ~= 0 then
					local var_125_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191029", "story_v_out_420191.awb") / 1000

					if var_125_5 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + 0
					end

					if var_125_1.prefab_name ~= "" and arg_122_1.actors_[var_125_1.prefab_name] ~= nil then
						local var_125_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_1.prefab_name].transform, "story_v_out_420191", "420191029", "story_v_out_420191.awb")

						arg_122_1:RecordAudio("420191029", var_125_6)
						arg_122_1:RecordAudio("420191029", var_125_6)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_420191", "420191029", "story_v_out_420191.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_420191", "420191029", "story_v_out_420191.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_7 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_7

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play420191030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 420191030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play420191031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1061ui_story = arg_126_1.actors_["1061ui_story"].transform.localPosition
			end

			local var_129_0 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 then
				arg_126_1.actors_["1061ui_story"].transform.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1061ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_0)
				arg_126_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).z)
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles = arg_126_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 then
				arg_126_1.actors_["1061ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.actors_["1061ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_126_1.actors_["1061ui_story"].transform.position).z)
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.z = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles.x = 0
				arg_126_1.actors_["1061ui_story"].transform.localEulerAngles = arg_126_1.actors_["1061ui_story"].transform.localEulerAngles
			end

			local var_129_1 = 0
			local var_129_2 = 1.3

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_3 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(420191030).content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 52 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 52)

				if (52 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 52)) > 0 and var_129_2 < var_129_5 then
					arg_126_1.talkMaxDuration = var_129_5

					if var_129_5 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + var_129_1
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_6 = math.max(var_129_2, arg_126_1.talkMaxDuration)

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_6 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_1) / var_129_6

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_1 + var_129_6 and arg_126_1.time_ < var_129_1 + var_129_6 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play420191031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 420191031
		arg_130_1.duration_ = 9.1

		local var_130_0 = {
			zh = 7.6,
			ja = 9.1
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play420191032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_133_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_2 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_2

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_2
						arg_130_1.bgmTxt2_.text = var_133_2
					end

					if arg_130_1.bgmTimer then
						arg_130_1.bgmTimer:Stop()

						arg_130_1.bgmTimer = nil
					end

					if arg_130_1.settingData.show_music_name == 1 then
						arg_130_1.musicController:SetSelectedState("show")
						arg_130_1.musicAnimator_:Play("open", 0, 0)

						if arg_130_1.settingData.music_time ~= 0 then
							arg_130_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_130_1.settingData.music_time), function()
								if arg_130_1 == nil or isNil(arg_130_1.bgmTxt_) then
									return
								end

								arg_130_1.musicController:SetSelectedState("hide")
								arg_130_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.333333333333333 < arg_130_1.time_ and arg_130_1.time_ <= 0.333333333333333 + arg_133_0 then
				arg_130_1:AudioAction("play", "music", "bgm_login_4_0", "bgm_login_4_0", "bgm_login_4_0.awb")

				local var_133_5 = manager.audio:GetAudioName("bgm_login_4_0", "bgm_login_4_0")

				if "" ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_5 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_5

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_5
						arg_130_1.bgmTxt2_.text = var_133_5
					end

					if arg_130_1.bgmTimer then
						arg_130_1.bgmTimer:Stop()

						arg_130_1.bgmTimer = nil
					end

					if arg_130_1.settingData.show_music_name == 1 then
						arg_130_1.musicController:SetSelectedState("show")
						arg_130_1.musicAnimator_:Play("open", 0, 0)

						if arg_130_1.settingData.music_time ~= 0 then
							arg_130_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_130_1.settingData.music_time), function()
								if arg_130_1 == nil or isNil(arg_130_1.bgmTxt_) then
									return
								end

								arg_130_1.musicController:SetSelectedState("hide")
								arg_130_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_133_6 = 0
			local var_133_7 = 0.6

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_8 = arg_130_1:GetWordFromCfg(420191031)
				local var_133_9 = arg_130_1:FormatText(var_133_8.content)

				arg_130_1.text_.text = var_133_9

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_11 = 24 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_9) / 24)

				if (24 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_9) / 24)) > 0 and var_133_7 < var_133_11 then
					arg_130_1.talkMaxDuration = var_133_11

					if var_133_11 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_11 + var_133_6
					end
				end

				arg_130_1.text_.text = var_133_9
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191031", "story_v_out_420191.awb") ~= 0 then
					local var_133_12 = manager.audio:GetVoiceLength("story_v_out_420191", "420191031", "story_v_out_420191.awb") / 1000

					if var_133_12 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_12 + var_133_6
					end

					if var_133_8.prefab_name ~= "" and arg_130_1.actors_[var_133_8.prefab_name] ~= nil then
						local var_133_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_8.prefab_name].transform, "story_v_out_420191", "420191031", "story_v_out_420191.awb")

						arg_130_1:RecordAudio("420191031", var_133_13)
						arg_130_1:RecordAudio("420191031", var_133_13)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_420191", "420191031", "story_v_out_420191.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_420191", "420191031", "story_v_out_420191.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_14 = math.max(var_133_7, arg_130_1.talkMaxDuration)

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_14 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_6) / var_133_14

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_6 + var_133_14 and arg_130_1.time_ < var_133_6 + var_133_14 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play420191032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 420191032
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play420191033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if arg_136_1.bgs_.STblack == nil then
				local var_139_0 = Object.Instantiate(arg_136_1.paintGo_)

				var_139_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_139_0.name = "STblack"
				var_139_0.transform.parent = arg_136_1.stage_.transform
				var_139_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.bgs_.STblack = var_139_0
			end

			if 2 < arg_136_1.time_ and arg_136_1.time_ <= 2 + arg_139_0 then
				local var_139_1 = arg_136_1.bgs_.STblack

				arg_136_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_139_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_139_2 = var_139_1:GetComponent("SpriteRenderer")

				if var_139_2 and var_139_2.sprite then
					local var_139_3 = 2 * (var_139_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_139_1.transform.localScale = Vector3.New(var_139_3 / var_139_2.sprite.bounds.size.y < var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x and var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x or var_139_3 / var_139_2.sprite.bounds.size.y, var_139_3 / var_139_2.sprite.bounds.size.y < var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x and var_139_3 * manager.ui.mainCameraCom_.aspect / var_139_2.sprite.bounds.size.x or var_139_3 / var_139_2.sprite.bounds.size.y, 0)
				end

				for iter_139_0, iter_139_1 in pairs(arg_136_1.bgs_) do
					if iter_139_0 ~= "STblack" then
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

			if 0.233333333333333 < arg_136_1.time_ and arg_136_1.time_ <= 0.233333333333333 + arg_139_0 then
				arg_136_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_lab", "")
			end

			if 2 < arg_136_1.time_ and arg_136_1.time_ <= 2 + arg_139_0 then
				arg_136_1.fswbg_:SetActive(true)
				arg_136_1.dialog_:SetActive(false)

				arg_136_1.fswtw_.percent = 0
				arg_136_1.fswt_.text = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(420191032).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.fswt_)

				arg_136_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_136_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_136_1.fswtw_:SetDirty()

				arg_136_1.typewritterCharCountI18N = 0

				SetActive(arg_136_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_136_1:ShowNextGo(false)
			end

			local var_139_14 = 3.53333333333333

			if 3.53333333333333 < arg_136_1.time_ and arg_136_1.time_ <= var_139_14 + arg_139_0 then
				arg_136_1.var_.oldValueTypewriter = arg_136_1.fswtw_.percent

				SetActive(arg_136_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_136_1:ShowNextGo(false)
			end

			local var_139_15 = 21
			local var_139_16 = 1.4
			local var_139_17, var_139_18 = arg_136_1:GetPercentByPara(arg_136_1:FormatText(arg_136_1:GetWordFromCfg(420191032).content), 1)

			if var_139_14 < arg_136_1.time_ and arg_136_1.time_ <= var_139_14 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0

				local var_139_19 = var_139_15 <= 0 and var_139_16 or var_139_16 * ((var_139_18 - arg_136_1.typewritterCharCountI18N) / var_139_15)

				if (var_139_15 <= 0 and var_139_16 or var_139_16 * ((var_139_18 - arg_136_1.typewritterCharCountI18N) / var_139_15)) > 0 and var_139_16 < var_139_19 then
					arg_136_1.talkMaxDuration = var_139_19

					if var_139_19 + var_139_14 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_19 + var_139_14
					end
				end
			end

			local var_139_20 = math.max(1.4, arg_136_1.talkMaxDuration)

			if var_139_14 <= arg_136_1.time_ and arg_136_1.time_ < var_139_14 + var_139_20 then
				arg_136_1.fswtw_.percent = Mathf.Lerp(arg_136_1.var_.oldValueTypewriter, var_139_17, (arg_136_1.time_ - var_139_14) / var_139_20)
				arg_136_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_136_1.fswtw_:SetDirty()
			end

			if arg_136_1.time_ >= var_139_14 + var_139_20 and arg_136_1.time_ < var_139_14 + var_139_20 + arg_139_0 then
				arg_136_1.fswtw_.percent = var_139_17

				arg_136_1.fswtw_:SetDirty()
				arg_136_1:ShowNextGo(true)

				arg_136_1.typewritterCharCountI18N = var_139_18
			end

			if 2 < arg_136_1.time_ and arg_136_1.time_ <= 2 + arg_139_0 then
				local var_139_21 = arg_136_1.fswbg_.transform:Find("textbox/adapt/content") or arg_136_1.fswbg_.transform:Find("textbox/content")
				local var_139_22 = arg_136_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_139_23 = var_139_21:GetComponent("RectTransform")

				var_139_21:GetComponent("Text").alignment = UnityEngine.TextAnchor.UpperLeft
				var_139_23.offsetMin = Vector2.New(0, 0)
				var_139_23.offsetMax = Vector2.New(0, 0)
			end

			if 4 < arg_136_1.time_ and arg_136_1.time_ <= 4 + arg_139_0 then
				arg_136_1:AudioAction("play", "effect", "se_story_140", "se_story_140_data02", "")
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play420191033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 420191033
		arg_140_1.duration_ = 1.47

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play420191034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.oldValueTypewriter = arg_140_1.fswtw_.percent

				SetActive(arg_140_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_140_1:ShowNextGo(false)
			end

			local var_143_0 = 22
			local var_143_1 = 1.46666666666667
			local var_143_2, var_143_3 = arg_140_1:GetPercentByPara(arg_140_1:FormatText(arg_140_1:GetWordFromCfg(420191032).content), 2)

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0

				local var_143_4 = var_143_0 <= 0 and var_143_1 or var_143_1 * ((var_143_3 - arg_140_1.typewritterCharCountI18N) / var_143_0)

				if (var_143_0 <= 0 and var_143_1 or var_143_1 * ((var_143_3 - arg_140_1.typewritterCharCountI18N) / var_143_0)) > 0 and var_143_1 < var_143_4 then
					arg_140_1.talkMaxDuration = var_143_4

					if var_143_4 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_4 + 0
					end
				end
			end

			local var_143_5 = math.max(1.46666666666667, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_5 then
				arg_140_1.fswtw_.percent = Mathf.Lerp(arg_140_1.var_.oldValueTypewriter, var_143_2, (arg_140_1.time_ - 0) / var_143_5)
				arg_140_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_140_1.fswtw_:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_5 and arg_140_1.time_ < 0 + var_143_5 + arg_143_0 then
				arg_140_1.fswtw_.percent = var_143_2

				arg_140_1.fswtw_:SetDirty()
				arg_140_1:ShowNextGo(true)

				arg_140_1.typewritterCharCountI18N = var_143_3
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play420191034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 420191034
		arg_144_1.duration_ = 3.3

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play420191035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.oldValueTypewriter = arg_144_1.fswtw_.percent

				SetActive(arg_144_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_144_1:ShowNextGo(false)
			end

			local var_147_0 = 28
			local var_147_1 = 1.86666666666667
			local var_147_2, var_147_3 = arg_144_1:GetPercentByPara(arg_144_1:FormatText(arg_144_1:GetWordFromCfg(420191032).content), 3)

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0

				local var_147_4 = var_147_0 <= 0 and var_147_1 or var_147_1 * ((var_147_3 - arg_144_1.typewritterCharCountI18N) / var_147_0)

				if (var_147_0 <= 0 and var_147_1 or var_147_1 * ((var_147_3 - arg_144_1.typewritterCharCountI18N) / var_147_0)) > 0 and var_147_1 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end
			end

			local var_147_5 = math.max(1.86666666666667, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_5 then
				arg_144_1.fswtw_.percent = Mathf.Lerp(arg_144_1.var_.oldValueTypewriter, var_147_2, (arg_144_1.time_ - 0) / var_147_5)
				arg_144_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_144_1.fswtw_:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_5 and arg_144_1.time_ < 0 + var_147_5 + arg_147_0 then
				arg_144_1.fswtw_.percent = var_147_2

				arg_144_1.fswtw_:SetDirty()
				arg_144_1:ShowNextGo(true)

				arg_144_1.typewritterCharCountI18N = var_147_3
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play420191035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 420191035
		arg_148_1.duration_ = 1.07

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play420191036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.oldValueTypewriter = arg_148_1.fswtw_.percent

				SetActive(arg_148_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_148_1:ShowNextGo(false)
			end

			local var_151_0 = 16
			local var_151_1 = 1.06666666666667
			local var_151_2, var_151_3 = arg_148_1:GetPercentByPara(arg_148_1:FormatText(arg_148_1:GetWordFromCfg(420191032).content), 4)

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0

				local var_151_4 = var_151_0 <= 0 and var_151_1 or var_151_1 * ((var_151_3 - arg_148_1.typewritterCharCountI18N) / var_151_0)

				if (var_151_0 <= 0 and var_151_1 or var_151_1 * ((var_151_3 - arg_148_1.typewritterCharCountI18N) / var_151_0)) > 0 and var_151_1 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end
			end

			local var_151_5 = math.max(1.06666666666667, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_5 then
				arg_148_1.fswtw_.percent = Mathf.Lerp(arg_148_1.var_.oldValueTypewriter, var_151_2, (arg_148_1.time_ - 0) / var_151_5)
				arg_148_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_148_1.fswtw_:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_5 and arg_148_1.time_ < 0 + var_151_5 + arg_151_0 then
				arg_148_1.fswtw_.percent = var_151_2

				arg_148_1.fswtw_:SetDirty()
				arg_148_1:ShowNextGo(true)

				arg_148_1.typewritterCharCountI18N = var_151_3
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play420191036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 420191036
		arg_152_1.duration_ = 1.73

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play420191037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.oldValueTypewriter = arg_152_1.fswtw_.percent

				SetActive(arg_152_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_152_1:ShowNextGo(false)
			end

			local var_155_0 = 26
			local var_155_1 = 1.73333333333333
			local var_155_2, var_155_3 = arg_152_1:GetPercentByPara(arg_152_1:FormatText(arg_152_1:GetWordFromCfg(420191032).content), 5)

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0

				local var_155_4 = var_155_0 <= 0 and var_155_1 or var_155_1 * ((var_155_3 - arg_152_1.typewritterCharCountI18N) / var_155_0)

				if (var_155_0 <= 0 and var_155_1 or var_155_1 * ((var_155_3 - arg_152_1.typewritterCharCountI18N) / var_155_0)) > 0 and var_155_1 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end
			end

			local var_155_5 = math.max(1.73333333333333, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_5 then
				arg_152_1.fswtw_.percent = Mathf.Lerp(arg_152_1.var_.oldValueTypewriter, var_155_2, (arg_152_1.time_ - 0) / var_155_5)
				arg_152_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_152_1.fswtw_:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_5 and arg_152_1.time_ < 0 + var_155_5 + arg_155_0 then
				arg_152_1.fswtw_.percent = var_155_2

				arg_152_1.fswtw_:SetDirty()
				arg_152_1:ShowNextGo(true)

				arg_152_1.typewritterCharCountI18N = var_155_3
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play420191037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 420191037
		arg_156_1.duration_ = 1.33

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play420191038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.oldValueTypewriter = arg_156_1.fswtw_.percent

				SetActive(arg_156_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_156_1:ShowNextGo(false)
			end

			local var_159_0 = 20
			local var_159_1 = 1.33333333333333
			local var_159_2, var_159_3 = arg_156_1:GetPercentByPara(arg_156_1:FormatText(arg_156_1:GetWordFromCfg(420191032).content), 6)

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				local var_159_4 = var_159_0 <= 0 and var_159_1 or var_159_1 * ((var_159_3 - arg_156_1.typewritterCharCountI18N) / var_159_0)

				if (var_159_0 <= 0 and var_159_1 or var_159_1 * ((var_159_3 - arg_156_1.typewritterCharCountI18N) / var_159_0)) > 0 and var_159_1 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end
			end

			local var_159_5 = math.max(1.33333333333333, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_5 then
				arg_156_1.fswtw_.percent = Mathf.Lerp(arg_156_1.var_.oldValueTypewriter, var_159_2, (arg_156_1.time_ - 0) / var_159_5)
				arg_156_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_156_1.fswtw_:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_5 and arg_156_1.time_ < 0 + var_159_5 + arg_159_0 then
				arg_156_1.fswtw_.percent = var_159_2

				arg_156_1.fswtw_:SetDirty()
				arg_156_1:ShowNextGo(true)

				arg_156_1.typewritterCharCountI18N = var_159_3
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play420191038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 420191038
		arg_160_1.duration_ = 1.53

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play420191039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.oldValueTypewriter = arg_160_1.fswtw_.percent

				SetActive(arg_160_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_160_1:ShowNextGo(false)
			end

			local var_163_0 = 23
			local var_163_1 = 1.53333333333333
			local var_163_2, var_163_3 = arg_160_1:GetPercentByPara(arg_160_1:FormatText(arg_160_1:GetWordFromCfg(420191032).content), 7)

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				local var_163_4 = var_163_0 <= 0 and var_163_1 or var_163_1 * ((var_163_3 - arg_160_1.typewritterCharCountI18N) / var_163_0)

				if (var_163_0 <= 0 and var_163_1 or var_163_1 * ((var_163_3 - arg_160_1.typewritterCharCountI18N) / var_163_0)) > 0 and var_163_1 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end
			end

			local var_163_5 = math.max(1.53333333333333, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_5 then
				arg_160_1.fswtw_.percent = Mathf.Lerp(arg_160_1.var_.oldValueTypewriter, var_163_2, (arg_160_1.time_ - 0) / var_163_5)
				arg_160_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_160_1.fswtw_:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_5 and arg_160_1.time_ < 0 + var_163_5 + arg_163_0 then
				arg_160_1.fswtw_.percent = var_163_2

				arg_160_1.fswtw_:SetDirty()
				arg_160_1:ShowNextGo(true)

				arg_160_1.typewritterCharCountI18N = var_163_3
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play420191039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 420191039
		arg_164_1.duration_ = 1.2

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play420191040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.oldValueTypewriter = arg_164_1.fswtw_.percent

				SetActive(arg_164_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_164_1:ShowNextGo(false)
			end

			local var_167_0 = 18
			local var_167_1 = 1.2
			local var_167_2, var_167_3 = arg_164_1:GetPercentByPara(arg_164_1:FormatText(arg_164_1:GetWordFromCfg(420191032).content), 8)

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				local var_167_4 = var_167_0 <= 0 and var_167_1 or var_167_1 * ((var_167_3 - arg_164_1.typewritterCharCountI18N) / var_167_0)

				if (var_167_0 <= 0 and var_167_1 or var_167_1 * ((var_167_3 - arg_164_1.typewritterCharCountI18N) / var_167_0)) > 0 and var_167_1 < var_167_4 then
					arg_164_1.talkMaxDuration = var_167_4

					if var_167_4 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_4 + 0
					end
				end
			end

			local var_167_5 = math.max(1.2, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_5 then
				arg_164_1.fswtw_.percent = Mathf.Lerp(arg_164_1.var_.oldValueTypewriter, var_167_2, (arg_164_1.time_ - 0) / var_167_5)
				arg_164_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_164_1.fswtw_:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_5 and arg_164_1.time_ < 0 + var_167_5 + arg_167_0 then
				arg_164_1.fswtw_.percent = var_167_2

				arg_164_1.fswtw_:SetDirty()
				arg_164_1:ShowNextGo(true)

				arg_164_1.typewritterCharCountI18N = var_167_3
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play420191040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 420191040
		arg_168_1.duration_ = 2.33

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play420191041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.oldValueTypewriter = arg_168_1.fswtw_.percent

				SetActive(arg_168_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_168_1:ShowNextGo(false)
			end

			local var_171_0 = 0
			local var_171_1 = -6.9
			local var_171_2, var_171_3 = arg_168_1:GetPercentByPara(arg_168_1:FormatText(arg_168_1:GetWordFromCfg(420191032).content), 5)

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0

				local var_171_4 = var_171_0 <= 0 and var_171_1 or var_171_1 * ((var_171_3 - arg_168_1.typewritterCharCountI18N) / var_171_0)

				if (var_171_0 <= 0 and var_171_1 or var_171_1 * ((var_171_3 - arg_168_1.typewritterCharCountI18N) / var_171_0)) > 0 and var_171_1 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end
			end

			local var_171_5 = math.max(-6.9, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_5 then
				arg_168_1.fswtw_.percent = Mathf.Lerp(arg_168_1.var_.oldValueTypewriter, var_171_2, (arg_168_1.time_ - 0) / var_171_5)
				arg_168_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_168_1.fswtw_:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_5 and arg_168_1.time_ < 0 + var_171_5 + arg_171_0 then
				arg_168_1.fswtw_.percent = var_171_2

				arg_168_1.fswtw_:SetDirty()
				arg_168_1:ShowNextGo(true)

				arg_168_1.typewritterCharCountI18N = var_171_3
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.fswbg_:SetActive(true)
				arg_168_1.dialog_:SetActive(false)

				arg_168_1.fswtw_.percent = 0
				arg_168_1.fswt_.text = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(420191039).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.fswt_)

				arg_168_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_168_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_168_1.fswtw_:SetDirty()

				arg_168_1.typewritterCharCountI18N = 0

				SetActive(arg_168_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_168_1:ShowNextGo(false)
			end

			local var_171_6 = 0.0666666666666667

			if 0.0666666666666667 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.var_.oldValueTypewriter = arg_168_1.fswtw_.percent

				SetActive(arg_168_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_168_1:ShowNextGo(false)
			end

			local var_171_7 = 34
			local var_171_8 = 2.26666666666667
			local var_171_9, var_171_10 = arg_168_1:GetPercentByPara(arg_168_1:FormatText(arg_168_1:GetWordFromCfg(420191039).content), 1)

			if var_171_6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0

				local var_171_11 = var_171_7 <= 0 and var_171_8 or var_171_8 * ((var_171_10 - arg_168_1.typewritterCharCountI18N) / var_171_7)

				if (var_171_7 <= 0 and var_171_8 or var_171_8 * ((var_171_10 - arg_168_1.typewritterCharCountI18N) / var_171_7)) > 0 and var_171_8 < var_171_11 then
					arg_168_1.talkMaxDuration = var_171_11

					if var_171_11 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_6
					end
				end
			end

			local var_171_12 = math.max(2.26666666666667, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_12 then
				arg_168_1.fswtw_.percent = Mathf.Lerp(arg_168_1.var_.oldValueTypewriter, var_171_9, (arg_168_1.time_ - var_171_6) / var_171_12)
				arg_168_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_168_1.fswtw_:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_12 and arg_168_1.time_ < var_171_6 + var_171_12 + arg_171_0 then
				arg_168_1.fswtw_.percent = var_171_9

				arg_168_1.fswtw_:SetDirty()
				arg_168_1:ShowNextGo(true)

				arg_168_1.typewritterCharCountI18N = var_171_10
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play420191041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 420191041
		arg_172_1.duration_ = 1.4

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play420191042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.oldValueTypewriter = arg_172_1.fswtw_.percent

				SetActive(arg_172_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_172_1:ShowNextGo(false)
			end

			local var_175_0 = 0
			local var_175_1 = -6.9
			local var_175_2, var_175_3 = arg_172_1:GetPercentByPara(arg_172_1:FormatText(arg_172_1:GetWordFromCfg(420191039).content), 4)

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				local var_175_4 = var_175_0 <= 0 and var_175_1 or var_175_1 * ((var_175_3 - arg_172_1.typewritterCharCountI18N) / var_175_0)

				if (var_175_0 <= 0 and var_175_1 or var_175_1 * ((var_175_3 - arg_172_1.typewritterCharCountI18N) / var_175_0)) > 0 and var_175_1 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end
			end

			local var_175_5 = math.max(-6.9, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_5 then
				arg_172_1.fswtw_.percent = Mathf.Lerp(arg_172_1.var_.oldValueTypewriter, var_175_2, (arg_172_1.time_ - 0) / var_175_5)
				arg_172_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_172_1.fswtw_:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_5 and arg_172_1.time_ < 0 + var_175_5 + arg_175_0 then
				arg_172_1.fswtw_.percent = var_175_2

				arg_172_1.fswtw_:SetDirty()
				arg_172_1:ShowNextGo(true)

				arg_172_1.typewritterCharCountI18N = var_175_3
			end

			local var_175_6 = 0

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.var_.oldValueTypewriter = arg_172_1.fswtw_.percent

				SetActive(arg_172_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_172_1:ShowNextGo(false)
			end

			local var_175_7 = 21
			local var_175_8 = 1.4
			local var_175_9, var_175_10 = arg_172_1:GetPercentByPara(arg_172_1:FormatText(arg_172_1:GetWordFromCfg(420191039).content), 2)

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0

				local var_175_11 = var_175_7 <= 0 and var_175_8 or var_175_8 * ((var_175_10 - arg_172_1.typewritterCharCountI18N) / var_175_7)

				if (var_175_7 <= 0 and var_175_8 or var_175_8 * ((var_175_10 - arg_172_1.typewritterCharCountI18N) / var_175_7)) > 0 and var_175_8 < var_175_11 then
					arg_172_1.talkMaxDuration = var_175_11

					if var_175_11 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_11 + var_175_6
					end
				end
			end

			local var_175_12 = math.max(1.4, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_12 then
				arg_172_1.fswtw_.percent = Mathf.Lerp(arg_172_1.var_.oldValueTypewriter, var_175_9, (arg_172_1.time_ - var_175_6) / var_175_12)
				arg_172_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_172_1.fswtw_:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_12 and arg_172_1.time_ < var_175_6 + var_175_12 + arg_175_0 then
				arg_172_1.fswtw_.percent = var_175_9

				arg_172_1.fswtw_:SetDirty()
				arg_172_1:ShowNextGo(true)

				arg_172_1.typewritterCharCountI18N = var_175_10
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play420191042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 420191042
		arg_176_1.duration_ = 1.6

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play420191043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.oldValueTypewriter = arg_176_1.fswtw_.percent

				SetActive(arg_176_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_176_1:ShowNextGo(false)
			end

			local var_179_0 = 0
			local var_179_1 = -6.9
			local var_179_2, var_179_3 = arg_176_1:GetPercentByPara(arg_176_1:FormatText(arg_176_1:GetWordFromCfg(420191039).content), 4)

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0

				local var_179_4 = var_179_0 <= 0 and var_179_1 or var_179_1 * ((var_179_3 - arg_176_1.typewritterCharCountI18N) / var_179_0)

				if (var_179_0 <= 0 and var_179_1 or var_179_1 * ((var_179_3 - arg_176_1.typewritterCharCountI18N) / var_179_0)) > 0 and var_179_1 < var_179_4 then
					arg_176_1.talkMaxDuration = var_179_4

					if var_179_4 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_4 + 0
					end
				end
			end

			local var_179_5 = math.max(-6.9, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_5 then
				arg_176_1.fswtw_.percent = Mathf.Lerp(arg_176_1.var_.oldValueTypewriter, var_179_2, (arg_176_1.time_ - 0) / var_179_5)
				arg_176_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_176_1.fswtw_:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_5 and arg_176_1.time_ < 0 + var_179_5 + arg_179_0 then
				arg_176_1.fswtw_.percent = var_179_2

				arg_176_1.fswtw_:SetDirty()
				arg_176_1:ShowNextGo(true)

				arg_176_1.typewritterCharCountI18N = var_179_3
			end

			local var_179_6 = 0

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.var_.oldValueTypewriter = arg_176_1.fswtw_.percent

				SetActive(arg_176_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_176_1:ShowNextGo(false)
			end

			local var_179_7 = 24
			local var_179_8 = 1.6
			local var_179_9, var_179_10 = arg_176_1:GetPercentByPara(arg_176_1:FormatText(arg_176_1:GetWordFromCfg(420191039).content), 3)

			if var_179_6 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0

				local var_179_11 = var_179_7 <= 0 and var_179_8 or var_179_8 * ((var_179_10 - arg_176_1.typewritterCharCountI18N) / var_179_7)

				if (var_179_7 <= 0 and var_179_8 or var_179_8 * ((var_179_10 - arg_176_1.typewritterCharCountI18N) / var_179_7)) > 0 and var_179_8 < var_179_11 then
					arg_176_1.talkMaxDuration = var_179_11

					if var_179_11 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_11 + var_179_6
					end
				end
			end

			local var_179_12 = math.max(1.6, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_12 then
				arg_176_1.fswtw_.percent = Mathf.Lerp(arg_176_1.var_.oldValueTypewriter, var_179_9, (arg_176_1.time_ - var_179_6) / var_179_12)
				arg_176_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_176_1.fswtw_:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_12 and arg_176_1.time_ < var_179_6 + var_179_12 + arg_179_0 then
				arg_176_1.fswtw_.percent = var_179_9

				arg_176_1.fswtw_:SetDirty()
				arg_176_1:ShowNextGo(true)

				arg_176_1.typewritterCharCountI18N = var_179_10
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play420191043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 420191043
		arg_180_1.duration_ = 1.8

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play420191044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.oldValueTypewriter = arg_180_1.fswtw_.percent

				SetActive(arg_180_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_180_1:ShowNextGo(false)
			end

			local var_183_0 = 0
			local var_183_1 = -6.9
			local var_183_2, var_183_3 = arg_180_1:GetPercentByPara(arg_180_1:FormatText(arg_180_1:GetWordFromCfg(420191039).content), 4)

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				local var_183_4 = var_183_0 <= 0 and var_183_1 or var_183_1 * ((var_183_3 - arg_180_1.typewritterCharCountI18N) / var_183_0)

				if (var_183_0 <= 0 and var_183_1 or var_183_1 * ((var_183_3 - arg_180_1.typewritterCharCountI18N) / var_183_0)) > 0 and var_183_1 < var_183_4 then
					arg_180_1.talkMaxDuration = var_183_4

					if var_183_4 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_4 + 0
					end
				end
			end

			local var_183_5 = math.max(-6.9, arg_180_1.talkMaxDuration)

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_5 then
				arg_180_1.fswtw_.percent = Mathf.Lerp(arg_180_1.var_.oldValueTypewriter, var_183_2, (arg_180_1.time_ - 0) / var_183_5)
				arg_180_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_180_1.fswtw_:SetDirty()
			end

			if arg_180_1.time_ >= 0 + var_183_5 and arg_180_1.time_ < 0 + var_183_5 + arg_183_0 then
				arg_180_1.fswtw_.percent = var_183_2

				arg_180_1.fswtw_:SetDirty()
				arg_180_1:ShowNextGo(true)

				arg_180_1.typewritterCharCountI18N = var_183_3
			end

			local var_183_6 = 0

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.var_.oldValueTypewriter = arg_180_1.fswtw_.percent

				SetActive(arg_180_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_180_1:ShowNextGo(false)
			end

			local var_183_7 = 27
			local var_183_8 = 1.8
			local var_183_9, var_183_10 = arg_180_1:GetPercentByPara(arg_180_1:FormatText(arg_180_1:GetWordFromCfg(420191039).content), 4)

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				local var_183_11 = var_183_7 <= 0 and var_183_8 or var_183_8 * ((var_183_10 - arg_180_1.typewritterCharCountI18N) / var_183_7)

				if (var_183_7 <= 0 and var_183_8 or var_183_8 * ((var_183_10 - arg_180_1.typewritterCharCountI18N) / var_183_7)) > 0 and var_183_8 < var_183_11 then
					arg_180_1.talkMaxDuration = var_183_11

					if var_183_11 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_11 + var_183_6
					end
				end
			end

			local var_183_12 = math.max(1.8, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_12 then
				arg_180_1.fswtw_.percent = Mathf.Lerp(arg_180_1.var_.oldValueTypewriter, var_183_9, (arg_180_1.time_ - var_183_6) / var_183_12)
				arg_180_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_180_1.fswtw_:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_12 and arg_180_1.time_ < var_183_6 + var_183_12 + arg_183_0 then
				arg_180_1.fswtw_.percent = var_183_9

				arg_180_1.fswtw_:SetDirty()
				arg_180_1:ShowNextGo(true)

				arg_180_1.typewritterCharCountI18N = var_183_10
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play420191044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 420191044
		arg_184_1.duration_ = 1.13

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play420191045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.oldValueTypewriter = arg_184_1.fswtw_.percent

				SetActive(arg_184_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_184_1:ShowNextGo(false)
			end

			local var_187_0 = 0
			local var_187_1 = -6.9
			local var_187_2, var_187_3 = arg_184_1:GetPercentByPara(arg_184_1:FormatText(arg_184_1:GetWordFromCfg(420191039).content), 4)

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0

				local var_187_4 = var_187_0 <= 0 and var_187_1 or var_187_1 * ((var_187_3 - arg_184_1.typewritterCharCountI18N) / var_187_0)

				if (var_187_0 <= 0 and var_187_1 or var_187_1 * ((var_187_3 - arg_184_1.typewritterCharCountI18N) / var_187_0)) > 0 and var_187_1 < var_187_4 then
					arg_184_1.talkMaxDuration = var_187_4

					if var_187_4 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_4 + 0
					end
				end
			end

			local var_187_5 = math.max(-6.9, arg_184_1.talkMaxDuration)

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_5 then
				arg_184_1.fswtw_.percent = Mathf.Lerp(arg_184_1.var_.oldValueTypewriter, var_187_2, (arg_184_1.time_ - 0) / var_187_5)
				arg_184_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_184_1.fswtw_:SetDirty()
			end

			if arg_184_1.time_ >= 0 + var_187_5 and arg_184_1.time_ < 0 + var_187_5 + arg_187_0 then
				arg_184_1.fswtw_.percent = var_187_2

				arg_184_1.fswtw_:SetDirty()
				arg_184_1:ShowNextGo(true)

				arg_184_1.typewritterCharCountI18N = var_187_3
			end

			local var_187_6 = 0

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.var_.oldValueTypewriter = arg_184_1.fswtw_.percent

				SetActive(arg_184_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_184_1:ShowNextGo(false)
			end

			local var_187_7 = 17
			local var_187_8 = 1.13333333333333
			local var_187_9, var_187_10 = arg_184_1:GetPercentByPara(arg_184_1:FormatText(arg_184_1:GetWordFromCfg(420191039).content), 5)

			if var_187_6 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0

				local var_187_11 = var_187_7 <= 0 and var_187_8 or var_187_8 * ((var_187_10 - arg_184_1.typewritterCharCountI18N) / var_187_7)

				if (var_187_7 <= 0 and var_187_8 or var_187_8 * ((var_187_10 - arg_184_1.typewritterCharCountI18N) / var_187_7)) > 0 and var_187_8 < var_187_11 then
					arg_184_1.talkMaxDuration = var_187_11

					if var_187_11 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_11 + var_187_6
					end
				end
			end

			local var_187_12 = math.max(1.13333333333333, arg_184_1.talkMaxDuration)

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_12 then
				arg_184_1.fswtw_.percent = Mathf.Lerp(arg_184_1.var_.oldValueTypewriter, var_187_9, (arg_184_1.time_ - var_187_6) / var_187_12)
				arg_184_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_184_1.fswtw_:SetDirty()
			end

			if arg_184_1.time_ >= var_187_6 + var_187_12 and arg_184_1.time_ < var_187_6 + var_187_12 + arg_187_0 then
				arg_184_1.fswtw_.percent = var_187_9

				arg_184_1.fswtw_:SetDirty()
				arg_184_1:ShowNextGo(true)

				arg_184_1.typewritterCharCountI18N = var_187_10
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play420191045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 420191045
		arg_188_1.duration_ = 1.53

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play420191046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.oldValueTypewriter = arg_188_1.fswtw_.percent

				SetActive(arg_188_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_188_1:ShowNextGo(false)
			end

			local var_191_0 = 0
			local var_191_1 = -6.9
			local var_191_2, var_191_3 = arg_188_1:GetPercentByPara(arg_188_1:FormatText(arg_188_1:GetWordFromCfg(420191039).content), 4)

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				local var_191_4 = var_191_0 <= 0 and var_191_1 or var_191_1 * ((var_191_3 - arg_188_1.typewritterCharCountI18N) / var_191_0)

				if (var_191_0 <= 0 and var_191_1 or var_191_1 * ((var_191_3 - arg_188_1.typewritterCharCountI18N) / var_191_0)) > 0 and var_191_1 < var_191_4 then
					arg_188_1.talkMaxDuration = var_191_4

					if var_191_4 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_4 + 0
					end
				end
			end

			local var_191_5 = math.max(-6.9, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_5 then
				arg_188_1.fswtw_.percent = Mathf.Lerp(arg_188_1.var_.oldValueTypewriter, var_191_2, (arg_188_1.time_ - 0) / var_191_5)
				arg_188_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_188_1.fswtw_:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_5 and arg_188_1.time_ < 0 + var_191_5 + arg_191_0 then
				arg_188_1.fswtw_.percent = var_191_2

				arg_188_1.fswtw_:SetDirty()
				arg_188_1:ShowNextGo(true)

				arg_188_1.typewritterCharCountI18N = var_191_3
			end

			local var_191_6 = 0

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.var_.oldValueTypewriter = arg_188_1.fswtw_.percent

				SetActive(arg_188_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_188_1:ShowNextGo(false)
			end

			local var_191_7 = 24
			local var_191_8 = 1.53333333333333
			local var_191_9, var_191_10 = arg_188_1:GetPercentByPara(arg_188_1:FormatText(arg_188_1:GetWordFromCfg(420191039).content), 6)

			if var_191_6 < arg_188_1.time_ and arg_188_1.time_ <= var_191_6 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0

				local var_191_11 = var_191_7 <= 0 and var_191_8 or var_191_8 * ((var_191_10 - arg_188_1.typewritterCharCountI18N) / var_191_7)

				if (var_191_7 <= 0 and var_191_8 or var_191_8 * ((var_191_10 - arg_188_1.typewritterCharCountI18N) / var_191_7)) > 0 and var_191_8 < var_191_11 then
					arg_188_1.talkMaxDuration = var_191_11

					if var_191_11 + var_191_6 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_11 + var_191_6
					end
				end
			end

			local var_191_12 = math.max(1.53333333333333, arg_188_1.talkMaxDuration)

			if var_191_6 <= arg_188_1.time_ and arg_188_1.time_ < var_191_6 + var_191_12 then
				arg_188_1.fswtw_.percent = Mathf.Lerp(arg_188_1.var_.oldValueTypewriter, var_191_9, (arg_188_1.time_ - var_191_6) / var_191_12)
				arg_188_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_188_1.fswtw_:SetDirty()
			end

			if arg_188_1.time_ >= var_191_6 + var_191_12 and arg_188_1.time_ < var_191_6 + var_191_12 + arg_191_0 then
				arg_188_1.fswtw_.percent = var_191_9

				arg_188_1.fswtw_:SetDirty()
				arg_188_1:ShowNextGo(true)

				arg_188_1.typewritterCharCountI18N = var_191_10
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play420191046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 420191046
		arg_192_1.duration_ = 1.05

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play420191047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0.05 < arg_192_1.time_ and arg_192_1.time_ <= 0.05 + arg_195_0 then
				arg_192_1:AudioAction("play", "effect", "se_story_140", "se_story_140_data04", "")
			end

			local var_195_1 = 0

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.oldValueTypewriter = arg_192_1.fswtw_.percent

				SetActive(arg_192_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_192_1:ShowNextGo(false)
			end

			local var_195_2 = 0
			local var_195_3 = -6.9
			local var_195_4, var_195_5 = arg_192_1:GetPercentByPara(arg_192_1:FormatText(arg_192_1:GetWordFromCfg(420191039).content), 4)

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				local var_195_6 = var_195_2 <= 0 and var_195_3 or var_195_3 * ((var_195_5 - arg_192_1.typewritterCharCountI18N) / var_195_2)

				if (var_195_2 <= 0 and var_195_3 or var_195_3 * ((var_195_5 - arg_192_1.typewritterCharCountI18N) / var_195_2)) > 0 and var_195_3 < var_195_6 then
					arg_192_1.talkMaxDuration = var_195_6

					if var_195_6 + var_195_1 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_6 + var_195_1
					end
				end
			end

			local var_195_7 = math.max(-6.9, arg_192_1.talkMaxDuration)

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_7 then
				arg_192_1.fswtw_.percent = Mathf.Lerp(arg_192_1.var_.oldValueTypewriter, var_195_4, (arg_192_1.time_ - var_195_1) / var_195_7)
				arg_192_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_192_1.fswtw_:SetDirty()
			end

			if arg_192_1.time_ >= var_195_1 + var_195_7 and arg_192_1.time_ < var_195_1 + var_195_7 + arg_195_0 then
				arg_192_1.fswtw_.percent = var_195_4

				arg_192_1.fswtw_:SetDirty()
				arg_192_1:ShowNextGo(true)

				arg_192_1.typewritterCharCountI18N = var_195_5
			end

			local var_195_8 = 0

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 then
				arg_192_1.var_.oldValueTypewriter = arg_192_1.fswtw_.percent

				SetActive(arg_192_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_192_1:ShowNextGo(false)
			end

			local var_195_9 = 14
			local var_195_10 = 0.933333333333333
			local var_195_11, var_195_12 = arg_192_1:GetPercentByPara(arg_192_1:FormatText(arg_192_1:GetWordFromCfg(420191039).content), 7)

			if var_195_8 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				local var_195_13 = var_195_9 <= 0 and var_195_10 or var_195_10 * ((var_195_12 - arg_192_1.typewritterCharCountI18N) / var_195_9)

				if (var_195_9 <= 0 and var_195_10 or var_195_10 * ((var_195_12 - arg_192_1.typewritterCharCountI18N) / var_195_9)) > 0 and var_195_10 < var_195_13 then
					arg_192_1.talkMaxDuration = var_195_13

					if var_195_13 + var_195_8 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_13 + var_195_8
					end
				end
			end

			local var_195_14 = math.max(0.933333333333333, arg_192_1.talkMaxDuration)

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_14 then
				arg_192_1.fswtw_.percent = Mathf.Lerp(arg_192_1.var_.oldValueTypewriter, var_195_11, (arg_192_1.time_ - var_195_8) / var_195_14)
				arg_192_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_192_1.fswtw_:SetDirty()
			end

			if arg_192_1.time_ >= var_195_8 + var_195_14 and arg_192_1.time_ < var_195_8 + var_195_14 + arg_195_0 then
				arg_192_1.fswtw_.percent = var_195_11

				arg_192_1.fswtw_:SetDirty()
				arg_192_1:ShowNextGo(true)

				arg_192_1.typewritterCharCountI18N = var_195_12
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play420191047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 420191047
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play420191048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.fswbg_:SetActive(false)
				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_196_1:ShowNextGo(false)
			end

			local var_199_0 = 0
			local var_199_1 = 0.675

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_2 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(420191047).content)

				arg_196_1.text_.text = var_199_2

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_4 = 27 <= 0 and var_199_1 or var_199_1 * (utf8.len(var_199_2) / 27)

				if (27 <= 0 and var_199_1 or var_199_1 * (utf8.len(var_199_2) / 27)) > 0 and var_199_1 < var_199_4 then
					arg_196_1.talkMaxDuration = var_199_4

					if var_199_4 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_4 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_2
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_5 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_5 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_5

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_5 and arg_196_1.time_ < var_199_0 + var_199_5 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play420191048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 420191048
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play420191049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.45

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_1 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(420191048).content)

				arg_200_1.text_.text = var_203_1

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_3 = 18 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 18)

				if (18 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 18)) > 0 and var_203_0 < var_203_3 then
					arg_200_1.talkMaxDuration = var_203_3

					if var_203_3 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_3 + 0
					end
				end

				arg_200_1.text_.text = var_203_1
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_4 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_4

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play420191049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 420191049
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play420191050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.8

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_1 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(420191049).content)

				arg_204_1.text_.text = var_207_1

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_3 = 32 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 32)

				if (32 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_1) / 32)) > 0 and var_207_0 < var_207_3 then
					arg_204_1.talkMaxDuration = var_207_3

					if var_207_3 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_3 + 0
					end
				end

				arg_204_1.text_.text = var_207_1
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_4 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_4

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play420191050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 420191050
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play420191051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_211_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_208_1.bgmTxt_.text ~= var_211_2 and arg_208_1.bgmTxt_.text ~= "" then
						if arg_208_1.bgmTxt2_.text ~= "" then
							arg_208_1.bgmTxt_.text = arg_208_1.bgmTxt2_.text
						end

						arg_208_1.bgmTxt2_.text = var_211_2

						arg_208_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_208_1.bgmTxt_.text = var_211_2
						arg_208_1.bgmTxt2_.text = var_211_2
					end

					if arg_208_1.bgmTimer then
						arg_208_1.bgmTimer:Stop()

						arg_208_1.bgmTimer = nil
					end

					if arg_208_1.settingData.show_music_name == 1 then
						arg_208_1.musicController:SetSelectedState("show")
						arg_208_1.musicAnimator_:Play("open", 0, 0)

						if arg_208_1.settingData.music_time ~= 0 then
							arg_208_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_208_1.settingData.music_time), function()
								if arg_208_1 == nil or isNil(arg_208_1.bgmTxt_) then
									return
								end

								arg_208_1.musicController:SetSelectedState("hide")
								arg_208_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_211_3 = 0
			local var_211_4 = 0.125

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_3 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_5 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(420191050).content)

				arg_208_1.text_.text = var_211_5

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_7 = 5 <= 0 and var_211_4 or var_211_4 * (utf8.len(var_211_5) / 5)

				if (5 <= 0 and var_211_4 or var_211_4 * (utf8.len(var_211_5) / 5)) > 0 and var_211_4 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_3 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_3
					end
				end

				arg_208_1.text_.text = var_211_5
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_8 = math.max(var_211_4, arg_208_1.talkMaxDuration)

			if var_211_3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_3 + var_211_8 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_3) / var_211_8

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_3 + var_211_8 and arg_208_1.time_ < var_211_3 + var_211_8 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play420191051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 420191051
		arg_213_1.duration_ = 8.9

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play420191052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if arg_213_1.bgs_.L16I == nil then
				local var_216_0 = Object.Instantiate(arg_213_1.paintGo_)

				var_216_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L16I")
				var_216_0.name = "L16I"
				var_216_0.transform.parent = arg_213_1.stage_.transform
				var_216_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.bgs_.L16I = var_216_0
			end

			if 2 < arg_213_1.time_ and arg_213_1.time_ <= 2 + arg_216_0 then
				local var_216_1 = arg_213_1.bgs_.L16I

				arg_213_1.bgs_.L16I.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_216_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_216_2 = var_216_1:GetComponent("SpriteRenderer")

				if var_216_2 and var_216_2.sprite then
					local var_216_3 = 2 * (var_216_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_216_1.transform.localScale = Vector3.New(var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, 0)
				end

				for iter_216_0, iter_216_1 in pairs(arg_213_1.bgs_) do
					if iter_216_0 ~= "L16I" then
						iter_216_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_216_4 = 4

			if 4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.allBtn_.enabled = false
			end

			if arg_213_1.time_ >= var_216_4 + 0.3 and arg_213_1.time_ < var_216_4 + 0.3 + arg_216_0 then
				arg_213_1.allBtn_.enabled = true
			end

			local var_216_5 = 0

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_6 = 2

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_6 then
				local var_216_7 = Color.New(0, 0, 0)

				var_216_7.a = Mathf.Lerp(0, 1, (arg_213_1.time_ - var_216_5) / var_216_6)
				arg_213_1.mask_.color = var_216_7
			end

			if arg_213_1.time_ >= var_216_5 + var_216_6 and arg_213_1.time_ < var_216_5 + var_216_6 + arg_216_0 then
				local var_216_8 = Color.New(0, 0, 0)

				var_216_8.a = 1
				arg_213_1.mask_.color = var_216_8
			end

			local var_216_9 = 2

			if 2 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_10 = 2

			if var_216_9 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_10 then
				local var_216_11 = Color.New(0, 0, 0)

				var_216_11.a = Mathf.Lerp(1, 0, (arg_213_1.time_ - var_216_9) / var_216_10)
				arg_213_1.mask_.color = var_216_11
			end

			if arg_213_1.time_ >= var_216_9 + var_216_10 and arg_213_1.time_ < var_216_9 + var_216_10 + arg_216_0 then
				local var_216_12 = Color.New(0, 0, 0)

				arg_213_1.mask_.enabled = false
				var_216_12.a = 0
				arg_213_1.mask_.color = var_216_12
			end

			local var_216_13 = "1056ui_story"

			if arg_213_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_216_14 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_213_1.stage_.transform)

				var_216_14.name = var_216_13
				var_216_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.actors_[var_216_13] = var_216_14

				local var_216_15 = var_216_14:GetComponentInChildren(typeof(CharacterEffect))

				var_216_15.enabled = true

				local var_216_16 = GameObjectTools.GetOrAddComponent(var_216_14, typeof(DynamicBoneHelper))

				if var_216_16 then
					var_216_16:EnableDynamicBone(false)
				end

				arg_213_1:ShowWeapon(var_216_15.transform, false)

				arg_213_1.var_[var_216_13 .. "Animator"] = var_216_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_213_1.var_[var_216_13 .. "Animator"].applyRootMotion = true
				arg_213_1.var_[var_216_13 .. "LipSync"] = var_216_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_216_17 = arg_213_1.actors_["1056ui_story"].transform

			if 3.9 < arg_213_1.time_ and arg_213_1.time_ <= 3.9 + arg_216_0 then
				arg_213_1.var_.moveOldPos1056ui_story = var_216_17.localPosition
			end

			local var_216_18 = 0.001

			if 3.9 <= arg_213_1.time_ and arg_213_1.time_ < 3.9 + var_216_18 then
				var_216_17.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_213_1.time_ - 3.9) / var_216_18)
				var_216_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_17.position).x, (manager.ui.mainCamera.transform.position - var_216_17.position).y, (manager.ui.mainCamera.transform.position - var_216_17.position).z)
				var_216_17.localEulerAngles.z = 0
				var_216_17.localEulerAngles.x = 0
				var_216_17.localEulerAngles = var_216_17.localEulerAngles
			end

			if arg_213_1.time_ >= 3.9 + var_216_18 and arg_213_1.time_ < 3.9 + var_216_18 + arg_216_0 then
				var_216_17.localPosition = Vector3.New(0, -1, -5.75)
				var_216_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_17.position).x, (manager.ui.mainCamera.transform.position - var_216_17.position).y, (manager.ui.mainCamera.transform.position - var_216_17.position).z)
				var_216_17.localEulerAngles.z = 0
				var_216_17.localEulerAngles.x = 0
				var_216_17.localEulerAngles = var_216_17.localEulerAngles
			end

			local var_216_19 = arg_213_1.actors_["1056ui_story"]

			if 3.9 < arg_213_1.time_ and arg_213_1.time_ <= 3.9 + arg_216_0 and not isNil(var_216_19) and arg_213_1.var_.characterEffect1056ui_story == nil then
				arg_213_1.var_.characterEffect1056ui_story = var_216_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_20 = 0.200000002980232

			if 3.9 <= arg_213_1.time_ and arg_213_1.time_ < 3.9 + var_216_20 and not isNil(var_216_19) then
				if arg_213_1.var_.characterEffect1056ui_story and not isNil(var_216_19) then
					arg_213_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 3.9 + var_216_20 and arg_213_1.time_ < 3.9 + var_216_20 + arg_216_0 and not isNil(var_216_19) and arg_213_1.var_.characterEffect1056ui_story then
				arg_213_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 3.9 < arg_213_1.time_ and arg_213_1.time_ <= 3.9 + arg_216_0 then
				arg_213_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 3.9 < arg_213_1.time_ and arg_213_1.time_ <= 3.9 + arg_216_0 then
				arg_213_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 3.9 < arg_213_1.time_ and arg_213_1.time_ <= 3.9 + arg_216_0 then
				if arg_213_1.var_.characterEffect1056ui_story == nil then
					arg_213_1.var_.characterEffect1056ui_story = arg_213_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_216_22 = arg_213_1.var_.characterEffect1056ui_story

				arg_213_1.var_.characterEffect1056ui_story.imageEffect:turnOff()

				var_216_22.interferenceEffect.enabled = true
				var_216_22.interferenceEffect.noise = 0.001
				var_216_22.interferenceEffect.simTimeScale = 1
				var_216_22.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 3.9 < arg_213_1.time_ and arg_213_1.time_ <= 3.9 + arg_216_0 then
				if arg_213_1.var_.characterEffect1056ui_story == nil then
					arg_213_1.var_.characterEffect1056ui_story = arg_213_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_213_1.var_.characterEffect1056ui_story.imageEffect:turnOn(false)
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_216_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_213_1.bgmTxt_.text ~= var_216_26 and arg_213_1.bgmTxt_.text ~= "" then
						if arg_213_1.bgmTxt2_.text ~= "" then
							arg_213_1.bgmTxt_.text = arg_213_1.bgmTxt2_.text
						end

						arg_213_1.bgmTxt2_.text = var_216_26

						arg_213_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_213_1.bgmTxt_.text = var_216_26
						arg_213_1.bgmTxt2_.text = var_216_26
					end

					if arg_213_1.bgmTimer then
						arg_213_1.bgmTimer:Stop()

						arg_213_1.bgmTimer = nil
					end

					if arg_213_1.settingData.show_music_name == 1 then
						arg_213_1.musicController:SetSelectedState("show")
						arg_213_1.musicAnimator_:Play("open", 0, 0)

						if arg_213_1.settingData.music_time ~= 0 then
							arg_213_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_213_1.settingData.music_time), function()
								if arg_213_1 == nil or isNil(arg_213_1.bgmTxt_) then
									return
								end

								arg_213_1.musicController:SetSelectedState("hide")
								arg_213_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.5 < arg_213_1.time_ and arg_213_1.time_ <= 1.5 + arg_216_0 then
				arg_213_1:AudioAction("play", "music", "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night.awb")

				local var_216_29 = manager.audio:GetAudioName("bgm_activity_4_0_story_park_night", "bgm_activity_4_0_story_park_night")

				if "" ~= "" then
					if arg_213_1.bgmTxt_.text ~= var_216_29 and arg_213_1.bgmTxt_.text ~= "" then
						if arg_213_1.bgmTxt2_.text ~= "" then
							arg_213_1.bgmTxt_.text = arg_213_1.bgmTxt2_.text
						end

						arg_213_1.bgmTxt2_.text = var_216_29

						arg_213_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_213_1.bgmTxt_.text = var_216_29
						arg_213_1.bgmTxt2_.text = var_216_29
					end

					if arg_213_1.bgmTimer then
						arg_213_1.bgmTimer:Stop()

						arg_213_1.bgmTimer = nil
					end

					if arg_213_1.settingData.show_music_name == 1 then
						arg_213_1.musicController:SetSelectedState("show")
						arg_213_1.musicAnimator_:Play("open", 0, 0)

						if arg_213_1.settingData.music_time ~= 0 then
							arg_213_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_213_1.settingData.music_time), function()
								if arg_213_1 == nil or isNil(arg_213_1.bgmTxt_) then
									return
								end

								arg_213_1.musicController:SetSelectedState("hide")
								arg_213_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.5 < arg_213_1.time_ and arg_213_1.time_ <= 1.5 + arg_216_0 then
				arg_213_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 1.83333333333333 < arg_213_1.time_ and arg_213_1.time_ <= 1.83333333333333 + arg_216_0 then
				arg_213_1.fswbg_:SetActive(false)
				arg_213_1.dialog_:SetActive(false)
				SetActive(arg_213_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_213_1:ShowNextGo(false)
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_31 = 4
			local var_216_32 = 0.4

			if 4 < arg_213_1.time_ and arg_213_1.time_ <= var_216_31 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_33 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_33:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_213_1.dialogCg_.alpha = arg_219_0
				end))
				var_216_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_34 = arg_213_1:GetWordFromCfg(420191051)
				local var_216_35 = arg_213_1:FormatText(var_216_34.content)

				arg_213_1.text_.text = var_216_35

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_37 = 16 <= 0 and var_216_32 or var_216_32 * (utf8.len(var_216_35) / 16)

				if (16 <= 0 and var_216_32 or var_216_32 * (utf8.len(var_216_35) / 16)) > 0 and var_216_32 < var_216_37 then
					arg_213_1.talkMaxDuration = var_216_37
					var_216_31 = var_216_31 + 0.3

					if var_216_37 + var_216_31 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_37 + var_216_31
					end
				end

				arg_213_1.text_.text = var_216_35
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191051", "story_v_out_420191.awb") ~= 0 then
					local var_216_38 = manager.audio:GetVoiceLength("story_v_out_420191", "420191051", "story_v_out_420191.awb") / 1000

					if var_216_38 + var_216_31 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_38 + var_216_31
					end

					if var_216_34.prefab_name ~= "" and arg_213_1.actors_[var_216_34.prefab_name] ~= nil then
						local var_216_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_34.prefab_name].transform, "story_v_out_420191", "420191051", "story_v_out_420191.awb")

						arg_213_1:RecordAudio("420191051", var_216_39)
						arg_213_1:RecordAudio("420191051", var_216_39)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_420191", "420191051", "story_v_out_420191.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_420191", "420191051", "story_v_out_420191.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_40 = var_216_31 + 0.3
			local var_216_41 = math.max(var_216_32, arg_213_1.talkMaxDuration)

			if var_216_31 + 0.3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_40 + var_216_41 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_40) / var_216_41

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_40 + var_216_41 and arg_213_1.time_ < var_216_40 + var_216_41 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play420191052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 420191052
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play420191053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1056ui_story = arg_221_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1056ui_story"].transform.position).z)
				arg_221_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1056ui_story"].transform.localEulerAngles = arg_221_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1056ui_story"].transform.position).z)
				arg_221_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1056ui_story"].transform.localEulerAngles = arg_221_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				if arg_221_1.var_.characterEffect1056ui_story == nil then
					arg_221_1.var_.characterEffect1056ui_story = arg_221_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_224_1 = arg_221_1.var_.characterEffect1056ui_story

				arg_221_1.var_.characterEffect1056ui_story.imageEffect:turnOff()

				var_224_1.interferenceEffect.enabled = false
				var_224_1.interferenceEffect.noise = 0.001
				var_224_1.interferenceEffect.simTimeScale = 1
				var_224_1.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				if arg_221_1.var_.characterEffect1056ui_story == nil then
					arg_221_1.var_.characterEffect1056ui_story = arg_221_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_221_1.var_.characterEffect1056ui_story.imageEffect:turnOff()
			end

			local var_224_3 = 0
			local var_224_4 = 1.1

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_3 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_5 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(420191052).content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 44 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 44)

				if (44 <= 0 and var_224_4 or var_224_4 * (utf8.len(var_224_5) / 44)) > 0 and var_224_4 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_3 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_3
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_4, arg_221_1.talkMaxDuration)

			if var_224_3 <= arg_221_1.time_ and arg_221_1.time_ < var_224_3 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_3) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_3 + var_224_8 and arg_221_1.time_ < var_224_3 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play420191053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 420191053
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play420191054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0.35 < arg_225_1.time_ and arg_225_1.time_ <= 0.35 + arg_228_0 then
				arg_225_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_down", "")
			end

			local var_228_1 = 0
			local var_228_2 = 0.35

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(420191053).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 14 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 14)

				if (14 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 14)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play420191054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 420191054
		arg_229_1.duration_ = 12.43

		local var_229_0 = {
			zh = 9.1,
			ja = 12.433
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play420191055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 1.1

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:GetWordFromCfg(420191054)
				local var_232_2 = arg_229_1:FormatText(var_232_1.content)

				arg_229_1.text_.text = var_232_2

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_4 = 44 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 44)

				if (44 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_2) / 44)) > 0 and var_232_0 < var_232_4 then
					arg_229_1.talkMaxDuration = var_232_4

					if var_232_4 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_4 + 0
					end
				end

				arg_229_1.text_.text = var_232_2
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191054", "story_v_out_420191.awb") ~= 0 then
					local var_232_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191054", "story_v_out_420191.awb") / 1000

					if var_232_5 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + 0
					end

					if var_232_1.prefab_name ~= "" and arg_229_1.actors_[var_232_1.prefab_name] ~= nil then
						local var_232_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_1.prefab_name].transform, "story_v_out_420191", "420191054", "story_v_out_420191.awb")

						arg_229_1:RecordAudio("420191054", var_232_6)
						arg_229_1:RecordAudio("420191054", var_232_6)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_420191", "420191054", "story_v_out_420191.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_420191", "420191054", "story_v_out_420191.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_7 and arg_229_1.time_ < 0 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play420191055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 420191055
		arg_233_1.duration_ = 7.5

		local var_233_0 = {
			zh = 4.766,
			ja = 7.5
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play420191056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.525

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_1 = arg_233_1:GetWordFromCfg(420191055)
				local var_236_2 = arg_233_1:FormatText(var_236_1.content)

				arg_233_1.text_.text = var_236_2

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 21 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 21)

				if (21 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 21)) > 0 and var_236_0 < var_236_4 then
					arg_233_1.talkMaxDuration = var_236_4

					if var_236_4 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_4 + 0
					end
				end

				arg_233_1.text_.text = var_236_2
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191055", "story_v_out_420191.awb") ~= 0 then
					local var_236_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191055", "story_v_out_420191.awb") / 1000

					if var_236_5 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + 0
					end

					if var_236_1.prefab_name ~= "" and arg_233_1.actors_[var_236_1.prefab_name] ~= nil then
						local var_236_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_1.prefab_name].transform, "story_v_out_420191", "420191055", "story_v_out_420191.awb")

						arg_233_1:RecordAudio("420191055", var_236_6)
						arg_233_1:RecordAudio("420191055", var_236_6)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_420191", "420191055", "story_v_out_420191.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_420191", "420191055", "story_v_out_420191.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play420191056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 420191056
		arg_237_1.duration_ = 10.5

		local var_237_0 = {
			zh = 6.366,
			ja = 10.5
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play420191057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1056ui_story = arg_237_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1056ui_story"].transform.position).z)
				arg_237_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1056ui_story"].transform.localEulerAngles = arg_237_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, -1, -5.75)
				arg_237_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1056ui_story"].transform.position).z)
				arg_237_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1056ui_story"].transform.localEulerAngles = arg_237_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["1056ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1056ui_story == nil then
				arg_237_1.var_.characterEffect1056ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect1056ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect1056ui_story then
				arg_237_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				if arg_237_1.var_.characterEffect1056ui_story == nil then
					arg_237_1.var_.characterEffect1056ui_story = arg_237_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_240_4 = arg_237_1.var_.characterEffect1056ui_story

				arg_237_1.var_.characterEffect1056ui_story.imageEffect:turnOff()

				var_240_4.interferenceEffect.enabled = false
				var_240_4.interferenceEffect.noise = 0.001
				var_240_4.interferenceEffect.simTimeScale = 1
				var_240_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				if arg_237_1.var_.characterEffect1056ui_story == nil then
					arg_237_1.var_.characterEffect1056ui_story = arg_237_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_237_1.var_.characterEffect1056ui_story.imageEffect:turnOff()
			end

			local var_240_6 = 0
			local var_240_7 = 0.8

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_6 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_8 = arg_237_1:GetWordFromCfg(420191056)
				local var_240_9 = arg_237_1:FormatText(var_240_8.content)

				arg_237_1.text_.text = var_240_9

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_11 = 32 <= 0 and var_240_7 or var_240_7 * (utf8.len(var_240_9) / 32)

				if (32 <= 0 and var_240_7 or var_240_7 * (utf8.len(var_240_9) / 32)) > 0 and var_240_7 < var_240_11 then
					arg_237_1.talkMaxDuration = var_240_11

					if var_240_11 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_11 + var_240_6
					end
				end

				arg_237_1.text_.text = var_240_9
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191056", "story_v_out_420191.awb") ~= 0 then
					local var_240_12 = manager.audio:GetVoiceLength("story_v_out_420191", "420191056", "story_v_out_420191.awb") / 1000

					if var_240_12 + var_240_6 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_12 + var_240_6
					end

					if var_240_8.prefab_name ~= "" and arg_237_1.actors_[var_240_8.prefab_name] ~= nil then
						local var_240_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_8.prefab_name].transform, "story_v_out_420191", "420191056", "story_v_out_420191.awb")

						arg_237_1:RecordAudio("420191056", var_240_13)
						arg_237_1:RecordAudio("420191056", var_240_13)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_420191", "420191056", "story_v_out_420191.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_420191", "420191056", "story_v_out_420191.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_14 = math.max(var_240_7, arg_237_1.talkMaxDuration)

			if var_240_6 <= arg_237_1.time_ and arg_237_1.time_ < var_240_6 + var_240_14 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_6) / var_240_14

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_6 + var_240_14 and arg_237_1.time_ < var_240_6 + var_240_14 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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

		arg_237_1:InitPlayNodeList()
	end,
	Play420191057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 420191057
		arg_241_1.duration_ = 8.87

		local var_241_0 = {
			zh = 6.533,
			ja = 8.866
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play420191058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1056ui_story = arg_241_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1056ui_story"].transform.position).z)
				arg_241_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1056ui_story"].transform.localEulerAngles = arg_241_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1056ui_story"].transform.position).z)
				arg_241_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1056ui_story"].transform.localEulerAngles = arg_241_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_244_1 = "10102ui_story"

			if arg_241_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_244_2 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_241_1.stage_.transform)

				var_244_2.name = var_244_1
				var_244_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_[var_244_1] = var_244_2

				local var_244_3 = var_244_2:GetComponentInChildren(typeof(CharacterEffect))

				var_244_3.enabled = true

				local var_244_4 = GameObjectTools.GetOrAddComponent(var_244_2, typeof(DynamicBoneHelper))

				if var_244_4 then
					var_244_4:EnableDynamicBone(false)
				end

				arg_241_1:ShowWeapon(var_244_3.transform, false)

				arg_241_1.var_[var_244_1 .. "Animator"] = var_244_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_241_1.var_[var_244_1 .. "Animator"].applyRootMotion = true
				arg_241_1.var_[var_244_1 .. "LipSync"] = var_244_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_244_5 = arg_241_1.actors_["10102ui_story"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos10102ui_story = var_244_5.localPosition
			end

			local var_244_6 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_6 then
				var_244_5.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_241_1.time_ - 0) / var_244_6)
				var_244_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_5.position).x, (manager.ui.mainCamera.transform.position - var_244_5.position).y, (manager.ui.mainCamera.transform.position - var_244_5.position).z)
				var_244_5.localEulerAngles.z = 0
				var_244_5.localEulerAngles.x = 0
				var_244_5.localEulerAngles = var_244_5.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_6 and arg_241_1.time_ < 0 + var_244_6 + arg_244_0 then
				var_244_5.localPosition = Vector3.New(0, -0.985, -6.275)
				var_244_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_5.position).x, (manager.ui.mainCamera.transform.position - var_244_5.position).y, (manager.ui.mainCamera.transform.position - var_244_5.position).z)
				var_244_5.localEulerAngles.z = 0
				var_244_5.localEulerAngles.x = 0
				var_244_5.localEulerAngles = var_244_5.localEulerAngles
			end

			local var_244_7 = arg_241_1.actors_["10102ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.characterEffect10102ui_story == nil then
				arg_241_1.var_.characterEffect10102ui_story = var_244_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_8 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_8 and not isNil(var_244_7) then
				if arg_241_1.var_.characterEffect10102ui_story and not isNil(var_244_7) then
					arg_241_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_8 and arg_241_1.time_ < 0 + var_244_8 + arg_244_0 and not isNil(var_244_7) and arg_241_1.var_.characterEffect10102ui_story then
				arg_241_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_244_10 = 0
			local var_244_11 = 0.825

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_12 = arg_241_1:GetWordFromCfg(420191057)
				local var_244_13 = arg_241_1:FormatText(var_244_12.content)

				arg_241_1.text_.text = var_244_13

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_15 = 33 <= 0 and var_244_11 or var_244_11 * (utf8.len(var_244_13) / 33)

				if (33 <= 0 and var_244_11 or var_244_11 * (utf8.len(var_244_13) / 33)) > 0 and var_244_11 < var_244_15 then
					arg_241_1.talkMaxDuration = var_244_15

					if var_244_15 + var_244_10 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_15 + var_244_10
					end
				end

				arg_241_1.text_.text = var_244_13
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191057", "story_v_out_420191.awb") ~= 0 then
					local var_244_16 = manager.audio:GetVoiceLength("story_v_out_420191", "420191057", "story_v_out_420191.awb") / 1000

					if var_244_16 + var_244_10 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_16 + var_244_10
					end

					if var_244_12.prefab_name ~= "" and arg_241_1.actors_[var_244_12.prefab_name] ~= nil then
						local var_244_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_12.prefab_name].transform, "story_v_out_420191", "420191057", "story_v_out_420191.awb")

						arg_241_1:RecordAudio("420191057", var_244_17)
						arg_241_1:RecordAudio("420191057", var_244_17)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_420191", "420191057", "story_v_out_420191.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_420191", "420191057", "story_v_out_420191.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_18 = math.max(var_244_11, arg_241_1.talkMaxDuration)

			if var_244_10 <= arg_241_1.time_ and arg_241_1.time_ < var_244_10 + var_244_18 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_10) / var_244_18

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_10 + var_244_18 and arg_241_1.time_ < var_244_10 + var_244_18 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play420191058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 420191058
		arg_245_1.duration_ = 7.6

		local var_245_0 = {
			zh = 6.4,
			ja = 7.6
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
				arg_245_0:Play420191059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10102ui_story"]) and arg_245_1.var_.characterEffect10102ui_story == nil then
				arg_245_1.var_.characterEffect10102ui_story = arg_245_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10102ui_story"]) then
				if arg_245_1.var_.characterEffect10102ui_story and not isNil(arg_245_1.actors_["10102ui_story"]) then
					arg_245_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10102ui_story"]) and arg_245_1.var_.characterEffect10102ui_story then
				arg_245_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 0.625

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(420191058)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 25 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_4) / 25)

				if (25 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_4) / 25)) > 0 and var_248_2 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191058", "story_v_out_420191.awb") ~= 0 then
					local var_248_7 = manager.audio:GetVoiceLength("story_v_out_420191", "420191058", "story_v_out_420191.awb") / 1000

					if var_248_7 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_1
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_420191", "420191058", "story_v_out_420191.awb")

						arg_245_1:RecordAudio("420191058", var_248_8)
						arg_245_1:RecordAudio("420191058", var_248_8)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_420191", "420191058", "story_v_out_420191.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_420191", "420191058", "story_v_out_420191.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_9 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_9 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_9

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_9 and arg_245_1.time_ < var_248_1 + var_248_9 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play420191059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 420191059
		arg_249_1.duration_ = 7.97

		local var_249_0 = {
			zh = 6.733,
			ja = 7.966
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play420191060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0.875

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_1 = arg_249_1:GetWordFromCfg(420191059)
				local var_252_2 = arg_249_1:FormatText(var_252_1.content)

				arg_249_1.text_.text = var_252_2

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 35 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 35)

				if (35 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 35)) > 0 and var_252_0 < var_252_4 then
					arg_249_1.talkMaxDuration = var_252_4

					if var_252_4 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_4 + 0
					end
				end

				arg_249_1.text_.text = var_252_2
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191059", "story_v_out_420191.awb") ~= 0 then
					local var_252_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191059", "story_v_out_420191.awb") / 1000

					if var_252_5 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + 0
					end

					if var_252_1.prefab_name ~= "" and arg_249_1.actors_[var_252_1.prefab_name] ~= nil then
						local var_252_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_1.prefab_name].transform, "story_v_out_420191", "420191059", "story_v_out_420191.awb")

						arg_249_1:RecordAudio("420191059", var_252_6)
						arg_249_1:RecordAudio("420191059", var_252_6)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_420191", "420191059", "story_v_out_420191.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_420191", "420191059", "story_v_out_420191.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play420191060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 420191060
		arg_253_1.duration_ = 6.8

		local var_253_0 = {
			zh = 6.233,
			ja = 6.8
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play420191061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.75

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1160].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_woundeda")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_1 = arg_253_1:GetWordFromCfg(420191060)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 30 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 30)

				if (30 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 30)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191060", "story_v_out_420191.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191060", "story_v_out_420191.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_420191", "420191060", "story_v_out_420191.awb")

						arg_253_1:RecordAudio("420191060", var_256_6)
						arg_253_1:RecordAudio("420191060", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_420191", "420191060", "story_v_out_420191.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_420191", "420191060", "story_v_out_420191.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play420191061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 420191061
		arg_257_1.duration_ = 3

		local var_257_0 = {
			zh = 2.533,
			ja = 3
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
				arg_257_0:Play420191062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["10102ui_story"]) and arg_257_1.var_.characterEffect10102ui_story == nil then
				arg_257_1.var_.characterEffect10102ui_story = arg_257_1.actors_["10102ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["10102ui_story"]) then
				if arg_257_1.var_.characterEffect10102ui_story and not isNil(arg_257_1.actors_["10102ui_story"]) then
					arg_257_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["10102ui_story"]) and arg_257_1.var_.characterEffect10102ui_story then
				arg_257_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102actionlink/10102action452")
			end

			local var_260_2 = 0
			local var_260_3 = 0.175

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_4 = arg_257_1:GetWordFromCfg(420191061)
				local var_260_5 = arg_257_1:FormatText(var_260_4.content)

				arg_257_1.text_.text = var_260_5

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 7 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 7)

				if (7 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 7)) > 0 and var_260_3 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_5
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191061", "story_v_out_420191.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191061", "story_v_out_420191.awb") / 1000

					if var_260_8 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_2
					end

					if var_260_4.prefab_name ~= "" and arg_257_1.actors_[var_260_4.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_4.prefab_name].transform, "story_v_out_420191", "420191061", "story_v_out_420191.awb")

						arg_257_1:RecordAudio("420191061", var_260_9)
						arg_257_1:RecordAudio("420191061", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_420191", "420191061", "story_v_out_420191.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_420191", "420191061", "story_v_out_420191.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_3, arg_257_1.talkMaxDuration)

			if var_260_2 <= arg_257_1.time_ and arg_257_1.time_ < var_260_2 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_2) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_2 + var_260_10 and arg_257_1.time_ < var_260_2 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play420191062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 420191062
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play420191063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10102ui_story = arg_261_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_264_0 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 then
				arg_261_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_261_1.time_ - 0) / var_264_0)
				arg_261_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10102ui_story"].transform.position).z)
				arg_261_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["10102ui_story"].transform.localEulerAngles = arg_261_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 then
				arg_261_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_261_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_261_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_261_1.actors_["10102ui_story"].transform.position).z)
				arg_261_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_261_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_261_1.actors_["10102ui_story"].transform.localEulerAngles = arg_261_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_264_1 = 0
			local var_264_2 = 0.9

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(420191062).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 36 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 36)

				if (36 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 36)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_6 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_6 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_6

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_6 and arg_261_1.time_ < var_264_1 + var_264_6 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
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
	Play420191063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 420191063
		arg_265_1.duration_ = 2

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play420191064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1085ui_story = arg_265_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1085ui_story"].transform.position).z)
				arg_265_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1085ui_story"].transform.localEulerAngles = arg_265_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_265_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1085ui_story"].transform.position).z)
				arg_265_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1085ui_story"].transform.localEulerAngles = arg_265_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1085ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1085ui_story == nil then
				arg_265_1.var_.characterEffect1085ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect1085ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1085ui_story then
				arg_265_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_268_4 = 0
			local var_268_5 = 0.05

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(420191063)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 2 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 2)

				if (2 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 2)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191063", "story_v_out_420191.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_out_420191", "420191063", "story_v_out_420191.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_out_420191", "420191063", "story_v_out_420191.awb")

						arg_265_1:RecordAudio("420191063", var_268_11)
						arg_265_1:RecordAudio("420191063", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_420191", "420191063", "story_v_out_420191.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_420191", "420191063", "story_v_out_420191.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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

		arg_265_1:InitPlayNodeList()
	end,
	Play420191064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 420191064
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play420191065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1085ui_story = arg_269_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1085ui_story"].transform.position).z)
				arg_269_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1085ui_story"].transform.localEulerAngles = arg_269_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_269_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["1085ui_story"].transform.position).z)
				arg_269_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["1085ui_story"].transform.localEulerAngles = arg_269_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_272_1 = 0
			local var_272_2 = 0.575

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(420191064).content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 23 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 23)

				if (23 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 23)) > 0 and var_272_2 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_1 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_1
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_6 = math.max(var_272_2, arg_269_1.talkMaxDuration)

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_6 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_1) / var_272_6

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_1 + var_272_6 and arg_269_1.time_ < var_272_1 + var_272_6 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
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

		arg_269_1:InitPlayNodeList()
	end,
	Play420191065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 420191065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play420191066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0.5 < arg_273_1.time_ and arg_273_1.time_ <= 0.5 + arg_276_0 then
				arg_273_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_hug", "")
			end

			local var_276_1 = 0
			local var_276_2 = 0.825

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(420191065).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 33 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 33)

				if (33 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 33)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play420191066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 420191066
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play420191067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.775

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(420191066).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 31 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 31)

				if (31 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 31)) > 0 and var_280_0 < var_280_3 then
					arg_277_1.talkMaxDuration = var_280_3

					if var_280_3 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_3 + 0
					end
				end

				arg_277_1.text_.text = var_280_1
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_4 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_4

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play420191067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 420191067
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play420191068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 1.4

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(420191067).content)

				arg_281_1.text_.text = var_284_1

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_3 = 56 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 56)

				if (56 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 56)) > 0 and var_284_0 < var_284_3 then
					arg_281_1.talkMaxDuration = var_284_3

					if var_284_3 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_3 + 0
					end
				end

				arg_281_1.text_.text = var_284_1
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_4 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_4

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play420191068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 420191068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play420191069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.275

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(420191068).content)

				arg_285_1.text_.text = var_288_1

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_3 = 11 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 11)

				if (11 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 11)) > 0 and var_288_0 < var_288_3 then
					arg_285_1.talkMaxDuration = var_288_3

					if var_288_3 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_3 + 0
					end
				end

				arg_285_1.text_.text = var_288_1
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_4 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_4

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play420191069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 420191069
		arg_289_1.duration_ = 4.03

		local var_289_0 = {
			zh = 4.033,
			ja = 3.433
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
				arg_289_0:Play420191070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1085ui_story = arg_289_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1085ui_story"].transform.position).z)
				arg_289_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1085ui_story"].transform.localEulerAngles = arg_289_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_289_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1085ui_story"].transform.position).z)
				arg_289_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1085ui_story"].transform.localEulerAngles = arg_289_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["1085ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1085ui_story == nil then
				arg_289_1.var_.characterEffect1085ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect1085ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1085ui_story then
				arg_289_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_292_4 = 0
			local var_292_5 = 0.175

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:GetWordFromCfg(420191069)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 7 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 7)

				if (7 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 7)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191069", "story_v_out_420191.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_420191", "420191069", "story_v_out_420191.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_420191", "420191069", "story_v_out_420191.awb")

						arg_289_1:RecordAudio("420191069", var_292_11)
						arg_289_1:RecordAudio("420191069", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_420191", "420191069", "story_v_out_420191.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_420191", "420191069", "story_v_out_420191.awb")
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

		arg_289_1.nodeConfigList_ = {
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

		arg_289_1:InitPlayNodeList()
	end,
	Play420191070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 420191070
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play420191071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1085ui_story = arg_293_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1085ui_story"].transform.position).z)
				arg_293_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1085ui_story"].transform.localEulerAngles = arg_293_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_293_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1085ui_story"].transform.position).z)
				arg_293_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1085ui_story"].transform.localEulerAngles = arg_293_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_296_1 = 0
			local var_296_2 = 1.55

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_1 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_3 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(420191070).content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 62 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 62)

				if (62 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 62)) > 0 and var_296_2 < var_296_5 then
					arg_293_1.talkMaxDuration = var_296_5

					if var_296_5 + var_296_1 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + var_296_1
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_6 = math.max(var_296_2, arg_293_1.talkMaxDuration)

			if var_296_1 <= arg_293_1.time_ and arg_293_1.time_ < var_296_1 + var_296_6 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_1) / var_296_6

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_1 + var_296_6 and arg_293_1.time_ < var_296_1 + var_296_6 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
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

		arg_293_1:InitPlayNodeList()
	end,
	Play420191071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 420191071
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play420191072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.375

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(420191071).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 15 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 15)

				if (15 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 15)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play420191072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 420191072
		arg_301_1.duration_ = 4.67

		local var_301_0 = {
			zh = 3.633,
			ja = 4.666
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
				arg_301_0:Play420191073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1085ui_story"]) and arg_301_1.var_.characterEffect1085ui_story == nil then
				arg_301_1.var_.characterEffect1085ui_story = arg_301_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1085ui_story"]) then
				if arg_301_1.var_.characterEffect1085ui_story and not isNil(arg_301_1.actors_["1085ui_story"]) then
					arg_301_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1085ui_story"]) and arg_301_1.var_.characterEffect1085ui_story then
				arg_301_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_304_2 = arg_301_1.actors_["1085ui_story"].transform

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1085ui_story = var_304_2.localPosition
			end

			local var_304_3 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 then
				var_304_2.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_301_1.time_ - 0) / var_304_3)
				var_304_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_2.position).x, (manager.ui.mainCamera.transform.position - var_304_2.position).y, (manager.ui.mainCamera.transform.position - var_304_2.position).z)
				var_304_2.localEulerAngles.z = 0
				var_304_2.localEulerAngles.x = 0
				var_304_2.localEulerAngles = var_304_2.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 then
				var_304_2.localPosition = Vector3.New(0, -1.01, -5.83)
				var_304_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_304_2.position).x, (manager.ui.mainCamera.transform.position - var_304_2.position).y, (manager.ui.mainCamera.transform.position - var_304_2.position).z)
				var_304_2.localEulerAngles.z = 0
				var_304_2.localEulerAngles.x = 0
				var_304_2.localEulerAngles = var_304_2.localEulerAngles
			end

			local var_304_4 = 0
			local var_304_5 = 0.25

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:GetWordFromCfg(420191072)
				local var_304_7 = arg_301_1:FormatText(var_304_6.content)

				arg_301_1.text_.text = var_304_7

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 10 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 10)

				if (10 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_7) / 10)) > 0 and var_304_5 < var_304_9 then
					arg_301_1.talkMaxDuration = var_304_9

					if var_304_9 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_9 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_7
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191072", "story_v_out_420191.awb") ~= 0 then
					local var_304_10 = manager.audio:GetVoiceLength("story_v_out_420191", "420191072", "story_v_out_420191.awb") / 1000

					if var_304_10 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_4
					end

					if var_304_6.prefab_name ~= "" and arg_301_1.actors_[var_304_6.prefab_name] ~= nil then
						local var_304_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_6.prefab_name].transform, "story_v_out_420191", "420191072", "story_v_out_420191.awb")

						arg_301_1:RecordAudio("420191072", var_304_11)
						arg_301_1:RecordAudio("420191072", var_304_11)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_420191", "420191072", "story_v_out_420191.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_420191", "420191072", "story_v_out_420191.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_12 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_12 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_12

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_12 and arg_301_1.time_ < var_304_4 + var_304_12 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play420191073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 420191073
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play420191074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1085ui_story"]) and arg_305_1.var_.characterEffect1085ui_story == nil then
				arg_305_1.var_.characterEffect1085ui_story = arg_305_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1085ui_story"]) then
				if arg_305_1.var_.characterEffect1085ui_story and not isNil(arg_305_1.actors_["1085ui_story"]) then
					arg_305_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1085ui_story"]) and arg_305_1.var_.characterEffect1085ui_story then
				arg_305_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.25

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(420191073).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 10 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 10)

				if (10 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 10)) > 0 and var_308_2 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_6 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_6 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_6

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_6 and arg_305_1.time_ < var_308_1 + var_308_6 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play420191074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 420191074
		arg_309_1.duration_ = 14.6

		local var_309_0 = {
			zh = 10.266,
			ja = 14.6
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play420191075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["1085ui_story"]) and arg_309_1.var_.characterEffect1085ui_story == nil then
				arg_309_1.var_.characterEffect1085ui_story = arg_309_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["1085ui_story"]) then
				if arg_309_1.var_.characterEffect1085ui_story and not isNil(arg_309_1.actors_["1085ui_story"]) then
					arg_309_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["1085ui_story"]) and arg_309_1.var_.characterEffect1085ui_story then
				arg_309_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_312_2 = 0
			local var_312_3 = 0.95

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_2 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_4 = arg_309_1:GetWordFromCfg(420191074)
				local var_312_5 = arg_309_1:FormatText(var_312_4.content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_7 = 38 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_5) / 38)

				if (38 <= 0 and var_312_3 or var_312_3 * (utf8.len(var_312_5) / 38)) > 0 and var_312_3 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_2
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191074", "story_v_out_420191.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191074", "story_v_out_420191.awb") / 1000

					if var_312_8 + var_312_2 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_2
					end

					if var_312_4.prefab_name ~= "" and arg_309_1.actors_[var_312_4.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_4.prefab_name].transform, "story_v_out_420191", "420191074", "story_v_out_420191.awb")

						arg_309_1:RecordAudio("420191074", var_312_9)
						arg_309_1:RecordAudio("420191074", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_420191", "420191074", "story_v_out_420191.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_420191", "420191074", "story_v_out_420191.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_3, arg_309_1.talkMaxDuration)

			if var_312_2 <= arg_309_1.time_ and arg_309_1.time_ < var_312_2 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_2) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_2 + var_312_10 and arg_309_1.time_ < var_312_2 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play420191075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 420191075
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play420191076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1085ui_story = arg_313_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1085ui_story"].transform.position).z)
				arg_313_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1085ui_story"].transform.localEulerAngles = arg_313_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_313_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["1085ui_story"].transform.position).z)
				arg_313_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["1085ui_story"].transform.localEulerAngles = arg_313_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_316_1 = 0
			local var_316_2 = 0.875

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(420191075).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 35 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 35)

				if (35 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 35)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
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

		arg_313_1:InitPlayNodeList()
	end,
	Play420191076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 420191076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play420191077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 1.025

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

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(420191076).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 41 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 41)

				if (41 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 41)) > 0 and var_320_0 < var_320_3 then
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
	Play420191077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 420191077
		arg_321_1.duration_ = 12.53

		local var_321_0 = {
			zh = 7.566,
			ja = 12.533
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
				arg_321_0:Play420191078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos1085ui_story = arg_321_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos1085ui_story, Vector3.New(0, -1.01, -5.83), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1085ui_story"].transform.position).z)
				arg_321_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1085ui_story"].transform.localEulerAngles = arg_321_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, -1.01, -5.83)
				arg_321_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["1085ui_story"].transform.position).z)
				arg_321_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["1085ui_story"].transform.localEulerAngles = arg_321_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_324_1 = arg_321_1.actors_["1085ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1085ui_story == nil then
				arg_321_1.var_.characterEffect1085ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect1085ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect1085ui_story then
				arg_321_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_324_4 = 0
			local var_324_5 = 0.575

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:GetWordFromCfg(420191077)
				local var_324_7 = arg_321_1:FormatText(var_324_6.content)

				arg_321_1.text_.text = var_324_7

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_9 = 23 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 23)

				if (23 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_7) / 23)) > 0 and var_324_5 < var_324_9 then
					arg_321_1.talkMaxDuration = var_324_9

					if var_324_9 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_9 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_7
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191077", "story_v_out_420191.awb") ~= 0 then
					local var_324_10 = manager.audio:GetVoiceLength("story_v_out_420191", "420191077", "story_v_out_420191.awb") / 1000

					if var_324_10 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_4
					end

					if var_324_6.prefab_name ~= "" and arg_321_1.actors_[var_324_6.prefab_name] ~= nil then
						local var_324_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_6.prefab_name].transform, "story_v_out_420191", "420191077", "story_v_out_420191.awb")

						arg_321_1:RecordAudio("420191077", var_324_11)
						arg_321_1:RecordAudio("420191077", var_324_11)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_420191", "420191077", "story_v_out_420191.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_420191", "420191077", "story_v_out_420191.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_12 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 <= arg_321_1.time_ and arg_321_1.time_ < var_324_4 + var_324_12 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_4) / var_324_12

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_4 + var_324_12 and arg_321_1.time_ < var_324_4 + var_324_12 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
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

		arg_321_1:InitPlayNodeList()
	end,
	Play420191078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 420191078
		arg_325_1.duration_ = 9.1

		local var_325_0 = {
			zh = 8.466,
			ja = 9.1
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play420191079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.75

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_1 = arg_325_1:GetWordFromCfg(420191078)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 30 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 30)

				if (30 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 30)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191078", "story_v_out_420191.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191078", "story_v_out_420191.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_out_420191", "420191078", "story_v_out_420191.awb")

						arg_325_1:RecordAudio("420191078", var_328_6)
						arg_325_1:RecordAudio("420191078", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_420191", "420191078", "story_v_out_420191.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_420191", "420191078", "story_v_out_420191.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play420191079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 420191079
		arg_329_1.duration_ = 6.3

		local var_329_0 = {
			zh = 5.433,
			ja = 6.3
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
				arg_329_0:Play420191080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0.45

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_1 = arg_329_1:GetWordFromCfg(420191079)
				local var_332_2 = arg_329_1:FormatText(var_332_1.content)

				arg_329_1.text_.text = var_332_2

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_4 = 18 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 18)

				if (18 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_2) / 18)) > 0 and var_332_0 < var_332_4 then
					arg_329_1.talkMaxDuration = var_332_4

					if var_332_4 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_4 + 0
					end
				end

				arg_329_1.text_.text = var_332_2
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191079", "story_v_out_420191.awb") ~= 0 then
					local var_332_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191079", "story_v_out_420191.awb") / 1000

					if var_332_5 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + 0
					end

					if var_332_1.prefab_name ~= "" and arg_329_1.actors_[var_332_1.prefab_name] ~= nil then
						local var_332_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_1.prefab_name].transform, "story_v_out_420191", "420191079", "story_v_out_420191.awb")

						arg_329_1:RecordAudio("420191079", var_332_6)
						arg_329_1:RecordAudio("420191079", var_332_6)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_420191", "420191079", "story_v_out_420191.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_420191", "420191079", "story_v_out_420191.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_7 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_7 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_7

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_7 and arg_329_1.time_ < 0 + var_332_7 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play420191080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 420191080
		arg_333_1.duration_ = 1

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"

			SetActive(arg_333_1.choicesGo_, true)

			for iter_334_0, iter_334_1 in ipairs(arg_333_1.choices_) do
				SetActive(iter_334_1.go, iter_334_0 <= 1)
			end

			arg_333_1.choices_[1].txt.text = arg_333_1:FormatText(StoryChoiceCfg[1239].name)
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play420191081(arg_333_1)
			end

			arg_333_1:RecordChoiceLog(420191080, 1239)
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1085ui_story"]) and arg_333_1.var_.characterEffect1085ui_story == nil then
				arg_333_1.var_.characterEffect1085ui_story = arg_333_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1085ui_story"]) then
				if arg_333_1.var_.characterEffect1085ui_story and not isNil(arg_333_1.actors_["1085ui_story"]) then
					arg_333_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_0)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1085ui_story"]) and arg_333_1.var_.characterEffect1085ui_story then
				arg_333_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play420191081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 420191081
		arg_337_1.duration_ = 14.63

		local var_337_0 = {
			zh = 14.633,
			ja = 10.033
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
				arg_337_0:Play420191082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1085ui_story"]) and arg_337_1.var_.characterEffect1085ui_story == nil then
				arg_337_1.var_.characterEffect1085ui_story = arg_337_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1085ui_story"]) then
				if arg_337_1.var_.characterEffect1085ui_story and not isNil(arg_337_1.actors_["1085ui_story"]) then
					arg_337_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1085ui_story"]) and arg_337_1.var_.characterEffect1085ui_story then
				arg_337_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_340_2 = 0
			local var_340_3 = 1

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_2 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_4 = arg_337_1:GetWordFromCfg(420191081)
				local var_340_5 = arg_337_1:FormatText(var_340_4.content)

				arg_337_1.text_.text = var_340_5

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_7 = 40 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 40)

				if (40 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 40)) > 0 and var_340_3 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_2
					end
				end

				arg_337_1.text_.text = var_340_5
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191081", "story_v_out_420191.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191081", "story_v_out_420191.awb") / 1000

					if var_340_8 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_2
					end

					if var_340_4.prefab_name ~= "" and arg_337_1.actors_[var_340_4.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_4.prefab_name].transform, "story_v_out_420191", "420191081", "story_v_out_420191.awb")

						arg_337_1:RecordAudio("420191081", var_340_9)
						arg_337_1:RecordAudio("420191081", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_420191", "420191081", "story_v_out_420191.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_420191", "420191081", "story_v_out_420191.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_3, arg_337_1.talkMaxDuration)

			if var_340_2 <= arg_337_1.time_ and arg_337_1.time_ < var_340_2 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_2) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_2 + var_340_10 and arg_337_1.time_ < var_340_2 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play420191082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 420191082
		arg_341_1.duration_ = 10.03

		local var_341_0 = {
			zh = 10.033,
			ja = 8.3
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
				arg_341_0:Play420191083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0.8

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_1 = arg_341_1:GetWordFromCfg(420191082)
				local var_344_2 = arg_341_1:FormatText(var_344_1.content)

				arg_341_1.text_.text = var_344_2

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 32 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 32)

				if (32 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 32)) > 0 and var_344_0 < var_344_4 then
					arg_341_1.talkMaxDuration = var_344_4

					if var_344_4 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_4 + 0
					end
				end

				arg_341_1.text_.text = var_344_2
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191082", "story_v_out_420191.awb") ~= 0 then
					local var_344_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191082", "story_v_out_420191.awb") / 1000

					if var_344_5 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + 0
					end

					if var_344_1.prefab_name ~= "" and arg_341_1.actors_[var_344_1.prefab_name] ~= nil then
						local var_344_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_1.prefab_name].transform, "story_v_out_420191", "420191082", "story_v_out_420191.awb")

						arg_341_1:RecordAudio("420191082", var_344_6)
						arg_341_1:RecordAudio("420191082", var_344_6)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_420191", "420191082", "story_v_out_420191.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_420191", "420191082", "story_v_out_420191.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_7 and arg_341_1.time_ < 0 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play420191083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 420191083
		arg_345_1.duration_ = 7.07

		local var_345_0 = {
			zh = 5.766,
			ja = 7.066
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
				arg_345_0:Play420191084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action429")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_348_0 = 0
			local var_348_1 = 0.375

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_2 = arg_345_1:GetWordFromCfg(420191083)
				local var_348_3 = arg_345_1:FormatText(var_348_2.content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_5 = 15 <= 0 and var_348_1 or var_348_1 * (utf8.len(var_348_3) / 15)

				if (15 <= 0 and var_348_1 or var_348_1 * (utf8.len(var_348_3) / 15)) > 0 and var_348_1 < var_348_5 then
					arg_345_1.talkMaxDuration = var_348_5

					if var_348_5 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_5 + var_348_0
					end
				end

				arg_345_1.text_.text = var_348_3
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191083", "story_v_out_420191.awb") ~= 0 then
					local var_348_6 = manager.audio:GetVoiceLength("story_v_out_420191", "420191083", "story_v_out_420191.awb") / 1000

					if var_348_6 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_6 + var_348_0
					end

					if var_348_2.prefab_name ~= "" and arg_345_1.actors_[var_348_2.prefab_name] ~= nil then
						local var_348_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_2.prefab_name].transform, "story_v_out_420191", "420191083", "story_v_out_420191.awb")

						arg_345_1:RecordAudio("420191083", var_348_7)
						arg_345_1:RecordAudio("420191083", var_348_7)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_420191", "420191083", "story_v_out_420191.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_420191", "420191083", "story_v_out_420191.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_8 = math.max(var_348_1, arg_345_1.talkMaxDuration)

			if var_348_0 <= arg_345_1.time_ and arg_345_1.time_ < var_348_0 + var_348_8 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_0) / var_348_8

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_0 + var_348_8 and arg_345_1.time_ < var_348_0 + var_348_8 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play420191084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 420191084
		arg_349_1.duration_ = 5.03

		local var_349_0 = {
			zh = 5.033,
			ja = 4.1
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
				arg_349_0:Play420191085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.325

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_1 = arg_349_1:GetWordFromCfg(420191084)
				local var_352_2 = arg_349_1:FormatText(var_352_1.content)

				arg_349_1.text_.text = var_352_2

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_4 = 13 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 13)

				if (13 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 13)) > 0 and var_352_0 < var_352_4 then
					arg_349_1.talkMaxDuration = var_352_4

					if var_352_4 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_4 + 0
					end
				end

				arg_349_1.text_.text = var_352_2
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191084", "story_v_out_420191.awb") ~= 0 then
					local var_352_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191084", "story_v_out_420191.awb") / 1000

					if var_352_5 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + 0
					end

					if var_352_1.prefab_name ~= "" and arg_349_1.actors_[var_352_1.prefab_name] ~= nil then
						local var_352_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_1.prefab_name].transform, "story_v_out_420191", "420191084", "story_v_out_420191.awb")

						arg_349_1:RecordAudio("420191084", var_352_6)
						arg_349_1:RecordAudio("420191084", var_352_6)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_420191", "420191084", "story_v_out_420191.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_420191", "420191084", "story_v_out_420191.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_7 and arg_349_1.time_ < 0 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play420191085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 420191085
		arg_353_1.duration_ = 1

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"

			SetActive(arg_353_1.choicesGo_, true)

			for iter_354_0, iter_354_1 in ipairs(arg_353_1.choices_) do
				SetActive(iter_354_1.go, iter_354_0 <= 1)
			end

			arg_353_1.choices_[1].txt.text = arg_353_1:FormatText(StoryChoiceCfg[1240].name)
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play420191086(arg_353_1)
			end

			arg_353_1:RecordChoiceLog(420191085, 1240)
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			return
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play420191086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 420191086
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play420191087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1085ui_story = arg_357_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1085ui_story"].transform.position).z)
				arg_357_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1085ui_story"].transform.localEulerAngles = arg_357_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_357_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1085ui_story"].transform.position).z)
				arg_357_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1085ui_story"].transform.localEulerAngles = arg_357_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:AudioAction("play", "effect", "se_story_140", "se_story_140_hug02", "")
			end

			local var_360_2 = 0
			local var_360_3 = 0.775

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_2 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_4 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(420191086).content)

				arg_357_1.text_.text = var_360_4

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_6 = 31 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_4) / 31)

				if (31 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_4) / 31)) > 0 and var_360_3 < var_360_6 then
					arg_357_1.talkMaxDuration = var_360_6

					if var_360_6 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_6 + var_360_2
					end
				end

				arg_357_1.text_.text = var_360_4
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_3, arg_357_1.talkMaxDuration)

			if var_360_2 <= arg_357_1.time_ and arg_357_1.time_ < var_360_2 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_2) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_2 + var_360_7 and arg_357_1.time_ < var_360_2 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	Play420191087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 420191087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play420191088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.5

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_1 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(420191087).content)

				arg_361_1.text_.text = var_364_1

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_3 = 20 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 20)

				if (20 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_1) / 20)) > 0 and var_364_0 < var_364_3 then
					arg_361_1.talkMaxDuration = var_364_3

					if var_364_3 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_3 + 0
					end
				end

				arg_361_1.text_.text = var_364_1
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_4 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_4 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_4

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_4 and arg_361_1.time_ < 0 + var_364_4 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play420191088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 420191088
		arg_365_1.duration_ = 1

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"

			SetActive(arg_365_1.choicesGo_, true)

			for iter_366_0, iter_366_1 in ipairs(arg_365_1.choices_) do
				SetActive(iter_366_1.go, iter_366_0 <= 1)
			end

			arg_365_1.choices_[1].txt.text = arg_365_1:FormatText(StoryChoiceCfg[1241].name)
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play420191089(arg_365_1)
			end

			arg_365_1:RecordChoiceLog(420191088, 1241)
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			return
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play420191089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 420191089
		arg_369_1.duration_ = 2

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play420191090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.cswbg_:SetActive(true)

				local var_372_0 = arg_369_1.cswt_:GetComponent("RectTransform")

				arg_369_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_372_0.offsetMin = Vector2.New(0, 0)
				var_372_0.offsetMax = Vector2.New(0, 130)
				arg_369_1.cswt_.text = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(420191089).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.cswt_)

				arg_369_1.cswt_.fontSize = 120
				arg_369_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_369_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_369_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_372_1 = 0

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.mask_.enabled = true
				arg_369_1.mask_.raycastTarget = true

				arg_369_1:SetGaussion(false)
			end

			local var_372_2 = 2

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_2 then
				local var_372_3 = Color.New(0, 0, 0)

				var_372_3.a = Mathf.Lerp(1, 0, (arg_369_1.time_ - var_372_1) / var_372_2)
				arg_369_1.mask_.color = var_372_3
			end

			if arg_369_1.time_ >= var_372_1 + var_372_2 and arg_369_1.time_ < var_372_1 + var_372_2 + arg_372_0 then
				local var_372_4 = Color.New(0, 0, 0)

				arg_369_1.mask_.enabled = false
				var_372_4.a = 0
				arg_369_1.mask_.color = var_372_4
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				local var_372_5 = arg_369_1.bgs_.STblack

				arg_369_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_372_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_372_6 = var_372_5:GetComponent("SpriteRenderer")

				if var_372_6 and var_372_6.sprite then
					local var_372_7 = 2 * (var_372_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_372_5.transform.localScale = Vector3.New(var_372_7 / var_372_6.sprite.bounds.size.y < var_372_7 * manager.ui.mainCameraCom_.aspect / var_372_6.sprite.bounds.size.x and var_372_7 * manager.ui.mainCameraCom_.aspect / var_372_6.sprite.bounds.size.x or var_372_7 / var_372_6.sprite.bounds.size.y, var_372_7 / var_372_6.sprite.bounds.size.y < var_372_7 * manager.ui.mainCameraCom_.aspect / var_372_6.sprite.bounds.size.x and var_372_7 * manager.ui.mainCameraCom_.aspect / var_372_6.sprite.bounds.size.x or var_372_7 / var_372_6.sprite.bounds.size.y, 0)
				end

				for iter_372_0, iter_372_1 in pairs(arg_369_1.bgs_) do
					if iter_372_0 ~= "STblack" then
						iter_372_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.fswbg_:SetActive(false)
				arg_369_1.dialog_:SetActive(false)
				SetActive(arg_369_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_369_1:ShowNextGo(false)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play420191090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 420191090
		arg_373_1.duration_ = 2

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play420191091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.cswbg_:SetActive(true)

				local var_376_0 = arg_373_1.cswt_:GetComponent("RectTransform")

				arg_373_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_376_0.offsetMin = Vector2.New(0, 0)
				var_376_0.offsetMax = Vector2.New(0, 130)
				arg_373_1.cswt_.text = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(420191090).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.cswt_)

				arg_373_1.cswt_.fontSize = 120
				arg_373_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_373_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_373_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play420191091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 420191091
		arg_377_1.duration_ = 2

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play420191092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.cswbg_:SetActive(true)

				local var_380_0 = arg_377_1.cswt_:GetComponent("RectTransform")

				arg_377_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_380_0.offsetMin = Vector2.New(0, 0)
				var_380_0.offsetMax = Vector2.New(0, 130)
				arg_377_1.cswt_.text = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(420191091).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.cswt_)

				arg_377_1.cswt_.fontSize = 108
				arg_377_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_377_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_377_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play420191092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 420191092
		arg_381_1.duration_ = 6

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play420191093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.cswbg_:SetActive(false)
			end

			local var_384_0 = 0

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_0 + arg_384_0 then
				arg_381_1.mask_.enabled = true
				arg_381_1.mask_.raycastTarget = true

				arg_381_1:SetGaussion(false)
			end

			local var_384_1 = 1

			if var_384_0 <= arg_381_1.time_ and arg_381_1.time_ < var_384_0 + var_384_1 then
				local var_384_2 = Color.New(0, 0, 0)

				var_384_2.a = Mathf.Lerp(1, 0, (arg_381_1.time_ - var_384_0) / var_384_1)
				arg_381_1.mask_.color = var_384_2
			end

			if arg_381_1.time_ >= var_384_0 + var_384_1 and arg_381_1.time_ < var_384_0 + var_384_1 + arg_384_0 then
				local var_384_3 = Color.New(0, 0, 0)

				arg_381_1.mask_.enabled = false
				var_384_3.a = 0
				arg_381_1.mask_.color = var_384_3
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				local var_384_4 = arg_381_1.bgs_.L16I

				arg_381_1.bgs_.L16I.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_384_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_384_5 = var_384_4:GetComponent("SpriteRenderer")

				if var_384_5 and var_384_5.sprite then
					local var_384_6 = 2 * (var_384_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_384_4.transform.localScale = Vector3.New(var_384_6 / var_384_5.sprite.bounds.size.y < var_384_6 * manager.ui.mainCameraCom_.aspect / var_384_5.sprite.bounds.size.x and var_384_6 * manager.ui.mainCameraCom_.aspect / var_384_5.sprite.bounds.size.x or var_384_6 / var_384_5.sprite.bounds.size.y, var_384_6 / var_384_5.sprite.bounds.size.y < var_384_6 * manager.ui.mainCameraCom_.aspect / var_384_5.sprite.bounds.size.x and var_384_6 * manager.ui.mainCameraCom_.aspect / var_384_5.sprite.bounds.size.x or var_384_6 / var_384_5.sprite.bounds.size.y, 0)
				end

				for iter_384_0, iter_384_1 in pairs(arg_381_1.bgs_) do
					if iter_384_0 ~= "L16I" then
						iter_384_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_381_1.frameCnt_ <= 1 then
				arg_381_1.dialog_:SetActive(false)
			end

			local var_384_7 = 1
			local var_384_8 = 0.525

			if 1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_7 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0

				arg_381_1.dialog_:SetActive(true)

				arg_381_1.dialogCg_.alpha = 0

				local var_384_9 = LeanTween.value(arg_381_1.dialog_, 0, 1, 0.3)

				var_384_9:setOnUpdate(LuaHelper.FloatAction(function(arg_385_0)
					arg_381_1.dialogCg_.alpha = arg_385_0
				end))
				var_384_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_381_1.dialog_)
					var_384_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_381_1.duration_ = arg_381_1.duration_ + 0.3

				SetActive(arg_381_1.leftNameGo_, false)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_10 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(420191092).content)

				arg_381_1.text_.text = var_384_10

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_12 = 21 <= 0 and var_384_8 or var_384_8 * (utf8.len(var_384_10) / 21)

				if (21 <= 0 and var_384_8 or var_384_8 * (utf8.len(var_384_10) / 21)) > 0 and var_384_8 < var_384_12 then
					arg_381_1.talkMaxDuration = var_384_12
					var_384_7 = var_384_7 + 0.3

					if var_384_12 + var_384_7 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_12 + var_384_7
					end
				end

				arg_381_1.text_.text = var_384_10
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_13 = var_384_7 + 0.3
			local var_384_14 = math.max(var_384_8, arg_381_1.talkMaxDuration)

			if var_384_7 + 0.3 <= arg_381_1.time_ and arg_381_1.time_ < var_384_13 + var_384_14 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_13) / var_384_14

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_13 + var_384_14 and arg_381_1.time_ < var_384_13 + var_384_14 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play420191093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 420191093
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play420191094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0.725

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_1 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(420191093).content)

				arg_387_1.text_.text = var_390_1

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_3 = 29 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 29)

				if (29 <= 0 and var_390_0 or var_390_0 * (utf8.len(var_390_1) / 29)) > 0 and var_390_0 < var_390_3 then
					arg_387_1.talkMaxDuration = var_390_3

					if var_390_3 + 0 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_3 + 0
					end
				end

				arg_387_1.text_.text = var_390_1
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_4 = math.max(var_390_0, arg_387_1.talkMaxDuration)

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_4 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - 0) / var_390_4

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= 0 + var_390_4 and arg_387_1.time_ < 0 + var_390_4 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play420191094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 420191094
		arg_391_1.duration_ = 4.1

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play420191095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 1.05 < arg_391_1.time_ and arg_391_1.time_ <= 1.05 + arg_394_0 then
				local var_394_0 = arg_391_1.bgs_.STblack

				arg_391_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_394_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_394_1 = var_394_0:GetComponent("SpriteRenderer")

				if var_394_1 and var_394_1.sprite then
					local var_394_2 = 2 * (var_394_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_394_0.transform.localScale = Vector3.New(var_394_2 / var_394_1.sprite.bounds.size.y < var_394_2 * manager.ui.mainCameraCom_.aspect / var_394_1.sprite.bounds.size.x and var_394_2 * manager.ui.mainCameraCom_.aspect / var_394_1.sprite.bounds.size.x or var_394_2 / var_394_1.sprite.bounds.size.y, var_394_2 / var_394_1.sprite.bounds.size.y < var_394_2 * manager.ui.mainCameraCom_.aspect / var_394_1.sprite.bounds.size.x and var_394_2 * manager.ui.mainCameraCom_.aspect / var_394_1.sprite.bounds.size.x or var_394_2 / var_394_1.sprite.bounds.size.y, 0)
				end

				for iter_394_0, iter_394_1 in pairs(arg_391_1.bgs_) do
					if iter_394_0 ~= "STblack" then
						iter_394_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_394_3 = 0

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_3 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_4 = 1.05

			if var_394_3 <= arg_391_1.time_ and arg_391_1.time_ < var_394_3 + var_394_4 then
				local var_394_5 = Color.New(0, 0, 0)

				var_394_5.a = Mathf.Lerp(0, 1, (arg_391_1.time_ - var_394_3) / var_394_4)
				arg_391_1.mask_.color = var_394_5
			end

			if arg_391_1.time_ >= var_394_3 + var_394_4 and arg_391_1.time_ < var_394_3 + var_394_4 + arg_394_0 then
				local var_394_6 = Color.New(0, 0, 0)

				var_394_6.a = 1
				arg_391_1.mask_.color = var_394_6
			end

			local var_394_7 = 1.05

			if 1.05 < arg_391_1.time_ and arg_391_1.time_ <= var_394_7 + arg_394_0 then
				arg_391_1.mask_.enabled = true
				arg_391_1.mask_.raycastTarget = true

				arg_391_1:SetGaussion(false)
			end

			local var_394_8 = 2

			if var_394_7 <= arg_391_1.time_ and arg_391_1.time_ < var_394_7 + var_394_8 then
				local var_394_9 = Color.New(0, 0, 0)

				var_394_9.a = Mathf.Lerp(1, 0, (arg_391_1.time_ - var_394_7) / var_394_8)
				arg_391_1.mask_.color = var_394_9
			end

			if arg_391_1.time_ >= var_394_7 + var_394_8 and arg_391_1.time_ < var_394_7 + var_394_8 + arg_394_0 then
				local var_394_10 = Color.New(0, 0, 0)

				arg_391_1.mask_.enabled = false
				var_394_10.a = 0
				arg_391_1.mask_.color = var_394_10
			end

			if 0.05 < arg_391_1.time_ and arg_391_1.time_ <= 0.05 + arg_394_0 then
				arg_391_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_nightloop", "")
			end

			if 0.05 < arg_391_1.time_ and arg_391_1.time_ <= 0.05 + arg_394_0 then
				arg_391_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_394_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_391_1.bgmTxt_.text ~= var_394_14 and arg_391_1.bgmTxt_.text ~= "" then
						if arg_391_1.bgmTxt2_.text ~= "" then
							arg_391_1.bgmTxt_.text = arg_391_1.bgmTxt2_.text
						end

						arg_391_1.bgmTxt2_.text = var_394_14

						arg_391_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_391_1.bgmTxt_.text = var_394_14
						arg_391_1.bgmTxt2_.text = var_394_14
					end

					if arg_391_1.bgmTimer then
						arg_391_1.bgmTimer:Stop()

						arg_391_1.bgmTimer = nil
					end

					if arg_391_1.settingData.show_music_name == 1 then
						arg_391_1.musicController:SetSelectedState("show")
						arg_391_1.musicAnimator_:Play("open", 0, 0)

						if arg_391_1.settingData.music_time ~= 0 then
							arg_391_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_391_1.settingData.music_time), function()
								if arg_391_1 == nil or isNil(arg_391_1.bgmTxt_) then
									return
								end

								arg_391_1.musicController:SetSelectedState("hide")
								arg_391_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.05 < arg_391_1.time_ and arg_391_1.time_ <= 1.05 + arg_394_0 then
				local var_394_15 = arg_391_1.fswbg_.transform:Find("textbox/adapt/content") or arg_391_1.fswbg_.transform:Find("textbox/content")
				local var_394_16 = arg_391_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_394_17 = var_394_15:GetComponent("RectTransform")

				var_394_15:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_394_17.offsetMin = Vector2.New(0, -70)
				var_394_17.offsetMax = Vector2.New(0, 0)
			end

			if 1.05 < arg_391_1.time_ and arg_391_1.time_ <= 1.05 + arg_394_0 then
				arg_391_1.cswbg_:SetActive(true)

				local var_394_18 = arg_391_1.cswt_:GetComponent("RectTransform")

				arg_391_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_394_18.offsetMin = Vector2.New(0, 0)
				var_394_18.offsetMax = Vector2.New(0, 130)
				arg_391_1.cswt_.text = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(419145).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.cswt_)

				arg_391_1.cswt_.fontSize = 120
				arg_391_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_391_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_391_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1.06666666666667 < arg_391_1.time_ and arg_391_1.time_ <= 1.06666666666667 + arg_394_0 then
				arg_391_1.fswbg_:SetActive(false)
				arg_391_1.dialog_:SetActive(false)
				SetActive(arg_391_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_391_1:ShowNextGo(false)
			end

			local var_394_19 = 0.933333333333333

			arg_391_1.isInRecall_ = false

			if var_394_19 < arg_391_1.time_ and arg_391_1.time_ <= var_394_19 + arg_394_0 then
				arg_391_1.screenFilterGo_:SetActive(false)

				for iter_394_2, iter_394_3 in pairs(arg_391_1.actors_) do
					for iter_394_4, iter_394_5 in ipairs((iter_394_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_394_5.color = iter_394_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_394_20 = 0.116666666666667

			if var_394_19 <= arg_391_1.time_ and arg_391_1.time_ < var_394_19 + var_394_20 then
				arg_391_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_391_1.time_ - var_394_19) / var_394_20)
			end

			if arg_391_1.time_ >= var_394_19 + var_394_20 and arg_391_1.time_ < var_394_19 + var_394_20 + arg_394_0 then
				arg_391_1.screenFilterEffect_.weight = 0
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play420191095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 420191095
		arg_396_1.duration_ = 4.63

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play420191096(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.fswbg_:SetActive(true)
				arg_396_1.dialog_:SetActive(false)

				arg_396_1.fswtw_.percent = 0
				arg_396_1.fswt_.text = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(420191095).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.fswt_)

				arg_396_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_396_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_396_1.fswtw_:SetDirty()

				arg_396_1.typewritterCharCountI18N = 0

				SetActive(arg_396_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_396_1:ShowNextGo(false)
			end

			local var_399_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.var_.oldValueTypewriter = arg_396_1.fswtw_.percent

				SetActive(arg_396_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_396_1:ShowNextGo(false)
			end

			local var_399_1 = 7
			local var_399_2 = 0.7
			local var_399_3, var_399_4 = arg_396_1:GetPercentByPara(arg_396_1:FormatText(arg_396_1:GetWordFromCfg(420191095).content), 1)

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0

				local var_399_5 = var_399_1 <= 0 and var_399_2 or var_399_2 * ((var_399_4 - arg_396_1.typewritterCharCountI18N) / var_399_1)

				if (var_399_1 <= 0 and var_399_2 or var_399_2 * ((var_399_4 - arg_396_1.typewritterCharCountI18N) / var_399_1)) > 0 and var_399_2 < var_399_5 then
					arg_396_1.talkMaxDuration = var_399_5

					if var_399_5 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_5 + var_399_0
					end
				end
			end

			local var_399_6 = math.max(0.7, arg_396_1.talkMaxDuration)

			if var_399_0 <= arg_396_1.time_ and arg_396_1.time_ < var_399_0 + var_399_6 then
				arg_396_1.fswtw_.percent = Mathf.Lerp(arg_396_1.var_.oldValueTypewriter, var_399_3, (arg_396_1.time_ - var_399_0) / var_399_6)
				arg_396_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_396_1.fswtw_:SetDirty()
			end

			if arg_396_1.time_ >= var_399_0 + var_399_6 and arg_396_1.time_ < var_399_0 + var_399_6 + arg_399_0 then
				arg_396_1.fswtw_.percent = var_399_3

				arg_396_1.fswtw_:SetDirty()
				arg_396_1:ShowNextGo(true)

				arg_396_1.typewritterCharCountI18N = var_399_4
			end

			local var_399_7 = 0
			local var_399_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191095", "story_v_out_420191.awb") / 1000

			if var_399_8 > 0 and 4.633 < var_399_8 and var_399_8 + var_399_7 > arg_396_1.duration_ then
				arg_396_1.duration_ = var_399_8 + var_399_7
			end

			if var_399_7 < arg_396_1.time_ and arg_396_1.time_ <= var_399_7 + arg_399_0 then
				arg_396_1:AudioAction("play", "voice", "story_v_out_420191", "420191095", "story_v_out_420191.awb")
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play420191096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 420191096
		arg_400_1.duration_ = 10.27

		local var_400_0 = {
			zh = 8.9,
			ja = 10.266
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play420191097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 2 < arg_400_1.time_ and arg_400_1.time_ <= 2 + arg_403_0 then
				arg_400_1.allBtn_.enabled = false
			end

			if arg_400_1.time_ >= 2 + 0.3 and arg_400_1.time_ < 2 + 0.3 + arg_403_0 then
				arg_400_1.allBtn_.enabled = true
			end

			local var_403_0 = "ST0505"

			if arg_400_1.bgs_.ST0505 == nil then
				local var_403_1 = Object.Instantiate(arg_400_1.paintGo_)

				var_403_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_403_0)
				var_403_1.name = var_403_0
				var_403_1.transform.parent = arg_400_1.stage_.transform
				var_403_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_400_1.bgs_[var_403_0] = var_403_1
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				local var_403_2 = arg_400_1.bgs_.ST0505

				arg_400_1.bgs_.ST0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_403_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_403_3 = var_403_2:GetComponent("SpriteRenderer")

				if var_403_3 and var_403_3.sprite then
					local var_403_4 = 2 * (var_403_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_403_2.transform.localScale = Vector3.New(var_403_4 / var_403_3.sprite.bounds.size.y < var_403_4 * manager.ui.mainCameraCom_.aspect / var_403_3.sprite.bounds.size.x and var_403_4 * manager.ui.mainCameraCom_.aspect / var_403_3.sprite.bounds.size.x or var_403_4 / var_403_3.sprite.bounds.size.y, var_403_4 / var_403_3.sprite.bounds.size.y < var_403_4 * manager.ui.mainCameraCom_.aspect / var_403_3.sprite.bounds.size.x and var_403_4 * manager.ui.mainCameraCom_.aspect / var_403_3.sprite.bounds.size.x or var_403_4 / var_403_3.sprite.bounds.size.y, 0)
				end

				for iter_403_0, iter_403_1 in pairs(arg_400_1.bgs_) do
					if iter_403_0 ~= "ST0505" then
						iter_403_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_403_5 = 0

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_5 + arg_403_0 then
				arg_400_1.mask_.enabled = true
				arg_400_1.mask_.raycastTarget = true

				arg_400_1:SetGaussion(false)
			end

			local var_403_6 = 2

			if var_403_5 <= arg_400_1.time_ and arg_400_1.time_ < var_403_5 + var_403_6 then
				local var_403_7 = Color.New(0, 0, 0)

				var_403_7.a = Mathf.Lerp(1, 0, (arg_400_1.time_ - var_403_5) / var_403_6)
				arg_400_1.mask_.color = var_403_7
			end

			if arg_400_1.time_ >= var_403_5 + var_403_6 and arg_400_1.time_ < var_403_5 + var_403_6 + arg_403_0 then
				local var_403_8 = Color.New(0, 0, 0)

				arg_400_1.mask_.enabled = false
				var_403_8.a = 0
				arg_400_1.mask_.color = var_403_8
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.cswbg_:SetActive(false)
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.fswbg_:SetActive(false)
				arg_400_1.dialog_:SetActive(false)
				SetActive(arg_400_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_400_1:ShowNextGo(false)
			end

			local var_403_9 = "404001ui_story"

			if arg_400_1.actors_["404001ui_story"] == nil and not isNil((Asset.Load("Char/" .. "404001ui_story"))) then
				local var_403_10 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_400_1.stage_.transform)

				var_403_10.name = var_403_9
				var_403_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_400_1.actors_[var_403_9] = var_403_10

				local var_403_11 = var_403_10:GetComponentInChildren(typeof(CharacterEffect))

				var_403_11.enabled = true

				local var_403_12 = GameObjectTools.GetOrAddComponent(var_403_10, typeof(DynamicBoneHelper))

				if var_403_12 then
					var_403_12:EnableDynamicBone(false)
				end

				arg_400_1:ShowWeapon(var_403_11.transform, false)

				arg_400_1.var_[var_403_9 .. "Animator"] = var_403_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_400_1.var_[var_403_9 .. "Animator"].applyRootMotion = true
				arg_400_1.var_[var_403_9 .. "LipSync"] = var_403_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_403_13 = arg_400_1.actors_["404001ui_story"].transform

			if 2 < arg_400_1.time_ and arg_400_1.time_ <= 2 + arg_403_0 then
				arg_400_1.var_.moveOldPos404001ui_story = var_403_13.localPosition
			end

			local var_403_14 = 0.001

			if 2 <= arg_400_1.time_ and arg_400_1.time_ < 2 + var_403_14 then
				var_403_13.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_400_1.time_ - 2) / var_403_14)
				var_403_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_403_13.position).x, (manager.ui.mainCamera.transform.position - var_403_13.position).y, (manager.ui.mainCamera.transform.position - var_403_13.position).z)
				var_403_13.localEulerAngles.z = 0
				var_403_13.localEulerAngles.x = 0
				var_403_13.localEulerAngles = var_403_13.localEulerAngles
			end

			if arg_400_1.time_ >= 2 + var_403_14 and arg_400_1.time_ < 2 + var_403_14 + arg_403_0 then
				var_403_13.localPosition = Vector3.New(0, -1.55, -5.5)
				var_403_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_403_13.position).x, (manager.ui.mainCamera.transform.position - var_403_13.position).y, (manager.ui.mainCamera.transform.position - var_403_13.position).z)
				var_403_13.localEulerAngles.z = 0
				var_403_13.localEulerAngles.x = 0
				var_403_13.localEulerAngles = var_403_13.localEulerAngles
			end

			local var_403_15 = arg_400_1.actors_["404001ui_story"]

			if 2 < arg_400_1.time_ and arg_400_1.time_ <= 2 + arg_403_0 and not isNil(var_403_15) and arg_400_1.var_.characterEffect404001ui_story == nil then
				arg_400_1.var_.characterEffect404001ui_story = var_403_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_16 = 0.200000002980232

			if 2 <= arg_400_1.time_ and arg_400_1.time_ < 2 + var_403_16 and not isNil(var_403_15) then
				if arg_400_1.var_.characterEffect404001ui_story and not isNil(var_403_15) then
					arg_400_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_400_1.time_ >= 2 + var_403_16 and arg_400_1.time_ < 2 + var_403_16 + arg_403_0 and not isNil(var_403_15) and arg_400_1.var_.characterEffect404001ui_story then
				arg_400_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 2 < arg_400_1.time_ and arg_400_1.time_ <= 2 + arg_403_0 then
				arg_400_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 2 < arg_400_1.time_ and arg_400_1.time_ <= 2 + arg_403_0 then
				arg_400_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_403_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_400_1.bgmTxt_.text ~= var_403_20 and arg_400_1.bgmTxt_.text ~= "" then
						if arg_400_1.bgmTxt2_.text ~= "" then
							arg_400_1.bgmTxt_.text = arg_400_1.bgmTxt2_.text
						end

						arg_400_1.bgmTxt2_.text = var_403_20

						arg_400_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_400_1.bgmTxt_.text = var_403_20
						arg_400_1.bgmTxt2_.text = var_403_20
					end

					if arg_400_1.bgmTimer then
						arg_400_1.bgmTimer:Stop()

						arg_400_1.bgmTimer = nil
					end

					if arg_400_1.settingData.show_music_name == 1 then
						arg_400_1.musicController:SetSelectedState("show")
						arg_400_1.musicAnimator_:Play("open", 0, 0)

						if arg_400_1.settingData.music_time ~= 0 then
							arg_400_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_400_1.settingData.music_time), function()
								if arg_400_1 == nil or isNil(arg_400_1.bgmTxt_) then
									return
								end

								arg_400_1.musicController:SetSelectedState("hide")
								arg_400_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.566666666666667 < arg_400_1.time_ and arg_400_1.time_ <= 0.566666666666667 + arg_403_0 then
				arg_400_1:AudioAction("play", "music", "bgm_activity_4_0_story_ui", "bgm_activity_4_0_story_ui", "bgm_activity_4_0_story_ui.awb")

				local var_403_23 = manager.audio:GetAudioName("bgm_activity_4_0_story_ui", "bgm_activity_4_0_story_ui")

				if "" ~= "" then
					if arg_400_1.bgmTxt_.text ~= var_403_23 and arg_400_1.bgmTxt_.text ~= "" then
						if arg_400_1.bgmTxt2_.text ~= "" then
							arg_400_1.bgmTxt_.text = arg_400_1.bgmTxt2_.text
						end

						arg_400_1.bgmTxt2_.text = var_403_23

						arg_400_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_400_1.bgmTxt_.text = var_403_23
						arg_400_1.bgmTxt2_.text = var_403_23
					end

					if arg_400_1.bgmTimer then
						arg_400_1.bgmTimer:Stop()

						arg_400_1.bgmTimer = nil
					end

					if arg_400_1.settingData.show_music_name == 1 then
						arg_400_1.musicController:SetSelectedState("show")
						arg_400_1.musicAnimator_:Play("open", 0, 0)

						if arg_400_1.settingData.music_time ~= 0 then
							arg_400_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_400_1.settingData.music_time), function()
								if arg_400_1 == nil or isNil(arg_400_1.bgmTxt_) then
									return
								end

								arg_400_1.musicController:SetSelectedState("hide")
								arg_400_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.57 < arg_400_1.time_ and arg_400_1.time_ <= 0.57 + arg_403_0 then
				arg_400_1:AudioAction("play", "music", "bgm_activity_4_0_story_ui", "inst", "bgm_activity_4_0_story_ui.awb")

				local var_403_26 = manager.audio:GetAudioName("bgm_activity_4_0_story_ui", "inst")

				if "" ~= "" then
					if arg_400_1.bgmTxt_.text ~= var_403_26 and arg_400_1.bgmTxt_.text ~= "" then
						if arg_400_1.bgmTxt2_.text ~= "" then
							arg_400_1.bgmTxt_.text = arg_400_1.bgmTxt2_.text
						end

						arg_400_1.bgmTxt2_.text = var_403_26

						arg_400_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_400_1.bgmTxt_.text = var_403_26
						arg_400_1.bgmTxt2_.text = var_403_26
					end

					if arg_400_1.bgmTimer then
						arg_400_1.bgmTimer:Stop()

						arg_400_1.bgmTimer = nil
					end

					if arg_400_1.settingData.show_music_name == 1 then
						arg_400_1.musicController:SetSelectedState("show")
						arg_400_1.musicAnimator_:Play("open", 0, 0)

						if arg_400_1.settingData.music_time ~= 0 then
							arg_400_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_400_1.settingData.music_time), function()
								if arg_400_1 == nil or isNil(arg_400_1.bgmTxt_) then
									return
								end

								arg_400_1.musicController:SetSelectedState("hide")
								arg_400_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.566666666666667 < arg_400_1.time_ and arg_400_1.time_ <= 0.566666666666667 + arg_403_0 then
				arg_400_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room02", "")
			end

			if 2 < arg_400_1.time_ and arg_400_1.time_ <= 2 + arg_403_0 then
				arg_400_1:AudioAction("play", "effect", "se_story_140", "se_story_140_data01", "")
			end

			if arg_400_1.frameCnt_ <= 1 then
				arg_400_1.dialog_:SetActive(false)
			end

			local var_403_29 = 2
			local var_403_30 = 0.675

			if 2 < arg_400_1.time_ and arg_400_1.time_ <= var_403_29 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0

				arg_400_1.dialog_:SetActive(true)

				arg_400_1.dialogCg_.alpha = 0

				local var_403_31 = LeanTween.value(arg_400_1.dialog_, 0, 1, 0.3)

				var_403_31:setOnUpdate(LuaHelper.FloatAction(function(arg_407_0)
					arg_400_1.dialogCg_.alpha = arg_407_0
				end))
				var_403_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_400_1.dialog_)
					var_403_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_400_1.duration_ = arg_400_1.duration_ + 0.3

				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_32 = arg_400_1:GetWordFromCfg(420191096)
				local var_403_33 = arg_400_1:FormatText(var_403_32.content)

				arg_400_1.text_.text = var_403_33

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_35 = 27 <= 0 and var_403_30 or var_403_30 * (utf8.len(var_403_33) / 27)

				if (27 <= 0 and var_403_30 or var_403_30 * (utf8.len(var_403_33) / 27)) > 0 and var_403_30 < var_403_35 then
					arg_400_1.talkMaxDuration = var_403_35
					var_403_29 = var_403_29 + 0.3

					if var_403_35 + var_403_29 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_35 + var_403_29
					end
				end

				arg_400_1.text_.text = var_403_33
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191096", "story_v_out_420191.awb") ~= 0 then
					local var_403_36 = manager.audio:GetVoiceLength("story_v_out_420191", "420191096", "story_v_out_420191.awb") / 1000

					if var_403_36 + var_403_29 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_36 + var_403_29
					end

					if var_403_32.prefab_name ~= "" and arg_400_1.actors_[var_403_32.prefab_name] ~= nil then
						local var_403_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_32.prefab_name].transform, "story_v_out_420191", "420191096", "story_v_out_420191.awb")

						arg_400_1:RecordAudio("420191096", var_403_37)
						arg_400_1:RecordAudio("420191096", var_403_37)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_420191", "420191096", "story_v_out_420191.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_420191", "420191096", "story_v_out_420191.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_38 = var_403_29 + 0.3
			local var_403_39 = math.max(var_403_30, arg_400_1.talkMaxDuration)

			if var_403_29 + 0.3 <= arg_400_1.time_ and arg_400_1.time_ < var_403_38 + var_403_39 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_38) / var_403_39

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_38 + var_403_39 and arg_400_1.time_ < var_403_38 + var_403_39 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play420191097 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 420191097
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play420191098(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos404001ui_story = arg_409_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_412_0 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 then
				arg_409_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_409_1.time_ - 0) / var_412_0)
				arg_409_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["404001ui_story"].transform.position).z)
				arg_409_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["404001ui_story"].transform.localEulerAngles = arg_409_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 then
				arg_409_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_409_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_409_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_409_1.actors_["404001ui_story"].transform.position).z)
				arg_409_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_409_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_409_1.actors_["404001ui_story"].transform.localEulerAngles = arg_409_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_412_1 = 0
			local var_412_2 = 0.75

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_3 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(420191097).content)

				arg_409_1.text_.text = var_412_3

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_5 = 30 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 30)

				if (30 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_3) / 30)) > 0 and var_412_2 < var_412_5 then
					arg_409_1.talkMaxDuration = var_412_5

					if var_412_5 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_3
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_6 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_6 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_6

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_6 and arg_409_1.time_ < var_412_1 + var_412_6 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
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

		arg_409_1:InitPlayNodeList()
	end,
	Play420191098 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 420191098
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play420191099(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = 0.875

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, false)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_1 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(420191098).content)

				arg_413_1.text_.text = var_416_1

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_3 = 35 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 35)

				if (35 <= 0 and var_416_0 or var_416_0 * (utf8.len(var_416_1) / 35)) > 0 and var_416_0 < var_416_3 then
					arg_413_1.talkMaxDuration = var_416_3

					if var_416_3 + 0 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_3 + 0
					end
				end

				arg_413_1.text_.text = var_416_1
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_4 = math.max(var_416_0, arg_413_1.talkMaxDuration)

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - 0) / var_416_4

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play420191099 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 420191099
		arg_417_1.duration_ = 4.17

		local var_417_0 = {
			zh = 4.166,
			ja = 3.5
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play420191100(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 3.10862446895044e-15 < arg_417_1.time_ and arg_417_1.time_ <= 3.10862446895044e-15 + arg_420_0 then
				arg_417_1.var_.moveOldPos404001ui_story = arg_417_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 3.10862446895044e-15 <= arg_417_1.time_ and arg_417_1.time_ < 3.10862446895044e-15 + var_420_0 then
				arg_417_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_417_1.time_ - 3.10862446895044e-15) / var_420_0)
				arg_417_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["404001ui_story"].transform.position).z)
				arg_417_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["404001ui_story"].transform.localEulerAngles = arg_417_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 3.10862446895044e-15 + var_420_0 and arg_417_1.time_ < 3.10862446895044e-15 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_417_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["404001ui_story"].transform.position).z)
				arg_417_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["404001ui_story"].transform.localEulerAngles = arg_417_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_420_1 = arg_417_1.actors_["404001ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect404001ui_story == nil then
				arg_417_1.var_.characterEffect404001ui_story = var_420_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 and not isNil(var_420_1) then
				if arg_417_1.var_.characterEffect404001ui_story and not isNil(var_420_1) then
					arg_417_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect404001ui_story then
				arg_417_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 3.10862446895044e-15 < arg_417_1.time_ and arg_417_1.time_ <= 3.10862446895044e-15 + arg_420_0 then
				arg_417_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 3.10862446895044e-15 < arg_417_1.time_ and arg_417_1.time_ <= 3.10862446895044e-15 + arg_420_0 then
				arg_417_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_420_4 = 0
			local var_420_5 = 0.375

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_4 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_6 = arg_417_1:GetWordFromCfg(420191099)
				local var_420_7 = arg_417_1:FormatText(var_420_6.content)

				arg_417_1.text_.text = var_420_7

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_9 = 15 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 15)

				if (15 <= 0 and var_420_5 or var_420_5 * (utf8.len(var_420_7) / 15)) > 0 and var_420_5 < var_420_9 then
					arg_417_1.talkMaxDuration = var_420_9

					if var_420_9 + var_420_4 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_9 + var_420_4
					end
				end

				arg_417_1.text_.text = var_420_7
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191099", "story_v_out_420191.awb") ~= 0 then
					local var_420_10 = manager.audio:GetVoiceLength("story_v_out_420191", "420191099", "story_v_out_420191.awb") / 1000

					if var_420_10 + var_420_4 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_10 + var_420_4
					end

					if var_420_6.prefab_name ~= "" and arg_417_1.actors_[var_420_6.prefab_name] ~= nil then
						local var_420_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_6.prefab_name].transform, "story_v_out_420191", "420191099", "story_v_out_420191.awb")

						arg_417_1:RecordAudio("420191099", var_420_11)
						arg_417_1:RecordAudio("420191099", var_420_11)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_420191", "420191099", "story_v_out_420191.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_420191", "420191099", "story_v_out_420191.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_12 = math.max(var_420_5, arg_417_1.talkMaxDuration)

			if var_420_4 <= arg_417_1.time_ and arg_417_1.time_ < var_420_4 + var_420_12 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_4) / var_420_12

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_4 + var_420_12 and arg_417_1.time_ < var_420_4 + var_420_12 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.10862446895044e-15,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play420191100 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 420191100
		arg_421_1.duration_ = 4.13

		local var_421_0 = {
			zh = 3.433,
			ja = 4.133
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play420191101(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0.45

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_1 = arg_421_1:GetWordFromCfg(420191100)
				local var_424_2 = arg_421_1:FormatText(var_424_1.content)

				arg_421_1.text_.text = var_424_2

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_4 = 18 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 18)

				if (18 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 18)) > 0 and var_424_0 < var_424_4 then
					arg_421_1.talkMaxDuration = var_424_4

					if var_424_4 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_4 + 0
					end
				end

				arg_421_1.text_.text = var_424_2
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191100", "story_v_out_420191.awb") ~= 0 then
					local var_424_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191100", "story_v_out_420191.awb") / 1000

					if var_424_5 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + 0
					end

					if var_424_1.prefab_name ~= "" and arg_421_1.actors_[var_424_1.prefab_name] ~= nil then
						local var_424_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_1.prefab_name].transform, "story_v_out_420191", "420191100", "story_v_out_420191.awb")

						arg_421_1:RecordAudio("420191100", var_424_6)
						arg_421_1:RecordAudio("420191100", var_424_6)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_420191", "420191100", "story_v_out_420191.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_420191", "420191100", "story_v_out_420191.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_7 and arg_421_1.time_ < 0 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play420191101 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 420191101
		arg_425_1.duration_ = 2.73

		local var_425_0 = {
			zh = 2.2,
			ja = 2.733
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play420191102(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.var_.moveOldPos1085ui_story = arg_425_1.actors_["1085ui_story"].transform.localPosition
			end

			local var_428_0 = 0.001

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 then
				arg_425_1.actors_["1085ui_story"].transform.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos1085ui_story, Vector3.New(0.75, -1.01, -5.83), (arg_425_1.time_ - 0) / var_428_0)
				arg_425_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1085ui_story"].transform.position).z)
				arg_425_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1085ui_story"].transform.localEulerAngles = arg_425_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 then
				arg_425_1.actors_["1085ui_story"].transform.localPosition = Vector3.New(0.75, -1.01, -5.83)
				arg_425_1.actors_["1085ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_425_1.actors_["1085ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1085ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_425_1.actors_["1085ui_story"].transform.position).z)
				arg_425_1.actors_["1085ui_story"].transform.localEulerAngles.z = 0
				arg_425_1.actors_["1085ui_story"].transform.localEulerAngles.x = 0
				arg_425_1.actors_["1085ui_story"].transform.localEulerAngles = arg_425_1.actors_["1085ui_story"].transform.localEulerAngles
			end

			local var_428_1 = arg_425_1.actors_["1085ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1085ui_story == nil then
				arg_425_1.var_.characterEffect1085ui_story = var_428_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_2 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_2 and not isNil(var_428_1) then
				if arg_425_1.var_.characterEffect1085ui_story and not isNil(var_428_1) then
					arg_425_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_425_1.time_ >= 0 + var_428_2 and arg_425_1.time_ < 0 + var_428_2 + arg_428_0 and not isNil(var_428_1) and arg_425_1.var_.characterEffect1085ui_story then
				arg_425_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_428_4 = arg_425_1.actors_["404001ui_story"].transform

			if 3.10862446895044e-15 < arg_425_1.time_ and arg_425_1.time_ <= 3.10862446895044e-15 + arg_428_0 then
				arg_425_1.var_.moveOldPos404001ui_story = var_428_4.localPosition
			end

			local var_428_5 = 0.001

			if 3.10862446895044e-15 <= arg_425_1.time_ and arg_425_1.time_ < 3.10862446895044e-15 + var_428_5 then
				var_428_4.localPosition = Vector3.Lerp(arg_425_1.var_.moveOldPos404001ui_story, Vector3.New(-0.8, -1.55, -5.5), (arg_425_1.time_ - 3.10862446895044e-15) / var_428_5)
				var_428_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_428_4.position).x, (manager.ui.mainCamera.transform.position - var_428_4.position).y, (manager.ui.mainCamera.transform.position - var_428_4.position).z)
				var_428_4.localEulerAngles.z = 0
				var_428_4.localEulerAngles.x = 0
				var_428_4.localEulerAngles = var_428_4.localEulerAngles
			end

			if arg_425_1.time_ >= 3.10862446895044e-15 + var_428_5 and arg_425_1.time_ < 3.10862446895044e-15 + var_428_5 + arg_428_0 then
				var_428_4.localPosition = Vector3.New(-0.8, -1.55, -5.5)
				var_428_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_428_4.position).x, (manager.ui.mainCamera.transform.position - var_428_4.position).y, (manager.ui.mainCamera.transform.position - var_428_4.position).z)
				var_428_4.localEulerAngles.z = 0
				var_428_4.localEulerAngles.x = 0
				var_428_4.localEulerAngles = var_428_4.localEulerAngles
			end

			local var_428_6 = arg_425_1.actors_["404001ui_story"]

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(var_428_6) and arg_425_1.var_.characterEffect404001ui_story == nil then
				arg_425_1.var_.characterEffect404001ui_story = var_428_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_7 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_7 and not isNil(var_428_6) then
				if arg_425_1.var_.characterEffect404001ui_story and not isNil(var_428_6) then
					arg_425_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_425_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_7)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_7 and arg_425_1.time_ < 0 + var_428_7 + arg_428_0 and not isNil(var_428_6) and arg_425_1.var_.characterEffect404001ui_story then
				arg_425_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_425_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_428_8 = 0
			local var_428_9 = 0.225

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_8 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_10 = arg_425_1:GetWordFromCfg(420191101)
				local var_428_11 = arg_425_1:FormatText(var_428_10.content)

				arg_425_1.text_.text = var_428_11

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_13 = 9 <= 0 and var_428_9 or var_428_9 * (utf8.len(var_428_11) / 9)

				if (9 <= 0 and var_428_9 or var_428_9 * (utf8.len(var_428_11) / 9)) > 0 and var_428_9 < var_428_13 then
					arg_425_1.talkMaxDuration = var_428_13

					if var_428_13 + var_428_8 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_13 + var_428_8
					end
				end

				arg_425_1.text_.text = var_428_11
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191101", "story_v_out_420191.awb") ~= 0 then
					local var_428_14 = manager.audio:GetVoiceLength("story_v_out_420191", "420191101", "story_v_out_420191.awb") / 1000

					if var_428_14 + var_428_8 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_14 + var_428_8
					end

					if var_428_10.prefab_name ~= "" and arg_425_1.actors_[var_428_10.prefab_name] ~= nil then
						local var_428_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_10.prefab_name].transform, "story_v_out_420191", "420191101", "story_v_out_420191.awb")

						arg_425_1:RecordAudio("420191101", var_428_15)
						arg_425_1:RecordAudio("420191101", var_428_15)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_420191", "420191101", "story_v_out_420191.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_420191", "420191101", "story_v_out_420191.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_16 = math.max(var_428_9, arg_425_1.talkMaxDuration)

			if var_428_8 <= arg_425_1.time_ and arg_425_1.time_ < var_428_8 + var_428_16 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_8) / var_428_16

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_8 + var_428_16 and arg_425_1.time_ < var_428_8 + var_428_16 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {
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
				startTime = 3.10862446895044e-15,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_425_1:InitPlayNodeList()
	end,
	Play420191102 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 420191102
		arg_429_1.duration_ = 2.1

		local var_429_0 = {
			zh = 1.6,
			ja = 2.1
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play420191103(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["404001ui_story"]) and arg_429_1.var_.characterEffect404001ui_story == nil then
				arg_429_1.var_.characterEffect404001ui_story = arg_429_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_0 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["404001ui_story"]) then
				if arg_429_1.var_.characterEffect404001ui_story and not isNil(arg_429_1.actors_["404001ui_story"]) then
					arg_429_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["404001ui_story"]) and arg_429_1.var_.characterEffect404001ui_story then
				arg_429_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_432_2 = arg_429_1.actors_["1085ui_story"]

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(var_432_2) and arg_429_1.var_.characterEffect1085ui_story == nil then
				arg_429_1.var_.characterEffect1085ui_story = var_432_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_3 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_3 and not isNil(var_432_2) then
				if arg_429_1.var_.characterEffect1085ui_story and not isNil(var_432_2) then
					arg_429_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_429_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_429_1.time_ - 0) / var_432_3)
				end
			end

			if arg_429_1.time_ >= 0 + var_432_3 and arg_429_1.time_ < 0 + var_432_3 + arg_432_0 and not isNil(var_432_2) and arg_429_1.var_.characterEffect1085ui_story then
				arg_429_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_429_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_432_4 = 0
			local var_432_5 = 0.2

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_4 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_6 = arg_429_1:GetWordFromCfg(420191102)
				local var_432_7 = arg_429_1:FormatText(var_432_6.content)

				arg_429_1.text_.text = var_432_7

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_9 = 8 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 8)

				if (8 <= 0 and var_432_5 or var_432_5 * (utf8.len(var_432_7) / 8)) > 0 and var_432_5 < var_432_9 then
					arg_429_1.talkMaxDuration = var_432_9

					if var_432_9 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_9 + var_432_4
					end
				end

				arg_429_1.text_.text = var_432_7
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191102", "story_v_out_420191.awb") ~= 0 then
					local var_432_10 = manager.audio:GetVoiceLength("story_v_out_420191", "420191102", "story_v_out_420191.awb") / 1000

					if var_432_10 + var_432_4 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_10 + var_432_4
					end

					if var_432_6.prefab_name ~= "" and arg_429_1.actors_[var_432_6.prefab_name] ~= nil then
						local var_432_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_6.prefab_name].transform, "story_v_out_420191", "420191102", "story_v_out_420191.awb")

						arg_429_1:RecordAudio("420191102", var_432_11)
						arg_429_1:RecordAudio("420191102", var_432_11)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_420191", "420191102", "story_v_out_420191.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_420191", "420191102", "story_v_out_420191.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_12 = math.max(var_432_5, arg_429_1.talkMaxDuration)

			if var_432_4 <= arg_429_1.time_ and arg_429_1.time_ < var_432_4 + var_432_12 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_4) / var_432_12

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_4 + var_432_12 and arg_429_1.time_ < var_432_4 + var_432_12 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play420191103 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 420191103
		arg_433_1.duration_ = 1.8

		local var_433_0 = {
			zh = 1.5,
			ja = 1.8
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play420191104(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["1085ui_story"]) and arg_433_1.var_.characterEffect1085ui_story == nil then
				arg_433_1.var_.characterEffect1085ui_story = arg_433_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_0 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["1085ui_story"]) then
				if arg_433_1.var_.characterEffect1085ui_story and not isNil(arg_433_1.actors_["1085ui_story"]) then
					arg_433_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["1085ui_story"]) and arg_433_1.var_.characterEffect1085ui_story then
				arg_433_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_436_2 = arg_433_1.actors_["404001ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_2) and arg_433_1.var_.characterEffect404001ui_story == nil then
				arg_433_1.var_.characterEffect404001ui_story = var_436_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_3 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_3 and not isNil(var_436_2) then
				if arg_433_1.var_.characterEffect404001ui_story and not isNil(var_436_2) then
					arg_433_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_433_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_3)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_3 and arg_433_1.time_ < 0 + var_436_3 + arg_436_0 and not isNil(var_436_2) and arg_433_1.var_.characterEffect404001ui_story then
				arg_433_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_433_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_436_4 = 0
			local var_436_5 = 0.175

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_4 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_6 = arg_433_1:GetWordFromCfg(420191103)
				local var_436_7 = arg_433_1:FormatText(var_436_6.content)

				arg_433_1.text_.text = var_436_7

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_9 = 7 <= 0 and var_436_5 or var_436_5 * (utf8.len(var_436_7) / 7)

				if (7 <= 0 and var_436_5 or var_436_5 * (utf8.len(var_436_7) / 7)) > 0 and var_436_5 < var_436_9 then
					arg_433_1.talkMaxDuration = var_436_9

					if var_436_9 + var_436_4 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_9 + var_436_4
					end
				end

				arg_433_1.text_.text = var_436_7
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191103", "story_v_out_420191.awb") ~= 0 then
					local var_436_10 = manager.audio:GetVoiceLength("story_v_out_420191", "420191103", "story_v_out_420191.awb") / 1000

					if var_436_10 + var_436_4 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_10 + var_436_4
					end

					if var_436_6.prefab_name ~= "" and arg_433_1.actors_[var_436_6.prefab_name] ~= nil then
						local var_436_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_6.prefab_name].transform, "story_v_out_420191", "420191103", "story_v_out_420191.awb")

						arg_433_1:RecordAudio("420191103", var_436_11)
						arg_433_1:RecordAudio("420191103", var_436_11)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_420191", "420191103", "story_v_out_420191.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_420191", "420191103", "story_v_out_420191.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_12 = math.max(var_436_5, arg_433_1.talkMaxDuration)

			if var_436_4 <= arg_433_1.time_ and arg_433_1.time_ < var_436_4 + var_436_12 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_4) / var_436_12

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_4 + var_436_12 and arg_433_1.time_ < var_436_4 + var_436_12 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play420191104 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 420191104
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play420191105(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1085ui_story"]) and arg_437_1.var_.characterEffect1085ui_story == nil then
				arg_437_1.var_.characterEffect1085ui_story = arg_437_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_0 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1085ui_story"]) then
				if arg_437_1.var_.characterEffect1085ui_story and not isNil(arg_437_1.actors_["1085ui_story"]) then
					arg_437_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_0)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1085ui_story"]) and arg_437_1.var_.characterEffect1085ui_story then
				arg_437_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_440_1 = 0
			local var_440_2 = 0.975

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_1 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, false)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_3 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(420191104).content)

				arg_437_1.text_.text = var_440_3

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_5 = 39 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 39)

				if (39 <= 0 and var_440_2 or var_440_2 * (utf8.len(var_440_3) / 39)) > 0 and var_440_2 < var_440_5 then
					arg_437_1.talkMaxDuration = var_440_5

					if var_440_5 + var_440_1 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_5 + var_440_1
					end
				end

				arg_437_1.text_.text = var_440_3
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_6 = math.max(var_440_2, arg_437_1.talkMaxDuration)

			if var_440_1 <= arg_437_1.time_ and arg_437_1.time_ < var_440_1 + var_440_6 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_1) / var_440_6

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_1 + var_440_6 and arg_437_1.time_ < var_440_1 + var_440_6 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play420191105 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 420191105
		arg_441_1.duration_ = 3.7

		local var_441_0 = {
			zh = 3.4,
			ja = 3.7
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play420191106(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["1085ui_story"]) and arg_441_1.var_.characterEffect1085ui_story == nil then
				arg_441_1.var_.characterEffect1085ui_story = arg_441_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_444_0 = 0.200000002980232

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["1085ui_story"]) then
				if arg_441_1.var_.characterEffect1085ui_story and not isNil(arg_441_1.actors_["1085ui_story"]) then
					arg_441_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["1085ui_story"]) and arg_441_1.var_.characterEffect1085ui_story then
				arg_441_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_444_2 = 0
			local var_444_3 = 0.275

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_2 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_4 = arg_441_1:GetWordFromCfg(420191105)
				local var_444_5 = arg_441_1:FormatText(var_444_4.content)

				arg_441_1.text_.text = var_444_5

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_7 = 11 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_5) / 11)

				if (11 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_5) / 11)) > 0 and var_444_3 < var_444_7 then
					arg_441_1.talkMaxDuration = var_444_7

					if var_444_7 + var_444_2 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_2
					end
				end

				arg_441_1.text_.text = var_444_5
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191105", "story_v_out_420191.awb") ~= 0 then
					local var_444_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191105", "story_v_out_420191.awb") / 1000

					if var_444_8 + var_444_2 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_8 + var_444_2
					end

					if var_444_4.prefab_name ~= "" and arg_441_1.actors_[var_444_4.prefab_name] ~= nil then
						local var_444_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_4.prefab_name].transform, "story_v_out_420191", "420191105", "story_v_out_420191.awb")

						arg_441_1:RecordAudio("420191105", var_444_9)
						arg_441_1:RecordAudio("420191105", var_444_9)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_420191", "420191105", "story_v_out_420191.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_420191", "420191105", "story_v_out_420191.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_10 = math.max(var_444_3, arg_441_1.talkMaxDuration)

			if var_444_2 <= arg_441_1.time_ and arg_441_1.time_ < var_444_2 + var_444_10 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_2) / var_444_10

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_2 + var_444_10 and arg_441_1.time_ < var_444_2 + var_444_10 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play420191106 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 420191106
		arg_445_1.duration_ = 4.73

		local var_445_0 = {
			zh = 3.6,
			ja = 4.733
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play420191107(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["404001ui_story"]) and arg_445_1.var_.characterEffect404001ui_story == nil then
				arg_445_1.var_.characterEffect404001ui_story = arg_445_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["404001ui_story"]) then
				if arg_445_1.var_.characterEffect404001ui_story and not isNil(arg_445_1.actors_["404001ui_story"]) then
					arg_445_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["404001ui_story"]) and arg_445_1.var_.characterEffect404001ui_story then
				arg_445_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_448_2 = arg_445_1.actors_["1085ui_story"]

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(var_448_2) and arg_445_1.var_.characterEffect1085ui_story == nil then
				arg_445_1.var_.characterEffect1085ui_story = var_448_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_3 = 0.200000002980232

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_3 and not isNil(var_448_2) then
				if arg_445_1.var_.characterEffect1085ui_story and not isNil(var_448_2) then
					arg_445_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_445_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_445_1.time_ - 0) / var_448_3)
				end
			end

			if arg_445_1.time_ >= 0 + var_448_3 and arg_445_1.time_ < 0 + var_448_3 + arg_448_0 and not isNil(var_448_2) and arg_445_1.var_.characterEffect1085ui_story then
				arg_445_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_445_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			local var_448_4 = 0
			local var_448_5 = 0.4

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_4 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_6 = arg_445_1:GetWordFromCfg(420191106)
				local var_448_7 = arg_445_1:FormatText(var_448_6.content)

				arg_445_1.text_.text = var_448_7

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_9 = 16 <= 0 and var_448_5 or var_448_5 * (utf8.len(var_448_7) / 16)

				if (16 <= 0 and var_448_5 or var_448_5 * (utf8.len(var_448_7) / 16)) > 0 and var_448_5 < var_448_9 then
					arg_445_1.talkMaxDuration = var_448_9

					if var_448_9 + var_448_4 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_9 + var_448_4
					end
				end

				arg_445_1.text_.text = var_448_7
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191106", "story_v_out_420191.awb") ~= 0 then
					local var_448_10 = manager.audio:GetVoiceLength("story_v_out_420191", "420191106", "story_v_out_420191.awb") / 1000

					if var_448_10 + var_448_4 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_10 + var_448_4
					end

					if var_448_6.prefab_name ~= "" and arg_445_1.actors_[var_448_6.prefab_name] ~= nil then
						local var_448_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_6.prefab_name].transform, "story_v_out_420191", "420191106", "story_v_out_420191.awb")

						arg_445_1:RecordAudio("420191106", var_448_11)
						arg_445_1:RecordAudio("420191106", var_448_11)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_420191", "420191106", "story_v_out_420191.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_420191", "420191106", "story_v_out_420191.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_12 = math.max(var_448_5, arg_445_1.talkMaxDuration)

			if var_448_4 <= arg_445_1.time_ and arg_445_1.time_ < var_448_4 + var_448_12 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_4) / var_448_12

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_4 + var_448_12 and arg_445_1.time_ < var_448_4 + var_448_12 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play420191107 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 420191107
		arg_449_1.duration_ = 5.6

		local var_449_0 = {
			zh = 4.7,
			ja = 5.6
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play420191108(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0.525

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_1 = arg_449_1:GetWordFromCfg(420191107)
				local var_452_2 = arg_449_1:FormatText(var_452_1.content)

				arg_449_1.text_.text = var_452_2

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_4 = 21 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 21)

				if (21 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 21)) > 0 and var_452_0 < var_452_4 then
					arg_449_1.talkMaxDuration = var_452_4

					if var_452_4 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_4 + 0
					end
				end

				arg_449_1.text_.text = var_452_2
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191107", "story_v_out_420191.awb") ~= 0 then
					local var_452_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191107", "story_v_out_420191.awb") / 1000

					if var_452_5 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + 0
					end

					if var_452_1.prefab_name ~= "" and arg_449_1.actors_[var_452_1.prefab_name] ~= nil then
						local var_452_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_1.prefab_name].transform, "story_v_out_420191", "420191107", "story_v_out_420191.awb")

						arg_449_1:RecordAudio("420191107", var_452_6)
						arg_449_1:RecordAudio("420191107", var_452_6)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_420191", "420191107", "story_v_out_420191.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_420191", "420191107", "story_v_out_420191.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_7 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_7 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_7

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_7 and arg_449_1.time_ < 0 + var_452_7 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play420191108 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 420191108
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play420191109(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos404001ui_story = arg_453_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["404001ui_story"].transform.position).z)
				arg_453_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["404001ui_story"].transform.localEulerAngles = arg_453_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_453_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["404001ui_story"].transform.position).z)
				arg_453_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["404001ui_story"].transform.localEulerAngles = arg_453_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_456_1 = arg_453_1.actors_["1085ui_story"].transform

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1085ui_story = var_456_1.localPosition
			end

			local var_456_2 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_2 then
				var_456_1.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1085ui_story, Vector3.New(0, 100, 0), (arg_453_1.time_ - 0) / var_456_2)
				var_456_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_456_1.position).x, (manager.ui.mainCamera.transform.position - var_456_1.position).y, (manager.ui.mainCamera.transform.position - var_456_1.position).z)
				var_456_1.localEulerAngles.z = 0
				var_456_1.localEulerAngles.x = 0
				var_456_1.localEulerAngles = var_456_1.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_2 and arg_453_1.time_ < 0 + var_456_2 + arg_456_0 then
				var_456_1.localPosition = Vector3.New(0, 100, 0)
				var_456_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_456_1.position).x, (manager.ui.mainCamera.transform.position - var_456_1.position).y, (manager.ui.mainCamera.transform.position - var_456_1.position).z)
				var_456_1.localEulerAngles.z = 0
				var_456_1.localEulerAngles.x = 0
				var_456_1.localEulerAngles = var_456_1.localEulerAngles
			end

			if 0.05 < arg_453_1.time_ and arg_453_1.time_ <= 0.05 + arg_456_0 then
				arg_453_1:AudioAction("play", "effect", "se_story_side_1042", "se_story_1042_doorbell", "")
			end

			local var_456_4 = 0
			local var_456_5 = 1.275

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_4 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_6 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(420191108).content)

				arg_453_1.text_.text = var_456_6

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_8 = 51 <= 0 and var_456_5 or var_456_5 * (utf8.len(var_456_6) / 51)

				if (51 <= 0 and var_456_5 or var_456_5 * (utf8.len(var_456_6) / 51)) > 0 and var_456_5 < var_456_8 then
					arg_453_1.talkMaxDuration = var_456_8

					if var_456_8 + var_456_4 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_8 + var_456_4
					end
				end

				arg_453_1.text_.text = var_456_6
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_9 = math.max(var_456_5, arg_453_1.talkMaxDuration)

			if var_456_4 <= arg_453_1.time_ and arg_453_1.time_ < var_456_4 + var_456_9 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_4) / var_456_9

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_4 + var_456_9 and arg_453_1.time_ < var_456_4 + var_456_9 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
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
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play420191109 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 420191109
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play420191110(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.8

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_1 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(420191109).content)

				arg_457_1.text_.text = var_460_1

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_3 = 32 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 32)

				if (32 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_1) / 32)) > 0 and var_460_0 < var_460_3 then
					arg_457_1.talkMaxDuration = var_460_3

					if var_460_3 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_3 + 0
					end
				end

				arg_457_1.text_.text = var_460_1
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_4 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_4

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play420191110 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 420191110
		arg_461_1.duration_ = 6.77

		local var_461_0 = {
			zh = 4.633,
			ja = 6.766
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play420191111(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 3.10862446895044e-15 < arg_461_1.time_ and arg_461_1.time_ <= 3.10862446895044e-15 + arg_464_0 then
				arg_461_1.var_.moveOldPos404001ui_story = arg_461_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_464_0 = 0.001

			if 3.10862446895044e-15 <= arg_461_1.time_ and arg_461_1.time_ < 3.10862446895044e-15 + var_464_0 then
				arg_461_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos404001ui_story, Vector3.New(0, -1.55, -5.5), (arg_461_1.time_ - 3.10862446895044e-15) / var_464_0)
				arg_461_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["404001ui_story"].transform.position).z)
				arg_461_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["404001ui_story"].transform.localEulerAngles = arg_461_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_461_1.time_ >= 3.10862446895044e-15 + var_464_0 and arg_461_1.time_ < 3.10862446895044e-15 + var_464_0 + arg_464_0 then
				arg_461_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_461_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["404001ui_story"].transform.position).z)
				arg_461_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["404001ui_story"].transform.localEulerAngles = arg_461_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			local var_464_1 = arg_461_1.actors_["404001ui_story"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect404001ui_story == nil then
				arg_461_1.var_.characterEffect404001ui_story = var_464_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_2 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_2 and not isNil(var_464_1) then
				if arg_461_1.var_.characterEffect404001ui_story and not isNil(var_464_1) then
					arg_461_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= 0 + var_464_2 and arg_461_1.time_ < 0 + var_464_2 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect404001ui_story then
				arg_461_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			if 3.10862446895044e-15 < arg_461_1.time_ and arg_461_1.time_ <= 3.10862446895044e-15 + arg_464_0 then
				arg_461_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 3.10862446895044e-15 < arg_461_1.time_ and arg_461_1.time_ <= 3.10862446895044e-15 + arg_464_0 then
				arg_461_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_464_4 = 0
			local var_464_5 = 0.425

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_4 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_6 = arg_461_1:GetWordFromCfg(420191110)
				local var_464_7 = arg_461_1:FormatText(var_464_6.content)

				arg_461_1.text_.text = var_464_7

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_9 = 17 <= 0 and var_464_5 or var_464_5 * (utf8.len(var_464_7) / 17)

				if (17 <= 0 and var_464_5 or var_464_5 * (utf8.len(var_464_7) / 17)) > 0 and var_464_5 < var_464_9 then
					arg_461_1.talkMaxDuration = var_464_9

					if var_464_9 + var_464_4 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_9 + var_464_4
					end
				end

				arg_461_1.text_.text = var_464_7
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191110", "story_v_out_420191.awb") ~= 0 then
					local var_464_10 = manager.audio:GetVoiceLength("story_v_out_420191", "420191110", "story_v_out_420191.awb") / 1000

					if var_464_10 + var_464_4 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_10 + var_464_4
					end

					if var_464_6.prefab_name ~= "" and arg_461_1.actors_[var_464_6.prefab_name] ~= nil then
						local var_464_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_6.prefab_name].transform, "story_v_out_420191", "420191110", "story_v_out_420191.awb")

						arg_461_1:RecordAudio("420191110", var_464_11)
						arg_461_1:RecordAudio("420191110", var_464_11)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_420191", "420191110", "story_v_out_420191.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_420191", "420191110", "story_v_out_420191.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_12 = math.max(var_464_5, arg_461_1.talkMaxDuration)

			if var_464_4 <= arg_461_1.time_ and arg_461_1.time_ < var_464_4 + var_464_12 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_4) / var_464_12

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_4 + var_464_12 and arg_461_1.time_ < var_464_4 + var_464_12 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.10862446895044e-15,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play420191111 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 420191111
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play420191112(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["404001ui_story"]) and arg_465_1.var_.characterEffect404001ui_story == nil then
				arg_465_1.var_.characterEffect404001ui_story = arg_465_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_0 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["404001ui_story"]) then
				if arg_465_1.var_.characterEffect404001ui_story and not isNil(arg_465_1.actors_["404001ui_story"]) then
					arg_465_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_465_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_465_1.time_ - 0) / var_468_0)
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["404001ui_story"]) and arg_465_1.var_.characterEffect404001ui_story then
				arg_465_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_465_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_468_1 = 0
			local var_468_2 = 0.65

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_1 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_3 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(420191111).content)

				arg_465_1.text_.text = var_468_3

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 26 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_3) / 26)

				if (26 <= 0 and var_468_2 or var_468_2 * (utf8.len(var_468_3) / 26)) > 0 and var_468_2 < var_468_5 then
					arg_465_1.talkMaxDuration = var_468_5

					if var_468_5 + var_468_1 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + var_468_1
					end
				end

				arg_465_1.text_.text = var_468_3
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_6 = math.max(var_468_2, arg_465_1.talkMaxDuration)

			if var_468_1 <= arg_465_1.time_ and arg_465_1.time_ < var_468_1 + var_468_6 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_1) / var_468_6

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_1 + var_468_6 and arg_465_1.time_ < var_468_1 + var_468_6 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play420191112 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 420191112
		arg_469_1.duration_ = 7.23

		local var_469_0 = {
			zh = 7.233,
			ja = 7.166
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play420191113(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["404001ui_story"]) and arg_469_1.var_.characterEffect404001ui_story == nil then
				arg_469_1.var_.characterEffect404001ui_story = arg_469_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["404001ui_story"]) then
				if arg_469_1.var_.characterEffect404001ui_story and not isNil(arg_469_1.actors_["404001ui_story"]) then
					arg_469_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["404001ui_story"]) and arg_469_1.var_.characterEffect404001ui_story then
				arg_469_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_472_2 = 0
			local var_472_3 = 0.85

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_2 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_4 = arg_469_1:GetWordFromCfg(420191112)
				local var_472_5 = arg_469_1:FormatText(var_472_4.content)

				arg_469_1.text_.text = var_472_5

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_7 = 34 <= 0 and var_472_3 or var_472_3 * (utf8.len(var_472_5) / 34)

				if (34 <= 0 and var_472_3 or var_472_3 * (utf8.len(var_472_5) / 34)) > 0 and var_472_3 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_2
					end
				end

				arg_469_1.text_.text = var_472_5
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191112", "story_v_out_420191.awb") ~= 0 then
					local var_472_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191112", "story_v_out_420191.awb") / 1000

					if var_472_8 + var_472_2 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_8 + var_472_2
					end

					if var_472_4.prefab_name ~= "" and arg_469_1.actors_[var_472_4.prefab_name] ~= nil then
						local var_472_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_4.prefab_name].transform, "story_v_out_420191", "420191112", "story_v_out_420191.awb")

						arg_469_1:RecordAudio("420191112", var_472_9)
						arg_469_1:RecordAudio("420191112", var_472_9)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_420191", "420191112", "story_v_out_420191.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_420191", "420191112", "story_v_out_420191.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_10 = math.max(var_472_3, arg_469_1.talkMaxDuration)

			if var_472_2 <= arg_469_1.time_ and arg_469_1.time_ < var_472_2 + var_472_10 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_2) / var_472_10

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_2 + var_472_10 and arg_469_1.time_ < var_472_2 + var_472_10 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play420191113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 420191113
		arg_473_1.duration_ = 6.07

		local var_473_0 = {
			zh = 4.333,
			ja = 6.066
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play420191114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.575

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_1 = arg_473_1:GetWordFromCfg(420191113)
				local var_476_2 = arg_473_1:FormatText(var_476_1.content)

				arg_473_1.text_.text = var_476_2

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 23 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 23)

				if (23 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 23)) > 0 and var_476_0 < var_476_4 then
					arg_473_1.talkMaxDuration = var_476_4

					if var_476_4 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_4 + 0
					end
				end

				arg_473_1.text_.text = var_476_2
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191113", "story_v_out_420191.awb") ~= 0 then
					local var_476_5 = manager.audio:GetVoiceLength("story_v_out_420191", "420191113", "story_v_out_420191.awb") / 1000

					if var_476_5 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + 0
					end

					if var_476_1.prefab_name ~= "" and arg_473_1.actors_[var_476_1.prefab_name] ~= nil then
						local var_476_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_1.prefab_name].transform, "story_v_out_420191", "420191113", "story_v_out_420191.awb")

						arg_473_1:RecordAudio("420191113", var_476_6)
						arg_473_1:RecordAudio("420191113", var_476_6)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_420191", "420191113", "story_v_out_420191.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_420191", "420191113", "story_v_out_420191.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_7 and arg_473_1.time_ < 0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play420191114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 420191114
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play420191115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["404001ui_story"]) and arg_477_1.var_.characterEffect404001ui_story == nil then
				arg_477_1.var_.characterEffect404001ui_story = arg_477_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["404001ui_story"]) then
				if arg_477_1.var_.characterEffect404001ui_story and not isNil(arg_477_1.actors_["404001ui_story"]) then
					arg_477_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_477_1.var_.characterEffect404001ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_477_1.time_ - 0) / var_480_0)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["404001ui_story"]) and arg_477_1.var_.characterEffect404001ui_story then
				arg_477_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_477_1.var_.characterEffect404001ui_story.fillRatio = 0.5
			end

			local var_480_1 = 0
			local var_480_2 = 0.825

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_1 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_3 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(420191114).content)

				arg_477_1.text_.text = var_480_3

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 33 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 33)

				if (33 <= 0 and var_480_2 or var_480_2 * (utf8.len(var_480_3) / 33)) > 0 and var_480_2 < var_480_5 then
					arg_477_1.talkMaxDuration = var_480_5

					if var_480_5 + var_480_1 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + var_480_1
					end
				end

				arg_477_1.text_.text = var_480_3
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_6 = math.max(var_480_2, arg_477_1.talkMaxDuration)

			if var_480_1 <= arg_477_1.time_ and arg_477_1.time_ < var_480_1 + var_480_6 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_1) / var_480_6

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_1 + var_480_6 and arg_477_1.time_ < var_480_1 + var_480_6 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play420191115 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 420191115
		arg_481_1.duration_ = 9.1

		local var_481_0 = {
			zh = 7.533,
			ja = 9.1
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play420191116(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(arg_481_1.actors_["404001ui_story"]) and arg_481_1.var_.characterEffect404001ui_story == nil then
				arg_481_1.var_.characterEffect404001ui_story = arg_481_1.actors_["404001ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_0 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 and not isNil(arg_481_1.actors_["404001ui_story"]) then
				if arg_481_1.var_.characterEffect404001ui_story and not isNil(arg_481_1.actors_["404001ui_story"]) then
					arg_481_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 and not isNil(arg_481_1.actors_["404001ui_story"]) and arg_481_1.var_.characterEffect404001ui_story then
				arg_481_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_484_2 = 0
			local var_484_3 = 0.725

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_2 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_4 = arg_481_1:GetWordFromCfg(420191115)
				local var_484_5 = arg_481_1:FormatText(var_484_4.content)

				arg_481_1.text_.text = var_484_5

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_7 = 29 <= 0 and var_484_3 or var_484_3 * (utf8.len(var_484_5) / 29)

				if (29 <= 0 and var_484_3 or var_484_3 * (utf8.len(var_484_5) / 29)) > 0 and var_484_3 < var_484_7 then
					arg_481_1.talkMaxDuration = var_484_7

					if var_484_7 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_7 + var_484_2
					end
				end

				arg_481_1.text_.text = var_484_5
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191115", "story_v_out_420191.awb") ~= 0 then
					local var_484_8 = manager.audio:GetVoiceLength("story_v_out_420191", "420191115", "story_v_out_420191.awb") / 1000

					if var_484_8 + var_484_2 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_8 + var_484_2
					end

					if var_484_4.prefab_name ~= "" and arg_481_1.actors_[var_484_4.prefab_name] ~= nil then
						local var_484_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_4.prefab_name].transform, "story_v_out_420191", "420191115", "story_v_out_420191.awb")

						arg_481_1:RecordAudio("420191115", var_484_9)
						arg_481_1:RecordAudio("420191115", var_484_9)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_420191", "420191115", "story_v_out_420191.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_420191", "420191115", "story_v_out_420191.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_10 = math.max(var_484_3, arg_481_1.talkMaxDuration)

			if var_484_2 <= arg_481_1.time_ and arg_481_1.time_ < var_484_2 + var_484_10 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_2) / var_484_10

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_2 + var_484_10 and arg_481_1.time_ < var_484_2 + var_484_10 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play420191116 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 420191116
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play420191117(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos404001ui_story = arg_485_1.actors_["404001ui_story"].transform.localPosition
			end

			local var_488_0 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 then
				arg_485_1.actors_["404001ui_story"].transform.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos404001ui_story, Vector3.New(0, 100, 0), (arg_485_1.time_ - 0) / var_488_0)
				arg_485_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["404001ui_story"].transform.position).z)
				arg_485_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["404001ui_story"].transform.localEulerAngles = arg_485_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 then
				arg_485_1.actors_["404001ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_485_1.actors_["404001ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["404001ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["404001ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["404001ui_story"].transform.position).z)
				arg_485_1.actors_["404001ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["404001ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["404001ui_story"].transform.localEulerAngles = arg_485_1.actors_["404001ui_story"].transform.localEulerAngles
			end

			if 0.05 < arg_485_1.time_ and arg_485_1.time_ <= 0.05 + arg_488_0 then
				arg_485_1:AudioAction("play", "effect", "se_story_side_1075", "se_story_side_1075_footstep_quiet", "")
			end

			local var_488_2 = 0
			local var_488_3 = 1.15

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_4 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(420191116).content)

				arg_485_1.text_.text = var_488_4

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_6 = 46 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_4) / 46)

				if (46 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_4) / 46)) > 0 and var_488_3 < var_488_6 then
					arg_485_1.talkMaxDuration = var_488_6

					if var_488_6 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_6 + var_488_2
					end
				end

				arg_485_1.text_.text = var_488_4
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_7 = math.max(var_488_3, arg_485_1.talkMaxDuration)

			if var_488_2 <= arg_485_1.time_ and arg_485_1.time_ < var_488_2 + var_488_7 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_2) / var_488_7

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_2 + var_488_7 and arg_485_1.time_ < var_488_2 + var_488_7 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
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

		arg_485_1:InitPlayNodeList()
	end,
	Play420191117 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 420191117
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play420191118(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0.9 < arg_489_1.time_ and arg_489_1.time_ <= 0.9 + arg_492_0 then
				arg_489_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_dooropen", "")
			end

			local var_492_1 = 0
			local var_492_2 = 0.55

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_3 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(420191117).content)

				arg_489_1.text_.text = var_492_3

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 22 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 22)

				if (22 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 22)) > 0 and var_492_2 < var_492_5 then
					arg_489_1.talkMaxDuration = var_492_5

					if var_492_5 + var_492_1 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + var_492_1
					end
				end

				arg_489_1.text_.text = var_492_3
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_6 = math.max(var_492_2, arg_489_1.talkMaxDuration)

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_6 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_1) / var_492_6

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_1 + var_492_6 and arg_489_1.time_ < var_492_1 + var_492_6 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play420191118 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 420191118
		arg_493_1.duration_ = 9

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play420191119(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 4 < arg_493_1.time_ and arg_493_1.time_ <= 4 + arg_496_0 then
				arg_493_1.allBtn_.enabled = false
			end

			if arg_493_1.time_ >= 4 + 0.633333333333333 and arg_493_1.time_ < 4 + 0.633333333333333 + arg_496_0 then
				arg_493_1.allBtn_.enabled = true
			end

			local var_496_0 = 0

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_0 + arg_496_0 then
				arg_493_1.mask_.enabled = true
				arg_493_1.mask_.raycastTarget = true

				arg_493_1:SetGaussion(false)
			end

			local var_496_1 = 2

			if var_496_0 <= arg_493_1.time_ and arg_493_1.time_ < var_496_0 + var_496_1 then
				local var_496_2 = Color.New(0, 0, 0)

				var_496_2.a = Mathf.Lerp(0, 1, (arg_493_1.time_ - var_496_0) / var_496_1)
				arg_493_1.mask_.color = var_496_2
			end

			if arg_493_1.time_ >= var_496_0 + var_496_1 and arg_493_1.time_ < var_496_0 + var_496_1 + arg_496_0 then
				local var_496_3 = Color.New(0, 0, 0)

				var_496_3.a = 1
				arg_493_1.mask_.color = var_496_3
			end

			local var_496_4 = 2

			if 2 < arg_493_1.time_ and arg_493_1.time_ <= var_496_4 + arg_496_0 then
				arg_493_1.mask_.enabled = true
				arg_493_1.mask_.raycastTarget = true

				arg_493_1:SetGaussion(false)
			end

			local var_496_5 = 2

			if var_496_4 <= arg_493_1.time_ and arg_493_1.time_ < var_496_4 + var_496_5 then
				local var_496_6 = Color.New(0, 0, 0)

				var_496_6.a = Mathf.Lerp(1, 0, (arg_493_1.time_ - var_496_4) / var_496_5)
				arg_493_1.mask_.color = var_496_6
			end

			if arg_493_1.time_ >= var_496_4 + var_496_5 and arg_493_1.time_ < var_496_4 + var_496_5 + arg_496_0 then
				local var_496_7 = Color.New(0, 0, 0)

				arg_493_1.mask_.enabled = false
				var_496_7.a = 0
				arg_493_1.mask_.color = var_496_7
			end

			if 1.83333333333333 < arg_493_1.time_ and arg_493_1.time_ <= 1.83333333333333 + arg_496_0 then
				arg_493_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_room02", "")
			end

			if 2 < arg_493_1.time_ and arg_493_1.time_ <= 2 + arg_496_0 then
				arg_493_1:AudioAction("play", "music", "bgm_activity_4_0_story_ui", "vocal", "bgm_activity_4_0_story_ui.awb")

				local var_496_11 = manager.audio:GetAudioName("bgm_activity_4_0_story_ui", "vocal")

				if "" ~= "" then
					if arg_493_1.bgmTxt_.text ~= var_496_11 and arg_493_1.bgmTxt_.text ~= "" then
						if arg_493_1.bgmTxt2_.text ~= "" then
							arg_493_1.bgmTxt_.text = arg_493_1.bgmTxt2_.text
						end

						arg_493_1.bgmTxt2_.text = var_496_11

						arg_493_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_493_1.bgmTxt_.text = var_496_11
						arg_493_1.bgmTxt2_.text = var_496_11
					end

					if arg_493_1.bgmTimer then
						arg_493_1.bgmTimer:Stop()

						arg_493_1.bgmTimer = nil
					end

					if arg_493_1.settingData.show_music_name == 1 then
						arg_493_1.musicController:SetSelectedState("show")
						arg_493_1.musicAnimator_:Play("open", 0, 0)

						if arg_493_1.settingData.music_time ~= 0 then
							arg_493_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_493_1.settingData.music_time), function()
								if arg_493_1 == nil or isNil(arg_493_1.bgmTxt_) then
									return
								end

								arg_493_1.musicController:SetSelectedState("hide")
								arg_493_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_496_12 = "SS2004"

			if arg_493_1.bgs_.SS2004 == nil then
				local var_496_13 = Object.Instantiate(arg_493_1.paintGo_)

				var_496_13:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_496_12)
				var_496_13.name = var_496_12
				var_496_13.transform.parent = arg_493_1.stage_.transform
				var_496_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_493_1.bgs_[var_496_12] = var_496_13
			end

			local var_496_14 = arg_493_1.bgs_.SS2004.transform

			if 2 < arg_493_1.time_ and arg_493_1.time_ <= 2 + arg_496_0 then
				arg_493_1.var_.moveOldPosSS2004 = var_496_14.localPosition
			end

			local var_496_15 = 0.001

			if 2 <= arg_493_1.time_ and arg_493_1.time_ < 2 + var_496_15 then
				var_496_14.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPosSS2004, Vector3.New(0, 1, 10), (arg_493_1.time_ - 2) / var_496_15)
			end

			if arg_493_1.time_ >= 2 + var_496_15 and arg_493_1.time_ < 2 + var_496_15 + arg_496_0 then
				var_496_14.localPosition = Vector3.New(0, 1, 10)
			end

			local var_496_16 = arg_493_1.bgs_.SS2004.transform

			if 2.03333333333333 < arg_493_1.time_ and arg_493_1.time_ <= 2.03333333333333 + arg_496_0 then
				arg_493_1.var_.moveOldPosSS2004 = var_496_16.localPosition
			end

			local var_496_17 = 3.3

			if 2.03333333333333 <= arg_493_1.time_ and arg_493_1.time_ < 2.03333333333333 + var_496_17 then
				var_496_16.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPosSS2004, Vector3.New(0.5, 1, 9), (arg_493_1.time_ - 2.03333333333333) / var_496_17)
			end

			if arg_493_1.time_ >= 2.03333333333333 + var_496_17 and arg_493_1.time_ < 2.03333333333333 + var_496_17 + arg_496_0 then
				var_496_16.localPosition = Vector3.New(0.5, 1, 9)
			end

			if arg_493_1.frameCnt_ <= 1 then
				arg_493_1.dialog_:SetActive(false)
			end

			local var_496_18 = 4
			local var_496_19 = 1.225

			if 4 < arg_493_1.time_ and arg_493_1.time_ <= var_496_18 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0

				arg_493_1.dialog_:SetActive(true)

				arg_493_1.dialogCg_.alpha = 0

				local var_496_20 = LeanTween.value(arg_493_1.dialog_, 0, 1, 0.3)

				var_496_20:setOnUpdate(LuaHelper.FloatAction(function(arg_498_0)
					arg_493_1.dialogCg_.alpha = arg_498_0
				end))
				var_496_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_493_1.dialog_)
					var_496_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_493_1.duration_ = arg_493_1.duration_ + 0.3

				SetActive(arg_493_1.leftNameGo_, false)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_21 = arg_493_1:FormatText(arg_493_1:GetWordFromCfg(420191118).content)

				arg_493_1.text_.text = var_496_21

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_23 = 49 <= 0 and var_496_19 or var_496_19 * (utf8.len(var_496_21) / 49)

				if (49 <= 0 and var_496_19 or var_496_19 * (utf8.len(var_496_21) / 49)) > 0 and var_496_19 < var_496_23 then
					arg_493_1.talkMaxDuration = var_496_23
					var_496_18 = var_496_18 + 0.3

					if var_496_23 + var_496_18 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_23 + var_496_18
					end
				end

				arg_493_1.text_.text = var_496_21
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)
				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_24 = var_496_18 + 0.3
			local var_496_25 = math.max(var_496_19, arg_493_1.talkMaxDuration)

			if var_496_18 + 0.3 <= arg_493_1.time_ and arg_493_1.time_ < var_496_24 + var_496_25 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_24) / var_496_25

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_24 + var_496_25 and arg_493_1.time_ < var_496_24 + var_496_25 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2004",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2004",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.3,
				className = "StoryMoveNode",
				startTime = 2.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play420191119 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 420191119
		arg_500_1.duration_ = 5

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play420191120(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			local var_503_0 = 1.25

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, false)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_1 = arg_500_1:FormatText(arg_500_1:GetWordFromCfg(420191119).content)

				arg_500_1.text_.text = var_503_1

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_3 = 50 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 50)

				if (50 <= 0 and var_503_0 or var_503_0 * (utf8.len(var_503_1) / 50)) > 0 and var_503_0 < var_503_3 then
					arg_500_1.talkMaxDuration = var_503_3

					if var_503_3 + 0 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_3 + 0
					end
				end

				arg_500_1.text_.text = var_503_1
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)
				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_4 = math.max(var_503_0, arg_500_1.talkMaxDuration)

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_4 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - 0) / var_503_4

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= 0 + var_503_4 and arg_500_1.time_ < 0 + var_503_4 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {}

		arg_500_1:InitPlayNodeList()
	end,
	Play420191120 = function(arg_504_0, arg_504_1)
		arg_504_1.time_ = 0
		arg_504_1.frameCnt_ = 0
		arg_504_1.state_ = "playing"
		arg_504_1.curTalkId_ = 420191120
		arg_504_1.duration_ = 5

		SetActive(arg_504_1.tipsGo_, false)

		function arg_504_1.onSingleLineFinish_()
			arg_504_1.onSingleLineUpdate_ = nil
			arg_504_1.onSingleLineFinish_ = nil
			arg_504_1.state_ = "waiting"
		end

		function arg_504_1.playNext_(arg_506_0)
			if arg_506_0 == 1 then
				arg_504_0:Play420191121(arg_504_1)
			end
		end

		function arg_504_1.onSingleLineUpdate_(arg_507_0)
			local var_507_0 = 0.775

			if 0 < arg_504_1.time_ and arg_504_1.time_ <= 0 + arg_507_0 then
				arg_504_1.talkMaxDuration = 0
				arg_504_1.dialogCg_.alpha = 1

				arg_504_1.dialog_:SetActive(true)
				SetActive(arg_504_1.leftNameGo_, false)

				arg_504_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_504_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_504_1:RecordName(arg_504_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_504_1.iconTrs_.gameObject, false)
				arg_504_1.callingController_:SetSelectedState("normal")

				local var_507_1 = arg_504_1:FormatText(arg_504_1:GetWordFromCfg(420191120).content)

				arg_504_1.text_.text = var_507_1

				LuaForUtil.ClearLinePrefixSymbol(arg_504_1.text_)

				local var_507_3 = 31 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_1) / 31)

				if (31 <= 0 and var_507_0 or var_507_0 * (utf8.len(var_507_1) / 31)) > 0 and var_507_0 < var_507_3 then
					arg_504_1.talkMaxDuration = var_507_3

					if var_507_3 + 0 > arg_504_1.duration_ then
						arg_504_1.duration_ = var_507_3 + 0
					end
				end

				arg_504_1.text_.text = var_507_1
				arg_504_1.typewritter.percent = 0

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(false)
				arg_504_1:RecordContent(arg_504_1.text_.text)
			end

			local var_507_4 = math.max(var_507_0, arg_504_1.talkMaxDuration)

			if 0 <= arg_504_1.time_ and arg_504_1.time_ < 0 + var_507_4 then
				arg_504_1.typewritter.percent = (arg_504_1.time_ - 0) / var_507_4

				arg_504_1.typewritter:SetDirty()
			end

			if arg_504_1.time_ >= 0 + var_507_4 and arg_504_1.time_ < 0 + var_507_4 + arg_507_0 then
				arg_504_1.typewritter.percent = 1

				arg_504_1.typewritter:SetDirty()
				arg_504_1:ShowNextGo(true)
			end
		end

		arg_504_1.nodeConfigList_ = {}

		arg_504_1:InitPlayNodeList()
	end,
	Play420191121 = function(arg_508_0, arg_508_1)
		arg_508_1.time_ = 0
		arg_508_1.frameCnt_ = 0
		arg_508_1.state_ = "playing"
		arg_508_1.curTalkId_ = 420191121
		arg_508_1.duration_ = 3.6

		local var_508_0 = {
			zh = 3.6,
			ja = 3.466
		}
		local var_508_1 = manager.audio:GetLocalizationFlag()

		if var_508_0[var_508_1] ~= nil then
			arg_508_1.duration_ = var_508_0[var_508_1]
		end

		SetActive(arg_508_1.tipsGo_, false)

		function arg_508_1.onSingleLineFinish_()
			arg_508_1.onSingleLineUpdate_ = nil
			arg_508_1.onSingleLineFinish_ = nil
			arg_508_1.state_ = "waiting"
		end

		function arg_508_1.playNext_(arg_510_0)
			if arg_510_0 == 1 then
				arg_508_0:Play420191122(arg_508_1)
			end
		end

		function arg_508_1.onSingleLineUpdate_(arg_511_0)
			if 0 < arg_508_1.time_ and arg_508_1.time_ <= 0 + arg_511_0 then
				arg_508_1.var_.moveOldPosSS2004 = arg_508_1.bgs_.SS2004.transform.localPosition
			end

			local var_511_0 = 0.125

			if 0 <= arg_508_1.time_ and arg_508_1.time_ < 0 + var_511_0 then
				arg_508_1.bgs_.SS2004.transform.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPosSS2004, Vector3.New(0.5, 1, 9), (arg_508_1.time_ - 0) / var_511_0)
			end

			if arg_508_1.time_ >= 0 + var_511_0 and arg_508_1.time_ < 0 + var_511_0 + arg_511_0 then
				arg_508_1.bgs_.SS2004.transform.localPosition = Vector3.New(0.5, 1, 9)
			end

			local var_511_1 = arg_508_1.bgs_.SS2004.transform

			if 0.125 < arg_508_1.time_ and arg_508_1.time_ <= 0.125 + arg_511_0 then
				arg_508_1.var_.moveOldPosSS2004 = var_511_1.localPosition
			end

			local var_511_2 = 1.875

			if 0.125 <= arg_508_1.time_ and arg_508_1.time_ < 0.125 + var_511_2 then
				var_511_1.localPosition = Vector3.Lerp(arg_508_1.var_.moveOldPosSS2004, Vector3.New(0.6, 0.8, 8.5), (arg_508_1.time_ - 0.125) / var_511_2)
			end

			if arg_508_1.time_ >= 0.125 + var_511_2 and arg_508_1.time_ < 0.125 + var_511_2 + arg_511_0 then
				var_511_1.localPosition = Vector3.New(0.6, 0.8, 8.5)
			end

			if arg_508_1.frameCnt_ <= 1 then
				arg_508_1.dialog_:SetActive(false)
			end

			local var_511_3 = 2
			local var_511_4 = 0.125

			if 2 < arg_508_1.time_ and arg_508_1.time_ <= var_511_3 + arg_511_0 then
				arg_508_1.talkMaxDuration = 0

				arg_508_1.dialog_:SetActive(true)

				arg_508_1.dialogCg_.alpha = 0

				local var_511_5 = LeanTween.value(arg_508_1.dialog_, 0, 1, 0.3)

				var_511_5:setOnUpdate(LuaHelper.FloatAction(function(arg_512_0)
					arg_508_1.dialogCg_.alpha = arg_512_0
				end))
				var_511_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_508_1.dialog_)
					var_511_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_508_1.duration_ = arg_508_1.duration_ + 0.3

				SetActive(arg_508_1.leftNameGo_, true)

				arg_508_1.leftNameTxt_.text = arg_508_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_508_1.leftNameTxt_.transform)

				arg_508_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_508_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_508_1:RecordName(arg_508_1.leftNameTxt_.text)
				SetActive(arg_508_1.iconTrs_.gameObject, false)
				arg_508_1.callingController_:SetSelectedState("normal")

				local var_511_6 = arg_508_1:GetWordFromCfg(420191121)
				local var_511_7 = arg_508_1:FormatText(var_511_6.content)

				arg_508_1.text_.text = var_511_7

				LuaForUtil.ClearLinePrefixSymbol(arg_508_1.text_)

				local var_511_9 = 5 <= 0 and var_511_4 or var_511_4 * (utf8.len(var_511_7) / 5)

				if (5 <= 0 and var_511_4 or var_511_4 * (utf8.len(var_511_7) / 5)) > 0 and var_511_4 < var_511_9 then
					arg_508_1.talkMaxDuration = var_511_9
					var_511_3 = var_511_3 + 0.3

					if var_511_9 + var_511_3 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_9 + var_511_3
					end
				end

				arg_508_1.text_.text = var_511_7
				arg_508_1.typewritter.percent = 0

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191121", "story_v_out_420191.awb") ~= 0 then
					local var_511_10 = manager.audio:GetVoiceLength("story_v_out_420191", "420191121", "story_v_out_420191.awb") / 1000

					if var_511_10 + var_511_3 > arg_508_1.duration_ then
						arg_508_1.duration_ = var_511_10 + var_511_3
					end

					if var_511_6.prefab_name ~= "" and arg_508_1.actors_[var_511_6.prefab_name] ~= nil then
						local var_511_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_508_1.actors_[var_511_6.prefab_name].transform, "story_v_out_420191", "420191121", "story_v_out_420191.awb")

						arg_508_1:RecordAudio("420191121", var_511_11)
						arg_508_1:RecordAudio("420191121", var_511_11)
					else
						arg_508_1:AudioAction("play", "voice", "story_v_out_420191", "420191121", "story_v_out_420191.awb")
					end

					arg_508_1:RecordHistoryTalkVoice("story_v_out_420191", "420191121", "story_v_out_420191.awb")
				end

				arg_508_1:RecordContent(arg_508_1.text_.text)
			end

			local var_511_12 = var_511_3 + 0.3
			local var_511_13 = math.max(var_511_4, arg_508_1.talkMaxDuration)

			if var_511_3 + 0.3 <= arg_508_1.time_ and arg_508_1.time_ < var_511_12 + var_511_13 then
				arg_508_1.typewritter.percent = (arg_508_1.time_ - var_511_12) / var_511_13

				arg_508_1.typewritter:SetDirty()
			end

			if arg_508_1.time_ >= var_511_12 + var_511_13 and arg_508_1.time_ < var_511_12 + var_511_13 + arg_511_0 then
				arg_508_1.typewritter.percent = 1

				arg_508_1.typewritter:SetDirty()
				arg_508_1:ShowNextGo(true)
			end
		end

		arg_508_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2004",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.125,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2004",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.875,
				className = "StoryMoveNode",
				startTime = 0.125,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_508_1:InitPlayNodeList()
	end,
	Play420191122 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 420191122
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play420191123(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = 0.075

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, true)
				arg_514_1.iconController_:SetSelectedState("hero")

				arg_514_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_514_1.callingController_:SetSelectedState("normal")

				arg_514_1.keyicon_.color = Color.New(1, 1, 1)
				arg_514_1.icon_.color = Color.New(1, 1, 1)

				local var_517_1 = arg_514_1:FormatText(arg_514_1:GetWordFromCfg(420191122).content)

				arg_514_1.text_.text = var_517_1

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_3 = 3 <= 0 and var_517_0 or var_517_0 * (utf8.len(var_517_1) / 3)

				if (3 <= 0 and var_517_0 or var_517_0 * (utf8.len(var_517_1) / 3)) > 0 and var_517_0 < var_517_3 then
					arg_514_1.talkMaxDuration = var_517_3

					if var_517_3 + 0 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_3 + 0
					end
				end

				arg_514_1.text_.text = var_517_1
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_4 = math.max(var_517_0, arg_514_1.talkMaxDuration)

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_4 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - 0) / var_517_4

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= 0 + var_517_4 and arg_514_1.time_ < 0 + var_517_4 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play420191123 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 420191123
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play420191124(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0.233333333332 < arg_518_1.time_ and arg_518_1.time_ <= 0.233333333332 + arg_521_0 then
				arg_518_1:AudioAction("play", "effect", "se_story_140", "se_story_140_curtain01", "")
			end

			local var_521_1 = 0
			local var_521_2 = 0.85

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, false)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_3 = arg_518_1:FormatText(arg_518_1:GetWordFromCfg(420191123).content)

				arg_518_1.text_.text = var_521_3

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_5 = 34 <= 0 and var_521_2 or var_521_2 * (utf8.len(var_521_3) / 34)

				if (34 <= 0 and var_521_2 or var_521_2 * (utf8.len(var_521_3) / 34)) > 0 and var_521_2 < var_521_5 then
					arg_518_1.talkMaxDuration = var_521_5

					if var_521_5 + var_521_1 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_5 + var_521_1
					end
				end

				arg_518_1.text_.text = var_521_3
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_6 = math.max(var_521_2, arg_518_1.talkMaxDuration)

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_6 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_1) / var_521_6

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_1 + var_521_6 and arg_518_1.time_ < var_521_1 + var_521_6 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play420191124 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 420191124
		arg_522_1.duration_ = 5

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play420191125(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				local var_525_0 = arg_522_1.var_.effect11118

				if not arg_522_1.var_.effect11118 then
					var_525_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_guangban"), manager.ui.mainCamera.transform)
					var_525_0.name = "11118"
					arg_522_1.var_.effect11118 = var_525_0
				else
					var_525_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_525_0.transform.localPosition = Vector3.New(1.57, 0.49, -0.66)
				var_525_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_525_2 = 0
			local var_525_3 = 1.05

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_2 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, false)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_4 = arg_522_1:FormatText(arg_522_1:GetWordFromCfg(420191124).content)

				arg_522_1.text_.text = var_525_4

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_6 = 42 <= 0 and var_525_3 or var_525_3 * (utf8.len(var_525_4) / 42)

				if (42 <= 0 and var_525_3 or var_525_3 * (utf8.len(var_525_4) / 42)) > 0 and var_525_3 < var_525_6 then
					arg_522_1.talkMaxDuration = var_525_6

					if var_525_6 + var_525_2 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_6 + var_525_2
					end
				end

				arg_522_1.text_.text = var_525_4
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)
				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_7 = math.max(var_525_3, arg_522_1.talkMaxDuration)

			if var_525_2 <= arg_522_1.time_ and arg_522_1.time_ < var_525_2 + var_525_7 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_2) / var_525_7

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_2 + var_525_7 and arg_522_1.time_ < var_525_2 + var_525_7 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play420191125 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 420191125
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play420191126(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = 1.1

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, false)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_1 = arg_526_1:FormatText(arg_526_1:GetWordFromCfg(420191125).content)

				arg_526_1.text_.text = var_529_1

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_3 = 44 <= 0 and var_529_0 or var_529_0 * (utf8.len(var_529_1) / 44)

				if (44 <= 0 and var_529_0 or var_529_0 * (utf8.len(var_529_1) / 44)) > 0 and var_529_0 < var_529_3 then
					arg_526_1.talkMaxDuration = var_529_3

					if var_529_3 + 0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_3 + 0
					end
				end

				arg_526_1.text_.text = var_529_1
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_4 = math.max(var_529_0, arg_526_1.talkMaxDuration)

			if 0 <= arg_526_1.time_ and arg_526_1.time_ < 0 + var_529_4 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - 0) / var_529_4

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= 0 + var_529_4 and arg_526_1.time_ < 0 + var_529_4 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play420191126 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 420191126
		arg_530_1.duration_ = 5

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play420191127(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = 0.825

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, false)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_1 = arg_530_1:FormatText(arg_530_1:GetWordFromCfg(420191126).content)

				arg_530_1.text_.text = var_533_1

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_3 = 33 <= 0 and var_533_0 or var_533_0 * (utf8.len(var_533_1) / 33)

				if (33 <= 0 and var_533_0 or var_533_0 * (utf8.len(var_533_1) / 33)) > 0 and var_533_0 < var_533_3 then
					arg_530_1.talkMaxDuration = var_533_3

					if var_533_3 + 0 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_3 + 0
					end
				end

				arg_530_1.text_.text = var_533_1
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_4 = math.max(var_533_0, arg_530_1.talkMaxDuration)

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_4 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - 0) / var_533_4

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= 0 + var_533_4 and arg_530_1.time_ < 0 + var_533_4 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play420191127 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 420191127
		arg_534_1.duration_ = 1

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"

			SetActive(arg_534_1.choicesGo_, true)

			for iter_535_0, iter_535_1 in ipairs(arg_534_1.choices_) do
				SetActive(iter_535_1.go, iter_535_0 <= 1)
			end

			arg_534_1.choices_[1].txt.text = arg_534_1:FormatText(StoryChoiceCfg[1245].name)
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play420191128(arg_534_1)
			end

			arg_534_1:RecordChoiceLog(420191127, 1245)
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			return
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play420191128 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 420191128
		arg_538_1.duration_ = 4.67

		local var_538_0 = {
			zh = 4.199999999999,
			ja = 4.666
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play420191129(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1.mask_.enabled = true
				arg_538_1.mask_.raycastTarget = true

				arg_538_1:SetGaussion(false)
			end

			local var_541_0 = 1

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_0 then
				local var_541_1 = Color.New(1, 1, 1)

				var_541_1.a = Mathf.Lerp(1, 0, (arg_538_1.time_ - 0) / var_541_0)
				arg_538_1.mask_.color = var_541_1
			end

			if arg_538_1.time_ >= 0 + var_541_0 and arg_538_1.time_ < 0 + var_541_0 + arg_541_0 then
				local var_541_2 = Color.New(1, 1, 1)

				arg_538_1.mask_.enabled = false
				var_541_2.a = 0
				arg_538_1.mask_.color = var_541_2
			end

			local var_541_3 = "SS2004a"

			if arg_538_1.bgs_.SS2004a == nil then
				local var_541_4 = Object.Instantiate(arg_538_1.paintGo_)

				var_541_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_541_3)
				var_541_4.name = var_541_3
				var_541_4.transform.parent = arg_538_1.stage_.transform
				var_541_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_538_1.bgs_[var_541_3] = var_541_4
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				local var_541_5 = arg_538_1.bgs_.SS2004a

				arg_538_1.bgs_.SS2004a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_541_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_541_6 = var_541_5:GetComponent("SpriteRenderer")

				if var_541_6 and var_541_6.sprite then
					local var_541_7 = 2 * (var_541_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_541_5.transform.localScale = Vector3.New(var_541_7 / var_541_6.sprite.bounds.size.y < var_541_7 * manager.ui.mainCameraCom_.aspect / var_541_6.sprite.bounds.size.x and var_541_7 * manager.ui.mainCameraCom_.aspect / var_541_6.sprite.bounds.size.x or var_541_7 / var_541_6.sprite.bounds.size.y, var_541_7 / var_541_6.sprite.bounds.size.y < var_541_7 * manager.ui.mainCameraCom_.aspect / var_541_6.sprite.bounds.size.x and var_541_7 * manager.ui.mainCameraCom_.aspect / var_541_6.sprite.bounds.size.x or var_541_7 / var_541_6.sprite.bounds.size.y, 0)
				end

				for iter_541_0, iter_541_1 in pairs(arg_538_1.bgs_) do
					if iter_541_0 ~= "SS2004a" then
						iter_541_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_538_1.frameCnt_ <= 1 then
				arg_538_1.dialog_:SetActive(false)
			end

			local var_541_8 = 1
			local var_541_9 = 0.2

			if 1 < arg_538_1.time_ and arg_538_1.time_ <= var_541_8 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0

				arg_538_1.dialog_:SetActive(true)

				arg_538_1.dialogCg_.alpha = 0

				local var_541_10 = LeanTween.value(arg_538_1.dialog_, 0, 1, 0.3)

				var_541_10:setOnUpdate(LuaHelper.FloatAction(function(arg_542_0)
					arg_538_1.dialogCg_.alpha = arg_542_0
				end))
				var_541_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_538_1.dialog_)
					var_541_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_538_1.duration_ = arg_538_1.duration_ + 0.3

				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_11 = arg_538_1:GetWordFromCfg(420191128)
				local var_541_12 = arg_538_1:FormatText(var_541_11.content)

				arg_538_1.text_.text = var_541_12

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_14 = 8 <= 0 and var_541_9 or var_541_9 * (utf8.len(var_541_12) / 8)

				if (8 <= 0 and var_541_9 or var_541_9 * (utf8.len(var_541_12) / 8)) > 0 and var_541_9 < var_541_14 then
					arg_538_1.talkMaxDuration = var_541_14
					var_541_8 = var_541_8 + 0.3

					if var_541_14 + var_541_8 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_14 + var_541_8
					end
				end

				arg_538_1.text_.text = var_541_12
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_420191", "420191128", "story_v_out_420191.awb") ~= 0 then
					local var_541_15 = manager.audio:GetVoiceLength("story_v_out_420191", "420191128", "story_v_out_420191.awb") / 1000

					if var_541_15 + var_541_8 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_15 + var_541_8
					end

					if var_541_11.prefab_name ~= "" and arg_538_1.actors_[var_541_11.prefab_name] ~= nil then
						local var_541_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_11.prefab_name].transform, "story_v_out_420191", "420191128", "story_v_out_420191.awb")

						arg_538_1:RecordAudio("420191128", var_541_16)
						arg_538_1:RecordAudio("420191128", var_541_16)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_out_420191", "420191128", "story_v_out_420191.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_out_420191", "420191128", "story_v_out_420191.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_17 = var_541_8 + 0.3
			local var_541_18 = math.max(var_541_9, arg_538_1.talkMaxDuration)

			if var_541_8 + 0.3 <= arg_538_1.time_ and arg_538_1.time_ < var_541_17 + var_541_18 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_17) / var_541_18

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_17 + var_541_18 and arg_538_1.time_ < var_541_17 + var_541_18 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play420191129 = function(arg_544_0, arg_544_1)
		arg_544_1.time_ = 0
		arg_544_1.frameCnt_ = 0
		arg_544_1.state_ = "playing"
		arg_544_1.curTalkId_ = 420191129
		arg_544_1.duration_ = 5

		SetActive(arg_544_1.tipsGo_, false)

		function arg_544_1.onSingleLineFinish_()
			arg_544_1.onSingleLineUpdate_ = nil
			arg_544_1.onSingleLineFinish_ = nil
			arg_544_1.state_ = "waiting"
		end

		function arg_544_1.playNext_(arg_546_0)
			if arg_546_0 == 1 then
				arg_544_0:Play420191130(arg_544_1)
			end
		end

		function arg_544_1.onSingleLineUpdate_(arg_547_0)
			if 0 < arg_544_1.time_ and arg_544_1.time_ <= 0 + arg_547_0 and not isNil(arg_544_1.actors_["1085ui_story"]) and arg_544_1.var_.characterEffect1085ui_story == nil then
				arg_544_1.var_.characterEffect1085ui_story = arg_544_1.actors_["1085ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_547_0 = 0.200000002980232

			if 0 <= arg_544_1.time_ and arg_544_1.time_ < 0 + var_547_0 and not isNil(arg_544_1.actors_["1085ui_story"]) then
				if arg_544_1.var_.characterEffect1085ui_story and not isNil(arg_544_1.actors_["1085ui_story"]) then
					arg_544_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_544_1.var_.characterEffect1085ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_544_1.time_ - 0) / var_547_0)
				end
			end

			if arg_544_1.time_ >= 0 + var_547_0 and arg_544_1.time_ < 0 + var_547_0 + arg_547_0 and not isNil(arg_544_1.actors_["1085ui_story"]) and arg_544_1.var_.characterEffect1085ui_story then
				arg_544_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_544_1.var_.characterEffect1085ui_story.fillRatio = 0.5
			end

			if 0.200000002980232 < arg_544_1.time_ and arg_544_1.time_ <= 0.200000002980232 + arg_547_0 then
				arg_544_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_glass", "")
			end

			local var_547_2 = 0
			local var_547_3 = 0.925

			if 0 < arg_544_1.time_ and arg_544_1.time_ <= var_547_2 + arg_547_0 then
				arg_544_1.talkMaxDuration = 0
				arg_544_1.dialogCg_.alpha = 1

				arg_544_1.dialog_:SetActive(true)
				SetActive(arg_544_1.leftNameGo_, false)

				arg_544_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_544_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_544_1:RecordName(arg_544_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_544_1.iconTrs_.gameObject, false)
				arg_544_1.callingController_:SetSelectedState("normal")

				local var_547_4 = arg_544_1:FormatText(arg_544_1:GetWordFromCfg(420191129).content)

				arg_544_1.text_.text = var_547_4

				LuaForUtil.ClearLinePrefixSymbol(arg_544_1.text_)

				local var_547_6 = 37 <= 0 and var_547_3 or var_547_3 * (utf8.len(var_547_4) / 37)

				if (37 <= 0 and var_547_3 or var_547_3 * (utf8.len(var_547_4) / 37)) > 0 and var_547_3 < var_547_6 then
					arg_544_1.talkMaxDuration = var_547_6

					if var_547_6 + var_547_2 > arg_544_1.duration_ then
						arg_544_1.duration_ = var_547_6 + var_547_2
					end
				end

				arg_544_1.text_.text = var_547_4
				arg_544_1.typewritter.percent = 0

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(false)
				arg_544_1:RecordContent(arg_544_1.text_.text)
			end

			local var_547_7 = math.max(var_547_3, arg_544_1.talkMaxDuration)

			if var_547_2 <= arg_544_1.time_ and arg_544_1.time_ < var_547_2 + var_547_7 then
				arg_544_1.typewritter.percent = (arg_544_1.time_ - var_547_2) / var_547_7

				arg_544_1.typewritter:SetDirty()
			end

			if arg_544_1.time_ >= var_547_2 + var_547_7 and arg_544_1.time_ < var_547_2 + var_547_7 + arg_547_0 then
				arg_544_1.typewritter.percent = 1

				arg_544_1.typewritter:SetDirty()
				arg_544_1:ShowNextGo(true)
			end
		end

		arg_544_1.nodeConfigList_ = {}

		arg_544_1:InitPlayNodeList()
	end,
	Play420191130 = function(arg_548_0, arg_548_1)
		arg_548_1.time_ = 0
		arg_548_1.frameCnt_ = 0
		arg_548_1.state_ = "playing"
		arg_548_1.curTalkId_ = 420191130
		arg_548_1.duration_ = 5

		SetActive(arg_548_1.tipsGo_, false)

		function arg_548_1.onSingleLineFinish_()
			arg_548_1.onSingleLineUpdate_ = nil
			arg_548_1.onSingleLineFinish_ = nil
			arg_548_1.state_ = "waiting"
		end

		function arg_548_1.playNext_(arg_550_0)
			if arg_550_0 == 1 then
				arg_548_0:Play420191131(arg_548_1)
			end
		end

		function arg_548_1.onSingleLineUpdate_(arg_551_0)
			local var_551_0 = 0.925

			if 0 < arg_548_1.time_ and arg_548_1.time_ <= 0 + arg_551_0 then
				arg_548_1.talkMaxDuration = 0
				arg_548_1.dialogCg_.alpha = 1

				arg_548_1.dialog_:SetActive(true)
				SetActive(arg_548_1.leftNameGo_, false)

				arg_548_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_548_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_548_1:RecordName(arg_548_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_548_1.iconTrs_.gameObject, false)
				arg_548_1.callingController_:SetSelectedState("normal")

				local var_551_1 = arg_548_1:FormatText(arg_548_1:GetWordFromCfg(420191130).content)

				arg_548_1.text_.text = var_551_1

				LuaForUtil.ClearLinePrefixSymbol(arg_548_1.text_)

				local var_551_3 = 37 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_1) / 37)

				if (37 <= 0 and var_551_0 or var_551_0 * (utf8.len(var_551_1) / 37)) > 0 and var_551_0 < var_551_3 then
					arg_548_1.talkMaxDuration = var_551_3

					if var_551_3 + 0 > arg_548_1.duration_ then
						arg_548_1.duration_ = var_551_3 + 0
					end
				end

				arg_548_1.text_.text = var_551_1
				arg_548_1.typewritter.percent = 0

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(false)
				arg_548_1:RecordContent(arg_548_1.text_.text)
			end

			local var_551_4 = math.max(var_551_0, arg_548_1.talkMaxDuration)

			if 0 <= arg_548_1.time_ and arg_548_1.time_ < 0 + var_551_4 then
				arg_548_1.typewritter.percent = (arg_548_1.time_ - 0) / var_551_4

				arg_548_1.typewritter:SetDirty()
			end

			if arg_548_1.time_ >= 0 + var_551_4 and arg_548_1.time_ < 0 + var_551_4 + arg_551_0 then
				arg_548_1.typewritter.percent = 1

				arg_548_1.typewritter:SetDirty()
				arg_548_1:ShowNextGo(true)
			end
		end

		arg_548_1.nodeConfigList_ = {}

		arg_548_1:InitPlayNodeList()
	end,
	Play420191131 = function(arg_552_0, arg_552_1)
		arg_552_1.time_ = 0
		arg_552_1.frameCnt_ = 0
		arg_552_1.state_ = "playing"
		arg_552_1.curTalkId_ = 420191131
		arg_552_1.duration_ = 4.15

		SetActive(arg_552_1.tipsGo_, false)

		function arg_552_1.onSingleLineFinish_()
			arg_552_1.onSingleLineUpdate_ = nil
			arg_552_1.onSingleLineFinish_ = nil
			arg_552_1.state_ = "waiting"
		end

		function arg_552_1.playNext_(arg_554_0)
			if arg_554_0 == 1 then
				arg_552_0:Play420191132(arg_552_1)
			end
		end

		function arg_552_1.onSingleLineUpdate_(arg_555_0)
			if 2 < arg_552_1.time_ and arg_552_1.time_ <= 2 + arg_555_0 then
				local var_555_0 = arg_552_1.bgs_.STblack

				arg_552_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_555_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_555_1 = var_555_0:GetComponent("SpriteRenderer")

				if var_555_1 and var_555_1.sprite then
					local var_555_2 = 2 * (var_555_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_555_0.transform.localScale = Vector3.New(var_555_2 / var_555_1.sprite.bounds.size.y < var_555_2 * manager.ui.mainCameraCom_.aspect / var_555_1.sprite.bounds.size.x and var_555_2 * manager.ui.mainCameraCom_.aspect / var_555_1.sprite.bounds.size.x or var_555_2 / var_555_1.sprite.bounds.size.y, var_555_2 / var_555_1.sprite.bounds.size.y < var_555_2 * manager.ui.mainCameraCom_.aspect / var_555_1.sprite.bounds.size.x and var_555_2 * manager.ui.mainCameraCom_.aspect / var_555_1.sprite.bounds.size.x or var_555_2 / var_555_1.sprite.bounds.size.y, 0)
				end

				for iter_555_0, iter_555_1 in pairs(arg_552_1.bgs_) do
					if iter_555_0 ~= "STblack" then
						iter_555_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_555_3 = 0

			if 0 < arg_552_1.time_ and arg_552_1.time_ <= var_555_3 + arg_555_0 then
				arg_552_1.mask_.enabled = true
				arg_552_1.mask_.raycastTarget = true

				arg_552_1:SetGaussion(false)
			end

			local var_555_4 = 2

			if var_555_3 <= arg_552_1.time_ and arg_552_1.time_ < var_555_3 + var_555_4 then
				local var_555_5 = Color.New(0, 0, 0)

				var_555_5.a = Mathf.Lerp(0, 1, (arg_552_1.time_ - var_555_3) / var_555_4)
				arg_552_1.mask_.color = var_555_5
			end

			if arg_552_1.time_ >= var_555_3 + var_555_4 and arg_552_1.time_ < var_555_3 + var_555_4 + arg_555_0 then
				local var_555_6 = Color.New(0, 0, 0)

				var_555_6.a = 1
				arg_552_1.mask_.color = var_555_6
			end

			local var_555_7 = 2

			if 2 < arg_552_1.time_ and arg_552_1.time_ <= var_555_7 + arg_555_0 then
				arg_552_1.mask_.enabled = true
				arg_552_1.mask_.raycastTarget = true

				arg_552_1:SetGaussion(false)
			end

			local var_555_8 = 2

			if var_555_7 <= arg_552_1.time_ and arg_552_1.time_ < var_555_7 + var_555_8 then
				local var_555_9 = Color.New(0, 0, 0)

				var_555_9.a = Mathf.Lerp(1, 0, (arg_552_1.time_ - var_555_7) / var_555_8)
				arg_552_1.mask_.color = var_555_9
			end

			if arg_552_1.time_ >= var_555_7 + var_555_8 and arg_552_1.time_ < var_555_7 + var_555_8 + arg_555_0 then
				local var_555_10 = Color.New(0, 0, 0)

				arg_552_1.mask_.enabled = false
				var_555_10.a = 0
				arg_552_1.mask_.color = var_555_10
			end

			if 2 < arg_552_1.time_ and arg_552_1.time_ <= 2 + arg_555_0 then
				arg_552_1.fswbg_:SetActive(true)
				arg_552_1.dialog_:SetActive(false)

				arg_552_1.fswtw_.percent = 0
				arg_552_1.fswt_.text = arg_552_1:FormatText(arg_552_1:GetWordFromCfg(420191131).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_552_1.fswt_)

				arg_552_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_552_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_552_1.fswtw_:SetDirty()

				arg_552_1.typewritterCharCountI18N = 0

				SetActive(arg_552_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_552_1:ShowNextGo(false)
			end

			local var_555_11 = 3.3

			if 3.3 < arg_552_1.time_ and arg_552_1.time_ <= var_555_11 + arg_555_0 then
				arg_552_1.var_.oldValueTypewriter = arg_552_1.fswtw_.percent

				SetActive(arg_552_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_552_1:ShowNextGo(false)
			end

			local var_555_12 = 6
			local var_555_13 = 0.4
			local var_555_14, var_555_15 = arg_552_1:GetPercentByPara(arg_552_1:FormatText(arg_552_1:GetWordFromCfg(420191131).content), 1)

			if var_555_11 < arg_552_1.time_ and arg_552_1.time_ <= var_555_11 + arg_555_0 then
				arg_552_1.talkMaxDuration = 0

				local var_555_16 = var_555_12 <= 0 and var_555_13 or var_555_13 * ((var_555_15 - arg_552_1.typewritterCharCountI18N) / var_555_12)

				if (var_555_12 <= 0 and var_555_13 or var_555_13 * ((var_555_15 - arg_552_1.typewritterCharCountI18N) / var_555_12)) > 0 and var_555_13 < var_555_16 then
					arg_552_1.talkMaxDuration = var_555_16

					if var_555_16 + var_555_11 > arg_552_1.duration_ then
						arg_552_1.duration_ = var_555_16 + var_555_11
					end
				end
			end

			local var_555_17 = math.max(0.4, arg_552_1.talkMaxDuration)

			if var_555_11 <= arg_552_1.time_ and arg_552_1.time_ < var_555_11 + var_555_17 then
				arg_552_1.fswtw_.percent = Mathf.Lerp(arg_552_1.var_.oldValueTypewriter, var_555_14, (arg_552_1.time_ - var_555_11) / var_555_17)
				arg_552_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_552_1.fswtw_:SetDirty()
			end

			if arg_552_1.time_ >= var_555_11 + var_555_17 and arg_552_1.time_ < var_555_11 + var_555_17 + arg_555_0 then
				arg_552_1.fswtw_.percent = var_555_14

				arg_552_1.fswtw_:SetDirty()
				arg_552_1:ShowNextGo(true)

				arg_552_1.typewritterCharCountI18N = var_555_15
			end

			if 2 < arg_552_1.time_ and arg_552_1.time_ <= 2 + arg_555_0 then
				local var_555_18 = arg_552_1.fswbg_.transform:Find("textbox/adapt/content") or arg_552_1.fswbg_.transform:Find("textbox/content")
				local var_555_19 = arg_552_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_555_20 = var_555_18:GetComponent("RectTransform")

				var_555_18:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_555_20.offsetMin = Vector2.New(0, -70)
				var_555_20.offsetMax = Vector2.New(0, 0)
			end

			if 1.66666666666667 < arg_552_1.time_ and arg_552_1.time_ <= 1.66666666666667 + arg_555_0 then
				if arg_552_1.var_.effect11118 then
					Object.Destroy(arg_552_1.var_.effect11118)

					arg_552_1.var_.effect11118 = nil
				end
			end
		end

		arg_552_1.nodeConfigList_ = {}

		arg_552_1:InitPlayNodeList()
	end,
	Play420191132 = function(arg_556_0, arg_556_1)
		arg_556_1.time_ = 0
		arg_556_1.frameCnt_ = 0
		arg_556_1.state_ = "playing"
		arg_556_1.curTalkId_ = 420191132
		arg_556_1.duration_ = 2.42

		SetActive(arg_556_1.tipsGo_, false)

		function arg_556_1.onSingleLineFinish_()
			arg_556_1.onSingleLineUpdate_ = nil
			arg_556_1.onSingleLineFinish_ = nil
			arg_556_1.state_ = "waiting"
		end

		function arg_556_1.playNext_(arg_558_0)
			if arg_558_0 == 1 then
				arg_556_0:Play420191133(arg_556_1)
			end
		end

		function arg_556_1.onSingleLineUpdate_(arg_559_0)
			if 0 < arg_556_1.time_ and arg_556_1.time_ <= 0 + arg_559_0 then
				arg_556_1.fswbg_:SetActive(true)
				arg_556_1.dialog_:SetActive(false)

				arg_556_1.fswtw_.percent = 0
				arg_556_1.fswt_.text = arg_556_1:FormatText(arg_556_1:GetWordFromCfg(420191132).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_556_1.fswt_)

				arg_556_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_556_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_556_1.fswtw_:SetDirty()

				arg_556_1.typewritterCharCountI18N = 0

				SetActive(arg_556_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_556_1:ShowNextGo(false)
			end

			local var_559_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_556_1.time_ and arg_556_1.time_ <= var_559_0 + arg_559_0 then
				arg_556_1.var_.oldValueTypewriter = arg_556_1.fswtw_.percent

				SetActive(arg_556_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_556_1:ShowNextGo(false)
			end

			local var_559_1 = 36
			local var_559_2 = 2.4
			local var_559_3, var_559_4 = arg_556_1:GetPercentByPara(arg_556_1:FormatText(arg_556_1:GetWordFromCfg(420191132).content), 1)

			if var_559_0 < arg_556_1.time_ and arg_556_1.time_ <= var_559_0 + arg_559_0 then
				arg_556_1.talkMaxDuration = 0

				local var_559_5 = var_559_1 <= 0 and var_559_2 or var_559_2 * ((var_559_4 - arg_556_1.typewritterCharCountI18N) / var_559_1)

				if (var_559_1 <= 0 and var_559_2 or var_559_2 * ((var_559_4 - arg_556_1.typewritterCharCountI18N) / var_559_1)) > 0 and var_559_2 < var_559_5 then
					arg_556_1.talkMaxDuration = var_559_5

					if var_559_5 + var_559_0 > arg_556_1.duration_ then
						arg_556_1.duration_ = var_559_5 + var_559_0
					end
				end
			end

			local var_559_6 = math.max(2.4, arg_556_1.talkMaxDuration)

			if var_559_0 <= arg_556_1.time_ and arg_556_1.time_ < var_559_0 + var_559_6 then
				arg_556_1.fswtw_.percent = Mathf.Lerp(arg_556_1.var_.oldValueTypewriter, var_559_3, (arg_556_1.time_ - var_559_0) / var_559_6)
				arg_556_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_556_1.fswtw_:SetDirty()
			end

			if arg_556_1.time_ >= var_559_0 + var_559_6 and arg_556_1.time_ < var_559_0 + var_559_6 + arg_559_0 then
				arg_556_1.fswtw_.percent = var_559_3

				arg_556_1.fswtw_:SetDirty()
				arg_556_1:ShowNextGo(true)

				arg_556_1.typewritterCharCountI18N = var_559_4
			end
		end

		arg_556_1.nodeConfigList_ = {}

		arg_556_1:InitPlayNodeList()
	end,
	Play420191133 = function(arg_560_0, arg_560_1)
		arg_560_1.time_ = 0
		arg_560_1.frameCnt_ = 0
		arg_560_1.state_ = "playing"
		arg_560_1.curTalkId_ = 420191133
		arg_560_1.duration_ = 3.02

		SetActive(arg_560_1.tipsGo_, false)

		function arg_560_1.onSingleLineFinish_()
			arg_560_1.onSingleLineUpdate_ = nil
			arg_560_1.onSingleLineFinish_ = nil
			arg_560_1.state_ = "waiting"
		end

		function arg_560_1.playNext_(arg_562_0)
			if arg_562_0 == 1 then
				arg_560_0:Play420191134(arg_560_1)
			end
		end

		function arg_560_1.onSingleLineUpdate_(arg_563_0)
			if 0 < arg_560_1.time_ and arg_560_1.time_ <= 0 + arg_563_0 then
				arg_560_1.fswbg_:SetActive(true)
				arg_560_1.dialog_:SetActive(false)

				arg_560_1.fswtw_.percent = 0
				arg_560_1.fswt_.text = arg_560_1:FormatText(arg_560_1:GetWordFromCfg(420191133).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_560_1.fswt_)

				arg_560_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_560_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_560_1.fswtw_:SetDirty()

				arg_560_1.typewritterCharCountI18N = 0

				SetActive(arg_560_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_560_1:ShowNextGo(false)
			end

			local var_563_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_560_1.time_ and arg_560_1.time_ <= var_563_0 + arg_563_0 then
				arg_560_1.var_.oldValueTypewriter = arg_560_1.fswtw_.percent

				SetActive(arg_560_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_560_1:ShowNextGo(false)
			end

			local var_563_1 = 30
			local var_563_2 = 3
			local var_563_3, var_563_4 = arg_560_1:GetPercentByPara(arg_560_1:FormatText(arg_560_1:GetWordFromCfg(420191133).content), 1)

			if var_563_0 < arg_560_1.time_ and arg_560_1.time_ <= var_563_0 + arg_563_0 then
				arg_560_1.talkMaxDuration = 0

				local var_563_5 = var_563_1 <= 0 and var_563_2 or var_563_2 * ((var_563_4 - arg_560_1.typewritterCharCountI18N) / var_563_1)

				if (var_563_1 <= 0 and var_563_2 or var_563_2 * ((var_563_4 - arg_560_1.typewritterCharCountI18N) / var_563_1)) > 0 and var_563_2 < var_563_5 then
					arg_560_1.talkMaxDuration = var_563_5

					if var_563_5 + var_563_0 > arg_560_1.duration_ then
						arg_560_1.duration_ = var_563_5 + var_563_0
					end
				end
			end

			local var_563_6 = math.max(3, arg_560_1.talkMaxDuration)

			if var_563_0 <= arg_560_1.time_ and arg_560_1.time_ < var_563_0 + var_563_6 then
				arg_560_1.fswtw_.percent = Mathf.Lerp(arg_560_1.var_.oldValueTypewriter, var_563_3, (arg_560_1.time_ - var_563_0) / var_563_6)
				arg_560_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_560_1.fswtw_:SetDirty()
			end

			if arg_560_1.time_ >= var_563_0 + var_563_6 and arg_560_1.time_ < var_563_0 + var_563_6 + arg_563_0 then
				arg_560_1.fswtw_.percent = var_563_3

				arg_560_1.fswtw_:SetDirty()
				arg_560_1:ShowNextGo(true)

				arg_560_1.typewritterCharCountI18N = var_563_4
			end
		end

		arg_560_1.nodeConfigList_ = {}

		arg_560_1:InitPlayNodeList()
	end,
	Play420191134 = function(arg_564_0, arg_564_1)
		arg_564_1.time_ = 0
		arg_564_1.frameCnt_ = 0
		arg_564_1.state_ = "playing"
		arg_564_1.curTalkId_ = 420191134
		arg_564_1.duration_ = 4.97

		SetActive(arg_564_1.tipsGo_, false)

		function arg_564_1.onSingleLineFinish_()
			arg_564_1.onSingleLineUpdate_ = nil
			arg_564_1.onSingleLineFinish_ = nil
			arg_564_1.state_ = "waiting"
			arg_564_1.auto_ = false
		end

		function arg_564_1.playNext_(arg_566_0)
			arg_564_1.onStoryFinished_()
		end

		function arg_564_1.onSingleLineUpdate_(arg_567_0)
			if 0 < arg_564_1.time_ and arg_564_1.time_ <= 0 + arg_567_0 then
				arg_564_1.fswbg_:SetActive(true)
				arg_564_1.dialog_:SetActive(false)

				arg_564_1.fswtw_.percent = 0
				arg_564_1.fswt_.text = arg_564_1:FormatText(arg_564_1:GetWordFromCfg(420191134).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_564_1.fswt_)

				arg_564_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_564_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_564_1.fswtw_:SetDirty()

				arg_564_1.typewritterCharCountI18N = 0

				SetActive(arg_564_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_564_1:ShowNextGo(false)
			end

			local var_567_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_564_1.time_ and arg_564_1.time_ <= var_567_0 + arg_567_0 then
				arg_564_1.var_.oldValueTypewriter = arg_564_1.fswtw_.percent

				SetActive(arg_564_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_564_1:ShowNextGo(false)
			end

			local var_567_1 = 32
			local var_567_2 = 2.13333333333333
			local var_567_3, var_567_4 = arg_564_1:GetPercentByPara(arg_564_1:FormatText(arg_564_1:GetWordFromCfg(420191134).content), 2)

			if var_567_0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_0 + arg_567_0 then
				arg_564_1.talkMaxDuration = 0

				local var_567_5 = var_567_1 <= 0 and var_567_2 or var_567_2 * ((var_567_4 - arg_564_1.typewritterCharCountI18N) / var_567_1)

				if (var_567_1 <= 0 and var_567_2 or var_567_2 * ((var_567_4 - arg_564_1.typewritterCharCountI18N) / var_567_1)) > 0 and var_567_2 < var_567_5 then
					arg_564_1.talkMaxDuration = var_567_5

					if var_567_5 + var_567_0 > arg_564_1.duration_ then
						arg_564_1.duration_ = var_567_5 + var_567_0
					end
				end
			end

			local var_567_6 = math.max(2.13333333333333, arg_564_1.talkMaxDuration)

			if var_567_0 <= arg_564_1.time_ and arg_564_1.time_ < var_567_0 + var_567_6 then
				arg_564_1.fswtw_.percent = Mathf.Lerp(arg_564_1.var_.oldValueTypewriter, var_567_3, (arg_564_1.time_ - var_567_0) / var_567_6)
				arg_564_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_564_1.fswtw_:SetDirty()
			end

			if arg_564_1.time_ >= var_567_0 + var_567_6 and arg_564_1.time_ < var_567_0 + var_567_6 + arg_567_0 then
				arg_564_1.fswtw_.percent = var_567_3

				arg_564_1.fswtw_:SetDirty()
				arg_564_1:ShowNextGo(true)

				arg_564_1.typewritterCharCountI18N = var_567_4
			end

			local var_567_7 = 0

			if 0 < arg_564_1.time_ and arg_564_1.time_ <= var_567_7 + arg_567_0 then
				arg_564_1.allBtn_.enabled = false
			end

			if arg_564_1.time_ >= var_567_7 + 1.33333333333333 and arg_564_1.time_ < var_567_7 + 1.33333333333333 + arg_567_0 then
				arg_564_1.allBtn_.enabled = true
			end
		end

		arg_564_1.nodeConfigList_ = {}

		arg_564_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/SS2005",
		"TextureConfig/Background/ST76",
		"TextureConfig/Background/ST67",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/L16I",
		"TextureConfig/Background/ST0505",
		"TextureConfig/Background/SS2004a"
	},
	voices = {
		"story_v_out_420191.awb"
	}
}
